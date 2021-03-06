package daewooInfo.seminar.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import daewooInfo.bbs.bean.BoardVO;
import daewooInfo.cmmn.bean.CmmnDetailCode;
import daewooInfo.seminar.bean.SeminarEntryVO;
import daewooInfo.seminar.bean.SeminarSearchVO;
import daewooInfo.seminar.bean.SeminarVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 교육관리 DAO 클래스
 * @author 박미영
 * @since 2014.09.15
 * @version 1.0
 * @see
 */
@Repository("seminarDAO")
public class SeminarDAO extends EgovAbstractDAO {
	
	/** log */
    protected static final Log log = LogFactory.getLog(SeminarDAO.class);
    
    /**
	 * 교육 정보를 등록
     * @param seminarVO
     * @throws Exception
     */
    public void insertSeminar(SeminarVO seminarVO) throws Exception {
        insert("seminarDAO.insertSeminarInfo", seminarVO);
    }
    
    /**
	 * 교육 정보를 수정
     * @param seminarVO
     * @throws Exception
     */
    public void updateSeminarInfo(SeminarVO seminarVO) throws Exception {
    	update("seminarDAO.updateSeminarInfo", seminarVO);
    }

    /**
	 * 교육 등록 총카운트 조회
     * @param seminarVO
     * @throws Exception
     */
    public int selectSeminarTotCnt(SeminarSearchVO searchVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("seminarDAO.selectSeminarTotCnt", searchVO);
    }
    
    /**
	 * 교육 전체 목록 조회
     * @param seminarVO
     * @return List(교육 전체 목록)
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<SeminarVO> selectSeminarInfo(SeminarSearchVO searchVO) throws Exception {
        return list("seminarDAO.selectSeminarInfo", searchVO);
    }

    /**
	 * 교육 일정 중복 조회
     * @param seminarVO
     * @throws Exception
     */
    public int selectCheckSeminarDate(SeminarVO seminarVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("seminarDAO.selectCheckSeminarDate", seminarVO);
    }
    
    /**
     * 교육 상세 내용 조회
     * 
     * @param seminarVO
     * @return
     * @throws Exception
     */
    public SeminarVO selSeminarInfoView(SeminarVO seminarVO) throws Exception {
    	return (SeminarVO)selectByPk("seminarDAO.selSeminarInfoView", seminarVO);
    }
    
    /**
	 * 교육  참가 신청 현황 카운트 조회
     * @param seminarVO
     * @throws Exception
     */
    public int selSeminarEntryCnt(SeminarEntryVO seminarEntryVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("seminarDAO.selSeminarEntryCnt", seminarEntryVO);
    }
    
    /**
	 * 교육 등록 조회수 업데이트
     * @param seminarVO
     * @throws Exception
     */
    public void updateSeminarCnt(SeminarVO seminarVO) throws Exception {
    	update("seminarDAO.updateSeminarCnt", seminarVO);
    }
    
    /**
	 * 교육 삭제 처리
     * @param seminarVO
     * @throws Exception
     */
    public void deleteSeminarInfo(SeminarVO seminarVO) throws Exception {
    	update("seminarDAO.deleteSeminarInfo", seminarVO);
    }
    
    /**
	 * 교육 승인/불허 처리
     * @param seminarVO
     * @throws Exception
     */
    public void updateSeminarState(SeminarVO seminarVO) throws Exception {
    	update("seminarDAO.updateSeminarState", seminarVO);
    }
    
    /**
	 * 교육신청현황 총카운트 조회
     * @param seminarVO
     * @throws Exception
     */
    public int selectSeminarApplicationTotCnt(SeminarSearchVO searchVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("seminarDAO.selectSeminarApplicationTotCnt", searchVO);
    }
    
    /**
	 * 교육신청현황 조회
     * @param seminarVO
     * @return List(교육신청현황 목록)
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<SeminarVO> selectSeminarApplication(SeminarSearchVO searchVO) throws Exception {
        return list("seminarDAO.selectSeminarApplication", searchVO);
    }
    
    /**
	 * 교육 참여자 조회
     * @param seminarEntryVO
     * @return List(교육 참여자 목록)
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<SeminarEntryVO> selSeminarEntryView(SeminarVO seminarVO) throws Exception {
        return list("seminarDAO.selSeminarEntryView", seminarVO);
    }
    
    
    /**
	 * 접수된 교육 총 카운트 조회
     * @param seminarVO
     * @throws Exception
     */
    public int selectAcceptTot(SeminarVO seminarVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("seminarDAO.selectAcceptTot", seminarVO);
    }
    
    
    /**
	 * 실시 완료된 총 카운트 조회
     * @param seminarVO
     * @throws Exception
     */
    public int selectCompleteTot(SeminarVO seminarVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("seminarDAO.selectCompleteTot", seminarVO);
    }
    
    
    /**
	 * 실시 예정된 총 카운트 조회
     * @param seminarVO
     * @throws Exception
     */
    public int selectPlanTot(SeminarVO seminarVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("seminarDAO.selectPlanTot", seminarVO);
    }
    
    
    /**
	 * 교육신청 총 카운트 조회 
     * @param seminarVO
     * @throws Exception
     */
    public int selectSeminarTot(SeminarVO seminarVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("seminarDAO.selectSeminarTot", seminarVO);
    }
    
    
    /**
	 * 강사신청 총 카운트 조회
     * @param seminarVO
     * @throws Exception
     */
    public int selectLectTot(SeminarVO seminarVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("seminarDAO.selectLectTot", seminarVO);
    }

    
    /**
	 * 교육 신청 처리
     * @param seminarEntryVO
     * @throws Exception
     */
    public void insertSeminarEntry(SeminarEntryVO seminarEntryVO) throws Exception {
        insert("seminarDAO.insertSeminarEntry", seminarEntryVO);
    }
    
    /**
	 * 교육 제외 처리
     * @param seminarEntryVO
     * @throws Exception
     */
    public void updateSeminarEntry(SeminarEntryVO seminarEntryVO) throws Exception {
    	update("seminarDAO.updateSeminarEntry", seminarEntryVO);
    }
    
    /**
	 * 교육 신청 중복 조회
     * @param seminarVO
     * @throws Exception
     */
    public int selectCheckSeminarEntry(SeminarEntryVO seminarEntryVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("seminarDAO.selectCheckSeminarEntry", seminarEntryVO);
    }
    
    /**
	 * 로그인 유저 소속 조회
     * @param seminarVO
     * @throws Exception
     */
    public String selectUperDept(SeminarSearchVO searchVO) throws Exception {
    	return (String)getSqlMapClientTemplate().queryForObject("seminarDAO.selectUperDept", searchVO);
    }
    
    /**
	 * 나의 교육 신청 현황 조회
     * @param searchVO
     * @return List(교육 참여자 목록)
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<SeminarVO> selMySeminarApplication(SeminarSearchVO searchVO) throws Exception {
        return list("seminarDAO.selMySeminarApplication", searchVO);
    }
    
    /**
	 * 나의 교육 신청 현황 총 카운트 조회
     * @param searchVO
     * @throws Exception
     */
    public int selMySeminarApplicationTot(SeminarSearchVO searchVO) throws Exception {
    	return (Integer)getSqlMapClientTemplate().queryForObject("seminarDAO.selMySeminarApplicationTot", searchVO);
    }
    
    /**
	 *교육 신청 참가자 현황 카운트 조회
     * @param seminarVO
     * @throws Exception
     */
    public String selectCheckSeminarEntryCount(SeminarVO seminarVO) throws Exception {
    	return (String)getSqlMapClientTemplate().queryForObject("seminarDAO.selectCheckSeminarEntryCount", seminarVO);
    }
    
    /**
	 * 교육 자동 마감 처리
     * @param seminarVO
     * @throws Exception
     */
    public void updateSeminarAutoClosingState(SeminarSearchVO searchVO) throws Exception {
    	update("seminarDAO.updateSeminarAutoClosingState", searchVO);
    }
    
    /**
	 * 교육 시작 3일전 교육 정보 조회(교육 자동 알림)
     * @return List(교육 정보 목록)
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<SeminarVO> selectSeminarInfoAlrimCheck(SeminarVO seminarVO) throws Exception {
        return list("seminarDAO.selectSeminarInfoAlrimCheck", seminarVO);
    }
    
    /**
	 * 교육 시작 3일전 교육 정보 조회(교육 자동 알림)
     * @return List(교육 정보 목록)
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<SeminarEntryVO> selectSeminarEntryAlrimCheck(SeminarVO seminarVO) throws Exception {
        return list("seminarDAO.selectSeminarEntryAlrimCheck", seminarVO);
    }
    
    /**
	 * 교육기관 리스트 정보 조회
     * @return List(교육 기관 목록)
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<CmmnDetailCode> getEduCode() throws Exception {
    	return list("seminarDAO.getEduCode", null);
    }
}