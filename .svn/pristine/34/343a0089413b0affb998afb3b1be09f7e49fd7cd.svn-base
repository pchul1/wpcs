package daewooInfo.spotmanage.view;

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

import daewooInfo.spotmanage.bean.SpotManageVO;
import daewooInfo.waterpolmnt.waterinfo.bean.RiverWater3HourWarningVO;

public class ExcelDetailViewFact extends AbstractExcelView{
	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook wb,
			HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HSSFCell cell = null;
		HSSFCellStyle style = null;
		HSSFDataFormat format = wb.createDataFormat();
		HSSFFont font = wb.createFont();
		
		Map<String, Object> map= (Map<String, Object>) model.get("chartMap");
		List<Object> chart = (List<Object>) map.get("chart");
		SpotManageVO spotManageVO = (SpotManageVO)map.get("spotManageVO");
		
		HSSFSheet sheet = wb.createSheet("측정소 조회 결과");
		
		sheet.setDefaultColumnWidth((short)15);
		
		
		//파일이름 설정
		String filename = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String ctime = sdf.format(new Date(System.currentTimeMillis()));
		filename = "SpotmgrList-"+ctime+".xls";
		filename = new String(filename.getBytes("euc-kr"), "8859_1");
		
		resp.setContentType("application/vnd.ms-excel; charset=UTF-8");
		resp.setHeader("Content-Disposition", "attachment;filename="+filename+";");
		
		
		// 제목
		cell = getCell(sheet, 0, 0);
		sheet.addMergedRegion(new CellRangeAddress(0,0,0,7));
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)14);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		
		cell.setCellStyle(style);
		setText(cell, "측정소 조회 결과");
		
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
		setText(cell, "연번");
		sheet.addMergedRegion(new CellRangeAddress(2,2,0,0));
		sheet.autoSizeColumn((short)1);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 1);
		setText(cell, "지점코드");
		sheet.addMergedRegion(new CellRangeAddress(2,2,1,1));
		sheet.autoSizeColumn((short)1);
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 2);
		setText(cell, "지점(장비)명");
		sheet.addMergedRegion(new CellRangeAddress(2,2,2,2));
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 3);
		setText(cell, "권역");
		sheet.addMergedRegion(new CellRangeAddress(2,2,3,3));
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 4);
		setText(cell, "수계");
		sheet.addMergedRegion(new CellRangeAddress(2,2,4,4));
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 5);
		setText(cell, "시스템");
		sheet.addMergedRegion(new CellRangeAddress(2,2,5,5));
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 6);
		setText(cell, "관리주체");
		sheet.addMergedRegion(new CellRangeAddress(2,2,6,6));
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 7);
		setText(cell, "사용여부");
		sheet.addMergedRegion(new CellRangeAddress(2,2,7,7));
		cell.setCellStyle(style);
		
		boolean isVO = false;
		
		if (chart.size() > 0) {
			Object obj = chart.get(0);
			isVO = obj instanceof SpotManageVO;
		}
		
		for (int i = 0; i < chart.size(); i++) {
			
			if (isVO) {	// VO일경우
				
				SpotManageVO vo = (SpotManageVO) chart.get(i);
				
				style = wb.createCellStyle();
				
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);
				
				//연번
				cell = getCell(sheet, 3 + i, 0);
				cell.setCellValue(vo.getNum());
				cell.setCellStyle(style);
				
				//지점코드
				cell = getCell(sheet, 3 + i, 1);
				cell.setCellValue(vo.getFactCode());
				cell.setCellStyle(style);
				
				//지점(장비)명
				cell = getCell(sheet, 3 + i, 2);
				cell.setCellValue(vo.getBranchName());
				cell.setCellStyle(style);
			
				
				
				//권역
				cell = getCell(sheet, 3 + i, 3);
				cell.setCellValue(vo.getAreaName());
				cell.setCellStyle(style);
				
				//수계
				cell = getCell(sheet, 3 + i, 4);
				cell.setCellValue(vo.getRiverDiv());
				cell.setCellStyle(style);
				
				//시스템
				cell = getCell(sheet, 3 + i, 5);
				cell.setCellValue(vo.getSysKind());
				cell.setCellStyle(style);
				
				//관리주체
				cell = getCell(sheet, 3 + i, 6);
				cell.setCellValue(vo.getMgrOrg());
				cell.setCellStyle(style);
				
				//사용여부
				cell = getCell(sheet, 3 + i, 7);
				cell.setCellValue(vo.getBranchUseFlag());
				cell.setCellStyle(style);
			} else {	// Map
				
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
