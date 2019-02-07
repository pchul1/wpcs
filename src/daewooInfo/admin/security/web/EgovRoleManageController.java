package daewooInfo.admin.security.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springmodules.validation.commons.DefaultBeanValidator;

import daewooInfo.admin.security.bean.AuthorManageVO;
import daewooInfo.admin.security.bean.RoleManage;
import daewooInfo.admin.security.bean.RoleManageVO;
import daewooInfo.admin.security.service.EgovAuthorManageService;
import daewooInfo.admin.security.service.EgovRoleManageService;
import daewooInfo.cmmn.bean.ComDefaultCodeVO;
import daewooInfo.cmmn.service.EgovCmmUseService;
import daewooInfo.common.TmsMessageSource;
import daewooInfo.common.login.bean.SessionVO;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 롤관리에 관한 controller 클래스를 정의한다.
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.11  이문준          최초 생성
 *
 * </pre>
 */

@Controller
@SessionAttributes(types=SessionVO.class)
public class EgovRoleManageController {

    /**
	 * @uml.property  name="tmsMessageSource"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="tmsMessageSource")
    TmsMessageSource tmsMessageSource;
    
    /**
	 * @uml.property  name="egovRoleManageService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "egovRoleManageService")
    private EgovRoleManageService egovRoleManageService;

    /**
	 * @uml.property  name="egovCmmUseService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "EgovCmmUseService")
    EgovCmmUseService egovCmmUseService;
    
    /**
	 * @uml.property  name="egovAuthorManageService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "egovAuthorManageService")
    private EgovAuthorManageService egovAuthorManageService;
    
    /**
	 * EgovPropertyService
	 * @uml.property  name="propertiesService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
    
    /**
	 * Message ID Generation
	 * @uml.property  name="egovRoleIdGnrService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="egovRoleIdGnrService")    
    private EgovIdGnrService egovRoleIdGnrService;
    
    /**
	 * @uml.property  name="beanValidator"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Autowired
	private DefaultBeanValidator beanValidator;

    /**
	 * 롤 목록화면 이동
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping("/admin/security/EgovRoleListView.do")
    public String selectRoleListView()
            throws Exception {
        return "/admin/security/EgovRoleManage";
    }    
    
	/**
	 * 등록된 롤 정보 목록 조회
	 * @param roleManageVO RoleManageVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/admin/security/EgovRoleList.do")
	public String selectRoleList(@ModelAttribute("roleManageVO") RoleManageVO roleManageVO, 
			                      ModelMap model) throws Exception {
    	
    	/** paging */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(roleManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(roleManageVO.getPageUnit());
		paginationInfo.setPageSize(roleManageVO.getPageSize());
		
		roleManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		roleManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		roleManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		roleManageVO.setRoleManageList(egovRoleManageService.selectRoleList(roleManageVO));
        model.addAttribute("roleList", roleManageVO.getRoleManageList());
        
        int totCnt = egovRoleManageService.selectRoleListTotCnt(roleManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("message", tmsMessageSource.getMessage("success.common.select"));

        return "/admin/security/EgovRoleManage";
	}    

	/**
	 * 등록된 롤 정보 조회
	 * @param roleCode String
	 * @param roleManageVO RoleManageVO
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/admin/security/EgovRole.do")
	public String selectRole(@RequestParam("roleCode") String roleCode,
	                         @ModelAttribute("roleManageVO") RoleManageVO roleManageVO, 
	                         @ModelAttribute("authorManageVO") AuthorManageVO authorManageVO,
		                      ModelMap model) throws Exception {
        
    	roleManageVO.setRoleCode(roleCode);
    	
    	authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorAllList(authorManageVO));

    	model.addAttribute("roleManage", egovRoleManageService.selectRole(roleManageVO));
        model.addAttribute("authorManageList", authorManageVO.getAuthorManageList());
        model.addAttribute("cmmCodeDetailList", getCmmCodeDetailList(new ComDefaultCodeVO(),"27"));

        return "/admin/security/EgovRoleUpdate";
	}

    /**
	 * 롤 등록화면 이동
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */     
    @RequestMapping("/admin/security/EgovRoleInsertView.do")
    public String insertRoleView(@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO, 
    		                      ModelMap model) throws Exception {
    	
    	authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorAllList(authorManageVO));
        model.addAttribute("authorManageList", authorManageVO.getAuthorManageList());
        model.addAttribute("cmmCodeDetailList", getCmmCodeDetailList(new ComDefaultCodeVO(),"27"));
        
        return "/admin/security/EgovRoleInsert";
    }

    /**
	 * 공통코드 호출
	 * @param comDefaultCodeVO ComDefaultCodeVO
	 * @param codeId String
	 * @return List
	 * @exception Exception
	 */ 
    public List getCmmCodeDetailList(ComDefaultCodeVO comDefaultCodeVO, String codeId)  throws Exception {
    	comDefaultCodeVO.setCodeId(codeId);
    	return egovCmmUseService.selectCmmCodeDetail(comDefaultCodeVO);
    }
        
	/**
	 * 시스템 메뉴에 따른 접근권한, 데이터 입력, 수정, 삭제의 권한 롤을 등록
	 * @param roleManage RoleManage
	 * @param roleManageVO RoleManageVO
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/admin/security/EgovRoleInsert.do")
	public String insertRole(@ModelAttribute("roleManage") RoleManage roleManage,
			                 @ModelAttribute("roleManageVO") RoleManageVO roleManageVO,
			                  BindingResult bindingResult,
			                  SessionStatus status, 
                              ModelMap model) throws Exception {
    	
    	beanValidator.validate(roleManage, bindingResult); //validation 수행

    	if (bindingResult.hasErrors()) { 
			return "/admin/security/EgovRoleInsert";
		} else {
    	    String roleTyp = roleManage.getRoleTyp();
	    	if(roleTyp.equals("method")) 
	    		roleTyp = "mtd";
	    	else if(roleTyp.equals("pointcut"))
	    		roleTyp = "pct";
	    	else roleTyp = "web";
	    	
	    	roleManage.setRoleCode(roleTyp.concat("-").concat(egovRoleIdGnrService.getNextStringId()));
	    	roleManageVO.setRoleCode(roleManage.getRoleCode());
	    	
	    	status.setComplete();
	        model.addAttribute("cmmCodeDetailList", getCmmCodeDetailList(new ComDefaultCodeVO(),"27"));
	    	model.addAttribute("message", tmsMessageSource.getMessage("success.common.insert"));
	        model.addAttribute("roleManage", egovRoleManageService.insertRole(roleManage, roleManageVO));
	        
	        return "/admin/security/EgovRoleUpdate";
		}
	}

	/**
	 * 시스템 메뉴에 따른 접근권한, 데이터 입력, 수정, 삭제의 권한 롤을 수정
	 * @param roleManage RoleManage
	 * @param bindingResult BindingResult
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/admin/security/EgovRoleUpdate.do")
	public String updateRole(@ModelAttribute("roleManage") RoleManage roleManage,
			BindingResult bindingResult,
			SessionStatus status, 
            ModelMap model) throws Exception {
    	
    	beanValidator.validate(roleManage, bindingResult); //validation 수행
    	if (bindingResult.hasErrors()) { 
			return "/admin/security/EgovRoleUpdate";
		} else {
    	egovRoleManageService.updateRole(roleManage);
    	status.setComplete();
    	model.addAttribute("message", tmsMessageSource.getMessage("success.common.update"));
    	return "forward:/admin/security/EgovRole.do";
		}
	}
	
	/**
	 * 불필요한 롤정보를 화면에 조회하여 데이터베이스에서 삭제
	 * @param roleManage RoleManage
	 * @return String
	 * @exception Exception
	 */
    @RequestMapping(value="/admin/security/EgovRoleDelete.do")
	public String deleteRole(@ModelAttribute("roleManage") RoleManage roleManage,
            SessionStatus status, 
            ModelMap model) throws Exception {
    	
    	egovRoleManageService.deleteRole(roleManage);
    	status.setComplete();
    	model.addAttribute("message", tmsMessageSource.getMessage("success.common.delete"));
    	return "forward:/admin/security/EgovRoleList.do";

	}
    
	/**
	 * 불필요한 그룹정보 목록을 화면에 조회하여 데이터베이스에서 삭제
	 * @param roleCodes String
	 * @param roleManage RoleManage
	 * @return String
	 * @exception Exception
	 */   
	@RequestMapping(value="/admin/security/EgovRoleListDelete.do")
	public String deleteRoleList(@RequestParam("roleCodes") String roleCodes,
			                     @ModelAttribute("roleManage") RoleManage roleManage, 
	                              SessionStatus status, 
	                              Model model) throws Exception {
    	String [] strRoleCodes = roleCodes.split(";");
    	for(int i=0; i<strRoleCodes.length;i++) {
    		roleManage.setRoleCode(strRoleCodes[i]);
    		egovRoleManageService.deleteRole(roleManage);
    	}
		status.setComplete();
		model.addAttribute("message", tmsMessageSource.getMessage("success.common.delete"));
		return "forward:/admin/security/EgovRoleList.do";
	}
}