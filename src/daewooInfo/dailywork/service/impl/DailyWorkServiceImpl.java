package daewooInfo.dailywork.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.dailywork.bean.CheckUseDetailVO;
import daewooInfo.dailywork.bean.CheckUseVO;
import daewooInfo.dailywork.bean.DailyWorkApprovalVO;
import daewooInfo.dailywork.bean.DailyWorkRainVO;
import daewooInfo.dailywork.bean.DailyWorkSearchVO;
import daewooInfo.dailywork.bean.DailyWorkVO;
import daewooInfo.dailywork.bean.DailyWorkWriteAuthVO;
import daewooInfo.dailywork.bean.SituationRoomVO;
import daewooInfo.dailywork.dao.DailyWorkDAO;
import daewooInfo.dailywork.service.DailyWorkService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * 
 * 업무일지 대한 서비스 구현클래스를 정의한다
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

@Service("DailyWorkService")
public class DailyWorkServiceImpl extends AbstractServiceImpl implements DailyWorkService {
	/**
	* @uml.property  name="idgenApprovalIdService"
	* @uml.associationEnd  readOnly="true"
	*/
	@Resource(name = "dailyApprovalIdGnrService")
	private EgovIdGnrService idgenApprovalIdService;
	    
	 /**
   	 * @uml.property  name="idgenAuthIdService"
   	 * @uml.associationEnd  readOnly="true"
   	 */
       @Resource(name = "dailyAuthIdGnrService")
       private EgovIdGnrService idgenAuthIdService;
       
	/**
	 * @uml.property  name="idgenSituationRoomIdService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "dailyWorkRainIdService")
	private EgovIdGnrService idgenDailyWorkRainIdService;
	
	@Resource(name = "checkUseIdGnrService")
    private EgovIdGnrService idgenCheckUseIdService;
       
    /**
	 * @uml.property  name="dailyWorkDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="DailyWorkDAO")
    private DailyWorkDAO dailyWorkDAO;
    
    /**
     * 업무일지 목록(페이징)
     */
    public Map<String, Object> dailyWorkList(DailyWorkSearchVO dailyWorkSearchVO) throws Exception {
    	List<DailyWorkSearchVO> result = dailyWorkDAO.dailyWorkList(dailyWorkSearchVO);

    	int cnt = dailyWorkDAO.dailyWorkListCnt(dailyWorkSearchVO);

    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	map.put("resultList", result);
    	map.put("resultCnt", Integer.toString(cnt));

    	return map;
    }
    
    /**
     * 결재자 정보
     */
    public String approvalNameSelect(String approvalId) throws Exception {
    	
    	String approvalName =  dailyWorkDAO.approvalNameSelect(approvalId);
    	
    	return approvalName;
    }
    
    /**
     * 업무일지 중복체크
     */
    public int selectDailyWorkInfo(DailyWorkVO dailyWorkVO) throws Exception{
    	
    	int cnt = dailyWorkDAO.selectDailyWorkInfo(dailyWorkVO);
    	
    	return cnt;
    }
    
    /**
     * 업무일지 결재정보 seq
     */
    public int getDailyWorkApprovalSeq(String dailyWorkId) throws Exception{
    	
    	int seq = dailyWorkDAO.getDailyWorkApprovalSeq(dailyWorkId);
    	
    	return seq;
    }
    
    /**
     * 업무일지 작성권한 seq
     */
    public int getDailyWorkWriteAuthSeq(String dailyWorkId) throws Exception{
		
    	int seq = dailyWorkDAO.getDailyWorkWriteAuthSeq(dailyWorkId);
    	
    	return seq;
    }
    
    /**
     * 업무일지 기본정보 등록
     */
    public void insertDailyWorkInfo(DailyWorkVO dailyWorkVO) throws Exception{
    	dailyWorkDAO.insertDailyWorkInfo(dailyWorkVO);
    }
    
    /**
     * 업무일지 수정이력 등록
     */
    public void insertDailyWorkHisInfo(DailyWorkVO dailyWorkVO) throws Exception{
    	dailyWorkDAO.insertDailyWorkHisInfo(dailyWorkVO);
    }
    
    /**
     * 업무일지 결재정보 등록
     */
    public void insertDailyWorkApprovalInfo(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception{
    	String approvalId = idgenApprovalIdService.getNextStringId();													//결재ID
		dailyWorkApprovalVO.setApprovalId(approvalId);
		
    	dailyWorkDAO.insertDailyWorkApprovalInfo(dailyWorkApprovalVO);
    }
    
    /**
     * 업무일지 작성권한 등록
     */
    public void insertDailyWriteAuthInfo(DailyWorkWriteAuthVO dailyWorkWriteAuthVO) throws Exception{
    	String authId =  authId = idgenAuthIdService.getNextStringId();												//작성권한ID
		dailyWorkWriteAuthVO.setAuthId(authId);
		
    	dailyWorkDAO.insertDailyWriteAuthInfo(dailyWorkWriteAuthVO);
    }
    
    /**
     * 업무일지 기본정보 조회
     */
    public DailyWorkVO selectDailyWorkMasterInfo(String dailyWorkId) throws Exception{
    	return dailyWorkDAO.selectDailyWorkMasterInfo(dailyWorkId);
    }
    
    /**
     * 업무일지 결재정보 조회
     */
    public List<DailyWorkApprovalVO> selectDailyWorkApprovalList(String dailyWorkId) throws Exception{
    	return dailyWorkDAO.selectDailyWorkApprovalList(dailyWorkId);
    }
    
    public void dailyWorkInfoDelete(String dailyWorkId) throws Exception{
    	dailyWorkDAO.dailyWorkInfoDelete(dailyWorkId);
    }
    
    /**
     * 업무일지 기본정보 수정
     */
    public void updateDailyWorkInfo(DailyWorkVO dailyWorkVO) throws Exception{
    	dailyWorkDAO.updateDailyWorkInfo(dailyWorkVO);
    }
    
    /**
     * 업무일지 결재정보 수정
     */
    public void updateDailyWorkApprovalInfo(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception{
    	dailyWorkDAO.updateDailyWorkApprovalInfo(dailyWorkApprovalVO);
    }
    
    /**
     * 업무일지 결재정보 삭제
     */
    public void deleteDailyWorkApprovalInfo(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception{
    	dailyWorkDAO.deleteDailyWorkApprovalInfo(dailyWorkApprovalVO);
    }
    
    /**
     * 업무일지 작성권한정보 삭제
     */
    public void deleteDailyWorkAuthInfo(DailyWorkWriteAuthVO dailyWorkWriteAuthVO) throws Exception{
    	dailyWorkDAO.deleteDailyWorkAuthInfo(dailyWorkWriteAuthVO);
    }
    
    /**
     * 업무일지 작성권한 수정
     */
    public void updateDailyWriteAuthInfo(DailyWorkWriteAuthVO dailyWorkWriteAuthVO) throws Exception{
    	dailyWorkDAO.updateDailyWriteAuthInfo(dailyWorkWriteAuthVO);
    }    
    
    /**
     * 업무일지 강우현황 저장
     */
    public void insertDailyWorkRainInfo(DailyWorkRainVO dailyWorkRainVO) throws Exception{
    	String rainId = idgenDailyWorkRainIdService.getNextStringId();	
    	dailyWorkRainVO.setRainId(rainId);
    	
    	int seq = 0;
    	seq = dailyWorkDAO.getDailyWorkRainSeq(dailyWorkRainVO);	
    	dailyWorkRainVO.setRainSeq(seq);
    	
    	dailyWorkDAO.insertDailyWorkRainInfo(dailyWorkRainVO);
    }
    
    /**
	 * 업무일지 강우현황 정보 조회
	 */
    public List<DailyWorkRainVO> selectDailyWorkRainInfo(DailyWorkRainVO dailyWorkRainVO) throws Exception {
    	return dailyWorkDAO.selectDailyWorkRainInfo(dailyWorkRainVO);
    }
    
    /**
     * 업무일지 강우현황 삭제
     */
    public int deleteDailyWorkRainInfo(String dailyWorkId) throws Exception{
    	int result = 0;
    	
    	dailyWorkDAO.deleteDailyWorkRainInfo(dailyWorkId);
    	
    	result++;
    	
    	return result;
    }
    
    /**
     * 업무일지 작성권한 체크
     */
    public int getDailyWorkWriteAuthId(DailyWorkWriteAuthVO dailyWorkWriteAuthVO) throws Exception{
		
    	int cnt = dailyWorkDAO.getDailyWorkWriteAuthId(dailyWorkWriteAuthVO);
    	
    	return cnt;
    }
    
    /**
	 * 업무일지 상태 변경
	 */
    public int updateDailyWorkStateInfo(DailyWorkVO dailyWorkVO) throws Exception{
    	
    	int result = 0;
    	
    	if(dailyWorkVO.getGubun().equals("S") || dailyWorkVO.getGubun().equals("R") || dailyWorkVO.getGubun().equals("M"))
    		dailyWorkDAO.updateDailyWorkStateInfo(dailyWorkVO);
    	else
    		dailyWorkDAO.updateCheckUseStateInfo(dailyWorkVO);
    	
    	result++;
    	
    	return result;
    }
    
    /**
     * 결재자 정보 조회
     */
    public String getApprovalMemberId(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception {
    	
    	String approvalMemberId =  dailyWorkDAO.getApprovalMemberId(dailyWorkApprovalVO);
    	
    	return approvalMemberId;
    }
    
    /**
     * 결재자 상신자 정보 조회
     */
    public String getDailyWorkApprovalId(String dailyWorkId) throws Exception {
    	
    	String approvalMemberId =  dailyWorkDAO.getDailyWorkApprovalId(dailyWorkId);
    	
    	return approvalMemberId;
    }
    
    /**
	 * 사용자별 결재대기 건수
	 */
    public int getDailyWorkApprovalCnt(String userId) throws Exception{
		
    	int cnt = dailyWorkDAO.getDailyWorkApprovalCnt(userId);
    	
    	return cnt;
    }
    
    /**
     * 받은결재조회 데이터 목록(페이징)
     */
    public Map<String, Object> receiveApprovalList(DailyWorkSearchVO dailyWorkSearchVO) throws Exception {
    	List<DailyWorkSearchVO> result = dailyWorkDAO.receiveApprovalList(dailyWorkSearchVO);

    	int cnt = dailyWorkDAO.receiveApprovalListCnt(dailyWorkSearchVO);

    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	map.put("resultList", result);
    	map.put("resultCnt", Integer.toString(cnt));

    	return map;
    }
    
    /**
     * 결재 등록
     */
    public void insertApproval(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception {
    	dailyWorkDAO.insertApproval(dailyWorkApprovalVO);    	
    }
    
    /**
     * 결재 상태 변경
     */
    public void updateApprovalState(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception {
    	dailyWorkDAO.updateApprovalState(dailyWorkApprovalVO);    	
    }
    
    /**
	 * 결재완료 처리
	 */
    public void updateDailyWorkState(DailyWorkVO dailyWorkVO) throws Exception{
    	
    	//if(dailyWorkVO.getGubun().equals("S") || dailyWorkVO.getGubun().equals("R") || dailyWorkVO.getGubun().equals("M"))
    		dailyWorkDAO.updateDailyWorkState(dailyWorkVO);
    	//else
    		dailyWorkDAO.updateCheckUseState(dailyWorkVO);
    }
    
    /**
	 * 작성권한 사용자 정보 가져오기
	 */
    public List getAuthUserList(String dailyWorkId) throws Exception {
    	return dailyWorkDAO.getAuthUserList(dailyWorkId);
    }

    /**
	 * 결재 승인에 대한 정보 가져오기
	 */
    public List getAppovalInfo(String dailyWorkId) throws Exception {
    	return dailyWorkDAO.getAppovalInfo(dailyWorkId);
    }
    
    /**
	 * 수정이력 정보 가져오기
	 */
    public List getDailyWorkHisInfoList(String dailyWorkId) throws Exception {
    	return dailyWorkDAO.getDailyWorkHisInfoList(dailyWorkId);
    }
    
    /**
     * 결재요청 정보 등록
     */
    public void updateApprovalRequestInfo(DailyWorkApprovalVO dailyWorkApprovalVO) throws Exception {
    	dailyWorkDAO.updateApprovalRequestInfo(dailyWorkApprovalVO);    	
    }
    /**
     * 결재정보 회수 처리 update
     */
    public void updateDailyWorkCancel(String dailyWorkId) throws Exception{
    	dailyWorkDAO.updateDailyWorkInfo(dailyWorkId);
    	dailyWorkDAO.updateDailyWorkApproval(dailyWorkId);
    }
    
    /**
     * 업무일지 등록
     */
    public int insertWorkJournalInfo(DailyWorkVO dailyWorkVO) throws Exception{
    	int result = 0;
    	dailyWorkDAO.insertWorkJournalInfo(dailyWorkVO);
    	result++;
    	
    	return result;
    }
    
    /**
     * 업무일지 목록(페이징)
     */
    public Map<String, Object> workJournalList(DailyWorkSearchVO dailyWorkSearchVO) throws Exception {
    	List<DailyWorkSearchVO> result = dailyWorkDAO.workJournalList(dailyWorkSearchVO);

    	int cnt = dailyWorkDAO.workJournalListCnt(dailyWorkSearchVO);

    	Map<String, Object> map = new HashMap<String, Object>();
    	
    	map.put("resultList", result);
    	map.put("resultCnt", Integer.toString(cnt));

    	return map;
    }
    
    /**
     * 업무일지 등록
     */
    public int updateWorkJournalInfo(DailyWorkVO dailyWorkVO) throws Exception{
    	int result = 0;
    	dailyWorkDAO.updateWorkJournalInfo(dailyWorkVO);
    	result++;
    	
    	return result;
    }
    
    /**
     * 업무일지 등록
     */
    public int deleteWorkJournalInfo(DailyWorkVO dailyWorkVO) throws Exception{
    	int result = 0;
    	dailyWorkDAO.deleteWorkJournalInfo(dailyWorkVO);
    	result++;
    	
    	return result;
    }
    
    /**
     * 점검및사용일지 목록(페이징)
     */
    public Map<String, Object> checkUseList(DailyWorkSearchVO dailyWorkSearchVO) throws Exception {
    	Map<String, Object> map = new HashMap<String, Object>();
    	try {
			
    		List<DailyWorkSearchVO> result = dailyWorkDAO.checkUseList(dailyWorkSearchVO);
    		
    		int cnt = dailyWorkDAO.checkUseListCnt(dailyWorkSearchVO);
    		
    		int regCnt = dailyWorkDAO.checkUseRegistCnt(dailyWorkSearchVO);
    		map.put("resultList", result);
    		map.put("resultCnt", Integer.toString(cnt));
    		map.put("regCnt", Integer.toString(regCnt));
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}

    	

    	return map;
    }
    
    /**
     * 점검및사용일지 기본정보 등록
     */
    public void insertCheckUseInfo(CheckUseVO checkUseVO) throws Exception{
    	dailyWorkDAO.insertCheckUseInfo(checkUseVO);
    }
    
    /**
     * 점검및사용일지 등록
     */
    public void insertCheckUseDetailInfo(CheckUseDetailVO checkUseDetailVO) throws Exception{
    	String detailId = idgenCheckUseIdService.getNextStringId();	//상황실 근무일지ID
		checkUseDetailVO.setDetailId(detailId);
		dailyWorkDAO.insertCheckUseDetailInfo(checkUseDetailVO);
    }
    
    public List getCheckEquipList(Map<String, Object> paramMap) throws Exception {
    	List resultList = dailyWorkDAO.getCheckEquipList(paramMap);
    	
    	return resultList;
    }
    
    /**
     * 업무일지 기본정보 조회
     */
    public CheckUseVO selectCheckUseMasterInfo(String dailyWorkId) throws Exception{
    	return dailyWorkDAO.selectCheckUseMasterInfo(dailyWorkId);
    }
    
    /**
     * 업무일지 결재정보 조회
     */
    public List<DailyWorkApprovalVO> selectCheckUseApprovalList(String dailyWorkId) throws Exception{
    	return dailyWorkDAO.selectCheckUseApprovalList(dailyWorkId);
    }
    
    /**
     * 업무일지 결재정보 조회
     */
    public List<CheckUseDetailVO> selectCheckUseDetailList(String dailyWorkId) throws Exception{
    	return dailyWorkDAO.selectCheckUseDetailList(dailyWorkId);
    }
    
    public void checkUseInfoDelete(String dailyWorkId) throws Exception{
    	dailyWorkDAO.checkUseInfoDelete(dailyWorkId);
    }
    
    /**
     * 결재정보 회수 처리 update
     */
    public void updateCheckUseCancel(String dailyWorkId) throws Exception{
    	dailyWorkDAO.updateCheckUseApprovalInfo(dailyWorkId);
    	dailyWorkDAO.updateDailyWorkApproval(dailyWorkId);
    }
    
    /**
	 * 점검일지 시설명 조회
	 */
    public String selectCheckUseEquipName(HashMap<String, Object> param) throws Exception{
    	return dailyWorkDAO.selectCheckUseEquipName(param);
    }
    
    /**
	 * 점검일지 수정을 위한 시설목록 조회 
	 */
	public List getCheckEquipModifyList(Map<String, Object> paramMap) throws Exception{
		List resultList = dailyWorkDAO.getCheckEquipModifyList(paramMap);
    	
    	return resultList;
	}

	@Override
	public void updateCheckUseInfo(CheckUseVO checkUseVO) throws Exception {
		// TODO Auto-generated method stub
		dailyWorkDAO.updateCheckUseInfo(checkUseVO);
	}

	@Override
	public void updateCheckUseDetailInfo(CheckUseDetailVO checkUseDetailVO) throws Exception {
		if("".equals(checkUseDetailVO.getDetailId()) || checkUseDetailVO.getDetailId()==null) {
			String detailId = idgenCheckUseIdService.getNextStringId();	//상황실 근무일지ID
			checkUseDetailVO.setDetailId(detailId);
		}
		dailyWorkDAO.updateCheckUseDetailInfo(checkUseDetailVO);
	}
	
	public List getMonitoringList(Map<String, Object> paramMap) throws Exception {
    	List resultList = dailyWorkDAO.getMonitoringList(paramMap);
    	
    	return resultList;
    }
	
	public HashMap<String, Object> getMonitoringCount(Map<String, Object> paramMap) throws Exception {
		HashMap<String, Object> map = new HashMap<String, Object>();
    	try {
			
    		paramMap.put("wmGubun", "W");
    		int totWeekCnt = dailyWorkDAO.getMonitoringCount(paramMap);
    		
    		paramMap.put("wmGubun", "M");
    		int totMonthCnt = dailyWorkDAO.getMonitoringCount(paramMap);
    		
    		map.put("totWeekCnt", totWeekCnt);
    		map.put("totMonthCnt", totMonthCnt);
    		
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
    	return map;
    }
	
	/**
	 * 작성권한 사용자 정보 가져오기
	 */
    public List getCheckUsePopupList(Map<String, Object> paramMap) throws Exception {
    	return dailyWorkDAO.getCheckUsePopupList(paramMap);
    }
}
