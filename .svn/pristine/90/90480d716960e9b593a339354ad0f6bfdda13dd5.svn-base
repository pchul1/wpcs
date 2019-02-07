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


public class AlertBySchdlrImplNew extends QuartzJobBean { 
	
	private static Log log = LogFactory.getLog(AlertBySchdlrImplNew.class);
	private static String ITEM_CODE_TUR00 = "TUR00";
	private static String ITEM_CODE_PHY00 = "PHY00";
	private static String ITEM_CODE_CON00 = "CON00";
	private static String ITEM_CODE_DOW00 = "DOW00";
		
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
	public AlertBySchdlrImplNew() {}
    
	/**
	 * 
	 * @see org.springframework.scheduling.quartz.QuartzJobBean#executeInternal(org.quartz.JobExecutionContext)
	 */
	@Override
    protected void executeInternal(JobExecutionContext ctx) throws JobExecutionException {

		log.debug("Start Alert by Scheduler!");
		
		
		try {

			AlertCntUpdateFlag = false;
			
			// 탁수 및 IP-USN
			// 새로 들어온 측정 자료를 조회한다.
			List<AlertMinVO> alertMinList = (List<AlertMinVO>)alertMakeDAO.getMinListNew();
			if( alertMinList.size() > 0 )
			{
				for(int i=0; i < alertMinList.size(); i++)
				{
					AlertMinVO alertMinVO = (AlertMinVO)alertMinList.get(i);
					alertMakeU(alertMinVO);
	
				}//end for(int i=0; i < alertMinList.size(); i++)
				
			}//end if( alertMinList.size() > 0 )
		}catch(Exception e){
			e.printStackTrace();
			log.error(" AlertBySchdlrImpl 스케줄러 executeInternal() 에러 : " + e.getMessage());
		}
		
	}

	/**
	 * IP-USN 경보 발생
	 * 
	 * @param alertMinVO
	 */
	@SuppressWarnings("unchecked")
	private void alertMakeU(AlertMinVO alertMinVO) {
		
		log.debug("Start Alert by Scheduler IP-USN!");
		
		try {
			
			String itemCodePhy	= ITEM_CODE_PHY00; //pH 수소이온농도
            String itemCodeDow	= ITEM_CODE_DOW00; //DO 용존산소
            String itemCodeCon	= ITEM_CODE_CON00; //EC 전기전도도
			
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

			//2015-11-20 경보기준 판단 변경
			List<AlertNewLawVO> alertNewLawList = (List<AlertNewLawVO>)alertMakeDAO.getNewLaw(alertSearchVO);
			if(alertNewLawList != null){
				Date currentDate = new Date(System.currentTimeMillis());
				SimpleDateFormat sdf = new SimpleDateFormat("MM");
				int curMm = Integer.parseInt(sdf.format(currentDate));
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
				 *  경계 : 전기전도도가 3배 이상 초과시
				 *  주의 : 수소이온농도 pH(phy), 전기전도도 EC(con), 용존산소량 DO(dow) 중 2개 이상이 2배 이상 초과시
				 *  		(단;수소이온농도 pH(phy)는 5 이하 또는 11 이상)
				 *  관심 : 수소이온농도 pH(phy), 전기전도도 EC(con), 용존산소량 DO(dow) 중 2개 이상이 기준 초과시
				 ***/
				int lawCount = 0;
				
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
				//MIN_OR(1:관심2:주의3:경계)
				if ( "1".equals(minOr) || "2".equals(minOr) ){ 
					if(flagPhy == 1 && flagDow == 1 && flagCon == 1)//CASE 1. PH/EC/DO 이상일경우
					{
						itemCode = itemCodePhy;
						itemCode1 = itemCodeDow;
						itemCode2 = itemCodeCon;
						minVl = phy;
						minVl1 = dow;
						minVl2 = con;
					}
					if (flagPhy == 1 && flagDow == 1) {
						itemCode = itemCodePhy;
						itemCode1 = itemCodeDow;
						minVl = phy;
						minVl1 = dow;
					} else if (flagPhy == 1 && flagCon == 1){
						itemCode = itemCodePhy;
						itemCode1 = itemCodeCon;
						minVl = phy;
						minVl1 = con;
					} else if (flagDow == 1 && flagCon == 1){
						log.debug("CALL!!! ");
						itemCode = itemCodeDow;
						itemCode1 = itemCodeCon;	
						minVl = dow;
						minVl1 = con;
					}else{
						minOr = "0";
					}
				}
			
			} else {
				minOr = "0";
				log.debug(" alertLawVO === null 이다");
			} 
			
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
				
				alertMakeDAO.updateMinOrNew(updateMap);
					
				if(!"".equals(itemCode1))
				{
					updateMap.put("itemCode", itemCode1);
					alertMakeDAO.updateMinOrNew(updateMap);
				}
				else if(!"".equals(itemCode2))
				{
					updateMap.put("itemCode", itemCode2);
					alertMakeDAO.updateMinOrNew(updateMap);
				}
				
			}// end if (Integer.parseInt(minOr) > 0)
			
		}catch(Exception e){
			e.printStackTrace();
			log.error(" AlertBySchdlrImpl 스케줄러 alertMakeU() 에러 : " + e.getMessage());
		}
	}	
	
}