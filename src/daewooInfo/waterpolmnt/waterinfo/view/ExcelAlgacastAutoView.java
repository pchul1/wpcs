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

import daewooInfo.waterpolmnt.waterinfo.bean.DetailViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.SearchTaksuVO;
import daewooInfo.waterpolmnt.waterinfo.bean.TaksuVO;

public class ExcelAlgacastAutoView extends AbstractExcelView{
	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook wb,
		HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HSSFCell cell = null;
		HSSFCellStyle style = null;
		HSSFDataFormat format = wb.createDataFormat();
		HSSFFont font = wb.createFont();
				 
		Map<String, Object> map= (Map<String, Object>) model.get("chartMap");
		List<Object> chart = (List<Object>) map.get("chart");
		SearchTaksuVO searchTaksuVO = (SearchTaksuVO)map.get("searchTaksuVO");
 
		HSSFSheet sheet = wb.createSheet("조류 측정 정보 조회 결과");
		sheet.setDefaultColumnWidth((short) 15);
 

		boolean isOneBranch = false;	//단일 측정소에 대한 결과
		 if(!"all".equals(searchTaksuVO.getGongku().toLowerCase()))
         {
         	isOneBranch = true;
         }
		 
		
		//파일이름 설정
		String filename = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
		String ctime = sdf.format(new Date(System.currentTimeMillis()));
		filename = "TMS-"+ctime+".xls";
	    filename = new String(filename.getBytes("euc-kr"), "8859_1"); 
	    resp.setHeader("Content-Disposition", "attachment;filename="+filename+";"); 
	    
	    
		
		// 제목
		cell = getCell(sheet, 0, 0);
		
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)14);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();		
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);
		style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		
				
		cell.setCellStyle(style);		
		setText(cell, "조류 측정 정보 조회 결과");	
		
		//검증되지 않은 데이터	
		cell = getCell(sheet, 1, 0);
	
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
		
		
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)11);
		font.setFontName("맑은 고딕");
		style = wb.createCellStyle();		
		style.setFont(font);
		style.setAlignment(HSSFCellStyle.ALIGN_CENTER);		
				
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
		
		int cn = 0;
		int addIdx = 3;
 
		if(!isOneBranch)
		{
			cell = getCell(sheet, 3, 0);
			sheet.addMergedRegion(new CellRangeAddress(3,4,0,0));
			setText(cell, "수계");
			cell = getCell(sheet, 3, 0);
			cell.setCellStyle(style);
			cell = getCell(sheet, 4, 0);
			cell.setCellStyle(style);
			
			
			cell = getCell(sheet, 3, 1);
			sheet.addMergedRegion(new CellRangeAddress(3,4,1,1));
			cell = getCell(sheet, 3, 1);
			setText(cell, "지역");
			cell = getCell(sheet, 3, 1);
			cell.setCellStyle(style);
			cell = getCell(sheet, 4, 1);
			cell.setCellStyle(style);
			
			
			cell = getCell(sheet, 3, 2);
			setText(cell, "측정소");
			sheet.addMergedRegion(new CellRangeAddress(3,4,2,2));
			cell = getCell(sheet, 3, 2);
			cell.setCellStyle(style);
			cell = getCell(sheet, 4, 2);
			cell.setCellStyle(style);
			
			cn = 3;
		}
		else
			addIdx = 4;
		
		cell = getCell(sheet, addIdx, cn);
		setText(cell, "일자");
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+1,cn,cn));
		cell = getCell(sheet, addIdx, cn);
		cell.setCellStyle(style);
		cell = getCell(sheet, addIdx+1, cn);
		cell.setCellStyle(style);
		
		cn++;
		
		cell = getCell(sheet, addIdx, cn);
		setText(cell, "시간");
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+1,cn,cn));
		cell = getCell(sheet, addIdx, cn);
		cell.setCellStyle(style);
		cell = getCell(sheet, addIdx+1, cn);
		cell.setCellStyle(style);
		
		cn++;
		
		cell = getCell(sheet, addIdx, cn);
		setText(cell, "수온1(℃)");
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+1,cn,cn));
		cell = getCell(sheet, addIdx, cn);
		cell.setCellStyle(style);
		cell = getCell(sheet, addIdx+1, cn);
		cell.setCellStyle(style);
		
		cn++;
		
		cell = getCell(sheet, addIdx, cn);
		setText(cell, "클로로필-a(㎍/L)");
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+1,cn,cn));
		cell = getCell(sheet, addIdx, cn);
		cell.setCellStyle(style);
		cell = getCell(sheet, addIdx+1, cn);
		cell.setCellStyle(style);
		
		cn++;

		
		
		sheet.addMergedRegion(new CellRangeAddress(0,0,0,cn-1));
		sheet.addMergedRegion(new CellRangeAddress(1,1,0,cn-1));		
		sheet.addMergedRegion(new CellRangeAddress(2,2,0,cn-1));		
		
		
		
		
		boolean isVO = false;
 
		if (chart.size() > 0) {
			Object obj = chart.get(0);
			isVO = obj instanceof DetailViewVO;
		}
		

		for (int i = 0; i < chart.size(); i++) {
 
			if (isVO) {	// VO
 
				DetailViewVO vo = (DetailViewVO) chart.get(i);
				
				style = wb.createCellStyle();
				
				//String factNumber = vo.getRiver_div();
                
//                if(factNumber.equals("R01"))
//                	factNumber = vo.getFactname().replace("한강","");
//                else if(factNumber.equals("R02"))
//                	factNumber =  vo.getFactname().replace("낙동강","");
//                else if(factNumber.equals("R03"))
//                	factNumber =  vo.getFactname().replace("금강","");
//                else if(factNumber.equals("R04"))
//                	factNumber =  vo.getFactname().replace("영산강","");
				
				if(isOneBranch && i == 0)
				{
					addIdx = 6;
					
					cell = getCell(sheet, 3, 0);
					sheet.addMergedRegion(new CellRangeAddress(3,3,0,cn-1));
					style.setBorderTop(HSSFCellStyle.BORDER_NONE);	
					style.setBorderLeft(HSSFCellStyle.BORDER_NONE);	
					style.setBorderRight(HSSFCellStyle.BORDER_NONE);	
					style.setBorderBottom(HSSFCellStyle.BORDER_NONE);	
					style.setAlignment(HSSFCellStyle.ALIGN_LEFT);
					cell.setCellStyle(style);		
					setText(cell, " 측정소 : " + vo.getRiver_name() + " [" + vo.getBranch_name() + "]");	
				}
				else
				{
					addIdx = 5;
				}
				
				
				
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);			
				
				style.setLocked(false);
                
				cn = 0;
				
				if(!isOneBranch)
				{
					//수계
					cell = getCell(sheet, addIdx + i, 0);
					cell.setCellValue(vo.getRiver_name());
					cell.setCellStyle(style);				
	                 
					//공구
					cell = getCell(sheet, 5 + i, 1);
					cell.setCellValue(vo.getFactname());
					cell.setCellStyle(style);				
	 
					//측정소
					cell = getCell(sheet, 5 + i, 2);
					cell.setCellValue(vo.getBranch_name());
					cell.setCellStyle(style);		
					
					cn = 3;
				}
				

				//일자
				cell = getCell(sheet, addIdx + i, cn);
				cell.setCellValue(vo.getStrdate());
				cell.setCellStyle(style);				

				cn++;
				
				style = wb.createCellStyle();
				style.setDataFormat(format.getFormat("0.00"));
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);			
				style.setLocked(false);

				//시간
				cell = getCell(sheet, addIdx + i, cn);
				cell.setCellValue(vo.getStrtime());
				cell.setCellStyle(style);
				
				cn++;
				
				style = wb.createCellStyle();
				style.setDataFormat(format.getFormat("0.00"));
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);			
				style.setLocked(false);

				//수온
				cell = getCell(sheet, addIdx + i, cn);
				cell.setCellValue(vo.getTmp());
				cell.setCellStyle(style);
				
				cn++;
				
				style = wb.createCellStyle();
				style.setDataFormat(format.getFormat("0.00"));
				style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
				style.setBorderLeft(HSSFCellStyle.BORDER_THIN);
				style.setBorderRight(HSSFCellStyle.BORDER_THIN);
				style.setBorderTop(HSSFCellStyle.BORDER_THIN);			
				style.setLocked(false);

				//클로로 A 
				cell = getCell(sheet, addIdx + i, cn);
				cell.setCellValue(vo.getTof());
				cell.setCellStyle(style);
				
				cn++;
				

				
			} else {	// Map
 
				Map<String, String> category = (Map<String, String>) chart.get(i);
 
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
