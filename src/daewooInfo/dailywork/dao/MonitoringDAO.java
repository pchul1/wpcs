package daewooInfo.dailywork.dao;

import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import daewooInfo.dailywork.bean.MonitoringVO;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 
 * 조류모니터링 대한 데이터 접근 클래스를 정의한다
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
@Repository("MonitoringDAO")
public class MonitoringDAO extends EgovAbstractDAO {
	
	/** log */
    protected static final Log log = LogFactory.getLog(MonitoringDAO.class);
	
    /**
     * 조류모니터링 기본정보 등록
     */
    public void insertMonitoringInfo(MonitoringVO monitoringVO) throws Exception{
    	insert("MonitoringDAO.insertMonitoringInfo", monitoringVO);
    }
    
    /**
     * 조류모니터링 수질예측정보 SEQ 
     */
    
    public int getForecastSeq(MonitoringVO monitoringVO) throws Exception{
    	return (Integer)selectByPk("MonitoringDAO.getForecastSeq", monitoringVO);
    }
    
    /**
     * 조류모니터링 수질예측정보 삭제
     */
    public void deleteForecastInfo(String dailyWorkId) throws Exception{
    	delete("MonitoringDAO.deleteForecastInfo", dailyWorkId);
    }
    
    /**
     * 조류모니터링 수질예측정보 등록
     */
    public void insertForecastInfo(MonitoringVO monitoringVO) throws Exception{
    	insert("MonitoringDAO.insertForecastInfo", monitoringVO);
    }
    
    /**
     * 조류모니터링 기본정보
     */
    public MonitoringVO selectMonitoringInfo(String dailyWorkId) throws Exception{
    	return (MonitoringVO)selectByPk("MonitoringDAO.selectMonitoringInfo", dailyWorkId);
    }
    
    /**
     * 수질예측정보조회
     */
    public List<MonitoringVO> selectForeCastInfo(MonitoringVO monitoringVO) throws Exception {
		return list("MonitoringDAO.selectForeCastInfo", monitoringVO);
    }
    
    /**
     * 조류모니터링 기본정보 수정
     */
    public void updateMonitoringInfo(MonitoringVO monitoringVO) throws Exception{
    	update("MonitoringDAO.updateMonitoringInfo", monitoringVO);
    }
    
    /**
     * 첨부파일 갯수조회
     */
    public int selectMonitoringFileCnt(String atchFileId) throws Exception {
    	return (Integer)selectByPk("MonitoringDAO.selectMonitoringFileCnt", atchFileId);
    }
}
