package daewooInfo.alert.service.impl;

import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import daewooInfo.alert.bean.AlertCallBackVO;
import daewooInfo.alert.bean.AlertDataVO;
import daewooInfo.alert.bean.AlertMinVO;
import daewooInfo.alert.bean.AlertNewLawVO;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertSendDataVO;
import daewooInfo.alert.bean.AlertSmsBranchVO;
import daewooInfo.alert.bean.AlertTargetVO;
import daewooInfo.alert.dao.AlertDAO;
import daewooInfo.alert.dao.AlertMakeDAO;
import daewooInfo.alert.dao.AlertSchDAO;
import daewooInfo.common.util.CommonUtil;

public class AlertIpUsnAbnormalImpl extends QuartzJobBean{

	private static Log log = LogFactory.getLog(AlertIpUsnLeave.class);
	
	private static final String DET_CODE = "SMSCD002";
	private static final String SYS_KIND_IPUSN = "U";
	private static final String ABNORMAL = "ABNOR";
	private static final String ALERT_KIND_SMS = "S";
	
	private static final String ITEMCODE_TMP = "TMP00";
	private static final String ITEMCODE_DOW = "DOW00";
	private static final String ITEMCODE_TUR = "TUR00";
	private static final String ITEMCODE_PHY = "PHY00";
	private static final String ITEMCODE_CON = "CON00";
	private static final String ITEMCODE_TOF = "TOF00";
	
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
	 * IP-USN 10분 주기로 이상 데이터 측정소를 가져옵니다.
	 */
	@Override
    protected void executeInternal(JobExecutionContext ctx) throws JobExecutionException {

		log.debug("Start Alert IpUsn Abnormal Data by Scheduler!");
		
		try{
			// 새로 들어온 측정 자료를 조회한다. (최근 3시간)
			List<AlertMinVO> alertMinList = (List<AlertMinVO>)alertMakeDAO.getMinList();
			
			if( alertMinList.size() > 0 )
			{
				for(int i=0; i < alertMinList.size(); i++)
				{
					AlertMinVO alertMinVO = (AlertMinVO)alertMinList.get(i);
					String system = alertMinVO.getFactCode().substring(2,3);
					if(SYS_KIND_IPUSN.equals(system)){
						alertAbnormalData(alertMinVO);
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			log.error(" AlertAbnormalData 스케줄러 executeInternal() 에러 : " + e.getMessage());
		}
	}
	/**
	 * IP-USN 이상 데이타
	 */
	private void alertAbnormalData(AlertMinVO alertMinVO){
		
		String factCode	= alertMinVO.getFactCode();
		int branchNo	= alertMinVO.getBranchNo();
		String minTime	= alertMinVO.getMinTime();
		String factName = "";
		String branchName = "";
	    Float tmp		= alertMinVO.getTmp(); //수온
	    Float dow		= alertMinVO.getDow(); //DO
	    Float tur		= alertMinVO.getTur(); //탁도
	    Float phy		= alertMinVO.getPhy(); //pH 
	    Float con		= alertMinVO.getCon(); //EC
	    Float tof		= alertMinVO.getTof(); //총클로로필-A
	
	    Float tmpH		= 0.0f;
	    Float dowH		= 0.0f;
	    Float turH		= 0.0f;
	    Float phyH		= 0.0f;
	    Float conH		= 0.0f;
	    Float tofH		= 0.0f;
	    
	    Float minVl     = 0.0f;
	    
	    boolean tmpF    = false;
	    boolean dowF	= false;
	    boolean turF	= false;
	    boolean phyF	= false;
	    boolean conF	= false;
	    boolean tofF	= false;

	    boolean sendFlag  = false;
	    
	    int totalCnt    = 0;
	    
	    String[] itemCode = new String[6];
	    Float[]  itemVal  = new Float[6];

	    String smsMsg     = "";
	     
		int currentHour   = Integer.parseInt(CommonUtil.getCurrentDate("HH"));
		
	    AlertSearchVO alertSearchVO = new AlertSearchVO();
	    alertSearchVO.setFactCode(alertMinVO.getFactCode());
	    alertSearchVO.setBranchNo(alertMinVO.getBranchNo());
	    
	    AlertDataVO alertDataVO = new AlertDataVO();				
		alertDataVO.setFactCode(factCode);
		alertDataVO.setBranchNo(branchNo);
		alertDataVO.setMinTime(minTime);
	    
	    try {
	    	
	    	factName   = alertMakeDAO.getFactName(alertSearchVO);
	    	branchName = alertMakeDAO.getBranchName(alertSearchVO);
	    	String warnSmsSendFlg = "";
	    	StringBuffer smsSendMsg = new StringBuffer(); 			//SMS SEND 메시지 
	    	
	    	//검출기준값을 조회한다.
	    	List<AlertNewLawVO> alertNewLawList = (List<AlertNewLawVO>)alertMakeDAO.getNewLaw(alertSearchVO);
	    	
	    	if(alertNewLawList.size() > 0){
	    		for(int i = 0 ; i< alertNewLawList.size(); i++){
	    			if("Y".equals(alertNewLawList.get(i).getLegYn())){
	    				// 검출대상(LEGYN) 사용(Y)
	    				if(ITEMCODE_TMP.equals(alertNewLawList.get(i).getItemCode())){
	    					tmpF = minDataInspection(tmp, ITEMCODE_TMP, alertSearchVO, alertNewLawList.get(i));
		    			}else if(ITEMCODE_DOW.equals(alertNewLawList.get(i).getItemCode())){
		    				dowF = minDataInspection(dow, ITEMCODE_DOW, alertSearchVO, alertNewLawList.get(i));
		    			}else if(ITEMCODE_TUR.equals(alertNewLawList.get(i).getItemCode())){
		    				turF = minDataInspection(tur, ITEMCODE_TUR, alertSearchVO, alertNewLawList.get(i));
		    			}else if(ITEMCODE_PHY.equals(alertNewLawList.get(i).getItemCode())){
		    				phyF = minDataInspection(phy, ITEMCODE_PHY, alertSearchVO, alertNewLawList.get(i));
		    			}else if(ITEMCODE_CON.equals(alertNewLawList.get(i).getItemCode())){
		    				conF = minDataInspection(con, ITEMCODE_CON, alertSearchVO, alertNewLawList.get(i));
		    			}else if(ITEMCODE_TOF.equals(alertNewLawList.get(i).getItemCode())){
		    				tofF = minDataInspection(tof, ITEMCODE_TOF, alertSearchVO, alertNewLawList.get(i));
		    			}
	    				
    				}
	    			
	    		}
	    	}
			//비교
	    	if(tmpF){
	    		totalCnt++;
	    		itemCode[0] = ITEMCODE_TMP;
	    		itemVal[0]  = tmp; 
	    	}
	    	if(dowF){
	    		totalCnt++;
	    		itemCode[1] = ITEMCODE_DOW;
	    		itemVal[1]  = dow;
	    	}
	    	if(turF){
	    		totalCnt++;
	    		itemCode[2] = ITEMCODE_TUR;
	    		itemVal[2]  = tur; 
	    	}
	    	if(phyF){
	    		totalCnt++;
	    		itemCode[3] = ITEMCODE_PHY;
	    		itemVal[3]  = phy; 
	    	}
	    	if(conF){
	    		totalCnt++;
	    		itemCode[4] = ITEMCODE_CON;
	    		itemVal[4]  = con; 
	    	}
	    	if(tofF){
	    		totalCnt++;
	    		itemCode[5] = ITEMCODE_TOF;
	    		itemVal[5]  = tof; 
	    	}
	    	log.debug("##### totalCnt ##### "+ totalCnt);
	    	
	    	AlertSendDataVO send = new AlertSendDataVO();
	    	
	    	if(totalCnt > 0){
	    		
	    		send.setFactCode(factCode);
	    		send.setRiverId("R0"+factCode.substring(3, 4)); 
	    		send.setBranchNo(branchNo); 
	    		send.setMinTime(minTime);
	    		send.setAlertMsg("");
	    		send.setMsgKind(ALERT_KIND_SMS);
	    		send.setAlertType(ABNORMAL); 				
	    		
		    	for(int j = 0 ; j < itemCode.length; j++){		//체크된 ITEM만	
		    		
		    		if(null != itemCode[j]){
		    			
		    			alertSearchVO.setItemCode(itemCode[j]); //search 값 셋팅
		    			
						send.setFactName(factName);
						send.setItemName(alertMakeDAO.getItemName(alertSearchVO));
		    			send.setItemCode(itemCode[j]);
		    			send.setAlertValue(itemVal[j]);
		    			send.setAlertStandard(itemVal[j]);
		    			
		    			smsMsg += (send.getItemCode()).substring(0,3).toLowerCase() +"("+String.format("%.2f", send.getAlertValue())+"),";
		    			
		    			// 통계와, 첫 위치이탈 전송을 기록하기 위해 T_WARNING_SEND_DATA 테이블에 기록
		    			alertSmsSendData(send, null, "N", "");
		    		}
				}
		    	
		    	alertSearchVO.setDetCode(DET_CODE);
		    	
	    		AlertSmsBranchVO alertSmsBranchVO = alertMakeDAO.getSmsBranchConf(alertSearchVO);
	    		
	    		if(alertSmsBranchVO != null){
	    			if("Y".equals(alertSmsBranchVO.getSend_use_flag()) &&
					  (currentHour >= Integer.parseInt(alertSmsBranchVO.getNot_send_from()) && 
					  	currentHour < Integer.parseInt(alertSmsBranchVO.getNot_send_to()))){
						log.debug("##### 이상데이터SMS::<SEND_USE_FLAG(Y)> ##### ");
						sendFlag = false;
					}else{
						log.debug("##### 이상데이터SMS::<SEND_USE_FLAG(N)> ##### ");
						sendFlag = true;
					}
					if(sendFlag && "Y".equals(alertSmsBranchVO.getDelay_use_flag())){
						
						alertSearchVO.setAlertDelayTime(alertSmsBranchVO.getChk_delay());
						
		    			for(int k = 0 ; k < itemCode.length; k++){//검출된 항목들이 지연시간에 존재하는지 판단한다.
		    				if(null != itemCode[k]){
		    					alertSearchVO.setItemCode(itemCode[k]);	
		    					
		    					int chk = alertMakeDAO.getIsAbnormal(alertSearchVO);
			    				
			    				if(chk > 0){		//검출지연시간내에 데이터 존재한다면 exit.
			    					log.debug("######### 검출지연시간 조회(O) #########");
			    					sendFlag = false;
			    					
			    				}else{				//존재하지 않는다면 SMS 전송
			    					log.debug("######### 검출지연시간 조회(X) #########");
			    					sendFlag = true;
			    				}
		    				}
		    			}
					}
	    		}
	    		
	    		alertDataVO.setSubject("USN(이상)");
	    		
	    		smsSendMsg.append("USN(이상)") // EX. 낙동강IP-USN
	    		.append(branchName).append(branchNo) // EX. 성주24
				// .append(" ").append(minTime.substring(2, 4))	// 년
				.append(" ").append(minTime.substring(4, 6))	// 월
				.append("/").append(minTime.substring(6, 8))	// 일
				.append(" ").append(minTime.substring(8, 10))	// 시
				.append(":").append(minTime.substring(10, 12))	// 분
	    		.append(" "+smsMsg.substring(0,(smsMsg.trim().length())-1));
				
	    		log.debug("############## SMS MSG ::" + smsSendMsg.toString());
	    		
	    		if(sendFlag){
	    			warnSmsSendFlg = "Y";
	    			alertSendSms(alertSearchVO, alertDataVO, smsSendMsg.toString(), alertSmsBranchVO);
	    		}
	    		
	    		// 문자 발송에 대해 T_WARNING_SEND_DATA 테이블에 기록
				if("Y".equals(warnSmsSendFlg)){
					alertSmsSendData(send, null, warnSmsSendFlg, smsSendMsg.toString());
				}
	    	}
	    	
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	/**
	 * 단지 사전조치 통계를 위해 T_WARNING_SEND_DATA에 넣어줍니다...
	 * @param alertStepVO
	 * @param sendData
	 * @param param
	 */
	protected int alertSmsSendData(AlertSendDataVO sendData,Map param, String sendFlag, String smsMsg){ 
		// sms 보내는 담당자 번호  1666-0128  
		int result = 0;
		
		try {
			//경보 발령 대상자를 추출한다.
			sendData.setDetCode(DET_CODE);
			sendData.setSendFlag(sendFlag);
			sendData.setMsg(smsMsg);
			log.debug("#####[SMSCD002]경보발령대상자 추출#####");
			List<AlertTargetVO> alertTargetList =alertSchDAO.getTargetList(sendData); 
			log.debug("##### T_WARNING_DATA IN SMS :: 경보 발령 대상자 = "+alertTargetList.size()); 
			if(alertTargetList.size() > 0) {
				for (int j=0; j < alertTargetList.size(); j++) { 
					
					AlertTargetVO alertTargetVO = (AlertTargetVO)alertTargetList.get(j); 
					String atPart 		= alertTargetVO.getAtPart();
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
	private void alertSendSms (AlertSearchVO alertSearchVO, AlertDataVO alertDataVO, String smsMsg, AlertSmsBranchVO alertSmsBranchVO){	
		try {
			// sms 보내는 담당자 번호  1666-0128
			AlertCallBackVO alertCallBackVO = alertMakeDAO.getCallBack(alertSearchVO);
			alertDataVO.setCallBack(alertCallBackVO.getCallBackTel());
			// 경보 발령 대상자를 추출한다.
			alertSearchVO.setDetCode(DET_CODE);
			
			List<AlertTargetVO> alertTargetList = alertMakeDAO.getTargetBranchSmsList(alertSearchVO);
			
			if(alertTargetList.size() > 0 ) {
				for (int j=0; j < alertTargetList.size(); j++) {
					AlertTargetVO alertTargetVO = (AlertTargetVO)alertTargetList.get(j);
					
					String atPart = alertTargetVO.getAtPart();				//deptNoName
					String atName = alertTargetVO.getAtName();				//memberName
					String atSmsTele = alertTargetVO.getAtSmsTele();		//mobileNo
					
					alertDataVO.setDestInfo(atName+"^"+atSmsTele);
					alertDataVO.setPart(atPart);
					alertDataVO.setToTel(atSmsTele.replace("-", ""));
					alertDataVO.setSendDate(alertSmsBranchVO.getChk_time());
					alertDataVO.setSmsMsg(smsMsg);
					
					if("Y".equals(alertSmsBranchVO.getTime_use_flag())){
						int sendCount = 0;
						alertDataVO.setSendDate(alertSmsBranchVO.getChk_time());
						sendCount = alertDAO.sendSmsCycleCheck(alertDataVO);
						if(sendCount == 0 ){
							alertDAO.insertSmsSend(alertDataVO);
							log.debug("[SMS이상데이터] 송신주기 동일("+sendCount+")건 으로인한 송신 ");
						}else{
							log.debug("[SMS이상데이터] 송신주기 동일("+sendCount+")건 으로인한 미송신 ");
						}
					}else{
						// 경보 대상자 별로 mySql에 인서트 한다.
						alertDAO.insertSmsSend(alertDataVO);
					}
				}
			}
		} catch(Exception e){
			e.printStackTrace();
			log.error(" AlertIpUsnAbnormalImpl 스케줄러 alertSendSms() 에러 : " + e.getMessage());
		}
	}
	
	private boolean minDataInspection(Float minVl, 
									String itemCode,
									AlertSearchVO alertSearchVO, 
									AlertNewLawVO alertNewLawVO){
	    
		Float calVl		= 0.0f;
	    
		if(minVl > Float.parseFloat(alertNewLawVO.getItemValueHi())
				|| 	minVl < Float.parseFloat(alertNewLawVO.getItemValueLo())){
				// 기준범위(최소값~최대값)를 벗어남
				return true;
				
		}else if("Y".equals(alertNewLawVO.getStandYn())){
			// 기준값(튐값) 사용
			alertSearchVO.setItemCode(itemCode);
			try{
				String beforeItemVal = alertMakeDAO.getBeforeItemValue(alertSearchVO);
				if(beforeItemVal != null){
					calVl = minVl - Float.parseFloat(beforeItemVal);
					if(Math.abs(calVl) > Float.parseFloat(alertNewLawVO.getTimeDurVal())){
						// 현재데이터와 바로 이전데이터의 값의 차이가 기준값을 초과
						return true;
					}else return false; // 기준값(튐값)을 초과하지 않음
				}else return false; 	// 이전데이터 없음
			}catch(Exception e){
				e.printStackTrace();
				return false;
			}

		}else{
			return false;
		}
	}
}