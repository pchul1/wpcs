package daewooInfo.alert.service;

import java.util.List;

import daewooInfo.alert.bean.AlertSendDataVO;
import daewooInfo.alert.bean.AlertStepVO; 
import daewooInfo.cmmn.bean.FileVO;
/**
 * @author  hyun
 */
public interface AlertStepService {
	
	public int insertAlertStep(AlertStepVO vo) throws Exception;
	public int insertAlertStepSub(AlertStepVO vo) throws Exception;
	public int updateAlertStep(AlertStepVO vo) throws Exception;
	/**
	 * @uml.property  name="maxAsId"
	 */
	public String getMaxAsId() throws Exception;
	public int getAlertStepListCount(AlertStepVO vo) throws Exception; 
	public List<AlertStepVO> getAlertStepList(AlertStepVO vo) throws Exception;
	public List<AlertStepVO> getAlertStepSubList(AlertStepVO vo) throws Exception;
	public AlertStepVO getAlertStep(AlertStepVO vo) throws Exception; 
    public String insertAlertFileInfs(List fvoList) throws Exception; 
    public FileVO selectAlertFileInf(FileVO fvo) throws Exception;
    public boolean sendSMS(AlertStepVO alertStepVO) throws Exception;
	public List<AlertSendDataVO> getSendWarningMsg(AlertStepVO vo) throws Exception;
	/**
	 * 추가상황전파
	 * @return
	 */
	public boolean addSendSMS(AlertStepVO alertStepVO, String[] members, String msg) throws Exception;
	
	/**
	 * @uml.property  name="recentAlertReg"
	 * @uml.associationEnd  
	 */
	public AlertStepVO getRecentAlertReg() throws Exception;
	public AlertStepVO getNewWarring(AlertStepVO vo) throws Exception;
	
	public void updateAlertTime(AlertStepVO vo) throws Exception;
	
	public String firstAlertStepSeq(AlertStepVO vo) throws Exception;
	public int prevAlertStep(AlertStepVO vo) throws Exception;
}
