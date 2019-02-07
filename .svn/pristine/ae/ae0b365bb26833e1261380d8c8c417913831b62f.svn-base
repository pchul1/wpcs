package daewooInfo.alert.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.alert.bean.AlertAlarmVO;
import daewooInfo.alert.bean.AlertDataLawVo;
import daewooInfo.alert.bean.AlertDataMinVo;
import daewooInfo.alert.bean.AlertMinVO;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertSendDataVO;
import daewooInfo.alert.bean.AlertStepLastVO;
import daewooInfo.alert.bean.AlertStepVO;
import daewooInfo.alert.bean.AlertTargetVO;
import daewooInfo.alert.bean.AlertVocsVO;
import daewooInfo.ipusn.bean.IpUsnVO;
import daewooInfo.smsmanage.bean.SmsBranchVO;
import daewooInfo.spotmanage.bean.SpotManageVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("alertSchDAO")
public class AlertSchDAO  extends EgovAbstractDAO{
	 
	/**
	 *  경보기준별 5분데이터 자료를 조회한다.
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AlertDataMinVo> getMinList(String sysKind) throws Exception { 
		HashMap map = new HashMap();
		map.put("sysKind", sysKind);  
		return list("alertSchDAO.getMinList", map);
	}
	/**현재조회된 시간이전 3시간동안 초과된 자료조회
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public AlertMinVO threeHourMinOverInfo(AlertSearchVO alertSearchVO) throws Exception { 
		return (AlertMinVO)selectByPk("alertSchDAO.threeHourMinOverInfo", alertSearchVO); 
	}
	@SuppressWarnings("unchecked")
	public AlertMinVO threeHourMinOverCount(AlertSearchVO alertSearchVO) throws Exception {
		return (AlertMinVO)selectByPk("alertSchDAO.threeHourMinOverCount", alertSearchVO);
	} 
	/** 탁수 경보기준을 가져온다 
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public AlertDataLawVo getFactLaw(AlertSearchVO alertSearchVO) throws Exception { 
		return (AlertDataLawVo)selectByPk("alertSchDAO.getFactLaw", alertSearchVO); 
	} 
	/**
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public AlertStepLastVO getLastAlertStep(AlertSearchVO vo) throws Exception {
		return (AlertStepLastVO)selectByPk("alertSchDAO.getLastAlertStep", vo);
	}
	/**
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public AlertStepVO getSelectOverStep(AlertSearchVO vo) throws Exception {
		return (AlertStepVO)selectByPk("alertSchDAO.selectOverStep", vo);
	}
	/**
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int updateStep(AlertStepVO vo) throws Exception {
		return update("alertSchDAO.updateStep", vo);
	} 
	/**
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int updateMinState(HashMap paramMap) throws Exception {
		return update("alertSchDAO.updateMinState", paramMap);
	}
	/**
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public AlertDataMinVo getMinTopData(AlertSearchVO alertSearchVO) throws Exception {  
		return (AlertDataMinVo)selectByPk("alertSchDAO.getMinTopData", alertSearchVO);  
	}  
	/**
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int updateStepAlertCount(AlertStepVO vo) throws Exception {
		return update("alertSchDAO.updateStepAlertCount", vo);
	} 
	
	/**
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public int insertAlertSendData(AlertSendDataVO vo) throws Exception {
		return update("alertSchDAO.insertAlertSendData", vo);
	}
	/**
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AlertTargetVO> getTargetList(AlertSendDataVO vo) throws Exception{
		return list("alertSchDAO.getTargetList", vo);
	}
	@SuppressWarnings("unchecked")
	public List<AlertSendDataVO> getAlertSmsList() throws Exception{
		return list("alertSchDAO.getAlertSmsList", null);
	}
	public List<AlertSendDataVO> getAlertArsList() throws Exception{
		return list("alertSchDAO.getAlertArsList", null);
	} 
	public int updateSmsClose(AlertSendDataVO vo) throws Exception {
		return update("alertSchDAO.updateSmsClose", vo);
	}  
	public List<AlertAlarmVO> getAlarmList() throws Exception{
		return list("alertSchDAO.getAlarmList", null);
	} 
	
	public int isLastData(AlertSearchVO vo) throws Exception{
		return (Integer)selectByPk("alertSchDAO.isLastData", vo);
	}
	
	/**
	 * 30분 이상 미수신중인 IP-USN 측정소 목록을 가져옵니다.
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<AlertStepVO> getNorecvList() throws Exception{
		return list("alertSchDAO.getNorecvList", null);
	}

	/**
	 * 10분 이상 미수신중인 IP-USN 측정소 목록을 가져옵니다.
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<AlertStepVO> getNorecvFirstList() throws Exception{
		return list("alertSchDAO.getNorecvFirstList", null);
	}
	
	/**
	 * 20분 이상 기준초과인지 판단합니다. 결과값이 0이면 20분동안 기준초과한 것입니다. (기준치 보다 낮은 값이 20분동안 없음)
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public Integer getIsVocAlert20Min(AlertVocsVO vo) throws Exception{
		return (Integer)selectByPk("alertSchDAO.getIsVocAlert20Min", vo);
	}
	
	/**
	 * 20분동안 들어온 데이터 수
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public Integer getVoc20MinCnt(AlertVocsVO vo) throws Exception{
		return (Integer)selectByPk("alertSchDAO.getVoc20MinCnt",vo);
	}
	
	/**
	 * 첫 미수신 전송기록이 있는지 확인합니다. 결과값이 0이면 30분동안 첫미수신 전송기록이 없는것입니다.
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public Integer getIsNorecvFirst(AlertStepVO vo) throws Exception {
		return (Integer)selectByPk("alertSchDAO.getIsNorecvFirst", vo);
	}
	
	/**
	 * 30분 미수신 전송기록이 있는지 확인합니다. 결과값이 0이면 30분동안 미수신 전송기록이 없는것입니다.
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public Integer getIsNorecv30Min(AlertStepVO vo) throws Exception {
		return (Integer)selectByPk("alertSchDAO.getIsNorecv30Min", vo);
	}
	
	/**
	 * 첫 VOCS관리기준 초과 전송기록이 있는지 확인합니다. 0 이면 30분동안 VOCS관리기준 전송기록이 없는것입니다.
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public Integer getIsVocsFirst(AlertVocsVO vo) throws Exception {
		return (Integer)selectByPk("alertSchDAO.getIsVocsFirst", vo);
	}
	
	
	public void updateNorecvIsNotFirst(AlertStepVO vo) throws Exception {
		update("alertSchDAO.updateNorecvIsNotFirst", vo);
	}
	
	
	
	/**
	 * 수신측정소목록
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<AlertStepVO> getRecvList() throws Exception {
		return list("alertSchDAO.getRecvList", null);
	}
	
	/**
	 * 수신 측정소 FLAG 업뎃
	 * @param vo
	 * @throws Exception
	 */
	public void updateRecv(AlertStepVO vo) throws Exception
	{
		update("alertSchDAO.updateRecv", vo);
	}

	
	/**
	 * VOCS 전송 FLAG 업뎃
	 * @param vo
	 * @throws Exception
	 */
	public void updateVocs(AlertVocsVO vo) throws Exception
	{
		update("alertSchDAO.updateVocs", vo);
	}
	
	
	/**
	 * VOCS 5분측정 리스트
	 * @return
	 * @throws Exception
	 */
	public List<AlertVocsVO> getVocsData() throws Exception
	{
		return list("alertSchDAO.getVocsData", null);
	}
	
	/**
	 * @return
	 * @throws Exception
	 */
	public AlertVocsVO getVocsLaw(AlertVocsVO vo) throws Exception
	{
		return (AlertVocsVO)selectByPk("alertSchDAO.getVocsLaw", vo);
	}
	
	/**
	 * VOCS->ECD 관리기준
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public AlertVocsVO getVocsECDLaw(AlertVocsVO vo) throws Exception
	{
		return (AlertVocsVO)selectByPk("alertSchDAO.getVocsECDLaw", vo);
	}
	public SmsBranchVO getSmsUsnSetting(SmsBranchVO smsBranchVo) {
		return (SmsBranchVO)selectByPk("alertSchDAO.getSmsUsnSetting", smsBranchVo);
		
	}
	public Integer getIsNorecvFirstUsn(AlertStepVO vo) throws Exception {
		return (Integer)selectByPk("alertSchDAO.getIsNorecvFirstUsn", vo);
	}
	
	
	public List<IpUsnVO> getIpUsnList() throws Exception{
		// TODO Auto-generated method stub
		return list("alertSchDAO.getIpUsnList", null);
	}
	public Integer getSmsUsnSettingCnt (SmsBranchVO smsBranchVo) throws Exception {
		return (Integer)selectByPk("alertSchDAO.getSmsUsnSettingCnt", smsBranchVo);
	}
	
	public String getLastRecvMinTime(AlertStepVO vo) throws Exception {
		return (String)selectByPk("alertSchDAO.getLastRecvMinTime", vo);
	}
}


