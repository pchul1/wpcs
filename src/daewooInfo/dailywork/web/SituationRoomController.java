package daewooInfo.dailywork.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.ui.ModelMap;

import daewooInfo.common.alrim.bean.AlrimVO;
import daewooInfo.common.alrim.service.AlrimService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.fcc.StringUtil;
import daewooInfo.common.TmsMessageSource;
import daewooInfo.dailywork.bean.DailyWorkApprovalVO;
import daewooInfo.dailywork.bean.DailyWorkRainVO;
import daewooInfo.dailywork.bean.DailyWorkVO;
import daewooInfo.dailywork.bean.DailyWorkWriteAuthVO;
import daewooInfo.dailywork.bean.SituationRoomVO;
import daewooInfo.dailywork.service.DailyWorkService;
import daewooInfo.dailywork.service.SituationRoomService;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.fdl.property.EgovPropertyService;


/**
 * 
 * 상황실 근무일지 관리
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
public class SituationRoomController {

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
	 * @uml.property  name="propertyService"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	/**
	 * @uml.property  name="idgenDailyWorkService"
	 */
    @Resource(name = "dailyWorkIdGnrService")
    private EgovIdGnrService idgenDailyWorkService;
    
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
	 * log
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
    Log log = LogFactory.getLog(DailyWorkController.class);
	
	/**
	 * 상황실근무일지 결재자, 작성권한 선택
	 * 2014.09.19
	 * yrkim
	 */
	@RequestMapping("/dailywork/situationRoomRegist.do")
	public String situationRoomRegist(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "dailywork/situationRoomRegist";
	}
	
	/**
	 * 상황실 근무일지 상세등록
	 * 2014.09.22
	 * yrkim
	 */
	@RequestMapping("/dailywork/situationRoomRegDetail.do")
	public ModelAndView situationRoomRegDetail(
			 Map<String, Object> commandMap
			,@RequestParam(value="memberAppId", required=false) String memberAppId
			,@RequestParam(value="memberAuthId", required=false) String memberAuthId
			,@RequestParam(value="workDay", required=false) String workDay
			, ModelMap model
			) throws Exception {
		
		String[] memberId = memberAppId.split(",");
//		System.out.println("memberid length >>>> " + memberId.length);
		String approvalName1 = dailyWorkService.approvalNameSelect(memberId[0]);		//결재자1
		String approvalName2 = "";
		if(memberId.length > 1) {
			approvalName2 = dailyWorkService.approvalNameSelect(memberId[1]);		//결재자2
		}
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("memberAppId", memberAppId);
		modelAndView.addObject("memberAuthId", memberAuthId);
		modelAndView.addObject("approvalName1", approvalName1);
		modelAndView.addObject("approvalName2", approvalName2);
		modelAndView.addObject("workDay", workDay);
		
		modelAndView.setViewName("dailywork/situationRoomRegDetail");
		
		return modelAndView;
	}
	
	/**
	 * 상황실 근무일지 등록
	 * 2014.09.24
	 */
	@RequestMapping("/dailywork/situationRoomRegProc.do")
	public ModelAndView situationRoomRegProc(
			  HttpServletRequest req
			, HttpServletResponse res
			, @RequestParam(value="workDay",		 				required=false) String workDay
			, @RequestParam(value="memberAppId",				required=false) String memberAppIds
			, @RequestParam(value="memberAuthId",				required=false) String memberAuthIds
			, @RequestParam(value="sGubun[]",					required=false) String[] sGubun
			, @RequestParam(value="sHour[]",						required=false) String[] sHour
			, @RequestParam(value="sMin[]",						required=false) String[] sMin
			, @RequestParam(value="sTargetMe[]",				required=false) String[] sTargetMe
			, @RequestParam(value="sTargetGov[]",				required=false) String[] sTargetGov
			, @RequestParam(value="sTargetKeco[]",				required=false) String[] sTargetKeco
			, @RequestParam(value="sTargetArea[]",				required=false) String[] sTargetArea
			, @RequestParam(value="sTargetAreaDetail[]",		required=false) String[] sTargetAreaDetail
			, @RequestParam(value="sTargetSigongsa[]",		required=false) String[] sTargetSigongsa
			, @RequestParam(value="sTargetEtc[]",				required=false) String[] sTargetEtc
			, @RequestParam(value="sContent[]",					required=false) String[] sContent
			, @RequestParam(value="gGubun[]",					required=false) String[] gGubun
			, @RequestParam(value="gHour[]",						required=false) String[] gHour
			, @RequestParam(value="gMin[]",						required=false) String[] gMin
			, @RequestParam(value="gTargetMe[]",				required=false) String[] gTargetMe
			, @RequestParam(value="gTargetGov[]",				required=false) String[] gTargetGov
			, @RequestParam(value="gTargetKeco[]",				required=false) String[] gTargetKeco
			, @RequestParam(value="gTargetArea[]",				required=false) String[] gTargetArea
			, @RequestParam(value="gTargetAreaDetail[]",		required=false) String[] gTargetAreaDetail
			, @RequestParam(value="gTargetSigongsa[]",		required=false) String[] gTargetSigongsa
			, @RequestParam(value="gTargetEtc[]",				required=false) String[] gTargetEtc
			, @RequestParam(value="gContent[]",					required=false) String[] gContent
			, @RequestParam(value="tRiverDiv[]",					required=false) String[] tRiverDiv
			, @RequestParam(value="tFactCode[]",				required=false) String[] tFactCode
			, @RequestParam(value="tRainFall[]",					required=false) String[] tRainFall
			, @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO															//업무일지 기본정보
			, @ModelAttribute("dailyWorkApprovalVO") DailyWorkApprovalVO dailyWorkApprovalVO						//결재
			, @ModelAttribute("dailyWorkWriteAuthVO") DailyWorkWriteAuthVO dailyWorkWriteAuthVO					//작성권한
			, @ModelAttribute("situationRoomVO") SituationRoomVO situationRoomVO										//상황전파현황
			, @ModelAttribute("dailyworkRainVO") DailyWorkRainVO dailyworkRainVO											//강우현황
			)throws Exception{
		
		try{
			
			dailyWorkVO.setGubun("S");
			dailyWorkVO.setWorkDay(workDay);
			
			int resultCnt =  dailyWorkService.selectDailyWorkInfo(dailyWorkVO);
			
			if (resultCnt > 0 ) {
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('입력하신 일자에 해당하는 상황실근무일지가 존재합니다.');history.back();</script>");
			}else{
				
				LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
				String userId = user.getId();
				dailyWorkVO.setRegId(userId);																		//작성자
				
				String dailyWorkId = idgenDailyWorkService.getNextStringId();								//업무일지ID
				
				dailyWorkVO.setGubun("S");																			//상황실근무일지:S, 4대강주요수계일지:R, 조류모니터링:M
				
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
					
					/** 상황실 근무일지 */
					situationRoomVO.setDailyWorkId(dailyWorkId);
					
					situationRoomService.insertSituationRoomInfo(situationRoomVO);
					
					/** 상황전파 현황 */
					int len =0;
					String hour = "";
					String min = "";
					
					//사고전파
					len = sGubun == null ? 0 : sGubun.length;
			
					for(int i=0; i<len; i++){
						hour = sHour[i] == null ? "" : sHour[i].length() == 1 ? "0"+sHour[i] : sHour[i];
						min = sMin[i] == null ? "" : sMin[i].length() == 1 ? "0"+sMin[i] : sMin[i];
						
						if(!hour.equals("")){
							situationRoomVO.setSpreadGubun(sGubun[i] == null ? "" : sGubun[i]);
							situationRoomVO.setTime(hour+min);
							situationRoomVO.setTargetMe(sTargetMe[i] == null ? "" : sTargetMe[i]);
							situationRoomVO.setTargetGov(sTargetGov[i] == null ? "" : sTargetGov[i]);
							situationRoomVO.setTargetKeco(sTargetKeco[i] == null ? "" : sTargetKeco[i]);
							situationRoomVO.setTargetArea(sTargetArea[i] == null ? "" : sTargetArea[i]);
							situationRoomVO.setTargetAreaDetail(sTargetAreaDetail[i] == null ? "" : sTargetAreaDetail[i]);
							situationRoomVO.setTargetSigongsa(sTargetSigongsa[i] == null ? "" : sTargetSigongsa[i]);
							situationRoomVO.setTargetEtc(sTargetEtc[i] == null ? "" : sTargetEtc[i]);
							situationRoomVO.setContent(sContent[i] == null ? "" : sContent[i]);
							
							situationRoomService.insertSituationSpreadInfo(situationRoomVO);
						}
					}
					
					//기상특보
					len = gGubun == null ? 0 : gGubun.length;
					
					for(int i=0; i<len; i++){
						hour = gHour[i] == null ? "" : gHour[i].length() == 1 ? "0"+gHour[i] : gHour[i];
						min = gMin[i] == null ? "" : gMin[i].length() == 1 ? "0"+gMin[i] : gMin[i];
						
						if(!hour.equals("")){
							situationRoomVO.setSpreadGubun(gGubun[i] == null ? "" : gGubun[i]);
							situationRoomVO.setTime(hour+min);
							situationRoomVO.setTargetMe(gTargetMe[i] == null ? "" : gTargetMe[i]);
							situationRoomVO.setTargetGov(gTargetGov[i] == null ? "" : gTargetGov[i]);
							situationRoomVO.setTargetKeco(gTargetKeco[i] == null ? "" : gTargetKeco[i]);
							situationRoomVO.setTargetArea(gTargetArea[i] == null ? "" : gTargetArea[i]);
							situationRoomVO.setTargetAreaDetail(gTargetAreaDetail[i] == null ? "" : gTargetAreaDetail[i]);
							situationRoomVO.setTargetSigongsa(gTargetSigongsa[i] == null ? "" : gTargetSigongsa[i]);
							situationRoomVO.setTargetEtc(gTargetEtc[i] == null ? "" : gTargetEtc[i]);
							situationRoomVO.setContent(gContent[i] == null ? "" : gContent[i]);
							
							situationRoomService.insertSituationSpreadInfo(situationRoomVO);
						}
						
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
					res.getWriter().print("<script>alert('상황실근무일지가 정상적으로 등록되었습니다.');document.location.href='/dailywork/dailyWorkList.do?gubun=S'</script>");
				} else{ 
					res.setContentType("text/html; charset=UTF-8");
					res.getWriter().print("<script>alert('ERROR');document.location.href='/dailywork/dailyWorkList.do?gubun=S'</script>");
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}		
		return null;
	}
	
	/**
	 * 상황실 근무일지 상세조회
	 */
	@RequestMapping("/dailywork/situationRoomDetail.do")
	public ModelAndView situationRoomDetail(
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
			
			modelAndView.setViewName("dailywork/situationRoomDetail");
			
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
					res.getWriter().print("<script>alert('작성권한이 없습니다.');document.location.href='/dailywork/dailyWorkList.do?gubun=S'</script>");
					
					return null;
					
				}else{
					return modelAndView;
				}
			}else{
				return modelAndView;
			}
			
	}
	
	/**
	 * 상황실 근무일지 수정화면
	 */
	@RequestMapping("/dailywork/situationRoomModify.do")	
	public String situationRoomModify(
			Map<String, Object> commandMap
			, @RequestParam(value="dailyWorkId", required=false) String dailyWorkId
			, @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO
			, @ModelAttribute("situationRoomVO") SituationRoomVO situationRoomVO
			, @ModelAttribute("dailyWorkRainVO") DailyWorkRainVO dailyWorkRainVO
			, @RequestParam(value="modifyGubun", 		required=false) String modifyGubun
			, ModelMap model
			) throws Exception {
		
		dailyWorkVO = dailyWorkService.selectDailyWorkMasterInfo(dailyWorkId);													//업무일지 기본정보
		List<DailyWorkApprovalVO> approvalList= dailyWorkService.selectDailyWorkApprovalList(dailyWorkId);				//업무일지 결재정보
		situationRoomVO = situationRoomService.selectSituationRoomInfo(dailyWorkId);											//상황실 근무일지 근무상황정보

		situationRoomVO.setDailyWorkId(dailyWorkId);
		
		situationRoomVO.setSpreadGubun("S");
		List<SituationRoomVO> spreadSList = situationRoomService.selectSituationSpreadInfo(situationRoomVO);		//업무일지 상황전파 현황
		
		situationRoomVO.setSpreadGubun("G");
		List<SituationRoomVO> spreadGList = situationRoomService.selectSituationSpreadInfo(situationRoomVO);		//업무일지 상황전파 현황
		
		List<DailyWorkRainVO> rainFallList = dailyWorkService.selectDailyWorkRainInfo(dailyWorkRainVO);					//업무일지 강우현황
		
		model.addAttribute("dailyWorkVO", dailyWorkVO);
		model.addAttribute("approvalList", approvalList);
		model.addAttribute("situationRoomVO", situationRoomVO);
		model.addAttribute("spreadSList", spreadSList);
		model.addAttribute("spreadGList", spreadGList);
		model.addAttribute("rainFallList", rainFallList);
		
		model.addAttribute("modifyGubun", modifyGubun);
		
		return "/dailywork/situationRoomModify";
	
	}
	
	/**
	 * 상황실 근무일지 수정
	 * 2014.09.24
	 */
	@RequestMapping("/dailywork/situationRoomModProc.do")
	public ModelAndView situationRoomModProc(
			  HttpServletRequest req
			, HttpServletResponse res
			, @RequestParam(value="approvalMember1", 				required=false) String approvalMember1
			, @RequestParam(value="approvalMember2", 				required=false) String approvalMember2
			, @RequestParam(value="memberAppId", 				required=false) String memberAppIds
			, @RequestParam(value="memberAuthId", 			required=false) String memberAuthIds
			, @RequestParam(value="modGubun", 					required=false) String modGubun
			, @RequestParam(value="sGubun[]",					required=false) String[] sGubun
			, @RequestParam(value="sHour[]",						required=false) String[] sHour
			, @RequestParam(value="sMin[]",						required=false) String[] sMin
			, @RequestParam(value="sTargetMe[]",				required=false) String[] sTargetMe
			, @RequestParam(value="sTargetGov[]",				required=false) String[] sTargetGov
			, @RequestParam(value="sTargetKeco[]",				required=false) String[] sTargetKeco
			, @RequestParam(value="sTargetArea[]",				required=false) String[] sTargetArea
			, @RequestParam(value="sTargetAreaDetail[]",		required=false) String[] sTargetAreaDetail
			, @RequestParam(value="sTargetSigongsa[]",		required=false) String[] sTargetSigongsa
			, @RequestParam(value="sTargetEtc[]",				required=false) String[] sTargetEtc
			, @RequestParam(value="sContent[]",					required=false) String[] sContent
			, @RequestParam(value="gGubun[]",					required=false) String[] gGubun
			, @RequestParam(value="gHour[]",						required=false) String[] gHour
			, @RequestParam(value="gMin[]",						required=false) String[] gMin
			, @RequestParam(value="gTargetMe[]",				required=false) String[] gTargetMe
			, @RequestParam(value="gTargetGov[]",				required=false) String[] gTargetGov
			, @RequestParam(value="gTargetKeco[]",				required=false) String[] gTargetKeco
			, @RequestParam(value="gTargetArea[]",				required=false) String[] gTargetArea
			, @RequestParam(value="gTargetAreaDetail[]",		required=false) String[] gTargetAreaDetail
			, @RequestParam(value="gTargetSigongsa[]",		required=false) String[] gTargetSigongsa
			, @RequestParam(value="gTargetEtc[]",				required=false) String[] gTargetEtc
			, @RequestParam(value="gContent[]",					required=false) String[] gContent
			, @RequestParam(value="tRiverDiv[]",					required=false) String[] tRiverDiv
			, @RequestParam(value="tFactCode[]",				required=false) String[] tFactCode
			, @RequestParam(value="tRainFall[]",					required=false) String[] tRainFall
			, @RequestParam(value="modifyGubun",				required=false) String modifyGubun
			, @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO															//업무일지 기본정보
			, @ModelAttribute("dailyWorkApprovalVO") DailyWorkApprovalVO dailyWorkApprovalVO						//결재
			, @ModelAttribute("dailyWorkWriteAuthVO") DailyWorkWriteAuthVO dailyWorkWriteAuthVO					//작성권한
			, @ModelAttribute("situationRoomVO") SituationRoomVO situationRoomVO										//상황전파현황
			, @ModelAttribute("dailyworkRainVO") DailyWorkRainVO dailyworkRainVO											//강우현황
			)throws Exception{
		
		try{
			
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			String userId = user.getId();
			dailyWorkVO.setModId(userId);																		//수정자
			
			int resultOk = 0; 
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
				
				/** 상황실 근무일지 */
				situationRoomVO.setDailyWorkId(dailyWorkVO.getDailyWorkId());
				
				situationRoomService.updateSituationRoomInfo(situationRoomVO);
				
				/** 상황전파 현황 */
				int len = 0;
				
				String hour = "";
				String min = "";
				
				len = sGubun == null ? 0 : sGubun.length;
				
				//상황전파 현황 삭제 후 저장
				int delResult = situationRoomService.deleteSituationSpreadInfo(dailyWorkVO.getDailyWorkId());
				
				if(delResult > 0){
					for(int i=0; i<len; i++){
						
						hour = sHour[i] == null ? "" : sHour[i].length() == 1 ? "0"+sHour[i] : sHour[i];
						min = sMin[i] == null ? "" : sMin[i].length() == 1 ? "0"+sMin[i] : sMin[i];
						
						if(!hour.equals("")){
							situationRoomVO.setSpreadGubun(sGubun[i] == null ? "" : sGubun[i]);
							situationRoomVO.setTime(hour+min);
							situationRoomVO.setTargetMe(sTargetMe[i] == null ? "" : sTargetMe[i]);
							situationRoomVO.setTargetGov(sTargetGov[i] == null ? "" : sTargetGov[i]);
							situationRoomVO.setTargetKeco(sTargetKeco[i] == null ? "" : sTargetKeco[i]);
							situationRoomVO.setTargetArea(sTargetArea[i] == null ? "" : sTargetArea[i]);
							situationRoomVO.setTargetAreaDetail(sTargetAreaDetail[i] == null ? "" : sTargetAreaDetail[i]);
							situationRoomVO.setTargetSigongsa(sTargetSigongsa[i] == null ? "" : sTargetSigongsa[i]);
							situationRoomVO.setTargetEtc(sTargetEtc[i] == null ? "" : sTargetEtc[i]);
							situationRoomVO.setContent(sContent[i] == null ? "" : sContent[i]);
							
							situationRoomService.insertSituationSpreadInfo(situationRoomVO);
						}
						
					}
					
					len = gGubun == null ? 0 : gGubun.length;
					
					for(int i=0; i<len; i++){
						hour = gHour[i] == null ? "" : gHour[i].length() == 1 ? "0"+gHour[i] : gHour[i];
						min = gMin[i] == null ? "" : gMin[i].length() == 1 ? "0"+gMin[i] : gMin[i];
						
						if(!hour.equals("")){
							situationRoomVO.setSpreadGubun(gGubun[i] == null ? "" : gGubun[i]);
							situationRoomVO.setTime(hour+min);
							situationRoomVO.setTargetMe(gTargetMe[i] == null ? "" : gTargetMe[i]);
							situationRoomVO.setTargetGov(gTargetGov[i] == null ? "" : gTargetGov[i]);
							situationRoomVO.setTargetKeco(gTargetKeco[i] == null ? "" : gTargetKeco[i]);
							situationRoomVO.setTargetArea(gTargetArea[i] == null ? "" : gTargetArea[i]);
							situationRoomVO.setTargetAreaDetail(gTargetAreaDetail[i] == null ? "" : gTargetAreaDetail[i]);
							situationRoomVO.setTargetSigongsa(gTargetSigongsa[i] == null ? "" : gTargetSigongsa[i]);
							situationRoomVO.setTargetEtc(gTargetEtc[i] == null ? "" : gTargetEtc[i]);
							situationRoomVO.setContent(gContent[i] == null ? "" : gContent[i]);
							
							situationRoomService.insertSituationSpreadInfo(situationRoomVO);
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
					    	alrimVO.setAlrimTitle(dailyWorkVO.getWorkDay()+" 상황실근무일지 결재");			
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
					msg = "상황실근무일지가 정상적으로 수정되었습니다.";
				}
				
				res.setContentType("text/html; charset=UTF-8");
				if(modifyGubun.equals("m")){
					res.getWriter().print("<script>alert('"+msg+"');document.location.href='/dailywork/dailyWorkList.do?gubun=S'</script>");
				}else{
					res.getWriter().print("<script>alert('"+msg+"');document.location.href='/dailywork/receiveApprovalList.do'</script>");
				}
				
			} else{ 
				if(modifyGubun.equals("m")){
					res.getWriter().print("<script>alert('ERROR');document.location.href='/dailywork/dailyWorkList.do?gubun=S'</script>");
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