package daewooInfo.alert.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertTaksuConfigVO;
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
 * @ 2010. 3. 26  	 khanian              new
 * @see Copyright (C) by DaeWoo Information Systems Co., Ltd. All right reserved.
 * @since 2010. 1. 21
 */

@Repository("alertTaksuConfigDAO")
public class AlertTaksuConfigDAO extends EgovAbstractDAO {

	/**
	 * 탁수 경보전파설정 목록을 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AlertTaksuConfigVO> getAlertTaksuConfig() throws Exception {
		return list("alertTaksuConfigDAO.getAlertTaksuConfig", null);
	}	
	
	/**
	 * 탁수 경보전파설정을 한다
	 * 
	 * @return
	 * @throws Exception
	 */
	public int mergeAlertTaksuConfig(AlertTaksuConfigVO vo) throws Exception {
		return update("alertTaksuConfigDAO.mergeAlertTaksuConfig", vo);
	}	
	
	/**
	 * 탁수 경보전파설정 로그 목록을 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AlertTaksuConfigVO> getAlertTaksuConfigHist(AlertSearchVO vo) throws Exception {
		return list("alertTaksuConfigDAO.getAlertTaksuConfigHist", vo);
	}	
	
	/**
	 * 탁수 경보전파설정 로그를 저장 한다
	 * 
	 * @return
	 * @throws Exception
	 */
	public int insertAlertTaksuConfigHist(AlertTaksuConfigVO vo) throws Exception {
		return update("alertTaksuConfigDAO.insertAlertTaksuConfigHist", vo);
	}		
	
	/**
	 * 배치 시 경보설정 해제할 목록을 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AlertTaksuConfigVO> getAlertTaksuConfigAuto() throws Exception {
		return list("alertTaksuConfigDAO.getAlertTaksuConfigAuto", null);
	}		
	
	/**
	 * 특정 공구의 탁수 설정을 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	public int getAlertTaksuConfigFlag(AlertTaksuConfigVO vo) throws Exception {
		return (Integer)selectByPk("alertTaksuConfigDAO.getAlertTaksuConfigFlag", vo);
	}			
}
