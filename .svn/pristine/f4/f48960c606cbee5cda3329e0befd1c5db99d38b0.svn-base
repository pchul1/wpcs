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

public class ExcelStatsAdActView extends AbstractExcelView{
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
 
		
		String title = "사전조치통계";
		
			
		HSSFSheet sheet = wb.createSheet(title);
		sheet.setDefaultColumnWidth((short)15);

		//파일이름 설정
		String filename = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String ctime = sdf.format(new Date(System.currentTimeMillis()));
		filename = "ad_acct-"+ctime+".xls";
	    filename = new String(filename.getBytes("euc-kr"), "8859_1"); 
	    resp.setHeader("Content-Disposition", "attachment;filename="+filename+";"); 
	    
	    
	    
	   		
	    
		int maxCell = 5;
		
		String gubun = vo.getGubun();
		
		
		String statsTitle = "";
		
		if("1".equals(gubun)) {
			statsTitle = "[ "+vo.getSearchYear()+"년 년간 통계 ]";
		} else if("2".equals(gubun) && !"all".equals(vo.getSearchQuarter())) {
			statsTitle = "[ "+vo.getSearchYear()+"년 "+vo.getSearchQuarter()+"분기 통계 ]";
		} else if("2".equals(gubun) && "all".equals(vo.getSearchQuarter())) {			
			statsTitle = "[ "+vo.getSearchYear()+"년 분기별 통계 ]";
		} else if("3".equals(gubun) && !"all".equals(vo.getSearchMonth())) {
			statsTitle = "[ "+vo.getSearchYear()+"년 "+vo.getSearchMonth()+"월 월별 통계 ]";
		} else if("3".equals(gubun) && "all".equals(vo.getSearchMonth())) {
			statsTitle = "[ "+vo.getSearchYear()+"년 월간 통계 ]";	
		} else if("4".equals(gubun)) {
			statsTitle = "[ "+ vo.getStartDate() +" 부터" + vo.getEndDate() +"까지의 통계 ]";
		}
		
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
		
		
		cell = getCell(sheet, addIdx, cellIdx++);
		setText(cell, "일시");
		cell.setCellStyle(style);
		
		cell = getCell(sheet, addIdx, cellIdx++);
		setText(cell, "기상");
		cell.setCellStyle(style);
		
		cell = getCell(sheet, addIdx, cellIdx++);
		setText(cell, "훈련");
		cell.setCellStyle(style);
		
		cell = getCell(sheet, addIdx, cellIdx++);
		setText(cell, "긴급상황");
		cell.setCellStyle(style);
		
		cell = getCell(sheet, addIdx, cellIdx++);
		setText(cell, "점검요청");
		cell.setCellStyle(style);
		
		cell = getCell(sheet, addIdx, cellIdx++);
		setText(cell, "기타");
		cell.setCellStyle(style);
		
		
		addIdx++;
		
		
		
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

			    String date="";
			    
			    
			    if("1".equals(gubun))
   			     	date = vo2.getStatsDate() + "년";
   			 	else if("2".equals(gubun))
				 	 date = vo.getSearchYear() + "년 " + vo2.getQuarter();
				 else if("3".equals(gubun))
					 date = vo.getSearchYear() + "년 " + vo2.getStartMonth()+ "월";
				 else
					 date = vo2.getDay();
			    
			   				 
				//일시
				cell = getCell(sheet, addIdx+ i, cellIdx++);
				cell.setCellValue(date);
				cell.setCellStyle(style);		
			
				
				style = wb.createCellStyle();
				style.setDataFormat(format.getFormat("0.00"));
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);	
				style.setLocked(false);
				
				//기상
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getActWeather());
				cell.setCellStyle(style);				
				
				//훈련
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getActTraning());
				cell.setCellStyle(style);				
				
				//긴급상황
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getActEmc());
				cell.setCellStyle(style);				

				//점검요청
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getActChk());
				cell.setCellStyle(style);				
			
				//기타
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getActOther());
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
