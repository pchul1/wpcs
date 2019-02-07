package daewooInfo.common.alrim.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import daewooInfo.common.alrim.bean.AlrimVO;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 알림 안내 DAO 클래스
 * @author 박미영
 * @since 2014.09.04
 * @version 1.0
 * @see
 */
@Repository("alrimDAO")
public class AlrimDAO extends EgovAbstractDAO {
	
	/** log */
    protected static final Log log = LogFactory.getLog(AlrimDAO.class);
    
	/**
	 * @uml.property  name="idgenService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "alrimIdGnrService")
    private EgovIdGnrService idgenService;
    
    /**
	 * 알림 전체 목록 조회
     * @param alrimVO
     * @return List(알림 전체 목록)
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<AlrimVO> selectAlrimList(AlrimVO alrimVO) throws Exception {
        return list("alrimDAO.selectAlrimList", alrimVO);
    }
    
    public int selectAlrimtotList(AlrimVO alrimVO) throws Exception {
        return (Integer)selectByPk("alrimDAO.selectAlrimtotList", alrimVO);
    }
 
    /**
	 * 알림 전체 총 카운트 조회
     * @param alrimVO
     * @return count
     * @throws Exception
     */
    public int selectAlrimListTotCount(AlrimVO alrimVO) throws Exception {
        return (Integer)getSqlMapClientTemplate().queryForObject("alrimDAO.selectAlrimListTotCount", alrimVO);
    }

    /**
	 * 알림 미확인 목록 조회
     * @param alrimVO
     * @return List(알림 미확인 목록)
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
    public List<AlrimVO> selectUnConfirmAlrimList(AlrimVO alrimVO) throws Exception {
        return list("alrimDAO.selectUnConfirmAlrimList", alrimVO);
    }
    

	/**
	 * 알림 전체 목록을 조회
	 * @param alrimVO
	 * @return List(알림 목록)
	 * @throws Exception
	 */
	public List<AlrimVO> selectMobileSeminarAlrimList(AlrimVO alrimVO) throws Exception{
		return list("alrimDAO.selectMobileSeminarAlrimList", alrimVO);
	}
	
    /**
	 * 알림 미확인 카운트 조회
     * @param alrimVO
     * @return count
     * @throws Exception
     */
    public int selectUnConfirmAlrimCount(AlrimVO alrimVO) throws Exception {
        return (Integer)getSqlMapClientTemplate().queryForObject("alrimDAO.selectUnConfirmAlrimCount", alrimVO);
    }    
    
    /**
	 * 알림 내용을 삽입 처리
     * @param alrimVO
     * @return String(알림 내용을 삽입)
     * @throws Exception
     */
    public String insertAlrim(AlrimVO alrimVO) throws Exception {
        return (String)insert("alrimDAO.insertAlrim", alrimVO);
    }
    
    /**
	 * 알림 내용 확인 처리
     * @param alrimVO
     * @throws Exception
     */
    public void updateAlrim(AlrimVO alrimVO) throws Exception {
        update("alrimDAO.updateAlrim", alrimVO);
    }
    
    /**
	 * 알림 내용 확인 처리
     * @param alrimVO
     * @throws Exception
     */
    public void deleteAlrim(AlrimVO alrimVO) throws Exception {
        delete("alrimDAO.deleteAlrim", alrimVO);
    }
    
    public String insertSeminarAlrim(AlrimVO alrimVO) throws Exception {
    	String alrimId = idgenService.getNextStringId();
    	alrimVO.setAlrimId(alrimId);
		return (String)insert("alrimDAO.insertAlrim", alrimVO);
	} 
}