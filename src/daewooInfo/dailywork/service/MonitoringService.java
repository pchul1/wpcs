package daewooInfo.dailywork.service;

import java.util.List;

import daewooInfo.dailywork.bean.MonitoringVO;

/**
 * 
 * 조류모니터링
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
public interface MonitoringService {
	
	/**
	 * 조류모니터링 기본정보 등록
	 * @param monitoringVO
	 * @throws Exception
	 */
	public void insertMonitoringInfo(MonitoringVO monitoringVO) throws Exception;
	
	/**
	 * 조류모니터링 기본정보 수정
	 * @param monitoringVO
	 * @throws Exception
	 */
	public void updateMonitoringInfo(MonitoringVO monitoringVO) throws Exception;
	
	/**
	 * 조류모니터링 수질예측정보 삭제
	 * @param monitoringVO
	 * @throws Exception
	 */
	public int deleteForecastInfo(String dailyWorkId) throws Exception;
	
	/**
	 * 조류모니터링 수질예측정보
	 * @param monitoringVO
	 * @throws Exception
	 */
	public void insertForecastInfo(MonitoringVO monitoringVO) throws Exception;
	
	/**
     * 조류모니터링 기본정보 조회
     */
    public MonitoringVO selectMonitoringInfo(String dailyWorkId) throws Exception; 
	
	/**
	 * 수질예측정보 조회
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	public List<MonitoringVO> selectForeCastInfo(MonitoringVO monitoringVO) throws Exception;
	
	/**
	 * 첨부파일 갯수조회
	 */
	public int selectMonitoringFileCnt(String atchFileId) throws Exception;
	
	
}
