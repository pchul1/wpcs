package daewooInfo.stats.web;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.alert.bean.AlertDataLawVo;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.service.AlertLawService;
import daewooInfo.common.code.bean.ResultVO;
import daewooInfo.common.code.bean.SearchVO;
import daewooInfo.common.code.service.CommonCodeService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.fcc.DateUtil;
import daewooInfo.stats.bean.AdActSearchVO;
import daewooInfo.stats.bean.StatsAnalysisVO;
import daewooInfo.stats.bean.StatsSearchVO;
import daewooInfo.stats.bean.StatsVO;
import daewooInfo.stats.service.StatsService;
import daewooInfo.waterpolmnt.waterinfo.bean.SearchTaksuVO;
import daewooInfo.waterpolmnt.waterinfo.service.WaterinfoService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * 상황관리 통계를 위한 컨트롤러  클래스
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *	
 *	수정일	  수정자			수정내용
 *  -------		--------	---------------------------
 *	2010.6.28  김태훈		  최초 생성
 *
 * </pre>
 */
@Controller
public class StatsController {
	/**
	 * @uml.property  name="logger"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log logger = LogFactory.getLog(StatsController.class);

	/**
	 * @uml.property  name="waterinfoService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "waterinfoService")
	private WaterinfoService waterinfoService;
	 
	/**
	 * @uml.property  name="statsService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "statsService")
	private StatsService statsService;
	
	/**
	 * @uml.property  name="commonCodeService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "commonCodeService")
	private CommonCodeService commonCodeService;
	
	/**
	 * @uml.property  name="alertLawService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertLawService")
	private AlertLawService alertLawService;
	
	/**
	 * EgovPropertyService
	 * @uml.property  name="propertiesService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
		
	/**
	 * 유역별 통계 화면을 보여준다.
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/statsSection.do")
	public String statsRiver() throws Exception{
		return "stats/statsSection";
	}  

	/**
	 * 유역별 통계 목록을 가져온다.
	 * 
	 * @param system
	 * @param factCode
	 * @param itemCode
	 * @param branchNo
	 * @param startDate
	 * @param gubun
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getSectionStatsList.do")
	public ModelAndView getSectionStatsList(
			@RequestParam("system")	String system,
			@RequestParam("factCode")	String factCode,
			@RequestParam("itemCode")	String itemCode,
			@RequestParam("branchNo")	String branchNo,
			@RequestParam("startDate")	String startDate,
			@RequestParam("gubun")		String gubun
			)
			throws Exception{

		ModelAndView modelAndView = new ModelAndView();
		
		StatsSearchVO vo = new StatsSearchVO();

		// 측정항목을 , 구분자로 잘라서 배열로 셋팅한다.
		String itemArr[] = itemCode.split(",");
		
		vo.setFactCode(factCode);
		vo.setBranchNo(branchNo);
		vo.setItemCode(itemCode);
		vo.setItemArr(itemArr);
		vo.setStartDate(startDate);
		vo.setGubun(Integer.parseInt(gubun));

		List<StatsVO> sectionStatsList = new ArrayList<StatsVO>();
		
		if(system.equals("W")) { // TMS
			sectionStatsList =  statsService.getSectionStatsTmsList(vo);
		//} else if(system.equals("A")) { // 국가수질자동측정망
		//	sectionStatsList =  statsService.getSectionStatsAutoList(vo);
		} else { // 탁수 모니터링, IP_USN, 국가수질자동측정망
			sectionStatsList =  statsService.getSectionStatsList(vo);
		}

		modelAndView.addObject("sectionStatsList", sectionStatsList);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}	

	/**
	 * 유역별 통계 차트를 가져온다.
	 * 
	 * @param system
	 * @param factCode
	 * @param factName
	 * @param branchNo
	 * @param startDate
	 * @param itemCode
	 * @param itemName
	 * @param gubun
	 * @param width
	 * @param height
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getSectionStatsChart.do")
	public ModelAndView getSectionStatsChart(
			@RequestParam(value="system", required=false) String system
			,@RequestParam(value="factCode", required=false) String factCode
			,@RequestParam(value="factName", required=false) String factName
			,@RequestParam(value="branchNo", required=false) String branchNo
			,@RequestParam(value="startDate", required=false) String startDate
			,@RequestParam(value="itemCode", required=false) String itemCode
			,@RequestParam(value="itemName", required=false) String itemName
			,@RequestParam(value="gubun", required=false) String gubun
			,@RequestParam(value="width", required=false) String width
			,@RequestParam(value="height", required=false) String height
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		StatsSearchVO vo = new StatsSearchVO();

		// 측정항목을 , 구분자로 잘라서 배열로 셋팅한다.
		String itemArr[] = itemCode.split(",");

		vo.setFactCode(factCode);
		vo.setBranchNo(branchNo);
		vo.setItemCode(itemCode);
		vo.setItemArr(itemArr);
		vo.setStartDate(startDate);
		vo.setGubun(Integer.parseInt(gubun));
		
		// 측정항목 코드를 List에 저장한다.
		List<String> itemCodeList = new ArrayList<String>();
		StringTokenizer tokens = new StringTokenizer(itemCode, ",");
		while(tokens.hasMoreTokens()) {
			itemCodeList.add(tokens.nextToken());
		}

		// 측정항목명을 List에 저장한다.
		List<String> itemNameList = new ArrayList<String>();
		tokens = new StringTokenizer(itemName, ",");
		while(tokens.hasMoreTokens()) {
			itemNameList.add(tokens.nextToken());
		}
		
		Map<String, List> dataMap = new HashMap();
		//Map<String, List> constantMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		// 측정항목 코드별로 Map에 List를 담는다.
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}
		
		//getData	
		List<StatsVO> graphDataList = new ArrayList<StatsVO>();
		
		if(system.equals("W")) { // TMS
			graphDataList =  statsService.getSectionStatsTmsList(vo);
		//} else if(system.equals("A")) { // 국가수질자동측정망
		//	graphDataList =  statsService.getSectionStatsAutoList(vo);
		} else { // 탁수모니터링, IP-USN, 국가수질자동측정망
			graphDataList =  statsService.getSectionStatsList(vo);
		}		
		
		int voCount = 0;
		// 각 측정항목별로 X축과 Y축 값을 맵에 담는다.
		for(StatsVO rvo : graphDataList) {
			List data = dataMap.get(rvo.getItemCode());
			Map valMap = new HashMap();
			valMap.put("x", rvo.getTime());
			valMap.put("y", rvo.getVlAvg());
			data.add(valMap);
			dataMap.put(rvo.getItemCode(), data);

			voCount++;
		}
		
		// 측정항목별 데이터의 갯수를 구한다.
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		// 차트 제목을 생성한다.
		StringBuffer title = new StringBuffer();
		title.append(factName).append(" 제").append(branchNo).append("측정소");

		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 1);
		modelAndView.addObject("legBox", "N");
		
		modelAndView.setViewName("chartStatsView");
		return modelAndView;
	}	

	/**
	 * 유역별 통계 엑셀을 가져온다.
	 * 
	 * @param system
	 * @param factCode
	 * @param factName
	 * @param branchNo
	 * @param startDate
	 * @param itemCode
	 * @param gubun
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getSectionStatsExcel.do")
	public ModelAndView getSectionStatsExcel(
			@RequestParam(value="system", required=false) String system
			,@RequestParam(value="factCode", required=false) String factCode
			,@RequestParam(value="factName", required=false) String factName
			,@RequestParam(value="branchNo", required=false) String branchNo
			,@RequestParam(value="startDate", required=false) String startDate
			,@RequestParam(value="itemCode", required=false) String itemCode
			,@RequestParam(value="gubun", required=false) String gubun
	) throws Exception {
		
		StatsSearchVO vo = new StatsSearchVO();
		
		// 제목을 생성한다.
		StringBuffer title = new StringBuffer();
		title.append(factName).append(" 제").append(branchNo).append("측정소");

		String itemArr[] = itemCode.split(",");

		vo.setFactCode(factCode);
		vo.setBranchNo(branchNo);
		vo.setItemCode(itemCode);
		vo.setItemArr(itemArr);
		vo.setStartDate(startDate);
		vo.setGubun(Integer.parseInt(gubun));
	 
		//각 컬럼명을 지정한다.
		String[] menu = {"수계","공구","측정소","측정항목","시간","통계","최대","최소","평균"};	
		List<StatsVO> excelDataList = new ArrayList<StatsVO>();
		
		if(system.equals("W")) { // TMS
			excelDataList =  statsService.getSectionStatsTmsList(vo);
		//} else if(system.equals("A")) { // 국가수질자동측정망
		//	excelDataList =	statsService.getSectionStatsAutoList(vo);
		} else { // 탁수모니터링, IP-USN, 국가수질자동측정망
			excelDataList =  statsService.getSectionStatsList(vo);
		}		
	 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("menu", menu);
		map.put("chart", excelDataList);
		map.put("searchDate", startDate);
		map.put("title", title.toString());
	 
		return new ModelAndView("excelStatsView", "chartMap", map);
	}	
	
	/**
	 * 항목별 통계 화면을 보여준다.
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/statsItem.do")
	public String statsItem() throws Exception{
		return "stats/statsItem";
	}	 
	
	/**
	 * 항목별 통계 목록을 가져온다.
	 * 
	 * @param system
	 * @param riverId
	 * @param itemCode
	 * @param startDate
	 * @param gubun
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getItemStatsList.do")
	public ModelAndView getItemStatsList(
			@RequestParam("system")	String system,
			@RequestParam("riverId")	String riverId,
			@RequestParam("itemCode")	String itemCode,
			@RequestParam("startDate")	String startDate,
			@RequestParam("gubun")		String gubun
			)
			throws Exception{

		ModelAndView modelAndView = new ModelAndView();
		
		StatsSearchVO vo = new StatsSearchVO();
		
		vo.setSystem(system);
		vo.setRiverId(riverId);
		vo.setItemCode(itemCode);
		vo.setStartDate(startDate);
		vo.setGubun(Integer.parseInt(gubun));

		List<StatsVO> itemStatsList = new ArrayList<StatsVO>();
		
		if(system.equals("all")) { // 전체
			itemStatsList =  statsService.getItemStatsAllList(vo);
		} else if(system.equals("W")) { // TMS
			itemStatsList =  statsService.getItemStatsTmsList(vo);
		//} else if(system.equals("A")) { // 국가수질자동측정망
		//	itemStatsList =  statsService.getItemStatsAutoList(vo);
		} else { // 탁수모니터링, IP-USN, 국가수질자동측정망
			itemStatsList =  statsService.getItemStatsList(vo);
		}			 

		modelAndView.addObject("itemStatsList", itemStatsList);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}
	
	/**
	 * 항목별 통계 차트를 가져온다.
	 * 
	 * @param system
	 * @param riverId
	 * @param riverName
	 * @param startDate
	 * @param itemCode
	 * @param itemName
	 * @param gubun
	 * @param width
	 * @param height
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getItemStatsChart.do")
	public ModelAndView getItemStatsChart(
			@RequestParam(value="system", required=false) String system
			,@RequestParam(value="riverId", required=false) String riverId
			,@RequestParam(value="riverName", required=false) String riverName
			,@RequestParam(value="startDate", required=false) String startDate
			,@RequestParam(value="itemCode", required=false) String itemCode
			,@RequestParam(value="itemName", required=false) String itemName
			,@RequestParam(value="gubun", required=false) String gubun
			,@RequestParam(value="width", required=false) String width
			,@RequestParam(value="height", required=false) String height
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		StatsSearchVO vo = new StatsSearchVO();

		vo.setSystem(system);
		vo.setRiverId(riverId);
		vo.setItemCode(itemCode);
		vo.setStartDate(startDate);
		vo.setGubun(Integer.parseInt(gubun));
		
		//getData
		List<StatsVO> graphDataList = new ArrayList<StatsVO>();
		
		if(system.equals("ALL")) { // 전체
			graphDataList =  statsService.getItemStatsAllList(vo);
		} else if(system.equals("W")) { // TMS
			graphDataList =  statsService.getItemStatsTmsList(vo);
		//} else if(system.equals("A")) { // 국가수질자동측정망
		//	graphDataList =  statsService.getItemStatsAutoList(vo);
		} else { // 탁수모니터링, IP-USN, 국가수질자동측정망
			graphDataList =  statsService.getItemStatsList(vo);
		}			
		
		// 공구와 측정소를 List에 담는다.
		List<String> itemCodeList = new ArrayList<String>();
		List<String> itemNameList = new ArrayList<String>();
		String tmpCode = "";
		for(StatsVO rvo : graphDataList) {
			if(!tmpCode.equals(rvo.getFactCode() + "-" + rvo.getBranchNo())) {
				tmpCode = rvo.getFactCode() + "-" + rvo.getBranchNo();
				itemCodeList.add(rvo.getFactCode() + "-" + rvo.getBranchNo());
				itemNameList.add(rvo.getFactName() + " " + rvo.getBranchNo());
			} 
		}
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		
		// 공구와 측정소별로 Map에 List를 담는다.
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}
		
		// 각 공구와 측정소별로 X축과 Y축 값을 맵에 담는다.
		int voCount = 0;
		for(StatsVO rvo : graphDataList) {
			List data = dataMap.get(rvo.getFactCode() + "-" + rvo.getBranchNo());
			Map valMap = new HashMap();
			valMap.put("x", rvo.getTime());
			valMap.put("y", rvo.getVlAvg());
			data.add(valMap);
			dataMap.put(rvo.getFactCode() + "-" + rvo.getBranchNo(), data);

			voCount++;
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append(riverName).append(" (").append(itemName).append(")");

		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 2);
		modelAndView.addObject("legBox", "Y");
		
		modelAndView.setViewName("chartStatsView");
		return modelAndView;
	}	

	/**
	 * 항목별 통계 엑셀을 가져온다.
	 * 
	 * @param system
	 * @param riverId
	 * @param riverName
	 * @param startDate
	 * @param itemCode
	 * @param itemName
	 * @param gubun
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getItemStatsExcel.do")
	public ModelAndView getItemStatsExcel(			
			@RequestParam(value="system", required=false) String system
			,@RequestParam(value="riverId", required=false) String riverId
			,@RequestParam(value="riverName", required=false) String riverName
			,@RequestParam(value="startDate", required=false) String startDate
			,@RequestParam(value="itemCode", required=false) String itemCode
			,@RequestParam(value="itemName", required=false) String itemName
			,@RequestParam(value="gubun", required=false) String gubun
	) throws Exception {
		
		StatsSearchVO vo = new StatsSearchVO();
		
		StringBuffer title = new StringBuffer();
		title.append(riverName).append(" (").append(itemName).append(")");

		vo.setSystem(system);
		vo.setRiverId(riverId);
		vo.setItemCode(itemCode);
		vo.setStartDate(startDate);
		vo.setGubun(Integer.parseInt(gubun));
	 
		//getData
		String[] menu = {"수계","공구","측정소","측정항목","시간","통계","최대","최소","평균"};
		List<StatsVO> excelDataList = new ArrayList<StatsVO>();
		
		if(system.equals("ALL")) {
			excelDataList =  statsService.getItemStatsAllList(vo);
		} else if(system.equals("W")) {
			excelDataList =  statsService.getItemStatsTmsList(vo);
		//} else if(system.equals("A")) {
		//	excelDataList =  statsService.getItemStatsAutoList(vo);
		} else {
			excelDataList =  statsService.getItemStatsList(vo);
		}		
	 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("menu", menu);
		map.put("chart", excelDataList);
		map.put("searchDate", startDate);
		map.put("title", title.toString());
	
		return new ModelAndView("excelStatsView", "chartMap", map);
	}		
	
	/**
	 * 사고발생 통계를 보여준다.
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/statsAccident.do")
	public String statsAccident() throws Exception{
		return "stats/statsAccident";
	}
	
	/**
	 * 사고발생 통계 목록을 가져온다.
	 * 
	 * @param riverId
	 * @param factCode
	 * @param itemCode
	 * @param branchNo
	 * @param startDate
	 * @param gubun
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getAccidentStatsList.do")
	public ModelAndView getAccidentStatsList(
			@RequestParam("riverId")	String riverId,
			@RequestParam("factCode")	String factCode,
			@RequestParam("itemCode")	String itemCode,
			@RequestParam("branchNo")	String branchNo,
			@RequestParam("startDate")	String startDate,
			@RequestParam("gubun")		String gubun
			)
			throws Exception{

		ModelAndView modelAndView = new ModelAndView();
		
		StatsSearchVO vo = new StatsSearchVO();
		
		vo.setRiverId(riverId);
		vo.setFactCode(factCode);
		vo.setBranchNo(branchNo);
		vo.setItemCode(itemCode);
		vo.setStartDate(startDate);
		vo.setGubun(Integer.parseInt(gubun));

		List<StatsVO> accidentStatsList =  statsService.getAccidentStatsList(vo);

		modelAndView.addObject("accidentStatsList", accidentStatsList);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}			
	
	/**
	 * 사고발생 통계 차트를 가져온다.
	 * 
	 * @param riverId
	 * @param riverName
	 * @param factCode
	 * @param factName
	 * @param branchNo
	 * @param startDate
	 * @param itemCode
	 * @param itemName
	 * @param gubun
	 * @param width
	 * @param height
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getAccidentStatsChart.do")
	public ModelAndView getAccidentStatsChart(
			@RequestParam(value="riverId", required=false) String riverId
			,@RequestParam(value="riverName", required=false) String riverName
			,@RequestParam(value="factCode", required=false) String factCode
			,@RequestParam(value="factName", required=false) String factName
			,@RequestParam(value="branchNo", required=false) String branchNo
			,@RequestParam(value="startDate", required=false) String startDate
			,@RequestParam(value="itemCode", required=false) String itemCode
			,@RequestParam(value="itemName", required=false) String itemName
			,@RequestParam(value="gubun", required=false) String gubun
			,@RequestParam(value="width", required=false) String width
			,@RequestParam(value="height", required=false) String height
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		StatsSearchVO vo = new StatsSearchVO();

		vo.setRiverId(riverId);
		vo.setFactCode(factCode);
		vo.setBranchNo(branchNo);
		vo.setItemCode(itemCode);
		vo.setStartDate(startDate);
		vo.setGubun(Integer.parseInt(gubun));
		
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("val1");
		itemCodeList.add("val2");
		itemCodeList.add("val3");

		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("관심");
		itemNameList.add("주의");
		itemNameList.add("경계");
		
		Map<String, List> dataMap = new HashMap();
		//Map<String, List> constantMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}
		
		//getData
		List<StatsVO> graphDataList = statsService.getAccidentStatsList(vo);
		
		int voCount = 0;
		for(StatsVO rvo : graphDataList) {
			List data = dataMap.get("val1");
			Map valMap = new HashMap();
			valMap.put("x", rvo.getTime());
			valMap.put("y", rvo.getVal1());
			data.add(valMap);
			dataMap.put("val1", data);
			
			voCount++;
			
			data = dataMap.get("val2");
			valMap = new HashMap();
			valMap.put("x", rvo.getTime());
			valMap.put("y", rvo.getVal2());
			data.add(valMap);
			dataMap.put("val2", data);
			
			voCount++;
			
			data = dataMap.get("val3");
			valMap = new HashMap();
			valMap.put("x", rvo.getTime());
			valMap.put("y", rvo.getVal3());
			data.add(valMap);
			dataMap.put("val3", data);			

			voCount++;
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append(factName).append(" 제").append(branchNo).append("측정소");

		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 1);		
		modelAndView.addObject("legBox", "N");
		
		modelAndView.setViewName("chartStatsView");
		return modelAndView;
	}	

	/**
	 * 사고발생 통계 엑셀을 가져온다.
	 * 
	 * @param riverId
	 * @param riverName
	 * @param factCode
	 * @param factName
	 * @param branchNo
	 * @param startDate
	 * @param itemCode
	 * @param itemName
	 * @param gubun
	 * @param width
	 * @param height
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getAccidentStatsExcel.do")
	public ModelAndView getAccidentStatsExcel(
			@RequestParam(value="riverId", required=false) String riverId
			,@RequestParam(value="riverName", required=false) String riverName
			,@RequestParam(value="factCode", required=false) String factCode
			,@RequestParam(value="factName", required=false) String factName
			,@RequestParam(value="branchNo", required=false) String branchNo
			,@RequestParam(value="startDate", required=false) String startDate
			,@RequestParam(value="itemCode", required=false) String itemCode
			,@RequestParam(value="itemName", required=false) String itemName
			,@RequestParam(value="gubun", required=false) String gubun
			,@RequestParam(value="width", required=false) String width
			,@RequestParam(value="height", required=false) String height	
	) throws Exception {
		
		StatsSearchVO vo = new StatsSearchVO();
		
		StringBuffer title = new StringBuffer();
		title.append(factName).append(" 제").append(branchNo).append("측정소");		

		vo.setRiverId(riverId);
		vo.setFactCode(factCode);
		vo.setBranchNo(branchNo);
		vo.setItemCode(itemCode);
		vo.setStartDate(startDate);
		vo.setGubun(Integer.parseInt(gubun));
	 
		//getData
		String[] menu = {"수계","공구","측정소","측정항목","시간","사고발생","관심","주의","경계"};
		List<StatsVO> excelDataList = statsService.getAccidentStatsList(vo);
	 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("menu", menu);
		map.put("chart", excelDataList);
		map.put("searchDate", startDate);
		map.put("title", title.toString());
	 
		return new ModelAndView("excelStatsView", "chartMap", map);
	}	
	
	/**
	 * 방제조치 통계를 보여준다.
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/statsPrevent.do")
	public String statsPrevent() throws Exception{
		return "stats/statsPrevent";
	}	
	
	/**
	 * 방제조치 통계 목록을 가져온다.
	 * 
	 * @param system
	 * @param startDate
	 * @param endDate
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getPreventStatsList.do")
	public ModelAndView getPreventStatsList(
			@RequestParam(value="system",required=true)	String system,
			@RequestParam(value="startDate", required=false)	String startDate,
			@RequestParam(value="endDate", required=false)		String endDate )
			throws Exception{

		ModelAndView modelAndView = new ModelAndView();
		
		StatsSearchVO vo = new StatsSearchVO();

		vo.setSystem(system);
		vo.setStartDate(startDate);
		vo.setEndDate(endDate);

		List<StatsVO> preventStatsList =  statsService.getPreventStatsList(vo);

		modelAndView.addObject("preventStatsList", preventStatsList);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}			
	
	/**
	 * 방제조치 통계 차트를 가져온다.
	 * 
	 * @param riverId
	 * @param riverName
	 * @param factCode
	 * @param factName
	 * @param branchNo
	 * @param startDate
	 * @param itemCode
	 * @param itemName
	 * @param gubun
	 * @param width
	 * @param height
	 * @param codeGbn
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getPreventStatsChart.do")
	public ModelAndView getPreventStatsChart(
			@RequestParam(value="riverId", required=false) String riverId
			,@RequestParam(value="riverName", required=false) String riverName
			,@RequestParam(value="factCode", required=false) String factCode
			,@RequestParam(value="factName", required=false) String factName
			,@RequestParam(value="branchNo", required=false) String branchNo
			,@RequestParam(value="startDate", required=false) String startDate
			,@RequestParam(value="itemCode", required=false) String itemCode
			,@RequestParam(value="itemName", required=false) String itemName
			,@RequestParam(value="gubun", required=false) String gubun
			,@RequestParam(value="width", required=false) String width
			,@RequestParam(value="height", required=false) String height			
			,@RequestParam(value="codeGbn", required=false) String codeGbn
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		StatsSearchVO vo = new StatsSearchVO();

		vo.setRiverId(riverId);
		vo.setFactCode(factCode);
		vo.setBranchNo(branchNo);
		vo.setItemCode(itemCode);
		vo.setStartDate(startDate);
		vo.setGubun(Integer.parseInt(gubun));
				
		SearchVO srchVO = new SearchVO();
		srchVO.setCodeGbn(codeGbn);		
		List<ResultVO> resultList = (List<ResultVO>)commonCodeService.getCode(srchVO);		
		
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("val1");
		itemCodeList.add("val2");
		itemCodeList.add("val3");
		itemCodeList.add("val4");

		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		for(int i=0; i<4; i++) {
			ResultVO rVo = resultList.get(i);
			itemNameList.add(rVo.getCAPTION());
		}
		
		Map<String, List> dataMap = new HashMap();
		//Map<String, List> constantMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}
		
		//getData
		List<StatsVO> graphDataList = statsService.getPreventStatsList(vo);
		
		int voCount = 0;
		for(StatsVO rvo : graphDataList) {
			List data = dataMap.get("val1");
			Map valMap = new HashMap();
			valMap.put("x", rvo.getTime());
			valMap.put("y", rvo.getVal1());
			data.add(valMap);
			dataMap.put("val1", data);
			
			voCount++;
			
			data = dataMap.get("val2");
			valMap = new HashMap();
			valMap.put("x", rvo.getTime());
			valMap.put("y", rvo.getVal2());
			data.add(valMap);
			dataMap.put("val2", data);
			
			voCount++;
			
			data = dataMap.get("val3");
			valMap = new HashMap();
			valMap.put("x", rvo.getTime());
			valMap.put("y", rvo.getVal3());
			data.add(valMap);
			dataMap.put("val3", data);

			voCount++;
			
			data = dataMap.get("val4");
			valMap = new HashMap();
			valMap.put("x", rvo.getTime());
			valMap.put("y", rvo.getVal4());
			data.add(valMap);
			dataMap.put("val4", data);

			voCount++;
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append(factName).append(" 제").append(branchNo).append("측정소");

		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 1);		
		modelAndView.addObject("legBox", "N");
		
		modelAndView.setViewName("chartStatsView");
		return modelAndView;
	}	

	/**
	 * 방제조치 통계 엑셀을 가져온다.
	 * 
	 * @param riverId
	 * @param riverName
	 * @param factCode
	 * @param factName
	 * @param branchNo
	 * @param startDate
	 * @param itemCode
	 * @param itemName
	 * @param gubun
	 * @param width
	 * @param height
	 * @param codeGbn
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getPreventStatsExcel.do")
	public ModelAndView getPreventStatsExcel(
			@RequestParam(value="riverId", required=false) String riverId
			,@RequestParam(value="riverName", required=false) String riverName
			,@RequestParam(value="factCode", required=false) String factCode
			,@RequestParam(value="factName", required=false) String factName
			,@RequestParam(value="branchNo", required=false) String branchNo
			,@RequestParam(value="startDate", required=false) String startDate
			,@RequestParam(value="itemCode", required=false) String itemCode
			,@RequestParam(value="itemName", required=false) String itemName
			,@RequestParam(value="gubun", required=false) String gubun
			,@RequestParam(value="width", required=false) String width
			,@RequestParam(value="height", required=false) String height
			,@RequestParam(value="codeGbn", required=false) String codeGbn
	) throws Exception {
		
		StatsSearchVO vo = new StatsSearchVO();
		
		StringBuffer title = new StringBuffer();
		title.append(factName).append(" 제").append(branchNo).append("측정소");

		vo.setRiverId(riverId);
		vo.setFactCode(factCode);
		vo.setBranchNo(branchNo);
		vo.setItemCode(itemCode);
		vo.setStartDate(startDate);
		vo.setGubun(Integer.parseInt(gubun));
		
		SearchVO srchVO = new SearchVO();
		srchVO.setCodeGbn(codeGbn);
		List<ResultVO> resultList = (List<ResultVO>)commonCodeService.getCode(srchVO);
		
		String[] menu = {"수계","공구","측정소","측정항목","시간","방제조치","","","",""};
		for(int i=0; i<4; i++) {
			ResultVO rVo = resultList.get(i);
			menu[6+i] = rVo.getCAPTION();
		}
		List<StatsVO> excelDataList = statsService.getPreventStatsList(vo);
	
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("menu", menu);
		map.put("chart", excelDataList);
		map.put("searchDate", startDate);
		map.put("title", title.toString());
	
		return new ModelAndView("excelStatsPreventView", "chartMap", map);
	}
	
	/**
	 * 수질항목별관계분석 화면을 보여준다.
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/statsItemAnalysis.do")
	public String statsItemAnalysis() throws Exception{
		return "stats/statsItemAnalysis";
	}
	
	/**
	 * 상관관계분석 목록을 가져온다.
	 * 
	 * @param system
	 * @param factCode
	 * @param itemCodeX
	 * @param itemCodeY
	 * @param branchNo
	 * @param startDate
	 * @param endDate
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getItemAnalysisStatsList.do")
	public ModelAndView getItemAnalysisStatsList(
			@RequestParam("system")	String system,
			@RequestParam("factCodeX")	String factCodeX,
			@RequestParam("branchNoX")	String branchNoX,
			@RequestParam("itemCodeX")	String itemCodeX,
			@RequestParam("factCodeY")	String factCodeY,
			@RequestParam("branchNoY")	String branchNoY,
			@RequestParam("itemCodeY")	String itemCodeY,
			@RequestParam("startDate")	String startDate,
			@RequestParam("endDate")	String endDate
			)
			throws Exception{

		ModelAndView modelAndView = new ModelAndView();
		
		StatsSearchVO vo = new StatsSearchVO();
		
		vo.setFactCodeX(factCodeX);
		vo.setBranchNoX(branchNoX);
		vo.setItemCodeX(itemCodeX);
		vo.setFactCodeY(factCodeY);
		vo.setBranchNoY(branchNoY);
		vo.setItemCodeY(itemCodeY);
		vo.setStartDate(startDate);
		vo.setEndDate(endDate);
		vo.setSort("list");

		List<StatsAnalysisVO> itemAnalysisStatsList = new ArrayList<StatsAnalysisVO>();
		
		if(system.equals("W")) {
			itemAnalysisStatsList =  statsService.getItemAnalysisStatsTmsList(vo);
		//} else if(system.equals("A")) {
		//	itemAnalysisStatsList =  statsService.getItemAnalysisStatsAutoList(vo);
		} else {
			itemAnalysisStatsList =  statsService.getItemAnalysisStatsList(vo);
		}
		
		String coefCorr = getCoefCorr1(itemAnalysisStatsList);

		modelAndView.addObject("itemAnalysisStatsList", itemAnalysisStatsList);
		modelAndView.addObject("coefCorr", coefCorr);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}

	/**
	 * 상관관계분석 차트를 가져온다.
	 * 
	 * @param system
	 * @param factCode
	 * @param factName
	 * @param branchNo
	 * @param startDate
	 * @param endDate
	 * @param itemCodeX
	 * @param itemCodeY
	 * @param itemNameX
	 * @param itemNameY
	 * @param width
	 * @param height
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getItemAnalysisStatsChart.do")
	public ModelAndView getItemAnalysisStatsChart(
			@RequestParam(value="system", required=false) String system
			,@RequestParam(value="factCodeX", required=false) String factCodeX
			,@RequestParam(value="factNameX", required=false) String factNameX
			,@RequestParam(value="branchNoX", required=false) String branchNoX
			,@RequestParam(value="factCodeY", required=false) String factCodeY
			,@RequestParam(value="factNameY", required=false) String factNameY
			,@RequestParam(value="branchNoY", required=false) String branchNoY
			,@RequestParam(value="startDate", required=false) String startDate
			,@RequestParam(value="endDate", required=false) String endDate
			,@RequestParam(value="itemCodeX", required=false) String itemCodeX
			,@RequestParam(value="itemCodeY", required=false) String itemCodeY
			,@RequestParam(value="itemNameX", required=false) String itemNameX
			,@RequestParam(value="itemNameY", required=false) String itemNameY
			,@RequestParam(value="width", required=false) String width
			,@RequestParam(value="height", required=false) String height
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		StatsSearchVO vo = new StatsSearchVO();

		vo.setSystem(system);
		vo.setFactCodeX(factCodeX);
		vo.setBranchNoX(branchNoX);
		vo.setItemCodeX(itemCodeX);
		vo.setFactCodeY(factCodeY);
		vo.setBranchNoY(branchNoY);
		vo.setItemCodeY(itemCodeY);
		vo.setStartDate(startDate);
		vo.setEndDate(endDate);
		vo.setSort("chart");
		
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("chart");

		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("chart");
		
		Map<String, List> dataMap = new HashMap();
		//Map<String, List> constantMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}
		
		//getData
		List<StatsAnalysisVO> graphDataList = new ArrayList<StatsAnalysisVO>();
		
		if(system.equals("W")) {
			graphDataList =  statsService.getItemAnalysisStatsTmsList(vo);
		//} else if(system.equals("A")) {
		//	graphDataList =  statsService.getItemAnalysisStatsAutoList(vo);
		} else {
			graphDataList =  statsService.getItemAnalysisStatsList(vo);
		}
		
		int voCount = 0;
		for(StatsAnalysisVO rvo : graphDataList) {
			List data = dataMap.get("chart");
			Map valMap = new HashMap();
			valMap.put("x", rvo.getItemXVl());
			valMap.put("y", rvo.getItemYVl());
			data.add(valMap);
			dataMap.put("chart", data);

			voCount++;
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append("");

		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 3);
		modelAndView.addObject("legBox", "N");
		modelAndView.addObject("axisTitleYn", "Y");
		modelAndView.addObject("axisXTitle", itemCodeX);
		modelAndView.addObject("axisYTitle", itemCodeY);
		
		modelAndView.setViewName("chartStatisticsView");
		return modelAndView;
	}	

	/**
	 * 수질유량관계분석 화면을 보여준다.
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/statsItemFlowAnalysis.do")
	public String statsItemFlowAnalysis() throws Exception{
		return "stats/statsItemFlowAnalysis";
	}		 
	
	/**
	 * 상관계수값을 구한다.
	 * 
	 * @param itemAnalysisStatsList
	 * @return
	 */
	public String getCoefCorr1(List<StatsAnalysisVO> itemAnalysisStatsList) {
	
		int cnt = itemAnalysisStatsList.size();
		double xSum = 0;
		double ySum = 0;
		double xAvg = 0;
		double yAvg = 0;
		double xStanDevi = 0;
		double yStanDevi = 0;
		
		double stanDevi = 0;
		
		double[] xArr = new double[cnt];
		double[] yArr = new double[cnt];

		int i=0;
		
		for(StatsAnalysisVO vo : itemAnalysisStatsList) {
			xSum = xSum + Double.parseDouble(vo.getItemXVl());
			ySum = ySum + Double.parseDouble(vo.getItemYVl());
			xArr[i] = Double.parseDouble(vo.getItemXVl());
			yArr[i] = Double.parseDouble(vo.getItemYVl());
			i++;
		}
		
		// 평균 구하기
		xAvg = xSum / cnt;
		yAvg = ySum / cnt;

		for(int j=0; j<xArr.length; j++) {
			xStanDevi = xStanDevi + ((xArr[j] - xAvg ) * ( xArr[j] - xAvg ));
			yStanDevi = yStanDevi + (( yArr[j] - yAvg ) * ( yArr[j] - yAvg ));

			stanDevi = stanDevi + (xArr[j] - xAvg) * (yArr[j] - yAvg);
		}
		
		DecimalFormat fmt = new DecimalFormat ("0.00");
		
		return fmt.format(stanDevi / (Math.sqrt(xStanDevi) * Math.sqrt(yStanDevi)));
		
	}
	
	
	
	
	/**
	 * 상관계수값을 구한다.
	 * 
	 * @param itemAnalysisStatsList
	 * @return
	 */
	public String getCoefCorr(double[] x, double[] y) {
	
	
		List<Double> calX = new ArrayList<Double>();
		List<Double> calY = new ArrayList<Double>();

		for(int i = 0 ; i < x.length ; i++)
		{
			//양쪽 데이터중에 0이 있으면 계산에서 제외시킴
			if(x[i] != 0 & y[i] != 0)
			{
				calX.add(x[i]);
				calY.add(y[i]);
			}
		}
		
		
		//int cnt = itemAnalysisStatsList.size();
		
		double xSum = 0;
		double ySum = 0;
		double xAvg = 0;
		double yAvg = 0;
		double xStanDevi = 0;
		double yStanDevi = 0;
		
		double stanDevi = 0;
		
		int i=0;
		
		// 평균 구하기
		for(int idx = 0 ; idx < calX.size(); idx++)
		{
			xSum = xSum + calX.get(idx);
			ySum = ySum + calY.get(idx);
		}
		
		xAvg = xSum / calX.size();
		yAvg = ySum / calY.size();
		
		for(int j=0; j<calX.size(); j++) {
			xStanDevi = xStanDevi + ((calX.get(j) - xAvg ) * ( calX.get(j) - xAvg ));
			yStanDevi = yStanDevi + ((calY.get(j) - yAvg ) * ( calY.get(j) - yAvg ));

			stanDevi = stanDevi + (calX.get(j) - xAvg) * (calY.get(j) - yAvg);
		}

		DecimalFormat fmt = new DecimalFormat ("0.00");
		
		Double dResult = stanDevi / (Math.sqrt(xStanDevi * yStanDevi));
		String result = dResult.isNaN() ? "-" : fmt.format(dResult);
		
		if("-0.00".equals(result))
			result = "0.00";
		
		return result;
	}
	
	
	private String[] itemArray = new String[41];
	private String[] itemCode = new String[41];
	private String[] itemEName = new String[41];
	private String[] itemArray2 = new String[2];
	private String[] itemCode2 = new String[2];
	private String[] itemEName2 = new String[2];
	
	private int upperX = 0;
	private int upperY = 0;
	private int lowerX = 0;
	private int lowerY = 0;
	
	private void setItemArray(String sys)
	{
		itemArray2[0] = "수위"; itemCode2[0] = "WLV00"; itemEName2[0] = "wlv";
		itemArray2[1] = "유량"; itemCode2[1] = "FLW00"; itemEName2[1] = "flw";
		
		if("A".equals(sys))
		{
			 itemArray[0] = "탁도";					itemCode[0] = "TUR00";			itemEName[0] = "tur";
			 itemArray[1] = "pH";					itemCode[1] = "PHY00";			itemEName[1] = "phy";
			 itemArray[2] = "DO";					itemCode[2] = "DOW00";			itemEName[2] = "dow";
			 itemArray[3] = "EC";					itemCode[3] = "CON00";			itemEName[3] = "con";
			 itemArray[4] = "수온";					itemCode[4] = "TMP00";			itemEName[4] = "tmp";
			 itemArray[5] = "총유기탄소";				itemCode[5] = "TOC00";			itemEName[5] = "toc";
			 itemArray[6] = "임펄스";					itemCode[6] = "IMP00";			itemEName[6] = "imp";
			 itemArray[7] = "임펄스(좌)";				itemCode[7] = "LIM00";			itemEName[7] = "lim";
			 itemArray[8] = "임펄스(우)";				itemCode[8] = "RIM00";			itemEName[8] = "rim";
			 itemArray[9] = "독성지수(좌)";				itemCode[9] = "LTX00";			itemEName[9] = "ltx";
			 itemArray[10] = "독성지수(우)";			itemCode[10] = "RTX00";			itemEName[10] = "rtx";
			 itemArray[11] = "미생물독성지수";			itemCode[11] = "TOX00";			itemEName[11] = "tox";
			 itemArray[12] = "조류독성지수";				itemCode[12] = "EVN00";			itemEName[12] = "evn";
			 itemArray[13] = "염화메틸렌";				itemCode[13] = "VOC01";			itemEName[13] = "voc1";
			 itemArray[14] = "1.1.1-트리클로로에테인";	itemCode[14] = "VOC02";			itemEName[14] = "voc2";
			 itemArray[15] = "벤젠";					itemCode[15] = "VOC03";			itemEName[15] = "voc3";
			 itemArray[16] = "사염화탄소";				itemCode[16] = "VOC04";			itemEName[16] = "voc4";
			 itemArray[17] = "트리클로로에틸렌";			itemCode[17] = "VOC05";			itemEName[17] = "voc5";
			 itemArray[18] = "톨루엔";					itemCode[18] = "VOC06";			itemEName[18] = "voc6";
			 itemArray[19] = "테트라클로로에티렌";			itemCode[19] = "VOC07";			itemEName[19] = "voc7";
			 itemArray[20] = "에틸벤젠";				itemCode[20] = "VOC08";			itemEName[20] = "voc8";
			 itemArray[21] = "m,p-자일렌";				itemCode[21] = "VOC09";			itemEName[21] = "voc9";
			 itemArray[22] = "o-자일렌";				itemCode[22] = "VOC10";			itemEName[22] = "voc10";
			 itemArray[23] = "[ECD]염화메틸렌";			itemCode[23] = "VOC11";			itemEName[23] = "voc11";
			 itemArray[24] = "[ECD]1.1.1-트리클로로에테인";	itemCode[24] = "VOC12";		itemEName[24] = "voc12";
			 itemArray[25] = "[ECD]사염화탄소";			itemCode[25] = "VOC13";			itemEName[25] = "voc13";
			 itemArray[26] = "[ECD]트리클로로에틸렌";		itemCode[26] = "VOC14";			itemEName[26] = "voc14";
			 itemArray[27] = "[ECD]테트라클로로에티렌";	itemCode[27] = "VOC15";			itemEName[27] = "voc15";
			 itemArray[28] = "총질소";					itemCode[28] = "TON00";			itemEName[28] = "ton";
			 itemArray[29] = "총인";					itemCode[29] = "TOP00";			itemEName[29] = "top";
			 itemArray[30] = "암모니아성질소";			itemCode[30] = "NH400";			itemEName[30] = "nh4";
			 itemArray[31] = "질산성질소";				itemCode[31] = "NO300";			itemEName[31] = "no3";
			 itemArray[32] = "인산염인";				itemCode[32] = "PO400";			itemEName[32] = "po4";
			 itemArray[33] = "Chl-a";				itemCode[33] = "TOF00";			itemEName[33] = "tof";
			 itemArray[34] = "카드뮴";					itemCode[34] = "CAD00";			itemEName[34] = "cad";
			 itemArray[35] = "납";					itemCode[35] = "PLU00";			itemEName[35] = "plu";
			 itemArray[36] = "구리";					itemCode[36] = "COP00";			itemEName[36] = "cop";
			 itemArray[37] = "아연";					itemCode[37] = "ZIN00";			itemEName[37] = "zin";
			 itemArray[38] = "페놀1";					itemCode[38] = "PHE00";			itemEName[38] = "phe";
			 itemArray[39] = "페놀2";					itemCode[39] = "PHL00";			itemEName[39] = "phl";
			 itemArray[40] = "강수량";					itemCode[40] = "RIN00";			itemEName[40] = "rin";
		}
		if("U".equals(sys))
		{
			 itemArray[0] = "탁도";				itemCode[0] = "TUR00";  itemEName[0] = "tur";
			 itemArray[1] = "수온";				itemCode[1] = "TMP00";  itemEName[1] = "tmp";
			 itemArray[2] = "pH";				itemCode[2] = "PHY00";  itemEName[2] = "phy";
			 itemArray[3] = "DO";				itemCode[3] = "DOW00"; itemEName[3] = "dow";
			 itemArray[4] = "전기전도도";			itemCode[4] = "CON00"; itemEName[4] = "con";
			 itemArray[5] = "Chl-a(μg/L)";		itemCode[5] = "TOF00"; itemEName[5] = "tof";
		}
		else
		{
			 itemArray[0] = "탁도";		itemCode[0] = "TUR00";
			 itemArray[1] = "수온";		itemCode[1] = "TMP00";
			 itemArray[2] = "pH";		itemCode[2] = "PHY00";
			 itemArray[3] = "DO";		itemCode[3] = "DOW00";
			 itemArray[4] = "전기전도도";	itemCode[4] = "CON00";
		}
	}
	
	private void setItemBound(String bItemX, String bItemY)
	{
		try
		{
			if(bItemX.equals("COM1"))
			{
				lowerX = 0;
				upperX = 4;
			}
			else if(bItemX.equals("ORGA"))
			{
				lowerX = 5;
				upperX = 5;
			}
			else if(bItemX.equals("BIO1"))
			{
				lowerX = 6;
				upperX = 6;
			}
			else if(bItemX.equals("BIO2"))
			{
				lowerX = 7;
				upperX = 8;
			}
			else if(bItemX.equals("BIO3"))
			{
				lowerX = 9;
				upperX = 10;
			}
			else if(bItemX.equals("BIO4"))
			{
				lowerX = 11;
				upperX = 11;
			}
			else if(bItemX.equals("BIO5"))
			{
				lowerX = 12;
				upperX = 12;
			}
			else if(bItemX.equals("VOCS"))
			{
				lowerX = 13;
				upperX = 27;
			}
			else if(bItemX.equals("NUTR"))
			{
				lowerX = 28;
				upperX = 32;
			}
			else if(bItemX.equals("CHLA"))
			{
				lowerX = 33;
				upperX = 33;
			}
			else if(bItemX.equals("METL"))
			{
				lowerX = 34;
				upperX = 37;
			}
			else if(bItemX.equals("PHEN"))
			{
				lowerX = 38;
				upperX = 39;
			}
			else if(bItemX.equals("RAIN"))
			{
				lowerX = 40;
				upperX = 40;
			}
		}
		catch(Exception ex)
		{
			lowerX = 0;
			upperX = 4;
		}
		
		try
		{
			//Y항목
			if(bItemY.equals("COM1"))
			{
				lowerY = 0;
				upperY = 4;
			}
			else if(bItemY.equals("ORGA"))
			{
				lowerY = 5;
				upperY = 5;
			}
			else if(bItemY.equals("BIO1"))
			{
				lowerY = 6;
				upperY = 6;
			}
			else if(bItemY.equals("BIO2"))
			{
				lowerY = 7;
				upperY = 8;
			}
			else if(bItemY.equals("BIO3"))
			{
				lowerY = 9;
				upperY = 10;
			}
			else if(bItemY.equals("BIO4"))
			{
				lowerY = 11;
				upperY = 11;
			}
			else if(bItemY.equals("BIO5"))
			{
				lowerY = 12;
				upperY = 12;
			}
			else if(bItemY.equals("VOCS"))
			{
				lowerY = 13;
				upperY = 27;
			}
			else if(bItemY.equals("NUTR"))
			{
				lowerY = 28;
				upperY = 32;
			}
			else if(bItemY.equals("CHLA"))
			{
				lowerY = 33;
				upperY = 33;
			}
			else if(bItemY.equals("METL"))
			{
				lowerY = 34;
				upperY = 37;
			}
			else if(bItemY.equals("PHEN"))
			{
				lowerY = 38;
				upperY = 39;
			}
			else if(bItemY.equals("RAIN"))
			{
				lowerY = 40;
				upperY = 40;
			}
		}
		catch(Exception ex)
		{
			lowerY = 0;
			upperY = 0;
		}
	}
	
	/**
	 * 상관계수값을 구한다.
	 * 
	 * @param itemAnalysisStatsList
	 * @return
	 */
	public Map<String, String> getCoefCorr(List<StatsVO> itemAnalysisStatsList) {
		
		Map<String, String> result = new HashMap<String,String>();
		
		int cnt = itemAnalysisStatsList.size();
		
		double[] xTurArr = new double[cnt];
		double[] xTmpArr = new double[cnt];
		double[] xPhyArr = new double[cnt];
		double[] xDowArr = new double[cnt];
		double[] xConArr = new double[cnt];
		
		double[] yTurArr = new double[cnt];
		double[] yTmpArr = new double[cnt];
		double[] yPhyArr = new double[cnt];
		double[] yDowArr = new double[cnt];
		double[] yConArr = new double[cnt];
		
		int i=0;
		
		
		for(StatsVO vo : itemAnalysisStatsList) {
			
			xTurArr[i] = Double.parseDouble(vo.getTurXVl().replaceAll(",", ""));
			xTmpArr[i] = Double.parseDouble(vo.getTmpXVl().replaceAll(",", ""));
			xPhyArr[i] = Double.parseDouble(vo.getPhyXVl().replaceAll(",", ""));
			xDowArr[i] = Double.parseDouble(vo.getDowXVl().replaceAll(",", ""));
			xConArr[i] = Double.parseDouble(vo.getConXVl().replaceAll(",", ""));
			
			yTurArr[i] = Double.parseDouble(vo.getTurYVl().replaceAll(",", ""));
			yTmpArr[i] = Double.parseDouble(vo.getTmpYVl().replaceAll(",", ""));
			yPhyArr[i] = Double.parseDouble(vo.getPhyYVl().replaceAll(",", ""));
			yDowArr[i] = Double.parseDouble(vo.getDowYVl().replaceAll(",", ""));
			yConArr[i] = Double.parseDouble(vo.getConYVl().replaceAll(",", ""));
			
			i++;
		}
		
		result.put("turtur", getCoefCorr(xTurArr, yTurArr));
		result.put("turtmp", getCoefCorr(xTurArr, yTmpArr));
		result.put("turphy", getCoefCorr(xTurArr, yPhyArr));
		result.put("turdow", getCoefCorr(xTurArr, yDowArr));
		result.put("turcon",  getCoefCorr(xTurArr, yConArr));
		
		result.put("tmptur",  getCoefCorr(xTmpArr, yTurArr));
		result.put("tmptmp",  getCoefCorr(xTmpArr, yTmpArr));
		result.put("tmpphy",  getCoefCorr(xTmpArr, yPhyArr));
		result.put("tmpdow",  getCoefCorr(xTmpArr, yDowArr));
		result.put("tmpcon",  getCoefCorr(xTmpArr, yConArr));
		
		result.put("phytur",  getCoefCorr(xPhyArr, yTurArr));
		result.put("phytmp",  getCoefCorr(xPhyArr, yTmpArr));
		result.put("phyphy",  getCoefCorr(xPhyArr, yPhyArr));
		result.put("phydow",  getCoefCorr(xPhyArr, yDowArr));
		result.put("phycon",  getCoefCorr(xPhyArr, yConArr));
		
		result.put("dowtur",  getCoefCorr(xDowArr, yTurArr));
		result.put("dowtmp",  getCoefCorr(xDowArr, yTmpArr));
		result.put("dowphy",  getCoefCorr(xDowArr, yPhyArr));
		result.put("dowdow",  getCoefCorr(xDowArr, yDowArr));
		result.put("dowcon",  getCoefCorr(xDowArr, yConArr));
		
		result.put("contur",  getCoefCorr(xConArr, yTurArr));
		result.put("contmp",  getCoefCorr(xConArr, yTmpArr));
		result.put("conphy",  getCoefCorr(xConArr, yPhyArr));
		result.put("condow",  getCoefCorr(xConArr, yDowArr));
		result.put("concon",  getCoefCorr(xConArr, yConArr));
		
		return result;
	}
	
	
	/**
	 * 상관계수값을 구한다.
	 * 
	 * @param itemAnalysisStatsList
	 * @return
	 */
	public Map<String, String> getCoefCorr2(StatsVO statsVO) throws Exception{
		
		Map<String, String> result = new HashMap<String,String>();
		
		for(int yIdx = lowerY;yIdx <= upperY;yIdx++)
		{
			for(int xIdx = lowerX;xIdx <= upperX; xIdx++)
			{
				statsVO.setItemCodeX(itemCode[xIdx]);
				statsVO.setItemCodeY(itemCode[yIdx]);
				List<StatsVO> list = statsService.getRelateItemAlanysisData(statsVO);
				
				double[] xArr = new double[list.size()];
				double[] yArr = new double[list.size()];
				
				int i = 0;
				for(StatsVO vo : list) {
					
					xArr[i] = Double.parseDouble(vo.getValueX().replaceAll(",", ""));
					yArr[i] = Double.parseDouble(vo.getValueY().replaceAll(",", ""));
					
					i++;
				}
				
				result.put(itemEName[xIdx]+itemEName[yIdx], getCoefCorr(xArr, yArr));
			}
		}
			
		return result;
	}
	
	
	
	/**
	 * 상관계수값을 구한다.
	 * 
	 * @param itemAnalysisStatsList
	 * @return
	 */
	public Map<String, String> getCoefCorr_flow(StatsVO statsVO) throws Exception{
		
		Map<String, String> result = new HashMap<String,String>();
		
		for(int yIdx = 0;yIdx <= 1;yIdx++)
		{
			for(int xIdx = lowerX;xIdx <= upperX; xIdx++)
			{
				statsVO.setItemCodeX(itemCode[xIdx]);
				statsVO.setItemCodeY(itemCode2[yIdx]);
				List<StatsVO> list = statsService.getRelateFlowAnalysisData(statsVO);
								
				double[] xArr = new double[list.size()];
				double[] yArr = new double[list.size()];

				int i = 0;
				for(StatsVO vo : list) {
					
					xArr[i] = Double.parseDouble(vo.getValueX().replaceAll(",", ""));
					yArr[i] = Double.parseDouble(vo.getValueY().replaceAll(",", ""));
					
					i++;
				}
				
				result.put(itemEName[xIdx]+itemEName2[yIdx], getCoefCorr(xArr, yArr));
			}
		}
			
		return result;
	}
	
	
	
	/**
	 * 수질 유량 상관계수값을 구한다.
	 * 
	 * @param itemAnalysisStatsList
	 * @return
	 */
	public Map<String, String> getCoefCorrFlow(List<StatsVO> itemAnalysisStatsList) {
		
		Map<String, String> result = new HashMap<String,String>();
		
		int cnt = itemAnalysisStatsList.size();
		
		double[] xTurArr = new double[cnt];
		double[] xTmpArr = new double[cnt];
		double[] xPhyArr = new double[cnt];
		double[] xDowArr = new double[cnt];
		double[] xConArr = new double[cnt];
		
		double[] yWlvArr = new double[cnt];
		double[] yFlwArr = new double[cnt];
	

		int i=0;

		for(StatsVO vo : itemAnalysisStatsList) {
			xTurArr[i] = Double.parseDouble(vo.getTurXVl().replaceAll(",", ""));
			xTmpArr[i] = Double.parseDouble(vo.getTmpXVl().replaceAll(",", ""));
			xPhyArr[i] = Double.parseDouble(vo.getPhyXVl().replaceAll(",", ""));
			xDowArr[i] = Double.parseDouble(vo.getDowXVl().replaceAll(",", ""));
			xConArr[i] = Double.parseDouble(vo.getConXVl().replaceAll(",", ""));
			
			yWlvArr[i] = Double.parseDouble(vo.getWlvYVl().replaceAll(",", ""));
			yFlwArr[i] = Double.parseDouble(vo.getFlwYVl().replaceAll(",", ""));
		
			i++;
		}
		
		
		result.put("turwlv",  getCoefCorr(xTurArr, yWlvArr));
		result.put("turflw",  getCoefCorr(xTurArr, yFlwArr));
		
		result.put("tmpwlv",  getCoefCorr(xTmpArr, yWlvArr));
		result.put("tmpflw",  getCoefCorr(xTmpArr, yFlwArr));

		result.put("phywlv",  getCoefCorr(xPhyArr, yWlvArr));
		result.put("phyflw",  getCoefCorr(xPhyArr, yFlwArr));
		
		result.put("dowwlv",  getCoefCorr(xDowArr, yWlvArr));
		result.put("dowflw",  getCoefCorr(xDowArr, yFlwArr));
		
		result.put("conwlv",  getCoefCorr(xConArr, yWlvArr));
		result.put("conflw",  getCoefCorr(xConArr, yFlwArr));
		
		return result;
	}
	
	
	/**
	 * 상관계수 메트릭스
	 * 
	 * @param system
	 * @param itemCode
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getCoefCorrList.do")
	public ModelAndView getCoefCorrList(
			@RequestParam(value="system", required=false)	 String system,
			@RequestParam(value="itemCode", required=false)	 String itemCode,
			@RequestParam(value="startDate", required=false) String startDate,
			@RequestParam(value="endDate", required=false)	 String endDate
			)
			throws Exception{

		if(system == null || system.equals("")) {
			system = "T";
		}
		
		if(itemCode == null || itemCode.equals("")) {
			itemCode = "TUR00";
		}
		
		if(startDate == null || startDate.equals("")) {
			startDate = DateUtil.getToday();
		}
		
		if(endDate == null || endDate.equals("")) {
			endDate = DateUtil.getToday();
		}						
		
		
		ModelAndView modelAndView = new ModelAndView();
				
		HashMap<String, String> hm = new HashMap<String, String>();
		hm.put("sysKind", system);		
		List<HashMap<String, Object>> list = statsService.getFactBranchList(hm);
		
		String[] arr = null;
		List<String[]> yList = new ArrayList<String[]>();
		
		for(HashMap<String, Object> mapi : list) {
			
			arr = new String[list.size()+1];
			int i=1;
			
			arr[0] = (String)mapi.get("FACTNAME") + " - " + ((BigDecimal)mapi.get("BRANCHNO")).toString();
			
			for(HashMap<String, Object> mapj : list) {
				
				StatsSearchVO vo = new StatsSearchVO();
				vo.setFactCodeX((String)mapi.get("FACTCODE"));
				vo.setBranchNoX(((BigDecimal)mapi.get("BRANCHNO")).toString());
				vo.setItemCodeX(itemCode);
				vo.setFactCodeY((String)mapj.get("FACTCODE"));
				vo.setBranchNoY(((BigDecimal)mapj.get("BRANCHNO")).toString());
				vo.setItemCodeY(itemCode);
				vo.setStartDate(startDate);
				vo.setEndDate(endDate);
				vo.setSort("list");
				
				List<StatsAnalysisVO> itemAnalysisStatsList = new ArrayList<StatsAnalysisVO>();
				
				if(system.equals("W")) {
					itemAnalysisStatsList =  statsService.getItemAnalysisStatsTmsList(vo);
				//} else if(system.equals("A")) {
				//	itemAnalysisStatsList =  statsService.getItemAnalysisStatsAutoList(vo);
				} else {
					itemAnalysisStatsList =  statsService.getItemAnalysisStatsList(vo);
				}
				
				String test = getCoefCorr1(itemAnalysisStatsList);
				arr[i++] = test;
			}
			yList.add(arr);
		}

		modelAndView.addObject("factList", list);
		modelAndView.addObject("coefCorrArr", yList);
		modelAndView.setViewName("/stats/statsCoefCorr");

		return modelAndView;
	}
	
	
	/**
	 * 유역별 통계화면으로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/goStatsBasin.do")
	public String goStatsBasin() throws Exception{
		return "stats/statsBasin";
	}
	
	/**
	 * 유역별 통계 데이터 조회
	 * @param statsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getStatsBasin.do")
	public ModelAndView getStatsBasin(
			@ModelAttribute("StatsVO") StatsVO statsVO
	) throws Exception {
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		statsVO.setRoleCode(user.getRoleCode());
		statsVO.setUserId(user.getId());
		
		ModelAndView mav = new ModelAndView();
		
		List<StatsVO> data = statsService.getStatsBasin(statsVO);
		
		mav.addObject("data", data);
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	
	
	/**
	 * 유역별 통계 엑셀출력
	 * @param statsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getStatsBasinExcel.do")
	public ModelAndView getStatsBasinExcel(
			@ModelAttribute("StatsVO") StatsVO statsVO
	) throws Exception {
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		statsVO.setRoleCode(user.getRoleCode());
		statsVO.setUserId(user.getId());
		
		List<StatsVO> data = statsService.getStatsBasin(statsVO);
		
		statsVO.setStatKind("BASIN1"); //유역별통계 | 시스템별 통계 구분
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("data", data);
		map.put("statsVO", statsVO);
		map.put("etc_excel", "Y");
	
		ModelAndView mav = null;
		
		if(!"A".equals(statsVO.getSystem()))
			mav = new ModelAndView("ExcelStatsBasinView", "map", map);
		else
			mav = new ModelAndView("ExcelStatsBasinAView", "map", map);
		
		return mav;
	}
	
	/**
	 * 시스템별 통계 데이터 가져오기
	 * @param statsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getStats.do")
	public ModelAndView getStats(
			@ModelAttribute("StatsVO") StatsVO statsVO
	) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		List<StatsVO> data = statsService.getStats(statsVO);
		
		mav.addObject("data", data);
		mav.setViewName("jsonView");
		
		return mav;
	}

	/**
	 * 시스템별 통계 엑셀출력
	 * @param statsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getStatsBasinExcel2.do")
	public ModelAndView getStatsBasinExcel2(
			@ModelAttribute("StatsVO") StatsVO statsVO
	) throws Exception {

		List<StatsVO> data = statsService.getStats(statsVO);
		
		statsVO.setStatKind("BASIN2"); //유역별통계 | 시스템별 통계 구분
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("data", data);
		map.put("statsVO", statsVO);
		map.put("etc_excel", "Y");
	
		ModelAndView mav = null;
		
		if(!"A".equals(statsVO.getSystem()))
			mav = new ModelAndView("ExcelStatsBasinView", "map", map);
		else
			mav = new ModelAndView("ExcelStatsBasinAView", "map", map);
		
		return mav;
	}
	
	
	
	/**
	 * IP-USN 통계화면으로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/goStatsBasinU.do")
	public String goStatsBasinU() throws Exception{
		return "stats/statsBasinU";
	}
	
	/**
	 * 국가수질자동측정망 통계 화면으로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/goStatsBasinA.do")
	public String goStatsBasinA() throws Exception{
		return "stats/statsBasinA";
	}
	
	/**
	 * 탁수모니터링 통계화면으로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/goStatsBasinT.do")
	public String goStatsBasinT() throws Exception{
		return "stats/statsBasinT";
	}
	
	/**
	 * 시스템별 통계 그래프 팝업화면으로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/goStatsBasinGraph.do")
	public String goStatsBasinGraph() throws Exception{
		return "stats/statsBasinGraph";
	}
	
	/**
	 * 시스템별 통계 그래프 팝업화면으로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/goStatsBasinGraph2.do")
	public String goStatsBasinGraph2() throws Exception{
		return "stats/statsBasinGraph2";
	}
	
	/**
	 * 시스템별 통계 그래프
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getStatsBasinGraph2.do")
	public ModelAndView getStatsBasinGraph2(
			@ModelAttribute("StatsVO") StatsVO statsVO,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height
	) throws Exception{
				
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("MAX");
		itemCodeList.add("AVG");
		itemCodeList.add("MIN");

		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("최대");
		itemNameList.add("평균");
		itemNameList.add("최소");
		
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}
		
		//getData
		List<StatsVO> graphDataList = statsService.getStatsGraph(statsVO);
		
		int voCount = 0;
		
		for(StatsVO detailData : graphDataList) {
			
			String gigan = "";
			
			if(detailData != null)
			{
				if("1".equals(statsVO.getGubun()))
					gigan = detailData.getYear() + "년";
				else if("2".equals(statsVO.getGubun()))
					gigan = detailData.getQuarter();
				 else if("3".equals(statsVO.getGubun()))
					 gigan = detailData.getStartMonth()+ "월";
				 else
					 gigan = detailData.getDay();
			}
			
			if(detailData.getMaxVl() != null)
			{
				List data =  dataMap.get("MAX");
				Map valMap = new HashMap();
				valMap = new HashMap();
				valMap.put("x", gigan);
				valMap.put("y", detailData.getMaxVl());
				data.add(valMap);
				dataMap.put("MAX", data);
				voCount++;
			}
			
			if(detailData.getAvgVl() != null)
			{
				List data =  dataMap.get("AVG");
				Map valMap = new HashMap();
				valMap.put("x", gigan);
				valMap.put("y", detailData.getAvgVl());
				data.add(valMap);
				dataMap.put("AVG", data);
				voCount++;
			}
			
			if(detailData.getMinVl() != null)
			{
				List data =  dataMap.get("MIN");
				Map valMap = new HashMap();
				valMap.put("x", gigan);
				valMap.put("y", detailData.getMinVl());
				data.add(valMap);
				dataMap.put("MIN", data);
				voCount++;
			}
		}
		
		
		if(voCount == 0)
		{
			itemNameList = new ArrayList<String>();
			itemCodeList = new ArrayList<String>();
			
			itemNameList.add("조회결과가 없습니다");
			itemCodeList.add("MAX");
			
			for(int i = 0 ; i < 20 ; i++)
			{
				List data = dataMap.get("MAX");
				
				Map valMap = new HashMap();
				valMap.put("x",  "");
				valMap.put("y", "0");
				data.add(valMap);
				dataMap.put("MAX", data);
				
				voCount ++;
			}
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append("");

		ModelAndView modelAndView = new ModelAndView();
		
		try
		{
			Double lawVl = null;
			if("T".equals(statsVO.getSysKind()))
			{
				if("TUR00".equals(statsVO.getItemCode()))
				{
					AlertSearchVO vo = new AlertSearchVO();
					vo.setFactCode(statsVO.getFactCode());
					vo.setBranchNo(Integer.parseInt(statsVO.getBranchNo()));
					vo.setItemCode("TUR00");
					
					AlertDataLawVo lawData = alertLawService.getFactLaw(vo);
					
					modelAndView.addObject("lawVl", lawData.getLawHValue());
				}
			}
		}
		catch(Exception ex)
		{
		}
			
		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("itemCode",statsVO.getItemCode());
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("sys",statsVO.getSysKind());
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 1);		
		modelAndView.addObject("legBox", "Y");
		
		modelAndView.setViewName("ChartStatsBasin2View");
		return modelAndView;
		
	}
	
	
	
	
	/**
	 * 시스템별 통계 그래프 팝업화면으로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/goRiverOutletGraph.do")
	public String goRiverOutletGraph() throws Exception{
		return "stats/statsRiverOutletGraph";
	}
	
	/**
	 * 시스템별 통계 그래프
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getRiverOutletGraph.do")
	public ModelAndView getRiverOutletGraph(
			@ModelAttribute("StatsVO") StatsVO statsVO,
			@RequestParam(value="itemCode", required=false) String itemCode,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height
	) throws Exception{
				
		statsVO.setOrderBy("asc");
		
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("VAL");
		itemCodeList.add("AVG");
		itemCodeList.add("FLW");

		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("부하량");
		itemNameList.add("농도");
		itemNameList.add("방류량");
		
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}

		//getData
		statsVO.setFirstIndex(0);
		statsVO.setRecordCountPerPage(Integer.MAX_VALUE);
		List<StatsVO> graphDataList = statsService.getRiverOutlet(statsVO);

		int voCount = 0;
		
	
		
		for(StatsVO detailData : graphDataList) {
			
			String gigan = "";
			
			if(detailData != null)
			{
				gigan = detailData.getBaseTime();
			}
			
			String val = "";
			String flw = "";
			String avg = "";
			
			if("BOD".equals(itemCode))
			{
				val = detailData.getBodValue();
				flw = detailData.getBodFlow();
				avg = detailData.getBodAvg();
			}
			if("COD".equals(itemCode))
			{
				val = detailData.getCodValue();
				flw = detailData.getCodFlow();
				avg = detailData.getCodAvg();
			}
			if("SUS".equals(itemCode))
			{
				val = detailData.getSusValue();
				flw = detailData.getSusFlow();
				avg = detailData.getSusAvg();
			}
			if("TON".equals(itemCode))
			{
				val = detailData.getTonValue();
				flw = detailData.getTonFlow();
				avg = detailData.getTonAvg();
			}
			if("TOP".equals(itemCode))
			{
				val = detailData.getTopValue();
				flw = detailData.getTopFlow();
				avg = detailData.getTopAvg();
			}
			
//			Double dFlw = 0D;
//			
//			if(flw != null)
//			{
//				flw = flw.replaceAll(",", "");
//				dFlw = Double.valueOf(flw);
//				dFlw = dFlw/1000;
//				
//				String pattern = "0.##";
//				DecimalFormat df = new DecimalFormat(pattern);
//				
//				flw = df.format(dFlw);
//			}
			
			
			if(val != null)
			{
				List data =  dataMap.get("VAL");
				Map valMap = new HashMap();
				valMap = new HashMap();
				valMap.put("x", gigan);
				valMap.put("y", val);
				data.add(valMap);
				dataMap.put("VAL", data);
				voCount++;
			}
			
			if(flw != null)
			{
				List data =  dataMap.get("FLW");
				Map valMap = new HashMap();
				valMap.put("x", gigan);
				valMap.put("y", flw);
				data.add(valMap);
				dataMap.put("FLW", data);
				voCount++;
			}
			
			if(avg != null)
			{
				List data =  dataMap.get("AVG");
				Map valMap = new HashMap();
				valMap.put("x", gigan);
				valMap.put("y", avg);
				data.add(valMap);
				dataMap.put("AVG", data);
				voCount++;
			}
		}
		
		
		if(voCount == 0)
		{
			itemNameList = new ArrayList<String>();
			itemCodeList = new ArrayList<String>();
			
			itemNameList.add("조회결과가 없습니다");
			itemCodeList.add("VAL");
			
			for(int i = 0 ; i < 20 ; i++)
			{
				List data = dataMap.get("VAL");
				
				Map valMap = new HashMap();
				valMap.put("x",  "");
				valMap.put("y", "0");
				data.add(valMap);
				dataMap.put("VAL", data);
				
				voCount ++;
			}
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append("");

		ModelAndView modelAndView = new ModelAndView();
		
		try
		{
			Double lawVl = null;
			if("T".equals(statsVO.getSysKind()))
			{
				if("TUR00".equals(statsVO.getItemCode()))
				{
					AlertSearchVO vo = new AlertSearchVO();
					vo.setFactCode(statsVO.getFactCode());
					vo.setBranchNo(Integer.parseInt(statsVO.getBranchNo()));
					vo.setItemCode("TUR00");
					
					AlertDataLawVo lawData = alertLawService.getFactLaw(vo);
					
					modelAndView.addObject("lawVl", lawData.getLawHValue());
				}
			}
		}
		catch(Exception ex)
		{
		}
			
		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("itemCode",statsVO.getItemCode());
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("sys",statsVO.getSysKind());
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 1);		
		modelAndView.addObject("legBox", "Y");
		
		modelAndView.setViewName("ChartStatsBasin2View");
		return modelAndView;
		
	}
	
	
	
	
	/**
	 * 사전조치통계화면으로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/goStatsAdAct.do")
	public String goStatsAdAct() throws Exception{
		return "stats/statsAdAct";
	}

	
	/**
	 * 사전조치 통계
	 * @param statsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getAdAct.do")
	public ModelAndView getAdAct(
			@ModelAttribute("StatsVO") StatsVO statsVO
	) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		List<StatsVO> data = statsService.getAdAct(statsVO);
		
		mav.addObject("data", data);
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	/**
	 * 사전조치통계 상세팝업으로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/goStatsAdActDetail.do")
	public ModelAndView goStatsAdActDetail(
			@RequestParam(value="statsDiv") String statsDiv,
			@RequestParam(value="statsDate") String statsDate,
			@RequestParam(value="kind") String kind
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("statsDiv", statsDiv);
		modelAndView.addObject("statsDate", statsDiv);
		modelAndView.addObject("kind", kind);
		
		modelAndView.setViewName("/stats/statsAdActDetail");
		return modelAndView;
	}
	
	/**
	 * 사전조치통계 상세팝업 목록 가져오기
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getStatsAdActDetail.do")
	public ModelAndView getStatsAdActDetail(
			  @ModelAttribute("adActSearchVO") AdActSearchVO adActSearchVO
			) throws Exception {
		
		//System.out.println("======================== 사전조치 통계팝업 ===============================");
		
		ModelAndView modelAndView = new ModelAndView();
		
		adActSearchVO.setPageUnit(10);
		adActSearchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(adActSearchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(adActSearchVO.getPageUnit());
		paginationInfo.setPageSize(adActSearchVO.getPageSize());
		
		adActSearchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		adActSearchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		adActSearchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());		
		
		List<AdActSearchVO> list = statsService.getStatsAdActDetail(adActSearchVO);
		int totCnt = statsService.getStatsAdActDetailCnt(adActSearchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("list", list);
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	
	/**
	 * 사전조치 통계 엑셀출력
	 * @param statsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getAdActExcel.do")
	public ModelAndView getAdActExcel(
			@ModelAttribute("StatsVO") StatsVO statsVO
	) throws Exception {

		List<StatsVO> data = statsService.getAdAct(statsVO);
		
 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("data", data);
		map.put("statsVO", statsVO);
	
		ModelAndView mav = null;

		mav = new ModelAndView("ExcelStatsAdActView", "map", map);
		
		return mav;
	}
	
	/**
	 * 통계 그래프화면으로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/goStatsGraph.do")
	public String goAdActGraph() throws Exception{
		return "stats/statsGraph";
	}
	
	/**
	 * 사전조치 통계 그래프
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getAdActGraph.do")
	public ModelAndView getStatsBasinGraph(
			@ModelAttribute("StatsVO") StatsVO statsVO,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height
	) throws Exception{
		
		statsVO.setSort("chart");

		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("W");
		itemCodeList.add("T");
		itemCodeList.add("E");
		itemCodeList.add("C");
		itemCodeList.add("A");

		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("기상");
		itemNameList.add("훈련");
		itemNameList.add("긴급");
		itemNameList.add("점검");
		itemNameList.add("기타");
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}

		//getData
		List<StatsVO> graphDataList = statsService.getAdAct(statsVO);

		int voCount = 0;
		
		for(StatsVO detailData : graphDataList) {
			
			String gigan = "";
			
			if(detailData != null)
			{
				if("1".equals(statsVO.getGubun()))
					gigan = detailData.getStatsDate() + "년";
				else if("2".equals(statsVO.getGubun()))
					gigan = detailData.getQuarter();
				else if("3".equals(statsVO.getGubun()))
					gigan = detailData.getStartMonth()+ "월";
				 //else
				//	 gigan = detailData.getDay();
			}
			
			if(detailData.getActWeather() != null){
				List data =  dataMap.get("W");
				Map valMap = new HashMap();
				valMap = new HashMap();
				valMap.put("x", gigan);
				valMap.put("y", detailData.getActWeather());
				data.add(valMap);
				dataMap.put("W", data);
				voCount++;
			}
			
			if(detailData.getActTraning() != null){
				List data =  dataMap.get("T");
				Map valMap = new HashMap();
				valMap.put("x", gigan);
				valMap.put("y", detailData.getActTraning());
				data.add(valMap);
				dataMap.put("T", data);
				voCount++;
			}
			
			if(detailData.getActEmc() != null){
				List data =  dataMap.get("E");
				Map valMap = new HashMap();
				valMap.put("x", gigan);
				valMap.put("y", detailData.getActEmc());
				data.add(valMap);
				dataMap.put("E", data);
				voCount++;
			}
			
			if(detailData.getActChk() != null){
				List data =  dataMap.get("C");
				Map valMap = new HashMap();
				valMap.put("x", gigan);
				valMap.put("y", detailData.getActChk());
				data.add(valMap);
				dataMap.put("C", data);
				voCount++;
			}
			
			if(detailData.getActOther() != null){
				List data =  dataMap.get("A");
				Map valMap = new HashMap();
				valMap.put("x", gigan);
				valMap.put("y", detailData.getActOther());
				data.add(valMap);
				dataMap.put("A", data);
				voCount++;
			}
		}		
		
		if(voCount == 0){
			itemNameList = new ArrayList<String>();
			itemCodeList = new ArrayList<String>();
			
			itemNameList.add("조회결과가 없습니다");
			itemCodeList.add("T");
			
			for(int i = 0 ; i < 20 ; i++)
			{
				List data = dataMap.get("T");
				
				Map valMap = new HashMap();
				valMap.put("x",  "");
				valMap.put("y", "0");
				data.add(valMap);
				dataMap.put("T", data);
				
				voCount ++;
			}
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		StringBuffer title = new StringBuffer();
		title.append("");

		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("itemCode",statsVO.getItemCode());
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("sys",statsVO.getSysKind());
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 2);		
		modelAndView.addObject("legBox", "Y");
		
		modelAndView.setViewName("ChartStatsBasin2View");
		return modelAndView;
	}
	
	
	/**
	 * 상황발생통계화면으로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/goStatsSituOc.do")
	public String goStatsSituOc() throws Exception{
		return "stats/statsSituOc";
	}
	
	/**
	 * 상황발생통계
	 * @param statsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getSituOC.do")
	public ModelAndView getSituOC(
			@ModelAttribute("StatsVO") StatsVO statsVO
	) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		List<StatsVO> data = null;
		
		if("SYS".equals(statsVO.getOcDiv()) && "T".equals(statsVO.getSysKind())) //시스템경보 && 탁수
			data = statsService.getSituOC(statsVO);
		else if("SYS".equals(statsVO.getOcDiv()) && !"T".equals(statsVO.getSysKind()))
			data = statsService.getSituOCWarning(statsVO);
		else if("REG".equals(statsVO.getOcDiv()))
			data = statsService.getSituOCAcct(statsVO);
			
		mav.addObject("data", data);
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	
	/**
	 * 상황발생 통계 그래프
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getSituOCGraph.do")
	public ModelAndView getSituOCGraph(
			@ModelAttribute("StatsVO") StatsVO statsVO,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height
	) throws Exception{
		
		statsVO.setSort("chart");

		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
	
		//itemNameList
		List<String> itemNameList = new ArrayList<String>();		
		
		if("SYS".equals(statsVO.getOcDiv()) && "T".equals(statsVO.getSysKind())) //시스템경보 && 탁수
		{
			itemCodeList.add("1");
			itemCodeList.add("2");
			itemCodeList.add("3");
			itemCodeList.add("4");
			
			itemNameList.add("최초");
			itemNameList.add("3시간");
			itemNameList.add("6시간");
			itemNameList.add("12시간 이상");
		}
		else if("SYS".equals(statsVO.getOcDiv()) && !"T".equals(statsVO.getSysKind()))
		{
			itemCodeList.add("1");
			itemCodeList.add("2");
			itemCodeList.add("3");
			itemCodeList.add("4");
			
			itemNameList.add("관심");
			itemNameList.add("주의");
			itemNameList.add("경계");
			itemNameList.add("심각");
		}
		else if("REG".equals(statsVO.getOcDiv()))
		{
			itemCodeList.add("1");
			itemCodeList.add("2");
			itemCodeList.add("3");
			itemCodeList.add("4");
			itemCodeList.add("5");
			itemCodeList.add("6");
			itemCodeList.add("7");
			itemCodeList.add("8");
			itemCodeList.add("9");
			itemCodeList.add("10");
			itemCodeList.add("11");
			itemCodeList.add("12");
			itemCodeList.add("13");
			
			itemNameList.add("오탁수발생");
			itemNameList.add("준설장비용출");
			itemNameList.add("준설장비전복");
			itemNameList.add("선박사고");
			itemNameList.add("선박페인트");
			itemNameList.add("탱크로리");
			itemNameList.add("홍수기");
			itemNameList.add("취정수장");
			itemNameList.add("유류유출");
			itemNameList.add("페놀");
			itemNameList.add("유해물질");
			itemNameList.add("물고기폐사");
			itemNameList.add("기타사항");
		}
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}	
		
		List<StatsVO> graphDataList = null;
		
		if("SYS".equals(statsVO.getOcDiv()) && "T".equals(statsVO.getSysKind())) //시스템경보 && 탁수
			graphDataList = statsService.getSituOC(statsVO);
		else if("SYS".equals(statsVO.getOcDiv()) && !"T".equals(statsVO.getSysKind()))
			graphDataList = statsService.getSituOCWarning(statsVO);
		else if("REG".equals(statsVO.getOcDiv()))
			graphDataList = statsService.getSituOCAcct(statsVO);
		
		int voCount = 0;
		
		for(StatsVO detailData : graphDataList) {
			
			String gigan = "";
			
			if(detailData != null)
			{
				if("1".equals(statsVO.getGubun()))
					gigan = detailData.getStatsDate() + "년";
				else if("2".equals(statsVO.getGubun()))
					gigan = detailData.getQuarter();
				 else if("3".equals(statsVO.getGubun()))
					 gigan = detailData.getStartMonth()+ "월";
				 //else
					 //gigan = detailData.getDay();
				
				if("REG".equals(statsVO.getOcDiv()) && "T".equals(statsVO.getOcPointDiv()))
				{
					gigan = gigan + " " +detailData.getStatsArea();
				}
			}
			
			
			if("SYS".equals(statsVO.getOcDiv()) && "T".equals(statsVO.getSysKind())) //시스템경보 && 탁수
			{
				if(detailData.getFirstCnt() != null)
				{
					List data =  dataMap.get("1");
					Map valMap = new HashMap();
					valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getFirstCnt());
					data.add(valMap);
					dataMap.put("1", data);
					voCount++;
				}
				
				if(detailData.getTime3Cnt() != null)
				{
					List data =  dataMap.get("2");
					Map valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getTime3Cnt());
					data.add(valMap);
					dataMap.put("2", data);
					voCount++;
				}
				
				if(detailData.getTime6Cnt() != null)
				{
					List data =  dataMap.get("3");
					Map valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getTime6Cnt());
					data.add(valMap);
					dataMap.put("3", data);
					voCount++;
				}
				
				if(detailData.getTime12Cnt() != null)
				{
					List data =  dataMap.get("4");
					Map valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getTime12Cnt());
					data.add(valMap);
					dataMap.put("4", data);
					voCount++;
				}
			}
			else if("SYS".equals(statsVO.getOcDiv()) && !"T".equals(statsVO.getSysKind()))
			{
				if(detailData.getWarningCnt() != null)
				{
					List data =  dataMap.get("1");
					Map valMap = new HashMap();
					valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getWarningCnt());
					data.add(valMap);
					dataMap.put("1", data);
					voCount++;
				}
				
				if(detailData.getCatCnt() != null)
				{
					List data =  dataMap.get("2");
					Map valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getCatCnt());
					data.add(valMap);
					dataMap.put("2", data);
					voCount++;
				}
				
				if(detailData.getAlertCnt() != null)
				{
					List data =  dataMap.get("3");
					Map valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getAlertCnt());
					data.add(valMap);
					dataMap.put("3", data);
					voCount++;
				}
				
				if(detailData.getSrsCnt() != null)
				{
					List data =  dataMap.get("4");
					Map valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getSrsCnt());
					data.add(valMap);
					dataMap.put("4", data);
					voCount++;
				}
			}
			else if("REG".equals(statsVO.getOcDiv()))
			{
				if(detailData.getDmwtrCnt() != null)
				{
					List data =  dataMap.get("1");
					Map valMap = new HashMap();
					valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getDmwtrCnt());
					data.add(valMap);
					dataMap.put("1", data);
					voCount++;
				}
				
				if(detailData.getEquEltnCnt() != null)
				{
					List data =  dataMap.get("2");
					Map valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getEquEltnCnt());
					data.add(valMap);
					dataMap.put("2", data);
					voCount++;
				}
				
				if(detailData.getEquRollCnt() != null)
				{
					List data =  dataMap.get("3");
					Map valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getEquRollCnt());
					data.add(valMap);
					dataMap.put("3", data);
					voCount++;
				}
				
				if(detailData.getShipCnt() != null)
				{
					List data =  dataMap.get("4");
					Map valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getShipCnt());
					data.add(valMap);
					dataMap.put("4", data);
					voCount++;
				}
				
				if(detailData.getShipPntCnt() != null)
				{
					List data =  dataMap.get("5");
					Map valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getShipPntCnt());
					data.add(valMap);
					dataMap.put("5", data);
					voCount++;
				}
				
				if(detailData.getTanktrCnt() != null)
				{
					List data =  dataMap.get("6");
					Map valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getTanktrCnt());
					data.add(valMap);
					dataMap.put("6", data);
					voCount++;
				}
				
				if(detailData.getFldssnCnt() != null)
				{
					List data =  dataMap.get("7");
					Map valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getFldssnCnt());
					data.add(valMap);
					dataMap.put("7", data);
					voCount++;
				}
				
				if(detailData.getIfplntCnt() != null)
				{
					List data =  dataMap.get("8");
					Map valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getIfplntCnt());
					data.add(valMap);
					dataMap.put("8", data);
					voCount++;
				}
				
				if(detailData.getOilCnt() != null)
				{
					List data =  dataMap.get("9");
					Map valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getOilCnt());
					data.add(valMap);
					dataMap.put("9", data);
					voCount++;
				}
				
				if(detailData.getPhenolCnt() != null)
				{
					List data =  dataMap.get("10");
					Map valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getPhenolCnt());
					data.add(valMap);
					dataMap.put("10", data);
					voCount++;
				}
				
				if(detailData.getToxicCnt() != null)
				{
					List data =  dataMap.get("11");
					Map valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getToxicCnt());
					data.add(valMap);
					dataMap.put("11", data);
					voCount++;
				}
				
				if(detailData.getFshdieCnt() != null)
				{
					List data =  dataMap.get("12");
					Map valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getFshdieCnt());
					data.add(valMap);
					dataMap.put("12", data);
					voCount++;
				}
				
				if(detailData.getEtcCnt() != null)
				{
					List data =  dataMap.get("13");
					Map valMap = new HashMap();
					valMap.put("x", gigan);
					valMap.put("y", detailData.getEtcCnt());
					data.add(valMap);
					dataMap.put("13", data);
					voCount++;
				}
			}
		}
		
		
		if(voCount == 0)
		{
			itemNameList = new ArrayList<String>();
			itemCodeList = new ArrayList<String>();
			
			itemNameList.add("조회결과가 없습니다");
			itemCodeList.add("SMS");
			
			for(int i = 0 ; i < 20 ; i++)
			{
				List data = dataMap.get("SMS");
				
				Map valMap = new HashMap();
				valMap.put("x",  "");
				valMap.put("y", "0");
				data.add(valMap);
				dataMap.put("SMS", data);
				
				voCount ++;
			}
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append("");

		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("itemCode",statsVO.getItemCode());
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("sys",statsVO.getSysKind());
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 2);		
		modelAndView.addObject("legBox", "Y");
		
		modelAndView.setViewName("ChartStatsBasin2View");
		return modelAndView;
	}
	
	
	
	/**
	 * 상황발생 통계 엑셀출력
	 * @param statsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getSituOCExcel.do")
	public ModelAndView getSituOCExcel(
			@ModelAttribute("StatsVO") StatsVO statsVO
	) throws Exception {

		List<StatsVO> data = null;
		
		if("SYS".equals(statsVO.getOcDiv()) && "T".equals(statsVO.getSysKind())) //시스템경보 && 탁수
			data = statsService.getSituOC(statsVO);
		else if("SYS".equals(statsVO.getOcDiv()) && !"T".equals(statsVO.getSysKind()))
			data = statsService.getSituOCWarning(statsVO);
		else if("REG".equals(statsVO.getOcDiv()))
			data = statsService.getSituOCAcct(statsVO);
		
 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("data", data);
		map.put("statsVO", statsVO);
	
		ModelAndView mav = null;

		mav = new ModelAndView("ExcelStatsSituOCView", "map", map);
		
		return mav;
	}
	
	
	
	/**
	 * 상황전파통계 화면으로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/goStatsSituSpread.do")
	public String goStatsSituSpread() throws Exception{
		return "stats/statsSituSpread";
	}
	
	
	/**
	 * 상황전파통계
	 * @param statsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getSituSpread.do")
	public ModelAndView getSituSpread(
			@ModelAttribute("StatsVO") StatsVO statsVO
	) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		List<StatsVO> data = statsService.getSituSpread(statsVO);
		
		mav.addObject("data", data);
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	/**
	 * 상황전파 통계 엑셀출력
	 * @param statsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getSituSpreadExcel.do")
	public ModelAndView getSituSpreadExcel(
			@ModelAttribute("StatsVO") StatsVO statsVO
	) throws Exception {

		List<StatsVO> data = statsService.getSituSpread(statsVO);
		
 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("data", data);
		map.put("statsVO", statsVO);
	
		ModelAndView mav = null;

		mav = new ModelAndView("ExcelStatsSituSpreadView", "map", map);
		
		return mav;
	}
	
	
	/**
	 * 상황전파 통계 그래프
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getSituSpreadGraph.do")
	public ModelAndView getSituSpreadGraph(
			@ModelAttribute("StatsVO") StatsVO statsVO,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height
	) throws Exception{
		
		statsVO.setSort("chart");

		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("SMS");
		itemCodeList.add("ACS");

		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("SMS");
		itemNameList.add("ACS");
		
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}

		//getData
		List<StatsVO> graphDataList = statsService.getSituSpread(statsVO);

		int voCount = 0;	
		
		for(StatsVO detailData : graphDataList) {
			
			String gigan = "";
			
			if(detailData != null)
			{
				if("1".equals(statsVO.getGubun()))
					gigan = detailData.getStatsDate() + "년";
				else if("2".equals(statsVO.getGubun()))
					gigan = detailData.getQuarter();
				 else if("3".equals(statsVO.getGubun()))
					 gigan = detailData.getStartMonth()+ "월";
				 //else
					 //gigan = detailData.getDay();
			}
			
			if(detailData.getSmsCnt() != null)
			{
				List data =  dataMap.get("SMS");
				Map valMap = new HashMap();
				valMap = new HashMap();
				valMap.put("x", gigan);
				valMap.put("y", detailData.getSmsCnt());
				data.add(valMap);
				dataMap.put("SMS", data);
				voCount++;
			}
			
			if(detailData.getAcsCnt() != null)
			{
				List data =  dataMap.get("ACS");
				Map valMap = new HashMap();
				valMap.put("x", gigan);
				valMap.put("y", detailData.getAcsCnt());
				data.add(valMap);
				dataMap.put("ACS", data);
				voCount++;
			}
		}
		
		
		if(voCount == 0)
		{
			itemNameList = new ArrayList<String>();
			itemCodeList = new ArrayList<String>();
			
			itemNameList.add("조회결과가 없습니다");
			itemCodeList.add("SMS");
			
			for(int i = 0 ; i < 20 ; i++)
			{
				List data = dataMap.get("SMS");
				
				Map valMap = new HashMap();
				valMap.put("x",  "");
				valMap.put("y", "0");
				data.add(valMap);
				dataMap.put("SMS", data);
				
				voCount ++;
			}
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append("");

		ModelAndView modelAndView = new ModelAndView();
		
		
		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("itemCode",statsVO.getItemCode());
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("sys",statsVO.getSysKind());
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 2);		
		modelAndView.addObject("legBox", "Y");
		
		modelAndView.setViewName("ChartStatsBasin2View");
		return modelAndView;
	}
	
	
	/**
	 * 상황조치통계 화면으로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/goStatsPrevStep.do")
	public String goStatsPrevStep() throws Exception{
		return "stats/statsPrevStep";
	}
	
	
	/**
	 * 상황조치통계
	 * @param statsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getPrevStep.do")
	public ModelAndView getPrevStep(
			@ModelAttribute("StatsVO") StatsVO statsVO
	) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		List<StatsVO> data = null;
		
		if("AUTO".equals(statsVO.getPrevType()))
			data = statsService.getPrevStep(statsVO);
		else if("REGI".equals(statsVO.getPrevType()))
			data = statsService.getPrevStep2(statsVO);
		
		mav.addObject("data", data);
		mav.setViewName("jsonView");
		
		return mav;
	}
	
	
	/**
	 * 상황조치 통계 엑셀출력
	 * @param statsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getPrevStepExcel.do")
	public ModelAndView getPrevStepExcel(
			@ModelAttribute("StatsVO") StatsVO statsVO
	) throws Exception {

		List<StatsVO> data = null;
		
		if("AUTO".equals(statsVO.getPrevType()))
			data = statsService.getPrevStep(statsVO);
		else if("REGI".equals(statsVO.getPrevType()))
			data = statsService.getPrevStep2(statsVO);
		
 
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("data", data);
		map.put("statsVO", statsVO);
	
		ModelAndView mav = null;

		mav = new ModelAndView("ExcelStatsPrevStepView", "map", map);
		
		return mav;
	}
	
	
	/**
	 * 상황조치 통계 그래프
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getPrevStepGraph.do")
	public ModelAndView getPrevStepGraph(
			@ModelAttribute("StatsVO") StatsVO statsVO,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height
	) throws Exception{
		
		statsVO.setSort("chart");

		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("WARNING");
		itemCodeList.add("FIELD");
		itemCodeList.add("SAMPLE");
		itemCodeList.add("ISSUE");
		itemCodeList.add("SPREAD");
		itemCodeList.add("END");

		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("경보");
		itemNameList.add("현장");
		itemNameList.add("시료");
		itemNameList.add("발령");
		itemNameList.add("전파");
		itemNameList.add("종료");
		
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}

		
		//getData
		List<StatsVO> graphDataList = null;
		
		if("AUTO".equals(statsVO.getPrevType()))
			graphDataList = statsService.getPrevStep(statsVO);
		else if("REGI".equals(statsVO.getPrevType()))
			graphDataList = statsService.getPrevStep2(statsVO);
		
	

		int voCount = 0;
		
	
		for(StatsVO detailData : graphDataList) {
			
			String gigan = "";
			
			if(detailData != null)
			{
				if("1".equals(statsVO.getGubun()))
					gigan = detailData.getStatsDate() + "년";
				else if("2".equals(statsVO.getGubun()))
					gigan = detailData.getQuarter();
				 else if("3".equals(statsVO.getGubun()))
					 gigan = detailData.getStartMonth()+ "월";
				 //else
					 //gigan = detailData.getDay();
				
		
				if("REGI".equals(statsVO.getPrevType()))
				{
					gigan = gigan + " " +detailData.getStatsArea();
				}
			
			}
			
			if(detailData.getWarningCnt() != null)
			{
				List data =  dataMap.get("WARNING");
				Map valMap = new HashMap();
				valMap = new HashMap();
				valMap.put("x", gigan);
				valMap.put("y", detailData.getWarningCnt());
				data.add(valMap);
				dataMap.put("WARNING", data);
				voCount++;
			}
			
			if(detailData.getFldCnt() != null)
			{
				List data =  dataMap.get("FIELD");
				Map valMap = new HashMap();
				valMap.put("x", gigan);
				valMap.put("y", detailData.getFldCnt());
				data.add(valMap);
				dataMap.put("FIELD", data);
				voCount++;
			}
			
			if(detailData.getSmplCnt() != null)
			{
				List data =  dataMap.get("SAMPLE");
				Map valMap = new HashMap();
				valMap.put("x", gigan);
				valMap.put("y", detailData.getSmplCnt());
				data.add(valMap);
				dataMap.put("SAMPLE", data);
				voCount++;
			}
			
			if(detailData.getIssCnt() != null)
			{
				List data =  dataMap.get("ISSUE");
				Map valMap = new HashMap();
				valMap.put("x", gigan);
				valMap.put("y", detailData.getIssCnt());
				data.add(valMap);
				dataMap.put("ISSUE", data);
				voCount++;
			}
			
			if(detailData.getSpreadCnt() != null)
			{
				List data =  dataMap.get("SPREAD");
				Map valMap = new HashMap();
				valMap.put("x", gigan);
				valMap.put("y", detailData.getSpreadCnt());
				data.add(valMap);
				dataMap.put("SPREAD", data);
				voCount++;
			}
			
			if(detailData.getEndCnt() != null)
			{
				List data =  dataMap.get("END");
				Map valMap = new HashMap();
				valMap.put("x", gigan);
				valMap.put("y", detailData.getEndCnt());
				data.add(valMap);
				dataMap.put("END", data);
				voCount++;
			}
		}
		
		
		if(voCount == 0)
		{
			itemNameList = new ArrayList<String>();
			itemCodeList = new ArrayList<String>();
			
			itemNameList.add("조회결과가 없습니다");
			itemCodeList.add("T");
			
			for(int i = 0 ; i < 20 ; i++)
			{
				List data = dataMap.get("T");
				
				Map valMap = new HashMap();
				valMap.put("x",  "");
				valMap.put("y", "0");
				data.add(valMap);
				dataMap.put("T", data);
				
				voCount ++;
			}
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append("");

		ModelAndView modelAndView = new ModelAndView();
		
		
		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("itemCode",statsVO.getItemCode());
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("sys",statsVO.getSysKind());
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 2);
		modelAndView.addObject("legBox", "Y");
		
		modelAndView.setViewName("ChartStatsBasin2View");
		return modelAndView;
		
	}
	
	
	/**
	 * 폐수방류량 통계 화면으로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/goStatsRiverOutlet.do")
	public ModelAndView goStatsRiverOutlet(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		String startDate = statsService.getStartBaseTime();
		String endDate = statsService.getEndBaseTime();
		
		modelAndView.addObject("startDate", startDate);
		modelAndView.addObject("endDate", endDate);
		//modelAndView.setViewName("jsonView");
		modelAndView.setViewName("stats/statsRiverOutlet");
		return modelAndView;
	}
	
	/**
	 * 폐수방류량 통계
	 * @param searchTaksuVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getRiverOutlet.do")
	public ModelAndView getRiverOutlet(
			@ModelAttribute("StatsVO") StatsVO statsVO
	)
	throws Exception{
	
		PaginationInfo paginationInfo = new PaginationInfo();

		if(statsVO.getPageIndex() == 0)
			statsVO.setPageIndex(1);
		
		/** paging */
		statsVO.setPageUnit(20);
		paginationInfo.setCurrentPageNo(statsVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(statsVO.getPageUnit());
		paginationInfo.setPageSize(statsVO.getPageSize());

		
		statsVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		statsVO.setLastIndex(paginationInfo.getLastRecordIndex());
		statsVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List<StatsVO> refreshData =  statsService.getRiverOutlet(statsVO);
		
		int totCnt = statsService.getRiverOutletCnt(statsVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("statsVO", statsVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("detailViewList", refreshData);
		
		modelAndView.setViewName("jsonView");
		//modelAndView.setViewName("waterpolmnt/waterinfo/dischargewater");
		
		return modelAndView;
	}
	
	/**
	 * 상황조치 통계 엑셀출력
	 * @param statsVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getRiverOutletExcel.do")
	public ModelAndView getRiverOutletExcel(
			@ModelAttribute("StatsVO") StatsVO statsVO
	) throws Exception {


		statsVO.setFirstIndex(0);
		statsVO.setRecordCountPerPage(Integer.MAX_VALUE);

		List<StatsVO> refreshData =  statsService.getRiverOutlet(statsVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("data", refreshData);
		map.put("statsVO", statsVO);
	
		ModelAndView mav = null;

		mav = new ModelAndView("ExcelStatsRiverOutletView", "map", map);
		
		return mav;
	}
	
	
	/**
	 * 수질항목관계 화면으로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/goRelateItemAnalysis.do")
	public String goRelateItemAnalysis() throws Exception{
		return "stats/relateItemAnalysis";
	}
	
	/**
	 * 수질항목관계 
	 * 
	 * @param system
	 * @param factCode
	 * @param itemCodeX
	 * @param itemCodeY
	 * @param branchNo
	 * @param startDate
	 * @param endDate
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getRelateItemAnalysis.do")
	public ModelAndView getRelateItemAnalysis(
			@ModelAttribute("StatsVO") StatsVO statsVO
		)
		throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		statsVO.setSort("list");
		
		List<StatsVO> data = new ArrayList<StatsVO>();
		
		this.setItemArray(statsVO.getSystem());
		this.setItemBound(statsVO.getBItemX(), statsVO.getBItemY());
		
		if("T".equals(statsVO.getSystem()))
		{
			data = statsService.getRelateItemAnalysis(statsVO);
			
			Map<String, String> coefCorr = getCoefCorr(data);
			
			modelAndView.addObject("turtur", coefCorr.get("turtur"));
			modelAndView.addObject("turtmp", coefCorr.get("turtmp"));
			modelAndView.addObject("turphy", coefCorr.get("turphy"));
			modelAndView.addObject("turdow", coefCorr.get("turdow"));
			modelAndView.addObject("turcon", coefCorr.get("turcon"));
			
			modelAndView.addObject("tmptur", coefCorr.get("tmptur"));
			modelAndView.addObject("tmptmp", coefCorr.get("tmptmp"));
			modelAndView.addObject("tmpphy", coefCorr.get("tmpphy"));
			modelAndView.addObject("tmpdow", coefCorr.get("tmpdow"));
			modelAndView.addObject("tmpcon", coefCorr.get("tmpcon"));
			
			modelAndView.addObject("phytur", coefCorr.get("phytur"));
			modelAndView.addObject("phytmp", coefCorr.get("phytmp"));
			modelAndView.addObject("phyphy", coefCorr.get("phyphy"));
			modelAndView.addObject("phydow", coefCorr.get("phydow"));
			modelAndView.addObject("phycon", coefCorr.get("phycon"));
			
			modelAndView.addObject("dowtur", coefCorr.get("dowtur"));
			modelAndView.addObject("dowtmp", coefCorr.get("dowtmp"));
			modelAndView.addObject("dowphy", coefCorr.get("dowphy"));
			modelAndView.addObject("dowdow", coefCorr.get("dowdow"));
			modelAndView.addObject("dowcon", coefCorr.get("dowcon"));
			
			modelAndView.addObject("contur", coefCorr.get("contur"));
			modelAndView.addObject("contmp", coefCorr.get("contmp"));
			modelAndView.addObject("conphy", coefCorr.get("conphy"));
			modelAndView.addObject("condow", coefCorr.get("condow"));
			modelAndView.addObject("concon", coefCorr.get("concon"));
			
			modelAndView.addObject("data", data);
			modelAndView.addObject("coefCorr", coefCorr);
			modelAndView.setViewName("jsonView");
		}
		else
		{
			if("U".equals(statsVO.getSystem()))
				lowerX = 0; upperX = 5; lowerY = 0; upperY = 5;
				
			Map<String, String> coefCorr = getCoefCorr2(statsVO);
			
			for(int yIdx = lowerY;yIdx <= upperY;yIdx++)
			{
				for(int xIdx = lowerX;xIdx <= upperX; xIdx++)
				{
					String itemRelate = itemEName[xIdx] + itemEName[yIdx];
					
					modelAndView.addObject(itemRelate, coefCorr.get(itemRelate));
				}
			}
			
			modelAndView.addObject("coefCorr", coefCorr);
			modelAndView.setViewName("jsonView");
		}

		return modelAndView;
	}	
	
	
	/**
	 * 수질유량관계 화면으로 이동
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/goRelateFlowAnalysis.do")
	public String goRelateFlowAnalysis() throws Exception{
		return "stats/relateFlowAnalysis";
	}
	
	
	
	/**
	 * 수질유량관계 
	 * 
	 * @param system
	 * @param factCode
	 * @param itemCodeX
	 * @param itemCodeY
	 * @param branchNo
	 * @param startDate
	 * @param endDate
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getRelateFlowAnalysis.do")
	public ModelAndView getRelateFlowAnalysis(
			@ModelAttribute("StatsVO") StatsVO statsVO
		)
		throws Exception{

		ModelAndView modelAndView = new ModelAndView();
				
		statsVO.setSort("list");

		List<StatsVO> data = new ArrayList<StatsVO>();
		
		
		this.setItemArray(statsVO.getSystem());
		this.setItemBound(statsVO.getBItemX(), statsVO.getBItemY());
		
		if("T".equals(statsVO.getSystem()))
		{
			 data = statsService.getRelateFlowAnalysis(statsVO);
//			if(system.equals("W")) {
//			itemAnalysisStatsList =  statsService.getItemAnalysisStatsTmsList(vo);
//			//} else if(system.equals("A")) {
//			//	itemAnalysisStatsList =  statsService.getItemAnalysisStatsAutoList(vo);
//			} else {
//			itemAnalysisStatsList =  statsService.getItemAnalysisStatsList(vo);
//			}		
			
			Map<String, String> coefCorr = getCoefCorrFlow(data);

			modelAndView.addObject("turwlv", coefCorr.get("turwlv"));
			modelAndView.addObject("turflw", coefCorr.get("turflw"));
			
			modelAndView.addObject("tmpwlv", coefCorr.get("tmpwlv"));
			modelAndView.addObject("tmpflw", coefCorr.get("tmpflw"));
	
			modelAndView.addObject("phywlv", coefCorr.get("phywlv"));
			modelAndView.addObject("phyflw", coefCorr.get("phyflw"));
			
			modelAndView.addObject("dowwlv", coefCorr.get("dowwlv"));
			modelAndView.addObject("dowflw", coefCorr.get("dowflw"));
			
			modelAndView.addObject("conwlv", coefCorr.get("conwlv"));
			modelAndView.addObject("conflw", coefCorr.get("conflw"));
		
			modelAndView.addObject("data", data);
			modelAndView.addObject("coefCorr", coefCorr);
			modelAndView.setViewName("jsonView");
		}
		else
		{
			if("U".equals(statsVO.getSystem()))
				lowerX = 0; upperX = 5;
				
			Map<String, String> coefCorr = getCoefCorr_flow(statsVO);
			
			for(int yIdx = 0;yIdx <= 1;yIdx++)
			{
				for(int xIdx = lowerX;xIdx <= upperX; xIdx++)
				{
					String itemRelate = itemEName[xIdx] + itemEName2[yIdx];
					
					modelAndView.addObject(itemRelate, coefCorr.get(itemRelate));
				}
			}
			
			modelAndView.addObject("coefCorr", coefCorr);
			modelAndView.setViewName("jsonView");
		}
		

		return modelAndView;
	}	
	
	
	@RequestMapping("/stats/goRelateFlowGraph.do")
	public String goRelateFlowGraph() throws Exception
	{
		return "stats/relateFlowGraph";
	}
	
	@RequestMapping("/stats/getRelateFlowGraph.do")
	public ModelAndView getRelateFlowGraph(
			@ModelAttribute("StatsVO") StatsVO statsVO,
			@RequestParam(value="width") String width,
			@RequestParam(value="height") String height
	) throws Exception
	{
		SearchTaksuVO svo = new SearchTaksuVO();
		svo.setGongku(statsVO.getFactCodeX());
		svo.setChukjeongso(statsVO.getBranchNoX());
		String factNameX = waterinfoService.getBranchName(svo).getChukjeongso();
		
		svo.setGongku(statsVO.getFactCodeY());
		svo.setChukjeongso(statsVO.getBranchNoY());
		String factNameY = waterinfoService.getFlowOBSName(svo).getGongku();
		
		String itemCodeX = statsVO.getItemCodeX() + "X";
		String itemCodeY = statsVO.getItemCodeY() + "Y";
		
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add(itemCodeX);
		itemCodeList.add(itemCodeY);

		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add(factNameX);
		itemNameList.add(factNameY);
		
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}

		//getData
		List<StatsVO> graphDataList = statsService.getRelateFlowGraph(statsVO);

		int voCount = 0;

		
		for(StatsVO detailData : graphDataList) {
			
		
			if(detailData.getValueX() != null)
			{
				List data =  dataMap.get(itemCodeX);
				Map valMap = new HashMap();
				valMap = new HashMap();
				valMap.put("x", detailData.getTime());
				valMap.put("y", detailData.getValueX().replaceAll(",", ""));
				data.add(valMap);
				dataMap.put(itemCodeX, data);
				voCount++;
			}
			
			if(detailData.getValueY() != null)
			{
				List data =  dataMap.get(itemCodeY);
				Map valMap = new HashMap();
				valMap.put("x", detailData.getTime());
				valMap.put("y", detailData.getValueY().replaceAll(",", ""));
				data.add(valMap);
				dataMap.put(itemCodeY, data);
				voCount++;
			}
		}
		
		
		if(voCount == 0)
		{
			itemNameList = new ArrayList<String>();
			itemCodeList = new ArrayList<String>();
			
			itemNameList.add("조회결과가 없습니다");
			itemCodeList.add("XXX");
			
			for(int i = 0 ; i < 20 ; i++)
			{
				dataMap.put("XXX", new ArrayList());
				
				List data = dataMap.get("XXX");
				
				Map valMap = new HashMap();
				valMap.put("x",  "");
				valMap.put("y", "0");
				data.add(valMap);
				dataMap.put("XXX", data);
				
				voCount ++;
			}
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append("");

		ModelAndView modelAndView = new ModelAndView();
		
		
		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("itemCodeX", itemCodeX);
		modelAndView.addObject("itemCodeY", itemCodeY);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("sys",statsVO.getSysKind());
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 1);
		modelAndView.addObject("legBox", "Y");
		
		modelAndView.setViewName("relateChartView");
		return modelAndView;
	}
	
	
	
	@RequestMapping("/stats/goRelateItemGraph.do")
	public String goRelateItemGraph()
		throws Exception{
		return "stats/relateItemGraph";
	}
	
	@RequestMapping("/stats/getRelateItemGraph.do")
	public ModelAndView getRelateItemGraph(
			@ModelAttribute("StatsVO") StatsVO statsVO,
			@RequestParam(value="width") String width,
			@RequestParam(value="height") String height
	) throws Exception
	{
		SearchTaksuVO svo = new SearchTaksuVO();
		svo.setGongku(statsVO.getFactCodeX());
		svo.setChukjeongso(statsVO.getBranchNoX());
		String factNameX = waterinfoService.getBranchName(svo).getChukjeongso();
		
		svo.setGongku(statsVO.getFactCodeY());
		svo.setChukjeongso(statsVO.getBranchNoY());
		String factNameY = waterinfoService.getBranchName(svo).getChukjeongso();
		
		String itemCodeX = statsVO.getItemCodeX() + "X";
		String itemCodeY = statsVO.getItemCodeY() + "Y";
		
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add(itemCodeX);
		itemCodeList.add(itemCodeY);

		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add(factNameX);
		itemNameList.add(factNameY);
		
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}

		//getData
		List<StatsVO> graphDataList = statsService.getRelateItemGraph(statsVO);

		int voCount = 0;

		
		for(StatsVO detailData : graphDataList) {
			
		
			if(detailData.getValueX() != null)
			{
				List data =  dataMap.get(itemCodeX);
				Map valMap = new HashMap();
				valMap = new HashMap();
				valMap.put("x", detailData.getTime());
				valMap.put("y", detailData.getValueX().replaceAll(",", ""));
				data.add(valMap);
				dataMap.put(itemCodeX, data);
				voCount++;
			}
			
			if(detailData.getValueY() != null)
			{
				List data =  dataMap.get(itemCodeY);
				Map valMap = new HashMap();
				valMap.put("x", detailData.getTime());
				valMap.put("y", detailData.getValueY().replaceAll(",", ""));
				data.add(valMap);
				dataMap.put(itemCodeY, data);
				voCount++;
			}
		}
		
		
		if(voCount == 0)
		{
			itemNameList = new ArrayList<String>();
			itemCodeList = new ArrayList<String>();
			
			itemNameList.add("조회결과가 없습니다");
			itemCodeList.add("XXX");
			
			for(int i = 0 ; i < 20 ; i++)
			{
				dataMap.put("XXX", new ArrayList());
				
				List data = dataMap.get("XXX");
				
				Map valMap = new HashMap();
				valMap.put("x",  "");
				valMap.put("y", "0");
				data.add(valMap);
				dataMap.put("XXX", data);
				
				voCount ++;
			}
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		
		StringBuffer title = new StringBuffer();
		title.append("");

		ModelAndView modelAndView = new ModelAndView();
		
		
		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("itemCodeX", itemCodeX);
		modelAndView.addObject("itemCodeY", itemCodeY);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("sys",statsVO.getSysKind());
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 1);
		modelAndView.addObject("legBox", "Y");
		
		modelAndView.setViewName("relateChartView");
		return modelAndView;
	}
}
