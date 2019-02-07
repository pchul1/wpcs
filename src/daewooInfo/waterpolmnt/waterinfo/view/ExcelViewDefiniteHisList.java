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

import daewooInfo.waterpolmnt.waterinfo.bean.DetailViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.LimitViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.SelectDataVO;

public class ExcelViewDefiniteHisList extends AbstractExcelView{
	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook wb,
		HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HSSFCell cell = null;
		HSSFCellStyle style = null;
		HSSFCellStyle style_definiteType = null;
		HSSFDataFormat format = wb.createDataFormat();
		HSSFFont font = wb.createFont();
		HSSFFont font_red = wb.createFont();

		Map<String, Object> map= (Map<String, Object>) model.get("map");
		List<Object> data = (List<Object>) map.get("data");
		SelectDataVO selectDataVO = (SelectDataVO)map.get("selectDataVO");
		
		//파일이름 설정
		String filename = "";
  		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
  		String ctime = sdf.format(new Date(System.currentTimeMillis()));
  		filename = "DefiniteHisList-"+ctime+".xls";
  				
  		filename = new String(filename.getBytes("euc-kr"), "8859_1"); 
  		resp.setHeader("Content-Disposition", "attachment;filename="+filename+";"); 
	    
 
		HSSFSheet sheet = wb.createSheet("확정이력");
		sheet.setDefaultColumnWidth((short)18);
		
		String[] menu = {"번호","수계", "측정소", "확정 데이터 기간", "작업자", "작업일자", "확정구분"};
		
		// 제목
		cell = getCell(sheet, 0, 0);
		sheet.addMergedRegion(new CellRangeAddress(0,0,0,6));
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)14);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();		
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		
		cell.setCellStyle(style);		
		setText(cell, "확정이력");
		
		
		// 기간		
		cell = getCell(sheet, 1, 0);
		sheet.addMergedRegion(new CellRangeAddress(1,1,0,6));
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)11);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		style.setBorderBottom(HSSFCellStyle.BORDER_NONE);
				
		cell.setCellStyle(style);	
		String sdt = selectDataVO.getStr_time();
		String edt = selectDataVO.getEnd_time();
		setText(cell, "기간 : "+sdt.substring(0,4)+"년"+sdt.substring(4,6)+"월"+sdt.substring(6,8)+"일 "
				+sdt.substring(8,10)+"시" +" ~ "
				+edt.substring(0,4)+"년"+edt.substring(4,6)+"월"+edt.substring(6,8)+"일 "
				+edt.substring(8,10)+"시");
		
		
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
		
		boolean isVO = false;
 
		if (data.size() > 0) {
			Object obj = data.get(0);
			isVO = obj instanceof SelectDataVO;
		}
		
		for (int i = 0; i < data.size(); i++) {
 
			if (isVO) {	// VO
				
				SelectDataVO vo = (SelectDataVO)data.get(i);
				style = wb.createCellStyle();
				
				style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);				
				style.setLocked(false);
				
				font_red.setFontHeightInPoints((short)11);
				font_red.setFontName("맑은 고딕");
				font_red.setColor(HSSFColor.RED.index);
				
				
				//번호
				cell = getCell(sheet, 3 + i, 0);
				cell.setCellValue(i+1);
				cell.setCellStyle(style);
				
				
				//수계
				cell = getCell(sheet, 3 + i, 1);
				cell.setCellValue(vo.getRiver_name());
				cell.setCellStyle(style);		

				
				//측정소
				cell = getCell(sheet,3+ i, 2);
				cell.setCellValue(vo.getBranch_name());
				cell.setCellStyle(style);
				
				
				//확정 데이터 기간
				cell = getCell(sheet,3+ i, 3);
				cell.setCellValue(vo.getStr_time());
				cell.setCellStyle(style);

				
				//작업자
				cell = getCell(sheet,3+ i, 4);
				cell.setCellValue(vo.getReg_name());
				cell.setCellStyle(style);
				
				
				//작업일자
				cell = getCell(sheet,3+ i, 5);
				cell.setCellValue(vo.getReg_date());
				cell.setCellStyle(style);
				
				
				//확정구분
				style_definiteType = wb.createCellStyle();
				if(vo.getDefinite_type() != null && vo.getDefinite_type().equals("확정취소")){
					style_definiteType.setFont(font_red);
				}
				style_definiteType.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				style_definiteType.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style_definiteType.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style_definiteType.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style_definiteType.setBorderTop(HSSFCellStyle.BORDER_THIN);
				style_definiteType.setLocked(false);
				
				cell = getCell(sheet,3+ i, 6);
				cell.setCellValue(vo.getDefinite_type());
				cell.setCellStyle(style_definiteType);
				
				
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
