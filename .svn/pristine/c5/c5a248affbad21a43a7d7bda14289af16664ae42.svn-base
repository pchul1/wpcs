package daewooInfo.waterpolmnt.waterinfo.view;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.record.EscherAggregate;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFClientAnchor;
import org.apache.poi.hssf.usermodel.HSSFDataFormat;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFPatriarch;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddress;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import daewooInfo.common.login.bean.MemberVO;
import daewooInfo.seminar.bean.SeminarVO;
import daewooInfo.waterpolmnt.waterinfo.bean.DetailViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.LimitViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.SelectDataVO;

public class ExcelViewSelectDataReport extends AbstractExcelView{
	@Override
	protected void buildExcelDocument(Map model, HSSFWorkbook wb,
		HttpServletRequest req, HttpServletResponse resp) throws Exception {
		HSSFCell cell = null;
		HSSFCellStyle style = null;
		HSSFCellStyle tableStyle = null;
		HSSFCellStyle tableLStyle = null;
		HSSFCellStyle tableLTStyle = null;
		HSSFCellStyle tableHdStyle = null;
		HSSFCellStyle titleStyle = null;
		HSSFCellStyle titleStyle2 = null;
		HSSFCellStyle titleStyle3 = null;
		HSSFDataFormat format = wb.createDataFormat();
		HSSFFont font = wb.createFont();

		Map<String, Object> map= (Map<String, Object>) model.get("map");
		
		SelectDataVO selectDataInfo = (SelectDataVO)map.get("selectDataInfo");
		List<Object> selectDataList = (List<Object>) map.get("selectDataList");
		SelectDataVO selectDataViewInfo = (SelectDataVO)map.get("selectDataViewInfo");
		MemberVO memberInfo = (MemberVO)map.get("member");
		List<Object> fileList = (List<Object>) map.get("fileList");
		
		SelectDataVO selectDataVO = (SelectDataVO)map.get("selectDataVO");
		
		//파일이름 설정
		String filename = "";
		filename = "selectDataReport.xls";
	    filename = new String(filename.getBytes("euc-kr"), "8859_1"); 
	    resp.setHeader("Content-Disposition", "attachment;filename="+filename+";"); 				
 
		HSSFSheet sheet = wb.createSheet("선별사유서");
		sheet.setDefaultColumnWidth((short)18);
		sheet.setColumnWidth(2,(short)4000); // 0부터 시작
		sheet.setColumnWidth(3,(short)4000); // 0부터 시작
		sheet.setColumnWidth(4,(short)2500); // 0부터 시작
		sheet.setColumnWidth(5,(short)3500); // 0부터 시작
		sheet.setColumnWidth(6,(short)3500); // 0부터 시작
		sheet.setColumnWidth(7,(short)3500); // 0부터 시작
		sheet.setColumnWidth(8,(short)2500); // 0부터 시작
		//컬럼명 
		format = wb.createDataFormat();
		font.setFontHeightInPoints((short)11);
		font.setFontName("돋움");
		
		titleStyle = wb.createCellStyle();
		titleStyle.setFont(font);
		
		titleStyle2 = wb.createCellStyle();
		titleStyle2.setFont(font);
		titleStyle2.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		
		titleStyle3 = wb.createCellStyle();
		titleStyle3.setFont(font);
		titleStyle3.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		
		tableHdStyle = wb.createCellStyle();
		tableHdStyle.setFont(font);
		tableHdStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		tableHdStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		tableHdStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		tableHdStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		tableHdStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
//		tableHdStyle.setFillBackgroundColor(HSSFColor.AQUA.index);
//		tableHdStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
		tableHdStyle.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);        //셀에 색깔 채우기    
		tableHdStyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);   

		tableStyle = wb.createCellStyle();
		tableStyle.setFont(font);
		tableStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		tableStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		tableStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		tableStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		tableStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);	
		
		tableLStyle = wb.createCellStyle();
		tableLStyle.setFont(font);
		tableLStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		tableLStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		tableLStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		tableLStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		tableLStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		
		tableLTStyle = wb.createCellStyle();
		tableLTStyle.setFont(font);
		tableLTStyle.setAlignment(HSSFCellStyle.ALIGN_LEFT);
		tableLTStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_TOP);
		tableLTStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		tableLTStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		tableLTStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		tableLTStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
				
		cell = getCell(sheet, 0, 0);
		sheet.addMergedRegion(new CellRangeAddress(0,0,0,8));
		setText(cell, "이동형 측정기기 표준운영절차서");
		cell.setCellStyle(titleStyle3);
		
		cell = getCell(sheet, 0, 1);
		cell.setCellStyle(titleStyle3);
		
		cell = getCell(sheet, 0, 2);
		cell.setCellStyle(titleStyle3);
		
		cell = getCell(sheet, 0, 3);
		cell.setCellStyle(titleStyle3);
		
		cell = getCell(sheet, 0, 4);
		cell.setCellStyle(titleStyle3);
		
		cell = getCell(sheet, 0, 5);
		cell.setCellStyle(titleStyle3);
		
		cell = getCell(sheet, 0, 6);
		cell.setCellStyle(titleStyle3);
		
		cell = getCell(sheet, 0, 7);
		cell.setCellStyle(titleStyle3);
		
		cell = getCell(sheet, 0, 8);
		cell.setCellStyle(titleStyle3);
		
		cell = getCell(sheet, 2, 0);
		sheet.addMergedRegion(new CellRangeAddress(2,2,0,8));
		setText(cell, "이동형 측정기기의 이상데이터 발생 사유 통보");
		cell.setCellStyle(titleStyle2);
		
		cell = getCell(sheet, 4, 0);
		sheet.addMergedRegion(new CellRangeAddress(4,4,0,1));
		setText(cell, "○측정기기 위치");
		cell.setCellStyle(titleStyle);
		
		cell = getCell(sheet, 5, 0);
		setText(cell, "지역");
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, 5, 1);
		setText(cell, "지점");
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, 5, 2);
		sheet.addMergedRegion(new CellRangeAddress(5,5,2,8));
		setText(cell, "통보일");
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, 5, 3);
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, 5, 4);
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, 5, 5);
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, 5, 6);
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, 5, 7);
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, 5, 8);
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, 6, 0);
		setText(cell, selectDataInfo.getRiver_name());
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 6, 1);
		setText(cell, selectDataInfo.getBranch_name());
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 6, 2);
		sheet.addMergedRegion(new CellRangeAddress(6,6,2,8));
		setText(cell, selectDataViewInfo.getReg_date());
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 6, 3);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 6, 4);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 6, 5);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 6, 6);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 6, 7);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 6, 8);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 8, 0);
		sheet.addMergedRegion(new CellRangeAddress(8,8,0,1));
		setText(cell, "○측정기기 기간 및 상세");
		cell.setCellStyle(titleStyle);
		
		cell = getCell(sheet, 9, 0);
		sheet.addMergedRegion(new CellRangeAddress(9,9,0,8));
		setText(cell, "선별기간");
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, 9, 1);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 9, 2);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 9, 3);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 9, 4);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 9, 5);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 9, 6);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 9, 7);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 9, 8);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 10, 0);
		sheet.addMergedRegion(new CellRangeAddress(10,10,0,8));
		setText(cell, selectDataVO.getSearchYear()+"년 "+selectDataVO.getSearchMonth()+"월");
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 10, 1);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 10, 2);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 10, 3);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 10, 4);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 10, 5);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 10, 6);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 10, 7);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 10, 8);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, 12, 0);
		sheet.addMergedRegion(new CellRangeAddress(12,12,0,1));
		setText(cell, "일시");
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, 12, 1);
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, 12, 2);
		setText(cell, "측정항목");
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, 12, 3);
		setText(cell, "선별기준");
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, 12, 4);
		setText(cell, "구분");
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, 12, 5);
		sheet.addMergedRegion(new CellRangeAddress(12,12,5,7));
		setText(cell, "이상데이터사유");
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, 12, 6);
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, 12, 7);
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, 12, 8);
		setText(cell, "첨부");
		cell.setCellStyle(tableHdStyle);
		
		boolean isVO = false;
 
		if (selectDataList.size() > 0) {
			Object obj = selectDataList.get(0);
			isVO = obj instanceof SelectDataVO;
		}
		
		for (int i = 0; i < selectDataList.size(); i++) {
 
			if (isVO) {	// VO
 
				SelectDataVO vo2 = (SelectDataVO)selectDataList.get(i);
				//일시
				cell = getCell(sheet, 13 + i, 0);
				sheet.addMergedRegion(new CellRangeAddress(13 + i, 13 + i, 0, 1));
				cell.setCellValue(vo2.getStr_time()+" ~ "+vo2.getEnd_time());
				cell.setCellStyle(tableStyle);
				
				cell = getCell(sheet, 13 + i, 1);
				cell.setCellStyle(tableStyle);
				
				//측정항목
				cell = getCell(sheet, 13 + i, 2);
				cell.setCellValue(vo2.getSel_item());
				cell.setCellStyle(tableStyle);		

				//선별기준
				cell = getCell(sheet, 13+ i, 3);
				cell.setCellValue(vo2.getLimit_yn());
				cell.setCellStyle(tableStyle);
				
				//구분
				cell = getCell(sheet, 13+ i, 4);
				cell.setCellValue(vo2.getDel_yn());
				cell.setCellStyle(tableStyle);
				
				//이상데이터선별사유
				cell = getCell(sheet, 13+ i, 5);
				sheet.addMergedRegion(new CellRangeAddress(13 + i, 13 + i, 5, 7));
				cell.setCellValue(vo2.getSel_reason());
				cell.setCellStyle(tableLStyle);
				
				cell = getCell(sheet, 13 + i, 6);
				cell.setCellStyle(tableLStyle);
				
				cell = getCell(sheet, 13 + i, 7);
				cell.setCellStyle(tableLStyle);
				
				//첨부
				cell = getCell(sheet, 13+ i, 8);
				cell.setCellValue(vo2.getFile_cnt());
				cell.setCellStyle(tableStyle);
				
			} else {	// Map
 
				Map<String, String> category = (Map<String, String>) map.get(i);
 
			}
			
		}
		
		int rowNum = 14 + selectDataList.size();
		
		cell = getCell(sheet, rowNum, 0);
		sheet.addMergedRegion(new CellRangeAddress(rowNum,rowNum,0,1));
		setText(cell, "○기타사항");
		cell.setCellStyle(titleStyle);
		
		cell = getCell(sheet, rowNum+1, 0);
		sheet.addMergedRegion(new CellRangeAddress(rowNum+1,rowNum+3,0,8));
		setText(cell, selectDataViewInfo.getEtc_content());
		cell.setCellStyle(tableLTStyle);
		
		cell = getCell(sheet, rowNum+1, 1);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+1, 2);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+1, 3);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+1, 4);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+1, 5);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+1, 6);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+1, 7);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+1, 8);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+2, 0);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+2, 8);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+3, 0);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+3, 1);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+3, 2);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+3, 3);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+3, 4);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+3, 5);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+3, 6);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+3, 7);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+3, 8);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+5, 0);
		sheet.addMergedRegion(new CellRangeAddress(rowNum+5,rowNum+5,0,1));
		setText(cell, "○작성자");
		cell.setCellStyle(titleStyle);
		
		cell = getCell(sheet, rowNum+6, 0);
		sheet.addMergedRegion(new CellRangeAddress(rowNum+6,rowNum+6,0,3));
		setText(cell, "소속");
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, rowNum+6, 1);
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, rowNum+6, 2);
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, rowNum+6, 3);
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, rowNum+6, 4);
		sheet.addMergedRegion(new CellRangeAddress(rowNum+6,rowNum+6,4,6));
		setText(cell, "직책");
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, rowNum+6, 5);
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, rowNum+6, 6);
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, rowNum+6, 7);
		sheet.addMergedRegion(new CellRangeAddress(rowNum+6,rowNum+6,7,8));
		setText(cell, "성명");
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, rowNum+6, 8);
		cell.setCellStyle(tableHdStyle);
		
		cell = getCell(sheet, rowNum+7, 0);
		sheet.addMergedRegion(new CellRangeAddress(rowNum+7,rowNum+7,0,3));
		setText(cell, memberInfo.getDeptNoName());
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+7, 1);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+7, 2);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+7, 3);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+7, 4);
		sheet.addMergedRegion(new CellRangeAddress(rowNum+7,rowNum+7,4,6));
		setText(cell, memberInfo.getGradeName());
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+7, 5);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+7, 6);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+7, 7);
		sheet.addMergedRegion(new CellRangeAddress(rowNum+7,rowNum+7,7,8));
		setText(cell, memberInfo.getMemberName());
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+7, 8);
		cell.setCellStyle(tableStyle);
		
		cell = getCell(sheet, rowNum+9, 0);
		sheet.addMergedRegion(new CellRangeAddress(rowNum+9,rowNum+9,0,1));
		setText(cell, "○첨부파일");
		cell.setCellStyle(titleStyle);
		
		isVO = false;
		
		if (fileList.size() > 0) {
			Object obj = fileList.get(0);
			isVO = obj instanceof SelectDataVO;
		}
		
		rowNum = 30;
		
		HSSFPatriarch patriarch = sheet.createDrawingPatriarch();
				
		for (int i = 0; i < fileList.size(); i++) {
			if(isVO){	// VO
				if(i<2){
					
					SelectDataVO fileVo = (SelectDataVO)fileList.get(i);
					
					cell = getCell(sheet, rowNum, 0);
					sheet.addMergedRegion(new CellRangeAddress(rowNum,rowNum,0,3));
					setText(cell, "["+fileVo.getStr_time()+" ~ "+fileVo.getEnd_time()+" "+fileVo.getSel_item()+" "+fileVo.getOrignl_file_name()+"]");
					cell.setCellStyle(titleStyle);
					
					File file = new File(fileVo.getImg_url());
					byte[] picData = new byte[(int)file.length()];
					
					FileInputStream picIn = new FileInputStream(file);
					picIn.read(picData);
					
					int indx = wb.addPicture(picData, HSSFWorkbook.PICTURE_TYPE_JPEG);	//이미지 type
					
					HSSFClientAnchor anchor = new HSSFClientAnchor(rowNum+1, rowNum+1, rowNum+1, 40, (short)0, rowNum+1, (short)4, rowNum+21);
					anchor.setAnchorType(2);
					
					patriarch.createPicture(anchor, indx);
					
					rowNum = rowNum+21;
					picIn.close();
				}
			}
		}
	}
}
