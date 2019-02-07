package daewooInfo.stats.view;

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

import daewooInfo.stats.bean.StatsVO;
import daewooInfo.weather.bean.WeatherInfoVO;

public class ExcelStatsBasinView extends AbstractExcelView{
	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook wb,
		HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HSSFCell cell = null;
		HSSFCellStyle style = null;
		HSSFDataFormat format = wb.createDataFormat();
		HSSFFont font = wb.createFont();

		Map<String, Object> map= (Map<String, Object>) model.get("map");
		List<Object> data = (List<Object>) map.get("data");
		StatsVO vo = (StatsVO)map.get("statsVO");
 
		
		String title = "유역별 통계";
		String eTitle = "stats_basin";
		if(!"BASIN1".equals(vo.getStatKind()))
		{
			if("T".equals(vo.getSystem()))
			{
				title = "탁수모니터링통계";
				eTitle = "stats_tur";
			}
			else if("U".equals(vo.getSystem()))
			{
				title = "이동형측정기기 통계";
				eTitle = "stats_ipusn";
			}
			else if("A".equals(vo.getSystem()))
			{
				title = "수질측정망통계";
				eTitle = "stats_tms";
			}
		}
		
			
		HSSFSheet sheet = wb.createSheet(title);
		sheet.setDefaultColumnWidth((short)15);

		//파일이름 설정
		String filename = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String ctime = sdf.format(new Date(System.currentTimeMillis()));
		filename = eTitle + "-"+ctime+".xls";
	    filename = new String(filename.getBytes("euc-kr"), "8859_1"); 
	    resp.setHeader("Content-Disposition", "attachment;filename="+filename+";"); 
	    
	    
	    
	   		
	    
		int maxCell = 4;
		int baseCell = 4;
		
		if("T".equals(vo.getSystem()))
		{
			maxCell = maxCell + (3*2) -1;
		}
		else if("U".equals(vo.getSystem()))
		{
			baseCell += 1; //IP-USN은 수신율이추가됨
			maxCell = maxCell + (3*6) -1 + 1; 
			if(map.get("etc_excel").equals("Y")){
				baseCell-=1;
			}
		}
		else if("A".equals(vo.getSystem()))
		{
			maxCell = maxCell + (3 * 45) -1;
		}
		
		
		String gubun = vo.getGubun();
		
		String statsTitle = "";
		
		if("1".equals(gubun)) {
			statsTitle = "[ "+vo.getSearchYear()+"년 년간 통계 ]";
		} else if("2".equals(gubun) && !"all".equals(vo.getSearchQuarter())) {
			statsTitle = "[ "+vo.getSearchYear()+"년 "+vo.getSearchQuarter()+"분기 통계 ]";
		} else if("2".equals(gubun) && "all".equals(vo.getSearchQuarter())) {			
			statsTitle = "[ "+vo.getSearchYear()+"년 분기별 통계 ]";
		} else if("3".equals(gubun) && !"all".equals(vo.getSearchMonth())) {
			statsTitle = "[ "+vo.getSearchYear()+"년 "+vo.getSearchMonth()+"월 월별 통계 ]";
		} else if("3".equals(gubun) && "all".equals(vo.getSearchMonth())) {
			statsTitle = "[ "+vo.getSearchYear()+"년 월간 통계 ]";	
		} else if("4".equals(gubun) && !"all".equals(vo.getSearchDay())) {
			statsTitle = "[ "+vo.getSearchYear()+"년 "+vo.getSearchMonth()+"월 "+vo.getSearchDay()+"일 일간 통계 ]";
		} else if("4".equals(gubun) && "all".equals(vo.getSearchDay())) {
			statsTitle = "[ "+vo.getSearchYear()+"년 "+vo.getSearchMonth()+"월 일별 통계 ]";		
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
		setText(cell, title);	
		
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
		setText(cell,"");
		
		// 기간		
		cell = getCell(sheet, 2, 0);
		sheet.addMergedRegion(new CellRangeAddress(2,2,0,maxCell));		
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)11);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();		
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_LEFT);		
				
		cell.setCellStyle(style);	
		setText(cell, statsTitle);			
		
		
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
		
		
		if(!"BASIN1".equals(vo.getStatKind()))
		{
			cell = getCell(sheet, addIdx, cellIdx);
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+1,cellIdx,cellIdx));
			setText(cell, "수계");
			cell = getCell(sheet, addIdx, cellIdx);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx+1, cellIdx);
			cell.setCellStyle(style);
			
			cellIdx++;
		}
		
		if(!map.get("etc_excel").equals("Y")){
			cell = getCell(sheet, addIdx, cellIdx);
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+1,cellIdx,cellIdx));
			setText(cell, "지역");
			cell = getCell(sheet, addIdx, cellIdx);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx+1, cellIdx);
			cell.setCellStyle(style);
			cellIdx++;
		}
		
		
		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+1,cellIdx,cellIdx));
		setText(cell, "기간");
		cell = getCell(sheet, addIdx, cellIdx);
		cell.setCellStyle(style);
		cell = getCell(sheet, addIdx+1, cellIdx);
		cell.setCellStyle(style);
		
		cellIdx++;

		if("BASIN1".equals(vo.getStatKind()))
		{
			cell = getCell(sheet, addIdx, cellIdx);
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+1,cellIdx,cellIdx));
			setText(cell, "시스템");
			cell = getCell(sheet, addIdx, cellIdx);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx+1, cellIdx);
			cell.setCellStyle(style);
			
			cellIdx++;
		}
		
		
		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+1,cellIdx,cellIdx));
		setText(cell, "측정소");
		cell = getCell(sheet, addIdx, cellIdx);
		cell.setCellStyle(style);
		cell = getCell(sheet, addIdx+1, cellIdx);
		cell.setCellStyle(style);
		
		cellIdx++;
		
		
		if("U".equals(vo.getSystem()))
		{
			cell = getCell(sheet, addIdx, cellIdx);
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+1,cellIdx,cellIdx));
			setText(cell, "수신율");
			cell = getCell(sheet, addIdx, cellIdx);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx+1, cellIdx);
			cell.setCellStyle(style);
			
			cellIdx++;
		}
		
		String[] items = null;
		
		//헤더생성
		if("T".equals(vo.getSystem()))
		{			
			items = new String[]{"탁도", "전기전도도"};
		}
		else if("U".equals(vo.getSystem()))
		{
			items = new String[]{"탁도", "수온", "pH", "용존산소", "전기전도도", "Chl-a"};
		}
		else if("A".equals(vo.getSystem()))
		{
			items = new String[]{"탁도", "수온", "pH", "용존산소", "전기전도도"};			
		}
		
		//헤더생성
		for(int idx = 0 ; idx < items.length ; idx++)
		{	
			cellIdx = baseCell + (idx * 3);
				
			
			cell = getCell(sheet, addIdx, cellIdx);
			setText(cell, items[idx]);
			sheet.addMergedRegion(new CellRangeAddress(addIdx, addIdx,cellIdx,cellIdx+2));
			cell = getCell(sheet, addIdx, cellIdx);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx, cellIdx+1);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx, cellIdx+2);
			cell.setCellStyle(style);
			

			
			cell = getCell(sheet, addIdx+1, cellIdx);
			setText(cell, "최대");
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx+1, cellIdx+1);
			setText(cell, "평균");
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx+1, cellIdx+2);
			setText(cell, "최소");
			cell.setCellStyle(style);
		}
		
		addIdx+=2;
		
		
		
		boolean isVO = false;
 
		if (data.size() > 0) {
			Object obj = data.get(0);
			isVO = obj instanceof StatsVO;
		}
		
		
 
		for (int i = 0; i < data.size(); i++) {
 
			if (isVO) {	// VO
 
				StatsVO vo2 = (StatsVO) data.get(i);
				
				style = wb.createCellStyle();
				
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);				
				style.setLocked(false);
				
			
			    cellIdx = 0;
                
			   
			    //수계
			    if(!"BASIN1".equals(vo.getStatKind()))
			    {
			    	cell = getCell(sheet, addIdx + i, cellIdx++);
			    	cell.setCellValue(vo2.getRiverName());
			    	cell.setCellStyle(style);			
			    }
			    
			    if(!map.get("etc_excel").equals("Y")){
				    //지역
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getRegName());
					cell.setCellStyle(style);			
			    }

				
				String date = "";
				
				if("1".equals(gubun))
   			     	date = vo.getSearchYear() + "년";
   			 	else if("2".equals(gubun))
				 	 date = vo.getSearchYear() + "년 " + vo2.getQuarter();
				 else if("3".equals(gubun))
					 date = vo.getSearchYear() + "년 " + vo2.getStartMonth()+ "월";
				 else
					 date = vo2.getDay();
				 
				//기간
				cell = getCell(sheet, addIdx+ i, cellIdx++);
				cell.setCellValue(date);
				cell.setCellStyle(style);					
					
			    
				if("BASIN1".equals(vo.getStatKind()))
			    {
					//시스템
					cell = getCell(sheet, addIdx+ i, cellIdx++);
					cell.setCellValue(vo2.getSysName());
					cell.setCellStyle(style);				
			    }
				
				//측정소
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getBranchName());
				cell.setCellStyle(style);				
					
				
				if("U".equals(vo.getSystem()))
				{
					//수신율
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getRecvRt());
					cell.setCellStyle(style);			
				}
				
				
				style = wb.createCellStyle();
				style.setDataFormat(format.getFormat("0.00"));
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);	
				style.setLocked(false);

				
				//탁도 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTurMax());
				cell.setCellStyle(style);
				//탁도 Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTurAvg());
				cell.setCellStyle(style);
				//탁도 Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTurMin());
				cell.setCellStyle(style);
				
				
				if(!"T".equals(vo.getSystem()))
				{
					//수온 Max
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getTmpMax());
					cell.setCellStyle(style);
					//수온 Avg
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getTmpAvg());
					cell.setCellStyle(style);
					//수온 Min
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getTmpMin());
					cell.setCellStyle(style);
					
					//pH Max
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getPhyMax());
					cell.setCellStyle(style);
					//pH Avg
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getPhyAvg());
					cell.setCellStyle(style);
					//pH Min
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getPhyMin());
					cell.setCellStyle(style);
					
					//DO Max
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getDowMax());
					cell.setCellStyle(style);
					//DO Avg
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getDowAvg());
					cell.setCellStyle(style);
					//DO Min
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getDowMin());
					cell.setCellStyle(style);
				}
				
				//전기전도도 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getConMax());
				cell.setCellStyle(style);
				//전기전도도 Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getConAvg());
				cell.setCellStyle(style);
				//전기전도도 Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getConMin());
				cell.setCellStyle(style);
				
				if("U".equals(vo.getSystem()))
				{
					//chla Max
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getTofMax());
					cell.setCellStyle(style);
					//chla Avg
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getTofAvg());
					cell.setCellStyle(style);
					//chla Min
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getTofMin());
					cell.setCellStyle(style);
				}
			
				
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
