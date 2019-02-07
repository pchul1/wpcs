package daewooInfo.rss.web;

import java.net.URL;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.ui.ModelMap;

import com.sun.syndication.feed.synd.SyndEntry;
import com.sun.syndication.feed.synd.SyndFeed;
import com.sun.syndication.io.SyndFeedInput;
import com.sun.syndication.io.XmlReader;

import daewooInfo.admin.keyword.bean.KeywordVO;
import daewooInfo.admin.keyword.service.KeywordService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.util.fcc.StringUtil;
import daewooInfo.common.TmsMessageSource;
import daewooInfo.rss.bean.RssSearchVO;
import daewooInfo.rss.bean.RssVO;
import daewooInfo.rss.service.RssManageService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;


/**
 * 
 * 보도자료 관리
 * @author yrkim
 * @since 2014.09.04
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2014.09.04  yrkim          최초 생성
 *
 * </pre>
 */

@Controller
public class RssManageController {

	/**
	 * @uml.property  name="rssManageService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "RssManageService")
    private RssManageService rssManageService;
	
	/**
	 * keywordService
	 * @uml.property  name="keywordService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "keywordService")
	private KeywordService keywordService;
	
	/**
	 * @uml.property  name="propertyService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	/**
	 * EgovMessageSource
	 * @uml.property  name="tmsMessageSource"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="tmsMessageSource")
	TmsMessageSource tmsMessageSource;

	/**
	 * log
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
    Log log = LogFactory.getLog(RssManageController.class);
	
	/**
	 * 보도자료 목록 데이터
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/rss/rssDataList.do")
	public String selectRssDataList(
			@ModelAttribute("searchVO") RssSearchVO searchVO, 
			Map<String, Object> commandMap,
			ModelMap model) throws Exception {
		
		String returnValue = "rss/rssManageList";
		
		DecimalFormat df = new DecimalFormat("00");
		Calendar currentCalendar = Calendar.getInstance();
		
		if(StringUtil.isEmpty(searchVO.getStartDate())){
			
		    //현재 날짜 구하기
			String endYear   = Integer.toString(currentCalendar.get(Calendar.YEAR));
			String endMonth  = df.format(currentCalendar.get(Calendar.MONTH) + 1);
			String endDay   = df.format(currentCalendar.get(Calendar.DATE));
			String endDate = endYear+"/"+endMonth+"/"+endDay;
			
			//한달 전 날짜 구하기
			currentCalendar.add(currentCalendar.MONTH, -1);
		    String startYear   = Integer.toString(currentCalendar.get(Calendar.YEAR));
		    String startMonth  = df.format(currentCalendar.get(Calendar.MONTH) + 1);
		    String startDay   = df.format(currentCalendar.get(Calendar.DATE));
		    String startDate = startYear +"/"+startMonth +"/"+startDay;
			
			searchVO.setStartDate(startDate);
			searchVO.setEndDate(endDate);
		}
			
		searchVO.setPageUnit(10);		
		
		searchVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
	
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		Map<String, Object> map = rssManageService.rssDataList(searchVO);
		
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		List<RssSearchVO> resultList = (List<RssSearchVO>)map.get("resultList");
		
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", totCnt);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("paginationInfo", paginationInfo);
		
		model.addAttribute("menu", commandMap.get("menu"));
		model.addAttribute("no", commandMap.get("no"));
		
		return returnValue;
	}
	
	/**
	 * 보도자료 엑셀 다운로드
	 */
	@RequestMapping("/rss/rssDataListExcel.do")
	public ModelAndView selectRssDataListExcel (
			@ModelAttribute("searchVO") RssSearchVO searchVO
	) throws Exception {
		
		List<RssSearchVO> data = rssManageService.rssDataListExcel(searchVO);
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("data", data);
		map.put("searchVO", searchVO);
		
		ModelAndView mav = null;
		
		mav = new ModelAndView("ExcelRssDataView", "map", map);
		
		return mav;
	}
	
	/**
	 * 보도자료 등록
	 */
	@RequestMapping("/rss/rssDataRegist.do")
	public String insertRssData (
			@ModelAttribute("searchVO") RssSearchVO rssSearchVO
			,@ModelAttribute("rssVO") RssVO rssVO
			, ModelMap model
			, HttpServletRequest request
			, HttpServletResponse response
			, Map<String, Object> commandMap
			) throws Exception {
		
		String returnValue = "";
		
		String message = tmsMessageSource.getMessage("success.request.msg");
		
		if(rssVO.getCheckRssId().indexOf(",") > -1){
			String checkNoArray[] = rssVO.getCheckRssId().split(",");
			
			for(int i=0; i<checkNoArray.length; i++){
				rssVO.setRssId(checkNoArray[i]);
				
				rssManageService.insertRssData(rssVO);
			}
		}else{
			rssVO.setRssId(rssVO.getCheckRssId());
			
			rssManageService.insertRssData(rssVO);
		}
		
		model.addAttribute("searchVO", rssSearchVO);
		model.addAttribute("resultMsg", message);
		
		returnValue = "forward:/rss/rssDataList.do";
		
		return returnValue;
	}
	
	/**
	 * 보도자료 삭제
	 */
	@RequestMapping("/rss/rssDataDelete.do")
	public String deleteRssData (
			@ModelAttribute("searchVO") RssSearchVO rssSearchVO
			,@ModelAttribute("rssVO") RssVO rssVO
			, ModelMap model
			, HttpServletRequest request
			, HttpServletResponse response
			, Map<String, Object> commandMap
			) throws Exception {
		
		String returnValue = "";
		
		String message = tmsMessageSource.getMessage("success.request.msg");
		
		if(rssVO.getCheckRssId().indexOf(",") > -1){
			String checkNoArray[] = rssVO.getCheckRssId().split(",");
			
			for(int i=0; i<checkNoArray.length; i++){
				rssVO.setRssId(checkNoArray[i]);
				
				rssManageService.deleteRssData(rssVO);
			}
		}else{
			rssVO.setRssId(rssVO.getCheckRssId());
			
			rssManageService.deleteRssData(rssVO);
		}
		
		model.addAttribute("searchVO", rssSearchVO);
		model.addAttribute("resultMsg", message);
		
		returnValue = "forward:/rss/rssDataList.do";
		
		return returnValue;
	}
	
	/**
	 * 보도자료 읽어오기
	 */
	@RequestMapping("/rss/rssReader.do")
	public void rssReader(
			@ModelAttribute("rssVO") RssVO rssVO
		  , @ModelAttribute("keywordVO") KeywordVO keywordVO
	) {
		try{
			
			List<KeywordVO> rssKeyword = keywordService.rssKeywordSelect();
			
			String keyword = "";
			for(int i=0; i<rssKeyword.size(); i++){
				if(i==0){
					keyword = rssKeyword.get(i).getKeywordNm();
				}else{
					keyword = keyword+"+"+rssKeyword.get(i).getKeywordNm();
				}
			}
			String rssFeedUrl = "http://newssearch.naver.com/search.naver?where=rss&query="+keyword+"&st=news.all&q_enc=EUC-KR&r_enc=UTF-8&r_format=xml&rp=none&sm=all.basic&ic=all&so=rel.dsc&detail=0&pd=1&start=1&display=50";
			
			URL feedUrl = new URL(rssFeedUrl);
			SyndFeedInput input = new SyndFeedInput();
			SyndFeed feed = input.build(new XmlReader(feedUrl));
			List<SyndEntry> entries = feed.getEntries();
			
			SyndEntry entry = null;
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmm");
			
			String checkDate = "";
			
			DecimalFormat df = new DecimalFormat("00");
			Calendar currentCalendar = Calendar.getInstance();
			//현재 날짜 구하기
			String year   = Integer.toString(currentCalendar.get(Calendar.YEAR));
			String month  = df.format(currentCalendar.get(Calendar.MONTH) + 1);
			String day   = df.format(currentCalendar.get(Calendar.DATE));
			checkDate = year+month+day;
			
			for(int i=0; i<entries.size(); i++){
				entry = entries.get(i);
				
				rssVO.setAuthor(entry.getAuthor());
				rssVO.setTitle(entry.getTitle());
				rssVO.setDescription(entry.getDescription().getValue());
				rssVO.setUrl(entry.getUri());
				rssVO.setPublisheddate(sdf.format(entry.getPublishedDate()));
				
				int cnt = rssManageService.rssReaderSelect(checkDate);
				
				//타이틀이 같은 경우는 저장 하지 않음
				if(cnt == 0){
					rssManageService.insertRssReader(rssVO);
				}
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}