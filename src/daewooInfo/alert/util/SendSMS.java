package daewooInfo.alert.util;

import java.util.HashMap;
import java.util.List;

import daewooInfo.alert.bean.AlertCallBackVO;
import daewooInfo.alert.bean.AlertDataVO;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertSendDataVO;
import daewooInfo.alert.bean.AlertSmsListVO;
import daewooInfo.alert.bean.AlertTargetVO;
import daewooInfo.alert.dao.AlertDAO;
import daewooInfo.alert.dao.AlertMakeDAO;
import daewooInfo.common.alrim.bean.AlrimVO;
import daewooInfo.dailywork.bean.DailyWorkApprovalVO;

public class SendSMS {
	private static AlertDAO alertDAO;
	private static AlertMakeDAO alertMakeDAO;
	
	public void setAlertDAO(AlertDAO alertDAO) {
		this.alertDAO = alertDAO;
	}
	
	public void setAlertMakeDAO(AlertMakeDAO alertMakeDAO) {
		this.alertMakeDAO = alertMakeDAO;
	}

	/*
	 * 해당 사업장과 측정소의 전파 대상자에게 SMS를 발송한다.
	 * factCode : 사업장 코드
	 * branchNo : 측정소 코드
	 * minTime	: 접수시간 or 상황발생 시간
	 * minOr	: 단계(1-관심, 2-주의, 3-경계)
	 * message	: SMS 메시지
	 */
	public static int sendSms(String factCode, int branchNo, String minTime, String minOr, String message, String subject) throws Exception {		
		int insertCount = 0;
		AlertDataVO alertDataVO = new AlertDataVO();
		
		// 경보 발령 대상자를 추출한다.
		AlertSearchVO alertSearchVO = new AlertSearchVO();
		alertSearchVO.setFactCode(factCode);
		alertSearchVO.setBranchNo(branchNo);
		alertSearchVO.setMinOr(minOr);
		
		// sms 보내는 담당자 번호  1666-0128
		AlertCallBackVO alertCallBackVO = alertMakeDAO.getCallBack(alertSearchVO);
		String callBack = alertCallBackVO.getCallBackTel();		
		
		List<AlertTargetVO> alertTargetList = alertMakeDAO.getTargetList(alertSearchVO);
		if(alertTargetList.size() > 0) {
			for (int j=0; j < alertTargetList.size(); j++) {
				AlertTargetVO alertTargetVO = (AlertTargetVO)alertTargetList.get(j);
				
				String atPart = alertTargetVO.getAtPart();
				String atName = alertTargetVO.getAtName();
				String atSms = alertTargetVO.getAtSms();
				String atSmsTele = alertTargetVO.getAtSmsTele();
																									
				if (atSms != null){
					alertDataVO.setSubject(subject);
					alertDataVO.setFactCode(factCode);
					alertDataVO.setBranchNo(branchNo);
					alertDataVO.setCallBack(callBack);
					alertDataVO.setDestInfo(atName+"^"+atSmsTele);
					alertDataVO.setPart(atPart);
					alertDataVO.setSmsMsg(message);
					alertDataVO.setMinTime(minTime);
					
					// 경보 대상자 별로 mySql에 인서트 한다.
					alertDAO.insertSmsSend(alertDataVO);
					insertCount++;				
				}//end if (atSms != null)
			}//end for (int j=0; j < alertTargetList.size(); j++)
		}
		
		return insertCount;
	}
	
	/*
	 * 수동 발송용 SMS
	 * 
	 * factCode : 사업장 코드
	 * branchNo : 측정소 코드
	 * minTime	: 접수시간 or 상황발생 시간
	 * minOr	: 단계(1-관심, 2-주의, 3-경계)
	 * message	: SMS 메시지
	 */
	public static int sendManualSms(String system, String sugye, String factCode, String branchNo, String[] memberId, String minTime, String message, String subject, String phoneNo) throws Exception {		
		int insertCount = 0;
		AlertDataVO alertDataVO = new AlertDataVO();
		
		// 경보 발령 대상자를 추출한다.
		AlertSearchVO alertSearchVO = new AlertSearchVO();
		alertSearchVO.setFactCode("0001");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("system", system);
		map.put("riverId", sugye);
		map.put("factCode", factCode);
		map.put("branchNo", branchNo);
		map.put("memberId", memberId);
		map.put("phoneNo", phoneNo);
		
		// sms 보내는 담당자 번호  1666-0128
		AlertCallBackVO alertCallBackVO = alertMakeDAO.getCallBack(alertSearchVO);
		String callBack = "1666-0128";
		
		if(phoneNo.equals("none")){	
			
			List<AlertTargetVO> alertTargetList = alertMakeDAO.getTargetManualList(map);
			
			if(alertTargetList.size() > 0) {
				for (int j=0; j < alertTargetList.size(); j++) {
					AlertTargetVO alertTargetVO = (AlertTargetVO)alertTargetList.get(j);
					
					String atPart = alertTargetVO.getAtPart();
					String atName = alertTargetVO.getAtName();
					String atSms = alertTargetVO.getAtSms();
					String atSmsTele = alertTargetVO.getAtSmsTele();
																										
					if (atSmsTele != null){
						alertDataVO.setSubject(subject);
						alertDataVO.setFactCode(factCode);
						if(branchNo != null && !branchNo.equals("") && !"all".equals(branchNo)) {
							alertDataVO.setBranchNo(Integer.parseInt(branchNo));
						}
						alertDataVO.setCallBack(callBack);
						alertDataVO.setDestInfo(atName+"^"+atSmsTele);
						alertDataVO.setPart(atPart);
						alertDataVO.setSmsMsg(message);
						alertDataVO.setMinTime(minTime);
						
						// 통계용 T_WARNING_SEND_DATA 인서트
						alertSmsSendData(factCode, branchNo,  message, atPart, atName, atSmsTele);
						// 경보 대상자 별로 mySql에 인서트 한다.
						alertDAO.insertSmsSend(alertDataVO);
						
						insertCount++;				
					}//end if (atSms != null)
				}//end for (int j=0; j < alertTargetList.size(); j++)
			}
		}else{			
			alertDataVO.setSubject(subject);    //ok
			alertDataVO.setFactCode(factCode);  //ok
			if(branchNo != null && !branchNo.equals("") && !"all".equals(branchNo)) {
				alertDataVO.setBranchNo(Integer.parseInt(branchNo));
			}
			alertDataVO.setCallBack(callBack); //ok
			alertDataVO.setDestInfo("수동입력"+"^"+phoneNo); //ok
			alertDataVO.setPart("기타"); //ok
			alertDataVO.setSmsMsg(message); //ok
			alertDataVO.setMinTime(minTime);
			
			// 통계용 T_WARNING_SEND_DATA 인서트
			alertSmsSendData(factCode, branchNo, message, "기타", "수동입력", phoneNo);
			// 경보 대상자 별로 mySql에 인서트 한다.
			alertDAO.insertSmsSend(alertDataVO);
			
			insertCount++;
		}
		
		return insertCount;
	}
	
	private static void alertSmsSendData(String factCode, String branchNo, 
			String smsMsg, String atPart, String atName, String atSmsTele){
		
		AlertSendDataVO sendData = new AlertSendDataVO();
		if(factCode == null) factCode = "";
		if(branchNo == null) branchNo = "0";
		if(smsMsg == null) smsMsg = "";
		if(atPart == null) atPart = "";
		if(atName == null) atName = "";
		if(atSmsTele == null) atSmsTele = "";
		
		sendData.setFactCode(factCode);
		sendData.setBranchNo(Integer.parseInt(branchNo));
		sendData.setAlertKind("S");
		sendData.setAlertType("MNSMS");
		sendData.setMsg(smsMsg);
		sendData.setSendFlag("Y");
		sendData.setPart(atPart); 
		sendData.setSendName("방제정보시스템");
		sendData.setSendTel("1666-0128");
		sendData.setReceiveName(atName);
		sendData.setReceiveTel(atSmsTele);

		try{
			alertMakeDAO.insertManualSendData(sendData);
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public static int sendRegSms(String factCode, String branchNo, String[] memberId,String message, String subject) throws Exception {		
		int insertCount = 0;
		AlertDataVO alertDataVO = new AlertDataVO();
		
		// 경보 발령 대상자를 추출한다.
		AlertSearchVO alertSearchVO = new AlertSearchVO();
		alertSearchVO.setFactCode("0001");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		//map.put("system", system);
		//map.put("riverId", sugye);
		//map.put("factCode", factCode);
		//map.put("branchNo", branchNo);
		map.put("memberId", memberId);
		//System.out.println("memberId - " + memberId);
		
		// sms 보내는 담당자 번호  1666-0128 
		String callBack = "1666-0128"; 
		List<AlertTargetVO> alertTargetList = alertMakeDAO.getTargetManualList(map);
		
		//System.out.println("===================================================2");
		if(alertTargetList.size() > 0) {
			for (int j=0; j < alertTargetList.size(); j++) {
				AlertTargetVO alertTargetVO = (AlertTargetVO)alertTargetList.get(j);
				
				String atPart = alertTargetVO.getAtPart();
				String atName = alertTargetVO.getAtName();
				String atSms = alertTargetVO.getAtSms();
				String atSmsTele = alertTargetVO.getAtSmsTele();
																									
				if (atSmsTele != null){
					alertDataVO.setSubject(subject);
					alertDataVO.setFactCode(factCode);
					if(branchNo != null && !branchNo.equals("") && !"all".equals(branchNo)) {
						alertDataVO.setBranchNo(Integer.parseInt(branchNo));
					}
					alertDataVO.setCallBack(callBack);
					alertDataVO.setDestInfo(atName+"^"+atSmsTele);
					alertDataVO.setPart(atPart);
					alertDataVO.setSmsMsg(message);
					//alertDataVO.setMinTime(minTime);
					
					// 경보 대상자 별로 mySql에 인서트 한다.
					alertDAO.insertSmsSend(alertDataVO);
					insertCount++;				
				}//end if (atSms != null)
			}//end for (int j=0; j < alertTargetList.size(); j++)
		}
		return insertCount;
	}	

	//수질오염사고 접수 SMS 등록
	public static int sendRegSmsWaterPollution(String wpCode, String branchNo, String[] memberId, String smsContent, String subject) throws Exception {	
		int insertCount = 0;
		AlertDataVO alertDataVO = new AlertDataVO();
		
		// 경보 발령 대상자를 추출한다.
		AlertSearchVO alertSearchVO = new AlertSearchVO();
		alertSearchVO.setFactCode("0001");
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("memberId", memberId);
		
		// sms 보내는 담당자 번호  1666-0128 
		String callBack = "1666-0128"; 
		List<AlertTargetVO> alertTargetList = alertMakeDAO.getTargetManualList(map);
		
		//System.out.println("===================================================2");
		if(alertTargetList.size() > 0) {
			for (int j=0; j < alertTargetList.size(); j++) {
				AlertTargetVO alertTargetVO = (AlertTargetVO)alertTargetList.get(j);
				
				String atPart = alertTargetVO.getAtPart();
				String atName = alertTargetVO.getAtName();
				String atSms = alertTargetVO.getAtSms();
				String atSmsTele = alertTargetVO.getAtSmsTele();
																									
				if (atSmsTele != null){
					alertDataVO.setSubject(subject);
					alertDataVO.setFactCode(wpCode);
					if(branchNo != null && !branchNo.equals("") && !"all".equals(branchNo)) {
						alertDataVO.setBranchNo(Integer.parseInt(branchNo));
					}
					alertDataVO.setCallBack(callBack);
					alertDataVO.setDestInfo(atName+"^"+atSmsTele);
					alertDataVO.setPart(atPart);
					alertDataVO.setSmsMsg(smsContent);
					//alertDataVO.setMinTime(minTime);
					
					// 경보 대상자 별로 mySql에 인서트 한다.
					alertDAO.insertSmsSend(alertDataVO);
					insertCount++;				
				}//end if (atSms != null)
			}//end for (int j=0; j < alertTargetList.size(); j++)
		}
		return insertCount;
	}


	/*
	 * 상황일지 결재자에게 SMS를 발송한다.
	 * factCode : 사업장 코드
	 * branchNo : 측정소 코드
	 * minTime	: 접수시간 or 상황발생 시간
	 * minOr	: 단계(1-관심, 2-주의, 3-경계)
	 * message	: SMS 메시지
	 */
	public static int sendDailyWorkApprovalSms(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception {		
		int insertCount = 0;
		AlertDataVO alertDataVO = new AlertDataVO();
		
		String callBack = "1666-0128";		
		String subject = "상황근무일지 결재";
		
		List<AlertSmsListVO> alertTargetList = alertMakeDAO.getDailyWorkSmsList(dailyWorkApprovalVO);
		if(alertTargetList.size() > 0) {
			for (int j=0; j < alertTargetList.size(); j++) {
				AlertSmsListVO alertSmsListVO = (AlertSmsListVO)alertTargetList.get(j);
				
				String atName = alertSmsListVO.getName();
				String atSmsTele = alertSmsListVO.getTelNo();
				String smsMsg = alertSmsListVO.getSmsMsg();
				
				if (atSmsTele != null && !"".equals(atSmsTele)) {
					alertDataVO.setSubject(subject);
					alertDataVO.setFactCode("");
					alertDataVO.setBranchNo(0);
					alertDataVO.setCallBack(callBack);
					alertDataVO.setDestInfo(atName+"^"+atSmsTele);
					alertDataVO.setPart("");
					alertDataVO.setSmsMsg(smsMsg);
					alertDataVO.setMinTime("");
					
					// 결재자 별로 mySql에 인서트 한다.
					alertDAO.insertSmsSend(alertDataVO);
					
					//alertSmsSendData("", "", smsMsg, "", atName, atSmsTele);
					
					insertCount++;				
				}//end if (atSms != null)
			}//end for (int j=0; j < alertTargetList.size(); j++)
		}
		
		return insertCount;
	}
}