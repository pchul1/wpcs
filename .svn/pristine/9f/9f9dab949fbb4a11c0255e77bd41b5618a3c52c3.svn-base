package daewooInfo.alert.service.sch;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException; 

import daewooInfo.alert.bean.AlertConfigVO;
import daewooInfo.alert.bean.AlertLawVO;
import daewooInfo.alert.bean.AlertMinVO;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertSendDataVO;
import daewooInfo.alert.bean.AlertStepLastVO;
import daewooInfo.alert.bean.AlertStepVO;
import daewooInfo.alert.dao.AlertSchUsnDAO; 
import daewooInfo.alert.dao.AlertStepDAO;

public class AlertIPUSNScheduler  extends AlertScheduler {
	
	private static Log log 				 = LogFactory.getLog(AlertIPUSNScheduler.class);
	
	/**
	 * @uml.property  name="alertSchUsnDAO"
	 * @uml.associationEnd  
	 */
	private AlertSchUsnDAO alertSchUsnDAO; 
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
	
	/**
	 * @param alertSchUsnDAO
	 * @uml.property  name="alertSchUsnDAO"
	 */
	public void setAlertSchUsnDAO(AlertSchUsnDAO alertSchUsnDAO) {
		this.alertSchUsnDAO = alertSchUsnDAO;
	} 
	@Override
	protected void executeInternal(JobExecutionContext context)throws JobExecutionException {
		 
		try { 
			
			alertTaksuConfig();  
			
			//새로 들어온 측정 자료를 조회한다.  
			List<AlertMinVO> alertMinList = (List<AlertMinVO>)alertSchUsnDAO.getMinList();
			if(alertMinList.size() > 0 )
			{ 	
				for(int i=0; i < alertMinList.size(); i++)
				{
					AlertMinVO alertMinVO = (AlertMinVO)alertMinList.get(i); 
					HashMap minUpdateMap  = new HashMap(); 
					// 검색조건 세팅
					AlertSearchVO alertSearchVO = new AlertSearchVO();
					alertSearchVO.setFactCode(alertMinVO.getFactCode());
					alertSearchVO.setBranchNo(alertMinVO.getBranchNo()); 
					alertSearchVO.setMinTime(alertMinVO.getMinTime());
					
					//경보 기준 가져온다.  
					AlertLawVO alertLawVO =alertSchUsnDAO.getFactLaw(alertSearchVO);
					
					if(alertLawVO !=null){ 
						
						//기준초과 확인
						Map		info  =	alertIpusnCheck(alertLawVO,alertMinVO);
						String  minOr = (String)info.get("minOr");
						
						if(log.isDebugEnabled()){
							log.debug("#minOr="+minOr); 
							log.debug("#excessMinVl_1="+info.get("excessMinVl_1"));
						}  
						//기준초과 이상일 때 ==>사고접수등록 
						if(Integer.parseInt(minOr) >0){
							 
							if(info.containsKey("excessMinVl_1"))  
								alertSearchVO.setExcessItemCode_1((String)info.get("excessItemCode_1")); 
								alertSearchVO.setItemCode((String)info.get("excessItemCode_1"));
								alertSearchVO.setExcessMinVl_1((Float)info.get("excessMinVl_1"));
							if(info.containsKey("excessItemCode_2")) 
								alertSearchVO.setExcessMinVl_2((Float)info.get("excessMinVl_2"));
								alertSearchVO.setExcessItemCode_2((String)info.get("excessItemCode_2"));
								
							AlertConfigVO configVo=alertSchUsnDAO.getConfig(alertSearchVO); 
							if (configVo != null){ //경보대상확인.
								 
								// 해당 공구 아이템의 완료되지 않은 마지막 전파 내용 (alert_step < 4)
								AlertStepLastVO alertStepLastVO =alertSchUsnDAO.getLastIpusnAlert(alertSearchVO);
								
								AlertSendDataVO send = new AlertSendDataVO(); 
								
								if(alertStepLastVO != null){	//상태업데이트 
									
									AlertStepVO 	alertStepVO = new AlertStepVO(); 		//사고조치 
									boolean 			 result = false; 
									int alertTerm 			= configVo.getAlertTerm(); 
									Double timeDiff 		= alertStepLastVO.getTimeDiff(); 
									
									if (alertTerm > 0) { 
										 //경과시간이 30분이상~40분이하이면...	  
										 if (timeDiff >= alertTerm && timeDiff < (alertTerm+10)){ 
											result=true;
											alertStepVO.setAsId(alertStepLastVO.getAsId()); 
											send.setAlertMsg(getAlertMsg(minOr));
											send.setMsg("USN"); 
											if(minOr.equals(alertStepLastVO.getMinOr())){
												//같은상태이면..상태지속메세지보낸다.
												send.setAlertMsg("지속");
												send.setMsg("USN"); 
											}
											//사고조치상태업데이트 
											alertSchUsnDAO.updateStepAlertCount(alertStepVO);
										}
									} 
									if(configVo.getSmsFlag() !=null){	//SMS 
										if(result){//SMS보내기
											if(log.isDebugEnabled()){
												log.debug("#SMS SEND !!!");  
											} 
										} 
									}
									if(configVo.getArsFlag() !=null){	//ARS
										if(result){//ARS보내기
											if(log.isDebugEnabled()){
												log.debug("#ARS SEND !!!");  
											}  
										}
									} 
									
									
								}else{
									
									//사고조치관리 신규등록
									AlertStepVO alertStepVO = new AlertStepVO();
						            alertStepVO.setFactCode(alertMinVO.getFactCode());
									alertStepVO.setBranchNo(alertMinVO.getBranchNo());
									alertStepVO.setItemCode(alertSearchVO.getExcessItemCode_1());
									alertStepVO.setMinTime(alertMinVO.getMinTime());
									alertStepVO.setAlertTest("0");					//0 : 실제발송   1 :훈련발송
									alertStepVO.setRiverId("R0"+alertMinVO.getFactCode().substring(3, 4));  
									alertStepVO.setAlertStep("1");					//상황조치단계
									alertStepVO.setMinOr(minOr); 	
									alertStepVO.setMinVl(alertSearchVO.getExcessMinVl_1());   	 //초과측정값  1 
									alertStepVO.setExcessMinVl(alertSearchVO.getExcessMinVl_2()); //초과측정값  2 
									alertStepVO.setAlertKind("U");
									String asId = (String)alertStepDAO.getMaxAsId(); 
									alertStepVO.setAsId(asId);
									
									alertStepVO.setAlertStepText("경보가 정상적으로 발령되었습니다.<br>");  
									alertStepDAO.insertAlertStep(alertStepVO);
									alertStepDAO.insertAlertStepSub(alertStepVO);  
								}
								
							}
							
							
							
							
						}//end minOr  
						
					}//end if alertLawVO 
				}//end for 
			}//end if
			
			
		}catch(Exception e) {
			e.printStackTrace();
			log.error(" AlertIPUSNScheduler 스케줄러 executeInternal() 에러 : " + e.getMessage());
		} 
		
	} 
}
