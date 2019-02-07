package daewooInfo.cmmn.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.alert.bean.AlertDataLawVo;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.cmmn.bean.CmnLogCounterVO;
import daewooInfo.cmmn.bean.ReportVO;
import daewooInfo.cmmn.service.CmnLogCounterService;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntMainDetailSearchTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.TotalMntMainDetailTSVO;

/**
 * @Class Name : CmnLogCounterController.java
 * @Description : 메뉴별 통계 작업을 위한 Controller
 * @Modification Information @ @ 수정일 수정자 수정내용 @ ------- --------
 *               --------------------------- @ 2011.12.26 bobylone
 * 
 * @author bobylone
 * @since 2011.12.26
 * @version 1.0
 * @see
 * 
 */
@Controller
public class CmnLogCounterController {

	/**
	 * @uml.property  name="cmnLogCounterService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "CmnLogCounterService")
	private CmnLogCounterService cmnLogCounterService;

	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Logger log = Logger.getLogger(this.getClass());

	/**
	 * 메뉴리스트를 조회한다.
	 * 
	 * @return 출력페이지정보 "cmmn/CmnLogCounterList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/cmmn/CmnLogCounterList.do")
	public String selectCmnLogCounterList(ModelMap model) throws Exception {

		return "/cmmn/CmnLogCounterList";
	}
	
	/**
	 * 메뉴별 통계내역을 조회한다.
	 * 
	 * @param frDate
	 * @param toDate
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cmmn/getCmnLogCounterList.do")
	public ModelAndView getCmnLogCounterList(
			@RequestParam(value="frDate") String frDate,
			@RequestParam(value="toDate") String toDate
			) throws Exception {
		
		Map<String, String> searchMap = new HashMap<String, String>();
		searchMap.put("frDate", frDate);
		searchMap.put("toDate", toDate);
		
		List list = cmnLogCounterService.getLogList(searchMap);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("MenuConuterList", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	/**
	 * 총 방문자수와 오늘 방문자수를 가져 온다
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cmmn/getTotalCmnLogCounter.do")
	public ModelAndView getTotalCmnLogCounter() throws Exception {
		
		
		List list = cmnLogCounterService.getTotalLogCounter();
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("ConuterMap", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	/**
	 * 일간 방문자수 평균
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cmmn/getAvgPage.do")
	public ModelAndView getAvgPage(
			@RequestParam(value="frDate") String frDate,
			@RequestParam(value="toDate") String toDate
			) throws Exception {
		Map<String, String> searchMap = new HashMap<String, String>();
		searchMap.put("frDate", frDate);
		searchMap.put("toDate", toDate);
		List list = cmnLogCounterService.getAvgPage(searchMap);
		//System.out.println(list.size());
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("AvgPageMap", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 보고 저장
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cmmn/saveWeblogReport.do")
	public ModelAndView saveWeblogReport(
			@ModelAttribute("reportVO") ReportVO reportVO) throws Exception {
		ModelAndView modelAndView  = new ModelAndView(); 
		cmnLogCounterService.saveWeblogReport(reportVO);			
		
		modelAndView.setViewName("jsonView");
		
        return modelAndView;
	}
	
	/**
	 * 보고 리스트 가져오기
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cmmn/getWeblogReportList.do")
	public ModelAndView getWeblogReportList(
			@ModelAttribute("reportVO") ReportVO reportVO
			) throws Exception {
		List list = cmnLogCounterService.getWeblogReportList(reportVO);
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("reportList", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	// 방문자 차트
	@RequestMapping("/cmmn/CmnLogCounterChart.do")
    public ModelAndView getTotalMntDetailGraph(
    		 @RequestParam(value="width", required=false) String width
    		,@RequestParam(value="height", required=false) String height
    		,@RequestParam(value="hiddenEndDate", required=false) String hiddenEndDate
    		,@RequestParam(value="hiddenStartDate", required=false) String hiddenStartDate
    		
    		) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	

		CmnLogCounterVO cmnLogCounterVO = new CmnLogCounterVO();
		
		//cmnLogCounterVO.setFrDate("2013/04/01");
		cmnLogCounterVO.setFrDate(hiddenStartDate);
		cmnLogCounterVO.setToDate(hiddenEndDate);
		
		List <CmnLogCounterVO> list = cmnLogCounterService.getLoginCountChart(cmnLogCounterVO);
    
    	//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();		
		itemCodeList.add("loginCnt");		
		
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("방문자수");
    	
    	Map<String, List> dataMap = new HashMap();
    	
    	dataMap.put("loginCnt", new ArrayList());
    	
    	Map<String, String> constantMap = new HashMap();
    	
    	List<Map> data = dataMap.get("loginCnt") ;
    	
    	for(int i=0; i<list.size(); i++){
    		Map<String, String> valMap = new HashMap<String, String>();
        	valMap = new HashMap<String, String>();
    		
        	valMap.put("x", list.get(i).getLoginDate() );
        	valMap.put("y", list.get(i).getLoginCnt() );
        	
        	data.add(valMap);
        	dataMap.put("loginCnt", data);
    	}
    	
    	
    	Integer itemDataSize =  list.size();// new Integer(voCount/itemCount);
    	
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
    	modelAndView.addObject("chartType", 1);  
    	//modelAndView.addObject("sys", sys_kind);
    	
    	//if(sys_kind.equals("A"))
    	//	modelAndView.addObject("legBox","N");
    	//else
    		modelAndView.addObject("legBox", "Y");
    	
    	modelAndView.setViewName("cmnLogChartView");
    	
    	return modelAndView;
    }
}