package daewooInfo.seminar.web;

import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.cmmn.bean.CmmnDetailCode;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.common.alrim.bean.AlrimVO;
import daewooInfo.common.alrim.service.AlrimService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.EgovFileMngUtil;
import daewooInfo.common.util.fcc.StringUtil;
import daewooInfo.seminar.bean.SeminarEntryVO;
import daewooInfo.seminar.bean.SeminarSearchVO;
import daewooInfo.seminar.bean.SeminarVO;
import daewooInfo.seminar.service.SeminarService;
import daewooInfo.cmmn.service.EgovFileMngService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 교육관리 Controller 클래스
 * @author 박미영
 * @since 2014.09.04
 * @version 1.0
 * @see
 */
@Controller
public class SeminarController {
	/**
	 * log
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log log = LogFactory.getLog(SeminarController.class);
	
	/**
	 * @uml.property  name="seminarService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "SeminarService")
	private SeminarService seminarService;

	/**
	 * @uml.property  name="alrimService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alrimService")
	private AlrimService alrimService;
	
	/**
	 * @uml.property  name="fileMngService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	/**
	 * @uml.property  name="fileUtil"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	/**
	 * @uml.property  name="propertyService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;

	/**
	 * XSS 방지 처리.
	 * 
	 * @param data
	 * @return
	 */
	protected String unscript(String data) {
		if (data == null || data.trim().equals("")) {
			return "";
		}
		
		String ret = data;
		
		ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
		ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");
		
		ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
		ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");
		
		ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
		ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");
		
		ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
		ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
		
		ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
		ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form");

		return ret;
	}	
	
	/**
	 * 교육일정 목록
	 * @param alrimVO
	 * @return view 페이지
	 * @exception Exception
	 */
	@RequestMapping("/seminar/SeminarScheduleList.do")
	public String seminarScheduleList(
			Map<String, Object> commandMap,
			@ModelAttribute("searchVO") SeminarSearchVO searchVO, 
			ModelMap model) throws Exception {
		
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
		
		List<SeminarVO> resultList = seminarService.selectSeminarApplication(searchVO);
		SeminarSearchVO searchVO2 = new SeminarSearchVO();
		
		/*for(int i = 0; i < resultList.size(); i++) {
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
		}*/
		
		int totCnt = seminarService.selectSeminarApplicationTotCnt(searchVO);
		//접수된 교육 총 카운트
		/*int totACnt = seminarService.selectAcceptTot(searchVO);
		//실시 완료된 총 카운트
		int totCCnt = seminarService.selectCompleteTot(searchVO);
		//실시예정된 총 카운트
		int totPCnt = seminarService.selectPlanTot(searchVO);
		//교육 신청 총 카운트
		int totSCnt = seminarService.selectSeminarTot(searchVO);
		//강사 신청 총 카운트
		int totLCnt = seminarService.selectLectTot(searchVO);*/
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", totCnt);
		/*model.addAttribute("totACnt", totACnt);
		model.addAttribute("totCCnt", totCCnt);
		model.addAttribute("totPCnt", totPCnt);
		model.addAttribute("totSCnt", totSCnt);
		model.addAttribute("totLCnt", totLCnt);*/
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		return "seminar/seminarScheduleList";
	}
	
	/**
	 * 교육정보를 등록한다.
	 * 
	 * @param boardVO
	 * @param board
	 * @param sessionVO
	 * @param model
	 * @return view 페이지
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/seminar/insertSeminar.do")
	public String insertSeminar(
			@ModelAttribute("searchVO") SeminarSearchVO searchVO,
			@ModelAttribute("serminarVO") SeminarVO seminarVO, 
			BindingResult bindingResult, 
			SessionStatus status,
			Map<String, Object> commandMap,
			ModelMap model) throws Exception {
	
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if (isAuthenticated) {
			try{
				seminarService.insertSeminar(seminarVO);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		return "redirect:/seminar/SeminarScheduleList.do";
	}
	
	/**
	 * 교육 일정 중복 조회
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping("/seminar/selectCheckSeminarDate.do")
	public ModelAndView selectCheckSeminarDate(
			@RequestParam(value="startDt", required=false) String startDt, 
			@RequestParam(value="endDt", required=false) String endDt, 
			@RequestParam(value="seminarId", required=false) String seminarId
		) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		SeminarVO seminarVO = new SeminarVO();
		seminarVO.setSeminarDateFrom(startDt);
		seminarVO.setSeminarDateTo(endDt);
		if(seminarId != "undefined") {
			seminarVO.setSeminarId(seminarId);
		}
		int totCnt = seminarService.selectCheckSeminarDate(seminarVO);
		String msg = "OK";
		//일정 중복인 경우
		if(totCnt > 0) msg = "duplication";
		modelAndView.addObject("msg", msg);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 교육등록 목록
	 * @param commandMap
	 * @param SeminarSearchVO
	 * @param ModelMap
	 * @return view 페이지
	 * @exception Exception
	 */
	@RequestMapping("/seminar/SeminarRegistList.do")
	public String seminarRegistList(
			Map<String, Object> commandMap,
			@ModelAttribute("searchVO") SeminarSearchVO searchVO, 
			ModelMap model) throws Exception {
		
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
		
		List<SeminarVO> resultList = seminarService.selectSeminarInfo(searchVO);
		int totCnt = seminarService.selectSeminarTotCnt(searchVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", totCnt);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("menu", commandMap.get("menu"));
		model.addAttribute("no", commandMap.get("no"));
		return "seminar/seminarRegistList";
	}

	/**
	 * 교육등록
	 * @param commandMap
	 * @return view 페이지
	 * @exception Exception
	 */
	@RequestMapping("/seminar/SeminarRegist.do")
	public String seminarRegist(
			@ModelAttribute("searchVO") SeminarSearchVO searchVO, 
			Map<String, Object> commandMap, 
			ModelMap model
		) throws Exception {
		
		/*LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		//로그인 유저의 소속 검색
		String deptId = user.getDeptNo();
		searchVO.setSearchDeptId(deptId);
		String depfInfo = seminarService.selectUperDept(searchVO);
		String deptFlas = "N";
		if(depfInfo != null) {
			if(depfInfo.equals("7000")) {
				//지자체인 경우
				deptFlas = "Y";
			}
		}*/
		//등록일 현재 날짜 표시
		Date ndate = new Date();
		SimpleDateFormat todayform;
		todayform= new SimpleDateFormat("yyyy/MM/dd");
		String today = todayform.format(ndate);
		
		List<CmmnDetailCode> eduCode = seminarService.getEduCode();
		
		//searchVO.setSearchDept(deptFlas);
		model.addAttribute("today", today);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("menu", commandMap.get("menu"));
		model.addAttribute("no", commandMap.get("no"));
		model.addAttribute("eduCode", eduCode);
		return "seminar/seminarRegist";
	}
	
	/**
	 *  교육일정 - 월간
	 * @param commandMap
	 * @return view 페이지
	 * @exception Exception
	 */
	@RequestMapping("/seminar/SeminarSchedule.do")
	public String seminarMonth(
			Map<String, Object> commandMap,
			@ModelAttribute("searchVO") SeminarSearchVO searchVO, 
			ModelMap model
		) throws Exception {
		
		Date ndate = new Date();
		SimpleDateFormat year , mon;
		year = new SimpleDateFormat("yyyy");
		mon = new SimpleDateFormat("MM");
		String nYear = year.format(ndate);
		String nMonth = mon.format(ndate);
		if(StringUtil.isEmpty(searchVO.getSearchYear())){
			searchVO.setSearchYear(nYear);
			searchVO.setSearchMonth(nMonth);
		}
		String Ym = searchVO.getSearchYear()  + "-" +  searchVO.getSearchMonth();
		if(StringUtil.isEmpty(searchVO.getSearchYmBgn())){
			searchVO.setSearchYmBgn(Ym);
			searchVO.setSearchYmEnd(Ym);
		}
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setPageSize(searchVO.getPageSize());
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(50);
		
		List<SeminarVO> resultList = seminarService.selectSeminarApplication(searchVO);
		int totCnt = seminarService.selectSeminarApplicationTotCnt(searchVO);
		for(int i = 0; i < resultList.size(); i++) {
			//참여인원 마감처리
			if(resultList.get(i).getSeminarCount() == resultList.get(i).getEntryCount()) {
				resultList.get(i).setSeminarClosingStateName("신청마감");
				resultList.get(i).setSeminarClosingState("N");
			}
			if(resultList.get(i).getSeminarClosingStateName().equals("신청가능")) {
				resultList.get(i).setSeminarClosingState("Y");
			} else {
				resultList.get(i).setSeminarClosingState("N");
			}
		}
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", totCnt);
		model.addAttribute("menu", commandMap.get("menu"));
		model.addAttribute("no", commandMap.get("no"));
		String viewUrl = "seminar/seminarSchedule";
		if(searchVO.getUrlStr().equals("popupCal")) {
			viewUrl = "seminar/monthCal";
		}
		return viewUrl;
	}
	
	/**
	 *  교육일정 - 달력
	 * @param commandMap
	 * @return view 페이지
	 * @exception Exception
	 */
	@SuppressWarnings({ "deprecation" })
	@RequestMapping("/seminar/SeminarMonthWeek.do")
	public ModelAndView SeminarMonthWeek(
			@RequestParam(value="searchYear", required=false) String  curYear,
			@RequestParam(value="searchMonth", required=false) String  curMon,
			@RequestParam(value="mode", required=false) String  mode,
			@RequestParam(value="move", required=false) String  move) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		SeminarSearchVO searchVO = new SeminarSearchVO();
		int curY = Integer.valueOf(curYear);
		int curM =  Integer.valueOf(curMon);
		Date startDate = null;
		Date endDate = null;
		Date curDate = null;
		
		if(move.equals("prev")) {
			curDate = new Date(curY , curM-1 , 1);
			startDate = new Date(curY , curM-2 , 1);
			endDate = new Date(curY , curM , 1);
		} else {
			curDate = new Date(curY , curM+1 , 1);
			startDate = new Date(curY , curM , 1);
			endDate = new Date(curY , curM+2 , 1);
		}
		
		String startMonth = String.valueOf(startDate.getMonth());
		String endMonth = String.valueOf(endDate.getMonth());
		String curMonth = String.valueOf(curDate.getMonth());

		if(startMonth.length() == 1) {
			startMonth = "0" + startMonth;
		}
		
		if(endMonth.length() == 1) {
			endMonth = "0" + endMonth;
		}
		
		if(curMonth.length() == 1) {
			curMonth = "0" + curMonth; 
		}
		
		String startYm = startDate.getYear()  + "-" +  startMonth;
		String endYm = endDate.getYear()  + "-" +  endMonth;
		
		searchVO.setSearchYear(String.valueOf(curDate.getYear()));
		searchVO.setSearchMonth(curMonth);
		
		searchVO.setSearchYmBgn(startYm);
		searchVO.setSearchYmEnd(endYm);
		
		PaginationInfo paginationInfo = new PaginationInfo();		
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(50);
		
		List<SeminarVO> resultList = seminarService.selectSeminarApplication(searchVO);
		int totCnt = seminarService.selectSeminarTotCnt(searchVO);
		
		for(int i = 0; i < resultList.size(); i++) {
			//참여인원 마감처리
			if(resultList.get(i).getSeminarCount() == resultList.get(i).getEntryCount()) {
				resultList.get(i).setSeminarClosingStateName("신청마감");
				resultList.get(i).setSeminarClosingState("N");
			}
			
			if(resultList.get(i).getSeminarClosingStateName().equals("신청가능")) {
				resultList.get(i).setSeminarClosingState("Y");
			} else {
				resultList.get(i).setSeminarClosingState("N");
			}
		}
		
		paginationInfo.setTotalRecordCount(totCnt);
		modelAndView.addObject("resultList", resultList);
		modelAndView.addObject("resultCnt", totCnt);
		modelAndView.addObject("curYear", curDate.getYear());
		modelAndView.addObject("curMon", curMonth);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}

	/**
	 * 교육승인
	 * @param commandMap
	 * @param SeminarSearchVO
	 * @param ModelMap
	 * @return view 페이지
	 * @exception Exception
	 */
	@RequestMapping("/seminar/SeminarApproval.do")
	public String seminarApproval(
			Map<String, Object> commandMap,
			@ModelAttribute("searchVO") SeminarSearchVO searchVO, 
			ModelMap model) throws Exception {
		
		try{
			
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
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			PaginationInfo paginationInfo = new PaginationInfo();
			
			paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
			paginationInfo.setPageSize(searchVO.getPageSize());
	
			searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
			searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			List<SeminarVO> resultList = seminarService.selectSeminarInfo(searchVO);
			int totCnt = seminarService.selectSeminarTotCnt(searchVO);
			
			//로그인 유저의 소속 검색
			String deptId = user.getDeptNo();
			searchVO.setSearchDeptId(deptId);
			String depfInfo = seminarService.selectUperDept(searchVO);
			String deptFlas = "N";
			if(depfInfo != null) {
				if(depfInfo.equals("7000")) {
					//지자체인 경우
					deptFlas = "Y";
				}
			}
			searchVO.setSearchDept(deptFlas);
			paginationInfo.setTotalRecordCount(totCnt);
			model.addAttribute("resultList", resultList);
			model.addAttribute("resultCnt", totCnt);
			model.addAttribute("searchVO", searchVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("menu", commandMap.get("menu"));
			model.addAttribute("no", commandMap.get("no"));
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		return "seminar/seminarApproval";
	}
	
	/**
	 * 교육정보 상세 보기 / 수정페이지 이동
	 * @param commandMap
	 * @param SeminarSearchVO
	 * @param SeminarVO
	 * @param ModelMap
	 * @return  view 페이지
	 * @exception Exception
	 */
	@RequestMapping("/seminar/SeminarView.do")
	public String seminarInfoView(
			Map<String, Object> commandMap,
			@ModelAttribute("searchVO") SeminarSearchVO searchVO,
			@ModelAttribute("seminarVO") SeminarVO seminarVO, 
			ModelMap model) throws Exception {
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		
		try{
			
			//조회수 업데이트
			seminarService.updateSeminarCnt(seminarVO);
			//교육 상세 보기 조회
			SeminarVO vo = seminarService.selSeminarInfoView(seminarVO);
			//교육 참여자수 카운트 조회
			SeminarEntryVO seminarEntryVO = new SeminarEntryVO();
			seminarEntryVO.setSeminarId(seminarVO.getSeminarId());
			int entryCnt = seminarService.selSeminarEntryCnt(seminarEntryVO);
			
			//로그인 유저의 소속 검색
			String deptId = user.getDeptNo();
			searchVO.setSearchDeptId(deptId);
			String depfInfo = seminarService.selectUperDept(searchVO);
			String deptFlas = "N";
			if(depfInfo != null) {	
				if(depfInfo.equals("7000")) {
					//지자체인 경우
					deptFlas = "Y";
				}
			}
			searchVO.setSearchDept(deptFlas);
			model.addAttribute("searchVO", searchVO);
			model.addAttribute("loginUserId", user.getId());
			model.addAttribute("deptFlas", deptFlas);
			model.addAttribute("result", vo);
			model.addAttribute("entryCnt", entryCnt);
			model.addAttribute("menu", commandMap.get("menu"));
			model.addAttribute("no", commandMap.get("no"));
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		String returnUrl ="seminar/seminarRegistView";
		
		if(searchVO.getUrlStr().equals("SeminarRegistEdit.do")) {
			returnUrl ="seminar/seminarRegistEdit";
		}
		
		return returnUrl;
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
	@RequestMapping("/seminar/DeleteSeminarInfo.do")
	public String deleteSeminarInfo(
			@ModelAttribute("seminarVO") SeminarVO seminarVO,
			Map<String, Object> commandMap,
			ModelMap model) 
		throws Exception {
	
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if (isAuthenticated) {
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			try{
				seminarVO.setModId(user.getId());
				seminarService.deleteSeminarInfo(seminarVO);
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
	
		return "forward:/seminar/SeminarRegistList.do";
	}
	
	/**
	 * 교육정보를 수정
	 * 
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/seminar/UpdateSeminarInfo.do")
	public String updateSeminarInfo(
			@ModelAttribute("searchVO") SeminarSearchVO searchVO,
			@ModelAttribute("serminarVO") SeminarVO seminarVO, 
			BindingResult bindingResult, 
			SessionStatus status,
			Map<String, Object> commandMap,
			ModelMap model) 
		throws Exception {
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
     	if (isAuthenticated) {
     		try{
				seminarVO.setModId(user.getId());
				seminarService.updateSeminarInfo(seminarVO);
     		}catch(Exception e) {
     			e.printStackTrace();
     		}
		}
		
		return "redirect:/seminar/SeminarScheduleList.do";
	}
	
	/**
	 * 교육 승인 OR 불허 처리
	 * 
	 * @param seminarVO
	 * @param commandMap
	 * @param model
	 * @return view 페이지
	 * @throws Exception
	 */
	@RequestMapping("/seminar/UpdateSeminarState.do")
	public String updateSeminarState(
			@ModelAttribute("searchVO") SeminarSearchVO searchVO,
			@ModelAttribute("seminarVO") SeminarVO seminarVO,
			Map<String, Object> commandMap,
			ModelMap model)
		throws Exception {
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if (isAuthenticated) {
			try{
				LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
				seminarVO.setModId(user.getId());
				AlrimVO alrimVO = new AlrimVO();
				String seminarState = "교육 등록(불허) : " +  seminarVO.getSeminarReason();
				if(seminarVO.getSeminarState().equals("A")) seminarState = "교육 등록이 승인 되었습니다.";
				if(seminarVO.getCheckSeminarId().indexOf(",") >  -1){
					String checkNoArray[] = seminarVO.getCheckSeminarId().split(",");
					for(int i=0; i<checkNoArray.length; i++){
						String array[] = checkNoArray[i].split("//");
				    	alrimVO.setAlrimGubun("S");
				    	alrimVO.setAlrimTitle(seminarState);
				    	alrimVO.setAlrimLink("/seminar/SeminarScheduleList.do");	
				    	alrimVO.setAlrimMenuId(34000);
				    	alrimVO.setAlrimWriterId(user.getId());		
				    	alrimVO.setAlrimApprovalId(array[1]);

				    	//승인OR불허 업데이트
				    	seminarVO.setSeminarId(array[0]);
						seminarService.updateSeminarState(seminarVO);
						
				    	//알림등록
						alrimService.insertAlrim(alrimVO);
						
					}
				} else{
					String array[] = seminarVO.getCheckSeminarId().split("//");
			    	alrimVO.setAlrimGubun("S");			
			    	alrimVO.setAlrimTitle(seminarState);			
			    	alrimVO.setAlrimLink("/seminar/SeminarScheduleList.do");			
			    	alrimVO.setAlrimMenuId(34000);			
			    	alrimVO.setAlrimWriterId(user.getId());			
			    	alrimVO.setAlrimApprovalId(array[1]);
					
					seminarVO.setSeminarId(array[0]);
					seminarService.updateSeminarState(seminarVO);
					
					//알림등록
					alrimService.insertAlrim(alrimVO);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return "forward:/seminar/SeminarApproval.do";
	}

	/**
	 * 교육신청내역 목록
	 * @param commandMap
	 * @param model
	 * @return view 페이지
	 * @exception Exception
	 */
	@RequestMapping("/seminar/SeminarApplicationList.do")
	public String seminarApplicationList(
			Map<String, Object> commandMap,
			@ModelAttribute("searchVO") SeminarSearchVO searchVO, 
			ModelMap model) throws Exception {
		
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
		
		List<SeminarVO> resultList = seminarService.selectSeminarApplication(searchVO);
		for(int i = 0; i < resultList.size(); i++) {
			//참여인원 마감처리
			if(resultList.get(i).getSeminarCount() == resultList.get(i).getEntryCount()) {
				resultList.get(i).setSeminarClosingStateName("신청마감");
				resultList.get(i).setSeminarClosingState("N");
			}
			
			if(resultList.get(i).getSeminarClosingStateName().equals("신청가능")) {
				resultList.get(i).setSeminarClosingState("Y");
			} else {
				resultList.get(i).setSeminarClosingState("N");
			}
		}
		
		int totCnt = seminarService.selectSeminarApplicationTotCnt(searchVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", totCnt);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("menu", commandMap.get("menu"));
		model.addAttribute("no", commandMap.get("no"));
		return "seminar/seminarApplicationList";
	}

	/**
	 * 교육 참석자 목록 조회
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping("/seminar/selSeminarEntryView.do")
	public ModelAndView selSeminarEntryView(@RequestParam(value="seminarId", required=false) String seminarId) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		SeminarVO seminarVO = new SeminarVO();
		seminarVO.setSeminarId(seminarId);
		List<SeminarEntryVO> resultList = seminarService.selSeminarEntryView(seminarVO);
		modelAndView.addObject("resultList", resultList);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}

	/**
	 * 교육신청내역 상세보기
	 * @param commandMap
	 * @param SeminarSearchVO
	 * @param ModelMap
	 * @return view 페이지
	 * @exception Exception
	 */
	@RequestMapping("/seminar/SeminarApplicationView.do")
	public String seminarApplicationView(
			Map<String, Object> commandMap,
			@ModelAttribute("searchVO") SeminarSearchVO searchVO,
			@ModelAttribute("seminarVO") SeminarVO seminarVO,
			ModelMap model) throws Exception {
		
		//조회수 업데이트
//		seminarService.updateSeminarCnt(seminarVO);
		//교육 상세 보기 조회
		SeminarVO vo = seminarService.selSeminarInfoView(seminarVO);
		//교육 참여자수 카운트 조회
		/*SeminarEntryVO seminarEntryVO = new SeminarEntryVO();
		seminarEntryVO.setSeminarId(seminarVO.getSeminarId());
		int entryCnt = seminarService.selSeminarEntryCnt(seminarEntryVO);*/
		//교육 참여자 목록 조회
//		List<SeminarEntryVO> resultList = seminarService.selSeminarEntryView(seminarVO);
		
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("result", vo);
		/*model.addAttribute("resultMemList", resultList);
		model.addAttribute("entryCnt", entryCnt);*/
		model.addAttribute("menu", commandMap.get("menu"));
		model.addAttribute("no", commandMap.get("no"));

		return "seminar/seminarApplicationView";
	}
	
	/**
	 * 교육 신청/제외 처리
	 * 
	 * @param seminarVO
	 * @param commandMap
	 * @param model
	 * @return view 페이지
	 * @throws Exception
	 */
	@RequestMapping("/seminar/UpdateSeminarEntry.do")
	public ModelAndView updateSeminarEntry(
			@ModelAttribute("searchVO") SeminarSearchVO searchVO,
			@ModelAttribute("seminarEntryVO") SeminarEntryVO seminarEntryVO,
			@ModelAttribute("seminarVO") SeminarVO seminarVO)
		throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if (isAuthenticated) {
			try {
				LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
				SeminarSearchVO searchVO2 = new SeminarSearchVO();
				if(searchVO.getUrlStr().equals("SeminarApplicationList.do")){
					//제외처리
					seminarEntryVO.setModId(user.getId());
					seminarEntryVO.setSeminarId(seminarVO.getSeminarId());
					seminarEntryVO.setEntryYn("N");
					
					AlrimVO alrimVO = new AlrimVO();
					String reason = "교육 신청(제외) : " +  seminarEntryVO.getEntryReason();
					
					if(seminarVO.getCheckSeminarId().indexOf(",") >  -1){
						String checkNoArray[] = seminarVO.getCheckSeminarId().split(",");
						for(int i=0; i<checkNoArray.length; i++){
							String array[] = checkNoArray[i].split("//");
					    	alrimVO.setAlrimGubun("S");
					    	alrimVO.setAlrimTitle(reason);
					    	//추후 링크 수정
					    	alrimVO.setAlrimLink("/seminar/SeminarScheduleList.do");
					    	alrimVO.setAlrimMenuId(34000);
					    	alrimVO.setAlrimWriterId(user.getId());
					    	alrimVO.setAlrimApprovalId(array[1]);
	
					    	//알림등록
							alrimService.insertAlrim(alrimVO);
							
							seminarEntryVO.setSeminarEntryId(array[0]);
							seminarService.updateSeminarEntry(seminarEntryVO);
						}
					} else{
						String array[] = seminarVO.getCheckSeminarId().split("//");
				    	alrimVO.setAlrimGubun("S");			
				    	alrimVO.setAlrimTitle(reason);			
				    	alrimVO.setAlrimLink("/seminar/SeminarScheduleList.do");			
				    	alrimVO.setAlrimMenuId(34000);			
				    	alrimVO.setAlrimWriterId(user.getId());			
				    	alrimVO.setAlrimApprovalId(array[1]);
	
				    	//알림등록
						alrimService.insertAlrim(alrimVO);
						
						seminarEntryVO.setSeminarEntryId(array[0]);
						seminarService.updateSeminarEntry(seminarEntryVO);
					}
					
					//교육 참가자 신청 조회
					
					String countArray = seminarService.selectCheckSeminarEntryCount(seminarVO);
					if(countArray.equals("신청마감")) {
						//교육 참가자 수와 신청 참여자 수가 같은 경우 마감처리
						searchVO2.setSearchSeminarId(seminarVO.getSeminarId());
						searchVO2.setSearchClosingState("Y");
						searchVO2.setSearchUClosingState("N");
						seminarService.updateSeminarAutoClosingState(searchVO2);
					} else {
						searchVO2.setSearchSeminarId(seminarVO.getSeminarId());
						searchVO2.setSearchClosingState("N");
						searchVO2.setSearchUClosingState("Y");
						seminarService.updateSeminarAutoClosingState(searchVO2);
					}
				} else {
					//교육 신청하기
					seminarEntryVO.setSeminarMemId(user.getId());
					seminarEntryVO.setEntryYn("Y");
					seminarEntryVO.setWriterId(user.getId());
					seminarEntryVO.setSeminarId(seminarVO.getSeminarId());
					
					// 교육 중복신청 체크
					int count = seminarService.selectCheckSeminarEntry(seminarEntryVO);
					if(count >  0) {
						//중복 신청한 경우
						modelAndView.addObject("resultStr", "NG");
						modelAndView.addObject("msg", "이미 신청하신 교육입니다.");
					} else {
						//교육 참가자 신청 조회
						String countArray = seminarService.selectCheckSeminarEntryCount(seminarVO);
						if(countArray.equals("신청마감")) {
							//교육 참가자 수와 신청 참여자 수가 같은 경우 마감처리
							searchVO2.setSearchSeminarId(seminarVO.getSeminarId());
							searchVO2.setSearchClosingState("Y");
							searchVO2.setSearchUClosingState("N");
							seminarService.updateSeminarAutoClosingState(searchVO2);
							
							modelAndView.addObject("resultStr", "NG");
							modelAndView.addObject("msg", "이미 마감된 교육입니다.");
							modelAndView.setViewName("jsonView");
							return modelAndView;
						}
						
						//중복 신청이 아닌 경우
						modelAndView.addObject("resultStr", "OK");
						seminarService.insertSeminarEntry(seminarEntryVO);
						modelAndView.addObject("msg", "교육 신청이 완료되었습니다. 마이페이지> 나의교육에서 신청하신 교육을 확인 하실 수 있습니다.");
						
						//교육 참가자 신청 조회
						String countArray2 = seminarService.selectCheckSeminarEntryCount(seminarVO);
						if(countArray2.equals("신청마감")) {
							//교육 참가자 수와 신청 참여자 수가 같은 경우 마감처리
							searchVO2.setSearchSeminarId(seminarVO.getSeminarId());
							searchVO2.setSearchClosingState("Y");
							searchVO2.setSearchUClosingState("N");
							seminarService.updateSeminarAutoClosingState(searchVO2);
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 교육 신청 참가자 여부 조회
	 * @param 
	 * @return 
	 * @exception Exception
	 */
	@RequestMapping("/seminar/SelectSeminarEntryCount.do")
	public ModelAndView selectSeminarEntryCount(
			@RequestParam(value="seiminarArray", required=false) String seiminarArray
		) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		//교육 참여자수 카운트 조회
		SeminarEntryVO seminarEntryVO = new SeminarEntryVO();
		boolean confirm = false;
		try {
			if(seiminarArray.indexOf(",") > 0) {
				String [] seminarInfo = seiminarArray.split(",");
				for(int i=0; i<seminarInfo.length; i++) {
					String [] seminarIdArray = seminarInfo[i].split("//");
					seminarEntryVO.setSeminarId(seminarIdArray[0]);
					int entryCnt = seminarService.selSeminarEntryCnt(seminarEntryVO);
					if(entryCnt > 0) {
						confirm = true;
						break;
					}
				}
			} else {
				String [] seminarInfo = seiminarArray.split("//");
				seminarEntryVO.setSeminarId(seminarInfo[0]);
				int entryCnt = seminarService.selSeminarEntryCnt(seminarEntryVO);
				//참가자가 있는 경우
				if(entryCnt > 0) confirm = true;
			}
			modelAndView.addObject("confirm", confirm);
			modelAndView.setViewName("jsonView");
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return modelAndView;
	}
	
	/**
	 * 교육일정 엑셀 다운로드
	 */
	@RequestMapping("/seminar/ScheduleListExcel.do")
	public ModelAndView selectScheduleDataListExcel (
			@ModelAttribute("searchVO") SeminarSearchVO searchVO 
	) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		ModelAndView mav = null;
		
		//승인된 교육 등록 총 카운트 조회
		int totCnt = seminarService.selectSeminarApplicationTotCnt(searchVO);
		//접수된 교육 총 카운트 조회
		int totACnt = seminarService.selectAcceptTot(searchVO);
		//실시 완료된 총 카운트 조회
		int totCCnt = seminarService.selectCompleteTot(searchVO);
		//실시예정된 총 카운트 조회
		int totPCnt = seminarService.selectPlanTot(searchVO);
		//교육 신청 총 카운트 조회
		int totSCnt = seminarService.selectSeminarTot(searchVO);
		//강사 신청 총 카운트 조회
		int totLCnt = seminarService.selectLectTot(searchVO);
		
		searchVO.setPageSize(propertyService.getInt("pageSize"));
		searchVO.setFirstIndex(0);
		searchVO.setRecordCountPerPage(totCnt);
		
		List<SeminarVO> data = seminarService.selectSeminarApplication(searchVO);
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
		
		map.put("totCnt", totCnt);
		map.put("totACnt", totACnt);
		map.put("totCCnt", totCCnt);
		map.put("totPCnt", totPCnt);
		map.put("totSCnt", totSCnt);
		map.put("totLCnt", totLCnt);		
		map.put("data", data);
		map.put("searchVO", searchVO);
		
		mav = new ModelAndView("ExcelViewSeminarSchedule", "map", map);
		return mav;
	}
	
	/**
	 * 교육 등록 엑셀 다운로드
	 */
	@RequestMapping("/seminar/RegistListExcel.do")
	public ModelAndView selectRegistDataListExcel (
			@ModelAttribute("searchVO") SeminarSearchVO searchVO 
	) throws Exception {
		
		Map<String, Object> map = new HashMap<String, Object>();
		ModelAndView mav = null;
		
		int totCnt = seminarService.selectSeminarTotCnt(searchVO);
		
		searchVO.setPageSize(propertyService.getInt("pageSize"));
		searchVO.setFirstIndex(0);
		searchVO.setRecordCountPerPage(totCnt);
		List<SeminarVO> data = seminarService.selectSeminarInfo(searchVO);
		map.put("data", data);
		map.put("searchVO", searchVO);
		mav = new ModelAndView("ExcelViewSeminarRegist", "map", map);
		
		return mav;
	}
	
	/**
	 * 교육 승인 엑셀 다운로드
	 */
	@RequestMapping("/seminar/ApprovalExcel.do")
	public ModelAndView selectApprovalDataListExcel (
			@ModelAttribute("searchVO") SeminarSearchVO searchVO 
	) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		ModelAndView mav = null;
		
		int totCnt = seminarService.selectSeminarTotCnt(searchVO);
		
		searchVO.setPageSize(propertyService.getInt("pageSize"));
		searchVO.setFirstIndex(0);
		searchVO.setRecordCountPerPage(totCnt);
		List<SeminarVO> data =  seminarService.selectSeminarInfo(searchVO);
		map.put("data", data);
		map.put("searchVO", searchVO);
		
		mav = new ModelAndView("ExcelViewSeminarApproval", "map", map);
		
		return mav;
	}
	
	/**
	 * 교육신청 내역 다운로드
	 */
	@RequestMapping("/seminar/ApplicationListExcel.do")
	public ModelAndView selectApplicationDataListExcel (
			@ModelAttribute("searchVO") SeminarSearchVO searchVO 
	) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		ModelAndView mav = null;
		
		int totCnt = seminarService.selectSeminarApplicationTotCnt(searchVO);
		
		searchVO.setPageSize(propertyService.getInt("pageSize"));
		searchVO.setFirstIndex(0);
		searchVO.setRecordCountPerPage(totCnt);
		List<SeminarVO> data = seminarService.selectSeminarApplication(searchVO);
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
		
		mav = new ModelAndView("ExcelViewSeminarApplication", "map", map);
		
		return mav;
	}
}