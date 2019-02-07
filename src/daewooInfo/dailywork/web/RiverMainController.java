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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.ui.ModelMap;

import daewooInfo.common.TmsMessageSource;
import daewooInfo.common.alrim.bean.AlrimVO;
import daewooInfo.common.alrim.service.AlrimService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.fcc.StringUtil;
import daewooInfo.dailywork.bean.DailyWorkApprovalVO;
import daewooInfo.dailywork.bean.DailyWorkVO;
import daewooInfo.dailywork.bean.DailyWorkWriteAuthVO;
import daewooInfo.dailywork.bean.RiverMainVO;
import daewooInfo.dailywork.service.DailyWorkService;
import daewooInfo.dailywork.service.RiverMainService;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;


/**
 * 
 * 4대강 주요수계일지 관리
 * @author yrkim
 * @since 2014.10.08
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
public class RiverMainController {
	/**
	 * @uml.property  name="dailyWorkService"
	 */
	@Resource(name = "DailyWorkService")
    private DailyWorkService dailyWorkService;
	
	/**
	 * @uml.property  name="riverMainService"
	 */
	@Resource(name = "RiverMainService")
    private RiverMainService riverMainService;
	
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
	 * 4대강 주요수계일지 결재자 선택
	 * 2014.10.08
	 * yrkim
	 */
	@RequestMapping("/dailywork/riverMainRegist.do")
	public String situationRoomRegist(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "dailywork/riverMainRegist";
	}
	
	/**
	 * 4대강 주요수계일지 상세등록
	 * 2014.10.08
	 * yrkim
	 */
	@RequestMapping("/dailywork/riverMainRegDetail.do")
	public ModelAndView riverMainRegDetail(
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
		
		modelAndView.setViewName("dailywork/riverMainRegDetail");
		
		return modelAndView;
	}
	
	/**
	 * 4대강 주요수계일지 등록
	 * 2014.10.10
	 * yrkim
	 */
	@RequestMapping("/dailywork/riverMainRegProc.do")
	public ModelAndView riverMainRegProc(
			   HttpServletResponse res
			 , @RequestParam(value="memberAppId",				required=false) String memberAppIds
			 , @RequestParam(value="memberAuthId",				required=false) String memberAuthIds
			 , @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO															//업무일지 기본정보
			 , @ModelAttribute("dailyWorkApprovalVO") DailyWorkApprovalVO dailyWorkApprovalVO							//결재
			 , @ModelAttribute("dailyWorkWriteAuthVO") DailyWorkWriteAuthVO dailyWorkWriteAuthVO					//작성권한
			 , @ModelAttribute("riverMainVO") RiverMainVO riverMainVO																//4대강 주요수계일지
			)throws Exception{
		try{
			
			dailyWorkVO.setGubun("R");																										//상황실근무일지:S, 4대강주요수계일지:R, 조류모니터링:M
			
			int resultCnt =  dailyWorkService.selectDailyWorkInfo(dailyWorkVO);
			
			if (resultCnt > 0 ) {
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('입력하신 일자에 해당하는 4대강주요수계일지가 존재합니다.');history.back();</script>");
			}else{
				LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
				String userId = user.getId();
				dailyWorkVO.setRegId(userId);																		//작성자
				
				String dailyWorkId = idgenDailyWorkService.getNextStringId();								//업무일지ID
				
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
					
					
					/** 상시감시 주요결과*/
					riverMainVO.setDailyWorkId(dailyWorkId);
					riverMainService.insertRiverMainInfo(riverMainVO);
					
					res.setContentType("text/html; charset=UTF-8");
					res.getWriter().print("<script>alert('4대강주요수계일지가 정상적으로 등록되었습니다.');document.location.href='/dailywork/dailyWorkList.do?gubun=R'</script>");
				}else{ 
					res.setContentType("text/html; charset=UTF-8");
					res.getWriter().print("<script>alert('ERROR');document.location.href='/dailywork/dailyWorkList.do?gubun=R'</script>");
				}
				
			}
		}catch(Exception e){
			e.printStackTrace();
		}		
		return null;
	}
	
	/**
	 * 4대강주요수계일지 상세조회
	 */
	@RequestMapping("/dailywork/riverMainDetail.do")
	public ModelAndView riverMainDetail(
			  HttpServletResponse res
			, Map<String, Object> commandMap
			, @RequestParam(value="dailyWorkId", 		required=false) String dailyWorkId
			, @RequestParam(value="regId", 				required=false) String regId
			, @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO
			, @ModelAttribute("riverMainVO") RiverMainVO riverMainVO
			, @ModelAttribute("dailyWorkWriteAuthVO") DailyWorkWriteAuthVO dailyWorkWriteAuthVO
			, ModelAndView modelAndView
			) throws Exception {
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		String userId = user.getId();
		
		dailyWorkVO = dailyWorkService.selectDailyWorkMasterInfo(dailyWorkId);												//업무일지 기본정보
		List<DailyWorkApprovalVO> approvalList= dailyWorkService.selectDailyWorkApprovalList(dailyWorkId);				//업무일지 결재정보
		riverMainVO = riverMainService.selectRiverMainInfo(dailyWorkId);															//4대강주요수계일지정보
		
		modelAndView.addObject("dailyWorkVO", dailyWorkVO);
		modelAndView.addObject("approvalList", approvalList);
		modelAndView.addObject("riverMainVO", riverMainVO);
		modelAndView.addObject("menuGubun", "dailyWork");
		modelAndView.addObject("userId", userId);
		
		modelAndView.setViewName("dailywork/riverMainDetail");
		

		if(!regId.equals(userId)){
			
			dailyWorkWriteAuthVO.setDailyWorkId(dailyWorkId);
			dailyWorkWriteAuthVO.setWriteAuthId(userId);
			
			int cnt = dailyWorkService.getDailyWorkWriteAuthId(dailyWorkWriteAuthVO);		
			
			if(cnt == 0){
 				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('작성권한이 없습니다.');document.location.href='/dailywork/dailyWorkList.do?gubun=R'</script>");
				
				return null;
				
			}else{
				return modelAndView;
			}
		}else{
			return modelAndView;
		}
		
	}
	
	/**
	 * 4대강주요수계일지 수정화면
	 */
	@RequestMapping("/dailywork/riverMainModify.do")	
	public String riverMainModify(
			Map<String, Object> commandMap
			, @RequestParam(value="dailyWorkId", required=false) String dailyWorkId
			, @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO
			, @ModelAttribute("riverMainVO") RiverMainVO riverMainVO
			, @RequestParam(value="modifyGubun", 		required=false) String modifyGubun
			, ModelMap model
			) throws Exception {
		
		dailyWorkVO = dailyWorkService.selectDailyWorkMasterInfo(dailyWorkId);													//업무일지 기본정보
		List<DailyWorkApprovalVO> approvalList= dailyWorkService.selectDailyWorkApprovalList(dailyWorkId);				//업무일지 결재정보
		riverMainVO = riverMainService.selectRiverMainInfo(dailyWorkId);																//4대강주요수계일지정보
		
		model.addAttribute("dailyWorkVO", dailyWorkVO);
		model.addAttribute("approvalList", approvalList);
		model.addAttribute("riverMainVO", riverMainVO);
		model.addAttribute("modifyGubun", modifyGubun);
		
		return "/dailywork/riverMainModify";
	}
	
	/**
	 * 4대강 주요수계일지 수정
	 * 2014.10.10
	 * yrkim
	 */
	@RequestMapping("/dailywork/riverMainModProc.do")
	public ModelAndView riverMainModProc(
			   HttpServletResponse res
			 , @RequestParam(value="memberAppId",				required=false) String memberAppIds
			 , @RequestParam(value="memberAuthId",				required=false) String memberAuthIds
			 , @RequestParam(value="modGubun", 					required=false) String modGubun
			 , @ModelAttribute("dailyWorkVO") DailyWorkVO dailyWorkVO															//업무일지 기본정보
			 , @ModelAttribute("dailyWorkApprovalVO") DailyWorkApprovalVO dailyWorkApprovalVO							//결재
			 , @ModelAttribute("dailyWorkWriteAuthVO") DailyWorkWriteAuthVO dailyWorkWriteAuthVO					//작성권한
			 , @ModelAttribute("riverMainVO") RiverMainVO riverMainVO																//4대강 주요수계일지
			 , @RequestParam(value="modifyGubun",				required=false) String modifyGubun
			)throws Exception{
		try{
			
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			String userId = user.getId();
			dailyWorkVO.setModId(userId);																									//수정자
			
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
				
				/** 상시감시 주요결과*/
				riverMainVO.setDailyWorkId(dailyWorkVO.getDailyWorkId());
				riverMainService.updateRiverMainInfo(riverMainVO);
				
				//결재상신
				if(modGubun.equals("app")){
					dailyWorkVO.setApprovalId(userId);
					dailyWorkVO.setState("B"); 																								//저장:S 결재대기:B 결재진행:A 결재반려:R 결재완료: F 삭제:D
					int stateResult = dailyWorkService.updateDailyWorkStateInfo(dailyWorkVO);
					
					dailyWorkApprovalVO.setSeq(1);
					String approvalMemberId = dailyWorkService.getApprovalMemberId(dailyWorkApprovalVO); 			//결재자 정보 조회
					
					if(stateResult>0){
						//알람등록
						AlrimVO alrimVO = new AlrimVO();
				    	alrimVO.setAlrimGubun("D");			
				    	alrimVO.setAlrimTitle(dailyWorkVO.getWorkDay()+" 4대강주요수계일지 결재");			
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
					msg = "4대강주요수계일지가 정상적으로 수정되었습니다.";
				}

				res.setContentType("text/html; charset=UTF-8");
				
				if(modifyGubun.equals("m")){
					res.getWriter().print("<script>alert('"+msg+"');document.location.href='/dailywork/dailyWorkList.do?gubun=R'</script>");
				}else{
					res.getWriter().print("<script>alert('"+msg+"');document.location.href='/dailywork/receiveApprovalList.do'</script>");
				}
			}else{ 
				res.setContentType("text/html; charset=UTF-8");
				
				if(modifyGubun.equals("m")){
					res.getWriter().print("<script>alert('ERROR');document.location.href='/dailywork/dailyWorkList.do?gubun=R'</script>");
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