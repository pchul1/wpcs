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

public class ExcelStatsSituOCView extends AbstractExcelView{
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
 
		
		String title = "상황발생통계";
		
			
		HSSFSheet sheet = wb.createSheet(title);
		sheet.setDefaultColumnWidth((short)15);

		//파일이름 설정
		String filename = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String ctime = sdf.format(new Date(System.currentTimeMillis()));
		filename = "stats_situ_oc" + "-"+ctime+".xls";
		filename = new String(filename.getBytes("euc-kr"), "8859_1"); 
		resp.setHeader("Content-Disposition", "attachment;filename="+filename+";"); 
		
		
		
			
		
		int maxCell = 7;
		
		if("SYS".equals(vo.getOcDiv()))
				maxCell = 7;
		else if("REG".equals(vo.getOcDiv()))
		{
			if("T".equals(vo.getOcPointDiv())) //임의지점
				maxCell = 15;
			else
				maxCell = 16;
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
		} else if("4".equals(gubun)) {
			statsTitle = "[ "+ vo.getStartDate() +" 부터" + vo.getEndDate() +"까지의 통계 ]";
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
		
		
		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+1,cellIdx,cellIdx));
		setText(cell, "기간");
		cell = getCell(sheet, addIdx, cellIdx);
		cell.setCellStyle(style);
		cell = getCell(sheet, addIdx+1, cellIdx);
		cell.setCellStyle(style);
		
		cellIdx++;
		
		cell = getCell(sheet, addIdx, cellIdx);
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+1,cellIdx,cellIdx));
		setText(cell, "수계");
		cell = getCell(sheet, addIdx, cellIdx);
		cell.setCellStyle(style);
		cell = getCell(sheet, addIdx+1, cellIdx);
		cell.setCellStyle(style);
			
		cellIdx++;
		
		if("REG".equals(vo.getOcDiv()))
		{
			cell = getCell(sheet, addIdx, cellIdx);
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+1,cellIdx,cellIdx));
			setText(cell, "지역");
			cell = getCell(sheet, addIdx, cellIdx);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx+1, cellIdx);
			cell.setCellStyle(style);
			
			cellIdx++;
		}
		
		if(!"REG".equals(vo.getOcDiv()) || !"T".equals(vo.getOcPointDiv()))
		{
			cell = getCell(sheet, addIdx, cellIdx);
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+1,cellIdx,cellIdx));
			setText(cell, "측정소");
			cell = getCell(sheet, addIdx, cellIdx);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx+1, cellIdx);
			cell.setCellStyle(style);
			
			cellIdx++;
		}
		
		
		if("SYS".equals(vo.getOcDiv()))
		{
			if("T".equals(vo.getSysKind()))
			{
				cell = getCell(sheet, addIdx, cellIdx);
				sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx+3));
				setText(cell, "경보 유형");
				cell = getCell(sheet, addIdx, cellIdx);
				cell.setCellStyle(style);
				cell = getCell(sheet, addIdx, cellIdx + 1);
				cell.setCellStyle(style);
				cell = getCell(sheet, addIdx, cellIdx + 2);
				cell.setCellStyle(style);
				cell = getCell(sheet, addIdx, cellIdx + 3);
				cell.setCellStyle(style);
				
				addIdx++;
				
				cell = getCell(sheet, addIdx, cellIdx++);
				setText(cell, "최초");
				cell.setCellStyle(style);
				
				cell = getCell(sheet, addIdx, cellIdx++);
				setText(cell, "3시간");
				cell.setCellStyle(style);
				
				cell = getCell(sheet, addIdx, cellIdx++);
				setText(cell, "6시간");
				cell.setCellStyle(style);
				
				cell = getCell(sheet, addIdx, cellIdx++);
				setText(cell, "12시간이상");
				cell.setCellStyle(style);
			}
			else
			{
				cell = getCell(sheet, addIdx, cellIdx);
				sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx+3));
				setText(cell, "경보 단계");
				cell = getCell(sheet, addIdx, cellIdx);
				cell.setCellStyle(style);
				cell = getCell(sheet, addIdx, cellIdx + 1);
				cell.setCellStyle(style);
				cell = getCell(sheet, addIdx, cellIdx + 2);
				cell.setCellStyle(style);
				cell = getCell(sheet, addIdx, cellIdx + 3);
				cell.setCellStyle(style);
				
				addIdx++;
				
				cell = getCell(sheet, addIdx, cellIdx++);
				setText(cell, "관심");
				cell.setCellStyle(style);
				
				cell = getCell(sheet, addIdx, cellIdx++);
				setText(cell, "주의");
				cell.setCellStyle(style);
				
				cell = getCell(sheet, addIdx, cellIdx++);
				setText(cell, "경계");
				cell.setCellStyle(style);
				
				cell = getCell(sheet, addIdx, cellIdx++);
				setText(cell, "심각");
				cell.setCellStyle(style);
			}
		}
		else if("REG".equals(vo.getOcDiv()))
		{
			cell = getCell(sheet, addIdx, cellIdx);
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cellIdx,cellIdx+12));
			setText(cell, "경보 단계");
			cell = getCell(sheet, addIdx, cellIdx);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx, cellIdx + 1);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx, cellIdx + 2);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx, cellIdx + 3);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx, cellIdx + 4);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx, cellIdx + 5);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx, cellIdx + 6);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx, cellIdx + 7);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx, cellIdx + 8);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx, cellIdx + 9);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx, cellIdx + 10);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx, cellIdx + 11);
			cell.setCellStyle(style);
			cell = getCell(sheet, addIdx, cellIdx + 12);
			cell.setCellStyle(style);
			
			addIdx++;
			
			cell = getCell(sheet, addIdx, cellIdx++);
			setText(cell, "오탁수발생");
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx, cellIdx++);
			setText(cell, "준설장비용출");
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx, cellIdx++);
			setText(cell, "준설장비전복");
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx, cellIdx++);
			setText(cell, "선박사고");
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx, cellIdx++);
			setText(cell, "선박페인트");
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx, cellIdx++);
			setText(cell, "탱크로리");
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx, cellIdx++);
			setText(cell, "홍수기");
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx, cellIdx++);
			setText(cell, "취정수장");
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx, cellIdx++);
			setText(cell, "유류유출");
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx, cellIdx++);
			setText(cell, "페놀");
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx, cellIdx++);
			setText(cell, "유해물질");
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx, cellIdx++);
			setText(cell, "물고기폐사");
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx, cellIdx++);
			setText(cell, "기타사항");
			cell.setCellStyle(style);
		}
		
		addIdx++;
		
		
		
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
				
				String date="";
				
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
				
				//수계
				cell = getCell(sheet, addIdx + i, cellIdx++);
				cell.setCellValue(vo2.getRiverName());
				cell.setCellStyle(style);
				
				if("REG".equals(vo.getOcDiv()))
				{
					if("REG".equals(vo.getOcDiv()) && "T".equals(vo.getOcPointDiv()))
					{
						//지역
						cell = getCell(sheet, addIdx + i, cellIdx++);
						cell.setCellValue(vo2.getStatsArea());
						cell.setCellStyle(style);
					}
					else
					{
						//지역
						cell = getCell(sheet, addIdx + i, cellIdx++);
						cell.setCellValue(vo2.getRegName());
						cell.setCellStyle(style);
					}
				}
				
				if(!"REG".equals(vo.getOcDiv()) || !"T".equals(vo.getOcPointDiv()))
				{
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
				}
				
				if("SYS".equals(vo.getOcDiv()))
				{
					if("T".equals(vo.getSysKind()))
					{
						//최초
						cell = getCell(sheet, addIdx + i, cellIdx++);
						cell.setCellValue(vo2.getFirstCnt());
						cell.setCellStyle(style);
						//3시간
						cell = getCell(sheet, addIdx + i, cellIdx++);
						cell.setCellValue(vo2.getTime3Cnt());
						cell.setCellStyle(style);
						//6시간
						cell = getCell(sheet, addIdx + i, cellIdx++);
						cell.setCellValue(vo2.getTime6Cnt());
						cell.setCellStyle(style);
						//12시간이상
						cell = getCell(sheet, addIdx + i, cellIdx++);
						cell.setCellValue(vo2.getTime12Cnt());
						cell.setCellStyle(style);
					}
					else
					{
						//관심
						cell = getCell(sheet, addIdx + i, cellIdx++);
						cell.setCellValue(vo2.getAtnCnt());
						cell.setCellStyle(style);
						//주의
						cell = getCell(sheet, addIdx + i, cellIdx++);
						cell.setCellValue(vo2.getCatCnt());
						cell.setCellStyle(style);
						//경계
						cell = getCell(sheet, addIdx + i, cellIdx++);
						cell.setCellValue(vo2.getAlertCnt());
						cell.setCellStyle(style);
						//심각
						cell = getCell(sheet, addIdx + i, cellIdx++);
						cell.setCellValue(vo2.getSrsCnt());
						cell.setCellStyle(style);
					}
				}
				else if("REG".equals(vo.getOcDiv()))
				{
					//오탁수발생
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getDmwtrCnt());
					cell.setCellStyle(style);
					//준설장비용출
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getEquEltnCnt());
					cell.setCellStyle(style);
					//준설장비전복
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getEquRollCnt());
					cell.setCellStyle(style);
					//선박사고
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getShipCnt());
					cell.setCellStyle(style);
					//선박페인트
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getShipPntCnt());
					cell.setCellStyle(style);
					//탱크로리
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getTanktrCnt());
					cell.setCellStyle(style);
					
					//홍수기
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getFldssnCnt());
					cell.setCellStyle(style);
					
					//취정수장
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getIfplntCnt());
					cell.setCellStyle(style);
					
					//유류유출
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getOilCnt());
					cell.setCellStyle(style);
					
					//페놀
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getPhenolCnt());
					cell.setCellStyle(style);
					
					//유해물질
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getToxicCnt());
					cell.setCellStyle(style);
					
					//물고기폐사
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getFshdieCnt());
					cell.setCellStyle(style);
					
					//기타사항
					cell = getCell(sheet, addIdx + i, cellIdx++);
					cell.setCellValue(vo2.getEtcCnt());
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
