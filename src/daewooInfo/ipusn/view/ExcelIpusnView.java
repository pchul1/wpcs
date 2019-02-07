package daewooInfo.ipusn.view;

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

import daewooInfo.ipusn.bean.IpUsnVO;
import daewooInfo.mobile.com.utl.ProjectJstlUtil;
import daewooInfo.mobile.com.utl.ObjectUtil;

/**
 * 상황관리 통계 엑셀을 저장하는 View Class
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------     --------    ---------------------------
 *   2010.6.28  김태훈          최초 생성
 *
 */
public class ExcelIpusnView extends AbstractExcelView{
    /**
     * 상환관리 통계 엑셀을 생성하여 저장한다.
     * 
     */		
	@Override
	protected void buildExcelDocument(Map map, HSSFWorkbook wb, HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HSSFCell cell = null;
		HSSFCellStyle style = null;
		HSSFDataFormat format = wb.createDataFormat();
		HSSFFont font = wb.createFont();
				 
		String[] menu = (String[]) map.get("menu");
		List<Object> List = (List<Object>) map.get("List");
		String searchDate = ObjectUtil.getTimeString("yyyy/MM/dd HH:mm");
		String title = (String)map.get("title");
		
		//엑셀의 캐릭터셋을 설정한다.(UTF-8)
		resp.setContentType("application/vnd.ms-excel; charset=UTF-8");
		
		//엑셀파일명을 설정한다.
		resp.setHeader("Content-Disposition", "attachment; filename=\"stats_"+searchDate+".xls\"");				
 
		HSSFSheet sheet = wb.createSheet(title);
		sheet.setDefaultColumnWidth((short) 12);
 
		// 제목
		cell = getCell(sheet, 0, 0);
		sheet.addMergedRegion(new CellRangeAddress(0,0,0,8));
		
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
		
		// 측정일		
		cell = getCell(sheet, 1, 0);
		sheet.addMergedRegion(new CellRangeAddress(1,1,0,8));		
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)11);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();		
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_RIGHT);		
				
		cell.setCellStyle(style);		
		setText(cell, "조회날짜 : "+searchDate);			
		
		
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
 
		for(int i=0;i<menu.length;i++){
			cell = getCell(sheet, 2, i);
			setText(cell, menu[i]);
			cell.setCellStyle(style);
		}
 
		for (int i = 0; i < List.size(); i++) {
			IpUsnVO vo = (IpUsnVO) List.get(i);
			
			style = wb.createCellStyle();

			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			style.setBorderRight(HSSFCellStyle.BORDER_THIN);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);				

			cell = getCell(sheet, 4 + i, 0);
			cell.setCellValue(vo.getRn());
			cell.setCellStyle(style);				

			cell = getCell(sheet, 4 + i, 1);
			cell.setCellValue(vo.getRiver_div_name());
			cell.setCellStyle(style);				

			cell = getCell(sheet, 4 + i, 2);
			cell.setCellValue(vo.getBranch_name());
			cell.setCellStyle(style);				

			cell = getCell(sheet, 4 + i, 3);
			cell.setCellValue(vo.getTemperature());
			cell.setCellStyle(style);				

			cell = getCell(sheet, 4 + i, 4);
			cell.setCellValue(vo.getHumidity());
			cell.setCellStyle(style);				

			cell = getCell(sheet, 4 + i, 5);
			cell.setCellValue(vo.getBattery());
			cell.setCellStyle(style);				

			cell = getCell(sheet, 4 + i, 6);
			cell.setCellValue(vo.getInput_time());
			cell.setCellStyle(style);				
			
			cell = getCell(sheet, 4 + i, 8);
			cell.setCellValue(ProjectJstlUtil.SelectIpUsnstr(vo.getDevice_st()));
			cell.setCellStyle(style);

			String nowlocation = ProjectJstlUtil.SelectIpUsnDistance(vo.getLatitude1(), vo.getLongitude1(), vo.getLatitude2(), vo.getLongitude2(), "M", vo.getGps_dist(), "N");
			cell = getCell(sheet, 4 + i, 7);
			cell.setCellValue(nowlocation);
			if("위치이탈".equals(nowlocation)){
				style = wb.createCellStyle();
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);		
				style.setFillForegroundColor(HSSFColor.RED.index);
				style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);		

				cell.setCellStyle(style);
			}else if("위치정상".equals(nowlocation)){
				style = wb.createCellStyle();
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);		
				style.setFillForegroundColor(HSSFColor.BRIGHT_GREEN.index);
				style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);		
				cell.setCellStyle(style);
			}else{
				cell.setCellStyle(style);
			}
		}
	}
}
