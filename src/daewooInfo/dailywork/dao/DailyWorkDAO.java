package daewooInfo.dailywork.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import daewooInfo.dailywork.bean.CheckUseDetailVO;
import daewooInfo.dailywork.bean.CheckUseVO;
import daewooInfo.dailywork.bean.DailyWorkApprovalVO;
import daewooInfo.dailywork.bean.DailyWorkRainVO;
import daewooInfo.dailywork.bean.DailyWorkSearchVO;
import daewooInfo.dailywork.bean.DailyWorkVO;
import daewooInfo.dailywork.bean.DailyWorkWriteAuthVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 
 * 업무일지에 대한 데이터 접근 클래스를 정의한다
 * @author yrkim
 * @since 2014.09.18
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2014.09.18  yrkim          최초 생성
 *
 * </pre>
 */
@Repository("DailyWorkDAO")
public class DailyWorkDAO extends EgovAbstractDAO {
	
	/** log */
    protected static final Log log = LogFactory.getLog(DailyWorkDAO.class);
	
    /**
     * 업무일지 데이터 목록 (페이징)
     * @param vo
     * @return
     * @throws Exception
     */
    public List dailyWorkList(DailyWorkSearchVO dailyWorkSearchVO) throws Exception {
    	return list("DailyWorkDAO.dailyWorkList", dailyWorkSearchVO);
    }
    
    
    
    /**
     * 업무일지 데이터 목록 카운트
     * @param vo
     * @return
     * @throws Exception
     */
    public int dailyWorkListCnt(DailyWorkSearchVO dailyWorkSearchVO) throws Exception {
    	return (Integer)selectByPk("DailyWorkDAO.dailyWorkListCnt", dailyWorkSearchVO);
    }
    
    /**
     * 결재자 정보
     */
    public String approvalNameSelect(String approvalId) throws Exception {
    	return (String)getSqlMapClientTemplate().queryForObject("DailyWorkDAO.approvalNameSelect", approvalId);
    }
    
    /**
     * 업무일지 중복체크
     * @param vo
     * @return
     * @throws Exception
     */
    public int selectDailyWorkInfo(DailyWorkVO dailyWorkVO) throws Exception {
    	return (Integer)selectByPk("DailyWorkDAO.selectDailyWorkInfo", dailyWorkVO);
    }
    
    /**
     * 업무일지 결재정보 seq
     * @param vo
     * @return
     * @throws Exception
     */
    public int getDailyWorkApprovalSeq(String dailyWorkId) throws Exception {
    	return (Integer)selectByPk("DailyWorkDAO.getDailyWorkApprovalSeq", dailyWorkId);
    }
    
    /**
     * 업무일지 작성권한 seq
     * @param vo
     * @return
     * @throws Exception
     */
    public int getDailyWorkWriteAuthSeq(String dailyWorkId) throws Exception {
    	return (Integer)selectByPk("DailyWorkDAO.getDailyWorkWriteAuthSeq", dailyWorkId);
    }
    
    /**
     * 업무일지 기본정보 등록
     */
    public void insertDailyWorkInfo(DailyWorkVO dailyWorkVO) throws Exception{
    	insert("DailyWorkDAO.insertDailyWorkInfo", dailyWorkVO);
    }
    
    /**
     * 업무일지 수정이력 등록
     */
    public void insertDailyWorkHisInfo(DailyWorkVO dailyWorkVO) throws Exception{
    	insert("DailyWorkDAO.insertDailyWorkHisInfo", dailyWorkVO);
    }
    
    /**
     * 업무일지 결재정보 등록
     */
    public void insertDailyWorkApprovalInfo(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception{
    	insert("DailyWorkDAO.insertDailyWorkApprovalInfo", dailyWorkApprovalVO);
    }
    
    /**
     * 업무일지 작성권한정보 등록
     */
    public void insertDailyWriteAuthInfo(DailyWorkWriteAuthVO dailyWorkWriteAuthVO) throws Exception{
    	insert("DailyWorkDAO.insertDailyWriteAuthInfo", dailyWorkWriteAuthVO);
    }
    
    /**
     * 업무일지 기본정보 조회
     */
    public DailyWorkVO selectDailyWorkMasterInfo(String dailyWorkId) throws Exception{
    	return (DailyWorkVO)selectByPk("DailyWorkDAO.selectDailyWorkMasterInfo", dailyWorkId);
    }
    
    /**
     * 업무일지 결재정보 조회
     */
    public List<DailyWorkApprovalVO> selectDailyWorkApprovalList(String dailyWorkId) throws Exception{
    	return list("DailyWorkDAO.selectDailyWorkApprovalList", dailyWorkId);
    }
    
    /**
     * 업무일지 결재정보 등록
     */
    public void dailyWorkInfoDelete(String dailyWorkId) throws Exception{
    	update("DailyWorkDAO.dailyWorkInfoDelete", dailyWorkId);
    }
    
    /**
     * 업무일지 기본정보 수정
     */
    public void updateDailyWorkInfo(DailyWorkVO dailyWorkVO) throws Exception{
    	update("DailyWorkDAO.updateDailyWorkInfo", dailyWorkVO);
    }
    
    /**
     * 업무일지 결재정보 수정
     */
    public void updateDailyWorkApprovalInfo(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception{
    	update("DailyWorkDAO.updateDailyWorkApprovalInfo", dailyWorkApprovalVO);
    }
    
    /**
     * 업무일지 결재정보 삭제
     */
    public void deleteDailyWorkApprovalInfo(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception{
    	delete("DailyWorkDAO.deleteDailyWorkApprovalInfo", dailyWorkApprovalVO);
    }
    
    /**
     * 업무일지 작성권한 삭제
     */
    public void deleteDailyWorkAuthInfo(DailyWorkWriteAuthVO dailyWorkWriteAuthVO) throws Exception{
    	delete("DailyWorkDAO.deleteDailyWorkAuthInfo", dailyWorkWriteAuthVO);
    }
    
    /**
     * 업무일지 작성권한정보 수정
     */
    public void updateDailyWriteAuthInfo(DailyWorkWriteAuthVO dailyWorkWriteAuthVO) throws Exception{
    	update("DailyWorkDAO.updateDailyWriteAuthInfo", dailyWorkWriteAuthVO);
    }
    
    /**
     * 업무일지 강우현황 저장
     */
    public void insertDailyWorkRainInfo(DailyWorkRainVO dailyWorkRainVO) throws Exception{
    	insert("DailyWorkDAO.insertDailyWorkRainInfo", dailyWorkRainVO);
    }
    
    /**
     * 강우현황 SEQ 
     */
    public int getDailyWorkRainSeq(DailyWorkRainVO dailyWorkRainVO) throws Exception{
    	return (Integer)selectByPk("DailyWorkDAO.getDailyWorkRainSeq", dailyWorkRainVO);
    }
    
    /**
     * 업무일지 강우현황 정보 조회
     */
    public List<DailyWorkRainVO> selectDailyWorkRainInfo(DailyWorkRainVO dailyWorkRainVO) throws Exception {
		return list("DailyWorkDAO.selectDailyWorkRainInfo", dailyWorkRainVO);
    }
    
    /**
     * 업무일지 강우현황 삭제
     */
    public void deleteDailyWorkRainInfo(String dailyWorkId) throws Exception{
    	delete("DailyWorkDAO.deleteDailyWorkRainInfo", dailyWorkId);
    }
    
    /**
     * 업무일지 작성권한 체크
     * @param vo
     * @return
     * @throws Exception
     */
    public int getDailyWorkWriteAuthId(DailyWorkWriteAuthVO dailyWorkWriteAuthVO) throws Exception {
    	return (Integer)selectByPk("DailyWorkDAO.getDailyWorkWriteAuthId", dailyWorkWriteAuthVO);
    }
    
    /**
	 * 업무일지 상태 변경
	 */
    
    public void updateDailyWorkStateInfo(DailyWorkVO dailyWorkVO) throws Exception{
    	update("DailyWorkDAO.updateDailyWorkStateInfo", dailyWorkVO);
    }
    
    /**
     * 결재자 정보 조회
     */
    public String getApprovalMemberId(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception {
    	return (String)getSqlMapClientTemplate().queryForObject("DailyWorkDAO.getApprovalMemberId", dailyWorkApprovalVO);
    }
    
    /**
     * 결재상신자 정보 조회
     */
    public String getDailyWorkApprovalId(String dailyWorkId) throws Exception {
    	return (String)getSqlMapClientTemplate().queryForObject("DailyWorkDAO.getDailyWorkApprovalId", dailyWorkId);
    }
    
    /**
     * 사용자별 결재대기 건수
     * @param vo
     * @return
     * @throws Exception
     */
    public int getDailyWorkApprovalCnt(String userId) throws Exception {
    	return (Integer)selectByPk("DailyWorkDAO.getDailyWorkApprovalCnt", userId);
    }
    
    /**
     * 받은결재조회 데이터 목록(페이징)
     * @param vo
     * @return
     * @throws Exception
     */
    public List receiveApprovalList(DailyWorkSearchVO dailyWorkSearchVO) throws Exception {
    	return list("DailyWorkDAO.receiveApprovalList", dailyWorkSearchVO);
    }
    
    /**
     * 받은결재조회 데이터 목록 카운트
     * @param vo
     * @return
     * @throws Exception
     */
    public int receiveApprovalListCnt(DailyWorkSearchVO dailyWorkSearchVO) throws Exception {
    	return (Integer)selectByPk("DailyWorkDAO.receiveApprovalListCnt", dailyWorkSearchVO);
    }
    
    /**
     * 결재 등록
     */
    public void insertApproval(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception{
    	update("DailyWorkDAO.insertApproval", dailyWorkApprovalVO);
    }
    
    /**
     * 결재 상태 변경
     */
    public void updateApprovalState(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception{
    	update("DailyWorkDAO.updateApprovalState", dailyWorkApprovalVO);
    }
    
    /**
	 * 결재완료 처리
	 */
    public void updateDailyWorkState(DailyWorkVO dailyWorkVO) throws Exception{
    	update("DailyWorkDAO.updateDailyWorkState", dailyWorkVO);
    }
    
    /**
	 * 결재완료 처리
	 */
    public void updateCheckUseState(DailyWorkVO dailyWorkVO) throws Exception{
    	update("DailyWorkDAO.updateCheckUseState", dailyWorkVO);
    }
    
    /**
     * 작성권한 사용자 정보 가져오기
     */
    public List getAuthUserList(String dailyWorkId) throws Exception {
		return list("DailyWorkDAO.getAuthUserList", dailyWorkId);
    }
    
    /**
     * 결재 승인에 대한 정보 가져오기
     */
    public List getAppovalInfo(String dailyWorkId) throws Exception {
		return list("DailyWorkDAO.getAppovalInfo", dailyWorkId);
    }
    
    /**
     * 수정이력 정보 가져오기
     */
    public List getDailyWorkHisInfoList(String dailyWorkId) throws Exception {
		return list("DailyWorkDAO.getDailyWorkHisInfoList", dailyWorkId);
    }
    
    /**
     * 결재요청 정보 등록
     */
    public void updateApprovalRequestInfo(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception{
    	update("DailyWorkDAO.updateApprovalRequestInfo", dailyWorkApprovalVO);
    }
    /**
     * T_DAILY_WORK STATE, APPROVAL_ID, APPROVAL_DATE 변경 
     */
	public void updateDailyWorkInfo(String dailyWorkId) throws Exception{
		update("DailyWorkDAO.updateDailyWork", dailyWorkId);
	}
	/**
     * T_DAILY_APPROVAL UPDATE
     */
	public void updateDailyWorkApproval(String dailyWorkId) throws Exception {
		update("DailyWorkDAO.deleteDailyWorkApproval", dailyWorkId);
	}
	/**
     * T_WORK_JOURNAL INSERT
     */
	public void insertWorkJournalInfo(DailyWorkVO dailyWorkVO) throws Exception {
		update("DailyWorkDAO.insertWorkJournalInfo", dailyWorkVO);
	}
	
	/**
     * 업무일지 데이터 목록 (페이징)
     * @param vo
     * @return
     * @throws Exception
     */
    public List workJournalList(DailyWorkSearchVO dailyWorkSearchVO) throws Exception {
    	return list("DailyWorkDAO.workJournalList", dailyWorkSearchVO);
    }
    
    /**
     * 업무일지 데이터 목록 카운트
     * @param vo
     * @return
     * @throws Exception
     */
    public int workJournalListCnt(DailyWorkSearchVO dailyWorkSearchVO) throws Exception {
    	return (Integer)selectByPk("DailyWorkDAO.workJournalListCnt", dailyWorkSearchVO);
    }
    
    /**
     * T_WORK_JOURNAL UPDATE
     */
	public void updateWorkJournalInfo(DailyWorkVO dailyWorkVO) throws Exception {
		update("DailyWorkDAO.updateWorkJournalInfo", dailyWorkVO);
	}
	
	/**
     * T_WORK_JOURNAL DELETE
     */
	public void deleteWorkJournalInfo(DailyWorkVO dailyWorkVO) throws Exception {
		update("DailyWorkDAO.deleteWorkJournalInfo", dailyWorkVO);
	}

	/**
     * 점검및사용일지 데이터 목록 (페이징)
     * @param vo
     * @return
     * @throws Exception
     */
    public List checkUseList(DailyWorkSearchVO dailyWorkSearchVO) throws Exception {
    	return list("DailyWorkDAO.checkUseList", dailyWorkSearchVO);
    }
    
    /**
     * 점검및사용일지 데이터 목록 카운트
     * @param vo
     * @return
     * @throws Exception
     */
    public int checkUseListCnt(DailyWorkSearchVO dailyWorkSearchVO) throws Exception {
    	return (Integer)selectByPk("DailyWorkDAO.checkUseListCnt", dailyWorkSearchVO);
    }
	
    /**
     * 점검및사용일지 등록가능 카운트
     * @param vo
     * @return
     * @throws Exception
     */
    public int checkUseRegistCnt(DailyWorkSearchVO dailyWorkSearchVO) throws Exception {
    	return (Integer)selectByPk("DailyWorkDAO.checkUseRegistCnt", dailyWorkSearchVO);
    }
    
	/**
     * 점검및사용일지 기본정보 등록 
     */
    public void insertCheckUseInfo(CheckUseVO checkUseVO) throws Exception{
    	insert("DailyWorkDAO.insertCheckUseInfo", checkUseVO);
    }
    
    /**
     * 점검및사용일지 점검분야 등록 
     */
    public void insertCheckUseDetailInfo(CheckUseDetailVO checkUseDetailVO) throws Exception{
    	insert("DailyWorkDAO.insertCheckUseDetailInfo", checkUseDetailVO);
    }
    
    /**
     * 점검일지 시설목록 조회
     * @param dailyWorkSearchVO
     * @return
     * @throws Exception
     */
    public List getCheckEquipList(Map<String, Object> params) throws Exception {
    	return list("DailyWorkDAO.getCheckEquipList", params);
    }
    
    /**
     * 점검일지 기본정보 조회
     */
    public CheckUseVO selectCheckUseMasterInfo(String dailyWorkId) throws Exception{
    	return (CheckUseVO)selectByPk("DailyWorkDAO.selectCheckUseMasterInfo", dailyWorkId);
    }
    
    /**
     * 점검일지 결재정보 조회
     */
    public List<DailyWorkApprovalVO> selectCheckUseApprovalList(String dailyWorkId) throws Exception{
    	return list("DailyWorkDAO.selectCheckUseApprovalList", dailyWorkId);
    }
    
    /**
     * 점검일지 결재정보 조회
     */
    public List<CheckUseDetailVO> selectCheckUseDetailList(String dailyWorkId) throws Exception{
    	return list("DailyWorkDAO.selectCheckUseDetailList", dailyWorkId);
    }
    
    /**
     * 점검일지 결재정보 삭제
     */
    public void checkUseInfoDelete(String dailyWorkId) throws Exception{
    	update("DailyWorkDAO.checkUseInfoDelete", dailyWorkId);
    }
    
    /**
	 * 점검일지 상태 변경
	 */
    
    public void updateCheckUseStateInfo(DailyWorkVO dailyWorkVO) throws Exception{
    	update("DailyWorkDAO.updateCheckUseStateInfo", dailyWorkVO);
    }
    
    /**
     * T_CHECK_USE STATE, APPROVAL_ID, APPROVAL_DATE 변경 
     */
	public void updateCheckUseApprovalInfo(String dailyWorkId) throws Exception{
		update("DailyWorkDAO.updateCheckUseApprovalInfo", dailyWorkId);
	}
	
	/**
     * 점검일지 시설명 조회
     */
    public String selectCheckUseEquipName(HashMap<String, Object> param) throws Exception{
    	return (String)getSqlMapClientTemplate().queryForObject("DailyWorkDAO.selectCheckUseEquipName", param);
    }
    
    /**
     * 점검일지 수정을 위한시설목록 조회
     * @param dailyWorkSearchVO
     * @return
     * @throws Exception
     */
    public List getCheckEquipModifyList(Map<String, Object> params) throws Exception {
    	return list("DailyWorkDAO.getCheckEquipModifyList", params);
    }
    
    /**
     * 점검일지 기본정보 수정
     */
    public void updateCheckUseInfo(CheckUseVO checkUseVO) throws Exception{
    	update("DailyWorkDAO.updateCheckUseInfo", checkUseVO);
    }
    
    /**
     * 점검및사용일지 점검분야 수정 
     */
    public void updateCheckUseDetailInfo(CheckUseDetailVO checkUseDetailVO) throws Exception{
    	update("DailyWorkDAO.updateCheckUseDetailInfo", checkUseDetailVO);
    }
    
    public List getMonitoringList(Map<String, Object> params) throws Exception {
    	return list("DailyWorkDAO.getMonitoringList", params);
    }
    
    public int getMonitoringCount(Map<String, Object> params) throws Exception {
    	return (Integer)selectByPk("DailyWorkDAO.getMonitoringCount", params);
    }
    
    /**
     * 작성권한 사용자 정보 가져오기
     */
    public List getCheckUsePopupList(Map<String, Object> params) throws Exception {
		return list("DailyWorkDAO.getCheckUsePopupList", params);
    }
}
