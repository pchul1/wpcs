package daewooInfo.waterpolmnt.waterinfo.service.impl;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import daewooInfo.admin.mindataEmployee.bean.MindataEmployeeVO;
import daewooInfo.admin.mindataEmployee.dao.MindataEmployeeDAO;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.common.Globals;
import daewooInfo.common.alrim.bean.AlrimVO;
import daewooInfo.common.alrim.dao.AlrimDAO;
import daewooInfo.warehouse.bean.ExcelItemVO;
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
import daewooInfo.waterpolmnt.waterinfo.dao.WaterinfoDAO;
import daewooInfo.waterpolmnt.waterinfo.service.WaterinfoService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;

@Service("waterinfoService")
public class WaterinfoServiceImpl extends AbstractServiceImpl implements WaterinfoService {
	
	/**
	 * @uml.property  name="waterinfoDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "waterinfoDAO")
	private WaterinfoDAO waterinfoDAO;
	
	@Resource(name = "MindataEmployeeDAO")
    private MindataEmployeeDAO mindataEmployeeDAO;

	@Resource(name = "alrimDAO")
	private AlrimDAO alrimDAO;


	// 시스템 권한 조회
	public List<HashMap> getSystemList(HttpServletRequest request) throws Exception{
		return waterinfoDAO.getSystemList(request);
	}
	

	// 수계 목록 조회
	public List<HashMap> getSugyeList(HttpServletRequest request, String system) throws Exception {
		return waterinfoDAO.getSugyeList(request, system);
	}
	public List<HashMap> getSugyeList(String userId, String system, String userGubun) throws Exception{
		return waterinfoDAO.getSugyeList(userId, system, userGubun);
	}
		
	// 공구 목록 조회
	public List<HashMap> getGongkuList(HttpServletRequest request, String system, String sugye) throws Exception{
		return waterinfoDAO.getGongkuList(request, system, sugye);
	}
	
	public List<HashMap> getGongkuList(String system, String sugye, String userGubun, String userId) throws Exception{
		return waterinfoDAO.getGongkuList(system, sugye, userGubun, userId);
	}
	
	// 과학원 측정소 목록 조회 - 유량지점
	public List<HashMap> getFlowFact(String sugye) throws Exception{
		return waterinfoDAO.getFlowFact(sugye);
	}
	
	// 과학원 측정소 목록 조회 - 수위지점
	public List<HashMap> getWLFact(String sugye) throws Exception{
		return waterinfoDAO.getWLFact(sugye);
	}
	
	// 과학원 측정소 목록 조회 - 댐
	public List<HashMap> getDamFact(String sugye) throws Exception{
		return waterinfoDAO.getDamFact(sugye);
	}
	
	
	// 측정소 목록 조회
	public List<HashMap> getBranchList(String factCode) throws Exception{
		return waterinfoDAO.getBranchList(factCode);
	}
	
	public List<HashMap> getBranchListNew(String factCode, String userId) throws Exception{
		return waterinfoDAO.getBranchListNew(factCode, userId);
	}
	
	// 측정소 목록 조회
	public String getFactBranchCnt(String factCode) throws Exception{
		return waterinfoDAO.getFactBranchCnt(factCode);
	}
	
	// 측정항목 목록 조회
	public List<HashMap> getItemList(String system, String sugye, String factCode, String branchNo) throws Exception{
		return waterinfoDAO.getItemList(system,sugye, factCode, branchNo);
	}
	
	// 측정항목 목록 조회
	public List<HashMap> getItemList2(String itemKind) throws Exception{
		return waterinfoDAO.getItemList2(itemKind);
	}
	
	// 하천수질조회
	public List<DetailViewVO> getDetailViewRIVER(SearchTaksuVO searchTaksuVO) throws Exception{
		
		List<DetailViewVO> result = null;
		
		//dataType에 다른 쿼리 분기(시간자료, 분자료)
		if(searchTaksuVO.getDataType().equals("1"))
			result = waterinfoDAO.getDetailViewRIVER_HOUR(searchTaksuVO);
		else
			result = waterinfoDAO.getDetailViewRIVER_MIN(searchTaksuVO);
		
		return result;
	}
	
	// 하천수질조회 검색 레코드 수
	public int getTotCntRiver(SearchTaksuVO searchTaksuVO) throws Exception{
		
		int result = 0;
		
		//dataType에 다른 쿼리 분기(시간자료, 분자료)
		if(searchTaksuVO.getDataType().equals("1"))
		{
			result = waterinfoDAO.getTotCntRiver_HOUR(searchTaksuVO);
		}
		else
			result = waterinfoDAO.getTotCntRiver_MIN(searchTaksuVO);
		
		return result;
	}
	
	// 하천수질조회(그래프 & 엑셀 조회)
	public List<DetailViewVO> getRiverGraph(SearchTaksuVO searchTaksuVO) throws Exception{
		
		List<DetailViewVO> result = null;
		
		if(searchTaksuVO.getDataType().equals("1"))
			result = waterinfoDAO.getRiverGraph_HOUR(searchTaksuVO);
		else
			result = waterinfoDAO.getRiverGraph_MIN(searchTaksuVO);
			
		return result; 
	}

	// 방류수질 측정소 조회
	public List<HashMap> getTMSList(HttpServletRequest request, String sugye) throws Exception {
		return waterinfoDAO.getTMSList(request, sugye);
	}
	
	public List<HashMap> getTMSListNew(String sugye, String userId, String userGubun) throws Exception {
		return waterinfoDAO.getTMSListNew(sugye, userId, userGubun);
	}

	// 방류수질 측정소 조회
	public List<HashMap> getTMSList2(String sugye, String tmsCtyCode) throws Exception {
		return waterinfoDAO.getTMSList2(sugye, tmsCtyCode);
	}
	
	// 방류수질 측정소 조회
	public List<HashMap> getTMSRiverD1List() throws Exception {
		return waterinfoDAO.getTMSRiverD1List();
	}
	
	// 방류수질 측정소 조회
	public List<HashMap> getTMSRiverD2List(String sugye) throws Exception {
		return waterinfoDAO.getTMSRiverD2List(sugye);
	}
	
	public List<HashMap> getWastList(String factCode) throws Exception {
		return waterinfoDAO.getWastList(factCode);
	}
	
	
	// 방류수질 조회
	public List<DetailViewVO> getDetailViewDISCHARGE(SearchTaksuVO searchTaksuVO) throws Exception{
		
		List<DetailViewVO> result = null;
		
		//dataType에 다른 쿼리 분기(시간자료, 분자료)
		if(searchTaksuVO.getDataType().equals("1"))
			result = waterinfoDAO.getDetailViewDISCHARGE_HOUR(searchTaksuVO);
		else
			result = waterinfoDAO.getDetailViewDISCHARGE_MIN(searchTaksuVO);
		
		return result;
	}
	
	// 방류수질조회 검색 레코드 수
	public int getTotCntDischarge(SearchTaksuVO searchTaksuVO) throws Exception{
		
		int result = 0;
		
		//dataType에 다른 쿼리 분기(시간자료, 분자료)
		if(searchTaksuVO.getDataType().equals("1"))
		{
			result = waterinfoDAO.getTotCntDischarge_HOUR(searchTaksuVO);
		}
		else
			result = waterinfoDAO.getTotCntDischarge_MIN(searchTaksuVO);
		
		return result;
	}
	
	// 방류수질조회(그래프 & 엑셀 조회)
	public List<TaksuVO> getDischargeGraph(SearchTaksuVO searchTaksuVO) throws Exception{
		
		List<TaksuVO> result = null;
		
		if(searchTaksuVO.getDataType().equals("1"))
			result = waterinfoDAO.getDischargeGraph_HOUR(searchTaksuVO);
		else
			result = waterinfoDAO.getDischargeGraph_MIN(searchTaksuVO);
			
		return result; 
	}
	
	/**
	 * 유량조회 
	 */
	public List<FlowDataVO> getFlowData(SearchTaksuVO searchTaksuVO) throws Exception {
		return waterinfoDAO.getFlowData(searchTaksuVO);
	}
	
	/**
	 * 유량조회 레코드 수
	 */
	public int getFlowData_cnt(SearchTaksuVO searchTaksuVO) throws Exception {
		return waterinfoDAO.getFlowData_cnt(searchTaksuVO);
	}
	
	/**
	 * 유량조회 측정소별 하루치 그래프 
	 */
	public List<FlowDataVO> getFlowData_chart(SearchTaksuVO searchTaksuVO) throws Exception{
		return waterinfoDAO.getFlowData_chart(searchTaksuVO);
	}
	
	/**
	 * 유량조회 팝업 그래프
	 */
	public List<FlowDataVO> getFlowData_chartpopup(SearchTaksuVO searchTaksuVO) throws Exception {
		return waterinfoDAO.getFlowData_chartpopup(searchTaksuVO);
	}
	
	/**
	 * 유량 지점 위치 조회
	 */
	public LocationVO getFlowFactLocation(SearchTaksuVO searchTaksuVO) throws Exception {
		return waterinfoDAO.getFlowFactLocation(searchTaksuVO);
	}
	
	
	/**
	 * 수위 조회 
	 */
	public List<FlowDataVO> getWLData(SearchTaksuVO searchTaksuVO) throws Exception {
		return waterinfoDAO.getWLData(searchTaksuVO);
	}
	
	/**
	 * 수위 조회 레코드 수
	 */
	public int getWLData_cnt(SearchTaksuVO searchTaksuVO) throws Exception {
		return waterinfoDAO.getWLData_cnt(searchTaksuVO);
	}
	
	/**
	 * 수위 조회 측정소별 하루치 그래프 
	 */
	public List<FlowDataVO> getWLData_chart(SearchTaksuVO searchTaksuVO) throws Exception{
		return waterinfoDAO.getWLData_chart(searchTaksuVO);
	}
	
	/**
	 * 수위 조회 팝업 그래프
	 */
	public List<FlowDataVO> getWLData_chartpopup(SearchTaksuVO searchTaksuVO) throws Exception {
		return waterinfoDAO.getWLData_chartpopup(searchTaksuVO);
	}
	
	/**
	 * 수위 지점 위치 조회
	 */
	public LocationVO getWLFactLocation(SearchTaksuVO searchTaksuVO) throws Exception {
		return waterinfoDAO.getWLFactLocation(searchTaksuVO);
	}
	
	
	/**
	 * 댐 조회 
	 */
	public List<DamDataVO> getDamData(SearchTaksuVO searchTaksuVO) throws Exception {
		return waterinfoDAO.getDamData(searchTaksuVO);
	}
	
	/**
	 * 댐 조회 레코드 수
	 */
	public int getDamData_cnt(SearchTaksuVO searchTaksuVO) throws Exception {
		return waterinfoDAO.getDamData_cnt(searchTaksuVO);
	}
	
	/**
	 * 댐 조회 측정소별 하루치 그래프 
	 */
	public List<DamDataVO> getDamData_chart(SearchTaksuVO searchTaksuVO) throws Exception{
		return waterinfoDAO.getDamData_chart(searchTaksuVO);
	}
	
	/**
	 * 댐 조회 팝업 그래프
	 */
	public List<DamDataVO> getDamData_chartpopup(SearchTaksuVO searchTaksuVO) throws Exception {
		return waterinfoDAO.getDamData_chartpopup(searchTaksuVO);
	}
	
	/**
	 * 댐 지점 위치 조회
	 */
	public LocationVO getDamFactLocation(SearchTaksuVO searchTaksuVO) throws Exception {
		return waterinfoDAO.getDamFactLocation(searchTaksuVO);
	}
	
	
	
	/**
	 * 조류예보 목록 조회
	 */
	public List<AlgaCastDataVO> getAlgaCastList(AlgaCastDataVO algaDataVO) throws Exception{
		return waterinfoDAO.getAlgaCastList(algaDataVO);
	}
	
	/**
	 * 조류예보 목록 총 조회 레코드 수
	 * @param airMntData
	 * @return
	 * @throws Exception
	 */
	public int getAlgaCastList_cnt(AlgaCastDataVO algaDataVO) throws Exception{
		
		int result = 0;
		
		result = waterinfoDAO.getAlgaCastList_cnt(algaDataVO);
		
		return result;
	}
	
	
	/**
	 * 조류예보 초기 조회
	 */
	public List<AlgaCastDataVO> getAlgaCastFirst(String river_div) {
		return waterinfoDAO.getAlgaCastFirst(river_div);
	}

	/**
	 * 조류예보 상세정보 조회
	 */
	public AlgaCastDataVO getAlgaCast(String cast_num)
	{
		return waterinfoDAO.getAlgaCast(cast_num);
	}
	
	/**
	 * 조류예보 삭제
	 */
	public void deleteAlgaCast(String cast_num)
	{
		waterinfoDAO.deleteAlgaCast(cast_num);
	}
	
	/**
	 * 조류예보 업데이트
	 * @param algaCastData
	 */
	public void updateAlgaCast(AlgaCastDataVO algaCastData)
	{
		waterinfoDAO.updateAlgaCast(algaCastData);
	}
	
	
	/**
	 * 항공감시 목록조회
	 * @param airMntData
	 * @return
	 */
	public List<AirMntDataVO> getAirMntList(AirMntDataVO airMntData)
	{
		return waterinfoDAO.getAirMntList(airMntData);
	}
	
	/**
	 * 항공감시 목록 총 조회 레코드 수
	 * @param airMntData
	 * @return
	 * @throws Exception
	 */
	public int getAirMntList_cnt(AirMntDataVO airMntData) throws Exception{
		
		int result = 0;
		
		result = waterinfoDAO.getAirMntList_cnt(airMntData);
		
		return result;
	}
	
	/**
	 * 항공감시 초기 조회
	 * @return
	 */
	public List<AirMntDataVO> getAirMntFirst(String sugye)
	{
		return waterinfoDAO.getAirMntFirst(sugye);
	}
	
	/**
	 * 항공감시 상세정보 조회
	 * @param obv_num
	 * @return
	 */
	public AirMntDataVO getAirMnt(String obv_num)
	{
		return waterinfoDAO.getAirMnt(obv_num);
	}
	
	/**
	 * 항공감시 삭제
	 * @param obv_num
	 */
	public void deleteAirMnt(String obv_num)
	{
		waterinfoDAO.deleteAirMnt(obv_num);
	}

	/**
	 * 항공감시 업데이트
	 * @param airMntData
	 */
	public void updateAirMnt(AirMntDataVO airMntData)
	{
		waterinfoDAO.updateAirMnt(airMntData);
	}

	// 하천수질조회(경보 3시간이상)
	public List<RiverWater3HourWarningVO> getRiverWater3HourWarning(RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO) throws Exception{
		return waterinfoDAO.getRiverWater3HourWarning(riverWater3HourWarningSearchVO);
	}
	
	// 하천수질조회(경보 3시간이상) 엑셀
		public List<RiverWater3HourWarningVO> getRiverWater3HourWarningExcel(RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO) throws Exception{
			return waterinfoDAO.getRiverWater3HourWarningExcel(riverWater3HourWarningSearchVO);
		}

	// 하천수질조회(경보 3시간이상) 검색 레코드 수
	public int getRiverWarning_cnt(RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO) throws Exception{
		
		int result = 0;
		
		result = waterinfoDAO.getRiverWarning_cnt(riverWater3HourWarningSearchVO);
		
		return result;
	}
	
	// 하천수질조회(경보 3시간이상) (그래프 & 엑셀 조회)
	public List<RiverWater3HourWarningVO> getChartWarning(RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO) throws Exception{
		
		List<RiverWater3HourWarningVO> result = null;
		
		result = waterinfoDAO.getChartWaning(riverWater3HourWarningSearchVO);
			
		return result; 
	}
	
	// 하천수질조회(경보 3시간이상)- 세부조회
	public List<RiverWater3HourWarningVO> getRiverWater3HourWarningPopDetail(RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO) throws Exception{
		return waterinfoDAO.getRiverWater3HourWarningPopDetail(riverWater3HourWarningSearchVO);
	}
	
	//국가수질자동측정망 유효데이터 입력
	public void insertValidData(DetailViewVO detailViewVO) throws Exception
	{
		waterinfoDAO.insertValidData(detailViewVO);
	}
	
	public HashMap uploadExcelData(String factCode, HashMap<String, String> excelFileInfo) throws Exception
	{
//		SimpleDateFormat sdf_date = new SimpleDateFormat("yyyyMMdd");
//		SimpleDateFormat sdf_time = new SimpleDateFormat("HHmm");
// 		
//		
//		FileInputStream fis;
//		HashMap<String, Object> resultMap = new HashMap<String,Object>();
//		
//		String errorMsg = "no error";
//		
//		String time = "";
//		String date = "";
//			
//		//엑셀파일 불러오기
//		String uploadFileName = excelFileInfo.get(Globals.UPLOAD_FILE_NM);
//		String excelfile = excelFileInfo.get(Globals.FILE_PATH) + File.separator + uploadFileName;
//		
//		
//		Workbook wb = null;
//		
//		try
//		{
//			//Office 97-03
//			fis = new FileInputStream(excelfile);
//			wb = new HSSFWorkbook(fis);
//		}
//		catch(OfficeXmlFileException e)
//		{
//			//Office 2007
//			fis = new FileInputStream(excelfile);	
//			wb  = new XSSFWorkbook(fis);
//		}
//		
//		
//		PlatformTransactionManager transactionManager = null;
//		TransactionStatus status = null;
//		
//		try
//		{
//			//트랜잭션
//			transactionManager = new DataSourceTransactionManager(waterinfoDAO.getDataSource());
//			
//			DefaultTransactionDefinition def = new DefaultTransactionDefinition();
//			def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
//			status = transactionManager.getTransaction(def);
//			
//			//엑셀 파일 내용 추출
//			int sheetNum = wb.getNumberOfSheets();
//			System.out.println("[Excel fiile Reading Success!]");
//			
//			
//			//TEST
//			//factCode = "S04002";
//			
//			
//			//해당 공구의 ITEM LIST를 가져옵니다.
//			SearchTaksuVO vo = new SearchTaksuVO();
//			vo.setGongku(factCode);
//			
//			List<String> itemSeq = this.getValidItemSeq(vo);
//			
//			
//			
//			//Sheet 순환
//			for(int sheetIdx = 0 ; sheetIdx < sheetNum ; sheetIdx ++)
//			{
//				//System.out.println("===========================================");
//				
//				//System.out.println("[Sheet name] : " + wb.getSheetName(sheetIdx));				
//				
//				Sheet sheet = wb.getSheetAt(sheetIdx);
//				
//				//입력 날자 불러오기 (날자형식으로 되어있어야 함)
//				date = sdf_date.format(sheet.getRow(3).getCell(2).getDateCellValue());
//				
//				//System.out.println("[input date :" + date + "]");
//				
//				int rowCnt = sheet.getPhysicalNumberOfRows();
//				
//				//Row 순환
//				for(int rowIdx = 7 ; rowIdx < 295 ; rowIdx ++)
//				{
//					Row row = sheet.getRow(rowIdx);
//					
//					if(row != null)
//					{
//						int cellCnt = row.getPhysicalNumberOfCells();
//						
//						//ITEM 순환
//						for(int cellIdx = 1 ; cellIdx < (1+itemSeq.size()) ; cellIdx++)
//						{
//							Cell cell = row.getCell(cellIdx);
//							
//							if(cell != null)
//							{
//								String value = null;
//								
//								switch(cell.getCellType())
//								{
//									case Cell.CELL_TYPE_NUMERIC :
//										value = String.valueOf(cell.getNumericCellValue());
//										if(cellIdx == 1) value = sdf_time.format(cell.getDateCellValue());
//										break;
//									default :
//										continue; //숫자형식이 아니면 패스~
//								}
//								
//								if(cellIdx == 1)
//								{
//									time = value;
//								}
//						
//								if(cellIdx > 1)
//								{
//									String itemCode = itemSeq.get(cellIdx-1);
//									
//									DetailViewVO data = new DetailViewVO();
//									
//									data.setFactcode(factCode);
//									data.setItemcode(itemCode);
//									data.setMintime(date+time);
//									data.setMinrtime(date+time);
//									data.setMinvl(value);
//									
//									waterinfoDAO.insertValidData(data);
//									
//									//System.out.println("[" + rowIdx + ", " + cellIdx + "] : factCode=" + factCode + ", itemCode=" + itemCode + ", mintime=" + (date + time) + ", value=" + value);
//								}
//							}
//						}
//					}
//				}
//			}
//				
//			//System.out.println("===========================================");
//	
//			fis.close();
//			wb = null;
//		
//			//resultMap.put("result", result)
//			resultMap.put("insertTime", date);
//			
//			transactionManager.commit(status);
//		}
//		catch(Exception e)
//		{
//			//롤백
//			if(transactionManager != null)
//				transactionManager.rollback(status);
//			throw e;
//		}
//		finally
//		{
//			//생성된 임시파일 삭제
//			EgovFileMngUtil.deleteFile(excelfile);
//		}
//		
//		return resultMap;
		
		return null;
	}
	
	
	/**
	 * 유효데이터 입력 데이터 순서를 가져옵니다.
	 * @param searchTaksuVO
	 * @return
	 */
	public List<String> getValidItemSeq(SearchTaksuVO searchTaksuVO) throws Exception
	{
		return waterinfoDAO.getValidItemSeq(searchTaksuVO);
	}
	
	/**
	 * 공구의 위치 정보
	 * @param searchTaksuVO
	 * @return
	 * @throws Exception
	 */
	public LocationVO getFactLocation(SearchTaksuVO searchTaksuVO) throws Exception
	{
		return waterinfoDAO.getFactLocation(searchTaksuVO);
	}
	
	//측정소 이름
	public SearchTaksuVO getBranchName(SearchTaksuVO searchTaksuVO) throws Exception
	{
		return waterinfoDAO.getBranchName(searchTaksuVO);
	}
	
	//유량측정소 이름
	public SearchTaksuVO getFlowOBSName(SearchTaksuVO searchTaksuVO)
	{
		return waterinfoDAO.getFlowOBSName(searchTaksuVO);
	}

	public List getBoObsCdList(String sugye) throws Exception {
		return waterinfoDAO.getBoObsCdList(sugye);
	}

	public List getBoManageList(BoSearchVO searchVO) throws Exception {
		List result = null;
		
		//System.out.println("YIK=========================================== 3");
		//System.out.println("YIK=========================================== searchVO.getDataType()" + searchVO.getDataType());
		
		//dataType에 다른 쿼리 분기(시간자료, 분자료)
		if(searchVO.getDataType().equals("1"))
			result = waterinfoDAO.getBoManageList_HOUR(searchVO);
		else
			result = waterinfoDAO.getBoManageList_MIN(searchVO);
		
		//System.out.println("YIK=========================================== 4");
		
		return result;
		
	}

	public int getBoManageListCnt(BoSearchVO searchVO) throws Exception {
		int result = 0;
		
		//dataType에 다른 쿼리 분기(시간자료, 분자료)
		if(searchVO.getDataType().equals("1"))
			result = waterinfoDAO.getBoManageListCnt_HOUR(searchVO);
		else
			result = waterinfoDAO.getBoManageListCnt_MIN(searchVO);
		
		return result;
		
		
	}
	
	// 조류측정 정보 조회 리스트 
	public List getAlgacastAutoList(SearchTaksuVO searchTaksuVO) {
		return waterinfoDAO.getAlgacastAutoList(searchTaksuVO);
	}
	
	// 조류 측정 정보 조회 수량 
	public int getAlgacastAutoCnt(SearchTaksuVO searchTaksuVO)
	{
		return waterinfoDAO.getAlgacastAutoCnt(searchTaksuVO);
	}
	
	// 점오염원 정보 조회 리스트 
	public List getFactoryIndustList(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getFactoryIndustList(cmnSearchVO);
	}
	
	// 점오염원 정보 조회 수량 
	public int getFactoryIndustListCnt(CmnSearchVO cmnSearchVO)
	{
		return waterinfoDAO.getFactoryIndustListCnt(cmnSearchVO);
	}
	
	// 단일 점오염원 상세조회 리스트 
	public List getFactoryIndustIdList(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getFactoryIndustIdList(cmnSearchVO);
	}
	
	// 점오염원 사업장규모별 조회 리스트
	public List getFactoryIndustSizeList(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getFactoryIndustSizeList(cmnSearchVO);
	}
	
	// 점오염원 오염물질별 조회 리스트
	public List getFactoryIndustSpecList(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getFactoryIndustSpecList(cmnSearchVO);
	}
	
	// 점오염원 사업장규모별 및 오염물질별 합계 리스트
	public List getFactoryIndustSizeSpecCnt(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getFactoryIndustSizeSpecCnt(cmnSearchVO);
	}
	
	// 대권 유역 정보조회 리스트
	public List getBasinLargeList(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getBasinLargeList(cmnSearchVO);
	}
	
	// 중권 유역 정보조회 리스트
	public List getBasinMiddleList(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getBasinMiddleList(cmnSearchVO);
	}
	
	// 점오염원 사업소 id 중복 체크
	public int duplicateFacId(FactoryIndustViewVO factoryIndustViewVO) throws Exception {
		return waterinfoDAO.duplicateFacId(factoryIndustViewVO);
	}
	
	// 점오염원 사업소 등록
	public void insertFactoryIndust(FactoryIndustViewVO factoryIndustViewVO) throws Exception
	{
		waterinfoDAO.insertFactoryIndust(factoryIndustViewVO);
	}
	
	// 점오염원 사업소 size 등록
	public void insertFactoryIndustSize(FactoryIndustViewVO factoryIndustViewVO) throws Exception
	{
		waterinfoDAO.insertFactoryIndustSize(factoryIndustViewVO);
	}
	
	// 점오염원 사업소 spec 등록
	public void insertFactoryIndustSpec(FactoryIndustViewVO factoryIndustViewVO) throws Exception
	{
		waterinfoDAO.insertFactoryIndustSpec(factoryIndustViewVO);
	}
	
	// 점오염원 사업소 cnt 등록
	public void insertFactoryIndustCnt(FactoryIndustViewVO factoryIndustViewVO) throws Exception
	{
		waterinfoDAO.insertFactoryIndustCnt(factoryIndustViewVO);
	}
	
	// 점오염원 사업소 수정
	public void updatFactoryIndust(FactoryIndustViewVO factoryIndustViewVO)
	{
		waterinfoDAO.updatFactoryIndust(factoryIndustViewVO);
	}
	
	// 점오염원 사업소 삭제
	public int deleteFactoryIndust(CmnSearchVO cmnSearchVO)
	{
		return waterinfoDAO.deleteFactoryIndust(cmnSearchVO);
	}
	
	// 점오염원  사업소별size 측정값 수정
	public void updateFactoryIndustSize(FactoryIndustViewVO factoryIndustViewVO)
	{
		waterinfoDAO.updateFactoryIndustSize(factoryIndustViewVO);
	}
	
	// 점오염원  사업소별spec 측정값 수정
	public void updateFactoryIndustSpec(FactoryIndustViewVO factoryIndustViewVO)
	{
		waterinfoDAO.updateFactoryIndustSpec(factoryIndustViewVO);
	}
	
	// 점오염원  사업소별cnt 측정값 수정
	public void updateFactoryIndustCnt(FactoryIndustViewVO factoryIndustViewVO)
	{
		waterinfoDAO.updateFactoryIndustCnt(factoryIndustViewVO);
	}
	
	// 취정수장 정보 조회 리스트 
	public List getWaterDcCenterList(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getWaterDcCenterList(cmnSearchVO);
	}
	
	// 취정수장 정보 조회 수량 
	public int getWaterDcCenterListCnt(CmnSearchVO cmnSearchVO)
	{
		return waterinfoDAO.getWaterDcCenterListCnt(cmnSearchVO);
	}
	
	// 보 정보 조회 리스트 
	public List getBoObsInfoList(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getBoObsInfoList(cmnSearchVO);
	}
	
	// 보 정보 조회 수량 
	public int getBoObsInfoListCnt(CmnSearchVO cmnSearchVO)
	{
		return waterinfoDAO.getBoObsInfoListCnt(cmnSearchVO);
	}
	
	// 댐 정보 조회 리스트 
	public List getDamList(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getDamList(cmnSearchVO);
	}
	
	// 댐 정보 조회 수량 
	public int getDamListCnt(CmnSearchVO cmnSearchVO)
	{
		return waterinfoDAO.getDamListCnt(cmnSearchVO);
	}
	
	// 유관기관 정보 조회 리스트 
	public List getRelOffList(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getRelOffList(cmnSearchVO);
	}
	
	// 유관기관 정보 조회 수량 
	public int getRelOffListCnt(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getRelOffListCnt(cmnSearchVO);
	}
	
	// 단일 유관기관 상세조회 리스트 
	public List getRelOffDetailList(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getRelOffDetailList(cmnSearchVO);
	}
	
	// 유관기관 id 중복 체크
	public int duplicateRelOffId(RelateOfficeDataVO relateOfficeDataVO) throws Exception {
		return waterinfoDAO.duplicateRelOffId(relateOfficeDataVO);
	}
	
	// 유관기관 등록
	public void insertRelOff(RelateOfficeDataVO relateOfficeDataVO) throws Exception {
		waterinfoDAO.insertRelOff(relateOfficeDataVO);
	}
	
	// 유관기관 수정
	public void updatRelOff(RelateOfficeDataVO relateOfficeDataVO) {
		waterinfoDAO.updatRelOff(relateOfficeDataVO);
	}
	
	// 유관기관 삭제
	public int deleteRelOff(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.deleteRelOff(cmnSearchVO);
	}
	
	// 특별시/동 조회
	public List getDoCodeList(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getDoCodeList(cmnSearchVO);
	}
	
	// 시군구 조회
	public List getCtyCodeList(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getCtyCodeList(cmnSearchVO);
	}	
	
	// 방제업체 목록 조회
	public List getEcompanyList(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getEcompanyList(cmnSearchVO);
	}
	
	// 방제업체 수량
	public int getEcompanyListCnt(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getEcompanyListCnt(cmnSearchVO);
	}
	
	// 단일 방제업체 상세조회 리스트 
	public List getEcompanyDetailList(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getEcompanyDetailList(cmnSearchVO);
	}
	
	// 방제업체 id 중복 체크
	public int duplicateEcoId(EcompanyDataVO ecompanyDataVO) throws Exception {
		return waterinfoDAO.duplicateEcoId(ecompanyDataVO);
	}
		
	// 방제업체 등록
	public void insertEcompany(EcompanyDataVO ecompanyDataVO) throws Exception {
		waterinfoDAO.insertEcompany(ecompanyDataVO);
	}
	
	// 방제업체 수정
	public void updatEcompany(EcompanyDataVO ecompanyDataVO) {
		waterinfoDAO.updatEcompany(ecompanyDataVO);
	}
	
	// 방제업체 삭제
	public int deleteEcompany(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.deleteEcompany(cmnSearchVO);
	}
	
	// 방제물품 조회
	public List getEcompanyOwnItemList(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getEcompanyOwnItemList(cmnSearchVO);
	}
	
	// 방제물품 수량
	public int getEcompanyOwnItemListCnt(CmnSearchVO cmnSearchVO) {
		return waterinfoDAO.getEcompanyOwnItemListCnt(cmnSearchVO);
	}
	
	// 방제물품 추가
	public void insertEcompanyOwnItem(EcompayOwnItemDataVO ecompayOwnItemDataVO) throws Exception {
		waterinfoDAO.insertEcompanyOwnItem(ecompayOwnItemDataVO);
	}
	
	// 방제물품 삭제
	public int deleteEcompanyOwnItem(EcompayOwnItemDataVO ecompayOwnItemDataVO) {
		return waterinfoDAO.deleteEcompanyOwnItem(ecompayOwnItemDataVO);
	}
	
	
	// 측정소 기준치 조회 (IP-USN)
	public List<LimitDataVO> getDetailViewLIMIT_U(LimitDataVO limitDataVO) {
		return waterinfoDAO.getDetailViewLIMIT_U(limitDataVO);
	}

	// 측정소 기준치 조회 (수질측정망)
	public List<LimitDataVO> getDetailViewLIMIT_A(LimitDataVO limitDataVO) {
		return waterinfoDAO.getDetailViewLIMIT_A(limitDataVO);
	}
	
	// 측정소 기준치 적용 (수질측정망 -> IP-USN)
	public void applyDetailViewLIMIT(LimitDataVO limitDataVO) throws Exception {
		waterinfoDAO.deleteDetailViewLIMIT(limitDataVO);
		waterinfoDAO.insertDetailViewLIMIT(limitDataVO);
	}
	
	// 측정소 기준치 수정 (IP-USN)
	public void updateDetailViewLIMIT(LimitDataVO limitDataVO) throws Exception {
		waterinfoDAO.updateDetailViewLIMIT(limitDataVO);
	}
	
	// 측정소 데이터 선별 조회 (IP-USN)
	public List<LimitViewVO> getSelectDataList(SelectDataVO selectDataVO) {
		return waterinfoDAO.getSelectDataList(selectDataVO);
	}
	
	// 측정소 데이터 선별 조회 (IP-USN)_전체
	public List<LimitViewVO> getSelectDataListAll(SelectDataVO selectDataVO) {
		return waterinfoDAO.getSelectDataListAll(selectDataVO);
	}
		
	// 측정소 데이터 선별 검색 레코드 수 (IP-USN)
	public int getSelectDataCnt(SelectDataVO selectDataVO) {
		return waterinfoDAO.getSelectDataCnt(selectDataVO);
	}
	
	// 측정소 데이터 기준치설정정보 레코드 수 (IP-USN)
	public int getStandardInfoCnt(SelectDataVO selectDataVO) {
		return waterinfoDAO.getStandardInfoCnt(selectDataVO);
	}

	// 측정소 데이터 선별 검색 선별 최종일 (IP-USN)
	public String getSelectDataMaxDate(SelectDataVO selectDataVO) {
		return waterinfoDAO.getSelectDataMaxDate(selectDataVO);
	}
	
	// 데이터 선별 등록
	public String saveSelectData(SelectDataVO selectDataVO) throws Exception {
		String message = "fail";
		
		int Chk = waterinfoDAO.getChkSelectData(selectDataVO);
		if(Chk > 0){
			message = "being";
		}else{
			/*
			int count_chk = waterinfoDAO.getCntSelectData(selectDataVO);
			if(count_chk == 0){
				message = "nodata";
			}else{
				if(selectDataVO.getCmd().equals("Mod")){
					waterinfoDAO.deleteSelectData(selectDataVO);
				}
				
				int seq = 0;
				seq = waterinfoDAO.selectSelSeq(selectDataVO);
				selectDataVO.setSel_seq(seq);
				waterinfoDAO.saveSelectData(selectDataVO);
				waterinfoDAO.saveSelectDataItem(selectDataVO);
				message = "success";
			}
			*/
			if(selectDataVO.getCmd().equals("Mod")){
				waterinfoDAO.deleteSelectData(selectDataVO);
			}
			
			int seq = 0;
			seq = waterinfoDAO.selectSelSeq(selectDataVO);
			selectDataVO.setSel_seq(seq);
			waterinfoDAO.saveSelectData(selectDataVO);
			waterinfoDAO.saveSelectDataItem(selectDataVO);
			message = "success";
		}
		return message;
	}
	
	// 데이터 선별 상세 삭제
	public void deleteSelectData(SelectDataVO selectDataVO) throws Exception {
		waterinfoDAO.deleteSelectData(selectDataVO);
	}

	// 데이터 선별 상세 초기화
	public void deleteSelectDataAll(SelectDataVO selectDataVO) throws Exception {
		waterinfoDAO.deleteSelectDataAll(selectDataVO);
	}
	
	// 데이터 선별 상세 조회
	public SelectDataVO getDetailSelectData(SelectDataVO selectDataVO) {
		return waterinfoDAO.getDetailSelectData(selectDataVO);
	}
	
	// 데이터 선별 선별사유 조회
	public SelectDataVO getSelectDataReason(SelectDataVO selectDataVO) {
		return waterinfoDAO.getSelectDataReason(selectDataVO);
	}
	
	// 확정 데이터 입력
	public void insertDefiniteData(SelectDataVO selectDataVO) throws Exception {
		waterinfoDAO.insertDefiniteHis(selectDataVO);
		waterinfoDAO.insertDefiniteData(selectDataVO);
		waterinfoDAO.insertDefiniteDataHour(selectDataVO);
	}
	
	/**
	 * 선별/ 확정 데이터 입력
	 * 2014.11.11 kyr
	 */
	public void saveSelectDataInfo(SelectDataVO selectDataVO) throws Exception {
		int count_chk = waterinfoDAO.getCntSelectDataInfo(selectDataVO);
		if(count_chk != 0){
			waterinfoDAO.deleteSelectDataInfo(selectDataVO);
		}
		int sel_seq = 0;
		sel_seq = waterinfoDAO.selectSelInfoSeq(selectDataVO);
		selectDataVO.setSel_seq(sel_seq);
		
		waterinfoDAO.saveSelectDataInfo(selectDataVO);
		
		int sel_his_seq = 0;
		sel_his_seq = waterinfoDAO.selectSelInfoHisSeq(selectDataVO);
		selectDataVO.setSel_his_seq(sel_his_seq);
		
		waterinfoDAO.saveSelectDataInfoHis(selectDataVO);
		
		AlrimVO alrimVO = new AlrimVO();
		MindataEmployeeVO mindataEmployeeVO = new MindataEmployeeVO();
		mindataEmployeeVO.setGubun("E");
		List<MindataEmployeeVO> MindataEmployeeList = mindataEmployeeDAO.selectMindataEmployeeList(mindataEmployeeVO);
		

		for(MindataEmployeeVO vo : MindataEmployeeList){
			String title = "데이터 확정건이 있습니다. 확정을 해 주시기 바랍니다.";
			//선별 담당자 알림등록
			
			alrimVO.setAlrimGubun("W");
	    	alrimVO.setAlrimTitle(title);
	    	alrimVO.setAlrimLink("/waterpolmnt/waterinfo/goSelectConfirm.do");	
	    	alrimVO.setAlrimMenuId(12430);
	    	alrimVO.setAlrimWriterId(selectDataVO.getReg_id());
	    	alrimVO.setAlrimApprovalId(vo.getMember_id());
    		alrimDAO.insertSeminarAlrim(alrimVO);
		}
	}
	
	/**
	 * 선별/ 확정 데이터 수정
	 * 2014.11.11 kyr
	 */
	public void updateSelectDataInfo(SelectDataVO selectDataVO) throws Exception {
		
		waterinfoDAO.updateSelectDataInfo(selectDataVO);
	}
	
	// 측정소 수질 선별 이력 조회 (IP-USN)
	public List<SelectDataVO> getSelectHisList(SelectDataVO selectDataVO) {
		return waterinfoDAO.getSelectHisList(selectDataVO);
	}
	
	// 측정소 수질 선별 이력 검색 레코드 수 (IP-USN)
	public int getSelectHisCnt(SelectDataVO selectDataVO) {
		return waterinfoDAO.getSelectHisCnt(selectDataVO);
	}
	
	/**
	 * 선별보고서 조회
	 * 2014.11.11 kyr
	 * @param selectDataVO
	 * @return
	 */
	public List<SelectDataVO> getSelectDataReportList(SelectDataVO selectDataVO) {
		return waterinfoDAO.getSelectDataReportList(selectDataVO);
	}
	
	public List<SelectDataVO> getSelectDataFileList(SelectDataVO selectDataVO) {
		return waterinfoDAO.getSelectDataFileList(selectDataVO);
	}

	// 측정소 수질 확정 이력 조회 (IP-USN)
	public List<SelectDataVO> getDefiniteHisList(SelectDataVO selectDataVO) {
		return waterinfoDAO.getDefiniteHisList(selectDataVO);
	}
	
	// 측정소 수질 확정 이력 검색 레코드 수 (IP-USN)
	public int getDefiniteHisCnt(SelectDataVO selectDataVO) {
		return waterinfoDAO.getDefiniteHisCnt(selectDataVO);
	}
	
	// 측정소 수질 확정 취소 (IP-USN)
	public String deleteDefiniteData(SelectDataVO selectDataVO) throws Exception {
		String message = "fail";
		
		int count_chk = waterinfoDAO.getCntDefiniteData(selectDataVO);
		if(count_chk == 0){
			message = "nodata";
		}else{
			waterinfoDAO.insertDefiniteHis(selectDataVO);
			waterinfoDAO.deleteDefiniteData(selectDataVO);
			waterinfoDAO.deleteDefiniteDataHour(selectDataVO);
			message = "success";
		}
		return message;
	}
	
	// 측정소 데이터 확정 조회 (IP-USN)
	public List<LimitViewVO> getDefiniteDataList(SelectDataVO selectDataVO) {
		return waterinfoDAO.getDefiniteDataList(selectDataVO);
	}
	
	// 측정소 데이터 확정 조회 (IP-USN)_전체
	public List<LimitViewVO> getDefiniteDataListAll(SelectDataVO selectDataVO) {
		return waterinfoDAO.getDefiniteDataListAll(selectDataVO);
	}
	
	//데이터 선별 조회 차트
	public List<LimitViewVO> getDefiniteDataChart(LimitViewVO LimitViewVO){
		return waterinfoDAO.getDefiniteDataChart(LimitViewVO);
	}
	
	// 측정소 데이터 확정 조회 연산(최소, 최대, 평균) (IP-USN)
	public SumViewVO getDefiniteDataSum(SelectDataVO selectDataVO) {
		return waterinfoDAO.getDefiniteDataSum(selectDataVO);
	}
	
	// 측정소 데이터 확정 검색 레코드 수 (IP-USN)
	public int getDefiniteDataCnt(SelectDataVO selectDataVO) {
		return waterinfoDAO.getDefiniteDataCnt(selectDataVO);
	}
	
	// 데이터선별이력건수
	public int getDataSelectCnt(String useFlag) {
		return waterinfoDAO.getDataSelectCnt(useFlag);
	}
	
	/**
	 * 선별보고서 측정기기 정보
	 * 2014.11.11 kyr
	 * @param selectDataVO
	 * @return
	 */
	public SelectDataVO getSelectDataInfo(SelectDataVO selectDataVO) {
		return waterinfoDAO.getSelectDataInfo(selectDataVO);
	}
	
	public int getCntSelectDataInfo(SelectDataVO selectDataVO) {
		return waterinfoDAO.getCntSelectDataInfo(selectDataVO);
	}
	
	/**
	 *  데이터확정 조회
	 *  2014.11.11 kyr
	 * @param selectDataVO
	 * @return
	 */
	public List<SelectDataVO> getSelectConfirmList(SelectDataVO selectDataVO) {
		return waterinfoDAO.getSelectConfirmList(selectDataVO);
	}
	
	/**
	 *  데이터확정 조회 건수
	 *  2014.11.11 kyr
	 * @param selectDataVO
	 * @return
	 */
	public int getSelectConfirmListCnt(SelectDataVO selectDataVO) {
		return waterinfoDAO.getSelectConfirmListCnt(selectDataVO);
	}
	
	/**
	 * 데이터 선별취소
	 */
	public void cancelSelectDataInfo(SelectDataVO selectDataVO) throws Exception {
		int sel_his_seq = 0;
		sel_his_seq = waterinfoDAO.selectSelInfoHisSeq(selectDataVO);
		selectDataVO.setSel_his_seq(sel_his_seq);
		
		waterinfoDAO.insertSelectDataInfoHis(selectDataVO);
		
		waterinfoDAO.cancelSelectDataInfo(selectDataVO);
	}
	
	/**
	 * 데이터 확정
	 */
	public void confirmSelectDataInfo(SelectDataVO selectDataVO) throws Exception {
		int sel_his_seq = 0;
		sel_his_seq = waterinfoDAO.selectSelInfoHisSeq(selectDataVO);
		selectDataVO.setSel_his_seq(sel_his_seq);
		
		waterinfoDAO.insertSelectDataInfoHis(selectDataVO);
		
		waterinfoDAO.confirmSelectDataInfo(selectDataVO);
	}
	
	/**
	 *  데이터선별이력 조회
	 *  2014.11.12 kyr
	 * @param selectDataVO
	 * @return
	 */
	public List<SelectDataVO> getSelectDataHisList(SelectDataVO selectDataVO) {
		return waterinfoDAO.getSelectDataHisList(selectDataVO);
	}
	
	/**
	 *  데이터선별이력 건수
	 *  2014.11.12 kyr
	 * @param selectDataVO
	 * @return
	 */
	public int getSelectDataHisListCnt(SelectDataVO selectDataVO) {
		return waterinfoDAO.getSelectDataHisListCnt(selectDataVO);
	}
	
	/**
	 *  취소사유 정보조회
	 *  2014.11.12 kyr
	 * @param selectDataVO
	 * @return
	 */
	public List getCancelDataInfo(String sel_his_seq) {
		return waterinfoDAO.getCancelDataInfo(sel_his_seq);
	}
	
	/**
	 * 기타사항 정보 조회
	 */
	public SelectDataVO getSelectDataEtcInfo(SelectDataVO selectDataVO){
		return waterinfoDAO.getSelectDataEtcInfo(selectDataVO);
	}
	
	/**
	 * 기타사항 정보 조회
	 */
	public SelectDataVO getSelectDataEtcInfo(int sel_seq){
		return waterinfoDAO.getSelectDataEtcInfo(sel_seq);
	}
	
	public void updateAtchFileId(String atchFileId){
		waterinfoDAO.updateAtchFileId(atchFileId);
	}
	
	/**
	 * 선별데이터 초기화
	 * 2014.11.17 kyr
	 */
	public void initSelectData(SelectDataVO selectDataVO) throws Exception {
		waterinfoDAO.initSelectData(selectDataVO);
		waterinfoDAO.initSelectDataItem(selectDataVO);
	}
	
	/**
	 * 선별데이터 선택 초기화
	 * 2014.12.18 kyr
	 */
	public void initCheckSelectData(String sel_seq) throws Exception {
		waterinfoDAO.initCheckSelectDataItem(sel_seq);
		waterinfoDAO.initCheckSelectData(sel_seq);
	}
	
	public List<HashMap> goStatusCode(String status) throws Exception{
		return waterinfoDAO.goStatusCode(status);
	}
	
	public List<HashMap> getGongkuListKumho() throws Exception{
		return waterinfoDAO.getGongkuListKumho();
	}
	
	/**
	 * 금호강 일대 시간 자료 조회
	 */
	public List<DetailViewVO> getKumhoRealData(SearchTaksuVO searchTaksuVO) throws Exception {
		return waterinfoDAO.getKumhoRealData(searchTaksuVO);
	}
	
	/**
	 * 금호강 일대 시간 자료 조회 레코드 수
	 */
	public int getKumhoRealData_cnt(SearchTaksuVO searchTaksuVO) throws Exception {
		return waterinfoDAO.getKumhoRealData_cnt(searchTaksuVO);
	}
	
	/**
	 * 금호강 일대 시간 자료 조회
	 */
	public List<DetailViewVO> getKumhoModelingData(SearchTaksuVO searchTaksuVO) throws Exception {
		return waterinfoDAO.getKumhoModelingData(searchTaksuVO);
	}
	
	/**
	 * 금호강 일대 시간 자료 조회 레코드 수
	 */
	public int getKumhoModelingData_cnt(SearchTaksuVO searchTaksuVO) throws Exception {
		return waterinfoDAO.getKumhoModelingData_cnt(searchTaksuVO);
	}
	
	/**
	 * 금호강 모델링 엑셀 데이터 입력
	 * @param excelFileInfo
	 * @return
	 * @throws Exception
	 */
	public int readExcelUpdateModeling(HashMap<String, String> excelFileInfo) throws Exception
	{
		int resultCnt = 0;
		
		String ext = excelFileInfo.get(Globals.FILE_EXT);
		if("xls".equals(ext.toLowerCase())) {
			// 반환할 객체를 생성
			List<ExcelModelingVO> list = new ArrayList<ExcelModelingVO>();
			
			FileInputStream fis = null;
			HSSFWorkbook workbook = null;
			
			String filePath = excelFileInfo.get(Globals.FILE_PATH) + File.separator + excelFileInfo.get(Globals.UPLOAD_FILE_NM);
			try {
				
				fis= new FileInputStream(filePath);
				// HSSFWorkbook은 엑셀파일 전체 내용을 담고 있는 객체
				workbook = new HSSFWorkbook(fis);
				
				// 탐색에 사용할 Sheet, Row, Cell 객체
				HSSFSheet curSheet;
				HSSFRow   curRow;
				HSSFCell  curCell;
				ExcelModelingVO vo;
				
				// Sheet 탐색 for문
				for(int sheetIndex = 0 ; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++) {
					// 현재 Sheet 반환
					curSheet = workbook.getSheetAt(sheetIndex);
					// row 탐색 for문
					for(int rowIndex=2; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++) {
						// row 0은 헤더정보이기 때문에 무시
						//if(rowIndex != 0) {
							// 현재 row 반환
							curRow = curSheet.getRow(rowIndex);
							vo = new ExcelModelingVO();
							String value = "";
							
							// row의 첫번째 cell값이 비어있지 않은 경우 만 cell탐색
							if(!"".equals(curRow.getCell(0).getStringCellValue())) {
								
								vo.setMesuType("S");
								// cell 탐색 for 문
								for(int cellIndex=0;cellIndex<curRow.getPhysicalNumberOfCells(); cellIndex++) {
									curCell = curRow.getCell(cellIndex);
									
									if(true) {
										value = "";
										// cell 스타일이 다르더라도 String으로 반환 받음
										switch (curCell.getCellType()){
							                case HSSFCell.CELL_TYPE_FORMULA:
							                	value = curCell.getCellFormula();
							                    break;
							                case HSSFCell.CELL_TYPE_NUMERIC:
							                	if( DateUtil.isCellDateFormatted(curCell)) {
							        				Date date = curCell.getDateCellValue();
							        				value = new SimpleDateFormat("yyyyMMdd").format(date);
							        			} else {
							        				value = curCell.getNumericCellValue()+"";
							        			}
							                    break;
							                case HSSFCell.CELL_TYPE_STRING:
							                    value = curCell.getStringCellValue()+"";
							                    break;
							                case HSSFCell.CELL_TYPE_BLANK:
							                    value = curCell.getBooleanCellValue()+"";
							                    break;
							                case HSSFCell.CELL_TYPE_ERROR:
							                    value = curCell.getErrorCellValue()+"";
							                    break;
							                default:
							                	value = new String();
												break;
						                }
										
										// 현재 column index에 따라서 vo에 입력
										switch (cellIndex) {
											case 0: 
												vo.setFactCode(value);;
												break;
											case 1: 
												break;
											case 2: 
												vo.setHourTime(value.replaceAll("-", ""));
												break;
											case 3:
												vo.setItemCode("FLW00");
												vo.setHourVl(value);
												
												resultCnt = waterinfoDAO.mergeHourDataModeling(vo);
												break;
											case 4:
												vo.setItemCode("TMP00");
												vo.setHourVl(value);
												resultCnt = waterinfoDAO.mergeHourDataModeling(vo);
												break;
											case 5:
												vo.setItemCode("DOW00");
												vo.setHourVl(value);
												resultCnt = waterinfoDAO.mergeHourDataModeling(vo);
												break;
											case 6:
												vo.setItemCode("BOD00");
												vo.setHourVl(value);
												resultCnt = waterinfoDAO.mergeHourDataModeling(vo);
												break;
											case 7:
												vo.setItemCode("TON00");
												vo.setHourVl(value);
												resultCnt = waterinfoDAO.mergeHourDataModeling(vo);
												break;
											case 8:
												vo.setItemCode("TOP00");
												vo.setHourVl(value);
												resultCnt = waterinfoDAO.mergeHourDataModeling(vo);
												break;
											default:
												break;
										}
									}
								}
								// cell 탐색 이후 vo 추가
								//list.add(vo);
							}
						//}
					}
				}
			} catch (FileNotFoundException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				
			} finally {
				try {
					// 사용한 자원은 finally에서 해제
//					if( workbook!= null) workbook.close();
					if( fis!= null) fis.close();
					
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		} else if("xlsx".equals(ext.toLowerCase())) {
			
		}
		
		return resultCnt;
	}
	
	public int insertModelingInfoXls(MultipartHttpServletRequest req, FileVO fvo, WareHouseVO wareHouseVO){
		
		// 반환할 객체를 생성
		List<ExcelModelingVO> list = new ArrayList<ExcelModelingVO>();

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
			ExcelModelingVO vo = null;

			String itemCode = "";
			String factName = "";
			String factCode = "";

//			itemCode = req.getParameter("itemCode");
			itemCode = "TOF00";
			// Sheet 탐색 for문
			for (int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++) {
				// 현재 sheet 반환
				curSheet = workbook.getSheetAt(sheetIndex);
				// row 탐색 for문
				for (int rowIndex = 0; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++) {
					// row 0은 헤더정보이기 때문에 무시
					//if (rowIndex != 0 && rowIndex != 2 && rowIndex != 3) {
					curRow = curSheet.getRow(rowIndex);
					if(rowIndex > 2) {
						vo = new ExcelModelingVO();
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
												if( DateUtil.isCellDateFormatted(curCell)) {
							        				Date date = curCell.getDateCellValue();
							        				value = new SimpleDateFormat("yyyyMMdd").format(date);
							        			} else {
							        				value = curCell.getNumericCellValue()+"";
							        			}
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
								
										if(rowIndex == 0) {
										// 현재 colum index에 따라서 vo입력
											switch (cellIndex) {
												case 1: 
													factName = value;
													break;
												default:
													break;
											}
										} else if(rowIndex == 1) {
											switch (cellIndex) {
												case 1: 
													factCode = value;
													break;
												default:
													break;
											}
										} else {
											if(rowIndex > 2) {
												vo.setFactName(factName);
												vo.setFactCode(factCode);
												vo.setItemCode(itemCode);
												switch (cellIndex) {
													case 0: 
														vo.setModelDate(value.replaceAll("\\.", "").replaceAll("-", ""));
														break;
													case 1:
														vo.setMesuValu(value);
														break;
													case 2:
														vo.setPredValu1(value);
														break;
													case 3:
														vo.setPredValu2(value);
														break;
													case 4:
														vo.setNierFrom(value);
														break;
													case 5:
														vo.setNierTo(value);
														break;
												}
												
											}
										}
									} // end if
								}
							} // end for
							// cell 탐색 이후 vo 추가
							//vo.setStdDate(stdDate);
							if(rowIndex>2) list.add(vo);
							//} // end
						//} // end if
					//}
				}
			}
			
			for(int i=0;i<list.size();i++) {
				resultCnt += waterinfoDAO.insertModelingInfo(list.get(i));
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
	public int insertModelingInfoXlsx(MultipartHttpServletRequest req, FileVO fvo, WareHouseVO wareHouseVO){
		
		// 반환할 객체를 생성
		List<ExcelModelingVO> list = new ArrayList<ExcelModelingVO>();

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
			ExcelModelingVO vo = null;
			
			String itemCode = "";
			String factName = "";
			String factCode = "";

//			itemCode = req.getParameter("itemCode");
			itemCode = "TOF00";
			// Sheet 탐색 for문
			for (int sheetIndex = 0; sheetIndex < workbook.getNumberOfSheets(); sheetIndex++) {
				// 현재 sheet 반환
				curSheet = workbook.getSheetAt(sheetIndex);
				// row 탐색 for문
				for (int rowIndex = 0; rowIndex < curSheet.getPhysicalNumberOfRows(); rowIndex++) {
					// row 0은 헤더정보이기 때문에 무시
					//if (rowIndex != 0) {
						curRow = curSheet.getRow(rowIndex);
						if(rowIndex > 2) {
							vo = new ExcelModelingVO();
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
													if( DateUtil.isCellDateFormatted(curCell)) {
								        				Date date = curCell.getDateCellValue();
								        				value = new SimpleDateFormat("yyyyMMdd").format(date);
								        			} else {
								        				value = curCell.getNumericCellValue()+"";
								        			}
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
									
											if(rowIndex == 0) {
											// 현재 colum index에 따라서 vo입력
												switch (cellIndex) {
													case 1: 
														factName = value;
														break;
													default:
														break;
												}
											} else if(rowIndex == 1) {
												switch (cellIndex) {
													case 1: 
														factCode = value;
														break;
													default:
														break;
												}
											} else {
												if(rowIndex > 2) {
													vo.setFactName(factName);
													vo.setFactCode(factCode);
													vo.setItemCode(itemCode);
													switch (cellIndex) {
														case 0: 
															vo.setModelDate(value.replaceAll("\\.", "").replaceAll("-", ""));
															break;
														case 1:
															vo.setMesuValu(value);
															break;
														case 2:
															vo.setPredValu1(value);
															break;
														case 3:
															vo.setPredValu2(value);
															break;
														case 4:
															vo.setNierFrom(value);
															break;
														case 5:
															vo.setNierTo(value);
															break;
													}
													
													//if("2017801".equals(factCode)) System.out.println(rowIndex + " / " + vo.getModelDate() + " / value >>>> " + value);
												}
											}
										} // end if
									}
								} // end for
								// cell 탐색 이후 vo 추가
								//vo.setStdDate(stdDate);
								if(rowIndex>2) {
									list.add(vo);
								}
							//} // end
						//} // end if
					//} 
				}
			}
			
			for(int i=0;i<list.size();i++) {
				resultCnt += waterinfoDAO.insertModelingInfo(list.get(i));
			}
		} catch (IOException e) {
			e.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		}

		return resultCnt;
	}
	
	public int insertModelingImage(MultipartHttpServletRequest req, FileVO fvo, WareHouseVO wareHouseVO){
		return waterinfoDAO.insertModelingImage(wareHouseVO);
	}
	
	public List<ExcelModelingVO> getModelingResultList(SearchTaksuVO searchTaksuVO) throws Exception{
		
		List<ExcelModelingVO> result = null;
		
		result = waterinfoDAO.getModelingResultList(searchTaksuVO);
		
		return result;
	}
	
	public int getTotCntModelingResult(SearchTaksuVO searchTaksuVO) throws Exception{
		
		int result = 0;
		
		result = waterinfoDAO.getTotCntModelingResult(searchTaksuVO);
		
		return result;
	}
	
	public List<ExcelModelingVO> getModelingResultDetail(SearchTaksuVO searchTaksuVO) throws Exception{
		
		List<ExcelModelingVO> result = null;
		
		result = waterinfoDAO.getModelingResultDetail(searchTaksuVO);
		
		return result;
	}
	
public List<WareHouseVO> getModelingImageResultList(SearchTaksuVO searchTaksuVO) throws Exception{
		
		List<WareHouseVO> result = null;
		
		result = waterinfoDAO.getModelingImageResultList(searchTaksuVO);
		
		return result;
	}
}