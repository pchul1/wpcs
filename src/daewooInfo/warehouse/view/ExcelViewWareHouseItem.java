package daewooInfo.warehouse.view;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import daewooInfo.warehouse.bean.ItemConditionManageSearchVO;
import daewooInfo.warehouse.bean.ItemHoldConditionVO;

public class ExcelViewWareHouseItem extends AbstractExcelView{
	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook wb,
		HttpServletRequest req, HttpServletResponse resp) throws Exception {
		
	  
		HSSFCell cell = null;
		HSSFCellStyle style = null;
		HSSFDataFormat format = wb.createDataFormat();
		HSSFFont font = wb.createFont();

		Map<String, Object> map= (Map<String, Object>) model.get("chartMap");
		List<Object> chart = (List<Object>) map.get("chart");
		List<Object> resultList = (List<Object>)map.get("resultList");
		int totalCnt = (Integer) map.get("totalCnt");		
		ItemConditionManageSearchVO searchVO = (ItemConditionManageSearchVO)map.get("searchVO");
		List<Map<String,String>> whNames = (List<Map<String, String>>) map.get("whNames");
		HSSFSheet sheet = wb.createSheet("방제물품 보유현황");
		sheet.setDefaultColumnWidth((short) 12);
 
		//파일이름 설정
		String filename = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String ctime = sdf.format(new Date(System.currentTimeMillis()));
		
		filename = "방제물품 보유현황-"+ctime+".xls";
		
		filename = new String(filename.getBytes("euc-kr"), "8859_1"); 
		resp.setHeader("Content-Disposition", "attachment;filename="+filename+";"); 
		
		// 제목
		cell = getCell(sheet, 0, 0);
		sheet.addMergedRegion(new CellRangeAddress(0,0,0,4+whNames.size()));
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)14);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		
		cell.setCellStyle(style);
		setText(cell, "방제물품 보유현황");
		
		cell = getCell(sheet, 1, 0);
		sheet.addMergedRegion(new CellRangeAddress(1,1,0,4+whNames.size()));
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)12);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
				
		cell.setCellStyle(style);
		setText(cell,"[ 일자 : " + searchVO.getEndDate() + "    관리부서 : " + new String(searchVO.getDeptName().getBytes("8859_1"), "utf-8")+" ]");
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)11);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();		
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);			
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);	
		
		//엑셀 헤더생성
		cell = getCell(sheet, 2, 0);
		sheet.addMergedRegion(new CellRangeAddress(2,4,0,0));
		setText(cell,"순서");
		
		cell = getCell(sheet, 2, 0);
		cell.setCellStyle(style);
		cell = getCell(sheet, 3, 0);
		cell.setCellStyle(style);
		cell = getCell(sheet, 4, 0);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 1);
		sheet.addMergedRegion(new CellRangeAddress(2,4,1,1));
		setText(cell,"물품명");
		
		cell = getCell(sheet, 2, 1);
		cell.setCellStyle(style);
		cell = getCell(sheet, 3, 1);
		cell.setCellStyle(style);
		cell = getCell(sheet, 4, 1);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 2);
		sheet.addMergedRegion(new CellRangeAddress(2,4,2,2));
		setText(cell,"단위");
		
		cell = getCell(sheet, 2, 2);
		cell.setCellStyle(style);
		cell = getCell(sheet, 3, 2);
		cell.setCellStyle(style);
		cell = getCell(sheet, 4, 2);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 3);
		sheet.addMergedRegion(new CellRangeAddress(2,4,3,3));
		setText(cell,"합계");
		
		cell = getCell(sheet, 2, 3);
		cell.setCellStyle(style);
		cell = getCell(sheet, 3, 3);
		cell.setCellStyle(style);
		cell = getCell(sheet, 4, 3);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 4);
		sheet.addMergedRegion(new CellRangeAddress(2,2,4,4+whNames.size()));
		setText(cell,"지역본부");
		cell.setCellStyle(style);
		
		for(int k = 1 ; k <= whNames.size() ; k++){
			cell = getCell(sheet, 2, 4+k);
			cell.setCellStyle(style);
		}

		cell = getCell(sheet, 3, 4);
		sheet.addMergedRegion(new CellRangeAddress(3,4,4,4));
		setText(cell,"소계");
		
		cell = getCell(sheet, 3, 4);
		cell.setCellStyle(style);
		cell = getCell(sheet, 4, 4);
		cell.setCellStyle(style);
		
		for(int i = 1 ; i <= whNames.size(); i++){
			
			Map<String,String> tempMap = whNames.get(i-1);
			cell = getCell(sheet, 3, 4+i);
			sheet.addMergedRegion(new CellRangeAddress(3,3,4+i,4+i));
			cell.setCellStyle(style);
			setText(cell,tempMap.get("CAPTION"));
			
			cell = getCell(sheet, 4, 4+i);
			sheet.addMergedRegion(new CellRangeAddress(4,4,4+i,4+i));
			cell.setCellStyle(style);
			setText(cell,tempMap.get("CTY_NAME"));
			
		}
		
		//조회 데이터 생성
		style = wb.createCellStyle();		
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);	
		
		boolean isVo = false;
		ItemHoldConditionVO itemHoldConditionVO = new ItemHoldConditionVO();
		if(totalCnt > 0){
			Object obj = resultList.get(0);
			isVo = obj instanceof ItemHoldConditionVO;
			if(isVo){
				for(int i = 0 ; i < totalCnt ; i++){
					itemHoldConditionVO = (ItemHoldConditionVO)resultList.get(i);
					for(int k=0; k <= 4+whNames.size() ; k++){
						if( k == 0 ){
							cell = getCell(sheet, 5 + i , k);
							cell.setCellStyle(style);
							//setText(cell, String.valueOf((k+1)));
							cell.setCellValue(String.valueOf((i+1)));
						}
						if(k == 1){
							cell = getCell(sheet, 5 + i , k);
							cell.setCellStyle(style);
							//setText(cell, itemHoldConditionVO.getItemName());
							cell.setCellValue(itemHoldConditionVO.getItemName());							
						}
						if(k == 2){
							cell = getCell(sheet, 5 + i , k);
							cell.setCellStyle(style);
							//setText(cell, itemHoldConditionVO.getItemStan());
							cell.setCellValue(itemHoldConditionVO.getItemStan());							
						}
						if(k == 3){
							cell = getCell(sheet, 5 + i , k);
							cell.setCellStyle(style);
							//setText(cell, itemHoldConditionVO.getTotalCnt());
							cell.setCellValue(itemHoldConditionVO.getTotalCnt());							
						}
						if(k == 4){
							cell = getCell(sheet, 5 + i , k);
							cell.setCellStyle(style);
							//setText(cell, itemHoldConditionVO.getCnt());
							cell.setCellValue(itemHoldConditionVO.getCnt());
						}
						if(k == 5){
							if(null != itemHoldConditionVO.getWh1()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								//setText(cell, itemHoldConditionVO.getWh1());
								cell.setCellValue(itemHoldConditionVO.getWh1());
							}							
						}
						if(k == 6){
							if(null != itemHoldConditionVO.getWh2()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								//setText(cell, itemHoldConditionVO.getWh2());
								cell.setCellValue(itemHoldConditionVO.getWh2());
							}							
						}
						if(k == 7){
							if(null != itemHoldConditionVO.getWh3()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								//setText(cell, itemHoldConditionVO.getWh3());
								cell.setCellValue(itemHoldConditionVO.getWh3());
							}							
						}
						if(k == 8){
							if(null != itemHoldConditionVO.getWh4()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								setText(cell, itemHoldConditionVO.getWh4());
							}							
						}
						if(k == 9){
							if(null != itemHoldConditionVO.getWh5()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								setText(cell, itemHoldConditionVO.getWh5());
							}							
						}
						if(k == 10){
							if(null != itemHoldConditionVO.getWh6()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								setText(cell, itemHoldConditionVO.getWh6());
							}							
						}
						if(k == 11){
							if(null != itemHoldConditionVO.getWh7()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								setText(cell, itemHoldConditionVO.getWh7());
							}							
						}
						if(k == 12){
							if(null != itemHoldConditionVO.getWh8()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								setText(cell, itemHoldConditionVO.getWh8());
							}							
						}
						if(k == 13){
							if(null != itemHoldConditionVO.getWh9()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								setText(cell, itemHoldConditionVO.getWh9());
							}							
						}
						if(k == 14){
							if(null != itemHoldConditionVO.getWh10()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								setText(cell, itemHoldConditionVO.getWh10());
							}								
						}
						if(k == 15){
							if(null != itemHoldConditionVO.getWh11()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								setText(cell, itemHoldConditionVO.getWh11());
							}								
						}
						if(k == 16){
							if(null != itemHoldConditionVO.getWh12()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								setText(cell, itemHoldConditionVO.getWh12());
							}								
						}
						if(k == 17){
							if(null != itemHoldConditionVO.getWh13()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								setText(cell, itemHoldConditionVO.getWh13());
							}								
						}
						if(k == 18){
							if(null != itemHoldConditionVO.getWh14()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								setText(cell, itemHoldConditionVO.getWh14());
							}								
						}
						if(k == 19){
							if(null != itemHoldConditionVO.getWh15()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								setText(cell, itemHoldConditionVO.getWh15());
							}								
						}
						if(k == 20){
							if(null != itemHoldConditionVO.getWh16()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								setText(cell, itemHoldConditionVO.getWh16());
							}								
						}
						if(k == 21){
							if(null != itemHoldConditionVO.getWh17()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								setText(cell, itemHoldConditionVO.getWh17());
							}								
						}
						if(k == 22){
							if(null != itemHoldConditionVO.getWh18()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								setText(cell, itemHoldConditionVO.getWh18());
							}								
						}
						if(k == 23){
							if(null != itemHoldConditionVO.getWh19()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								setText(cell, itemHoldConditionVO.getWh19());
							}								
						}
						if(k == 24){
							if(null != itemHoldConditionVO.getWh20()){
								cell = getCell(sheet, 5 + i , k);
								cell.setCellStyle(style);
								setText(cell, itemHoldConditionVO.getWh20());
							}								
						}
					}
				}	
			}
		}
		/*
		HSSFWorkbook wb = new HSSFWorkbook();
        
        HSSFSheet st = wb.createSheet("Test Sheet");
         
        st.addMergedRegion(new CellRangeAddress(
                  0, //시작 행번호
                  2, //마지막 행번호
                  2, //시작 열번호
                  4  //마지막 열번호
          ));

		*/
		//검증되지 않은 데이터
		/*
		cell = getCell(sheet, 1, 0);
		sheet.addMergedRegion(new CellRangeAddress(1,1,0,maxCell));
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)11);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
				
		cell.setCellStyle(style);	
		setText(cell,"(검증되지 않은 데이터 입니다)");
		
		// 기간		
		cell = getCell(sheet, 2, 0);
		sheet.addMergedRegion(new CellRangeAddress(2,2,0,maxCell));
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)11);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		style.setBorderBottom(HSSFCellStyle.BORDER_NONE);
				
		cell.setCellStyle(style);	
		String sdt = searchTaksuVO.getFrDate();
		String edt = searchTaksuVO.getToDate();
		setText(cell, "기간 : "+sdt.substring(0,4)+"년"+sdt.substring(4,6)+"월"+sdt.substring(6,8)+"일 "
				+searchTaksuVO.getFrTime()+"시" +" ~ "
				+edt.substring(0,4)+"년"+edt.substring(4,6)+"월"+edt.substring(6,8)+"일 "
				+searchTaksuVO.getToTime()+"시");
		
		
		// 컬럼		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)11);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
			
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);
 
		int cellIdx = 0;
		int addIdx = 0;
		
		if(!isOneBranch)
		{
			cell = getCell(sheet, 3, cellIdx);
			sheet.addMergedRegion(new CellRangeAddress(3,4,cellIdx,cellIdx));
			setText(cell, "수계");
			cell = getCell(sheet, 3, cellIdx);
			cell.setCellStyle(style);
			cell = getCell(sheet, 4, cellIdx);
			cell.setCellStyle(style);
			
			cellIdx++;
			
			cell = getCell(sheet, 3, cellIdx);
			sheet.addMergedRegion(new CellRangeAddress(3,4,cellIdx,cellIdx));
			cell = getCell(sheet, 3, cellIdx);
			setText(cell, "지역");
			cell = getCell(sheet, 3, cellIdx);
			cell.setCellStyle(style);
			cell = getCell(sheet, 4, cellIdx);
			cell.setCellStyle(style);
			
			cellIdx++;
			
			cell = getCell(sheet, 3, cellIdx);
			setText(cell, "측정소");
			sheet.addMergedRegion(new CellRangeAddress(3,4,cellIdx,cellIdx));
			cell = getCell(sheet, 3, cellIdx);
			cell.setCellStyle(style);
			cell = getCell(sheet, 4, cellIdx);
			cell.setCellStyle(style);
			
			cellIdx++;
		}
		else
		{
			addIdx+=1;
		}
		
		cell = getCell(sheet, 3+addIdx, cellIdx);
		setText(cell, "수신일자");
		sheet.addMergedRegion(new CellRangeAddress(3+addIdx,4+addIdx,cellIdx, cellIdx));
		cell = getCell(sheet, 3+addIdx, cellIdx);
		cell.setCellStyle(style);
		cell = getCell(sheet, 4+addIdx, cellIdx);
		cell.setCellStyle(style);
		
		cellIdx++;
		
		cell = getCell(sheet, 3+addIdx, cellIdx);
		setText(cell, "수신시간");
		sheet.addMergedRegion(new CellRangeAddress(3+addIdx,4+addIdx,cellIdx, cellIdx));
		cell = getCell(sheet, 3+addIdx, cellIdx);
		cell.setCellStyle(style);
		cell = getCell(sheet, 4+addIdx, cellIdx);
		cell.setCellStyle(style);
		
		cellIdx++;
		
		cell = getCell(sheet, 3+addIdx, cellIdx);
		setText(cell, "측정항목");
		
		if("U".equals(searchTaksuVO.getSys()))
			sheet.addMergedRegion(new CellRangeAddress(3+addIdx,3+addIdx,cellIdx,cellIdx+5));
		else
			sheet.addMergedRegion(new CellRangeAddress(3+addIdx,3+addIdx,cellIdx,cellIdx+4));
			
		cell = getCell(sheet, 3+addIdx, cellIdx);
		cell.setCellStyle(style);
		cell = getCell(sheet, 3+addIdx, cellIdx+1);
		cell.setCellStyle(style);
		cell = getCell(sheet, 3+addIdx, cellIdx+2);
		cell.setCellStyle(style);
		cell = getCell(sheet, 3+addIdx, cellIdx+3);
		cell.setCellStyle(style);
		cell = getCell(sheet, 3+addIdx, cellIdx+4);
		cell.setCellStyle(style);
		
		if("U".equals(searchTaksuVO.getSys()))
		{
			cell = getCell(sheet, 3+addIdx, cellIdx+5);
			cell.setCellStyle(style);	
		}
		else
		{
			cell = getCell(sheet, 3+addIdx, cellIdx+4);
			cell.setCellStyle(style);	
		}
		
		
		cell = getCell(sheet, 4+addIdx, cellIdx);
		setText(cell, "탁도(NTU)");
		cell.setCellStyle(style);
		
		cellIdx++;
		
		cell = getCell(sheet, 4+addIdx, cellIdx);
		setText(cell, "수온(℃)");
		cell.setCellStyle(style);
		
		cellIdx++;
		
		cell = getCell(sheet, 4+addIdx, cellIdx);
		setText(cell, "pH");
		cell.setCellStyle(style);
		
		cellIdx++;
		
		cell = getCell(sheet, 4+addIdx, cellIdx);
		setText(cell, "DO(mg/L)");
		cell.setCellStyle(style);
		
		cellIdx++;
		
		cell = getCell(sheet, 4+addIdx, cellIdx);
		setText(cell, "EC(mS/cm)");
		cell.setCellStyle(style);
		
		cellIdx++;
		
		
		if("U".equals(searchTaksuVO.getSys()))
		{
			cell = getCell(sheet, 4+addIdx, cellIdx);
			setText(cell, "Chl-a(μg/L)");
			cell.setCellStyle(style);
			
			cellIdx++;
		}

		boolean isVO = false;
 
		if (chart.size() > 0) {
			Object obj = chart.get(0);
			isVO = obj instanceof DetailViewVO;
		}
		
		
 
		addIdx = 0;
		
		for (int i = 0; i < chart.size(); i++) {
 
			if (isVO) {	// VO
 
				DetailViewVO vo = (DetailViewVO) chart.get(i);
				
				style = wb.createCellStyle();
				
			

				String factNumber = vo.getRiver_div();
				
//				if(factNumber.equals("R01"))
//					factNumber = vo.getFactname().replace("한강","");
//				else if(factNumber.equals("R02"))
//					factNumber =  vo.getFactname().replace("낙동강","");
//				else if(factNumber.equals("R03"))
//					factNumber =  vo.getFactname().replace("금강","");
//				else if(factNumber.equals("R04"))
//					factNumber =  vo.getFactname().replace("영산강","");
							   
				
				
				
				if(isOneBranch && i == 0)
				{
					addIdx = 1;
					
					cell = getCell(sheet, 3, 0);
					sheet.addMergedRegion(new CellRangeAddress(3,3,0,maxCell));
					style.setBorderTop(HSSFCellStyle.BORDER_NONE);	
					style.setBorderLeft(HSSFCellStyle.BORDER_NONE);	
					style.setBorderRight(HSSFCellStyle.BORDER_NONE);	
					style.setBorderBottom(HSSFCellStyle.BORDER_NONE);	
					style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
					cell.setCellStyle(style);		
					setText(cell, " 측정소 : " + vo.getRiver_name() + "("+ vo.getFactname() +")" + " [" + vo.getBranch_name() + "]");	
				}
				
				
				
				
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);
				style.setLocked(false);
				
				
				cellIdx = 0;
				
				if(!isOneBranch)
				{
					//수계
					cell = getCell(sheet, 5 + i + addIdx, cellIdx);
					cell.setCellValue(vo.getRiver_name());
					cell.setCellStyle(style);
	 
					cellIdx++;
					
			
					//공구
					cell = getCell(sheet, 5 + i + addIdx, cellIdx);
					cell.setCellValue(vo.getFactname());
					cell.setCellStyle(style);
	 
					cellIdx++;
					
					//측정소
					cell = getCell(sheet, 5 + i + addIdx, cellIdx);
					cell.setCellValue(vo.getBranch_name());
					cell.setCellStyle(style);
	
					cellIdx++;
				}
				
				style = wb.createCellStyle();
				style.setDataFormat(format.getFormat("0.00"));
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);
				style.setLocked(false);
				
				//일자
				cell = getCell(sheet, 5 + i + addIdx, cellIdx);
				cell.setCellValue(vo.getStrdate());
				cell.setCellStyle(style);
				
				cellIdx++;

				//시간
				cell = getCell(sheet, 5 + i + addIdx, cellIdx);
				cell.setCellValue(vo.getStrtime());
				cell.setCellStyle(style);
				
				cellIdx++;
				
				//탁도
				cell = getCell(sheet, 5 + i + addIdx, cellIdx);
				cell.setCellValue(vo.getTur());
				cell.setCellStyle(style);
				
				cellIdx++;
				
				//수온
				cell = getCell(sheet, 5 + i + addIdx, cellIdx);
				cell.setCellValue(vo.getTmp());
				cell.setCellStyle(style);
				
				cellIdx++;
				
				//ph
				cell = getCell(sheet, 5 + i + addIdx, cellIdx);
				cell.setCellValue(vo.getPhy());
				cell.setCellStyle(style);
				
				cellIdx++;
				
				//Dow
				cell = getCell(sheet, 5 + i + addIdx, cellIdx);
				cell.setCellValue(vo.getDow());
				cell.setCellStyle(style);
				
				cellIdx++;
				
				//con
				cell = getCell(sheet, 5 + i + addIdx, cellIdx);
				cell.setCellValue(vo.getCon());
				cell.setCellStyle(style);
				
				cellIdx++;
				
				
				if("U".equals(searchTaksuVO.getSys()))
				{
					//chla
					cell = getCell(sheet, 5 + i + addIdx, cellIdx);
					cell.setCellValue(vo.getTof());
					cell.setCellStyle(style);
				}
				
			} else {	// Map
 
				Map<String, String> category = (Map<String, String>) chart.get(i);
 
				cell = getCell(sheet, 4 + i, 0);
				setText(cell, category.get("id"));
 
				cell = getCell(sheet, 4 + i, 1);
				setText(cell, category.get("name"));
 
				cell = getCell(sheet, 4 + i, 2);
				setText(cell, category.get("description"));
 
				cell = getCell(sheet, 4 + i, 3);
				setText(cell, category.get("useyn"));
 
				cell = getCell(sheet, 4 + i, 4);
				setText(cell, category.get("reguser"));
 
			}
		}*/
	}
}
