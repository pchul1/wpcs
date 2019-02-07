package daewooInfo.admin.cmmncode.service;

import java.util.List;

import daewooInfo.cmmn.bean.CmmnDetailCode;
import daewooInfo.cmmn.bean.CmmnDetailCodeVO;

/**
 * 
 * 공통상세코드에 관한 서비스 인터페이스 클래스를 정의한다
 * @author 공통서비스 개발팀 이중호
 * @since 2009.04.01
 * @version 1.0
 * @see
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 * 수정일			수정자			수정내용
 * -------		--------	---------------------------
 * 2009.04.01	이중호			최초 생성
 * 
 * </pre>
 */
public interface CmmnDetailCodeManageService {
	
	/**
	 * 공통상세코드를 삭제한다.
	 * @param cmmnDetailCode
	 * @throws Exception
	 */
	void deleteCmmnDetailCode(CmmnDetailCode cmmnDetailCode) throws Exception;

	/**
	 * 공통상세코드를 등록한다.
	 * @param cmmnDetailCode
	 * @throws Exception
	 */
	int insertCmmnDetailCode(CmmnDetailCode cmmnDetailCode) throws Exception;

	/**
	 * 공통상세코드 상세항목을 조회한다.
	 * @param cmmnDetailCode
	 * @return CmmnDetailCode(공통상세코드)
	 * @throws Exception
	 */
	List selectCmmnDetailCodeDetail(CmmnDetailCode cmmnDetailCode) throws Exception;
	
	/**
	 * 공통상세코드 목록을 조회한다.
	 * @param searchVO
	 * @return List(공통상세코드 목록)
	 * @throws Exception
	 */
	List selectCmmnDetailCodeList(CmmnDetailCodeVO searchVO) throws Exception;

	/**
	 * 공통상세코드 총 갯수를 조회한다.
	 * @param searchVO
	 * @return int(공통상세코드 총 갯수)
	 */
	int selectCmmnDetailCodeListTotCnt(CmmnDetailCodeVO searchVO) throws Exception;
	
	/**
	 * 공통상세코드를 수정한다.
	 * @param cmmnDetailCode
	 * @throws Exception
	 */
	int updateCmmnDetailCode(CmmnDetailCode cmmnDetailCode) throws Exception;
	
	/**
	 * 공통코드를 중복체크 한다.
	 * @param cmmnDetailCode
	 * @throws Exception
	 */
	int dupCmnCode(CmmnDetailCode cmmnDetailCode) throws Exception;
}
