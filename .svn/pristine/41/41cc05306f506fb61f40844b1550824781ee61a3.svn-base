package daewooInfo.stats.view;

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
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.HSSFColor;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import daewooInfo.stats.bean.StatsVO;
import daewooInfo.weather.bean.WeatherInfoVO;

public class ExcelStatsRiverOutletView extends AbstractExcelView{
	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook wb,
		HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HSSFCell cell = null;
		HSSFCellStyle style = null;
		HSSFDataFormat format = wb.createDataFormat();
		HSSFFont font = wb.createFont();

		Map<String, Object> map= (Map<String, Object>) model.get("map");
		List<Object> data = (List<Object>) map.get("data");
		StatsVO vo = (StatsVO)map.get("statsVO");
 
		
		String title = "폐수방류량 통계";
		
			
		HSSFSheet sheet = wb.createSheet(title);
		sheet.setDefaultColumnWidth((short)15);

		//파일이름 설정
		String filename = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String ctime = sdf.format(new Date(System.currentTimeMillis()));
		filename = "stats_river_outlet" + "-"+ctime+".xls";
	    filename = new String(filename.getBytes("euc-kr"), "8859_1"); 
	    resp.setHeader("Content-Disposition", "attachment;filename="+filename+";"); 
	    
	    
	    
	   		
	    
		int maxCell = 16;

		
		
		String sdt = vo.getFrDate();
		String edt = vo.getToDate();
		String statsTitle = "";
		
		statsTitle = "기간 : "+sdt.substring(0,4)+"년"+sdt.substring(4,6)+"월"+sdt.substring(6,8)+"일 "+" ~ "
				+edt.substring(0,4)+"년"+edt.substring(4,6)+"월"+edt.substring(6,8)+"일 ";	
		
//		statsTitle = "[ "+vo.getFrDate() + " ~ " + vo.getToDate() + " ]";
		
		
		

		
		
		// 제목
		cell = getCell(sheet, 0, 0);
		sheet.addMergedRegion(new CellRangeAddress(0,0,0,maxCell));
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)14);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();		
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		
				
		cell.setCellStyle(style);		
		setText(cell, title);	
		
		//검증되지 않은 데이터	
		cell = getCell(sheet, 1, 0);
		sheet.addMergedRegion(new CellRangeAddress(1,1,0,maxCell));		
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)11);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();		
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);		
				
		cell.setCellStyle(style);	
		setText(cell,"");
		
		// 기간		
		cell = getCell(sheet, 2, 0);
		sheet.addMergedRegion(new CellRangeAddress(2,2,0,maxCell));		
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)11);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();		
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_LEFT);		
				
		cell.setCellStyle(style);	
		setText(cell, statsTitle);			
		
		
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
		int addIdx = 3;
		
		
		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+1,cellIdx,cellIdx));
		setText(cell, "수계");
		cell = getCell(sheet, addIdx, cellIdx);
		cell.setCellStyle(style);
		cell = getCell(sheet, addIdx+1, cellIdx);
		cell.setCellStyle(style);
		
		sheet.setColumnWidth(cellIdx, 6000);
		
		cellIdx++;
		
		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+1,cellIdx,cellIdx));
		setText(cell,"측정일");
		cell = getCell(sheet, addIdx, cellIdx);
		cell.setCellStyle(style);
		cell = getCell(sheet, addIdx+1, cellIdx);
		cell.setCellStyle(style);
		
		cellIdx++;
		
		
		String[] items = null;
		

		items = new String[]{"BOD(ppm)", "COD(ppm)", "SS(mg/L)", "TON(mg/L)", "TOP(mg/L)"};
		
		
		//헤더생성
		for(int idx = 0 ; idx < items.length ; idx++)
		{	
			cellIdx = 2 + (idx * 3);
				
			cell = getCell(sheet, addIdx, cellIdx);
			setText(cell, items[idx]);
			sheet.addMergedRegion(new CellRangeAddress(addIdx, addIdx,cellIdx,cellIdx+2));
			cell = getCell(sheet, addIdx, cellIdx);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx, cellIdx+1);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx, cellIdx+2);
			cell.setCellStyle(style);
		
			
			cell = getCell(sheet, addIdx+1, cellIdx);
			setText(cell, "부하량");
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx+1, cellIdx+1);
			setText(cell, "방류량");
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx+1, cellIdx+2);
			setText(cell, "평균값");
			cell.setCellStyle(style);
		}
		
		addIdx+=2;
		
		
		
		boolean isVO = false;
 
		if (data.size() > 0) {
			Object obj = data.get(0);
			isVO = obj instanceof StatsVO;
		}
		
		
 
		for (int i = 0; i < data.size(); i++) {
 
			if (isVO) {	// VO
 
				StatsVO vo2 = (StatsVO) data.get(i);
				
				style = wb.createCellStyle();
				
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);				
				style.setLocked(false);
				
			
			    cellIdx = 0;
                
			   
			  
			    //수계
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getRiverName());
				cell.setCellStyle(style);			

				//측정시간
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTime());
				cell.setCellStyle(style);				
					
				
				style = wb.createCellStyle();
				style.setDataFormat(format.getFormat("0.00"));
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);	
				style.setLocked(false);

				
				//BOD Value
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getBodValue());
				cell.setCellStyle(style);
				//Flow
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getBodFlow());
				cell.setCellStyle(style);
				//Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getBodAvg());
				cell.setCellStyle(style);
				
				//COD Value
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getCodValue());
				cell.setCellStyle(style);
				//Flow
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getCodFlow());
				cell.setCellStyle(style);
				//Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getCodAvg());
				cell.setCellStyle(style);
				
				//SUS Value
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getSusValue());
				cell.setCellStyle(style);
				//Flow
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getSusFlow());
				cell.setCellStyle(style);
				//Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getSusAvg());
				cell.setCellStyle(style);
				
				//TON Value
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTonValue());
				cell.setCellStyle(style);
				//Flow
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTonFlow());
				cell.setCellStyle(style);
				//Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTonAvg());
				cell.setCellStyle(style);
				
				//TOP Value
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTopValue());
				cell.setCellStyle(style);
				//Flow
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTopFlow());
				cell.setCellStyle(style);
				//Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTopAvg());
				cell.setCellStyle(style);
				
			
				
			} else {	// Map
 
				Map<String, String> category = (Map<String, String>) map.get(i);
 
				cell = getCell(sheet, 3 + i, 0);
				setText(cell, category.get("id"));
 
				cell = getCell(sheet, 3 + i, 1);
				setText(cell, category.get("name"));
 
				cell = getCell(sheet, 3 + i, 2);
				setText(cell, category.get("description"));
 
				cell = getCell(sheet, 3 + i, 3);
				setText(cell, category.get("useyn"));
 
				cell = getCell(sheet, 3 + i, 4);
				setText(cell, category.get("reguser"));
 
			}
		}
	}
}
