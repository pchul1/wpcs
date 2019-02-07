package daewooInfo.dailywork.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import daewooInfo.dailywork.bean.CheckUseDetailVO;
import daewooInfo.dailywork.bean.CheckUseVO;
import daewooInfo.dailywork.bean.DailyWorkApprovalVO;
import daewooInfo.dailywork.bean.DailyWorkRainVO;
import daewooInfo.dailywork.bean.DailyWorkSearchVO;
import daewooInfo.dailywork.bean.DailyWorkVO;
import daewooInfo.dailywork.bean.DailyWorkWriteAuthVO;
import daewooInfo.dailywork.bean.SituationRoomVO;

/**
 * 
 * 업무일지 관한 서비스 인터페이스 클래스를 정의한다
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
public interface DailyWorkService {
	
	/**
	 * 업무일지작성조회 데이터 목록 (페이징)
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> dailyWorkList(DailyWorkSearchVO dailyWorkSearchVO) throws Exception;
	
	/**
	 * 결재자 정보
	 */
	public String approvalNameSelect(String approvalId) throws Exception; 
	
	/**
	 * 업무일지 중복 체크
	 */
	public int selectDailyWorkInfo(DailyWorkVO dailyWorkVO) throws Exception;
	
	/**
	 * 업무일지 결재정보 seq
	 */
	public int getDailyWorkApprovalSeq(String dailyWorkId) throws Exception;
	
	/**
	 * 업무일지 작성권한 seq
	 */
	public int getDailyWorkWriteAuthSeq(String dailyWorkId) throws Exception;
	
	/**
	 * 업무일지 기본정보 등록
	 */
	public void insertDailyWorkInfo(DailyWorkVO dailyWorkVO) throws Exception;
	
	/**
	 * 업무일지 수정이력 등록
	 */
	public void insertDailyWorkHisInfo(DailyWorkVO dailyWorkVO) throws Exception;
	
	/**
	 * 업무일지 결재정보 등록 
	 */
	public void insertDailyWorkApprovalInfo(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception;
	
	/**
	 * 업무일지 작성권한 등록 
	 */
	public void insertDailyWriteAuthInfo(DailyWorkWriteAuthVO dailyWorkWriteAuthVO) throws Exception;
	
	
	/**
	 * 업무일지 기본정보 조회
	 */
    public DailyWorkVO selectDailyWorkMasterInfo(String dailyWorkId) throws Exception; 
    
    /**
	 * 업무일지 결재정보 조회
	 */
    public List<DailyWorkApprovalVO> selectDailyWorkApprovalList(String dailyWorkId) throws Exception; 
    
    /**
     * 업무일지 삭제
     */
    public void dailyWorkInfoDelete(String dailyWorkId) throws Exception;
    
    /**
	 * 업무일지 기본정보  수정
	 */
	public void updateDailyWorkInfo(DailyWorkVO dailyWorkVO) throws Exception;
	
	/**
	 * 업무일지 결재정보 수정 
	 */
	public void updateDailyWorkApprovalInfo(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception;
	
	/**
	 * 업무일지 결재정보 삭제
	 */
	public void deleteDailyWorkApprovalInfo(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception;
	
	/**
	 * 업무일지 작성권한정보 삭제
	 */
	public void deleteDailyWorkAuthInfo(DailyWorkWriteAuthVO dailyWorkWriteAuthVO) throws Exception;
	                
	/**
	 * 업무일지 작성권한 수정 
	 */
	public void updateDailyWriteAuthInfo(DailyWorkWriteAuthVO dailyWorkWriteAuthVO) throws Exception;
	
	/**
	 * 업무일지 강우현황 저장
	 */
	public void insertDailyWorkRainInfo(DailyWorkRainVO dailyWorkRainVO) throws Exception;
	
	/**
	 * 업무일지 강우현황 정보 조회
	 */
	public List<DailyWorkRainVO> selectDailyWorkRainInfo(DailyWorkRainVO dailyWorkRainVO) throws Exception;
	
	/**
	 * 업무일지 강우현황 삭제
	 */
	public int deleteDailyWorkRainInfo(String dailyWorkId) throws Exception;
	
	/**
	 * 업무일지 작성권한 체크
	 */
	public int getDailyWorkWriteAuthId(DailyWorkWriteAuthVO dailyWorkWriteAuthVO) throws Exception;
	
	/**
	 * 업무일지 상태 변경
	 */
	public int updateDailyWorkStateInfo(DailyWorkVO dailyWorkVO) throws Exception;
	
	/**
	 * 결재자 정보 조회
	 */
	public String getApprovalMemberId(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception; 
	
	/**
	 * 결재상신자 정보 조회
	 */
	public String getDailyWorkApprovalId(String dailyWorkId) throws Exception; 
	
	/**
	 * 사용자별 결재대기 건수
	 */
	public int getDailyWorkApprovalCnt(String userId) throws Exception; 
	
	/**
	 * 받은결재조회 데이터 목록(페이징)
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> receiveApprovalList(DailyWorkSearchVO dailyWorkSearchVO) throws Exception;
	
	/**
	 * 결재 등록
	 */
	void insertApproval(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception;
	
	/**
	 * 결재 상태 변경
	 */
	void updateApprovalState(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception;
	
	/**
	 * 결재완료 처리
	 */
	public void updateDailyWorkState(DailyWorkVO dailyWorkVO) throws Exception;
	
	/**
	 * 작성권한 사용자 정보 가져오기
	 */
	public List getAuthUserList(String dailyWorkId) throws Exception;
	
	/**
	 * 결재 승인에 대한 정보 가져오기
	 */
	public List getAppovalInfo(String dailyWorkId) throws Exception;
	
	/**
	 * 수정이력정보 가져오기
	 */
	public List getDailyWorkHisInfoList(String dailyWorkId) throws Exception;
	
	/**
	 * 결재요청 정보 등록
	 */
	void updateApprovalRequestInfo(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception;
	
	/**
	 * 결재정보 회수처리 update
	 */
	public void updateDailyWorkCancel(String dailyWorkId) throws Exception;
	
	/**
	 * 업무일지 기본정보 등록
	 */
	public int insertWorkJournalInfo(DailyWorkVO dailyWorkVO) throws Exception;
	
	/**
	 * 업무일지조회 데이터 목록 (페이징)
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> workJournalList(DailyWorkSearchVO dailyWorkSearchVO) throws Exception;

	/**
	 * 점검및사용일지 데이터 목록 (페이징)
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> checkUseList(DailyWorkSearchVO dailyWorkSearchVO) throws Exception;
	
	/**
	 * 업무일지 기본정보 수정
	 */
	public int updateWorkJournalInfo(DailyWorkVO dailyWorkVO) throws Exception;
	
	/**
	 * 업무일지 기본정보 삭제
	 */
	public int deleteWorkJournalInfo(DailyWorkVO dailyWorkVO) throws Exception;
	
	/**
	 * 점검및사용일지 기본정보 등록
	 */
	public void insertCheckUseInfo(CheckUseVO checkUseVO) throws Exception;
	
	/**
	 * 점검및사용일지 상세점검분야 등록
	 */
	public void insertCheckUseDetailInfo(CheckUseDetailVO checkUseDetailVO) throws Exception;
	
	/**
	 * 점검일지 시설목록 조회
	 */
	public List getCheckEquipList(Map<String, Object> paramMap) throws Exception;
	
	/**
	 * 업무일지 기본정보 조회
	 */
    public CheckUseVO selectCheckUseMasterInfo(String dailyWorkId) throws Exception; 
    
    /**
	 * 업무일지 결재정보 조회
	 */
    public List<DailyWorkApprovalVO> selectCheckUseApprovalList(String dailyWorkId) throws Exception; 
    
    /**
	 * 업무일지 결재정보 조회
	 */
    public List<CheckUseDetailVO> selectCheckUseDetailList(String dailyWorkId) throws Exception;
    
    /**
     * 업무일지 삭제
     */
    public void checkUseInfoDelete(String dailyWorkId) throws Exception;
    
    /**
	 * 점검일지 결재정보 회수처리 update
	 */
	public void updateCheckUseCancel(String dailyWorkId) throws Exception;
	
	/**
	 * 점검일지 시설명 조회
	 */
    public String selectCheckUseEquipName(HashMap<String, Object> param) throws Exception; 
    
    /**
	 * 점검일지 수정을 위한 시설목록 조회 
	 */
	public List getCheckEquipModifyList(Map<String, Object> paramMap) throws Exception;
	
	/**
	 * 점검일지 기본정보  수정
	 */
	public void updateCheckUseInfo(CheckUseVO checkUseVO) throws Exception;
	
	/**
	 * 점검및사용일지 수정
	 */
	public void updateCheckUseDetailInfo(CheckUseDetailVO checkUseDetailVO) throws Exception;
	
	/**
	 * 점검일지 시설목록 조회
	 */
	public List getMonitoringList(Map<String, Object> paramMap) throws Exception;
	
	/**
	 * 점검일지 시설목록 조회
	 */
	public HashMap<String, Object> getMonitoringCount(Map<String, Object> paramMap) throws Exception;

	/**
	 * 작성권한 사용자 정보 가져오기
	 */
	public List getCheckUsePopupList(Map<String, Object> paramMap) throws Exception;
}
