package daewooInfo.admin.cmmncode.dao;

import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.admin.cmmncode.bean.CmmnCode;
import daewooInfo.admin.cmmncode.bean.CmmnCodeVO;
import daewooInfo.cmmn.bean.CmmnDetailCode;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 
 * 공통코드에 대한 데이터 접근 클래스를 정의한다
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
@Repository("CmmnCodeManageDAO")
public class CmmnCodeManageDAO extends EgovAbstractDAO {

	/**
	 * 공통코드를 삭제한다.
	 * @param cmmnCode
	 * @throws Exception
	 */
	public void deleteCmmnCode(CmmnCode cmmnCode) throws Exception {
		delete("CmmnCodeManageDAO.deleteCmmnCode", cmmnCode);
	}


	/**
	 * 공통코드를 등록한다.
	 * @param cmmnCode
	 * @throws Exception
	 */
	public void insertCmmnCode(CmmnCode cmmnCode) throws Exception {
        insert("CmmnCodeManageDAO.insertCmmnCode", cmmnCode);
	}

	/**
	 * 공통코드 상세항목을 조회한다.
	 * @param cmmnCode
	 * @return CmmnCode(공통코드)
	 */
	public List selectCmmnCodeDetail(CmmnCode cmmnCode) throws Exception {
		return list("CmmnCodeManageDAO.selectCmmnCodeDetail", cmmnCode);
	}


    /**
	 * 공통코드 목록을 조회한다.
     * @param searchVO
     * @return List(공통코드 목록)
     * @throws Exception
     */
    public List selectCmmnCodeList(CmmnCodeVO searchVO) throws Exception {
        return list("CmmnCodeManageDAO.selectCmmnCodeList", searchVO);
    }

    /**
	 * 공통코드 총 갯수를 조회한다.
     * @param searchVO
     * @return int(공통코드 총 갯수)
     */
    public int selectCmmnCodeListTotCnt(CmmnCodeVO searchVO) throws Exception {
        return (Integer)getSqlMapClientTemplate().queryForObject("CmmnCodeManageDAO.selectCmmnCodeListTotCnt", searchVO);
    }

	/**
	 * 공통코드를 수정한다.
	 * @param cmmnCode
	 * @throws Exception
	 */
	public void updateCmmnCode(CmmnCode cmmnCode) throws Exception {
		update("CmmnCodeManageDAO.updateCmmnCode", cmmnCode);
	}
	
	/**
	 * 공통상세코드를 수정한다.
	 * @param cmmnDetailCode
	 * @throws Exception
	 */
	public int updateCmmnDetailCode(CmmnCode cmmnCode) throws Exception {
		return (Integer)update("CmmnCodeManageDAO.updateCmmnDetailCode", cmmnCode);
	}
	
	/**
	 * 공통코드를 중복체크 한다.
	 * @param cmmnDetailCode
	 * @throws Exception
	 */
	public int dupCmnCode(CmmnCode cmmnCode) throws Exception {
		return (Integer)selectByPk("CmmnCodeManageDAO.dupCmnCode", cmmnCode);
	}
}
