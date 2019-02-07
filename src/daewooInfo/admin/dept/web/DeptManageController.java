package daewooInfo.admin.dept.web;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import daewooInfo.admin.dept.bean.DeptManageVO;
import daewooInfo.admin.dept.service.DeptManageService;
import daewooInfo.cmmn.bean.CmmnDetailCode;
import daewooInfo.cmmn.bean.ComDefaultVO;
import daewooInfo.common.TmsMessageSource;
import daewooInfo.common.login.service.LoginService;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import egovframework.rte.fdl.property.EgovPropertyService;

/** 
 * 부서 관리및 부서생성을 처리하는 비즈니스 구현 클래스
 * @author kisspa
 * @since 2010.07.19
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *  2010.07.19  kisspa          최초 생성
 *
 * </pre>
 */
@Controller
public class DeptManageController {

	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	protected Log log = LogFactory.getLog(this.getClass());
	/* Validator */
	/**
	 * @uml.property  name="beanValidator"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Autowired
	private DefaultBeanValidator beanValidator;
	/**
	 * EgovPropertyService
	 * @uml.property  name="propertiesService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /**
	 * EgovMenuManageService
	 * @uml.property  name="deptManageService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "deptManageService")
    private DeptManageService deptManageService;
	/**
	 * LoginService
	 * @uml.property  name="loginService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "loginService")
    private LoginService loginService;
	/**
	 * tmsMessageSource
	 * @uml.property  name="tmsMessageSource"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="tmsMessageSource")
    TmsMessageSource tmsMessageSource;	

    /**
     * 부서 리스트를 조회한다. 
     * @param searchVO ComDefaultVO
     * @return 출력페이지정보 "admin/dept/DeptList" 
     * @exception Exception
     */
    @RequestMapping(value="/admin/dept/DeptListSelect.do")
    public String selectDeptList(
    		@ModelAttribute("searchVO") ComDefaultVO searchVO, 
    		ModelMap model)
            throws Exception { 
    	String resultMsg    = "";
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
        	return "common/login/LoginUser";
    	}
    	
    	// 시/도 코드 정보
    	List<CmmnDetailCode> areaDoCode = loginService.getAreaDoCode();
    	// 부서정보
    	List list_deptlist = deptManageService.selectDeptList();
    	
    	model.addAttribute("areaDoCode", areaDoCode);
        model.addAttribute("list_deptlist", list_deptlist);
        return  "admin/dept/DeptList"; 
    }
    
    /**
     * 부서리스트의 부서정보를 등록한다. 
     * @param deptManageVO DeptManageVO
     * @return 출력페이지정보 "admin/dept/DeptList" 
     * @exception Exception
     */
    @RequestMapping(value="/admin/dept/DeptListInsert.do")
    public String insertDeptList(
    		@ModelAttribute("deptManageVO") DeptManageVO deptManageVO, 
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception { 
        String sLocationUrl = null;
    	String resultMsg    = "";
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
        	return "common/login/LoginUser";
    	}

        beanValidator.validate(deptManageVO, bindingResult);
		if (bindingResult.hasErrors()){
			sLocationUrl = "admin/dept/DeptList";
			return sLocationUrl;
		}

		if(deptManageService.selectDeptNoByPk(deptManageVO) == 0){
			deptManageService.insertDeptManage(deptManageVO);
	    	resultMsg = tmsMessageSource.getMessage("success.common.insert");
		    sLocationUrl = "forward:/admin/dept/DeptListSelect.do";
			
		}else{
    		resultMsg = tmsMessageSource.getMessage("common.isExist.msg");
    		sLocationUrl = "forward:/admin/dept/DeptListSelect.do";
		}
		model.addAttribute("resultMsg", resultMsg);
      	return sLocationUrl;
    } 

    /**
     * 부서리스트의 메뉴정보를 수정한다.
     * @param deptManageVO DeptManageVO
     * @return 출력페이지정보 "admin/dept/DeptList" 
     * @exception Exception
     */
    @RequestMapping(value="/admin/dept/DeptListUpdt.do")
    public String updateDeptList(
    		@ModelAttribute("deptManageVO") DeptManageVO deptManageVO, 
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception { 
        String sLocationUrl = null;
    	String resultMsg    = "";
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
        	return "common/login/LoginUser";
    	}
    	
    	beanValidator.validate(deptManageVO, bindingResult);
		if (bindingResult.hasErrors()){
			log.debug("\n\nbindingResult.hasErrors()\n\n");
			sLocationUrl = "forward:/admin/dept/DeptListSelect.do";
			return sLocationUrl;
		}
		deptManageService.updateDeptManage(deptManageVO);
		resultMsg = tmsMessageSource.getMessage("success.common.update");
        sLocationUrl = "forward:/admin/dept/DeptListSelect.do";
        model.addAttribute("resultMsg", resultMsg);
      	return sLocationUrl;
    }    

    /**
     * 부서리스트의 메뉴정보를 삭제한다. 
     * @param deptManageVO DeptManageVO
     * @return 출력페이지정보 "admin/dept/DeptList" 
     * @exception Exception
     */
    @RequestMapping(value="/admin/dept/DeptListDelete.do")
    public String deleteDeptList(
    		@ModelAttribute("deptManageVO") DeptManageVO deptManageVO,
    		BindingResult bindingResult,
    		ModelMap model)
            throws Exception {
        String sLocationUrl = null;
    	String resultMsg    = "";
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
        	return "common/login/LoginUser";
    	}

        beanValidator.validate(deptManageVO, bindingResult);
		if (bindingResult.hasErrors()){
			sLocationUrl = "admin/dept/DeptList";
			return sLocationUrl;
		}
		deptManageService.deleteDeptManage(deptManageVO);
		resultMsg = tmsMessageSource.getMessage("success.common.delete");
        sLocationUrl = "forward:/admin/dept/DeptListSelect.do";
		model.addAttribute("resultMsg", resultMsg);
      	return sLocationUrl;    	
    }
    
    /**
     * 상위 부서 선택 팝업을 조회한다. 
     * @param searchVO  ComDefaultVO 
     * @return 출력페이지정보 "admin/dept/DeptMvmn" 
     * @exception Exception
     */
    @RequestMapping(value="/admin/dept/DeptListSelectMvmn.do")
    public String selectDeptListMvmn(
    		@ModelAttribute("searchVO") ComDefaultVO searchVO, 
    		ModelMap model)
            throws Exception { 
    	// 0. Spring Security 사용자권한 처리
    	Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
    	if(!isAuthenticated) {
    		model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
        	return "common/login/LoginUser";
    	}
    	
    	List list_deptlist = deptManageService.selectDeptList();
        model.addAttribute("list_deptlist", list_deptlist);
      	return  "admin/dept/DeptMvmn"; 
    }
}