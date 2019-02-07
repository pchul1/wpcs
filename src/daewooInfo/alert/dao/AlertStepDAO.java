package daewooInfo.alert.dao;

import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.alert.bean.AlertSendDataVO;
import daewooInfo.alert.bean.AlertStepLastVO;
import daewooInfo.alert.bean.AlertStepVO;
import daewooInfo.cmmn.bean.FileVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * @author DaeWoo Information Systems Co., Ltd.  Technical Expert Team. loafzzang.
 * @version 1.0
 * @Class Name : .java
 * @Description :  Class
 * @Modification Information
 * @
 * @ Modify Date     author               Modify Contents
 * @ --------------  ------------   -------------------------------
 * @ 2010. 5. 19  	 khanian              new
 * @see Copyright (C) by DaeWoo Information Systems Co., Ltd. All right reserved.
 * @since 2010. 1. 21
 */

@Repository("alertStepDAO")
public class AlertStepDAO extends EgovAbstractDAO {
		
	public int insertAlertStep(AlertStepVO vo) throws Exception {
		return update("alertStepDAO.insertAlertStep", vo);
	}
	
	public int insertAlertStepSub(AlertStepVO vo) throws Exception {
		return update("alertStepDAO.insertAlertStepSub", vo);
	}
	
	public int updateAlertStep(AlertStepVO vo) throws Exception {
		return update("alertStepDAO.updateAlertStep", vo);
	}
	
	public String getMaxAsId() throws Exception {
		return (String)selectByPk("alertStepDAO.getMaxAsId", null);
	}
	
	public int getAlertStepListCount(AlertStepVO vo)
	{
		return (Integer)selectByPk("alertStepDAO.getAlertStepListCount", vo);
	} 
	@SuppressWarnings("unchecked")
	public List<AlertStepVO> getAlertStepList(AlertStepVO vo) throws Exception { 
		return list("alertStepDAO.getAlertStepList", vo); 
	}	
	
	@SuppressWarnings("unchecked")
	public List<AlertStepVO> getAlertStepSubList(AlertStepVO vo) throws Exception {
		return list("alertStepDAO.getAlertStepSubList", vo);
	}
	
	public AlertStepVO getAlertStep(AlertStepVO vo) throws Exception{
		return (AlertStepVO)selectByPk("alertStepDAO.getAlertStep", vo);
	}
	
	public AlertStepLastVO getLastAlert(AlertStepVO vo) throws Exception {
		return (AlertStepLastVO)selectByPk("alertStepDAO.getLastAlert", vo);
	}
	
	public int updateLastAlertStep(AlertStepVO vo) throws Exception {
		return update("alertStepDAO.updateLastAlertStep", vo);
	}
	
	/**
     * 여러 개의 파일에 대한 정보(속성 및 상세)를 등록한다.
     * 
     * @param fileList
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public String insertAlertFileInfs(List fileList) throws Exception {
	
    	FileVO vo 			= (FileVO)fileList.get(0);
    	String atchFileId 	= vo.getAtchFileId(); 

	Iterator iter = fileList.iterator();
	while (iter.hasNext()) {
	    vo = (FileVO)iter.next(); 
	    insert("alertStepDAO.insertAlertFile", vo);
	} 
	return atchFileId;
    }
    
    /**
     * 파일에 대한 상세정보를 조회한다. 
     * @param fvo
     * @return
     * @throws Exception
     */
    public FileVO selectAlertFileInf(FileVO fvo) throws Exception {
	return (FileVO)selectByPk("alertStepDAO.selectAlertFileInf", fvo);
    }
    
    /**
     * 경보발령단계에서 전송된 SMS/ARS정보를 조회합니다.
     * @param vo
     * @return
     * @throws Exception
     */
    public List<AlertSendDataVO> getSendWarningMsg(AlertStepVO vo) throws Exception{
    	return list("alertStepDAO.getSendWarningMsg",vo);
    }
    
    
    /**
     * 3분내에 등록된 사고조치접수내용을 가져옵니다.
     * @return
     * @throws Exception
     */
    public AlertStepVO getRecentAlertReg() throws Exception{
    	return (AlertStepVO)selectByPk("alertStepDAO.getRecentAlertReg", null);
    }
    

    /**
     * 3분내에 등록된 사고조치접수내용을 가져옵니다.
     * @return
     * @throws Exception
     */
    public AlertStepVO getNewWarring(AlertStepVO vo) throws Exception{
    	return (AlertStepVO)selectByPk("alertStepDAO.getNewWarring", vo);
    }

    /**
     * 사고조치내역의 시간을 업데이트합니다.
     * @param vo
     * @return
     * @throws Exception
     */
    public void updateAlertTime(AlertStepVO vo) throws Exception{
    	update("alertStepDAO.updateAlertTime", vo);
    }
    

    /**
     * 사고조치내역의 시간을 업데이트합니다.
     * @param vo
     * @return
     * @throws Exception
     */
    public void deleteAlertStep(AlertStepVO vo) throws Exception{
    	update("alertStepDAO.deleteAlertStep", vo);
    }
    
    public String firstAlertStepSeq(AlertStepVO vo) throws Exception{
    	return (String)selectByPk("alertStepDAO.firstAlertStepSeq", vo);
    }
}
