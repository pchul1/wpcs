package daewooInfo.rss.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springmodules.validation.commons.DefaultBeanValidator;

import daewooInfo.rss.bean.RssKeywordSearchVO;
import daewooInfo.rss.bean.RssKeywordVO;
import daewooInfo.rss.service.RssKeywordService;
import daewooInfo.common.TmsMessageSource;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.sim.ClntInfo;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class RssKeywordController {

	/**
	 * rssKeywordService
	 * @uml.property  name="rssKeywordService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "rssKeywordService")
	private RssKeywordService rssKeywordService;
	
	
	/**
	 * EgovPropertyService
	 * @uml.property  name="propertiesService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/**
	 * EgovMessageSource
	 * @uml.property  name="tmsMessageSource"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="tmsMessageSource")
	TmsMessageSource tmsMessageSource;
	
	/**
	 * @uml.property  name="beanValidator"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Autowired
	private DefaultBeanValidator beanValidator;
	
	/**
	 * log
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log log = LogFactory.getLog(RssKeywordController.class);
	
	
	/**
	 * 키워드의 목록을 조회한다.
	 * @param loginVO
	 * @param searchVO
	 * @param model
	 * @return "/rss/keywordList"
	 * @throws Exception
	 */
	@RequestMapping(value="/rss/KeywordList.do")
	public String selectKeywordList(
			@ModelAttribute("searchVO") RssKeywordSearchVO searchVO
			, @ModelAttribute("keywordVO") RssKeywordVO keywordVO
			, Map<String, Object> commandMap
			, HttpServletRequest request
			, ModelMap model
			) throws Exception {
		String mode = (String)commandMap.get("mode");
		if (mode == null) mode = "";
		
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
		searchVO.setPageSize(propertiesService.getInt("pageSize"));
		
		int pageIndex = searchVO.getPageIndex();
		if(mode.equals("edit") || mode.equals("editOK")) {
			pageIndex = Integer.parseInt((String)commandMap.get("pageIndex"));
			searchVO.setKeywordNm((String)commandMap.get("pageIndex"));
			searchVO.setSearchCondition("name");
		}
		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(pageIndex);
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<RssKeywordSearchVO> keywordList = rssKeywordService.selectKeywordList(searchVO);
		model.addAttribute("resultList", keywordList);

		if (mode.equals("edit")) {
//			int keywordId = Integer.parseInt((String)commandMap.get("keywordId"));
//			keywordVO.setKeywordId(keywordId);
			RssKeywordVO vo = rssKeywordService.selectKeywordDetail(keywordVO);
			vo.setKeywordNm(vo.getKeywordNm());
			model.addAttribute("keywordVO", vo);
			model.addAttribute("filterNo", vo.getKeywordId());
			model.addAttribute("keywordNm", vo.getKeywordNm());
			model.addAttribute("currentMode", "");
		}
		
		int totCnt = rssKeywordService.selectKeywordListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("mode", mode);

		if (mode == "edit") {
			return "forward:/rss/KeywordList.do";
		} else {
			return "/rss/keywordList";
		}
	}
	
	/**
	 * 키워드를 등록한다.
	 * @param keywordVO
	 * @param bindingResult
	 * @param commandMap
	 * @return "/rss/Keyword"
	 * @throws Exception
	 */
	@RequestMapping(value="/rss/KeywordRegist.do")
	public String insertKeyword (
			@ModelAttribute("keywordVO") RssKeywordVO keywordVO
			, @ModelAttribute("loginVO") LoginVO loginVO
			, BindingResult bindingResult
			, ModelMap model
			, HttpServletRequest request
			, HttpServletResponse response
			, Map<String, Object> commandMap
			) throws Exception {
		String returnValue = "forward:/rss/KeywordList.do";
		String mode = (String)commandMap.get("mode");
		if (mode == null) mode = "";
		String keywordId = (String)commandMap.get("keywordId");
		String errKeyword = "";
		String message = tmsMessageSource.getMessage("success.request.msg");
		String connectIp = ClntInfo.getClntIP(request);
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		
		if (keywordId == null || keywordId == "") keywordId = "0";
		//비밀번호 키워드 등록
		beanValidator.validate(keywordVO, bindingResult);
		if (bindingResult.hasErrors()){
			return returnValue;
		} else {
			int checkNum = 0;
			String kubun = "";
			if(keywordVO.getKeywordNm().indexOf(",") > -1){
				String keywordArray[]=keywordVO.getKeywordNm().split(",");
				for(int i=0; i < keywordArray.length; i++) {
					if(!keywordArray[i].trim().replaceAll(" ", "").equals("")){
						if(keywordArray[i].trim() != null) {
							keywordVO.setKeywordNm(keywordArray[i].trim());
							keywordVO.setRegId(user.getId());
							int checkCnt = rssKeywordService.selectKeywordCheckCnt(keywordVO);
							if(checkCnt == 0) {
								rssKeywordService.insertKeyword(keywordVO);
							} else {
								if(checkNum > 0) kubun = ",";
								errKeyword = errKeyword + kubun + keywordArray[i].trim();
								checkNum ++;
							}
						}
					}
				}
				if(!errKeyword.equals("")) message = "[" + errKeyword + "] " + tmsMessageSource.getMessage("fail.keyword.duplicationMsg");
			} else {
				keywordVO.setKeywordNm(keywordVO.getKeywordNm().trim());
				keywordVO.setRegId(user.getId());
				int checkCnt = rssKeywordService.selectKeywordCheckCnt(keywordVO);
				if(checkCnt == 0) {
					rssKeywordService.insertKeyword(keywordVO);
				} else {
					errKeyword = tmsMessageSource.getMessage("fail.keyword.msg");
					message = errKeyword;
				}
			}
			model.addAttribute("mode", mode);
			model.addAttribute("resultMsg", message);
			returnValue = "forward:/rss/KeywordList.do";
		}
		return returnValue;
	}
	
	/**
	 * 키워드를 수정한다.
	 * @param keywordVO
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/rss/Keyword"
	 * @throws Exception
	 */
	@RequestMapping(value="/rss/KeywordEdit.do")
	public String updateKeyword (
			@ModelAttribute("keywordVO") RssKeywordVO keywordVO
			, @ModelAttribute("loginVO") LoginVO loginVO
			, BindingResult bindingResult
			, HttpServletRequest request
			, HttpServletResponse response
			, ModelMap model
			, Map<String, Object> commandMap
			) throws Exception {
		String returnValue = "forward:/rss/KeywordList.do";
		String mode = (String)commandMap.get("mode");
		if (mode == null) mode = "";
		String errKeyword = "";
		String message = tmsMessageSource.getMessage("success.request.msg");
		//비밀번호 키워드 수정
		beanValidator.validate(keywordVO, bindingResult);
		if (bindingResult.hasErrors()){
			return returnValue;
		}
		String keywordId = (String)commandMap.get("keywordId");
		
		if (String.valueOf(keywordId) == null) keywordId = "";
		String connectIp = ClntInfo.getClntIP(request);
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		keywordVO.setKeywordId(keywordId);
		keywordVO.setKeywordNm(keywordVO.getKeywordNm().trim());
		keywordVO.setRegId(user.getId());
		int checkCnt = rssKeywordService.selectKeywordCheckCnt(keywordVO);
		if(checkCnt == 0) {
			rssKeywordService.updateKeyword(keywordVO);
			model.addAttribute("resultMsg", message);
			model.addAttribute("mode", mode);
		} else {
			errKeyword = tmsMessageSource.getMessage("fail.keyword.errorsMsg");
			message = "";
			model.addAttribute("resultMsg", errKeyword);
			model.addAttribute("mode", "edit");
			//returnValue = "admin/keyword/KeywordList";
		}
		return returnValue;
	}

	/**
	 * 키워드를 삭제한다.
	 * @param keywordVO
	 * @param model
	 * @return "forward:/rss/keywordList.do"
	 * @throws Exception
	 */
	@RequestMapping(value="/rss/KeywordRemove.do")
	public String deleteKeyword (
			@ModelAttribute("keywordVO") RssKeywordVO keywordVO
			, ModelMap model
			) throws Exception {
		
			rssKeywordService.deleteKeyword(keywordVO);
		
			return "forward:/rss/KeywordList.do";
	}
}