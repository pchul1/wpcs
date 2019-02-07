package daewooInfo.alert.service.sch;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import daewooInfo.alert.bean.AlertDataVO;
import daewooInfo.alert.bean.AlertSendDataVO;
import daewooInfo.alert.dao.AlertDAO;
import daewooInfo.alert.dao.AlertSchDAO;
import daewooInfo.alert.util.DataUtil;

public class McsAgentArsProcess extends QuartzJobBean{
	
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	private Log log = LogFactory.getLog(McsAgentArsProcess.class);
	
	/**
	 * @uml.property  name="alertDAO"
	 * @uml.associationEnd  
	 */
	private AlertDAO alertDAO;
	/**
	 * @uml.property  name="alertSchDAO"
	 * @uml.associationEnd  
	 */
	private AlertSchDAO alertSchDAO;
	
	/**
	 * @param alertDAO
	 * @uml.property  name="alertDAO"
	 */
	public void setAlertDAO(AlertDAO alertDAO) {
		this.alertDAO = alertDAO;
	}  
	/**
	 * @param alertSchDAO
	 * @uml.property  name="alertSchDAO"
	 */
	public void setAlertSchDAO(AlertSchDAO alertSchDAO) {
		this.alertSchDAO = alertSchDAO;
	} 
	@Override
	protected void executeInternal(JobExecutionContext context)throws JobExecutionException {
		
		log.debug("#ARS Job Start "+DataUtil.logBeginTime()+" #"); 
		  
		try { 
			
			List<AlertSendDataVO> list= (List<AlertSendDataVO>)alertSchDAO.getAlertArsList(); 
			if(list.size()>0){
				for(int i=0;i < list.size();i++){ 
					
					AlertSendDataVO info  = (AlertSendDataVO)list.get(i); 
					
					AlertDataVO sms = new AlertDataVO();
					
					//탁수모니터링 SMS 전송  
					if(info.getAlertType().equals("TAKSU")){
						
						String msg ="";
						msg =info.getMsg()+"  "+info.getAlertMsg()+" "+info.getFactName()+"  "+info.getBranchNo();
						msg +="번 에서";
						msg +=info.getMinTime().substring(0, 4);
						msg +="년";
						msg +=info.getMinTime().substring(4, 6);
						msg +="월";
						msg +=info.getMinTime().substring(6, 8);
						msg +="일";
						msg +=info.getMinTime().substring(8, 10);
						msg +="시";
						msg +=info.getMinTime().substring(10, 12);
						msg +="분에 탁도 경보가 발령되었습니다.... 감사합니다.";
						 
						sms.setMinTime(info.getMinTime());
						sms.setFactCode(info.getFactCode());
						sms.setBranchNo(info.getBranchNo());
						sms.setItemCode(info.getItemCode()); 
						
						sms.setCallBack(info.getSendTel());
						sms.setDestInfo(info.getReceiveName()+"^"+info.getReceiveTel().replaceAll("-",""));
						sms.setPart(info.getPart());
						sms.setSmsMsg(msg);
					} 
					//ARS 전송
					alertDAO.insertVmsSend(sms);
					
					//ARS 전송 전송상태변경
					alertSchDAO.updateSmsClose(info); 
				} 
			}
			
			
		} catch (Exception e) { 
			e.printStackTrace();
			log.error(" McsAgentSmSProcess SMS 에러 : " + e.getMessage());
		}
		log.debug("#ARS Job End "+DataUtil.logBeginTime()+" #");
	}

}
