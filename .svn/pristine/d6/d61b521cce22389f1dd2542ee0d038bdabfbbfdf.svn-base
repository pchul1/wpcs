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

public class ExcelStatsBasinAView extends AbstractExcelView{
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
		
			

		if(!"BASIN1".equals(vo.getStatKind()))
		{
			title = "수질측정망통계";
		}
		
		
		HSSFSheet sheet = wb.createSheet(title);
		sheet.setDefaultColumnWidth((short)15);

		//파일이름 설정
		String filename = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String ctime = sdf.format(new Date(System.currentTimeMillis()));
		filename = "stats_basin-"+ctime+".xls";
	    filename = new String(filename.getBytes("euc-kr"), "8859_1"); 
	    resp.setHeader("Content-Disposition", "attachment;filename="+filename+";"); 
	    
	    
	    

		
		int maxCell = 4;
	
		maxCell = maxCell + (3 * 45) -1;
		
		
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
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+2,cellIdx,cellIdx));
			setText(cell, "수계");
			cell = getCell(sheet, addIdx, cellIdx);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx+1, cellIdx);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx+2, cellIdx);
			cell.setCellStyle(style);
			
			cellIdx++;
		}
		
		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+2,cellIdx,cellIdx));
		setText(cell, "지역");
		cell = getCell(sheet, addIdx, cellIdx);
		cell.setCellStyle(style);
		cell = getCell(sheet, addIdx+1, cellIdx);
		cell.setCellStyle(style);
		cell = getCell(sheet, addIdx+2, cellIdx);
		cell.setCellStyle(style);
		
		cellIdx++;

		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+2,cellIdx,cellIdx));
		setText(cell, "기간");
		cell = getCell(sheet, addIdx, cellIdx);
		cell.setCellStyle(style);
		cell = getCell(sheet, addIdx+1, cellIdx);
		cell.setCellStyle(style);
		cell = getCell(sheet, addIdx+2, cellIdx);
		cell.setCellStyle(style);
		
		cellIdx++;

		if("BASIN1".equals(vo.getStatKind()))
		{
			cell = getCell(sheet, addIdx, cellIdx);
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+2,cellIdx,cellIdx));
			setText(cell, "시스템");
			cell = getCell(sheet, addIdx, cellIdx);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx+1, cellIdx);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx+2, cellIdx);
			cell.setCellStyle(style);
			
			cellIdx++;
		}
		
			
		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+2,cellIdx,cellIdx));
		setText(cell, "측정소");
		cell = getCell(sheet, addIdx, cellIdx);
		cell.setCellStyle(style);
		cell = getCell(sheet, addIdx+1, cellIdx);
		cell.setCellStyle(style);
		cell = getCell(sheet, addIdx+2, cellIdx);
		cell.setCellStyle(style);
		
		cellIdx++;
		
		
		
		String[] items = new String[]{ "pH1", "DO1(mg/L)", "EC1(mS/cm)", "수온1(℃)", "pH2" ,"DO2(mg/L)","EC2(mS/cm)","수온2(℃)","탁도(NTU)","임펄스"
												,"임펄스(좌)" ,"임펼스(우)","독성지수(좌)","독성지수(우)","미생물 독성지수(%)","조류독성지수","클로로필-a","염화메틸렌","1.1.1-트리클로로에틸렌", "벤젠", "사염화탄소"
												,"트리클로로에틸렌","톨루엔" ,"테트라클로로에티렌","에틸벤젠","m,p-자일렌","o-자일렌","[ECD]염화메틸렌"	,"[ECD]1.1.1-트리클로로에테인","[ECD]사염화탄소"
												,"[ECD]트리클로로에틸렌","[ECD]테트라클로로에티렌","카드뮴" ,"납","구리","아연","페놀1","페놀2","총유기탄소","총질소"
												,"총인","암모니아성질소","질산성질소","인산염인","강수량"};			
		
		
		
		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx+((4*3)-1)));
		setText(cell, "일반항목(내부)");
		
		for(int idx = 0 ; idx < (4*3) ; idx++)
		{
			cell = getCell(sheet, addIdx, cellIdx++);
			cell.setCellStyle(style);
		}
		
		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx+((5*3)-1)));
		setText(cell, "일반항목(외부)");
		
		for(int idx = 0 ; idx < (5*3) ; idx++)
		{
			cell = getCell(sheet, addIdx, cellIdx++);
			cell.setCellStyle(style);
		}
		

		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx + ((1*3)-1)));
		setText(cell, "물고기");
		
		for(int idx = 0 ; idx < (1*3) ; idx++)
		{
			cell = getCell(sheet, addIdx, cellIdx++);
			cell.setCellStyle(style);
		}

		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx+((2*3)-1)));
		setText(cell, "생물독성(물벼룩1)");
		for(int idx = 0 ; idx < (2*3) ; idx++)
		{
			cell = getCell(sheet, addIdx, cellIdx++);
			cell.setCellStyle(style);
		}

		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx+(2*3)-1));
		setText(cell, "생물독성(물벼룩2)");
		for(int idx = 0 ; idx < (2*3) ; idx++)
		{
			cell = getCell(sheet, addIdx, cellIdx++);
			cell.setCellStyle(style);
		}

		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx+(1*3)-1));
		setText(cell, "생물독성(미생물)");
		for(int idx = 0 ; idx < (1*3) ; idx++)
		{
			cell = getCell(sheet, addIdx, cellIdx++);
			cell.setCellStyle(style);
		}
		
		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx+(1*3)-1));
		setText(cell, "생물독성(조류)");
		for(int idx = 0 ; idx < (1*3) ; idx++)
		{
			cell = getCell(sheet, addIdx, cellIdx++);
			cell.setCellStyle(style);
		}
		
		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx+(1*3)-1));
		setText(cell, "클로로필-a");
		for(int idx = 0 ; idx < (1*3) ; idx++)
		{
			cell = getCell(sheet, addIdx, cellIdx++);
			cell.setCellStyle(style);
		}
		
		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx+(15*3)-1));
		setText(cell, "휘발성 유기화합물");
		for(int idx = 0 ; idx < (15*3) ; idx++)
		{
			cell = getCell(sheet, addIdx, cellIdx++);
			cell.setCellStyle(style);
		}
		
		
		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx+(4*3)-1));
		setText(cell, "중금속");
		for(int idx = 0 ; idx < (4*3) ; idx++)
		{
			cell = getCell(sheet, addIdx, cellIdx++);
			cell.setCellStyle(style);
		}
		
		
		
		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx+(2*3)-1));
		setText(cell, "페놀");
		for(int idx = 0 ; idx < (2*3) ; idx++)
		{
			cell = getCell(sheet, addIdx, cellIdx++);
			cell.setCellStyle(style);
		}
		
		
		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx+(1*3)-1));
		setText(cell, "유기물질");
		for(int idx = 0 ; idx < (1*3) ; idx++)
		{
			cell = getCell(sheet, addIdx, cellIdx++);
			cell.setCellStyle(style);
		}

		
		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx+(5*3)-1));
		setText(cell, "영양염류");
		for(int idx = 0 ; idx < (5*3) ; idx++)
		{
			cell = getCell(sheet, addIdx, cellIdx++);
			cell.setCellStyle(style);
		}
		
		
		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx+(1*3)-1));
		setText(cell, "강수량계");
		for(int idx = 0 ; idx < (1*3) ; idx++)
		{
			cell = getCell(sheet, addIdx, cellIdx++);
			cell.setCellStyle(style);
		}
		
		addIdx++;
		
		for(int idx = 0 ; idx < items.length ; idx++)
		{	
			cellIdx = 4 + (idx * 3);
				
			
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
			    
			    //지역
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getRegName());
				cell.setCellStyle(style);			

				
			
				String date = "";
				
				if("1".equals(gubun))
   			     	date = vo2.getStatsDate() + "년";
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
					
				style = wb.createCellStyle();
				style.setDataFormat(format.getFormat("0.00"));
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);	
				style.setLocked(false);

				
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
				
				
				//pH2Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getPhy1Max());
				cell.setCellStyle(style);
				//pH2Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getPhy1Avg());
				cell.setCellStyle(style);
				//pH2Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getPhy1Min());
				cell.setCellStyle(style);
				
				//DO2 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getDow1Max());
				cell.setCellStyle(style);
				//DO2 Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getDow1Avg());
				cell.setCellStyle(style);
				//DO2 Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getDow1Min());
				cell.setCellStyle(style);
				
				//전기전도도2 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getCon1Max());
				cell.setCellStyle(style);
				//전기전도도2 Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getCon1Avg());
				cell.setCellStyle(style);
				//전기전도도2 Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getCon1Min());
				cell.setCellStyle(style);
				
				//수온2 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTmp1Max());
				cell.setCellStyle(style);
				//수온2 Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTmp1Avg());
				cell.setCellStyle(style);
				//수온2 Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTmp1Min());
				cell.setCellStyle(style);
				
				
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
				
				
				//임펄스 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getImpMax());
				cell.setCellStyle(style);
				//임펄스 Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getImpAvg());
				cell.setCellStyle(style);
				//임펄스 Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getImpMin());
				cell.setCellStyle(style);
				
				//임펄스(좌) Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getLimMax());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getLimAvg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getLimMin());
				cell.setCellStyle(style);
				
				
				//임펄스(우) Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getRimMax());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getRimAvg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getRimMin());
				cell.setCellStyle(style);
				
				
				//독성지수 (좌) Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getLtxMax());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getLtxAvg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getLtxMin());
				cell.setCellStyle(style);
				
				
				// 독성지수(우) Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getRtxMax());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getRtxAvg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getRtxMin());
				cell.setCellStyle(style);
				
				
				//미생물 독성지수 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getToxMax());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getToxAvg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getToxMin());
				cell.setCellStyle(style);
				
				//조류독성지수 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getEvnMax());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getEvnAvg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getEvnMin());
				cell.setCellStyle(style);
				
				
				// 클로로필-a Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTofMax());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTofAvg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTofMin());
				cell.setCellStyle(style);
				

				// voc1 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc1Max());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc1Avg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc1Min());
				cell.setCellStyle(style);
				
				// voc2 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc2Max());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc2Avg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc2Min());
				cell.setCellStyle(style);
				
				// voc3 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc3Max());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc3Avg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc3Min());
				cell.setCellStyle(style);
				
				// voc4 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc4Max());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc4Avg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc4Min());
				cell.setCellStyle(style);
				
				// voc5 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc5Max());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc5Avg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc5Min());
				cell.setCellStyle(style);
				
				// voc6 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc6Max());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc6Avg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc6Min());
				cell.setCellStyle(style);
				
				// voc7 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc7Max());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc7Avg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc7Min());
				cell.setCellStyle(style);
				
				// voc8 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc8Max());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc8Avg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc8Min());
				cell.setCellStyle(style);
				
				// voc9 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc9Max());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc9Avg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc9Min());
				cell.setCellStyle(style);
				
				// voc10 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc10Max());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc10Avg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc10Min());
				cell.setCellStyle(style);
				
				// voc11 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc11Max());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc11Avg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc11Min());
				cell.setCellStyle(style);
				
				// voc12 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc12Max());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc12Avg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc12Min());
				cell.setCellStyle(style);
				
				// voc13 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc13Max());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc13Avg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc13Min());
				cell.setCellStyle(style);
				
				// voc14 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc14Max());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc14Avg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc14Min());
				cell.setCellStyle(style);
				
				// voc15 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc15Max());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc15Avg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getVoc15Min());
				cell.setCellStyle(style);
				
				
				// 카드뮴 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getCadMax());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getCadAvg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getCadMin());
				cell.setCellStyle(style);
				
				// 납 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getPluMax());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getPluAvg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getPluMin());
				cell.setCellStyle(style);
				
				
				// 구리 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getCopMax());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getCopAvg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getCopMin());
				cell.setCellStyle(style);
				
				// 아연 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getZinMax());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getZinAvg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getZinMin());
				cell.setCellStyle(style);
				
				// 페놀1 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getPheMax());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getPheAvg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getPheMin());
				cell.setCellStyle(style);
				
				// 페놀2 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getPhlMax());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getPhlAvg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getPhlMin());
				cell.setCellStyle(style);
				
				// 총유기탄소 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTocMax());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTocAvg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTocMin());
				cell.setCellStyle(style);
				
				// 총질소 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTonMax());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTonAvg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTonMin());
				cell.setCellStyle(style);
				
				// 총인 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTopMax());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTopAvg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getTopMin());
				cell.setCellStyle(style);
				
				//암모니아성질소 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getNh4Max());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getNh4Avg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getNh4Min());
				cell.setCellStyle(style);
				
				// 질산성질소 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getNo3Max());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getNo3Avg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getNo3Min());
				cell.setCellStyle(style);
				
				// 인산염인 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getPo4Max());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getPo4Avg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getPo4Min());
				cell.setCellStyle(style);
				
				
				// 강수량 Max
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getRinMax());
				cell.setCellStyle(style);
				// Avg
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getRinAvg());
				cell.setCellStyle(style);
				// Min
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getRinMin());
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
