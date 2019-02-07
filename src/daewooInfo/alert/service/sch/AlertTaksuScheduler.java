package daewooInfo.alert.service.sch;

import java.util.HashMap;
import java.util.List; 
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException; 

import daewooInfo.alert.bean.AlertDataLawVo;
import daewooInfo.alert.bean.AlertDataMinVo; 
import daewooInfo.alert.bean.AlertMinVO;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertSendDataVO;
import daewooInfo.alert.bean.AlertStepLastVO;
import daewooInfo.alert.bean.AlertStepVO; 
import daewooInfo.alert.dao.AlertStepDAO;
import daewooInfo.alert.util.DataUtil;

/**
 * 탁도 스케줄러
 */
public class AlertTaksuScheduler extends AlertScheduler {
	
	private static Log log 				 = LogFactory.getLog(AlertTaksuScheduler.class); 
	private static String LAW_VALUE_OVER = "3";			//기준 초과 시 상수
	private static int OVER_TIME 	 	 = 180;
	private static String TAKSU_FLAG 	 = "START"; 
	
	/**
	 * @uml.property  name="alertStepDAO"
	 * @uml.associationEnd  
	 */
	private AlertStepDAO alertStepDAO; 
	
	/**
	 * @param alertStepDAO
	 * @uml.property  name="alertStepDAO"
	 */
	public void setAlertStepDAO(AlertStepDAO alertStepDAO) {
		this.alertStepDAO = alertStepDAO;
	}  
	@Override
	protected void executeInternal(JobExecutionContext context)throws JobExecutionException {
		
		log.debug("#AlertTaksuScheduler Job Start "+DataUtil.logBeginTime()+" #"); 
		try {  
			alertTaksuConfig(); 
			
			//새로 들어온 측정 자료를 조회한다.  
			List<AlertDataMinVo> alertMinList = (List<AlertDataMinVo>)alertSchDAO.getMinList("T"); 
			
			if(alertMinList.size() > 0 )
			{ 	
				boolean sendFlg=false;
				
				for(int i=0; i < alertMinList.size(); i++)
				{
					AlertDataMinVo alertMinVO = (AlertDataMinVo)alertMinList.get(i);  
					//UPDATE Map 
					HashMap minUpdateMap  = new HashMap(); 
					// 검색조건 세팅
					AlertSearchVO alertSearchVO = new AlertSearchVO();
					alertSearchVO.setFactCode(alertMinVO.getFactCode());
					alertSearchVO.setBranchNo(alertMinVO.getBranchNo());
					alertSearchVO.setItemCode(alertMinVO.getItemCode());
					alertSearchVO.setMinTime(alertMinVO.getMinTime()); 
					
					AlertDataLawVo alertLawVO =alertSchDAO.getFactLaw(alertSearchVO); 
					
					//현재 들어온 데이터보다 이후에 들어온 데이터의 수
					int dataCnt = alertSchDAO.isLastData(alertSearchVO);
					
					//가장 최근에 들어온 데이터가 아닐 때는 기준값만 설정해 줍니다
					if(dataCnt > 1)
					{
						if(alertLawVO != null)
						{
							if(alertMinVO.getMin_vl() >= alertLawVO.getLawHValue()){
								minUpdateMap.put("minOr", LAW_VALUE_OVER); 
							}
						}
					}
					else
					{
						if(alertLawVO != null && "START".equals(alertLawVO.getTaksuFlag())){ 
							AlertSendDataVO 	send = new AlertSendDataVO();
							
							send.setFactCode(alertMinVO.getFactCode());
							send.setRiverId("R0"+alertMinVO.getFactCode().substring(3, 4)); 
							send.setFactName(alertLawVO.getFactName());
							send.setBranchNo(alertMinVO.getBranchNo()); 
							send.setItemCode(alertMinVO.getItemCode());	
							send.setMinTime(alertMinVO.getMinTime());
							send.setAlertValue(alertMinVO.getMin_vl());
							send.setAlertStandard(alertLawVO.getLawHValue()); 
							
							int finalSmsSend =1;  
							
							/**기준초가시**/
	//						if(alertMinVO.getMin_vl() > alertLawVO.getLawHValue()){   
							if(alertMinVO.getMin_vl() >= alertLawVO.getLawHValue()){ // -KGB  기준치와 값이 같아도 경보~
								
								send.setMinOr(LAW_VALUE_OVER); 
								minUpdateMap.put("minOr", LAW_VALUE_OVER); 
								
								//기준 초과시 탁수정보발송  발송중지하면 발송중지             // 경보설정에서 ARS,SMS가 하나이상은 발송을 선택해야 발송이 된다.
								if(alertLawVO.getTaksuFlag().equals(TAKSU_FLAG) && ( alertLawVO.getArsFlag() !=null || alertLawVO.getSmsFlag() !=null)){
									sendFlg = true;
								}
								
								if(sendFlg){ 
									
									alertSearchVO.setHighValue(alertLawVO.getLawHValue()); 
									
									//3시간이상지속조회
									AlertMinVO minInfo =alertSchDAO.threeHourMinOverCount(alertSearchVO);
									
									if(log.isDebugEnabled()){
										log.debug("3시간 동안 정상데이터  횟수="+minInfo.getTimeDiff()); 
									}
									
									if(minInfo.getTimeDiff() == 0)
									{  
										//3시간동안 정상데이터가 없으면..경보(경보지속) 대상이된다.
										
										finalSmsSend = -1; 
										
										if(log.isDebugEnabled()){
											log.debug("마지막 사고조치등록조회!!!"); 
										}
										
										//마지막 사고조치등록조회
										AlertStepLastVO lastStep =alertSchDAO.getLastAlertStep(alertSearchVO); 
										
										
										if(lastStep !=null)
										{  
											//사고조치 등록이 되어 있음 (이미 3시간 지속되었음)
											
											AlertStepVO alertStepVO = new AlertStepVO();
											
											Map  		info 		= alertStepCheck(lastStep); //진행단계
											
											String      stateName   = (String)info.get("stateName");	//문자 내용(경보지속/ 상황해제)
											String      stateValue  = (String)info.get("stateValue");	//상황처리 단계
											String      stateKind   = (String)info.get("stateKind"); 		//NEXT, STOP, FAIL
											String	 	  alertCount = (Integer)info.get("alertCount") + ""; // -KGB
											
											if(log.isDebugEnabled())
											{
												log.debug("경과 시간 : "+lastStep.getTimeDiff()+" 분"); 
											} 
											if(log.isDebugEnabled())
											{
												log.debug("stateName="+stateName);
												log.debug("&stateValue="+stateValue);
												log.debug("&stateKind="+stateKind);
											}
											alertStepVO.setStateKind(stateKind);
											alertStepVO.setAsId(lastStep.getAsId());
											alertStepVO.setAlertCount(alertCount);	// -KGB (전파프로세스 단계)(전파 횟수)
											
											//stateKind : NEXT ==>경보지속(SMS)전송 ,STOP  ==>경보해제(SMS)전송  
											if(stateKind.equals("NEXT") || stateKind.equals("STOP") )
											{ 
												send.setAlertMsg(stateName);
												if("STOP".equals(stateKind))
													send.setAlertStep("-1");
												else
													send.setAlertStep(alertCount);	// -KGB (전파프로세스 단계)
												
												if(alertLawVO.getSmsFlag() !=null)
												{  
													//SMS
													send.setMsgKind("SMS");
													send.setAlertType("TAKSU"); 
													send.setMsg("탁도"); 
													alertSmsSendData(send, info);
												}
												if(alertLawVO.getArsFlag() !=null)
												{ 
													//ARS
													send.setMsgKind("ARS");
													send.setAlertType("TAKSU"); 
													send.setMsg("안녕하십니까? 한국환경공단 방제센터입니다..."); 
													alertArsSendData(send, null); 
												}

												//사고조치관리 수정 
												alertSchDAO.updateStepAlertCount(alertStepVO);
											}
										}
										else
										{
											//신규 상황 등록 - 사고조치단계 : 경보
											//						 전파프로세스단계 : 1단계
										
											if(log.isDebugEnabled()){
												log.debug("신규등록!!!"); 
											}
											
											AlertStepVO alertStepVO = new AlertStepVO();
								            alertStepVO.setFactCode(alertMinVO.getFactCode());
											alertStepVO.setBranchNo(alertMinVO.getBranchNo());
											alertStepVO.setItemCode(alertMinVO.getItemCode());
											alertStepVO.setMinTime(alertMinVO.getMinTime());
											alertStepVO.setAlertTest("0");					//0 : 실제발송   1 :훈련발송
											alertStepVO.setRiverId("R0"+alertMinVO.getFactCode().substring(3, 4));  
											alertStepVO.setAlertStep("1");					//상황조치단계
											alertStepVO.setMinOr(LAW_VALUE_OVER); 		    //구분(1:관심,2:주의,3:경계)
											alertStepVO.setMinVl(alertMinVO.getMin_vl());   //측정값 
											alertStepVO.setAlertCount("1");		//현 전파 프로세스 단계			
											
											int result=0;
											//SMS 발송후 사고 조치등록 
											if(alertLawVO.getSmsFlag() !=null){   
												send.setMsgKind("SMS");
												send.setAlertType("TAKSU"); 
												send.setMsg("탁도");
												send.setAlertMsg("경보지속(3)");
												send.setAlertStep("1");	//전파 프로세스 단계
												result=alertSmsSendData(send, null); 
											}
											if(alertLawVO.getArsFlag() !=null){  
												send.setMsgKind("ARS");
												send.setAlertType("TAKSU"); 
												send.setMsg("안녕하십니까? 한국환경공단 방제센터입니다...");
												send.setAlertMsg("경보지속(3)");
												send.setAlertStep("1");	//전파 프로세스 단계
												alertArsSendData(send, null); 
											}  
											String asId    = (String)alertStepDAO.getMaxAsId(); 
											alertStepVO.setAsId(asId);  
											if(log.isDebugEnabled()){
												log.debug("getMaxAsId asId = "+asId); 
											}  
											if(result <0){
												alertStepVO.setAlertStepText("상황전파불가능 : SMS받을 경보 발령 대상자가 존재하지 않습니다");	
											}else{
												//탁도 경보 발생 영산강02 1측정소 2010.07.04.05.20
												String msg = send.getMsg() + "경보 발생 " +send.getFactName() +" "+send.getBranchNo()+"측정소" +send.getMinTime();
												alertStepVO.setAlertStepText("경보가 정상적으로 발령되었습니다.<br>"+msg); 
											}  
											alertStepDAO.insertAlertStep(alertStepVO);
											alertStepDAO.insertAlertStepSub(alertStepVO);  
											if(log.isDebugEnabled()){
												log.debug("!!!!insertAlertStep end !!!!!"); 
											}
										}
									}
									else
									{
										
										//첫 경보 발생
										//전파 프로세스 0단계 - 경보 문자 발송, 사고조치 등록 안됨
										
										AlertDataMinVo preMin = alertSchDAO.getMinTopData(alertSearchVO);
										
										//바로 이전 데이터가 기준초과가 아닐때만 보내줌
										if(preMin.getMin_vl() < alertLawVO.getLawHValue())
										{
											//SMS 발송 
											if(finalSmsSend ==1)
											{
												
												if(alertLawVO.getSmsFlag() !=null)
												{ 
													send.setMsgKind("SMS");
													send.setAlertType("TAKSU"); 
													send.setMsg("탁도");
													send.setAlertMsg("경보");
													send.setAlertStep("0");
													alertSmsSendData(send, null); 
												} 
												if(alertLawVO.getArsFlag() !=null)
												{  
													send.setMsgKind("ARS");
													send.setAlertType("TAKSU"); 
													send.setMsg("안녕하십니까? 한국환경공단 방제센터입니다...");
													send.setAlertMsg("경보발생");
													send.setAlertStep("0");
													alertArsSendData(send, null); 
												} 
											}
										}
									}
								}//END sendFlg  
								
								
							}
							else
							{
								//기준초과 아니면...
								//경계지속 상태도 기준초과미만이면..자동해제된다. 
								AlertStepVO vo =alertSchDAO.getSelectOverStep(alertSearchVO); 
								if(vo !=null)
								{  
									//사고조치관리 종료
									alertSchDAO.updateStep(vo);
									//sms발송
									send.setMinOr(LAW_VALUE_OVER);
									send.setMsgKind("SMS");
									send.setAlertType("TAKSU"); 
									send.setAlertMsg("경보해제");
									send.setMsg("탁도"); 
									alertSmsSendData(send, null);  
								}
								else
								{
									//이전데이타와 비교해 이전데이터가 기준초과이면..자동해제메세지 
									AlertDataMinVo preMin =alertSchDAO.getMinTopData(alertSearchVO);
									if(preMin !=null)
									{
										if(log.isDebugEnabled())
										{ 
											log.debug("!!!!기준치="+alertLawVO.getLawHValue()); 
											log.debug("!!!!바로이전5분데이터="+preMin.getMin_vl());
										}
										if(preMin.getMin_vl() > alertLawVO.getLawHValue())
										{
											if(log.isDebugEnabled())
											{ 
												log.debug("해제대상 ");  
											}	
											//sms발송
											send.setMinOr(LAW_VALUE_OVER);
											send.setMsgKind("SMS");
											send.setAlertType("TAKSU"); 
											send.setAlertMsg("경보해제");
											send.setMsg("탁도"); 
											alertSmsSendData(send, null);  
										} 
									}//preMin end if  
								} 
							}  
							
						}//end getFactLaw 
					}
					
					//초과가아니더라도  모두 업데이트 대상이 된다. 
					minUpdateMap.put("factCode", alertMinVO.getFactCode());
					minUpdateMap.put("branchNo", alertMinVO.getBranchNo());
					minUpdateMap.put("itemCode", alertMinVO.getItemCode());
					minUpdateMap.put("minTime", alertMinVO.getMinTime()); 
					alertSchDAO.updateMinState(minUpdateMap);
					
				}//end for
				
			} //end alertMinList 
			
		}catch(Exception e) {  
			//System.out.println("=================================================");
			//System.out.println(e.getMessage());
			//System.out.println("=================================================");
			e.printStackTrace();
			log.error(" AlertTaksuScheduler 스케줄러 executeInternal() 에러 : " + e.getMessage());
		} 
		log.debug("#AlertTaksuScheduler Job End "+DataUtil.logBeginTime()+" #"); 
	}
}
