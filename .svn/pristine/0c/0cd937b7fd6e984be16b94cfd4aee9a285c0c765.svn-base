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

import daewooInfo.waterpolmnt.waterinfo.bean.DamDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.FlowDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.SearchTaksuVO;

public class ExcelDetailViewDam extends AbstractExcelView{
	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook wb,
			HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HSSFCell cell = null;
		HSSFCellStyle style = null;
		HSSFDataFormat format = wb.createDataFormat();
		HSSFFont font = wb.createFont();
				 
		Map<String, Object> map= (Map<String, Object>) model.get("chartMap");
		List<Object> chart = (List<Object>) map.get("chart");
		String item = (String)map.get("item");
		SearchTaksuVO searchTaksuVO = (SearchTaksuVO)map.get("searchTaksuVO");
 
		HSSFSheet sheet = wb.createSheet("댐 수위,방류량 조회 상세조회 결과");
		sheet.setDefaultColumnWidth((short) 14);
		
		//파일이름 설정
		String filename = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String ctime = sdf.format(new Date(System.currentTimeMillis()));
		filename = "dam_wlv_discharge-"+ctime+".xls";
	    filename = new String(filename.getBytes("euc-kr"), "8859_1"); 
	    resp.setHeader("Content-Disposition", "attachment;filename="+filename+";"); 
	    
	    
		boolean isOneBranch = false;	//단일 측정소에 대한 결과
		int maxCell = 3;
		 if(!"all".equals(searchTaksuVO.getGongku().toLowerCase()))
         {
         	maxCell = 2;
         	isOneBranch = true;
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
		setText(cell, "댐 수위,방류량 조회 상세조회 결과");
		
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
		String sdt = searchTaksuVO.getFrDate();
		String edt = searchTaksuVO.getToDate();
		setText(cell, "기간 : "+sdt.substring(0,4)+"년"+sdt.substring(4,6)+"월"+sdt.substring(6,8)+"일 "
				+searchTaksuVO.getFrTime()+"시" +" ~ "
				+edt.substring(0,4)+"년"+edt.substring(4,6)+"월"+edt.substring(6,8)+"일 "
				+searchTaksuVO.getToTime()+"시");			
		
		
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
		//cell = getCell(sheet, 2, 0);
		//setText(cell, "수계");
		//sheet.addMergedRegion(new CellRangeAddress(2,3,0,0));
		//cell.setCellStyle(style);
		
		if(!isOneBranch)
		{
			cell = getCell(sheet, 3, cellIdx);
			setText(cell, "측정소");
			cell.setCellStyle(style);
			
			cellIdx++;
		}
		else
		{
			addIdx = 4;
		}
		
		cell = getCell(sheet, addIdx, cellIdx);
		setText(cell, "일자");
		cell.setCellStyle(style);

		cellIdx++;
		
		cell = getCell(sheet, addIdx, cellIdx);
		setText(cell,  "수위");
		cell.setCellStyle(style);
		
		cellIdx++;
		
		cell = getCell(sheet, addIdx, cellIdx);
		setText(cell,  "방류량"); 
		cell.setCellStyle(style);

		cellIdx++;
 
		boolean isVO = false;
 
		if (chart.size() > 0) {
			Object obj = chart.get(0);
			isVO = obj instanceof DamDataVO;
		}
		
 
		addIdx = 0;
		
		for (int i = 0; i < chart.size(); i++) {
 
			if (isVO) {	// VO
 
				DamDataVO vo = (DamDataVO) chart.get(i);
				
				style = wb.createCellStyle();
				
				
				
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
					setText(cell, " 측정소 : " + vo.getFact_name());	
				}
				else if(i==0)
				{
					addIdx = 4;
				}
				
				
				
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);				
				style.setLocked(false);	
				
				
				cellIdx = 0;
				
				//수계
				//cell = getCell(sheet, 4 + i, 0);
				//cell.setCellValue(vo.getRiver_name());
				//cell.setCellStyle(style);				

				if(!isOneBranch)
				{
					//측정소
					cell = getCell(sheet, addIdx + i, cellIdx);
					cell.setCellValue(vo.getFact_name());
					cell.setCellStyle(style);				
					
					cellIdx++;
				}
				
				//일자
				cell = getCell(sheet, addIdx + i, cellIdx);
				cell.setCellValue(vo.getRcv_date());
				cell.setCellStyle(style);				
				
				cellIdx++;
				
				style = wb.createCellStyle();
				style.setDataFormat(format.getFormat("0.00"));
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);						
				style.setLocked(false);
				
				//수위
				cell = getCell(sheet, addIdx + i, cellIdx);
				cell.setCellValue(vo.getSWL());
				cell.setCellStyle(style);
				
				cellIdx++;
				
				//방류량
				cell = getCell(sheet, addIdx + i, cellIdx);
				cell.setCellValue(vo.getSFW());
				cell.setCellStyle(style);
				
				cellIdx++;

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
