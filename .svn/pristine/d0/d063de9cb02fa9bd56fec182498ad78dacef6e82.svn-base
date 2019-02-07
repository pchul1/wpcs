package daewooInfo.dailywork.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.dailywork.bean.MonitoringVO;
import daewooInfo.dailywork.service.MonitoringService;
import daewooInfo.dailywork.dao.MonitoringDAO;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * 
 * 조류모니터링 대한 서비스 구현클래스를 정의한다
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

@Service("MonitoringService")
public class MonitoringServiceImpl extends AbstractServiceImpl implements MonitoringService {
	/**
	 * @uml.property  name="riverMainDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="MonitoringDAO")
    private MonitoringDAO monitoringDAO;
    
    /**
  	 * @uml.property  name="idgenMonitoringIdService"
  	 * @uml.associationEnd  readOnly="true"
  	 */
      @Resource(name = "monitoringIdService")
      private EgovIdGnrService idgenMonitoringIdService;
      
  /**
	 * @uml.property  name="idgenForeCastIdService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "foreCastIdService")
    private EgovIdGnrService idgenForeCastIdService;
    
	/**
     * 조류모니터링 기본정보 등록
     */
    public void insertMonitoringInfo(MonitoringVO monitoringVO) throws Exception{
    	String mId = idgenMonitoringIdService.getNextStringId();																													//조류모니터링ID
    	monitoringVO.setmId(mId);
		
		monitoringDAO.insertMonitoringInfo(monitoringVO);
    }
    
    /**
     * 조류모니터링 수질예측정보 삭제
     */
    public int deleteForecastInfo(String dailyWorkId) throws Exception{
    	int result = 0;
    	
    	monitoringDAO.deleteForecastInfo(dailyWorkId);
    	
    	result++;
    	return result;
    }
    
    /**
     * 조류모니터링 수질예측정보 저장
     */
    public void insertForecastInfo(MonitoringVO monitoringVO) throws Exception{
    	int seq = 0;
    	
    	String forecastId = idgenForeCastIdService.getNextStringId();																											//수질예측정보ID
    	monitoringVO.setForecastId(forecastId);
			
    	seq = monitoringDAO.getForecastSeq(monitoringVO);																														//seq
    	monitoringVO.setSeq(seq);
    	
		monitoringDAO.insertForecastInfo(monitoringVO);
    }
    
    /**
     * 조류모니터링 기본정보
     */
    public MonitoringVO selectMonitoringInfo(String dailyWorkId) throws Exception{
    	return monitoringDAO.selectMonitoringInfo(dailyWorkId);
    }
    
    /**
     * 수질예측정보조회
     */
    public List<MonitoringVO> selectForeCastInfo(MonitoringVO monitoringVO) throws Exception {
    	return monitoringDAO.selectForeCastInfo(monitoringVO);
    }
    
    /**
     * 조류모니터링 기본정보 수정
     */
    public void updateMonitoringInfo(MonitoringVO monitoringVO) throws Exception{
		monitoringDAO.updateMonitoringInfo(monitoringVO);
    }
    
    /**
     * 첨부파일 갯수조회
     */
    public int selectMonitoringFileCnt(String atchFileId) throws Exception {
    	return monitoringDAO.selectMonitoringFileCnt(atchFileId);
    }
}
