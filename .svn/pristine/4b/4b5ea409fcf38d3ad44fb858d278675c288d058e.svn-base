package daewooInfo.dailywork.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.ui.ModelMap;

import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.cmmn.service.EgovFileMngService;
import daewooInfo.common.TmsMessageSource;
import daewooInfo.common.alrim.bean.AlrimVO;
import daewooInfo.common.alrim.dao.AlrimDAO;
import daewooInfo.common.alrim.service.AlrimService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.EgovFileMngUtil;
import daewooInfo.common.util.fcc.StringUtil;
import daewooInfo.dailywork.bean.DailyWorkApprovalVO;
import daewooInfo.dailywork.bean.DailyWorkRainVO;
import daewooInfo.dailywork.bean.DailyWorkVO;
import daewooInfo.dailywork.bean.DailyWorkWriteAuthVO;
import daewooInfo.dailywork.bean.MonitoringVO;
import daewooInfo.dailywork.service.DailyWorkService;
import daewooInfo.dailywork.service.MonitoringService;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;


/**
 * 
 * 조류모니터링 관리
 * @author yrkim
 * @since 2014.10.10
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2014.10.10  yrkim          최초 생성
 *
 * </pre>
 */

@Controller
public class MonitoringController {
	/**
	 * @uml.property  name="dailyWorkService"
	 */
	@Resource(name = "DailyWorkService")
    private DailyWorkService dailyWorkService;
	
	/**
	 * @uml.property  name="monitoringService"
	 */
	@Resource(name = "MonitoringService")
    private MonitoringService monitoringService;
	
	/**
	 * @uml.property  name="fileUtil"
	 */
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	/**
	 * @uml.property  name="fileMngService"
	 */
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;
	
	/**
	 * AlrimService
	 * @uml.property  name="alrimService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alrimService")
	private AlrimService alrimService;         
	    
	/**
	 * EgovMessageSource
	 * @uml.property  name="tmsMessageSource"
	 */
	@Resource(name="tmsMessageSource")
	TmsMessageSource tmsMessageSource;
	
	/**
	 * @uml.property  name="idgenDailyWorkService"
	 */
    @Resource(name = "dailyWorkIdGnrService")
    private EgovIdGnrService idgenDailyWorkService;
    
	/**
	 * log
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
    Log log = LogFactory.getLog(RiverMainController.class);
	
	/**
	 * 조류모니터링 결재자 선택
	 * 2014.10.10
	 * yrkim
	 */
	@RequestMapping("/dailywork/monitoringRegist.do")
	public String monitoringRegist(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "dailywork/monitoringRegist";
	}
	
	/**
	 * 조류모니터링 상세등록
	 * 2014.10.10
	 * yrkim
	 */
	@RequestMapping("/dailywork/monitoringRegDetail.do")
	public ModelAndView monitoringRegDetail(
			 Map<String, Object> commandMap
			,@RequestParam(value="memberAppId", required=false) String memberAppId
			,@RequestParam(value="memberAuthId", required=false) String memberAuthId
			,@RequestParam(value="workDay", required=false) String workDay
			, ModelMap model
			) throws Exception {
		
		String[] memberId = memberAppId.split(",");
		
		String approvalName1 = dailyWorkService.approvalNameSelect(memberId[0]);		//결재자1
		String approvalName2 = dailyWorkService.approvalNameSelect(memberId[1]);		//결재자2
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("memberAppId", memberAppId);
		modelAndView.addObject("memberAuthId", memberAuthId);
		modelAndView.addObject("approvalName1", approvalName1);
		modelAndView.addObject("approvalName2", approvalName2);
		modelAndView.addObject("workDay", workDay);
		
		modelAndView.setViewName("dailywork/monitoringRegDetail");
		
		return modelAndView;
	}
	
	/**
	 * 조류모니터링 등록
	 * 2014.10.13
	 * yrkim
	 */
	@RequestMapping("/dailywork/monitoringRegProc.do")
	public ModelAndView monitoringRegProc(
			   final MultipartHttpServletRequest multiRequest
			,  HttpServletResponse res
			 , @RequestParam(value="memberAppId",				required=false) String memberAppIds
			 , @RequestParam(value="memberAuthId",				required=false) String memberAuthIds
			 , @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO																//업무일지 기본정보
			 , @ModelAttribute("dailyWorkApprovalVO") DailyWorkApprovalVO dailyWorkApprovalVO								//결재
			 , @ModelAttribute("dailyWorkWriteAuthVO") DailyWorkWriteAuthVO dailyWorkWriteAuthVO					//작성권한
			 , @ModelAttribute("monitoringVO") MonitoringVO monitoringVO																//조류모니터링
			 , @ModelAttribute("dailyworkRainVO") DailyWorkRainVO dailyworkRainVO											//강우현황
			 , @RequestParam(value="tRiverDiv[]",					required=false) String[] tRiverDiv
			 , @RequestParam(value="tFactCode[]",				required=false) String[] tFactCode
			 , @RequestParam(value="tRainFall[]",					required=false) String[] tRainFall
			 , @RequestParam(value="aRiverDiv[]",					required=false) String[] aRiverDiv
			 , @RequestParam(value="aFactCode[]",				required=false) String[] aFactCode
			 , @RequestParam(value="aForecastDay[]",			required=false) String[] aForecastDay
			 , @RequestParam(value="aForecastStatus[]",		required=false) String[] aForecastStatus
			 , @RequestParam(value="aForecastCon[]",			required=false) String[] aForecastCon
			 , @RequestParam(value="aForecastTidal[]",			required=false) String[] aForecastTidal
			 , @RequestParam(value="aForecastAuto[]",			required=false) String[] aForecastAuto
			)throws Exception{
		try{
			
			dailyWorkVO.setGubun("M");																										//상황실근무일지:S, 4대강주요수계일지:R, 조류모니터링:M
			
			int resultCnt =  dailyWorkService.selectDailyWorkInfo(dailyWorkVO);
			
			if (resultCnt > 0 ) {
				res.setContentType("text/html; charset=UTF-8");
//				res.getWriter().print("<script>alert('입력하신 일자에 해당하는 조류모니터링 일지가 존재합니다.');document.location.href='/dailywork/dailyWorkList.do?gubun=R'</script>");
				res.getWriter().print("<script>alert('입력하신 일자에 해당하는 조류모니터링 일지가 존재합니다.');history.back();</script>");
			}else{
				LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
				String userId = user.getId();
				dailyWorkVO.setRegId(userId);																								//작성자
				
				String dailyWorkId = idgenDailyWorkService.getNextStringId();														//업무일지ID
				
				int resultOk = 0; 
				
				/** 업무일지정보 저장 */
				dailyWorkVO.setDailyWorkId(dailyWorkId);
				
				try{
					
					dailyWorkService.insertDailyWorkInfo(dailyWorkVO);
					resultOk++;
					
				}catch(Exception e){
					resultOk = 0;
				}
				
				if(resultOk  > 0) {
					/** 결재 정보 저장 */
					String[] memberAppId = memberAppIds.split(",");												//결재자
					
					dailyWorkApprovalVO.setDailyWorkId(dailyWorkId);
					
					int seq = 0;
					
					for(int i=0; i<memberAppId.length; i++){
						seq = dailyWorkService.getDailyWorkApprovalSeq(dailyWorkId);						//seq 
						
						dailyWorkApprovalVO.setSeq(seq);
						dailyWorkApprovalVO.setApprovalMemberId(memberAppId[i]);
						dailyWorkService.insertDailyWorkApprovalInfo(dailyWorkApprovalVO);		
					}
					
					/** 작성권한 정보 */
					String[] memberAuthId = memberAuthIds.split(",");												//작성권한
					dailyWorkWriteAuthVO.setDailyWorkId(dailyWorkId);
					
					for(int i=0; i<memberAuthId.length; i++){
						seq = dailyWorkService.getDailyWorkWriteAuthSeq(dailyWorkId);						//seq 
						
						dailyWorkWriteAuthVO.setSeq(seq);
						dailyWorkWriteAuthVO.setWriteAuthId(memberAuthId[i]);
						dailyWorkService.insertDailyWriteAuthInfo(dailyWorkWriteAuthVO);			
					}
					
					monitoringVO.setDailyWorkId(dailyWorkId);
					
					List<FileVO> result = null;
					String atchFileId = "";
					final Map<String, MultipartFile> files = multiRequest.getFileMap();
					
					if (!files.isEmpty()) {
						result = fileUtil.parseFileInf(files, "DAILY_WORK_", 0, "", "");
						atchFileId = fileMngService.insertFileInfs(result);
					}
					
					monitoringVO.setAtchFileId(atchFileId);
					/** 조류모니터링일지 기본정보 */
					monitoringService.insertMonitoringInfo(monitoringVO);
					
					/** 수질예측정보*/
					for(int i=0; i<aRiverDiv.length; i++){
						monitoringVO.setRiverDiv(aRiverDiv[i] == null ? "" : aRiverDiv[i]);
						monitoringVO.setFactCode(aFactCode[i] == null ? "" : aFactCode[i]);
						monitoringVO.setForecastDay(aForecastDay[i] == null ? "" : aForecastDay[i]);
						monitoringVO.setForecastStatus(aForecastStatus[i] == null ? "" : aForecastStatus[i]);
						monitoringVO.setForecastCon(aForecastCon[i] == null ? "" : aForecastCon[i]);
						monitoringVO.setForecastTidal(aForecastTidal[i] == null ? "" : aForecastTidal[i]);
						monitoringVO.setForecastAuto(aForecastAuto[i] == null ? "" : aForecastAuto[i]);
						
						monitoringService.insertForecastInfo(monitoringVO);
					}
					
					/**
					 * 강우현황 저장
					 */
					dailyworkRainVO.setDailyWorkId(dailyWorkId);
					
					for(int i=0; i<tRiverDiv.length; i++){
						dailyworkRainVO.setRiverDiv(tRiverDiv[i] == null ? "" : tRiverDiv[i]);
						dailyworkRainVO.setFactCode(tFactCode[i] == null ? "" : tFactCode[i]);
						dailyworkRainVO.setRainFall(tRainFall[i] == null ? "" : tRainFall[i]);
						
						dailyWorkService.insertDailyWorkRainInfo(dailyworkRainVO);
					}
					
					res.setContentType("text/html; charset=UTF-8");
					res.getWriter().print("<script>alert('조류모니터링일지가 정상적으로 등록되었습니다.');document.location.href='/dailywork/dailyWorkList.do?gubun=M'</script>");
				}else{ 
					res.setContentType("text/html; charset=UTF-8");
					res.getWriter().print("<script>alert('ERROR');document.location.href='/dailywork/dailyWorkList.do?gubun=M'</script>");
				}
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}		
		return null;
	}
	
	/**
	 * 조류모니터링 상세조회
	 */
	@RequestMapping("/dailywork/monitoringDetail.do")
	public ModelAndView monitoringDetail(
			  HttpServletResponse res
			, Map<String, Object> commandMap
			, @RequestParam(value="dailyWorkId", 		required=false) String dailyWorkId
			,@RequestParam(value="memberAuthId", required=false) String memberAuthId
			, @RequestParam(value="regId", 				required=false) String regId
			, @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO
			, @ModelAttribute("monitoringVO") MonitoringVO monitoringVO
			, @ModelAttribute("dailyWorkRainVO") DailyWorkRainVO dailyWorkRainVO
			, @ModelAttribute("dailyWorkWriteAuthVO") DailyWorkWriteAuthVO dailyWorkWriteAuthVO
			, ModelAndView modelAndView
			) throws Exception {
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		String userId = user.getId();
		
		dailyWorkVO = dailyWorkService.selectDailyWorkMasterInfo(dailyWorkId);												//업무일지 기본정보
		List<DailyWorkApprovalVO> approvalList= dailyWorkService.selectDailyWorkApprovalList(dailyWorkId);				//업무일지 결재정보
		
		monitoringVO = monitoringService.selectMonitoringInfo(dailyWorkId);														//조류모니터링 기본정보
		
		monitoringVO.setDailyWorkId(dailyWorkId);
		
		List<MonitoringVO> forecastSList = monitoringService.selectForeCastInfo(monitoringVO);							//수질예측정보
		
		List<DailyWorkRainVO> rainFallList = dailyWorkService.selectDailyWorkRainInfo(dailyWorkRainVO);				//업무일지 강우현황
		
		modelAndView.addObject("dailyWorkVO", dailyWorkVO);
		modelAndView.addObject("approvalList", approvalList);
		modelAndView.addObject("monitoringVO", monitoringVO);
		modelAndView.addObject("forecastSList", forecastSList);
		modelAndView.addObject("rainFallList", rainFallList);
		modelAndView.addObject("menuGubun", "dailyWork");
		modelAndView.addObject("userId", userId);
		
		modelAndView.setViewName("dailywork/monitoringDetail");
		
		if(!regId.equals(userId)){
			
			dailyWorkWriteAuthVO.setDailyWorkId(dailyWorkId);
			dailyWorkWriteAuthVO.setWriteAuthId(userId);
			
			int cnt = dailyWorkService.getDailyWorkWriteAuthId(dailyWorkWriteAuthVO);		
			
			if(cnt == 0){
 				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('작성권한이 없습니다.');document.location.href='/dailywork/dailyWorkList.do?gubun=M'</script>");
				
				return null;
				
			}else{
				return modelAndView;
			}
		}else{
			return modelAndView;
		}
		
	}
	
	/**
	 * 조류모니터링 수정화면
	 */
	@RequestMapping("/dailywork/monitoringModify.do")
	public ModelAndView monitoringModify(
			  HttpServletResponse res
			, Map<String, Object> commandMap
			, @RequestParam(value="dailyWorkId", 		required=false) String dailyWorkId
			, @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO
			, @ModelAttribute("monitoringVO") MonitoringVO monitoringVO
			, @ModelAttribute("dailyWorkRainVO") DailyWorkRainVO dailyWorkRainVO
			, @RequestParam(value="modifyGubun",				required=false) String modifyGubun
			, ModelAndView modelAndView
			) throws Exception {
		
		dailyWorkVO = dailyWorkService.selectDailyWorkMasterInfo(dailyWorkId);												//업무일지 기본정보
		List<DailyWorkApprovalVO> approvalList= dailyWorkService.selectDailyWorkApprovalList(dailyWorkId);				//업무일지 결재정보
		monitoringVO = monitoringService.selectMonitoringInfo(dailyWorkId);														//조류모니터링 기본정보
		
		monitoringVO.setDailyWorkId(dailyWorkId);
		
		List<MonitoringVO> forecastSList = monitoringService.selectForeCastInfo(monitoringVO);							//수질예측정보
		
		int cnt = monitoringService.selectMonitoringFileCnt(monitoringVO.getAtchFileId());									//첨부파일 조회
		
		if(cnt>0){
			monitoringVO.setFileAtchPosblAt("N");
		}else{
			monitoringVO.setFileAtchPosblAt("Y");
		}
		
		List<DailyWorkRainVO> rainFallList = dailyWorkService.selectDailyWorkRainInfo(dailyWorkRainVO);				//업무일지 강우현황
		
		modelAndView.addObject("dailyWorkVO", dailyWorkVO);
		modelAndView.addObject("approvalList", approvalList);
		modelAndView.addObject("monitoringVO", monitoringVO);
		modelAndView.addObject("forecastSList", forecastSList);
		modelAndView.addObject("rainFallList", rainFallList);
		modelAndView.addObject("modifyGubun", modifyGubun);
		
		modelAndView.setViewName("dailywork/monitoringModify");
		
		return modelAndView;
		
	}
	
	/**
	 * 조류모니터링 수정
	 * 2014.10.13
	 * yrkim
	 */
	@RequestMapping("/dailywork/monitoringModProc.do")
	public ModelAndView monitoringModProc(
			final MultipartHttpServletRequest multiRequest
			 , HttpServletResponse res
			 , @RequestParam(value="memberAppId",				required=false) String memberAppIds
			 , @RequestParam(value="memberAuthId", 			required=false) String memberAuthIds
			 , @RequestParam(value="modGubun", 					required=false) String modGubun
			 , @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO																//업무일지 기본정보
			 , @ModelAttribute("dailyWorkApprovalVO") DailyWorkApprovalVO dailyWorkApprovalVO								//결재
			 , @ModelAttribute("dailyWorkWriteAuthVO") DailyWorkWriteAuthVO dailyWorkWriteAuthVO					//작성권한
			 , @ModelAttribute("monitoringVO") MonitoringVO monitoringVO																//조류모니터링
			 , @ModelAttribute("dailyworkRainVO") DailyWorkRainVO dailyworkRainVO												//강우현황
			 , @RequestParam(value="tRiverDiv[]",					required=false) String[] tRiverDiv
			 , @RequestParam(value="tFactCode[]",				required=false) String[] tFactCode
			 , @RequestParam(value="tRainFall[]",					required=false) String[] tRainFall
			 , @RequestParam(value="aRiverDiv[]",					required=false) String[] aRiverDiv
			 , @RequestParam(value="aFactCode[]",				required=false) String[] aFactCode
			 , @RequestParam(value="aForecastDay[]",			required=false) String[] aForecastDay
			 , @RequestParam(value="aForecastStatus[]",		required=false) String[] aForecastStatus
			 , @RequestParam(value="aForecastCon[]",			required=false) String[] aForecastCon
			 , @RequestParam(value="aForecastTidal[]",			required=false) String[] aForecastTidal
			 , @RequestParam(value="aForecastAuto[]",			required=false) String[] aForecastAuto
			 , @RequestParam(value="modifyGubun",				required=false) String modifyGubun
			)throws Exception{
		try{
			
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			String userId = user.getId();
			dailyWorkVO.setRegId(userId);																								//수정자
			dailyWorkVO.setModId(userId);																								//수정자
			
			int resultOk = 0; 
			
			/** 업무일지정보 저장 */
			String msg = "";
			try{
				
				dailyWorkService.updateDailyWorkInfo(dailyWorkVO);
				resultOk++;
				
			}catch(Exception e){
				resultOk = 0;
			}
			
			if(resultOk  > 0) {
				//수정이력 저장
				dailyWorkService.insertDailyWorkHisInfo(dailyWorkVO);
				
				/** 결재 정보 저장 */
				dailyWorkApprovalVO.setDailyWorkId(dailyWorkVO.getDailyWorkId());
				
				//변경 된 결재자가 있을경우에만 삭제 후 저장
				if(!StringUtil.isEmpty(memberAppIds)) {
					dailyWorkService.deleteDailyWorkApprovalInfo(dailyWorkApprovalVO);											//결재정보 삭제 후 저장
					
					String[] memberAppId = memberAppIds.split(",");		
					
					int seq = 0;
					for(int i=0; i<memberAppId.length; i++){
						if(i==0){
							
						}
						seq = dailyWorkService.getDailyWorkApprovalSeq(dailyWorkVO.getDailyWorkId());						//seq 
						
						dailyWorkApprovalVO.setSeq(seq);
						dailyWorkApprovalVO.setApprovalMemberId(memberAppId[i]);
						dailyWorkService.insertDailyWorkApprovalInfo(dailyWorkApprovalVO);		
					}
				}
				/** 작성권한 정보 */
				dailyWorkWriteAuthVO.setDailyWorkId(dailyWorkVO.getDailyWorkId());
				
				//변경 된 작성권한 있을경우에만 삭제 후 저장
				if(!StringUtil.isEmpty(memberAuthIds)) {
					dailyWorkService.deleteDailyWorkAuthInfo(dailyWorkWriteAuthVO);												//작성권한 정보 삭제 후 저장
					
					String[] memberAuthId = memberAuthIds.split(",");		
					
					int seq = 0;
					for(int i=0; i<memberAuthId.length; i++){
						if(i==0){
							
						}
						seq = dailyWorkService.getDailyWorkWriteAuthSeq(dailyWorkVO.getDailyWorkId());						//seq 
						
						dailyWorkWriteAuthVO.setSeq(seq);
						dailyWorkWriteAuthVO.setWriteAuthId(memberAuthId[i]);
						dailyWorkService.insertDailyWriteAuthInfo(dailyWorkWriteAuthVO);			
					}
				}
				String dailyWorkId = dailyWorkVO.getDailyWorkId();
				
				monitoringVO.setDailyWorkId(dailyWorkId);
				
				/** 조류모니터링일지 기본정보 */
				String atchFileId = monitoringVO.getAtchFileId();
				
				//첨부파일
				final Map<String, MultipartFile> files = multiRequest.getFileMap();
				
				if(files !=null){
					if (!files.isEmpty()) {
						if ("".equals(atchFileId) || atchFileId==null) {
							List<FileVO> result = fileUtil.parseFileInf(files, "DAILY_WORK_", 0, atchFileId, "");
							atchFileId = fileMngService.insertFileInfs(result);
							monitoringVO.setAtchFileId(atchFileId);
						}else {
							FileVO fvo = new FileVO();
							fvo.setAtchFileId(atchFileId);
							int cnt = fileMngService.getMaxFileSN(fvo);
							List<FileVO> _result = fileUtil.parseFileInf(files, "DAILY_WORK_", cnt, atchFileId, "");
							fileMngService.updateFileInfs(_result);
						}
					}
				}
				
				monitoringService.updateMonitoringInfo(monitoringVO);
				
				/** 수질예측정보*/
				//수질예측정보 삭제 후 저장
				int delforecastResult = monitoringService.deleteForecastInfo(dailyWorkId);
				
				if(delforecastResult > 0){
					for(int i=0; i<aRiverDiv.length; i++){
						monitoringVO.setRiverDiv(aRiverDiv[i] == null ? "" : aRiverDiv[i]);
						monitoringVO.setFactCode(aFactCode[i] == null ? "" : aFactCode[i]);
						monitoringVO.setForecastDay(aForecastDay[i] == null ? "" : aForecastDay[i]);
						monitoringVO.setForecastStatus(aForecastStatus[i] == null ? "" : aForecastStatus[i]);
						monitoringVO.setForecastCon(aForecastCon[i] == null ? "" : aForecastCon[i]);
						monitoringVO.setForecastTidal(aForecastTidal[i] == null ? "" : aForecastTidal[i]);
						monitoringVO.setForecastAuto(aForecastAuto[i] == null ? "" : aForecastAuto[i]);
						
						monitoringService.insertForecastInfo(monitoringVO);
					}
				}
				
				/**
				 * 강우현황 저장
				 */
				dailyworkRainVO.setDailyWorkId(dailyWorkVO.getDailyWorkId());
				
				//강우현황 정보 삭제 후 저장
				int delRainResult = dailyWorkService.deleteDailyWorkRainInfo(dailyWorkVO.getDailyWorkId());
				
				if(delRainResult > 0){
					for(int i=0; i<tRiverDiv.length; i++){
						dailyworkRainVO.setRiverDiv(tRiverDiv[i] == null ? "" : tRiverDiv[i]);
						dailyworkRainVO.setFactCode(tFactCode[i] == null ? "" : tFactCode[i]);
						dailyworkRainVO.setRainFall(tRainFall[i] == null ? "" : tRainFall[i]);
						
						dailyWorkService.insertDailyWorkRainInfo(dailyworkRainVO);
					}
				}
				
				//결재상신
				if(modGubun.equals("app")){
					dailyWorkVO.setApprovalId(userId);
					dailyWorkVO.setState("B"); 																										//저장:S 결재대기:B 결재진행:A 결재반려:R 결재완료: F 삭제:D
					int stateResult = dailyWorkService.updateDailyWorkStateInfo(dailyWorkVO);
					
					dailyWorkApprovalVO.setSeq(1);
					String approvalMemberId = dailyWorkService.getApprovalMemberId(dailyWorkApprovalVO); 					//결재자 정보 조회
					
					if(stateResult>0){
						//알람등록
						AlrimVO alrimVO = new AlrimVO();
						alrimVO.setAlrimGubun("D");			
				    	alrimVO.setAlrimTitle(dailyWorkVO.getWorkDay()+" 조류모니터링 결재");			
				    	alrimVO.setAlrimLink("/dailywork/receiveApprovalList.do");			
				    	alrimVO.setAlrimMenuId(33200);			
				    	alrimVO.setAlrimWriterId(userId);			
				    	alrimVO.setAlrimApprovalId(approvalMemberId);
						
				    	alrimService.insertAlrim(alrimVO);
				    	
				    	dailyWorkApprovalVO.setApprovalRequestId(userId);																	//결재요청자
						dailyWorkService.updateApprovalRequestInfo(dailyWorkApprovalVO);												//결재요청일 정보 
						
						msg = "결재가 정상적으로 등록되었습니다.";
					}else{
						msg = "ERROR";
					}
				}else{
					msg = "조류모니터링일지가 정상적으로 수정되었습니다.";
				}
				
				res.setContentType("text/html; charset=UTF-8");
				
				if(modifyGubun.equals("m")){
					res.getWriter().print("<script>alert('"+msg+"');document.location.href='/dailywork/dailyWorkList.do?gubun=M'</script>");
				}else{
					res.getWriter().print("<script>alert('"+msg+"');document.location.href='/dailywork/receiveApprovalList.do'</script>");
				}
				
			}else{ 
				res.setContentType("text/html; charset=UTF-8");
				if(modifyGubun.equals("m")){
					res.getWriter().print("<script>alert('ERROR');document.location.href='/dailywork/dailyWorkList.do?gubun=M'</script>");
				}else{
					res.getWriter().print("<script>alert('ERROR');document.location.href='/receiveApprovalList.do'</script>");
				}
				
			}
				
		}catch(Exception e){
			e.printStackTrace();
		}		
		return null;
	}
}