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
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import daewooInfo.waterpolmnt.waterinfo.bean.RiverWater3HourWarningSearchVO;
import daewooInfo.waterpolmnt.waterinfo.bean.RiverWater3HourWarningVO;
import daewooInfo.waterpolmnt.waterinfo.bean.SearchTaksuVO;
import daewooInfo.waterpolmnt.waterinfo.bean.TaksuVO;

public class ExcelDetailViewWARNING extends AbstractExcelView{
	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook wb,
			HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HSSFCell cell = null;
		HSSFCellStyle style = null;
		HSSFDataFormat format = wb.createDataFormat();
		HSSFFont font = wb.createFont();
				 
		Map<String, Object> map= (Map<String, Object>) model.get("chartMap");
		List<Object> chart = (List<Object>) map.get("chart");
		RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO = (RiverWater3HourWarningSearchVO)map.get("riverWater3HourWarningSearchVO");
		
		HSSFSheet sheet = wb.createSheet("경보지속지점 조회 결과");
		//sheet.setDefaultColumnWidth((short) 12);
		
		sheet.setDefaultColumnWidth((short)15);
		
		boolean isOneBranch = false;	//단일 측정소에 대한 결과
		int maxCell = 6;
			if(!"all".equals(riverWater3HourWarningSearchVO.getBranch_no().toLowerCase()))
			{
				maxCell = 4;
				isOneBranch = true;
			}
		
		
		//파일이름 설정
		String filename = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String ctime = sdf.format(new Date(System.currentTimeMillis()));
		filename = "Warning-"+ctime+".xls";
		filename = new String(filename.getBytes("euc-kr"), "8859_1"); 
		resp.setHeader("Content-Disposition", "attachment;filename="+filename+";"); 
		
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
		setText(cell, "경보지속지점 조회 결과");
		
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
		setText(cell,"(검증되지 않은 데이터 입니다)");
		
		
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
		String sdt = riverWater3HourWarningSearchVO.getFrDate();
		String edt = riverWater3HourWarningSearchVO.getToDate();
		setText(cell, "기간 : "+sdt.substring(0,4)+"년"+sdt.substring(4,6)+"월"+sdt.substring(6,8)+"일 "
				+riverWater3HourWarningSearchVO.getFrTime()+"시" +" ~ "
				+edt.substring(0,4)+"년"+edt.substring(4,6)+"월"+edt.substring(6,8)+"일 "
				+riverWater3HourWarningSearchVO.getToTime()+"시");
		
		
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
			sheet.addMergedRegion(new CellRangeAddress(3,3,0,0));
			cell.setCellStyle(style);
			
			cell = getCell(sheet, 3, 1);
			setText(cell, "측정소명");
			sheet.addMergedRegion(new CellRangeAddress(3,3,1,1));
			cell.setCellStyle(style);
			
			cellIdx = 2;
		}
		else
			addIdx = 4;
		
		
		cell = getCell(sheet, addIdx, cellIdx);
		setText(cell, "경보발생시간");
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx));
		cell.setCellStyle(style);
		
		cellIdx++;
		
		cell = getCell(sheet, addIdx, cellIdx);
		setText(cell, "경보단계");
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx));
		cell.setCellStyle(style);
		
		cellIdx++;
		
		cell = getCell(sheet, addIdx, cellIdx);
		setText(cell, "경보내용");
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx));
		cell.setCellStyle(style);
		
		cellIdx++;
//		
//		cell = getCell(sheet, addIdx, cellIdx);
//		setText(cell, "종료시간");
//		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx));
//		cell.setCellStyle(style);
//
//		cellIdx++;
//		
//		cell = getCell(sheet, addIdx, cellIdx);
//		setText(cell, "시스템");
//		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx));
//		cell.setCellStyle(style);
		
		boolean isVO = false;
		
		if (chart.size() > 0) {
			Object obj = chart.get(0);
			isVO = obj instanceof RiverWater3HourWarningVO;
		}
		
		for (int i = 0; i < chart.size(); i++) {
			
			if (isVO) {	// VO
				
				RiverWater3HourWarningVO vo = (RiverWater3HourWarningVO) chart.get(i);
				
				style = wb.createCellStyle();
				
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);
				
				style.setLocked(false);
				
				
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
					setText(cell, " 측정소 : " + vo.getRiver_name() + "["  + vo.getBranch_name() + "]");
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
					cell.setCellValue(vo.getRiver_name());
					cell.setCellStyle(style);
					
					//측정소
					cell = getCell(sheet, 4 + i, 1);
					cell.setCellValue(vo.getBranch_name());
					cell.setCellStyle(style);
				
					cellIdx = 2;
				}
				
				
				//항목
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo.getAlert_time());
				cell.setCellStyle(style);
				
				style = wb.createCellStyle();
				style.setDataFormat(format.getFormat("0.00"));
				
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);
				
				style.setLocked(false);
				
				//측정값
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo.getAlert_level());
				cell.setCellStyle(style);
				
				//시간
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo.getAlert_msg());
				cell.setCellStyle(style);
				
//				//시간
//				cell = getCell(sheet, addIdx + i, cellIdx++);
//				cell.setCellValue(vo.getLast_time());
//				cell.setCellStyle(style);
//
//				//시스템
//				cell = getCell(sheet, addIdx + i, cellIdx++);
//				cell.setCellValue(vo.getSys_kind_name());
//				cell.setCellStyle(style);
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
