package daewooInfo.admin.security.web;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.common.TmsMessageSource;
import daewooInfo.admin.security.bean.AuthorRoleManage;
import daewooInfo.admin.security.bean.AuthorRoleManageVO;
import daewooInfo.admin.security.service.EgovAuthorRoleManageService;
import daewooInfo.common.login.bean.SessionVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 권한별 롤관리에 관한 controller 클래스를 정의한다.
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *	
 *	수정일		수정자		수정내용
 *  -------		--------	---------------------------
 *	2009.03.11	이문준		최초 생성
 *
 * </pre>
 */

@Controller
@SessionAttributes(types=SessionVO.class)
public class EgovAuthorRoleController {
	
	/**
	 * @uml.property  name="tmsMessageSource"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="tmsMessageSource")
	TmsMessageSource tmsMessageSource;
	
	/**
	 * @uml.property  name="egovAuthorRoleManageService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "egovAuthorRoleManageService")
	private EgovAuthorRoleManageService egovAuthorRoleManageService;
	
	/**
	 * EgovPropertyService
	 * @uml.property  name="propertiesService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/**
	 * 권한 롤 관계 화면 이동
	 * @return "/admin/security/EgovDeptAuthorList"
	 * @exception Exception
	 */
	@RequestMapping("/admin/security/EgovAuthorRoleListView.do")
	public String selectAuthorRoleListView() throws Exception {

		return "/admin/security/EgovAuthorRoleManage";
	}
	
	/**
	 * 권한별 할당된 롤 목록 조회
	 * 
	 * @param authorRoleManageVO AuthorRoleManageVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/security/EgovAuthorRoleList.do")
	public String selectAuthorRoleList(
			@ModelAttribute("authorRoleManageVO") AuthorRoleManageVO authorRoleManageVO,
			ModelMap model
			) throws Exception {
		
		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(authorRoleManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(authorRoleManageVO.getPageUnit());
		paginationInfo.setPageSize(authorRoleManageVO.getPageSize());
		
		authorRoleManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		authorRoleManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		authorRoleManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		authorRoleManageVO.setAuthorRoleList(egovAuthorRoleManageService.selectAuthorRoleList(authorRoleManageVO));
		model.addAttribute("authorRoleList", authorRoleManageVO.getAuthorRoleList());
		
		int totCnt = egovAuthorRoleManageService.selectAuthorRoleListTotCnt(authorRoleManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("message", tmsMessageSource.getMessage("success.common.select"));
		
		return "/admin/security/EgovAuthorRoleManage";
	}
	
	/**
	 * 권한정보에 롤을 할당하여 데이터베이스에 등록
	 * @param authorCode String
	 * @param roleCodes String
	 * @param regYns String
	 * @param authorRoleManage AuthorRoleManage
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/security/EgovAuthorRoleInsert.do")
	public String insertAuthorRole(@RequestParam("authorCode") String authorCode,
									@RequestParam("roleCodes") String roleCodes,
									@RequestParam("regYns") String regYns,
									@ModelAttribute("authorRoleManage") AuthorRoleManage authorRoleManage,
									SessionStatus status,
									ModelMap model) throws Exception {
		
		String [] strRoleCodes = roleCodes.split(";");
		String [] strRegYns = regYns.split(";");
		
		authorRoleManage.setAuthorCode(authorCode);
		
		for(int i=0; i<strRoleCodes.length;i++) {
			authorRoleManage.setRoleCode(strRoleCodes[i]);
			authorRoleManage.setRegYn(strRegYns[i]);
//			if(strRegYns[i].equals("Y"))
				egovAuthorRoleManageService.insertAuthorRole(authorRoleManage);
//			else
//				egovAuthorRoleManageService.deleteAuthorRole(authorRoleManage);
		}
		
		status.setComplete();
		model.addAttribute("message", tmsMessageSource.getMessage("success.common.insert"));
		return "forward:/admin/security/EgovAuthorRoleList.do";
	}
	/**
	 * SignGate TestSample
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/sgsample.do")
	public ModelAndView sgsample(){
		
		ModelAndView mav = new ModelAndView();
		mav.setViewName("/sgSample/LoginForm.jsp");
		
	return mav;
	}
}
