package daewooInfo.alert.service.impl;

import java.sql.Time;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;
import java.util.Map;













import m2soft.rdsystem.server.core.rddbagent.rdfile.Replace;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import daewooInfo.alert.bean.AlertCallBackVO;
import daewooInfo.alert.bean.AlertDataVO;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertSendDataVO;
import daewooInfo.alert.bean.AlertStepVO;
import daewooInfo.alert.bean.AlertTargetVO;
import daewooInfo.alert.dao.AlertConfigDAO;
import daewooInfo.alert.dao.AlertDAO;
import daewooInfo.alert.dao.AlertMakeDAO;
import daewooInfo.alert.dao.AlertSchDAO;
import daewooInfo.alert.dao.AlertStepDAO;
import daewooInfo.alert.dao.AlertTaksuConfigDAO;
import daewooInfo.common.util.CommonUtil;
import daewooInfo.smsmanage.bean.SmsBranchVO;

 

public class AlertIpUsnNorecv extends QuartzJobBean{

	private static Log log = LogFactory.getLog(AlertIpUsnNorecv.class);
	
	private static final String DET_CODE = "SMSCD001";
	private static final String SYS_KIND_IPUSN = "U";
	private static final String NOT_RECIVE = "NRECV";
	private static final String ALERT_KIND_SMS = "S";
	
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

	/**
	 * @uml.property  name="alertSchDAO"
	 * @uml.associationEnd  
	 */
	protected AlertSchDAO alertSchDAO;

	private AlertConfigDAO alertConfigDAO;
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

	
	public void setAlertConfigDAO(AlertConfigDAO alertConfigDAO) {
		this.alertConfigDAO = alertConfigDAO;
	}
	
	/**
	 * IP-USN 10분 주기 중 미수신 측정소를 가져옵니다.
	 */
	@Override
    protected void executeInternal(JobExecutionContext ctx) throws JobExecutionException {

		log.debug("Start Alert by Scheduler!");
		
		try {
			
			//IP-USN 수신 측정소 체크
			ipusnRecvChck();
			//IP-USN 미수신 측정소 체크
			ipusnNorecvSend();		
			
		}catch(Exception e){
			e.printStackTrace();
			log.error(" AlertIpUsnNorecv 스케줄러 executeInternal() 에러 : " + e.getMessage());
		}
		
	}
	
	/**
	 * IP-USN 전송된 측정소의 FLAG를 해제합니다.
	 */
	private void ipusnRecvChck()
	{
		try
		{
			List<AlertStepVO> recvList = alertSchDAO.getRecvList();
			
			for(AlertStepVO vo : recvList)
			{
				alertSchDAO.updateRecv(vo);
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			log.error(" AlertIpUsnNorecv 스케줄러 ipusnNorecvSend() 에러 : " + e.getMessage());
		}
	}
	
	
	
	
	/**
	 * IP-USN 미수신 측정소 SMS전송
	 */
	private void ipusnNorecvSend()
	{
		try
		{
			//미수신 측정소 리스트
			List<AlertStepVO> norecvList = alertSchDAO.getNorecvFirstList();

			String curTime = CommonUtil.getCurrentDate("HH");					// 현재 시간(시)를 가져온다.

			for(AlertStepVO vo : norecvList)
			{
				String SendFlag = "N";
				String warnSmsSendFlg = "";
				String smsMsg = "";
				String lastMinTime = "";
				SmsBranchVO smsBranchVo = new SmsBranchVO();

				smsBranchVo.setSys_kind(SYS_KIND_IPUSN);						// IPUSN
				smsBranchVo.setDet_code(DET_CODE);								// 검출코드 (미수신)
				smsBranchVo.setBranch_no(Integer.toString(vo.getBranchNo()));	// BRANCHNO
				smsBranchVo.setFact_code(vo.getFactCode());						// FACTCODE

				// 최종 수신 MIN_DATE 를 가져온다.
				lastMinTime = alertSchDAO.getLastRecvMinTime(vo);
				if(lastMinTime != null){
					vo.setMinTime(lastMinTime);
				}
				
				int settingCnt = alertSchDAO.getSmsUsnSettingCnt(smsBranchVo);		// 측정소 SMS 관리 데이터

				if(settingCnt != 0){
					smsBranchVo = alertSchDAO.getSmsUsnSetting(smsBranchVo);		// 측정소 SMS 관리 데이터
					
					if("Y".equals(smsBranchVo.getSend_use_flag())){												// flag 값이 Y 인경우
						if( Integer.parseInt(smsBranchVo.getNot_send_from()) <= Integer.parseInt(curTime) && 	// from이 지금시간보다 작거나 같으면
								Integer.parseInt(smsBranchVo.getNot_send_to()) > Integer.parseInt(curTime)){	// 현재시간이 미전송시간에 크다면 
							SendFlag = "N";																	// SMS를 보내지 않도록
						}else{
							SendFlag = "Y";
						}
					}else{
						SendFlag = "Y";									// Flag 값이 N 인경우 (보내지않는시간을 사용하지 않는경우 SMS 를 다 보내라)
					}
					vo.setAlertDelayTime(smsBranchVo.getChk_delay());	// 검출지연시간 세팅

					int isFirst = 0;									// 검출지연시간을 사용 안한다면 무조건 미수신전파를 시도하도록 기본값설정
					if("Y".equals(smsBranchVo.getDelay_use_flag())){
						isFirst = alertSchDAO.getIsNorecvFirstUsn(vo);	// 검출지연시간 사이에 미수신 내역의 카운트
					}

					if(isFirst == 0){
						warnSmsSendFlg = "N";
						
						if("Y".equals(SendFlag)){						// SMS 보내기
							String nowSysTime = CommonUtil.getCurrentDate("MM/dd HH:mm");
							String time = "";
							if(vo.getMinTime() == null){
								time = "1년 이상 미수신";
							}else{
								time = vo.getMinTime();
								time = time.substring(4, 6) + "/" 			// 월
										+ time.substring(6, 8) + " " 		// 일
										+ time.substring(8,10) + ":"		// 시 
										+ time.substring(10,12);			// 분
							}
							
							smsMsg = "USN(미수신)"+vo.getBranchName()+vo.getBranchNo()+" "+nowSysTime+" 현재 미수신. 최종수신 : " +time;
							
							warnSmsSendFlg = "Y";
							alertSendSms(vo, smsMsg, smsBranchVo);		// SMS 전송
						}
						
						// 통계와, 첫 미수신전송을 기록하기 위해 T_WARNING_SEND_DATA 테이블에 기록
						alertSmsSendData(vo, null, warnSmsSendFlg, smsMsg);
					}
				}
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
			log.error("AlertIpUsnNorecv 스케줄러 ipusnNorecvSend() 에러 : " + e.getMessage());
		}
	}
	
	
	
	/**
	 * 사전조치 통계를 위해 T_WARNING_SEND_DATA에 넣어줍니다... 여기의 데이터로 첫미수신기록을 확인합니다.
	 * @param alertStepVO
	 * @param sendData
	 * @param param
	 */
	protected int alertSmsSendData(AlertStepVO vo, Map param, String sendFlag, String smsMsg){

		AlertSendDataVO sendData = new AlertSendDataVO();
		sendData.setFactCode(vo.getFactCode());
		sendData.setRiverId("R0"+vo.getFactCode().substring(3, 4)); 
		sendData.setFactName(vo.getFactName());
		sendData.setBranchNo(vo.getBranchNo()); 
		sendData.setItemCode(NOT_RECIVE);	
		sendData.setMinTime(vo.getMinTime());
		sendData.setAlertValue(0F);
		sendData.setAlertStandard(50F); 
		sendData.setSendFlag(sendFlag); 		// Y 또는 N으로 문자를 전송했는지 여부를 구분
		sendData.setAlertMsg("");
		sendData.setMsgKind("SMS");
		sendData.setAlertType(NOT_RECIVE);			// 미수신 전파
		sendData.setMinOr("5");
		sendData.setMsg(smsMsg);					// 문자 발송된 경우 메시지도 기록
		sendData.setDetCode(DET_CODE);
		
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
					
					if(alertTargetVO.getAtSmsTele() !=null){
						sendData.setPart(atPart); 
						sendData.setSendName("방제정보시스템");
						sendData.setSendTel("1666-0128");
						sendData.setReceiveName(atName);
						sendData.setReceiveTel(atSmsTele);
						sendData.setAlertKind(ALERT_KIND_SMS);
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
	 * SMS 날리기
	 * 
	 * @param alertSearchVO
	 * @param alertDataVO
	 * @param alertStepVO
	 * @param alertFlag
	 * @param smsMsg
	 * @param string 
	 * @param smsMsgMinVl
	 */
	private void alertSendSms (AlertStepVO vo, String smsMsg, SmsBranchVO smsBranchVo){	
		try {

			AlertSearchVO alertSearchVO = new AlertSearchVO();
			
			alertSearchVO.setBranchNo(vo.getBranchNo());
			alertSearchVO.setFactCode(vo.getFactCode());
			alertSearchVO.setMinOr("5");
			alertSearchVO.setDetCode(DET_CODE);			
			
			AlertDataVO alertDataVO = new AlertDataVO();
			alertDataVO.setFactCode(vo.getFactCode());
			alertDataVO.setBranchNo(vo.getBranchNo());
			alertDataVO.setMinTime(vo.getMinTime());
			alertDataVO.setItemCode(NOT_RECIVE);	//전파이력조회 자동전파 구분위해 넣어줍니다.
			alertDataVO.setSubject("미수신측정소전파");			
			
			// sms 보내는 담당자 번호  1666-0128
			AlertCallBackVO alertCallBackVO = alertMakeDAO.getCallBack(alertSearchVO);
			alertDataVO.setCallBack(alertCallBackVO.getCallBackTel());
			
			List<AlertTargetVO> alertTargetList = new ArrayList<AlertTargetVO>();
			
			// 경보 발령 대상자를 추출한다.
			if(smsBranchVo != null && "B".equals(smsBranchVo.getGubun())){
				alertTargetList = alertMakeDAO.getTargetBranchSmsList(alertSearchVO);
				log.debug("##### 측정소>미수신경보발령대상자 :: "+alertTargetList.size());
			}
			if(alertTargetList.size() > 0) {
				for (int j=0; j < alertTargetList.size(); j++) {
					AlertTargetVO alertTargetVO = (AlertTargetVO)alertTargetList.get(j);
					
					String atPart = alertTargetVO.getAtPart();
					String atName = alertTargetVO.getAtName();
					String atSmsTele = alertTargetVO.getAtSmsTele();
					
					alertDataVO.setDestInfo(atName+"^"+atSmsTele);
					alertDataVO.setPart(atPart);
					alertDataVO.setSmsMsg(smsMsg);
					alertDataVO.setToTel(atSmsTele.replace("-", ""));
					
					// SMS 송신주기 설정
					if("Y".equals(smsBranchVo.getTime_use_flag())){
						int sendCount = 0;
						alertDataVO.setSendDate(smsBranchVo.getChk_time());
						sendCount = alertDAO.sendSmsCycleCheck(alertDataVO);
						if(sendCount == 0){
							alertDAO.insertSmsSend(alertDataVO);
						}else{
							log.debug("SMS 데이터 미수신 송신주기 동일("+sendCount+")건 으로인한 미송신 ");
						}
					}else{
						alertDAO.insertSmsSend(alertDataVO);
						log.debug("SMS 데이터 미수신 송신 (송신주기 사용안함) ");
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
	
}
