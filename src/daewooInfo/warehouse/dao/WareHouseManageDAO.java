package daewooInfo.warehouse.dao;

import java.util.List;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Repository;

import daewooInfo.admin.member.bean.MemberSearchVO;
import daewooInfo.cmmn.bean.DeptVO;
import daewooInfo.common.login.bean.MemberVO;
import daewooInfo.itemmanage.bean.ItemGroupVO;
import daewooInfo.warehouse.bean.WareHouseItemDetailVO;
import daewooInfo.warehouse.bean.WareHouseZipcodeVO;
import daewooInfo.warehouse.bean.ExcelItemVO;
import daewooInfo.warehouse.bean.ItemCalcSearchVO;
import daewooInfo.warehouse.bean.ItemCalcVO;
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
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * 
 * 방제물품관리에 대한 데이터 접근 클래스를 정의한다
 * @author kisspa
 * @since 2010.07.28
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2010.07.28  kisspa          최초 생성
 *
 * </pre>
 */
@Repository("WareHouseManageDAO")
public class WareHouseManageDAO extends EgovAbstractDAO {
	
	/** log */
    protected static final Log log = LogFactory.getLog(WareHouseManageDAO.class);
	
	/**
	 * 창고 목록을 조회한다.
     * @return List(창고 목록)
     * @throws Exception
     */
    public List<WareHouseVO> selectWareHouseList(WareHouseVO wareHouseVO) throws Exception {
        return list("WareHouseManageDAO.selectWareHouseList", wareHouseVO);
    }
    
    /**
     * 창고물품 간단조회(전체)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<ItemCodeVO> selectWareHouseItemListSimpleAll(SearchVO vo) throws Exception {
    	return list("WareHouseManageDAO.selectWareHouseItemListSimpleAll", vo);
    }
    
    /**
     * 창고물품 간단조회(특정창고)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<ItemCodeVO> selectWareHouseItemListSimpleOne(SearchVO vo) throws Exception {
    	return list("WareHouseManageDAO.selectWareHouseItemListSimpleOne", vo);
    }
    
    /**
     * 창고물품 상세조회(입고)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<ItemCodeVO> selectWareHouseItemListDetail_store(SearchVO vo) throws Exception {
    	return list("WareHouseManageDAO.selectWareHouseItemListDetail_store", vo);
    }
    
    /**
     * 창고물품 상세조회(출고)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<ItemCodeVO> selectWareHouseItemListDetail_rele(SearchVO vo) throws Exception {
    	return list("WareHouseManageDAO.selectWareHouseItemListDetail_rele", vo);
    }
    
    /**
     * 방제물품 코드 리스트
     * @return
     * @throws Exception
     */
    public List<ItemCodeVO> selectWareHouseItemCodeList(SearchVO vo) throws Exception {
    	return list("WareHouseManageDAO.selectWareHouseItemCodeList", vo);
    }
    
    /**
     * 방제물품 코드 입력
     * @param vo
     * @throws Exception
     */
    public void insertWareHouseItemCode(ItemCodeVO vo) throws Exception {
    	insert("WareHouseManageDAO.insertWareHouseItemCode", vo);
    }
    
    /**
     * 방제물품 코드 수정
     * @param vo
     * @throws Exception
     */
    public void updateWareHouseItemCode(ItemCodeVO vo) throws Exception {    	
    	update("WareHouseManageDAO.updateWareHouseItemCode", vo);
    } 
    
    /**
     * 입고 목록
     * @param vo
     * @return
     * @throws Exception
     */
    public List<ItemCodeVO> selectWareHouseItemStorList(SearchVO vo) throws Exception {
    	return list("WareHouseManageDAO.selectWareHouseItemStorList", vo);
    }
    
    /**
     * 입고 삭제
     * @param vo
     * @throws Exception
     */
    public int deleteWareHouseItemStor(ItemCodeVO vo) throws Exception {
    	return delete("WareHouseManageDAO.deleteWareHouseItemStor", vo);
    }
    
    /**
     * 입고 입력
     * @param vo
     * @throws Exception
     */
    public void insertWareHouseItemStor(ItemCodeVO vo) throws Exception {
    	insert("WareHouseManageDAO.insertWareHouseItemStor", vo);
    }
    
    /**
     * 입고 수정
     * @param vo
     * @throws Exception
     */
    public void updateWareHouseItemStor(ItemCodeVO vo) throws Exception {
    	update("WareHouseManageDAO.updateWareHouseItemStor", vo);
    }
    
    /**
     * 출고 목록
     * @param vo
     * @return
     * @throws Exception
     */
    public List<ItemCodeVO> selectWareHouseItemReleList(SearchVO vo) throws Exception {
    	return list("WareHouseManageDAO.selectWareHouseItemReleList", vo);
    }
    
    /**
     * 출고 삭제
     * @param vo
     * @throws Exception
     */
    public void deleteWareHouseItemRele(ItemCodeVO vo) throws Exception {
    	delete("WareHouseManageDAO.deleteWareHouseItemRele", vo);
    }
    
    /**
     * 출고 입력
     * @param vo
     * @throws Exception
     */
    public void insertWareHouseItemRele(ItemCodeVO vo) throws Exception {
    	insert("WareHouseManageDAO.insertWareHouseItemRele", vo);
    }
    
    /**
     * 출고 수정
     * @param vo
     * @throws Exception
     */
    public void updateWareHouseItemRele(ItemCodeVO vo) throws Exception {
    	update("WareHouseManageDAO.updateWareHouseItemRele", vo);
    }
    
    /**
     * 입고 데이터 목록 (페이징)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<ItemCodeSearchVO> itemStoreDataList(ItemCodeSearchVO vo) throws Exception {
    	return list("WareHouseManageDAO.itemStoreDataList", vo);
    }
    
    /**
     * 입고 데이터 목록 카운트
     * @param vo
     * @return
     * @throws Exception
     */
    public int itemStoreDataListCnt(ItemCodeSearchVO vo) throws Exception {
    	return (Integer)selectByPk("WareHouseManageDAO.itemStoreDataListCnt", vo);
    }
    
    /**
     * 출고 데이터 목록 (페이징)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<ItemCodeSearchVO> itemReleDataList(ItemCodeSearchVO vo) throws Exception {
    	return list("WareHouseManageDAO.itemReleDataList", vo);
    }
    
    /**
     * 출고 데이터 목록 카운트
     * @param vo
     * @return
     * @throws Exception
     */
    public int itemReleDataListCnt(ItemCodeSearchVO vo) throws Exception {
    	return (Integer)selectByPk("WareHouseManageDAO.itemReleDataListCnt", vo);
    }
    
    /**
     * 정산 데이터 목록 (페이징)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<ItemCodeSearchVO> itemCalcDataList(ItemCalcSearchVO vo) throws Exception {
    	return list("WareHouseManageDAO.itemCalcDataList", vo);
    }
    
    /**
     * 정산 데이터 목록 카운트
     * @param vo
     * @return
     * @throws Exception
     */
    public int itemCalcDataListCnt(ItemCalcSearchVO vo) throws Exception {
    	return (Integer)selectByPk("WareHouseManageDAO.itemCalcDataListCnt", vo);
    }
    
    public int mergeItemCalc(ItemCalcSearchVO vo) throws Exception {
    	return (Integer)update("WareHouseManageDAO.mergeItemCalc", vo);
    }
    
    /**
     * 방제물품 검색 데이터 목록 전체 (페이징)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<ItemCodeSearchVO> itemSearchDataListALL(ItemCodeSearchVO vo) throws Exception {
    	return list("WareHouseManageDAO.itemSearchDataListALL", vo);
    }
    
    /**
     * 방제물품 검색 데이터 전체 카운트
     * @param vo
     * @return
     * @throws Exception
     */
    public int itemSearchDataListCntALL(ItemCodeSearchVO vo) throws Exception {
    	return (Integer)selectByPk("WareHouseManageDAO.itemSearchDataListCntALL", vo);
    }
    
    /**
     * 방제물품 검색 데이터 목록 특정 창고 (페이징)
     * @param vo
     * @return
     * @throws Exception
     */
    public List<ItemCodeSearchVO> itemSearchDataList(ItemCodeSearchVO vo) throws Exception {
    	return list("WareHouseManageDAO.itemSearchDataList", vo);
    }
    
    /**
     * 방제물품 검색 데이터 카운트 특정 창고
     * @param vo
     * @return
     * @throws Exception
     */
    public int itemSearchDataListCnt(ItemCodeSearchVO vo) throws Exception {
    	return (Integer)selectByPk("WareHouseManageDAO.itemSearchDataListCnt", vo);
    }
    
    /**
     * 하나의 창고 정보 
     * @param whCode
     * @return
     * @throws Exception
     */
    public WareHouseVO wareHouseInfo(String whCode) throws Exception {
    	return (WareHouseVO)selectByPk("WareHouseManageDAO.wareHouseInfo", whCode);
    }
    
    /**
     * 아이템 코드 목록 데이터
     * @param vo
     * @return
     * @throws Exception
     */
    public List<ItemCodeSearchVO> itemCodeDataList(ItemCodeSearchVO vo) throws Exception {
    	return list("WareHouseManageDAO.itemCodeDataList", vo);
    }
    
    /**
     * 아이템 코드 목록 데이터 카운트
     * @param vo
     * @return
     * @throws Exception
     */
    public int itemCodeDataListCnt(ItemCodeSearchVO vo) throws Exception {
    	return (Integer)selectByPk("WareHouseManageDAO.itemCodeDataListCnt", vo);
    }
    
    /**
     * merge into 방제물품 현황
     * @param vo
     * @return
     * @throws Exception
     */
    public int mergeWareHouseItemStor(ItemCodeSearchVO vo) throws Exception {
    	return (Integer)update("WareHouseManageDAO.mergeWareHouseItemStor", vo);
    }
    
    /**
     * merge into 방제물품 코드
     * @param vo
     * @return
     * @throws Exception
     */
    public int mergeWareHouseItemCode(ItemCodeSearchVO vo) throws Exception {
    	return (Integer)update("WareHouseManageDAO.mergeWareHouseItemCode", vo);
    }
    
    public int mergeWareHouseItemCodeN(ItemCodeSearchVO vo) throws Exception {
    	return (Integer)update("WareHouseManageDAO.mergeWareHouseItemCodeN", vo);
    }
    
    public int saveWareHouseItemCodeDetail(ItemCodeVO itemCodeVO) throws Exception {
    	return (Integer)update("WareHouseManageDAO.saveWareHouseItemCodeDetail", itemCodeVO);
    }
    
    public void insertWareHouseItemCodeN(ItemCodeSearchVO vo) {
		update("WareHouseManageDAO.insertWareHouseItemCodeN", vo);
	}
	
	public void updateWareHouseItemCodeN(ItemCodeSearchVO vo) {
		update("WareHouseManageDAO.updateWareHouseItemCodeN", vo);
	}
    
    /**
     * 방제물품 창고 데이터 리스트
     * @param vo
     * @return
     * @throws Exception
     */
    public List<WareHouseSearchVO> wareHouseDataList(WareHouseSearchVO vo) throws Exception {
    	return list("WareHouseManageDAO.wareHouseDataList", vo);
    }
    
    /**
     * 방제물품 창고 데이터 리스트 카운트
     * @param vo
     * @return
     * @throws Exception
     */
    public int wareHouseDataListCnt(WareHouseSearchVO vo) throws Exception {
    	return (Integer)selectByPk("WareHouseManageDAO.wareHouseDataListCnt", vo);
    }
    
    /**
     * merge into 방제물품 창고 정보
     * @param vo
     * @return
     * @throws Exception
     */
    public int mergeWareHouse(WareHouseSearchVO vo) throws Exception {
    	return (Integer)update("WareHouseManageDAO.mergeWareHouse", vo);
    } 
    
    /**
     * 지역코드
     * @return
     * @throws Exception
     */
    public List<Map<String,String>> ctyCode() throws Exception {
    	return list("WareHouseManageDAO.ctyCode", null);
    }
    
    public List<Map<String,String>> selectDoCode() throws Exception {
    	return list("WareHouseManageDAO.selectDoCode", null);
    }
    
    public List<Map<String,String>> wareHousectyCode() throws Exception {
    	return list("WareHouseManageDAO.wareHousectyCode", null);
    }
    
    public int duplicateItemCode(ItemCodeSearchVO vo) throws Exception {
    	return (Integer)selectByPk("WareHouseManageDAO.duplicateItemCode", vo);
    }
    
    
	public List CalcTotalCost(ItemCalcSearchVO searchVO) throws Exception {
		return list("WareHouseManageDAO.CalcTotalCost", searchVO);
	}
	
	public void insertWareHouseItemCalc(ItemCalcSearchVO searchVO) throws Exception {
		insert("WareHouseManageDAO.insertWareHouseItemCalcSave", searchVO);
	}
	
	public List WareHouseCalcTotalList(ItemCalcSearchVO searchVO) throws Exception {
		return list("WareHouseManageDAO.WareHouseCalcTotalList", searchVO);
	}
	
	public int WareHouseCalcTotalCnt(ItemCalcSearchVO searchVO) throws Exception  {
		return (Integer)selectByPk("WareHouseManageDAO.WareHouseCalcTotalCnt", searchVO);
	}
	public List getcalcItemPrintInfo(ItemCalcSearchVO itemCalcVO) throws Exception  {
		return list("WareHouseManageDAO.getcalcItemPrintInfo",itemCalcVO);		
	}

	public List getWareHouseManageList(WareHouseManageSearchVO searchVO) {
		return list("WareHouseManageDAO.getWareHouseManageList", searchVO);
	}

	public int getWareHouseManageListCnt(WareHouseManageSearchVO searchVO) {
		return (Integer)selectByPk("WareHouseManageDAO.getWareHouseManageListCnt", searchVO);
	}

	public void insertWareHouseManage(WareHouseVO wareHouseVO) {
		insert("WareHouseManageDAO.insertWareHouseManage", wareHouseVO);
	}

	public List wareHouseManageDeptUpper() {
		return list("WareHouseManageDAO.wareHouseManageDeptUpper", null);
	}

	public List<Map<String, String>> wareHouseManageDeptAdmin(DeptVO deptVO) {
		return list("WareHouseManageDAO.wareHouseManageDeptAdmin", deptVO);
	}

	public List<Map<String, String>> wareHouseManageAdminName(MemberVO memberVO) {
		return list("WareHouseManageDAO.wareHouseManageAdminName", memberVO);
	}

	public void updateWareHouseManage(WareHouseVO wareHouseVO) {
		update("WareHouseManageDAO.updateWareHouseManage", wareHouseVO);
	}

	public List getWareHouseManageDetail(WareHouseVO wareHouseVO) {
		return list("WareHouseManageDAO.getWareHouseManageDetail", wareHouseVO);
	}

	public void deleteWareHouseManage(WareHouseVO wareHouseVO) {
		update("WareHouseManageDAO.deleteWareHouseManage", wareHouseVO);
	}

	public List getItemManageList(ItemManageSearchVO searchVO) {
		return list("WareHouseManageDAO.getItemManageList", searchVO);
	}

	public int getItemManageListCnt(ItemManageSearchVO searchVO) {
		return (Integer)selectByPk("WareHouseManageDAO.getItemManageListCnt", searchVO);
	}

	public List getItemManageDetail(ItemCodeVO itemCodeVO) {
		return list("WareHouseManageDAO.getItemManageDetail", itemCodeVO);
	}

	public void insertItemManage(ItemCodeVO itemCodeVO) {
		
		String code = "";
		String tempItemCode = "";
		
		code = (String)selectByPk("WareHouseManageDAO.getItemCodeNextCode", itemCodeVO);
		
		if(code == null){
			code = "001";
		}
		
		tempItemCode = itemCodeVO.getGroupCode() + code;
		itemCodeVO.setItemCode(tempItemCode);
		
		insert("WareHouseManageDAO.insertItemManage", itemCodeVO);
	}

	public List<Map<String, String>> itemManageUpperGroupCode() {
		return list("WareHouseManageDAO.itemManageUpperGroupCode", null);
	}

	public List<Map<String, String>> itemManageGroupCode(ItemCodeVO itemCodeVO) {
		return list("WareHouseManageDAO.itemManageGroupCode", itemCodeVO);
	}

	public void updateItemManage(ItemCodeVO itemCodeVO) {
		update("WareHouseManageDAO.updateItemManage", itemCodeVO);
	}

	public List<ItemCodeSearchVO> itemUpperGroupDataList(ItemGroupSearchVO searchVO) {
		return list("WareHouseManageDAO.itemUpperGroupDataList", searchVO);
	}

	public int itemUpperGroupDataListCnt(ItemGroupSearchVO searchVO) {
		return (Integer)selectByPk("WareHouseManageDAO.itemUpperGroupDataListCnt", searchVO);
	}

	public List<ItemCodeSearchVO> itemGroupDataList(ItemGroupSearchVO searchVO) {
		return list("WareHouseManageDAO.itemGroupDataList", searchVO);
	}

	public int itemGroupDataListCnt(ItemGroupSearchVO searchVO) {
		return (Integer)selectByPk("WareHouseManageDAO.itemGroupDataListCnt", searchVO);
	}

	public void itemGroupModify(ItemCodeGroupVO itemCodeGroupVO) {
		update("WareHouseManageDAO.itemGroupModify", itemCodeGroupVO);
	}
	
	public String getItemGroupNextCode(ItemCodeGroupVO itemCodeGroupVO) {
		
		return (String)selectByPk("WareHouseManageDAO.getItemGroupNextCode", itemCodeGroupVO);
	}
	
	public String getMaxItemCode(ItemCodeSearchVO itemCodeSearchVO){
		return (String)selectByPk("WareHouseManageDAO.getMaxItemCode", itemCodeSearchVO);
	}

	public void itemGroupInsert(ItemCodeGroupVO itemCodeGroupVO) {
		String code = "";
		String tempGroupCode = "";
		
		code = (String)selectByPk("WareHouseManageDAO.getItemGroupNextCode", itemCodeGroupVO);
		
		if(code == null){
			code = "01";
		}
		
		tempGroupCode = itemCodeGroupVO.getUpperGroupCode() + code;
		
		itemCodeGroupVO.setGroupCode(tempGroupCode);
		
		insert("WareHouseManageDAO.itemGroupInsert", itemCodeGroupVO);
	}

	public void itemUpperGroupInsert(ItemCodeGroupVO itemCodeGroupVO) {
		insert("WareHouseManageDAO.itemUpperGroupInsert", itemCodeGroupVO);
	}

	public List getItemConditionManageList(ItemConditionManageSearchVO searchVO) {
		return list("WareHouseManageDAO.getItemConditionManageList", searchVO);
	}
	
	public int getItemConditionManageListCnt(ItemConditionManageSearchVO searchVO) {
		return (Integer)selectByPk("WareHouseManageDAO.getItemConditionManageListCnt", searchVO);
	}

	public List<Map<String, String>> itemConditionCode(ItemCodeVO itemCodeVO) {
		return list("WareHouseManageDAO.itemConditionCode", itemCodeVO);
	}
	
	public List<Map<String, String>> itemCodeInWareHouse(WareHouseVO wareHouseVO) {
		return list("WareHouseManageDAO.itemCodeInWareHouse", wareHouseVO);
	}

	public List<Map<String, String>> getWareHouseCode(WareHouseVO wareHouseVO) {
		return list("WareHouseManageDAO.getWareHouseCode", wareHouseVO);
	}

	public List<Map<String, String>> getItemDetailValue(ItemCodeVO itemCodeVO) {
		return list("WareHouseManageDAO.getItemDetailValue", itemCodeVO);
	}

	public void insertItemConditionStor(ItemCodeVO itemCodeVO) {
		insert("WareHouseManageDAO.insertItemConditionStor", itemCodeVO);
	}

	public List getItemConditionReleDetail(ItemCodeVO itemCodeVO) {
		return list("WareHouseManageDAO.getItemConditionReleDetail", itemCodeVO);
	}

	public void insertItemConditionRele(ItemCodeVO itemCodeVO) {
		insert("WareHouseManageDAO.insertItemConditionRele", itemCodeVO);
	}

	public List<ItemCodeSearchVO> itemCalculateManageList(ItemCodeSearchVO searchVO) {
		String searchType = (String)searchVO.getSearchType();
		
		String strQuery = "";
		if(searchType.equals("river")){
			strQuery = "WareHouseManageDAO.itemCalculateRiverList";
		}else if(searchType.equals("warehouse")){
			strQuery = "WareHouseManageDAO.itemCalculateWareHouseList";
		}else if(searchType.equals("item")){
			strQuery = "WareHouseManageDAO.itemCalculateItemList";
		}	
		return list(strQuery, searchVO);
	}
	
	public List itemCalculateManageDetailList(ItemCodeVO itemCodeVO) {
		return list("WareHouseManageDAO.itemCalculateManageDetailList", itemCodeVO);
	}

	public int itemCalculateManageListCnt(ItemCodeSearchVO searchVO) {
		String searchType = (String)searchVO.getSearchType();
		
		String strQuery = "";
		if(searchType.equals("river")){
			strQuery = "WareHouseManageDAO.itemCalculateRiverListCnt";
		}else if(searchType.equals("warehouse")){
			strQuery = "WareHouseManageDAO.itemCalculateWarehouseListCnt";
		}else if(searchType.equals("item")){
			strQuery = "WareHouseManageDAO.itemCalculateItemListCnt";
		}	
		return (Integer)selectByPk(strQuery, searchVO);
	}

	public List<ItemCodeSearchVO> getItemCalculateManageDetail(ItemCodeSearchVO searchVO) {
		return list("WareHouseManageDAO.getItemCalculateManageDetail", searchVO);
	}

	public int getItemCalculateManageDetailCnt(ItemCodeSearchVO searchVO) {	
		return (Integer)selectByPk("WareHouseManageDAO.getItemCalculateManageDetailCnt", searchVO);
	}

	public List<ItemCodeSearchVO> itemUpperGroupCodeDup(ItemCodeGroupVO itemCodeGroupVO) {
		return list("WareHouseManageDAO.itemUpperGroupCodeDup", itemCodeGroupVO);
	}

	public List<Map<String, String>> getAdminTelNo(MemberVO memberVO) {
		return list("WareHouseManageDAO.getAdminTelNo", memberVO);
	}

	public List getWarehouseAddrList(WareHouseZipcodeVO zipcodeVO) {
		return list("WareHouseManageDAO.getWarehouseAddrList", zipcodeVO);
	}
	
	public List<Map<String,String>> getRiverCodeTwo(){
		return list("WareHouseManageDAO.getRiverCodeTwo",null);
	}
	
	public List<Map<String,String>> getUpperDeptCode(){
		return list("WareHouseManageDAO.getUpperDeptCode",null);
	}
	
	public List<Map<String,String>> getDeptCode(Map<String,String> mapParam){
		return list("WareHouseManageDAO.getDeptCode",mapParam);
	}
	
	public String getMaxWareHouseCode(){
		return (String) selectByPk("WareHouseManageDAO.getMaxWareHouseCode",null);
	}
	
	public List<MemberSearchVO> getSearchMember(MemberSearchVO memberSearchVO){
		return list("WareHouseManageDAO.getSearchMember",memberSearchVO);
	}
	
	public List<WareHouseSearchVO> getSearchWareHouseList(WareHouseSearchVO wareHouseSearchVO){
		
		return list("WareHouseManageDAO.getSearchWareHouseList",wareHouseSearchVO);
	}
	
	public List<ItemCodeVO> getSearchItemStockList(ItemCodeSearchVO searchVO){
		return list("WareHouseManageDAO.getSearchItemStockList" , searchVO);
	}
	
	public void addItemInOut(ItemCodeVO itemCodeVO){
		insert("WareHouseManageDAO.addItemInOut", itemCodeVO);
	}
	
	public void modifyItemInOut(ItemCodeVO itemCodeVO){
		update("WareHouseManageDAO.modifyItemInOut", itemCodeVO);
	}
	
	public int mergeItemStock(ItemCodeVO itemCodeVO){
		return (Integer)update("WareHouseManageDAO.mergeItemStock", itemCodeVO);
	}
	
	public List<ItemCodeVO> getItemInOutList(ItemCodeSearchVO searchVO){
		return list("WareHouseManageDAO.getItemInOutList",searchVO);
	}
	
	public List<ItemCodeVO> itemWarehouseManage(ItemCodeSearchVO searchVO) {
		return list("WareHouseManageDAO.itemWarehouseManage",searchVO);
	}

	public List getItemHoldConditionList(ItemConditionManageSearchVO searchVO) {
		
		String whName = (String)selectByPk("WareHouseManageDAO.getWhNameList",searchVO);
		searchVO.setWhName(null);
		searchVO.setWhName(whName.replace("^", "'"));
		
		return list("WareHouseManageDAO.getItemHoldConditionList", searchVO);
	}

	public int getItemHoldConditionListCnt(ItemConditionManageSearchVO searchVO) {
		// TODO Auto-generated method stub
		return (Integer)selectByPk("WareHouseManageDAO.getItemHoldConditionListCnt", searchVO);
	}

	public List<Map<String, String>> getWareHouseNames(WareHouseVO wareHouseVO) {
		// TODO Auto-generated method stub
		return list("WareHouseManageDAO.getWareHouseNames", wareHouseVO);
	}
	
	/**
	 * 동일 시간 동일 물품 입고(출고) 중복 확인
	 * @param itemCodeVO
	 * @return
	 */
	public int checkDuplicateItemInOut(ItemCodeVO itemCodeVO){
		return (Integer)selectByPk("WareHouseManageDAO.checkDuplicateItemInOut", itemCodeVO);
	}
	
	/**
	 * 물품 상세 정보를 조회 ItemCodeVO itemCodeVO
	 * @param itemCodeVO
	 * @return
	 */
	public ItemCodeVO showItemDetailView(ItemCodeVO itemCodeVO){
		return (ItemCodeVO) selectByPk("WareHouseManageDAO.showItemDetailView", itemCodeVO);
	}
//	public WareHouseItemDetailVO showItemDetailView(WareHouseItemDetailVO wareHouseItemDetailVO){
//		return (WareHouseItemDetailVO) selectByPk("WareHouseManageDAO.showItemDetailView", wareHouseItemDetailVO);
//	}
	
	@SuppressWarnings("unchecked")
	public List<ItemCodeVO> getLocationOfItemStockList(ItemCodeVO itemCodeVO){
		return list("WareHouseManageDAO.getLocationOfItemStockList", itemCodeVO);
	}
	
	@SuppressWarnings("unchecked")
	public List<ItemCodeVO> getLocationOfItemStockDeptList(ItemCodeVO itemCodeVO){
		return list("WareHouseManageDAO.getLocationOfItemStockDeptList", itemCodeVO);
	}
	
	/**
	 * 물품 상세 정보를 저장
	 * @param itemCodeVO
	 */
	public int saveItemDetailView(ItemCodeVO itemCodeVO){
		return (Integer)update("WareHouseManageDAO.saveItemDetailView", itemCodeVO);
	}
	
	/**
	 * 창고가 재고를 보유하고 있는지 여부
	 * @param wareHouseVO
	 * @return
	 */
	public String hasItemStock(WareHouseVO wareHouseVO){
		return (String)selectByPk("WareHouseManageDAO.hasItemStock", wareHouseVO);
	}
	
	/**
	 * 창고 삭제
	 * @param wareHouseVO
	 * @return
	 */
	public int deleteWareHouse(WareHouseVO wareHouseVO){
		return (Integer)delete("WareHouseManageDAO.deleteWareHouse", wareHouseVO);
	}
	
	/**
	 * 방제장비물품현황 등록
	 * @param wareHouseVO
	 */
	public int insertItemConditionInfo(ExcelItemVO vo){
		return (Integer)update("WareHouseManageDAO.insertItemConditionInfo", vo);
	}
	
	/**
	 * 방제장비물품현황 상세
	 */
	@SuppressWarnings("unchecked")
	public List<ExcelItemVO> selectItemConditionList(){
		return list("WareHouseManageDAO.selectItemConditionList", null);
	}
	
	/**
	 * 방제장비물품현황 상세
	 */
	@SuppressWarnings("unchecked")
	public List<ExcelItemVO> selectItemConditionDetail(String stdDate){
		return list("WareHouseManageDAO.selectItemConditionDetail", stdDate);
	}
}
