package daewooInfo.admin.security.web;

import java.util.HashMap;
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

import daewooInfo.admin.onetouch.bean.EmpOnetouchSmsVO;
import daewooInfo.admin.security.bean.GroupManage;
import daewooInfo.admin.security.bean.GroupManageVO;
import daewooInfo.admin.security.service.EgovGroupManageService;
import daewooInfo.common.TmsMessageSource;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.login.bean.SessionVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * SMS전파그룹관리에 관한 controller 클래스를 정의한다.
 * @author 네이쳐텍 최회섭
 * @since 2017.09.10
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *	
 *	수정일	  수정자			수정내용
 *  -------	--------	---------------------------
 *	2017.09.10 최회섭		  최초 생성
 *
 * </pre>
 */

@Controller
@SessionAttributes(types=SessionVO.class)
public class SmsGroupManageController {
	
	/**
	 * @uml.property  name="tmsMessageSource"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="tmsMessageSource")
	TmsMessageSource tmsMessageSource;

	/**
	 * @uml.property  name="egovGroupManageService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "egovGroupManageService")
	private EgovGroupManageService egovGroupManageService;

	/**
	 * EgovPropertyService
	 * @uml.property  name="propertiesService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/**
	 * Message ID Generation
	 * @uml.property  name="egovGroupIdGnrService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="egovGroupIdGnrService")	
	private EgovIdGnrService egovGroupIdGnrService;
	
	/**
	 * @uml.property  name="beanValidator"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Autowired
	private DefaultBeanValidator beanValidator;
	
	/**
	 * 그룹 목록화면 이동
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping("/admin/security/SmsGroupListView.do")
	public String selectGroupListView(
			@ModelAttribute("groupManageVO") GroupManageVO groupManageVO,
			ModelMap model) throws Exception {
		
		/** paging */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(groupManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(groupManageVO.getPageUnit());
		paginationInfo.setPageSize(groupManageVO.getPageSize());
		
		groupManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		groupManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		groupManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		groupManageVO.setGroupManageList(egovGroupManageService.selectGroupList(groupManageVO));
		model.addAttribute("groupList", groupManageVO.getGroupManageList());
		
		int totCnt = egovGroupManageService.selectGroupListTotCnt(groupManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("message", tmsMessageSource.getMessage("success.common.select"));
		
		return "/admin/security/SmsGroupManage";
	}	

	/**
	 * 시스템사용 목적별 그룹 목록 조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/security/SmsGroupList.do")
	public String egovGroupList(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/admin/security/SmsGroupManage";
	}
	
	/**
	 * 시스템사용 목적별 그룹 목록 조회
	 * @param groupManageVO GroupManageVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/security/SmsGroupDetailList.do")
	public ModelAndView EgovGroupDetailList (
					@ModelAttribute("groupManageVO") GroupManageVO groupManageVO
					, ModelMap model
			) throws Exception {
		PaginationInfo paginationInfo = new PaginationInfo();
		
		/** paging */
		groupManageVO.setPageUnit(100000);
		
		paginationInfo.setCurrentPageNo(groupManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(groupManageVO.getPageUnit());
		paginationInfo.setPageSize(groupManageVO.getPageSize());
		
		groupManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		groupManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		groupManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<GroupManageVO> egovGroupList = egovGroupManageService.selectGroupList(groupManageVO);
		
		int totCnt = egovGroupManageService.selectGroupListTotCnt(groupManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("resultList", egovGroupList);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}

	/**
	 * 검색조건에 따른 그룹정보를 조회
	 * @param groupManageVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/security/SmsGroup.do")
	public ModelAndView selectGroup(
								@ModelAttribute("groupManageVO") GroupManageVO groupManageVO,
								ModelMap model
								) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		GroupManageVO groupManage = egovGroupManageService.selectGroup(groupManageVO);
		//EmpOnetouchSmsVO empOnetouchSmsVO = egovGroupManageService.selectGroupMember(groupManageVO);
		modelAndView.addObject("smsGroup", groupManage);
		//modelAndView.addObject("smsGroupMember", empOnetou);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 검색조건에 따른 그룹정보를 조회
	 * @param groupManageVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/security/SmsGroupMember.do")
	public ModelAndView selectGroupMember(
			@RequestParam(value="groupId", required=false) String groupId
			) throws Exception {
		List<HashMap<String, String>> groupList = egovGroupManageService.selectGroupMember(groupId);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("groupList", groupList);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}

	/**
	 * 그룹 등록화면 이동
	 * @return String
	 * @exception Exception
	 */	 
	@RequestMapping(value="/admin/security/SmsGroupInsertView.do")
	public String insertGroupView()
			throws Exception {
		return "/admin/security/SmsGroupInsert";
	}

	/**
	 * 그룹 기본정보를 화면에서 입력하여 항목의 정합성을 체크하고 데이터베이스에 저장
	 * @param groupManage GroupManage
	 * @param groupManageVO GroupManageVO
	 * @return String
	 * @exception Exception
	 */ 
	@RequestMapping(value="/admin/security/SmsGroupInsert.do")
	public String insertGroup(@ModelAttribute("groupManage") GroupManage groupManage, 
							  @ModelAttribute("groupManageVO") GroupManageVO groupManageVO, 
							  @ModelAttribute("empOnetouchSmsVO") EmpOnetouchSmsVO empOnetouchSmsVO,
								BindingResult bindingResult,
								SessionStatus status, 
								ModelMap model) throws Exception {
		
		beanValidator.validate(groupManage, bindingResult); //validation 수행
		
		if (bindingResult.hasErrors()) { 
			return "/admin/security/SmsGroupInsert";
		} else {
			groupManage.setGroupId(egovGroupIdGnrService.getNextStringId());
			groupManageVO.setGroupId(groupManage.getGroupId());
			
			status.setComplete();
			model.addAttribute("message", tmsMessageSource.getMessage("success.common.insert"));
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			empOnetouchSmsVO.setReg_id(user.getId());
			egovGroupManageService.insertGroup(groupManage, groupManageVO, empOnetouchSmsVO);
			return "/admin/security/SmsGroupManage";
		}
	}
	
	/**
	 * 화면에 조회된 그룹의 기본정보를 수정하여 항목의 정합성을 체크하고 수정된 데이터를 데이터베이스에 반영
	 * @param groupManage GroupManage
	 * @return String
	 * @exception Exception
	 */	 
	@RequestMapping(value="/admin/security/SmsGroupUpdate.do")
	public String updateGroup(@ModelAttribute("groupManage") GroupManage groupManage, 
								BindingResult bindingResult,
								SessionStatus status, 
								Model model) throws Exception {
		
		beanValidator.validate(groupManage, bindingResult); //validation 수행
		
		if (bindingResult.hasErrors()) { 
			return "/admin/security/SmsGroupUpdate";
		} else {
			egovGroupManageService.updateGroup(groupManage);
			status.setComplete();
			model.addAttribute("message", tmsMessageSource.getMessage("success.common.update"));
			return "forward:/admin/security/SmsGroup.do";
		}
	}	
	
	/**
	 * 불필요한 그룹정보를 화면에 조회하여 데이터베이스에서 삭제
	 * @param groupManage GroupManage
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/security/SmsGroupDelete.do")
	public String deleteGroup(@ModelAttribute("groupManage") GroupManage groupManage, 
							 SessionStatus status, 
							 Model model) throws Exception {
		egovGroupManageService.deleteGroup(groupManage);
		status.setComplete();
		model.addAttribute("message", tmsMessageSource.getMessage("success.common.delete"));
		return "forward:/admin/security/SmsGroupList.do";
	}

	/**
	 * 불필요한 그룹정보 목록을 화면에 조회하여 데이터베이스에서 삭제
	 * @param groupIds String
	 * @param groupManage GroupManage
	 * @return String
	 * @exception Exception
	 */	
	@RequestMapping(value="/admin/security/SmsGroupListDelete.do")
	public String deleteGroupList(@RequestParam("groupIds") String groupIds,
								  @ModelAttribute("groupManage") GroupManage groupManage, 
									SessionStatus status, 
									Model model) throws Exception {
		String [] strGroupIds = groupIds.split(";");
		for(int i=0; i<strGroupIds.length;i++) {
			groupManage.setGroupId(strGroupIds[i]);
			egovGroupManageService.deleteGroup(groupManage);
		}
		status.setComplete();
		model.addAttribute("message", tmsMessageSource.getMessage("success.common.delete"));
		return "forward:/admin/security/SmsGroupList.do";
	}
	
	/**
	 * 그룹팝업 화면 이동
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/security/SmsGroupSearchView.do")
	public String selectGroupSearchView(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/admin/security/SmsGroupSearch";
	}
		
	/**
	 * 시스템사용 목적별 그룹 목록 조회
	 * @param groupManageVO GroupManageVO
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/security/SmsGroupSearchDetailView.do")
	public ModelAndView selectGroupSearchDetailView (
			@ModelAttribute("groupManageVO") GroupManageVO groupManageVO
			, ModelMap model
			) throws Exception {
		PaginationInfo paginationInfo = new PaginationInfo();

		/** paging */
		groupManageVO.setPageUnit(100000);

		paginationInfo.setCurrentPageNo(groupManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(groupManageVO.getPageUnit());
		paginationInfo.setPageSize(groupManageVO.getPageSize());
		
		groupManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		groupManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		groupManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<GroupManageVO> groupList = egovGroupManageService.selectGroupList(groupManageVO);
		
		int totCnt = egovGroupManageService.selectGroupListTotCnt(groupManageVO);
		paginationInfo.setTotalRecordCount(totCnt);

		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("resultList", groupList);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
}