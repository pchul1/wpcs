package daewooInfo.stats.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.stats.bean.AdActSearchVO;
import daewooInfo.stats.bean.StatsAnalysisVO;
import daewooInfo.stats.bean.StatsSearchVO;
import daewooInfo.stats.bean.StatsVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 상황관리의 통계를 내기 위한 데이터 접근 클래스
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2010.06.28  김태훈          최초 생성
 *
 * </pre>
 */
@Repository("statsDAO")
public class StatsDAO extends EgovAbstractDAO{

    /**
     * 유역별 통계 정보를 가져온다.(탁수모니터링, IP-USN)
     * 
     * @param StatsSearchVO
     */	
    public List<StatsVO> getSectionStatsList(StatsSearchVO vo) {
        return list("statsDAO.getSectionStatsList", vo);
    }
    
    /**
     * 유역별 통계 정보를 가져온다.(TMS)
     * 
     * @param StatsSearchVO
     */	    
    public List<StatsVO> getSectionStatsTmsList(StatsSearchVO vo) {
        return list("statsDAO.getSectionStatsTmsList", vo);
    }    
    
    /**
     * 유역별 통계 정보를 가져온다.(국가수질자동측정망)
     * 
     * @param StatsSearchVO
     */	      
    public List<StatsVO> getSectionStatsAutoList(StatsSearchVO vo) {
    	return list("statsDAO.getSectionStatsAutoList", vo);
    }    
    
    /**
     * 항목별 통계 정보를 가져온다.(탁수모니터링, IP-USN)
     * 
     * @param StatsSearchVO
     */	        
    public List<StatsVO> getItemStatsList(StatsSearchVO vo) {
        return list("statsDAO.getItemStatsList", vo);
    }
    
    /**
     * 항목별 통계 정보를 가져온다.(TMS)
     * 
     * @param StatsSearchVO
     */	    
    public List<StatsVO> getItemStatsTmsList(StatsSearchVO vo) {
        return list("statsDAO.getItemStatsTmsList", vo);
    }    
    
    /**
     * 항목별 통계 정보를 가져온다.(국가수질자동측정망)
     * 
     * @param StatsSearchVO
     */	      
    public List<StatsVO> getItemStatsAutoList(StatsSearchVO vo) {
    	return list("statsDAO.getItemStatsAutoList", vo);
    }    
    
    /**
     * 항목별 통계 정보를 가져온다.(전체)
     * 
     * @param StatsSearchVO
     */	     
    public List<StatsVO> getItemStatsAllList(StatsSearchVO vo) {
    	return list("statsDAO.getItemStatsAllList", vo);
    }    
    
    /**
     * 사고발생 통계 정보를 가져온다.
     * 
     * @param StatsSearchVO
     */	        
    public List<StatsVO> getAccidentStatsList(StatsSearchVO vo) {
        return list("statsDAO.getAccidentStatsList", vo);
    }            
    
    /**
     * 방제조치 통계 정보를 가져온다.
     * 
     * @param StatsSearchVO
     */	        
    public List<StatsVO> getPreventStatsList(StatsSearchVO vo) {
        return list("statsDAO.getPreventStatsList", vo);
    }
    
    /**
     * 상관 관계 분석 정보를 가져온다.(탁수모니터링, IP-USN)
     * 
     * @param StatsSearchVO
     */	     
    public List<StatsAnalysisVO> getItemAnalysisStatsList(StatsSearchVO vo) {
    	return list("statsDAO.getItemAnalysisStatsList", vo);
    }
    
    /**
     * 수질항목별관계
     * @param vo
     * @return
     */
    public List<StatsVO> getRelateItemAnalysis(StatsVO vo)
    {
    	return list("statsDAO.getRelateItemAnalysis", vo);
    }
    
    /**
     * 수질항목별관계
     * @param vo
     * @return
     */
    public List<StatsVO> getRelateItemAlanysisData(StatsVO vo)
    {
    	return list("statsDAO.getRelateItemAlanysisData", vo);
    }
    
    /**
     * 수질유량관계
     * @param vo
     * @return
     */
    public List<StatsVO> getRelateFlowAnalysisData(StatsVO vo)
    {
    	return list("statsDAO.getRelateFlowAnalysisData", vo);
    }
    
    
    /**
     * 수질유량관계
     * @param vo
     * @return
     */
    public List<StatsVO> getRelateFlowAnalysis(StatsVO vo)
    {
    	return list("statsDAO.getRelateFlowAnalysis", vo);
    }
    
    
    //수질항목 추이 그래프
    public List<StatsVO> getRelateItemGraph(StatsVO vo)
    {
    	return list("statsDAO.getRelateItemGraph", vo);
    }
    
    //수질유량 추이 그래프
    public List<StatsVO> getRelateFlowGraph(StatsVO vo)
    {
    	return list("statsDAO.getRelateFlowGraph", vo);
    }
    
    
    /**
     * 상관 관계 분석 정보를 가져온다.(TMS)
     * 
     * @param StatsSearchVO
     */	         
    public List<StatsAnalysisVO> getItemAnalysisStatsTmsList(StatsSearchVO vo) {
    	return list("statsDAO.getItemAnalysisStatsTmsList", vo);
    }
    
    /**
     * 상관 관계 분석 정보를 가져온다.(국가수질자동측정망)
     * 
     * @param StatsSearchVO
     */	         
    public List<StatsAnalysisVO> getItemAnalysisStatsAutoList(StatsSearchVO vo) {
    	return list("statsDAO.getItemAnalysisStatsAutoList", vo);
    }         
    
    /**
     * 상관 계수 메트릭스
     * 
     * @param HashMap<String, String>
     */	         
    public List<HashMap<String, Object>> getFactBranchList(HashMap<String, String> vo) {
    	return list("statsDAO.getFactBranchList", vo);
    }        
    
    /**
     * 유역별 통계
     * @param vo
     * @return
     */
    public List<StatsVO> getStatsBasin(StatsVO vo)
    {
    	return list("statsDAO.getStatsBasin", vo);
    }
    
    /**
     * 시스템별 통계
     * @param vo
     * @return
     */
    public List<StatsVO> getStats(StatsVO vo)
    {
    	return list("statsDAO.getStats", vo);
    }
    
    /**
     * 시스템별 통계 그래프
     * @param vo
     * @return
     */
    public List<StatsVO> getStatsGraph(StatsVO vo)
    {
    	return list("statsDAO.getStatsGraph", vo);
    }
    
    /**
     * 사전조치 통계
     * @param vo
     * @return
     */
    public List<StatsVO> getAdAct(StatsVO vo)
    {
    	return list("statsDAO.getAdAct", vo);
    }
    
    /**
     * 상황전파 통계
     * @param vo
     * @return
     */
    public List<StatsVO> getSituSpread(StatsVO vo)
    {
    	return list("statsDAO.getSituSpread", vo);
    }
    
    /**
     * 상황발생통계 (시스템경보 & 탁수모니터링의 경우)
     * @param vo
     * @return
     */
    public List<StatsVO> getSituOC(StatsVO vo)
    {
    	return list("statsDAO.getSituOC", vo);
    }
    
    /**
     * 상황발생통계 (시스템경보 & IP-USN,측정망일 경우)
     * @param vo
     * @return
     */
    public List<StatsVO> getSituOCWarning(StatsVO vo)
    {
    	return list("statsDAO.getSituOCWarning", vo);
    }
    
    /**
     * 상황발생통계 (사고접수)
     * @param vo
     * @return
     */
    public List<StatsVO> getSituOCAcct(StatsVO vo)
    {
    	return list("statsDAO.getSituOCAcct", vo);
    }
    
    /**
     * 상황조치통계
     * @param vo
     * @return
     */
    public List<StatsVO> getPrevStep(StatsVO vo)
    {
    	return list("statsDAO.getPrevStep", vo);
    }
    
    /**
     * 상황조치통계(사고접수)
     * @param vo
     * @return
     */
    public List<StatsVO> getPrevStep2(StatsVO vo)
    {
    	return list("statsDAO.getPrevStep2", vo);
    }
    
    /**
     * 폐수방류량 통계
     * @param vo
     * @return
     */
    public List<StatsVO> getRiverOutlet(StatsVO vo)
    {
    	return list("statsDAO.getRiverOutlet", vo);
    }
    
    /**
     * 폐수방류량통계 Cnt
     * @param vo
     * @return
     */
    public Integer getRiverOutletCnt(StatsVO vo)
    {
    	return(Integer)selectByPk("statsDAO.getRiverOutletCnt", vo);
    }

	@SuppressWarnings("unchecked")
	public List<AdActSearchVO> getStatsAdActDetail(AdActSearchVO adActSearchVO) {
		//System.out.println("========================>>> 상황조치팝업 DAO Start");
		return list("statsDAO.getStatsAdActDetail", adActSearchVO);
	}

	public int getStatsAdActDetailCnt(AdActSearchVO adActSearchVO) {
		//System.out.println("========================>>> 상황조치팝업  CNT DAO");
		return (Integer)selectByPk("statsDAO.getStatsAdActDetailCnt", adActSearchVO);
	}
	
	public String getStartBaseTime(){
		return (String) selectByPk("statsDAO.getStartBaseTime",null);
	}
	
	public String getEndBaseTime(){
		return (String) selectByPk("statsDAO.getEndBaseTime",null);
	}
}
