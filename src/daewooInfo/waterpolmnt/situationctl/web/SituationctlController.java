package daewooInfo.waterpolmnt.situationctl.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.beanutils.BeanUtils;
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
import daewooInfo.warehouse.bean.WareHouseSearchVO;
import daewooInfo.waterpolmnt.situationctl.bean.AlertTargetVO;
import daewooInfo.waterpolmnt.situationctl.bean.AutoDataVO;
import daewooInfo.waterpolmnt.situationctl.bean.FactLawVO;
import daewooInfo.waterpolmnt.situationctl.bean.FactLocationVO;
import daewooInfo.waterpolmnt.situationctl.bean.MainChartVO;
import daewooInfo.waterpolmnt.situationctl.bean.ResultChartVO;
import daewooInfo.waterpolmnt.situationctl.bean.SearchTaksuMainVO;
import daewooInfo.waterpolmnt.situationctl.bean.SearchTaksuPopupVO;
import daewooInfo.waterpolmnt.situationctl.bean.SearchTaksuSumDataVO;
import daewooInfo.waterpolmnt.situationctl.bean.SeqInfoVO;
import daewooInfo.waterpolmnt.situationctl.bean.TaksuMainVO;
import daewooInfo.waterpolmnt.situationctl.bean.TaksuPopupVO;
import daewooInfo.waterpolmnt.situationctl.bean.TaksuTopDataVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntMainDetailSearchTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntMainDetailTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntMainSearchTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntMainSearchVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntMainVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntNorecvSearchTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntNorecvTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntSummaryVO;
import daewooInfo.waterpolmnt.situationctl.bean.WatersysMntCoordVO;
import daewooInfo.waterpolmnt.situationctl.bean.WatersysMntMainDetailSearchTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.WatersysMntMainDetailTSVO;
import daewooInfo.waterpolmnt.situationctl.service.SituationctlService;
import daewooInfo.waterpolmnt.waterinfo.bean.AirMntDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.AlgaCastDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.BoSearchVO;
import daewooInfo.waterpolmnt.waterinfo.bean.DamViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.DetailViewVO;
import daewooInfo.waterpolmnt.waterinfo.service.WaterinfoService;
import daewooInfo.weather.service.WeatherService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @author DaeWoo Information Systems Co., Ltd. Technical Expert Team.
 *		 loafzzang.
 * @version 1.0
 * @Class Name : MonitoringController.java
 * @Description : monitoring Controller Class
 * @Modification Information @ @ Modify Date author Modify Contents @
 *				-------------- ------------ ------------------------------- @
 *				2010. 1. 21 loafzzang new
 * @see Copyright (C) by DaeWoo Information Systems Co., Ltd. All right
 *	  reserved.
 * @since 2010. 1. 21
 */

@Controller
public class SituationctlController{
	/**
	 * @uml.property  name="logger"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log logger = LogFactory.getLog(SituationctlController.class);
	
	/**
	 * @uml.property  name="situationctlService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "situationctlService")
	private SituationctlService situationctlService;
	
	/**
	 * @uml.property  name="weatherService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="weatherService")
	private WeatherService weatherService;
	
	/**
	 * @uml.property  name="waterinfoService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "waterinfoService")
	private WaterinfoService waterinfoService;
	
	/**
	 * @uml.property  name="alertLawService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertLawService")
	private AlertLawService alertLawService;
	
	/**
	 * @uml.property  name="propertyService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;	
	
	// 메인(로그인후) - 측정값 조회
	@RequestMapping("/waterpolmnt/situationctl/goDetailRIVERMAIN.do")
	public String goDetailRIVERMAIN() throws Exception{
		return "../main";
	}

	// 메인(로그인후) - 측정값 조회
	@RequestMapping("/waterpolmnt/situationctl/getDetailRIVERMAIN.do")
	public ModelAndView getDetailRIVERMAIN(
			@RequestParam(value="sys", required=false) String sys,
			@RequestParam(value="step", required=false) String step
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuMainVO searchTaksuMainVO = new SearchTaksuMainVO();
		
		searchTaksuMainVO.setSys(sys);
		searchTaksuMainVO.setStep(step);
		List<TaksuMainVO> refreshData =  situationctlService.getDetailRIVERMAIN(searchTaksuMainVO);
		
		modelAndView.addObject("refreshData", refreshData);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 통합감시 - 통계표 조회
	@RequestMapping("/waterpolmnt/situationctl/getTotalMntMainTopTS.do")
	public ModelAndView getTotalMntMainTopTS() throws Exception{
		
		List totalData = situationctlService.getTotalMntMainTopTS();
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("totalData", totalData);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}

	// 통합감시 - 측정값 조회
	@RequestMapping("/waterpolmnt/situationctl/goTotalMntMainTS.do")
	public ModelAndView goTotalMntMainTS() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		HashMap<String, Integer> riverSqCnt = new HashMap<String, Integer>();
		
		riverSqCnt.put("R01", weatherService.getLastSeq("R01"));
		riverSqCnt.put("R02", weatherService.getLastSeq("R02"));
		riverSqCnt.put("R03", weatherService.getLastSeq("R03"));
		riverSqCnt.put("R04", weatherService.getLastSeq("R04"));
		
		modelAndView.addObject("riverSqCnt", riverSqCnt);
		
		modelAndView.setViewName("/waterpolmnt/situationctl/totalmnt");
		
		return modelAndView;
	}
	
	
 // 통합감시 - 측정값 조회(전체)
	@RequestMapping("/waterpolmnt/situationctl/getTotalMntMain.do")
	public ModelAndView getTotalMntMain(
			@RequestParam(value="sys", required=false) String sys,
			@RequestParam(value="item", required=false) String item,
			@RequestParam(value="river_div", required=false) String river_div
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		TotalMntMainSearchVO totalMntMainSearchVO = new TotalMntMainSearchVO();
		
		totalMntMainSearchVO.setSys(sys);
		totalMntMainSearchVO.setItem(item);
		totalMntMainSearchVO.setRiver_div(river_div);
		
		List<TotalMntMainVO> refreshData =  situationctlService.getTotalMntMain(totalMntMainSearchVO);
		
		modelAndView.addObject("refreshData", refreshData);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	
	// 통합감시 - 측정값 조회(한강)
	@RequestMapping("/waterpolmnt/situationctl/getTotalMntMainR01.do")
	public ModelAndView getTotalMntMainR01(
			@RequestParam(value="sys", required=false) String sys,
			@RequestParam(value="item", required=false) String item
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		TotalMntMainSearchVO totalMntMainSearchVO = new TotalMntMainSearchVO();
		
		totalMntMainSearchVO.setSys(sys);
		totalMntMainSearchVO.setItem(item);
		
		try{
			List<TotalMntMainVO> refreshData =  situationctlService.getTotalMntMainR01(totalMntMainSearchVO);
			modelAndView.addObject("refreshData", refreshData);
		}catch(Exception e){
			e.printStackTrace();
		}
//		List<ResultChartVO> graphDataList = situationctlService.getRiverMainChart(vo);
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	
	// 통합감시 - 측정값 조회(금강)
	@RequestMapping("/waterpolmnt/situationctl/getTotalMntMainR03.do")
	public ModelAndView getTotalMntMainR03(
			@RequestParam(value="sys", required=false) String sys,
			@RequestParam(value="item", required=false) String item
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		TotalMntMainSearchVO totalMntMainSearchVO = new TotalMntMainSearchVO();
		
		totalMntMainSearchVO.setSys(sys);
		totalMntMainSearchVO.setItem(item);
		List<TotalMntMainVO> refreshData =  situationctlService.getTotalMntMainR03(totalMntMainSearchVO);
		
		modelAndView.addObject("refreshData", refreshData);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	
	 // 통합감시 - 측정값 조회(낙동강)
	@RequestMapping("/waterpolmnt/situationctl/getTotalMntMainR02.do")
	public ModelAndView getTotalMntMainR02(
			@RequestParam(value="sys", required=false) String sys,
			@RequestParam(value="item", required=false) String item
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		TotalMntMainSearchVO totalMntMainSearchVO = new TotalMntMainSearchVO();
		
		totalMntMainSearchVO.setSys(sys);
		totalMntMainSearchVO.setItem(item);
		List<TotalMntMainVO> refreshData =  situationctlService.getTotalMntMainR02(totalMntMainSearchVO);
		
		modelAndView.addObject("refreshData", refreshData);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}	
	
	
	 // 통합감시 - 측정값 조회(영산강)
	@RequestMapping("/waterpolmnt/situationctl/getTotalMntMainR04.do")
	public ModelAndView getTotalMntMainR04(
			@RequestParam(value="sys", required=false) String sys,
			@RequestParam(value="item", required=false) String item
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		TotalMntMainSearchVO totalMntMainSearchVO = new TotalMntMainSearchVO();
		
		totalMntMainSearchVO.setSys(sys);
		totalMntMainSearchVO.setItem(item);
		List<TotalMntMainVO> refreshData =  situationctlService.getTotalMntMainR04(totalMntMainSearchVO);
		
		modelAndView.addObject("refreshData", refreshData);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	
	// 통합감시 - 상세정보보기
	@RequestMapping("/waterpolmnt/situationctl/goTotalMntSummary.do")
	public String goTotalMntSummary() throws Exception{
		return "/waterpolmnt/situationctl/totalmntpopsummary";
	}
  
	
	// 통합감시 - 상세정보 조회
	@RequestMapping("/waterpolmnt/situationctl/getTotalMntSummary.do")
	public ModelAndView getTotalMntSummaryl(
			@RequestParam(value="sys", required=false) String sys,
			@RequestParam(value="river", required=false) String river,
			@RequestParam(value="step", required=false) String step
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		TotalMntMainSearchTSVO totalMntMainSearchTSVO = new TotalMntMainSearchTSVO();
		
		totalMntMainSearchTSVO.setSys(sys);
		totalMntMainSearchTSVO.setRiver(river);
		totalMntMainSearchTSVO.setStep(step);
		
		List<TotalMntSummaryVO> refreshData =  situationctlService.getTotalMntSummary(totalMntMainSearchTSVO);
		
		modelAndView.addObject("refreshData", refreshData);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
  
	
	// 통합감시 - 측정값 조회(세부팝업)
	@RequestMapping("/waterpolmnt/situationctl/goTotalMntMainDetailTS.do")
	public String goTotalMntMainDetailTS() throws Exception{
		return "/waterpolmnt/situationctl/totalmntpopdetail";
	}

	
	// 통합감시 - 측정값 조회(세부팝업)
	@RequestMapping("/waterpolmnt/situationctl/getTotalMntMainDetailTS.do")
	public ModelAndView getTotalMntMainDetailTS(
			@RequestParam(value="fact_code", required=false) String fact_code,
			@RequestParam(value="branch_no", required=false) String branch_no,
			@RequestParam(value="sys_kind", required=false) String sys_kind
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		TotalMntMainDetailSearchTSVO totalMntMainDetailSearchTSVO = new TotalMntMainDetailSearchTSVO();
		
		totalMntMainDetailSearchTSVO.setFact_code(fact_code);
		totalMntMainDetailSearchTSVO.setBranch_no(branch_no);
		totalMntMainDetailSearchTSVO.setSys(sys_kind);
		totalMntMainDetailSearchTSVO.setOrderby("desc");

		List<TotalMntMainDetailTSVO> refreshData =  situationctlService.getTotalMntMainDetailTS(totalMntMainDetailSearchTSVO);
		
		modelAndView.addObject("refreshData", refreshData);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}

	/**
	 * 4대강 공사 통합감시
	 */
	  @RequestMapping("/waterpolmnt/situationctl/goConstruct_totalmnt.do")
	  public ModelAndView goConstruct_totalmnt() throws Exception{
		  
		ModelAndView modelAndView = new ModelAndView();
		
		HashMap<String, Integer> riverSqCnt = new HashMap<String, Integer>();
		
		riverSqCnt.put("R01", weatherService.getLastSeq("R01"));
		riverSqCnt.put("R02", weatherService.getLastSeq("R02"));
		riverSqCnt.put("R03", weatherService.getLastSeq("R03"));
		riverSqCnt.put("R04", weatherService.getLastSeq("R04"));
		
		modelAndView.addObject("riverSqCnt", riverSqCnt);
		
		modelAndView.setViewName("/waterpolmnt/situationctl/construct_totalmnt");
		
		return modelAndView;
		
	  }
  
	@RequestMapping("/waterpolmnt/situationctl/goTotalmntpopAlertList.do")
	public String goTotalmntpopAlertList() throws Exception{
		return "/waterpolmnt/situationctl/totalmntpopalertlist";
	}
	
	// 통합감시 - 측정값 조회(세부팝업-상황전파자)
	@RequestMapping("/waterpolmnt/situationctl/goAlertTargetList.do")
	public String goAlertTargetList() throws Exception{
		return "/waterpolmnt/situationctl/totalmntpopbranchadmininfo";
	}
	
	// 통합감시 - 측정값 조회(세부팝업-상황전파자)
	@RequestMapping("/waterpolmnt/situationctl/getAlertTargetList.do")
	public ModelAndView getAlertTargetList(
			@RequestParam(value="factCode", required=false) String factCode
			,@RequestParam(value="branchNo", required=false) String branchNo
			,@RequestParam(value="dept", required=false) String dept
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	

		AlertTargetVO alertTargetVO = new AlertTargetVO();
		alertTargetVO.setFactCode(factCode);
		alertTargetVO.setBranchNo(Integer.parseInt(branchNo));
		alertTargetVO.setDept(dept);
//		alertTargetVO.setAtDepth(atDepth);

		List<AlertTargetVO> refreshData =  situationctlService.getAlertTargetList(alertTargetVO);

		modelAndView.addObject("refreshData", refreshData);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}	
	
	// 통합감시 - 측정값 조회(세부팝업-세부팝업 그래프)
	@RequestMapping("/waterpolmnt/situationctl/getTotalMntDetailGraph.do")
	public ModelAndView getTotalMntDetailGraph(
			@RequestParam(value="factCode", required=false) String factCode
			,@RequestParam(value="branchNo", required=false) String branchNo
			,@RequestParam(value="branchName", required=false) String branchName
			,@RequestParam(value="sys_kind", required=false) String sys_kind
			,@RequestParam(value="width", required=false) String width
			,@RequestParam(value="height", required=false) String height
			,@RequestParam(value="item", required=false) String item
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	

		TotalMntMainDetailSearchTSVO totalMntMainDetailSearchTSVO = new TotalMntMainDetailSearchTSVO();
		
		
		//일반항목의 경우 외부 항목부터 검사
		if("PHY00".equals(item))
			item = "PHY01";
		else if("DOW00".equals(item))
			item = "DOW01";
		else if("CON00".equals(item))
			item = "CON01";
		else if("TMP00".equals(item))
			item = "TMP01";
			
		
		totalMntMainDetailSearchTSVO.setFact_code(factCode);
		totalMntMainDetailSearchTSVO.setBranch_no(branchNo);
		totalMntMainDetailSearchTSVO.setSys(sys_kind);
		totalMntMainDetailSearchTSVO.setItem(item);
	
		
		
		
		totalMntMainDetailSearchTSVO.setOrderby("asc");

	
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		if(sys_kind.equals("U"))
		{
			
			itemCodeList.add("TUR");
			itemCodeList.add("TMP");
			itemCodeList.add("PHY");
			itemCodeList.add("DOW");
			itemCodeList.add("CON");
			itemCodeList.add("TOF");
		}
		else if(sys_kind.equals("A"))
		{
			itemCodeList.add(item);
		}
		else
		{
			itemCodeList.add("PHY");
			itemCodeList.add("BOD");
			itemCodeList.add("COD");
			itemCodeList.add("SUS");
			itemCodeList.add("TON");
			itemCodeList.add("TOP");
		}
		
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			itemCount++;
		}

		List<TotalMntMainDetailTSVO> graphDataList =  situationctlService.getTotalMntMainDetailTSGraph(totalMntMainDetailSearchTSVO);
		
		if("PHY01".equals(item) || "DOW01".equals(item) || "CON01".equals(item) || "TMP01".equals(item))
		{
			int cnt = 0;
			for(TotalMntMainDetailTSVO data : graphDataList)
			{
				if(data.getMin_vl() != null)
					cnt++;
			}
			
			//일반항목 외부로 검색한 결과가 없으면 내부항목으로 다시검색
			if(cnt == 0)
			{
				item = item.substring(0,3) + "00";
				totalMntMainDetailSearchTSVO.setItem(item);
				
				graphDataList = situationctlService.getTotalMntMainDetailTSGraph(totalMntMainDetailSearchTSVO);
				
				itemCodeList = new ArrayList<String>();
				
				if(!"A".equals(sys_kind))
					itemCodeList.add(item.substring(0,3));
				else
					itemCodeList.add(item);
				
				itemCount = 0;
				for(String code : itemCodeList) {
					dataMap.put(code, new ArrayList());
					constantMap.put(code,null);
					itemCount++;
				}
			}
		}
			
		

		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		
		if(sys_kind.equals("U"))
		{
			itemNameList.add("탁도");
			itemNameList.add("수온");
			itemNameList.add("pH");
			itemNameList.add("DO");
			itemNameList.add("전기전도도");
			itemNameList.add("Chl-a");
		}
		else if(sys_kind.equals("A"))
		{
			if(graphDataList.size() > 0)
				itemNameList.add(graphDataList.get(0).getItem_name());
		}
		else
		{
			itemNameList.add("pH");
			itemNameList.add("BOD");
			itemNameList.add("COD");
			itemNameList.add("SS");
			itemNameList.add("T-N");
			itemNameList.add("T-P");
		}
		
		
		int voCount = 0;
		
		//if(sys_kind.equals("A"))
		//{
			if(graphDataList.size() == 0)
			{
				itemNameList = new ArrayList<String>();
				itemCodeList = new ArrayList<String>();
				dataMap = new HashMap();
				
				itemNameList.add("조회결과가 없습니다");
				itemCodeList.add("none");
				dataMap.put("none", new ArrayList<String>());
				
				
				for(int i = 0 ; i < 20 ; i++)
				{
					List data = dataMap.get("none");
					
					Map valMap = new HashMap();
					valMap.put("x",  "");
					valMap.put("y", "0.00");
					data.add(valMap);
					dataMap.put("none", data);
					
					voCount ++;
				}
			}
		//}
		
			
		int turCnt = 0;
		int dowCnt = 0;
		int tmpCnt = 0;
		int phyCnt = 0;
		int bodCnt = 0;
		int codCnt = 0;
		int susCnt = 0;
		int topCnt = 0;
		int tonCnt = 0;
		int conCnt = 0;
		int tofCnt = 0;
		String a_itemcode = "";
		
		for(TotalMntMainDetailTSVO detailData : graphDataList) {
	
			if(sys_kind.equals("U"))
			{
				
				if("all".equals(item) || "TUR00".equals(item))
				{
						List data =  dataMap.get("TUR");
						Map valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", detailData.getStrtime());
						valMap.put("y", detailData.getTur());
						data.add(valMap);
						dataMap.put("TUR", data);
						
						if(detailData.getTur() != null)
							turCnt++;
				}
				
				if("all".equals(item) || "DOW00".equals(item))
				{
						List data =  dataMap.get("DOW");
						Map valMap = new HashMap();
						valMap.put("x", detailData.getStrtime());
						valMap.put("y", detailData.getDow());
						data.add(valMap);
						dataMap.put("DOW", data);
						
						if(detailData.getDow() != null)
							dowCnt++;
				}
				
				if("all".equals(item) || "TMP00".equals(item))
				{
						List data =  dataMap.get("TMP");
						Map valMap = new HashMap();
						valMap.put("x", detailData.getStrtime());
						valMap.put("y", detailData.getTmp());
						data.add(valMap);
						dataMap.put("TMP", data);
						
						if(detailData.getTmp() != null)
							tmpCnt++;
				}
				
				if("all".equals(item) || "PHY00".equals(item))
				{
						List data =  dataMap.get("PHY");
						Map valMap = new HashMap();
						valMap.put("x", detailData.getStrtime());
						valMap.put("y", detailData.getPhy());
						data.add(valMap);
						dataMap.put("PHY", data);
						
						if(detailData.getPhy() != null)
							phyCnt++;
				}
				
				if("all".equals(item) || "CON00".equals(item))
				{
						List data =  dataMap.get("CON");
						Map valMap = new HashMap();
						valMap.put("x", detailData.getStrtime());
						valMap.put("y", detailData.getCon());
						data.add(valMap);
						dataMap.put("CON", data);
						
						if(detailData.getCon() != null)
							conCnt++;
				}
				
				if("U".equals(sys_kind) && ("all".equals(item) || "TOF00".equals(item)))
				{
					List data =  dataMap.get("TOF");
					Map valMap = new HashMap();
					valMap.put("x", detailData.getStrtime());
					valMap.put("y", detailData.getTof());
					data.add(valMap);
					dataMap.put("TOF", data);
					
					if(detailData.getTof() != null)
						tofCnt++;
				}
			}
			else if(sys_kind.equals("A"))
			{
					List data = dataMap.get(item);
					
					Map valMap = new HashMap();
					valMap.put("x",  detailData.getStrtime());
					
					if(item.toUpperCase().indexOf("VOC") > -1){
						if(Integer.parseInt(item.substring(3)) < 10) {
							a_itemcode = item.replace("0", "");
						}else{
							a_itemcode = item;
						}
					}else{
						a_itemcode = item.substring(0,3);
					}
					valMap.put("y", BeanUtils.getProperty(detailData, a_itemcode.toLowerCase()));
					data.add(valMap);
					dataMap.put(item, data);
			}
			else
			{
				if("all".equals(item) || "PHY00".equals(item))
				{
						List data =  dataMap.get("PHY");
						Map valMap = new HashMap();
						valMap = new HashMap();
						valMap.put("x", detailData.getStrtime());
						valMap.put("y", detailData.getPhy());
						data.add(valMap);
						dataMap.put("PHY", data);
						
						if(detailData.getPhy() != null)
							phyCnt++;
				}
				
				if("all".equals(item) || "BOD00".equals(item))
				{
						List data =  dataMap.get("BOD");
						Map valMap = new HashMap();
						valMap.put("x", detailData.getStrtime());
						valMap.put("y", detailData.getBod());
						data.add(valMap);
						dataMap.put("BOD", data);
						
						if(detailData.getBod() != null)
							bodCnt++;
				}
				
				if("all".equals(item) || "COD00".equals(item))
				{
						List data =  dataMap.get("COD");
						Map valMap = new HashMap();
						valMap.put("x", detailData.getStrtime());
						valMap.put("y", detailData.getCod());
						data.add(valMap);
						dataMap.put("COD", data);
						
						if(detailData.getCod() != null)
							codCnt++;
				}
				
				if("all".equals(item) || "SUS00".equals(item))
				{
						List data =  dataMap.get("SUS");
						Map valMap = new HashMap();
						valMap.put("x", detailData.getStrtime());
						valMap.put("y", detailData.getSus());
						data.add(valMap);
						dataMap.put("SUS", data);
						
						if(detailData.getSus() != null)
							susCnt++;
				}
				
				if("all".equals(item) || "TOP00".equals(item))
				{
						List data =  dataMap.get("TOP");
						Map valMap = new HashMap();
						valMap.put("x", detailData.getStrtime());
						valMap.put("y", detailData.getTop());
						data.add(valMap);
						dataMap.put("TOP", data);
						
						if(detailData.getTop() != null)
							topCnt++;
				}
				
				if(("all".equals(item) || "TON00".equals(item)))
				{
					List data =  dataMap.get("TON");
					Map valMap = new HashMap();
					valMap.put("x", detailData.getStrtime());
					valMap.put("y", detailData.getTon());
					data.add(valMap);
					dataMap.put("TON", data);
					
					if(detailData.getTon() != null)
						tonCnt++;
				}
			}
//			List data = dataMap.get(taksuVO.get .getItemCode().substring(0, 3));
			
//			Map valMap = new HashMap();
//			valMap.put("x", 
//							"[" + taksuVO.getStrDate() + " " + taksuVO.getStrTime() + "]" + 
//							"\n" + taksuVO.getFactName() +
//							"\n" + taksuVO.getWastNo() + "측정소"
//							);
//			valMap.put("y", taksuVO.getMinVl());
			
//			data.add(valMap);
//			dataMap.put(taksuVO.getItemCode().substring(0, 3), data);

			voCount++;
		}
		
		if(graphDataList.size() != 0 && !"A".equals(sys_kind))
		{
			if(turCnt == 0)
			{
				itemNameList.remove("탁도");
				itemCodeList.remove("TUR");
			}
			if(phyCnt == 0)
			{
				itemNameList.remove("pH");
				itemCodeList.remove("PHY");
			}
			if(dowCnt == 0)
			{
				itemNameList.remove("DO");
				itemCodeList.remove("DOW");
			}
			if(conCnt == 0)
			{
				itemNameList.remove("전기전도도");
				itemCodeList.remove("CON");
			}
			if(tmpCnt == 0)
			{
				itemNameList.remove("수온");
				itemCodeList.remove("TMP");
			}
			if("U".equals(sys_kind) && tofCnt == 0)
			{
				itemNameList.remove("Chl-a");
				itemCodeList.remove("TOF");
			}
			
			if(bodCnt == 0)
			{
				itemNameList.remove("BOD");
				itemCodeList.remove("BOD");
			}
			
			if(codCnt == 0)
			{
				itemNameList.remove("COD");
				itemCodeList.remove("COD");
			}
			
			if(susCnt == 0)
			{
				itemNameList.remove("SS");
				itemCodeList.remove("SUS");
			}

			if(topCnt == 0)
			{
				itemNameList.remove("T-P");
				itemCodeList.remove("TOP");
			}
			
			if(tonCnt == 0)
			{
				itemNameList.remove("T-N");
				itemCodeList.remove("TON");
			}
			
			if(tmpCnt == 0)
			{
				itemNameList.remove("수온");
				itemCodeList.remove("TMP");
			}
		}
		
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		StringBuffer title = new StringBuffer();
		title.append("");

		try
		{
			Double lawVl = null;
			if("T".equals(sys_kind))
			{
				/*if(itemCodeList.size() == 1 && "PHY".equals(itemCodeList.get(0)))
				{
					AlertSearchVO vo = new AlertSearchVO();
					vo.setFactCode(factCode);
					vo.setBranchNo(Integer.parseInt(branchNo));
					vo.setItemCode("PHY00");
					
					AlertDataLawVo lawData = alertLawService.getFactLaw(vo);
					
					modelAndView.addObject("lawVl", lawData.getLawHValue());
				}*/
			}
		}
		catch(Exception ex)
		{
			
		}
		
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
		modelAndView.addObject("sys", sys_kind);
		
		//if(sys_kind.equals("A"))
		//	modelAndView.addObject("legBox","N");
		//else
			modelAndView.addObject("legBox", "Y");
		
		modelAndView.setViewName("chartView");
		
		return modelAndView;
	}	
	
	
	
	// 통합감시 - 측정값 조회(세부팝업-세부팝업 그래프)
	@RequestMapping("/waterpolmnt/situationctl/getTotalMntDetailGraph_compare.do")
	public ModelAndView getTotalMntDetailGraph_compare(
			@RequestParam(value="factCode", required=false) String factCode
			,@RequestParam(value="branchNo", required=false) String branchNo
			,@RequestParam(value="branchName", required=false) String branchName
			,@RequestParam(value="sys_kind", required=false) String sys_kind
			,@RequestParam(value="width", required=false) String width
			,@RequestParam(value="height", required=false) String height
			,@RequestParam(value="item", required=false) String item
			,@RequestParam(value="compareDate", required=false) String compareDate
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	

		TotalMntMainDetailSearchTSVO totalMntMainDetailSearchTSVO = new TotalMntMainDetailSearchTSVO();
		
		//일반항목의 경우 외부 항목부터 검사
		if("PHY00".equals(item))
			item = "PHY01";
		else if("DOW00".equals(item))
			item = "DOW01";
		else if("CON00".equals(item))
			item = "CON01";
		else if("TMP00".equals(item))
			item = "TMP01";
		
		totalMntMainDetailSearchTSVO.setFact_code(factCode);
		totalMntMainDetailSearchTSVO.setBranch_no(branchNo);
		totalMntMainDetailSearchTSVO.setSys(sys_kind);
		totalMntMainDetailSearchTSVO.setItem(item);
		totalMntMainDetailSearchTSVO.setCompareDate(compareDate);
		
		totalMntMainDetailSearchTSVO.setOrderby("asc");

	
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add(item); // 현재 일
		itemCodeList.add("compare"); // 비교 날짜 설정 일
		

		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			itemCount++;
		}

		List<TotalMntMainDetailTSVO> graphDataList =  situationctlService.getTotalMntMainDetailTSGraph_compare(totalMntMainDetailSearchTSVO);

		
		if("PHY01".equals(item) || "DOW01".equals(item) || "CON01".equals(item) || "TMP01".equals(item))
		{
			//일반항목 외부로 검색한 결과가 없으면 내부항목으로 다시검색
			if(graphDataList.size() == 0)
			{
				item = item.substring(0,3) + "00";
				totalMntMainDetailSearchTSVO.setItem(item);
				//System.out.println("#################################################################");
				//System.out.println("#################################################################");
				//System.out.println("#################################################################");
				graphDataList = situationctlService.getTotalMntMainDetailTSGraph_compare(totalMntMainDetailSearchTSVO);
				//System.out.println("#################################################################");
				//System.out.println("#################################################################");
				//System.out.println("#################################################################");
				
				itemCodeList = new ArrayList<String>();
				itemCodeList.add(item);
				
				itemCount = 0;
				for(String code : itemCodeList) {
					dataMap.put(code, new ArrayList());
					constantMap.put(code,null);
					itemCount++;
				}
			}
		}
		
		
		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("오늘");
		itemNameList.add("비교일");
	
		int voCount = 0;
		
		if(sys_kind.equals("A"))
		{
			if(graphDataList.size() == 0)
			{
				itemNameList.add("조회결과가 없습니다");
				
				for(int i = 0 ; i < 20 ; i++)
				{
					List data = dataMap.get(item);
					
					Map valMap = new HashMap();
					valMap.put("x",  "");
					valMap.put("y", "0.00");
					data.add(valMap);
					dataMap.put(item, data);
					
					voCount ++;
				}
			}
		}
		
		for(TotalMntMainDetailTSVO detailData : graphDataList) {
	
			if(detailData.getMin_vl() != null)
			{
				List data = dataMap.get(item);
				
				Map valMap = new HashMap();
				valMap.put("x",  detailData.getMin_time().substring(10));
				valMap.put("y", detailData.getMin_vl());
				data.add(valMap);
				dataMap.put(item, data);
			}
			
			if(detailData.getMin_vl2() != null)
			{
				List data = dataMap.get("compare");
				
				Map valMap = new HashMap();
				valMap.put("x",  detailData.getMin_time().substring(10));
				valMap.put("y", detailData.getMin_vl2());
				data.add(valMap);
				dataMap.put("compare", data);
			}

			voCount++;
		}
		
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		StringBuffer title = new StringBuffer();
		title.append("");
		
		
		try
		{
			Double lawVl = null;
			if("T".equals(sys_kind))
			{
				if(itemCodeList.size() == 1 && "TUR".equals(itemCodeList.get(0)))
				{
					AlertSearchVO vo = new AlertSearchVO();
					vo.setFactCode(factCode);
					vo.setBranchNo(Integer.parseInt(branchNo));
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
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 1);  
		modelAndView.addObject("sys", sys_kind);
		
		//if(sys_kind.equals("A"))
		//	modelAndView.addObject("legBox","N");
		//else
			modelAndView.addObject("legBox", "Y");
		
		modelAndView.setViewName("chartView");
		
		return modelAndView;
	}	
	
	
	
	 // 통합감시 - 상세정보보기
	@RequestMapping("/waterpolmnt/situationctl/goTotalMntGraph.do")
	public String goTotalMntGraph() throws Exception{
		return "/waterpolmnt/situationctl/totalmntpopgraph";
	}
 
	 // 통합감시 - 측정값 조회(팝업-그래프)
	@RequestMapping("/waterpolmnt/situationctl/getTotalMntGraph.do")
	public ModelAndView getTotalMntGraph(
			@RequestParam(value="river", required=false) String river,
			@RequestParam(value="sys", required=false) String sys,
			@RequestParam(value="item", required=false) String item,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height
	)
	throws Exception{
		
		
		ModelAndView modelAndView = new ModelAndView();
		
		TotalMntMainSearchTSVO totalMntMainSearchTSVO = new TotalMntMainSearchTSVO();
		
		totalMntMainSearchTSVO.setSys(sys);
		totalMntMainSearchTSVO.setRiver(river);
		totalMntMainSearchTSVO.setItem(item);

		
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add(item);

		String itemName = "";
		if(item.equals("TUR"))
			itemName = "탁도";
		else if(item.equals("TMP"))
			itemName = "수온";
		else if(item.equals("PHY"))
			itemName = "pH";
		else if(item.equals("DOW"))
			itemName = "DO";
		else if(item.equals("CON"))
			itemName = "전기전도도";
		else if(item.equals("TOF00"))
			itemName = "Chl-a";
		
		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add(itemName);
		
		//itemMinorList
		List<String> itemMinorList = new ArrayList<String>();
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		
		int itemCount = 1;
		dataMap.put(item, new ArrayList());
		constantMap.put(item,null);
  
		
		//getData
		List<ResultChartVO> graphDataList =  situationctlService.getTotalMntGraph2(totalMntMainSearchTSVO);
		
		
		int voCount = 0;
		
		for(ResultChartVO rvo : graphDataList) {
			List data = dataMap.get(item);
			Map valMap = new HashMap();
			//valMap.put("x", rvo.getFact_name() + ((rvo.getBranch_no() != null) ?  "-" + rvo.getBranch_no() : ""));
			valMap.put("x", rvo.getBranch_name());
			valMap.put("y", rvo.getMin_vl());
			data.add(valMap);
			dataMap.put("TUR", data);

			itemMinorList.add(rvo.getMin_or());
			
			voCount++;
		}
		
		if(voCount > 0)
		{
			Integer itemDataSize = new Integer(voCount/itemCount);
			
			StringBuffer title = new StringBuffer();
			title.append("");
	
			modelAndView.addObject("sys", sys);
			modelAndView.addObject("title", title.toString());
			modelAndView.addObject("itemNameList",itemNameList);
			modelAndView.addObject("itemCodeList",itemCodeList);
			modelAndView.addObject("itemDataSize",itemDataSize);
			modelAndView.addObject("itemMinorList", itemMinorList);
			modelAndView.addObject("width",width);
			modelAndView.addObject("height",height);
			modelAndView.addObject("itemDataMap", dataMap);
			modelAndView.addObject("constLine", "N");
			modelAndView.addObject("constantMap", constantMap);
			modelAndView.addObject("chartType", 2);
			modelAndView.addObject("legBox", "N");
			modelAndView.addObject("renderStyle", "control");
			
			modelAndView.setViewName("popupChartView");
		}
		
		return modelAndView;
	}
	
	// 통합감시 - 선택한 측정값 조회(팝업-그래프)
		@RequestMapping("/waterpolmnt/situationctl/getSelectTotalMntGraph.do")
		public ModelAndView getSelectTotalMntGraph(
				@RequestParam(value="river", required=false) String river,
				@RequestParam(value="sys", required=false) String sys,
				@RequestParam(value="item", required=false) String item,
				@RequestParam(value="width", required=false) String width,
				@RequestParam(value="height", required=false) String height,
				@RequestParam(value="chartType", required=false) String chartType,
				@RequestParam(value="pointVal", required=false) String pointVal				
		)
		throws Exception{
			
			
			ModelAndView modelAndView = new ModelAndView();
			
			//gis에서 받은 코드값
			String selectCode = pointVal;
			selectCode = selectCode.replace(".", "#");			
			//String selectCode = "IP-USN,99U1001,15#!IP-USN,99U1001,16#IP-USN,99U1001,17#IP-USN,99U1001,18#IP-USN,99U1001,19";
			//String selectCode = "수질자동측정망,S01001,1#!수질자동측정망,S01002,1#수질자동측정망,S01003,1#수질자동측정망,S01004,1#수질자동측정망,S01005,1";
			String[] selectBranch = selectCode.split("#");
			String transSys = "";
			
			int chartTypeVal = Integer.parseInt(chartType);
			
			//gis에서 받은코드를 arrayList에 배열로 담기
			List<HashMap<String, Object>> listData = new ArrayList<HashMap<String,Object>>();
			HashMap<String, Object> listMap;
			
			//gis에서 선택한 좌표값 담을 map
			HashMap<String , Object> selectPoint = new HashMap<String, Object>();
			
			for(String sub: selectBranch){
				String[] selectBranchTemp = sub.split(",");
				
				//선택좌표를 map에 담기
				if(selectBranchTemp[0].indexOf("!") > -1){
					selectPoint.put("factCode", selectBranchTemp[1]);
					selectPoint.put("branchNo", selectBranchTemp[2]);
					
					/*String  sysTransVal = selectBranchTemp[0].replace("!", "");
					if("IP-USN".equals(sysTransVal)){
						transSys = "U";
					}else if("수질자동측정망".equals(sysTransVal)){
						transSys = "A";		
					}else if("수질TMS".equals(sysTransVal)){
						transSys = "W";
					}else if("탁수 모니터링".equals(sysTransVal)){
						transSys = "T";
					}else{
						transSys = "";
					}*/
				}
			
				listMap = new HashMap<String, Object>();
				listMap.put("factCode", selectBranchTemp[1]);
				listMap.put("branchNo", selectBranchTemp[2]);
				
				listData.add(listMap);
			}
			
			TotalMntMainSearchTSVO totalMntMainSearchTSVO = new TotalMntMainSearchTSVO();
			
			totalMntMainSearchTSVO.setSys(sys);
			totalMntMainSearchTSVO.setRiver(river);
			totalMntMainSearchTSVO.setItem(item);
			
			totalMntMainSearchTSVO.setListData(listData);
			
			//itemCodeList
			List<String> itemCodeList = new ArrayList<String>();
			itemCodeList.add(item);

			String itemName = "";
			if(item.equals("TUR"))
				itemName = "탁도";
			else if(item.equals("TMP"))
				itemName = "수온";
			else if(item.equals("PHY"))
				itemName = "pH";
			else if(item.equals("DOW"))
				itemName = "DO";
			else if(item.equals("CON"))
				itemName = "전기전도도";
			else if(item.equals("TOF00"))
				itemName = "Chl-a";
			
			//itemNameList
			List<String> itemNameList = new ArrayList<String>();
			itemNameList.add(itemName);
			
			//itemMinorList
			List<String> itemMinorList = new ArrayList<String>();
			
			Map<String, List> dataMap = new HashMap();
			Map<String, String> constantMap = new HashMap();
			
			
			int itemCount = 1;
			dataMap.put(item, new ArrayList());
			constantMap.put(item,null);	  
			
			//getData
//			List<ResultChartVO> graphDataList =  situationctlService.getTotalMntGraph2(totalMntMainSearchTSVO);
			List<ResultChartVO> graphDataList =  situationctlService.getSelectTotalMntGraph2(totalMntMainSearchTSVO);			
			
			int voCount = 0;
			
			for(ResultChartVO rvo : graphDataList) {
				List data = dataMap.get(item);
				Map valMap = new HashMap();
				//valMap.put("x", rvo.getFact_name() + ((rvo.getBranch_no() != null) ?  "-" + rvo.getBranch_no() : ""));
				valMap.put("x", rvo.getBranch_name());
				valMap.put("y", rvo.getMin_vl());
				data.add(valMap);
				dataMap.put("TUR", data);

				itemMinorList.add(rvo.getMin_or());
				
				voCount++;
			}
			
			if(voCount > 0)
			{
				Integer itemDataSize = new Integer(voCount/itemCount);
				
				StringBuffer title = new StringBuffer();
				title.append("");
		
				modelAndView.addObject("sys", sys);
				modelAndView.addObject("title", title.toString());
				modelAndView.addObject("itemNameList",itemNameList);
				modelAndView.addObject("itemCodeList",itemCodeList);
				modelAndView.addObject("itemDataSize",itemDataSize);
				modelAndView.addObject("itemMinorList", itemMinorList);
				modelAndView.addObject("width",width);
				modelAndView.addObject("height",height);
				modelAndView.addObject("itemDataMap", dataMap);
				modelAndView.addObject("constLine", "N");
				modelAndView.addObject("constantMap", constantMap);
				modelAndView.addObject("chartType", chartTypeVal);
				modelAndView.addObject("legBox", "N");
				modelAndView.addObject("renderStyle", "control");
				
				modelAndView.setViewName("popupChartView");
			}
			
			return modelAndView;
		}

	// 통합감시 - 미수신 정보보기
	@RequestMapping("/waterpolmnt/situationctl/goTotalMntNorecv.do")
	public String goTotalMntNorecv() throws Exception{
		return "/waterpolmnt/situationctl/totalmntpopnorecv";
	}
  
	// 통합감시 - 미수신 정보 조회
	@RequestMapping("/waterpolmnt/situationctl/getTotalMntNorecv.do")
	public ModelAndView getTotalMntNorecv(
			@RequestParam(value="sys", required=false) String sys,
			@RequestParam(value="river", required=false) String river
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		TotalMntNorecvSearchTSVO totalMntNorecvSearchTSVO = new TotalMntNorecvSearchTSVO();
		
		totalMntNorecvSearchTSVO.setSys_kind(sys);
		if(sys.equals("T"))
		{
			river = river.replace("R", "");
		}
		totalMntNorecvSearchTSVO.setRiver_div(river);
		
		List<TotalMntNorecvTSVO> refreshData =  situationctlService.getTotalMntNorecv(totalMntNorecvSearchTSVO);
		
		modelAndView.addObject("refreshData", refreshData);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 수계별 통합감시 - 통계표 조회
	//@RequestMapping("/waterpolmnt/situationctl/getTopDataTAKSU.do")
	//public ModelAndView getTopDataTAKSU() throws Exception{
		
		//List totalData = situationctlService.getTopDataTAKSU();
		
		//ModelAndView modelAndView = new ModelAndView();
		
		//modelAndView.addObject("totalData", totalData);
		//modelAndView.setViewName("jsonView");
		
		//return modelAndView;
	//}

	// 수계별 통합감시 - 통계표 조회
	@RequestMapping("/waterpolmnt/situationctl/getTopDataTAKSU.do")
	public ModelAndView getTopDataTAKSU(
			@RequestParam(value="river", required=false) String river,
			@RequestParam(value="sys", required=false) String sys
	) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuSumDataVO searchTaksuSumDataVO = new SearchTaksuSumDataVO();

		searchTaksuSumDataVO.setRiver(river);
		searchTaksuSumDataVO.setSys(sys);

		List<TaksuTopDataVO> totalData =  situationctlService.getTopDataTAKSU(searchTaksuSumDataVO);
		
		modelAndView.addObject("totalData", totalData);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 수계별 통합감시 - 측정값 조회
	@RequestMapping("/waterpolmnt/situationctl/goWATERSYSMNT.do")
	public ModelAndView goWATERSYSMNT(
//			@RequestParam(value="river", required=false) String river,
//			@RequestParam(value="sys", required=false) String sys
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuPopupVO searchTaksuPopupVO = new SearchTaksuPopupVO();
		
		
		searchTaksuPopupVO.setSys("A");
		List<WatersysMntCoordVO> a_coordData =  situationctlService.getWaterSysMnt_coord(searchTaksuPopupVO);
		searchTaksuPopupVO.setSys("T");
		List<WatersysMntCoordVO> t_coordData = situationctlService.getWaterSysMnt_coord(searchTaksuPopupVO);
		searchTaksuPopupVO.setSys("U");
		List<WatersysMntCoordVO> u_coordData = situationctlService.getWaterSysMnt_coord(searchTaksuPopupVO);
		
		
		modelAndView.addObject("a_coordData", a_coordData);
		modelAndView.addObject("t_coordData", t_coordData);
		modelAndView.addObject("u_coordData", u_coordData);
		
		modelAndView.setViewName("/waterpolmnt/situationctl/watersysmnt");
		
		return modelAndView;
	}
	
	// 선택좌표 - 측정값 조회 팝업화면
		@RequestMapping("/waterpolmnt/situationctl/goSelectWATERSYSMNT.do")
		public ModelAndView goSelectWATERSYSMNT(
//					@RequestParam(value="river", required=false) String river,
				@RequestParam(value="sys", required=false) String sys,
				@RequestParam(value="pointVal", required=false) String pointVal
				) throws Exception{
			
			ModelAndView modelAndView = new ModelAndView();
			
			SearchTaksuPopupVO searchTaksuPopupVO = new SearchTaksuPopupVO();		
			
			searchTaksuPopupVO.setSys("A");
			List<WatersysMntCoordVO> a_coordData =  situationctlService.getWaterSysMnt_coord(searchTaksuPopupVO);
			searchTaksuPopupVO.setSys("T");
			List<WatersysMntCoordVO> t_coordData = situationctlService.getWaterSysMnt_coord(searchTaksuPopupVO);
			searchTaksuPopupVO.setSys("U");
			List<WatersysMntCoordVO> u_coordData = situationctlService.getWaterSysMnt_coord(searchTaksuPopupVO);		
			
			modelAndView.addObject("a_coordData", a_coordData);
			modelAndView.addObject("t_coordData", t_coordData);
			modelAndView.addObject("u_coordData", u_coordData);
			
			modelAndView.addObject("SelectSys", sys);
			modelAndView.addObject("SelectPointVal", pointVal);
			//System.out.println(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> SelectPointVal :" + pointVal);
			
			modelAndView.setViewName("/waterpolmnt/situationctl/selectWatersysmnt");
			
			return modelAndView;
		}
	
	// 수계별 통합감시 - 좌표수정 팝업
	@RequestMapping("/waterpolmnt/situationctl/goWatersysMntCoordMng.do")
	public ModelAndView goWatersysMntCoordMng() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuPopupVO searchTaksuPopupVO = new SearchTaksuPopupVO();
		
		
		searchTaksuPopupVO.setSys("A");
		List<WatersysMntCoordVO> a_coordData =  situationctlService.getWaterSysMnt_coord(searchTaksuPopupVO);
		searchTaksuPopupVO.setSys("T");
		List<WatersysMntCoordVO> t_coordData = situationctlService.getWaterSysMnt_coord(searchTaksuPopupVO);
		searchTaksuPopupVO.setSys("U");
		List<WatersysMntCoordVO> u_coordData = situationctlService.getWaterSysMnt_coord(searchTaksuPopupVO);
		
		
		modelAndView.addObject("a_coordData", a_coordData);
		modelAndView.addObject("t_coordData", t_coordData);
		modelAndView.addObject("u_coordData", u_coordData);
		
		modelAndView.setViewName("/waterpolmnt/situationctl/watersysMntCoordMng");
		
		return modelAndView;
	}
	
 // 수계별 통합감시 - 좌표수정 팝업
	@RequestMapping("/waterpolmnt/situationctl/updateWaterSysMnt_coord.do")
	public ModelAndView updateWaterSysMnt_coord(
			@RequestParam(value="coord_x", required=false) String coord_x,
			@RequestParam(value="coord_y", required=false) String coord_y,
			@RequestParam(value="fact_code", required=false) String fact_code,
			@RequestParam(value="branch_no", required=false) String branch_no,
			@RequestParam(value="sys", required=false) String sys,
			@RequestParam(value="river_div", required=false) String river_div
	) throws Exception{
		
		WatersysMntCoordVO coordVO = new WatersysMntCoordVO();
		
		coordVO.setCoord_x(coord_x);
		coordVO.setCoord_y(coord_y);
		coordVO.setFact_code(fact_code);
		coordVO.setBranch_no(branch_no);
		
		situationctlService.updateWaterSysMnt_coord(coordVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("success", "OK");
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 수계별 통합감시 - 측정값 조회
	@RequestMapping("/waterpolmnt/situationctl/goTest.do")
	public String goTest() throws Exception{
		return "/waterpolmnt/situationctl/watersysmnt_popup";
	}

	// 수계별 통합감시 - 측정값 조회
	@RequestMapping("/waterpolmnt/situationctl/getWATERSYSMNT.do")
	public ModelAndView getWATERSYSMNT(
			@RequestParam(value="river", required=false) String river,
			@RequestParam(value="sys", required=false) String sys
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		SearchTaksuPopupVO searchTaksuPopupVO = new SearchTaksuPopupVO();
		
		searchTaksuPopupVO.setRiver(river);
		searchTaksuPopupVO.setSys(sys);
		List<TaksuPopupVO> refreshData = situationctlService.getWATERSYSMNT(searchTaksuPopupVO);
		
		modelAndView.addObject("refreshData", refreshData);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	public List<TaksuPopupVO> allSelectPointVal(String value, String sys) throws Exception{
		List<TaksuPopupVO> list = new ArrayList<TaksuPopupVO>();
		String returnVal = value;
		String tmpSys = sys;
		
		ModelAndView modelAndView = new ModelAndView();
		
		String selectCode = returnVal;
		selectCode = selectCode.replace(".", "#");
		String[] selectBranch = selectCode.split("#");
		
		//gis에서 받은코드를 arrayList에 배열로 담기
		List<HashMap<String, Object>> listData = new ArrayList<HashMap<String,Object>>();
		HashMap<String, Object> listMap;
		
		for(String sub: selectBranch){
			String[] selectBranchTemp = sub.split(",");
			
			if("A".equals(selectBranchTemp[0]) || "U".equals(selectBranchTemp[0])){
				listMap = new HashMap<String, Object>();
				listMap.put("factCode", selectBranchTemp[1]);
				listMap.put("branchNo", selectBranchTemp[2]);
				
				listData.add(listMap);
			}
			else if("P".equals(selectBranchTemp[0])){
				listMap = new HashMap<String, Object>();
				listMap.put("whCode", selectBranchTemp[1]);
				
				listData.add(listMap);	
			}
			else if("D".equals(selectBranchTemp[0])){
				listMap = new HashMap<String, Object>();
				listMap.put("id", selectBranchTemp[1]);
				
				listData.add(listMap);	
			}
			else if("I".equals(selectBranchTemp[0])){
				listMap = new HashMap<String, Object>();
				listMap.put("boobscd", selectBranchTemp[1]);
				
				listData.add(listMap);	
			}
		}
		
		if("A".equals(tmpSys)){
			SearchTaksuPopupVO searchTaksuPopupVO = new SearchTaksuPopupVO();
			
			searchTaksuPopupVO.setSys(tmpSys);
			searchTaksuPopupVO.setListData(listData);
			
			list = situationctlService.getSelectWATERSYSMNT(searchTaksuPopupVO);
		}
		else if("U".equals(tmpSys)){
			SearchTaksuPopupVO searchTaksuPopupVO = new SearchTaksuPopupVO();
			
			searchTaksuPopupVO.setSys(tmpSys);
			searchTaksuPopupVO.setListData(listData);
			
			list = situationctlService.getSelectWATERSYSMNT(searchTaksuPopupVO);
		}
		else if("P".equals(tmpSys)){
			SearchTaksuPopupVO searchTaksuPopupVO = new SearchTaksuPopupVO();
			
			searchTaksuPopupVO.setSys(tmpSys);
			searchTaksuPopupVO.setListData(listData);
			
			list = situationctlService.getSelectWATERSYSMNT(searchTaksuPopupVO);
		}
		else if("D".equals(tmpSys)){
			SearchTaksuPopupVO searchTaksuPopupVO = new SearchTaksuPopupVO();
			
			searchTaksuPopupVO.setSys(tmpSys);
			searchTaksuPopupVO.setListData(listData);
			
			list = situationctlService.getSelectWATERSYSMNT(searchTaksuPopupVO);
		}
		else if("I".equals(tmpSys)){
			SearchTaksuPopupVO searchTaksuPopupVO = new SearchTaksuPopupVO();
			
			searchTaksuPopupVO.setSys(tmpSys);
			searchTaksuPopupVO.setListData(listData);
			
			list = situationctlService.getSelectWATERSYSMNT(searchTaksuPopupVO);
		}
		
		return list;
	}
	
	// 선택좌표 - 측정값 조회 팝업화면
		@RequestMapping("/waterpolmnt/situationctl/goSelectAllWATERSYSMNT.do")
		public ModelAndView goSelectAllWATERSYSMNT(
//					@RequestParam(value="river", required=false) String river,
				@RequestParam(value="sys", required=false) String sys,
				@RequestParam(value="pointVal", required=false) String pointVal
				) throws Exception{
			
			//System.out.println("goSelectWaterSysMnt_pointVal : >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> " + pointVal);
			ModelAndView modelAndView = new ModelAndView();
			
			SearchTaksuPopupVO searchTaksuPopupVO = new SearchTaksuPopupVO();		
			
			searchTaksuPopupVO.setSys("A");
			List<WatersysMntCoordVO> a_coordData =  situationctlService.getWaterSysMnt_coord(searchTaksuPopupVO);
			searchTaksuPopupVO.setSys("T");
			List<WatersysMntCoordVO> t_coordData = situationctlService.getWaterSysMnt_coord(searchTaksuPopupVO);
			searchTaksuPopupVO.setSys("U");
			List<WatersysMntCoordVO> u_coordData = situationctlService.getWaterSysMnt_coord(searchTaksuPopupVO);		
			
			modelAndView.addObject("a_coordData", a_coordData);
			modelAndView.addObject("t_coordData", t_coordData);
			modelAndView.addObject("u_coordData", u_coordData);
			
			//20151118		
			String tmpSys = sys;		
			String chkCode = pointVal;
			chkCode = chkCode.replace(".", "#");
			String[] splitCode = chkCode.split("#");
			
			String tmpSel="";
			String tmpA="";
			String tmpU="";
			String tmpW="";
			String tmpP="";
			String tmpD="";
			String tmpI="";
			
			try {
				for(String code: splitCode){
					//System.out.println("code : >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>" + code);
					String[] splitCodeTemp = code.split(",");
					
					String codeTmp = splitCodeTemp[0];
					
					//선택값
					if(codeTmp.indexOf("!") > -1){
						codeTmp = codeTmp.replace("!", "");
						
						if("P".equals(codeTmp) || "D".equals(codeTmp) || "I".equals(codeTmp)){
							tmpSel = codeTmp+","+splitCodeTemp[1];
						}
						else{
							tmpSel = codeTmp+","+splitCodeTemp[1]+","+splitCodeTemp[2];
						}
						
					}
					
					if("A".equals(codeTmp)){
						if("".equals(tmpA)){
							tmpA += codeTmp+","+splitCodeTemp[1]+","+splitCodeTemp[2];
						}
						else{
							tmpA += "."+codeTmp+","+splitCodeTemp[1]+","+splitCodeTemp[2];
						}
					}
					else if("U".equals(codeTmp)){
						if("".equals(tmpU)){
							tmpU += codeTmp+","+splitCodeTemp[1]+","+splitCodeTemp[2];
						}
						else{
							tmpU += "."+codeTmp+","+splitCodeTemp[1]+","+splitCodeTemp[2];
						}
					}
					else if("W".equals(codeTmp)){
						if(splitCodeTemp[1].length() > 5){
							if("".equals(tmpW)){
								tmpW += codeTmp+","+splitCodeTemp[1]+","+splitCodeTemp[2];
							}
							else{
								tmpW += "."+codeTmp+","+splitCodeTemp[1]+","+splitCodeTemp[2];
							}
						}
					}
					else if("P".equals(codeTmp)){
						if("".equals(tmpP)){
							tmpP += codeTmp+","+splitCodeTemp[1];
						}
						else{
							tmpP += "."+codeTmp+","+splitCodeTemp[1];
						}
					}
					else if("D".equals(codeTmp)){
						if("".equals(tmpD)){
							tmpD += codeTmp+","+splitCodeTemp[1];
						}
						else{
							tmpD += "."+codeTmp+","+splitCodeTemp[1];
						}
					}
					else if("I".equals(codeTmp)){
						if("".equals(tmpI)){
							tmpI += codeTmp+","+splitCodeTemp[1];
						}
						else{
							tmpI += "."+codeTmp+","+splitCodeTemp[1];
						}
					}else{
						//System.out.println("goSelectWATERSYSMNT ERROR : " + splitCodeTemp[0]);
					}
				}
				
				/*System.out.println("tmpSel : >>>>>>>>>>>>>>>" + tmpSel);
				System.out.println("tmpA : >>>>>>>>>>>>>>>" + tmpA);
				System.out.println("tmpU : >>>>>>>>>>>>>>>" + tmpU);
				System.out.println("tmpW : >>>>>>>>>>>>>>>" + tmpW);
				System.out.println("tmpP : >>>>>>>>>>>>>>>" + tmpP);
				System.out.println("tmpD : >>>>>>>>>>>>>>>" + tmpD);
				System.out.println("tmpI : >>>>>>>>>>>>>>>" + tmpI);*/
				
				List<TaksuPopupVO> listA = new ArrayList<TaksuPopupVO>();
				List<TaksuPopupVO> listU = new ArrayList<TaksuPopupVO>();
				List<DetailViewVO> listW = new ArrayList<DetailViewVO>();
				List<WareHouseSearchVO> listP = new ArrayList<WareHouseSearchVO>();
				List<DamViewVO> listD = new ArrayList<DamViewVO>();
				List<BoSearchVO> listI = new ArrayList<BoSearchVO>();
				
				if(!"".equals(tmpA)){
					listA  = allSelectPointValA(tmpA, "A");
					//System.out.println("listA size : >>>>>>>>>>>>>>>>>>>>>>>>>" + listA.size());
				}
				if(!"".equals(tmpU)){
					listU  = allSelectPointValU(tmpU, "U");
					//System.out.println("listU size : >>>>>>>>>>>>>>>>>>>>>>>>>" + listU.size());
				}
				if(!"".equals(tmpW)){
					listW = allSelectPointValW(tmpW, "W");
					//System.out.println("listW size : >>>>>>>>>>>>>>>>>>>>>>>>>" + listW.size());
				}
				if(!"".equals(tmpP)){
					listP   = allSelectPointValP(tmpP, "P");
					//System.out.println("listP size : >>>>>>>>>>>>>>>>>>>>>>>>>" + listP.size());					
				}
				if(!"".equals(tmpD)){
					listD   = allSelectPointValD(tmpD, "D");
					//System.out.println("listD size : >>>>>>>>>>>>>>>>>>>>>>>>>" + listD.size());
				}
				if(!"".equals(tmpI)){
					listI   = allSelectPointValI(tmpI, "I");
					//System.out.println("listI size : >>>>>>>>>>>>>>>>>>>>>>>>>" + listI.size());
				}
				
				modelAndView.addObject("refreshDataA", listA);
				modelAndView.addObject("refreshDataU", listU);
				modelAndView.addObject("refreshDataW", listW);
				modelAndView.addObject("refreshDataP", listP);
				modelAndView.addObject("refreshDataD", listD);
				modelAndView.addObject("refreshDataI", listI);
				
				modelAndView.addObject("sel", tmpSel);
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			modelAndView.addObject("SelectSys", sys);
			modelAndView.addObject("SelectPointVal", pointVal);
			
			modelAndView.setViewName("/waterpolmnt/situationctl/selectAllWatersysmnt");
			
			return modelAndView;
		}
		
	public List<TaksuPopupVO> allSelectPointValA(String value, String sys) throws Exception{
		//System.out.println("allSelectPointValA : >>>>>>>>>>>>>>>>>>>>>>>>>>>");
		List<TaksuPopupVO> list = new ArrayList<TaksuPopupVO>();
		String returnVal = value;
		String tmpSys = sys;
		
		ModelAndView modelAndView = new ModelAndView();
		
		String selectCode = returnVal;
		selectCode = selectCode.replace(".", "#");
		String[] selectBranch = selectCode.split("#");
		
		//gis에서 받은코드를 arrayList에 배열로 담기
		List<HashMap<String, Object>> listData = new ArrayList<HashMap<String,Object>>();
		HashMap<String, Object> listMap;
		
		for(String sub: selectBranch){
			String[] selectBranchTemp = sub.split(",");
		
			listMap = new HashMap<String, Object>();
			listMap.put("factCode", selectBranchTemp[1]);
			listMap.put("branchNo", selectBranchTemp[2]);
			
			listData.add(listMap);
		}
	
		SearchTaksuPopupVO searchTaksuPopupVO = new SearchTaksuPopupVO();
		
		searchTaksuPopupVO.setSys(tmpSys);
		searchTaksuPopupVO.setListData(listData);
		
		list = situationctlService.getSelectWATERSYSMNT(searchTaksuPopupVO);
		
		return list;
	}
	
	public List<TaksuPopupVO> allSelectPointValU(String value, String sys) throws Exception{
		System.out.println("allSelectPointValU : >>>>>>>>>>>>>>>>>>>>>>>>>>>");
		List<TaksuPopupVO> list = new ArrayList<TaksuPopupVO>();
		String returnVal = value;
		String tmpSys = sys;
		
		ModelAndView modelAndView = new ModelAndView();
		
		String selectCode = returnVal;
		selectCode = selectCode.replace(".", "#");
		String[] selectBranch = selectCode.split("#");
		
		//gis에서 받은코드를 arrayList에 배열로 담기
		List<HashMap<String, Object>> listData = new ArrayList<HashMap<String,Object>>();
		HashMap<String, Object> listMap;
		
		for(String sub: selectBranch){
			String[] selectBranchTemp = sub.split(",");
		
			listMap = new HashMap<String, Object>();
			listMap.put("factCode", selectBranchTemp[1]);
			listMap.put("branchNo", selectBranchTemp[2]);
			
			listData.add(listMap);
		}
		
		SearchTaksuPopupVO searchTaksuPopupVO = new SearchTaksuPopupVO();
		
		searchTaksuPopupVO.setSys(tmpSys);
		searchTaksuPopupVO.setListData(listData);
		
		list = situationctlService.getSelectWATERSYSMNT(searchTaksuPopupVO);
		
		return list;
	}
	
	public List<DetailViewVO> allSelectPointValW(String value, String sys) throws Exception{
		//System.out.println("allSelectPointValW : >>>>>>>>>>>>>>>>>>>>>>>>>>>");
		List<DetailViewVO> list = new ArrayList<DetailViewVO>();
		String returnVal = value;
		String tmpSys = sys;
		ModelAndView modelAndView = new ModelAndView();
		
		String selectCode = returnVal;
		selectCode = selectCode.replace(".", "#");
		String[] selectBranch = selectCode.split("#");
		try {
			//gis에서 받은코드를 arrayList에 배열로 담기
			List<HashMap<String, Object>> listData = new ArrayList<HashMap<String,Object>>();
			HashMap<String, Object> listMap;
			
			for(String sub: selectBranch){
				String[] selectBranchTemp = sub.split(",");
				
				listMap = new HashMap<String, Object>();
				listMap.put("factCode", selectBranchTemp[1]);
				listMap.put("branchNo", selectBranchTemp[2]);
				
				listData.add(listMap);
			}
			
			SearchTaksuPopupVO searchTaksuPopupVO = new SearchTaksuPopupVO();
			
			//현재시간
			SimpleDateFormat fm= new SimpleDateFormat("yyyyMMddHHmm");
		    String fromDate = fm.format(new Date());    
		    //10분전 시간
		    Calendar cal = new GregorianCalendar(Locale.KOREA);
		    cal.setTime(new Date());
		    cal.add(Calendar.MINUTE, -20);	     
		    SimpleDateFormat fm1 = new SimpleDateFormat("yyyyMMddHHmm");
		    String toDate = fm1.format(cal.getTime());
		    
		    searchTaksuPopupVO.setFromDate(fromDate);
		    searchTaksuPopupVO.setToDate(toDate);
		    searchTaksuPopupVO.setSys(tmpSys);
			searchTaksuPopupVO.setListData(listData);
			
			list = situationctlService.getAllDetailViewDISCHARGE(searchTaksuPopupVO);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<DamViewVO> allSelectPointValD(String value, String sys) throws Exception{
		//System.out.println("allSelectPointValD : >>>>>>>>>>>>>>>>>>>>>>>>>>>");
		List<DamViewVO> list = new ArrayList<DamViewVO>();
		String returnVal = value;
		String tmpSys = sys;
		
		ModelAndView modelAndView = new ModelAndView();
		
		String selectCode = returnVal;
		selectCode = selectCode.replace(".", "#");
		String[] selectBranch = selectCode.split("#");
		
		//gis에서 받은코드를 arrayList에 배열로 담기
		List<HashMap<String, Object>> listData = new ArrayList<HashMap<String,Object>>();
		HashMap<String, Object> listMap;
		
		for(String sub: selectBranch){
			String[] selectBranchTemp = sub.split(",");
			
			listMap = new HashMap<String, Object>();
			listMap.put("dId", selectBranchTemp[1]);
			
			listData.add(listMap);	
		}
			
		SearchTaksuPopupVO searchTaksuPopupVO = new SearchTaksuPopupVO();
	    
	    searchTaksuPopupVO.setSys(tmpSys);
		searchTaksuPopupVO.setListData(listData);
		
		list = situationctlService.getAllDetailViewDAM(searchTaksuPopupVO);
			
		return list;
	}
	
	public List<WareHouseSearchVO> allSelectPointValP(String value, String sys) throws Exception{
		//System.out.println("allSelectPointValP : >>>>>>>>>>>>>>>>>>>>>>>>>>>");
		List<WareHouseSearchVO> list = new ArrayList<WareHouseSearchVO>();
		String returnVal = value;
		String tmpSys = sys;
		
		ModelAndView modelAndView = new ModelAndView();
		
		String selectCode = returnVal;
		selectCode = selectCode.replace(".", "#");
		String[] selectBranch = selectCode.split("#");
		
		//gis에서 받은코드를 arrayList에 배열로 담기
		List<HashMap<String, Object>> listData = new ArrayList<HashMap<String,Object>>();
		HashMap<String, Object> listMap;
		
		for(String sub: selectBranch){
			String[] selectBranchTemp = sub.split(",");
			
			listMap = new HashMap<String, Object>();
			listMap.put("whCode", selectBranchTemp[1]);
			
			listData.add(listMap);	
		}
			
		SearchTaksuPopupVO searchTaksuPopupVO = new SearchTaksuPopupVO();
	    
	    searchTaksuPopupVO.setSys(tmpSys);
		searchTaksuPopupVO.setListData(listData);
		
		list = situationctlService.getAllDetailViewWAREHOUSE(searchTaksuPopupVO);
			
		return list;
	}
	
	public List<BoSearchVO> allSelectPointValI(String value, String sys) throws Exception{
		//System.out.println("allSelectPointValI : >>>>>>>>>>>>>>>>>>>>>>>>>>>");
		List<BoSearchVO> list = new ArrayList<BoSearchVO>();
		String returnVal = value;
		String tmpSys = sys;
		
		ModelAndView modelAndView = new ModelAndView();
		
		String selectCode = returnVal;
		selectCode = selectCode.replace(".", "#");
		String[] selectBranch = selectCode.split("#");
		
		//gis에서 받은코드를 arrayList에 배열로 담기
		List<HashMap<String, Object>> listData = new ArrayList<HashMap<String,Object>>();
		HashMap<String, Object> listMap;
		
		for(String sub: selectBranch){
			String[] selectBranchTemp = sub.split(",");
			
			listMap = new HashMap<String, Object>();
			listMap.put("boobscd", selectBranchTemp[1]);
			
			listData.add(listMap);	
			
		}
			
		SearchTaksuPopupVO searchTaksuPopupVO = new SearchTaksuPopupVO();
		
		//현재시간
		SimpleDateFormat fm= new SimpleDateFormat("yyyyMMddHHmm");
	    String fromDate = fm.format(new Date());    
	    //1시간전 시간
	    Calendar cal = new GregorianCalendar(Locale.KOREA);
	    cal.setTime(new Date());
	    cal.add(Calendar.HOUR, -1);
	    SimpleDateFormat fm1 = new SimpleDateFormat("yyyyMMddHHmm");
	    String toDate = fm1.format(cal.getTime());
	    
	    searchTaksuPopupVO.setFromDate(fromDate);
	    searchTaksuPopupVO.setToDate(toDate);
	    searchTaksuPopupVO.setSys(tmpSys);
		searchTaksuPopupVO.setListData(listData);
		
		list = situationctlService.getAllDetailViewBO(searchTaksuPopupVO);
			
		return list;
	}
	
	// 통합감시 - 선택한 측정값 조회(팝업-그래프)
	@RequestMapping("/waterpolmnt/situationctl/getSelectMultiTotalMntGraph.do")
	public ModelAndView getSelectMultiTotalMntGraph(
			@RequestParam(value="river", required=false) String river,
			@RequestParam(value="sys", required=false) String sys,
			@RequestParam(value="item", required=false) String item,
			@RequestParam(value="width", required=false) String width,
			@RequestParam(value="height", required=false) String height,
			@RequestParam(value="chartType", required=false) String chartType,
			@RequestParam(value="pointVal", required=false) String pointVal
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		//gis에서 받은 코드값
		String selectCode = pointVal;
		selectCode = selectCode.replace(".", "#");
		String[] selectBranch = selectCode.split("#");
		
		//gis에서 받은코드를 arrayList에 배열로 담기
		List<HashMap<String, Object>> listData = new ArrayList<HashMap<String,Object>>();
		HashMap<String, Object> listMap;
		
		for(String sub: selectBranch){
			String[] selectBranchTemp = sub.split(",");
		
			listMap = new HashMap<String, Object>();
			listMap.put("factCode", selectBranchTemp[1]);
			listMap.put("branchNo", selectBranchTemp[2]);
			
			listData.add(listMap);
		}
		
		TotalMntMainSearchTSVO totalMntMainSearchTSVO = new TotalMntMainSearchTSVO();
		
		totalMntMainSearchTSVO.setSys(sys);
		totalMntMainSearchTSVO.setRiver(river);
		totalMntMainSearchTSVO.setItem(item);
		
		totalMntMainSearchTSVO.setListData(listData);
		
		List<ResultChartVO> graphDataList =  situationctlService.getSelectMultiTotalMntGraph2(totalMntMainSearchTSVO);	
		
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		//itemCodeList.add(item);
		List<String> itemNameList = new ArrayList<String>();
		String itemName = "";
		
		String itemTempVal = item;
		
		//itemTempVal = "TUR,TMP,PHY,DOW,CON,TOF";
		try {
			String itemArray[] = itemTempVal.split(",");
			if(itemArray.length > 0){
				for(String itemSub: itemArray){
					itemCodeList.add(itemSub);
					
					if("TUR".equals(itemSub)){
						itemName = "탁도";
					}
					else if("TMP".equals(itemSub)){
						itemName = "수온";
					}
					else if("PHY".equals(itemSub)){
						itemName = "pH";
					}
					else if("DOW".equals(itemSub)){
						itemName = "DO";
					}
					else if("CON".equals(itemSub)){
						itemName = "전기전도도";
					}
					else if("TOF".equals(itemSub)){
						itemName = "Chl-a";
					}
					
					itemNameList.add(itemName);
				}
			}
			else{
				new Throwable("itemCodeList Error");
			}
		}
		 catch (Exception e) {
			e.printStackTrace();
		}
		
		/*if(item.equals("TUR"))
			itemName = "탁도";
		else if(item.equals("TMP"))
			itemName = "수온";
		else if(item.equals("PHY"))
			itemName = "pH";
		else if(item.equals("DOW"))
			itemName = "DO";
		else if(item.equals("CON"))
			itemName = "전기전도도";
		else if(item.equals("TOF"))
			itemName = "Chl-a";*/
		
		//itemNameList
		/*List<String> itemNameList = new ArrayList<String>();
		itemNameList.add(itemName);*/
		
		//itemMinorList
		List<String> itemMinorList = new ArrayList<String>();
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();		
		
		int itemCount = itemCodeList.size();
		//int itemCount = 1;
		
		for(String subTemp: itemCodeList){
			dataMap.put(subTemp, new ArrayList());
			constantMap.put(subTemp, null);	  
		}
		
		/*dataMap.put(item, new ArrayList());
		constantMap.put(item,null);	  */
		
		//getData
//		List<ResultChartVO> graphDataList =  situationctlService.getTotalMntGraph2(totalMntMainSearchTSVO);
						
		int voCount = 0;
		
		for(ResultChartVO rvo : graphDataList) {
			
			for(String cdTemp: itemCodeList){
				List data = dataMap.get(cdTemp);
				Map valMap = new HashMap();
				
				valMap.put("x", rvo.getBranch_name());
				if("TUR".equals(cdTemp)){
					valMap.put("y", rvo.getTur_min_vl());
					
					itemMinorList.add(rvo.getTur_min_or());
				}
				else if("TMP".equals(cdTemp)){
					valMap.put("y", rvo.getTmp_min_vl());
					
					itemMinorList.add(rvo.getTmp_min_or());
				}
				else if("PHY".equals(cdTemp)){
					valMap.put("y", rvo.getPhy_min_vl());	
					
					itemMinorList.add(rvo.getPhy_min_or());
				}
				else if("DOW".equals(cdTemp)){
					valMap.put("y", rvo.getDow_min_vl());
					
					itemMinorList.add(rvo.getDow_min_or());
				}
				else if("CON".equals(cdTemp)){
					valMap.put("y", rvo.getCon_min_vl());
					
					itemMinorList.add(rvo.getCon_min_or());
				}
				else if("TOF".equals(cdTemp)){
					valMap.put("y", rvo.getTof_min_vl());
					
					itemMinorList.add(rvo.getTof_min_or());
				}
				
				data.add(valMap);
				dataMap.put(cdTemp, data);
				
				//확인필요 ~ 배열로 담아야 함.
				//itemMinorList.add(rvo.getTur_min_or());
			}
			
			
			
			/*List data = dataMap.get(item);
			Map valMap = new HashMap();
			//valMap.put("x", rvo.getFact_name() + ((rvo.getBranch_no() != null) ?  "-" + rvo.getBranch_no() : ""));
			valMap.put("x", rvo.getBranch_name());
			//valMap.put("y", rvo.getMin_vl());
			
			// 여기에 리스트(?) 넣기 ??
			valMap.put("y", "0");
			
			data.add(valMap);
			dataMap.put("TUR", data);

			itemMinorList.add(rvo.getMin_or());*/
			
			voCount++;
		}
		
		if(voCount > 0)
		{
			Integer itemDataSize = new Integer(voCount/itemCount);
			
			StringBuffer title = new StringBuffer();
			title.append("");
	
			modelAndView.addObject("sys", sys);
			modelAndView.addObject("title", title.toString());
			modelAndView.addObject("itemNameList",itemNameList);
			modelAndView.addObject("itemCodeList",itemCodeList);
			modelAndView.addObject("itemDataSize",itemDataSize);
			modelAndView.addObject("itemMinorList", itemMinorList);
			modelAndView.addObject("width",width);
			modelAndView.addObject("height",height);
			modelAndView.addObject("itemDataMap", dataMap);
			modelAndView.addObject("constLine", "N");
			modelAndView.addObject("constantMap", constantMap);
			modelAndView.addObject("chartType", Integer.parseInt(chartType));
			if(itemCount != 1){
				modelAndView.addObject("legBox", "Y");
			}
			else{
				modelAndView.addObject("legBox", "N");
			}			
			modelAndView.addObject("renderStyle", "control");
			modelAndView.setViewName("popupChartView");
		}
		
		return modelAndView;
	}
			
	// 선택좌표 - 측정값 조회
	@RequestMapping("/waterpolmnt/situationctl/getSelectWATERSYSMNT.do")
	public ModelAndView getSelectWATERSYSMNT(
			@RequestParam(value="pointVal", required=false) String pointVal,
			@RequestParam(value="sys", required=false) String sys
	)
	throws Exception{
		
	ModelAndView modelAndView = new ModelAndView();
	
	//gis에서 받은 코드값
	String selectCode = pointVal;	
	selectCode = selectCode.replace(".", "#");
	//String selectCode = "IP-USN,99U1001,15#!IP-USN,99U1001,16#IP-USN,99U1001,17#IP-USN,99U1001,18#IP-USN,99U1001,19";
	//String selectCode = "수질자동측정망,S01001,1#!수질자동측정망,S01002,1#수질자동측정망,S01003,1#수질자동측정망,S01004,1#수질자동측정망,S01005,1";
	String[] selectBranch = selectCode.split("#");
	
	//String transSys = "";
	
	//gis에서 받은코드를 arrayList에 배열로 담기
	List<HashMap<String, Object>> listData = new ArrayList<HashMap<String,Object>>();
	HashMap<String, Object> listMap;
	
	//gis에서 선택한 좌표값 담을 map
	HashMap<String , Object> selectPoint = new HashMap<String, Object>();
	
	for(String sub: selectBranch){
		String[] selectBranchTemp = sub.split(",");
		
		//선택좌표를 map에 담기
		if(selectBranchTemp[0].indexOf("!") > -1){
			selectPoint.put("factCode", selectBranchTemp[1]);
			selectPoint.put("branchNo", selectBranchTemp[2]);
			
			/*String  sysTransVal = selectBranchTemp[0].replace("!", "");
			if("IP-USN".equals(sysTransVal)){
				transSys = "U";
			}
			else if("수질자동측정망".equals(sysTransVal)){
				transSys = "A";		
			}
			else if("수질TMS".equals(sysTransVal)){
				transSys = "W";
			}
			else if("탁수 모니터링".equals(sysTransVal)){
				transSys = "T";
			}
			else{
				transSys = "";
			}*/
		}
		
		listMap = new HashMap<String, Object>();
		listMap.put("factCode", selectBranchTemp[1]);
		listMap.put("branchNo", selectBranchTemp[2]);
		
		listData.add(listMap);
	}
	
	SearchTaksuPopupVO searchTaksuPopupVO = new SearchTaksuPopupVO();
	
	//searchTaksuPopupVO.setRiver(river);
	searchTaksuPopupVO.setSys(sys);
	searchTaksuPopupVO.setListData(listData);
	
	List<TaksuPopupVO> refreshDataTemp = situationctlService.getSelectWATERSYSMNT(searchTaksuPopupVO);
	
	String selectFactCode = (String) selectPoint.get("factCode");
	String selectRiver = "";
	List<TaksuPopupVO> refreshData = new ArrayList<TaksuPopupVO>();
	List<TaksuPopupVO> refreshDataEx = new ArrayList<TaksuPopupVO>();

	for(int i=0; i<refreshDataTemp.size(); i++){
		if(selectFactCode.equals(refreshDataTemp.get(i).getFact_code())){
			selectRiver = refreshDataTemp.get(i).getRiver_div();
		}
	}
	
	String useForRiver = "";
	for(int i=0; i<refreshDataTemp.size(); i++){
		useForRiver = refreshDataTemp.get(i).getRiver_div();
		//System.out.println("selectRiver : >>>>>>>>>>>>>" + selectRiver);
		//System.out.println("useForRiver : >>>>>>>>>>>>>" + useForRiver);
		
		if(selectRiver.equals(useForRiver)){			
			refreshData.add(refreshDataTemp.get(i));
			//System.out.println("refreshData size : >>>>>>>>>>>>>" + refreshData.size());
		}
		else{			
			refreshDataEx.add(refreshDataTemp.get(i));
			//System.out.println("refreshDataEx size : >>>>>>>>>>>>>" + refreshDataEx.size());
		}
	}
	
	modelAndView.addObject("selectPoint", selectPoint);
	//modelAndView.addObject("transSys", sys);
	modelAndView.addObject("refreshData", refreshData);
	modelAndView.addObject("refreshDataEx", refreshDataEx);
	modelAndView.setViewName("jsonView");
		
	return modelAndView;
	}

	@RequestMapping("/waterpolmnt/situationctl/getRiverMainChart.do")
	public ModelAndView getRiverMainChart(
			@RequestParam(value="riverDiv", required=false) String riverDiv
			,@RequestParam(value="sysKind", required=false) String sysKind
			,@RequestParam(value="itemCode", required=false) String itemCode
			,@RequestParam(value="itemName", required=false) String itemName
			,@RequestParam(value="width", required=false) String width
			,@RequestParam(value="height", required=false) String height
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		MainChartVO vo = new MainChartVO();

		vo.setRiverDiv(riverDiv);
		vo.setSysKind(sysKind);
		vo.setItemCode(itemCode);

		if(itemCode.equals("TUR") || itemCode.equals("TUR00"))
			itemName = "탁도";
		else if(itemCode.equals("TMP") || itemCode.equals("TMP00"))
			itemName = "수온";
		else if(itemCode.equals("PHY") || itemCode.equals("PHY00"))
			itemName = "pH";
		else if(itemCode.equals("DOW") || itemCode.equals("DOW00"))
			itemName = "용존산소";
		else if(itemCode.equals("CON") || itemCode.equals("CON00"))
			itemName = "전기전도도";
		
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add(itemCode);

		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add(itemName);
		
		//itemMinorList
		List<String> itemMinorList = new ArrayList<String>();
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 1;
		dataMap.put(itemCode, new ArrayList());
		constantMap.put(itemCode,null);
		
		//getData
		List<ResultChartVO> graphDataList = situationctlService.getRiverMainChart(vo);
		
		int voCount = 0;
		for(ResultChartVO rvo : graphDataList) {
			List data = dataMap.get(itemCode);
			Map valMap = new HashMap();
			valMap.put("x", rvo.getBranch_name());
			valMap.put("y", rvo.getMin_vl());
			
			data.add(valMap);
			dataMap.put(itemCode, data);
			
			itemMinorList.add(rvo.getMin_or());
			
			voCount++;
		}
		
		if(voCount > 0)
		{
			Integer itemDataSize = new Integer(voCount/itemCount);
			
			StringBuffer title = new StringBuffer();
			title.append("");
	
			modelAndView.addObject("title", title.toString());
			modelAndView.addObject("itemNameList",itemNameList);
			modelAndView.addObject("itemCodeList",itemCodeList);
			modelAndView.addObject("itemDataSize",itemDataSize);
			modelAndView.addObject("itemMinorList", itemMinorList);
			modelAndView.addObject("width",width);
			modelAndView.addObject("height",height);
			modelAndView.addObject("itemDataMap", dataMap);
			modelAndView.addObject("constLine", "N");
			modelAndView.addObject("constantMap", constantMap);
			modelAndView.addObject("chartType", 1);
			modelAndView.addObject("legBox", "N");
			modelAndView.addObject("renderStyle", "control");
			modelAndView.addObject("sys", sysKind);
			
			modelAndView.setViewName("totalMntChartView");
		}
		
//		Integer itemDataSize = new Integer(voCount/itemCount);
//		
//		
//		StringBuffer title = new StringBuffer();
//		title.append("");
//
//		modelAndView.addObject("title", title.toString());
//		modelAndView.addObject("itemNameList",itemNameList);
//		modelAndView.addObject("itemCodeList",itemCodeList);
//		modelAndView.addObject("itemDataSize",itemDataSize);
//		modelAndView.addObject("width",width);
//		modelAndView.addObject("height",height);
//		modelAndView.addObject("itemDataMap", dataMap);
//		modelAndView.addObject("constLine", "N");
//		modelAndView.addObject("constantMap", constantMap);
//		modelAndView.addObject("chartType", 2);		
//		modelAndView.addObject("legBox", "N");
//		
//		modelAndView.setViewName("popupChartView");
		return modelAndView;
	}	
	
	@RequestMapping("/waterpolmnt/situationctl/getRiverGaugeChart.do")
	public ModelAndView getRiverGaugeChart(
			@RequestParam(value="riverDiv", required=true) String riverDiv
			,@RequestParam(value="sysKind", required=true) String sysKind
			,@RequestParam(value="factCode", required=true) String factCode
			,@RequestParam(value="branchNo", required=true) String branchNo
			,@RequestParam(value="itemCode", required=false) String itemCode
			,@RequestParam(value="itemName", required=false) String itemName
			,@RequestParam(value="lawVl", required=false) String lawVl
			,@RequestParam(value="lawMax", required=false) String lawMax
			,@RequestParam(value="minVl", required=false) String minVl
			,@RequestParam(value="width", required=true) String width
			,@RequestParam(value="height", required=true) String height
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		MainChartVO vo = new MainChartVO();
		
		vo.setRiverDiv(riverDiv);
		vo.setSysKind(sysKind);
		vo.setFactCode(factCode);
		vo.setBranchNo(branchNo);
		vo.setItemCode(itemCode);
		vo.setItemName(itemName);
		
		//getData
		ResultChartVO gaugeData = situationctlService.getRiverGaugeChart(vo);
	
		//String minVl="";
		
		if(gaugeData != null) {minVl = gaugeData.getMin_vl();}
		
		modelAndView.addObject("title", itemName);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("minVl", minVl);
		modelAndView.addObject("lawVl", lawVl);
		modelAndView.addObject("lawMax", lawMax);
		modelAndView.addObject("itemName", itemName);		
		
		//modelAndView.setViewName("gaugeChartView");
		modelAndView.setViewName("phGaugeView");
		return modelAndView;
	}
	
	/**
	 * Ph 차트
	 */
	@RequestMapping("/waterpolmnt/situationctl/getPhGauge.do")
	public ModelAndView getPhGauge(
			@RequestParam(value="fact_code", required=false) String fact_code
			,@RequestParam(value="branch_no", required=false) String branch_no
			,@RequestParam(value="minVl", required=false) String minVl
			,@RequestParam(value="minOr", required=false) String minOr
			,@RequestParam(value="lawVl", required=false) String lawVl
			,@RequestParam(value="lawMax", required=false) String lawMax
			,@RequestParam(value="width", required=true) String width
			,@RequestParam(value="height", required=true) String height
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		FactLawVO factLaw = null;
		
		if(fact_code != null && !fact_code.equals(""))
		{
			//FactLaw 조회
			factLaw = new FactLawVO();
			factLaw.setFact_code(fact_code);
			factLaw.setBranch_no(branch_no);
			factLaw.setItem("PHY");
			factLaw = situationctlService.getFactLaw(factLaw);
		}
		
		if(factLaw != null)
		{
			if(factLaw.getLaw_low() != null && !factLaw.getLaw_low().equals(""))
				lawVl = factLaw.getLaw_low();
			
			if(factLaw.getLaw_high() != null && !factLaw.getLaw_high().equals(""))
				lawMax = factLaw.getLaw_high();
		}
		
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("minVl", minVl);
		modelAndView.addObject("minOr", minOr);
		modelAndView.addObject("lawVl", lawVl);
		modelAndView.addObject("lawMax", lawMax);
		
		//modelAndView.setViewName("gaugeChartView");
		modelAndView.setViewName("phGaugeView");
		return modelAndView;
	}
	
	/**
	 * DO 차트
	 */
	@RequestMapping("/waterpolmnt/situationctl/getDoGauge.do")
	public ModelAndView getDoGauge(
			@RequestParam(value="fact_code", required=false) String fact_code
			,@RequestParam(value="branch_no", required=false) String branch_no
			,@RequestParam(value="minVl", required=false) String minVl
			,@RequestParam(value="minOr", required=false) String minOr
			,@RequestParam(value="lawVl", required=false) String lawVl
			,@RequestParam(value="width", required=true) String width
			,@RequestParam(value="height", required=true) String height
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		FactLawVO factLaw = null;
		
		if(fact_code != null && !fact_code.equals(""))
		{
			//FactLaw 조회
			factLaw = new FactLawVO();
			factLaw.setFact_code(fact_code);
			factLaw.setBranch_no(branch_no);
			factLaw.setItem("DOW");
			factLaw = situationctlService.getFactLaw(factLaw);
		}
		
		if(factLaw != null)
		{
			if(factLaw.getLaw_high() != null && !factLaw.getLaw_high().equals(""))
				lawVl = factLaw.getLaw_high();
		}
		
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("minVl", minVl);
		modelAndView.addObject("lawVl", lawVl);
		modelAndView.addObject("minOr", minOr);
		
		//modelAndView.setViewName("gaugeChartView");
		modelAndView.setViewName("doGaugeView");
		return modelAndView;
	}
	
	/**
	 * 전기전도도 차트
	 */
	@RequestMapping("/waterpolmnt/situationctl/getEcGauge.do")
	public ModelAndView getEcGauge(
			@RequestParam(value="fact_code", required=false) String fact_code
			,@RequestParam(value="branch_no", required=false) String branch_no
			,@RequestParam(value="minVl", required=false) String minVl
			,@RequestParam(value="minOr", required=false) String minOr
			,@RequestParam(value="lawVl", required=false) String lawVl
			,@RequestParam(value="width", required=true) String width
			,@RequestParam(value="height", required=true) String height
			,@RequestParam(value="sys", required=false) String sys
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		FactLawVO factLaw = null;
		
		if("T".equals(sys))
		{
			if(fact_code != null && !fact_code.equals(""))
			{
				//FactLaw 조회
				factLaw = new FactLawVO();
				factLaw.setFact_code(fact_code);
				factLaw.setBranch_no(branch_no);
				factLaw.setItem("CON");
				factLaw = situationctlService.getFactLaw(factLaw);
			}
			
			if(factLaw != null)
			{
				if(factLaw.getLaw_high() != null && !factLaw.getLaw_high().equals(""))
					lawVl = factLaw.getLaw_high();
			}
		}
		
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("minVl", minVl);
		modelAndView.addObject("lawVl", lawVl);
		modelAndView.addObject("minOr", minOr);
		modelAndView.addObject("sys", sys);
		
		//modelAndView.setViewName("gaugeChartView");
		modelAndView.setViewName("ecGaugeView");
		return modelAndView;
	}
	
	
	/**
	 * 탁도 차트
	 */
	@RequestMapping("/waterpolmnt/situationctl/getTurGauge.do")
	public ModelAndView getTurGauge(
			@RequestParam(value="fact_code", required=false) String fact_code
			,@RequestParam(value="branch_no", required=false) String branch_no
			,@RequestParam(value="minVl", required=false) String minVl
			,@RequestParam(value="minOr", required=false) String minOr
			,@RequestParam(value="lawVl", required=false) String lawVl
			,@RequestParam(value="width", required=true) String width
			,@RequestParam(value="height", required=true) String height
			,@RequestParam(value="sys", required=false) String sys
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		FactLawVO factLaw = null;
		
		if("T".equals(sys))
		{
			if(fact_code != null && !fact_code.equals(""))
			{
				//FactLaw 조회
				factLaw = new FactLawVO();
				factLaw.setFact_code(fact_code);
				factLaw.setBranch_no(branch_no);
				factLaw.setItem("TUR");
				factLaw = situationctlService.getFactLaw(factLaw);
			}
			
			if(factLaw != null)
			{
				if(factLaw.getLaw_high() != null && !factLaw.getLaw_high().equals(""))
					lawVl = factLaw.getLaw_high();
			}
		}
		
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("minVl", minVl);
		modelAndView.addObject("minOr", minOr);
		modelAndView.addObject("lawVl", lawVl);
		modelAndView.addObject("sys", sys);
		
		//modelAndView.setViewName("gaugeChartView");
		modelAndView.setViewName("turGaugeView");
		return modelAndView;
	}
	
	/**
	 * 수온 차트
	 */
	@RequestMapping("/waterpolmnt/situationctl/getTempGauge.do")
	public ModelAndView getTempGauge(
			@RequestParam(value="fact_code", required=false) String fact_code
			,@RequestParam(value="branch_no", required=false) String branch_no
			,@RequestParam(value="minVl", required=false) String minVl
			,@RequestParam(value="minOr", required=false) String minOr
			,@RequestParam(value="width", required=true) String width
			,@RequestParam(value="height", required=true) String height
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("minVl", minVl);
		modelAndView.addObject("minOr", minOr);
		
		//modelAndView.setViewName("gaugeChartView");
		modelAndView.setViewName("tempGaugeView");
		return modelAndView;
	}
	
	
	
	/**
	 * 수질측정망 항목별 차트
	 */
	@RequestMapping("/waterpolmnt/situationctl/getGauge.do")
	public ModelAndView getGauge(
			@RequestParam(value="fact_code", required=false) String fact_code
			,@RequestParam(value="branch_no", required=false) String branch_no
			,@RequestParam(value="minVl", required=false) String minVl
			,@RequestParam(value="minOr", required=false) String minOr
			,@RequestParam(value="width", required=true) String width
			,@RequestParam(value="height", required=true) String height
			,@RequestParam(value="itemCode", required=false) String itemCode
	)
	throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("minVl", minVl);
		modelAndView.addObject("minOr", minOr);
		modelAndView.addObject("itemCode", itemCode);
		
		//modelAndView.setViewName("gaugeChartView");
		modelAndView.setViewName("GaugeView");
		return modelAndView;
	}
	
	

	//수계별 통합감시 - 추이 그래프 팝업
	@RequestMapping("/waterpolmnt/situationctl/goWatersysMntTransition.do")
	public String goWatersysMntTransition() throws Exception{
		return "/waterpolmnt/situationctl/watersysmnttransition";
	}
	
	//수계별 통합감시 - 지도 팝업
	@RequestMapping("/waterpolmnt/situationctl/goWatersysMntMapPopup.do")
	public ModelAndView goWatersysMntMapPopup(
			@RequestParam(value="fact_code") String factCode,
			@RequestParam(value="branch_no") String branchNo
	) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		FactLocationVO factLocation = new FactLocationVO();
		
		factLocation.setFact_code(factCode);
		factLocation.setBranch_no(branchNo);
		
		factLocation = situationctlService.getFactLocation(factLocation);
		
		modelAndView.addObject("lat", factLocation.getLatitude());
		modelAndView.addObject("long", factLocation.getLongitude());
		modelAndView.setViewName("/waterpolmnt/situationctl/watersysmntmappopup");
		
		return modelAndView;
//		return "/waterpolmnt/situationctl/watersysmntmappopup";
	}
	
	//수계별 통합감시 - 지도 팝업 새로운 것 2014.06.02
		@RequestMapping("/waterpolmnt/situationctl/sysMntMap.do")
		public ModelAndView sysMntMap(
				@ModelAttribute("factLocation") FactLocationVO factLocation
				) throws Exception{
			ModelAndView modelAndView = new ModelAndView();
			
			factLocation = situationctlService.getFactLocation(factLocation);
			
			modelAndView.addObject("resultList", factLocation);
			modelAndView.setViewName("jsonView");
			
			return modelAndView;
		}
	
	// 통합감시 - 날씨 상세정보 팝업
	@RequestMapping("/waterpolmnt/situationctl/goTotalMntWeather.do")
	public String goTotalMntWeather() throws Exception{
		return "/waterpolmnt/situationctl/totalmntpopweather";
	}
	
	// 수계별 통합감시 - 측정값 조회(세부팝업)
	@RequestMapping("/waterpolmnt/situationctl/goWatersysMntMainDetail.do")
	public String goWatersysMntMainDetail() throws Exception{
		return "/waterpolmnt/situationctl/watersysmntpopdetail";
	}

	// 수계별 통합감시 - 측정값 조회(세부팝업)
	@RequestMapping("/waterpolmnt/situationctl/getWatersysMntMainDetail.do")
	public ModelAndView getWatersysMntMainDetail(
			@RequestParam(value="fact_code", required=false) String fact_code,
			@RequestParam(value="branch_no", required=false) String branch_no,
			@RequestParam(value="sys_kind", required=false) String sys_kind,
			@RequestParam(value="frDate", required=false) String frDate,
			@RequestParam(value="toDate", required=false) String toDate,
			@RequestParam(value="frTime", required=false) String frTime,
			@RequestParam(value="toTime", required=false) String toTime,
			@RequestParam(value="item", required=false) String item
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO = new WatersysMntMainDetailSearchTSVO();
		
		watersysMntMainDetailSearchTSVO.setFact_code(fact_code);
		watersysMntMainDetailSearchTSVO.setBranch_no(branch_no);
		watersysMntMainDetailSearchTSVO.setFrDate(frDate);
		watersysMntMainDetailSearchTSVO.setToDate(toDate);
		watersysMntMainDetailSearchTSVO.setFrTime(frTime);
		watersysMntMainDetailSearchTSVO.setToTime(toTime);
		watersysMntMainDetailSearchTSVO.setSys_kind(sys_kind);
		watersysMntMainDetailSearchTSVO.setItem(item);
		
		List<WatersysMntMainDetailTSVO> refreshData =  situationctlService.getWatersysMntMainDetail(watersysMntMainDetailSearchTSVO);
		
		modelAndView.addObject("refreshData", refreshData);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	
	// 수계별 통합감시 - 측정값 조회(세부팝업) - 다음, 이전 공구 데이터 가져오기
	@RequestMapping("/waterpolmnt/situationctl/getWatersysMntMainDetail_next.do")
	public ModelAndView getWatersysMntMainDetail_next(
			@RequestParam(value="fact_code", required=false) String fact_code,
			@RequestParam(value="sys_kind", required=false) String sys_kind,
			@RequestParam(value="branch_no", required=false) String branch_no,
			@RequestParam(value="river_div", required=false) String river_div,
			@RequestParam(value="isNext", required=false) String isNext,
			@RequestParam(value="frDate", required=false) String frDate,
			@RequestParam(value="toDate", required=false) String toDate,
			@RequestParam(value="frTime", required=false) String frTime,
			@RequestParam(value="toTime", required=false) String toTime,
			@RequestParam(value="item", required=false) String item
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO = new WatersysMntMainDetailSearchTSVO();
		
		watersysMntMainDetailSearchTSVO.setSys_kind(sys_kind);
		watersysMntMainDetailSearchTSVO.setRiver(river_div);
		watersysMntMainDetailSearchTSVO.setFact_code(fact_code);
		watersysMntMainDetailSearchTSVO.setBranch_no(branch_no);
		watersysMntMainDetailSearchTSVO.setIsNext(isNext);
		
		watersysMntMainDetailSearchTSVO.setFrDate(frDate);
		watersysMntMainDetailSearchTSVO.setToDate(toDate);
		watersysMntMainDetailSearchTSVO.setFrTime(frTime);
		watersysMntMainDetailSearchTSVO.setToTime(toTime);
		
		watersysMntMainDetailSearchTSVO.setItem(item);
		
		WatersysMntMainDetailTSVO nextFact = null;
		
		String nextBranchName = "";
		
		if("U".equals(sys_kind))
		{
			nextFact = situationctlService.getNextFact_U(watersysMntMainDetailSearchTSVO);
			
			if(nextFact != null)
				nextBranchName = nextFact.getBranch_name();
		}
		else
		{
			nextFact = situationctlService.getNextFact(watersysMntMainDetailSearchTSVO);
		}
		
		String nextFactCode = null;
		String nextFactName = null;
		
		if(nextFact != null)
		{
			nextFactCode = nextFact.getFact_code();
			nextFactName = nextFact.getFact_name();
		}
		
		//다음(또는 이전)공구의 fact_code
		if(nextFactCode != null && !nextFactCode.trim().equals(""))
		{
			watersysMntMainDetailSearchTSVO.setFact_code(nextFactCode);
			
			if("U".equals(sys_kind))
				watersysMntMainDetailSearchTSVO.setBranch_no(nextFact.getBranch_no());
			
			List<WatersysMntMainDetailTSVO> refreshData =  situationctlService.getWatersysMntMainDetail(watersysMntMainDetailSearchTSVO);
			
			modelAndView.addObject("refreshData", refreshData);
			modelAndView.addObject("factCode", nextFactCode);
			modelAndView.addObject("factName", nextFactName);
			modelAndView.addObject("branchName", nextBranchName);
			modelAndView.setViewName("jsonView");
		}
		else
		{
			modelAndView.addObject("refreshData", null);
			modelAndView.addObject("factCode", nextFactCode);
			modelAndView.addObject("factName", nextFactName);
			modelAndView.addObject("branchName", nextBranchName);
			modelAndView.setViewName("jsonView");
		}
		return modelAndView;
	}
	
	
	// 수계별 통합감시 - 측정값 조회(세부팝업) - 다음, 이전 공구 데이터 가져오기
	////20140312 이광복 추가
	@RequestMapping("/waterpolmnt/situationctl/getWatersysMntMainDetail_all.do")
	public ModelAndView getWatersysMntMainDetail_all(
			@RequestParam(value="fact_code", required=false) String fact_code,
			@RequestParam(value="sys_kind", required=false) String sys_kind,
			@RequestParam(value="branch_no", required=false) String branch_no,
			@RequestParam(value="near_all", required=false) String near_all,
			@RequestParam(value="river_div", required=false) String river_div,
			@RequestParam(value="isNext", required=false) String isNext,
			@RequestParam(value="frDate", required=false) String frDate,
			@RequestParam(value="toDate", required=false) String toDate,
			@RequestParam(value="frTime", required=false) String frTime,
			@RequestParam(value="toTime", required=false) String toTime,
			@RequestParam(value="item", required=false) String item,
			@RequestParam(value="beforeBranchNo", required=false) String beforeBranchNo,
			@RequestParam(value="nextBranchNo", required=false) String nextBranchNo,
			@RequestParam(value="pageIndex", required=false) String pageIndex
	)
	throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO = new WatersysMntMainDetailSearchTSVO();
		
		watersysMntMainDetailSearchTSVO.setSys_kind(sys_kind);
		watersysMntMainDetailSearchTSVO.setRiver(river_div);
		watersysMntMainDetailSearchTSVO.setFact_code(fact_code);
		watersysMntMainDetailSearchTSVO.setBranch_no(branch_no);
		watersysMntMainDetailSearchTSVO.setNearAll(near_all);
		watersysMntMainDetailSearchTSVO.setIsNext(isNext);
		
		watersysMntMainDetailSearchTSVO.setFrDate(frDate);
		watersysMntMainDetailSearchTSVO.setToDate(toDate);
		watersysMntMainDetailSearchTSVO.setFrTime(frTime);
		watersysMntMainDetailSearchTSVO.setToTime(toTime);
		watersysMntMainDetailSearchTSVO.setItem(item);
		
		watersysMntMainDetailSearchTSVO.setBeforeBranchNo(beforeBranchNo);
		watersysMntMainDetailSearchTSVO.setNextBranchNo(nextBranchNo);
		
		//2014-10-21 mypark 페이징 추가
		watersysMntMainDetailSearchTSVO.setPageSize(propertyService.getInt("pageSize"));
		PaginationInfo paginationInfo = new PaginationInfo();
		int totCnt = 0;
		
		watersysMntMainDetailSearchTSVO.setPageIndex(Integer.valueOf(pageIndex));
		paginationInfo.setCurrentPageNo(watersysMntMainDetailSearchTSVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(watersysMntMainDetailSearchTSVO.getPageUnit());
		paginationInfo.setPageSize(watersysMntMainDetailSearchTSVO.getPageSize());
		
		watersysMntMainDetailSearchTSVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		watersysMntMainDetailSearchTSVO.setLastIndex(paginationInfo.getLastRecordIndex());
		watersysMntMainDetailSearchTSVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		WatersysMntMainDetailTSVO beforeFact = null;
		WatersysMntMainDetailTSVO nextFact = null;
		
		String beforeBranchName = "";
		String nextBranchName = "";
		
		watersysMntMainDetailSearchTSVO.setIsNext("N");
		if("U".equals(sys_kind))
		{
			beforeFact = situationctlService.getNextFact_U(watersysMntMainDetailSearchTSVO);
			
			if(beforeFact != null)
				beforeBranchName = beforeFact.getBranch_name();
		}
		else
		{
			beforeFact = situationctlService.getNextFact(watersysMntMainDetailSearchTSVO);
		}
		
		watersysMntMainDetailSearchTSVO.setIsNext("Y");
		if("U".equals(sys_kind))
		{
			nextFact = situationctlService.getNextFact_U(watersysMntMainDetailSearchTSVO);
			
			if(nextFact != null)
				nextBranchName = nextFact.getBranch_name();
		}
		else
		{
			nextFact = situationctlService.getNextFact(watersysMntMainDetailSearchTSVO);
		}
		
		String beforeFactCode = null;
		String beforeFactName = null;
		String nextFactCode = null;
		String nextFactName = null;
		
		if(beforeFact != null)
		{
			beforeFactCode = beforeFact.getFact_code();
			beforeFactName = beforeFact.getFact_name();
		}
		if(nextFact != null)
		{
			nextFactCode = nextFact.getFact_code();
			nextFactName = nextFact.getFact_name();
		}
		
		//다음(또는 이전)공구의 fact_code
		if(nextFactCode != null && !nextFactCode.trim().equals("") && beforeFactCode != null && !beforeFactCode.trim().equals(""))
		{
			System.out.println("$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$");
			watersysMntMainDetailSearchTSVO.setFact_code(fact_code);
			watersysMntMainDetailSearchTSVO.setBeforeFactCode(beforeFactCode);
			watersysMntMainDetailSearchTSVO.setNextFactCode(nextFactCode);
			
			if("U".equals(sys_kind)) {
				watersysMntMainDetailSearchTSVO.setBranch_no(branch_no);
				watersysMntMainDetailSearchTSVO.setBeforeBranchNo(beforeFact.getBranch_no());
				watersysMntMainDetailSearchTSVO.setNextBranchNo(nextFact.getBranch_no());
			}
			
			//2014-10-21 mypark 페이징 추가(총 카운트 조회)
			totCnt = situationctlService.getWatersysMntMainDetail_all_count(watersysMntMainDetailSearchTSVO);
			List<WatersysMntMainDetailTSVO> refreshData =  situationctlService.getWatersysMntMainDetail_all(watersysMntMainDetailSearchTSVO);
			paginationInfo.setTotalRecordCount(totCnt);
			
			//2014-10-21 mypark 페이징 추가
			modelAndView.addObject("totCnt", totCnt);
			modelAndView.addObject("PaginationInfo", paginationInfo);
			modelAndView.addObject("refreshData", refreshData);
			modelAndView.addObject("factCode", nextFactCode);
			modelAndView.addObject("factName", nextFactName);
			modelAndView.addObject("beforeFactCode", beforeFactCode);
			modelAndView.addObject("beforeFactName", beforeFactName);
			modelAndView.addObject("nextFactCode", nextFactCode);
			modelAndView.addObject("nextFactName", nextFactName);
			modelAndView.addObject("beforeBranchName", beforeBranchName);
			modelAndView.addObject("branchName", nextBranchName);
			modelAndView.addObject("nextBranchName", nextBranchName);
			modelAndView.setViewName("jsonView");
		}
		else
		{
			System.out.println("%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%");
			//2014-10-21 mypark 페이징 추가
			modelAndView.addObject("totCnt", totCnt);
			modelAndView.addObject("PaginationInfo", paginationInfo);
			modelAndView.addObject("refreshData", null);
			modelAndView.addObject("factCode", nextFactCode);
			modelAndView.addObject("factName", nextFactName);
			modelAndView.addObject("beforeFactCode", beforeFactCode);
			modelAndView.addObject("beforeFactName", beforeFactName);
			modelAndView.addObject("nextFactCode", nextFactCode);
			modelAndView.addObject("nextFactName", nextFactName);
			modelAndView.addObject("beforeBranchName", beforeBranchName);
			modelAndView.addObject("branchName", nextBranchName);
			modelAndView.addObject("nextBranchName", nextBranchName);
			modelAndView.setViewName("jsonView");
		}
		return modelAndView;
	}
	
	//메인 수질 측정 평균
	@RequestMapping("/IndexWaterSysMainDetail.do")
	public ModelAndView IndexWaterSysMainDetail(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO) throws Exception{
		ModelAndView modelAndView = new ModelAndView();

		List<WatersysMntMainDetailTSVO> refreshData =  situationctlService.IndexWaterSysMainDetail(watersysMntMainDetailSearchTSVO);
		
		modelAndView.addObject("data", refreshData);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	@RequestMapping("/waterpolmnt/situationctl/goWeatherWarn.do")
	public String goWeatherWarn() throws Exception{
		return "/waterpolmnt/situationctl/totalmntpopweatherwarning";
	}
	
	// 수계별 통합감시 - 측정값 조회(세부팝업-세부팝업 그래프)
	@RequestMapping("/waterpolmnt/situationctl/getWatersysMntDetailGraph.do")
	public ModelAndView getWatersysMntDetailGraph(
			@RequestParam(value="factCode", required=false) String factCode
			,@RequestParam(value="branchNo", required=false) String branchNo
			,@RequestParam(value="branchNo_before", required=false) String branchNo_before
			,@RequestParam(value="branchNo_next", required=false) String branchNo_next
			,@RequestParam(value="branchName", required=false) String branchName
			,@RequestParam(value="sys_kind", required=false) String sys_kind
			,@RequestParam(value="item", required=false) String item
			,@RequestParam(value="frDate", required=false) String frDate
			,@RequestParam(value="toDate", required=false) String toDate
			,@RequestParam(value="frTime", required=false) String frTime
			,@RequestParam(value="toTime", required=false) String toTime
			,@RequestParam(value="width", required=false) String width
			,@RequestParam(value="height", required=false) String height
			) throws Exception{
		
		if(branchNo.equals("null") || branchNo.trim().equals(""))
			branchNo = "1";
		if(branchNo_before.equals("null") || branchNo_before.trim().equals(""))
			branchNo_before = "1";
		if(branchNo_next.equals("null") || branchNo_next.trim().equals(""))
			branchNo_next = "1";
		
		ModelAndView modelAndView = new ModelAndView();
		
		WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO = new WatersysMntMainDetailSearchTSVO();
		
		watersysMntMainDetailSearchTSVO.setFact_code(factCode);
		watersysMntMainDetailSearchTSVO.setBranch_no(branchNo);
		watersysMntMainDetailSearchTSVO.setCurFactCode(factCode);
		watersysMntMainDetailSearchTSVO.setCurBranchNo(branchNo);
		watersysMntMainDetailSearchTSVO.setSys(sys_kind);
		watersysMntMainDetailSearchTSVO.setItem(item);
		
		watersysMntMainDetailSearchTSVO.setFrDate(frDate);
		watersysMntMainDetailSearchTSVO.setToDate(toDate);
		watersysMntMainDetailSearchTSVO.setFrTime(frTime);
		watersysMntMainDetailSearchTSVO.setToTime(toTime);
		
		watersysMntMainDetailSearchTSVO.setSys_kind(sys_kind);
		
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("B");
		itemCodeList.add("N");
		itemCodeList.add("C");
		//itemCodeList.add("DOW");
		//itemCodeList.add("TEM");
		//itemCodeList.add("PHY");
		//itemCodeList.add("CON");
		List<String> itemNameList = new ArrayList<String>();
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 0;
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			itemCount++;
		}
		
		//current
		//List<WatersysMntMainDetailTSVO> graphDataList =  situationctlService.getWatersysMntMainDetailGraph(watersysMntMainDetailSearchTSVO);
		
		//before
		watersysMntMainDetailSearchTSVO.setIsNext("N");
		WatersysMntMainDetailTSVO beforeVO = null;
		
		if("U".equals(sys_kind))
			beforeVO = situationctlService.getNextFact_U(watersysMntMainDetailSearchTSVO);
		else
			beforeVO = situationctlService.getNextFact(watersysMntMainDetailSearchTSVO);
		
		String beforeFact = "";
		String beforeBranchNo = "";
		
		if(beforeVO != null)
		{
			beforeFact = beforeVO.getFact_code();
			beforeBranchNo = beforeVO.getBranch_no();
		}
		
		watersysMntMainDetailSearchTSVO.setBeforeFactCode(beforeFact);
		
		if("U".equals(sys_kind))
			watersysMntMainDetailSearchTSVO.setBeforeBranchNo(beforeBranchNo);
		else
			watersysMntMainDetailSearchTSVO.setBeforeBranchNo(branchNo_before);
		
		//List<WatersysMntMainDetailTSVO> graphDataList_before = situationctlService.getWatersysMntMainDetailGraph(watersysMntMainDetailSearchTSVO);
		
		//next
		watersysMntMainDetailSearchTSVO.setIsNext("Y");
		watersysMntMainDetailSearchTSVO.setFact_code(factCode);
		WatersysMntMainDetailTSVO nextVO = null;
		
		if("U".equals(sys_kind))
			nextVO = situationctlService.getNextFact_U(watersysMntMainDetailSearchTSVO);
		else
			nextVO = situationctlService.getNextFact(watersysMntMainDetailSearchTSVO);
		
		String nextFact = "";
		String nextBranchNo = "";
		
		if(nextVO != null)
		{
			nextFact = nextVO.getFact_code();
			nextBranchNo = nextVO.getBranch_no();
		}
		
		watersysMntMainDetailSearchTSVO.setNextFactCode(nextFact);
		
		if("U".equals(sys_kind))
			watersysMntMainDetailSearchTSVO.setNextBranchNo(nextBranchNo);
		else
			watersysMntMainDetailSearchTSVO.setNextBranchNo(branchNo_next);
		
		//List<WatersysMntMainDetailTSVO> graphDataList_next = situationctlService.getWatersysMntMainDetailGraph(watersysMntMainDetailSearchTSVO);
		
		
		List<WatersysMntMainDetailTSVO> graphDataList = situationctlService.getWatersysMntMainDetailGraph(watersysMntMainDetailSearchTSVO);
		
		
		int voCount = 0;
		
		if(graphDataList.size() != 0)
		{
			
			if(graphDataList.get(0).getBeforeFactName() != null)
				itemNameList.add(graphDataList.get(0).getBeforeFactName());
			else
				itemNameList.add("-");
			
			for(WatersysMntMainDetailTSVO detailData : graphDataList) {
				
				List data = dataMap.get("B");
				
				Map valMap = new HashMap();
				valMap.put("x", detailData.getMin_time());
				valMap.put("y", detailData.getVlBefore());
				data.add(valMap);
				dataMap.put(item, data);
				
				voCount++;
			}
			
			if(graphDataList.get(0).getNextFactName() != null)
				itemNameList.add(graphDataList.get(0).getNextFactName());
			else
				itemNameList.add("-");
			
			for(WatersysMntMainDetailTSVO detailData : graphDataList) {
				
				List data = dataMap.get("N");
				
				Map valMap = new HashMap();
				valMap.put("x", detailData.getMin_time());
				valMap.put("y", detailData.getVlNext());
				data.add(valMap);
				dataMap.put(item, data);
				
				voCount++;
			}
			
				if(graphDataList.get(0).getCurFactName() != null)
					itemNameList.add(graphDataList.get(0).getCurFactName());
				else
					itemNameList.add("-");
				
				for(WatersysMntMainDetailTSVO detailData : graphDataList) {
					
					List data = dataMap.get("C");
					
					Map valMap = new HashMap();
					valMap.put("x", detailData.getMin_time());
					valMap.put("y", detailData.getVlCur());
					data.add(valMap);
					dataMap.put(item, data);
					
					voCount++;
			}
		}
		else
		{
			itemNameList = new ArrayList<String>();
			itemCodeList = new ArrayList<String>();
			
			itemNameList.add("조회결과가 없습니다");
			itemCodeList.add("B");
			
			for(int i = 0 ; i < 20 ; i++)
			{
				List data = dataMap.get("B");
				
				Map valMap = new HashMap();
				valMap.put("x", "");
				valMap.put("y", "0.00");
				data.add(valMap);
				dataMap.put("B", data);
				
				voCount++;
			}
		}
		Integer itemDataSize = new Integer(voCount/itemCount);
		StringBuffer title = new StringBuffer();
		title.append("");
		
		try
		{
			Double lawVl = null;
			if("T".equals(sys_kind))
			{
				if(itemCodeList.size() == 1 && "TUR".equals(itemCodeList.get(0)))
				{
					AlertSearchVO vo = new AlertSearchVO();
					vo.setFactCode(factCode);
					vo.setBranchNo(Integer.parseInt(branchNo));
					vo.setItemCode("TUR00");
					
					AlertDataLawVo lawData = alertLawService.getFactLaw(vo);
					
					modelAndView.addObject("lawVl", lawData.getLawHValue());
				}
			}
		}
		catch(Exception ex)
		{
			
		}
		
		modelAndView.addObject("svo", watersysMntMainDetailSearchTSVO);
		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType",1);
		modelAndView.addObject("legBox", "Y");
		modelAndView.addObject("sys", sys_kind);
		
		modelAndView.setViewName("watersysMntPopDetailChartView");
		
		return modelAndView;
	}
	
	// 통합 감시 하단 조류 예보
	@RequestMapping("/waterpolmnt/waterinfo/getRecentAlga.do")
	public ModelAndView getRecentAlga() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		AlgaCastDataVO algaCastDataVO = new AlgaCastDataVO();
		
		List<AlgaCastDataVO> recentAlga = waterinfoService.getAlgaCastFirst("all");
		
		if(recentAlga.size() > 0)
			algaCastDataVO =  recentAlga.get(0);
		
		modelAndView.addObject("algaData", algaCastDataVO);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 통합 감시 하단 항공 감시
	@RequestMapping("/waterpolmnt/waterinfo/getRecentAir.do")
	public ModelAndView getRecentAir() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		AirMntDataVO airDataVO = new AirMntDataVO();
		
		List<AirMntDataVO> recnetAir = waterinfoService.getAirMntFirst("all");
		
		if(recnetAir.size() > 0)
			airDataVO =  recnetAir.get(0);
		
		
		modelAndView.addObject("airData", airDataVO);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	
	/**
	 * SMS 팝업
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmmn/weatherSmsSend.do")
	public String alertSmsSend(
			@RequestParam(value="msg") String msg,
			ModelMap model
			) throws Exception {
		
		model.addAttribute("msg", msg);
		
		return "cmmn/weatherSmsSend";
	}
	
	/**
	 * 측정망 정보 팝업
	 * @return
	 */
	@RequestMapping("/waterpolmnt/situationctl/goChuckjungmang.do")
	public String goChuckjungmakg()
	{
		return "waterpolmnt/situationctl/chuckjungmang";
	}
	
	/**
	 * 자동측정망 실시간 데이터 조회
	 */
	@RequestMapping("/waterpolmnt/situationctl/getAutoData.do")
	public ModelAndView getAutoData() throws Exception
	{
		ModelAndView modelAndView = new ModelAndView();
		
		List<AutoDataVO> autoDataList = situationctlService.getAutoData();
		
		modelAndView.addObject("autoData", autoDataList);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 자동측정망 실시간 데이터 조회
	 */
	@RequestMapping("/waterpolmnt/situationctl/getAutoInsertData.do")
	public ModelAndView getAutoInsertData(
			@RequestParam(value="time") String time
	) throws Exception
	{
		ModelAndView modelAndView = new ModelAndView();
		
		List<AutoDataVO> autoDataList = situationctlService.getAutoInsertData(time);
		
		modelAndView.addObject("autoData", autoDataList);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	
	//소속기관 목록 조회
	@RequestMapping("/waterpolmnt/situationctl/getDepts.do")
	public ModelAndView getTMSList() throws Exception{
		
		List depts = situationctlService.getDepts();
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("depts", depts);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	
	//상위 댐 정보
	@RequestMapping("/waterpolmnt/situationctl/getHighDamInfo.do")
	public ModelAndView getHighDamInfo(
			@RequestParam(value="factCode") String factCode,
			@RequestParam(value="branchNo") String branchNo
	) throws Exception
	{
		SeqInfoVO vo = new SeqInfoVO();
		vo.setFactCode(factCode);
		vo.setBranchNo(branchNo);
		
		SeqInfoVO result = situationctlService.getHighDamInfo(vo);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("result", result);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	
	//상위 댐 정보
	@RequestMapping("/waterpolmnt/situationctl/getLowWaterDCCenter.do")
	public ModelAndView getLowWaterDCCenter(
			@RequestParam(value="factCode") String factCode,
			@RequestParam(value="branchNo") String branchNo
	) throws Exception
	{
		SeqInfoVO vo = new SeqInfoVO();
		vo.setFactCode(factCode);
		vo.setBranchNo(branchNo);
		
		SeqInfoVO result = situationctlService.getLowWaterDCCenter(vo);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("result", result);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
}