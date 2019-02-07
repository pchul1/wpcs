package daewooInfo.admin.access.dao;

import java.sql.SQLException;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import daewooInfo.admin.access.bean.AccessManageVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("accessManageDAO")
public class AccessManageDAO extends EgovAbstractDAO {
	
	/** log */
    protected static final Log LOG = LogFactory.getLog(AccessManageDAO.class);	
    
    /** 개인정보조회이력  ************************/
    
    /**
	 * 개인정보조회 정보를 등록한다.
	 * @param accessManageVO
	 * @throws Exception
	 */
	public void insertFilterAccess(AccessManageVO accessManageVO) throws SQLException {
        insert("AccessManageDAO.insertFilterAccess", accessManageVO);
	}
	
	/**
	 * 개인정보조회 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	public List selectAccessIndiList(AccessManageVO vo) throws SQLException {
		return list("AccessManageDAO.selectAccessIndiList", vo);
	}
	
	/**
	 * 개인정보조회 총건수를 조회한다.
	 * @param vo AccessManageVO 
	 * @return int 
	 * @exception Exception
	 */
    public int selectAccessIndiListTotCnt(AccessManageVO vo) throws SQLException {
        return (Integer)getSqlMapClientTemplate().queryForObject("AccessManageDAO.selectAccessIndiListTotCnt", vo);
    }	
    
   
	
	/**
	 * 개인정보조회 정보변경 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	public List selectAccessChangeInfoList(AccessManageVO vo) throws SQLException{
		return list("AccessManageDAO.selectAccessChangeInfoList", vo);
	}

    /** 접속이력  ************************/

    /**
	 * 접속이력 정보를 등록한다.
	 * @param accessManageVO
	 * @throws Exception
	 */
	public void insertAccessLogin(AccessManageVO accessManageVO) throws SQLException {
        insert("AccessManageDAO.insertAccessLogin", accessManageVO);
	}
	
	/**
	 * 접속이력 목록을 조회
	 * @param vo ComDefaultVO
	 * @return List
	 * @exception Exception
	 */
	public List selectAccessLoginList(AccessManageVO vo) throws SQLException {
		return list("AccessManageDAO.selectAccessLoginList", vo);
	}
	
	/**
	 * 접속이력 총건수를 조회한다.
	 * @param vo AccessManageVO 
	 * @return int 
	 * @exception Exception
	 */
    public int selectAccessLoginListTotCnt(AccessManageVO vo) throws SQLException {
        return (Integer)getSqlMapClientTemplate().queryForObject("AccessManageDAO.selectAccessLoginListTotCnt", vo);
    }	
    
	
}
