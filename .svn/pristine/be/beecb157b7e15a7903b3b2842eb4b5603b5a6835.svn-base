package daewooInfo.stats.service.impl;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.stats.bean.AdActSearchVO;
import daewooInfo.stats.bean.StatsAnalysisVO;
import daewooInfo.stats.bean.StatsSearchVO;
import daewooInfo.stats.bean.StatsVO;
import daewooInfo.stats.dao.StatsDAO;
import daewooInfo.stats.service.StatsService;

/**
 * 상황관리의 통계를 내기 위한 서비스 구현 클래스
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------     --------    ---------------------------
 *   2010.6.28  김태훈          최초 생성
 *
 */
@Service("statsService")
public class StatsServiceImpl implements StatsService{

	/**
	 * @uml.property  name="statsDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "statsDAO")
	private StatsDAO statsDAO;
	
	
    /**
     * 유역별 통계 정보를 가져온다.(탁수모니터링, IP-USN)
     * 
     * @see daewooInfo.stats.service.StatsService#getSectionStatsList(daewooInfo.stats.bean.StatsSearchVO)
     */
    public List<StatsVO> getSectionStatsList(StatsSearchVO vo) {
        return statsDAO.getSectionStatsList(vo);
    }
        
    /**
     * 유역별 통계 정보를 가져온다.(TMS)
     * 
     * @see daewooInfo.stats.service.StatsService#getSectionStatsTmsList(daewooInfo.stats.bean.StatsSearchVO)
     */
    public List<StatsVO> getSectionStatsTmsList(StatsSearchVO vo) {
    	return statsDAO.getSectionStatsTmsList(vo);
    }
    
    /**
     * 유역별 통계 정보를 가져온다.(국가수질자동측정망)
     * 
     * @see daewooInfo.stats.service.StatsService#getSectionStatsAutoList(daewooInfo.stats.bean.StatsSearchVO)
     */
    public List<StatsVO> getSectionStatsAutoList(StatsSearchVO vo) {
    	return statsDAO.getSectionStatsAutoList(vo);
    }		    
    
    /**
     * 항목별 통계 정보를 가져온다.(탁수모니터링, IP-USN)
     * 
     * @see daewooInfo.stats.service.StatsService#getItemStatsList(daewooInfo.stats.bean.StatsSearchVO)
     */
    public List<StatsVO> getItemStatsList(StatsSearchVO vo) {
        return statsDAO.getItemStatsList(vo);
    }
    
    /**
     * 항목별 통계 정보를 가져온다.(TMS)
     * 
     * @see daewooInfo.stats.service.StatsService#getItemStatsTmsList(daewooInfo.stats.bean.StatsSearchVO)
     */
    public List<StatsVO> getItemStatsTmsList(StatsSearchVO vo) {
    	return statsDAO.getItemStatsTmsList(vo);
    }
    
    /**
     * 항목별 통계 정보를 가져온다.(국가수질자동측정망)
     * 
     * @see daewooInfo.stats.service.StatsService#getItemStatsAutoList(daewooInfo.stats.bean.StatsSearchVO)
     */
    public List<StatsVO> getItemStatsAutoList(StatsSearchVO vo) {
    	return statsDAO.getItemStatsTmsList(vo);
    }
    
    /**
     * 항목별 통계 정보를 가져온다.(전체)
     * 
     * @see daewooInfo.stats.service.StatsService#getItemStatsAllList(daewooInfo.stats.bean.StatsSearchVO)
     */
    public List<StatsVO> getItemStatsAllList(StatsSearchVO vo) {
    	return statsDAO.getItemStatsAllList(vo);
    }
    
    /**
     * 사고발생 통계 정보를 가져온다.
     * 
     * @see daewooInfo.stats.service.StatsService#getAccidentStatsList(daewooInfo.stats.bean.StatsSearchVO)
     */
    public List<StatsVO> getAccidentStatsList(StatsSearchVO vo) {
    	return statsDAO.getAccidentStatsList(vo);
    }
    
    /**
     * 방제조치 통계 정보를 가져온다.
     * 
     * @see daewooInfo.stats.service.StatsService#getPreventStatsList(daewooInfo.stats.bean.StatsSearchVO)
     */
    public List<StatsVO> getPreventStatsList(StatsSearchVO vo) {
    	return statsDAO.getPreventStatsList(vo);
    }
    
    /**
     * 상관 관계 분석 정보를 가져온다.(탁수모니터링, IP-USN)
     * 
     * @see daewooInfo.stats.service.StatsService#getItemAnalysisStatsList(daewooInfo.stats.bean.StatsSearchVO)
     */
    public List<StatsAnalysisVO> getItemAnalysisStatsList(StatsSearchVO vo) {
    	return statsDAO.getItemAnalysisStatsList(vo);
    }
    
    /**
     * 수질항목별관계
     * @param vo
     * @return
     */
    public List<StatsVO> getRelateItemAnalysis(StatsVO vo)
    {
    	return statsDAO.getRelateItemAnalysis(vo);
    }

   
    public List<StatsVO> getRelateItemAlanysisData(StatsVO vo)
    {
	   return statsDAO.getRelateItemAlanysisData(vo);
    }

    /**
     * 수질유량관계
     * @param vo
     * @return
     */
    public List<StatsVO> getRelateFlowAnalysis(StatsVO vo)
    {
    	return statsDAO.getRelateFlowAnalysis(vo);
    }
    
    public List<StatsVO> getRelateFlowAnalysisData(StatsVO vo)
    {
	   return statsDAO.getRelateFlowAnalysisData(vo);
    }
    
    public List<StatsVO> getRelateItemGraph(StatsVO vo)
    {
    	return statsDAO.getRelateItemGraph(vo);
    }
    
    public List<StatsVO> getRelateFlowGraph(StatsVO vo)
    {
    	return statsDAO.getRelateFlowGraph(vo);
    }
    
    /**
     * 상관 관계 분석 정보를 가져온다.(TMS)
     * 
     * @see daewooInfo.stats.service.StatsService#getItemAnalysisStatsTmsList(daewooInfo.stats.bean.StatsSearchVO)
     */
    public List<StatsAnalysisVO> getItemAnalysisStatsTmsList(StatsSearchVO vo) {
    	return statsDAO.getItemAnalysisStatsTmsList(vo);
    }
    
    /**
     * 상관 관계 분석 정보를 가져온다.(국가수질자동측정망)
     * 
     * @see daewooInfo.stats.service.StatsService#getItemAnalysisStatsAutoList(daewooInfo.stats.bean.StatsSearchVO)
     */
    public List<StatsAnalysisVO> getItemAnalysisStatsAutoList(StatsSearchVO vo) {
    	return statsDAO.getItemAnalysisStatsTmsList(vo);
    }		    
    
    /**
     * 상관 계수 메트릭스
     * 
     * @param HashMap<String, String>
     */	      
    public List<HashMap<String, Object>> getFactBranchList(HashMap<String, String> vo) {
    	return statsDAO.getFactBranchList(vo);
    }    	
    
    /**
     * 유역별 통계
     * @param vo
     * @return
     */
    public List<StatsVO> getStatsBasin(StatsVO vo) throws Exception
    {
    	return statsDAO.getStatsBasin(vo);
    }
    
    
    /**
     * 시스템별 통계
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getStats(StatsVO vo) throws Exception
    {
    	return statsDAO.getStats(vo);
    }
    
    /**
     * 시스템별 통계 그래프
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getStatsGraph(StatsVO vo) throws Exception
    {
    	return statsDAO.getStatsGraph(vo);
    }
    
    /**
     * 사고조치 통계
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getAdAct(StatsVO vo) throws Exception
    {
    	return statsDAO.getAdAct(vo);
    }
    
    /**
     * 상황전파통계
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getSituSpread(StatsVO vo) throws Exception
    {
    	return statsDAO.getSituSpread(vo);
    }
    
    /**
     * 상황발생통계 (시스템경보 & 탁수모니터링일 경우)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getSituOC(StatsVO vo) throws Exception
    {
    	return statsDAO.getSituOC(vo);
    }
    
    /**
     * 상황발생통계 (시스템경보 & IP-USN, 측정망 일 경우)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getSituOCWarning(StatsVO vo) throws Exception
    {
    	return statsDAO.getSituOCWarning(vo);
    }
    
    /**
     * 상황발생통계 (임의지점)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getSituOCAcct(StatsVO vo) throws Exception
    {
    	return statsDAO.getSituOCAcct(vo);
    }
    
    /**
     * 상황조치통계
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getPrevStep(StatsVO vo) throws Exception
    {
    	return statsDAO.getPrevStep(vo);
    }
    
    /**
     * 상황조치통계(사고접수)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getPrevStep2(StatsVO vo) throws Exception
    {
    	return statsDAO.getPrevStep2(vo);
    }
    
    /**
     * 폐수방류량조회
     * @param vo
     * @return
     * @throws Exception
     */
    public List<StatsVO> getRiverOutlet(StatsVO vo) throws Exception
    {
    	return statsDAO.getRiverOutlet(vo);
    }
    
    /**
     * 폐수방류량 Cnt
     * @param vo
     * @return
     * @throws Exception
     */
    public Integer getRiverOutletCnt(StatsVO vo) throws Exception
    {
    	return statsDAO.getRiverOutletCnt(vo);
    }

	public List<AdActSearchVO> getStatsAdActDetail(AdActSearchVO adActSearchVO) {
		return statsDAO.getStatsAdActDetail(adActSearchVO);
	}

	public int getStatsAdActDetailCnt(AdActSearchVO searchVO) {
		return statsDAO.getStatsAdActDetailCnt(searchVO);
	}
	
	public String getStartBaseTime() {
		// TODO Auto-generated method stub
		return statsDAO.getStartBaseTime();
	}
	
	public String getEndBaseTime() {
		// TODO Auto-generated method stub
		return statsDAO.getEndBaseTime();
	}
}
