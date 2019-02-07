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

public class ExcelDetailViewRIVER2 extends AbstractExcelView{
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
 
		HSSFSheet sheet = wb.createSheet("수질측정망 조회 결과");
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
		filename = "수질측정망-"+ctime+".xls";
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
		setText(cell, "수질측정망 조회 결과");
		
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
		setText(cell, "수신일자");
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+1,cn,cn));
		cell = getCell(sheet, addIdx, cn);
		cell.setCellStyle(style);
		cell = getCell(sheet, addIdx+1, cn);
		cell.setCellStyle(style);
		
		cn++;
		
		cell = getCell(sheet, addIdx, cn);
		setText(cell, "수신시간");
		sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx+1,cn,cn));
		cell = getCell(sheet, addIdx, cn);
		cell.setCellStyle(style);
		cell = getCell(sheet, addIdx+1, cn);
		cell.setCellStyle(style);
		
		cn++;

		String bItem = searchTaksuVO.getItem();
		
		if("all".equals(bItem) || "COM1".equals(bItem))
		{
			//일반항목 내부
			cell = getCell(sheet, addIdx, cn);
			setText(cell, "일반항목");
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cn,cn+4));
			
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
	
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "탁도(NTU)");
			cell.setCellStyle(style);
			
			++cn;
			
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "pH1");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "DO1(mg/L)");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "EC1(mS/cm");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "수온(℃)");
			cell.setCellStyle(style);
		
			++cn;
		}

		
		if("all".equals(bItem) || "ORGA".equals(bItem))
		{
			//유기물질
			cell = getCell(sheet, addIdx, cn);
			setText(cell, "유기물질");
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx, cn, cn));
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
	
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "총유기탄소(mg/L)");
			cell.setCellStyle(style);
			
			++cn;
		}
		
		

		if("all".equals(bItem) || "BIO1".equals(bItem))
		{
			//생물독성 물고기
			cell = getCell(sheet, addIdx, cn);
			setText(cell, "생물독성(물고기)");
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cn, cn));
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
	
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "임펄스(pulse)");
			cell.setCellStyle(style);
	
			++cn;
		}
	
		if("all".equals(bItem) || "BIO2".equals(bItem))
		{
			//생물독성(물벼룩1)
			cell = getCell(sheet, addIdx, cn);
			setText(cell, "생물독성(물벼룩1)");
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cn,cn+1));
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "임펄스(좌)(pulse)");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
	
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "임펄스(우)(pulse)");
			cell.setCellStyle(style);
	
			++cn;
		}
		
		if("all".equals(bItem) || "BIO3".equals(bItem))
		{
			//생물독성(물벼룩2)
			cell = getCell(sheet, addIdx, cn);
			setText(cell, "생물독성(물벼룩2)");
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cn,cn+1));
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "독성지수(좌)(TOX)");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
	
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "독성지수(우)(TOX)");
			cell.setCellStyle(style);
	
			++cn;
		}
		
		if("all".equals(bItem) || "BIO4".equals(bItem))
		{
			//생물독성(미생물)
			cell = getCell(sheet, addIdx, cn);
			setText(cell, "생물독성(미생물)");
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cn,cn));
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
	
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "미생물독성지수(%)");
			cell.setCellStyle(style);
			
			++cn;
		}
		
		if("all".equals(bItem) || "BIO5".equals(bItem))
		{
			//생물독성(조류)
			cell = getCell(sheet, addIdx, cn);
			setText(cell, "생물독성(조류)");
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cn,cn));
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
	
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "조류독성지수(TOX)");
			cell.setCellStyle(style);
			
			++cn;
		}
		
			
		if("all".equals(bItem) || "VOCS".equals(bItem))
		{
			//휘발성 유기화합물
			cell = getCell(sheet, addIdx, cn);
			setText(cell, "휘발성 유기화합물");
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cn,cn+14));
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "염화메틸렌(㎍/L)");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "1.1.1-트리클로로에테인(㎍/L)");
			cell.setCellStyle(style);
			
			++cn;
		
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "벤젠(㎍/L)");
			cell.setCellStyle(style);
			
			++cn;
			
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "사염화탄소(㎍/L)");
			cell.setCellStyle(style);
			
			++cn;
		
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "트리클로로에틸렌(㎍/L)");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "톨루엔(㎍/L)");
			cell.setCellStyle(style);
	
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "테트라클로로에틸렌(㎍/L)");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "에틸벤젠(㎍/L)");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "m,p-자일렌(㎍/L)");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "o-자일렌(㎍/L)");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "[ECD]염화메틸렌(㎍/L)");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "[ECD]1.1.1-트리클로로에테인(㎍/L)");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "[ECD]사염화탄소(㎍/L)");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "[ECD]트리클로로에틸렌(㎍/L)");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
		
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "[ECD]테트라클로로에틸렌(㎍/L)");
			cell.setCellStyle(style);
			
			++cn;
		}

		if("all".equals(bItem) || "NUTR".equals(bItem))
		{
			//영양염류
			cell = getCell(sheet, addIdx, cn);
			setText(cell, "영양염류");
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx, cn, cn+4));
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "총질소(mg/L)");
			cell.setCellStyle(style);
			
			cn++;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "총인(mg/L)");
			cell.setCellStyle(style);
			
			cn++;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "암모니아성질소(mg/L)");
			cell.setCellStyle(style);
			
			cn++;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "질산성질소(mg/L)");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "인산염인(mg/L)");
			cell.setCellStyle(style);
			
			++cn;
		}
		
	
		if("all".equals(bItem) || "CHLA".equals(bItem))
		{
			//클로로필-a
			cell = getCell(sheet, addIdx, cn);
			setText(cell, "클로로필-a");
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx,cn,cn));
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
	
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "클로로필-a(㎍/L)");
			cell.setCellStyle(style);
			
			++cn;
		}
		
		
		if("all".equals(bItem) || "METL".equals(bItem))
		{
			//중금속
			cell = getCell(sheet, addIdx, cn);
			setText(cell, "중금속");
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx, cn, cn+3));
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "카드뮴(mg/L)");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "납(mg/L)");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "구리(mg/L)");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "아연(mg/L)");
			cell.setCellStyle(style);
	
			++cn;
		}
		
		if("all".equals(bItem) || "PHEN".equals(bItem))
		{
			//페놀
			cell = getCell(sheet, addIdx, cn);
			setText(cell, "페놀");
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx, cn, cn+1));
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
			
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "페놀1(mg/L)");
			cell.setCellStyle(style);
			
			++cn;
			
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
	
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "페놀2(mg/L)");
			cell.setCellStyle(style);
			
			++cn;
		}
		
		
		if("all".equals(bItem) || "RAIN".equals(bItem))
		{
			//강수량계
			cell = getCell(sheet, addIdx, cn);
			setText(cell, "강수량계");
			sheet.addMergedRegion(new CellRangeAddress(addIdx,addIdx, cn, cn));
			cell = getCell(sheet, addIdx, cn);
			cell.setCellStyle(style);
	
			cell = getCell(sheet, addIdx+1, cn);
			setText(cell, "강수량(mm/L)");
			cell.setCellStyle(style);
			
			++cn;
		}
		
		
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
				
//				if(factNumber.equals("R01"))
//					factNumber = vo.getFactname().replace("한강","");
//				else if(factNumber.equals("R02"))
//					factNumber =  vo.getFactname().replace("낙동강","");
//				else if(factNumber.equals("R03"))
//					factNumber =  vo.getFactname().replace("금강","");
//				else if(factNumber.equals("R04"))
//					factNumber =  vo.getFactname().replace("영산강","");
				
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
				
				
				if("all".equals(bItem) || "COM1".equals(bItem))
				{
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getTur());
					cell.setCellStyle(style);
					
					//수소이온농도1
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getPhy());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getDow());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getCon());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getTmp());
					cell.setCellStyle(style);
				}
			
				if("all".equals(bItem) || "ORGA".equals(bItem))
				{
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getToc());
					cell.setCellStyle(style);
				}
				
				if("all".equals(bItem) || "BIO1".equals(bItem))
				{
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getImp());
					cell.setCellStyle(style);
				}
				
				if("all".equals(bItem) || "BIO2".equals(bItem))
				{
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getLim());
					cell.setCellStyle(style);
				
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getRim());
					cell.setCellStyle(style);
				}
				
				if("all".equals(bItem) || "BIO3".equals(bItem))
				{
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getLtx());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getRtx());
					cell.setCellStyle(style);
				}
				
				if("all".equals(bItem) || "BIO4".equals(bItem))
				{
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getTox());
					cell.setCellStyle(style);
				}
				
				if("all".equals(bItem) || "BIO5".equals(bItem))
				{
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getEvn());
					cell.setCellStyle(style);
				}
				
				
				if("all".equals(bItem) || "VOCS".equals(bItem))
				{
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getVoc1());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getVoc2());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getVoc3());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getVoc4());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getVoc5());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getVoc6());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getVoc7());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getVoc8());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getVoc9());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getVoc10());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getVoc11());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getVoc12());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getVoc13());
					cell.setCellStyle(style);
					
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getVoc14());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getVoc15());
					cell.setCellStyle(style);
				}

				if("all".equals(bItem) || "NUTR".equals(bItem))
				{
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getTon());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getTop());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getNh4());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getNo3());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getPo4());
					cell.setCellStyle(style);
				}
				
				if("all".equals(bItem) || "CHLA".equals(bItem))
				{
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getTof());
					cell.setCellStyle(style);
				}
				
				
				if("all".equals(bItem) || "METL".equals(bItem))
				{
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getCad());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getPlu());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getCop());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getZin());
					cell.setCellStyle(style);
				}
				
				if("all".equals(bItem) || "PHEN".equals(bItem))
				{
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getPhe());
					cell.setCellStyle(style);
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getPhl());
					cell.setCellStyle(style);
				}
				
				if("all".equals(bItem) || "RAIN".equals(bItem))
				{
					//
					cell = getCell(sheet, addIdx + i, cn++);
					cell.setCellValue(vo.getRin());
					cell.setCellStyle(style);
				}
				
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
