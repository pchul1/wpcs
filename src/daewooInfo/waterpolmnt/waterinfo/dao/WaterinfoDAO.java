package daewooInfo.waterpolmnt.waterinfo.dao;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Repository;

import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.mobile.com.utl.LogInfoUtil;
import daewooInfo.warehouse.bean.WareHouseVO;
import daewooInfo.waterpolmnt.waterinfo.bean.AirMntDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.AlgaCastDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.BoSearchVO;
import daewooInfo.waterpolmnt.waterinfo.bean.CmnSearchVO;
import daewooInfo.waterpolmnt.waterinfo.bean.DamDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.DetailViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.EcompanyDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.EcompayOwnItemDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.ExcelModelingVO;
import daewooInfo.waterpolmnt.waterinfo.bean.FactoryIndustViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.FlowDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.LimitDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.LimitViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.LocationVO;
import daewooInfo.waterpolmnt.waterinfo.bean.RelateOfficeDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.RiverWater3HourWarningSearchVO;
import daewooInfo.waterpolmnt.waterinfo.bean.RiverWater3HourWarningVO;
import daewooInfo.waterpolmnt.waterinfo.bean.SearchTaksuVO;
import daewooInfo.waterpolmnt.waterinfo.bean.SelectDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.SumViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.TaksuVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("waterinfoDAO")
public class WaterinfoDAO extends EgovAbstractDAO{

	// 공구 목록 조회
	public List<HashMap> getSystemList(HttpServletRequest request) throws Exception {
		HashMap paraMap = new HashMap();
		paraMap.put("id", LogInfoUtil.GetSessionLogin().getId());
		paraMap.put("roleCode", LogInfoUtil.GetSessionLogin().getRoleCode());
		return list("waterinfoDAO.getSystemList", paraMap);
	}
	
	// 수계 목록 조회
	public List<HashMap> getSugyeList(HttpServletRequest request, String system) throws Exception {
		HashMap paraMap = new HashMap();
		paraMap.put("system", system);
		paraMap.put("id", LogInfoUtil.GetSessionLogin().getId());
		paraMap.put("roleCode", LogInfoUtil.GetSessionLogin().getRoleCode());
		return list("waterinfoDAO.getSugyeListMain", paraMap);
	}
	public List<HashMap> getSugyeList(String userId, String system, String userGubun) {
		HashMap paraMap = new HashMap();
		paraMap.put("userId", userId);
		paraMap.put("system", system);
		paraMap.put("userGubun", userGubun);
		return list("waterinfoDAO.getSugyeList", paraMap);
	}
	
	// 공구 목록 조회
	public List<HashMap> getGongkuList(HttpServletRequest request, String system, String sugye) throws Exception {
		HashMap paraMap = new HashMap();
		paraMap.put("system", system);
		paraMap.put("sugye", sugye);
		try{ 
			paraMap.put("id", LogInfoUtil.GetSessionLogin().getId());
			paraMap.put("roleCode", LogInfoUtil.GetSessionLogin().getRoleCode());
		}catch(Exception e){}
		return list("waterinfoDAO.getGongkuListNew", paraMap);
	}
	
	// 방류수질 측정소 조회
	public List<HashMap> getTMSList(HttpServletRequest request, String sugye) throws Exception 
	{
		HashMap paraMap = new HashMap();
		paraMap.put("sugye", sugye);
		paraMap.put("id", LogInfoUtil.GetSessionLogin().getId());
		paraMap.put("roleCode", LogInfoUtil.GetSessionLogin().getRoleCode());
		return list("waterinfoDAO.getTMSList", paraMap);
	}
	
	// 공구 목록 조회
	public List<HashMap> getGongkuList(String system, String sugye, String userGubun, String userId) {
		HashMap paraMap = new HashMap();
		paraMap.put("system", system);
		paraMap.put("sugye", sugye);
		paraMap.put("userGubun", userGubun);
		paraMap.put("userId", userId);
		return list("waterinfoDAO.getGongkuList", paraMap);
	}
	

	// 과학원 측정소 목록 조회 - 유량지점
	public List<HashMap> getFlowFact(String sugye) {
		HashMap paraMap = new HashMap();
		paraMap.put("sugye", sugye);
		return list("waterinfoDAO.getFlowFact", paraMap);
	}
	
	// 과학원 측정소 목록 조회 - 수위 지점
	public List<HashMap> getWLFact(String sugye) {
		HashMap paraMap = new HashMap();
		paraMap.put("sugye", sugye);
		return list("waterinfoDAO.getWLFact", paraMap);
	}
	
	// 과학원 측정소 목록 조회 - 댐 지점
	public List<HashMap> getDamFact(String sugye) {
		HashMap paraMap = new HashMap();
		paraMap.put("sugye", sugye);
		return list("waterinfoDAO.getDamFact", paraMap);
	}
	
	// 측정소 목록 조회
	public List<HashMap> getBranchList(String factCode) {
		HashMap paraMap = new HashMap();
		paraMap.put("factCode", factCode);
		return list("waterinfoDAO.getBranchList", paraMap);
	}
	
	public List<HashMap> getBranchListNew(String factCode, String userId) {
		HashMap paraMap = new HashMap();
		paraMap.put("factCode", factCode);
		paraMap.put("userId", userId);
		return list("waterinfoDAO.getBranchListNew", paraMap);
	}
	
	// 측정소 목록 조회
	public String getFactBranchCnt(String factCode) {
		HashMap paraMap = new HashMap();
		paraMap.put("factCode", factCode);
		return (String)selectByPk("waterinfoDAO.getFactBranchCnt", paraMap);
	}
	
	// 측정항목 목록 조회
	public List<HashMap> getItemList(String system, String sugye, String factCode, String branchNo) {
		HashMap paraMap = new HashMap();
		paraMap.put("system", system);
		paraMap.put("sugye", sugye);
		paraMap.put("factCode", factCode);
		paraMap.put("branchNo", branchNo);
		return list("waterinfoDAO.getItemList", paraMap);
	}
	
	// 측정항목 목록 조회
	public List<HashMap> getItemList2(String itemKind) {
		HashMap paraMap = new HashMap();
		paraMap.put("itemKind", itemKind);
		return list("waterinfoDAO.getItemList2", paraMap);
	}
	
	// 하천수질조회
	public List<TaksuVO> getDetailViewRIVER(SearchTaksuVO searchTaksuVO) {
		return list("waterinfoDAO.getDetailViewRIVER", searchTaksuVO);
	}
	
	//하천 수질 조회 검색전체 수
	public int getTotCntRiver_MIN(SearchTaksuVO searchTaksuVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getTotCntRiver_MIN", searchTaksuVO);
	}
	
	//하천 수질 조회 검색전체 수
	public int getTotCntRiver_HOUR(SearchTaksuVO searchTaksuVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getTotCntRiver_HOUR", searchTaksuVO);
	}
	
	//하천수질조회(시간자료)
	public List<DetailViewVO> getDetailViewRIVER_HOUR(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getDetailViewRIVER_HOUR", searchTaksuVO);
	}
	
	//하천수질조회(분자료)
	public List<DetailViewVO> getDetailViewRIVER_MIN(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getDetailViewRIVER_MIN", searchTaksuVO);
	}
	
	//하천수질조회_그래프&엑셀(시간자료)
	public List<DetailViewVO> getRiverGraph_HOUR(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getRiverGraph_HOUR", searchTaksuVO);
	}
	
	//하천수질조회_그래프&엑셀(분자료)
	public List<DetailViewVO> getRiverGraph_MIN(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getRiverGraph_MIN", searchTaksuVO);
	}
	public List<HashMap> getTMSListNew(String sugye, String userId, String userGubun)
	{
		HashMap paraMap = new HashMap();
		paraMap.put("sugye", sugye);
		paraMap.put("userId", userId);
		paraMap.put("userGubun", userGubun);
		return list("waterinfoDAO.getTMSListNew", paraMap);
	}
	
	// 방류수질 측정소 조회
	public List<HashMap> getTMSList2(String sugye, String tmsCtyCode)
	{
		HashMap paraMap = new HashMap();
		paraMap.put("sugye", sugye);
		paraMap.put("tmsCtyCode", tmsCtyCode);
		return list("waterinfoDAO.getTMSList2", paraMap);
	}
	
	// TMS 지천 목록 조회
	public List<HashMap> getTMSRiverD1List()
	{
		HashMap paraMap = new HashMap();
		return list("waterinfoDAO.getTMSRiverD1List", paraMap);
	}
	
	// TMS 지천 목록 조회
	public List<HashMap> getTMSRiverD2List(String sugye)
	{
		HashMap paraMap = new HashMap();
		paraMap.put("sugye", sugye);
		return list("waterinfoDAO.getTMSRiverD2List", paraMap);
	}
	
	// 방류수질 방류구 조회
	public List<HashMap> getWastList(String factCode)
	{
		HashMap paraMap = new HashMap();
		paraMap.put("factCode", factCode);
		return list("waterinfoDAO.getWastList", paraMap);
	}
	
	// 방류수 수질조회
	public List<TaksuVO> getDetailViewDISCHARGE(SearchTaksuVO searchTaksuVO) {
		return list("waterinfoDAO.getDetailViewDISCHARGE", searchTaksuVO);
	}
	
	//방류수 수질 조회 검색전체 수
	public int getTotCntDischarge_MIN(SearchTaksuVO searchTaksuVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getTotCntDischarge_MIN", searchTaksuVO);
	}
	
	//방류수 수질 조회 검색전체 수
	public int getTotCntDischarge_HOUR(SearchTaksuVO searchTaksuVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getTotCntDischarge_HOUR", searchTaksuVO);
	}
	
	//방류수 수질 조회(시간자료)
	public List<DetailViewVO> getDetailViewDISCHARGE_HOUR(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getDetailViewDISCHARGE_HOUR", searchTaksuVO);
	}
	
	//방류수 수질조회(분자료)
	public List<DetailViewVO> getDetailViewDISCHARGE_MIN(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getDetailViewDISCHARGE_MIN", searchTaksuVO);
	}
	
	//방류수 수질조회_그래프&엑셀(시간자료)
	public List<TaksuVO> getDischargeGraph_HOUR(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getDischargeGraph_HOUR", searchTaksuVO);
	}
	
	//방류수 수질조회_그래프&엑셀(분자료)
	public List<TaksuVO> getDischargeGraph_MIN(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getDischargeGraph_MIN", searchTaksuVO);
	}
	
	//유량 조회
	public List<FlowDataVO> getFlowData(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getFlowData", searchTaksuVO);
	}

	//유량조회 조회 레코드 수
	public int getFlowData_cnt(SearchTaksuVO searchTaksuVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getFlowData_cnt", searchTaksuVO);
	}
	
	//유량조회 측정소별 하루 데이터 그래프
	public List<FlowDataVO> getFlowData_chart(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getFlowData_chart", searchTaksuVO);
	}
	
	//유량조회 그래프 팝업
	public List<FlowDataVO> getFlowData_chartpopup(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getFlowData_chartpopup", searchTaksuVO);
	}
	
	//유량조회 측정소 위치
	public LocationVO getFlowFactLocation(SearchTaksuVO searchTaksuVO)
	{
		return (LocationVO)selectByPk("waterinfoDAO.getFlowFactLocation", searchTaksuVO);
	}
	
	//수위 조회
	public List<FlowDataVO> getWLData(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getWLData", searchTaksuVO);
	}

	//수위 조회 조회 레코드 수
	public int getWLData_cnt(SearchTaksuVO searchTaksuVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getWLData_cnt", searchTaksuVO);
	}
	
	//수위조회 측정소별 하루 데이터 그래프
	public List<FlowDataVO> getWLData_chart(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getWLData_chart", searchTaksuVO);
	}
	
	//수위 그래프 팝업
	public List<FlowDataVO> getWLData_chartpopup(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getWLData_chartpopup", searchTaksuVO);
	}
	
	//수위조회 측정소 위치
	public LocationVO getWLFactLocation(SearchTaksuVO searchTaksuVO)
	{
		return (LocationVO)selectByPk("waterinfoDAO.getWLFactLocation", searchTaksuVO);
	}
	
	
	//댐 조회
	public List<DamDataVO> getDamData(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getDamData", searchTaksuVO);
	}

	//댐  조회 조회 레코드 수
	public int getDamData_cnt(SearchTaksuVO searchTaksuVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getDamData_cnt", searchTaksuVO);
	}
	
	//댐 측정소별 하루 데이터 그래프
	public List<DamDataVO> getDamData_chart(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getDamData_chart", searchTaksuVO);
	}
	
	//댐 그래프 팝업
	public List<DamDataVO> getDamData_chartpopup(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getDamData_chartpopup", searchTaksuVO);
	}
	
	//댐 측정소 위치
	public LocationVO getDamFactLocation(SearchTaksuVO searchTaksuVO)
	{
		return (LocationVO)selectByPk("waterinfoDAO.getDamFactLocation", searchTaksuVO);
	}
	
	
	/**
	 * 조류예보 목록 조회
	 * @param algaDataVO
	 * @return
	 */
	public List<AlgaCastDataVO> getAlgaCastList(AlgaCastDataVO algaDataVO)
	{
		return list("waterinfoDAO.getAlgaCastList", algaDataVO);
	}
	
	/**
	 * 조류예보 리스트 검색 총 조회수
	 * @param riverWater3HourWarningSearchVO
	 * @return
	 */
	public int getAlgaCastList_cnt(AlgaCastDataVO algaDataVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getAlgaCastList_cnt", algaDataVO);
	}
	
	/**
	 * 조류예보 초기 조회
	 */
	public List<AlgaCastDataVO> getAlgaCastFirst(String river_div)
	{
		HashMap paraMap = new HashMap();
		paraMap.put("river_div", river_div);
		return list("waterinfoDAO.getAlgaCastFirst", paraMap);
	}
	
	
	/**
	 * 조류예보 상세정보 조회
	 * @param cast_num
	 * @return
	 */
	public AlgaCastDataVO getAlgaCast(String cast_num)
	{
		return (AlgaCastDataVO)selectByPk("waterinfoDAO.getAlgaCast", cast_num);
	}
	
	/**
	 * 조류예보 삭제
	 * @param cast_num
	 */
	public void deleteAlgaCast(String cast_num)
	{
		update("waterinfoDAO.deleteAlgaCast", cast_num);
	}
	
	/**
	 * 조류예보 업데이트
	 * @param algaCastData
	 */
	public void updateAlgaCast(AlgaCastDataVO algaCastData)
	{
		update("waterinfoDAO.updateAlgaCast", algaCastData);
	}
	
	
	/**
	 * 항공감시 리스트 조회
	 * @param airMntData
	 * @return
	 */
	public List<AirMntDataVO> getAirMntList(AirMntDataVO airMntData)
	{
		return list("waterinfoDAO.getAirMntList", airMntData);
	}
	
	/**
	 * 항공감시 리스트 검색 총 조회수
	 * @param riverWater3HourWarningSearchVO
	 * @return
	 */
	public int getAirMntList_cnt(AirMntDataVO airMntData)
	{
		return (Integer)selectByPk("waterinfoDAO.getAirMntList_cnt", airMntData);
	}
	
	public AirMntDataVO getAirMnt(String obv_num)
	{
		return (AirMntDataVO)selectByPk("waterinfoDAO.getAirMnt", obv_num);
	}
	
	/**
	 * 항공감시 초기 조회
	 */
	public List<AirMntDataVO> getAirMntFirst(String sugye)
	{
		HashMap paraMap = new HashMap();
		paraMap.put("sugye", sugye);
		return list("waterinfoDAO.getAirMntFirst", paraMap);
	}

	/**
	 * 항공감시삭제
	 * @param obv_num
	 */
	public void deleteAirMnt(String obv_num)
	{
		update("waterinfoDAO.deleteAirMnt", obv_num);
	}
	
	/**
	 * 항공감시 업데이트
	 * @param airMntData
	 */
	public void updateAirMnt(AirMntDataVO airMntData)
	{
		update("waterinfoDAO.updateAirMnt", airMntData);
	}
	
	// 하천수질조회(경보 3시간이상)
	public List<RiverWater3HourWarningVO> getRiverWater3HourWarning(RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO) {
		return list("waterinfoDAO.getRiverWater3HourWarning", riverWater3HourWarningSearchVO);
	}
	
	// 하천수질조회(경보 3시간이상) 엑셀
	public List<RiverWater3HourWarningVO> getRiverWater3HourWarningExcel(RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO) {
		return list("waterinfoDAO.getRiverWater3HourWarningExcel", riverWater3HourWarningSearchVO);
	}
	
	//하천수질조회(경보 3시간이상) 전체검색수
	public int getRiverWarning_cnt(RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getRiverWarning_cnt", riverWater3HourWarningSearchVO);
	}
	
	//하천수질조회(경보 3시간이상)_그래프&엑셀(시간자료)
	public List<RiverWater3HourWarningVO> getChartWaning(RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO)
	{
		return list("waterinfoDAO.getChartWarning", riverWater3HourWarningSearchVO);
	}
	
	// 하천수질조회(경보 3시간이상)- 세부조회
	public List<RiverWater3HourWarningVO> getRiverWater3HourWarningPopDetail(RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO) {
		return list("waterinfoDAO.getRiverWater3HourWarningPopDetail", riverWater3HourWarningSearchVO);
	}
	
	//국가수질자동측정망 유효데이터 입력
	public void insertValidData(DetailViewVO detailViewVO) throws Exception
	{
		insert("waterinfoDAO.insertValidData", detailViewVO);
	}
	
	public List<String> getValidItemSeq(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getValidItemSeq", searchTaksuVO);
	}
	
	/**
	 * 공구 위치 조회
	 * @param searchTaksuVO
	 * @return
	 */
	public LocationVO getFactLocation(SearchTaksuVO searchTaksuVO)
	{
		return (LocationVO)selectByPk("waterinfoDAO.getFactLocation", searchTaksuVO);
	}
	
	//측정소 이름
	public SearchTaksuVO getBranchName(SearchTaksuVO searchTaksuVO)
	{
		return (SearchTaksuVO)selectByPk("waterinfoDAO.getBranchName", searchTaksuVO);
	}
	
	//유량측정소 이름
	public SearchTaksuVO getFlowOBSName(SearchTaksuVO searchTaksuVO)
	{
		return (SearchTaksuVO)selectByPk("waterinfoDAO.getFlowOBSName", searchTaksuVO);
	}

	@SuppressWarnings("unchecked")
	public List getBoObsCdList(String sugye) {
		HashMap paraMap = new HashMap();
		paraMap.put("sugye", sugye);
		return list("waterinfoDAO.getBoObsCdList", paraMap);
	}

	@SuppressWarnings("unchecked")
	public List getBoManageList_HOUR(BoSearchVO searchVO) {
		return list("waterinfoDAO.getBoManageList_HOUR", searchVO);
	}

	@SuppressWarnings("unchecked")
	public List getBoManageList_MIN(BoSearchVO searchVO) {
		return list("waterinfoDAO.getBoManageList_MIN", searchVO);
	}

	public int getBoManageListCnt_HOUR(BoSearchVO searchVO) {
		return (Integer)selectByPk("waterinfoDAO.getBoManageListCnt_HOUR", searchVO);
	}

	public int getBoManageListCnt_MIN(BoSearchVO searchVO) {
		return (Integer)selectByPk("waterinfoDAO.getBoManageListCnt_MIN", searchVO);
	}   
	
	// 조류측정 정보 조회 리스트 
	public List getAlgacastAutoList(SearchTaksuVO searchTaksuVO) {
		return list("waterinfoDAO.getAlgacastAutoList", searchTaksuVO);
	}
	
	// 조류 측정 정보 조회 수량 
	public int getAlgacastAutoCnt(SearchTaksuVO searchTaksuVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getAlgacastAutoCnt", searchTaksuVO);
	}
	
	// 점오염원 정보 조회 리스트 
	public List getFactoryIndustList(CmnSearchVO cmnSearchVO) {
		return list("waterinfoDAO.getFactoryIndustList", cmnSearchVO);
	}
	
	// 점오염원 정보 조회 수량 
	public int getFactoryIndustListCnt(CmnSearchVO cmnSearchVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getFactoryIndustListCnt", cmnSearchVO);
	}
	
	// 단일 점오염원 상세조회 리스트 
	public List getFactoryIndustIdList(CmnSearchVO cmnSearchVO) {
		return list("waterinfoDAO.getFactoryIndustIdList", cmnSearchVO);
	}
	
	// 점오염원 사업장규모별 조회 리스트
	public List getFactoryIndustSizeList(CmnSearchVO cmnSearchVO) {
		return list("waterinfoDAO.getFactoryIndustSizeList", cmnSearchVO);
	}
	
	// 점오염원 사업장규모별 및 오염물질별 합계 리스트
	public List getFactoryIndustSizeSpecCnt(CmnSearchVO cmnSearchVO) {
		return list("waterinfoDAO.getFactoryIndustSizeSpecCnt", cmnSearchVO);
	}
	
	// 점오염원 오염물질별 조회 리스트
	public List getFactoryIndustSpecList(CmnSearchVO cmnSearchVO) {
		return list("waterinfoDAO.getFactoryIndustSpecList", cmnSearchVO);
	}
	
	// 대권 유역 정보조회 리스트
	public List getBasinLargeList(CmnSearchVO cmnSearchVO) {
		return list("waterinfoDAO.getBasinLargeList", cmnSearchVO);
	}
	
	// 중권 유역 정보조회 리스트
	public List getBasinMiddleList(CmnSearchVO cmnSearchVO) {
		return list("waterinfoDAO.getBasinMiddleList", cmnSearchVO);
	}
	
	// 점오염원 사업소 id 중복 체크
	public int duplicateFacId(FactoryIndustViewVO factoryIndustViewVO) throws Exception {
		return (Integer)selectByPk("waterinfoDAO.duplicateFacId", factoryIndustViewVO);
	}
	
	// 점오염원 사업소 등록
	public void insertFactoryIndust(FactoryIndustViewVO factoryIndustViewVO) throws Exception
	{
		insert("waterinfoDAO.insertFactoryIndust", factoryIndustViewVO);
	}
	
	// 점오염원 사업소 size 등록
	public void insertFactoryIndustSize(FactoryIndustViewVO factoryIndustViewVO) throws Exception
	{
		insert("waterinfoDAO.insertFactoryIndustSize", factoryIndustViewVO);
	}
	
	// 점오염원 사업소 spec 등록
	public void insertFactoryIndustSpec(FactoryIndustViewVO factoryIndustViewVO) throws Exception
	{
		insert("waterinfoDAO.insertFactoryIndustSpec", factoryIndustViewVO);
	}
	
	// 점오염원 사업소 cnt 등록
	public void insertFactoryIndustCnt(FactoryIndustViewVO factoryIndustViewVO) throws Exception
	{
		insert("waterinfoDAO.insertFactoryIndustCnt", factoryIndustViewVO);
	}
	
	// 점오염원 사업소 수정
	public void updatFactoryIndust(FactoryIndustViewVO factoryIndustViewVO)
	{
		update("waterinfoDAO.updatFactoryIndust", factoryIndustViewVO);
	}
	
	// 점오염원 사업소 삭제
	public int deleteFactoryIndust(CmnSearchVO cmnSearchVO)
	{
		return (Integer)update("waterinfoDAO.deleteFactoryIndust", cmnSearchVO);
	}
	
	// 점오염원  사업소별size 측정값 수정
	public void updateFactoryIndustSize(FactoryIndustViewVO factoryIndustViewVO)
	{
		update("waterinfoDAO.updateFactoryIndustSize", factoryIndustViewVO);
	}
	
	// 점오염원  사업소별spec 측정값 수정
	public void updateFactoryIndustSpec(FactoryIndustViewVO factoryIndustViewVO)
	{
		update("waterinfoDAO.updateFactoryIndustSpec", factoryIndustViewVO);
	}
	
	// 점오염원  사업소별cnt 측정값 수정
	public void updateFactoryIndustCnt(FactoryIndustViewVO factoryIndustViewVO)
	{
		update("waterinfoDAO.updateFactoryIndustCnt", factoryIndustViewVO);
	}
	
	// 취정수장 정보 조회 리스트 
	public List getWaterDcCenterList(CmnSearchVO cmnSearchVO) {
		return list("waterinfoDAO.getWaterDcCenterList", cmnSearchVO);
	}
	
	// 취정수장 정보 조회 수량 
	public int getWaterDcCenterListCnt(CmnSearchVO cmnSearchVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getWaterDcCenterListCnt", cmnSearchVO);
	}
	
	// 보 정보 조회 리스트 
	public List getBoObsInfoList(CmnSearchVO cmnSearchVO) {
		return list("waterinfoDAO.getBoObsInfoList", cmnSearchVO);
	}
	
	// 보 정보 조회 수량 
	public int getBoObsInfoListCnt(CmnSearchVO cmnSearchVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getBoObsInfoListCnt", cmnSearchVO);
	}
	
	// 댐 정보 조회 리스트 
	public List getDamList(CmnSearchVO cmnSearchVO) {
		return list("waterinfoDAO.getDamList", cmnSearchVO);
	}
	
	// 댐 정보 조회 수량 
	public int getDamListCnt(CmnSearchVO cmnSearchVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getDamListCnt", cmnSearchVO);
	}
	
	// 유관기관 정보 조회 리스트 
	public List getRelOffList(CmnSearchVO cmnSearchVO) {
		return list("waterinfoDAO.getRelOffList", cmnSearchVO);
	}
	
	// 유관기관 정보 조회 수량 
	public int getRelOffListCnt(CmnSearchVO cmnSearchVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getRelOffListCnt", cmnSearchVO);
	}
	
	// 단일 점오염원 상세조회 리스트 
	public List getRelOffDetailList(CmnSearchVO cmnSearchVO) {
		return list("waterinfoDAO.getRelOffDetailList", cmnSearchVO);
	}
	
	// 유관기관 id 중복 체크
	public int duplicateRelOffId(RelateOfficeDataVO elateOfficeDataVO) throws Exception {
		return (Integer)selectByPk("waterinfoDAO.duplicateRelOffId", elateOfficeDataVO);
	}
	
	// 유관기관 등록
	public void insertRelOff(RelateOfficeDataVO relateOfficeDataVO) throws Exception
	{
		insert("waterinfoDAO.insertRelOff", relateOfficeDataVO);
	}
	 
	// 유관기관 수정
	public void updatRelOff(RelateOfficeDataVO relateOfficeDataVO)
	{
		update("waterinfoDAO.updatRelOff", relateOfficeDataVO);
	}
	
	// 유관기관 삭제
	public int deleteRelOff(CmnSearchVO cmnSearchVO)
	{
		return (Integer)update("waterinfoDAO.deleteRelOff", cmnSearchVO);
	}
	
	// 특별시/동 조회
	public List getDoCodeList(CmnSearchVO cmnSearchVO) {
		return list("waterinfoDAO.getDoCodeList", cmnSearchVO);
	}
	
//	// 시군구 조회
	public List getCtyCodeList(CmnSearchVO cmnSearchVO) {
		return list("waterinfoDAO.getCtyCodeList", cmnSearchVO);
	}
	
	// 방제업체 목록 조회
	public List getEcompanyList(CmnSearchVO cmnSearchVO) {
		return list("waterinfoDAO.getEcompanyList", cmnSearchVO);
	}
	
	// 방제업체 수량
	public int getEcompanyListCnt(CmnSearchVO cmnSearchVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getEcompanyListCnt", cmnSearchVO);
	}
	
	// 단일 방제업체 상세조회 리스트 
	public List getEcompanyDetailList(CmnSearchVO cmnSearchVO) {
		return list("waterinfoDAO.getEcompanyDetailList", cmnSearchVO);
	}
	
	// 방제업체 id 중복 체크
	public int duplicateEcoId(EcompanyDataVO ecompanyDataVO) throws Exception {
		return (Integer)selectByPk("waterinfoDAO.duplicateEcoId", ecompanyDataVO);
	}
	
	// 방제업체 등록
	public void insertEcompany(EcompanyDataVO ecompanyDataVO) throws Exception
	{
		insert("waterinfoDAO.insertEcompany", ecompanyDataVO);
	}
	 
	// 방제업체 수정
	public void updatEcompany(EcompanyDataVO ecompanyDataVO)
	{
		update("waterinfoDAO.updatEcompany", ecompanyDataVO);
	}
	
	// 방제업체 삭제
	public int deleteEcompany(CmnSearchVO cmnSearchVO)
	{
		return (Integer)update("waterinfoDAO.deleteEcompany", cmnSearchVO);
	}
	// 방제물품 조회
	public List getEcompanyOwnItemList(CmnSearchVO cmnSearchVO) {
		return list("waterinfoDAO.getEcompanyOwnItemList", cmnSearchVO);
	}
	
	// 방제업체 수량
	public int getEcompanyOwnItemListCnt(CmnSearchVO cmnSearchVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getEcompanyOwnItemListCnt", cmnSearchVO);
	}
	
	// 방제물품 추가
	public void insertEcompanyOwnItem(EcompayOwnItemDataVO ecompayOwnItemDataVO) throws Exception
	{
		insert("waterinfoDAO.insertEcompanyOwnItem", ecompayOwnItemDataVO);
	}
	
	// 방제물품 삭제
	public int deleteEcompanyOwnItem(EcompayOwnItemDataVO ecompayOwnItemDataVO)
	{
		return (Integer)update("waterinfoDAO.deleteFactoryIndust", ecompayOwnItemDataVO);
	}
	
	// 측정소 기준치 조회 (IP-USN)
	public List<LimitDataVO> getDetailViewLIMIT_U(LimitDataVO limitDataVO)
	{
		return list("waterinfoDAO.getDetailViewLIMIT_U", limitDataVO);
	}

	// 측정소 기준치 조회 (국가수질측정망)
	public List<LimitDataVO> getDetailViewLIMIT_A(LimitDataVO limitDataVO)
	{
		return list("waterinfoDAO.getDetailViewLIMIT_A", limitDataVO);
	}
	
	// 방제물품 삭제
	public void deleteDetailViewLIMIT(LimitDataVO limitDataVO) throws Exception
	{
		update("waterinfoDAO.deleteDetailViewLIMIT", limitDataVO);
	}
	
	// 측정소 기준치 적용 (수질측정망 -> IP-USN)
	public void insertDetailViewLIMIT(LimitDataVO limitDataVO) throws Exception
	{
		insert("waterinfoDAO.insertDetailViewLIMIT", limitDataVO);
	}
	
	// 측정소 기준치 수정 (IP-USN)
	public void updateDetailViewLIMIT(LimitDataVO limitDataVO) throws Exception
	{
		update("waterinfoDAO.updateDetailViewLIMIT", limitDataVO);
	}
	
	// 측정소 데이터 선별 조회 (IP-USN)
	public List<LimitViewVO> getSelectDataList(SelectDataVO selectDataVO)
	{
		return list("waterinfoDAO.getSelectDataList", selectDataVO);
	}
	
	// 측정소 데이터 선별 조회 (IP-USN)_전체
	public List<LimitViewVO> getSelectDataListAll(SelectDataVO selectDataVO)
	{
		return list("waterinfoDAO.getSelectDataListAll", selectDataVO);
	}
	
	// 측정소 데이터 선별 검색 레코드 수 (IP-USN)
	public int getSelectDataCnt(SelectDataVO selectDataVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getSelectDataCnt", selectDataVO);
	}
	
	// 측정소 데이터 기준치설정정보 레코드 수 (IP-USN)
	public int getStandardInfoCnt(SelectDataVO selectDataVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getStandardInfoCnt", selectDataVO);
	}
	
	// 측정소 데이터 선별 검색 선별 최종일 (IP-USN)
	public String getSelectDataMaxDate(SelectDataVO selectDataVO)
	{
		return (String)selectByPk("waterinfoDAO.getSelectDataMaxDate", selectDataVO);
	}
	
	// 데이터 선별 seq 조회
	public int selectSelSeq(SelectDataVO selectDataVO)
	{
		return (Integer)selectByPk("waterinfoDAO.selectSelSeq", selectDataVO);
	}
	
	// 데이터 선별 등록
	public void saveSelectData(SelectDataVO selectDataVO) throws Exception
	{
		insert("waterinfoDAO.saveSelectData", selectDataVO);
	}
	
	// 데이터 선별 측정 등록 (항목별)
	public void saveSelectDataItem(SelectDataVO selectDataVO) throws Exception
	{
		insert("waterinfoDAO.saveSelectDataItem", selectDataVO);
	}
	
	// 데이터 선별 상세 조회
	public SelectDataVO getDetailSelectData(SelectDataVO selectDataVO)
	{
		return (SelectDataVO)selectByPk("waterinfoDAO.getDetailSelectData", selectDataVO);
	}
	
	// 데이터 선별 선별사유 조회
	public SelectDataVO getSelectDataReason(SelectDataVO selectDataVO)
	{
		return (SelectDataVO)selectByPk("waterinfoDAO.getSelectDataReason", selectDataVO);
	}
	
	// 데이터 선별 상세 삭제
	public void deleteSelectData(SelectDataVO selectDataVO) throws Exception
	{
		update("waterinfoDAO.deleteSelectData", selectDataVO);
	}

	// 데이터 선별 상세 초기화
	public void deleteSelectDataAll(SelectDataVO selectDataVO) throws Exception
	{
		update("waterinfoDAO.deleteSelectDataAll", selectDataVO);
	}
	
	// 데이터 선별 갯수 체크
	public int getChkSelectData(SelectDataVO selectDataVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getChkSelectData", selectDataVO);
	}

	// 데이터 선별 갯수 체크
	public int getCntSelectData(SelectDataVO selectDataVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getCntSelectData", selectDataVO);
	}
	
	// 확정 히스토리 입력
	public void insertDefiniteHis(SelectDataVO selectDataVO) throws Exception
	{
		insert("waterinfoDAO.insertDefiniteHis", selectDataVO);
	}
	
	// 확정 데이터 입력 (Min)
	public void insertDefiniteData(SelectDataVO selectDataVO) throws Exception
	{
		insert("waterinfoDAO.insertDefiniteData", selectDataVO);
	}

	// 확정 데이터 입력 (Hour)
	public void insertDefiniteDataHour(SelectDataVO selectDataVO) throws Exception
	{
		insert("waterinfoDAO.insertDefiniteDataHour", selectDataVO);
	}
	
	// 선별/ 확정 데이터 입력
	public void saveSelectDataInfo(SelectDataVO selectDataVO) throws Exception
	{
		insert("waterinfoDAO.saveSelectDataInfo", selectDataVO);
	}
	
	// 선별/ 확정 데이터 입력
	public void updateSelectDataInfo(SelectDataVO selectDataVO) throws Exception
	{
		update("waterinfoDAO.updateSelectDataInfo", selectDataVO);
	}
	
	// 선별/ 확정 데이터 이력 입력
	public void saveSelectDataInfoHis(SelectDataVO selectDataVO) throws Exception
	{
		insert("waterinfoDAO.saveSelectDataInfoHis", selectDataVO);
	}
	
	// 측정소 수질 선별 이력 조회 (IP-USN)
	public List<SelectDataVO> getSelectHisList(SelectDataVO selectDataVO)
	{
		return list("waterinfoDAO.getSelectHisList", selectDataVO);
	}
	
	// 측정소 수질 선별 이력 검색 레코드 수 (IP-USN)
	public int getSelectHisCnt(SelectDataVO selectDataVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getSelectHisCnt", selectDataVO);
	}
	
	/**
	 * 선별보고서 조회
	 * 2014.11.11 kyr
	 * @param selectDataVO
	 * @return
	 */
	public List<SelectDataVO> getSelectDataReportList(SelectDataVO selectDataVO)
	{
		return list("waterinfoDAO.getSelectDataReportList", selectDataVO);
	}
	
	public List<SelectDataVO> getSelectDataFileList(SelectDataVO selectDataVO)
	{
		return list("waterinfoDAO.getSelectDataFileList", selectDataVO);
	}
	
	// 측정소 수질 확정 이력 조회 (IP-USN)
	public List<SelectDataVO> getDefiniteHisList(SelectDataVO selectDataVO)
	{
		return list("waterinfoDAO.getDefiniteHisList", selectDataVO);
	}
	
	// 측정소 수질 확정 이력 검색 레코드 수 (IP-USN)
	public int getDefiniteHisCnt(SelectDataVO selectDataVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getDefiniteHisCnt", selectDataVO);
	}
	
	// 데이터 선별 갯수 체크
	public int getCntDefiniteData(SelectDataVO selectDataVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getCntDefiniteData", selectDataVO);
	}
	
	// 측정소 수질 확정 취소 (IP-USN, Min)
	public void deleteDefiniteData(SelectDataVO selectDataVO) throws Exception
	{
		update("waterinfoDAO.deleteDefiniteData", selectDataVO);
	}

	// 측정소 수질 확정 취소 (IP-USN, Hour)
	public void deleteDefiniteDataHour(SelectDataVO selectDataVO) throws Exception
	{
		update("waterinfoDAO.deleteDefiniteDataHour", selectDataVO);
	}
	
	// 측정소 데이터 확정 조회 (IP-USN)
	public List<LimitViewVO> getDefiniteDataList(SelectDataVO selectDataVO)
	{
		return list("waterinfoDAO.getDefiniteDataList", selectDataVO);
	}
	
	// 측정소 데이터 확정 조회 (IP-USN)_All
	public List<LimitViewVO> getDefiniteDataListAll(SelectDataVO selectDataVO)
	{
		return list("waterinfoDAO.getDefiniteDataListAll", selectDataVO);
	}
	
	public List<LimitViewVO> getDefiniteDataChart(LimitViewVO LimitViewVO){
		return list("waterinfoDAO.getDefiniteDataChart", LimitViewVO);
	}

	// 측정소 데이터 확정 조회 연산(최소, 최대, 평균) (IP-USN)
	public SumViewVO getDefiniteDataSum(SelectDataVO selectDataVO)
	{
		return (SumViewVO)selectByPk("waterinfoDAO.getDefiniteDataSum", selectDataVO);
	}
	
	// 측정소 데이터 확정 검색 레코드 수 (IP-USN)
	public int getDefiniteDataCnt(SelectDataVO selectDataVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getDefiniteDataCnt", selectDataVO);
	}
	
	// 데이터선별이력건수
	public int getDataSelectCnt(String useFlag)
	{
		return (Integer)selectByPk("waterinfoDAO.getDataSelectCnt", useFlag);
	}
	
	/**
	 * 선별보고서 측정기기 정보
	 * 2014.11.11 kyr
	 * @param selectDataVO
	 * @return
	 */
	public SelectDataVO getSelectDataInfo(SelectDataVO selectDataVO)
	{
		return (SelectDataVO)selectByPk("waterinfoDAO.getSelectDataInfo", selectDataVO);
	}
	
	/**
	 * 선별 정보 체크
	 * @param selectDataVO
	 * @return
	 */
	public int getCntSelectDataInfo(SelectDataVO selectDataVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getCntSelectDataInfo", selectDataVO);
	}
	
	/**
	 * 선별정보 삭제
	 * 2014.11.11
	 * @param selectDataVO
	 */
	public void deleteSelectDataInfo(SelectDataVO selectDataVO)
	{
		delete("waterinfoDAO.deleteSelectDataInfo", selectDataVO);
	}
	
	// 선별정보 seq 조회
	public int selectSelInfoSeq(SelectDataVO selectDataVO)
	{
		return (Integer)selectByPk("waterinfoDAO.selectSelInfoSeq", selectDataVO);
	}
	
	// 선별정보 이력 seq 조회
	public int selectSelInfoHisSeq(SelectDataVO selectDataVO)
	{
		return (Integer)selectByPk("waterinfoDAO.selectSelInfoHisSeq", selectDataVO);
	}
	
	/**
	 *  데이터확정 조회
	 *  2014.11.11 kyr
	 * @param selectDataVO
	 * @return
	 */
	public List<SelectDataVO> getSelectConfirmList(SelectDataVO selectDataVO)
	{
		return list("waterinfoDAO.getSelectConfirmList", selectDataVO);
	}
	
	/**
	 *  데이터확정 조회 건수
	 *  2014.11.11 kyr
	 * @param selectDataVO
	 * @return
	 */
	public int getSelectConfirmListCnt(SelectDataVO selectDataVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getSelectConfirmListCnt", selectDataVO);
	}
	
	/**
	 * 데이터 선별취소
	 * 2014.11.11
	 * @param selectDataVO
	 */
	public void cancelSelectDataInfo(SelectDataVO selectDataVO)
	{
		update("waterinfoDAO.cancelSelectDataInfo", selectDataVO);
	}
	
	/**
	 * 데이터 확정
	 * 2014.11.11
	 * @param selectDataVO
	 */
	public void confirmSelectDataInfo(SelectDataVO selectDataVO)
	{
		update("waterinfoDAO.confirmSelectDataInfo", selectDataVO);
	}
	
	/**
	 * 데이터 이력
	 * 2014.11.11
	 * @param selectDataVO
	 */
	public void insertSelectDataInfoHis(SelectDataVO selectDataVO)
	{
		insert("waterinfoDAO.insertSelectDataInfoHis", selectDataVO);
	}
	
	/**
	 *  데이터선별이력 조회
	 *  2014.11.12 kyr
	 * @param selectDataVO
	 * @return
	 */
	public List<SelectDataVO> getSelectDataHisList(SelectDataVO selectDataVO)
	{
		return list("waterinfoDAO.getSelectDataHisList", selectDataVO);
	}
	
	/**
	 *  데이터선별이력 조회 건수
	 *  2014.11.12 kyr
	 * @param selectDataVO
	 * @return
	 */
	public int getSelectDataHisListCnt(SelectDataVO selectDataVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getSelectDataHisListCnt", selectDataVO);
	}
	
	/**
	 *  취소사유 정보 조회
	 *  2014.11.12 kyr
	 * @param selectDataVO
	 * @return
	 */
	public List getCancelDataInfo(String sel_his_seq)
	{
		return list("waterinfoDAO.getCancelDataInfo", sel_his_seq);
	}
	
	/**
	 * 기타사항 정보 조회
	 */
	public SelectDataVO getSelectDataEtcInfo(int sel_seq){
		return (SelectDataVO)selectByPk("waterinfoDAO.getSelectDataEtcInfo", sel_seq);
	}
	
	/**
	 * 기타사항 정보 조회
	 */
	public SelectDataVO getSelectDataEtcInfo(SelectDataVO selectDataVO){
		return (SelectDataVO)selectByPk("waterinfoDAO.getSelectDataEtcInfo2", selectDataVO);
	}
	
	public void updateAtchFileId(String atchFileId)
	{
		update("waterinfoDAO.updateAtchFileId", atchFileId);
	}
	
	/**
	 * 선별정보 초기화
	 * 2014.11.11
	 * @param selectDataVO
	 */
	public void initSelectData(SelectDataVO selectDataVO)
	{
		delete("waterinfoDAO.initSelectData", selectDataVO);
	}
	
	/**
	 * 선별정보 초기화
	 * 2014.11.11
	 * @param selectDataVO
	 */
	public void initSelectDataItem(SelectDataVO selectDataVO)
	{
		delete("waterinfoDAO.initSelectDataItem", selectDataVO);
	}
	
	/**
	 * 선별정보 선택 초기화
	 * 2014.12.18
	 * @param selectDataVO
	 */
	public void initCheckSelectData(String sel_seq)
	{
		delete("waterinfoDAO.initCheckSelectData", sel_seq);
	}
	
	/**
	 * 선별정보 선택초기화
	 * 2014.12.18
	 * @param selectDataVO
	 */
	public void initCheckSelectDataItem(String sel_seq)
	{
		delete("waterinfoDAO.initCheckSelectDataItem", sel_seq);
	}
	
	public List<HashMap> goStatusCode(String status) {
		HashMap paraMap = new HashMap();
		paraMap.put("status", status);
		return list("waterinfoDAO.goStatusCode", paraMap);
	}
	
	// 금호강 일대 공구 목록 조회
	public List<HashMap> getGongkuListKumho() {
		HashMap paraMap = new HashMap();
		return list("waterinfoDAO.getGongkuListKumho", paraMap);
	}
	
	//금호강 일대 시간 자료 조회
	public List<DetailViewVO> getKumhoRealData(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getKumhoRealData", searchTaksuVO);
	}

	//금호강 일대 시간 자료 조회 레코드 수
	public int getKumhoRealData_cnt(SearchTaksuVO searchTaksuVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getKumhoRealData_cnt", searchTaksuVO);
	}
	
	//금호강 일대 시간 자료 조회
	public List<DetailViewVO> getKumhoModelingData(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getKumhoModelingData", searchTaksuVO);
	}

	//금호강 일대 시간 자료 조회 레코드 수
	public int getKumhoModelingData_cnt(SearchTaksuVO searchTaksuVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getKumhoModelingData_cnt", searchTaksuVO);
	}
	
	public int mergeHourDataModeling(ExcelModelingVO paramVO) {
		return update("waterinfoDAO.mergeHourDataModeling", paramVO);
	}
	
	public int insertModelingInfo(ExcelModelingVO vo){
		return (Integer)update("waterinfoDAO.insertModelingInfo", vo);
	}
	
	public int insertModelingImage(WareHouseVO vo){
		return (Integer)update("waterinfoDAO.insertModelingImage", vo);
	}
	
	public List<ExcelModelingVO> getModelingResultList(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getModelingResultList", searchTaksuVO);
	}
	
	public int getTotCntModelingResult(SearchTaksuVO searchTaksuVO)
	{
		return (Integer)selectByPk("waterinfoDAO.getTotCntModelingResult", searchTaksuVO);
	}
	
	public List<ExcelModelingVO> getModelingResultDetail(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getModelingResultDetail", searchTaksuVO);
	}
	
	public List<WareHouseVO> getModelingImageResultList(SearchTaksuVO searchTaksuVO)
	{
		return list("waterinfoDAO.getModelingImageResultList", searchTaksuVO);
	}
}
