package daewooInfo.dailywork.web;

import java.io.FileInputStream;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.alert.util.SendSMS;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.cmmn.service.EgovFileMngService;
import daewooInfo.common.TmsMessageSource;
import daewooInfo.common.alrim.bean.AlrimVO;
import daewooInfo.common.alrim.service.AlrimService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.EgovFileMngUtil;
import daewooInfo.common.util.fcc.StringUtil;
import daewooInfo.dailywork.bean.CheckUseDetailVO;
import daewooInfo.dailywork.bean.CheckUseVO;
import daewooInfo.dailywork.bean.DailyWorkApprovalVO;
import daewooInfo.dailywork.bean.DailyWorkRainVO;
import daewooInfo.dailywork.bean.DailyWorkSearchVO;
import daewooInfo.dailywork.bean.DailyWorkVO;
import daewooInfo.dailywork.bean.DailyWorkWriteAuthVO;
import daewooInfo.dailywork.bean.DateDataVO;
import daewooInfo.dailywork.bean.MonitoringVO;
import daewooInfo.dailywork.bean.RiverMainVO;
import daewooInfo.dailywork.bean.SituationRoomVO;
import daewooInfo.dailywork.service.DailyWorkService;
import daewooInfo.dailywork.service.MonitoringService;
import daewooInfo.dailywork.service.RiverMainService;
import daewooInfo.dailywork.service.SituationRoomService;
import daewooInfo.seminar.bean.SeminarSearchVO;
import egovframework.rte.fdl.cmmn.exception.EgovBizException;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 
 * 업무일지 관리
 * @author yrkim
 * @since 2014.09.18
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2014.09.18  yrkim          최초 생성
 *
 * </pre>
 */

@Controller
//public class DailyWorkController {
public class DailyWorkController {
	/**
	 * @uml.property  name="dailyWorkService"
	 */
	@Resource(name = "DailyWorkService")
    private DailyWorkService dailyWorkService;
	
	/**
	 * @uml.property  name="dailyWorkService"
	 */
	@Resource(name = "SituationRoomService")
    private SituationRoomService situationRoomService;
	
	/**
	 * @uml.property  name="riverMainService"
	 */
	@Resource(name = "RiverMainService")
    private RiverMainService riverMainService;
	
	/**
	 * @uml.property  name="monitoringService"
	 */
	@Resource(name = "MonitoringService")
    private MonitoringService monitoringService;
	
	/**
	 * @uml.property  name="propertyService"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	/**
	 * EgovMessageSource
	 * @uml.property  name="tmsMessageSource"
	 */
	@Resource(name="tmsMessageSource")
	TmsMessageSource tmsMessageSource;
	
	/**
	 * AlrimService
	 * @uml.property  name="alrimService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alrimService")
	private AlrimService alrimService;    
	
	@Resource(name = "dailyWorkIdGnrService")
    private EgovIdGnrService idgenDailyWorkService;
	
	/**
	 * log
	 * @uml.property  name="log"
	 */
    Log log = LogFactory.getLog(DailyWorkController.class);
	
    /**
	 * @uml.property  name="fileUtil"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	/**
	 * @uml.property  name="fileMngService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;
	
    public static String searchDate(String gubun){
    	DecimalFormat df = new DecimalFormat("00");
		Calendar currentCalendar = Calendar.getInstance();
		
		if(gubun.equals("addMonth")){
			//한달 전 날짜 구하기
			currentCalendar.add(currentCalendar.MONTH, -1);
		}
		
	    String year   = Integer.toString(currentCalendar.get(Calendar.YEAR));
	    String month  = df.format(currentCalendar.get(Calendar.MONTH) + 1);
	    String day   = df.format(currentCalendar.get(Calendar.DATE));
	    String date = year +"/"+month +"/"+day;
	    
    	return date;
    }
    
   /**
	 * 업무일지 목록 데이터
	 * 2014.09.18
	 * yrkim
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dailywork/dailyWorkList.do")
	public String dailyWorkList(
			@RequestParam(value="gubun", required=false) String gubun,
			@ModelAttribute("searchVO") DailyWorkSearchVO searchVO, 
			Map<String, Object> commandMap,
			ModelMap model) throws Exception {
		
		String returnValue = "/dailywork/dailyWorkList";
		
		if(StringUtil.isEmpty(searchVO.getStartDate())){
			searchVO.setStartDate(searchDate("addMonth"));
			searchVO.setEndDate(searchDate("today"));
		}
			
		searchVO.setPageUnit(10);		
		
		searchVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
	
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		searchVO.setSearchGubun(gubun);		//상황실근무일지:S, 4대강주요수계일지:R, 조류모니터링:M
		
		Map<String, Object> map = dailyWorkService.dailyWorkList(searchVO);
		
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		List<DailyWorkSearchVO> resultList = (List<DailyWorkSearchVO>)map.get("resultList");
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", totCnt);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("gubun", gubun);
		model.addAttribute("menu", commandMap.get("menu"));
		model.addAttribute("no", commandMap.get("no"));
		
		return returnValue;
	}
	
	/**
	 * 업무일지 삭제
	 */
	@RequestMapping("/dailywork/dailyWorkInfoDelete.do")	
	public ModelAndView dailyWorkInfoDelete(
			 Map<String, Object> commandMap
			 , HttpServletResponse res
			 , @RequestParam(value="dailyWorkId", required=false) String dailyWorkId
			 , @RequestParam(value="gubun", required=false) String gubun
			 )throws Exception {
		
		try{
			
			dailyWorkService.dailyWorkInfoDelete(dailyWorkId);
			
			String url = "";
			
			if(gubun.equals("S")){
				url = "<script>alert('업무일지가 정상적으로 삭제되었습니다.');document.location.href='/dailywork/dailyWorkList.do?gubun=S'</script>";
			}else if(gubun.equals("R")){
				url = "<script>alert('업무일지가 정상적으로 삭제되었습니다.');document.location.href='/dailywork/dailyWorkList.do?gubun=R'</script>";
			}else if(gubun.equals("M")){
				url = "<script>alert('업무일지가 정상적으로 삭제되었습니다.');document.location.href='/dailywork/dailyWorkList.do?gubun=M'</script>";
			}else{
				url = "<script>alert('업무일지가 정상적으로 삭제되었습니다.');document.location.href='/dailywork/dailyWorkList.do?gubun=S'</script>";
			}
			
			res.setContentType("text/html; charset=UTF-8");
			res.getWriter().print(url);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 업무일지 결재정보 회수
	 */
	@RequestMapping("/dailywork/dailyWorkInfoCancel.do")	
	public ModelAndView dailyWorkInfoCancel(
			 Map<String, Object> commandMap
			 , HttpServletResponse res
			 , @RequestParam(value="dailyWorkId", required=false) String dailyWorkId
			 , @RequestParam(value="gubun", required=false) String gubun
			 , @RequestParam(value="approvalId", required=false) String approvalId
			 )throws Exception {
		
		try{
			//T_DAILY_WORK : STATE, APPROVAL_ID, APPROVAL_DATE 변경
			dailyWorkService.updateDailyWorkCancel(dailyWorkId);
			
			String url = "";
			
			if(gubun.equals("S")){
				url = "<script>alert('업무일지가 정상적으로 회수되었습니다.');document.location.href='/dailywork/dailyWorkList.do?gubun=S'</script>";
			}
			
			res.setContentType("text/html; charset=UTF-8");
			res.getWriter().print(url);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 결재자 정보 가져오기
	 */
	@RequestMapping("/dailywork/getApprovalInfo.do")
	public ModelAndView getApprovalInfo(
			 @RequestParam(value="approvalId1", required=false) String approvalId1
			,@RequestParam(value="approvalId2", required=false) String approvalId2
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		String approvalName1 = dailyWorkService.approvalNameSelect(approvalId1);
		String approvalName2 = dailyWorkService.approvalNameSelect(approvalId2);
		
        modelAndView.addObject("approvalName1", approvalName1);
        modelAndView.addObject("approvalName2", approvalName2);
        modelAndView.setViewName("jsonView");

        return modelAndView;
	}
	
	/**
	 * 근무일지 상세조회 팝업
	 */
	@RequestMapping("/dailywork/dailyWorkPrintView_popup.do")
	public ModelAndView dailyWorkPrintView_popup(
			  HttpServletResponse res
			, Map<String, Object> commandMap
			, @RequestParam(value="dailyWorkId", 		required=false) String dailyWorkId
			, @RequestParam(value="printGubun", 		required=false) String printGubun
			, @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO
			, ModelAndView modelAndView
			) throws Exception {
		
		dailyWorkVO = dailyWorkService.selectDailyWorkMasterInfo(dailyWorkId);													//업무일지 기본정보
		List<DailyWorkApprovalVO> approvalList= dailyWorkService.selectDailyWorkApprovalList(dailyWorkId);				//업무일지 결재정보
		
		if(printGubun.equals("S")){
			SituationRoomVO situationRoomVO = new SituationRoomVO();
			DailyWorkRainVO dailyWorkRainVO = new DailyWorkRainVO();
			
			situationRoomVO = situationRoomService.selectSituationRoomInfo(dailyWorkId);										//상황실 근무일지 근무상황정보
			
			situationRoomVO.setDailyWorkId(dailyWorkId);
			
			situationRoomVO.setSpreadGubun("S");
			List<SituationRoomVO> spreadSList = situationRoomService.selectSituationSpreadInfo(situationRoomVO);	//업무일지 상황전파 현황
			
			situationRoomVO.setSpreadGubun("G");
			List<SituationRoomVO> spreadGList = situationRoomService.selectSituationSpreadInfo(situationRoomVO);	//업무일지 상황전파 현황
			
			dailyWorkRainVO.setDailyWorkId(dailyWorkId);
			List<DailyWorkRainVO> rainFallList = dailyWorkService.selectDailyWorkRainInfo(dailyWorkRainVO);				//업무일지 강우현황
			
			modelAndView.addObject("situationRoomVO", situationRoomVO);
			modelAndView.addObject("spreadSList", spreadSList);
			modelAndView.addObject("spreadGList", spreadGList);
			modelAndView.addObject("rainFallList", rainFallList);
			
			modelAndView.setViewName("dailywork/situationRoomPrintView");
		}else if(printGubun.equals("R")){
			
			RiverMainVO riverMainVO = new RiverMainVO();
			riverMainVO = riverMainService.selectRiverMainInfo(dailyWorkId);															//4대강주요수계일지정보
			
			modelAndView.addObject("riverMainVO", riverMainVO);
			
			modelAndView.setViewName("dailywork/riverMainPrintView");
		}else if(printGubun.equals("M")){
			
			MonitoringVO monitoringVO = new MonitoringVO();
			DailyWorkRainVO dailyWorkRainVO = new DailyWorkRainVO();
			
			monitoringVO = monitoringService.selectMonitoringInfo(dailyWorkId);														//조류모니터링 기본정보
			
			monitoringVO.setDailyWorkId(dailyWorkId);
			
			List<MonitoringVO> forecastSList = monitoringService.selectForeCastInfo(monitoringVO);							//수질예측정보
			
			dailyWorkRainVO.setDailyWorkId(dailyWorkId);
			List<DailyWorkRainVO> rainFallList = dailyWorkService.selectDailyWorkRainInfo(dailyWorkRainVO);				//업무일지 강우현황
			
			modelAndView.addObject("monitoringVO", monitoringVO);
			modelAndView.addObject("forecastSList", forecastSList);
			modelAndView.addObject("rainFallList", rainFallList);
			
			modelAndView.setViewName("dailywork/monitoringPrintView");
		}
		
		modelAndView.addObject("dailyWorkVO", dailyWorkVO);
		modelAndView.addObject("approvalList", approvalList);
		
		
		return modelAndView;
	}
	

	/**
	 * 받은결재
	 * 2014.10.02
	 * yrkim
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dailywork/receiveApprovalList.do")
	public String receiveApprovalList(
			@ModelAttribute("searchVO") DailyWorkSearchVO searchVO, 
			Map<String, Object> commandMap,
			ModelMap model) throws Exception {
		
		String returnValue = "dailywork/receiveApprovalList";
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		
		if(StringUtil.isEmpty(searchVO.getStartDate())){
			searchVO.setStartDate(searchDate("addMonth"));
			searchVO.setEndDate(searchDate("today"));
		}
			
		searchVO.setPageUnit(10);		
		
		searchVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
	
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		searchVO.setUserId(user.getId());
		Map<String, Object> map = dailyWorkService.receiveApprovalList(searchVO);
		
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		List<DailyWorkSearchVO> resultList = (List<DailyWorkSearchVO>)map.get("resultList");
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", totCnt);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("menu", commandMap.get("menu"));
		model.addAttribute("no", commandMap.get("no"));
		
		return returnValue;
	}
	
	/**
	 * 받은결재 상세
	 * 2014.10.06
	 * yrkim
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dailywork/receiveApprovalDetail.do")
	public ModelAndView situationRoomDetail(
			  @RequestParam(value="dailyWorkId", 		required=false) String dailyWorkId
			, @RequestParam(value="gubun", 				required=false) String gubun
			, @RequestParam(value="approvalSeq", 		required=false) String approvalSeq
			, @RequestParam(value="appCheck", 			required=false) String appCheck
			, @RequestParam(value="pageNo", 			required=false) String pageNo
			, @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO
			, @ModelAttribute("dailyWorkRainVO") DailyWorkRainVO dailyWorkRainVO
			, ModelAndView modelAndView
			) throws Exception {
		
		dailyWorkVO = dailyWorkService.selectDailyWorkMasterInfo(dailyWorkId);													//업무일지 기본정보
		List<DailyWorkApprovalVO> approvalList= dailyWorkService.selectDailyWorkApprovalList(dailyWorkId);				//업무일지 결재정보
		
		if(gubun.equals("S")){
			SituationRoomVO situationRoomVO = new SituationRoomVO();
			
			situationRoomVO = situationRoomService.selectSituationRoomInfo(dailyWorkId);										//상황실 근무일지 근무상황정보
			
			situationRoomVO.setDailyWorkId(dailyWorkId);
			
			situationRoomVO.setSpreadGubun("S");
			List<SituationRoomVO> spreadSList = situationRoomService.selectSituationSpreadInfo(situationRoomVO);	//업무일지 상황전파 현황
			
			situationRoomVO.setSpreadGubun("G");
			List<SituationRoomVO> spreadGList = situationRoomService.selectSituationSpreadInfo(situationRoomVO);	//업무일지 상황전파 현황
			
			List<DailyWorkRainVO> rainFallList = dailyWorkService.selectDailyWorkRainInfo(dailyWorkRainVO);				//업무일지 강우현황
			
			modelAndView.addObject("situationRoomVO", situationRoomVO);
			modelAndView.addObject("spreadSList", spreadSList);
			modelAndView.addObject("spreadGList", spreadGList);
			modelAndView.addObject("rainFallList", rainFallList);
			
			modelAndView.setViewName("dailywork/situationRoomDetail");
			
		}else if(gubun.equals("R")){
			RiverMainVO riverMainVO = new RiverMainVO();
			riverMainVO = riverMainService.selectRiverMainInfo(dailyWorkId);															//4대강주요수계일지정보
			
			modelAndView.addObject("riverMainVO", riverMainVO);
			modelAndView.setViewName("dailywork/riverMainDetail");
			
		}else if(gubun.equals("M")){
			MonitoringVO monitoringVO = new MonitoringVO();
			monitoringVO = monitoringService.selectMonitoringInfo(dailyWorkId);														//조류모니터링 기본정보
			
			monitoringVO.setDailyWorkId(dailyWorkId);
			
			List<MonitoringVO> forecastSList = monitoringService.selectForeCastInfo(monitoringVO);							//수질예측정보
			
			List<DailyWorkRainVO> rainFallList = dailyWorkService.selectDailyWorkRainInfo(dailyWorkRainVO);				//업무일지 강우현황
			
			modelAndView.addObject("monitoringVO", monitoringVO);
			modelAndView.addObject("forecastSList", forecastSList);
			modelAndView.addObject("rainFallList", rainFallList);
			modelAndView.setViewName("dailywork/monitoringDetail");
		}else if(gubun.equals("C")){
			CheckUseVO checkUseVO = new CheckUseVO();
			checkUseVO = dailyWorkService.selectCheckUseMasterInfo(dailyWorkId);					//업무일지 기본정보
			String equipCode1 = checkUseVO.getEquipCode1();
			String equipCode2 = checkUseVO.getEquipCode2();
			String[] arrEquipCode1 = null;
			String[] arrEquipCode2 = null;
			HashMap<String, Object> param = new HashMap<String, Object>();
			/*if(!"".equals(equipCode1) && equipCode1!=null) {
				arrEquipCode1 = equipCode1.split(",");
			}
			if(!"".equals(equipCode2) && equipCode2!=null) {
				arrEquipCode2 = equipCode2.split(",");
			}
			
			param.put("arrEquipCode", arrEquipCode1);
			equipCode1 = dailyWorkService.selectCheckUseEquipName(param);
			checkUseVO.setEquipCode1(equipCode1);
			
			param.put("arrEquipCode", arrEquipCode2);
			equipCode2 = dailyWorkService.selectCheckUseEquipName(param);
			checkUseVO.setEquipCode2(equipCode2);*/
			
			if(!"".equals(equipCode1) && equipCode1!=null) {
				arrEquipCode1 = equipCode1.split(",");
				
				param.put("arrEquipCode", arrEquipCode1);
				equipCode1 = dailyWorkService.selectCheckUseEquipName(param);
				checkUseVO.setEquipCode1(equipCode1);
			}
			if(!"".equals(equipCode2) && equipCode2!=null) {
				arrEquipCode2 = equipCode2.split(",");
				
				param.put("arrEquipCode", arrEquipCode2);
				equipCode2 = dailyWorkService.selectCheckUseEquipName(param);
				checkUseVO.setEquipCode2(equipCode2);
			}
			
			approvalList= dailyWorkService.selectCheckUseApprovalList(dailyWorkId);
			List<CheckUseDetailVO> checkList = dailyWorkService.selectCheckUseDetailList(dailyWorkId);
			
			modelAndView.setViewName("dailywork/checkUseDetail"+checkUseVO.getGubun());
				
			modelAndView.addObject("checkUseVO", checkUseVO);
			modelAndView.addObject("checkList", checkList);
		}
		
		modelAndView.addObject("gubun", gubun);
		modelAndView.addObject("seq", approvalSeq);
		modelAndView.addObject("menuGubun", "app");
		modelAndView.addObject("appCheck", appCheck);
		modelAndView.addObject("pageNo", pageNo);
		modelAndView.addObject("dailyWorkVO", dailyWorkVO);
		modelAndView.addObject("approvalList", approvalList);
		
		return modelAndView;
	}
	
	/**
	 * 결재 승인
	 * 2014.10.07
	 */
	@RequestMapping("/dailywork/approvalProc.do")
	public ModelAndView insertApproval (
			HttpServletResponse res
			, @ModelAttribute("searchVO") DailyWorkSearchVO searchVO
			, @ModelAttribute("dailyWorkApprovalVO") DailyWorkApprovalVO dailyWorkApprovalVO
			, @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO
			, ModelMap model
			, Map<String, Object> commandMap
			) throws Exception {
		try{
				LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
				
				//일지 여러개 선택
				if(dailyWorkApprovalVO.getCheckDailyWorkId().indexOf(",") > -1){
					String checkNoArray[] = dailyWorkApprovalVO.getCheckDailyWorkId().split(",");
					
					for(int i=0; i<checkNoArray.length; i++){
						String dailyWorkInfo[] = checkNoArray[i].split(";");
						String dailyWorkId = dailyWorkInfo[0];
						int seq = Integer.parseInt(dailyWorkInfo[1]);
						String workDay = dailyWorkInfo[2];
						
						dailyWorkApprovalVO.setDailyWorkId(dailyWorkId);
						dailyWorkApprovalVO.setSeq(seq);
						dailyWorkApprovalVO.setApprovalMemberId(user.getId());
						dailyWorkApprovalVO.setApprovalState("A");																				//결재:A 반려:R
						
						dailyWorkService.insertApproval(dailyWorkApprovalVO);
						
						dailyWorkApprovalVO.setSeq(seq+1);
						String approvalMemberId = dailyWorkService.getApprovalMemberId(dailyWorkApprovalVO); 				//결재자 정보 조회
						
						dailyWorkApprovalVO.setApprovalRequestId(user.getId());															//결재요청자
						dailyWorkService.updateApprovalRequestInfo(dailyWorkApprovalVO);												//결재요청일 정보 
						
						dailyWorkVO.setDailyWorkId(dailyWorkId);
						
						if(!StringUtil.isEmpty(approvalMemberId)){
							//알람등록
					    	AlrimVO alrimVO = new AlrimVO();
					    	alrimVO.setAlrimGubun("D");			
					    	alrimVO.setAlrimTitle(workDay+"일지 결재");			
					    	alrimVO.setAlrimLink("/dailywork/receiveApprovalList.do");			
					    	alrimVO.setAlrimMenuId(33210);			
					    	alrimVO.setAlrimWriterId(user.getId());			
					    	alrimVO.setAlrimApprovalId(approvalMemberId);
							
					    	alrimService.insertAlrim(alrimVO);
					    	
					    	dailyWorkVO.setState("A");																								//저장:S 결재대기:B 결재진행:A 결재반려:R 결재완료: F 삭제:D
						}else{
							dailyWorkVO.setDailyWorkId(dailyWorkId);
							dailyWorkVO.setState("F");																								//저장:S 결재대기:B 결재진행:A 결재반려:R 결재완료: F 삭제:D
						}
						
						dailyWorkService.updateDailyWorkState(dailyWorkVO);																//상태변경
					}
				//일지 하나 선택
				}else{
					String dailyWorkInfo[] = dailyWorkApprovalVO.getCheckDailyWorkId().split(";");
					
					String dailyWorkId = dailyWorkInfo[0];
					int seq = Integer.parseInt(dailyWorkInfo[1]);
					String workDay = dailyWorkInfo[2];
					
					dailyWorkApprovalVO.setDailyWorkId(dailyWorkId);
					dailyWorkApprovalVO.setSeq(seq);
					dailyWorkApprovalVO.setApprovalMemberId(user.getId());
					dailyWorkApprovalVO.setApprovalState("A");																					//결재:A 반려:R
					
					dailyWorkService.insertApproval(dailyWorkApprovalVO);
					
					dailyWorkApprovalVO.setSeq(seq+1);
					String approvalMemberId = dailyWorkService.getApprovalMemberId(dailyWorkApprovalVO); 				//결재자 정보 조회
					
					dailyWorkApprovalVO.setApprovalRequestId(user.getId());															//결재요청자
					dailyWorkService.updateApprovalRequestInfo(dailyWorkApprovalVO);												//결재요청일 정보 
					
					dailyWorkVO.setDailyWorkId(dailyWorkId);
					
					if(!StringUtil.isEmpty(approvalMemberId)){
						//알람등록
						AlrimVO alrimVO = new AlrimVO();
						alrimVO.setAlrimGubun("D");			
				    	alrimVO.setAlrimTitle(workDay+"일지 결재");				
				    	alrimVO.setAlrimLink("/dailywork/receiveApprovalList.do");			
				    	alrimVO.setAlrimMenuId(33210);			
				    	alrimVO.setAlrimWriterId(user.getId());			
				    	alrimVO.setAlrimApprovalId(approvalMemberId);
						
				    	alrimService.insertAlrim(alrimVO);
				    	
				    	dailyWorkVO.setState("A");																								//저장:S 결재대기:B 결재진행:A 결재반려:R 결재완료: F 삭제:D
					}else{
						dailyWorkVO.setDailyWorkId(dailyWorkId);
						dailyWorkVO.setState("F");																								//저장:S 결재대기:B 결재진행:A 결재반려:R 결재완료: F 삭제:D
					}
					
					dailyWorkService.updateDailyWorkState(dailyWorkVO);																//상태변경
					
				}
				
				model.addAttribute("searchVO", searchVO);
				
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('결재가 정상적으로 등록되었습니다.');document.location.href='/dailywork/receiveApprovalList.do?pageIndex="+searchVO.getPageIndex()+"'</script>");
				
		}catch(Exception e){
			e.printStackTrace();
		}		
		return null;
	}
	
	/**
	 * 결재 반려
	 * 2014.10.08
	 */
	@RequestMapping("/dailywork/approvalReturnProc.do")
	public ModelAndView insertApprovalReturn (
			HttpServletResponse res
			, @ModelAttribute("searchVO") DailyWorkSearchVO searchVO
			, @ModelAttribute("dailyWorkApprovalVO") DailyWorkApprovalVO dailyWorkApprovalVO
			, @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO
			, ModelMap model
			, Map<String, Object> commandMap
			) throws Exception {
		try{
			
				LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
				
				//일지 여러개 선택
				if(dailyWorkApprovalVO.getCheckDailyWorkId().indexOf(",") > -1){
					String checkNoArray[] = dailyWorkApprovalVO.getCheckDailyWorkId().split(",");
					
					for(int i=0; i<checkNoArray.length; i++){
						String dailyWorkInfo[] = checkNoArray[i].split(";");
						String dailyWorkId = dailyWorkInfo[0];
						int approvalSeq = Integer.parseInt(dailyWorkInfo[1]);
						String workDay = dailyWorkInfo[2];
						
						dailyWorkApprovalVO.setDailyWorkId(dailyWorkId);
						dailyWorkApprovalVO.setSeq(approvalSeq);
						dailyWorkApprovalVO.setApprovalMemberId(user.getId());
						dailyWorkApprovalVO.setApprovalState("");																				//결재:A 반려:R
						
						dailyWorkService.insertApproval(dailyWorkApprovalVO);
						
						int nextSeq = 0;
						
						nextSeq = approvalSeq == 1 ? approvalSeq : approvalSeq-1;
						
						dailyWorkApprovalVO.setSeq(nextSeq);
						
						if(approvalSeq > 1){
							dailyWorkApprovalVO.setApprovalState("B");	
							dailyWorkService.updateApprovalState(dailyWorkApprovalVO);
						}
						String approvalMemberId = "";
						if(approvalSeq == 1){
							approvalMemberId = dailyWorkService.getDailyWorkApprovalId(dailyWorkId);
						}else{
							approvalMemberId = dailyWorkService.getApprovalMemberId(dailyWorkApprovalVO); 					//결재자 정보 조회
						}
						
						dailyWorkVO.setDailyWorkId(dailyWorkId);
						
						if(!StringUtil.isEmpty(approvalMemberId)){
							//알람등록
							AlrimVO alrimVO = new AlrimVO();
							alrimVO.setAlrimGubun("D");			
					    	alrimVO.setAlrimTitle(workDay+"일지 반려");		
					    	alrimVO.setAlrimLink("/dailywork/receiveApprovalList.do");			
					    	alrimVO.setAlrimMenuId(33210);			
					    	alrimVO.setAlrimWriterId(user.getId());			
					    	alrimVO.setAlrimApprovalId(approvalMemberId);
							
					    	alrimService.insertAlrim(alrimVO);
					    	
					    	if(approvalSeq == 1){
								dailyWorkVO.setState("R");																								//저장:S 결재대기:B 결재진행:A 결재반려:R 결재완료: F 삭제:D
							}else{
								dailyWorkVO.setState("A");																								//저장:S 결재대기:B 결재진행:A 결재반려:R 결재완료: F 삭제:D
							}
						}else{
							dailyWorkVO.setDailyWorkId(dailyWorkId);
							dailyWorkVO.setState("F");																									//저장:S 결재대기:B 결재진행:A 결재반려:R 결재완료: F 삭제:D
						}
						
						dailyWorkService.updateDailyWorkState(dailyWorkVO);																	//상태변경
					}
				//일지 하나 선택
				}else{
					String dailyWorkInfo[] = dailyWorkApprovalVO.getCheckDailyWorkId().split(";");
					
					String dailyWorkId = dailyWorkInfo[0];
					int approvalSeq = Integer.parseInt(dailyWorkInfo[1]);
					String workDay = dailyWorkInfo[2];
					
					dailyWorkApprovalVO.setDailyWorkId(dailyWorkId);
					dailyWorkApprovalVO.setSeq(approvalSeq);
					dailyWorkApprovalVO.setApprovalMemberId(user.getId());
					dailyWorkApprovalVO.setApprovalState("");																					//결재:A 반려:R
					
					dailyWorkApprovalVO.setApprovalMemberId(user.getId());
					
					dailyWorkService.insertApproval(dailyWorkApprovalVO);
					
					int nextSeq = 0;
					
					nextSeq = approvalSeq == 1 ? approvalSeq : approvalSeq-1;
					
					dailyWorkApprovalVO.setSeq(nextSeq);
					
					if(approvalSeq > 1){
						dailyWorkApprovalVO.setApprovalState("B");	
						dailyWorkService.updateApprovalState(dailyWorkApprovalVO);
					}
					String approvalMemberId = "";
					if(approvalSeq == 1){
						approvalMemberId = dailyWorkService.getDailyWorkApprovalId(dailyWorkId);
					}else{
						approvalMemberId = dailyWorkService.getApprovalMemberId(dailyWorkApprovalVO); 						//결재자 정보 조회
					}
					
					dailyWorkVO.setDailyWorkId(dailyWorkId);
					
					if(!StringUtil.isEmpty(approvalMemberId)){
						//알람등록
						AlrimVO alrimVO = new AlrimVO();
						alrimVO.setAlrimGubun("D");			
				    	alrimVO.setAlrimTitle(workDay+"일지 반려");	
				    	alrimVO.setAlrimLink("/dailywork/receiveApprovalList.do");			
				    	alrimVO.setAlrimMenuId(33210);			
				    	alrimVO.setAlrimWriterId(user.getId());			
				    	alrimVO.setAlrimApprovalId(approvalMemberId);
						
				    	alrimService.insertAlrim(alrimVO);
				    	
						if(approvalSeq == 1){
							dailyWorkVO.setState("R");																								//저장:S 결재대기:B 결재진행:A 결재반려:R 결재완료: F 삭제:D
						}else{
							dailyWorkVO.setState("A");																								//저장:S 결재대기:B 결재진행:A 결재반려:R 결재완료: F 삭제:D
						}
					}else{
						dailyWorkVO.setDailyWorkId(dailyWorkId);
						dailyWorkVO.setState("F");																									//저장:S 결재대기:B 결재진행:A 결재반려:R 결재완료: F 삭제:D
					}
					
					dailyWorkService.updateDailyWorkState(dailyWorkVO);																	//상태변경
					
				}
				
				model.addAttribute("searchVO", searchVO);
				
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('반려가 정상적으로 등록되었습니다.');document.location.href='/dailywork/receiveApprovalList.do?pageIndex="+searchVO.getPageIndex()+"'</script>");
				
		}catch(Exception e){
			e.printStackTrace();
		}		
		return null;
	}
	
	/**
	 * 작성권한 사용자 정보 가져오기
	 */
	@RequestMapping("/dailywork/getDailyWorkAuthUserList.do")
	public ModelAndView getDailyWorkAuthUserList(
			 @RequestParam(value="dailyWorkId", required=false) String dailyWorkId
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		List authUserList = dailyWorkService.getAuthUserList(dailyWorkId);
		
        modelAndView.addObject("authUserList", authUserList);
        modelAndView.setViewName("jsonView");

        return modelAndView;
	}
	
	/**
	 * 결재 승인에 대한 정보 가져오기
	 */
	@RequestMapping("/dailywork/getDailyWorkAppovalInfo.do")
	public ModelAndView getDailyWorkAppovalInfo(
			 @RequestParam(value="dailyWorkId", required=false) String dailyWorkId
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		List appovalInfoList = dailyWorkService.getAppovalInfo(dailyWorkId);
		
        modelAndView.addObject("appovalInfoList", appovalInfoList);
        modelAndView.setViewName("jsonView");
		
        return modelAndView;
	}
	
	/**
	 * 수정이력 정보 가져오기
	 */
	@RequestMapping("/dailywork/getDailyWorkHisInfoList.do")
	public ModelAndView getDailyWorkHisInfoList(
			 @RequestParam(value="dailyWorkId", required=false) String dailyWorkId
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		List hisInfoList = dailyWorkService.getDailyWorkHisInfoList(dailyWorkId);
		
        modelAndView.addObject("hisInfoList", hisInfoList);
        modelAndView.setViewName("jsonView");

        return modelAndView;
	}
	
	/**
	 * 근무일지 결재상신
	 * 2014.10.15
	 */
	@RequestMapping("/dailywork/insertDailyWorkApproval.do")
	public ModelAndView insertDailyWorkApproval(
			  HttpServletRequest req
			, HttpServletResponse res
			, @RequestParam(value="gubun", 				required=false) String gubun
			, @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO																//업무일지 기본정보
			, @ModelAttribute("dailyWorkApprovalVO") DailyWorkApprovalVO dailyWorkApprovalVO							//결재
			)throws Exception{
		
		try{
			
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			String userId = user.getId();
			
			String gubunName = "";
			String url = "";
			if(gubun.equals("S")){
				gubunName = "상황실근무일지";
				url = "<script>alert('상황실근무일지 결재가 정상적으로 등록되었습니다.');document.location.href='/dailywork/dailyWorkList.do?gubun=S'</script>";
			}else if(gubun.equals("R")){
				gubunName = "4대강주요수계일지";
				url = "<script>alert('4대강주요수계일지 결재가 정상적으로 등록되었습니다.');document.location.href='/dailywork/dailyWorkList.do?gubun=R'</script>";
			}else if(gubun.equals("M")){
				gubunName = "조류모니터링";
				url = "<script>alert('조류모니터링 결재가 정상적으로 등록되었습니다.');document.location.href='/dailywork/dailyWorkList.do?gubun=M'</script>";
			}else if(gubun.equals("A")){
				gubunName = "점검및사용일지";
				url = "<script>alert('선박및계류장 점검일지 결재가 정상적으로 등록되었습니다.');document.location.href='/dailywork/checkUseList.do?gubun=A'</script>";
			}else if(gubun.equals("B")){
				gubunName = "점검및사용일지";
				url = "<script>alert('유회수기 점검일지 결재가 정상적으로 등록되었습니다.');document.location.href='/dailywork/checkUseList.do?gubun=B'</script>";
			}else if(gubun.equals("C")){
				gubunName = "점검및사용일지";
				url = "<script>alert('방제창고 점검일지 결재가 정상적으로 등록되었습니다.');document.location.href='/dailywork/checkUseList.do?gubun=C'</script>";
			}else if(gubun.equals("D")){
				gubunName = "점검및사용일지";
				url = "<script>alert('차량류 점검일지 결재가 정상적으로 등록되었습니다.');document.location.href='/dailywork/checkUseList.do?gubun=D'</script>";
			}else if(gubun.equals("E")){
				gubunName = "점검및사용일지";
				url = "<script>alert('보조방제장비 점검일지 결재가 정상적으로 등록되었습니다.');document.location.href='/dailywork/checkUseList.do?gubun=E'</script>";
			}else if(gubun.equals("F")){
				gubunName = "점검및사용일지";
				url = "<script>alert('보조방제장비 점검일지 결재가 정상적으로 등록되었습니다.');document.location.href='/dailywork/checkUseList.do?gubun=F'</script>";
			}else{
				gubunName = "업무일지";
				url = "<script>alert('업무일지 결재가 정상적으로 등록되었습니다.');document.location.href='/dailywork/dailyWorkList.do?gubun=S'</script>";
			}
			dailyWorkVO.setApprovalId(userId);
			dailyWorkVO.setState("B"); 																										//저장:S 결재대기:B 결재진행:A 결재반려:R 결재완료: F 삭제:D
			int stateResult = dailyWorkService.updateDailyWorkStateInfo(dailyWorkVO);
			
			if(stateResult>0){
				dailyWorkApprovalVO.setSeq(1);
				String approvalMemberId = dailyWorkService.getApprovalMemberId(dailyWorkApprovalVO); 				//결재자 정보 조회
				
				dailyWorkApprovalVO.setApprovalRequestId(userId);																	//결재요청자
				dailyWorkService.updateApprovalRequestInfo(dailyWorkApprovalVO);												//결재요청일 정보 
				
				// 2016-11-22 KANG JI NAM 작성자와 결재자1이 동일인인 경우
				if(userId.equals(approvalMemberId)){ 
					try{
						// 본인에 대한 알람등록 제외
						// 결재자1에 대한 결재 승인 프로세스 진행
						// return new ModelAndView("redirect:/dailywork/approvalProc.do");
						String dailyWorkId = dailyWorkVO.getDailyWorkId();
						int seq = 1;
						
						dailyWorkApprovalVO.setDailyWorkId(dailyWorkId);
						dailyWorkApprovalVO.setSeq(seq);
						dailyWorkApprovalVO.setApprovalMemberId(user.getId());
						dailyWorkApprovalVO.setApprovalState("A");																					//결재:A 반려:R
						
						dailyWorkService.insertApproval(dailyWorkApprovalVO);
						
						dailyWorkApprovalVO.setSeq(seq+1);
						String approvalMemberId2 = dailyWorkService.getApprovalMemberId(dailyWorkApprovalVO); 				//결재자 정보 조회
						
						dailyWorkApprovalVO.setApprovalRequestId(user.getId());															//결재요청자
						dailyWorkService.updateApprovalRequestInfo(dailyWorkApprovalVO);												//결재요청일 정보 
						
						dailyWorkVO.setDailyWorkId(dailyWorkId);
						
						if(!StringUtil.isEmpty(approvalMemberId2)){
							//알람등록
							AlrimVO alrimVO = new AlrimVO();
							alrimVO.setAlrimGubun("D");			
					    	alrimVO.setAlrimTitle(dailyWorkVO.getWorkDay()+"일지 결재");				
					    	alrimVO.setAlrimLink("/dailywork/receiveApprovalList.do");			
					    	alrimVO.setAlrimMenuId(33210);			
					    	alrimVO.setAlrimWriterId(user.getId());			
					    	alrimVO.setAlrimApprovalId(approvalMemberId2);
							
					    	alrimService.insertAlrim(alrimVO);
					    	
					    	dailyWorkVO.setState("A");																								//저장:S 결재대기:B 결재진행:A 결재반려:R 결재완료: F 삭제:D
						}else{
							dailyWorkVO.setDailyWorkId(dailyWorkId);
							dailyWorkVO.setState("F");																								//저장:S 결재대기:B 결재진행:A 결재반려:R 결재완료: F 삭제:D
						}
						
						dailyWorkService.updateDailyWorkState(dailyWorkVO);
					} catch(Exception e) {
						e.printStackTrace();
					}	
				}else{
					//알람등록
			    	AlrimVO alrimVO = new AlrimVO();
			    	alrimVO.setAlrimGubun("D");			
			    	alrimVO.setAlrimTitle(dailyWorkVO.getWorkDay()+gubunName+" 결재");			
			    	alrimVO.setAlrimLink("/dailywork/receiveApprovalList.do");			
			    	alrimVO.setAlrimMenuId(33200);			
			    	alrimVO.setAlrimWriterId(userId);			
			    	alrimVO.setAlrimApprovalId(approvalMemberId);
					
			    	alrimService.insertAlrim(alrimVO);
				}
				
			}
			
			// 결재자에게 SMS 전송
			int cnt = 0;
			
			cnt = SendSMS.sendDailyWorkApprovalSms(dailyWorkApprovalVO);
			
			res.setContentType("text/html; charset=UTF-8");
			
			res.getWriter().print(url);
			
		}catch(Exception e){
			e.printStackTrace();
		}		
		return null;
	}
	
	/**
	 * 업무일지 목록 데이터
	 * 2014.09.18
	 * yrkim
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dailywork/workJournalList.do")
	public String workJournalList(
			@ModelAttribute("searchVO") DailyWorkSearchVO searchVO, 
			Map<String, Object> commandMap,
			ModelMap model) throws Exception {
		
		String returnValue = "/dailywork/workJournalList";
		
		if(StringUtil.isEmpty(searchVO.getStartDate())){
			searchVO.setStartDate(searchDate("addMonth"));
			searchVO.setEndDate(searchDate("today"));
		}
			
		searchVO.setPageUnit(10);		
		
		searchVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
	
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		searchVO.setUserId(user.getId());
		searchVO.setRoleCode(user.getRoleCode());
		
		Map<String, Object> map = dailyWorkService.workJournalList(searchVO);
		
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		List<DailyWorkSearchVO> resultList = (List<DailyWorkSearchVO>)map.get("resultList");
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", totCnt);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("menu", commandMap.get("menu"));
		model.addAttribute("no", commandMap.get("no"));
		
		return returnValue;
	}
	
	/**
	 * 업무일지 등록화면
	 * 2018.01.03
	 * choi hoe seop
	 */
	@RequestMapping("/dailywork/workJournalRegist.do")
	public String workJournalRegist(
			@ModelAttribute("searchVO") DailyWorkSearchVO searchVO
			, Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		System.out.println("seqno >>>>>>>> " + searchVO.getSeqNo());
		List<DailyWorkSearchVO> resultList = null;
		
		if(searchVO.getSeqNo() != null && !"".equals(searchVO.getSeqNo())) {
		
			PaginationInfo paginationInfo = new PaginationInfo();
			
			paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
			paginationInfo.setPageSize(searchVO.getPageSize());
		
			searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
			searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			searchVO.setUserId(user.getId());
			searchVO.setRoleCode(user.getRoleCode());
			
			Map<String, Object> map = dailyWorkService.workJournalList(searchVO);
			
			resultList = (List<DailyWorkSearchVO>)map.get("resultList");
			
			model.addAttribute("resultList", resultList);
			model.addAttribute("searchVO", searchVO);
		}
		return "dailywork/workJournalRegist";
	}
	
	/**
	 * 업무일지 스캔 파일 등록
	 * @param multiRequest
	 * @param response
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/dailywork/uploadworkJournalData.do")
	public ModelAndView uploadworkJournalData(
			@ModelAttribute("dailyWork") DailyWorkVO dailyWork,
			final MultipartHttpServletRequest multiRequest,
			HttpServletResponse response
	) throws Exception {
	
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		String tmpFileName = "";
		FileInputStream fis;
		Boolean result = true;
		String errorMsg = "no error";
		
		String time = "";
		int resultCnt = 0;
		
		try
		{
			if (isAuthenticated) {
				final Map<String, MultipartFile> files = multiRequest.getFileMap();
				String atchFileId = "";
				
				if(files !=null){
					if (!files.isEmpty()) {
						List<FileVO> upFileInfo = fileUtil.parseWpStepFileInf(files, "WKJN_", 0, "", "");
						atchFileId = fileMngService.insertFileInfs(upFileInfo);
						
						dailyWork.setAtchFileId(atchFileId);
						
						FileVO vo = (FileVO)upFileInfo.get(0);
						dailyWork.setTitle(vo.getOrignlFileNm());
						
						if(dailyWork.getSeqNo()==null || "".equals(dailyWork.getSeqNo())) {
							dailyWork.setRegId(user.getId());
							
							resultCnt = dailyWorkService.insertWorkJournalInfo(dailyWork);
							
						} else {
							dailyWork.setModId(user.getId());
							
							resultCnt = dailyWorkService.updateWorkJournalInfo(dailyWork);
						}
					}
				}
			} else {
				result = false;
				errorMsg = "Access denied";
			}
		}
		catch(Exception ex)
		{
			result = false;
			
			if(ex != null)
			{
				errorMsg = ex.getMessage();
			
				if(errorMsg == null)
					errorMsg = "";
				else if(errorMsg.contains("ORA-00001:"))
					errorMsg = "측정시간이 동일한 데이터가 이미 입력되어 있습니다.";
				else if(errorMsg.contains("waterinfoDAO.insertValidData-InlineParameterMap"))
					errorMsg = "데이터 형식이 잘못되어있습니다.";
			}
			else
			{
				errorMsg = "데이터 업로드를 실패하였습니다.";
			}
		}

		//return "forward:/bbs/selectBoardList.do";
		if(resultCnt  > 0) {
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().print("<script>alert('저장되었습니다.');</script>");
		} else{ 
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().print("<script>alert('Error');</script>"); 
		} 
		
		response.getWriter().print("<script>location.href='/dailywork/workJournalList.do';</script>"); 
		
		return null;
	}
	
	/**
	 * 지역본부 업무일지 삭제
	 * @param commandMap
	 * @param res
	 * @param dailyWorkId
	 * @param gubun
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/dailywork/deleteWorkJournalData.do")	
	public ModelAndView deleteWorkJournalData(
			 Map<String, Object> commandMap
			 , @ModelAttribute("dailyWork") DailyWorkVO dailyWork
			 , HttpServletResponse res
			 )throws Exception {
		
		try{
			
			dailyWorkService.deleteWorkJournalInfo(dailyWork);
			
			String url = "";
			
			url = "<script>alert('업무일지가 정상적으로 삭제되었습니다.');document.location.href='/dailywork/workJournalList.do'</script>";
			
			res.setContentType("text/html; charset=UTF-8");
			res.getWriter().print(url);
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	   
	   /**
		 * 업무일지 목록 데이터
		 * 2014.09.18
		 * yrkim
		 * @param commandMap
		 * @return
		 * @throws Exception
		 */
		@RequestMapping("/dailywork/checkUseList.do")
		public String checkUseList(
				@RequestParam(value="gubun", required=false) String gubun,
				@ModelAttribute("searchVO") DailyWorkSearchVO searchVO, 
				Map<String, Object> commandMap,
				ModelMap model) throws Exception {
			
			String returnValue = "";
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			if (user == null) {
				throw new EgovBizException("인증된 사용자 정보가 존재하지 않습니다.");
			} else {
			String deptNo = user.getDeptNo();
			String roleCode = user.getRoleCode();
			
//			System.out.println("deptNo >>>>>>> " + deptNo);
//			System.out.println("rolecode >>>>>>>> " + roleCode);
			
			returnValue = "/dailywork/checkUseList";
			
			if(StringUtil.isEmpty(searchVO.getStartDate())){
				searchVO.setStartDate(searchDate("addMonth"));
				searchVO.setEndDate(searchDate("today"));
			}
				
			searchVO.setPageUnit(10);		
			
			searchVO.setPageSize(propertyService.getInt("pageSize"));
		
			PaginationInfo paginationInfo = new PaginationInfo();
			
			paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
			paginationInfo.setPageSize(searchVO.getPageSize());
		
			searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
			searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
			searchVO.setSearchGubun(gubun);	
			searchVO.setDeptNo(deptNo);
			searchVO.setRoleCode(roleCode);
			
			Map<String, Object> map = dailyWorkService.checkUseList(searchVO);
			
			int totCnt = Integer.parseInt((String)map.get("resultCnt"));
			
			paginationInfo.setTotalRecordCount(totCnt);
			
			List<DailyWorkSearchVO> resultList = (List<DailyWorkSearchVO>)map.get("resultList");
			
			int regCnt = Integer.parseInt((String)map.get("regCnt"));
			
			model.addAttribute("resultList", resultList);
			model.addAttribute("resultCnt", totCnt);
			model.addAttribute("regCnt", regCnt);
			model.addAttribute("searchVO", searchVO);
			model.addAttribute("paginationInfo", paginationInfo);
			model.addAttribute("gubun", gubun);
			model.addAttribute("menu", commandMap.get("menu"));
			model.addAttribute("no", commandMap.get("no"));
			}
			return returnValue;
		}
		
		/**
		 * 사용및점검일지 결재자, 작성권한 선택
		 */
		@RequestMapping("/dailywork/checkUseRegist.do")
		public String checkUseRegist(
				Map<String, Object> commandMap
				, ModelMap model
				) throws Exception {
			
			return "/dailywork/checkUseRegist";
		}
		
		/**
		 * 점검일지 상세등록
		 * @param commandMap
		 * @param memberAppId
		 * @param memberAuthId
		 * @param workDay
		 * @param model
		 * @return
		 * @throws Exception
		 */
		@RequestMapping("/dailywork/checkUseRegDetail.do")
		public ModelAndView checkUseRegDetail(
				 Map<String, Object> commandMap
				,@RequestParam(value="memberAppId", required=false) String memberAppId
				,@RequestParam(value="memberAuthId", required=false) String memberAuthId
				,@RequestParam(value="workDay", required=false) String workDay
				, ModelMap model
				) throws Exception {
			
			String[] memberId = memberAppId.split(",");
			
			String approvalName1 = dailyWorkService.approvalNameSelect(memberId[0]);		//결재자1
			String approvalName2 = "";
			if(memberId.length > 1) {
				approvalName2 = dailyWorkService.approvalNameSelect(memberId[1]);		//결재자2
			}
			
			ModelAndView modelAndView = new ModelAndView();
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			if (user == null) {
				throw new EgovBizException("인증된 사용자 정보가 존재하지 않습니다.");
			} else {
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("gubun", (String)commandMap.get("gubun"));
			paramMap.put("checkGubun", (String)commandMap.get("checkGubun"));
			paramMap.put("deptCode", user.getDeptNo());
			
			List equipList = dailyWorkService.getCheckEquipList(paramMap);
			
			//System.out.println("equipList >>>>>>>>>>>> " + equipList.size());
			
			
			modelAndView.addObject("memberAppId", memberAppId);
			modelAndView.addObject("memberAuthId", memberAuthId);
			modelAndView.addObject("approvalName1", approvalName1);
			modelAndView.addObject("approvalName2", approvalName2);
			modelAndView.addObject("workDay", workDay);
			modelAndView.addObject("equipList", equipList);
			
			modelAndView.setViewName("/dailywork/checkUseRegDetail"+commandMap.get("gubun"));
			}
			return modelAndView;
		}
		
		/**
		 * 상황실 근무일지 상세조회
		 */
		@RequestMapping("/dailywork/checkUseRoomDetail.do")
		public ModelAndView checkUseRoomDetail(
				  HttpServletResponse res
				, Map<String, Object> commandMap
				, @RequestParam(value="dailyWorkId", 		required=false) String dailyWorkId
				, @RequestParam(value="regId", 				required=false) String regId
				, @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO
				, @ModelAttribute("situationRoomVO") SituationRoomVO situationRoomVO
				, @ModelAttribute("dailyWorkRainVO") DailyWorkRainVO dailyWorkRainVO
				, @ModelAttribute("dailyWorkWriteAuthVO") DailyWorkWriteAuthVO dailyWorkWriteAuthVO
				, ModelAndView modelAndView
				) throws Exception {
				
				LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
				if (user == null) {
					throw new EgovBizException("인증된 사용자 정보가 존재하지 않습니다.");
				} else {
				String userId = user.getId();
				
				try {
				dailyWorkVO = dailyWorkService.selectDailyWorkMasterInfo(dailyWorkId);												//업무일지 기본정보
				List<DailyWorkApprovalVO> approvalList= dailyWorkService.selectDailyWorkApprovalList(dailyWorkId);				//업무일지 결재정보
				
				situationRoomVO = situationRoomService.selectSituationRoomInfo(dailyWorkId);										//상황실 근무일지 근무상황정보
				
				situationRoomVO.setDailyWorkId(dailyWorkId);
				
				situationRoomVO.setSpreadGubun("S");
				List<SituationRoomVO> spreadSList = situationRoomService.selectSituationSpreadInfo(situationRoomVO);	//업무일지 상황전파 현황
				
				situationRoomVO.setSpreadGubun("G");
				List<SituationRoomVO> spreadGList = situationRoomService.selectSituationSpreadInfo(situationRoomVO);	//업무일지 상황전파 현황
				
				List<DailyWorkRainVO> rainFallList = dailyWorkService.selectDailyWorkRainInfo(dailyWorkRainVO);				//업무일지 강우현황
				
				modelAndView.addObject("dailyWorkVO", dailyWorkVO);
				modelAndView.addObject("approvalList", approvalList);
				modelAndView.addObject("situationRoomVO", situationRoomVO);
				modelAndView.addObject("spreadSList", spreadSList);
				modelAndView.addObject("spreadGList", spreadGList);
				modelAndView.addObject("rainFallList", rainFallList);
				modelAndView.addObject("menuGubun", "dailyWork");
				
				modelAndView.setViewName("/dailywork/checkUseRoomDetail");
				
				} catch(Exception e) {
					e.printStackTrace();
				}
				
				if(!regId.equals(userId)){
					//System.out.println("regid <> userId");
					dailyWorkWriteAuthVO.setDailyWorkId(dailyWorkId);
					dailyWorkWriteAuthVO.setWriteAuthId(userId);
					
					int cnt = dailyWorkService.getDailyWorkWriteAuthId(dailyWorkWriteAuthVO);		
					//System.out.println("cnt >>>>>>>>>>> " + cnt);
					if(cnt == 0){
						res.setContentType("text/html; charset=UTF-8");
						res.getWriter().print("<script>alert('작성권한이 없습니다.');document.location.href='/dailywork/checkUseList.do?gubun=A'</script>");
						
						return null;
						
					}else{
						return modelAndView;
					}
				}else{
					return modelAndView;
				}
			}
		}
		
		/**
		 * 점검및사용일지 등록
		 * @param req
		 * @param res
		 * @param workDay
		 * @param memberAppIds
		 * @param memberAuthIds
		 * @param gubun
		 * @param checkUseVO
		 * @param dailyWorkApprovalVO
		 * @param dailyWorkWriteAuthVO
		 * @param checkUseDetailVO
		 * @return
		 * @throws Exception
		 */
		@RequestMapping("/dailywork/checkUseRegProc.do")
		public ModelAndView checkUseRegProc(
				final MultipartHttpServletRequest req
				, HttpServletResponse res
				, @RequestParam(value="workDay",		required=false) String   workDay
				, @RequestParam(value="memberAppId",	required=false) String   memberAppIds
				, @RequestParam(value="memberAuthId",	required=false) String   memberAuthIds
				, @RequestParam(value="gubun",			required=false) String   gubun
				, @ModelAttribute("checkUseVO") CheckUseVO checkUseVO									//사용및점검일지 기본정보
				, @ModelAttribute("dailyWorkApprovalVO") DailyWorkApprovalVO dailyWorkApprovalVO		//결재
				, @ModelAttribute("dailyWorkWriteAuthVO") DailyWorkWriteAuthVO dailyWorkWriteAuthVO		//작성권한
				, @ModelAttribute("checkUseDetailVO") CheckUseDetailVO checkUseDetailVO					//점검결과
				) throws Exception {
			
			try{
				checkUseVO.setGubun(gubun);
				checkUseVO.setWorkDay(workDay);
				
				int resultCnt = 0;
				
				//int resultCnt =  dailyWorkService.selectDailyWorkInfo(checkUseVO);
				
				if (resultCnt > 0 ) {
					res.setContentType("text/html; charset=UTF-8");
					res.getWriter().print("<script>alert('입력하신 일자에 해당하는 점검및사용일지가 존재합니다.');history.back();</script>");
				}else{
					LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
					if (user == null) {
						throw new EgovBizException("인증된 사용자 정보가 존재하지 않습니다.");
					} else {
					String userId = user.getId();
					checkUseVO.setRegId(userId);																		//작성자
					
					String checkUseId = idgenDailyWorkService.getNextStringId();								//업무일지ID
					
					int resultOk = 0; 
					
					/** 업무일지정보 저장 */
					checkUseVO.setCheckUseId(checkUseId);
					
					try{
						
						MultipartFile file1 = req.getFile("file1");
						MultipartFile file2 = req.getFile("file2");
						MultipartFile file3 = req.getFile("file3");
						
						String atchFileId = "";
						if(!file1.isEmpty()) {
							FileVO fileVO1 = fileUtil.uploadCheckUseFile(file1, "CHK_", 0, "");
							atchFileId = fileMngService.insertFileInf(fileVO1);
							checkUseVO.setPhoto1Id(atchFileId);
						}
						if(!file2.isEmpty()) {
							FileVO fileVO2 = fileUtil.uploadCheckUseFile(file2, "CHK_", 0, "");
							atchFileId = fileMngService.insertFileInf(fileVO2);
							checkUseVO.setPhoto2Id(atchFileId);
						}
						if(!file3.isEmpty()) {
							FileVO fileVO3 = fileUtil.uploadCheckUseFile(file3, "CHK_", 0, "");
							atchFileId = fileMngService.insertFileInf(fileVO3);
							checkUseVO.setPhoto3Id(atchFileId);
						}
						
						dailyWorkService.insertCheckUseInfo(checkUseVO);
						resultOk++;
						
					}catch(Exception e){
						e.printStackTrace();
						resultOk = 0;
					}
					
					if(resultOk  > 0) {
						/** 결재 정보 저장 */
						String[] memberAppId = memberAppIds.split(",");												//결재자
						
						dailyWorkApprovalVO.setDailyWorkId(checkUseId);
						
						int seq = 0;
						
						for(int i=0; i<memberAppId.length; i++){
							seq = dailyWorkService.getDailyWorkApprovalSeq(checkUseId);						//seq 
							
							dailyWorkApprovalVO.setSeq(seq);
							dailyWorkApprovalVO.setApprovalMemberId(memberAppId[i]);
							dailyWorkService.insertDailyWorkApprovalInfo(dailyWorkApprovalVO);		
						}
									
						/** 작성권한 정보 */
						String[] memberAuthId = memberAuthIds.split(",");												//작성권한
						dailyWorkWriteAuthVO.setDailyWorkId(checkUseId);
						
						for(int i=0; i<memberAuthId.length; i++){
							seq = dailyWorkService.getDailyWorkWriteAuthSeq(checkUseId);						//seq 
							
							dailyWorkWriteAuthVO.setSeq(seq);
							dailyWorkWriteAuthVO.setWriteAuthId(memberAuthId[i]);
							dailyWorkService.insertDailyWriteAuthInfo(dailyWorkWriteAuthVO);			
						}
						
						checkUseDetailVO.setCheckUseId(checkUseId);
						
						
						/*List<MultipartFile> files = req.getFiles("fileArr");
						List<FileVO> result = null;
						String atchFileId = "";
						if(!files.isEmpty()) {
							result = fileUtil.parseChkUseFileInf(files, "CHK_", 0, "", "");
							atchFileId = fileMngService.insertFileInfs(result);
						}*/
						/*List<MultipartFile> mf = req.getFiles("fileArr");
						
						System.out.println("upload files >>>>>>>>> " + mf.size());

			            for (int i = 0; i < mf.size(); i++) {
			 
			                long fileSize = mf.get(i).getSize(); // 파일 사이즈
			                
			                System.out.println("file size >>> " + i + " : " + fileSize);
			                
			                List<FileVO> result = null;
							String atchFileId = "";
							final Map<String, MultipartFile> files = req.getFileMap();
							if (!files.isEmpty()) {
								result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
								atchFileId = fileMngService.insertFileInfs(result);
							}
//							board.setAtchFileId(atchFileId);
//							board.setFrstRegisterId(user.getUniqId());
//							board.setBbsId(board.getBbsId());
			 
			            }*/
						
						//System.out.println("upload files >>>>>>>>> " + req.getFiles("fileArr").size());
						
						/*System.out.println("equip code >>>>>>>>> " + checkUseVO.getEquipCode());
						System.out.println("equip code length >>>>>>>>> " + checkUseVO.getEquipCode().split(",").length);
						
						System.out.println("gubun code >>>>>>>>> " + checkUseDetailVO.getGubunCode());
						System.out.println("gubun code length >>>>>>>>> " + checkUseDetailVO.getGubunCode().split(",").length);
						
						System.out.println("note >>>>>>>>> " + checkUseDetailVO.getNote());
						System.out.println("note length >>>>>>>>> " + checkUseDetailVO.getNote().split(",").length);*/
						
						//System.out.println("file size >>>>>>>> " + result.size());
						
						String[] arrGubunCode = checkUseDetailVO.getGubunCode().split(",");
						String[] arrCheckCode = checkUseDetailVO.getCheckCode().split(",");
						String[] arrCheckResult = checkUseDetailVO.getCheckResult().split(",");
						String[] arrNote = checkUseDetailVO.getNote().split(",", arrGubunCode.length);
						for(int i=0;i<arrGubunCode.length;i++) {
							checkUseDetailVO.setGubunCode(arrGubunCode[i]);
							checkUseDetailVO.setCheckCode(arrCheckCode[i]);
							checkUseDetailVO.setCheckResult(arrCheckResult[i]);
							checkUseDetailVO.setNote(arrNote[i]);
							
							dailyWorkService.insertCheckUseDetailInfo(checkUseDetailVO);
						}
						
						res.setContentType("text/html; charset=UTF-8");
						res.getWriter().print("<script>alert('점검및사용일지가 정상적으로 등록되었습니다.');document.location.href='/dailywork/checkUseList.do?gubun=" + gubun + "'</script>");
					} else{ 
						res.setContentType("text/html; charset=UTF-8");
						res.getWriter().print("<script>alert('ERROR');document.location.href='/dailywork/checkUseList.do?gubun=" + gubun + "'</script>");
					}
				}
				}
			}catch(Exception e){
				e.printStackTrace();
			}		
			return null;
		}
		
		/**
		 * 점검일지 상세
		 * @param commandMap
		 * @return
		 * @throws Exception
		 */
		@RequestMapping("/dailywork/checkUseDetail.do")
		public ModelAndView checkUseDetail(
				HttpServletResponse res
				, @RequestParam(value="dailyWorkId", 		required=false) String dailyWorkId
			    , @RequestParam(value="regId", 				required=false) String regId
				, @RequestParam(value="gubun", 				required=false) String gubun
				, @RequestParam(value="pageNo", 			required=false) String pageNo
				, @ModelAttribute("checkUseVO") CheckUseVO checkUseVO
				, @ModelAttribute("checkUseDetailVO") CheckUseDetailVO checkUseDetailVO
				, @ModelAttribute("dailyWorkWriteAuthVO") DailyWorkWriteAuthVO dailyWorkWriteAuthVO
				, ModelAndView modelAndView
				) throws Exception {
			
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			if (user == null) {
				throw new EgovBizException("인증된 사용자 정보가 존재하지 않습니다.");
			} else {
				String userId = user.getId();
				String deptNo = user.getDeptNo();
				
				checkUseVO = dailyWorkService.selectCheckUseMasterInfo(dailyWorkId);					//업무일지 기본정보
				String equipCode1 = checkUseVO.getEquipCode1();
				String equipCode2 = checkUseVO.getEquipCode2();
				String[] arrEquipCode1 = null;
				String[] arrEquipCode2 = null;
				HashMap<String, Object> param = new HashMap<String, Object>();
				if(!"".equals(equipCode1) && equipCode1!=null) {
					arrEquipCode1 = equipCode1.split(",");
					
					param.put("arrEquipCode", arrEquipCode1);
					equipCode1 = dailyWorkService.selectCheckUseEquipName(param);
					checkUseVO.setEquipCode1(equipCode1);
				}
				if(!"".equals(equipCode2) && equipCode2!=null) {
					arrEquipCode2 = equipCode2.split(",");
					
					param.put("arrEquipCode", arrEquipCode2);
					equipCode2 = dailyWorkService.selectCheckUseEquipName(param);
					checkUseVO.setEquipCode2(equipCode2);
				}
				
				List<DailyWorkApprovalVO> approvalList= dailyWorkService.selectCheckUseApprovalList(dailyWorkId);				//업무일지 결재정보
				
				List<CheckUseDetailVO> checkList = dailyWorkService.selectCheckUseDetailList(dailyWorkId);
				
				modelAndView.setViewName("dailywork/checkUseDetail"+gubun);
					
				modelAndView.addObject("gubun", gubun);
				modelAndView.addObject("menuGubun", "dailyWork");
				modelAndView.addObject("checkUseVO", checkUseVO);
				modelAndView.addObject("approvalList", approvalList);
				modelAndView.addObject("checkList", checkList);
				if(pageNo==null || "".equals(pageNo)) pageNo = "1";
				modelAndView.addObject("pageNo", pageNo);
			
			
				if(!regId.equals(userId) && !"1001".equals(deptNo)){
					dailyWorkWriteAuthVO.setDailyWorkId(dailyWorkId);
					dailyWorkWriteAuthVO.setWriteAuthId(userId);
					
					int cnt = dailyWorkService.getDailyWorkWriteAuthId(dailyWorkWriteAuthVO);		
					if(cnt == 0){
						res.setContentType("text/html; charset=UTF-8");
						res.getWriter().print("<script>alert('작성권한이 없습니다.');document.location.href='/dailywork/checkUseList.do?gubun="+gubun+"'</script>");
						return null;
						
					}else{
						return modelAndView;
					}
				}else{
					return modelAndView;
				}
			}
		}
		
		/**
		 * 점검일지 삭제
		 */
		@RequestMapping("/dailywork/checkUseInfoDelete.do")	
		public ModelAndView checkUseInfoDelete(
				 Map<String, Object> commandMap
				 , HttpServletResponse res
				 , @RequestParam(value="checkUseId", required=false) String checkUseId
				 , @RequestParam(value="gubun", required=false) String gubun
				 )throws Exception {
			
			try{
				
				dailyWorkService.checkUseInfoDelete(checkUseId);
				
				String url = "";
				
				url = "<script>alert('점검 및 사용일지가 정상적으로 삭제되었습니다.');document.location.href='/dailywork/checkUseList.do?gubun=" + gubun + "'</script>";
				
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print(url);
				
			}catch(Exception e){
				e.printStackTrace();
			}
			return null;
		}
		
		/**
		 * 점검일지 결재정보 회수
		 */
		@RequestMapping("/dailywork/checkUseInfoCancel.do")	
		public ModelAndView checkUseInfoCancel(
				 Map<String, Object> commandMap
				 , HttpServletResponse res
				 , @RequestParam(value="dailyWorkId", required=false) String dailyWorkId
				 , @RequestParam(value="gubun", required=false) String gubun
				 , @RequestParam(value="approvalId", required=false) String approvalId
				 )throws Exception {
			
			try{
				//T_DAILY_WORK : STATE, APPROVAL_ID, APPROVAL_DATE 변경
				dailyWorkService.updateCheckUseCancel(dailyWorkId);
				
				String url = "";
				
				url = "<script>alert('점검일지가 정상적으로 회수되었습니다.');document.location.href='/dailywork/checkUseList.do?gubun=" + gubun + "'</script>";
				
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print(url);
				
			}catch(Exception e){
				e.printStackTrace();
			}
			return null;
		}
		
		/**
		 * 점검및사용일지 수정화면
		 */
		@RequestMapping("/dailywork/checkUseModify.do")	
		public String situationRoomModify(
				Map<String, Object> commandMap
				, @RequestParam(value="dailyWorkId", required=false) String dailyWorkId
				, @RequestParam(value="gubun", 				required=false) String gubun
				, @ModelAttribute("checkUseVO") CheckUseVO checkUseVO
				, @ModelAttribute("checkUseDetailVO") CheckUseDetailVO checkUseDetailVO
				, @RequestParam(value="modifyGubun", 		required=false) String modifyGubun
				, ModelMap model
				) throws Exception {
			
			checkUseVO = dailyWorkService.selectCheckUseMasterInfo(dailyWorkId);													//업무일지 기본정보
			List<DailyWorkApprovalVO> approvalList= dailyWorkService.selectDailyWorkApprovalList(dailyWorkId);				//업무일지 결재정보

			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("gubun", gubun);
			paramMap.put("checkUseId", dailyWorkId);
			paramMap.put("deptCode", user.getDeptNo());
			List equipList = dailyWorkService.getCheckEquipList(paramMap);

			List checkList = dailyWorkService.getCheckEquipModifyList(paramMap);
			
			model.addAttribute("gubun", gubun);
			model.addAttribute("checkUseVO", checkUseVO);
			model.addAttribute("approvalList", approvalList);
			model.addAttribute("modifyGubun", modifyGubun);
			model.addAttribute("equipList", equipList);
			model.addAttribute("checkList", checkList);
			
			return "/dailywork/checkUseModify"+gubun;
		
		}
		
		/**
		 * 상황실 근무일지 수정
		 * 2014.09.24
		 */
		@RequestMapping("/dailywork/checkUseModProc.do")
		public ModelAndView situationRoomModProc(
				final MultipartHttpServletRequest req
				, HttpServletResponse res
				, @RequestParam(value="approvalMember1", 				required=false) String approvalMember1
				, @RequestParam(value="approvalMember2", 				required=false) String approvalMember2
				, @RequestParam(value="memberAppId", 				required=false) String memberAppIds
				, @RequestParam(value="memberAuthId", 			required=false) String memberAuthIds
				, @RequestParam(value="modGubun", 					required=false) String modGubun
				, @RequestParam(value="modifyGubun",				required=false) String modifyGubun
				, @RequestParam(value="gubun",				required=false) String gubun
				, @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO
				, @ModelAttribute("checkUseVO") CheckUseVO checkUseVO															//업무일지 기본정보
				, @ModelAttribute("dailyWorkApprovalVO") DailyWorkApprovalVO dailyWorkApprovalVO						//결재
				, @ModelAttribute("dailyWorkWriteAuthVO") DailyWorkWriteAuthVO dailyWorkWriteAuthVO					//작성권한
				, @ModelAttribute("checkUseDetailVO") CheckUseDetailVO checkUseDetailVO										//상황전파현황
				, @ModelAttribute("dailyworkRainVO") DailyWorkRainVO dailyworkRainVO											//강우현황
				)throws Exception{
			
			try{
				
				LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
				String userId = user.getId();
				dailyWorkVO.setModId(userId);																		//수정자
				checkUseVO.setModId(userId);
				
				int resultOk = 0; 
				String msg = "";
				try{
					
					MultipartFile file1 = req.getFile("file1");
					MultipartFile file2 = req.getFile("file2");
					MultipartFile file3 = req.getFile("file3");
					
					String atchFileId = "";
					if(!file1.isEmpty()) {
						FileVO fileVO1 = fileUtil.uploadCheckUseFile(file1, "CHK_", 0, "");
						atchFileId = fileMngService.insertFileInf(fileVO1);
						
						if("Y".equals(checkUseVO.getPhoto1IdDelYn()) || (!"".equals(checkUseVO.getPhoto1Id()) && checkUseVO.getPhoto1Id() != null)) {
							String uploadFile = fileMngService.selectUploadFileName(checkUseVO.getPhoto1Id());
							fileUtil.deleteCheckUseFile(uploadFile);
							fileMngService.deleteAllFileInfs(checkUseVO.getPhoto1Id());
						}
					} else {
						atchFileId = "";
						if(!"".equals(checkUseVO.getPhoto1Id())) {
							atchFileId = checkUseVO.getPhoto1Id();
						}
						if("Y".equals(checkUseVO.getPhoto1IdDelYn())) {
							String uploadFile = fileMngService.selectUploadFileName(checkUseVO.getPhoto1Id());
							fileUtil.deleteCheckUseFile(uploadFile);
							fileMngService.deleteAllFileInfs(checkUseVO.getPhoto1Id());
						}
					}
					checkUseVO.setPhoto1Id(atchFileId);
					if(!file2.isEmpty()) {
						FileVO fileVO2 = fileUtil.uploadCheckUseFile(file2, "CHK_", 0, "");
						atchFileId = fileMngService.insertFileInf(fileVO2);
						
						if("Y".equals(checkUseVO.getPhoto2IdDelYn()) || (!"".equals(checkUseVO.getPhoto2Id()) && checkUseVO.getPhoto2Id() != null)) {
							String uploadFile = fileMngService.selectUploadFileName(checkUseVO.getPhoto2Id());
							fileUtil.deleteCheckUseFile(uploadFile);
							fileMngService.deleteAllFileInfs(checkUseVO.getPhoto2Id());
						}
					} else {
						atchFileId = "";
						if(!"".equals(checkUseVO.getPhoto2Id())) {
							atchFileId = checkUseVO.getPhoto2Id();
						}
						if("Y".equals(checkUseVO.getPhoto2IdDelYn())) {
							String uploadFile = fileMngService.selectUploadFileName(checkUseVO.getPhoto2Id());
							fileUtil.deleteCheckUseFile(uploadFile);
							fileMngService.deleteAllFileInfs(checkUseVO.getPhoto2Id());
						}
					}
					checkUseVO.setPhoto2Id(atchFileId);
					if(!file3.isEmpty()) {
						FileVO fileVO3 = fileUtil.uploadCheckUseFile(file3, "CHK_", 0, "");
						atchFileId = fileMngService.insertFileInf(fileVO3);
						
						if("Y".equals(checkUseVO.getPhoto3IdDelYn()) || (!"".equals(checkUseVO.getPhoto3Id()) && checkUseVO.getPhoto3Id() != null)) {
							String uploadFile = fileMngService.selectUploadFileName(checkUseVO.getPhoto3Id());
							fileUtil.deleteCheckUseFile(uploadFile);
							fileMngService.deleteAllFileInfs(checkUseVO.getPhoto3Id());
						}
					} else {
						atchFileId = "";
						if(!"".equals(checkUseVO.getPhoto3Id())) {
							atchFileId = checkUseVO.getPhoto3Id();
						}
						if("Y".equals(checkUseVO.getPhoto3IdDelYn())) {
							String uploadFile = fileMngService.selectUploadFileName(checkUseVO.getPhoto3Id());
							fileUtil.deleteCheckUseFile(uploadFile);
							fileMngService.deleteAllFileInfs(checkUseVO.getPhoto3Id());
						}
					}
					checkUseVO.setPhoto3Id(atchFileId);
					
					dailyWorkService.updateCheckUseInfo(checkUseVO);
					
					resultOk++;
					
				}catch(Exception e){
					resultOk = 0;
					e.printStackTrace();
				}
				
				if(resultOk  > 0) {
					//수정이력 저장
					dailyWorkService.insertDailyWorkHisInfo(dailyWorkVO);
					
					/** 결재 정보 저장 */
					dailyWorkApprovalVO.setDailyWorkId(checkUseVO.getCheckUseId());
					
					//변경 된 결재자가 있을경우에만 삭제 후 저장
					if(!StringUtil.isEmpty(memberAppIds)) {
						dailyWorkService.deleteDailyWorkApprovalInfo(dailyWorkApprovalVO);											//결재정보 삭제 후 저장
						
						String[] memberAppId = memberAppIds.split(",");		
						
						int seq = 0;
						for(int i=0; i<memberAppId.length; i++){
							if(i==0){
								
							}
							seq = dailyWorkService.getDailyWorkApprovalSeq(checkUseVO.getCheckUseId());						//seq 
							
							dailyWorkApprovalVO.setSeq(seq);
							dailyWorkApprovalVO.setApprovalMemberId(memberAppId[i]);
							dailyWorkService.insertDailyWorkApprovalInfo(dailyWorkApprovalVO);		
						}
					}
					
					/** 작성권한 정보 */
					dailyWorkWriteAuthVO.setDailyWorkId(checkUseVO.getCheckUseId());
					
					//변경 된 작성권한 있을경우에만 삭제 후 저장
					if(!StringUtil.isEmpty(memberAuthIds)) {
						dailyWorkService.deleteDailyWorkAuthInfo(dailyWorkWriteAuthVO);												//작성권한 정보 삭제 후 저장
						
						String[] memberAuthId = memberAuthIds.split(",");		
						
						int seq = 0;
						for(int i=0; i<memberAuthId.length; i++){
							if(i==0){
								
							}
							seq = dailyWorkService.getDailyWorkWriteAuthSeq(checkUseVO.getCheckUseId());						//seq 
							
							dailyWorkWriteAuthVO.setSeq(seq);
							dailyWorkWriteAuthVO.setWriteAuthId(memberAuthId[i]);
							dailyWorkService.insertDailyWriteAuthInfo(dailyWorkWriteAuthVO);			
						}
					}
					
					/** 상황실 근무일지 */
					checkUseDetailVO.setCheckUseId(checkUseVO.getCheckUseId());
					
					String[] arrGubunCode = checkUseDetailVO.getGubunCode().split(",");
					String[] arrCheckCode = checkUseDetailVO.getCheckCode().split(",");
					String[] arrCheckResult = checkUseDetailVO.getCheckResult().split(",");
					String[] arrDetailId = checkUseDetailVO.getDetailId().split(",", arrGubunCode.length);
					String[] arrNote = checkUseDetailVO.getNote().split(",", arrGubunCode.length);
					for(int i=0;i<arrGubunCode.length;i++) {
						checkUseDetailVO.setDetailId(arrDetailId[i]);;
						checkUseDetailVO.setGubunCode(arrGubunCode[i]);
						checkUseDetailVO.setCheckCode(arrCheckCode[i]);
						checkUseDetailVO.setCheckResult(arrCheckResult[i]);
						checkUseDetailVO.setNote(arrNote[i]);
						
						dailyWorkService.updateCheckUseDetailInfo(checkUseDetailVO);
					}
					
					//결재상신
					if(modGubun.equals("app")){
						dailyWorkVO.setApprovalId(userId);
						dailyWorkVO.setState("B"); 	 //저장:S 결재대기:B 결재진행:A 결재반려:R 결재완료: F 삭제:D
						if(userId.equals(approvalMember1) || userId.equals(approvalMember2)) {
							dailyWorkVO.setState("F"); //결재자와 상신자가 동일한 경우 자동 결재완료처리
						}
						int stateResult = dailyWorkService.updateDailyWorkStateInfo(dailyWorkVO);
						
						dailyWorkApprovalVO.setSeq(1);
						String approvalMemberId = dailyWorkService.getApprovalMemberId(dailyWorkApprovalVO); 					//결재자 정보 조회
						
						if(stateResult>0){
							
							if(userId.equals(approvalMember1) || userId.equals(approvalMember2)) {
								dailyWorkApprovalVO.setApprovalRequestId(userId);																	//결재요청자
								dailyWorkService.updateApprovalRequestInfo(dailyWorkApprovalVO);
								
								msg = "상신자와 결재자가 동일하여 자동으로 결재완료되었습니다.";
							} else {
								//알람등록
								AlrimVO alrimVO = new AlrimVO();
								alrimVO.setAlrimGubun("D");			
						    	alrimVO.setAlrimTitle(dailyWorkVO.getWorkDay()+" 점검및사용일지 결재");			
						    	alrimVO.setAlrimLink("/dailywork/receiveApprovalList.do");			
						    	alrimVO.setAlrimMenuId(33200);			
						    	alrimVO.setAlrimWriterId(userId);			
						    	alrimVO.setAlrimApprovalId(approvalMemberId);
								
						    	alrimService.insertAlrim(alrimVO);
						    	
						    	dailyWorkApprovalVO.setApprovalRequestId(userId);																	//결재요청자
								dailyWorkService.updateApprovalRequestInfo(dailyWorkApprovalVO);												//결재요청일 정보 
								
								msg = "결재가 정상적으로 등록되었습니다.";
							}
						}else{
							msg = "ERROR";
						}
					}else{
						msg = "점검및사용일지가 정상적으로 수정되었습니다.";
					}
					
					res.setContentType("text/html; charset=UTF-8");
					if(modifyGubun.equals("m")){
						res.getWriter().print("<script>alert('"+msg+"');document.location.href='/dailywork/checkUseList.do?gubun="+gubun+"'</script>");
					}else{
						res.getWriter().print("<script>alert('"+msg+"');document.location.href='/dailywork/receiveApprovalList.do'</script>");
					}
					
				} else{ 
					if(modifyGubun.equals("m")){
						res.getWriter().print("<script>alert('ERROR');document.location.href='/dailywork/checkUseList.do?gubun="+gubun+"'</script>");
					}else{
						res.getWriter().print("<script>alert('ERROR');document.location.href='/receiveApprovalList.do'</script>");
					}
				}

			}catch(Exception e){
				e.printStackTrace();
			}		
			return null;
		}
		
		/**
		 * 점검및사용일지 상세조회 팝업
		 */
		@RequestMapping("/dailywork/checkUsePrintView_popup.do")
		public ModelAndView checkUsePrintView_popup(
				@RequestParam(value="dailyWorkId", 		required=false) String dailyWorkId
				, @RequestParam(value="gubun", 				required=false) String gubun
				, @ModelAttribute("checkUseVO") CheckUseVO checkUseVO
				, @ModelAttribute("checkUseDetailVO") CheckUseDetailVO checkUseDetailVO
				, ModelAndView modelAndView
				) throws Exception {
			
			checkUseVO = dailyWorkService.selectCheckUseMasterInfo(dailyWorkId);					//업무일지 기본정보
			String equipCode1 = checkUseVO.getEquipCode1();
			String equipCode2 = checkUseVO.getEquipCode2();
			String[] arrEquipCode1 = null;
			String[] arrEquipCode2 = null;
			HashMap<String, Object> param = new HashMap<String, Object>();
			if(!"".equals(equipCode1) && equipCode1!=null) {
				arrEquipCode1 = equipCode1.split(",");
				
				param.put("arrEquipCode", arrEquipCode1);
				equipCode1 = dailyWorkService.selectCheckUseEquipName(param);
				checkUseVO.setEquipCode1(equipCode1);
			}
			if(!"".equals(equipCode2) && equipCode2!=null) {
				arrEquipCode2 = equipCode2.split(",");
				
				param.put("arrEquipCode", arrEquipCode2);
				equipCode2 = dailyWorkService.selectCheckUseEquipName(param);
				checkUseVO.setEquipCode2(equipCode2);
			}
			
			/*String equipCode1 = checkUseVO.getEquipCode1();
			String equipCode2 = checkUseVO.getEquipCode2();
			String[] arrEquipCode1 = null;
			String[] arrEquipCode2 = null;
			HashMap<String, Object> param = new HashMap<String, Object>();
			if(!"".equals(equipCode1) && equipCode1!=null) {
				arrEquipCode1 = equipCode1.split(",");
			}
			if(!"".equals(equipCode2) && equipCode2!=null) {
				arrEquipCode2 = equipCode2.split(",");
			}
			
			param.put("arrEquipCode", arrEquipCode1);
			equipCode1 = dailyWorkService.selectCheckUseEquipName(param);
			checkUseVO.setEquipCode1(equipCode1);
			
			param.put("arrEquipCode", arrEquipCode2);
			equipCode2 = dailyWorkService.selectCheckUseEquipName(param);
			checkUseVO.setEquipCode2(equipCode2);*/
			List<DailyWorkApprovalVO> approvalList= dailyWorkService.selectCheckUseApprovalList(dailyWorkId);				//업무일지 결재정보
			
			List<CheckUseDetailVO> checkList = dailyWorkService.selectCheckUseDetailList(dailyWorkId);
			
			modelAndView.setViewName("dailywork/checkUsePrintView"+gubun);
				
			modelAndView.addObject("gubun", gubun);
			modelAndView.addObject("menuGubun", "dailyWork");
			modelAndView.addObject("checkUseVO", checkUseVO);
			modelAndView.addObject("approvalList", approvalList);
			modelAndView.addObject("checkList", checkList);
			
			
			return modelAndView;
		}
		
		/**
		 * 점검및사용일지 모니터링
		 * @param commandMap
		 * @return view 페이지
		 * @exception Exception
		 */
		@RequestMapping("/dailywork/checkUseMonitoring.do")
		public String checkUseMonitoring(
				Map<String, Object> commandMap,
				@ModelAttribute("searchVO") SeminarSearchVO searchVO,
				DateDataVO dateData,
				ModelMap model
			) throws Exception {
			
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			String deptNo = user.getDeptNo(); 
			
			String deptCode = "";
			if("".equals((String)commandMap.get("searchDeptNo")) || (String)commandMap.get("searchDeptNo")==null) {
				//if(deptNo=="1001") {
					//deptCode = "1002";
				//} else {
					deptCode = deptNo;
				//}
			} else {
				deptCode = (String)commandMap.get("searchDeptNo");
			}
			Calendar cal = Calendar.getInstance();
			DateDataVO calendarData;
			//검색 날짜
			if(dateData.getDate().equals("")&&dateData.getMonth().equals("")){
				dateData = new DateDataVO(String.valueOf(cal.get(Calendar.YEAR)),String.valueOf(cal.get(Calendar.MONTH)),String.valueOf(cal.get(Calendar.DATE)),null);
			}
			//검색 날짜 end
			dateData.setDeptNo(deptCode);

			Map<String, Integer> today_info =  dateData.today_info(dateData);
			List<DateDataVO> dateList = new ArrayList<DateDataVO>();
			
			int count;
			
			int year = Integer.parseInt(dateData.getYear());
			int month = Integer.parseInt(dateData.getMonth());
			if(month==0) {
				year = year-1;
				count=dateData.lastDay(Integer.parseInt(dateData.getYear())-1, month+1) - today_info.get("start") + 1;
			} else if(month==11){
				//if(month==11) year = year+1;
				count=dateData.lastDay(Integer.parseInt(dateData.getYear())+1, month+1) - today_info.get("start") + 1;
			} else {
				count=dateData.lastDay(Integer.parseInt(dateData.getYear()), month+1) - today_info.get("start") + 1;
			}
			//실질적인 달력 데이터 리스트에 데이터 삽입 시작.
			//일단 시작 인덱스까지 아무것도 없는 데이터 삽입
			String startDate = "";
			String endDate = "";
			for(int i=1; i<today_info.get("start"); i++){
				//calendarData= new DateDataVO(null, null, null, null);
				if(i==1) {
					String prefix = "";
					if(month<10 && month>0) prefix = "0";
					startDate = String.valueOf(year)+prefix+String.valueOf(month==0?12:month)+String.valueOf(i+count);
				}
				calendarData= new DateDataVO(String.valueOf(year), String.valueOf(month-1), String.valueOf(i+count), "");
				dateList.add(calendarData);
			}
			
			//날짜 삽입
			for (int i = today_info.get("startDay"); i <= today_info.get("endDay"); i++) {
				if(i==today_info.get("startDay") && startDate=="") {
					String prefix = "";
					if(month+1<10 || month+1>12) prefix = "0";
					startDate = String.valueOf(year)+prefix+String.valueOf(month+1)+"01";
				}
				if(i==today_info.get("endDay")) {
					String prefix1 = "";
					String prefix2 = "";
					if(month+1<10 || month+1>12) prefix1 = "0";
					if(today_info.get("endDay")<10) prefix2 = "0";
					endDate = String.valueOf(month+1>12?year+1:year)+prefix1+String.valueOf(month+1>12?1:month+1)+prefix2+today_info.get("endDay");
				}
				if(i==today_info.get("today")){
					calendarData= new DateDataVO(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "today");
				}else{
					calendarData= new DateDataVO(String.valueOf(dateData.getYear()), String.valueOf(dateData.getMonth()), String.valueOf(i), "normal_date");
				}
				dateList.add(calendarData);
			}
			//달력 빈곳 빈 데이터로 삽입
			int index = 7-dateList.size()%7;
			count=1;
			if(dateList.size()%7!=0){
				
				for (int i = 0; i < index; i++) {
					if(i==index-1) {
						String prefix = "";
						if(month+2<10 || month+2>12) prefix = "0";
						if(month==0) year=Integer.parseInt(dateData.getYear());
						if(month==11) year=Integer.parseInt(dateData.getYear())+1;
						endDate = String.valueOf(month+2>12?year+1:year)+prefix+String.valueOf(month+2>12?1:month+2)+"0"+String.valueOf(index);
					}
					calendarData= new DateDataVO(String.valueOf(year), String.valueOf(month+1), String.valueOf(i+count), "");
					//calendarData= new DateDataVO(null, null, null, null);
					dateList.add(calendarData);
				}
			}
			//System.out.println("END DATE >>>> " + endDate);
			//System.out.println(dateList);
			
			//LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("deptCode", deptCode);
			paramMap.put("startDate", startDate);
			paramMap.put("endDate", endDate);
			paramMap.put("searchMonth", ""+dateData.getYear()+(month+1<10?"0"+(month+1):""+(month+1)));
			
			//System.out.println("paramMap >>> " + paramMap);
			
			int totWeekCnt = 0;
			int totMonthCnt = 0;
			Map<String, Object> resultMap = dailyWorkService.getMonitoringCount(paramMap);
			List displayList = dailyWorkService.getMonitoringList(paramMap);
			//배열에 담음
			//System.out.println("displayList size >>>> " + displayList.size());
			//System.out.println("dateList size >>>> " + dateList.size());
			
			for(int k=0;k<dateList.size();k++) {
				calendarData = dateList.get(k);
				dateList.remove(k);
				calendarData.setSchedule(""+((HashMap<String,Object>)displayList.get(k)).get("DUM_DAYS"));
				calendarData.setTotWeek(""+((HashMap<String,Object>)displayList.get(k)).get("TOT_WEEK"));
				calendarData.setTotMonth(""+((HashMap<String,Object>)displayList.get(k)).get("TOT_MONTH"));
				calendarData.setTotWeek2(""+((HashMap<String,Object>)displayList.get(k)).get("TOT_WEEK2"));
				calendarData.setTotMonth2(""+((HashMap<String,Object>)displayList.get(k)).get("TOT_MONTH2"));
				calendarData.setLastDay(""+((HashMap<String,Object>)displayList.get(k)).get("LASTDAY"));
				
				dateList.add(k, calendarData);
			}
			
			model.addAttribute("dateList", dateList);		//날짜 데이터 배열
			//model.addAttribute("displayList", displayList);		//날짜 데이터 배열
			model.addAttribute("today_info", today_info);
			model.addAttribute("deptNo", deptNo);
			model.addAttribute("totWeekCnt", resultMap.get("totWeekCnt"));
			model.addAttribute("totMonthCnt", resultMap.get("totMonthCnt"));
			return "dailywork/checkUseMonitoring";
		}
		
		/**
		 * 업무일지 목록 데이터
		 * 2014.09.18
		 * yrkim
		 * @param commandMap
		 * @return
		 * @throws Exception
		 */
		@RequestMapping("/dailywork/getCheckUsePopupList.do")
		public ModelAndView getCheckUsePopupList(
				@ModelAttribute("searchVO") DailyWorkSearchVO searchVO, 
				Map<String, Object> commandMap,
				ModelMap model) throws Exception {
			
			String deptNo = (String)commandMap.get("deptCode");
			String regDate = (String)commandMap.get("regDate");
			
			Map<String, Object> paramMap = new HashMap<String, Object>();
			paramMap.put("regDate", regDate);
			paramMap.put("deptNo",  deptNo);
			
			List authUserList = dailyWorkService.getCheckUsePopupList(paramMap);
			
			ModelAndView modelAndView = new ModelAndView();
			
	        modelAndView.addObject("authUserList", authUserList);
	        modelAndView.setViewName("jsonView");

	        return modelAndView;
		}
}