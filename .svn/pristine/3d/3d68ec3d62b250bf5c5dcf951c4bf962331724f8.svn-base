package daewooInfo.alert.web;

import java.text.SimpleDateFormat;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.alert.bean.AlertCallBackVO;
import daewooInfo.alert.bean.AlertConfigVO;
import daewooInfo.alert.bean.AlertDataVO;
import daewooInfo.alert.bean.AlertLawVO;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertSmsListSearchVO;
import daewooInfo.alert.bean.AlertSmsListVO;
import daewooInfo.alert.bean.AlertStepVO;
import daewooInfo.alert.bean.AlertTargetVO;
import daewooInfo.alert.bean.SearchVO;
import daewooInfo.alert.service.AlertMakeService;
import daewooInfo.alert.service.AlertService;
import daewooInfo.alert.service.AlertStepService;
import daewooInfo.alert.util.SendSMS;
import daewooInfo.common.util.fcc.StringUtil;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;



/**
 * @author DaeWoo Information Systems Co., Ltd.  Technical Expert Team. khanian.
 * @version 1.0
 * @Class Name : .java
 * @Description :  Class
 * @Modification Information
 * @
 * @ Modify Date	 author			   Modify Contents
 * @ --------------  ------------   -------------------------------
 * @ 2010. 3. 26  	 khanian			  new
 * @see Copyright (C) by DaeWoo Information Systems Co., Ltd. All right reserved.
 * @since 2010. 1. 21
 */

@Controller
public class AlertController {
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log log = LogFactory.getLog(AlertController.class);
	/**
	 * @uml.property  name="alertService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertService")
	private AlertService alertService;
	
	/**
	 * @uml.property  name="alertMakeService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertMakeService")
	private AlertMakeService alertMakeService;
	
	/**
	 * @uml.property  name="alertStepService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertStepService")
	private AlertStepService alertStepService;
	
	@RequestMapping("/alert/alertSms.do")
	public String getAlertSms() throws Exception {
		return "alert/alertSms"; //return String
	} 
	@RequestMapping("/alert/alertList.do")
	public String getAlertList() throws Exception {
		return "alert/alertList"; //return String
	} 
	@RequestMapping("/alert/alertPopupList.do")
	public String getAlertPopupList() throws Exception {
		return "alert/alertPopupList"; //return String
	} 
	/**
	 * 경보 발송 목록을 가져온다.
	 * 
	 * @param factCode
	 * @param branchNo
	 * @param sendDate
	 * @param type
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/alertListView.do")
	public ModelAndView getAlertListView(
			@ModelAttribute("searchVO") AlertSmsListSearchVO alertSearchVO
			) throws Exception{
		
		ModelAndView 	modelAndView 	= new ModelAndView();	
		PaginationInfo paginationInfo 	= new PaginationInfo();	
		
		if(alertSearchVO.getPageIndex() == 0)
			alertSearchVO.setPageIndex(1); 
		
		/** paging */
		alertSearchVO.setPageUnit(10);
		
		paginationInfo.setCurrentPageNo(alertSearchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(alertSearchVO.getPageUnit());
		paginationInfo.setPageSize(alertSearchVO.getPageSize());
	
		alertSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		alertSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		alertSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		alertSearchVO.setRecordCountPerPage(10);
		
		if(alertSearchVO.getStartDate() == null || alertSearchVO.getStartDate().trim().equals(""))
			alertSearchVO.setSendDate(new SimpleDateFormat("yyyyMMdd").format(System.currentTimeMillis()));
		if(alertSearchVO.getEndDate() == null || alertSearchVO.getEndDate().trim().equals(""))
			alertSearchVO.setEndDate( new SimpleDateFormat("yyyyMMdd").format(System.currentTimeMillis()));
		if(alertSearchVO.getFactCode() == null || alertSearchVO.getFactCode().equals("") || alertSearchVO.getFactCode().equals("all") || alertSearchVO.getFactCode().equals("null")) {
			alertSearchVO.setFactCode("");
		}	 
		if(alertSearchVO.getBranchNo() == null || alertSearchVO.getBranchNo().equals("") || alertSearchVO.getBranchNo().equals("all") || alertSearchVO.getBranchNo().equals("null")) {	
			alertSearchVO.setBranchNo("");
		}   
		// List<AlertSmsListVO> alertList =  alertService.getSmsList(alertSearchVO);
		// int totCnt 					   =  alertService.getSmsListCount(alertSearchVO);
		List<AlertSmsListVO> alertList =  alertMakeService.getSmsDataList(alertSearchVO);
		int totCnt 					   =  alertMakeService.getSmsDataListCount(alertSearchVO);
		paginationInfo.setTotalRecordCount(totCnt); 
		
		modelAndView.addObject("alertList", alertList);
		modelAndView.addObject("paginationInfo", paginationInfo); 
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}
			
	/**
	 * 수동 경보 발송 : 탁수모니터링 (SYS_KIND = 'T')
	 * 
	 * @param req
	 * @param res
	 * @param alertDataVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/addAlert.do")
	public ModelAndView addAlert (
			HttpServletRequest req,
			HttpServletResponse res,
			AlertDataVO alertDataVO
	)
	throws Exception{
		
		log.debug("============alertController start==========");
		
		//ModelAndView mav = new ModelAndView();
		String riverId = alertDataVO.getRiverId();
		String factCode = alertDataVO.getFactCode();
		int branchNo = alertDataVO.getBranchNo();
		String itemCode = alertDataVO.getItemCode();
		Float minVl = alertDataVO.getMinVl();
		String subject = alertDataVO.getSubject();
		String minTime = StringUtil.getTimeStamp();
		String minOr = alertDataVO.getMinOr();
		String smsMsg = alertDataVO.getSmsMsg();
		int insertCount = 0;
		
		log.debug("riverId ====== " +riverId);
		
		minTime = minTime.substring(0, 12);
		log.debug("minTime === " + minTime);
		
		// 사고 조치 관리의 시작 insert alertStep and alertStepSub 
		AlertStepVO alertStepVO = new AlertStepVO();
		alertStepVO.setFactCode(factCode);
		alertStepVO.setBranchNo(branchNo);
		alertStepVO.setItemCode(itemCode);
		alertStepVO.setMinTime(minTime);
		alertStepVO.setMinOr(minOr);
		alertStepVO.setMinVl(minVl);
		
		log.debug("minOr ==== " + minOr);
		
		// Get fact_name, item_name 
		//AlertLawVO alertLawVO = alertMakeService.getLaw(alertSearchVO);
		//String factName = alertMakeService.getFactName(alertSearchVO);
		//String itemName = alertLawVO.getItemName();
		
		// 사고 발생의 경우인지 체크한다.
		if (Integer.parseInt(minOr) > 0){
			
			if ("1".equals(minOr) ){
				//minVl = 44.0f;
				subject = subject+" 관심";
			}
			else if ("2".equals(minOr) ){
				//minVl = 55.0f;
				subject = subject+" 주의";
			}
			else if ("3".equals(minOr) ){
				//minVl = 66.0f;
				subject = subject+" 경보";
			}
			
			//userId == 1 훈련 체크 박스가 체크된 상태이면 제목 앞에 (훈련) 붙임 
			String userId = StringUtil.nullConvert(alertDataVO.getUserId());
			if ("".equals(userId)){
				log.debug("userId======" +userId);
				alertStepVO.setAlertTest("0");
			} else {
				subject = "(훈련) "+subject;
				smsMsg = "(훈련) "+smsMsg;
				alertStepVO.setAlertTest("1");
			}
			
			insertCount = SendSMS.sendSms(factCode, branchNo, minTime, minOr, smsMsg, subject);
			
		}//if (Integer.parseInt(minOr) > 0)
		
		// 사고조치 테이블에 입력
		String resultOk = "1";
		String asId = alertStepService.getMaxAsId();
			
		
		alertStepVO.setAsId(asId);
		alertStepVO.setRiverId(riverId);
				
		if (insertCount>0) {
			alertStepVO.setAlertStep("1");
			alertStepVO.setAlertStepText(subject + " 경보가 정상적으로 발령되었습니다.<br>발송내용:"+smsMsg.toString());
		} else {
			resultOk = "0";
			alertStepVO.setAlertStepText("상황전파불가능 : 경보 발령 대상자가 존재하지 않습니다.");
			alertStepVO.setAlertStep("9");
		}
				
		alertStepService.insertAlertStep(alertStepVO);
		alertStepService.insertAlertStepSub(alertStepVO);
		
		if(resultOk == "0") {
			res.setContentType("text/html; charset=UTF-8");
			res.getWriter().print("<script>alert('"+alertStepVO.getAlertStepText()+"');self.close();</script>");
		} else {
			res.setContentType("text/html; charset=UTF-8");
			res.getWriter().print("<script>alert('경보가 정상적으로 발령되었습니다.');self.close();</script>");
		}
		
		return null;
	}
	
	/*
	 * 탁수 모니터링 경보 system(T:탁수, I:ipUsn)에 따라 구분 하는 거 추가 필요
	 */
	/**
	 * 수동 경보 발송 : IP-USN (SYS_KIND = 'U')
	 * 
	 * @param req
	 * @param res
	 * @param alertDataVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/addAlertUsn.do")
	public ModelAndView addAlertUsn (
			HttpServletRequest req,
			HttpServletResponse res,
			AlertDataVO alertDataVO
	)
	throws Exception{
		
		//ModelAndView mav = new ModelAndView();
		String riverId = alertDataVO.getRiverId();
		String factCode = alertDataVO.getFactCode();
		int branchNo = alertDataVO.getBranchNo();
		String[] itemCodeArr = alertDataVO.getItemCodeArr();
		Float[] minVlArr = alertDataVO.getMinVlArr();
		String subject = alertDataVO.getSubject();
		String minTime = StringUtil.getTimeStamp();
		String minOr = alertDataVO.getMinOr();
		String smsMsg = alertDataVO.getSmsMsg();
		int insertCount = 0;
		
		//String factName = new String();
		//String[] itemName = new String[2];
		
		minTime = minTime.substring(0, 12);
		log.debug("minTime === " + minTime);
		
		// 사고 조치 관리의 시작 insert alertStep and alertStepSub 
		AlertStepVO alertStepVO = new AlertStepVO();
		alertStepVO.setFactCode(factCode);
		alertStepVO.setBranchNo(branchNo);
		alertStepVO.setItemCode(itemCodeArr[0]);
		alertStepVO.setMinTime(minTime);
		alertStepVO.setMinOr(minOr);
		alertStepVO.setMinVl(minVlArr[0]);
		
		alertStepVO.setExcessItemCode(itemCodeArr[1]);
		alertStepVO.setExcessMinVl(minVlArr[1]); 
		
		// 사고 발생의 경우인지 체크한다.
		if (Integer.parseInt(minOr) > 0){
			
			if ("1".equals(minOr) ){
				subject = subject+" 관심";
			}
			else if ("2".equals(minOr) ){
				subject = subject+" 주의";
			}
			else if ("3".equals(minOr) ){
				subject = subject+" 경계";
			}
			else if ("4".equals(minOr) ){
				subject = subject+" 심각";
			}
			
			//userId == 1 훈련 체크 박스가 체크된 상태이면 제목 앞에 (훈련) 붙임 
			String userId = StringUtil.nullConvert(alertDataVO.getUserId());
			if ("".equals(userId)){
				log.debug("userId======" +userId);
				alertStepVO.setAlertTest("0");
			} else {
				subject = "(훈련) "+subject;
				smsMsg = "(훈련) "+smsMsg;
				alertDataVO.setSubject(subject);
				alertStepVO.setAlertTest("1");
			}
			
			insertCount = SendSMS.sendSms(factCode, branchNo, minTime, minOr, smsMsg, subject);
		}//if (Integer.parseInt(minOr) > 0)
		
		// 사고조치 테이블에 입력
		String resultOk = "1";
		String asId = alertStepService.getMaxAsId();
		
		alertStepVO.setAsId(asId);
		alertStepVO.setRiverId(riverId);
		
		if (insertCount>0) {
			alertStepVO.setAlertStep("1");
			alertStepVO.setAlertStepText(subject + " 경보가 정상적으로 발령되었습니다.<br>발송내용:"+smsMsg.toString());
		} else {
			resultOk = "0";
			alertStepVO.setAlertStepText("상황전파불가능 : 경보 발령 대상자가 존재하지 않습니다.");
			alertStepVO.setAlertStep("9");
		}
		
		alertStepService.insertAlertStep(alertStepVO);
		alertStepService.insertAlertStepSub(alertStepVO);
		
		if(resultOk == "0") {
			res.setContentType("text/html; charset=UTF-8");
			res.getWriter().print("<script>alert('"+alertStepVO.getAlertStepText()+"');self.close();</script>");
		} else {
			res.setContentType("text/html; charset=UTF-8");
			res.getWriter().print("<script>alert('경보가 정상적으로 발령되었습니다.');self.close();</script>");
		}
		
		return null;
	}
}