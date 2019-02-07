package daewooInfo.common.menu.web;

import java.text.DecimalFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.admin.keyword.bean.KeywordSearchVO;
import daewooInfo.admin.keyword.bean.KeywordVO;
import daewooInfo.admin.keyword.service.KeywordService;
import daewooInfo.admin.member.service.MemberService;
import daewooInfo.common.TmsMessageSource;
import daewooInfo.common.alrim.bean.AlrimVO;
import daewooInfo.common.alrim.service.AlrimService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.login.bean.MemberVO;
import daewooInfo.common.login.service.LoginService;
import daewooInfo.common.menu.bean.MyMenuVO;
import daewooInfo.common.menu.service.MyMenuService;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.fcc.StringUtil;
import daewooInfo.mobile.com.utl.LogInfoUtil;
import daewooInfo.mobile.com.utl.ObjectUtil;
import daewooInfo.seminar.bean.SeminarEntryVO;
import daewooInfo.seminar.bean.SeminarSearchVO;
import daewooInfo.seminar.bean.SeminarVO;
import daewooInfo.seminar.service.SeminarService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class MyMenuController {

	/**
	 * MemberService
	 * @uml.property  name="memberService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "memberService")
	private MemberService memberService;

	/**
	 * KeywordService
	 * @uml.property  name="keywordService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "keywordService")
	private KeywordService keywordService;
	
	
	/**
	 * EgovMessageSource
	 * @uml.property  name="tmsMessageSource"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="tmsMessageSource")
	TmsMessageSource tmsMessageSource;


	/**
	 * @uml.property  name="menuService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="MyMenuService")
	MyMenuService myMenuService;
	

	/**
	 * @uml.property  name="menuService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="alrimService")
	AlrimService alrimService;
	
	/**
	 * @uml.property  name="seminarService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "SeminarService")
	private SeminarService seminarService;
	
	/**
	 * @uml.property  name="propertyService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	/**
	 * LoginService
	 * @uml.property  name="loginService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "loginService")
	private LoginService loginService;
	
	/**
	 * log
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log log = LogFactory.getLog(MyMenuController.class);
	

	/**
	 * 유저의 정보를 수정한다.
	 * @param loginVO
	 * @param memberVO
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/admin/member/MemberModify"
	 * @throws Exception
	 */
	@RequestMapping(value="/common/member/InfoModify.do")
	public String InfoModify (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("memberVO") MemberVO memberVO
			, @ModelAttribute("keywordVO") KeywordVO keywordVO
			, @ModelAttribute("keywordSearchVO") KeywordSearchVO keywordSearchVO
			, HttpServletRequest request
			, HttpServletResponse response
			, Map commandMap
			, ModelMap model
			) throws Exception {

		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		memberVO.setMemberId(user.getId());
		request.getSession().setAttribute("memberAccess",null);
		return "/admin/member/InfoModify";
	}
	

	@RequestMapping(value="/common/member/MemberAccess.do")
	public String MemberAccess (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("memberVO") MemberVO memberVO
			, @ModelAttribute("keywordVO") KeywordVO keywordVO
			, @ModelAttribute("keywordSearchVO") KeywordSearchVO keywordSearchVO
			, HttpServletRequest request
			, HttpServletResponse response
			, Map commandMap
			, ModelMap model  
			) throws Exception {

		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		memberVO.setMemberId(user.getId());
		if(request.getRemoteAddr() != null) memberVO.setConnectIp(request.getRemoteAddr());
		MemberVO vo = memberService.selectMemberDetail(memberVO, true);
		
		if (vo.getMobileNo() != null && !"".equals(vo.getMobileNo()) && vo.getMobileNo().split("-").length == 3) {
			String mobile = vo.getMobileNo().split("-")[0];
			String mobile1 = vo.getMobileNo().split("-")[1];
			String mobile2 = vo.getMobileNo().split("-")[2];
			  
			vo.setMobileNo(mobile);
			vo.setMobileNo1(mobile1);
			vo.setMobileNo2(mobile2);
		}
		
		if (vo.getFaxNum() != null && !"".equals(vo.getFaxNum()) && vo.getFaxNum().split("-").length == 3) {
			String fax = vo.getFaxNum().split("-")[0];
			String fax1 = vo.getFaxNum().split("-")[1];
			String fax2 = vo.getFaxNum().split("-")[2];
			vo.setFaxNum(fax);
			vo.setFaxNum1(fax1);
			vo.setFaxNum2(fax2);
		}
		
		if (vo.getOfficeNo() != null && !"".equals(vo.getOfficeNo()) && vo.getOfficeNo().split("-").length == 3) {
			String office = vo.getOfficeNo().split("-")[0];
			String office1 = vo.getOfficeNo().split("-")[1];
			String office2 = vo.getOfficeNo().split("-")[2];
			
			vo.setOfficeNo(office);
			vo.setOfficeNo1(office1);
			vo.setOfficeNo2(office2);
		}
		
		if (vo.getEmail() != null && !"".equals(vo.getEmail())) {
			String email = vo.getEmail().split("@")[0];
			String email1 = "";
			if (vo.getEmail().split("@").length > 1) {
				email1 = vo.getEmail().split("@")[1];
			}
			vo.setEmail(email);
			vo.setEmail1(email1);
			vo.setEmail2("");
		}
		
		model.addAttribute("memberVO", vo);
		
		boolean memberAccess = false;
		//인증 여부 확인
		if(null != request.getSession().getAttribute("memberAccess")){
			if("OK".equals(request.getSession().getAttribute("memberAccess").toString())){
				memberAccess = true;
			}
		}
		String return_str = "";

		if(!memberAccess){
			return_str = "redirect:/common/member/InfoModify.do";
		}else{
			request.getSession().setAttribute("memberAccess",null);
			return_str = "/admin/member/MemberAccess";
		}
		return return_str;
	}
	
	@RequestMapping(value="/common/member/MemberAccessAction.do")
	public String MemberAccessAction (@ModelAttribute("loginVO") LoginVO loginVO
			, HttpServletRequest request
			, HttpServletResponse response
			, Map commandMap
			, ModelMap model
			) throws Exception {
		
		loginVO.setId(((LoginVO)TmsUserDetailsHelper.getAuthenticatedUser()).getId());

		LoginVO resultVO = loginService.actionLogin(loginVO);
				

		String return_str;
		if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("") ) {
			// 2. spring security 연동
			request.getSession().setAttribute("memberAccess","OK");
			return_str = "redirect:/common/member/MemberAccess.do";
			if(request.getRequestURL().indexOf("waterkorea.or.kr") >= 0)
			{
				return_str = "redirect:http://www.waterkorea.or.kr/common/member/MemberAccess.do";
			}
		} else {
			return_str = "redirect:/common/member/InfoModify.do?fase=ok";
			if(request.getRequestURL().indexOf("waterkorea.or.kr") >= 0)
			{
				return_str = "redirect:http://www.waterkorea.or.kr/common/member/InfoModify.do?fase=ok";
			}
			
		}
		return return_str;
	}
	

	/**
	 * 유저의 정보를 수정한다.
	 * @param loginVO
	 * @param memberVO
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/admin/member/MemberModify"
	 * @throws Exception
	 */
	@RequestMapping(value="/common/member/InfoModifyAction.do")
	public String updateInfo (@ModelAttribute("loginVO") LoginVO loginVO
			, HttpServletRequest request
			, final MultipartHttpServletRequest multiRequest
			, @ModelAttribute("memberVO") MemberVO memberVO
			, @ModelAttribute("keywordVO") KeywordVO keywordVO
			, @ModelAttribute("keywordSearchVO") KeywordSearchVO keywordSearchVO
			, BindingResult bindingResult
			, Map commandMap
			, HttpServletResponse response
			, ModelMap model
			) throws Exception {
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		memberVO.setMemberId(user.getId());
		
		// 비밀번호를 변경할지 체크
		String passwordChange = (String)commandMap.get("passwordChange");
		if (passwordChange == null) passwordChange = "";
		
		log.debug("passwordChange : "+passwordChange);
		if ("change".equals(passwordChange)) {
			keywordSearchVO.setSearchKeyword(memberVO.getPassword());
			List resultList = keywordService.selectKeywordCheckList(keywordSearchVO);
			if (resultList.size() > 0){
				//금지된 문구가 들어가 비밀번호로 사용할 수 없다는 메시지 출력
				model.addAttribute("resultList", resultList);
				model.addAttribute("resultMsg", tmsMessageSource.getMessage("fail.keyword.pwsearch"));
				return "/admin/member/InfoModify";
			}
			memberService.changePassword(memberVO);
		}
		
		memberVO.setEmail(memberVO.getEmail()+"@"+memberVO.getEmail1());
		memberVO.setOfficeNo(memberVO.getOfficeNo()+"-"+memberVO.getOfficeNo1()+"-"+memberVO.getOfficeNo2());
		memberVO.setMobileNo(memberVO.getMobileNo()+"-"+memberVO.getMobileNo1()+"-"+memberVO.getMobileNo2());
		memberVO.setFaxNum(memberVO.getFaxNum()+"-"+memberVO.getFaxNum1()+"-"+memberVO.getFaxNum2());

		memberService.updateInfo(memberVO, multiRequest);
		

		response.setContentType("text/html; charset=UTF-8");

		if(request.getRequestURL().indexOf("waterkorea.or.kr") >= 0)
		{
			response.getWriter().print("<script>alert('성공적으로 처리하였습니다.');document.location.href='http://www.waterkorea.or.kr/common/member/InfoModify.do';</script>");
		}
		else
		{
			response.getWriter().print("<script>alert('성공적으로 처리하였습니다.');document.location.href='/common/member/InfoModify.do';</script>");
		}
		
		
		
		return null;
	}


	/**
	 * 받은알람 화면
	 * @param loginVO
	 * @param memberVO
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/admin/member/MemberModify"
	 * @throws Exception
	 */
	@RequestMapping(value="/common/member/MyAlrim.do")
	public String MyAlrim (@ModelAttribute("searchVO") AlrimVO alrimVO, ModelMap model, HttpServletResponse response, HttpServletRequest request) throws Exception {
		alrimVO.setAlrimApprovalId(LogInfoUtil.GetSessionLogin().getId());
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		alrimVO.setSearchStartDate((null == alrimVO.getSearchStartDate()) ? ObjectUtil.getTimeString("yyyyMM")+"01" : alrimVO.getSearchStartDate().replaceAll("/", ""));
		alrimVO.setSearchEndDate((null == alrimVO.getSearchEndDate()) ? ObjectUtil.getTimeString("yyyyMMdd") : alrimVO.getSearchEndDate().replaceAll("/", ""));
		
		paginationInfo.setCurrentPageNo(alrimVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(alrimVO.getPageUnit());
		paginationInfo.setPageSize(alrimVO.getPageSize());
	
		alrimVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		alrimVO.setLastIndex(paginationInfo.getLastRecordIndex());
		alrimVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		int totCnt = alrimService.selectAlrimtotList(alrimVO);
		paginationInfo.setTotalRecordCount(totCnt);
		List<AlrimVO> list = alrimService.selectAlrimList(alrimVO);
		
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("List", list);
		model.addAttribute("param_s", alrimVO);
		return "/admin/member/MyAlrim";
	}		

	/**
	 * 알람 일괄 확인
	 * @param loginVO
	 * @param memberVO
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/admin/member/MemberModify"
	 * @throws Exception
	 */
	@RequestMapping(value="/common/member/UpdateCheckAlrimList.do")  
	public String UpdateCheckAlrimList (AlrimVO alrimVO, ModelMap model, HttpServletResponse response, HttpServletRequest request) throws Exception {
		
		alrimService.updateAlrimList(alrimVO, request);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print("<script>document.location.href='/common/member/MyAlrim.do';</script>");
		return null;
	}
	

	/**
	 * 알람 일괄 삭제
	 * @param loginVO
	 * @param memberVO
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/admin/member/MemberModify"
	 * @throws Exception
	 */
	@RequestMapping(value="/common/member/DeleteAlrimList.do")  
	public String DeleteAlrimList (AlrimVO alrimVO, ModelMap model, HttpServletResponse response, HttpServletRequest request) throws Exception {
		alrimService.deleteAlrim(alrimVO, request);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print("<script>alert('삭제하였습니다.');document.location.href='/common/member/MyAlrim.do';</script>");
		return null;
	}
	
	/**
	 * 나의 교육 화면
	 * 교육신청현황
	 * @param response
	 * @param searchVO
	 * @param model
	 * @return "/admin/member/MySeminarSchedule"
	 * @throws Exception
	 */
	@RequestMapping(value="/common/member/MySeminarSchedule.do")
	public String MySchedule (ModelMap model,
		 @ModelAttribute("searchVO") SeminarSearchVO searchVO,
		 HttpServletResponse response ,
		 HttpServletRequest request) throws Exception {
		
		DecimalFormat df = new DecimalFormat("00");
		Calendar currentCalendar = Calendar.getInstance();
		
		//검색기간
		if(StringUtil.isEmpty(searchVO.getSearchBgnDe())){
		    //현재 날짜 구하기
			String endYear   = Integer.toString(currentCalendar.get(Calendar.YEAR));
			String endMonth  = df.format(currentCalendar.get(Calendar.MONTH) + 1);
			String endDay   = df.format(currentCalendar.get(Calendar.DATE));
			String endDate = endYear+"/"+endMonth+"/"+endDay;
			
			//한달 전 날짜 구하기
			currentCalendar.add(currentCalendar.MONTH, -1);
		    String startYear   = Integer.toString(currentCalendar.get(Calendar.YEAR));
		    String startMonth  = df.format(currentCalendar.get(Calendar.MONTH) + 1);
		    String startDay   = df.format(currentCalendar.get(Calendar.DATE));
		    String startDate = startYear +"/"+startMonth +"/"+startDay;
			
			searchVO.setSearchBgnDe(startDate);
			searchVO.setSearchEndDe(endDate);
		}
		
		searchVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		searchVO.setSearchMemId(LogInfoUtil.GetSessionLogin().getId());
		List<SeminarVO> resultList = seminarService.selMySeminarApplication(searchVO);
		SeminarSearchVO searchVO2 = new SeminarSearchVO();
		for(int i = 0; i < resultList.size(); i++) {
			//참여인원 마감처리
			if(resultList.get(i).getSeminarClosingStateName().equals("신청마감")) {
				searchVO2.setSearchSeminarId(resultList.get(i).getSeminarId());
				searchVO2.setSearchClosingState("Y");
				searchVO2.setSearchUClosingState("N");
				seminarService.updateSeminarAutoClosingState(searchVO2);
			}
			
			if(resultList.get(i).getSeminarCount() == resultList.get(i).getEntryCount()) {
				searchVO2.setSearchSeminarId(resultList.get(i).getSeminarId());
				searchVO2.setSearchClosingState("Y");
				searchVO2.setSearchUClosingState("N");
				seminarService.updateSeminarAutoClosingState(searchVO2);
				
				resultList.get(i).setSeminarClosingStateName("신청마감");
				resultList.get(i).setSeminarClosingState("N");
			}
			
			if(resultList.get(i).getSeminarClosingStateName().equals("신청예정") || resultList.get(i).getSeminarClosingStateName().equals("신청가능")) {
				searchVO2.setSearchSeminarId(resultList.get(i).getSeminarId());
				searchVO2.setSearchClosingState("N");
				searchVO2.setSearchUClosingState("Y");
				resultList.get(i).setSeminarClosingState("Y");
			}
		}
		
		int totCnt = seminarService.selMySeminarApplicationTot(searchVO);

		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", totCnt);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "/admin/member/MySeminarSchedule";
	}
	
	/**
	 * 나의 교육 화면
	 * 교육등록현황
	 * @param loginVO
	 * @param memberVO
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/admin/member/MySeminarApplication"
	 * @throws Exception
	 */
	@RequestMapping(value="/common/member/MySeminarApplication.do")
	public String MySeminarApplication (ModelMap model,
		@ModelAttribute("searchVO") SeminarSearchVO searchVO,
		HttpServletResponse response,
		HttpServletRequest request) throws Exception {
		
		DecimalFormat df = new DecimalFormat("00");
		Calendar currentCalendar = Calendar.getInstance();
		
		//검색기간
		if(StringUtil.isEmpty(searchVO.getSearchBgnDe())){
		    //현재 날짜 구하기
			String endYear   = Integer.toString(currentCalendar.get(Calendar.YEAR));
			String endMonth  = df.format(currentCalendar.get(Calendar.MONTH) + 1);
			String endDay   = df.format(currentCalendar.get(Calendar.DATE));
			String endDate = endYear+"/"+endMonth+"/"+endDay;
			
			//한달 전 날짜 구하기
			currentCalendar.add(currentCalendar.MONTH, -1);
		    String startYear   = Integer.toString(currentCalendar.get(Calendar.YEAR));
		    String startMonth  = df.format(currentCalendar.get(Calendar.MONTH) + 1);
		    String startDay   = df.format(currentCalendar.get(Calendar.DATE));
		    String startDate = startYear +"/"+startMonth +"/"+startDay;
			
			searchVO.setSearchBgnDe(startDate);
			searchVO.setSearchEndDe(endDate);
		}
		
		searchVO.setPageSize(propertyService.getInt("pageSize"));
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());

		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		searchVO.setSearchMemId(LogInfoUtil.GetSessionLogin().getId());
		List<SeminarVO> resultList = seminarService.selectSeminarInfo(searchVO);
		int totCnt = seminarService.selectSeminarTotCnt(searchVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", totCnt);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "/admin/member/MySeminarApplication";
	}
	
	
	/**
	 * 교육 삭제 처리
	 * 
	 * @param seminarVO
	 * @param commandMap
	 * @param model
	 * @return view 페이지
	 * @throws Exception
	 */
	@RequestMapping(value="/common/member/DeleteSeminarInfo.do")
	public void deleteSeminarInfo(
			@ModelAttribute("searchVO") SeminarSearchVO searchVO ,
			@ModelAttribute("seminarVO") SeminarVO seminarVO ,
			HttpServletRequest request , 
			HttpServletResponse response ,
			ModelMap model) 
		throws Exception {
	
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if (isAuthenticated) {
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			try{
				seminarVO.setModId(user.getId());
				if(seminarVO.getCheckSeminarId().indexOf(",")>0) {
					String checkNoArray[] = seminarVO.getCheckSeminarId().split(",");
					for(int i=0; i<checkNoArray.length; i++){
				    	//삭제 처리
				    	seminarVO.setSeminarId(checkNoArray[i]);
				    	seminarService.deleteSeminarInfo(seminarVO);
					}
				} else {
					seminarService.deleteSeminarInfo(seminarVO);
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print("<script>alert('성공적으로 삭제 되었습니다.');document.location.href='/common/member/MySeminarApplication.do';</script>");
	}
	
	/**
	 * 교육 신청 취소 처리
	 * 
	 * @param searchVO
	 * @param seminarEntryVO
	 * @param seminarVO
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping("/common/member/UpdateSeminarEntry.do")
	public void updateSeminarEntry(
			@ModelAttribute("searchVO") SeminarSearchVO searchVO ,
			@ModelAttribute("seminarEntryVO") SeminarEntryVO seminarEntryVO ,
			@ModelAttribute("seminarVO") SeminarVO seminarVO ,
			HttpServletRequest request ,
			HttpServletResponse response)
		throws Exception {
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if (isAuthenticated) {
			try {
				LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
				//제외처리
				seminarEntryVO.setModId(user.getId());
				seminarEntryVO.setEntryYn("N");
				if(seminarVO.getCheckSeminarId().indexOf(",")>0) {
					String checkNoArray[] = seminarVO.getCheckSeminarId().split(",");
					for(int i=0; i<checkNoArray.length; i++){
				    	seminarEntryVO.setSeminarEntryId(checkNoArray[i]);
						seminarService.updateSeminarEntry(seminarEntryVO);
					}
				} else{
			    	seminarEntryVO.setSeminarEntryId(searchVO.getCheckSeminarId());
					seminarService.updateSeminarEntry(seminarEntryVO);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print("<script>alert('성공적으로 교육취소가 되었습니다.');document.location.href='/common/member/MySeminarSchedule.do';</script>");
	}
	
	/**
	 * 마이메뉴 화면
	 * @param loginVO
	 * @param memberVO
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/admin/member/MemberModify"
	 * @throws Exception
	 */
	@RequestMapping(value="/common/member/MyMenu.do")
	public String MyMenu (@ModelAttribute("myMenuVO") MyMenuVO myMenuVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		myMenuVO.setMember_id(LogInfoUtil.GetSessionLogin().getId());
		myMenuVO.setRoleName(LogInfoUtil.GetSessionLogin().getRoleCode());
		myMenuVO.setView_mode("N");
		model.addAttribute("List", myMenuService.TreeselectMenu(myMenuVO));
		return "/admin/member/MyMenu";
	}		
	

	/**
	 * 마이메뉴를 편집한다.
	 * @param loginVO
	 * @param memberVO
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/admin/member/MemberModify"
	 * @throws Exception
	 */
	@RequestMapping(value="/common/member/InsertMyMenu.do")
	public String InsertMyMenu (@ModelAttribute("myMenuVO") MyMenuVO myMenuVO, ModelMap model ,HttpServletRequest request, HttpServletResponse response) throws Exception {
		myMenuService.InsertMyMenu(request, myMenuVO);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print("<script>alert('성공적으로 등록되었습니다.');document.location.href='/common/member/MyMenu.do';</script>");
		return null;
	}	
	
	/**
	 * 나의 교육신청 현황 엑셀 다운로드
	 * @param searchVO
	 */
	@RequestMapping(value="/common/member/MySeminarScheduleExcel.do")
	public ModelAndView selectScheduleDataListExcel (
			@ModelAttribute("searchVO") SeminarSearchVO searchVO ,
			HttpServletRequest request
	) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		ModelAndView mav = null;
		
		searchVO.setSearchMemId(LogInfoUtil.GetSessionLogin().getId());
		int totCnt = seminarService.selMySeminarApplicationTot(searchVO);
		
		searchVO.setPageSize(propertyService.getInt("pageSize"));
		searchVO.setFirstIndex(0);
		searchVO.setRecordCountPerPage(totCnt);
		
		List<SeminarVO> data = seminarService.selMySeminarApplication(searchVO);
		for(int i = 0; i < data.size(); i++) {
			if(data.get(i).getSeminarCount() == data.get(i).getEntryCount()) {
				data.get(i).setSeminarClosingStateName("신청마감");
				data.get(i).setSeminarClosingState("N");
			}
			if(data.get(i).getSeminarClosingStateName().equals("신청가능")) {
				data.get(i).setSeminarClosingState("Y");
			} else {
				data.get(i).setSeminarClosingState("N");
			}
		}
		map.put("data", data);
		map.put("searchVO", searchVO);
		mav = new ModelAndView("ExcelViewMySeminarSchedule", "map", map);
		return mav;
	}
	
	/**
	 * 나의 교육등록 현황 엑셀 다운로드
	 * @param searchVO
	 */
	@RequestMapping(value="/common/member/MySeminarApplicationExcel.do")
	public ModelAndView selectApplicationDataListExcel (
			@ModelAttribute("searchVO") SeminarSearchVO searchVO,
			HttpServletRequest request
	) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		ModelAndView mav = null;
		
		searchVO.setSearchMemId(LogInfoUtil.GetSessionLogin().getId());
		int totCnt = seminarService.selectSeminarTotCnt(searchVO);
		
		searchVO.setPageSize(propertyService.getInt("pageSize"));
		searchVO.setFirstIndex(0);
		searchVO.setRecordCountPerPage(totCnt);
		
		List<SeminarVO> data = seminarService.selectSeminarInfo(searchVO);
		map.put("data", data);
		map.put("searchVO", searchVO);
		mav = new ModelAndView("ExcelViewMySeminarApplication", "map", map);
		return mav;
	}
	
	/**
	 * 회원탈퇴
	 * @param memberVO
	 * @return "/admin/member/MemberSecession"
	 * @throws Exception
	 */
	@RequestMapping(value="/common/member/MemberSecession.do")
	public String MemberSecession (
			@ModelAttribute("memberVO") MemberVO memberVO
			, HttpServletRequest request
			) throws Exception {
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		memberVO.setMemberId(user.getId());
		return "/admin/member/MemberSecession";
	}
	
	@RequestMapping(value="/common/member/MemberRemove.do")
	public String updateMemberState (
			@ModelAttribute("memberVO") MemberVO memberVO
			, HttpServletRequest request
			) throws Exception {
		//MemberVO vo = memberService.selectMemberDetail(memberVO);
		if(request.getRemoteAddr() != null) memberVO.setConnectIp(request.getRemoteAddr());
		memberService.deleteMember(memberVO); 
		request.getSession().invalidate();
		return "redirect:/err/biz_err03.jsp";
	}
}