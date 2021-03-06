package daewooInfo.seminar.service;

import java.util.List;

import daewooInfo.seminar.bean.SeminarSearchVO;
import daewooInfo.seminar.bean.SeminarVO;
import daewooInfo.cmmn.bean.CmmnDetailCode;
import daewooInfo.seminar.bean.SeminarEntryVO;

/**
 * 교육관리 Service 클래스
 * @author 박미영
 * @since 2014.09.15
 * @version 1.0
 * @see
 */
public interface SeminarService {
	/**
	 *교육 정보를 등록
	 * @param seminarVO
	 * @throws Exception
	 */
	void insertSeminar(SeminarVO seminarVO) throws Exception;
	
	/**
	 *교육 일정 중복 조회
	 * @param seminarVO
	 * @throws Exception
	 */
	int selectCheckSeminarDate(SeminarVO seminarVO) throws Exception;
	
	/**
	 *교육 정보를 수정
	 * @param seminarVO
	 * @throws Exception
	 */
	void updateSeminarInfo(SeminarVO seminarVO) throws Exception;
	
	/**
	 *교육 등록 총카운트 조회
	 * @param searchVO
	 * @throws Exception
	 */
	int selectSeminarTotCnt(SeminarSearchVO searchVO) throws Exception;

	/**
	 * 교육 전체 목록을 조회
	 * @param searchVO
	 * @return List(교육 목록)
	 * @throws Exception
	 */
	List<SeminarVO> selectSeminarInfo(SeminarSearchVO searchVO) throws Exception;
	
	/**
	 *교육  참가 신청 현황 카운트 조회
	 * @param seminarVO
	 * @throws Exception
	 */
	int selSeminarEntryCnt(SeminarEntryVO seminarEntryVO) throws Exception;	

	/**
	 *교육  상세 조회
	 * @param seminarVO
	 * @throws Exception
	 */
	SeminarVO selSeminarInfoView(SeminarVO seminarVO) throws Exception;
	
	/**
	 *교육 등록 조회수 업데이트
	 * @param seminarVO
	 * @throws Exception
	 */
	void updateSeminarCnt(SeminarVO seminarVO) throws Exception;
	
	/**
	 *교육 삭제 처리
	 * @param seminarVO
	 * @throws Exception
	 */
	void deleteSeminarInfo(SeminarVO seminarVO) throws Exception;
	
	/**
	 *교육 승인/불허 처리
	 * @param seminarVO
	 * @throws Exception
	 */
	void updateSeminarState(SeminarVO seminarVO) throws Exception;

    /**
	 * 교육신청현황 총카운트 조회
     * @param seminarVO
     * @throws Exception
     */
	int selectSeminarApplicationTotCnt(SeminarSearchVO searchVO) throws Exception;
	
    /**
	 * 교육신청현황 조회
     * @param seminarVO
     * @throws Exception
     */	
	List<SeminarVO> selectSeminarApplication(SeminarSearchVO searchVO) throws Exception;
	
    /**
	 * 교육 참여자 조회
     * @param seminarVO
     * @throws Exception
     */
	List<SeminarEntryVO> selSeminarEntryView(SeminarVO seminarVO) throws Exception;

    /**
	 * 접수된 교육 총 카운트 조회
     * @param seminarVO
     * @throws Exception
     */
	int selectAcceptTot(SeminarVO seminarVO) throws Exception;

    /**
	 * 실시 완료된 총 카운트 조회
     * @param seminarVO
     * @throws Exception
     */
	int selectCompleteTot(SeminarVO seminarVO) throws Exception;

    /**
	 * 실시 예정된 총 카운트 조회
     * @param seminarVO
     * @throws Exception
     */
	int selectPlanTot(SeminarVO seminarVO) throws Exception;

    /**
	 * 교육신청 총 카운트 조회 
     * @param seminarVO
     * @throws Exception
     */
	int selectSeminarTot(SeminarVO seminarVO) throws Exception;

    /**
	 * 강사신청 총 카운트 조회
     * @param seminarVO
     * @throws Exception
     */
	int selectLectTot(SeminarVO seminarVO) throws Exception;
	
    /**
	 * 교육 신청 처리
     * @param seminarEntryVO
     * @throws Exception
     */
    void insertSeminarEntry(SeminarEntryVO seminarEntryVO) throws Exception;
    
    /**
	 * 교육 제외 처리
     * @param seminarEntryVO
     * @throws Exception
     */
    void updateSeminarEntry(SeminarEntryVO seminarEntryVO) throws Exception;
    
    /**
	 * 교육 신청 중복 조회
     * @param seminarVO
     * @throws Exception
     */
    int selectCheckSeminarEntry(SeminarEntryVO seminarEntryVO) throws Exception;

    /**
	 * 로그인 유저 소속 조회
     * @param seminarVO
     * @throws Exception
     */
    String selectUperDept(SeminarSearchVO searchVO) throws Exception;
    
    /**
	 * 나의 교육 신청 현황 조회
     * @param seminarVO
     * @throws Exception
     */
    List<SeminarVO> selMySeminarApplication(SeminarSearchVO searchVO) throws Exception;
    
    /**
	 * 나의 교육 신청 현황 총 카운트 조회
     * @param seminarVO
     * @throws Exception
     */
    int selMySeminarApplicationTot(SeminarSearchVO searchVO) throws Exception;
    
    /**
   	 * 로그인 유저 소속 조회
     * @param seminarVO
     * @throws Exception
     */
    String selectCheckSeminarEntryCount(SeminarVO seminarVO) throws Exception;
    
    /**
	 * 교육 마감 처리
     * @param seminarEntryVO
     * @throws Exception
     */
    void updateSeminarAutoClosingState(SeminarSearchVO searchVO) throws Exception;
    
    /**
	 * 교육 시작 3일전 교육 정보 조회
     * @throws Exception
     */
    List<SeminarVO> selectSeminarInfoAlrimCheck(SeminarVO seminarVO) throws Exception;

    /**
	 * 교육 시작 3일전 교육 정보 조회
     * @throws Exception
     */
    List<SeminarEntryVO> selectSeminarEntryAlrimCheck(SeminarVO seminarVO) throws Exception;
    
    /**
     * 교육기관 코드 정보 조회
     * @return
     * @throws Exception
     */
    List<CmmnDetailCode> getEduCode() throws Exception;
}