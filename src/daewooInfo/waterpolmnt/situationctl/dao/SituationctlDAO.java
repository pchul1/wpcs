package daewooInfo.waterpolmnt.situationctl.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.warehouse.bean.WareHouseSearchVO;
import daewooInfo.waterpolmnt.situationctl.bean.AlertTargetVO;
import daewooInfo.waterpolmnt.situationctl.bean.AutoDataVO;
import daewooInfo.waterpolmnt.situationctl.bean.FactLawVO;
import daewooInfo.waterpolmnt.situationctl.bean.FactLocationVO;
import daewooInfo.waterpolmnt.situationctl.bean.MainChartVO;
import daewooInfo.waterpolmnt.situationctl.bean.ResultChartVO;
import daewooInfo.waterpolmnt.situationctl.bean.SearchTaksuMainVO;
import daewooInfo.waterpolmnt.situationctl.bean.SearchTaksuPopupVO;
import daewooInfo.waterpolmnt.situationctl.bean.SearchTaksuSumDataVO;
import daewooInfo.waterpolmnt.situationctl.bean.SeqInfoVO;
import daewooInfo.waterpolmnt.situationctl.bean.TaksuMainVO;
import daewooInfo.waterpolmnt.situationctl.bean.TaksuPopupVO;
import daewooInfo.waterpolmnt.situationctl.bean.TaksuTopDataVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntMainDetailSearchTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntMainDetailTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntMainSearchTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntMainSearchVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntMainTopTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntMainVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntNorecvSearchTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntNorecvTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntSummaryVO;
import daewooInfo.waterpolmnt.situationctl.bean.WatersysMntCoordVO;
import daewooInfo.waterpolmnt.situationctl.bean.WatersysMntMainDetailSearchTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.WatersysMntMainDetailTSVO;
import daewooInfo.waterpolmnt.waterinfo.bean.AirMntDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.AlgaCastDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.BoSearchVO;
import daewooInfo.waterpolmnt.waterinfo.bean.DamViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.DetailViewVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("situationctlDAO")
public class SituationctlDAO extends EgovAbstractDAO{
	
	// 메인(로그인후) - 측정값 조회
	public List<TaksuMainVO> getDetailRIVERMAIN(SearchTaksuMainVO searchTaksuMainVO) {
    	return list("situationctlDAO.getDetailRIVERMAIN", searchTaksuMainVO);
    }

    // 통합감시 - 통계표 조회	
    public List<TotalMntMainTopTSVO> getTotalMntMainTopTS() {
    	return list("situationctlDAO.getTotalMntMainTopTS", null);
    }
    
    // 통합감시 - 측정값 조회(전체)
    public List<TotalMntMainVO> getTotalMntMain(TotalMntMainSearchVO totalMntMainSearchVO) {
    	return list("situationctlDAO.getTotalMntMain", totalMntMainSearchVO);
    }
    
    // 통합감시 - 측정값 조회(한강)
    public List<TotalMntMainVO> getTotalMntMainR01(TotalMntMainSearchVO totalMntMainSearchVO) {
    	
    	List<TotalMntMainVO> ret = null;
    	if(totalMntMainSearchVO.getSys().equals("T"))
    	{
    		ret = list("situationctlDAO.getTotalMntMainR01TMS", totalMntMainSearchVO);
    	}
    	else
    	{
    		ret = list("situationctlDAO.getTotalMntMainR01", totalMntMainSearchVO);
    	}
    	
    	/*return list("situationctlDAO.getTotalMntMainR01", totalMntMainSearchVO);*/
    	return ret;
    }

    // 통합감시 - 측정값 조회(금강)
    public List<TotalMntMainVO> getTotalMntMainR03(TotalMntMainSearchVO totalMntMainSearchVO) {
    	List<TotalMntMainVO> ret = null;
    	if(totalMntMainSearchVO.getSys().equals("T"))
    	{
    		ret = list("situationctlDAO.getTotalMntMainR03TMS", totalMntMainSearchVO);
    	}
    	else
    	{
    		ret = list("situationctlDAO.getTotalMntMainR03", totalMntMainSearchVO);
    	}
    	
    	/*return list("situationctlDAO.getTotalMntMainR01", totalMntMainSearchVO);*/
    	return ret;
    	/*return list("situationctlDAO.getTotalMntMainR03", totalMntMainSearchVO);*/
    }

    // 통합감시 - 측정값 조회(낙동강)
    public List<TotalMntMainVO> getTotalMntMainR02(TotalMntMainSearchVO totalMntMainSearchVO) {
    	List<TotalMntMainVO> ret = null;
    	if(totalMntMainSearchVO.getSys().equals("T"))
    	{
    		ret = list("situationctlDAO.getTotalMntMainR02TMS", totalMntMainSearchVO);
    	}
    	else
    	{
    		ret = list("situationctlDAO.getTotalMntMainR02", totalMntMainSearchVO);
    	}
    	
    	/*return list("situationctlDAO.getTotalMntMainR01", totalMntMainSearchVO);*/
    	return ret;
    	/*return list("situationctlDAO.getTotalMntMainR02", totalMntMainSearchVO);*/
    }

    // 통합감시 - 측정값 조회(영산강)
    public List<TotalMntMainVO> getTotalMntMainR04(TotalMntMainSearchVO totalMntMainSearchVO) {
    	
    	List<TotalMntMainVO> ret = null;
    	if(totalMntMainSearchVO.getSys().equals("T"))
    	{
    		ret = list("situationctlDAO.getTotalMntMainR04TMS", totalMntMainSearchVO);
    	}
    	else
    	{
    		ret = list("situationctlDAO.getTotalMntMainR04", totalMntMainSearchVO);
    	}
    	
    	/*return list("situationctlDAO.getTotalMntMainR04", totalMntMainSearchVO);*/
    	return ret;
    }

   // 통합감시 - 상세정보 조회
    public List<TotalMntSummaryVO> getTotalMntSummary(TotalMntMainSearchTSVO totalMntMainSearchTSVO) {
    	
    	List<TotalMntSummaryVO> ret = null;
    	if(totalMntMainSearchTSVO.getSys().equals("T"))
    	{
    		ret = list("situationctlDAO.getTotalMntSummaryTMS", totalMntMainSearchTSVO);
    	}
    	else
    	{
    		ret = list("situationctlDAO.getTotalMntSummary", totalMntMainSearchTSVO);
    	}
    	
    	return ret;
    	/*return list("situationctlDAO.getTotalMntSummary", totalMntMainSearchTSVO);*/
    }

    // 통합감시 - 측정값 조회(세부팝업)
    public List<TotalMntMainDetailTSVO> getTotalMntMainDetailTS(TotalMntMainDetailSearchTSVO totalMntMainDetailSearchTSVO) {
    	
    	List<TotalMntMainDetailTSVO> ret = null;
    	if(totalMntMainDetailSearchTSVO.getSys().equals("T"))
    	{
    		ret = list("situationctlDAO.getTotalMntMainDetailTS_TMS", totalMntMainDetailSearchTSVO);
    	}
    	else
    	{
    		ret = list("situationctlDAO.getTotalMntMainDetailTS", totalMntMainDetailSearchTSVO);
    	}
    	
    	return ret;
    	/*return list("situationctlDAO.getTotalMntMainDetailTS", totalMntMainDetailSearchTSVO);*/
    }
    
    public List<TotalMntMainDetailTSVO> getTotalMntMainDetailTSGraph(TotalMntMainDetailSearchTSVO totalMntMainDetailSearchTSVO)
    {
    	List<TotalMntMainDetailTSVO> ret = null;
    	if(totalMntMainDetailSearchTSVO.getSys().equals("T"))
    	{
    		ret = list("situationctlDAO.getTotalMntMainDetailTSGraph_TMS", totalMntMainDetailSearchTSVO);
    	}
    	else
    	{
    		ret = list("situationctlDAO.getTotalMntMainDetailTSGraph", totalMntMainDetailSearchTSVO);
    	}
    	
    	return ret;
    	//return list("situationctlDAO.getTotalMntMainDetailTSGraph", totalMntMainDetailSearchTSVO);
    }
    
    public List<TotalMntMainDetailTSVO> getTotalMntMainDetailTSGraph_compare(TotalMntMainDetailSearchTSVO totalMntMainDetailSearchTSVO)
    {
    	return list("situationctlDAO.getTotalMntMainDetailTSGraph_compare", totalMntMainDetailSearchTSVO);
    }

    // 통합감시 - 측정값 조회(세부팝업-상황전파자)
	public List<AlertTargetVO> getAlertTargetList(AlertTargetVO alertTargetVO) throws Exception {
		return list("situationctlDAO.getAlertTargetList", alertTargetVO);
	}			
	
    // 통합감시 - 측정값 조회(세부팝업-그래프)
    public List<ResultChartVO> getTotalMntGraph(TotalMntMainSearchTSVO totalMntMainSearchTSVO) {
    	List<ResultChartVO> ret = null;
    	if(totalMntMainSearchTSVO.getSys().equals("T"))
    	{
    		ret = list("situationctlDAO.getTotalMntGraphTMS", totalMntMainSearchTSVO);
    	}
    	else
    	{
    		ret = list("situationctlDAO.getTotalMntGraph", totalMntMainSearchTSVO);
    	}
    	
    	
    	
    	return ret;
    	/*return list("situationctlDAO.getTotalMntGraph", totalMntMainSearchTSVO);*/
    }
    // 통합감시 - 측정값 조회(세부팝업-그래프)
    public List<ResultChartVO> getTotalMntGraph2(TotalMntMainSearchTSVO totalMntMainSearchTSVO) {
    	List<ResultChartVO> ret = null;
    	if(totalMntMainSearchTSVO.getSys().equals("T"))
    	{
    		ret = list("situationctlDAO.getTotalMntGraphTMS", totalMntMainSearchTSVO);
    	}
    	else
    	{
    		ret = list("situationctlDAO.getTotalMntGraph2", totalMntMainSearchTSVO);
    	}
    	
    	
    	
    	return ret;
    	// list("situationctlDAO.getTotalMntGraph2", totalMntMainSearchTSVO);
    }
    
    // 통합감시 - 선택한 측정값 조회(세부팝업-그래프)
    public List<ResultChartVO> getSelectTotalMntGraph2(TotalMntMainSearchTSVO totalMntMainSearchTSVO) {
    	return list("situationctlDAO.getSelectTotalMntGraph2", totalMntMainSearchTSVO);
    }
    
 // 통합감시 - 선택한 측정값 조회(세부팝업-그래프)
    public List<ResultChartVO> getSelectMultiTotalMntGraph2(TotalMntMainSearchTSVO totalMntMainSearchTSVO) {
    	return list("situationctlDAO.getSelectMultiTotalMntGraph2", totalMntMainSearchTSVO);
    }

    // 통합감시 - 미수신 정보 조회
    public List<TotalMntNorecvTSVO> getTotalMntNorecv(TotalMntNorecvSearchTSVO totalMntNorecvSearchTSVO) {
    	
    	List<TotalMntNorecvTSVO> ret = null;
    	if(totalMntNorecvSearchTSVO.getSys_kind().equals("T"))
    	{
    		ret = list("situationctlDAO.getTotalMntNorecvTMS", totalMntNorecvSearchTSVO);
    	}
    	else
    	{
    		ret = list("situationctlDAO.getTotalMntNorecv", totalMntNorecvSearchTSVO);
    	}
    	
    	return ret;
    }

    // 수계별 통합감시 - 통계표 조회
    public List<TaksuTopDataVO> getTopDataTAKSU(SearchTaksuSumDataVO searchTaksuSumDataVO) {
    	return list("situationctlDAO.getTopDataTAKSU", searchTaksuSumDataVO);
    }

	// 수계별 통합감시 - 측정값 조회
	public List<TaksuPopupVO> getWATERSYSMNT(SearchTaksuPopupVO searchTaksuPopupVO) {
    	return list("situationctlDAO.getWATERSYSMNT", searchTaksuPopupVO);
    }
	
	// 선택좌표 - 측정값 조회
	public List<TaksuPopupVO> getSelectWATERSYSMNT(SearchTaksuPopupVO searchTaksuPopupVO) {
    	return list("situationctlDAO.getSelectWATERSYSMNT", searchTaksuPopupVO);
    }
	
	// 선택좌표 - 측정값 조회
	public List<DetailViewVO> getAllDetailViewDISCHARGE(SearchTaksuPopupVO searchTaksuPopupVO) {
    	return list("situationctlDAO.getAllDetailViewDISCHARGE", searchTaksuPopupVO);
    }
	
// 선택좌표 - 측정값 조회
	public List<BoSearchVO> getAllDetailViewBO(SearchTaksuPopupVO searchTaksuPopupVO) {
    	return list("situationctlDAO.getAllDetailViewBO", searchTaksuPopupVO);
    }
	
	// 선택좌표 - 측정값 조회
	public List<DamViewVO> getAllDetailViewDAM(SearchTaksuPopupVO searchTaksuPopupVO) {
    	return list("situationctlDAO.getAllDamList", searchTaksuPopupVO);
    }
	
	// 선택좌표 - 측정값 조회
	public List<WareHouseSearchVO> getAllDetailViewWAREHOUSE(SearchTaksuPopupVO searchTaksuPopupVO) {
    	return list("situationctlDAO.getAllSearchWareHouseList", searchTaksuPopupVO);
    }
    
	// 통합감시 - 차트 
    public List<ResultChartVO> getRiverMainChart(MainChartVO mainChartVO) {
    	
    	List<ResultChartVO> ret = null;
    	if(mainChartVO.getSysKind().equals("T"))
    	{
    		ret = list("situationctlDAO.getRiverMainChartTMS", mainChartVO);
    	}
    	else
    	{
    		ret = list("situationctlDAO.getRiverMainChart", mainChartVO);
    	}
    	
    	/*return list("situationctlDAO.getRiverMainChart", mainChartVO);*/
    	
    	return ret;
    }
    
	// 수계별 통합감시 - 게이지 차트
    public ResultChartVO getRiverGaugeChart(MainChartVO mainChartVO) {
    	return (ResultChartVO)selectByPk("situationctlDAO.getRiverGaugeChart", mainChartVO);
    }
    
    // 통합감시 - 측정값 조회(세부팝업)
    public List<WatersysMntMainDetailTSVO> getWatersysMntMainDetail(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO) {
    	return list("situationctlDAO.getWatersysMntMainDetail", watersysMntMainDetailSearchTSVO);
    }

    // 통합감시 - 측정값 조회(세부팝업) 20140312 이광복 추가.
    public List<WatersysMntMainDetailTSVO> getWatersysMntMainDetail_all(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO) {
    	return list("situationctlDAO.getWatersysMntMainDetail_all", watersysMntMainDetailSearchTSVO);
    }
    
    // 2014-10-21 mypark 측정소별 감시 - 측정값 총 카운트 추가 
    public int getWatersysMntMainDetail_all_count(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO) {
    	return (Integer)getSqlMapClientTemplate().queryForObject("situationctlDAO.getWatersysMntMainDetail_all_count", watersysMntMainDetailSearchTSVO);
    }
    
    public List<WatersysMntMainDetailTSVO> getWatersysMntMainDetailGraph(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO) {
    	return list("situationctlDAO.getWatersysMntMainDetailGraph", watersysMntMainDetailSearchTSVO);
    }
    
    // 통합감시 - 측정값 모바일 조회(세부팝업)
    public List<WatersysMntMainDetailTSVO> getWaterMobilesysMntMainDetail(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO) {
    	return list("situationctlDAO.getWaterMobilesysMntMainDetail", watersysMntMainDetailSearchTSVO);
    }
    
    /**
     * Fact Law 조회
     * @param factLaw
     */
    public FactLawVO getFactLaw(FactLawVO factLaw)
    {
    	return (FactLawVO)selectByPk("situationctlDAO.getFactLaw", factLaw);
    }
    
	// 통합감시 하단 조류 예보
	public AlgaCastDataVO getRecentAlga()
	{
		return (AlgaCastDataVO)selectByPk("situationctlDAO.getRecentAlga", null);
	}
    
	/**
	 * 통합감시 하단 항공 감시
	 * @param algaCastDataVO
	 */	
	public AirMntDataVO getRecentAir()
	{
		return (AirMntDataVO)selectByPk("situationctlDAO.getRecentAir", null);
	} 	
	
	/**
	 * 다음(또는 이전) 공구코드를 가져옵니다. (isNext가 Y이면 다음공구 아니면 이전공구)
	 * @param factCode
	 * @return
	 */
	public WatersysMntMainDetailTSVO getNextFact(WatersysMntMainDetailSearchTSVO search)
	{
		return (WatersysMntMainDetailTSVO)selectByPk("situationctlDAO.getNextFact", search);
	}
	
	/**
	 * 다음(또는 이전) 공구코드를 가져옵니다. (isNext가 Y이면 다음공구 아니면 이전공구) IP_USN용
	 * @param factCode
	 * @return
	 */
	public WatersysMntMainDetailTSVO getNextFact_U(WatersysMntMainDetailSearchTSVO search)
	{
		return (WatersysMntMainDetailTSVO)selectByPk("situationctlDAO.getNextFact_U", search);
	}
	
	/***
	 * 수계별 통합감시용 
	 */
	public List<WatersysMntCoordVO> getWaterSysMnt_coord(SearchTaksuPopupVO searchTaksuPopupVO)
	{
		return list("situationctlDAO.getWaterSysMnt_coord", searchTaksuPopupVO);
	}
	
	/**
	 * 수계별 통합감시 좌표 수정
	 */
	public void updateWaterSysMnt_coord(WatersysMntCoordVO watersysMntCoordVO)
	{
		update("situationctlDAO.updateWaterSysMnt_coord", watersysMntCoordVO);
	}
	
	/**
	 * 공구 - 측정소의 위도, 경도 정보를 가져옵니다.
	 * @param factLocationVO
	 * @return
	 */
	public FactLocationVO getFactLocation(FactLocationVO factLocationVO)
	{
		return (FactLocationVO)selectByPk("situationctlDAO.getFactLocation", factLocationVO);
	}
	
	/**
	 * 자동측정망 실시간 감시 데이터 조회
	 */
	public List<AutoDataVO> getAutoData()
	{
		return list("situationctlDAO.getAutoData", null);
	}
	
	/**
	 * 자동측정망 실시간 감시 데이터 조회
	 */
	public List<AutoDataVO> getAutoInsertData(String time)
	{
		return list("situationctlDAO.getAutoInsertData", time);
	}
	
	
	// 소속기관 목록 조회
	public List<HashMap> getDepts() {
    	return list("situationctlDAO.getDepts", null);
    }
	
	//상위 댐 정보
	public SeqInfoVO getHighDamInfo(SeqInfoVO vo)
	{
		return (SeqInfoVO)selectByPk("situationctlDAO.getHighDamInfo", vo);
	}
	
	//하위 취 정수장 정보
	public SeqInfoVO getLowWaterDCCenter(SeqInfoVO vo)
	{
		return (SeqInfoVO)selectByPk("situationctlDAO.getLowWaterDCCenter", vo);
	}
	
	public List<WatersysMntMainDetailTSVO> IndexWaterSysMainDetail(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO){
		return list("situationctlDAO.IndexWaterSysMainDetail", watersysMntMainDetailSearchTSVO);
	}
}
