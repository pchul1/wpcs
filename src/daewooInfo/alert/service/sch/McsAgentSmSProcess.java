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
/**
 * @author kichan
 * SMS 전송 모듈
 */
public class McsAgentSmSProcess extends QuartzJobBean{

	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	private Log log = LogFactory.getLog(McsAgentSmSProcess.class);
	
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
		
		log.debug("#SMS Job Start "+DataUtil.logBeginTime()+" #"); 
		  
		try { 
			
			List<AlertSendDataVO> list= (List<AlertSendDataVO>)alertSchDAO.getAlertSmsList(); 
			if(list.size()>0){
				for(int i=0;i < list.size();i++){ 
					
					AlertSendDataVO info  = (AlertSendDataVO)list.get(i); 
					
					AlertDataVO sms = new AlertDataVO();
					
					//탁수모니터링 SMS 전송 
					//EX)탁도(경보) 낙동강30-1 100926 18:30 
					if(info.getAlertType().equals("TAKSU")){
						
						String msg ="";
						msg =info.getMsg()+"("+info.getAlertMsg()+")"+" "+info.getFactName()+"-"+info.getBranchNo();
						msg +=" ";
						msg +=info.getMinTime().substring(2, 4);
						msg +="/";
						msg +=info.getMinTime().substring(4, 6);
						msg +="/";
						msg +=info.getMinTime().substring(6, 8);
						msg +=" ";
						msg +=info.getMinTime().substring(8, 10);
						msg +=":";
						msg +=info.getMinTime().substring(10, 12);
						
						sms.setMinTime(info.getMinTime());
						sms.setFactCode(info.getFactCode());
						sms.setBranchNo(info.getBranchNo());
						sms.setItemCode(info.getItemCode()); 
						
						sms.setCallBack(info.getSendTel());
						sms.setDestInfo(info.getReceiveName()+"^"+info.getReceiveTel().replaceAll("-",""));
						sms.setPart(info.getPart());
						sms.setSmsMsg(msg);
					}else if(info.getAlertType().equals("ALRAM")){ //수질자동 측정망
						 
						sms.setMinTime(info.getMinTime());
						sms.setFactCode(info.getFactCode());
						sms.setBranchNo(info.getBranchNo());
						sms.setItemCode(info.getItemCode()); 
						
						sms.setCallBack(info.getSendTel());
						sms.setDestInfo(info.getReceiveName()+"^"+info.getReceiveTel().replaceAll("-",""));
						sms.setPart(info.getPart());
						sms.setSmsMsg(info.getMsg());
					}
					//SMS 전송
					alertDAO.insertSmsSend(sms);
					
					//전송상태변경
					alertSchDAO.updateSmsClose(info); 
				} 
			}
			
			
		} catch (Exception e) { 
			e.printStackTrace();
			log.error(" McsAgentSmSProcess SMS 에러 : " + e.getMessage());
		}
		log.debug("#SMS Job End "+DataUtil.logBeginTime()+" #");
	}
}
