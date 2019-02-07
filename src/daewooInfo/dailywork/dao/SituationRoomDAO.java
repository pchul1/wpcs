package daewooInfo.dailywork.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import daewooInfo.dailywork.bean.SituationRoomVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 
 * 상황실근무일지 대한 데이터 접근 클래스를 정의한다
 * @author yrkim
 * @since 2014.09.24
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2014.09.24  yrkim          최초 생성
 *
 * </pre>
 */
@Repository("SituationRoomDAO")
public class SituationRoomDAO extends EgovAbstractDAO {
	
	/** log */
    protected static final Log log = LogFactory.getLog(SituationRoomDAO.class);
	
    /**
     * 상황근무일지등록
     */
    public void insertSituationRoomInfo(SituationRoomVO situationRoomVO) throws Exception{
    	insert("SituationRoomDAO.insertSituationRoomInfo", situationRoomVO);
    }
    
    /**
     * 상황전파 현황 등록
     */
    public void insertSituationSpreadInfo(SituationRoomVO situationRoomVO) throws Exception{
    	insert("SituationRoomDAO.insertSituationSpreadInfo", situationRoomVO);
    }
    
    /**
     * 상황전파 현황 삭제
     */
    public void deleteSituationSpreadInfo(String dailyWorkId) throws Exception{
    	delete("SituationRoomDAO.deleteSituationSpreadInfo", dailyWorkId);
    }
    
    /**
     * 상황전파현황 SEQ 
     */
    
    public int getSituationSpreadSeq(SituationRoomVO situationRoomVO) throws Exception{
    	return (Integer)selectByPk("SituationRoomDAO.getSituationSpreadSeq", situationRoomVO);
    }
    
    /**
     * 상황실 근무일지 근무상황
     */
    public SituationRoomVO selectSituationRoomInfo(String dailyWorkId) throws Exception{
    	return (SituationRoomVO)selectByPk("SituationRoomDAO.selectSituationRoomInfo", dailyWorkId);
    }
    
    /**
     * 상황근무일지수정
     */
    public void updateSituationRoomInfo(SituationRoomVO situationRoomVO) throws Exception{
    	update("SituationRoomDAO.updateSituationRoomInfo", situationRoomVO);
    }
    
    /**
     * 상황실근무일지 상황전파 현황
     */
    public List<SituationRoomVO> selectSituationSpreadInfo(SituationRoomVO situationRoomVO) throws Exception {
		return list("SituationRoomDAO.selectSituationSpreadInfo", situationRoomVO);
    }
    
}
