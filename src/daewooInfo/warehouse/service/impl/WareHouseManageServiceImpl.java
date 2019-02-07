package daewooInfo.warehouse.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
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
import daewooInfo.warehouse.dao.WareHouseManageDAO;
import daewooInfo.warehouse.service.WareHouseManageService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

/**
 * 
 * 공통코드에 대한 서비스 구현클래스를 정의한다
 * @author kisspa
 * @since 2010.06.18
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2010.06.18  kisspa          최초 생성
 *
 * </pre>
 */
@Service("WareHouseManageService")
public class WareHouseManageServiceImpl extends AbstractServiceImpl implements WareHouseManageService {

    /**
	 * @uml.property  name="wareHouseManageDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="WareHouseManageDAO")
    private WareHouseManageDAO wareHouseManageDAO;

	public List<WareHouseVO> selectWareHouseList(WareHouseVO wareHouseVO) throws Exception {
		return wareHouseManageDAO.selectWareHouseList(wareHouseVO);
	}

	public List<ItemCodeVO> selectWareHouseItemListDetail_rele(SearchVO vo)
			throws Exception {
		return wareHouseManageDAO.selectWareHouseItemListDetail_rele(vo);
	}

	public List<ItemCodeVO> selectWareHouseItemListDetail_store(SearchVO vo)
			throws Exception {
		return wareHouseManageDAO.selectWareHouseItemListDetail_store(vo);
	}

	public List<ItemCodeVO> selectWareHouseItemListSimpleAll(SearchVO vo)
			throws Exception {
		return wareHouseManageDAO.selectWareHouseItemListSimpleAll(vo);
	}

	public List<ItemCodeVO> selectWareHouseItemListSimpleOne(SearchVO vo)
			throws Exception {
		return wareHouseManageDAO.selectWareHouseItemListSimpleOne(vo);
	}

	public List<ItemCodeVO> selectWareHouseItemCodeList(SearchVO vo) throws Exception {
		return wareHouseManageDAO.selectWareHouseItemCodeList(vo);
	}

	public void insertWareHouseItemCode(ItemCodeVO vo) throws Exception {
		wareHouseManageDAO.insertWareHouseItemCode(vo);
	}

	public void updateWareHouseItemCode(ItemCodeVO vo) throws Exception {
		wareHouseManageDAO.updateWareHouseItemCode(vo);
	}
	
	public List<ItemCodeVO> selectWareHouseItemStorList(SearchVO vo)
		throws Exception {
		return wareHouseManageDAO.selectWareHouseItemStorList(vo);
	}
	
	public int deleteWareHouseItemStor(ItemCodeVO vo) throws Exception {
		return wareHouseManageDAO.deleteWareHouseItemStor(vo);
	}

	public void insertWareHouseItemStor(ItemCodeVO vo) throws Exception {
		wareHouseManageDAO.insertWareHouseItemStor(vo);
	}

	public void updateWareHouseItemStor(ItemCodeVO vo) throws Exception {
		wareHouseManageDAO.updateWareHouseItemStor(vo);
	}
	
	public List<ItemCodeVO> selectWareHouseItemReleList(SearchVO vo)
		throws Exception {
		return wareHouseManageDAO.selectWareHouseItemReleList(vo);
	}
	
	public void deleteWareHouseItemRele(ItemCodeVO vo) throws Exception {
		wareHouseManageDAO.deleteWareHouseItemRele(vo);
	}
	
	public void insertWareHouseItemRele(ItemCodeVO vo) throws Exception {
		wareHouseManageDAO.insertWareHouseItemRele(vo);
	}
	
	public void updateWareHouseItemRele(ItemCodeVO vo) throws Exception {
		wareHouseManageDAO.updateWareHouseItemRele(vo);
	}

	public List<ItemCodeSearchVO> itemStoreDataList(ItemCodeSearchVO vo)
			throws Exception {
		return wareHouseManageDAO.itemStoreDataList(vo);
	}

	public int itemStoreDataListCnt(ItemCodeSearchVO vo)
			throws Exception {
		return wareHouseManageDAO.itemStoreDataListCnt(vo);
	}
	
	public List<ItemCodeSearchVO> itemReleDataList(ItemCodeSearchVO vo)
		throws Exception {
		return wareHouseManageDAO.itemReleDataList(vo);
	}
	
	public int itemReleDataListCnt(ItemCodeSearchVO vo)
		throws Exception {
		return wareHouseManageDAO.itemReleDataListCnt(vo);
	}
	
	public List<ItemCodeSearchVO> itemCalcDataList(ItemCalcSearchVO vo)
		throws Exception {
		return wareHouseManageDAO.itemCalcDataList(vo);
	}
	
	public int itemCalcDataListCnt(ItemCalcSearchVO vo)
		throws Exception {
		return wareHouseManageDAO.itemCalcDataListCnt(vo);
	}
	
	public int mergeItemCalc(ItemCalcSearchVO vo)
		throws Exception {
		return wareHouseManageDAO.mergeItemCalc(vo);
	}

	public List<ItemCodeSearchVO> itemSearchDataList(ItemCodeSearchVO vo)
			throws Exception {
		return wareHouseManageDAO.itemSearchDataList(vo);
	}

	public int itemSearchDataListCnt(ItemCodeSearchVO vo) throws Exception {
		return wareHouseManageDAO.itemSearchDataListCnt(vo);
	}
	
	public List<ItemCodeSearchVO> itemSearchDataListALL(ItemCodeSearchVO vo)
		throws Exception {
	return wareHouseManageDAO.itemSearchDataListALL(vo);
	}
	
	public int itemSearchDataListCntALL(ItemCodeSearchVO vo) throws Exception {
		return wareHouseManageDAO.itemSearchDataListCntALL(vo);
	}

	public WareHouseVO wareHouseInfo(String whCode) throws Exception {
		return wareHouseManageDAO.wareHouseInfo(whCode);
	}

	public List<ItemCodeSearchVO> itemCodeDataList(ItemCodeSearchVO vo)
			throws Exception {
		return wareHouseManageDAO.itemCodeDataList(vo);
	}

	public int itemCodeDataListCnt(ItemCodeSearchVO vo) throws Exception {
		return wareHouseManageDAO.itemCodeDataListCnt(vo);
	}

	public int mergeWareHouseItemStor(ItemCodeSearchVO vo) throws Exception {
		return wareHouseManageDAO.mergeWareHouseItemStor(vo);
	}
	
	public int mergeWareHouseItemCode(ItemCodeSearchVO vo) throws Exception {
		return wareHouseManageDAO.mergeWareHouseItemCode(vo);
	}
	
	public int mergeWareHouseItemCodeN(ItemCodeSearchVO vo) throws Exception {
		if(wareHouseManageDAO.duplicateItemCode(vo) > 0) {
			wareHouseManageDAO.updateWareHouseItemCodeN(vo);
		}else {
			wareHouseManageDAO.insertWareHouseItemCodeN(vo);
		}
		return 1;
		//return wareHouseManageDAO.mergeWareHouseItemCodeN(vo);
	}

	public int saveWareHouseItemCodeDetail(ItemCodeVO itemCodeVO) throws Exception {
		return wareHouseManageDAO.saveWareHouseItemCodeDetail(itemCodeVO);
	}
	
	public List<WareHouseSearchVO> wareHouseDataList(WareHouseSearchVO vo) throws Exception {
		return wareHouseManageDAO.wareHouseDataList(vo);
	}

	public int wareHouseDataListCnt(WareHouseSearchVO vo) throws Exception {
		return wareHouseManageDAO.wareHouseDataListCnt(vo);
	}

	public int mergeWareHouse(WareHouseSearchVO vo) throws Exception {
		return wareHouseManageDAO.mergeWareHouse(vo);
	}
	
	public List<Map<String, String>> ctyCode() throws Exception {
		return wareHouseManageDAO.ctyCode();
	}
	
	public List<Map<String, String>> selectDoCode() throws Exception {
		return wareHouseManageDAO.selectDoCode();
	}
	
	public List<Map<String, String>> wareHousectyCode() throws Exception {
		return wareHouseManageDAO.wareHousectyCode();
	}

	public int duplicateItemCode(ItemCodeSearchVO vo) throws Exception {
		return wareHouseManageDAO.duplicateItemCode(vo);
	}

	public List CalcTotalCost(ItemCalcSearchVO searchVO) throws Exception {
		return wareHouseManageDAO.CalcTotalCost(searchVO);
	}

	public void insertWareHouseItemCalc(ItemCalcSearchVO searchVO)throws Exception {
		wareHouseManageDAO.insertWareHouseItemCalc(searchVO);
	}

	public List WareHouseCalcTotalList(ItemCalcSearchVO searchVO) throws Exception {
		
		return wareHouseManageDAO.WareHouseCalcTotalList(searchVO);
	}
	public int WareHouseCalcTotalCnt(ItemCalcSearchVO searchVO) throws Exception {
	 
		return wareHouseManageDAO.WareHouseCalcTotalCnt(searchVO);
	}

	public List getcalcItemPrintInfo(ItemCalcSearchVO itemCalcVO) throws Exception {
		return wareHouseManageDAO.getcalcItemPrintInfo(itemCalcVO);
	}

	public List getWareHouseManageList(WareHouseManageSearchVO searchVO) {
		return wareHouseManageDAO.getWareHouseManageList(searchVO);
	}

	public int getWareHouseManageListCnt(WareHouseManageSearchVO searchVO) {
		return wareHouseManageDAO.getWareHouseManageListCnt(searchVO);
	}

	public void insertWareHouseManage(WareHouseVO wareHouseVO){		
		wareHouseManageDAO.insertWareHouseManage(wareHouseVO);		
	}

	public List wareHouseManageDeptUpper() {
		return wareHouseManageDAO.wareHouseManageDeptUpper();
	}

	public List<Map<String, String>> wareHouseManageDeptAdmin(DeptVO deptVO) {
		return wareHouseManageDAO.wareHouseManageDeptAdmin(deptVO);
	}

	public List<Map<String, String>> wareHouseManageAdminName(MemberVO memberVO) {
		return wareHouseManageDAO.wareHouseManageAdminName(memberVO);
	}

	public void updateWareHouseManage(WareHouseVO wareHouseVO) {
		wareHouseManageDAO.updateWareHouseManage(wareHouseVO);
	}

	public List getWareHouseManageDetail(WareHouseVO wareHouseVO) {
		return wareHouseManageDAO.getWareHouseManageDetail(wareHouseVO);
	}

	public void deleteWareHouseManage(WareHouseVO wareHouseVO) {
		wareHouseManageDAO.deleteWareHouseManage(wareHouseVO);		
	}

	public List getItemManageList(ItemManageSearchVO searchVO) {
		return wareHouseManageDAO.getItemManageList(searchVO);
	}

	public int getItemManageListCnt(ItemManageSearchVO searchVO) {
		return wareHouseManageDAO.getItemManageListCnt(searchVO);
	}

	public List getItemManageDetail(ItemCodeVO itemCodeVO) {
		return wareHouseManageDAO.getItemManageDetail(itemCodeVO);
	}

	public void insertItemManage(ItemCodeVO itemCodeVO) {
		wareHouseManageDAO.insertItemManage(itemCodeVO);
		
	}

	public List<Map<String, String>> itemManageUpperGroupCode() {
		return wareHouseManageDAO.itemManageUpperGroupCode();
	}

	public List<Map<String, String>> itemManageGroupCode(ItemCodeVO itemCodeVO) {
		return wareHouseManageDAO.itemManageGroupCode(itemCodeVO);
	}

	public void updateItemManage(ItemCodeVO itemCodeVO) {
		wareHouseManageDAO.updateItemManage(itemCodeVO);
	}

	public List<ItemCodeSearchVO> itemUpperGroupDataList(ItemGroupSearchVO searchVO) {
		return wareHouseManageDAO.itemUpperGroupDataList(searchVO);
	}

	public int itemUpperGroupDataListCnt(ItemGroupSearchVO searchVO) {
		return wareHouseManageDAO.itemUpperGroupDataListCnt(searchVO);
	}

	public List<ItemCodeSearchVO> itemGroupDataList(ItemGroupSearchVO searchVO) {
		return wareHouseManageDAO.itemGroupDataList(searchVO);
	}

	public int itemGroupDataListCnt(ItemGroupSearchVO searchVO) {
		return wareHouseManageDAO.itemGroupDataListCnt(searchVO);
	}

	public void itemGroupModify(ItemCodeGroupVO itemCodeGroupVO) {		
		wareHouseManageDAO.itemGroupModify(itemCodeGroupVO);
	}
	
	public void itemUpperGroupInsert(ItemCodeGroupVO itemCodeGroupVO) {		
		wareHouseManageDAO.itemUpperGroupInsert(itemCodeGroupVO);			
	}

	public void itemGroupInsert(ItemCodeGroupVO itemCodeGroupVO) {
		wareHouseManageDAO.itemGroupInsert(itemCodeGroupVO);		
	}

	public List getItemConditionManageList(ItemConditionManageSearchVO searchVO) {
		
		return wareHouseManageDAO.getItemConditionManageList(searchVO);
	}
	public List getItemHoldConditionList(ItemConditionManageSearchVO searchVO) {
		
		return wareHouseManageDAO.getItemHoldConditionList(searchVO);
	}
	public int getItemConditionManageListCnt(ItemConditionManageSearchVO searchVO) {
		return wareHouseManageDAO.getItemConditionManageListCnt(searchVO);
	}

	public List<Map<String, String>> itemConditionCode(ItemCodeVO itemCodeVO) {
		return wareHouseManageDAO.itemConditionCode(itemCodeVO);
	}

	public List<Map<String, String>> itemCodeInWareHouse(WareHouseVO wareHouseVO) {
		return wareHouseManageDAO.itemCodeInWareHouse(wareHouseVO);
	}
	
	public List<Map<String, String>> getWareHouseCode(WareHouseVO wareHouseVO) {
		return wareHouseManageDAO.getWareHouseCode(wareHouseVO);
	}

	public List<Map<String, String>> getItemDetailValue(ItemCodeVO itemCodeVO) {
		return wareHouseManageDAO.getItemDetailValue(itemCodeVO);
	}

	public void insertItemConditionStor(ItemCodeVO itemCodeVO) {
		wareHouseManageDAO.insertItemConditionStor(itemCodeVO);
	}

	public List getItemConditionReleDetail(ItemCodeVO itemCodeVO) {
		return wareHouseManageDAO.getItemConditionReleDetail(itemCodeVO);
	}

	public void insertItemConditionRele(ItemCodeVO itemCodeVO) {
		wareHouseManageDAO.insertItemConditionRele(itemCodeVO);
	}

	public List<ItemCodeSearchVO> itemCalculateManageList(ItemCodeSearchVO searchVO) {
		return wareHouseManageDAO.itemCalculateManageList(searchVO);
	}
	
	public List<ItemCodeSearchVO> itemCalculateManageDetailList(ItemCodeVO itemCodeVO) {
		return wareHouseManageDAO.itemCalculateManageDetailList(itemCodeVO);
	}

	public int itemCalculateManageListCnt(ItemCodeSearchVO searchVO) {	// TODO Auto-generated method stub
		return wareHouseManageDAO.itemCalculateManageListCnt(searchVO);
	}

	public List<ItemCodeSearchVO> getItemCalculateManageDetail(ItemCodeSearchVO searchVO) {
		return wareHouseManageDAO.getItemCalculateManageDetail(searchVO);
	}

	public int getItemCalculateManageDetailCnt(ItemCodeSearchVO searchVO) {
		return wareHouseManageDAO.getItemCalculateManageDetailCnt(searchVO);
	}

	public List<ItemCodeSearchVO> itemUpperGroupCodeDup(ItemCodeGroupVO itemCodeGroupVO) {
		return wareHouseManageDAO.itemUpperGroupCodeDup(itemCodeGroupVO);
	}

	public List<Map<String, String>> getAdminTelNo(MemberVO memberVO) {
		return wareHouseManageDAO.getAdminTelNo(memberVO);
	}

	public List getWarehouseAddrList(WareHouseZipcodeVO zipcodeVO) {
		return wareHouseManageDAO.getWarehouseAddrList(zipcodeVO);
	}

	public String getItemGroupNextCode(ItemCodeGroupVO itemCodeGroupVO) {
		// TODO Auto-generated method stub
		return wareHouseManageDAO.getItemGroupNextCode(itemCodeGroupVO);
	}	
	
	public String getMaxItemCode(ItemCodeSearchVO itemCodeSearchVO){
		
		return wareHouseManageDAO.getMaxItemCode(itemCodeSearchVO);
	}

	public List<Map<String,String>> getRiverCodeTwo() {
		// TODO Auto-generated method stub
		
		return wareHouseManageDAO.getRiverCodeTwo();
	}

	public List<Map<String, String>> getUpperDeptCode() {
		// TODO Auto-generated method stub
		return wareHouseManageDAO.getUpperDeptCode();
	}

	public List<Map<String, String>> getDeptCode(Map<String, String> mapParam) {
		// TODO Auto-generated method stub
		return wareHouseManageDAO.getDeptCode(mapParam);
	}

	public String getMaxWareHouseCode() {
		// TODO Auto-generated method stub
		return wareHouseManageDAO.getMaxWareHouseCode();
	}

	public List<MemberSearchVO> getSearchMember(MemberSearchVO memberSearchVO) {
		// TODO Auto-generated method stub
		return wareHouseManageDAO.getSearchMember(memberSearchVO);
	}

	public List<WareHouseSearchVO> getSearchWareHouseList(WareHouseSearchVO wareHouseSearchVO) {
		// TODO Auto-generated method stub
		return wareHouseManageDAO.getSearchWareHouseList(wareHouseSearchVO);
	}

	public List<ItemCodeVO> getSearchItemStockList(ItemCodeSearchVO searchVO) {
		// TODO Auto-generated method stub
		return wareHouseManageDAO.getSearchItemStockList(searchVO);
	}

	public void addItemInOut(ItemCodeVO itemCodeVO) {
		// TODO Auto-generated method stub
		wareHouseManageDAO.addItemInOut(itemCodeVO);
	}

	public void modifyStockItem(ItemCodeVO itemCodeVO) {
		// TODO Auto-generated method stub
		wareHouseManageDAO.modifyItemInOut(itemCodeVO);
	}

	public int mergeItemStock(ItemCodeVO itemCodeVO) {
		// TODO Auto-generated method stub
		return wareHouseManageDAO.mergeItemStock(itemCodeVO);
	}
	
	public int tranItemInOut(ItemCodeVO itemCodeVO){
		wareHouseManageDAO.addItemInOut(itemCodeVO);
		return wareHouseManageDAO.mergeItemStock(itemCodeVO);
	}

	public List<ItemCodeVO> getItemInOutList(ItemCodeSearchVO searchVO) {
		// TODO Auto-generated method stub
		return wareHouseManageDAO.getItemInOutList(searchVO);
	}
	
	public List<Map<String, String>> getWareHouseNames(WareHouseVO wareHouseVO) {
		return wareHouseManageDAO.getWareHouseNames(wareHouseVO);
	}
	public List<ItemCodeVO> itemWarehouseManage(ItemCodeSearchVO searchVO) {
		// TODO Auto-generated method stub
		return wareHouseManageDAO.itemWarehouseManage(searchVO);
	}
	public int getItemHoldConditionListCnt(ItemConditionManageSearchVO searchVO) {
		return wareHouseManageDAO.getItemHoldConditionListCnt(searchVO);
	}
	
	/**
	 * 동일 시간 동일 물품 입고(출고) 중복 확인
	 * @param itemCodeVO
	 * @return
	 */
	public int checkDuplicateItemInOut(ItemCodeVO itemCodeVO){
		return wareHouseManageDAO.checkDuplicateItemInOut(itemCodeVO);
	}
	
	/**
	 * 물품 상세 정보를 조회
	 * @param itemCodeVO
	 */
	public ItemCodeVO showItemDetailView(ItemCodeVO itemCodeVO){
		return wareHouseManageDAO.showItemDetailView(itemCodeVO);
	}
//	public WareHouseItemDetailVO showItemDetailView(WareHouseItemDetailVO wareHouseItemDetailVO){
//		return wareHouseManageDAO.showItemDetailView(wareHouseItemDetailVO);
//	}
	
	public List<ItemCodeVO> getLocationOfItemStockList(ItemCodeVO itemCodeVO){
		return wareHouseManageDAO.getLocationOfItemStockList(itemCodeVO);
	}
	
	public List<ItemCodeVO> getLocationOfItemStockDeptList(ItemCodeVO itemCodeVO){
		return wareHouseManageDAO.getLocationOfItemStockDeptList(itemCodeVO);
	}
	
	/**
	 * 물품 상세 정보를 저장
	 * @param itemCodeVO
	 */
	public int saveItemDetailView(ItemCodeVO itemCodeVO){
		return wareHouseManageDAO.saveItemDetailView(itemCodeVO);
	}
	
	public String deleteWareHouse(WareHouseVO wareHouseVO){
		String status = "";
		String stockTot = "";
		
		stockTot = wareHouseManageDAO.hasItemStock(wareHouseVO);
		if(stockTot != null && Integer.parseInt(stockTot.trim()) > 0){
			// 재고 보유
			status = "hasItem";
		}else{
			// 재고 없음
			if(wareHouseManageDAO.deleteWareHouse(wareHouseVO) > 0){
				status = "success";
			}else{
				status = "noWarehouse";
			}
		}
		return status;
	}
	
	/**
	 * 방제장비물품현황 등록
	 * @param wareHouseVO
	 */
	public int insertItemConditionInfoXls(MultipartHttpServletRequest req, FileVO fvo, WareHouseVO wareHouseVO){
		
		// 반환할 객체를 생성
		List<ExcelItemVO> list = new ArrayList<ExcelItemVO>();

		MultipartFile file = req.getFile("excel");

		HSSFWorkbook workbook = null;
		int resultCnt = 0;
		
		try {
			// HSSFWorkbook은 엑셀파일 전체 내용을 담고 있는 객체
			workbook = new HSSFWorkbook(file.getInputStream());
	
			// 탐색에 사용할 Sheet, Row, Cell 객체
			HSSFSheet curSheet;
			HSSFRow curRow;
			HSSFCell curCell;
			ExcelItemVO vo = null;

			String stdDate = "";
			// Sheet 탐색 for문
			for (int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++) {
				// 현재 sheet 반환
				curSheet = workbook.getSheetAt(sheetIndex);
				// row 탐색 for문
				for (int rowIndex = 0; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++) {
					// row 0은 헤더정보이기 때문에 무시
					if (rowIndex != 0 && rowIndex != 2 && rowIndex != 3) {
						curRow = curSheet.getRow(rowIndex);
						if(rowIndex != 1) {
							vo = new ExcelItemVO();
						}
						String value;
				
						// row의 첫번째 cell값이 비어있지 않는 경우만 cell탐색
						//if (curRow.getCell(0) != null) {
							//if (!"".equals(curRow.getCell(0).getStringCellValue())) {
								// cell 탐색 for문
								for (int cellIndex = 0; cellIndex < curRow.getLastCellNum(); cellIndex++) {
									curCell = curRow.getCell(cellIndex);
									if(curCell != null) {
										if (true) {
											value = "";
											// cell 스타일이 다르더라도 String으로 반환 받음
											switch (curCell.getCellType()) {
												case HSSFCell.CELL_TYPE_FORMULA:
													value = curCell.getNumericCellValue() + "";
													break;
												case HSSFCell.CELL_TYPE_NUMERIC:
													value = curCell.getNumericCellValue() + "";
													break;
												case HSSFCell.CELL_TYPE_STRING:
													value = curCell.getStringCellValue() + "";
													break;
												case HSSFCell.CELL_TYPE_BLANK:
													value = "0.0";
													break;
												case HSSFCell.CELL_TYPE_ERROR:
													value = curCell.getErrorCellValue() + "";
													break;
												default:
													value = new String();
													break;
											} // end switch
									
											if(rowIndex == 1) {
											// 현재 colum index에 따라서 vo입력
												switch (cellIndex) {
													case 9: // 나이
														stdDate = value;
														break;
													default:
														break;
												}
											} else {
												vo.setStdDate(stdDate);
												switch (cellIndex) {
													case 5: 
														vo.setDept1001Cnt(value);
														break;
													case 6:
														vo.setDept1002Cnt(value);
														break;
													case 7:
														vo.setDept1004Cnt(value);
														break;
													case 8:
														vo.setDept1003Cnt(value);
														break;
													case 9:
														vo.setDept1005Cnt(value);
														break;
													default:
														vo.setStdDate(stdDate);
														break;
												}
											}
										} // end if
									}
								} // end for
								// cell 탐색 이후 vo 추가
								//vo.setStdDate(stdDate);
								if(rowIndex!=1) list.add(vo);
							//} // end
						//} // end if
					}
				}
			}
			
			for(int i=0;i<list.size();i++) {
				resultCnt += wareHouseManageDAO.insertItemConditionInfo(list.get(i));
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resultCnt;
	}
	
	/**
	 * 방제장비물품현황 등록
	 * @param wareHouseVO
	 */
	public int insertItemConditionInfoXlsx(MultipartHttpServletRequest req, FileVO fvo, WareHouseVO wareHouseVO){
		
		// 반환할 객체를 생성
		List<ExcelItemVO> list = new ArrayList<ExcelItemVO>();

		MultipartFile file = req.getFile("excel");

		XSSFWorkbook workbook = null;
		
		int resultCnt = 0;
		
		try {
			// HSSFWorkbook은 엑셀파일 전체 내용을 담고 있는 객체
			workbook = new XSSFWorkbook(file.getInputStream());
	
			// 탐색에 사용할 Sheet, Row, Cell 객체
			XSSFSheet curSheet;
			XSSFRow curRow;
			XSSFCell curCell;
			ExcelItemVO vo = null;
			
			String stdDate = "";
			// Sheet 탐색 for문
			for (int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++) {
				// 현재 sheet 반환
				curSheet = workbook.getSheetAt(sheetIndex);
				// row 탐색 for문
				for (int rowIndex = 0; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++) {
					// row 0은 헤더정보이기 때문에 무시
					if (rowIndex != 0 && rowIndex != 2 && rowIndex != 3) {
						curRow = curSheet.getRow(rowIndex);
						if(rowIndex != 1) {
							vo = new ExcelItemVO();
						}
						String value;
				
						// row의 첫번째 cell값이 비어있지 않는 경우만 cell탐색
						//if (curRow.getCell(0) != null) {
							//if (!"".equals(curRow.getCell(0).getStringCellValue())) {
								// cell 탐색 for문
								for (int cellIndex = 0; cellIndex < curRow.getLastCellNum(); cellIndex++) {
									curCell = curRow.getCell(cellIndex);
									if(curCell != null) {
										if (true) {
											value = "";
											// cell 스타일이 다르더라도 String으로 반환 받음
											switch (curCell.getCellType()) {
												case HSSFCell.CELL_TYPE_FORMULA:
													value = curCell.getNumericCellValue() + "";
													break;
												case HSSFCell.CELL_TYPE_NUMERIC:
													value = curCell.getNumericCellValue() + "";
													break;
												case HSSFCell.CELL_TYPE_STRING:
													value = curCell.getStringCellValue() + "";
													break;
												case HSSFCell.CELL_TYPE_BLANK:
													value = "0.0";
													break;
												case HSSFCell.CELL_TYPE_ERROR:
													value = curCell.getErrorCellValue() + "";
													break;
												default:
													value = new String();
													break;
											} // end switch
									
											if(rowIndex == 1) {
											// 현재 colum index에 따라서 vo입력
												switch (cellIndex) {
													case 9: // 나이
														stdDate = value;
														break;
													default:
														break;
												}
											} else {
												vo.setStdDate(stdDate);
												switch (cellIndex) {
													case 5: 
														vo.setDept1001Cnt(value);
														break;
													case 6:
														vo.setDept1002Cnt(value);
														break;
													case 7:
														vo.setDept1004Cnt(value);
														break;
													case 8:
														vo.setDept1003Cnt(value);
														break;
													case 9:
														vo.setDept1005Cnt(value);
														break;
													default:
														vo.setStdDate(stdDate);
														break;
												}
											}
										} // end if
									}
								} // end for
								// cell 탐색 이후 vo 추가
								//vo.setStdDate(stdDate);
								if(rowIndex!=1) list.add(vo);
							//} // end
						//} // end if
					}
				}
			}
			
			for(int i=0;i<list.size();i++) {
				resultCnt += wareHouseManageDAO.insertItemConditionInfo(list.get(i));
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resultCnt;
	}
	
	public List<ExcelItemVO> getItemConditionList() {
		List<ExcelItemVO> resultList = null;
		
		resultList = wareHouseManageDAO.selectItemConditionList();
		
		return resultList;
	}
	
	public List<ExcelItemVO> getItemConditionDetail(String stdDate) {
		List<ExcelItemVO> resultList = null;
		
		resultList = wareHouseManageDAO.selectItemConditionDetail(stdDate);
		
		return resultList;
	}
}
