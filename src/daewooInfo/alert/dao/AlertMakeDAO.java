package daewooInfo.alert.dao;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Repository;

import com.ibatis.sqlmap.client.SqlMapClient;

import daewooInfo.alert.bean.AlertAlarmVO;
import daewooInfo.alert.bean.AlertCallBackVO;
import daewooInfo.alert.bean.AlertConfigVO;
import daewooInfo.alert.bean.AlertDataVO;
import daewooInfo.alert.bean.AlertHourVO;
import daewooInfo.alert.bean.AlertLawVO;
import daewooInfo.alert.bean.AlertMinVO;
import daewooInfo.alert.bean.AlertNewLawVO;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertSendDataVO;
import daewooInfo.alert.bean.AlertSmsBranchVO;
import daewooInfo.alert.bean.AlertSmsCommVO;
import daewooInfo.alert.bean.AlertSmsListSearchVO;
import daewooInfo.alert.bean.AlertSmsListVO;
import daewooInfo.alert.bean.AlertStepVO;
import daewooInfo.alert.bean.AlertTargetVO;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.dailywork.bean.DailyWorkApprovalVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;


/**
 * @author DaeWoo Information Systems Co., Ltd.  Technical Expert Team. khanian.
 * @version 1.0
 * @Class Name : .java
 * @Description :  Class
 * @Modification Information
 * @
 * @ Modify Date     author               Modify Contents
 * @ --------------  ------------   -------------------------------
 * @ 2010. 4. 14  	 khanian              new
 * @see Copyright (C) by DaeWoo Information Systems Co., Ltd. All right reserved.
 * @since 2010. 1. 21
 */

@Repository("alertMakeDAO")
public class AlertMakeDAO extends EgovAbstractDAO{
		
	/**
	 * 새로 들어온 분 데이터를 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AlertMinVO> getMinList() throws Exception {
		return list("alertMakeDAO.getMinList", null);
	}
	
	
	/**
	 * 새로 들어온 분 데이터를 가져온다.
	 * 
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AlertMinVO> getMinListNew() throws Exception {
		return list("alertMakeDAO.getMinListNew", null);
	}
	
	/**
	 * 새로 들어온 시간 데이터를 가져온다. (미사용)
	 *  
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AlertHourVO> getHourList() throws Exception{
		return list("alertMakeDAO.getHourList", null);
	}
	
	/**
	 * 분 자료 테이블에 해당된 오염사고의 한 시간 동안의 갯수 (미사용)
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int getOverCount(HashMap paramMap) throws Exception {
		return (Integer)selectByPk("alertMakeDAO.getOverCount", paramMap);
	}
	
	/**
	 * 보내는 사람의 번호를 가져온다. 방제센터 번호
	 * 
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public AlertCallBackVO getCallBack(AlertSearchVO alertSearchVO) throws Exception{
		return (AlertCallBackVO)selectByPk("alertMakeDAO.getCallBack", alertSearchVO);
	}
	
	/**
	 * 경보 기준을 가져온다.
	 * 
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public AlertLawVO getLaw(AlertSearchVO alertSearchVO) throws Exception{
		return (AlertLawVO)selectByPk("alertMakeDAO.getLaw", alertSearchVO);
	}
	
	/**
	 * 공구,사업장의 이름을 가져온다.
	 * 
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public String getFactName(AlertSearchVO alertSearchVO) throws Exception{
		return (String)selectByPk("alertMakeDAO.getFactName", alertSearchVO);
	}
	
	/**
	 * 측정소 이름을 가져온다.
	 * 
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public String getBranchName(AlertSearchVO alertSearchVO) throws Exception{
		return (String)selectByPk("alertMakeDAO.getBranchName", alertSearchVO);
	}
	
	/**
	 * 측정항목의 이름을 가져온다.
	 * 
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */	
	public String getItemName(AlertSearchVO alertSearchVO) throws Exception{
		return (String)selectByPk("alertMakeDAO.getItemName", alertSearchVO);
	}
	
	/**
	 * 경보 환경 설정을 가져온다.
	 * 
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	public AlertConfigVO getConfig(AlertSearchVO alertSearchVO) throws Exception{
		return (AlertConfigVO)selectByPk("alertMakeDAO.getConfig", alertSearchVO);
	}
	
	/**
	 * 경보 발송 대상자를 가져온다.
	 * 
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AlertTargetVO> getTargetList(AlertSearchVO alertSearchVO) throws Exception{
		return list("alertMakeDAO.getTargetList", alertSearchVO);
	}
	
	/**
	 * 수동 경보 발송 대상자를 가져온다.
	 * 
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AlertTargetVO> getTargetManualList(HashMap map) throws Exception{
		return list("alertMakeDAO.getTargetManualList", map);
	}
	
	/**
	 * 오염 판단이 끝난 자료를 업데이트한다.(min_dcd=0) 
	 * 
	 * @return
	 * @throws Exception
	 */
	public int updateMin() throws Exception {
		return update("alertMakeDAO.updateMin", null);
	}
	
	/**
	 * 오염 단계를 분자료 테이블에 업데이트한다.
	 * 
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int updateMinOr(HashMap paramMap) throws Exception {
		return update("alertMakeDAO.updateMinOr", paramMap);
	}
	
	/**
	 * 오염 단계를 분자료 테이블에 업데이트한다.
	 * 
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int updateMinOrNew(HashMap paramMap) throws Exception {
		return update("alertMakeDAO.updateMinOrNew", paramMap);
	}
	
	/**
	 * 국가수질자동측정망의 경보발생자료를 가져온다.
	 * 
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AlertAlarmVO> getAlarmList() throws Exception {
		return list("alertMakeDAO.getAlarmList", null);
	}
	
	/**
	 * 국가수질자동측정망 발송 시 발송 여부를 업데이트 한다.
	 * 
	 * @param paramMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int updateAlarm(AlertAlarmVO vo) throws Exception {
		return update("alertMakeDAO.updateAlarm", vo);
	}	
	
	/**
	 * SMS 발송 메세지 내역을 가져온다.
	 * 
	 * @param map
	 * @return map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<HashMap> getSendSmsMsgList(HashMap map) throws Exception {
		return list("alertMakeDAO.getSendSmsMsgList", map);
	}	
	
	/**
	 * SMS 발송 메세지를 저장한다.
	 * 
	 * @param map
	 * @return map
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public int saveSmsMsgList(HashMap map) throws Exception {
		return update("alertMakeDAO.saveSmsMsgList", map);
	}
	
	/**
	 * @param map 데이터 검증
	 * @return  
	 * @throws Exception
	 */
	public int saveAlertData(HashMap map) throws Exception {
		return update("alertMakeDAO.saveAlertData", map);
	}
	
	
	
	/**
	 * SMS 발송 메세지를 저장한다.
	 * 
	 * @param AlertStepVO
	 * @return AlertMinVO
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public AlertMinVO getPreMin(AlertStepVO vo) throws Exception {
		return (AlertMinVO)selectByPk("alertMakeDAO.getPreMin", vo);
	}		
	
	/**
	 * USN 30분 데이터를 가져온다.
	 * 
	 * @param AlertStepVO
	 * @return AlertMinVO
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AlertMinVO> getMinPreUsnList(AlertStepVO vo) throws Exception {
		return list("alertMakeDAO.getMinPreUsnList", vo);
	}	
	/**
	 * 신고접수 경보 발송 대상자를 가져온다. 
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AlertTargetVO> getTargetSmSList(HashMap map) throws Exception{
		return list("alertMakeDAO.getTargetSmSList", map);
	}

	@SuppressWarnings("unchecked")
	public String saveSmsMsgHist(HashMap map) throws Exception{
		return (String) insert("alertMakeDAO.saveSmsMsgHist", map);
	}

	@SuppressWarnings("unchecked")
	public void saveSmsMsgHistDetail(HashMap map) throws Exception{
		insert("alertMakeDAO.saveSmsMsgHistDetail", map);
	}

	@SuppressWarnings("unchecked")
	public List<HashMap> getSendSmsMsgMemberList(HashMap map) {
		return list("alertMakeDAO.getSendSmsMsgMemberList", map);
	}
	
	/**
	 * 경보 발송 자료를 가져온다. 
	 * @param alertSearchVO
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<AlertDataVO> getAlertSmSList() throws Exception{
		return list("alertMakeDAO.getAlertSmSList",null);
	}
	
	/**
	 * 경보 발송 자료를 Update.
	 * @param map 데이터 검증
	 * @return  
	 * @throws Exception
	 */
	public int updateAlertData(AlertDataVO alertDataVO) throws Exception {
		return update("alertMakeDAO.updateAlertData", alertDataVO);
	}
	@SuppressWarnings("unchecked")
	public List<AlertTargetVO> getTargetLeaveSms(AlertSearchVO alertSearchVO) throws Exception {
		return list("alertMakeDAO.getTargetLeaveSms", alertSearchVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<AlertTargetVO> getTargetBranchSmsList(AlertSearchVO alertSearchVO) throws Exception{
		return list("alertMakeDAO.getTargetBranchSmsList", alertSearchVO);
	}
	@SuppressWarnings("unchecked")
	public List<AlertNewLawVO> getNewLaw(AlertSearchVO alertSearchVO) throws Exception {
		return list("alertMakeDAO.getNewLaw", alertSearchVO);
	}

	public AlertSmsBranchVO getSmsBranchConf(AlertSearchVO alertSearchVO) throws Exception {
		return (AlertSmsBranchVO)selectByPk("alertMakeDAO.getSmsBranchConf", alertSearchVO);
	}

	public AlertSmsCommVO getSmsCommConf(String detCode) throws Exception {
		return (AlertSmsCommVO)selectByPk("alertMakeDAO.getSmsCommConf", detCode);
	}
	@SuppressWarnings("unchecked")
	public List<AlertTargetVO> getTargetCommSmsList(AlertSearchVO alertSearchVO) throws Exception{
		return list("alertMakeDAO.getTargetCommSmsList", alertSearchVO);
	}

	public int getIsAbnormal(AlertSearchVO alertSearchVO) throws Exception{
		return (Integer)selectByPk("alertMakeDAO.getIsAbnormal", alertSearchVO);
	}
	
	public String getBeforeItemValue(AlertSearchVO alertSearchVO) throws Exception{
		return (String)selectByPk("alertMakeDAO.getBeforeItemValue", alertSearchVO);
	}


	@SuppressWarnings("unchecked")
	public List<AlertSmsListVO> getSmsDataList(AlertSmsListSearchVO alertSmsListSearchVO) throws Exception{
		return list("alertMakeDAO.getSmsDataList", alertSmsListSearchVO);
	}


	public int getSmsDataListCount(AlertSmsListSearchVO alertSmsListSearchVO) throws Exception{
		return (Integer)selectByPk("alertMakeDAO.getSmsDataListCount", alertSmsListSearchVO);
	}
	
	public void insertManualSendData(AlertSendDataVO alertSendDataVO) throws Exception{
		insert("alertMakeDAO.insertManualSendData", alertSendDataVO);
	}
	
	public String getAddressFileSeq(HashMap map) throws Exception{
		return (String)selectByPk("alertMakeDAO.getAddressFileSeq", map);
	}
	
	public String insertAddressFileInfs(List<FileVO> result) throws Exception {
		FileVO vo			= (FileVO)result.get(0);
		String atchFileId	= vo.getAtchFileId(); 
		
		//insert("alertMakeDAO.insertAddressFile", vo);

		Iterator iter = result.iterator();
		while (iter.hasNext()) {
			vo = (FileVO)iter.next(); 
			insert("alertMakeDAO.insertAddressFileDetail", vo);
		} 
		return atchFileId;
	}
	
	@SuppressWarnings("unchecked")
	public List<AlertSmsListVO> getDailyWorkSmsList(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception{
		return list("alertMakeDAO.getDailyWorkSmsList", dailyWorkApprovalVO);
	}
}