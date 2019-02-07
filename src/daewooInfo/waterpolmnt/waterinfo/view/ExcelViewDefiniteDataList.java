package daewooInfo.waterpolmnt.waterinfo.view;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
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

public class ExcelViewDefiniteDataList extends AbstractExcelView{
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
		filename = "DefiniteDataList-"+ctime+".xls";
				
		filename = new String(filename.getBytes("euc-kr"), "8859_1"); 
		resp.setHeader("Content-Disposition", "attachment;filename="+filename+";"); 
	    
 
		HSSFSheet sheet = wb.createSheet("데이터조회");
		sheet.setDefaultColumnWidth((short)18);
		
		String[] menu = {"번호","수계", "측정소", "수신일자", "수신시간", "탁도(NTU)", "수온(℃)", "ph", "DO(mg/L)", "EC(mS/cm)", "Chl-a(μg/L)"};
		
		int maxCell = 0;
		String tur_chk = "N";
		String tmp_chk = "N";
		String phy_chk = "N";
		String dow_chk = "N";
		String con_chk = "N";
		String tof_chk = "N";
		String item_list_text = selectDataVO.getItem_list_text();
		String[] item_code_list = item_list_text.split(",");
		for(int i=0;i<item_code_list.length;i++){
			String check_item = item_code_list[i];
			if(check_item.equals("TUR00")){
				tur_chk = "Y";
				maxCell++;
			}else if(check_item.equals("TMP00")){
				tmp_chk = "Y";
				maxCell++;
			}else if(check_item.equals("PHY00")){
				phy_chk = "Y";
				maxCell++;
			}else if(check_item.equals("DOW00")){
				dow_chk = "Y";
				maxCell++;
			}else if(check_item.equals("CON00")){
				con_chk = "Y";
				maxCell++;
			}else if(check_item.equals("TOF00")){
				tof_chk = "Y";
				maxCell++;
			}
		}
		if(selectDataVO.getDefinite_type().equals("all")){
			maxCell = (maxCell+maxCell)+4;
		}else{
			maxCell = maxCell+4;
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
		setText(cell, "데이터조회");
		
		// 기간		
		cell = getCell(sheet, 1, 0);
		sheet.addMergedRegion(new CellRangeAddress(1,1,0,maxCell));
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)11);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_RIGHT);
		style.setBorderBottom(HSSFCellStyle.BORDER_NONE);
				
		cell.setCellStyle(style);	
//		String sdt = selectDataVO.getStr_time();
//		String edt = selectDataVO.getEnd_time();
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
		
		
		int cn = 0;
		
		cell = getCell(sheet, 2, cn);
		sheet.addMergedRegion(new CellRangeAddress(2,3,cn,cn));
		setText(cell, menu[0]);
		cell = getCell(sheet, 2, cn);
		cell.setCellStyle(style);
		cell = getCell(sheet, 3, cn);
		cell.setCellStyle(style);
		cn++;
		
		
		cell = getCell(sheet, 2, cn);
		sheet.addMergedRegion(new CellRangeAddress(2,3,cn,cn));
		cell = getCell(sheet, 2, cn);
		setText(cell, menu[1]);
		cell = getCell(sheet, 2, cn);
		cell.setCellStyle(style);
		cell = getCell(sheet, 3, cn);
		cell.setCellStyle(style);
		cn++;
		
		
		cell = getCell(sheet, 2, cn);
		setText(cell, menu[2]);
		sheet.addMergedRegion(new CellRangeAddress(2,3,cn,cn));
		cell = getCell(sheet, 2, cn);
		cell.setCellStyle(style);
		cell = getCell(sheet, 3, cn);
		cell.setCellStyle(style);
		cn++;
		
		
		cell = getCell(sheet, 2, cn);
		setText(cell, menu[3]);
		sheet.addMergedRegion(new CellRangeAddress(2,3,cn,cn));
		cell = getCell(sheet, 2, cn);
		cell.setCellStyle(style);
		cell = getCell(sheet, 3, cn);
		cell.setCellStyle(style);
		cn++;
		
		
		cell = getCell(sheet, 2, cn);
		setText(cell, menu[4]);
		sheet.addMergedRegion(new CellRangeAddress(2,3,cn,cn));
		cell = getCell(sheet, 2, cn);
		cell.setCellStyle(style);
		cell = getCell(sheet, 3, cn);
		cell.setCellStyle(style);
		cn++;
		
		
		//탁도(NTU)
		if(tur_chk.equals("Y")){
			if(selectDataVO.getDefinite_type().equals("all")){
				cell = getCell(sheet, 2, cn);
				setText(cell, menu[5]);
				sheet.addMergedRegion(new CellRangeAddress(2,2,cn,cn+1));
			}else{
				cell = getCell(sheet, 2, cn);
				setText(cell, menu[5]);
				sheet.addMergedRegion(new CellRangeAddress(2,2,cn,cn));
			}
			
			if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("before")){
				cell = getCell(sheet, 2, cn);
				cell.setCellStyle(style);
				cell = getCell(sheet, 3, cn);
				setText(cell, "확정전");
				cell.setCellStyle(style);
				cn++;
			}
			if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("after")){
				cell = getCell(sheet, 2, cn);
				cell.setCellStyle(style);
				cell = getCell(sheet, 3, cn);
				setText(cell, "확정후");
				cell.setCellStyle(style);
				cn++;
			}
		}
		
		
		//수온(℃)
		if(tmp_chk.equals("Y")){
			if(selectDataVO.getDefinite_type().equals("all")){
				cell = getCell(sheet, 2, cn);
				setText(cell, menu[6]);
				sheet.addMergedRegion(new CellRangeAddress(2,2,cn,cn+1));
			}else{
				cell = getCell(sheet, 2, cn);
				setText(cell, menu[6]);
				sheet.addMergedRegion(new CellRangeAddress(2,2,cn,cn));
			}
			
			if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("before")){
				cell = getCell(sheet, 2, cn);
				cell.setCellStyle(style);
				cell = getCell(sheet, 3, cn);
				setText(cell, "확정전");
				cell.setCellStyle(style);
				cn++;
			}
			if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("after")){
				cell = getCell(sheet, 2, cn);
				cell.setCellStyle(style);
				cell = getCell(sheet, 3, cn);
				setText(cell, "확정후");
				cell.setCellStyle(style);
				cn++;
			}
		}
		
		
		//ph
		if(phy_chk.equals("Y")){
			if(selectDataVO.getDefinite_type().equals("all")){
				cell = getCell(sheet, 2, cn);
				setText(cell, menu[7]);
				sheet.addMergedRegion(new CellRangeAddress(2,2,cn,cn+1));
			}else{
				cell = getCell(sheet, 2, cn);
				setText(cell, menu[7]);
				sheet.addMergedRegion(new CellRangeAddress(2,2,cn,cn));
			}
			
			if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("before")){
				cell = getCell(sheet, 2, cn);
				cell.setCellStyle(style);
				cell = getCell(sheet, 3, cn);
				setText(cell, "확정전");
				cell.setCellStyle(style);
				cn++;
			}
			if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("after")){
				cell = getCell(sheet, 2, cn);
				cell.setCellStyle(style);
				cell = getCell(sheet, 3, cn);
				setText(cell, "확정후");
				cell.setCellStyle(style);
				cn++;
			}
		}
		
		
		//DO(mg/L)
		if(dow_chk.equals("Y")){
			if(selectDataVO.getDefinite_type().equals("all")){
				cell = getCell(sheet, 2, cn);
				setText(cell, menu[8]);
				sheet.addMergedRegion(new CellRangeAddress(2,2,cn,cn+1));
			}else{
				cell = getCell(sheet, 2, cn);
				setText(cell, menu[8]);
				sheet.addMergedRegion(new CellRangeAddress(2,2,cn,cn));
			}
			
			if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("before")){
				cell = getCell(sheet, 2, cn);
				cell.setCellStyle(style);
				cell = getCell(sheet, 3, cn);
				setText(cell, "확정전");
				cell.setCellStyle(style);
				cn++;
			}
			if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("after")){
				cell = getCell(sheet, 2, cn);
				cell.setCellStyle(style);
				cell = getCell(sheet, 3, cn);
				setText(cell, "확정후");
				cell.setCellStyle(style);
				cn++;
			}
		}
		
		
		//EC(mS/cm)
		if(con_chk.equals("Y")){
			if(selectDataVO.getDefinite_type().equals("all")){
				cell = getCell(sheet, 2, cn);
				setText(cell, menu[9]);
				sheet.addMergedRegion(new CellRangeAddress(2,2,cn,cn+1));
			}else{
				cell = getCell(sheet, 2, cn);
				setText(cell, menu[9]);
				sheet.addMergedRegion(new CellRangeAddress(2,2,cn,cn));
			}
			
			if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("before")){
				cell = getCell(sheet, 2, cn);
				cell.setCellStyle(style);
				cell = getCell(sheet, 3, cn);
				setText(cell, "확정전");
				cell.setCellStyle(style);
				cn++;
			}
			if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("after")){
				cell = getCell(sheet, 2, cn);
				cell.setCellStyle(style);
				cell = getCell(sheet, 3, cn);
				setText(cell, "확정후");
				cell.setCellStyle(style);
				cn++;
			}
		}
		
		
		//Chl-a(μg/L)
		if(tof_chk.equals("Y")){
			if(selectDataVO.getDefinite_type().equals("all")){
				cell = getCell(sheet, 2, cn);
				setText(cell, menu[10]);
				sheet.addMergedRegion(new CellRangeAddress(2,2,cn,cn+1));
			}else{
				cell = getCell(sheet, 2, cn);
				setText(cell, menu[10]);
				sheet.addMergedRegion(new CellRangeAddress(2,2,cn,cn));
			}
			
			if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("before")){
				cell = getCell(sheet, 2, cn);
				cell.setCellStyle(style);
				cell = getCell(sheet, 3, cn);
				setText(cell, "확정전");
				cell.setCellStyle(style);
				cn++;
			}
			if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("after")){
				cell = getCell(sheet, 2, cn);
				cell.setCellStyle(style);
				cell = getCell(sheet, 3, cn);
				setText(cell, "확정후");
				cell.setCellStyle(style);
				cn++;
			}
		}
		
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
				
				if(vo.getTur2() == null || vo.getTur2().equals("")){
					vo.setTur2("-");
				}else{
					if(vo.getTur2().equals("999,999.00") && vo.getTur_st() != null){
//						if(vo.getTur_st().equals("0")){vo.setTur2("장비정상");}
						if(vo.getTur_st().equals("0")){vo.setTur2("D");}
						if(vo.getTur_st().equals("1")){vo.setTur2("가동중지");}
						if(vo.getTur_st().equals("2")){vo.setTur2("유량없음");}
						if(vo.getTur_st().equals("3")){vo.setTur2("교정중");}
						if(vo.getTur_st().equals("4")){vo.setTur2("정검/보수중");}
						if(vo.getTur_st().equals("5")){vo.setTur2("통신불량");}
						if(vo.getTur_st().equals("6")){vo.setTur2("장비이상");}
						if(vo.getTur_st().equals("7")){vo.setTur2("전원이상");}
						if(vo.getTur_st().equals("8")){vo.setTur2("시운전");}
						if(vo.getTur_st().equals("9")){vo.setTur2("재전송");}
					}
				}
				if(vo.getTmp2() == null || vo.getTmp2().equals("")){
					vo.setTmp2("-");
				}else{
					if(vo.getTmp2().equals("999,999.00") && vo.getTmp_st() != null){
//						if(vo.getTmp_st().equals("0")){vo.setTmp2("장비정상");}
						if(vo.getTmp_st().equals("0")){vo.setTmp2("D");}
						if(vo.getTmp_st().equals("1")){vo.setTmp2("가동중지");}
						if(vo.getTmp_st().equals("2")){vo.setTmp2("유량없음");}
						if(vo.getTmp_st().equals("3")){vo.setTmp2("교정중");}
						if(vo.getTmp_st().equals("4")){vo.setTmp2("정검/보수중");}
						if(vo.getTmp_st().equals("5")){vo.setTmp2("통신불량");}
						if(vo.getTmp_st().equals("6")){vo.setTmp2("장비이상");}
						if(vo.getTmp_st().equals("7")){vo.setTmp2("전원이상");}
						if(vo.getTmp_st().equals("8")){vo.setTmp2("시운전");}
						if(vo.getTmp_st().equals("9")){vo.setTmp2("재전송");}
					}
				}
				if(vo.getPhy2() == null || vo.getPhy2().equals("")){
					vo.setPhy2("-");
				}else{
					if(vo.getPhy2().equals("999,999.00") && vo.getPhy_st() != null){
//						if(vo.getPhy_st().equals("0")){vo.setPhy2("장비정상");}
						if(vo.getPhy_st().equals("0")){vo.setPhy2("D");}
						if(vo.getPhy_st().equals("1")){vo.setPhy2("가동중지");}
						if(vo.getPhy_st().equals("2")){vo.setPhy2("유량없음");}
						if(vo.getPhy_st().equals("3")){vo.setPhy2("교정중");}
						if(vo.getPhy_st().equals("4")){vo.setPhy2("정검/보수중");}
						if(vo.getPhy_st().equals("5")){vo.setPhy2("통신불량");}
						if(vo.getPhy_st().equals("6")){vo.setPhy2("장비이상");}
						if(vo.getPhy_st().equals("7")){vo.setPhy2("전원이상");}
						if(vo.getPhy_st().equals("8")){vo.setPhy2("시운전");}
						if(vo.getPhy_st().equals("9")){vo.setPhy2("재전송");}
					}
				}
				if(vo.getDow2() == null || vo.getDow2().equals("")){
					vo.setDow2("-");
				}else{
					if(vo.getDow2().equals("999,999.00") && vo.getDow_st() != null){
//						if(vo.getDow_st().equals("0")){vo.setDow2("장비정상");}
						if(vo.getDow_st().equals("0")){vo.setDow2("D");}
						if(vo.getDow_st().equals("1")){vo.setDow2("가동중지");}
						if(vo.getDow_st().equals("2")){vo.setDow2("유량없음");}
						if(vo.getDow_st().equals("3")){vo.setDow2("교정중");}
						if(vo.getDow_st().equals("4")){vo.setDow2("정검/보수중");}
						if(vo.getDow_st().equals("5")){vo.setDow2("통신불량");}
						if(vo.getDow_st().equals("6")){vo.setDow2("장비이상");}
						if(vo.getDow_st().equals("7")){vo.setDow2("전원이상");}
						if(vo.getDow_st().equals("8")){vo.setDow2("시운전");}
						if(vo.getDow_st().equals("9")){vo.setDow2("재전송");}
					}
				}
				if(vo.getCon2() == null || vo.getCon2().equals("")){
					vo.setCon2("-");
				}else{
					if(vo.getCon2().equals("999,999.000") && vo.getCon_st() != null){
//						if(vo.getCon_st().equals("0")){vo.setCon2("장비정상");}
						if(vo.getCon_st().equals("0")){vo.setCon2("D");}
						if(vo.getCon_st().equals("1")){vo.setCon2("가동중지");}
						if(vo.getCon_st().equals("2")){vo.setCon2("유량없음");}
						if(vo.getCon_st().equals("3")){vo.setCon2("교정중");}
						if(vo.getCon_st().equals("4")){vo.setCon2("정검/보수중");}
						if(vo.getCon_st().equals("5")){vo.setCon2("통신불량");}
						if(vo.getCon_st().equals("6")){vo.setCon2("장비이상");}
						if(vo.getCon_st().equals("7")){vo.setCon2("전원이상");}
						if(vo.getCon_st().equals("8")){vo.setCon2("시운전");}
						if(vo.getCon_st().equals("9")){vo.setCon2("재전송");}
					}
				}
				if(vo.getTof2() == null || vo.getTof2().equals("")){
					vo.setTof2("-");
				}else{
					if(vo.getTof2().equals("999,999.00") && vo.getTof_st() != null){
//						if(vo.getTof_st().equals("0")){vo.setTof2("장비정상");}
						if(vo.getTof_st().equals("0")){vo.setTof2("D");}
						if(vo.getTof_st().equals("1")){vo.setTof2("가동중지");}
						if(vo.getTof_st().equals("2")){vo.setTof2("유량없음");}
						if(vo.getTof_st().equals("3")){vo.setTof2("교정중");}
						if(vo.getTof_st().equals("4")){vo.setTof2("정검/보수중");}
						if(vo.getTof_st().equals("5")){vo.setTof2("통신불량");}
						if(vo.getTof_st().equals("6")){vo.setTof2("장비이상");}
						if(vo.getTof_st().equals("7")){vo.setTof2("전원이상");}
						if(vo.getTof_st().equals("8")){vo.setTof2("시운전");}
						if(vo.getTof_st().equals("9")){vo.setTof2("재전송");}
					}
				}
				
				cn = 0;
				
				
				//번호
				cell = getCell(sheet, 4 + i, cn);
				cell.setCellValue(i+1);
				cell.setCellStyle(style);
				cn++;
				
				
				//수계
				cell = getCell(sheet, 4 + i, cn);
				cell.setCellValue(vo.getRiver_name());
				cell.setCellStyle(style);
				cn++;

				
				//측정소
				cell = getCell(sheet, 4+ i, cn);
				cell.setCellValue(vo.getBranch_name());
				cell.setCellStyle(style);
				cn++;
				
				
				//수신일자
				cell = getCell(sheet, 4+ i, cn);
				cell.setCellValue(vo.getStr_date());
				cell.setCellStyle(style);
				cn++;

				
				//수신시간
				cell = getCell(sheet, 4+ i, cn);
				cell.setCellValue(vo.getStr_time());
				cell.setCellStyle(style);
				cn++;
				

				//탁도(NTU)
				if(tur_chk.equals("Y")){
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
					if(vo.getTur_over() != null && Integer.parseInt(vo.getTur_over()) > 0){
						style_tur.setFillForegroundColor(HSSFColor.ROSE.index);
						style_tur.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
					}
					style_tur.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
					style_tur.setBorderBottom(HSSFCellStyle.BORDER_THIN);
					style_tur.setBorderLeft(HSSFCellStyle.BORDER_THIN);
					style_tur.setBorderRight(HSSFCellStyle.BORDER_THIN);
					style_tur.setBorderTop(HSSFCellStyle.BORDER_THIN);
					style_tur.setLocked(false);
					
					if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("before")){
						cell = getCell(sheet, 4+ i, cn);
						cell.setCellValue(vo.getTur());
						cell.setCellStyle(style_tur);
						cn++;
					}
					if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("after")){
						cell = getCell(sheet, 4+ i, cn);
						cell.setCellValue(vo.getTur2());
						cell.setCellStyle(style_tur);
						cn++;
					}
				}
				
				
				//수온(℃)
				if(tmp_chk.equals("Y")){
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
					if(vo.getTmp_over() != null && Integer.parseInt(vo.getTmp_over()) > 0){
						style_tmp.setFillForegroundColor(HSSFColor.ROSE.index);
						style_tmp.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
					}
					style_tmp.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
					style_tmp.setBorderBottom(HSSFCellStyle.BORDER_THIN);
					style_tmp.setBorderLeft(HSSFCellStyle.BORDER_THIN);
					style_tmp.setBorderRight(HSSFCellStyle.BORDER_THIN);
					style_tmp.setBorderTop(HSSFCellStyle.BORDER_THIN);
					style_tmp.setLocked(false);
					
					if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("before")){
						cell = getCell(sheet, 4+ i, cn);
						cell.setCellValue(vo.getTmp());
						cell.setCellStyle(style_tmp);
						cn++;
					}
					if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("after")){
						cell = getCell(sheet, 4+ i, cn);
						cell.setCellValue(vo.getTmp2());
						cell.setCellStyle(style_tmp);
						cn++;
					}
				}
				
				
				//ph
				if(phy_chk.equals("Y")){
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
					if(vo.getPhy_over() != null && Integer.parseInt(vo.getPhy_over()) > 0){
						style_phy.setFillForegroundColor(HSSFColor.ROSE.index);
						style_phy.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
					}
					style_phy.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
					style_phy.setBorderBottom(HSSFCellStyle.BORDER_THIN);
					style_phy.setBorderLeft(HSSFCellStyle.BORDER_THIN);
					style_phy.setBorderRight(HSSFCellStyle.BORDER_THIN);
					style_phy.setBorderTop(HSSFCellStyle.BORDER_THIN);
					style_phy.setLocked(false);
					
					if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("before")){
						cell = getCell(sheet, 4+ i, cn);
						cell.setCellValue(vo.getPhy());
						cell.setCellStyle(style_phy);
						cn++;
					}
					if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("after")){
						cell = getCell(sheet, 4+ i, cn);
						cell.setCellValue(vo.getPhy2());
						cell.setCellStyle(style_phy);
						cn++;
					}
				}
				
				
				//DO(mg/L)
				if(dow_chk.equals("Y")){
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
					if(vo.getDow_over() != null && Integer.parseInt(vo.getDow_over()) > 0){
						style_dow.setFillForegroundColor(HSSFColor.ROSE.index);
						style_dow.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
					}
					style_dow.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
					style_dow.setBorderBottom(HSSFCellStyle.BORDER_THIN);
					style_dow.setBorderLeft(HSSFCellStyle.BORDER_THIN);
					style_dow.setBorderRight(HSSFCellStyle.BORDER_THIN);
					style_dow.setBorderTop(HSSFCellStyle.BORDER_THIN);
					style_dow.setLocked(false);
					
					if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("before")){
						cell = getCell(sheet, 4+ i, cn);
						cell.setCellValue(vo.getDow());
						cell.setCellStyle(style_dow);
						cn++;
					}
					if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("after")){
						cell = getCell(sheet, 4+ i, cn);
						cell.setCellValue(vo.getDow2());
						cell.setCellStyle(style_dow);
						cn++;
					}
				}
				
				
				//EC(mS/cm)
				if(con_chk.equals("Y")){
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
					if(vo.getCon_over() != null && Integer.parseInt(vo.getCon_over()) > 0){
						style_con.setFillForegroundColor(HSSFColor.ROSE.index);
						style_con.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
					}
					style_con.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
					style_con.setBorderBottom(HSSFCellStyle.BORDER_THIN);
					style_con.setBorderLeft(HSSFCellStyle.BORDER_THIN);
					style_con.setBorderRight(HSSFCellStyle.BORDER_THIN);
					style_con.setBorderTop(HSSFCellStyle.BORDER_THIN);
					style_con.setLocked(false);
					
					if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("before")){
						cell = getCell(sheet, 4+ i, cn);
						cell.setCellValue(vo.getCon());
						cell.setCellStyle(style_con);
						cn++;
					}
					if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("after")){
						cell = getCell(sheet, 4+ i, cn);
						cell.setCellValue(vo.getCon2());
						cell.setCellStyle(style_con);
						cn++;
					}
				}
				
				
				//Chl-a(μg/L)
				if(tof_chk.equals("Y")){
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
					if(vo.getTof_over() != null && Integer.parseInt(vo.getTof_over()) > 0){
						style_tof.setFillForegroundColor(HSSFColor.ROSE.index);
						style_tof.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
					}
					style_tof.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
					style_tof.setBorderBottom(HSSFCellStyle.BORDER_THIN);
					style_tof.setBorderLeft(HSSFCellStyle.BORDER_THIN);
					style_tof.setBorderRight(HSSFCellStyle.BORDER_THIN);
					style_tof.setBorderTop(HSSFCellStyle.BORDER_THIN);
					style_tof.setLocked(false);
					
					if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("before")){
						cell = getCell(sheet, 4+ i, cn);
						cell.setCellValue(vo.getTof());
						cell.setCellStyle(style_tof);
						cn++;
					}
					if(selectDataVO.getDefinite_type().equals("all") || selectDataVO.getDefinite_type().equals("after")){
						cell = getCell(sheet, 4+ i, cn);
						cell.setCellValue(vo.getTof2());
						cell.setCellStyle(style_tof);
						cn++;
					}
				}
				
			} else {	// Map
 
				Map<String, String> category = (Map<String, String>) map.get(i);
 
				cell = getCell(sheet, 4 + i, 0);
				setText(cell, category.get("id"));
 
				cell = getCell(sheet, 4 + i, 1);
				setText(cell, category.get("name"));
 
				cell = getCell(sheet, 4 + i, 2);
				setText(cell, category.get("description"));
 
				cell = getCell(sheet, 4 + i, 3);
				setText(cell, category.get("useyn"));
 
				cell = getCell(sheet, 4 + i, 4);
				setText(cell, category.get("reguser"));
 
			}
		}
	}
}
