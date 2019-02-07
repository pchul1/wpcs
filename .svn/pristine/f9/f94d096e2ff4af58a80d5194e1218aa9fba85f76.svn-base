package daewooInfo.mobile.seminar.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import daewooInfo.cmmn.service.EgovFileMngService;
import daewooInfo.common.alrim.bean.AlrimVO;
import daewooInfo.common.alrim.service.AlrimService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.EgovFileMngUtil;
import daewooInfo.dailywork.bean.DailyWorkSearchVO;
import daewooInfo.mobile.com.utl.LogInfoUtil;
import daewooInfo.mobile.com.utl.ObjectUtil;
import daewooInfo.seminar.bean.SeminarEntryVO;
import daewooInfo.seminar.bean.SeminarSearchVO;
import daewooInfo.seminar.bean.SeminarVO;
import daewooInfo.seminar.service.SeminarService;
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
public class MobileSeminarController {
	/**
	 * log
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log log = LogFactory.getLog(MobileSeminarController.class);
	
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
   	 * 교육일정 검색
   	 * 2014.09.18
   	 * @param commandMap
   	 * @return
   	 * @throws Exception
   	 */
   	@RequestMapping("/mobile/sub/seminar/SeminarScheduleSearch.do")
   	public String SeminarScheduleSearch(@RequestParam(value="gubun", required=false) String gubun, @ModelAttribute("searchVO") DailyWorkSearchVO searchVO, ModelMap model) throws Exception {
   		return "mobile/sub/seminar/seminarScheduleSearch";
   	}
	
	/**
	 * 교육일정 목록
	 * @param alrimVO
	 * @return view 페이지
	 * @exception Exception
	 */
	@RequestMapping("/mobile/sub/seminar/SeminarScheduleList.do")
	public String seminarScheduleList(
			HttpServletResponse res,
			HttpServletRequest req,
			Map<String, Object> commandMap,
			@ModelAttribute("searchVO") SeminarSearchVO searchVO, 
			ModelMap model) throws Exception {
		
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
		//접수된 교육 총 카운트
		int totACnt = seminarService.selectAcceptTot(searchVO);
		//실시 완료된 총 카운트
		int totCCnt = seminarService.selectCompleteTot(searchVO);
		//실시예정된 총 카운트
		int totPCnt = seminarService.selectPlanTot(searchVO);
		//교육 신청 총 카운트
		int totSCnt = seminarService.selectSeminarTot(searchVO);
		//강사 신청 총 카운트
		int totLCnt = seminarService.selectLectTot(searchVO);
		
		paginationInfo.setTotalRecordCount(totCnt);  
		String param = ObjectUtil.RequestParamString(req, "searchBgnDe,searchEndDe,searchGubun,searchClosingState",false);
		model.addAttribute("listparameter", param);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", totCnt);
		model.addAttribute("totACnt", totACnt);
		model.addAttribute("totCCnt", totCCnt);
		model.addAttribute("totPCnt", totPCnt);
		model.addAttribute("totSCnt", totSCnt);
		model.addAttribute("totLCnt", totLCnt);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		return "/mobile/sub/seminar/seminarScheduleList";
	}
	

	/**
	 * 교육신청내역 상세보기
	 * @param commandMap
	 * @param SeminarSearchVO
	 * @param ModelMap
	 * @return view 페이지
	 * @exception Exception
	 */
	@RequestMapping("/mobile/sub/seminar/SeminarApplicationView.do")
	public String seminarApplicationView(
			HttpServletResponse res,
			HttpServletRequest req,
			Map<String, Object> commandMap,
			@ModelAttribute("searchVO") SeminarSearchVO searchVO,
			@ModelAttribute("seminarVO") SeminarVO seminarVO,
			ModelMap model) throws Exception {
		
		//조회수 업데이트
		seminarService.updateSeminarCnt(seminarVO);
		//교육 상세 보기 조회
		SeminarVO vo = seminarService.selSeminarInfoView(seminarVO);
		//교육 참여자수 카운트 조회
		SeminarEntryVO seminarEntryVO = new SeminarEntryVO();
		seminarEntryVO.setSeminarId(seminarVO.getSeminarId());
		int entryCnt = seminarService.selSeminarEntryCnt(seminarEntryVO);
		//교육 참여자 목록 조회
		List<SeminarEntryVO> resultList = seminarService.selSeminarEntryView(seminarVO);

		String param = ObjectUtil.RequestParamString(req, "searchBgnDe,searchEndDe,searchGubun,searchClosingState",false);
		model.addAttribute("listparameter", param);
		
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("ApplicationList", ServletRequestUtils.getStringParameter(req, "Seminargubun", "SeminarList"));
		model.addAttribute("result", vo);
		model.addAttribute("resultMemList", resultList);
		model.addAttribute("entryCnt", entryCnt);
		model.addAttribute("menu", commandMap.get("menu"));
		model.addAttribute("no", commandMap.get("no"));

		return "/mobile/sub/seminar/seminarApplicationView";
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
	@RequestMapping("/mobile/sub/seminar/UpdateSeminarEntry.do")
	public String updateSeminarEntry(
			HttpServletResponse res,
			HttpServletRequest req,
			@ModelAttribute("searchVO") SeminarSearchVO searchVO,
			@ModelAttribute("seminarEntryVO") SeminarEntryVO seminarEntryVO,
			@ModelAttribute("seminarVO") SeminarVO seminarVO,
			ModelMap model)
		throws Exception {
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();

		String param = ObjectUtil.RequestParamString(req, "seminarId,searchBgnDe,searchEndDe,searchGubun,searchClosingState");
		
		if (isAuthenticated) {
			try {
				LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
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
					return "jsonView";
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
						res.setContentType("text/html; charset=UTF-8");
						res.getWriter().print("<script>alert('교육을 이미 신청하셨습니다.');document.location.replace('/mobile/sub/seminar/SeminarApplicationView.do"+param+"');</script>");
					} else {
						//중복 신청이 아닌 경우
						seminarService.insertSeminarEntry(seminarEntryVO);
						res.setContentType("text/html; charset=UTF-8");
						res.getWriter().print("<script>alert('교육 신청이 완료되었습니다. 교육신청내역에서 신청하신 교육 내역을 확인 하실 수 있습니다.');document.location.replace('/mobile/sub/seminar/MySeminarScheduleList.do"+param+"');</script>");
					}
					
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	

    /**
   	 * 교육신청내역 검색
   	 * 2014.09.18
   	 * @param commandMap
   	 * @return
   	 * @throws Exception
   	 */
   	@RequestMapping("/mobile/sub/seminar/MySeminarScheduleSearch.do")
   	public String SeminarApplicationSearch(@RequestParam(value="gubun", required=false) String gubun, @ModelAttribute("searchVO") DailyWorkSearchVO searchVO, ModelMap model) throws Exception {
   		return "mobile/sub/seminar/MySeminarScheduleSearch";
   	}

	/**
	 * 교육신청내역 목록
	 * @param commandMap
	 * @param model
	 * @return view 페이지
	 * @exception Exception
	 */
	@RequestMapping("/mobile/sub/seminar/MySeminarScheduleList.do")
	public String seminarApplicationList(
			HttpServletResponse res,
			HttpServletRequest req,
			Map<String, Object> commandMap,
			@ModelAttribute("searchVO") SeminarSearchVO searchVO, 
			ModelMap model) throws Exception {
		
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
		return "/mobile/sub/seminar/MySeminarScheduleList";
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
	@RequestMapping("/mobile/sub/seminar/CancelSeminarEntry.do")
	public void updateSeminarEntry(@ModelAttribute("searchVO") SeminarEntryVO searchVO , HttpServletRequest request , HttpServletResponse response) throws Exception {	
		try {
			//제외처리  
			searchVO.setModId(LogInfoUtil.GetSessionLogin().getId());
			searchVO.setEntryYn("N");
			seminarService.updateSeminarEntry(searchVO);
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().print("<script>alert('성공적으로 교육취소가 되었습니다.');document.location.href='/mobile/sub/seminar/MySeminarScheduleList.do';</script>");
		} catch (Exception e) {
			e.printStackTrace();
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().print("<script>alert('error');document.location.href='/mobile/sub/seminar/MySeminarScheduleList.do';</script>");
		}
	}
}