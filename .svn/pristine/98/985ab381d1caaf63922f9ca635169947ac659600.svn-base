package daewooInfo.edu.view;

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

import daewooInfo.edu.bean.EduSearchVO;

public class ExcelEduView extends AbstractExcelView{
	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook wb,
		HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HSSFCell cell = null;
		HSSFCellStyle style = null;
		HSSFDataFormat format = wb.createDataFormat();
		HSSFFont font = wb.createFont();
				 
		Map<String, Object> map= (Map<String, Object>) model.get("chartMap");
		String[] menu = (String[]) map.get("menu");
		List<Object> chart = (List<Object>) map.get("chart");
		String title = (String)map.get("title");
		String strDate = (String)map.get("strDate");
		String endDate = (String)map.get("endDate");
		
		//엑셀의 캐릭터셋을 설정한다.(UTF-8)
		resp.setContentType("application/vnd.ms-excel; charset=UTF-8");
		
		//엑셀파일명을 설정한다.
		resp.setHeader("Content-Disposition", "attachment; filename=\"eduMember.xls\"");				
 
		HSSFSheet sheet = wb.createSheet(title);
		sheet.setDefaultColumnWidth((short) 12);
 
		// 제목
		cell = getCell(sheet, 0, 0);
		sheet.addMergedRegion(new CellRangeAddress(0,0,0,4));
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)14);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();		
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(HSSFColor.BRIGHT_GREEN.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);		
				
		cell.setCellStyle(style);		
		setText(cell, title);	
		
		cell = getCell(sheet, 1, 0);
		sheet.addMergedRegion(new CellRangeAddress(1,1,0,4));		
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)11);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();		
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_RIGHT);		
				
		cell.setCellStyle(style);		
		setText(cell, "교육기간 : "+strDate+"~"+endDate);			
		
		// 컬럼명을 셋팅한다.		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)11);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();		
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);		
 
		cell = getCell(sheet, 2, 0);
		setText(cell, menu[0]);
		sheet.addMergedRegion(new CellRangeAddress(2,3,0,0));
		sheet.autoSizeColumn((short)1);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 1);
		setText(cell, menu[1]);
		sheet.addMergedRegion(new CellRangeAddress(2,3,1,1));
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 2);
		setText(cell, menu[2]);
		sheet.addMergedRegion(new CellRangeAddress(2,3,2,2));
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 3);
		setText(cell, menu[3]);
		sheet.addMergedRegion(new CellRangeAddress(2,3,3,3));
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 4);
		setText(cell, menu[4]);
		sheet.addMergedRegion(new CellRangeAddress(2,3,4,4));
		cell.setCellStyle(style);
 
		boolean isVO = false;
 
		//데이터가 VO인지 여부를 체크한다.
		if (chart.size() > 0) {
			Object obj = chart.get(0);
			isVO = obj instanceof EduSearchVO;
		}
		
		for (int i = 0; i < chart.size(); i++) {
 
			if (isVO) {	// VO일경우
 
				EduSearchVO vo = (EduSearchVO) chart.get(i);
				
				style = wb.createCellStyle();
				
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);				
 
				cell = getCell(sheet, 4 + i, 0);
				cell.setCellValue(vo.getNum());
				cell.setCellStyle(style);				
 
				cell = getCell(sheet, 4 + i, 1);
				cell.setCellValue(vo.getTitle());
				cell.setCellStyle(style);				
 
				cell = getCell(sheet, 4 + i, 2);
				cell.setCellValue(vo.getMemberName());
				cell.setCellStyle(style);				
 
				cell = getCell(sheet, 4 + i, 3);
				cell.setCellValue(vo.getDeptNoName());
				cell.setCellStyle(style);				
 
				cell = getCell(sheet, 4 + i, 4);
				cell.setCellValue(vo.getMobileNo());
				cell.setCellStyle(style);				
				
			} else {	// Map일경우(미사용)
 
				Map<String, String> category = (Map<String, String>) chart.get(i);
 
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
