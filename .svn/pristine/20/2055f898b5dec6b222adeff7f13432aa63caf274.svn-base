package daewooInfo.dailywork.dao;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import daewooInfo.dailywork.bean.RiverMainVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 
 * 4대강주요수계일지 대한 데이터 접근 클래스를 정의한다
 * @author yrkim
 * @since 2014.10.10
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2014.10.10  yrkim          최초 생성
 *
 * </pre>
 */
@Repository("RiverMainDAO")
public class RiverMainDAO extends EgovAbstractDAO {
	
	/** log */
    protected static final Log log = LogFactory.getLog(RiverMainDAO.class);
	
    /**
     * 4대강주요수계일지 등록
     */
    public void insertRiverMainInfo(RiverMainVO riverMainVO) throws Exception{
    	insert("RiverMainDAO.insertRiverMainInfo", riverMainVO);
    }
    
    /**
     * 4대강주요수계일지 정보 조회
     */
    public RiverMainVO selectRiverMainInfo(String dailyWorkId) throws Exception{
    	return (RiverMainVO)selectByPk("RiverMainDAO.selectRiverMainInfo", dailyWorkId);
    }
    
    /**
     * 4대강주요수계일지 수정
     */
    public void updateRiverMainInfo(RiverMainVO riverMainVO) throws Exception{
    	update("RiverMainDAO.updateRiverMainInfo", riverMainVO);
    }
}
