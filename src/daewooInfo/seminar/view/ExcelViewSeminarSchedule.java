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

public class ExcelViewSeminarSchedule extends AbstractExcelView{
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
		filename = "SeminarScheduleList.xls";
	    filename = new String(filename.getBytes("euc-kr"), "8859_1"); 
	    resp.setHeader("Content-Disposition", "attachment;filename="+filename+";"); 				
 
		HSSFSheet sheet = wb.createSheet("교육 일정");
		sheet.setDefaultColumnWidth((short)18);
		
		String[] count_menu = {"접수된 교육", "실시완료 교육", "실시예정 교육", "교육신청", "강사신청"};
		String[] menu = {"번호","교육명", "교육기간", "신청기간", "교육시간", "교육장소", "담당자", "연락처", "참여인원", "구분", "마감여부"};
		
		int totACnt = (Integer)map.get("totACnt");
		int totCCnt = (Integer)map.get("totCCnt");
		int totPCnt = (Integer)map.get("totPCnt");
		int totSCnt = (Integer)map.get("totSCnt");
		int totLCnt = (Integer)map.get("totLCnt");

		// 제목
		cell = getCell(sheet, 0, 0);
		sheet.addMergedRegion(new CellRangeAddress(0,0,0,10));
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)14);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();		
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		
				
		cell.setCellStyle(style);		
		setText(cell, "교육일정");
		
		//검증되지 않은 데이터	
		cell = getCell(sheet, 1, 0);
		sheet.addMergedRegion(new CellRangeAddress(1,1,0,2));	
		
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
 
		cell = getCell(sheet, 2, 0);
		setText(cell, count_menu[0]);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 1);
		setText(cell, count_menu[1]);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 2);
		setText(cell, count_menu[2]);		
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 3);
		setText(cell, count_menu[3]);		
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 4);
		setText(cell, count_menu[4]);		
		cell.setCellStyle(style);
		
		// 조회 데이타		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)11);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();
		
		style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		style.setBorderRight(HSSFCellStyle.BORDER_THIN);
		style.setBorderTop(HSSFCellStyle.BORDER_THIN);				
		style.setLocked(false);
	
		
		cell = getCell(sheet, 3, 0);
		cell.setCellValue(totACnt);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 3, 1);
		cell.setCellValue(totCCnt);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 3, 2);
		cell.setCellValue(totPCnt);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 3, 3);
		cell.setCellValue(totSCnt);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 3, 4);
		cell.setCellValue(totLCnt);
		cell.setCellStyle(style);
		
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
 
		cell = getCell(sheet, 5, 0);
		setText(cell, menu[0]);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 5, 1);
		setText(cell, menu[1]);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 5, 2);
		setText(cell, menu[2]);		
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 5, 3);
		setText(cell, menu[3]);		
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 5, 4);
		setText(cell, menu[4]);		
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 5, 5);
		setText(cell, menu[5]);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 5, 6);
		setText(cell, menu[6]);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 5, 7);
		setText(cell, menu[7]);		
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 5, 8);
		setText(cell, menu[8]);		
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 5, 9);
		setText(cell, menu[9]);		
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 5, 10);
		setText(cell, menu[10]);		
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
				cell = getCell(sheet, 6 + i, 0);
				cell.setCellValue(i+1);
				cell.setCellStyle(style);
				
				//교육명
				cell = getCell(sheet, 6 + i, 1);
				cell.setCellValue(vo2.getSeminarTitle());
				cell.setCellStyle(style);			
 

				//교육기간
				cell = getCell(sheet,6+ i, 2);
				cell.setCellValue(vo2.getSeminarDate());
				cell.setCellStyle(style);
				
				//신청기간
				cell = getCell(sheet,6+ i, 3);
				cell.setCellValue(vo2.getSeminarEntryDate());
				cell.setCellStyle(style);
				
				//교육시간
				cell = getCell(sheet,6+ i, 4);
				cell.setCellValue(vo2.getSeminarTimeFrom() + "~" + vo2.getSeminarTimeTo());
				cell.setCellStyle(style);
				
				//교육장소
				cell = getCell(sheet,6+ i, 5);
				cell.setCellValue(vo2.getSeminarPlace());
				cell.setCellStyle(style);
				
				//담당자
				cell = getCell(sheet,6+ i, 6);
				cell.setCellValue(vo2.getSeminarLectName());
				cell.setCellStyle(style);
				
				//연락처
				cell = getCell(sheet,6+ i, 7);
				cell.setCellValue(vo2.getSeminarLectTel());
				cell.setCellStyle(style);
				
				//참여인원
				cell = getCell(sheet,6+ i, 8);
				cell.setCellValue(vo2.getEntryCount() + "/" +vo2.getSeminarCount());
				cell.setCellStyle(style);
				
				//구분
				cell = getCell(sheet,6+ i, 9);
				cell.setCellValue(vo2.getSeminarGubunName());
				cell.setCellStyle(style);
				
				//마감여부
				cell = getCell(sheet,6+ i, 10);
				cell.setCellValue(vo2.getSeminarClosingStateName());
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
