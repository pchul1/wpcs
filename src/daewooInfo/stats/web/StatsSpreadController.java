package daewooInfo.stats.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.stats.bean.StatsSearchVO;
import daewooInfo.stats.bean.StatsSpreadVO;
import daewooInfo.stats.service.StatsSpreadService;


/**
 * 상황전파 통계를 위한 컨트롤러  클래스
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------       --------    ---------------------------
 *   2010.6.28  김태훈          최초 생성
 *
 * </pre>
 */
@Controller
public class StatsSpreadController {
	/**
	 * @uml.property  name="logger"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log logger = LogFactory.getLog(StatsSpreadController.class);

    /**
	 * @uml.property  name="statsSpreadService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "statsSpreadService")
    private StatsSpreadService statsSpreadService;
        
    /**
     * 상황전파 통계를 보여준다.
     * 
     * @return
     * @throws Exception
     */
    @RequestMapping("/stats/statsSpread.do")
    public String statsSpread() throws Exception{
    	return "stats/statsSpread";
    }

    /**
     * 상황전파 통계 목록을 가져온다.
     * 
     * @param factCode
     * @param branchNo
     * @param startDate
     * @param gubun
     * @return
     * @throws Exception
     */
    @RequestMapping("/stats/getSpreadStatsList.do")
    public ModelAndView getSpreadStatsList(
            @RequestParam("factCode") 	String factCode,
            @RequestParam("branchNo")	String branchNo,
            @RequestParam("startDate") 	String startDate,
            @RequestParam("gubun") 		String gubun
            )
            throws Exception{

        ModelAndView modelAndView = new ModelAndView();
        
        StatsSearchVO vo = new StatsSearchVO();
        
        vo.setFactCode(factCode);
        vo.setBranchNo(branchNo);
        vo.setStartDate(startDate);
        vo.setGubun(Integer.parseInt(gubun));

        List<StatsSpreadVO> spreadStatsList =  statsSpreadService.getSpreadStatsList(vo);

        modelAndView.addObject("spreadStatsList", spreadStatsList);
        modelAndView.setViewName("jsonView");

        return modelAndView;
    }	

    /**
     * 상황전파 통계 차트를 가져온다.
     * 
     * @param factCode
     * @param factName
     * @param branchNo
     * @param startDate
     * @param gubun
     * @param width
     * @param height
     * @return
     * @throws Exception
     */
    @RequestMapping("/stats/getSpreadStatsChart.do")
    public ModelAndView getSpreadStatsChart(
    		@RequestParam(value="factCode", required=false) String factCode
    		,@RequestParam(value="factName", required=false) String factName
    		,@RequestParam(value="branchNo", required=false) String branchNo
    		,@RequestParam(value="startDate", required=false) String startDate
    		,@RequestParam(value="gubun", required=false) String gubun
    		,@RequestParam(value="width", required=false) String width
    		,@RequestParam(value="height", required=false) String height
    )
    throws Exception{
    	ModelAndView modelAndView = new ModelAndView();
    	
    	StatsSearchVO vo = new StatsSearchVO();

        vo.setFactCode(factCode);
        vo.setBranchNo(branchNo);
        vo.setStartDate(startDate);
        vo.setGubun(Integer.parseInt(gubun));
        
    	//itemCodeList
    	List<String> itemCodeList = new ArrayList<String>();
    	itemCodeList.add("smsSucc");
    	itemCodeList.add("smsFail");
    	itemCodeList.add("acsSucc");
    	itemCodeList.add("acsFail");

    	//itemNameList
    	List<String> itemNameList = new ArrayList<String>();
    	itemNameList.add("SMS수신");
    	itemNameList.add("SMS미수신");
    	itemNameList.add("ACS수신");
    	itemNameList.add("ACS미수신");
    	
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
    	List<StatsSpreadVO> graphDataList = statsSpreadService.getSpreadStatsList(vo);
    	
    	int voCount = 0;
    	for(StatsSpreadVO rvo : graphDataList) {
        	List data = dataMap.get("smsSucc");
        	Map valMap = new HashMap();
        	valMap.put("x", rvo.getTime());
        	valMap.put("y", rvo.getSmsSucc());
        	data.add(valMap);
        	dataMap.put("smsSucc", data);

        	voCount++;
        	
        	data = dataMap.get("smsFail");
        	valMap = new HashMap();
        	valMap.put("x", rvo.getTime());
        	valMap.put("y", rvo.getSmsFail());
        	data.add(valMap);
        	dataMap.put("smsFail", data);

        	voCount++;           	
        	
        	data = dataMap.get("acsSucc");
        	valMap = new HashMap();
        	valMap.put("x", rvo.getTime());
        	valMap.put("y", rvo.getAcsSucc());
        	data.add(valMap);
        	dataMap.put("acsSucc", data);

        	voCount++;   
        	
        	data = dataMap.get("acsFail");
        	valMap = new HashMap();
        	valMap.put("x", rvo.getTime());
        	valMap.put("y", rvo.getAcsFail());
        	data.add(valMap);
        	dataMap.put("acsFail", data);

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
     * 상황전파 통계 엑셀을 가져온다.
     * 
     * @param riverId
     * @param riverName
     * @param factCode
     * @param factName
     * @param branchNo
     * @param startDate
     * @param gubun
     * @return
     * @throws Exception
     */
    @RequestMapping("/stats/getSpreadStatsExcel.do")
    public ModelAndView getSpreadStatsExcel(
    		@RequestParam(value="riverId", required=false) String riverId
    		,@RequestParam(value="riverName", required=false) String riverName
    		,@RequestParam(value="factCode", required=false) String factCode
    		,@RequestParam(value="factName", required=false) String factName
    		,@RequestParam(value="branchNo", required=false) String branchNo
    		,@RequestParam(value="startDate", required=false) String startDate
    		,@RequestParam(value="gubun", required=false) String gubun
    ) throws Exception {
    	
    	StatsSearchVO vo = new StatsSearchVO();
    	
    	StringBuffer title = new StringBuffer();
    	title.append(factName).append(" 제").append(branchNo).append("측정소");    	

        vo.setFactCode(factCode);
        vo.setBranchNo(branchNo);
        vo.setStartDate(startDate);
        vo.setGubun(Integer.parseInt(gubun));
     
    	//getData
        String[] menu = {"수계","공구","측정소","시간","상황전파","SMS","ACS"};
    	List<StatsSpreadVO> excelDataList = statsSpreadService.getSpreadStatsList(vo);
    	List<StatsSpreadVO> excelTmp = new ArrayList<StatsSpreadVO>();
    	
    	for(StatsSpreadVO rvo : excelDataList) {
    		rvo.setRiverName(riverName);
    		rvo.setFactName(factName);
    		
    		excelTmp.add(rvo);
    	}
    	Map<String, Object> map = new HashMap<String, Object>();
    	map.put("menu", menu);
    	map.put("chart", excelTmp);
    	map.put("searchDate", startDate);
    	map.put("title", title.toString());
     
    	return new ModelAndView("excelStatsSpreadView", "chartMap", map);
    }              
}
