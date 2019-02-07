package daewooInfo.alert.service.sch;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import daewooInfo.alert.bean.AlertLawVO;
import daewooInfo.alert.bean.AlertMinVO;
import daewooInfo.alert.bean.AlertSendDataVO;
import daewooInfo.alert.bean.AlertStepLastVO; 
import daewooInfo.alert.bean.AlertTaksuConfigVO;
import daewooInfo.alert.bean.AlertTargetVO;
import daewooInfo.alert.dao.AlertSchDAO;
import daewooInfo.alert.dao.AlertTaksuConfigDAO;

public abstract class AlertScheduler  extends QuartzJobBean{
	
	private static Log log = LogFactory.getLog(AlertScheduler.class);
	
	private static String ITEM_CODE_TUR00 = "TUR00";
	private static String ITEM_CODE_PHY00 = "PHY00";
	private static String ITEM_CODE_CON00 = "CON00";
	private static String ITEM_CODE_DOW00 = "DOW00";
	
	/**
	 * @uml.property  name="alertTaksuConfigDAO"
	 * @uml.associationEnd  
	 */
	private AlertTaksuConfigDAO alertTaksuConfigDAO;
	
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
	 * @param alertTaksuConfigDAO
	 * @uml.property  name="alertTaksuConfigDAO"
	 */
	public void setAlertTaksuConfigDAO(AlertTaksuConfigDAO alertTaksuConfigDAO) {
		this.alertTaksuConfigDAO = alertTaksuConfigDAO;
	} 
	
	/**
	 * @param alertSchDAO
	 * @uml.property  name="alertSchDAO"
	 */
	public void setAlertSchDAO(AlertSchDAO alertSchDAO) {
		this.alertSchDAO = alertSchDAO;
	} 
	/**
	 * 탁수경보설절 테이블에서 해제할 경보설정을 가져온뒤 무조건 경보 설정을 처리
	 */
	protected void alertTaksuConfig(){ 
		log.debug("##### alertTaksuConfig start!!!");
		try { 
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
		log.debug("##### alertTaksuConfig end !!!");
	} 
	
	/**
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
					String atPart 		= alertTargetVO.getAtPart();
					String atPartGubun  = alertTargetVO.getAtPartGubun();
					String atName 		= alertTargetVO.getAtName(); 
					String atSmsTele 	= alertTargetVO.getAtSmsTele(); 
					
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
	protected int alertArsSendData(AlertSendDataVO sendData,Map param){ 
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
					String atAcs 		= alertTargetVO.getAtArs();
					
					if(atAcs!=null ){ 
						//현재는 SMS의 핸드폰번호로 발송하도록 함.
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
	  * 경계 : 전기전도도가 3배 이상 초과시
	  * 주의 : 수소이온농도 pH(phy), 전기전도도 EC(con), 용존산소량 DO(dow) 중 2개 이상이 2배 이상 초과시
	  *       (단;수소이온농도 pH(phy)는 5 이하 또는 11 이상)
	  * 관심 : 수소이온농도 pH(phy), 전기전도도 EC(con), 용존산소량 DO(dow) 중 2개 이상이 기준 초과시 
	 * @param lowVo
	 * @param minVo
	 * @return
	 */
	protected Map alertIpusnCheck(AlertLawVO lowVo,AlertMinVO minVo){
	    	
	    	int result 			= 0; 
	    	Map<String, Object> map = new HashMap<String, Object>();
	    	
	    	//CON00(전기전도도),DOW00(용존산소,PHY00(pH),TUR00(탁도),TMP00(수온)
	    	Float phy		= minVo.getPhy(); //pH 수소이온농도
	        Float dow		= minVo.getDow(); //DO 용존산소량
	        Float con		= minVo.getCon(); //EC 전기전도도
	         
	    	Float phyHVal 	= lowVo.getPhyHVal();
			Float phyLVal 	= lowVo.getPhyLVal();
			Float conHVal 	= lowVo.getConHVal();
			Float dowLVal 	= lowVo.getDowLVal();
			
			int flagCon 	= 0;    //전기전도도
            int flagDow 	= 0;    //용존산소량
            int flagPhy 	= 0;   //수소이온농도
            int lawCount 	= 0; 
            String minOr 	= "0"; 
            
            if(log.isDebugEnabled()){
            	log.debug("#con="+con);
            	log.debug("#phy="+phy);
            	log.debug("#con="+con);
            	
				log.debug("#phyHVal="+phyHVal);
				log.debug("#phyLVal="+phyLVal);
				log.debug("#conHVal="+conHVal);
				log.debug("#dowLVal="+dowLVal);
				log.debug("####################");
			} 
            //T_MIN_REAL(MIN_OR:상태) ==>1:관심,2:주의,3:경계 
            //전기전도도가 3배 이상 초과시
			if (con > (conHVal*3)) {  
				map.put("excessItemCode_1"	, ITEM_CODE_CON00);		
				map.put("excessMinVl_1"		, con);  
				minOr = "3";
			}else{
				if (con > (conHVal*2)) {flagCon = 1;lawCount++;}
				if (dow < (dowLVal/2)) {flagDow = 1;lawCount++;}
				if (phy < 5 || phy > 11){flagPhy = 1;lawCount++;}
				if (lawCount > 1) {minOr = "2";
				} else {
					if (con > conHVal) {flagCon = 1;lawCount++;}
					if (dow < dowLVal) {flagDow = 1;lawCount++;}
					if (phy < phyLVal || phy > phyHVal){flagPhy = 1;lawCount++;}
					if (lawCount > 1) {minOr = "1";
					} else {minOr = "0";}
				}
				
			}
			 if(log.isDebugEnabled()){
					log.debug("#minOr minOr="+minOr); 
				} 
			//2:주의,3:경계 이벤트시
			if ("1".equals(minOr) || "2".equals(minOr) ){ 
				if (flagPhy == 1 && flagDow == 1) { 		//(수소이온농도,용존산소)초과시   			
					map.put("excessItemCode_1"	, ITEM_CODE_PHY00);		
					map.put("excessMinVl_1"		, phy); 
					map.put("excessItemCode_2"	, ITEM_CODE_DOW00);		
					map.put("excessMinVl_2"		, dow); 
				}else if (flagPhy == 1 && flagCon == 1){	//(수소이온농도,전기전도도)초과시 
					map.put("excessItemCode_1"	, ITEM_CODE_PHY00);		
					map.put("excessMinVl_1"		, phy); 
					map.put("excessItemCode_2"	, ITEM_CODE_CON00);		
					map.put("excessMinVl_2"		, con);  
				}else{ 										//(용존산소,전기전도도)초과시
					map.put("excessItemCode_1"	, ITEM_CODE_DOW00);		
					map.put("excessMinVl_1"		, dow); 
					map.put("excessItemCode_2"	, ITEM_CODE_CON00);		
					map.put("excessMinVl_2"		, con); 
				}
			}
			map.put("minOr"		, minOr); 
			return map;
	}
	protected String getAlertMsg(String minOr){ 
		String rtn="";
		if ("1".equals(minOr) ){
			rtn="관심";
		}else if ("2".equals(minOr) ){
			rtn="주의";
		}else if ("3".equals(minOr) ){
			rtn="경계";
		}
		return rtn;
	} 
	/**
	 * @param vo
	 * @return
	 */
	protected int alertStepCheck1(AlertStepLastVO vo){ 
		
		int result 			= 0;
		Double timeDiff 	= vo.getTimeDiff();
		String sMinOr 		= vo.getMinOr();
		int alertCount 		= vo.getAlertCount();
		 
		//3시간 ,6시간,12시간  체크한다. 
		if(alertCount ==0){
			if (timeDiff > 180) 		//3시간 지속 
				result = 0;
		}else if(alertCount ==1){
			if(timeDiff > 360) 			//6시간 지속 
				result = 1;
		}else if(alertCount ==2){
			if(timeDiff > 720) 			//12시간 지속 
				result = 2;
		}else{
			result = -1;			   //지속시간이전
		}
		return result;
	}
	
	/**
	 * @param vo
	 * @return
	 */
	protected Map alertStepCheck(AlertStepLastVO vo){ 
		
		Map<String, Object> map = new HashMap<String, Object>();
		String result 		= "";
		Double timeDiff 	= vo.getTimeDiff();
		String sMinOr 		= vo.getMinOr();
		Integer alertCount = vo.getAlertCount(); // -KGB (int를 Integer로)
		String stepValue = vo.getAlertStep();	// -KGB
	
		
		if("6".equals(stepValue) || "7".equals(stepValue) || "10".equals(stepValue))	//사고처리단계가 6 [장비이상] 또는 7 [강우요인] 또는 10 [시료분석상황종료]로 처리되어 있을 시 -KGB
		{
			map.put("stateName",  "상황해제");
			map.put("stateKind",  "STOP"); 
		}
		else if("8".equals(stepValue))	//사고처리단계가 6 [장비이상] 또는 7 [강우요인] 또는 10 [시료분석상황종료]로 처리되어 있을 시 -KGB
		{
			map.put("stateName",  "상황종료");
			map.put("stateKind",  "STOP"); 
		}
		else if(alertCount ==1) //현 전파프로세스가 1단계라면 2단계로 갈 조건 검사! (첫 경보 발생 후 6시간 지속)
		{	
			if(timeDiff >= 360 && timeDiff <= 720)   //6시간 지속 
			{ 		
				alertCount += 1; //-KGB 2단계로!
				
				map.put("stateName",  "경보지속(6)");
		    	map.put("stateKind",  "NEXT"); 
			}
			else if(timeDiff > 720)
			{
				//1단계에서 바로 3단계로 점프?
				
				alertCount += 2; //-KGB 3단계로!

				map.put("stateName",  "경보지속(12)");
	    		map.put("stateKind",  "NEXT");
	    		
			}
			else
			{
		    	map.put("stateName",  "아직 6시간 지속되지 않음");	//아직 1단계!!!
		    	map.put("stateKind",  "FAIL");
			}
		}
		else if(alertCount >= 2) //현 전파프로세스 2단계라면 3단계로 넘어갈 조건 검사 (2단계 종료 후 12시간 지속)
		{	
			//12시간 간격설정 - KGB
			int startTimeDiff = 720 * (alertCount -1);
			int endTimeDiff = 720 * (alertCount);
			
			if(timeDiff >= startTimeDiff && timeDiff < endTimeDiff ) //12시간 지속 (이후에 계속 12시간씩 경보) -KGB
			{ 
				alertCount += 1;	//단계 업!
				
				map.put("stateName",  "경보지속(12)");
	    		map.put("stateKind",  "NEXT"); 
			}
			else
			{
	    		map.put("stateName",  "아직 12시간 지속되지 않음");	//아직 12시간 지나지 않음
	    		map.put("stateKind",  "FAIL");
			}
		}
		
		
//		else if(alertCount >= 3){  // -KGB (2단계 이후에는 12시간 간격으로 지속을 전파함)
//				map.put("stateName",  "상황해제");
//				map.put("stateKind",  "STOP");
//		}
		
		map.put("alertCount", alertCount);
    	map.put("stateValue", stepValue);	//상황조치단계는 유지됨	-KGB
    	
		return map;
	} 
   
	
	@Override
	protected abstract  void executeInternal(JobExecutionContext context)throws JobExecutionException;
}
 
