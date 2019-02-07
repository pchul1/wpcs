package daewooInfo.admin.access.view;

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

import daewooInfo.admin.access.bean.AccessManageVO;

public class ExcelViewAccessIndiList extends AbstractExcelView{
	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook wb,
		HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HSSFCell cell = null;
		HSSFCellStyle style = null;
		HSSFDataFormat format = wb.createDataFormat();
		HSSFFont font = wb.createFont();

		Map<String, Object> map= (Map<String, Object>) model.get("map");
		List<Object> data = (List<Object>) map.get("data");
		//AccessManageVO vo = (AccessManageVO)map.get("AccessManageVO");
		
		//파일이름 설정
		String filename = "";
		filename = "AccessIndiList.xls";
	    filename = new String(filename.getBytes("euc-kr"), "8859_1"); 
	    resp.setHeader("Content-Disposition", "attachment;filename="+filename+";"); 				
 
		HSSFSheet sheet = wb.createSheet("개인정보취급현황");
		sheet.setDefaultColumnWidth((short)15);
		
		String[] menu = {"순번", "로그인ID", "수행업무", "테이블명", "접속자IP", "접속일"};
		
		// 제목
		cell = getCell(sheet, 0, 0);
		sheet.addMergedRegion(new CellRangeAddress(0,0,0,5));
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)14);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		
		
		cell.setCellStyle(style);
		setText(cell, "개인정보취급현황");
		
		//검증되지 않은 데이터
		cell = getCell(sheet, 1, 0);
		sheet.addMergedRegion(new CellRangeAddress(1,1,0,5));
		
		//컬럼명 
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

		for(int i=0; i<menu.length; i++){
			cell = getCell(sheet, 2, i);
			setText(cell, menu[i]);
			cell.setCellStyle(style);
		}
		
		for (int i = 0; i < data.size(); i++) {
			Map<String, String> category = (Map<String, String>) data.get(i);
			
			if(category != null){
				cell = getCell(sheet, 3 + i, 0);
				setText(cell, category.get("loginId"));

				cell = getCell(sheet, 3 + i, 1);
				setText(cell, category.get("memberId"));

				cell = getCell(sheet, 3 + i, 2);
				setText(cell, category.get("type"));

				cell = getCell(sheet, 3 + i, 3);
				setText(cell, category.get("tableNm"));

				cell = getCell(sheet, 3 + i, 4);
				setText(cell, category.get("connectIp"));
				
				cell = getCell(sheet, 3 + i, 5);
				setText(cell, category.get("regDate"));
			}

		}
	}
}
