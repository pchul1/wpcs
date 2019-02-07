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
import daewooInfo.alert.bean.AlertStepVO;
import daewooInfo.alert.bean.AlertTargetVO;
import daewooInfo.alert.bean.AlertVocsVO;
import daewooInfo.alert.dao.AlertDAO;
import daewooInfo.alert.dao.AlertMakeDAO;
import daewooInfo.alert.dao.AlertSchDAO;
import daewooInfo.alert.dao.AlertStepDAO;
import daewooInfo.alert.dao.AlertTaksuConfigDAO;

public class AlertAutoVocs extends QuartzJobBean{

	private static Log log = LogFactory.getLog(AlertAutoVocs.class);
	
	
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
	 *5 분주기로 측정망 VOCS항목의 관리기준 초과여부를 검사한다
	 */
	@Override
	protected void executeInternal(JobExecutionContext ctx) throws JobExecutionException {

		log.debug("Start Alert by Scheduler!");
		
		try {
			
			//vocs항목 체크
			vocsCheck();
			
		}catch(Exception e){
			e.printStackTrace();
			log.error(" AlertIpUsnNorecv 스케줄러 executeInternal() 에러 : " + e.getMessage());
		}
		
	}
	
	
	
	/**
	 * vocs항목 체크
	 */
	private void vocsCheck()
	{
		try
		{
			//vocs측정 리스트
			List<AlertVocsVO> vocsList = alertSchDAO.getVocsData();
			
			for(AlertVocsVO vo : vocsList)
			{
				int isFirst = alertSchDAO.getIsVocsFirst(vo);
				
				String warnMsg = "";
			
				Double vocs1 = Double.valueOf(vo.getVoc1());
				Double vocs2 = Double.valueOf(vo.getVoc2());
				Double vocs3 = Double.valueOf(vo.getVoc3());
				Double vocs4 = Double.valueOf(vo.getVoc4());
				Double vocs5 = Double.valueOf(vo.getVoc5());
				Double vocs6 = Double.valueOf(vo.getVoc6());
				Double vocs7 = Double.valueOf(vo.getVoc7());
				Double vocs8 = Double.valueOf(vo.getVoc8());
				Double vocs9 = Double.valueOf(vo.getVoc9());
				Double vocs10= Double.valueOf(vo.getVoc10());
				
				Double vocs11= Double.valueOf(vo.getVoc11());
				Double vocs12= Double.valueOf(vo.getVoc12());
				Double vocs13= Double.valueOf(vo.getVoc13());
				Double vocs14= Double.valueOf(vo.getVoc14());
				Double vocs15= Double.valueOf(vo.getVoc15());
				Double vocs16= Double.valueOf(vo.getVoc16());

				
				AlertVocsVO vocsLaw = alertSchDAO.getVocsLaw(vo);
				
				if(vocsLaw == null)
					continue;
				
				//FID 항목 관리기준
				double v1 = Double.valueOf(vocsLaw.getVoc1Hval());
				double v2 = Double.valueOf(vocsLaw.getVoc2Hval());
				double v3 = Double.valueOf(vocsLaw.getVoc3Hval());
				double v4 = Double.valueOf(vocsLaw.getVoc4Hval());
				double v5 = Double.valueOf(vocsLaw.getVoc5Hval());
				double v6 = Double.valueOf(vocsLaw.getVoc6Hval());
				double v7 = Double.valueOf(vocsLaw.getVoc7Hval());
				double v8 = Double.valueOf(vocsLaw.getVoc8Hval());
				
				double v16 = Double.valueOf(vocsLaw.getVoc16Hval()); //자일렌

				
				int fidAlertCnt = 0;		//FID 항목 기준초과 항목 갯수
				String alertItem = "";		//초과한 항목코드(초과 항목이 1개일때만 사용됨)
				Double lawHval = 0D;	//초과한 항목 기준값
				
				
				if(vocs1 > v1 && "Y".equals(vocsLaw.getVoc1Flag()))
				{
					warnMsg += " 염화메틸렌(" + vocs1 + ")";
					fidAlertCnt++;
					alertItem = "VOC01";
					lawHval = v1;
				}
				if(vocs2 > v2 && "Y".equals(vocsLaw.getVoc2Flag()))
				{
					warnMsg += " 1.1.1-트리클로로에테인(" + vocs2 + ")";	
					fidAlertCnt++;
					alertItem = "VOC02";
					lawHval = v2;
				}
				if(vocs3 > v3  && "Y".equals(vocsLaw.getVoc3Flag()))
				{
					warnMsg += " 벤젠(" + vocs3 + ")";
					fidAlertCnt++;
					alertItem = "VOC03";
					lawHval = v3;
				}
				if(vocs4 > v4  && "Y".equals(vocsLaw.getVoc4Flag()))
				{
					warnMsg += " 사염화탄소(" + vocs4 + ")";
					fidAlertCnt++;
					alertItem = "VOC04";
					lawHval = v4;
				}
				if(vocs5 > v5  && "Y".equals(vocsLaw.getVoc5Flag()))
				{
					warnMsg += " 트리클로로에틸렌(" + vocs5 + ")";
					fidAlertCnt++;
					alertItem = "VOC05";
					lawHval = v5;
				}
				if(vocs6 > v6  && "Y".equals(vocsLaw.getVoc6Flag()))
				{
					warnMsg += " 톨루엔(" + vocs6 + ")";
					fidAlertCnt++;
					alertItem = "VOC06";
					lawHval = v6;
				}
				if(vocs7 > v7  && "Y".equals(vocsLaw.getVoc7Flag()))
				{
					warnMsg += " 테트라클로로에틸렌(" + vocs7 + ")";
					fidAlertCnt++;
					alertItem = "VOC07";
					lawHval = v7;
				}
				if(vocs8 > v8  && "Y".equals(vocsLaw.getVoc8Flag()))
				{
					warnMsg += " 에틸벤젠(" + vocs8 + ")";	
					fidAlertCnt++;
					alertItem = "VOC08";
					lawHval = v8;
				}
				if(vocs16 > v16  && "Y".equals(vocsLaw.getVoc16Flag()))
				{
					warnMsg += "자일렌(" + vocs16 + ")";
					fidAlertCnt++;
					alertItem = "VOC16";
					lawHval = v16;
				}
				
				
				String smsMsg = "";
				String time = vo.getMinTime();
				time = time.substring(2, 4) + "/" + time.substring(4, 6) + "/" + time.substring(6, 8) + " " + time.substring(8,10) + ":" + time.substring(10,12);
				
				
				boolean alertFlag = false;		//기준초과 플래그
				
				if(fidAlertCnt >= 2)
				{
					//smsMsg = "VOCs 관리기준초과 " + vo.getFactName() + " " + time;
					//smsMsg += warnMsg;
					
					//00측정소 유류유출 징후감지, 현장확인/조치 후 센터(1688-0128)로 연락바람
					smsMsg = vo.getFactName() + "측정소 유류유출 징후감지, 현장확인 및 회신(053-280-3800) 바람.";// + time;
					alertFlag = true;
				}
				else if(fidAlertCnt == 1) //한 항목만 기준초과시, 그 항목이 20분이상 기준을 초과하는지 체크
				{
					vo.setLawHval(lawHval);		//초과한 항목의 기준값
					vo.setItemCode(alertItem);	//초과한 항목 코드
					
					int minCnt = alertSchDAO.getVoc20MinCnt(vo); //20분동안 데이터가 들어온 수
					int is20Min = alertSchDAO.getIsVocAlert20Min(vo);
					
					if(is20Min == 0 && minCnt >= 4)	//한 항목 20분이상 기준을 초과했음 20분동안 수집된 데이터가 4개가 되어야 20분 지속임
					{
						//smsMsg = "VOCs 관리기준 20분 이상 초과 " + vo.getFactName() + " " + time;	//항목표시 필요없다고함 01/01/13
						//smsMsg += warnMsg;
						
						smsMsg = vo.getFactName() + "측정소 유류유출 징후감지, 현장확인 및 회신(053-280-3800) 바람.";// + time;
						
						alertFlag = true;
					}
					else //한 항목이 기준을 초과했지만 20분 이상 초과되지 않았을 때 해당초과 항목에 대한 ECD항목 기준 비교
					{
						vo.setFidItemCode(alertItem);	//초과한 FID항목 코드
						AlertVocsVO vocsEcdLaw = alertSchDAO.getVocsECDLaw(vo);	//초과한 FID항목에 대한 ECD항목 기준을 가져옴
						
						if(vocsEcdLaw != null)
						{
							//ECD 항목 관리기준
							double v11 = Double.valueOf(vocsEcdLaw.getVoc11Hval());
							double v12 = Double.valueOf(vocsEcdLaw.getVoc12Hval());
							double v13 = Double.valueOf(vocsEcdLaw.getVoc13Hval());
							double v14 = Double.valueOf(vocsEcdLaw.getVoc14Hval());
							double v15 = Double.valueOf(vocsEcdLaw.getVoc15Hval());
							
							
							int ecdAlertCnt = 0; //ECD 항목 기준초과 항목 갯수
							
							
							//2011.01.19 해당 항목과 동일한 ECD 항목에 대해서만 한계이상 검사
							if("VOC01".equals(alertItem) && vocs11 > v11 && "Y".equals(vocsEcdLaw.getVoc11Flag()))
							{
								warnMsg += " [ECD]염화메틸렌(" + vocs11 + ")";
								ecdAlertCnt++;
							}
							if("VOC02".equals(alertItem) && vocs12 > v12 && "Y".equals(vocsEcdLaw.getVoc12Flag()))
							{
								warnMsg += " [ECD]1.1.1-트리클로로에테인(" + vocs12 + ")";
								ecdAlertCnt++;
							}
							if("VOC04".equals(alertItem) && vocs13 > v13  && "Y".equals(vocsEcdLaw.getVoc13Flag()))
							{
								warnMsg += " [ECD]사염화탄소(" + vocs13 + ")";
								ecdAlertCnt++;
							}
							if("VOC05".equals(alertItem) && vocs14 > v14  && "Y".equals(vocsEcdLaw.getVoc14Flag()))
							{
								warnMsg += " [ECD]트리클로로에틸렌(" + vocs14 + ")";	
								ecdAlertCnt++;
							}
							if("VOC07".equals(alertItem) && vocs15 > v15  && "Y".equals(vocsEcdLaw.getVoc15Flag()))
							{
								warnMsg += " [ECD]테트라클로로에테인(" + vocs15 + ")";
								ecdAlertCnt++;
							}
							
							if(ecdAlertCnt >= 1) //ECD 한 항목이라도 초과시
							{
								//11.01.13 항목표시 필요없다고함
								//smsMsg = "VOCs 관리기준초과 " + vo.getFactName() + " " + time;
								//smsMsg += warnMsg;
								smsMsg = vo.getFactName() + "측정소 유류유출 징후감지, 현장확인 및 회신(053-280-3800) 바람.";// + time;
								
								alertFlag = true;
							}
						}
					}
				}
			
				
				if(alertFlag)
				{
					//isFirst 가 0 인 경우에 첫 전파시작
					if(isFirst == 0)
					{
						
						//SMS 전파
						//사전조치 통계를 내기위해 T_WARNING_SEND_DATA 테이블에 넣어줌
						AlertSendDataVO	send = new AlertSendDataVO();
						send.setFactCode(vo.getFactCode());
						send.setRiverId("R0"+vo.getFactCode().substring(2, 3)); 
						send.setFactName(vo.getFactName());
						send.setBranchNo(Integer.parseInt(vo.getBranchNo())); 
						send.setItemCode("FIRST");	
						send.setMinTime(vo.getMinTime());
						send.setAlertValue(0F);
						send.setAlertStandard(50F); 
						send.setSendFlag("Y"); // Y를 넣어서 스케쥴러에서 mysql인서트를 하지 않게함
						send.setAlertMsg("");
						send.setMsgKind("SMS");
						send.setAlertType("AVOCS"); // 자동측정망 VOCS 관리기준 초과 전파
						send.setMinOr("5");
						send.setMsg("");			
						alertSmsSendData(send, null); //통계와, 첫  전송을 기록하기 위해 T_WARNING_SEND_DATA테이블에기록합니다.\
						
//						String time = vo.getMinTime();
//						time = time.substring(2, 4) + "/" + time.substring(4, 6) + "/" + time.substring(6, 8) + " " + time.substring(8,10) + ":" + time.substring(10,12);
//						String smsMsg = "VOCs 관리기준초과 " + vo.getFactName() + " " + time;
//								 smsMsg += warnMsg;
									 
						alertSendSms(vo, smsMsg);
						
						
						
						//ARS 전파
						//사전조치 통계를 내기위해 T_WARNING_SEND_DATA 테이블에 넣어줌
						send = new AlertSendDataVO();
						send.setFactCode(vo.getFactCode());
						send.setRiverId("R0"+vo.getFactCode().substring(2, 3)); 
						send.setFactName(vo.getFactName());
						send.setBranchNo(Integer.parseInt(vo.getBranchNo())); 
						send.setItemCode("FIRST");	
						send.setMinTime(vo.getMinTime());
						send.setAlertValue(0F);
						send.setAlertStandard(50F); 
						send.setSendFlag("Y"); // Y를 넣어서 스케쥴러에서 mysql인서트를 하지 않게함
						send.setAlertMsg("");
						send.setMsgKind("ARS");
						send.setAlertType("AVOCS"); // 자동측정망 VOCS 관리기준 초과 전파
						send.setMinOr("5");
						send.setMsg("");			
						alertVmsSendData(send, null); //통계와, 첫  전송을 기록하기 위해 T_WARNING_SEND_DATA테이블에기록합니다.\
						
//						String time = vo.getMinTime();
//						time = time.substring(2, 4) + "/" + time.substring(4, 6) + "/" + time.substring(6, 8) + " " + time.substring(8,10) + ":" + time.substring(10,12);
//						String smsMsg = "VOCs 관리기준초과 " + vo.getFactName() + " " + time;
//								 smsMsg += warnMsg;
									 
						alertSendVms(vo, smsMsg);
					}
				}
				else
				{
					alertSchDAO.updateVocs(vo);
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
	 * 사전조치 통계를 위해 T_WARNING_SEND_DATA에 넣어줍니다... 여기의 데이터로 첫 전파기록을 확인합니다.
	 * @param alertStepVO
	 * @param sendData
	 * @param param
	 */
	protected int alertSmsSendData(AlertSendDataVO sendData,Map param){ 
		// sms 보내는 담당자 번호  1666-0128  
		int result = 0;
		try {
			
			//경보 발령 대상자를 추출한다.
			List<AlertTargetVO> alertTargetList =alertSchDAO.getTargetList(sendData); 
			log.debug("##### 경보 발령 대상자 ="+alertTargetList.size()); 
			if(alertTargetList.size() > 0) {
				for (int j=0; j < alertTargetList.size(); j++) { 
					
					AlertTargetVO alertTargetVO = (AlertTargetVO)alertTargetList.get(j); 
					String atPart		= alertTargetVO.getAtPart();
					String atPartGubun  = alertTargetVO.getAtPartGubun();
					String atName		= alertTargetVO.getAtName(); 
					String atSmsTele	= alertTargetVO.getAtSmsTele(); 
					
					if(alertTargetVO.getAtSmsTele() !=null && alertTargetVO.getAtSms().equals("S")){ 
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
	 * 사전조치 통계를 위해 T_WARNING_SEND_DATA에 넣어줍니다... 여기의 데이터로 첫 전파기록을 확인합니다.
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
					String atPart		= alertTargetVO.getAtPart();
					String atPartGubun  = alertTargetVO.getAtPartGubun();
					String atName		= alertTargetVO.getAtName(); 
					String atSmsTele	= alertTargetVO.getAtSmsTele(); 
					
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
	 * SMS 날리기
	 * 
	 * @param alertSearchVO
	 * @param alertDataVO
	 * @param alertStepVO
	 * @param alertFlag
	 * @param smsMsg
	 * @param smsMsgMinVl
	 */
	private void alertSendSms (AlertVocsVO vo, String smsMsg){	
		try {

			AlertSearchVO alertSearchVO = new AlertSearchVO();
			
			alertSearchVO.setBranchNo(Integer.valueOf(vo.getBranchNo()));
			alertSearchVO.setFactCode(vo.getFactCode());
			alertSearchVO.setMinOr("5");
			
			
			AlertDataVO alertDataVO = new AlertDataVO();
			alertDataVO.setFactCode(vo.getFactCode());
			alertDataVO.setBranchNo(Integer.valueOf(vo.getBranchNo()));
			alertDataVO.setMinTime(vo.getMinTime()); 
			alertDataVO.setItemCode("VOCS0"); //전파이력조회 자동전파 구분위해 넣어줍니다.
			alertDataVO.setSubject("VOCS관리기준 초과");
			
			
			// sms 보내는 담당자 번호  1666-0128
			//AlertCallBackVO alertCallBackVO = alertMakeDAO.getCallBack(alertSearchVO);
			alertDataVO.setCallBack("1666-0128");

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
	private void alertSendVms (AlertVocsVO vo, String smsMsg){	
		try {
			
			AlertSearchVO alertSearchVO = new AlertSearchVO();
			
			alertSearchVO.setBranchNo(Integer.valueOf(vo.getBranchNo()));
			alertSearchVO.setFactCode(vo.getFactCode());
			alertSearchVO.setMinOr("5");
			
			
			AlertDataVO alertDataVO = new AlertDataVO();
			alertDataVO.setFactCode(vo.getFactCode());
			alertDataVO.setBranchNo(Integer.valueOf(vo.getBranchNo()));
			alertDataVO.setMinTime(vo.getMinTime()); 
			alertDataVO.setItemCode("VOCS0"); //전파이력조회 자동전파 구분위해 넣어줍니다.
			alertDataVO.setSubject("VOCS관리기준 초과");
			
			
			// sms 보내는 담당자 번호  1666-0128
			alertDataVO.setCallBack("1666-0128");

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
						
						alertDataVO.setSmsMsg(smsMsg);
						
						// 경보 대상자 별로 mySql에 인서트 한다.
						alertDAO.insertVmsSend(alertDataVO);
						insertCount++;
					}
				}//end for (int j=0; j < alertTargetList.size(); j++)
			}else {
				//경보 대상자 없을 때 처리
			}//end if (alertTargetList.size() > 0)								
		} catch(Exception e){
			e.printStackTrace();
		}
	}
	
}
