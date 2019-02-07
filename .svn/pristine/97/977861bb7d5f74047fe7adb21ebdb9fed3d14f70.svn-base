package daewooInfo.admin.security.web;

import java.util.List;
import java.util.Map;

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
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;
import daewooInfo.common.TmsMessageSource;
import daewooInfo.admin.security.bean.AuthorManage;
import daewooInfo.admin.security.bean.AuthorManageVO;
import daewooInfo.admin.security.bean.GroupManageVO;
import daewooInfo.admin.security.service.EgovAuthorManageService;
import daewooInfo.common.login.bean.SessionVO;

/**
 * 권한관리에 관한 controller 클래스를 정의한다.
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *	
 *	수정일	  수정자			수정내용
 *  -------	--------	---------------------------
 *	2009.03.11  이문준		  최초 생성
 *
 * </pre>
 */
 
@Controller
@SessionAttributes(types=SessionVO.class)
public class EgovAuthorManageController {

	/**
	 * @uml.property  name="tmsMessageSource"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="tmsMessageSource")
	TmsMessageSource tmsMessageSource;
	
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
	 * @uml.property  name="beanValidator"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Autowired
	private DefaultBeanValidator beanValidator;
	
	/**
	 * 권한 목록화면 이동
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping("/admin/security/EgovAuthorListView.do")
	public String selectAuthorListView()
			throws Exception {
		return "/admin/security/EgovAuthorManage";
	}	
	
	@RequestMapping(value="/admin/security/EgovAuthorList.do")
	public String EgovAuthorList(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/admin/security/EgovAuthorManage";
	}
	
	/**
	 * 권한 목록을 조회한다
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/security/EgovAuthorDetailList.do")
	public ModelAndView selectAuthorList(
					@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO, 
					ModelMap model)
			throws Exception {
		
		/** EgovPropertyService.sample */
		//authorManageVO.setPageUnit(propertiesService.getInt("pageUnit"));
		//authorManageVO.setPageSize(propertiesService.getInt("pageSize"));
		
		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		
		/** paging */
		authorManageVO.setPageUnit(100000);
		paginationInfo.setCurrentPageNo(authorManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(authorManageVO.getPageUnit());
		paginationInfo.setPageSize(authorManageVO.getPageSize());
		
		authorManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		authorManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		authorManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<AuthorManageVO> egovAuthorList = egovAuthorManageService.selectAuthorList(authorManageVO);
		int totCnt =egovAuthorManageService.selectAuthorListTotCnt(authorManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("resultList", egovAuthorList);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 권한 세부정보를 조회한다.
	 * @param authorCode String
	 * @param authorManageVO AuthorManageVO
	 * @return String
	 * @exception Exception
	 */	
	@RequestMapping(value="/admin/security/EgovAuthor.do")
	public String selectAuthor(@RequestParam("authorCode") String authorCode,
								@ModelAttribute("authorManageVO") AuthorManageVO authorManageVO,
								ModelMap model) throws Exception {
		
		authorManageVO.setAuthorCode(authorCode);
		
		model.addAttribute("authorManage", egovAuthorManageService.selectAuthor(authorManageVO));
		model.addAttribute("message", tmsMessageSource.getMessage("success.common.select"));
		return "/admin/security/EgovAuthorUpdate";
	}
	
	/**
	 * 권한 등록화면 이동
	 * @return String
	 * @exception Exception
	 */	 
	@RequestMapping("/admin/security/EgovAuthorInsertView.do")
	public String insertAuthorView()
			throws Exception {
		return "/admin/security/EgovAuthorInsert";
	}
	
	/**
	 * 권한 세부정보를 등록한다.
	 * @param authorManage AuthorManage
	 * @param bindingResult BindingResult
	 * @return String
	 * @exception Exception
	 */ 
	@RequestMapping(value="/admin/security/EgovAuthorInsert.do")
	public String insertAuthor(@ModelAttribute("authorManage") AuthorManage authorManage, 
								BindingResult bindingResult,
								SessionStatus status, 
								ModelMap model) throws Exception {
		
		beanValidator.validate(authorManage, bindingResult); //validation 수행
		
		if (bindingResult.hasErrors()) { 
			return "/admin/security/EgovAuthorInsert";
		} else {
			egovAuthorManageService.insertAuthor(authorManage);
			status.setComplete();
			model.addAttribute("message", tmsMessageSource.getMessage("success.common.insert"));
			return "forward:/admin/security/EgovAuthor.do";
		}
	}
	
	/**
	 * 권한 세부정보를 수정한다.
	 * @param authorManage AuthorManage
	 * @param bindingResult BindingResult
	 * @return String
	 * @exception Exception
	 */	
	@RequestMapping(value="/admin/security/EgovAuthorUpdate.do")
	public String updateAuthor(@ModelAttribute("authorManage") AuthorManage authorManage, 
								BindingResult bindingResult,
								SessionStatus status, 
								Model model) throws Exception {
		
		beanValidator.validate(authorManage, bindingResult); //validation 수행
		
		if (bindingResult.hasErrors()) {
			return "/admin/security/EgovAuthorUpdate";
		} else {
			egovAuthorManageService.updateAuthor(authorManage);
			status.setComplete();
			model.addAttribute("message", tmsMessageSource.getMessage("success.common.update"));
			return "forward:/admin/security/EgovAuthor.do";
		}
	}	

	/**
	 * 권한 세부정보를 삭제한다.
	 * @param authorManage AuthorManage
	 * @return String
	 * @exception Exception
	 */  
	@RequestMapping(value="/admin/security/EgovAuthorDelete.do")
	public String deleteAuthor(@ModelAttribute("authorManage") AuthorManage authorManage, 
								SessionStatus status,
								Model model) throws Exception {
		
		egovAuthorManageService.deleteAuthor(authorManage);
		status.setComplete();
		model.addAttribute("message", tmsMessageSource.getMessage("success.common.delete"));
		return "forward:/admin/security/EgovAuthorList.do";
	}	
	
	/**
	 * 권한목록을 삭제한다.
	 * @param authorCodes String
	 * @param authorManage AuthorManage
	 * @return String
	 * @exception Exception
	 */  
	@RequestMapping(value="/admin/security/EgovAuthorListDelete.do")
	public String deleteAuthorList(@RequestParam("authorCodes") String authorCodes,
									@ModelAttribute("authorManage") AuthorManage authorManage, 
									SessionStatus status,
									Model model) throws Exception {
		
		String [] strAuthorCodes = authorCodes.split(";");
		for(int i=0; i<strAuthorCodes.length;i++) {
			authorManage.setAuthorCode(strAuthorCodes[i]);
			egovAuthorManageService.deleteAuthor(authorManage);
		}
		status.setComplete();
		model.addAttribute("message", tmsMessageSource.getMessage("success.common.delete"));
		return "forward:/admin/security/EgovAuthorList.do";
	}	
	
	/**
	 * 권한제한 화면 이동
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping("/common/accessDenied.do")
	public String accessDenied()
			throws Exception {
		return "/common/accessDenied";
	} 
}
