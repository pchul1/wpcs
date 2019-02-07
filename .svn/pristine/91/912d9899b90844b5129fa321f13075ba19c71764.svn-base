package daewooInfo.alert.service.impl;

import java.text.SimpleDateFormat;
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
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertSendDataVO;
import daewooInfo.alert.bean.AlertStepLastVO;
import daewooInfo.alert.bean.AlertStepVO;
import daewooInfo.alert.bean.AlertTaksuConfigVO;
import daewooInfo.alert.bean.AlertTargetVO;
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


public class AlertBySmsSchdlrImpl extends QuartzJobBean { 
	
	private static Log log = LogFactory.getLog(AlertBySmsSchdlrImpl.class);
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
	 * 생성자
	 */
	public AlertBySmsSchdlrImpl() {}
    
	/**
	 * 
	 * @see org.springframework.scheduling.quartz.QuartzJobBean#executeInternal(org.quartz.JobExecutionContext)
	 */
	@Override
    protected void executeInternal(JobExecutionContext ctx) throws JobExecutionException {

		log.debug("Start Alert by Scheduler!");
		
		
		try {

			// SMS 전송
			alertSendSms();
		}catch(Exception e){
			e.printStackTrace();
			log.error(" AlertBySmsSchdlrImpl 스케줄러 executeInternal() 에러 : " + e.getMessage());
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
	private void alertSendSms (){	
		try {
			
			AlertSearchVO alertSearchVO = new AlertSearchVO();
			AlertDataVO alertDataVO = new AlertDataVO();

			// SMS 전송대상 자료를 추출한다.
			List<AlertDataVO> alertSmsList = alertMakeDAO.getAlertSmSList();
			//System.out.println("전송자료 수  ===================  "+alertSmsList.size());
			if(alertSmsList.size() > 0) {
				int insertCount = 0;
				for (int j=0; j < alertSmsList.size(); j++) {
					alertDataVO = (AlertDataVO)alertSmsList.get(j);
					
					alertSearchVO.setFactCode(alertDataVO.getFactCode());
					
					// sms 보내는 담당자 번호  1666-0128
					AlertCallBackVO alertCallBackVO = alertMakeDAO.getCallBack(alertSearchVO);
					alertDataVO.setCallBack(alertCallBackVO.getCallBackTel());
					alertDataVO.setItemCode("NRECV"); //전파이력조회 자동전파 구분위해 넣어줍니다.
					
					if (alertDataVO.getSmsMsg() != null){
						// 경보 대상자 별로 mySql에 인서트 한다.
						alertDAO.insertSmsSend(alertDataVO);
						
						// SMS 발송 History Table Update
						alertMakeDAO.updateAlertData(alertDataVO);
						insertCount++;
					}
				}
				
			}else {
				log.debug("======SMS전송자료없음=======");
			}
									
		} catch(Exception e){
			e.printStackTrace();
			log.error(" AlertBySmsSchdlrImpl 스케줄러 alertSendSms() 에러 : " + e.getMessage());
		}
	}
}