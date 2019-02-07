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

public class ExcelViewSelectDataList extends AbstractExcelView{
	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook wb,
		HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HSSFCell cell = null;
		HSSFCellStyle style = null;
		HSSFCellStyle style_tur = null;
		HSSFCellStyle style_tmp = null;
		HSSFCellStyle style_phy = null;
		HSSFCellStyle style_dow = null;
		HSSFCellStyle style_con = null;
		HSSFCellStyle style_tof = null;
		HSSFDataFormat format = wb.createDataFormat();
		HSSFFont font = wb.createFont();
		HSSFFont font_red = wb.createFont();
		HSSFFont font_blue = wb.createFont();
		HSSFFont font_aqua = wb.createFont();
		HSSFFont font_violet = wb.createFont();
		HSSFFont font_pink = wb.createFont();
		HSSFFont font_gray = wb.createFont();
		HSSFFont font_darkYellow = wb.createFont();
		HSSFFont font_green = wb.createFont();

		Map<String, Object> map= (Map<String, Object>) model.get("map");
		List<Object> data = (List<Object>) map.get("data");
		SelectDataVO selectDataVO = (SelectDataVO)map.get("selectDataVO");
		
		//파일이름 설정
  		String filename = "";
  		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
  		String ctime = sdf.format(new Date(System.currentTimeMillis()));
  		filename = "SelectDataList-"+ctime+".xls";
  				
  		filename = new String(filename.getBytes("euc-kr"), "8859_1"); 
  		resp.setHeader("Content-Disposition", "attachment;filename="+filename+";"); 
	    
 
		HSSFSheet sheet = wb.createSheet("데이터선별");
		sheet.setDefaultColumnWidth((short)18);
		
		String[] menu = {"번호","수계", "측정소", "수신일자", "수신시간", "탁도(NTU)", "수온(℃)", "ph", "DO(mg/L)", "EC(mS/cm)", "Chl-a(μg/L)"};
		
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
		setText(cell, "데이터선별");
		
		
		// 기간		
		cell = getCell(sheet, 1, 0);
		sheet.addMergedRegion(new CellRangeAddress(1,1,0,10));
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)11);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		style.setBorderBottom(HSSFCellStyle.BORDER_NONE);
				
		cell.setCellStyle(style);	
		String year = selectDataVO.getSearchYear();
		String month = selectDataVO.getSearchMonth();
		setText(cell, "기간 : "+year+"년"+month+"월");
		
		
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
		
		cell = getCell(sheet, 2, 9);
		setText(cell, menu[9]);		
		cell.setCellStyle(style);
		
		cell = getCell(sheet, 2, 10);
		setText(cell, menu[10]);		
		cell.setCellStyle(style);

		boolean isVO = false;
 
		if (data.size() > 0) {
			Object obj = data.get(0);
			isVO = obj instanceof LimitViewVO;
		}
		
		for (int i = 0; i < data.size(); i++) {
 
			if (isVO) {	// VO
				
				LimitViewVO vo = (LimitViewVO)data.get(i);
				
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

				font_blue.setFontHeightInPoints((short)11);
				font_blue.setFontName("맑은 고딕");
				font_blue.setColor(HSSFColor.BLUE.index);
				
				font_aqua.setFontHeightInPoints((short)11);
				font_aqua.setFontName("맑은 고딕");
				font_aqua.setColor(HSSFColor.AQUA.index);
				
				font_violet.setFontHeightInPoints((short)11);
				font_violet.setFontName("맑은 고딕");
				font_violet.setColor(HSSFColor.VIOLET.index);
				
				font_pink.setFontHeightInPoints((short)11);
				font_pink.setFontName("맑은 고딕");
				font_pink.setColor(HSSFColor.PINK.index);
				
				font_gray.setFontHeightInPoints((short)11);
				font_gray.setFontName("맑은 고딕");
				font_gray.setColor(HSSFColor.GREY_50_PERCENT.index);
				
				font_darkYellow.setFontHeightInPoints((short)11);
				font_darkYellow.setFontName("맑은 고딕");
				font_darkYellow.setColor(HSSFColor.DARK_YELLOW.index);
				
				font_green.setFontHeightInPoints((short)11);
				font_green.setFontName("맑은 고딕");
				font_green.setColor(HSSFColor.GREEN.index);
				
				if(vo.getTur() == null || vo.getTur().equals("")){vo.setTur("-");}
				if(vo.getTmp() == null || vo.getTmp().equals("")){vo.setTmp("-");}
				if(vo.getPhy() == null || vo.getPhy().equals("")){vo.setPhy("-");}
				if(vo.getDow() == null || vo.getDow().equals("")){vo.setDow("-");}
				if(vo.getCon() == null || vo.getCon().equals("")){vo.setCon("-");}
				if(vo.getTof() == null || vo.getTof().equals("")){vo.setTof("-");}

				
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
				
				//수신일자
				cell = getCell(sheet,3+ i, 3);
				cell.setCellValue(vo.getStr_date());
				cell.setCellStyle(style);

				//수신시간
				cell = getCell(sheet,3+ i, 4);
				cell.setCellValue(vo.getStr_time());
				cell.setCellStyle(style);
				
				//탁도(NTU)
				style_tur = wb.createCellStyle();
				if(vo.getTur_or() != null && Integer.parseInt(vo.getTur_or()) > 0){
					style_tur.setFont(font_red);
				}else{
					if(vo.getTur_st() != null && Integer.parseInt(vo.getTur_st()) > 0){
						if(vo.getTur_st().equals("1")){style_tur.setFont(font_darkYellow);}
						if(vo.getTur_st().equals("2")){style_tur.setFont(font_green);}
						if(vo.getTur_st().equals("3")){style_tur.setFont(font_aqua);}
						if(vo.getTur_st().equals("4")){style_tur.setFont(font_blue);}
						if(vo.getTur_st().equals("5")){style_tur.setFont(font_gray);}
						if(vo.getTur_st().equals("6")){style_tur.setFont(font_pink);}
						if(vo.getTur_st().equals("7")){style_tur.setFont(font_violet);}
						if(vo.getTur_st().equals("8")){style_tur.setFont(font_green);}
						if(vo.getTur_st().equals("9")){style_tur.setFont(font_green);}
					}
				}
				if(vo.getTur_sel() != null){
					style_tur.setFillForegroundColor(HSSFColor.CORNFLOWER_BLUE.index);
					style_tur.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				}else if(vo.getTur_over() != null && Integer.parseInt(vo.getTur_over()) > 0){
					style_tur.setFillForegroundColor(HSSFColor.ROSE.index);
					style_tur.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				}
				style_tur.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				style_tur.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style_tur.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style_tur.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style_tur.setBorderTop(HSSFCellStyle.BORDER_THIN);
				style_tur.setLocked(false);
				
				cell = getCell(sheet,3+ i, 5);
				cell.setCellValue(vo.getTur());
				cell.setCellStyle(style_tur);
				
				
				//수온(℃)
				style_tmp = wb.createCellStyle();
				if(vo.getTmp_or() != null && Integer.parseInt(vo.getTmp_or()) > 0){
					style_tmp.setFont(font_red);
				}else{
					if(vo.getTmp_st() != null && Integer.parseInt(vo.getTmp_st()) > 0){
						if(vo.getTmp_st().equals("1")){style_tmp.setFont(font_darkYellow);}
						if(vo.getTmp_st().equals("2")){style_tmp.setFont(font_green);}
						if(vo.getTmp_st().equals("3")){style_tmp.setFont(font_aqua);}
						if(vo.getTmp_st().equals("4")){style_tmp.setFont(font_blue);}
						if(vo.getTmp_st().equals("5")){style_tmp.setFont(font_gray);}
						if(vo.getTmp_st().equals("6")){style_tmp.setFont(font_pink);}
						if(vo.getTmp_st().equals("7")){style_tmp.setFont(font_violet);}
						if(vo.getTmp_st().equals("8")){style_tmp.setFont(font_green);}
						if(vo.getTmp_st().equals("9")){style_tmp.setFont(font_green);}
					}
				}
				if(vo.getTmp_sel() != null){
					style_tmp.setFillForegroundColor(HSSFColor.CORNFLOWER_BLUE.index);
					style_tmp.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				}else if(vo.getTmp_over() != null && Integer.parseInt(vo.getTmp_over()) > 0){
					style_tmp.setFillForegroundColor(HSSFColor.ROSE.index);
					style_tmp.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				}
				style_tmp.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				style_tmp.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style_tmp.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style_tmp.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style_tmp.setBorderTop(HSSFCellStyle.BORDER_THIN);
				style_tmp.setLocked(false);
				
				cell = getCell(sheet,3+ i, 6);
				cell.setCellValue(vo.getTmp());
				cell.setCellStyle(style_tmp);
				
				
				//pH
				style_phy = wb.createCellStyle();
				if(vo.getPhy_or() != null && Integer.parseInt(vo.getPhy_or()) > 0){
					style_phy.setFont(font_red);
				}else{
					if(vo.getPhy_st() != null && Integer.parseInt(vo.getPhy_st()) > 0){
						if(vo.getPhy_st().equals("1")){style_phy.setFont(font_darkYellow);}
						if(vo.getPhy_st().equals("2")){style_phy.setFont(font_green);}
						if(vo.getPhy_st().equals("3")){style_phy.setFont(font_aqua);}
						if(vo.getPhy_st().equals("4")){style_phy.setFont(font_blue);}
						if(vo.getPhy_st().equals("5")){style_phy.setFont(font_gray);}
						if(vo.getPhy_st().equals("6")){style_phy.setFont(font_pink);}
						if(vo.getPhy_st().equals("7")){style_phy.setFont(font_violet);}
						if(vo.getPhy_st().equals("8")){style_phy.setFont(font_green);}
						if(vo.getPhy_st().equals("9")){style_phy.setFont(font_green);}
					}
				}
				if(vo.getPhy_sel() != null){
					style_phy.setFillForegroundColor(HSSFColor.CORNFLOWER_BLUE.index);
					style_phy.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				}else if(vo.getPhy_over() != null && Integer.parseInt(vo.getPhy_over()) > 0){
					style_phy.setFillForegroundColor(HSSFColor.ROSE.index);
					style_phy.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				}
				style_phy.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				style_phy.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style_phy.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style_phy.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style_phy.setBorderTop(HSSFCellStyle.BORDER_THIN);
				style_phy.setLocked(false);
				
				cell = getCell(sheet,3+ i, 7);
				cell.setCellValue(vo.getPhy());
				cell.setCellStyle(style_phy);
				
				
				//DO(mg/L)
				style_dow = wb.createCellStyle();
				if(vo.getDow_or() != null && Integer.parseInt(vo.getDow_or()) > 0){
					style_dow.setFont(font_red);
				}else{
					if(vo.getDow_st() != null && Integer.parseInt(vo.getDow_st()) > 0){
						if(vo.getDow_st().equals("1")){style_dow.setFont(font_darkYellow);}
						if(vo.getDow_st().equals("2")){style_dow.setFont(font_green);}
						if(vo.getDow_st().equals("3")){style_dow.setFont(font_aqua);}
						if(vo.getDow_st().equals("4")){style_dow.setFont(font_blue);}
						if(vo.getDow_st().equals("5")){style_dow.setFont(font_gray);}
						if(vo.getDow_st().equals("6")){style_dow.setFont(font_pink);}
						if(vo.getDow_st().equals("7")){style_dow.setFont(font_violet);}
						if(vo.getDow_st().equals("8")){style_dow.setFont(font_green);}
						if(vo.getDow_st().equals("9")){style_dow.setFont(font_green);}
					}
				}
				if(vo.getDow_sel() != null){
					style_dow.setFillForegroundColor(HSSFColor.CORNFLOWER_BLUE.index);
					style_dow.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				}else if(vo.getDow_over() != null && Integer.parseInt(vo.getDow_over()) > 0){
					style_dow.setFillForegroundColor(HSSFColor.ROSE.index);
					style_dow.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				}
				style_dow.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				style_dow.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style_dow.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style_dow.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style_dow.setBorderTop(HSSFCellStyle.BORDER_THIN);
				style_dow.setLocked(false);
				
				cell = getCell(sheet,3+ i, 8);
				cell.setCellValue(vo.getDow());
				cell.setCellStyle(style_dow);
				
				
				//EC(mS/cm)
				style_con = wb.createCellStyle();
				if(vo.getCon_or() != null && Integer.parseInt(vo.getCon_or()) > 0){
					style_con.setFont(font_red);
				}else{
					if(vo.getCon_st() != null && Integer.parseInt(vo.getCon_st()) > 0){
						if(vo.getCon_st().equals("1")){style_con.setFont(font_darkYellow);}
						if(vo.getCon_st().equals("2")){style_con.setFont(font_green);}
						if(vo.getCon_st().equals("3")){style_con.setFont(font_aqua);}
						if(vo.getCon_st().equals("4")){style_con.setFont(font_blue);}
						if(vo.getCon_st().equals("5")){style_con.setFont(font_gray);}
						if(vo.getCon_st().equals("6")){style_con.setFont(font_pink);}
						if(vo.getCon_st().equals("7")){style_con.setFont(font_violet);}
						if(vo.getCon_st().equals("8")){style_con.setFont(font_green);}
						if(vo.getCon_st().equals("9")){style_con.setFont(font_green);}
					}
				}
				if(vo.getCon_sel() != null){
					style_con.setFillForegroundColor(HSSFColor.CORNFLOWER_BLUE.index);
					style_con.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				}else if(vo.getCon_over() != null && Integer.parseInt(vo.getCon_over()) > 0){
					style_con.setFillForegroundColor(HSSFColor.ROSE.index);
					style_con.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				}
				style_con.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				style_con.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style_con.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style_con.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style_con.setBorderTop(HSSFCellStyle.BORDER_THIN);
				style_con.setLocked(false);
				
				cell = getCell(sheet,3+ i, 9);
				cell.setCellValue(vo.getCon());
				cell.setCellStyle(style_con);
				
				
				//Chl-a(μg/L)
				style_tof = wb.createCellStyle();
				if(vo.getTof_or() != null && Integer.parseInt(vo.getTof_or()) > 0){
					style_tof.setFont(font_red);
				}else{
					if(vo.getTof_st() != null && Integer.parseInt(vo.getTof_st()) > 0){
						if(vo.getTof_st().equals("1")){style_tof.setFont(font_darkYellow);}
						if(vo.getTof_st().equals("2")){style_tof.setFont(font_green);}
						if(vo.getTof_st().equals("3")){style_tof.setFont(font_aqua);}
						if(vo.getTof_st().equals("4")){style_tof.setFont(font_blue);}
						if(vo.getTof_st().equals("5")){style_tof.setFont(font_gray);}
						if(vo.getTof_st().equals("6")){style_tof.setFont(font_pink);}
						if(vo.getTof_st().equals("7")){style_tof.setFont(font_violet);}
						if(vo.getTof_st().equals("8")){style_tof.setFont(font_green);}
						if(vo.getTof_st().equals("9")){style_tof.setFont(font_green);}
					}
				}
				if(vo.getTof_sel() != null){
					style_tof.setFillForegroundColor(HSSFColor.CORNFLOWER_BLUE.index);
					style_tof.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				}else if(vo.getTof_over() != null && Integer.parseInt(vo.getTof_over()) > 0){
					style_tof.setFillForegroundColor(HSSFColor.ROSE.index);
					style_tof.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
				}
				style_tof.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
				style_tof.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style_tof.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style_tof.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style_tof.setBorderTop(HSSFCellStyle.BORDER_THIN);
				style_tof.setLocked(false);
				
				cell = getCell(sheet,3+ i, 10);
				cell.setCellValue(vo.getTof());
				cell.setCellStyle(style_tof);
				
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
