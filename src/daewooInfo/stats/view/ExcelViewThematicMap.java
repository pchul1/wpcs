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
import org.mortbay.log.Log;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import daewooInfo.stats.bean.ThematicMapSearchVO;
import daewooInfo.stats.bean.ThematicMapVO;

public class ExcelViewThematicMap extends AbstractExcelView{
	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook wb,
		HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HSSFCell cell = null;
		HSSFCellStyle style = null;
		HSSFDataFormat format = wb.createDataFormat();
		HSSFFont font = wb.createFont();

		Map<String, Object> map= (Map<String, Object>) model.get("map");
		List<Object> detailViewList = (List<Object>) map.get("detailViewList");
		List<Object> bermDataList = (List<Object>) map.get("bermDataList");
		List<Object> bermSettingList = (List<Object>) map.get("bermSettingList");
		
		ThematicMapSearchVO searchVO = (ThematicMapSearchVO)map.get("searchVO");
		
		
		//파일이름 설정
		String filename = "";
		filename = "주제도.xls";
	    filename = new String(filename.getBytes("euc-kr"), "8859_1"); 
	    resp.setHeader("Content-Disposition", "attachment;filename="+filename+";"); 				
 
		HSSFSheet sheet = wb.createSheet("데이터조회");
		sheet.setDefaultColumnWidth((short)18);
		
		
		// 제목
		cell = getCell(sheet, 0, 0);
		sheet.addMergedRegion(new CellRangeAddress(0,0,0,(detailViewList.size()*2)));
		
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
		
		//검증되지 않은 데이터	
		cell = getCell(sheet, 1, 0);
		sheet.addMergedRegion(new CellRangeAddress(1,1,0,2));	
		
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
		sheet.addMergedRegion(new CellRangeAddress(2,3,0,0));
		setText(cell, "항목");
		cell = getCell(sheet, 2, 0);
		cell.setCellStyle(style);
		cell = getCell(sheet, 3, 0);
		cell.setCellStyle(style);
		
		int cnt = 0;
		
		for (int i = 0; i < detailViewList.size(); i++) {
			ThematicMapVO vo = (ThematicMapVO)detailViewList.get(i);
		    
			cell = getCell(sheet, 2, cnt+1);
			setText(cell, vo.getBranchNameN());
			sheet.addMergedRegion(new CellRangeAddress(2,2,cnt+1,cnt+2));
			
			cell = getCell(sheet, 2, cnt+1);
			cell.setCellStyle(style);
			cell = getCell(sheet, 3, cnt+1);
			setText(cell, "검색데이터");
			cell.setCellStyle(style);
			
			cell = getCell(sheet, 2, cnt+2);
			cell.setCellStyle(style);
			cell = getCell(sheet, 3, cnt+2);
			setText(cell, "비교데이터");
			cell.setCellStyle(style);
			
			cnt = cnt+2;
		}
		
		boolean isDataVO = false;
		boolean isBermSetVO = false;
		
		String itempNm="";
		if(searchVO.getSearchItem().equals("T")){
			itempNm = "탁도";
		}else if(searchVO.getSearchItem().equals("W")){
			itempNm = "수온";
		}else if(searchVO.getSearchItem().equals("P")){
			itempNm = "ph";
		}else if(searchVO.getSearchItem().equals("D")){
			itempNm = "DO";
		}else if(searchVO.getSearchItem().equals("E")){
			itempNm = "EC";
		}else if(searchVO.getSearchItem().equals("C")){
			itempNm = "Chl-a";
		}
		 
		if (detailViewList.size() > 0) {
			Object obj = detailViewList.get(0);
			isDataVO = obj instanceof ThematicMapVO;
		}
		
		if (bermSettingList.size() > 0) {
			Object s_obj = bermSettingList.get(0);
			isBermSetVO = s_obj instanceof ThematicMapVO;
		}
		
		ThematicMapVO vo = new ThematicMapVO();
		
		if (isDataVO) {	// VO
			style = wb.createCellStyle();
			
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
			style.setBorderRight(HSSFCellStyle.BORDER_THIN);
			style.setBorderTop(HSSFCellStyle.BORDER_THIN);				
			style.setLocked(false);
			
			cell = getCell(sheet, 4, 0);
			cell.setCellValue(itempNm);
			cell.setCellStyle(style);
			
			cnt = 1;
			for (int i = 0; i < detailViewList.size(); i++) {
				vo = (ThematicMapVO)detailViewList.get(i);
				
				if(searchVO.getSearchItem().equals("T")){
					cell = getCell(sheet, 4, cnt++);
					cell.setCellValue(vo.getTurN() !=null && !vo.getTurN().equals("") ? vo.getTurN():"-");
					cell.setCellStyle(style);
					
					cell = getCell(sheet, 4, cnt++);
					cell.setCellValue(vo.getTurC() !=null && !vo.getTurC().equals("") ? vo.getTurC():"-");
					cell.setCellStyle(style);
					
				}else if(searchVO.getSearchItem().equals("W")){
					cell = getCell(sheet, 4, cnt++);
					cell.setCellValue(vo.getTmpN() !=null && !vo.getTmpN().equals("") ? vo.getTmpN():"-");
					cell.setCellStyle(style);
					
					cell = getCell(sheet, 4, cnt++);
					cell.setCellValue(vo.getTmpC() !=null && !vo.getTmpC().equals("") ? vo.getTmpC():"-");
					cell.setCellStyle(style);
				}else if(searchVO.getSearchItem().equals("P")){
					cell = getCell(sheet, 4, cnt++);
					cell.setCellValue(vo.getPhyN() !=null && !vo.getPhyN().equals("") ? vo.getPhyN():"-");
					cell.setCellStyle(style);
					
					cell = getCell(sheet, 4, cnt++);
					cell.setCellValue(vo.getPhyC() !=null && !vo.getPhyC().equals("") ? vo.getPhyC():"-");
					cell.setCellStyle(style);
				}else if(searchVO.getSearchItem().equals("D")){
					cell = getCell(sheet, 4, cnt++);
					cell.setCellValue(vo.getDowN() !=null && !vo.getDowN().equals("") ? vo.getDowN():"-");
					cell.setCellStyle(style);
					
					cell = getCell(sheet, 4, cnt++);
					cell.setCellValue(vo.getDowC() !=null && !vo.getDowC().equals("") ? vo.getDowC():"-");
					cell.setCellStyle(style);
				}else if(searchVO.getSearchItem().equals("E")){
					cell = getCell(sheet, 4, cnt++);
					cell.setCellValue(vo.getConN() !=null && !vo.getConN().equals("") ? vo.getConN():"-");
					cell.setCellStyle(style);
					
					cell = getCell(sheet, 4, cnt++);
					cell.setCellValue(vo.getConC() !=null && !vo.getConC().equals("") ? vo.getConC():"-");
					cell.setCellStyle(style);
				}else if(searchVO.getSearchItem().equals("C")){
					cell = getCell(sheet, 4, cnt++);
					cell.setCellValue(vo.getTofN() !=null && !vo.getTofN().equals("") ? vo.getTofN():"-");
					cell.setCellStyle(style);
					
					cell = getCell(sheet, 4, cnt++);
					cell.setCellValue(vo.getTofC() !=null && !vo.getTofC().equals("") ? vo.getTofC():"-");
					cell.setCellStyle(style);
				}
			}
		}
		
		int temp = 5;
		cnt = 0;
		if (isBermSetVO) {	// VO
			ThematicMapVO vo2 = (ThematicMapVO)bermSettingList.get(0);
			if(vo2.getItemR().equals("Y")){
				
				cell = getCell(sheet, temp, 0);
				cell.setCellValue("강우");
				cell.setCellStyle(style);
				
				cnt = 1;
				
				for (int i = 0; i < detailViewList.size(); i++) {
					vo = (ThematicMapVO)detailViewList.get(i);
					
					cell = getCell(sheet, temp, cnt++);
					cell.setCellValue(vo.getRainFall() !=null && !vo.getRainFall().equals("") ? vo.getRainFall():"-");
					cell.setCellStyle(style);
					
					cell = getCell(sheet, temp, cnt++);
					cell.setCellValue(vo.getRainFall() !=null && !vo.getRainFall().equals("") ? vo.getRainFall():"-");
					cell.setCellStyle(style);
				}
				
				temp++;
			}
			
			if(vo2.getItemH().equals("Y")){
				cell = getCell(sheet, temp, 0);
				cell.setCellValue("습도");
				cell.setCellStyle(style);
				
				cnt = 1;
				
				for (int i = 0; i < detailViewList.size(); i++) {
					vo = (ThematicMapVO)detailViewList.get(i);
					
					cell = getCell(sheet, temp, cnt++);
					cell.setCellValue(vo.getHumidity() !=null && !vo.getHumidity().equals("") ? vo.getHumidity():"-");
					cell.setCellStyle(style);
					
					cell = getCell(sheet, temp, cnt++);
					cell.setCellValue(vo.getHumidity() !=null && !vo.getHumidity().equals("") ? vo.getHumidity():"-");
					cell.setCellStyle(style);
				}
				
				temp++;
			}
			
			if(vo2.getItemT().equals("Y")){
				cell = getCell(sheet, temp, 0);
				cell.setCellValue("온도");
				cell.setCellStyle(style);
				
				cnt = 1;
				
				for (int i = 0; i < detailViewList.size(); i++) {
					vo = (ThematicMapVO)detailViewList.get(i);
					
					cell = getCell(sheet, temp, cnt++);
					cell.setCellValue(vo.getTemp() !=null && !vo.getTemp().equals("") ? vo.getTemp():"-");
					cell.setCellStyle(style);
					
					cell = getCell(sheet, temp, cnt++);
					cell.setCellValue(vo.getTemp() !=null && !vo.getTemp().equals("") ? vo.getTemp():"-");
					cell.setCellStyle(style);
				}
				
				temp++;
			}
			
			if(vo2.getItemWs().equals("Y")){
				
				cell = getCell(sheet, temp, 0);
				cell.setCellValue("풍속");
				cell.setCellStyle(style);
				
				cnt = 1;
				
				for (int i = 0; i < detailViewList.size(); i++) {
					vo = (ThematicMapVO)detailViewList.get(i);
					
					cell = getCell(sheet, temp, cnt++);
					cell.setCellValue(vo.getWindSpeed() !=null && !vo.getWindSpeed().equals("") ? vo.getWindSpeed():"-");
					cell.setCellStyle(style);
					
					cell = getCell(sheet, temp, cnt++);
					cell.setCellValue(vo.getWindSpeed() !=null && !vo.getWindSpeed().equals("") ? vo.getWindSpeed():"-");
					cell.setCellStyle(style);
				}
				
				temp++;
			}
			
			if(vo2.getItemWd().equals("Y")){
				cell = getCell(sheet, temp, 0);
				cell.setCellValue("풍향");
				cell.setCellStyle(style);
				
				cnt = 1;
				
				for (int i = 0; i < detailViewList.size(); i++) {
					vo = (ThematicMapVO)detailViewList.get(i);
					
					cell = getCell(sheet, temp, cnt++);
					cell.setCellValue(vo.getWindDir() !=null && !vo.getWindDir().equals("") ? vo.getWindDir():"-");
					cell.setCellStyle(style);
					
					cell = getCell(sheet, temp, cnt++);
					cell.setCellValue(vo.getWindDir() !=null && !vo.getWindDir().equals("") ? vo.getWindDir():"-");
					cell.setCellStyle(style);
				}
			}
			
			
			
		}
		
	}
	
	
}
