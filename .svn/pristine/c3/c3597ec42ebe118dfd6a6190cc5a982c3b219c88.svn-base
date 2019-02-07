package daewooInfo.alert.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import daewooInfo.alert.bean.AlertCallBackVO;
import daewooInfo.alert.bean.AlertDataVO;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertSendDataVO;
import daewooInfo.alert.bean.AlertTargetVO;
import daewooInfo.alert.dao.AlertDAO;
import daewooInfo.alert.dao.AlertMakeDAO;
import daewooInfo.alert.dao.AlertSchDAO;
import daewooInfo.common.util.CommonUtil;
import daewooInfo.ipusn.bean.IpUsnVO;
import daewooInfo.smsmanage.bean.SmsBranchVO;



public class AlertIpUsnLeave extends QuartzJobBean{

	private static Log log = LogFactory.getLog(AlertIpUsnLeave.class);
	
	private static final String DET_CODE = "SMSCD004";
	private static final int DEFAULT_CHK_LOC = 200;
	private static final String SYS_KIND_IPUSN = "U";
	private static final String LEAVE = "LEAVE";
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
	 * @uml.property  name="alertSchDAO"
	 * @uml.associationEnd  
	 */
	protected AlertSchDAO alertSchDAO;

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
	 * IP-USN 10분 주기 중 위치이탈 측정소를 가져옵니다.
	 */
	@Override
    protected void executeInternal(JobExecutionContext ctx) throws JobExecutionException {

		log.debug("Start Alert by Scheduler!");
		
		try {			
			
			ipusnLeaveSend();
			
			
		}catch(Exception e){
			e.printStackTrace();
			log.error(" AlertIpUsnLeave 스케줄러 executeInternal() 에러 : " + e.getMessage());
		}
		
	}
	
	/**
	 * IP-USN 전송된 측정소의 FLAG를 해제합니다.
	 */
	/*
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
	*/
	
	
	
	
	/**
	 * IP-USN 위치이탈 측정소 SMS전송
	 */
	private void ipusnLeaveSend() {
		
		String factName = "";
		String branchName = "";
		
		try
		{	
			List<IpUsnVO> ipUsnList = alertSchDAO.getIpUsnList();				// 위치이탈 측정소 리스트
			int CHK_LOC = 0;													// 위치이탈 범위				

			for(IpUsnVO vo : ipUsnList){
				
				AlertSearchVO alertSearchVO = new AlertSearchVO();
			    alertSearchVO.setFactCode(vo.getFact_code());
			    alertSearchVO.setBranchNo(Integer.parseInt(vo.getBranch_no()));
			    factName   = alertMakeDAO.getFactName(alertSearchVO);
			    branchName = alertMakeDAO.getBranchName(alertSearchVO);
				
				boolean SendFlag = false;										// true일때 SMS를 보낸다.
				double dDistance = Double.MIN_VALUE;
				String smsMsg = "";
				String warnSmsSendFlg = "";
				
				SmsBranchVO smsBranchVo = new SmsBranchVO();
					
				smsBranchVo.setSys_kind(SYS_KIND_IPUSN);						// IPUSN
				smsBranchVo.setDet_code(DET_CODE);								// 검출코드 (미수신)
				smsBranchVo.setBranch_no(vo.getBranch_no());					// BRANCHNO
				smsBranchVo.setFact_code(vo.getFact_code());					// FACTCODE

				int countSmsUsnSetting = alertSchDAO.getSmsUsnSettingCnt(smsBranchVo);		// 측정소 SMS 관리 데이터

				if(countSmsUsnSetting != 0){
					smsBranchVo = alertSchDAO.getSmsUsnSetting(smsBranchVo);				// 측정소 SMS 관리 데이터
					
					// 보내는 시간
					if("Y".equals(smsBranchVo.getLoc_use_flag())){				// 위치이탈 범위 지정 사용 유무
						try{
							CHK_LOC = Integer.parseInt(smsBranchVo.getChk_loc());	// 위치이탈 범위
						}catch(Exception e){
							e.printStackTrace();
							CHK_LOC = DEFAULT_CHK_LOC;							// 이탈 범위 오류시 기본값으로
						}
					}else{
						CHK_LOC = DEFAULT_CHK_LOC;								// 기본 200M
					}

					// 위치이탈 범위 계산 (측정소와 장비 사이의 거리 몇 미터)
					dDistance = calDistance(vo, CHK_LOC);

					// 위치이탈 인 경우
					if(isLeaveUsn(dDistance, CHK_LOC, "0".equals(vo.latitude2))){
						
						warnSmsSendFlg = "N";
						
						// 문자를 보내지 않는 시간 체크
						SendFlag = isTimeToSendSms("Y".equals(smsBranchVo.getSend_use_flag())
										, smsBranchVo.getNot_send_from()
										, smsBranchVo.getNot_send_to());
					}
				}
				
				if(SendFlag){								// SMS 보내기
					String time = "0";
					if(vo.getInput_time() != null){
						time = vo.getInput_time();
						time = time.substring(4, 6) 		// 월 ,  time.substring(2, 4) 년
							+ "/" + time.substring(6, 8)
							+ " " + time.substring(8,10)
							+ ":" + time.substring(10,12);
					}
					smsMsg = "USN(이탈)"+branchName+vo.getBranch_no()+" "+time+" 현재 약 "+dDistance+"m 위치 이탈(좌표계산). 현장 확인 바람";
					
					warnSmsSendFlg = "Y";
					
					alertLeaveSendSms(vo, smsMsg, smsBranchVo);		// SMS 전송
				}
				
				// 통계와, 첫 위치이탈 전송을 기록하기 위해 T_WARNING_SEND_DATA 테이블에 기록
				if("N".equals(warnSmsSendFlg) || "Y".equals(warnSmsSendFlg)){
					alertSmsSendData(vo, null, warnSmsSendFlg, smsMsg);
				}
			}			
		}catch(Exception e){
			
			e.printStackTrace();
			log.error("AlertIpUsnLeave 스케줄러 ipusnLeaveSend() 에러 : " + e.getMessage());
		}
	}
	
	// SMS 보내지 않는 시간 사용 체크 
	private boolean isTimeToSendSms(boolean isEnableFlag, String fromTime, String toTime){
		if(isEnableFlag){													// flag 값이 Y 인경우 보내는 시간을 사용한다
			String curTime = CommonUtil.getCurrentDate("HH");				// 현재 시간(시)를 가져온다.
			if( Integer.parseInt(fromTime) <= Integer.parseInt(curTime) && 	// from이 지금시간보다 작거나 같으면
					Integer.parseInt(toTime) > Integer.parseInt(curTime)){	// 현재시간이 미전송시간에 크다면 
				return false;												// SMS를 보내지 않도록
			}else{
				return true;
			}
		}else{
			return true;													// Flag 값이 N 인경우 (보내지않는시간을 사용하지 않는경우 SMS 를 다 보내라)
		}
	}
	
	// 벗어난 거리가 기준 거리를 초과하였는지 확인
	private boolean isLeaveUsn(double dDistance, int CHK_LOC, boolean isEmptyLocation){
		if(dDistance > CHK_LOC){
			if(isEmptyLocation){
				return false;		// 위치없음
			}else{
				return true; 		// 위치이탈
			}
		}else{
			return false; 			// 위치정상
		}
	}
	
	// 위치이탈 범위 계산
	private double calDistance(IpUsnVO vo, int CHK_LOC){

		double Lat1 = Double.parseDouble(vo.getLatitude1());		// 측정소 위도
		double Long1 = Double.parseDouble(vo.getLongitude1());		// 측정소 경도
		double Lat2 = Double.parseDouble(vo.getLatitude2());		// 장비 위도
		double Long2 = Double.parseDouble(vo.getLongitude2());		// 장비 경도

		double dDistance = Double.MIN_VALUE;
		double dLat1InRad = Lat1 * (Math.PI / 180.0);
		double dLong1InRad = Long1 * (Math.PI / 180.0);
		double dLat2InRad = Lat2 * (Math.PI / 180.0);
		double dLong2InRad = Long2 * (Math.PI / 180.0);

		double dLongitude = dLong2InRad - dLong1InRad;
		double dLatitude = dLat2InRad - dLat1InRad;

		// Intermediate result a.
		double a = Math.pow(Math.sin(dLatitude / 2.0), 2.0) + 
				Math.cos(dLat1InRad) * Math.cos(dLat2InRad) * 
				Math.pow(Math.sin(dLongitude / 2.0), 2.0);

		double c = 2.0 * Math.atan2(Math.sqrt(a), Math.sqrt(1.0 - a));

		Double kEarthRadiusKms = 6376.5;
		dDistance = kEarthRadiusKms * c;

		dDistance = dDistance*1000;
		
		return dDistance;
	}
	
	/**
	 * 사전조치 통계를 위해 T_WARNING_SEND_DATA에 넣어줍니다... 여기의 데이터로 첫미수신기록을 확인합니다.
	 * @param alertStepVO
	 * @param sendData
	 * @param param
	 */
	protected int alertSmsSendData(IpUsnVO vo, Map param, String sendFlag, String smsMsg){
		
		AlertSendDataVO sendData = new AlertSendDataVO();
		sendData.setFactCode(vo.getFact_code());
		sendData.setRiverId("R0"+vo.getFact_code().substring(3, 4)); 
		sendData.setFactName(vo.getFact_name());
		sendData.setBranchNo(Integer.parseInt(vo.getBranch_no())); 
		sendData.setItemCode(LEAVE);	
		sendData.setMinTime(vo.getMin_time());
		sendData.setAlertValue(0F);
		sendData.setAlertStandard(50F); 
		sendData.setSendFlag(sendFlag); 		// Y 또는 N으로 문자를 전송했는지 여부를 구분
		sendData.setAlertMsg("");
		sendData.setMsgKind(ALERT_KIND_SMS);
		sendData.setAlertType(LEAVE);			// 위치이탈 전파
		sendData.setMinOr("5");
		sendData.setMsg(smsMsg);				// 문자 발송된 경우 메시지도 기록
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
					//String atPartGubun  = alertTargetVO.getAtPartGubun();
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
	 */
	private void alertLeaveSendSms (IpUsnVO vo, String smsMsg, SmsBranchVO smsBranchVo){	
		try {
			
			AlertSearchVO alertSearchVO = new AlertSearchVO();
			
			alertSearchVO.setBranchNo(Integer.parseInt(vo.getBranch_no()));
			alertSearchVO.setFactCode(vo.getFact_code());
			alertSearchVO.setMinOr("5");
			alertSearchVO.setDetCode(DET_CODE);
			
			AlertDataVO alertDataVO = new AlertDataVO();
			alertDataVO.setFactCode(vo.getFact_code());
			alertDataVO.setBranchNo( Integer.parseInt(vo.getBranch_no()));
			alertDataVO.setMinTime(vo.getMin_time());
			alertDataVO.setItemCode(LEAVE);	//전파이력조회 자동전파 구분위해 넣어줍니다.
			alertDataVO.setSubject("위치이탈측정소전파");
			
			// sms 보내는 담당자 번호  1666-0128
			AlertCallBackVO alertCallBackVO = alertMakeDAO.getCallBack(alertSearchVO);
			alertDataVO.setCallBack(alertCallBackVO.getCallBackTel());
			
			List<AlertTargetVO> alertTargetList = new ArrayList<AlertTargetVO>();
			
			// 경보 발령 대상자를 추출한다.
			if(smsBranchVo != null && "B".equals(smsBranchVo.getGubun())){
				alertTargetList = alertMakeDAO.getTargetBranchSmsList(alertSearchVO);
				log.debug("##### 측정소>위치이탈경보발령대상자 :: "+alertTargetList.size());
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
							log.debug("SMS 위치이탈 송신주기 동일("+sendCount+")건 으로인한 미송신 ");
						}
					}else{
						alertDAO.insertSmsSend(alertDataVO);
						log.debug("SMS 위치이탈 송신 (송신주기 사용안함) ");
					}
				}
			}else {
				log.debug("======경보받을대상자없음=======");
			}
			
		} catch(Exception e){
			e.printStackTrace();
			log.error(" AlertIpUsnLeave 스케줄러 alertLeaveSendSms() 에러 : " + e.getMessage());
		}
	}
	
}
