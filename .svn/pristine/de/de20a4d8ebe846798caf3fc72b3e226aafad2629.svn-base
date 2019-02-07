package daewooInfo.mobile.dailywork.web;

import java.text.DecimalFormat;
import java.util.Calendar;
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
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.common.TmsMessageSource;
import daewooInfo.common.alrim.bean.AlrimVO;
import daewooInfo.common.alrim.service.AlrimService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.fcc.StringUtil;
import daewooInfo.dailywork.bean.DailyWorkApprovalVO;
import daewooInfo.dailywork.bean.DailyWorkRainVO;
import daewooInfo.dailywork.bean.DailyWorkSearchVO;
import daewooInfo.dailywork.bean.DailyWorkVO;
import daewooInfo.dailywork.bean.DailyWorkWriteAuthVO;
import daewooInfo.dailywork.bean.MonitoringVO;
import daewooInfo.dailywork.bean.RiverMainVO;
import daewooInfo.dailywork.bean.SituationRoomVO;
import daewooInfo.dailywork.service.DailyWorkService;
import daewooInfo.dailywork.service.MonitoringService;
import daewooInfo.dailywork.service.RiverMainService;
import daewooInfo.dailywork.service.SituationRoomService;
import daewooInfo.mobile.com.utl.LogInfoUtil;
import daewooInfo.mobile.com.utl.ObjectUtil;
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
public class MobileDailyWorkController {

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
	    
	/**
	 * log
	 * @uml.property  name="log"
	 */
    Log log = LogFactory.getLog(MobileDailyWorkController.class);

    /**
   	 * 업무일지 목록 데이터
   	 * 2014.09.18
   	 * yrkim
   	 * @param commandMap
   	 * @return
   	 * @throws Exception
   	 */
   	@RequestMapping("/mobile/sub/dailywork/dailyWorkSearch.do")
   	public String dailyWorkSearch(@RequestParam(value="gubun", required=false) String gubun, @ModelAttribute("searchVO") DailyWorkSearchVO searchVO, ModelMap model) throws Exception {
   		return "mobile/sub/dailywork/dailyWorkSearch";
   	}

    /**
   	 * 업무일지 목록 데이터
   	 * 2014.09.18
   	 * yrkim
   	 * @param commandMap
   	 * @return
   	 * @throws Exception
   	 */
   	@RequestMapping("/mobile/sub/dailywork/dailyWorkList.do")
   	public String dailyWorkList( @ModelAttribute("searchVO") DailyWorkSearchVO searchVO, ModelMap model) throws Exception {
		
		if(StringUtil.isEmpty(searchVO.getStartDate())){
			searchVO.setStartDate(searchDate("addMonth"));
			searchVO.setEndDate(searchDate("today"));
		}
			
		searchVO.setPageUnit(1000000);		
		
		searchVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
	
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		Map<String, Object> map = dailyWorkService.dailyWorkList(searchVO);
		
		List<DailyWorkSearchVO> resultList = (List<DailyWorkSearchVO>)map.get("resultList");
		
		model.addAttribute("List", resultList);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
   		return "mobile/sub/dailywork/dailyWorkList";
   	}
   	
   	/**
	 * 상황실 근무일지 상세조회
	 */
	@RequestMapping("/mobile/sub/dailywork/dailyWorkDetail.do")
	public String dailyWorkDetail(
			  HttpServletResponse res
			, HttpServletRequest req
			, @RequestParam(value="dailyWorkId", 		required=false) String dailyWorkId
			, @RequestParam(value="searchGubun", 				required=false) String gubun
			, @RequestParam(value="approvalSeq", 		required=false) String approvalSeq
			, @RequestParam(value="regId", 				required=false) String regId
			, @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO
			, @ModelAttribute("dailyWorkRainVO") DailyWorkRainVO dailyWorkRainVO
			, @ModelAttribute("dailyWorkWriteAuthVO") DailyWorkWriteAuthVO dailyWorkWriteAuthVO
			, ModelMap model
			) throws Exception {

		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		String userId = user.getId();
		
		dailyWorkVO = dailyWorkService.selectDailyWorkMasterInfo(dailyWorkId);													//업무일지 기본정보
		List<DailyWorkApprovalVO> approvalList= dailyWorkService.selectDailyWorkApprovalList(dailyWorkId);				//업무일지 결재정보

		String param = ObjectUtil.RequestParamString(req, "startDate,endDate,searchGubun,searchState");
		model.addAttribute("listparameter", param);
		
		String return_value = "";
		if(gubun.equals("S")){
			SituationRoomVO situationRoomVO = new SituationRoomVO();
			
			situationRoomVO = situationRoomService.selectSituationRoomInfo(dailyWorkId);										//상황실 근무일지 근무상황정보
			
			situationRoomVO.setDailyWorkId(dailyWorkId);
			
			situationRoomVO.setSpreadGubun("S");
			List<SituationRoomVO> spreadSList = situationRoomService.selectSituationSpreadInfo(situationRoomVO);	//업무일지 상황전파 현황
			
			situationRoomVO.setSpreadGubun("G");
			List<SituationRoomVO> spreadGList = situationRoomService.selectSituationSpreadInfo(situationRoomVO);	//업무일지 상황전파 현황
			
			List<DailyWorkRainVO> rainFallList = dailyWorkService.selectDailyWorkRainInfo(dailyWorkRainVO);				//업무일지 강우현황
			
			model.addAttribute("situationRoomVO", situationRoomVO);
			model.addAttribute("spreadSList", spreadSList);
			model.addAttribute("spreadGList", spreadGList);
			model.addAttribute("rainFallList", rainFallList);
			
			if(!regId.equals(userId)){
				
				dailyWorkWriteAuthVO.setDailyWorkId(dailyWorkId);
				dailyWorkWriteAuthVO.setWriteAuthId(userId);
				
				int cnt = dailyWorkService.getDailyWorkWriteAuthId(dailyWorkWriteAuthVO);		
				
				if(cnt == 0){
					res.setContentType("text/html; charset=UTF-8");
					res.getWriter().print("<script>alert('작성권한이 없습니다.');document.location.href='/mobile/sub/dailywork/dailyWorkList.do" + param + "'</script>");
					
					return null;
				}
			}
			
			return_value = "/mobile/sub/dailywork/situationRoomDetail";
			
		}else if(gubun.equals("R")){
			RiverMainVO riverMainVO = new RiverMainVO();
			riverMainVO = riverMainService.selectRiverMainInfo(dailyWorkId);															//4대강주요수계일지정보
			
			model.addAttribute("riverMainVO", riverMainVO);
			return_value = "/mobile/sub/dailywork/riverMainDetail";
			
		}else if(gubun.equals("M")){
			MonitoringVO monitoringVO = new MonitoringVO();
			monitoringVO = monitoringService.selectMonitoringInfo(dailyWorkId);														//조류모니터링 기본정보
			
			monitoringVO.setDailyWorkId(dailyWorkId);
			
			List<MonitoringVO> forecastSList = monitoringService.selectForeCastInfo(monitoringVO);							//수질예측정보
			
			List<DailyWorkRainVO> rainFallList = dailyWorkService.selectDailyWorkRainInfo(dailyWorkRainVO);				//업무일지 강우현황
			
			model.addAttribute("monitoringVO", monitoringVO);
			model.addAttribute("forecastSList", forecastSList);
			model.addAttribute("rainFallList", rainFallList);
			return_value = "/mobile/sub/dailywork/monitoringDetail";
		}
		
		model.addAttribute("seq", approvalSeq);
		model.addAttribute("dailyWorkVO", dailyWorkVO);
		model.addAttribute("approvalList", approvalList);
		model.addAttribute("menuGubun", "dailyWork");
		return return_value; 
	}

    /**
   	 * 받은결재 검색
   	 * 2014.09.18
   	 * yrkim
   	 * @param commandMap
   	 * @return
   	 * @throws Exception
   	 */
   	@RequestMapping("/mobile/sub/dailywork/receiveApprovalSearch.do")
   	public String receiveApprovalSearch(@RequestParam(value="gubun", required=false) String gubun, @ModelAttribute("searchVO") DailyWorkSearchVO searchVO, ModelMap model) throws Exception {
   		return "mobile/sub/dailywork/receiveApprovalSearch";
   	}
   	
	/**
	 * 받은결재 데이터
	 * 2014.10.02
	 * yrkim
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/dailywork/receiveApprovalList.do")
	public String receiveApprovalList(
			  HttpServletResponse res,
			  HttpServletRequest req,
			@ModelAttribute("searchVO") DailyWorkSearchVO searchVO, 
			Map<String, Object> commandMap,
			ModelMap model) throws Exception {
		
		
		if(StringUtil.isEmpty(searchVO.getStartDate())){
			searchVO.setStartDate(searchDate("addMonth"));
			searchVO.setEndDate(searchDate("today"));  
		}
			
		searchVO.setPageUnit(1000000);		
		
		searchVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
	
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		searchVO.setUserId(LogInfoUtil.GetSessionLogin().getId());
		Map<String, Object> map = dailyWorkService.receiveApprovalList(searchVO);
		
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		List<DailyWorkSearchVO> resultList = (List<DailyWorkSearchVO>)map.get("resultList");
		
		model.addAttribute("List", resultList);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "/mobile/sub/dailywork/receiveApprovalList";
	}
	
	/**
	 * 받은결재 상세
	 * 2014.10.06
	 * yrkim
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/dailywork/receiveApprovalDetail.do")
	public String situationRoomDetail(
			  HttpServletRequest req
			, @RequestParam(value="dailyWorkId", 		required=false) String dailyWorkId
			, @RequestParam(value="searchGubun", 				required=false) String gubun
			, @RequestParam(value="approvalSeq", 		required=false) String approvalSeq
			, @RequestParam(value="appCheck", 			required=false) String appCheck
			, @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO
			, @ModelAttribute("dailyWorkRainVO") DailyWorkRainVO dailyWorkRainVO
			, ModelMap model
			) throws Exception {
		
		dailyWorkVO = dailyWorkService.selectDailyWorkMasterInfo(dailyWorkId);													//업무일지 기본정보
		List<DailyWorkApprovalVO> approvalList= dailyWorkService.selectDailyWorkApprovalList(dailyWorkId);				//업무일지 결재정보
		
		String param = ObjectUtil.RequestParamString(req, "startDate,endDate,searchState");
		model.addAttribute("listparameter", param);
		
		String return_value;
		if(gubun.equals("S")){
			SituationRoomVO situationRoomVO = new SituationRoomVO();
			
			situationRoomVO = situationRoomService.selectSituationRoomInfo(dailyWorkId);										//상황실 근무일지 근무상황정보
			
			situationRoomVO.setDailyWorkId(dailyWorkId);
			
			situationRoomVO.setSpreadGubun("S");
			List<SituationRoomVO> spreadSList = situationRoomService.selectSituationSpreadInfo(situationRoomVO);	//업무일지 상황전파 현황
			
			situationRoomVO.setSpreadGubun("G");
			List<SituationRoomVO> spreadGList = situationRoomService.selectSituationSpreadInfo(situationRoomVO);	//업무일지 상황전파 현황
			
			List<DailyWorkRainVO> rainFallList = dailyWorkService.selectDailyWorkRainInfo(dailyWorkRainVO);				//업무일지 강우현황
			
			model.addAttribute("situationRoomVO", situationRoomVO);
			model.addAttribute("spreadSList", spreadSList);
			model.addAttribute("spreadGList", spreadGList);
			model.addAttribute("rainFallList", rainFallList);
			
			return_value =  "/mobile/sub/dailywork/situationRoomDetail";
			
		}else if(gubun.equals("R")){
			RiverMainVO riverMainVO = new RiverMainVO();
			riverMainVO = riverMainService.selectRiverMainInfo(dailyWorkId);															//4대강주요수계일지정보
			
			model.addAttribute("riverMainVO", riverMainVO);
			return_value =   "/mobile/sub/dailywork/riverMainDetail";
			
		}else{
			MonitoringVO monitoringVO = new MonitoringVO();
			monitoringVO = monitoringService.selectMonitoringInfo(dailyWorkId);														//조류모니터링 기본정보
			
			monitoringVO.setDailyWorkId(dailyWorkId);
			
			List<MonitoringVO> forecastSList = monitoringService.selectForeCastInfo(monitoringVO);							//수질예측정보
			
			List<DailyWorkRainVO> rainFallList = dailyWorkService.selectDailyWorkRainInfo(dailyWorkRainVO);				//업무일지 강우현황
			
			model.addAttribute("monitoringVO", monitoringVO);
			model.addAttribute("forecastSList", forecastSList);
			model.addAttribute("rainFallList", rainFallList);
			return_value =   "/mobile/sub/dailywork/monitoringDetail";
		}

		model.addAttribute("gubun", gubun);
		model.addAttribute("seq", approvalSeq);
		model.addAttribute("menuGubun", "app");
		model.addAttribute("appCheck", appCheck);
		model.addAttribute("dailyWorkVO", dailyWorkVO);
		model.addAttribute("approvalList", approvalList);
		return return_value; 
	}


	
	/**
	 * 결재 승인
	 * 2014.10.07
	 */
	@RequestMapping("/mobile/sub/dailywork/approvalProc.do")
	public ModelAndView insertApproval (
			HttpServletResponse res
			, HttpServletRequest req
			, @ModelAttribute("searchVO") DailyWorkSearchVO searchVO
			, @ModelAttribute("dailyWorkApprovalVO") DailyWorkApprovalVO dailyWorkApprovalVO
			, @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO
			, ModelMap model
			, Map<String, Object> commandMap
			) throws Exception {
		try{
				LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

				String param = ObjectUtil.RequestParamString(req, "startDate,endDate,searchState");
				model.addAttribute("listparameter", param);
				
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
				res.getWriter().print("<script>alert('결재가 정상적으로 등록되었습니다.');document.location.href='/mobile/sub/dailywork/receiveApprovalList.do"+param+"'</script>");
				
		}catch(Exception e){
			e.printStackTrace();
		}		
		return null;
	}
	
	/**
	 * 결재 반려
	 * 2014.10.08
	 */
	@RequestMapping("/mobile/sub/dailywork/approvalReturnProc.do")
	public ModelAndView insertApprovalReturn (
			HttpServletResponse res
			, HttpServletRequest req
			, @ModelAttribute("searchVO") DailyWorkSearchVO searchVO
			, @ModelAttribute("dailyWorkApprovalVO") DailyWorkApprovalVO dailyWorkApprovalVO
			, @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO
			, ModelMap model
			, Map<String, Object> commandMap
			) throws Exception {
		try{
				LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

				String param = ObjectUtil.RequestParamString(req, "startDate,endDate,searchState");
				model.addAttribute("listparameter", param);
				
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
				res.getWriter().print("<script>alert('반려가 정상적으로 등록되었습니다.');document.location.href='/mobile/sub/dailywork/receiveApprovalList.do"+param+"'</script>");
				
		}catch(Exception e){
			e.printStackTrace();
		}		
		return null;
	}
	
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
}