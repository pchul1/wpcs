package daewooInfo.mock.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.alert.service.AlertTargetService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.mock.bean.AnalysisVO;
import daewooInfo.mock.bean.ErrorCodeVO;
import daewooInfo.mock.bean.MockVO;
import daewooInfo.mock.service.MockService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class MockController {
	/**
	 * @uml.property  name="logger"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log logger = LogFactory.getLog(MockController.class);
	
    /**
	 * @uml.property  name="mockService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "mockService")
    private MockService mockService;	
    
	/**
	 * @uml.property  name="alertTargetService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertTargetService")
    private AlertTargetService alertTargetService;
	
    @RequestMapping("/mock/mockTest.do")
    public ModelAndView mockTest() throws Exception{
    	ModelAndView modelAndView = new ModelAndView();
    	
        modelAndView.setViewName("mock/mockTest");
    	
    	return modelAndView;
    }      
    
	@RequestMapping("/mock/getPointList.do")
    public ModelAndView getAlertConfigList(
    		@RequestParam(value="riverId", required=false) String riverId
    		) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	

		MockVO vo = new MockVO();
		vo.setRiverId(riverId);
		
        List<MockVO> pointList =  mockService.getPointList(vo);

        modelAndView.addObject("pointList", pointList);
        modelAndView.setViewName("jsonView");

        return modelAndView;
    }	  
	
	@Transactional(readOnly=false, propagation=Propagation.REQUIRED)
	@RequestMapping("/mock/delMock.do")
	public ModelAndView delMock(
			@RequestParam(value="mockId", required=false) String mockId
	) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	
		
		MockVO vo = new MockVO();
		vo.setMockId(mockId);
		
		mockService.delMockTest(vo);
		mockService.delMockSection(vo);
		mockService.delMockPoint(vo);
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}	  
	
    @RequestMapping("/mock/mockTestResult.do")
    public ModelAndView mockTestResult(
    		@RequestParam(value="sectionFlow") String[] sectionFlow
    		,@RequestParam(value="flowId") String[] flowId
    		,@RequestParam(value="pointId") String[] pointId
    		,@RequestParam(value="sectionId") String[] sectionId
    	) throws Exception{
    	
    	ModelAndView modelAndView = new ModelAndView();
    	List sectionList = new ArrayList<MockVO>();
    	List pointList = new ArrayList<MockVO>();
    	MockVO vo = new MockVO();
    	Map tmpMap = new HashMap<String, String>();
    	String riverId = "";
    	String riverName = "";
    	
    	Double sectionTot = 0.0;
    	Double pointTot = 0.0;
    	
    	Double tmp = 0.0;
    	
    	for(int i=0; i<flowId.length; i++) {
    		vo = new MockVO();
    		vo.setSectionId(flowId[i]);
    		vo.setFlow(sectionFlow[i]);

	    	vo = mockService.getFlow(vo);
	    	sectionList.add(vo);	    	
	    	
	    	tmpMap.put(vo.getSectionId(), vo.getNewEndTime());	    	
	    	tmpMap.put(vo.getSectionId()+"_1", sectionTot);	    	
	    	sectionTot += Double.parseDouble(vo.getNewEndTime());
	    	
	    	riverId = vo.getRiverId();
	    	riverName = vo.getRiverName();
    	}
    	
    	for(int i=0; i<pointId.length; i++) {
    		vo = new MockVO();
    		vo.setPointId(pointId[i]);
    		vo.setNewEndTime((String)tmpMap.get(sectionId[i]));

	    	vo = mockService.getPointFlow(vo);
	    	    			    
	    	vo.setNewEndTime(""+Double.parseDouble(String.format("%.1f",(Double.parseDouble(vo.getNewEndTime()) + (Double)tmpMap.get(sectionId[i]+"_1") - tmp))));
	    	
    		if(i == 0) {
    			tmp = Double.parseDouble(vo.getNewEndTime());
    			vo.setNewEndTime("0");
    		}	    	    	
	    	
	    	pointList.add(vo);
	    	
	    	pointTot = Double.parseDouble(vo.getNewEndTime());	    	
    	}    	
    	
    	sectionTot = Double.parseDouble(String.format("%.1f", sectionTot));
    	pointTot = Double.parseDouble(String.format("%.1f", pointTot));
    	
    	modelAndView.addObject("sectionList", sectionList);
    	modelAndView.addObject("sectionTot", sectionTot);
    	modelAndView.addObject("pointList", pointList);
    	modelAndView.addObject("pointTot", pointTot);
    	modelAndView.addObject("riverId", riverId);
    	modelAndView.addObject("riverName", riverName);
    	
        modelAndView.setViewName("mock/mockTestResult");
    	
    	return modelAndView;
    }    	
	
    @RequestMapping("/mock/mockTestList.do")
    public ModelAndView mockTestList(
    		@ModelAttribute("mockVO") MockVO mockVO
    		) throws Exception{
    	ModelAndView modelAndView = new ModelAndView();
    	
    	PaginationInfo paginationInfo = new PaginationInfo();    	

		/** paging */
		paginationInfo.setCurrentPageNo(mockVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(mockVO.getPageUnit());
		paginationInfo.setPageSize(mockVO.getPageSize());
	
		mockVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		mockVO.setLastIndex(paginationInfo.getLastRecordIndex());
		mockVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());    	    	
    	
    	List<MockVO> mockTestList = mockService.getMockTestList(mockVO);
    	
		int totCnt = mockService.getMockTestCnt(mockVO);		
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("mockVO", mockVO);
		modelAndView.addObject("totCnt", totCnt);
        modelAndView.addObject("mockTestList", mockTestList);
        modelAndView.setViewName("mock/mockTestList");
    	
    	return modelAndView;
    }  
    
    @RequestMapping("/mock/mockTestView.do")
    public ModelAndView mockTestView(
    		@RequestParam(value="mockId") String mockId
    		) throws Exception{
    	ModelAndView modelAndView = new ModelAndView();
    	
    	MockVO vo = new MockVO();
    	vo.setMockId(mockId);
    	
    	MockVO mockTest = mockService.getMockTest(vo);
    	List<MockVO> mockSectionList = mockService.getMockSection(vo);
    	List<MockVO> mockPointList = mockService.getMockPoint(vo);

    	
        modelAndView.addObject("mockTest", mockTest);
        modelAndView.addObject("mockSectionList", mockSectionList);
        modelAndView.addObject("mockPointList", mockPointList);
        modelAndView.setViewName("mock/mockTestView");
    	
    	return modelAndView;
    }      
    
    @Transactional(readOnly=false, propagation=Propagation.REQUIRED)
	@RequestMapping("/mock/mockTestSave.do")
	public ModelAndView mockTestSave(
    		HttpServletRequest req,
    		HttpServletResponse res,
    		@RequestParam(value="mockTitle", required=false) String mockTitle,
    		@RequestParam(value="mockEtc", required=false) String mockEtc,    		
    		@RequestParam(value="riverId", required=false) String riverId,    	
    		
    		@RequestParam(value="mockSectionId", required=false) String[] mockSectionId,    		
    		@RequestParam(value="mockSectionOrder", required=false) String[] mockSectionOrder,    		
    		@RequestParam(value="mockFlow", required=false) String[] mockFlow,    		
    		@RequestParam(value="mockFlowTime", required=false) String[] mockFlowTime,    	
    		
    		@RequestParam(value="mockPointId", required=false) String[] mockPointId,    		
    		@RequestParam(value="mockPointOrder", required=false) String[] mockPointOrder,    		
    		@RequestParam(value="mockPointFlowTime", required=false) String[] mockPointFlowTime      		
			) throws Exception{
		
		MockVO vo = new MockVO();
		
		String regId = "";
		
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(isAuthenticated) {
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			regId = user.getId();
		}	
		
		int idx = mockService.getMockTestPk();
		
		vo.setMockId(""+idx);
		vo.setMockTitle(mockTitle);
		vo.setMockEtc(mockEtc);
		vo.setRiverId(riverId);
		vo.setMemberId(regId);
		
		mockService.saveMockTest(vo);
		
		
		vo = new MockVO();
		for(int i=0; i<mockSectionId.length; i++) {
			vo.setMockId(""+idx);
			vo.setSectionId(mockSectionId[i]);
			vo.setMockSectionOrder(mockSectionOrder[i]);
			vo.setFlow(mockFlow[i]);
			vo.setFlowTime(mockFlowTime[i]);
			
			mockService.saveMockSection(vo);
		}
			
		vo = new MockVO();
		for(int i=0; i<mockPointId.length; i++) {
			vo.setMockId(""+idx);
			vo.setPointId(mockPointId[i]);
			vo.setMockPointOrder(mockPointOrder[i]);
			vo.setFlowTime(mockPointFlowTime[i]);
			
			mockService.saveMockPoint(vo);
		}		
		

        //return new ModelAndView("redirect:/alert/alertMngView.do?mngId="+alertMngVO.getMngId());
		res.setContentType("text/html; charset=UTF-8");
		res.getWriter().print("<script>alert('모의결과를 저장하였습니다.');location.href='"+req.getRequestURL().toString().replaceAll(req.getRequestURI(), "")+"/mock/mockTestView.do?mockId="+idx+"';</script>");

		return null;				
	}
    
    /**
     * 하천 종합 - 일지작성
     */
    @RequestMapping("/mock/goDailyLog.do")
    public ModelAndView goDailyLog() throws Exception
    {
    	ModelAndView modelAndView = new ModelAndView();
    	
        modelAndView.setViewName("mock/daily_log");
    	
    	return modelAndView;
    }
    
    
    /**
     * 하천종합 일지 저장
     * @param vo
     * @return
     * @throws Exception
     */
    @RequestMapping("/mock/insertDayLog.do")
    public ModelAndView insertDayLog(
    		@ModelAttribute("AnalysisVO") AnalysisVO vo
    ) throws Exception
    {
    	ModelAndView mav = new ModelAndView();

    	try
    	{
        	//로긴 한 유저의 그룹
        	LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

        	
	    	String wrkTime1 = String.format("%02d", Integer.parseInt(vo.getHTime1())) + ":" + String.format("%02d" ,Integer.parseInt(vo.getMTime1()));
	    	String wrkTime2 = String.format("%02d", Integer.parseInt(vo.getHTime2())) + ":" + String.format("%02d", Integer.parseInt(vo.getMTime2()));
	    	String daylogMakeTime = vo.getDaylogDate() + vo.getDaylogTime();
	    	
	    	vo.setRegId(user.getId());
	    	vo.setWrkTime1(wrkTime1);
	    	vo.setWrkTime2(wrkTime2);
	    	vo.setDaylogMakeTime(daylogMakeTime);
	    	
	    	mockService.insertDayLog(vo);
	    	mav.addObject("isOk","ok");	    	
    	}
    	catch(Exception ex)
    	{
    		mav.addObject("isOk", "false");
    	}
    	
    	mav.setViewName("/mock/daily_log");
    	return mav;
    }
    
    
    /**
     * 하천 종합 리스트
     */
    @RequestMapping("/mock/goDayLogList.do")
    public ModelAndView goSynthList() throws Exception
    {
    	ModelAndView modelAndView = new ModelAndView();
    	
        modelAndView.setViewName("mock/daylogList");
    	
    	return modelAndView;
    }
    
    @RequestMapping("/mock/getDayLogList.do")
    public ModelAndView getDayLogList(
    		@ModelAttribute("AnalysisVO") AnalysisVO vo
    ) throws Exception
    {
    	ModelAndView mav = new ModelAndView();
    	
    	PaginationInfo paginationInfo = new PaginationInfo();    	

    	if(vo.getPageIndex() == 0)
    		vo.setPageIndex(1);
    	
		/** paging */
    	vo.setPageUnit(20);
		paginationInfo.setCurrentPageNo(vo.getPageIndex());
		paginationInfo.setRecordCountPerPage(vo.getPageUnit());
		paginationInfo.setPageSize(vo.getPageSize());
	
		
		vo.setFirstIndex(paginationInfo.getFirstRecordIndex());
		vo.setLastIndex(paginationInfo.getLastRecordIndex());
		vo.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<AnalysisVO> voList = mockService.getDayLogList(vo);
		
		int totCnt = mockService.getDayLogList_cnt(vo);		
		paginationInfo.setTotalRecordCount(totCnt);
		
		mav.addObject("paginationInfo", paginationInfo);
		mav.addObject("analysysVO", vo);
		mav.addObject("totCnt", totCnt);
        mav.addObject("dataList", voList);

        mav.setViewName("jsonView");
//    	modelAndView.setViewName("waterpolmnt/waterinfo/algacast
    	
    	return mav;
    }
    
    
    @RequestMapping("/mock/goDayLogDet.do")
    public ModelAndView goDayLogDet(
    		@RequestParam(value="daylogNo") String daylogNo,
    		@RequestParam(value="isModify", required=false) String isModify
	) throws Exception
    {
    	ModelAndView mav = new ModelAndView();
    
    	AnalysisVO vo = new AnalysisVO();
    	
    	vo.setDaylogNo(daylogNo);
    	
    	vo = mockService.getDayLogDetail(vo);
    	
    	vo.setFrDate(vo.getDaylogMakeTime2());
    	vo.setToDate(vo.getDaylogMakeTime2());
    	
    	//IP-USN 전송현황
    	vo.setSysKind("U");
    	List<AnalysisVO> ipUsnTrans = mockService.getTrans(vo);
    	
    	//탁수 전송현황
    	vo.setSysKind("T");
    	vo.setParamRiverDiv("R01");
    	List<AnalysisVO> taksuTrans1 = mockService.getTrans(vo);
    	vo.setParamRiverDiv("R02");
    	List<AnalysisVO> taksuTrans2 = mockService.getTrans(vo);
    	vo.setParamRiverDiv("R03");
    	List<AnalysisVO> taksuTrans3 = mockService.getTrans(vo);
    	vo.setParamRiverDiv("R04");
    	List<AnalysisVO> taksuTrans4 = mockService.getTrans(vo);
    	
    	//강우량
    	List<AnalysisVO> rainFall = mockService.getRainfall(vo);
    
    
    	//탁수 전송현황
    	AnalysisVO cntVO = new AnalysisVO();
    	cntVO.setFrDate(vo.getDaylogMakeTime2());
    	cntVO.setToDate(vo.getDaylogMakeTime2());
    	cntVO.setRiverDiv("R01");
    	Integer r01TransCnt = mockService.getTransCnt(cntVO);
    	cntVO.setRiverDiv("R02");
    	Integer r02TransCnt = mockService.getTransCnt(cntVO);
    	cntVO.setRiverDiv("R03");
    	Integer r03TransCnt = mockService.getTransCnt(cntVO);
    	cntVO.setRiverDiv("R04");
    	Integer r04TransCnt = mockService.getTransCnt(cntVO);
    	
    	
    	List<AnalysisVO> spread1 = null;//mockService.getSpread(vo);
    	List<AnalysisVO> spread2 = null;//mockService.getSpread(vo);
    	
    	if(mockService.getDaylogSpreadCnt(vo) == 0)
    	{
    		//전파 현황
    		vo.setAdActKind("S");
    		spread1 = mockService.getSpread(vo);
    		vo.setAdActKind("W");
    		spread2 = mockService.getSpread(vo);
    		
    		mav.addObject("spreadKind", "1");
    	}
    	else
    	{
    		vo.setSpreadType("S");
    		spread1 = mockService.getDaylogSpreadList(vo);
    		vo.setSpreadType("W");
    		spread2 = mockService.getDaylogSpreadList(vo);
    		
    		mav.addObject("spreadKind", "2");
    	}
    	
    
    	//에러 코드 리스트
    	List<ErrorCodeVO> errorCodeList = mockService.getErrorCode();
 	
    	mav.addObject("errorCodeList", errorCodeList);
    	mav.addObject("spread1", spread1);
    	mav.addObject("spread1Cnt", spread1.size());
    	mav.addObject("spread2", spread2);
    	mav.addObject("spread2Cnt", spread2.size());
    	mav.addObject("r01TransCnt", r01TransCnt);
    	mav.addObject("r02TransCnt", r02TransCnt);
    	mav.addObject("r03TransCnt", r03TransCnt);
    	mav.addObject("r04TransCnt", r04TransCnt);
    	mav.addObject("taksu1_cnt", taksuTrans1.size());
    	mav.addObject("taksu2_cnt", taksuTrans2.size());
    	mav.addObject("taksu3_cnt", taksuTrans3.size());
    	mav.addObject("taksu4_cnt", taksuTrans4.size());
    	mav.addObject("data", vo);
    	mav.addObject("ipusn", ipUsnTrans);
    	mav.addObject("taksu1", taksuTrans1);
    	mav.addObject("taksu2", taksuTrans2);
    	mav.addObject("taksu3", taksuTrans3);
    	mav.addObject("taksu4", taksuTrans4);
    	mav.addObject("rainfall", rainFall);
    	mav.addObject("daylogNo", daylogNo);
    	
    	mav.addObject("isModify", isModify);
    	mav.setViewName("/mock/daylogDetail");
    	
    	return mav;
    }
    
    
    /**
     * 일지 완료시키기
     */
    @RequestMapping("/mock/completeDaylog.do")
    public ModelAndView completeDaylog(
    		@RequestParam(value="daylogNo") String daylogNo
    ) throws Exception
    {
    	ModelAndView mav = new ModelAndView();
    	
    	AnalysisVO vo = new AnalysisVO();
    	vo.setDaylogNo(daylogNo);
    	
    	mockService.completeDaylog(vo);
    	
    	mav.setViewName("jsonView");
    	
    	return mav;
    }
    
    @RequestMapping("/mock/updateDayLog.do")
    public String updateDayLog(
    		@ModelAttribute("AnalysisVO") AnalysisVO vo,
    		@RequestParam(value="saveData") String saveData,
    		@RequestParam(value="saveSpreadData") String saveSpreadData
    ) throws Exception
    {
    	    	
    	//기본 근무일지 업데이트
		String wrkTime1 = String.format("%02d", Integer.parseInt(vo.getHTime1())) + ":" + String.format("%02d" ,Integer.parseInt(vo.getMTime1()));
    	String wrkTime2 = String.format("%02d", Integer.parseInt(vo.getHTime2())) + ":" + String.format("%02d", Integer.parseInt(vo.getMTime2()));
    	
    	vo.setWrkTime1(wrkTime1);
    	vo.setWrkTime2(wrkTime2);
    	
    	mockService.updateDayLog(vo);
    	
    	
    	
       	//mockService.saveDaylogSpread(vo);
    	//상황전파 저장
    	String[] saveSpread = saveSpreadData.split(",");
    	
    	for(int idx = 0 ; idx < saveSpread.length ; idx++)
    	{
    		String[] tmp = saveSpread[idx].split("\\|");
    		
    		String spreadTime = "";
    		String spreadDept = "";
    		String spreadContent = "";
    		String spreadType = "";
    		
    		if(tmp.length >= 4)
    		{
    			spreadTime = tmp[0];
    			spreadDept = tmp[1];
    			spreadContent = tmp[2];
    			spreadType = tmp[3];
    			
    			AnalysisVO saveVo = new AnalysisVO();
    			
    			saveVo.setSpreadTime(spreadTime);
    			saveVo.setSpreadContent(spreadContent);
    			saveVo.setSpreadDept(spreadDept);
    			saveVo.setSpreadType(spreadType);
    			
    			saveVo.setDaylogNo(vo.getDaylogNo());
    			mockService.saveDaylogSpread(saveVo);
    		}
    	}
    	
    	
    	//에러코드 저장
    	String[] saveErrors = saveData.split(",");
    	
    	for(int idx = 0 ; idx < saveErrors.length ; idx++)
    	{
    		String[] tmp = saveErrors[idx].split("\\|");
    		
    		String factCode = "";
    		String branchNo = "";
    		String edataCode = "";
    		String warningOc = "";
    		
    		if(tmp.length >= 4)
    		{
    			factCode = tmp[0];
    			branchNo = tmp[1];
    			edataCode = tmp[2];
    			warningOc = tmp[3];

    			
    			//없음으로 선택된거 지움
    			if("none".equals(edataCode))
    			{
    				if(warningOc == null || "-".equals(warningOc) || "".equals(warningOc.trim()))
    				{
	    				AnalysisVO saveVO = new AnalysisVO();
		    			saveVO.setFactCode(factCode);
		    			saveVO.setBranchNo(branchNo);
		    			saveVO.setDaylogNo(vo.getDaylogNo());
		    			
		    			mockService.deleteDaylogDet(saveVO);
    				}
    				else
    				{
    					AnalysisVO saveVO = new AnalysisVO();
    	    			saveVO.setFactCode(factCode);
    	    			saveVO.setBranchNo(branchNo);
    	    			saveVO.setEdataCode(edataCode);
    	    			saveVO.setWarningOc(warningOc);
    	    			saveVO.setDaylogNo(vo.getDaylogNo());
    	    			
    	    			mockService.saveDaylogDet(saveVO);
    				}
    			}
    			else
    			{
	    			AnalysisVO saveVO = new AnalysisVO();
	    			saveVO.setFactCode(factCode);
	    			saveVO.setBranchNo(branchNo);
	    			saveVO.setEdataCode(edataCode);
	    			saveVO.setWarningOc(warningOc);
	    			saveVO.setDaylogNo(vo.getDaylogNo());
	    			
	    			mockService.saveDaylogDet(saveVO);
    			}
    		}
    	}
    
    	return "forward:/mock/goDayLogDet.do";
    }
    
}
