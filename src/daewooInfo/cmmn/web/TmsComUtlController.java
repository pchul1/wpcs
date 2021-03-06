package daewooInfo.cmmn.web;

import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.io.SyndFeedInput;
import com.sun.syndication.io.XmlReader;

import daewooInfo.admin.member.service.MemberService;
import daewooInfo.bbs.bean.BoardVO;
import daewooInfo.bbs.service.EgovBBSManageService;
import daewooInfo.cmmn.PdfUtil;
import daewooInfo.cmmn.bean.ChartVO;
import daewooInfo.cmmn.bean.CmmnDetailCode;
import daewooInfo.cmmn.bean.DeptVO;
import daewooInfo.cmmn.bean.MainweatherAreaVO;
import daewooInfo.cmmn.service.TmsComUtlService;
import daewooInfo.common.TmsProperties;
import daewooInfo.common.login.bean.MemberVO;
import daewooInfo.common.login.service.LoginService;
import daewooInfo.common.util.sim.ClntInfo;
import daewooInfo.rss.bean.RssSearchVO;
import daewooInfo.rss.service.RssManageService;
import daewooInfo.waterpollution.service.WaterPollutionService;
import daewooInfo.weather.bean.WeatherInfoVO;
import daewooInfo.weather.service.WeatherService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : EgovComUtlController.java
 * @Description : 공통유틸리티성 작업을 위한 Controller
 * @Modification Information
 * @
 * @  수정일		 수정자				   수정내용
 * @ -------	--------	---------------------------
 * @ 2010.06.22	kisspa		  
 *
 *  @author kisspa
 *  @since 2010.06.22
 *  @version 1.0
 *  @see
 *  
 */
@Controller
public class TmsComUtlController {

	/**
	 * EgovPropertyService
	 * @uml.property  name="propertiesService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	@Resource(name = "PdfUtil")
	private PdfUtil pdf;
	/**
	 * @uml.property  name="tmsComUtlService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "TmsComUtlService")
	private TmsComUtlService tmsComUtlService;
	
	/**
	 * @uml.property  name="weatherService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "weatherService")
	private WeatherService weatherService;
	
	/**
	 * @uml.property  name="rssManageService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "RssManageService")
    private RssManageService rssManageService;
	
	/**
	 * MemberService
	 * @uml.property  name="memberService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "memberService")
	private MemberService memberService;
	
	/**
	 * LoginService
	 * @uml.property  name="loginService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "loginService")
	private LoginService loginService;
	
	@Resource(name = "WaterPollutionService")
	private WaterPollutionService  waterPollutionService;

	/**
	 * @uml.property  name="bbsMngService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovBBSManageService")
	private EgovBBSManageService bbsMngService;
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Logger log = Logger.getLogger(this.getClass());
	
	/**
	 * 로그인 전 인덱스 페이지
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping("/index.do")
	public String index(ModelMap model) throws Exception {
	 
		model.addAttribute("WaterCount",waterPollutionService.getWaterPollutionRCVCnt());
		model.addAttribute("popupList", bbsMngService.selectMainpopup());
		return "index";
	}
	

	@RequestMapping(value="/popupNotice.do") 
	public String popupNotice(@ModelAttribute("searchVO") BoardVO boardVO ,
			HttpServletRequest request, ModelMap model) 
			throws Exception {
		boardVO.setBbsId("BBSMSTR_000000000030");
		model.addAttribute("popupView", bbsMngService.selectBoardArticle(boardVO));
		return "common/popupNotice";
	}

	@RequestMapping("/indexWaterPollutionChart.do")
	public String getRiverMainChart(ModelMap model, ChartVO chartVO,HttpServletResponse response) throws Exception{
		
		//itemCodeList
		List<ChartVO> List = waterPollutionService.getMainChart(chartVO);

		if(List.size() == 0)
		{
			ChartVO vo = new ChartVO();
			
			vo.setParam1_all("0");
			vo.setParam2_all("0");
			vo.setParam3_all("0");
			vo.setParam4_all("0");
			vo.setParam1_n("0");
			vo.setParam2_n("0");
			vo.setParam3_n("0");
			vo.setParam4_n("0");
			vo.setParam1_y("0");
			vo.setParam2_y("0");
			vo.setParam3_y("0");
			vo.setParam4_y("0");
			List.add(vo);
		}
		StringBuffer title = new StringBuffer();
		title.append("test");
		
		model.addAttribute("title", title.toString());
		model.addAttribute("List",List);
		model.addAttribute("width","733");
		model.addAttribute("height","180");
		model.addAttribute("constLine", "N");
		model.addAttribute("chartType", 2);  
		
		return "mainChart";
	}	
	/**
	 * 샘플 페이지
	 * @return
	 */
	@RequestMapping("/common/sample.do")
	public String sample() {
		return "common/sample";
	}
	
	/**
	 * param을 인자로 받아서 바로 jsp로 리턴해줌.
	 * ex) /psupport/psupport.do?param=psupport/list
	 *	 WEB-INF/jsp/psupport/list.jsp
	 *	 
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmmn/link.do")
	public String recentlyBoardList(
			Map<String, Object> commandMap,
			ModelMap model) throws Exception {
		String view = (String)commandMap.get("page");
		if(view.indexOf("../") >= 0 || view.indexOf("WEB-INF") >= 0 || view.indexOf("web.xml") >= 0){
			view = "/cmmn/egovError";
		}
		String menu = (String)commandMap.get("menu");
		model.addAttribute("menu", menu);
		model.addAttribute("page", view);
		
		return view;
	}
	
	 /**
	 * 팝업 페이지를 호출한다.
	 * 
	 * @param userVO
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/common/openPopup.do")
	public String openPopupWindow(Map<String, Object> commandMap, ModelMap model) throws Exception {

		String requestUrl = (String)commandMap.get("requestUrl");
		String trgetId = (String)commandMap.get("trgetId");
		String width = (String)commandMap.get("width");
		String height = (String)commandMap.get("height");
		String typeFlag = (String)commandMap.get("typeFlag");
	
		//log.debug(this.getClass().getName()+">>>>requestUrl  Before "+requestUrl);
		//log.debug(this.getClass().getName()+">>>>trgetId  Before "+trgetId);
		//log.debug(this.getClass().getName()+">>>>typeFlag  Before "+typeFlag);
	
		if (trgetId != null && trgetId != "") {
			if (typeFlag != null && typeFlag != "") {
			model.addAttribute("requestUrl", requestUrl + "?trgetId=" + trgetId + "&PopFlag=Y&typeFlag=" + typeFlag);
			} else {
			model.addAttribute("requestUrl", requestUrl + "?trgetId=" + trgetId + "&PopFlag=Y");
			}
		} else {
			if (typeFlag != null && typeFlag != "") {
			model.addAttribute("requestUrl", requestUrl + "?PopFlag=Y&typeFlag=" + typeFlag);
			} else {
			model.addAttribute("requestUrl", requestUrl + "?PopFlag=Y");
			}
	
		}
	
		model.addAttribute("width", width);
		model.addAttribute("height", height);
		
		return "/cmmn/egovModalPopupFrame";
	}
	
	/**
	 * JSP 호출작업만 처리하는 공통 함수
	 */
	@RequestMapping(value="/EgovPageLink.do")
	public String moveToPage(@RequestParam("link") String linkPage){
		String link = linkPage;
		// service 사용하여 리턴할 결과값 처리하는 부분은 생략하고 단순 페이지 링크만 처리함
		if (linkPage==null || linkPage.equals("")){
			link="cmmn/egovError";
		}
		return link;
	}

	/**
	 * JSP 호출작업만 처리하는 공통 함수
	 */
	@RequestMapping(value="/EgovPageLink.action")
	public String moveToPage_action(@RequestParam("link") String linkPage){
		String link = linkPage;
		// service 사용하여 리턴할 결과값 처리하는 부분은 생략하고 단순 페이지 링크만 처리함
		if (linkPage==null || linkPage.equals("")){
			link="cmmn/egovError";
		}
		return link;
	}
	
	/**
	 * 공통코드를 json형식으로 리턴해준다.
	 * @param 공통코드 카테고리
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmmn/getCode.do")
	public ModelAndView getCode(
			@RequestParam("code_id") String code_id,
			@RequestParam(required=false, value="flag") String flag
	) throws Exception{
		
		HashMap<String, String> map;
		
		ModelAndView modelAndView = new ModelAndView();
		List<Map<String,String>> codes = (List<Map<String,String>>)tmsComUtlService.getCode(code_id);
		
		if (flag == null) flag = "";
		
		if (flag.equals("all")) {
			map = new HashMap<String, String>();
			map.put("VALUE", "");
			map.put("CAPTION", "전체");
			codes.add(0,map);
		} else if (flag.equals("select")) {
			map = new HashMap<String, String>();
			map.put("VALUE", "");
			map.put("CAPTION", "선택");
			codes.add(0,map);
		}
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 메인(로그인후) - 금일 사고 발생 현황 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmmn/todayAccident.do")
	public ModelAndView todayAccident() throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		List<Map<String,String>> result = tmsComUtlService.todayAccident();
		modelAndView.addObject("todayAccident", result);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 날씨관련 코드를 가져온다.
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmmn/weatherAreaInfo.do")
	public ModelAndView weatherAreaInfo() throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		List<MainweatherAreaVO> result = tmsComUtlService.weatherAreaInfo("");
		modelAndView.addObject("weatherAreaInfo", result);
		modelAndView.setViewName("jsonView");
		 
		return modelAndView;
	}
	
	/**
	 * 날씨관련 코드를 기준으로 기상청의 웹서비스를 통해
	 * 날씨관련 코드에 등록된 factCode를 for문 돌며 전체 기상정보를 가져온후
	 * List 형태로 리턴해줌
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmmn/mainWeatherInfoList.do")
	public ModelAndView mainWeatherInfoList(
			@RequestParam(value="river_id", required=false) String river_id	
		) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		List<WeatherInfoVO> weatherInfoList = new ArrayList<WeatherInfoVO>();
		
		if (river_id == null || "".equals(river_id)) { river_id = "R01"; }// 한강
		 
		List<MainweatherAreaVO> result = tmsComUtlService.weatherAreaInfo(river_id);
		
		// for문을 돌며 날씨관련 코드에 있는 factCode값들의 날씨 정보를 가져온다.
		for (int i=0; i < result.size(); i++) {
			 
			WeatherInfoVO tmp = weatherService.getCurrentWeather(result.get(i).getFactCode(), result.get(i).getBranchNo(), null);
			tmp.setFactCode(result.get(i).getFactCode());
			weatherInfoList.add(tmp);
		}
		
		modelAndView.addObject("mainWeatherInfoList", weatherInfoList);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * SMS 팝업
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmmn/alertSmsSend.do")
	public String alertSmsSend(
			@RequestParam(value="sugye") String sugye,
			@RequestParam(value="factCode") String factCode,
			@RequestParam(value="factName") String factName,
			@RequestParam(value="weatherName", required=false) String weatherName,
			ModelMap model
			) throws Exception {
		
		model.addAttribute("sugye", sugye);
		model.addAttribute("factCode", factCode);
		model.addAttribute("factName", factName);
		model.addAttribute("weatherName", weatherName);
		
		return "cmmn/alertSmsSend";
	}
	
	/**
	 * 조직도를 트리형식으로 가져옴
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmmn/deptTree.do")
	public String deptTree(ModelMap model) throws Exception {

		List<DeptVO> result = tmsComUtlService.deptTree();
		model.addAttribute("result", result);
		return "cmmn/deptTree";
	}
	
	/**
	 * RSS 리더 (최근 or 팝업)
	 * @return
	 */
	@RequestMapping("/rss/reader.do")
	public String rssReader(Map<String, Object> commandMap, ModelMap model) {
		
		String returnValue = "common/popup/rssFeedList";
		
		try {
			
			// recently | popup
			String view = (String)commandMap.get("view"); // 최근 or 팝업
			
			if (view != null && "pub".equals(view)) {
				returnValue = "pub/bbs/rssFeedList";
			} else if (view != null && "popup".equals(view)) {
				returnValue = "common/popup/rssFeedList";
			} else {
				returnValue = "common/rssFeedRecently";
			}
			
			String rssFeedUrl = TmsProperties.getProperty("rss.rssFeedUrl");
			
			URL feedUrl = new URL(rssFeedUrl);
			SyndFeedInput input = new SyndFeedInput();
			SyndFeed feed = input.build(new XmlReader(feedUrl));
			List entries = feed.getEntries();
			
			model.addAttribute("feedList", entries);
			model.addAttribute("view", view);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return returnValue;
	}
	
	/**
	 * RSS 조회
	 * @return
	 */
	@RequestMapping("/rss/rssDataSelect.do")
	public String rssDataSelect(
			@ModelAttribute("searchVO") RssSearchVO searchVO
			, Map<String, Object> commandMap
			, ModelMap model) {
		
		String returnValue = "pub/bbs/rssFeedList";
		
		try {
			searchVO.setPageUnit(10);		
			
			searchVO.setPageSize(propertiesService.getInt("pageSize"));
		
			PaginationInfo paginationInfo = new PaginationInfo();
			
			paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
			paginationInfo.setPageSize(searchVO.getPageSize());
		
			searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
			searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
			Map<String, Object> map = rssManageService.rssDataSelect(searchVO);
			
			int totCnt = Integer.parseInt((String)map.get("resultCnt"));
			
			paginationInfo.setTotalRecordCount(totCnt);
			
			List<RssSearchVO> resultList = (List<RssSearchVO>)map.get("resultList");
			
			model.addAttribute("resultList", resultList);
			model.addAttribute("resultCnt", totCnt);
			model.addAttribute("searchVO", searchVO);
			model.addAttribute("paginationInfo", paginationInfo);
			
			model.addAttribute("menu", commandMap.get("menu"));
			model.addAttribute("no", commandMap.get("no"));
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return returnValue;
	}
	
	/**
	 * 계정신청
	 * @return
	 */
	@RequestMapping("/acc/accountApp.do")
	public String accountApp(
			 Map<String, Object> commandMap
			, ModelMap model) {
		
		String view = (String)commandMap.get("page");
		if(view.indexOf("../") >= 0 || view.indexOf("WEB-INF") >= 0 || view.indexOf("web.xml") >= 0){
			view = "/cmmn/egovError";
		}
		String menu = (String)commandMap.get("menu");
		model.addAttribute("menu", menu);
		model.addAttribute("page", view);
		
		return view;
	}
	
	/**
	 * 계정신청>정보입력
	 * @return
	 */
	@RequestMapping("/acc/accountAppInfo.do")
	public String accountAppInfo(
			 @ModelAttribute("memberVO") MemberVO memberVO
			, Map<String, Object> commandMap
			, ModelMap model)throws Exception {	
		
		String returnValue = "pub/acc/accountAppStep2";
		
		// 시/도, 시/군 정보를 가져온다.
		List<CmmnDetailCode> areaDoCode = loginService.getAreaDoCode();
		//List<Map<String,String>> areaCtyCode = loginService.getAreaCtyCode();
		List<CmmnDetailCode> areaCtyCodeAll = loginService.getAreaCtyCodeAll();
		
		// 담당 수계 정보를 가져온다.
		List<CmmnDetailCode> riverIdCode = loginService.getRiverIdCode();
		
		// 수계, 공구 정보를 가져온다.
		List<CmmnDetailCode> factInfoCode = loginService.getFactInfoCode();
		
		// 관련기관 정보를 가져온다.
		List<CmmnDetailCode> organCode = loginService.getOrganCode();
		
		// 부서정보를 가져온다.
		List<DeptVO> deptCode = loginService.getDeptCode("0");
		
		// 그룹정보를 가져온다.
		List<CmmnDetailCode> groupCode = loginService.getGroupCode();
		
		model.addAttribute("riverIdCode", riverIdCode);
		model.addAttribute("areaDoCode", areaDoCode);
		model.addAttribute("areaCtyCodeAll", areaCtyCodeAll);
		model.addAttribute("organCode", organCode);
		model.addAttribute("factInfoCode", factInfoCode);
		model.addAttribute("deptCode", deptCode);
		model.addAttribute("groupCode", groupCode);
		
		return returnValue;
	}
	
	/**
	 * ID중복 체크
	 * @param upperDeptNo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/acc/duplicateIdCheck.do")
	public ModelAndView duplicateIdCheck(
			@RequestParam("memberId") String memberId
		) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		int userCnt = memberService.getDuplicateIdCheck(memberId);
		
		String isIdCheck = "";
		
		if(userCnt == 0){
			isIdCheck = "Y";
		}else{
			isIdCheck = "N";
		}
		
		modelAndView.addObject("isIdCheck", isIdCheck);
		modelAndView.setViewName("jsonView");
		return modelAndView;
		
	}
	
	/**
	 * 계정신청
	 * @param loginVO 
	 * @param memberVO
	 * @param bindingResult
	 * @param model
	 * @return "/admin/member/MemberApplyProc"
	 * @throws Exception
	 */
	@RequestMapping(value="/acc/insertMemberApplyProc.do")
	public String insertMemberApplyProc (
			@ModelAttribute("memberVO") MemberVO memberVO
			, HttpServletRequest request
			, Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		String connectIp = ClntInfo.getClntIP(request);
		memberVO.setConnectIp(connectIp);
		
		if (null == memberVO.getDeptNo() || "".equals(memberVO.getDeptNo())) {
			memberVO.setDeptNo(memberVO.getDeptNoTmp());
		}
		
		memberVO.setEmail(memberVO.getEmail()+"@"+memberVO.getEmail1());
		memberVO.setOfficeNo(memberVO.getOfficeNo()+"-"+memberVO.getOfficeNo1()+"-"+memberVO.getOfficeNo2());
		memberVO.setMobileNo(memberVO.getMobileNo()+"-"+memberVO.getMobileNo1()+"-"+memberVO.getMobileNo2());
		memberVO.setFaxNum(memberVO.getFaxNum()+"-"+memberVO.getFaxNum1()+"-"+memberVO.getFaxNum2());
		
		memberVO.setPrivacyAgree("Y");
		
		memberVO.setApprovalFlag("S");//S:대기
//		memberVO.setMemberMgId("");
		memberService.insertMemberApply(memberVO);
		
		memberService.updateMemberMgId(memberVO.getMemberId());
		
//		MemberVO vo = memberService.selectMemberDetail(memberVO);
		
		// 세션에 값을 넣는 이유는 /acc/accountAppFinish.do 로의 URL직접 접근을 막기 위해서이다.
		request.getSession().setAttribute("urlAccessControl", "true");
		
		model.addAttribute("memberVO", memberVO);
		
		String return_str = "forward:/acc/accountAppFinish.do";
		if(request.getRequestURL().indexOf("waterkorea.or.kr") >= 0)
		{
			return_str = "redirect:http://www.waterkorea.or.kr/acc/accountAppFinish.do?memberId=" + memberVO.getMemberId();
		}
		return return_str;
		
//		return returnValue;
	}
	
	/**
	 * 계정신청>정보입력
	 * @return
	 */
	@RequestMapping(value="/acc/accountAppFinish.do")
	public String accountAppFinish(
			 @ModelAttribute("memberVO") MemberVO memberVO
			, HttpServletRequest request
			, HttpServletResponse response
			, Map<String, Object> commandMap
			, ModelMap model)throws Exception {	
		
		// 페이지 URL 직접 접근통제 (고객정보 확인 가능 http://www.waterkorea.or.kr/acc/accountAppFinish.do?memberId=waterkorea)
		String sessionStr = (String) request.getSession().getAttribute("urlAccessControl");
		if(sessionStr == null || !"true".equals(sessionStr)){
			response.setContentType("text/html; charset=UTF-8");
			response.getWriter().print("<script>alert('잘못된 접근입니다.');document.location.href='/index.do';</script>");
			return null;
		}
		// 기존 세션 악용방지...
		request.getSession().setAttribute("urlAccessControl", "false");
		
		MemberVO vo = memberService.selectMemberInfo(memberVO.getMemberId());
//		MemberVO vo = memberService.selectMemberDetail(memberVO);
		
		model.addAttribute("memberVO", vo);
		
		return "/pub/acc/accountAppStep3";
	}
	

	@RequestMapping(value="/acc/accountAppPdfDown.do")
	public String accountAppTestFinish(
			 @ModelAttribute("memberVO") MemberVO memberVO
			, HttpServletRequest request
			, HttpServletResponse response
			, Map<String, Object> commandMap
			, ModelMap model)throws Exception {
		
		
		MemberVO vo = memberService.selectMemberInfo(memberVO.getMemberId());

		
		String body = "<div style='clear: both;color: #111111;font-size: 26px;font-weight: bold;margin: 26px 0 40px;'>계정신청</div>"+ 
		"<table width=\"756\" cellspacing=\"0\" cellpadding=\"0\" style='margin:20px 0;'>"+
		"	<colgroup>"+
		"		<col width=\"200\" />"+
		"		<col />"+
		"	</colgroup>"+
		"	<tr>"+
		"		<th>관련기관</th>"+
		"		<td align='left'>"+
		"			" + vo.getDeptNoName() +
		"		</td>"+
		"	</tr>"+
		"	<tr>"+
		"		<th>직급(위)</th>"+
		"		<td align='left'>"+
		"			" + vo.getGradeName()+
		"		</td>"+
		"	</tr>"+
		"	<tr>"+
		"		<th>이름</th>"+
		"		<td align='left'>"+
		"			" + vo.getMemberName()+
		"		</td>"+
		"	</tr>"+
		"	<tr>"+
		"		<th>아이디</th>"+
		"		<td align='left'>"+
		"			" + vo.getMemberId()+
		"		</td>"+
		"	</tr>"+
		"	<tr>"+
		"		<th>이메일</th>"+
		"		<td align='left'>"+
		"			" + vo.getEmail()+
		"		</td>"+
		"	</tr>"+
		"	<tr>"+
		"		<th>연락처</th>"+
		"		<td align='left'>"+
		"			<div style=\"margin-top:5px\">"+
		"				사무실: " + vo.getOfficeNo()+
		"			</div>"+
		"			<div style=\"margin-top:5px\">"+
		"				핸드폰:" + vo.getMobileNo()+
		"			</div>"+
		"			<div style=\"margin-top:5px; margin-bottom:5px;\">"+
		"				<span style=\"margin-right:12px;\">팩</span>스:" + vo.getFaxNum()+
		"			</div>"+
		"		</td>"+
		"	</tr>"+
		"	<tr>"+
		"		<th>비고</th>"+
		"		<td align='left'>"+
		"			" + vo.getBigo() +
		"		</td>"+
		"	</tr>"+
		"</table>" +
		"<div style='padding-top:20px;'>"+ 
		"<div style='padding:10px 0 5px 0;color:red;'>※계정 승인을 위해 신청완료 폼을 출력 또는 다운로드 받은 후 전자문서로 보내주시기 바랍니다.</div>"+
		"<div style='padding:5px 0;'>※보내실 곳 : E.amil test@keco.or.kr 또는 Fax 032-590-1234</div>"+ 
		"</div>";
		
		pdf.pdfmake(response, body);
		pdf.pdfdownload(response);
		return null;
	}
	

	@RequestMapping("/acc/accountAppPrint.do")
	public ModelAndView accountAppPrint_popup(
			   HttpServletResponse res
			, Map<String, Object> commandMap
			, @RequestParam(value="memberId", 		required=false) String memberId
			, @ModelAttribute("memberVO") MemberVO memberVO
			, ModelAndView modelAndView
			) throws Exception {
		
		MemberVO vo = memberService.selectMemberInfo(memberId);
		  
		modelAndView.setViewName("pub/acc/accountAppPrint");
		
		modelAndView.addObject("memberVO", vo);
		
		return modelAndView;
	}
	
	/**
	 * ID/PW찾기
	 * @return
	 */
	@RequestMapping("/acc/accountFindId.do")
	public String accountFindId(
			 @ModelAttribute("memberVO") MemberVO memberVO
			, HttpServletRequest request
			, Map<String, Object> commandMap
			, ModelMap model)throws Exception {	
		
		String returnValue = "pub/acc/accountFindId";
		
		// 시/도, 시/군 정보를 가져온다.
		List<CmmnDetailCode> areaDoCode = loginService.getAreaDoCode();
		//List<Map<String,String>> areaCtyCode = loginService.getAreaCtyCode();
		List<CmmnDetailCode> areaCtyCodeAll = loginService.getAreaCtyCodeAll();
		
		// 담당 수계 정보를 가져온다.
		List<CmmnDetailCode> riverIdCode = loginService.getRiverIdCode();
		
		// 수계, 공구 정보를 가져온다.
		List<CmmnDetailCode> factInfoCode = loginService.getFactInfoCode();
		
		// 관련기관 정보를 가져온다.
		List<CmmnDetailCode> organCode = loginService.getOrganCode();
		
		// 부서정보를 가져온다.
		List<DeptVO> deptCode = loginService.getDeptCode("0");
		
		// 그룹정보를 가져온다.
		List<CmmnDetailCode> groupCode = loginService.getGroupCode();
		

		model.addAttribute("findId", request.getParameter("findId"));
		model.addAttribute("searchId", request.getSession().getAttribute("searchId"));
		model.addAttribute("searchMemverVO", request.getSession().getAttribute("searchMemverVO"));
		request.getSession().setAttribute("searchId", null);
		request.getSession().setAttribute("searchMemverVO", null);
		model.addAttribute("riverIdCode", riverIdCode);
		model.addAttribute("areaDoCode", areaDoCode);
		model.addAttribute("areaCtyCodeAll", areaCtyCodeAll);
		model.addAttribute("organCode", organCode);
		model.addAttribute("factInfoCode", factInfoCode);
		model.addAttribute("deptCode", deptCode);
		model.addAttribute("groupCode", groupCode);
		
		return returnValue;
	}
	
	/**
	 * ID찾기
	 * @param upperDeptNo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/acc/getAccountFindId.do")
	public String getAccountFindId(
			@ModelAttribute("memberVO") MemberVO memberVO
		  , HttpServletRequest request
		  ,	@RequestParam(value="deptNoTmp", required=false) String deptNoTmp
		  , @RequestParam(value="deptNo", required=false) String deptNo
		  , @RequestParam(value="ctyCode", required=false) String ctyCode
		  , @RequestParam(value="memberName", required=false) String memberName
		  , @RequestParam(value="email", required=false) String email
		  , @RequestParam(value="email1", required=false) String email1
			, ModelMap model
		) throws Exception {
		
		String memberId = memberService.getAccountFindId(memberVO);
		
		request.getSession().setAttribute("searchId", memberId);
		request.getSession().setAttribute("searchMemverVO", memberVO);
		
		String return_str = "redirect:/acc/accountFindId.do?findId=Y";
		if(request.getRequestURL().indexOf("waterkorea.or.kr") >= 0)
		{
			return_str = "redirect:http://www.waterkorea.or.kr/acc/accountFindId.do?findId=Y";
		}
		
		return return_str;
	}
	
	/**
	 * validato rule dynamic Javascript
	 */
	@RequestMapping("/validator.do")
	public String validate(){
		return "cmmn/validator";
	}
	

	/**
	 * 로그인 전 인덱스 페이지
	 * @return
	 */
	@RequestMapping("/loginFail.do")
	public String loginFail(HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print("<script>alert('로그인 정보가 올바르지 않습니다.');location.replace('/');</script>");
		return null;
	}
	
	/**
	 * 세션 로그아웃 
	 * @return
	 */
	@RequestMapping("/sessionTimeout.do")
	public String sessionTimeout(HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print("<script>alert('10분 동안 사용하지 않아 로그아웃되었습니다. 다시 로그인 해 주십시요.');location.replace('/');</script>");
		return null;
	}
}