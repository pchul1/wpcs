package daewooInfo.warehouse.service;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import daewooInfo.admin.member.bean.MemberSearchVO;
import daewooInfo.cmmn.bean.DeptVO;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.common.login.bean.MemberVO;
import daewooInfo.warehouse.bean.ExcelItemVO;
import daewooInfo.warehouse.bean.ItemCalcSearchVO;
import daewooInfo.warehouse.bean.ItemCodeGroupVO;
import daewooInfo.warehouse.bean.ItemCodeSearchVO;
import daewooInfo.warehouse.bean.ItemCodeVO;
import daewooInfo.warehouse.bean.ItemConditionManageSearchVO;
import daewooInfo.warehouse.bean.ItemGroupSearchVO;
import daewooInfo.warehouse.bean.ItemManageSearchVO;
import daewooInfo.warehouse.bean.SearchVO;
import daewooInfo.warehouse.bean.WareHouseManageSearchVO;
import daewooInfo.warehouse.bean.WareHouseSearchVO;
import daewooInfo.warehouse.bean.WareHouseVO;
import daewooInfo.warehouse.bean.WareHouseZipcodeVO;


/**
 * 방제물품관리에 관한 서비스 인터페이스 클래스를 정의한다
 * @author  kisspa
 * @since  2010.07.28
 * @version  1.0
 * @see  <pre>  수정일      수정자           수정내용  -------    --------    ---------------------------  2010.07.28  kisspa          최초 생성  </pre>
 */
public interface WareHouseManageService {
	
	/**
	 * 창고 목록을 가져온다.
	 * @return
	 * @throws Exception
	 */
	List<WareHouseVO> selectWareHouseList(WareHouseVO wareHouseVO) throws Exception;
	
	/**
	 * 창고물품 간단 조회(전체)
	 * @param vo
	 * @return
	 * @throws Excepton
	 */
	List<ItemCodeVO> selectWareHouseItemListSimpleAll(SearchVO vo) throws Exception;
	
	/**
	 * 창고물품 간단 조회(특정 창고)
	 * @param vo
	 * @return
	 * @throws Excepton
	 */
	List<ItemCodeVO> selectWareHouseItemListSimpleOne(SearchVO vo) throws Exception;
	
	/**
	 * 창고물품 상세조회(입고)
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	List<ItemCodeVO> selectWareHouseItemListDetail_store(SearchVO vo) throws Exception;
	
	/**
	 * 창고물품 상세조회(출고)
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	List<ItemCodeVO> selectWareHouseItemListDetail_rele(SearchVO vo) throws Exception;
	
	/**
	 * 방제물품 코드 리스트
	 * @return
	 * @throws Exception
	 */
	List<ItemCodeVO> selectWareHouseItemCodeList(SearchVO vo) throws Exception;
	
	/**
	 * 방제물품 코드 입력
	 * @param vo
	 * @throws Exception
	 */
	void insertWareHouseItemCode(ItemCodeVO vo) throws Exception;
	
	/**
	 * 방제물품 코드 수정
	 * @param vo
	 * @throws Exception
	 */
	void updateWareHouseItemCode(ItemCodeVO vo) throws Exception;
	
	/**
	 * 입고 리스트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	List<ItemCodeVO> selectWareHouseItemStorList(SearchVO vo) throws Exception;
	
	/**
	 * 입고 등록
	 * @param vo
	 * @throws Exception
	 */
	void insertWareHouseItemStor(ItemCodeVO vo) throws Exception;
	
	/**
	 * 입고 수정
	 * @param vo
	 * @throws Exception
	 */
	void updateWareHouseItemStor(ItemCodeVO vo) throws Exception;
	
	/**
	 * 입고 삭제
	 * @param vo
	 * @throws Exception
	 */
	int deleteWareHouseItemStor(ItemCodeVO vo) throws Exception;
	
	/**
	 * 출고 리스트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	List<ItemCodeVO> selectWareHouseItemReleList(SearchVO vo) throws Exception;
	
	/**
	 * 출고 등록
	 * @param vo
	 * @throws Exception
	 */
	void insertWareHouseItemRele(ItemCodeVO vo) throws Exception;
	
	/**
	 * 출고 수정
	 * @param vo
	 * @throws Exception
	 */
	void updateWareHouseItemRele(ItemCodeVO vo) throws Exception;
	
	/**
	 * 출고 삭제
	 * @param vo
	 * @throws Exception
	 */
	void deleteWareHouseItemRele(ItemCodeVO vo) throws Exception;
	
	
	/**
	 * 입고 데이터 목록
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	List<ItemCodeSearchVO> itemStoreDataList(ItemCodeSearchVO vo) throws Exception;
	
	/**
	 * 입고 데이터 목록 카운트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int itemStoreDataListCnt(ItemCodeSearchVO vo) throws Exception;
	
	/**
	 * 출고 데이터 목록
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	List<ItemCodeSearchVO> itemReleDataList(ItemCodeSearchVO vo) throws Exception;
	
	/**
	 * 출고 데이터 목록 카운트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int itemReleDataListCnt(ItemCodeSearchVO vo) throws Exception;
	
	/**
	 * 정산 데이터 목록
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	List<ItemCodeSearchVO> itemCalcDataList(ItemCalcSearchVO vo) throws Exception;
	
	/**
	 * 정산 데이터 목록 카운트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int itemCalcDataListCnt(ItemCalcSearchVO vo) throws Exception;
	
	/**
	 * 정산 데이터 merge into
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int mergeItemCalc(ItemCalcSearchVO vo) throws Exception;
	
	/**
	 * 방제물품 조회 데이터 목록 (전체)
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	List<ItemCodeSearchVO> itemSearchDataListALL(ItemCodeSearchVO vo) throws Exception;
	
	/**
	 * 방제물품 조회 데이터입고 데이터 목록 카운트 (전체)
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int itemSearchDataListCntALL(ItemCodeSearchVO vo) throws Exception;
	
	/**
	 * 방제물품 조회 데이터 목록 (특정창고)
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	List<ItemCodeSearchVO> itemSearchDataList(ItemCodeSearchVO vo) throws Exception;
	
	/**
	 * 방제물품 조회 데이터입고 데이터 목록 카운트 (특정창고)
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int itemSearchDataListCnt(ItemCodeSearchVO vo) throws Exception;
	
	/**
	 * 하나의 창고 정보
	 * @param whCode
	 * @return
	 * @throws Exception
	 */
	WareHouseVO wareHouseInfo(String whCode) throws Exception;
	
	/**
	 * 아이템 코드 관리 목록
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	List<ItemCodeSearchVO> itemCodeDataList(ItemCodeSearchVO vo) throws Exception;
	
	/**
	 * 아이템 코드 관리 목록 카운트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int itemCodeDataListCnt(ItemCodeSearchVO vo) throws Exception;
	
	/**
	 * merge into 방제물품 현황
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int mergeWareHouseItemStor(ItemCodeSearchVO vo) throws Exception;
	
	/**
	 * merge into 방제물품 코드
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int mergeWareHouseItemCode(ItemCodeSearchVO vo) throws Exception;
	
	int mergeWareHouseItemCodeN(ItemCodeSearchVO vo) throws Exception;
	
	int saveWareHouseItemCodeDetail(ItemCodeVO itemCodeVO) throws Exception;
	
	/**
	 * 방제물품 창고 관리 데이터
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	List<WareHouseSearchVO> wareHouseDataList(WareHouseSearchVO vo) throws Exception;
	
	/**
	 * 방제물품 창고 관리 데이터 카운트
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int wareHouseDataListCnt(WareHouseSearchVO vo) throws Exception;
	
	/**
	 * merge into 방제물품 창고 정보
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int mergeWareHouse(WareHouseSearchVO vo) throws Exception;
	
	/**
	 * 지역코드
	 * @return
	 * @throws Exception
	 */
	List<Map<String, String>> ctyCode() throws Exception;
	List<Map<String, String>> selectDoCode() throws Exception;
	List<Map<String, String>> wareHousectyCode() throws Exception;
	
	/**
	 * 방제물품 코드 중복 체크
	 * @param vo
	 * @return
	 * @throws Exception
	 */
	int duplicateItemCode(ItemCodeSearchVO vo) throws Exception;
	
	
	/**
	 * 방제물품 정산조회(정산기간조회)
	 * @param searchVO
	 * @return List
	 * @throws Exception
	 */
	List CalcTotalCost(ItemCalcSearchVO searchVO) throws Exception;
	
	/**
	 * 방제물품 정산내역저장
	 * @param searchVO
	 * @return void
	 * @throws Exception
	 */
	void insertWareHouseItemCalc(ItemCalcSearchVO searchVO)throws Exception;
	
	/**
	 * 방제물품 정산내역조회
	 * @param searchVO
	 * @return List
	 * @throws Exception
	 */
	List WareHouseCalcTotalList(ItemCalcSearchVO searchVO) throws Exception;
	
	/**
	 * 방제물품 정산내역조회된Count
	 * @param searchVO
	 * @return int
	 * @throws Exception
	 */
	int WareHouseCalcTotalCnt(ItemCalcSearchVO searchVO) throws Exception;
	
	/**
	 * 방제물품 청구서내용
	 * @param searchVO
	 * @return List
	 * @throws Exception
	 */
	List getcalcItemPrintInfo(ItemCalcSearchVO itemCalcVO) throws Exception;

	/**
	 * 방제물품 창고관리 목록
	 * @param searchVO
	 * @return
	 */
	List getWareHouseManageList(WareHouseManageSearchVO searchVO);

	/**
	 * 방제물품 창고관리 목록 총개수
	 * @param searchVO
	 * @return
	 */
	int getWareHouseManageListCnt(WareHouseManageSearchVO searchVO);

	/**
	 * 방제물품 창고관리 창고등록
	 * @param wareHouseVO
	 */
	void insertWareHouseManage(WareHouseVO wareHouseVO);

	/**
	 * 방제물품 창고관리 상위부서 코드
	 * @return
	 */
	List wareHouseManageDeptUpper();

	/**
	 * 방제물품 창고관리 담당부서코드 
	 * @param deptVO 
	 * @return
	 */
	List<Map<String, String>> wareHouseManageDeptAdmin(DeptVO deptVO);

	/**
	 * 방제물품 창고관리 담당자코드
	 * @param memberVO
	 * @return
	 */
	List<Map<String, String>> wareHouseManageAdminName(MemberVO memberVO);

	/**
	 * 방제물품 창고관리 창고수정
	 * @param wareHouseVO
	 */
	void updateWareHouseManage(WareHouseVO wareHouseVO);

	/**
	 * 방제물품 창고관리 창고상세
	 * @param wareHouseVO
	 * @return
	 */
	List getWareHouseManageDetail(WareHouseVO wareHouseVO);

	/**
	 * 방제물품 창고관리 창고삭제
	 * @param wareHouseVO
	 */
	void deleteWareHouseManage(WareHouseVO wareHouseVO);

	/**
	 * 방제물품 물품관리 목록
	 * @param searchVO
	 * @return
	 */
	List getItemManageList(ItemManageSearchVO searchVO);

	/**
	 * 방제물품 물품관리 목록 총개수
	 * @param searchVO
	 * @return
	 */
	int getItemManageListCnt(ItemManageSearchVO searchVO);

	/**
	 * 방제물품 물품관리 상세 페이지
	 * @param itemCodeVO
	 * @return
	 */
	List getItemManageDetail(ItemCodeVO itemCodeVO);

	/**
	 * 방제물품 물품관리 물품 등록
	 * @param itemCodeVO
	 */
	void insertItemManage(ItemCodeVO itemCodeVO);

	/**
	 * 방제물품 물품관리 분류코드
	 * @return
	 */
	List<Map<String, String>> itemManageUpperGroupCode();
	List<Map<String, String>> itemManageGroupCode(ItemCodeVO itemCodeVO);

	/**
	 * 방제물품 물품관리 물품수정
	 * @param itemCodeVO
	 */
	void updateItemManage(ItemCodeVO itemCodeVO);

	/**
	 * 방제물품 코드관리 대분류코드 목록
	 * @param searchVO
	 * @return
	 */
	List<ItemCodeSearchVO> itemUpperGroupDataList(ItemGroupSearchVO searchVO);
	int itemUpperGroupDataListCnt(ItemGroupSearchVO searchVO);

	/**
	 * 방제물품 코드관리 중분류코드 목록
	 * @param searchVO
	 * @return
	 */
	List<ItemCodeSearchVO> itemGroupDataList(ItemGroupSearchVO searchVO);
	int itemGroupDataListCnt(ItemGroupSearchVO searchVO);

	/**
	 * 방제물품 코드관리 분류코드 수정
	 * @param itemCodeGroupVO
	 */
	void itemGroupModify(ItemCodeGroupVO itemCodeGroupVO);

	/**
	 * 방제물품 코드관리 대분류항목 등록
	 * @param itemCodeGroupVO
	 */
	void itemUpperGroupInsert(ItemCodeGroupVO itemCodeGroupVO);

	/**
	 * 방제물품 코드관리 중분류항목 등록
	 * @param itemCodeGroupVO
	 */
	void itemGroupInsert(ItemCodeGroupVO itemCodeGroupVO);
	
	/**
	 * 중분류 코드 가져오기.
	 * @param itemCodeGroupVO
	 * @return String
	 */
	String getItemGroupNextCode(ItemCodeGroupVO itemCodeGroupVO);


	/**
	 * 방제물품 현황관리 현황목록 
	 * @param searchVO
	 * @return
	 */
	List getItemConditionManageList(ItemConditionManageSearchVO searchVO);
	int getItemConditionManageListCnt(ItemConditionManageSearchVO searchVO);

	/**
	 * 방제물품 코드목록 
	 * @param itemCodeVO
	 * @return
	 */
	List<Map<String, String>> itemConditionCode(ItemCodeVO itemCodeVO);
	
	/**
	 * 창고에 보유중인 방제물품 코드목록
	 * @param itemCodeVO
	 * @return
	 */
	List<Map<String, String>> itemCodeInWareHouse(WareHouseVO wareHouseVO);

	/**
	 * 담당하는 창고 불러오기
	 * @param wareHouseVO
	 * @return
	 */
	List<Map<String, String>> getWareHouseCode(WareHouseVO wareHouseVO);

	/**
	 * 물품의 규격, 단위 불러오기.
	 * @param itemCodeVO
	 * @return
	 */
	List<Map<String, String>> getItemDetailValue(ItemCodeVO itemCodeVO);

	/**
	 * 물품현황 물품 입고처리
	 * @param itemCodeVO
	 */
	void insertItemConditionStor(ItemCodeVO itemCodeVO);

	/**
	 * 물품현황 물품출고 페이지
	 * @param itemCodeVO
	 * @return
	 */
	List getItemConditionReleDetail(ItemCodeVO itemCodeVO);

	/**
	 * 물품현황 물품 출고처리
	 * @param itemCodeVO
	 */
	void insertItemConditionRele(ItemCodeVO itemCodeVO);

	/**
	 * 정산목록
	 * @param searchVO
	 * @return
	 */
	List<ItemCodeSearchVO> itemCalculateManageList(ItemCodeSearchVO searchVO);
	int itemCalculateManageListCnt(ItemCodeSearchVO searchVO);
	
	List<ItemCodeSearchVO> itemCalculateManageDetailList(ItemCodeVO itemCodeVO);
	
	/**
	 * 정산 물품의 상세
	 * @param searchVO
	 * @return
	 */
	List<ItemCodeSearchVO> getItemCalculateManageDetail(ItemCodeSearchVO searchVO);
	int getItemCalculateManageDetailCnt(ItemCodeSearchVO searchVO);	

	/**
	 * 대분류코드의 중복 체크
	 * @param itemCodeGroupVO
	 * @return
	 */
	List<ItemCodeSearchVO> itemUpperGroupCodeDup(ItemCodeGroupVO itemCodeGroupVO);

	/**
	 * 담당(정) 직원 전화번호 가져오기
	 * @param memberVO
	 * @return
	 */
	List<Map<String, String>> getAdminTelNo(MemberVO memberVO);

	/**
	 * 주소가져오기.
	 * @param zipcodeVO
	 * @return
	 */
	List getWarehouseAddrList(WareHouseZipcodeVO zipcodeVO);
	
	/**
	 * 물품코드 최대값 가져오기 
	 * @param ItemCodeSearchVO
	 * @return String
	 */
	String getMaxItemCode(ItemCodeSearchVO itemCodeSearchVO);
	
	
	/**
	 * 수계 코드 가져오기
	 * @param ItemCodeVO
	 * @return List<Map<String,String>>
	 */
	public List<Map<String,String>> getRiverCodeTwo();
	
	
	/**
	 * 운영기관 / 관리주체
	 * @param 
	 * @return List<Map<String,String>>
	 */
	public List<Map<String,String>> getUpperDeptCode();
	
	/**
	 * 운영부서 / 관리부서
	 * @param Map<String,String>
	 * @return List<Map<String,String>>
	 */
	public List<Map<String,String>> getDeptCode(Map<String,String> mapParam);
	
	
	/**
	 * 창고코드 순차 번호 얻기 
	 * @param  
	 * @return  String
	 * @uml.property  name="maxWareHouseCode"
	 */
	public String getMaxWareHouseCode();
	
	/**
	 * 담당자 검색 
	 * @param MemberSearchVO
	 * @return List<MemberSearchVO>
	 */
	public List<MemberSearchVO> getSearchMember(MemberSearchVO memberSearchVO);
	
	
	/**
	 * 창고 현황 검색 
	 * @param WareHouseVO
	 * @return  List<WareHouseSearchVO>
	 */
	public List<WareHouseSearchVO> getSearchWareHouseList(WareHouseSearchVO wareHouseSearchVO);
	
	
	/**
	 * 재고 현황 검색 
	 * @param ItemCodeSearchVO
	 * @return  List<ItemCodeSearchVO>
	 */
	public List<ItemCodeVO> getSearchItemStockList(ItemCodeSearchVO searchVO);
	/**
	 * 재고 이력 저장 ( T_ITEM_INOUT )
	 * @param ItemCodeVO
	 * @return  
	 */
	public void addItemInOut(ItemCodeVO itemCodeVO);
	
	/**
	 * 재고 이력 upate 
	 * @param ItemCodeVO
	 * @return  
	 */
	public void modifyStockItem(ItemCodeVO itemCodeVO);
	
	
	/**
	 * 재고 현황 추가, 수정  
	 * @param ItemCodeVO
	 * @return  int
	 */
	public int mergeItemStock(ItemCodeVO itemCodeVO);
	
	/**
	 * addItemInOut + mergeItemStock 재고 이력 인서트 + 재고 현황 갱신
	 * @param itemCodeVO
	 * @return
	 */
	public int tranItemInOut(ItemCodeVO itemCodeVO);
	
	/**
	 * 재고 현환 이력 조회  
	 * @param ItemCodeSearchVO
	 * @return  List<ItemCodeVO>
	 */
	public List<ItemCodeVO> getItemInOutList(ItemCodeSearchVO searchVO);
	
	/**
	 * 방제물품 보유현황 물품별 조회시 물품별 창고 분포현황 조회
	 * @param searchVO
	 * @return
	 */
	public List<ItemCodeVO> itemWarehouseManage(ItemCodeSearchVO searchVO);

	/**
	 * 방제물품 보유현황 조회
	 * @param searchVO
	 * @return
	 */
	public List getItemHoldConditionList(ItemConditionManageSearchVO searchVO);
	/**
	 * 방제물품 보유현황 조회 카운트
	 * @param searchVO
	 * @return
	 */
	public int getItemHoldConditionListCnt(ItemConditionManageSearchVO searchVO);
	/**
	 * 관리부서 소속창고 조회
	 * @param searchVO
	 * @return
	 */
	public List<Map<String, String>> getWareHouseNames(WareHouseVO wareHouseVO);

	/**
	 * 동일 시간 동일 물품 입고(출고) 중복 확인
	 * @param itemCodeVO
	 * @return
	 */
	public int checkDuplicateItemInOut(ItemCodeVO itemCodeVO);
	
	/**
	 * 물품 상세 정보를 조회
	 * @param itemCodeVO
	 * @return
	 */
	public ItemCodeVO showItemDetailView(ItemCodeVO itemCodeVO);
	//public WareHouseItemDetailVO showItemDetailView(WareHouseItemDetailVO wareHouseItemDetailVO);
	
	/**
	 * 물품(장비) 배치현황 조회
	 * @param itemCodeVO
	 * @return
	 */
	public List<ItemCodeVO> getLocationOfItemStockList(ItemCodeVO itemCodeVO);
	
	public List<ItemCodeVO> getLocationOfItemStockDeptList(ItemCodeVO itemCodeVO);
	
	/**
	 * 물품 상세 정보를 저장	
	 * @param itemCodeVO
	 */
	public int saveItemDetailView(ItemCodeVO itemCodeVO);
	//public int saveItemDetailView(WareHouseItemDetailVO wareHouseItemDetailVO);
	
	/**
	 * 창고 삭제
	 * @param wareHouseVO
	 * @return
	 */
	public String deleteWareHouse(WareHouseVO wareHouseVO);
	
	public int insertItemConditionInfoXls(MultipartHttpServletRequest req, FileVO file, WareHouseVO wareHouseVO);
	public int insertItemConditionInfoXlsx(MultipartHttpServletRequest req, FileVO file, WareHouseVO wareHouseVO);
	
	public List<ExcelItemVO> getItemConditionList();
	public List<ExcelItemVO> getItemConditionDetail(String stdDate);
}
