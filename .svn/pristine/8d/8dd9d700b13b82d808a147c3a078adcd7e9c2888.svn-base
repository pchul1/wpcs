package daewooInfo.admin.cmmncode.service;

import java.util.List;

import daewooInfo.admin.cmmncode.bean.CmmnCode;
import daewooInfo.admin.cmmncode.bean.CmmnCodeVO;
import daewooInfo.cmmn.bean.CmmnDetailCode;

/**
 * 
 * 공통코드에 관한 서비스 인터페이스 클래스를 정의한다
 * @author kisspa
 * @since 2010.06.18
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2010.06.18  kisspa          최초 생성
 *
 * </pre>
 */
public interface CmmnCodeManageService {
	    
	/**
	 * 공통코드를 삭제한다.
	 * @param cmmnCode
	 * @throws Exception
	 */
	void deleteCmmnCode(CmmnCode cmmnCode) throws Exception;

	/**
	 * 공통코드를 등록한다.
	 * @param cmmnCode
	 * @throws Exception
	 */
	void insertCmmnCode(CmmnCode cmmnCode) throws Exception;

	/**
	 * 공통코드 상세항목을 조회한다.
	 * @param cmmnCode
	 * @return CmmnCode(공통코드)
	 * @throws Exception
	 */
	List selectCmmnCodeDetail(CmmnCode cmmnCode) throws Exception;
	
	/**
	 * 공통코드 목록을 조회한다.
	 * @param searchVO
	 * @return List(공통코드 목록)
	 * @throws Exception
	 */
	List selectCmmnCodeList(CmmnCodeVO searchVO) throws Exception;

    /**
	 * 공통코드 총 갯수를 조회한다.
     * @param searchVO
     * @return int(공통코드 총 갯수)
     */
    int selectCmmnCodeListTotCnt(CmmnCodeVO searchVO) throws Exception;
	
	/**
	 * 공통코드를 수정한다.
	 * @param cmmnCode
	 * @throws Exception
	 */
	void updateCmmnCode(CmmnCode cmmnCode) throws Exception;
	
	/**
	 * 공통코드카테고리 상세를 수정한다.
	 * @param cmmnDetailCode
	 * @throws Exception
	 */
	int updateCmmnDetailCode(CmmnCode cmmnCode) throws Exception;
	
	/**
	 * 공통코드카테고리를 중복체크 한다.
	 * @param cmmnDetailCode
	 * @throws Exception
	 */
	int dupCmnCode(CmmnCode cmmnCode) throws Exception;
}
