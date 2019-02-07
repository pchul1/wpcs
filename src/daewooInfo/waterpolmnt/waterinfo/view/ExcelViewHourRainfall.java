package daewooInfo.waterpolmnt.waterinfo.view;

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

import daewooInfo.weather.bean.HourRainfallVO;
import daewooInfo.weather.bean.WeatherInfoVO;

public class ExcelViewHourRainfall extends AbstractExcelView{
	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook wb,
		HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HSSFCell cell = null;
		HSSFCellStyle style = null;
		HSSFDataFormat format = wb.createDataFormat();
		HSSFFont font = wb.createFont();

		Map<String, Object> map= (Map<String, Object>) model.get("map");
		List<Object> data = (List<Object>) map.get("data");
		HourRainfallVO vo = (HourRainfallVO)map.get("hourRainfallVO");
 
		String title = "기상정보(강수량) 조회 결과";
		
			
		HSSFSheet sheet = wb.createSheet(title);
		sheet.setDefaultColumnWidth((short)15);
 
		//파일이름 설정
		String filename = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String ctime = sdf.format(new Date(System.currentTimeMillis()));
		filename = "HourRainfall-"+ctime+".xls";
	    filename = new String(filename.getBytes("euc-kr"), "8859_1"); 
	    resp.setHeader("Content-Disposition", "attachment;filename="+filename+";"); 
		
		
		boolean isOneBranch = false;	//단일 측정소에 대한 결과
		int maxCell = 6;
		if(!"U".equals(vo.getSys()))
		{
			 if(!"all".equals(vo.getFactCode().toLowerCase()))
	         {
	         	maxCell = 3;
	         	isOneBranch = true;
	         }
		}
		else if("U".equals(vo.getSys()))
		{
			if(!"all".equals(vo.getBranch_no().toLowerCase()))
	         {
	         	maxCell = 3;
	         	isOneBranch = true;
	         }
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
		style.setAlignment(HSSFCellStyle.ALIGN_RIGHT);		
				
		cell.setCellStyle(style);	
		String sdt = vo.getFrDate();
		String edt = vo.getToDate();
		setText(cell, "기간 : "+sdt.substring(0,4)+"년"+sdt.substring(4,6)+"월"+sdt.substring(6,8)+"일 "
				+vo.getFrTime()+"시" +" ~ "
				+edt.substring(0,4)+"년"+edt.substring(4,6)+"월"+edt.substring(6,8)+"일 "
				+vo.getToTime()+"시");			
		
		
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
		
		if(!isOneBranch)
		{			
			cell = getCell(sheet, 3, 0);
			setText(cell, "수계");
			cell.setCellStyle(style);
	
			
			cell = getCell(sheet, 3, 1);
			setText(cell, "지역");
			cell.setCellStyle(style);
	
			
			cell = getCell(sheet, 3, 2);
			setText(cell, "측정소");
			cell.setCellStyle(style);
			
			cellIdx = 3;
		}
		else
		{
			addIdx = 4;
		}


		cell = getCell(sheet, addIdx, cellIdx++);
		setText(cell, "측정일");
		cell.setCellStyle(style);

		
		cell = getCell(sheet, addIdx, cellIdx++);
		setText(cell, "측정시간");
		cell.setCellStyle(style);

		
		cell = getCell(sheet, addIdx, cellIdx++);
		setText(cell, "시간강수량(mm)");
		cell.setCellStyle(style);


		cell = getCell(sheet, addIdx, cellIdx++);
		setText(cell, "누적강수량(mm)");
		cell.setCellStyle(style);

		
		boolean isVO = false;
 
		if (data.size() > 0) {
			Object obj = data.get(0);
			isVO = obj instanceof HourRainfallVO;
		}
		
		
		for (int i = 0; i < data.size(); i++) {
 
			if (isVO) {	// VO
 
				HourRainfallVO vo2 = (HourRainfallVO) data.get(i);
				
				style = wb.createCellStyle();
				
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);				
				style.setLocked(false);
				
				String factNumber = vo2.getFactName().replace(vo2.getRiver_name(),"");
				 
				if(isOneBranch && i == 0)
				{
					addIdx = 5;
					
					cell = getCell(sheet, 3, 0);
					sheet.addMergedRegion(new CellRangeAddress(3,3,0,maxCell));
					style.setBorderTop(HSSFCellStyle.BORDER_NONE);	
					style.setBorderLeft(HSSFCellStyle.BORDER_NONE);	
					style.setBorderRight(HSSFCellStyle.BORDER_NONE);	
					style.setBorderBottom(HSSFCellStyle.BORDER_NONE);	
					style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
					cell.setCellStyle(style);		
					setText(cell, " 측정소 : " + vo2.getRiver_name() + " - " + vo2.getRegionName() + "(" + factNumber + ")" + " ["  + vo2.getBranch_name() + "]");	
				}
				else if(i==0)
				{
					addIdx = 4;
				}
				
                cellIdx = 0;
                
                if(!isOneBranch)
				{
					//수계
					cell = getCell(sheet, 4 + i, 0);
					cell.setCellValue(vo2.getRiver_name());
					cell.setCellStyle(style);			
	
					//지역
					cell = getCell(sheet,4+ i, 1);
					cell.setCellValue(vo2.getRegionName() + "(" + factNumber + ")");
					cell.setCellStyle(style);				
	 
					//측정소
					cell = getCell(sheet, 4 + i, 2);
					cell.setCellValue(vo2.getBranch_name());
					cell.setCellStyle(style);				
					
					cellIdx = 3;
				}
                
				//일자
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getMeasu_date());
				cell.setCellStyle(style);				
				
				style = wb.createCellStyle();
				style.setDataFormat(format.getFormat("0.00"));
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);	
				style.setLocked(false);

				//시간
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getMeasu_time());
				cell.setCellStyle(style);
				
				//시간강수량
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getHour_rainfall());
				cell.setCellStyle(style);
				
				//누적 강수량
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getAcc_rainfall());
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
