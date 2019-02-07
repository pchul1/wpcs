package daewooInfo.admin.security.web;

import java.util.List;
import java.util.Map;

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
import daewooInfo.admin.security.bean.AuthorManageVO;
import daewooInfo.admin.security.service.EgovAuthorGroupService;
import daewooInfo.admin.security.bean.AuthorGroup;
import daewooInfo.admin.security.bean.AuthorGroupVO;
import daewooInfo.admin.security.bean.AuthorRoleManageVO;
import daewooInfo.admin.security.bean.GroupManageVO;
import daewooInfo.admin.security.service.EgovAuthorManageService;
import daewooInfo.common.login.bean.SessionVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 권한그룹에 관한 controller 클래스를 정의한다.
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *
 * 수정일		수정자		수정내용
 * -------		--------	---------------------------
 * 2009.03.11	이문준		최초 생성
 *
 * </pre>
 */

@Controller
@SessionAttributes(types=SessionVO.class)
public class EgovAuthorGroupController {

	/**
	 * @uml.property  name="tmsMessageSource"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="tmsMessageSource")
	TmsMessageSource tmsMessageSource;
	
	/**
	 * @uml.property  name="egovAuthorGroupService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "egovAuthorGroupService")
	private EgovAuthorGroupService egovAuthorGroupService;
	
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
	 * 권한 목록화면 이동
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping("/admin/security/EgovAuthorGroupListView.do")
	public String selectAuthorGroupListView() throws Exception {

		return "/admin/security/EgovAuthorGroupManage";
	}	

	
	/**
	 * 그룹별 할당된 권한 목록 조회
	 * @param authorGroupVO AuthorGroupVO
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/security/EgovAuthorGroupList.do")
	public String selectAuthorGroupList(@ModelAttribute("authorGroupVO") AuthorGroupVO authorGroupVO,
										@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO,
										 ModelMap model) throws Exception {

		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(authorGroupVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(authorGroupVO.getPageUnit());
		paginationInfo.setPageSize(authorGroupVO.getPageSize());
		
		authorGroupVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		authorGroupVO.setLastIndex(paginationInfo.getLastRecordIndex());
		authorGroupVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		authorGroupVO.setAuthorGroupList(egovAuthorGroupService.selectAuthorGroupList(authorGroupVO));
		model.addAttribute("authorGroupList", authorGroupVO.getAuthorGroupList());
		
		int totCnt = egovAuthorGroupService.selectAuthorGroupListTotCnt(authorGroupVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		authorManageVO.setAuthorManageList(egovAuthorManageService.selectAuthorAllList(authorManageVO));
		model.addAttribute("authorManageList", authorManageVO.getAuthorManageList());
		
		model.addAttribute("message", tmsMessageSource.getMessage("success.common.select"));
		
		return "/admin/security/EgovAuthorGroupManage";
	}
	
	/**
	 * 그룹에 권한정보를 할당하여 데이터베이스에 등록
	 * @param userIds String
	 * @param authorCodes String
	 * @param regYns String
	 * @param authorGroup AuthorGroup
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/security/EgovAuthorGroupInsert.do")
	public String insertAuthorGroup(@RequestParam("userIds") String userIds,
									@RequestParam("authorCodes") String authorCodes,
									@RequestParam("regYns") String regYns,
									@ModelAttribute("authorGroup") AuthorGroup authorGroup,
									 ModelMap model) throws Exception {
		
		String [] strUserIds = userIds.split(":");
		String [] strAuthorCodes = authorCodes.split(":");
		String [] strRegYns = regYns.split(":");
		
		for(int i=0; i<strUserIds.length;i++) {
			authorGroup.setUniqId(strUserIds[i]);
			authorGroup.setAuthorCode(strAuthorCodes[i]);
			if(strRegYns[i].equals("N"))
				egovAuthorGroupService.insertAuthorGroup(authorGroup);
			else
				egovAuthorGroupService.updateAuthorGroup(authorGroup);
		}
		
		model.addAttribute("message", tmsMessageSource.getMessage("success.common.insert"));
		return "forward:/admin/security/EgovAuthorGroupList.do";
	}
	
	/**
	 * 그룹별 할당된 시스템 메뉴 접근권한을 삭제
	 * @param userIds String
	 * @param authorGroup AuthorGroup
	 * @return String
	 * @exception Exception
	 */ 
	@RequestMapping(value="/admin/security/EgovAuthorGroupDelete.do")
	public String deleteAuthorGrsoup(@RequestParam("userIds") String userIds,
									@ModelAttribute("authorGroup") AuthorGroup authorGroup,
									 SessionStatus status,
									 ModelMap model) throws Exception {
		
		String [] strUserIds = userIds.split(":");
		for(int i=0; i<strUserIds.length;i++) {
			authorGroup.setUniqId(strUserIds[i]);
			egovAuthorGroupService.deleteAuthorGroup(authorGroup);
		}
		
		status.setComplete();
		model.addAttribute("message", tmsMessageSource.getMessage("success.common.delete"));
		return "forward:/admin/security/EgovAuthorGroupList.do";
	}
}