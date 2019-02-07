package daewooInfo.alert.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.Servlet;
import javax.servlet.ServletContext;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.alert.bean.AlertConfigVO;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertTargetVO;
import daewooInfo.alert.service.AlertConfigService;
import daewooInfo.alert.service.AlertMakeService;
import daewooInfo.alert.service.AlertTargetService;
import daewooInfo.alert.util.SendSMS;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.EgovFileMngUtil;
import daewooInfo.common.util.fcc.DateUtil;
import daewooInfo.common.util.fcc.StringUtil;

/**
 * 사전조치통보를 위한 컨트롤러  클래스
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------       --------    ---------------------------
 *   2010.6.28  김태훈          최초 생성
 *
 * </pre>
 */
@Controller
public class AlertSmsSendController {
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log log = LogFactory.getLog(AlertSmsSendController.class);

	/**
	 * @uml.property  name="alertTargetService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertTargetService")
    private AlertTargetService alertTargetService;
	
	/**
	 * @uml.property  name="alertMakeService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertMakeService")
    private AlertMakeService alertMakeService;	
	
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	@RequestMapping("/alert/alertSmsSend.do")
	public ModelAndView alertSmsSend() throws Exception {
		//return "alert/alertSmsSend"; //return String
		
		ModelAndView modelAndView = new ModelAndView();	
		String regId = "";
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("atchFileId", "FILE_000000000000001");
		String fileSeq = alertMakeService.getAddressFileSeq(map);

        modelAndView.addObject("fileSeq", fileSeq);       
        modelAndView.setViewName("/alert/alertSmsSend");
        
		return modelAndView;
	}	
	
	@RequestMapping("/alert/popupAddressRegist.do")
	public ModelAndView popupAddressRegist(@RequestParam(value="atchFileId", required=false) String atchFileId) throws Exception {
		ModelAndView modelAndView = new ModelAndView();	
		modelAndView.setViewName("/alert/popupAddressRegist");
		
		return modelAndView;
	}	
	
	@RequestMapping("/alert/addressFileUpload.do")
	public ModelAndView addressFileUpload(
			@RequestParam(value="atchFileId", required=false) String atchFileId, 
			@RequestParam(value="fileSn", required=false) String fileSn, 
			MultipartHttpServletRequest multiRequest,
			HttpServletResponse response
			) throws Exception {
		try{
			int resultOk = 0; 
			
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			
			if(files !=null){
				if (!files.isEmpty()) {
					List<FileVO> result = fileUtil.parseWpStepFileInf(files, "FILE_000000000000001", Integer.parseInt(fileSn)+1, "", "");
					alertMakeService.insertAddressFileInfs(result);
				}
			}
			
			resultOk++;

			if(resultOk  > 0) {
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().print("<script>alert('저장되었습니다.'); window.opener.location.reload();window.close();</script>");
			} else{ 
				response.setContentType("text/html; charset=UTF-8");
				response.getWriter().print("<script>alert('Error'); window.opener.location.reload(); window.close(); </script>"); 
			} 
		}catch(Exception e){
			e.printStackTrace();
		}		
		return null;
	}	
		
	

    /**
     * 해당 공구와 측정소의 조직 목록을 가져온다.
     * 
     * @param factCode
     * @param branchNo
     * @return
     * @throws Exception
     */
    @RequestMapping("/alert/getGroupList.do")
	public ModelAndView getGroupList(
			@RequestParam(value="system", required=false) String system
			,@RequestParam(value="sugye", required=false) String sugye
			,@RequestParam(value="factCode", required=false) String factCode
			,@RequestParam(value="branchNo", required=false) String branchNo
	) throws Exception{
    	
    	HashMap<String, String> map = new HashMap<String, String>();

    	if(system == null || system.equals("null") || system.equals("all")) {
    		system = null;
    	}
    	if(sugye == null || sugye.equals("null") || sugye.equals("all")) {
    		sugye = null;
    	}
    	if(factCode == null || factCode.equals("null") || factCode.equals("all")) {
    		factCode = null;
    	}    	
    	if(branchNo == null || branchNo.equals("null") || branchNo.equals("all")) {
    		branchNo = null;    		
    	}
    	

    	
    	map.put("system", system);
    	map.put("sugye", sugye);
    	map.put("factCode", factCode);
    	map.put("branchNo", branchNo);
		
		List<HashMap<String, String>> groupList = alertTargetService.getGroupList(map);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("groupList", groupList);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
    
    
    /**
     * 해당 공구와 측정소의 조직 목록을 가져온다.
     * 
     * @param factCode
     * @param branchNo
     * @return
     * @throws Exception
     */
    @RequestMapping("/alert/getGroupAndMember.do")
	public ModelAndView getGroupList(
			@RequestParam(value="orderType", required=false) String orderType
			,@RequestParam(value="value", required=false) String value
			,@RequestParam(value="step", required=false) String step
			,@RequestParam(value="branchNo", required=false) String branchNo
			,@RequestParam(value="factCode", required=false) String factCode
			,@RequestParam(value="system", required=false) String system
			,@RequestParam(value="sugye", required=false) String sugye
	) throws Exception{
    	
    	
    	if("null".equals(branchNo) || "all".equals(branchNo))
    		branchNo = null;
    	if("null".equals(factCode) || "all".equals(factCode))
    		factCode = null;
    	if("null".equals(system) || "all".equals(system))
    		system = null;
    	if("null".equals(sugye) || "all".equals(sugye))
    		sugye = null;

    	AlertTargetVO alertTargetVO = new AlertTargetVO();
    	alertTargetVO.setOrderType(orderType);
    	alertTargetVO.setValue(value);
    	alertTargetVO.setFactCode(factCode);
    	if(branchNo != null)
    		alertTargetVO.setBranchNo(Integer.parseInt(branchNo));    	
    	alertTargetVO.setSystem(system);
    	alertTargetVO.setSugye(sugye);
		
    	
    	alertTargetVO.setStep(step);

		List<HashMap<String, String>> groupList = alertTargetService.getGroupAndMember(alertTargetVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("groupList", groupList);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
    
    
    /**
     * 해당 공구와 측정소의 조직 목록을 가져온다.
     * 
     * @param factCode
     * @param branchNo
     * @return
     * @throws Exception
     */
    @RequestMapping("/alert/getSmsGroupList.do")
	public ModelAndView getSmsGroupList() throws Exception{

		List<HashMap<String, String>> groupList = alertTargetService.getSmsGroupList();
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("groupList", groupList);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}    
    
    
    /**
     * 해당 공구와 측정소의 조직 목록을 가져온다.
     * 
     * @param factCode
     * @param branchNo
     * @return
     * @throws Exception
     */
    @RequestMapping("/alert/getSmsGroupListMobile.do")
	public ModelAndView getSmsGroupListMobile(
			@RequestParam(value="orderType", required=false) String orderType
			,@RequestParam(value="value", required=false) String value
			,@RequestParam(value="step", required=false) String step
			,@RequestParam(value="branchNo", required=false) String branchNo
			,@RequestParam(value="factCode", required=false) String factCode
			,@RequestParam(value="system", required=false) String system
			,@RequestParam(value="sugye", required=false) String sugye
		) throws Exception{

    	if("null".equals(branchNo) || "all".equals(branchNo))
    		branchNo = null;
    	if("null".equals(factCode) || "all".equals(factCode))
    		factCode = null;
    	if("null".equals(system) || "all".equals(system))
    		system = null;
    	if("null".equals(sugye) || "all".equals(sugye))
    		sugye = null;

    	AlertTargetVO alertTargetVO = new AlertTargetVO();
    	alertTargetVO.setOrderType(orderType);
    	alertTargetVO.setValue(value);
    	alertTargetVO.setFactCode(factCode);
    	if(branchNo != null)
    		alertTargetVO.setBranchNo(Integer.parseInt(branchNo));    	
    	alertTargetVO.setSystem(system);
    	alertTargetVO.setSugye(sugye);
		
    	
    	alertTargetVO.setStep(step);
    	
		List<HashMap<String, String>> groupList = alertTargetService.getSmsGroupListMobile(alertTargetVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("groupList", groupList);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}   
    
    /**
     * 해당 공구와 측정소의 조직 목록을 가져온다.
     * 
     * @param factCode
     * @param branchNo
     * @return
     * @throws Exception
     */
    @RequestMapping("/alert/getSmsMemberList.do")
	public ModelAndView getSmsMemberList(
			@RequestParam(value="orderType", required=false) String orderType
			,@RequestParam(value="value", required=false) String value
			) throws Exception{

    	AlertTargetVO alertTargetVO = new AlertTargetVO();
    	alertTargetVO.setValue(value);
		List<HashMap<String, String>> groupList = alertTargetService.getSmsMemberList(alertTargetVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("groupList", groupList);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}  
    
    /**
     * 사전 조치 통보 SMS를 전송한다
     * 
     * @param factCode
     * @param branchNo
     * @return
     * @throws Exception
     */
    @RequestMapping("/alert/sendSms.do")
	public ModelAndView sendSms(
			@RequestParam(value="system", required=false) String system
			,@RequestParam(value="sugye", required=false) String sugye
			,@RequestParam(value="factCode", required=false) String factCode
			,@RequestParam(value="branchNo", required=false) String branchNo
			,@RequestParam(value="memberId", required=false) String member
			,@RequestParam(value="smsMsg", required=false) String smsMsg
			,@RequestParam(value="regId", required=false) String regId
			,@RequestParam(value="actKind", required=false) String actKind
			,@RequestParam(value="phoneNo", required=false) String phoneNo
			,HttpServletRequest request	
	) throws Exception{
    	
    	String subject = "사전 조치 통보";
    	String minTime = StringUtil.getTimeStamp();

    	String[] memberId = null;
    	if(!"".equals(member)) memberId = member.split(",");
    	
    	if(system == null || system.equals("null") || system.equals("all")) 
    		system = "0";
    	
    	if(sugye == null || sugye.equals("null") || sugye.equals("all")) 
    		sugye = "all";
    	
    	if(factCode == null || factCode.equals("null") || factCode.equals("all")) {
    		factCode = "all";
    	}    	
    	if(branchNo == null || branchNo.equals("null") || branchNo.equals("all")) {
    		branchNo = "0";    		
    	}
    	if(phoneNo == null || phoneNo.equals("null") || phoneNo.equals("")) {
    		phoneNo = "none";    		
    	}
    	
    	if(actKind == null || actKind.equals(""))
    		actKind = "C";
    	
    	int cnt = 0;
    	
    	try	{
    		cnt = SendSMS.sendManualSms(system, sugye, factCode, branchNo, memberId, minTime, smsMsg, subject, phoneNo);    	
    	}catch(Exception e){
    		log.debug(e.getMessage());
    		
    		e.printStackTrace();
    		
    		//System.out.println("================================");
    		//System.out.println(e.getMessage());
    		//System.out.println("================================");
    	}
    	
    	//if(cnt > 0) {
    		HashMap<String, String> map = new HashMap<String, String>();
    		map.put("smsMsg", smsMsg);
    		map.put("regId", regId);
    		map.put("factCode", factCode);
    		
    		if("all".equals(branchNo))
    			map.put("branchNo", "0");
    		else
    			map.put("branchNo", branchNo);
    		
    		map.put("riverDiv", sugye);
    		
    		map.put("actKind", actKind);
    		map.put("sysKind", system);
    		
    		alertMakeService.saveSmsMsgList(map);
    	//}
    	
    	/* 이전 메시지 조회용 등록 추가 Start*/
    	try{
    		HashMap<String, String> map2 = new HashMap<String, String>();
    		
    		map2.put("smsMsg", smsMsg);
    		map2.put("regId", regId);
    		map2.put("factCode", factCode);
    		
    		if("all".equals(branchNo))
    			map2.put("branchNo", "0");
    		else
    			map2.put("branchNo", branchNo);
    		
    		map2.put("riverDiv", sugye);
    		
    		map2.put("actKind", actKind);
    		map2.put("sysKind", system);
    		
    		String smsHistId = "";
    		
    		smsHistId = alertMakeService.saveSmsMsgHist(map2);
    		map2.put("smsHistId", smsHistId);
    		
        	if(smsHistId != null && !(smsHistId.equals(""))){        		
        		if(phoneNo.equals("none")){
        			for(int i=0 ; i < memberId.length ; i++ ){    		
        				map2.put("memberId", memberId[i]);
        				map2.put("phoneNo", "");
                		alertMakeService.saveSmsMsgHistDetail(map2);
                	}
        		}else{
        			map2.put("memberId", "");
        			map2.put("phoneNo", phoneNo);
        			alertMakeService.saveSmsMsgHistDetail(map2);        			
        		}
        	}        	
    	}catch (Exception e) {
    		log.debug(e.getMessage());
			e.printStackTrace();
			//System.out.println("================================");
    		//System.out.println(e.getMessage());
    		//System.out.println("================================");
		}    		
    	/* 이전 메시지 조회용 등록 추가 End*/    		
    	ModelAndView modelAndView = new ModelAndView();
    	
    	modelAndView.addObject("cnt", cnt);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
    
	/**
	 * 사용자가 발송했떤 SMS 메시지 이력을 가져온다
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/alertSmsMsg.do")
    public ModelAndView alertSmsMsg() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	
		String regId = "";
		
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(isAuthenticated) {
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			regId = user.getId();
		}

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("REG_ID", regId);
		List<HashMap> msgList = alertMakeService.getSendSmsMsgList(map);

        modelAndView.addObject("msgList", msgList);       
        modelAndView.setViewName("/alert/alertSmsMsg");
        
		return modelAndView;
	}
	
	/**
	 * 사용자가 발송했떤 SMS 메시지 이력을 가져온다
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/alertSmsMemberList.do")
    public ModelAndView alertSmsMemberList(
    		@RequestParam(value="smsHistId", required=false) String smsHistId
    	) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	
		String regId = "";
		
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(isAuthenticated) {
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			regId = user.getId();
		}

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("smsHistId", smsHistId);
		List<HashMap> msgMemeberList = alertMakeService.getSendSmsMsgMemberList(map);

        modelAndView.addObject("msgMemberList", msgMemeberList);       
        modelAndView.setViewName("/alert/alertSmsMsgMember");
        
		return modelAndView;
	}
	
	/**
     * 사전 조치 통보 SMS를 전송한다
     * 
     * @param factCode
     * @param branchNo
     * @return
     * @throws Exception
     */
    @RequestMapping("/alert/alertSmsSettingMember.do")
	public ModelAndView alertSmsSettingMember(
			@RequestParam(value="smsHistId", required=false) String smsHistId
	) throws Exception{
    	
    	ModelAndView modelAndView = new ModelAndView();	
		String regId = "";
		
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(isAuthenticated) {
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			regId = user.getId();
		}

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("smsHistId", smsHistId);
		List<HashMap> msgMemeberList = alertMakeService.getSendSmsMsgMemberList(map);

        modelAndView.addObject("list", msgMemeberList);       
        modelAndView.setViewName("jsonView");
        
		return modelAndView;
	}
	
}
