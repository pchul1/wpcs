package daewooInfo.stats.service;

import java.util.HashMap;
import java.util.List;

import daewooInfo.stats.bean.AdActSearchVO;
import daewooInfo.stats.bean.StatsAnalysisVO;
import daewooInfo.stats.bean.StatsSearchVO;
import daewooInfo.stats.bean.StatsVO;

/**
 * 상황관리의 통계를 내기 위한 서비스 인터페이스 클래스
 * @author  김태훈
 * @since  2010.06.28
 * @version  1.0
 * @see  <pre>  << 개정이력(Modification Information) >>  수정일      수정자           수정내용  -------     --------    ---------------------------  2010.6.28  김태훈          최초 생성
 */
public interface StatsService {
    /**
     * 유역별 통계 정보를 가져온다.(탁수모니터링, IP-USN)
     * 
     * @param StatsSearchVO
     */		
    List<StatsVO> getSectionStatsList(StatsSearchVO vo) throws Exception;
    
    /**
     * 유역별 통계 정보를 가져온다.(TMS)
     * 
     * @param StatsSearchVO
     */	     
    List<StatsVO> getSectionStatsTmsList(StatsSearchVO vo) throws Exception;
    
    /**
     * 유역별 통계 정보를 가져온다.(국가수질자동측정망)
     * 
     * @param StatsSearchVO
     */	     
    List<StatsVO> getSectionStatsAutoList(StatsSearchVO vo) throws Exception;
    
    /**
     * 항목별 통계 정보를 가져온다.(탁수모니터링, IP-USN)
     * 
     * @param StatsSearchVO
     */	       
    List<StatsVO> getItemStatsList(StatsSearchVO vo) throws Exception;
    
    /**
     * 항목별 통계 정보를 가져온다.(TMS)
     * 
     * @param StatsSearchVO
     */	      
    List<StatsVO> getItemStatsTmsList(StatsSearchVO vo) throws Exception;
    
    /**
     * 항목별 통계 정보를 가져온다.(국가수질자동측정망)
     * 
     * @param StatsSearchVO
     */	     
    List<StatsVO> getItemStatsAutoList(StatsSearchVO vo) throws Exception;
    
    /**
     * 항목별 통계 정보를 가져온다.(전체)
     * 
     * @param StatsSearchVO
     */	      
    List<StatsVO> getItemStatsAllList(StatsSearchVO vo) throws Exception;
    
    /**
     * 사고발생 통계 정보를 가져온다.
     * 
     * @param StatsSearchVO
     */	     
    List<StatsVO> getAccidentStatsList(StatsSearchVO vo) throws Exception;
    
    /**
     * 방제조치 통계 정보를 가져온다.
     * 
     * @param StatsSearchVO
     */	    
    List<StatsVO> getPreventStatsList(StatsSearchVO vo) throws Exception;
    
    /**
     * 상관 관계 분석 정보를 가져온다.(탁수모니터링, IP-USN)
     * 
     * @param StatsSearchVO
     */	        
    List<StatsAnalysisVO> getItemAnalysisStatsList(StatsSearchVO vo) throws Exception;
    
    /**
     * 수질항목별관계
     * @param vo
     * @return
     * @throws Exception
     */
    List<StatsVO> getRelateItemAnalysis(StatsVO vo) throws Exception;
    
    /**
     * 수질우량관계
     * @param vo
     * @return
     * @throws Exception
     */
    List<StatsVO> getRelateFlowAnalysis(StatsVO vo) throws Exception;
    
    List<StatsVO> getRelateItemAlanysisData(StatsVO vo) throws Exception;
    
    List<StatsVO> getRelateFlowAnalysisData(StatsVO vo) throws Exception;
    
    List<StatsVO> getRelateItemGraph(StatsVO vo) throws Exception;
    
    List<StatsVO> getRelateFlowGraph(StatsVO vo) throws Exception;
    
    /**
     * 상관 관계 분석 정보를 가져온다.(TMS)
     * 
     * @param StatsSearchVO
     */	    
    List<StatsAnalysisVO> getItemAnalysisStatsTmsList(StatsSearchVO vo) throws Exception;
    
    /**
     * 상관 관계 분석 정보를 가져온다.(국가수질자동측정망)
     * 
     * @param StatsSearchVO
     */	      
    List<StatsAnalysisVO> getItemAnalysisStatsAutoList(StatsSearchVO vo) throws Exception;
    
    /**
     * 상관 계수 메트릭스
     * 
     * @param HashMap<String, String>
     */	        
    List<HashMap<String, Object>> getFactBranchList(HashMap<String, String> vo) throws Exception;
    
    /**
     * 유역별 통계
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getStatsBasin(StatsVO vo) throws Exception;
    
    /**
     * 시스템별 통계
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getStats(StatsVO vo) throws Exception;
    
    /**
     * 시스템별 통계 그래프
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getStatsGraph(StatsVO vo) throws Exception;
    
    
    /**
     * 사고조치통계
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getAdAct(StatsVO vo) throws Exception;
    
    /**
     * 상황전파 통계
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getSituSpread(StatsVO vo) throws Exception;
    
    /**
     * 상황발생통계 (시스템경보일 경우, 탁수모니터링일 경우)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getSituOC(StatsVO vo) throws Exception;
    
    /**
     * 상황발생통계 (시스템경보 & IP-USN, 측정망 일 경우)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getSituOCWarning(StatsVO vo) throws Exception;
    
    /**
     * 상황발생통계 (사고접수)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getSituOCAcct(StatsVO vo) throws Exception;
    
    
    /**
     * 상황조치통계
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getPrevStep(StatsVO vo) throws Exception;
    
    /**
     * 상황조치통계(사고접수)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getPrevStep2(StatsVO vo) throws Exception;
    
    
    /**
     * 폐수방류량
     * @param vo
     * @return
     * @throws Excepion
     */
    public List<StatsVO> getRiverOutlet(StatsVO vo) throws Exception;
    
    
    /**
     * 폐수방류량 Cnt
     * @param vo
     * @return
     * @throws Exception
     */
    public Integer getRiverOutletCnt(StatsVO vo) throws Exception;

    /**
     * 사전조치통계 상세팝업
     * @param searchVO
     * @return
     */
	List<AdActSearchVO> getStatsAdActDetail(AdActSearchVO adActSearchVO);
	int getStatsAdActDetailCnt(AdActSearchVO adActSearchVO);
	
	/**
	 * 지천별 방류량 초기 검색 시작일자 얻기 
	 * @param  
	 * @return  String
	 * @uml.property  name="startBaseTime"
	 */
	public String getStartBaseTime();
	
	/**
	 * 지천별 방류량 초기 검색 종료일자 얻기 
	 * @param  
	 * @return  String
	 * @uml.property  name="endBaseTime"
	 */
	public String getEndBaseTime();
    
}
