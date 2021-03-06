package daewooInfo.waterpolmnt.waterinfo.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import daewooInfo.cmmn.bean.FileVO;
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

public interface WaterinfoService {

	// 시스템 권한 조회
	List<HashMap> getSystemList(HttpServletRequest request) throws Exception;

	// 수계 목록 조회
	List<HashMap> getSugyeList(HttpServletRequest request, String system) throws Exception;
	List<HashMap> getSugyeList(String userId, String system, String userGubun) throws Exception;
	
	// 공구 목록 조회 
	List<HashMap> getGongkuList(HttpServletRequest request,String system, String sugye) throws Exception;
	
	List<HashMap> getGongkuList(String system, String sugye, String userGubun, String userId) throws Exception;
	
	// 측정소 목록 조회 
	List<HashMap> getBranchList(String factCode) throws Exception;
	
	List<HashMap> getBranchListNew(String factCode, String userId) throws Exception;
	
	// 과학원 측정소 목록 조회
	List<HashMap> getFlowFact(String sugye) throws Exception;
	
	// 과학원 측정소 목록 조회 - 수위지점
	List<HashMap> getWLFact(String sugye) throws Exception;
	
	// 과학원 측정소 목록 조회 - 댐
	List<HashMap> getDamFact(String sugye) throws Exception;
	
	// 측정소 목록 조회 
	String getFactBranchCnt(String factCode) throws Exception;
	
	// 측정항목 목록 조회 
	List<HashMap> getItemList(String system, String sugye, String factCode, String branchNo) throws Exception;
	
	List<HashMap> getItemList2(String itemKind) throws Exception;
	
	// 하천수질조회
	List<DetailViewVO> getDetailViewRIVER(SearchTaksuVO searchTaksuVO) throws Exception;

	// 하천수질조회 검색 레코드 수
	int getTotCntRiver(SearchTaksuVO searchTaksuVO) throws Exception;
	
	// 하천수질조회(그래프 & 엑셀)
	List<DetailViewVO> getRiverGraph(SearchTaksuVO searchTaksuVO) throws Exception;
	
	// 방류수질 측정소 조회
	List<HashMap> getTMSList(HttpServletRequest request, String sugye) throws Exception;
	
	List<HashMap> getTMSListNew(String sugye, String userId, String userGubun) throws Exception;
	
	// 방류수질 측정소 조회
	List<HashMap> getTMSList2(String sugye, String tmsCtyCode) throws Exception;

	// 방류수질 측정소 조회
	List<HashMap> getTMSRiverD1List() throws Exception;
	
	// 방류수질 측정소 조회
	List<HashMap> getTMSRiverD2List(String sugye) throws Exception;
	
	// 방류수질 방류구 조회
	List<HashMap> getWastList(String factCode) throws Exception;
	
	// 방류수질조회
	List<DetailViewVO> getDetailViewDISCHARGE(SearchTaksuVO searchTaksuVO) throws Exception;
	
	// 하천수질조회 검색 레코드 수
	int getTotCntDischarge(SearchTaksuVO searchTaksuVO) throws Exception;
	
	// 하천수질조회(그래프 & 엑셀)
	List<TaksuVO> getDischargeGraph(SearchTaksuVO searchTaksuVO) throws Exception;
	
	//유량조회
	List<FlowDataVO> getFlowData(SearchTaksuVO searchTaksuVO) throws Exception;
	
	//유량조회 검색 레코드 수
	int getFlowData_cnt(SearchTaksuVO searchTaksuVO) throws Exception;

	//유량조회 하루치 그래프
	List<FlowDataVO> getFlowData_chart(SearchTaksuVO searchTaksuVO) throws Exception;

	//유량조회 그래프 팝업
	List<FlowDataVO> getFlowData_chartpopup(SearchTaksuVO searchTaksuVO) throws Exception;
	
	//유량 지점 위치 조회
	LocationVO getFlowFactLocation(SearchTaksuVO searchTaksuVO) throws Exception;
	
	
	//수위조회
	List<FlowDataVO> getWLData(SearchTaksuVO searchTaksuVO) throws Exception;
	
	//수위조회 검색 레코드 수
	int getWLData_cnt(SearchTaksuVO searchTaksuVO) throws Exception;

	//수위조회 하루치 그래프
	List<FlowDataVO> getWLData_chart(SearchTaksuVO searchTaksuVO) throws Exception;

	//수위조회 그래프 팝업
	List<FlowDataVO> getWLData_chartpopup(SearchTaksuVO searchTaksuVO) throws Exception;
	
	//수위 지점 위치 조회
	LocationVO getWLFactLocation(SearchTaksuVO searchTaksuVO) throws Exception;
	
	
	//댐 조회
	List<DamDataVO> getDamData(SearchTaksuVO searchTaksuVO) throws Exception;
	
	//댐 검색 레코드 수
	int getDamData_cnt(SearchTaksuVO searchTaksuVO) throws Exception;

	//댐 하루치 그래프
	List<DamDataVO> getDamData_chart(SearchTaksuVO searchTaksuVO) throws Exception;

	//댐 그래프 팝업
	List<DamDataVO> getDamData_chartpopup(SearchTaksuVO searchTaksuVO) throws Exception;
	
	//댐 지점 위치 조회
	LocationVO getDamFactLocation(SearchTaksuVO searchTaksuVO) throws Exception;
	
	/**
	 * 조류예보 목록가져옴
	 * @param algaDataVO
	 * @return
	 * @throws Exception
	 */
	List<AlgaCastDataVO> getAlgaCastList(AlgaCastDataVO algaDataVO) throws Exception;
	
	/**
	 * 조류예보 목록 총 조회 레코드 수
	 * @param airMntData
	 * @return
	 * @throws Exception
	 */
	public int getAlgaCastList_cnt(AlgaCastDataVO algaDataVO) throws Exception;
	
	/**
	 * 조류예보 초기 조회
	 * @return
	 * @throws Exception
	 */
	List<AlgaCastDataVO> getAlgaCastFirst(String river_div) throws Exception;
	
	/**
	 * 조류예보 상세정보 조회
	 * @param cast_num
	 * @return
	 * @throws Exception
	 */
	AlgaCastDataVO getAlgaCast(String cast_num) throws Exception;
	
	/**
	 * 조류예보 삭제
	 * @param cast_num
	 * @throws Exception
	 */
	void deleteAlgaCast(String cast_num) throws Exception;
	
	/**
	 * 조류예보 업데이트
	 * @param algaCastData
	 * @throws Exception
	 */
	void updateAlgaCast(AlgaCastDataVO algaCastData) throws Exception;
	
	/**
	 * 항공감시 목록 조회
	 * @param airMntData
	 * @return
	 * @throws Exception
	 */
	List<AirMntDataVO> getAirMntList(AirMntDataVO airMntData) throws Exception;
	
	/**
	 * 항공감시 목록 총 조회 레코드 수
	 * @param airMntData
	 * @return
	 * @throws Exception
	 */
	int getAirMntList_cnt(AirMntDataVO airMntData) throws Exception;
	
	/**
	 * 항공감시 초기조회
	 * @return
	 * @throws Exception
	 */
	List<AirMntDataVO> getAirMntFirst(String sugye) throws Exception;
	
	/**
	 * 항공감시 상세목록 조회
	 * @param obv_num
	 * @return
	 * @throws Exception
	 */
	AirMntDataVO getAirMnt(String obv_num) throws Exception;
	
	/**
	 * 항공감시 삭제
	 * @param obv_num
	 * @throws Exception
	 */
	void deleteAirMnt(String obv_num) throws Exception;
	
	/**
	 * 항공감시 데이터 업데이트
	 * @param airMntData
	 * @throws Exception
	 */
	void updateAirMnt(AirMntDataVO airMntData) throws Exception;
	
	// 하천수질조회(경보 3시간이상)
	List<RiverWater3HourWarningVO> getRiverWater3HourWarning(RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO) throws Exception;
	
	// 하천수질조회(경보 3시간이상) 엑셀
	List<RiverWater3HourWarningVO> getRiverWater3HourWarningExcel(RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO) throws Exception;
	
	// 하천수질조회(경보 3시간이상) 검색 레코드 수
	int getRiverWarning_cnt(RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO) throws Exception;
	
	// 하천수질조회(경보 3시간이상) (그래프 & 엑셀 조회)
	public List<RiverWater3HourWarningVO> getChartWarning(RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO) throws Exception;
	
	// 하천수질조회(경보 3시간이상)- 세부조회
	List<RiverWater3HourWarningVO> getRiverWater3HourWarningPopDetail(RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO) throws Exception;
	
	//수질자동 측정망 유효데이터 입력
	void insertValidData(DetailViewVO detailViewVO) throws Exception;
	
	//측정망 유효데이터 입력
	HashMap uploadExcelData(String factCode, HashMap<String, String> excelFileInfo) throws Exception;
	
	List<String> getValidItemSeq(SearchTaksuVO searchTaksuVO) throws Exception;
	
	//공구의 위치정보
	public LocationVO getFactLocation(SearchTaksuVO searchTaksuVO) throws Exception;
	
	//측정소 이름
	public SearchTaksuVO getBranchName(SearchTaksuVO searchTaksuVO) throws Exception;
	
	//측정소 이름
	public SearchTaksuVO getFlowOBSName(SearchTaksuVO searchTaksuVO) throws Exception;

	List getBoObsCdList(String sugye) throws Exception;

	List getBoManageList(BoSearchVO searchVO) throws Exception;
	
	int getBoManageListCnt(BoSearchVO searchVO) throws Exception;
	
	// 조류측정 정보 조회 리스트 
	List getAlgacastAutoList(SearchTaksuVO searchTaksuVO);

	// 조류 측정 정보 조회 수량 
	int getAlgacastAutoCnt(SearchTaksuVO searchTaksuVO);
	
	// 점오염원 정보 조회 리스트 
	List getFactoryIndustList(CmnSearchVO cmnSearchVO);

	// 점오염원 정보 조회 수량 
	int getFactoryIndustListCnt(CmnSearchVO cmnSearchVO);
	
	// 단일 점오염원 상세조회 리스트 
	List getFactoryIndustIdList(CmnSearchVO cmnSearchVO);
	
	// 점오염원 사업장규모별 조회 리스트
	List getFactoryIndustSizeList(CmnSearchVO cmnSearchVO);
	
	// 점오염원 오염물질별 조회 리스트
	List getFactoryIndustSpecList(CmnSearchVO cmnSearchVO);
	
	// 점오염원 사업장규모별 및 오염물질별 합계 리스트
	List getFactoryIndustSizeSpecCnt(CmnSearchVO cmnSearchVO);
	
	// 대권 유역 정보조회 리스트 
	List getBasinLargeList(CmnSearchVO cmnSearchVO);
	
	// 중권 유역 정보조회 리스트 
	List getBasinMiddleList(CmnSearchVO cmnSearchVO);
	
	/**
	 * 점오염원 사업소 id 중복 체크
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int duplicateFacId(FactoryIndustViewVO factoryIndustViewVO) throws Exception;
	// 점오염원 사업소 등록
	void insertFactoryIndust(FactoryIndustViewVO factoryIndustViewVO) throws Exception;
	
	// 점오염원 사업소 size 등록
	void insertFactoryIndustSize(FactoryIndustViewVO factoryIndustViewVO) throws Exception;
	
	// 점오염원 사업소 spec 등록
	void insertFactoryIndustSpec(FactoryIndustViewVO factoryIndustViewVO) throws Exception;
	
	// 점오염원 사업소 cnt 등록
	void insertFactoryIndustCnt(FactoryIndustViewVO factoryIndustViewVO) throws Exception;
	
	// 점오염원 사업소 수정
	void updatFactoryIndust(FactoryIndustViewVO factoryIndustViewVO) throws Exception;
	
	// 점오염원 사업소 삭제
	int deleteFactoryIndust(CmnSearchVO cmnSearchVO) throws Exception;
	
	// 점오염원  사업소별size 측정값 수정
	void updateFactoryIndustSize(FactoryIndustViewVO factoryIndustViewVO) throws Exception;
	
	// 점오염원  사업소별spec 측정값 수정
	void updateFactoryIndustSpec(FactoryIndustViewVO factoryIndustViewVO) throws Exception;
	
	// 점오염원  사업소별cnt 측정값 수정
	void updateFactoryIndustCnt(FactoryIndustViewVO factoryIndustViewVO) throws Exception;
	
	// 취정수장 정보 조회 리스트 
	List getWaterDcCenterList(CmnSearchVO cmnSearchVO);

	//취정수장 정보 조회 수량 
	int getWaterDcCenterListCnt(CmnSearchVO cmnSearchVO);
	
	// 보 정보 조회 리스트 
	List getBoObsInfoList(CmnSearchVO cmnSearchVO);

	// 보 정보 조회 수량 
	int getBoObsInfoListCnt(CmnSearchVO cmnSearchVO);
	
	// 댐 정보 조회 리스트 
	List getDamList(CmnSearchVO cmnSearchVO);

	// 댐 정보 조회 수량 
	int getDamListCnt(CmnSearchVO cmnSearchVO);
	
	// 유관기관 정보 조회 리스트 
	List getRelOffList(CmnSearchVO cmnSearchVO);

	// 유관기관 정보 조회 수량 
	int getRelOffListCnt(CmnSearchVO cmnSearchVO);
	
	// 단일 유관기관 상세조회 리스트 
	List getRelOffDetailList(CmnSearchVO cmnSearchVO);
	
	/**
	 * 유관기관 id 중복 체크
	 * @param relateOfficeDataVO
	 * @return
	 * @throws Exception
	 */
	int duplicateRelOffId(RelateOfficeDataVO relateOfficeDataVO) throws Exception;
	
	// 유관기관 등록
	void insertRelOff(RelateOfficeDataVO relateOfficeDataVO) throws Exception;
	
	// 유관기관 수정
	void updatRelOff(RelateOfficeDataVO relateOfficeDataVO) throws Exception;
	
	// 유관기관 삭제
	int deleteRelOff(CmnSearchVO cmnSearchVO) throws Exception;
	
	// 특별시/동 조회
	List getDoCodeList(CmnSearchVO cmnSearchVO);
	
	// 시군구 조회
	List getCtyCodeList(CmnSearchVO cmnSearchVO);
	
	// 방제업체 목록 조회
	List getEcompanyList(CmnSearchVO cmnSearchVO);
	
	// 방제업체 수량
	int getEcompanyListCnt(CmnSearchVO cmnSearchVO);
	
	// 단일 유관기관 상세조회 리스트 
	List getEcompanyDetailList(CmnSearchVO cmnSearchVO);
	
	/**
	 * 방제업체 id 중복 체크
	 * @param ecompanyDataVO
	 * @return
	 * @throws Exception
	 */
	int duplicateEcoId(EcompanyDataVO ecompanyDataVO) throws Exception;
	
	// 방제업체 등록
	void insertEcompany(EcompanyDataVO ecompanyDataVO) throws Exception;
	
	// 방제업체 수정
	void updatEcompany(EcompanyDataVO ecompanyDataVO) throws Exception;
	
	// 방제업체 삭제
	int deleteEcompany(CmnSearchVO cmnSearchVO) throws Exception;
	
	// 방제물품 조회
	List getEcompanyOwnItemList(CmnSearchVO cmnSearchVO);
	
	// 방제물품 수량
	int getEcompanyOwnItemListCnt(CmnSearchVO cmnSearchVO);
	
	
	// 방제물품 추가
	void insertEcompanyOwnItem(EcompayOwnItemDataVO ecompayOwnItemDataVO) throws Exception;
	
	// 방제물품 삭제
	int deleteEcompanyOwnItem(EcompayOwnItemDataVO ecompayOwnItemDataVO) throws Exception;
	
	
	// 측정소 기준치 조회 (IP-USN)
	List<LimitDataVO> getDetailViewLIMIT_U(LimitDataVO limitDataVO);
	
	// 측정소 기준치 조회 (수질측정망)
	List<LimitDataVO> getDetailViewLIMIT_A(LimitDataVO limitDataVO);
	
	// 측정소 기준치 적용 (수질측정망 -> IP-USN)
	void applyDetailViewLIMIT(LimitDataVO limitDataVO) throws Exception;
	
	// 측정소 기준치 수정 (IP-USN)
	void updateDetailViewLIMIT(LimitDataVO limitDataVO) throws Exception;
	
	// 측정소 데이터 선별 조회 (IP-USN)
	List<LimitViewVO> getSelectDataList(SelectDataVO selectDataVO);
	
	// 측정소 데이터 선별 조회 (IP-USN)_전체
	List<LimitViewVO> getSelectDataListAll(SelectDataVO selectDataVO);
	
	// 측정소 데이터 선별 검색 레코드 수 (IP-USN)
	int getSelectDataCnt(SelectDataVO selectDataVO);
	
	// 측정소 데이터 기준치설정정보 (IP-USN)
	int getStandardInfoCnt(SelectDataVO selectDataVO);

	// 측정소 데이터 선별 검색 선별 최종일 (IP-USN)
	String getSelectDataMaxDate(SelectDataVO selectDataVO);
	
	// 데이터 선별 등록
	String saveSelectData(SelectDataVO selectDataVO) throws Exception;
	
	// 데이터 선별 상세 삭제
	void deleteSelectData(SelectDataVO selectDataVO) throws Exception;

	// 데이터 선별 상세 초기화
	void deleteSelectDataAll(SelectDataVO selectDataVO) throws Exception;

	// 데이터 선별 상세 조회
	SelectDataVO getDetailSelectData(SelectDataVO selectDataVO);
	
	// 데이터 선별 선별사유 조회
	SelectDataVO getSelectDataReason(SelectDataVO selectDataVO);
	
	// 확정 데이터 입력
	void insertDefiniteData(SelectDataVO selectDataVO) throws Exception;
	
	/**
	 * 선별/ 확정 데이터 입력
	 * 2014.11.11 kyr
	 * @param selectDataVO
	 * @throws Exception
	 */
	void saveSelectDataInfo(SelectDataVO selectDataVO) throws Exception;
	
	/**
	 * 선별/ 확정 데이터 입력
	 * 2014.11.11 kyr
	 * @param selectDataVO
	 * @throws Exception
	 */
	void updateSelectDataInfo(SelectDataVO selectDataVO) throws Exception;
	
	// 측정소 수질 선별 이력 조회 (IP-USN)
	List<SelectDataVO> getSelectHisList(SelectDataVO selectDataVO);
	
	// 측정소 수질 선별 이력 검색 레코드 수 (IP-USN)
	int getSelectHisCnt(SelectDataVO selectDataVO);
	
	/**
	 * 선별보고서 조회
	 * 2014.11.11 kyr
	 * @param selectDataVO
	 * @return
	 */
	List<SelectDataVO> getSelectDataReportList(SelectDataVO selectDataVO);
	
	List<SelectDataVO> getSelectDataFileList(SelectDataVO selectDataVO);
	
	// 측정소 수질 확정 이력 조회 (IP-USN)
	List<SelectDataVO> getDefiniteHisList(SelectDataVO selectDataVO);
	
	// 측정소 수질 확정 이력 검색 레코드 수 (IP-USN)
	int getDefiniteHisCnt(SelectDataVO selectDataVO);
	
	// 측정소 수질 확정 취소 (IP-USN)
	String deleteDefiniteData(SelectDataVO selectDataVO) throws Exception;
	
	// 측정소 데이터 확정 조회 (IP-USN)
	List<LimitViewVO> getDefiniteDataList(SelectDataVO selectDataVO);
	
	// 측정소 데이터 확정 조회 (IP-USN)_전체
	List<LimitViewVO> getDefiniteDataListAll(SelectDataVO selectDataVO);

	// 차트 정보
	List<LimitViewVO> getDefiniteDataChart(LimitViewVO LimitViewVO);
	
	// 측정소 데이터 확정 조회 연산(최소, 최대, 평균) (IP-USN)
	SumViewVO getDefiniteDataSum(SelectDataVO selectDataVO);
	
	// 측정소 데이터 확정 검색 레코드 수 (IP-USN)
	int getDefiniteDataCnt(SelectDataVO selectDataVO);
	
	// 데이터선별이력건수
	int getDataSelectCnt(String useFlag);
	
	/**
	 * 선별보고서 측정기기 정보
	 * 2014.11.11 kyr
	 * @param selectDataVO
	 * @return
	 */
	SelectDataVO getSelectDataInfo(SelectDataVO selectDataVO);
	
	int getCntSelectDataInfo(SelectDataVO selectDataVO);
	
	/**
	 *  데이터확정 조회
	 *  2014.11.11 kyr
	 * @param selectDataVO
	 * @return
	 */
	List<SelectDataVO> getSelectConfirmList(SelectDataVO selectDataVO);
	
	/**
	 *  데이터확정 조회 건수
	 *  2014.11.11 kyr
	 * @param selectDataVO
	 * @return
	 */
	int getSelectConfirmListCnt(SelectDataVO selectDataVO);
	
	/**
	 * 선별취소
	 * 2014.11.12 kyr
	 * @param selectDataVO
	 * @return
	 * @throws Exception
	 */
	void cancelSelectDataInfo(SelectDataVO selectDataVO) throws Exception;
	
	/**
	 * 데이터확정
	 * 2014.11.12 kyr
	 * @param selectDataVO
	 * @return
	 * @throws Exception
	 */
	void confirmSelectDataInfo(SelectDataVO selectDataVO) throws Exception;
	
	/**
	 *  데이터선별 이력 조회
	 *  2014.11.12 kyr
	 * @param selectDataVO
	 * @return
	 */
	List<SelectDataVO> getSelectDataHisList(SelectDataVO selectDataVO);
	
	/**
	 *  데이터선별 이력 조회 건수
	 *  2014.11.12 kyr
	 * @param selectDataVO
	 * @return
	 */
	int getSelectDataHisListCnt(SelectDataVO selectDataVO);
	
	/**
	 * 취소사유 정보 조회
	 * 2014.11.12 kyr
	 */
	List getCancelDataInfo(String sel_his_seq);
	
	/**
	 * 기타사항 정보 조회
	 */
	SelectDataVO getSelectDataEtcInfo(int sel_seq);
	
	/**
	 * 기타사항 정보 조회
	 */
	SelectDataVO getSelectDataEtcInfo(SelectDataVO selectDataVO);
	
	void updateAtchFileId(String atchFileId);
	
	/**
	 * 선별데이터 초기화
	 * 2014.11.17 kyr
	 * @param selectDataVO
	 * @throws Exception
	 */
	void initSelectData(SelectDataVO selectDataVO) throws Exception;
	
	
	/**
	 * 선별데이터 선택 초기화
	 * 2014.12.18 kyr
	 * @param selectDataVO
	 * @throws Exception
	 */
	void initCheckSelectData(String sel_seq) throws Exception;
	
	List<HashMap> goStatusCode(String status) throws Exception;
	
	List<HashMap> getGongkuListKumho() throws Exception;
	
	//금호강 시간 자료 조회
	List<DetailViewVO> getKumhoRealData(SearchTaksuVO searchTaksuVO) throws Exception;
	
	//금호강 시간 자료 카운트
	int getKumhoRealData_cnt(SearchTaksuVO searchTaksuVO) throws Exception;
	
	//금호강 시간 자료 조회
	List<DetailViewVO> getKumhoModelingData(SearchTaksuVO searchTaksuVO) throws Exception;
	
	//금호강 시간 자료 카운트
	int getKumhoModelingData_cnt(SearchTaksuVO searchTaksuVO) throws Exception;
	
	//금호강 모델링 엑셀데이터 입력
	int readExcelUpdateModeling(HashMap<String, String> excelFileInfo) throws Exception;
	
	public int insertModelingInfoXls(MultipartHttpServletRequest req, FileVO file, WareHouseVO wareHouseVO);
	public int insertModelingInfoXlsx(MultipartHttpServletRequest req, FileVO file, WareHouseVO wareHouseVO);
	
	public int insertModelingImage(MultipartHttpServletRequest req, FileVO file, WareHouseVO wareHouseVO);
	
	List<ExcelModelingVO> getModelingResultList(SearchTaksuVO searchTaksuVO) throws Exception;

	int getTotCntModelingResult(SearchTaksuVO searchTaksuVO) throws Exception;
	
	List<ExcelModelingVO> getModelingResultDetail(SearchTaksuVO searchTaksuVO) throws Exception;
	List<WareHouseVO> getModelingImageResultList(SearchTaksuVO searchTaksuVO) throws Exception;
}
