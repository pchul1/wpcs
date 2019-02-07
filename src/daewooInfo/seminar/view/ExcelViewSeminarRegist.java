package daewooInfo.seminar.view;

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

import daewooInfo.seminar.bean.SeminarSearchVO;
import daewooInfo.seminar.bean.SeminarVO;

public class ExcelViewSeminarRegist extends AbstractExcelView{
	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook wb,
		HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HSSFCell cell = null;
		HSSFCellStyle style = null;
		HSSFDataFormat format = wb.createDataFormat();
		HSSFFont font = wb.createFont();

		Map<String, Object> map= (Map<String, Object>) model.get("map");
		List<Object> data = (List<Object>) map.get("data");
		SeminarVO vo = (SeminarVO)map.get("SeminarVO");
		
		//파일이름 설정
		String filename = "";
		filename = "SeminarRegistList.xls";
	    filename = new String(filename.getBytes("euc-kr"), "8859_1"); 
	    resp.setHeader("Content-Disposition", "attachment;filename="+filename+";"); 				
 
		HSSFSheet sheet = wb.createSheet("교육등록");
		sheet.setDefaultColumnWidth((short)18);
		
		String[] menu = {"번호","교육명", "교육기간", "담당자", "연락처", "작성자", "등록일", "구분", "상태"};
		
		// 제목
		cell = getCell(sheet, 0, 0);
		sheet.addMergedRegion(new CellRangeAddress(0,0,0,8));
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)14);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();		
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		
				
		cell.setCellStyle(style);		
		setText(cell, "교육등록");
		
		//검증되지 않은 데이터	
		cell = getCell(sheet, 1, 0);
		sheet.addMergedRegion(new CellRangeAddress(1,1,0,2));	
		
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

		cell = getCell(sheet, 2, 0);
		setText(cell, menu[0]);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 1);
		setText(cell, menu[1]);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 2);
		setText(cell, menu[2]);		
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 3);
		setText(cell, menu[3]);		
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 4);
		setText(cell, menu[4]);		
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 5);
		setText(cell, menu[5]);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 6);
		setText(cell, menu[6]);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 7);
		setText(cell, menu[7]);		
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 8);
		setText(cell, menu[8]);		
		cell.setCellStyle(style);

		boolean isVO = false;
 
		if (data.size() > 0) {
			Object obj = data.get(0);
			isVO = obj instanceof SeminarVO;
		}
		
		for (int i = 0; i < data.size(); i++) {
 
			if (isVO) {	// VO
 
				SeminarVO vo2 = (SeminarVO)data.get(i);
				style = wb.createCellStyle();
				
				style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);				
				style.setLocked(false);
				
				//번호
				cell = getCell(sheet, 3 + i, 0);
				cell.setCellValue(i+1);
				cell.setCellStyle(style);
				
				//교육명
				cell = getCell(sheet, 3 + i, 1);
				cell.setCellValue(vo2.getSeminarTitle());
				cell.setCellStyle(style);		

				//교육기간
				cell = getCell(sheet,3+ i, 2);
				cell.setCellValue(vo2.getSeminarDate());
				cell.setCellStyle(style);
				
				//담당자
				cell = getCell(sheet,3+ i, 3);
				cell.setCellValue(vo2.getSeminarLectName());
				cell.setCellStyle(style);
				
				//연락처
				cell = getCell(sheet,3+ i, 4);
				cell.setCellValue(vo2.getSeminarLectTel());
				cell.setCellStyle(style);
				
				//작성자
				cell = getCell(sheet,3+ i, 5);
				cell.setCellValue(vo2.getWriterName());
				cell.setCellStyle(style);
				
				//등록일
				cell = getCell(sheet,3+ i, 6);
				cell.setCellValue(vo2.getRegDate());
				cell.setCellStyle(style);
				
				//구분
				cell = getCell(sheet,3+ i, 7);
				cell.setCellValue(vo2.getSeminarGubunName());
				cell.setCellStyle(style);
				
				//상태
				cell = getCell(sheet,3+ i, 8);
				cell.setCellValue(vo2.getSeminarStateName());
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
