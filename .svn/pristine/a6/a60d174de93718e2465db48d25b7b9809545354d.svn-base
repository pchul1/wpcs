package daewooInfo.edu.service;

import java.util.List;
import java.util.Map;

import daewooInfo.edu.bean.EduSearchVO;

/**
 * 
 * 교육 및 교육 신청 에 관한 서비스 인터페이스 클래스를 정의한다
 * @author kisspa
 * @since 2010.09.02
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2010.09.02  kisspa          최초 생성
 *
 * </pre>
 */
public interface EduManageService {
	
	/**
	 * 교육 데이터 목록 전체
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	List<EduSearchVO> eduDataListAll(EduSearchVO vo) throws Exception;
	
	/**
	 * 교육 데이터 목록 (페이징)
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	List<EduSearchVO> eduDataList(EduSearchVO vo) throws Exception;
	
	/**
	 * 교육 데이터 목록 카운트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int eduDataListCnt(EduSearchVO vo) throws Exception;
	
	/**
	 * 교육 데이터 삭제
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int deleteEdu(EduSearchVO vo) throws Exception;
	
	/**
	 * 교육 데이터 merge into
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int mergeEdu(EduSearchVO vo) throws Exception;

	
	/**
	 * 교육 대상자 데이터 목록
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	List<EduSearchVO> eduMemberDataList(EduSearchVO vo) throws Exception;
	
	/**
	 * 교육 대상자 데이터 목록 카운트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int eduMemberDataListCnt(EduSearchVO vo) throws Exception;
	
	/**
	 * 교육 대상자 삭제
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int deleteEduMember(EduSearchVO vo) throws Exception;
	
	/**
	 * 교육 대상자 데이터 merge into
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int insertEduMember(EduSearchVO vo) throws Exception;
	
	/**
	 * 정원 초과 체크
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int isOverCapacityCnt(EduSearchVO vo) throws Exception;
	
	/**
	 * 교육이 신청되어 있는지 체크
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int isEduRigisterCnt(EduSearchVO vo) throws Exception;
	
	/**
	 * 나의 신청한 교육 데이터 목록 (페이징)
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	List<EduSearchVO> myEduDataList(EduSearchVO vo) throws Exception;
	
	/**
	 * 나의 신청한 교육 데이터 목록 카운트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int myEduDataListCnt(EduSearchVO vo) throws Exception;
}
