package daewooInfo.alert.service.impl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import daewooInfo.alert.bean.AlertAlarmVO;
import daewooInfo.alert.bean.AlertCallBackVO;
import daewooInfo.alert.bean.AlertConfigVO;
import daewooInfo.alert.bean.AlertDataVO;
import daewooInfo.alert.bean.AlertLawVO;
import daewooInfo.alert.bean.AlertMinVO;
import daewooInfo.alert.bean.AlertNewLawVO;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertSendDataVO;
import daewooInfo.alert.bean.AlertSmsBranchVO;
import daewooInfo.alert.bean.AlertSmsCommVO;
import daewooInfo.alert.bean.AlertStepLastVO;
import daewooInfo.alert.bean.AlertStepVO;
import daewooInfo.alert.bean.AlertTaksuConfigVO;
import daewooInfo.alert.bean.AlertTargetVO;
import daewooInfo.alert.dao.AlertConfigDAO;
import daewooInfo.alert.dao.AlertDAO;
import daewooInfo.alert.dao.AlertMakeDAO;
import daewooInfo.alert.dao.AlertSchDAO;
import daewooInfo.alert.dao.AlertStepDAO;
import daewooInfo.alert.dao.AlertTaksuConfigDAO;
import daewooInfo.common.util.CommonUtil;

/**
 * @author DaeWoo Information Systems Co., Ltd.  Technical Expert Team. khanian.
 * @version 1.0
 * @Class Name : .java
 * @Description :  Class
 * @Modification Information
 * @
 * @ Modify Date     author               Modify Contents
 * @ --------------  ------------   -------------------------------
 * @ 2010. 3. 26  	 khanian              new
 * @see Copyright (C) by DaeWoo Information Systems Co., Ltd. All right reserved.
 * @since 2010. 1. 21
 */


public class AlertBySchdlrImpl extends QuartzJobBean { 
	
	private static Log log = LogFactory.getLog(AlertBySchdlrImpl.class);
	
	private static final String DET_CODE = "SMSCD003";
	private static final String SYS_KIND_IPUSN = "U";
	private static final String IPUSN = "IPUSN";
	private static final String ALERT_KIND_SMS = "S";
	
	private static final String ITEM_CODE_TUR00 = "TUR00";
	private static final String ITEM_CODE_PHY00 = "PHY00";
	private static final String ITEM_CODE_CON00 = "CON00";
	private static final String ITEM_CODE_DOW00 = "DOW00";
		
	/**
	 * @uml.property  name="alertDAO"
	 * @uml.associationEnd  
	 */
	private AlertDAO alertDAO;
	/**
	 * @uml.property  name="alertMakeDAO"
	 * @uml.associationEnd  
	 */
	private AlertMakeDAO alertMakeDAO;
	/**
	 * @uml.property  name="alertStepDAO"
	 * @uml.associationEnd  
	 */
	private AlertStepDAO alertStepDAO;
	/**
	 * @uml.property  name="alertTaksuConfigDAO"
	 * @uml.associationEnd  
	 */
	private AlertTaksuConfigDAO alertTaksuConfigDAO;
	
	private AlertConfigDAO alertConfigDAO;
	
	/**
	 * @uml.property  name="alertCntUpdateFlag"
	 */
	private boolean AlertCntUpdateFlag = false;
		
	/**
	 * @param alertDAO
	 * @uml.property  name="alertDAO"
	 */
	public void setAlertDAO(AlertDAO alertDAO) {
		this.alertDAO = alertDAO;
	}
	
	/**
	 * @param alertMakeDAO
	 * @uml.property  name="alertMakeDAO"
	 */
	public void setAlertMakeDAO(AlertMakeDAO alertMakeDAO) {
		this.alertMakeDAO = alertMakeDAO;
	}

	/**
	 * @param alertStepDAO
	 * @uml.property  name="alertStepDAO"
	 */
	public void setAlertStepDAO(AlertStepDAO alertStepDAO) {
		this.alertStepDAO = alertStepDAO;
	}

	/**
	 * @param alertTaksuConfigDAO
	 * @uml.property  name="alertTaksuConfigDAO"
	 */
	public void setAlertTaksuConfigDAO(AlertTaksuConfigDAO alertTaksuConfigDAO) {
		this.alertTaksuConfigDAO = alertTaksuConfigDAO;
	}
	
	public void setAlertConfigDAO(AlertConfigDAO alertConfigDAO) {
		this.alertConfigDAO = alertConfigDAO;
	}


	/**
	 * @uml.property  name="alertSchDAO"
	 * @uml.associationEnd  
	 */
	protected AlertSchDAO alertSchDAO;
	
	/**
	 * @return
	 * @uml.property  name="alertSchDAO"
	 */
	public AlertSchDAO getAlertSchDAO() {
		return alertSchDAO;
	} 
	
	/**
	 * @param alertSchDAO
	 * @uml.property  name="alertSchDAO"
	 */
	public void setAlertSchDAO(AlertSchDAO alertSchDAO) {
		this.alertSchDAO = alertSchDAO;
	} 
	
	/**
	 * 생성자
	 */
	public AlertBySchdlrImpl() {}
    
	/**
	 * IP-USN 5분 주기로 경보발령 측정소를 가져옵니다.
	 */
	@Override
    protected void executeInternal(JobExecutionContext ctx) throws JobExecutionException {

		log.debug("Start Alert by Scheduler!");
		
		
		try {

			AlertCntUpdateFlag = false;
			
			// 탁수 경보 해지 설정 
			// 탁수 안씀
//			alertTaksuConfig();
			
			//IP-USN 미수신 측정소 체크
//			ipusnNorecvSend();
			
			// 탁수 및 IP-USN
			// 새로 들어온 측정 자료를 조회한다.
			List<AlertMinVO> alertMinList = (List<AlertMinVO>)alertMakeDAO.getMinList();
			if( alertMinList.size() > 0 ){
				
				for(int i=0; i < alertMinList.size(); i++){
					
					AlertMinVO alertMinVO = (AlertMinVO)alertMinList.get(i);
					String system = alertMinVO.getFactCode().substring(2,3);
					//log.debug("factCode ======= " + alertMinVO.getFactCode());
					if ("T".equals(system)){						
						//alertMakeT(alertMinVO);
					} else if ("U".equals(system)) {
						// alertMakeDAO.getMinList 쿼리 조건에 U가 있어서 U일 경우만 동작 
						alertMakeU(alertMinVO);
					}
	
				}//end for(int i=0; i < alertMinList.size(); i++)
				
				// 판단 대상에서 제외되도록 값 업데이트 min_dcd = '0'으로 만들기			
				alertMakeDAO.updateMin();
			}//end if( alertMinList.size() > 0 )
		}catch(Exception e){
			e.printStackTrace();
			log.error(" AlertBySchdlrImpl 스케줄러 executeInternal() 에러 : " + e.getMessage());
		}
		
	}

	/**
	 * 탁수 경보 해지 설정 
	 * 
	 * @param alertMinVO
	 */	
	private void alertTaksuConfig() {
		
		log.debug("Start Alert Taksu Config  by Scheduler!");
		
		try {
			//탁수경보설절 테이블에서 해제할 경보설정을 가져온다.
			List<AlertTaksuConfigVO> list = alertTaksuConfigDAO.getAlertTaksuConfigAuto();
			if(list.size() > 0) {
				for(AlertTaksuConfigVO vo : list) {
					vo.setAlertFlag("0");	
					vo.setHistMsg("전파중지 해제 (자동)");
					
					alertTaksuConfigDAO.mergeAlertTaksuConfig(vo);
					alertTaksuConfigDAO.insertAlertTaksuConfigHist(vo);
				}
			}

		}catch(Exception e){
			e.printStackTrace();
			log.error(" AlertBySchdlrImpl 스케줄러 alertTaksuConfig() 에러 : " + e.getMessage());
		}			
	}
	
	/**
	 * 국가수질자동측정망 경보 - 완전하지 않음. 손 좀 봐야 함.
	 */
	private void alertMakeA() {
		
		log.debug("Start Alert by Scheduler AAAAAA!");
		
		try {
			//국가수질자동측정망테이블에서 경보발송내용을 가져온다.
			List<AlertAlarmVO> alertAlarmList = (List<AlertAlarmVO>)alertMakeDAO.getAlarmList();
			if( alertAlarmList.size() > 0 )
			{
				for(int i=0; i < alertAlarmList.size(); i++)
				{
					AlertAlarmVO alertAlarmVO = (AlertAlarmVO)alertAlarmList.get(i);
					String factCode = alertAlarmVO.getFactCode();
					int branchNo = 1;
					String minOr = "0";
					String minTime = alertAlarmVO.getSendDate();
					String msgType = alertAlarmVO.getMsgType();
					String itemCode = "00000";
					String smsMsg = "";
					String smsMsgMinVl = "";
					
					//발송된 메시지에서 문자와 측정치 잘라내기
					String alarmMsg = alertAlarmVO.getAlarmMsg();
					Pattern p = Pattern.compile("[a-zA-Z]");
					Matcher m = p.matcher(alarmMsg);
					  
					if(m.find()) {  
						smsMsg = alarmMsg.substring(0, alarmMsg.indexOf(m.group()));
						smsMsgMinVl = alarmMsg.substring(alarmMsg.indexOf(m.group()));
					} else {
						smsMsg = alarmMsg.substring(0, alarmMsg.indexOf("("));
						smsMsgMinVl = alarmMsg.substring(alarmMsg.indexOf("("));
					}
					
					log.debug("smsMsg ==== " + smsMsg);
					log.debug("smsMsgMinVl ==== " + smsMsgMinVl);
					
					int alertFlag = 0;
					String alertSms = "";
		            String alertAcs = "";
		            String stringOr = smsMsg.substring(0, 2);
		            
		            log.debug("stringOr ========= " + stringOr);
		            
		            // 메시지 안에 관심,주의,경계에 대한 부분을 가져올 수가 없다. 여기가 문제.
		            if ("관심".equals(stringOr)) minOr = "1";
		            else if ("주의".equals(stringOr)) minOr = "2";
		            else if ("경계".equals(stringOr)) minOr = "3";
		            else minOr = "0";
		            
					// 경보 메시지를 위하여
					AlertDataVO alertDataVO = new AlertDataVO();				
					alertDataVO.setFactCode(factCode);
					alertDataVO.setBranchNo(branchNo);
					alertDataVO.setMinTime(minTime);
					alertDataVO.setItemCode(itemCode);
				
		            // 검색조건 세팅
					AlertSearchVO alertSearchVO = new AlertSearchVO();
					alertSearchVO.setFactCode(factCode);
					alertSearchVO.setBranchNo(branchNo);
					alertSearchVO.setItemCode(itemCode);
					// 경보 발령 대상자의 단계별 추출을 위하여
					alertSearchVO.setMinOr(minOr);
					
					AlertConfigVO alertConfigVO = alertMakeDAO.getConfig(alertSearchVO);
					if (alertConfigVO != null){
						alertSms = alertConfigVO.getSmsFlag();
						alertAcs = alertConfigVO.getArsFlag();
						if (alertSms != null || alertAcs != null){ 
							alertFlag = 1; 
						}
					}
					
					// SMS 경보 발송
					if (alertFlag > 0) {
						// SMS 경보 메시지를 만든다.
						String subject = "국가수질자동측정망";
											
						if (alertSms != null && "1".equals(msgType)){
																				
							alertDataVO.setSubject(subject);
							
							AlertStepVO alertStepVO = new AlertStepVO();
							//데이터 검증 
							//saveAlertData 
							// sms발송
							alertSendSms (alertSearchVO, alertDataVO, alertStepVO, 0, smsMsg, smsMsgMinVl, null);
							
						} // end if (alertSms != null)
						
						if (alertAcs != null  && "3".equals(msgType)) {
													
							AlertStepVO alertStepVO = new AlertStepVO();
							// ACS발송
							alertSendVms (alertSearchVO, alertDataVO, alertStepVO, 0, smsMsg, smsMsgMinVl);
							
						} // end if (alertAcs != null)
						
						//유하속도예측하여예경보날릴때 쓸 메쏘드
						//alertMakeForecast(alertSearchVO, alertDataVO, smsMsg, smsMsgMinVl);
					
					}//end if (alertFlag > 0)
	
					alertMakeDAO.updateAlarm(alertAlarmVO);
				}//end for(int i=0; i < alertAlarmList.size(); i++)
			}//end if( alertAlarmList.size() > 0 )
			
		}catch(Exception e){
			e.printStackTrace();
			log.error(" AlertBySchdlrImpl 스케줄러 alertMakeA() 에러 : " + e.getMessage());
		}
		
	}
	
	
	/**
	 * 탁수 경보 발생
	 * 
	 * @param alertMinVO
	 */
	@SuppressWarnings("unchecked")
	private void alertMakeT(AlertMinVO alertMinVO) {
		
		log.debug("Start Alert by Scheduler TTTTT!");
		
		try {
			
			String factCode	= alertMinVO.getFactCode();
			int branchNo	= alertMinVO.getBranchNo();
			String minTime	= alertMinVO.getMinTime();
            Float minVl		= alertMinVO.getTur();
            String itemCode	= ITEM_CODE_TUR00;
            String minOr 	= "0"; //기준치 초과 여부
            int alertFlag	= 0;
            String factName = "";
            String alertSms = "";
            String alertAcs = "";
            int alertTerm = 0;
            String riverId = "R0"+factCode.substring(3, 4);
            log.debug("minVl === " + minVl.toString());
            
            // 사고조치관리를 위하여
            AlertStepVO alertStepVO = new AlertStepVO();
            alertStepVO.setFactCode(factCode);
			alertStepVO.setBranchNo(branchNo);
			alertStepVO.setItemCode(itemCode);
			alertStepVO.setMinTime(minTime);
			alertStepVO.setAlertTest("0");//테스트나 훈련이 아님; 실제 경보	
			alertStepVO.setRiverId(riverId);

			// 경보 메시지를 위하여
			AlertDataVO alertDataVO = new AlertDataVO();				
			alertDataVO.setFactCode(factCode);
			alertDataVO.setBranchNo(branchNo);
			alertDataVO.setMinTime(minTime);
			alertDataVO.setItemCode(itemCode);
		
            // 검색조건 세팅
			AlertSearchVO alertSearchVO = new AlertSearchVO();
			alertSearchVO.setFactCode(factCode);
			alertSearchVO.setBranchNo(branchNo);
			alertSearchVO.setItemCode(itemCode);
			
			// 경보 기준을 가져와서 판단 한다. 
			AlertLawVO alertLawVO = alertMakeDAO.getLaw(alertSearchVO);			
			if (alertLawVO != null) { 
				Float lawHighValue = alertLawVO.getTurHVal();	//상한기준치
				/*
				 * 5분데이터의 5분측정값과 경보 기준의 상한기준치와 판단을 한다.
				 * 				
				 */
				if (minVl > lawHighValue) minOr = "3";
				else minOr = "0";

				factName = alertMakeDAO.getFactName(alertSearchVO);
			} else {
				minOr = "0";
				log.debug(" alertLawVO === null 이다");
				alertStepVO.setAlertStepText("상황전파불가능 : 수질 기준 설정이 존재하지 않습니다.");
			}			
			
			// 경보냐? 사고조치에 인서트냐 업데이트냐?
			if (Integer.parseInt(minOr) > 0){
				// update table min_real set minOr
				HashMap updateMap = new HashMap();
				updateMap.put("minOr", minOr);
				updateMap.put("factCode", factCode);
				updateMap.put("branchNo", branchNo);
				updateMap.put("itemCode", itemCode);
				updateMap.put("minTime", minTime);
				
				alertMakeDAO.updateMinOr(updateMap);
				
				//사고조치 테이블 인서트 용
				alertStepVO.setMinOr(minOr); //기분치 초과 여부 
				alertStepVO.setMinVl(minVl);//5분 측정값 										
				
				AlertConfigVO alertConfigVO = alertMakeDAO.getConfig(alertSearchVO);
				if (alertConfigVO != null){
					alertSms = alertConfigVO.getSmsFlag();
					alertAcs = alertConfigVO.getArsFlag();
					alertTerm = alertConfigVO.getAlertTerm();
					if (alertSms != null || alertAcs != null){ 
						alertFlag = 1; 
					}
				}
								
				//log.debug("minVl === " + minVl.toString());
				//log.debug("minOr === " + minOr.toString());
				
				// 경보 발령 대상자의 단계별 추출을 위하여
				alertSearchVO.setMinOr(minOr);
				
				// 해당 공구 아이템의 완료되지 않은 마지막 전파 내용 (alert_step < 4)
				AlertStepLastVO alertStepLastVO = alertStepDAO.getLastAlert(alertStepVO);
				
				// 탁수 경보 설정을 가져와서 발송여부를 결정한다.
				AlertTaksuConfigVO tVo = new AlertTaksuConfigVO();
				tVo.setFactCode(factCode);
				int taksuFlag = alertTaksuConfigDAO.getAlertTaksuConfigFlag(tVo);
				log.debug("탁수 경보 설정 체크 값  - " + taksuFlag);
				if(taksuFlag > 0) {
					alertFlag = 0;
					log.debug("경보 미발송");
				}
				/*
				if(taksuFlag < 1) {
					alertFlag = 0;
					log.debug("경보 미발송");
				}
				*/
				

				//연속 데이터의 경우엔 사고조치 테이블에 업데이트 
				if (alertFlag == 1 && alertStepLastVO != null){
					alertStepVO.setAsId(alertStepLastVO.getAsId());
					Double timeDiff = alertStepLastVO.getTimeDiff();
					String sMinOr = alertStepLastVO.getMinOr();
					int alertCount = alertStepLastVO.getAlertCount();
					int preFlag = 0;
					
					log.debug("alertCount === " + alertCount);
					/* alert_count 디폴트 : 0 변경
					 * 3시간 ,9시간,12시간   > 3, 6, 12
					 * 
					 */
					if(alertCount == 0) { //처음 경보 데이터
						if(timeDiff < 180)						
							alertFlag = 0; 
						else
							alertFlag = 1;
					}
					else if(alertCount == 1) {	// 3시간 지속 데이터
						if (timeDiff > 180){
							preFlag = 1;
						} else if (timeDiff >= 180){ 
							alertFlag = 2;
							if (minOr.equals(sMinOr)){
								alertFlag = 3;
							}
						}else{
							alertFlag =0; 
						}
					} else if(alertCount == 2) {	// 6시간 지속 데이터
						if (timeDiff > 360){
							preFlag = 1;
						} else if (timeDiff >= 360){ 
							alertFlag = 2;
							if (minOr.equals(sMinOr)){
								alertFlag = 3;
							}
						}else{
							alertFlag =0; 
						}						
					} else if(alertCount == 3) {	// 12시간 지속 데이터
						if (timeDiff > 720){
							preFlag = 1;
						} else if (timeDiff >= 720){ 
							alertFlag = 2;
							if (minOr.equals(sMinOr)){
								alertFlag = 3;
							}
						}else{
							alertFlag =0; 
						}						
					}
					
					log.debug("preFlag === " + preFlag);
					
					// 현재 값이 기준을 넘었으나 지속전파가 아닐경우 바로 이전의 데이터를 가져와서 
					// 그 데이터가 기준이하일 시 사고조치를 추가한다. 
					if(preFlag == 1) {		
						// 이전 데이터 가져오기
						AlertMinVO preVo =alertMakeDAO.getPreMin(alertStepVO);
						
						// 이전 데이터 측정값 						
						Float preMinVl = preVo.getTur();
						
						// 기준 측정값
						Float lawHighValue = alertLawVO.getTurHVal();						
									
						
						if (lawHighValue > preMinVl) 
							alertFlag = 1;
						else 
							alertFlag = 0;
					}
					
					/*
					if (preFlag == 1 && alertFlag == 1 && alertTerm > 0) {
						if (timeDiff < alertTerm){
							alertFlag = 0;
						} else if (timeDiff >= alertTerm && timeDiff < (alertTerm+10)){ 
							alertFlag = 2;
							if (minOr.equals(sMinOr)){
								alertFlag = 3;
							}
						}
					}
					*/

				}
				
			}// end if (Integer.parseInt(minOr) > 0)
			
			log.debug("alertFlag ====== " + alertFlag);
								
			// SMS 경보 발송
			if (alertFlag > 0) {
				// SMS 경보 메시지를 만든다.
				String subject = "";
				StringBuffer smsMsg = new StringBuffer();
				StringBuffer smsMsgMinVl = new StringBuffer();
				
				if (alertSms != null){
					
					if ("3".equals(minOr) ){
						subject = subject+" 경보";
						smsMsg.append("탁도(경보");
					}
					smsMsg.append(") ");
					/*
					if (alertFlag == 3) {
						smsMsg.append("지속) ");
					} else {
						smsMsg.append(") ");
					}
					*/
					smsMsg.append(factName).append("-").append(branchNo)
					//.append("측정소 ").append(minTime.substring(2, 4))
					.append(" ").append(minTime.substring(2, 4))
					.append("").append(minTime.substring(4, 6))
					.append("").append(minTime.substring(6, 8))
					.append(" ").append(minTime.substring(8, 10))
					.append(":").append(minTime.substring(10, 12));
					
					smsMsgMinVl.append("");
																		
					alertDataVO.setSubject(subject);
					
					//데이터 검증  
					alertData(alertDataVO.getFactCode(),alertSearchVO.getBranchNo(),alertSearchVO.getItemCode(),alertDataVO.getMinTime(),"S",smsMsg.toString(),smsMsgMinVl.toString(),alertFlag);
					// sms발송
					alertSendSms (alertSearchVO, alertDataVO,alertStepVO, alertFlag, smsMsg.toString(), smsMsgMinVl.toString(), null);
					
				} // end if (alertSms != null)
				
				if (alertAcs != null) {
									
					smsMsg.append("안녕하십니까? 한국환경공단 방제센터입니다...");
					
					if ("3".equals(minOr) ){
						subject = subject+" 경보";
						smsMsg.append("탁도 경보");
					}
					
					if (alertFlag == 3) {
						smsMsg.append(" 지속 ");
					} else {
						smsMsg.append(" 발생 ");
					}
					
					smsMsg.append(factName).append(" ").append(branchNo)
					//.append("번 측정소에서").append(minTime.substring(0, 4))
					.append("번 에서").append(minTime.substring(0, 4))
					.append("년").append(minTime.substring(4, 6))
					.append("월").append(minTime.substring(6, 8))
					.append("일").append(minTime.substring(8, 10))
					.append("시").append(minTime.substring(10, 12))
					.append("분에 탁도 경보가 발령되었습니다.... 감사합니다.");
					
					smsMsgMinVl.append("");
																		
					alertDataVO.setSubject(subject);
					
					// ACS발송
					alertSendVms (alertSearchVO, alertDataVO,alertStepVO, alertFlag, smsMsg.toString(), smsMsgMinVl.toString());
					
				} // end if (alertAcs != null)
				
				//유하속도예측하여예경보날릴때 쓸 메쏘드
				//alertMakeForecast(alertSearchVO, alertDataVO, alertStepVO, smsMsg.toString(), smsMsgMinVl.toString());
			
			}//end if (alertFlag > 0)
		}catch(Exception e){
			e.printStackTrace();
			log.error(" AlertBySchdlrImpl 스케줄러 alertMakeT() 에러 : " + e.getMessage());
		}
	}	
	
	
	
	/**
	 * 단지 사전조치 통계를 위해 T_WARNING_SEND_DATA에 넣어줍니다...
	 * @param alertStepVO
	 * @param sendData
	 * @param param
	 */
	protected int alertSmsSendData(AlertSendDataVO sendData, Map param, String sendFlag, String smsMsg){
		// sms 보내는 담당자 번호  1666-0128  
		int result = 0;
		try {
			sendData.setDetCode(DET_CODE);
			sendData.setSendFlag(sendFlag);
			sendData.setMsg(smsMsg);
			
			//경보 발령 대상자를 추출한다.
			List<AlertTargetVO> alertTargetList =alertSchDAO.getTargetList(sendData); 
			log.debug("경보발령대상자 추출");
			//List<AlertTargetVO> alertTargetList = alertMakeDAO.getTargetBranchSmsList(sendData);
			log.debug("##### T_WARNING_DATA IN SMS :: 경보 발령 대상자 = "+alertTargetList.size()); 
			if(alertTargetList.size() > 0) {
				for (int j=0; j < alertTargetList.size(); j++) { 
					
					AlertTargetVO alertTargetVO = (AlertTargetVO)alertTargetList.get(j); 
					String atPart 		= alertTargetVO.getAtPart();
					String atPartGubun  = alertTargetVO.getAtPartGubun();
					String atName 		= alertTargetVO.getAtName(); 
					String atSmsTele 	= alertTargetVO.getAtSmsTele(); 
					
					if(alertTargetVO.getAtSmsTele() !=null){ 
						sendData.setPart(atPart); 
						sendData.setSendName("방제정보시스템");
						sendData.setSendTel("1666-0128");
						sendData.setReceiveName(atName);
						sendData.setReceiveTel(atSmsTele);
						sendData.setAlertKind("S");
						result =alertSchDAO.insertAlertSendData(sendData); 
					} 
				}
			}else{
				result = -1; //대상이 없음.
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(" SMS SEND ERROR 에러 : " + e.getMessage());
		}
		return result; 
	} 
	
	
	
	/**
	 * 단지 사전조치 통계를 위해 T_WARNING_SEND_DATA에 넣어줍니다...
	 * @param alertStepVO
	 * @param sendData
	 * @param param
	 */
	protected int alertVmsSendData(AlertSendDataVO sendData,Map param){ 
		// sms 보내는 담당자 번호  1666-0128  
		int result = 0;
		try {
			
			//경보 발령 대상자를 추출한다.
			List<AlertTargetVO> alertTargetList =alertSchDAO.getTargetList(sendData); 
			log.debug("##### 경보 발령 대상자 ="+alertTargetList.size()); 
			if(alertTargetList.size() > 0) {
				for (int j=0; j < alertTargetList.size(); j++) { 
					
					AlertTargetVO alertTargetVO = (AlertTargetVO)alertTargetList.get(j); 
					String atPart 		= alertTargetVO.getAtPart();
					String atPartGubun  = alertTargetVO.getAtPartGubun();
					String atName 		= alertTargetVO.getAtName(); 
					String atSmsTele 	= alertTargetVO.getAtSmsTele(); 
					
					if(alertTargetVO.getAtSmsTele() !=null && alertTargetVO.getAtArs().equals("A")){ 
						sendData.setPart(atPart); 
						sendData.setSendName("방제정보시스템");
						sendData.setSendTel("1666-0128");
						sendData.setReceiveName(atName);
						sendData.setReceiveTel(atSmsTele);
						sendData.setAlertKind("A");
						result =alertSchDAO.insertAlertSendData(sendData); 
					} 
				}
			}else{
				result = -1; //대상이 없음.
			}
		} catch (Exception e) {
			e.printStackTrace();
			log.error(" SMS SEND ERROR 에러 : " + e.getMessage());
		}
		return result; 
	} 
	
	
	
	/**
	 * IP-USN 미수신 측정소 SMS전송
	 */
	/*
	private void ipusnNorecvSend()
	{
		try
		{
			//미수신 측정소 리스트
			List<AlertStepVO> norecvList = alertSchDAO.getNorecvList();
			
			for(AlertStepVO vo : norecvList)
			{	
				vo.setAlertDelayTime(alertConfigDAO.getAlertConfigTimeView().getAlert_delay_time());
				int isFirst = alertSchDAO.getIsNorecv30Min(vo);
				
				if(isFirst == 0)
				{
					//사전조치 통계를 내기위해 T_WARNING_SEND_DATA 테이블에 넣어줌
					AlertSendDataVO 	send = new AlertSendDataVO();
					send.setFactCode(vo.getFactCode());
					send.setRiverId("R0"+vo.getFactCode().substring(3, 4)); 
					send.setFactName(vo.getFactName());
					send.setBranchNo(vo.getBranchNo()); 
					send.setItemCode("30MIN");	
					send.setMinTime(vo.getMinTime());
					send.setAlertValue(0F);
					send.setAlertStandard(50F); 
					send.setSendFlag("Y"); // Y를 넣어서 스케쥴러에서 mysql인서트를 하지 않게함
					send.setAlertMsg("");
					send.setMsgKind("SMS");
					send.setAlertType("NRECV"); 
					send.setMsg("");				
					send.setMinOr("5");				
					
					
					String time = vo.getMinTime();
					time = time.substring(2, 4) + "/" + time.substring(4, 6) + "/" + time.substring(6, 8) + " " + time.substring(8,10) + ":" + time.substring(10,12);
					String smsMsg = "USN(30분이상 데이터 미수신) " + vo.getBranchName() + " " + time;
					
					alertSendSms(vo, smsMsg);
					alertSmsSendData(send, null); 
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			log.error(" AlertBySchdlrImpl 스케줄러 ipusnNorecvSend() 에러 : " + e.getMessage());
		}
	}
	
	*/

	/**
	 * IP-USN 경보 발생
	 * 
	 * @param alertMinVO
	 */
	@SuppressWarnings("unchecked")
	private void alertMakeU(AlertMinVO alertMinVO) {
		
		log.debug("Start Alert by Scheduler IP-USN!");
		
		try {
			
			String itemCodePhy	= ITEM_CODE_PHY00; //pH 수소이온농도 PHY00
            String itemCodeDow	= ITEM_CODE_DOW00; //DO 용존산소 DOW00
            String itemCodeCon	= ITEM_CODE_CON00; //EC 전기전도도 CON00
			
			String factCode	= alertMinVO.getFactCode();
			int branchNo	= alertMinVO.getBranchNo();
			String minTime	= alertMinVO.getMinTime();
            Float phy		= alertMinVO.getPhy(); //pH 수소이온농도
            Float dow		= alertMinVO.getDow(); //DO 용존산소
            Float con		= alertMinVO.getCon(); //EC 전기전도도
            String riverId = "R0"+factCode.substring(3, 4);
            
            int alertFlag 	= 0;
            String minOr 	= "0";

            int flagCon = 0;
            int flagDow = 0;
            int flagPhy = 0;
            Float minVl		= 0.0f;
            Float minVl1	= 0.0f;
            Float minVl2 	= 0.0f;
            String factName = "";
            String branchName = "";
            String itemCode = "";
            String itemCode1 = "";
			String itemName = "";
			String itemName1 = "";
			String itemCode2 = "";
			String itemName2 = "";
			
			String alertSms = "";
            String alertAcs = "";
            int alertTerm = 0;
           	
            Float phyHVal = 0.0f;
			Float phyLVal = 0.0f;
			Float conHVal = 0.0f;
			Float dowLVal = 0.0f;
			
            // 사고조치관리를 위하여
            AlertStepVO alertStepVO = new AlertStepVO();
            alertStepVO.setFactCode(factCode);
			alertStepVO.setBranchNo(branchNo);
			alertStepVO.setMinTime(minTime);
			alertStepVO.setAlertTest("0");//테스트나 훈련이 아님; 실제 경보
			alertStepVO.setRiverId(riverId);
			
			// 경보 메시지를 위하여
			AlertDataVO alertDataVO = new AlertDataVO();				
			alertDataVO.setFactCode(factCode);
			alertDataVO.setBranchNo(branchNo);
			alertDataVO.setMinTime(minTime);
			
            // 검색조건 세팅
			AlertSearchVO alertSearchVO = new AlertSearchVO();
			alertSearchVO.setFactCode(factCode);
			alertSearchVO.setBranchNo(branchNo);

			
			// 경보 기준을 가져와서 판단 한다. 
			//AlertLawVO alertLawVO = alertMakeDAO.getLaw(alertSearchVO);
			//2015-11-20 경보기준 판단 변경
			List<AlertNewLawVO> alertNewLawList = (List<AlertNewLawVO>)alertMakeDAO.getNewLaw(alertSearchVO);
			if(alertNewLawList != null){
				
				int curMm = Integer.parseInt(CommonUtil.getCurrentDate("MM"));
				for(int i = 0 ; i < alertNewLawList.size(); i++){
					String tCode = alertNewLawList.get(i).getItemCode();
					if("PHY00".equals(tCode)){
						if(!"".equals(alertNewLawList.get(i).getDrySeasonYn()) && "Y".equals(alertNewLawList.get(i).getDrySeasonYn()) && 
						  ((null != alertNewLawList.get(i).getDrySeasonFromMm() && Integer.parseInt(alertNewLawList.get(i).getDrySeasonFromMm()) <= curMm) && 
						   (null != alertNewLawList.get(i).getDrySeasonToMm()   && Integer.parseInt(alertNewLawList.get(i).getDrySeasonToMm()) >= curMm))){
							phyHVal = Float.parseFloat(alertNewLawList.get(i).getItemDryValueHi());
							phyLVal = Float.parseFloat(alertNewLawList.get(i).getItemDryValueLo());
							log.debug("##### 갈수기적용여부[PHY] :: Y #####");
						}else{
							phyHVal = Float.parseFloat(alertNewLawList.get(i).getItemValueHi());
							phyLVal = Float.parseFloat(alertNewLawList.get(i).getItemValueLo());							
						}
					}else if("CON00".equals(tCode)){
						if(!"".equals(alertNewLawList.get(i).getDrySeasonYn()) && "Y".equals(alertNewLawList.get(i).getDrySeasonYn()) && 
						((null != alertNewLawList.get(i).getDrySeasonFromMm() && Integer.parseInt(alertNewLawList.get(i).getDrySeasonFromMm()) <= curMm) && 
						 (null != alertNewLawList.get(i).getDrySeasonToMm()   && Integer.parseInt(alertNewLawList.get(i).getDrySeasonToMm()) >= curMm))){
							conHVal = Float.parseFloat(alertNewLawList.get(i).getItemDryValueHi());
							log.debug("##### 갈수기적용여부[CON] :: Y #####");
						}else{
							conHVal = Float.parseFloat(alertNewLawList.get(i).getItemValueHi());						
						}
					}else if("DOW00".equals(tCode)){
						if(!"".equals(alertNewLawList.get(i).getDrySeasonYn()) && "Y".equals(alertNewLawList.get(i).getDrySeasonYn()) && 
						  ((null != alertNewLawList.get(i).getDrySeasonFromMm() && Integer.parseInt(alertNewLawList.get(i).getDrySeasonFromMm()) <= curMm) && 
						   (null != alertNewLawList.get(i).getDrySeasonToMm()   && Integer.parseInt(alertNewLawList.get(i).getDrySeasonToMm()) >= curMm))){
							dowLVal = Float.parseFloat(alertNewLawList.get(i).getItemDryValueLo());
							log.debug("##### 갈수기적용여부[DOW] :: Y #####");
						}else{
							dowLVal = Float.parseFloat(alertNewLawList.get(i).getItemValueLo());					
						}
					}
				}
			}
			if (alertNewLawList != null) {
				/***
				 *  경계 : 전기전도도가 3배 이상 초과시 (변경됨, 현재 없어짐)
				 *  주의 : 수소이온농도 pH(phy), 전기전도도 EC(con), 용존산소량 DO(dow) 중 2개 이상이 2배 이상 초과시
				 *  		(단;수소이온농도 pH(phy)는 5 이하 또는 11 이상)
				 *  관심 : 수소이온농도 pH(phy), 전기전도도 EC(con), 용존산소량 DO(dow) 중 2개 이상이 기준 초과시
				 ***/
				/*
				int lawCount = 0;
				if (con >= (conHVal*3)) {
					itemCode = itemCodeCon;
					minVl = con;
					minOr = "3";
				} else {
					log.debug("###dow="+dow+"&dowLVal/2="+dowLVal/2 );
					
					if (con >= (conHVal*2)) {flagCon = 1;lawCount++;}
					if (dow < (dowLVal/2)) {flagDow = 1;lawCount++;}
					if (phy < 5 || phy > 11){flagPhy = 1;lawCount++;}
				
					if (lawCount > 1) {
						minOr = "2";
						lawCount = 0;
					} else {
						if (con >= conHVal) {flagCon = 1;lawCount++;}
						if (dow < dowLVal) {flagDow = 1;lawCount++;}
						if (phy < phyLVal || phy > phyHVal){flagPhy = 1;lawCount++;}
						if (lawCount > 1) {minOr = "1";
						} else {minOr = "0";}
					}
				}
				*/
				int lawCount = 0;
				
				if (con >= (conHVal*2)) {flagCon = 1;lawCount++;}					// 전기전도도가 기준치 두배이상
				if (dow < (dowLVal/2)) {flagDow = 1;lawCount++;}					// 용존산소가 기준치 절반 미만
				if (phy < 5 || phy > 11){flagPhy = 1;lawCount++;}					// PH가 5미만 또는 11초과 
			
				if (lawCount > 1) {													// 위 조건 2개 이상인 경우 '주의'
					minOr = "2";													// 주의는 minOr 값을 2로 설정
					lawCount = 0;
				} else {
					if (con >= conHVal) {flagCon = 1;lawCount++;}					// 전기전도도가 기준최대치보다 높은 경우
					if (dow < dowLVal) {flagDow = 1;lawCount++;}					// 용존산소가 기준최저치보다 낮은 경우
					if (phy < phyLVal || phy > phyHVal){flagPhy = 1;lawCount++;}	// PH가 기준 최저치보다 낮거나 최대치보다 높은 경우
					if (lawCount > 1) {minOr = "1";									// 기준 초과미만항목이 2개 이상일 경우 '관심'
					} else {minOr = "0";}											// 기준 초과미만항목이 1개 이하일 경우 '아무것도 안함!'
				}
				
				log.debug("###############ROW_DATA##################");           
				log.debug("phy === " + phy);
				log.debug("dow === " + dow);
				log.debug("con === " + con);
				log.debug("###############ROW_DATA##################");	
				log.debug("###############기준값####################");	   
				log.debug("phyHVal === " + phyHVal);
				log.debug("phyLVal === " + phyLVal);
				log.debug("conHVal === " + conHVal);
				log.debug("dowLVal === " + dowLVal); 
				log.debug("###############기준값####################");
				log.debug("###############VALUE_RESULT###############");
				log.debug("flagPhy === " + flagPhy);
				log.debug("flagDow === " + flagDow);
				log.debug("flagCon === " + flagCon);
				log.debug("###############VALUE_RESULT###############"); 
				
				if ( "1".equals(minOr) || "2".equals(minOr) ){ 			//MIN_OR(1:관심2:주의)
					if(flagPhy == 1 && flagDow == 1 && flagCon == 1)	//CASE 1. PH/DO/EC 이상일경우
					{
						itemCode = itemCodePhy;
						itemCode1 = itemCodeDow;
						itemCode2 = itemCodeCon;
						minVl = phy;
						minVl1 = dow;
						minVl2 = con;
					}
					if (flagPhy == 1 && flagDow == 1) {					//CASE 2. PH/DO 이상일경우
						itemCode = itemCodePhy;
						itemCode1 = itemCodeDow;
						minVl = phy;
						minVl1 = dow;
					} else if (flagPhy == 1 && flagCon == 1){			//CASE 3. PH/EC 이상일경우
						itemCode = itemCodePhy;
						itemCode1 = itemCodeCon;
						minVl = phy;
						minVl1 = con;
					} else if (flagDow == 1 && flagCon == 1){			//CASE 4. DO/EC 이상일경우
						itemCode = itemCodeDow;
						itemCode1 = itemCodeCon;	
						minVl = dow;
						minVl1 = con;
					}else{												//CASE 5. 2개 이상이 아닌 경우 아무것도 안함!
						minOr = "0";									//이 경우는 관심도 주의도 아닌 상황
					}
					alertSearchVO.setItemCode(itemCode1); //search 값 셋팅
					itemName1 = alertMakeDAO.getItemName(alertSearchVO);
					
					alertStepVO.setExcessItemCode(itemCode1); 
					alertStepVO.setExcessMinVl(minVl1); 
					if(!"".equals(itemCode2))
					{
						alertSearchVO.setItemCode(itemCode2);
						itemName2 = alertMakeDAO.getItemName(alertSearchVO);
						
						alertStepVO.setExcessItemCode_2(itemCode2);
						alertStepVO.setExcessMinVl_2(minVl2);
					}
					
				}
			
				//사고 조치 테이블 인서트용
				alertStepVO.setItemCode(itemCode);
				alertStepVO.setMinVl(minVl);
				
				factName = alertMakeDAO.getFactName(alertSearchVO);
				branchName = alertMakeDAO.getBranchName(alertSearchVO);
				
				alertSearchVO.setItemCode(itemCode);
				itemName = alertMakeDAO.getItemName(alertSearchVO);
			 
			} else {
				minOr = "0";
				log.debug(" alertLawVO === null 이다");
				alertStepVO.setAlertStepText("상황전파불가능 : 수질 기준 설정이 존재하지 않습니다.");
			} 
			
			boolean continueFlag = true;
			
			// 기준초과 이상일 때
			if (Integer.parseInt(minOr) > 0)
			{
				// update table min_real set minOr
				HashMap updateMap = new HashMap();
				updateMap.put("minOr", minOr);
				updateMap.put("factCode", factCode);
				updateMap.put("branchNo", branchNo);
				updateMap.put("itemCode", itemCode);
				updateMap.put("minTime", minTime);
				
				alertMakeDAO.updateMinOr(updateMap);		// T_MIN_DATA의 minOr 값 업데이트 
					
				if(!"".equals(itemCode1))
				{
					updateMap.put("itemCode", itemCode1);	// T_MIN_DATA의 minOr 값 업데이트
					alertMakeDAO.updateMinOr(updateMap);
				}
				else if(!"".equals(itemCode2))
				{
					updateMap.put("itemCode", itemCode2);	// T_MIN_DATA의 minOr 값 업데이트
					alertMakeDAO.updateMinOr(updateMap);
				}
				/*
				alertStepVO.setMinOr(minOr);
				
				AlertConfigVO alertConfigVO = alertMakeDAO.getConfig(alertSearchVO);
				
				if (alertConfigVO != null)
				{
					alertSms = alertConfigVO.getSmsFlag();
					alertAcs = alertConfigVO.getArsFlag();
					alertTerm = alertConfigVO.getAlertTerm();
					
					if (alertSms != null || alertAcs != null)
					{ 
						alertFlag = 1; 
					}
				}
				*/
				alertFlag = 1;
				// 경보 발령 대상자의 단계별 추출을 위하여
				alertSearchVO.setMinOr(minOr);								

				continueFlag = true;
				
				//현재 데이터 이전 30분의 데이터를 가져와서 기준 초과 여부를 체크한다.	
				//if (alertLawVO != null)
				log.debug("####30분전 if###");
				if(alertNewLawList != null)
				{ 			
					/*
					Float phyHVal 	= alertLawVO.getPhyHVal();
					Float phyLVal 	= alertLawVO.getPhyLVal();
					Float conHVal 	= alertLawVO.getConHVal();
					Float dowLVal 	= alertLawVO.getDowLVal();
					*/
					List<AlertMinVO> preList = alertMakeDAO.getMinPreUsnList(alertStepVO);
					
					log.debug("USN PRE LIST SIZE - " + preList.size());
					
					int preLawCount = 0; // preList 중에 한번이라도 기준치 이상인 경우 '지속' 여부 체크하기 위함
					for(AlertMinVO preVo : preList) {
						
						int preFlag = 0;								
			            Float prePhy		= preVo.getPhy(); //pH 수소이온농도
			            Float preDow		= preVo.getDow(); //DO 용존산소
			            Float preCon		= preVo.getCon(); //EC 전기전도도			            
					
						/***
						 *  경계 : 전기전도도가 3배 이상 초과시
						 *  관심 : 수소이온농도 pH(phy), 전기전도도 EC(con), 용존산소량 DO(dow) 중 2개 이상이 기준 초과시
						 *  주의 : 수소이온농도 pH(phy), 전기전도도 EC(con), 용존산소량 DO(dow) 중 2개 이상이 2배 이상 초과시
						 *  		(단;수소이온농도 pH(phy)는 5 이하 또는 11 초과)
						 ***/
			            /*
						int lawCount = 0;
						if (preCon >= (conHVal*3))
						{
							preFlag = 3;
						} else 
						{
							if (preCon >= (conHVal*2)) {lawCount++;}
							if (preDow < (dowLVal/2)) {lawCount++;}
							if (prePhy < 5 || prePhy > 11){lawCount++;}
							if (lawCount > 1) 
							{
								preFlag = 2;
							} 
							else 
							{
								if (preCon >= conHVal) {lawCount++;}
								if (preDow < dowLVal) {lawCount++;}
								if (prePhy < phyLVal ||prePhy > phyHVal){lawCount++;}
								if (lawCount > 1) {
									preFlag = 1;
								}
							}
						}
						*/
			            int lawCount = 0;
			            if (preCon >= (conHVal*2)) {lawCount++;}
						if (preDow < (dowLVal/2)) {lawCount++;}
						if (prePhy < 5 || prePhy > 11){lawCount++;}
						if (lawCount > 1)											// 기준치 2배 이상이 2개 이상 >> '주의'
						{
							preFlag = 2;
							preLawCount += 1;
						} 
						else 														// 나머지 중에...
						{
							if (preCon >= conHVal) {lawCount++;}
							if (preDow < dowLVal) {lawCount++;}
							if (prePhy < phyLVal ||prePhy > phyHVal){lawCount++;}
							if (lawCount > 1) {										// 기준치 이상이 2개 이상 >> '관심'
								preFlag = 1;
								preLawCount += 1;
							}
						}
						if(preFlag == 0) {											// '주의', '관심' 이 아닌 경우
							//30분동안 지속되지 않음
							// continueFlag = false;	// 이 값은 for문 밖에서 처리해야 할 듯함.
							//alertFlag = 0;
							// break;					// break 의 사용 대신 else로 처리 
						} else {													// 지속된 값 로깅처리
							log.debug("###############PRE_ROW_DATA##################");           
							log.debug("phy === " + phy);
							log.debug("dow === " + dow);
							log.debug("con === " + con);
							log.debug("###############PRE_ROW_DATA##################");	
							log.debug("###############기준값########################");	   
							log.debug("phyHVal === " + phyHVal);
							log.debug("phyLVal === " + phyLVal);
							log.debug("conHVal === " + conHVal);
							log.debug("dowLVal === " + dowLVal); 
							log.debug("###############기준값########################");
							log.debug("###############PRE_VALUE_RESULT##############");
							log.debug("flagPhy === " + flagPhy);
							log.debug("flagDow === " + flagDow);
							log.debug("flagCon === " + flagCon);
							log.debug("###############PRE_VALUE_RESULT##############"); 
						}
					}
					if(preLawCount ==  0){	// for문에서 기준치 이상이 한번도 발생하지 않은 경우 
						continueFlag = false;	// SMS메시지에 '지속' 이라는 단어를 추가하지 않기 위함
					}
					
				}	
				
				// 해당 공구 아이템의 완료되지 않은 마지막 전파 내용 (alert_step = 1)
				AlertStepLastVO alertStepLastVO = alertStepDAO.getLastAlert(alertStepVO);				
			
				if (alertFlag == 1 && alertStepLastVO != null){
					
					String alertTime = alertStepLastVO.getAlertTime();
					log.debug("getLastAlert Time :: "+ alertTime);
					
					/* 이 방식은 아래 before에서 무조건 else를 타게됨
					int year = Integer.valueOf(alertTime.substring(0,4));
					int month = Integer.valueOf(alertTime.substring(4,6));
					int day = Integer.valueOf(alertTime.substring(6,8));
					int hour = Integer.valueOf(alertTime.substring(8,10));
					int min = Integer.valueOf(alertTime.substring(10,12));
					*/
					
					//지난 경보발령시간
			        Calendar beforeAlertTime = Calendar.getInstance(); 			
			        //beforeAlertTime.set(year, month, day, hour, min);
			        beforeAlertTime.setTime(new SimpleDateFormat("yyyyMMddHHmm").parse(alertTime));
			        
			        beforeAlertTime.add(Calendar.MINUTE, 30); //지난 경보발령시간에 30분 추가
			               
			        //현재시간
			        Date currentDate = new Date(System.currentTimeMillis());
			        Calendar current = Calendar.getInstance(); 
			        current.setTime(currentDate);
			        
			        if (beforeAlertTime.before(current) || beforeAlertTime.equals(current)) //지난 경보발령으로부터 30분이 지났음
			        { 
			        	alertFlag = 1;
			        } 
			        else //30분이 지나지 않았으면 전파하지 않음
			        {
			        	alertFlag = 0;
			        }
				}
			}// end if (Integer.parseInt(minOr) > 0)
			log.debug("alertFlag ====== " + alertFlag);
			// 경보 발송
			if (alertFlag > 0) {
				
				// 경보 메시지를 만든다.
				String subject = "";
				String warnSmsSendFlg = "";
				StringBuffer smsMsg = new StringBuffer();
				StringBuffer smsMsgMinVl = new StringBuffer();
				
				if (alertSms != null) {		// 초기값이 ""이고 중간에 값의 변화가 없으므로 무조건 NULL이 아님
					
					if ("1".equals(minOr) ){						
						subject = subject+" 관심";
						smsMsg.append("USN(관심");
					} else if ("2".equals(minOr) ){
						subject = subject+" 주의";
						smsMsg.append("USN(주의");
					} else if ("3".equals(minOr) ){		// 3 '경계' 단계는 위에 로직에는 없음.
						subject = subject+" 경계";
						smsMsg.append("USN(경계");
					} 
					
					if (continueFlag) {
						smsMsg.append(" 지속) ");
					} else {
						smsMsg.append(" 발생) ");
					}
					
					smsMsg //.append(factName).append("-")
					.append(branchName).append(branchNo)
					// .append(" ").append(minTime.substring(2, 4)) // 년
					.append(" ").append(minTime.substring(4, 6))
					.append("/").append(minTime.substring(6, 8))
					.append(" ").append(minTime.substring(8, 10))
					.append(":").append(minTime.substring(10, 12));
					
					smsMsgMinVl.append(" 현재 ").append(itemCode.substring(0,2).toLowerCase())
					.append("(").append(String.format("%.2f", minVl)).append(")");
				
					if (!"".equals(itemName1)) smsMsgMinVl.append(" ").append(itemCode1.substring(0,2).toLowerCase()).append(" ");
					smsMsgMinVl.append("(").append(String.format("%.2f", minVl1)).append(")");
								
					if (!"".equals(itemName2)) smsMsgMinVl.append(" ").append(itemCode2.substring(0,2).toLowerCase()).append(" ");
					smsMsgMinVl.append("(").append(String.format("%.2f", minVl2)).append(")");
					
					alertDataVO.setSubject(subject);
					//데이터 검증
					//alertData(alertDataVO.getFactCode(),alertSearchVO.getBranchNo(),alertSearchVO.getItemCode(),alertDataVO.getMinTime(),"S",smsMsg.toString(),smsMsgMinVl.toString(),alertFlag);
					
					//사전조치 통계를 내기위해 T_WARNING_SEND_DATA 테이블에 넣어줌
					AlertSendDataVO 	send = new AlertSendDataVO();
					send.setFactCode(factCode);
					send.setRiverId("R0"+factCode.substring(3, 4)); 
					send.setFactName(factName);
					send.setBranchNo(branchNo); 
					send.setItemCode(itemCode);	
					send.setMinTime(minTime);
					send.setAlertValue(minVl);
					send.setAlertStandard(minVl);
					send.setAlertMsg("");
					send.setMsgKind(ALERT_KIND_SMS);
					send.setAlertType(IPUSN);
					send.setMinOr(minOr);
					warnSmsSendFlg = "N";
					
					//2015-11-24 [측정소별 SMS설정에 따른 분기]
					//boolean smsSendCFlag = true;
					boolean smsSendBFlag = true;
					
					int currentHour = Integer.parseInt(CommonUtil.getCurrentDate("HH"));

					alertSearchVO.setDetCode(DET_CODE);
					
					/*
					//공통수신 SMS 설정 조회 및 SMS SEND
					AlertSmsCommVO alertSmsCommVO = alertMakeDAO.getSmsCommConf(detCode);
					if(alertSmsCommVO != null){
						if("Y".equals(alertSmsCommVO.getSend_use_flag()) &&
						  (currentHour >= Integer.parseInt(alertSmsCommVO.getNot_send_from()) && currentHour < Integer.parseInt(alertSmsCommVO.getNot_send_to()))){
							log.debug("##### 공통SMS::<SEND_USE_FLAG(Y)> ##### ");
							smsSendCFlag = false;
						}else{
							log.debug("##### 공통SMS::<SEND_USE_FLAG(N)> ##### ");
							smsSendCFlag = true;
						}
					}
					// 공통수신sms발송
					if(smsSendCFlag){
						alertSendSms(alertSearchVO, alertDataVO, alertStepVO, alertFlag, smsMsg.toString(), smsMsgMinVl.toString(), alertSmsCommVO);						
					}
					*/
					
					//측정소별 SMS 설정 조회 및 SMS SEND
					AlertSmsBranchVO alertSmsBranchVO = alertMakeDAO.getSmsBranchConf(alertSearchVO);
					if(alertSmsBranchVO != null){
						if("Y".equals(alertSmsBranchVO.getSend_use_flag()) &&
						  (currentHour >= Integer.parseInt(alertSmsBranchVO.getNot_send_from()) && currentHour < Integer.parseInt(alertSmsBranchVO.getNot_send_to()))){
							log.debug("##### 측정소SMS::<SEND_USE_FLAG(Y)> ##### ");
							smsSendBFlag = false;
						}else{
							log.debug("##### 측정소SMS::<SEND_USE_FLAG(N)> ##### ");
							smsSendBFlag = true; // Flag 값이 N 인경우 (보내지않는시간을 사용하지 않는경우 SMS 를 다 보내라)
						}
					}
					// 측정소sms발송
					if(smsSendBFlag){
						warnSmsSendFlg = "Y";
						alertSendSms(alertSearchVO, alertDataVO, alertStepVO, alertFlag, smsMsg.toString(), smsMsgMinVl.toString(), alertSmsBranchVO);						
					}
					
					// 통계를 기록하기 위해 T_WARNING_SEND_DATA 테이블에 기록
					if("N".equals(warnSmsSendFlg) || "Y".equals(warnSmsSendFlg)){
						alertSmsSendData(send, null, warnSmsSendFlg, smsMsg.toString());
					}
					
				} // if (alertSms != null) 
				
				if (alertAcs != "") {
								
					smsMsg.append("안녕하십니까? 한국환경공단 방제센터입니다...");
					
					if ("1".equals(minOr) ){						
						subject = subject+" 관심";
						smsMsg.append("USN 관심");
					} else if ("2".equals(minOr) ){
						subject = subject+" 주의";
						smsMsg.append("USN 주의");
					} /*else if ("3".equals(minOr) ){
						subject = subject+" 경계";
						smsMsg.append("USN 경계");
					} */
					
					if (continueFlag) {
						smsMsg.append(" 지속 ");
					} else {
						smsMsg.append(" 발생 ");
					}
					
					smsMsg.append(factName).append(" ").append(branchNo)
					.append("번 측정소에서").append(minTime.substring(0, 4))
					.append("년").append(minTime.substring(4, 6))
					.append("월").append(minTime.substring(6, 8))
					.append("일").append(minTime.substring(8, 10))
					.append("시").append(minTime.substring(10, 12))
					.append("분에").append(subject).append(" 경보가 발령되었습니다.");
					
					smsMsgMinVl.append("측정치는 ").append(itemName).append(" ").append(minVl);
					
					if (!"".equals(itemName1)) smsMsgMinVl.append(" ").append(itemName1).append(" ");
					if (minVl1 > 0) smsMsgMinVl.append(minVl1);
								
					if (!"".equals(itemName2)) smsMsgMinVl.append(" ").append(itemName2).append(" ");
					if (minVl2 > 0) smsMsgMinVl.append(minVl2);
					
					smsMsgMinVl.append("입니다.");
																								
					alertDataVO.setSubject(subject);
					
					//DATA검증 
					
					//사전조치 통계를 내기위해 T_WARNING_SEND_DATA 테이블에 넣어줌
					AlertSendDataVO 	send = new AlertSendDataVO();
					send.setFactCode(factCode);
					send.setRiverId("R0"+factCode.substring(3, 4)); 
					send.setFactName(factName);
					send.setBranchNo(branchNo); 
					send.setItemCode(itemCode);	
					send.setMinTime(minTime);
					send.setAlertValue(minVl);
					send.setAlertStandard(minVl); 
					send.setSendFlag("Y"); // Y를 넣어서 스케쥴러에서 mysql인서트를 하지 않게함
					send.setAlertMsg("");
					send.setMsgKind("ARS");
					send.setAlertType("IPUSN"); 
					send.setMsg("");				
					send.setMinOr(minOr);				
					alertVmsSendData(send, null);
					
					// ACS발송
					alertSendVms (alertSearchVO, alertDataVO,alertStepVO, alertFlag, smsMsg.toString(), smsMsgMinVl.toString());
					
				} // end if (alertAcs != null)
				
				//유하속도예측하여예경보날릴때 쓸 메쏘드
				//alertMakeForecast(alertSearchVO, alertDataVO, alertStepVO, smsMsg.toString(), smsMsgMinVl.toString());
				
			}//end if (alertFlag > 0)
		}catch(Exception e){
			e.printStackTrace();
			log.error(" AlertBySchdlrImpl 스케줄러 alertMakeU() 에러 : " + e.getMessage());
		}
	}	
	
	/**
	 * SMS 날리기
	 * 
	 * @param alertSearchVO
	 * @param alertDataVO
	 * @param alertStepVO
	 * @param alertFlag
	 * @param smsMsg
	 * @param smsMsgMinVl
	 */
	private void alertSendSms (AlertSearchVO alertSearchVO, AlertDataVO alertDataVO, AlertStepVO alertStepVO, int alertFlag, String smsMsg, String smsMsgMinVl, AlertSmsBranchVO alertSmsBranchVO){	
		try {
			// sms 보내는 담당자 번호  1666-0128
			AlertCallBackVO alertCallBackVO = alertMakeDAO.getCallBack(alertSearchVO);
			alertDataVO.setCallBack(alertCallBackVO.getCallBackTel());
			// 경보 발령 대상자를 추출한다.
			alertSearchVO.setDetCode(DET_CODE);
			
			List<AlertTargetVO> alertTargetList = new ArrayList<AlertTargetVO>();
			
			/*
			if(alertSmsBranchVO != null && "C".equals(alertSmsBranchVO.getGubun())){
				alertTargetList = alertMakeDAO.getTargetCommSmsList(alertSearchVO);
				log.debug("##### 공통>경보발령대상자 :: "+alertTargetList.size());
			}
			*/
			
			if(alertSmsBranchVO != null && "B".equals(alertSmsBranchVO.getGubun())){
				alertTargetList = alertMakeDAO.getTargetBranchSmsList(alertSearchVO);
				log.debug("##### 측정소>경보발령대상자 :: "+alertTargetList.size());
			}
			if(alertTargetList.size() > 0 ) {
				int insertCount = 0;
				for (int j=0; j < alertTargetList.size(); j++) {
					AlertTargetVO alertTargetVO = (AlertTargetVO)alertTargetList.get(j);
					
					String atPart = alertTargetVO.getAtPart();//deptNoName
					String atPartGubun = alertTargetVO.getAtPartGubun();
					String atName = alertTargetVO.getAtName();//memberName
					//String atSms = alertTargetVO.getAtSms();
					String atSmsTele = alertTargetVO.getAtSmsTele();//mobileNo
					
					alertDataVO.setDestInfo(atName+"^"+atSmsTele);
					alertDataVO.setPart(atPart);
					alertDataVO.setToTel(atSmsTele.replace("-", ""));
					alertDataVO.setSendDate(alertSmsBranchVO.getChk_time());
					
					if ("1".equals(atPartGubun)) {
						alertDataVO.setSmsMsg(smsMsg);
					} else {
						alertDataVO.setSmsMsg(smsMsg+smsMsgMinVl);
					}
					if("Y".equals(alertSmsBranchVO.getTime_use_flag())){
						int sendCount = alertDAO.sendSmsCycleCheck(alertDataVO);
						if(sendCount == 0 ){
							alertDAO.insertSmsSend(alertDataVO);
							log.debug("SMS 경보발생 송신주기 동일("+sendCount+")건 으로인한 송신 ");
							insertCount++;
						}else{
							log.debug("SMS 경보발생 송신주기 동일("+sendCount+")건 으로인한 미송신 ");
						}
					}else{
						// 경보 대상자 별로 mySql에 인서트 한다.
						alertDAO.insertSmsSend(alertDataVO);
						insertCount++;
					}
				}//end for (int j=0; j < alertTargetList.size(); j++)
				
				if (insertCount>0) {
					//초기 경보등록은 "1"으로 시작함 - KGB
					alertStepVO.setAlertStep("1");
					alertStepVO.setAlertStepText(alertDataVO.getSubject() + " 경보가 정상적으로 발령되었습니다.<br>발송내용:"+alertDataVO.getSmsMsg());
				} else {
					alertStepVO.setAlertStep("9");
					alertStepVO.setAlertStepText("상황전파불가능 : SMS받을 경보 발령 대상자가 존재하지 않습니다.");
				}
			}else {
				//경보 대상자 없을 때 처리
				log.debug("======경보받을대상자없음=======");
				alertStepVO.setAlertStep("9");
				alertStepVO.setAlertStepText("상황전파불가능 : 경보 발령 대상자가 존재하지 않습니다.");
			}//end if (alertTargetList.size() > 0)								
			//사고 조치 테이블(T_Alert_Step)에 인서트 :alertFlag == 0 일때는 입력,수정 안 함. 
			if (alertFlag == 1) {
				String asId = (String)alertStepDAO.getMaxAsId();
				alertStepVO.setAsId(asId);
				alertStepDAO.insertAlertStep(alertStepVO);
				alertStepDAO.insertAlertStepSub(alertStepVO);
			} else if (alertFlag > 1) { //연속데이터는 업데이트만 
				
				if(!AlertCntUpdateFlag)
				{
					alertStepDAO.updateLastAlertStep(alertStepVO);				
					AlertCntUpdateFlag = true;
				}
			}
			
		} catch(Exception e){
			e.printStackTrace();
			log.error(" AlertBySchdlrImpl 스케줄러 alertSendSms() 에러 : " + e.getMessage());
		}
	}
	private void alertData(String fact,int branch,String itemcode,String mintime,String alramType,String smsMsg, String smsMsgMinVl, int alertFlag){	
		try {  
			//???? 왜 없는 테이블에 인서트를? - KGB
//			HashMap<String, String> map = new HashMap<String, String>();
//    		map.put("FACT_CODE", fact);
//    		map.put("BRANCH_NO",String.valueOf(branch) ); 
//    		map.put("ITEM_CODE", itemcode); 
//    		map.put("MIN_TIME", mintime); 
//    		map.put("ALARM_TYPE", alramType); 
//    		map.put("ALERT_VALUE", smsMsgMinVl); 
//    		map.put("ALERT_FLAG", String.valueOf(alertFlag)); 
//    		map.put("MSG", smsMsg); 
//			alertMakeDAO.saveAlertData(map);  
		} catch(Exception e){
			e.printStackTrace();
			log.error(" AlertBySchdlrImpl 스케줄러 alertSendSms() 에러 : " + e.getMessage());
		}
	}
	
	
	/**
	 * IP-USN 미수신SMS 날리기
	 * 
	 * @param alertSearchVO
	 * @param alertDataVO
	 * @param alertStepVO
	 * @param alertFlag
	 * @param smsMsg
	 * @param smsMsgMinVl
	 */
	/*
	private void alertSendSms (AlertStepVO vo, String smsMsg){	
		try {

			AlertSearchVO alertSearchVO = new AlertSearchVO();
			
			alertSearchVO.setBranchNo(vo.getBranchNo());
			alertSearchVO.setFactCode(vo.getFactCode());
			alertSearchVO.setMinOr("5");
			
			
			AlertDataVO alertDataVO = new AlertDataVO();
			alertDataVO.setFactCode(vo.getFactCode());
			alertDataVO.setBranchNo(vo.getBranchNo());
			alertDataVO.setMinTime(vo.getMinTime());
			alertDataVO.setItemCode("NRECV"); //전파이력조회 자동전파 구분위해 넣어줍니다.
			alertDataVO.setSubject("미수신측정소전파");
			
			
			// sms 보내는 담당자 번호  1666-0128
			AlertCallBackVO alertCallBackVO = alertMakeDAO.getCallBack(alertSearchVO);
			alertDataVO.setCallBack(alertCallBackVO.getCallBackTel());

			// 경보 발령 대상자를 추출한다.
			List<AlertTargetVO> alertTargetList = alertMakeDAO.getTargetList(alertSearchVO);
			if(alertTargetList.size() > 0) {
				int insertCount = 0;
				for (int j=0; j < alertTargetList.size(); j++) {
					AlertTargetVO alertTargetVO = (AlertTargetVO)alertTargetList.get(j);
					
					String atPart = alertTargetVO.getAtPart();
					String atPartGubun = alertTargetVO.getAtPartGubun();
					String atName = alertTargetVO.getAtName();
					String atSms = alertTargetVO.getAtSms();
					String atSmsTele = alertTargetVO.getAtSmsTele();
					
					if (atSms != null){
						alertDataVO.setDestInfo(atName+"^"+atSmsTele);
						alertDataVO.setPart(atPart);
					
						alertDataVO.setSmsMsg(smsMsg);

						// 경보 대상자 별로 mySql에 인서트 한다.
						alertDAO.insertSmsSend(alertDataVO);
						insertCount++;
					}
				}
				
			}else {
				log.debug("======경보받을대상자없음=======");
			}
									
		} catch(Exception e){
			e.printStackTrace();
			log.error(" AlertBySchdlrImpl 스케줄러 alertSendSms() 에러 : " + e.getMessage());
		}
	}
	
	*/
	
	/**
	 * ACS 날리기
	 * 
	 * @param alertSearchVO
	 * @param alertDataVO
	 * @param alertStepVO
	 * @param alertFlag
	 * @param smsMsg
	 * @param smsMsgMinVl
	 */
	private void alertSendVms (AlertSearchVO alertSearchVO, AlertDataVO alertDataVO, AlertStepVO alertStepVO, int alertFlag, String smsMsg, String smsMsgMinVl){	
		try {
			// sms 보내는 담당자 번호  1666-0128
			AlertCallBackVO alertCallBackVO = alertMakeDAO.getCallBack(alertSearchVO);
			alertDataVO.setCallBack(alertCallBackVO.getCallBackTel());

			// 경보 발령 대상자를 추출한다.
			List<AlertTargetVO> alertTargetList = alertMakeDAO.getTargetList(alertSearchVO);
			if(alertTargetList.size() > 0) {
				int insertCount = 0;
				for (int j=0; j < alertTargetList.size(); j++) {
					AlertTargetVO alertTargetVO = (AlertTargetVO)alertTargetList.get(j);
					
					String atPart = alertTargetVO.getAtPart();
					String atPartGubun = alertTargetVO.getAtPartGubun();
					String atName = alertTargetVO.getAtName();
					String atAcs = alertTargetVO.getAtArs();
					String atAcsTele = alertTargetVO.getAtArsTele();
					String atSmsTele = alertTargetVO.getAtSmsTele();
					
					if (atAcs != null){
						// 현재는 ACS를 SMS의 핸드폰번호로 발송하도록 함.
						//alertDataVO.setDestInfo(atName+"^"+atAcsTele);
						alertDataVO.setDestInfo(atName+"^"+atSmsTele);
						alertDataVO.setPart(atPart);
						
						if ("1".equals(atPartGubun)) {
							alertDataVO.setSmsMsg(smsMsg);
						} else {
							alertDataVO.setSmsMsg(smsMsg+smsMsgMinVl);
						}
						
						// 경보 대상자 별로 mySql에 인서트 한다.
						//ARS 일시 중지 2010.08.20
						alertDAO.insertVmsSend(alertDataVO);
						insertCount++;
					}
				}//end for (int j=0; j < alertTargetList.size(); j++)
				
				if (insertCount>0) {
					alertStepVO.setAlertStep("1");
					alertStepVO.setAlertStepText(alertDataVO.getSubject() + " ACS 경보가 정상적으로 발령되었습니다.<br>발송내용:"+alertDataVO.getSmsMsg());
				} else {
					alertStepVO.setAlertStep("9");
					alertStepVO.setAlertStepText("상황전파불가능 : ACS 받을 경보 발령 대상자가 존재하지 않습니다.");
				}
			}else {
				//경보 대상자 없을 때 처리
				log.debug("======ACS경보받을대상자없음=======");
				alertStepVO.setAlertStep("9");
				alertStepVO.setAlertStepText("상황전파불가능 : ACS 경보 발령 대상자가 존재하지 않습니다.");
			}//end if (alertTargetList.size() > 0)
									
			//사고 조치 테이블(T_Alert_Step)에 인서트 :alertFlag == 0 일때는 입력,수정 안 함. 
			if (alertFlag == 1) {
				String asId = (String)alertStepDAO.getMaxAsId();
				alertStepVO.setAsId(asId);
				alertStepDAO.insertAlertStep(alertStepVO);
				alertStepDAO.insertAlertStepSub(alertStepVO);
			} else if (alertFlag > 1) { //연속데이터는 업데이트만 
				
				if(!AlertCntUpdateFlag)
				{
					alertStepDAO.updateLastAlertStep(alertStepVO);
					AlertCntUpdateFlag = true;
				}
			}
			
		} catch(Exception e){
			e.printStackTrace();
			log.error(" AlertBySchdlrImpl 스케줄러 alertSendVms() 에러 : " + e.getMessage());
		}
	}
	
	
	/**
	 * 취정수장에 예보 SMS 날리기 - 완벽하지 않음. 손봐야할 데가 많아요.
	 * 
	 * @param alertSearchVO
	 * @param alertDataVO
	 * @param alertStepVO
	 * @param smsMsg
	 * @param smsMsgMinVl
	 */
/**	
	private void alertMakeForecast (AlertSearchVO alertSearchVO, AlertDataVO alertDataVO, AlertStepVO alertStepVO, String smsMsg, String smsMsgMinVl){	
		try {
			
			// 유하속도 예측하여 해당 취정수장에 smsMsg 가공하여 발송
			// 쿼리 vo, 만들어야함.
			// List<alertFactVO> alertFactForecastList = alertMakeDAO.getFactForecastList(alertSearchVO);
			// if(alertFactForecastList.size() > 0) {
			// 	for (int i=0; i < alertFactForecastList.size(); i++) {
			//		AlertFactVO alertFactVO = (AlertFactVO)alertFactForecastList.get(i);
			//	 	String factName = alertFactVO.getFactName();
			//	 	String sMin = alertFactVO.getMin();
			//	 	smsMsg = smsMsg + factName + "에 약 " + sMin +"분 후 도착 예정";
			//		alertSearchVO.setFactCode(alertFactVO.getFactCode());
			//		alertSearchVO.setBranchNo(alertFactVO.getBranchNo());
			//		
			//
					// 경보 발령 대상 취정수장의 대상자를 추출한다. alertSearchVO 조건 확인필요함.
					alertSendSms (alertSearchVO, alertDataVO, alertStepVO, 0, smsMsg, smsMsgMinVl);
			
			
			//	}// end for (int i=0; i < alertFactForecastList.size(); i++)
			//}// end if(alertFactForecastList.size() > 0)
											
		} catch(Exception e){
			e.printStackTrace();
			log.error(" AlertBySchdlrImpl 스케줄러 alertMakeForecast() 에러 : " + e.getMessage());
		}
	}
********/	
}