package daewooInfo.waterpolmnt.situationctl.service;

import java.util.HashMap;
import java.util.List;

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

/**
 * @author  hyun
 */
public interface SituationctlService {
	
	// 메인(로그인후) - 측정값 조회
	List<TaksuMainVO> getDetailRIVERMAIN(SearchTaksuMainVO searchTaksuMainVO) throws Exception;
	
    // 통합감시 - 통계표 조회	
	List<TotalMntMainTopTSVO> getTotalMntMainTopTS() throws Exception;
	
	// 통합감시 - 상세 정보 조회
	List<TotalMntSummaryVO> getTotalMntSummary(TotalMntMainSearchTSVO totalMntMainSearchTSVO) throws Exception;	
	
	// 통합감시 - 측정값 조회(전체)	
	List<TotalMntMainVO> getTotalMntMain(TotalMntMainSearchVO totalMntMainSearchVO) throws Exception;

	// 통합감시 - 측정값 조회(한강)	
	List<TotalMntMainVO> getTotalMntMainR01(TotalMntMainSearchVO totalMntMainSearchVO) throws Exception;
	
	// 통합감시 - 측정값 조회(금강)	
	List<TotalMntMainVO> getTotalMntMainR03(TotalMntMainSearchVO totalMntMainSearchVO) throws Exception;

	// 통합감시 - 측정값 조회(낙동강)	
	List<TotalMntMainVO> getTotalMntMainR02(TotalMntMainSearchVO totalMntMainSearchVO) throws Exception;

	// 통합감시 - 측정값 조회(영산강)	
	List<TotalMntMainVO> getTotalMntMainR04(TotalMntMainSearchVO totalMntMainSearchVO) throws Exception;

	// 통합감시 - 측정값 조회(세부팝업)
	List<TotalMntMainDetailTSVO> getTotalMntMainDetailTS(TotalMntMainDetailSearchTSVO totalMntMainDetailSearchTSVO) throws Exception;

	List<TotalMntMainDetailTSVO> getTotalMntMainDetailTSGraph(TotalMntMainDetailSearchTSVO totalMntMainDetailSearchTSVO) throws Exception;

	List<TotalMntMainDetailTSVO> getTotalMntMainDetailTSGraph_compare(TotalMntMainDetailSearchTSVO totalMntMainDetailSearchTSVO) throws Exception;
	
	// 통합감시 - 측정값 조회(세부팝업-상황전파자)
	List<AlertTargetVO> getAlertTargetList(AlertTargetVO alertTargetVO) throws Exception;
	
	// 통합감시 - 측정값 조회(세부팝업-그래프)
	List<ResultChartVO> getTotalMntGraph(TotalMntMainSearchTSVO totalMntMainSearchTSVO) throws Exception;
	// 통합감시 - 측정값 조회(세부팝업-그래프)
	List<ResultChartVO> getTotalMntGraph2(TotalMntMainSearchTSVO totalMntMainSearchTSVO) throws Exception;
	
	// 통합감시 - 선택한 측정값 조회(세부팝업-그래프)
		List<ResultChartVO> getSelectTotalMntGraph2(TotalMntMainSearchTSVO totalMntMainSearchTSVO) throws Exception;
		
	List<ResultChartVO> getSelectMultiTotalMntGraph2(TotalMntMainSearchTSVO totalMntMainSearchTSVO) throws Exception;	

	// 통합감시 - 미수신 정보 조회
	List<TotalMntNorecvTSVO> getTotalMntNorecv(TotalMntNorecvSearchTSVO totalMntNorecvSearchTSVO) throws Exception;	

	// 수계별 통합감시 - 통계표 조회
	List<TaksuTopDataVO> getTopDataTAKSU(SearchTaksuSumDataVO searchTaksuSumDataVO) throws Exception;

	// 수계별 통합감시 - 측정값 조회	
	List<TaksuPopupVO> getWATERSYSMNT(SearchTaksuPopupVO searchTaksuPopupVO) throws Exception;
	
	// 선택좌표 - 측정값 조회	
	List<TaksuPopupVO> getSelectWATERSYSMNT(SearchTaksuPopupVO searchTaksuPopupVO) throws Exception;
	
	// 선택좌표 - 측정값 조회	
	List<DetailViewVO> getAllDetailViewDISCHARGE(SearchTaksuPopupVO searchTaksuPopupVO) throws Exception;
	
	// 선택좌표 - 측정값 조회	
	List<BoSearchVO> getAllDetailViewBO(SearchTaksuPopupVO searchTaksuPopupVO) throws Exception;
	
	// 선택좌표 - 측정값 조회	
	List<DamViewVO> getAllDetailViewDAM(SearchTaksuPopupVO searchTaksuPopupVO) throws Exception;
	
	// 선택좌표 - 측정값 조회	
	List<WareHouseSearchVO> getAllDetailViewWAREHOUSE(SearchTaksuPopupVO searchTaksuPopupVO) throws Exception;

	// 통합감시 - 차트 
	List<ResultChartVO> getRiverMainChart(MainChartVO mainChartVO) throws Exception;

	// 수계별 통합감시 - 게이지 차트 
    public ResultChartVO getRiverGaugeChart(MainChartVO mainChartVO) throws Exception;
    
	// 수계별 통합감시 - 측정값 조회(세부팝업)
	List<WatersysMntMainDetailTSVO> getWatersysMntMainDetail(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO) throws Exception;

	// 수계별 통합감시 - 측정값 조회(세부팝업)
	List<WatersysMntMainDetailTSVO> getWatersysMntMainDetail_all(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO) throws Exception;
	
	// 수계별 통합감시 - 측정값 총 카운트 조회
	int getWatersysMntMainDetail_all_count(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO) throws Exception;
	
	// 수계별 통합감시 - 측정값 조회(세부팝업)
	List<WatersysMntMainDetailTSVO> getWatersysMntMainDetailGraph(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO) throws Exception;
	
	// 수계별 통합감시 - 측정값 모바일 조회(세부팝업)
	List<WatersysMntMainDetailTSVO> getWaterMobilesysMntMainDetail(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO) throws Exception;
	
	// FactLaw 조회
	FactLawVO getFactLaw(FactLawVO factLaw);
	
	// 통합감시 하단 조류 예보
	/**
	 * @uml.property  name="recentAlga"
	 * @uml.associationEnd  
	 */
	AlgaCastDataVO getRecentAlga() throws Exception;
	
	// 통합감시 하단 항공 감시
	/**
	 * @uml.property  name="recentAir"
	 * @uml.associationEnd  
	 */
	AirMntDataVO getRecentAir() throws Exception;	
	
	//다음 또는 이전 공구 코드 가져오기
	WatersysMntMainDetailTSVO getNextFact(WatersysMntMainDetailSearchTSVO search) throws Exception;
	
	//다음 또는 이전 공구 코드 가져오기(IP-USN용)
	WatersysMntMainDetailTSVO getNextFact_U(WatersysMntMainDetailSearchTSVO search) throws Exception;
	
	/***
	 * 수계별 통합감시용 
	 */
	public List<WatersysMntCoordVO> getWaterSysMnt_coord(SearchTaksuPopupVO searchTaksuPopupVO) throws Exception;
	
	public void updateWaterSysMnt_coord(WatersysMntCoordVO watersysMntCoordVO) throws Exception;
	
	/**
	 * Fact - branch 의 위도, 경도 정보
	 */
	public FactLocationVO getFactLocation(FactLocationVO factLocationVO) throws Exception;
	
	/**
	 * 자동측정망 실시간 데이터 조회
	 */
	public List<AutoDataVO> getAutoData() throws Exception;
	
	/**
	 * 자동측정망 실시간 데이터 조회
	 */
	public List<AutoDataVO> getAutoInsertData(String time) throws Exception;
	
	// 소속기관 목록 조회
	public List<HashMap> getDepts() throws Exception;
	
	//상위 댐 정보
	public SeqInfoVO getHighDamInfo(SeqInfoVO vo) throws Exception;
	
	//하위 취 정수장 정보
	public SeqInfoVO getLowWaterDCCenter(SeqInfoVO vo) throws Exception;
	
	// 수계별 통합감시 - 측정값 조회(세부팝업)
	List<WatersysMntMainDetailTSVO> IndexWaterSysMainDetail(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO) throws Exception;
}
