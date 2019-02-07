package daewooInfo.bbs.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import daewooInfo.admin.bbs.service.EgovBBSAttributeManageService;
import daewooInfo.bbs.bean.Board;
import daewooInfo.bbs.bean.BoardMaster;
import daewooInfo.bbs.bean.BoardMasterVO;
import daewooInfo.bbs.bean.BoardVO;
import daewooInfo.bbs.service.EgovBBSManageService;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.cmmn.service.EgovFileMngService;
import daewooInfo.common.TmsMessageSource;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.EgovFileMngUtil;
import daewooInfo.common.util.fcc.StringUtil;
import daewooInfo.weather.bean.WeatherInfoVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 게시물 관리를 위한 컨트롤러 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일	  수정자		   수정내용
 *  -------	   --------	---------------------------
 *   2009.3.19  이삼섭		  최초 생성
 *
 * </pre>
 */
@Controller
public class EgovBBSManageController {

	/**
	 * @uml.property  name="bbsMngService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovBBSManageService")
	private EgovBBSManageService bbsMngService;

	/**
	 * @uml.property  name="bbsAttrbService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovBBSAttributeManageService")
	private EgovBBSAttributeManageService bbsAttrbService;

	/**
	 * @uml.property  name="fileMngService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;

	/**
	 * @uml.property  name="fileUtil"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;

	/**
	 * @uml.property  name="propertyService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	/**
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
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Logger log = Logger.getLogger(this.getClass());
	
	/**
	 * XSS 방지 처리.
	 * 
	 * @param data
	 * @return
	 */
	protected String unscript(String data) {
		if (data == null || data.trim().equals("")) {
			return "";
		}
		
		String ret = data;
		
		ret = ret.replaceAll("<(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;script");
		ret = ret.replaceAll("</(S|s)(C|c)(R|r)(I|i)(P|p)(T|t)", "&lt;/script");
		
		ret = ret.replaceAll("<(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;object");
		ret = ret.replaceAll("</(O|o)(B|b)(J|j)(E|e)(C|c)(T|t)", "&lt;/object");
		
		ret = ret.replaceAll("<(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;applet");
		ret = ret.replaceAll("</(A|a)(P|p)(P|p)(L|l)(E|e)(T|t)", "&lt;/applet");
		
		ret = ret.replaceAll("<(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
		ret = ret.replaceAll("</(E|e)(M|m)(B|b)(E|e)(D|d)", "&lt;embed");
		
		ret = ret.replaceAll("<(F|f)(O|o)(R|r)(M|m)", "&lt;form");
		ret = ret.replaceAll("</(F|f)(O|o)(R|r)(M|m)", "&lt;form");

		return ret;
	}
	
	/**
	 * 최근 게시물을 보여준다.
	 * @param boardVO
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/bbs/recentlyBBS.do")
	public String recentlyBoardList(
			@ModelAttribute("searchVO") BoardVO boardVO, 
			Map<String, Object> commandMap,
			ModelMap model) throws Exception {
		
		String view = (String)commandMap.get("view");
		if (StringUtil.isEmpty(view)) {
			view = "index";
		}
		
		boardVO.setFirstIndex(0);
		boardVO.setBbsId(boardVO.getBbsId());
		boardVO.setRecordCountPerPage(boardVO.getRecordCountPerPage());
		
		BoardMasterVO vo = new BoardMasterVO();
		vo.setBbsId(boardVO.getBbsId());
		
		BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
	
		Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, vo.getBbsAttrbCode());
		
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("brdMstrVO", master);
		model.addAttribute("view", view);
		
		return "bbs/recentlyBBS";
	}
	
	/**
	 * 게시물에 대한 목록을 조회한다.
	 * 
	 * @param boardVO
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/bbs/selectBoardList.do")
	public String selectBoardArticles(
			@ModelAttribute("searchVO") BoardVO boardVO, 
			HttpServletRequest request,
			Map<String, Object> commandMap,
			ModelMap model) throws Exception {
		
		String returnValue = "bbs/EgovNoticeList";
		
		if ("pub".equals(commandMap.get("view"))) {
			returnValue = "pub/bbs/NoticeList";
		}
		
		// 일반게시판일 경우만 팝업으로 보여주게..
		if ("popup".equals(commandMap.get("viewFlag"))) {
			returnValue = "common/popup/bbsList";
		}
		
		String galleryNttId = (String)commandMap.get("galleryNttId");
		
		boardVO.setBbsId(boardVO.getBbsId());
		boardVO.setBbsNm(boardVO.getBbsNm());
	
		BoardMasterVO vo = new BoardMasterVO();
		
		vo.setBbsId(boardVO.getBbsId());
		//vo.setUniqId(user.getUniqId());
		
		BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
	
		boardVO.setPageUnit(propertyService.getInt("pageUnit"));
		
		// 갤러리 게시판이라면 리스트를 16개씩만 뿌려주자.
		if (master.getBbsAttrbCode().equals("BBSA02")) {
			boardVO.setPageUnit(16);
		}else{
			boardVO.setPageUnit(15);
		}
		
		boardVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
	
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, vo.getBbsAttrbCode());
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		List<BoardVO> resultList = (List<BoardVO>)map.get("resultList");
		
		//-------------------------------
		// 갤러리 게시판이라면..
		//-------------------------------
		BoardVO galleryBoardVO = null;
		if (master.getBbsAttrbCode().equals("BBSA02")
			&& galleryNttId != null 
			&& !"".equals(galleryNttId.trim()) ) {
			
			// 첫번째(or 선택한) 게시물의 상세정보를 가져온다.
			if (resultList != null && resultList.size() > 0) {
				
				galleryBoardVO = new BoardVO();
				galleryBoardVO.setBbsId(boardVO.getBbsId());
				
				try {
					galleryBoardVO.setNttId(Long.parseLong(galleryNttId));
				} catch (NumberFormatException e) {
					e.printStackTrace();
				}
				/*if (null != galleryNttId && !"".equals(galleryNttId)) {
					try {
						galleryBoardVO.setNttId(Long.parseLong(galleryNttId));
					} catch (NumberFormatException e) {}
				} else {
					galleryBoardVO.setNttId(resultList.get(0).getNttId());
				}*/
				
				galleryBoardVO = bbsMngService.selectBoardArticle(galleryBoardVO);
			}
			
			/*returnValue = "bbs/EgovNoticeList";
			
			if ("pub".equals(commandMap.get("view"))) {
				returnValue = "pub/bbs/NoticeList";
			}*/
		} 
		
		////-----------------------------
		
		model.addAttribute("galleryBoardVO", galleryBoardVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("brdMstrVO", master);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("return_url",request.getRequestURI());
		model.addAttribute("menu", commandMap.get("menu"));
		model.addAttribute("no", commandMap.get("no"));
		
		return returnValue;
	}

	/**
	 * 게시물에 대한 목록을 조회한다.
	 * 
	 * @param boardVO
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/bbs/selectBoardListAjax.do")
	public ModelAndView selectBoardArticlesAjax(
			@ModelAttribute("searchVO") BoardVO boardVO, 
			HttpServletRequest request,
			Map<String, Object> commandMap,
			ModelMap model) throws Exception {
		
		boardVO.setBbsId(boardVO.getBbsId());
		boardVO.setBbsNm(boardVO.getBbsNm());
	
		BoardMasterVO vo = new BoardMasterVO();
		
		vo.setBbsId(boardVO.getBbsId());
		//vo.setUniqId(user.getUniqId());
		
		BoardMasterVO master = bbsAttrbService.selectBBSMasterInf(vo);
	
		boardVO.setPageUnit(propertyService.getInt("pageUnit"));
		
		// 갤러리 게시판이라면 리스트를 16개씩만 뿌려주자.
		if (master.getBbsAttrbCode().equals("BBSA02")) {
			boardVO.setPageUnit(16);
		}else{
			boardVO.setPageUnit(15);
		}
		
		boardVO.setPageSize(propertyService.getInt("pageSize"));
	
		PaginationInfo paginationInfo = new PaginationInfo();
		
		paginationInfo.setCurrentPageNo(boardVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(boardVO.getPageUnit());
		paginationInfo.setPageSize(boardVO.getPageSize());
	
		boardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		boardVO.setLastIndex(paginationInfo.getLastRecordIndex());
		boardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
	
		Map<String, Object> map = bbsMngService.selectBoardArticles(boardVO, vo.getBbsAttrbCode());
		int totCnt = Integer.parseInt((String)map.get("resultCnt"));
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		List<BoardVO> resultList = (List<BoardVO>)map.get("resultList");
		
		
		//model.addAttribute("galleryBoardVO", galleryBoardVO);
		model.addAttribute("resultList", resultList);
		model.addAttribute("resultCnt", map.get("resultCnt"));
		model.addAttribute("boardVO", boardVO);
		model.addAttribute("brdMstrVO", master);
		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("return_url",request.getRequestURI());
		model.addAttribute("menu", commandMap.get("menu"));
		model.addAttribute("no", commandMap.get("no"));
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 게시물에 대한 상세 정보를 조회한다.
	 * 
	 * @param boardVO
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/bbs/selectBoardArticle.do")
	public String selectBoardArticle(
			@ModelAttribute("searchVO") BoardVO boardVO, 
			Map<String, Object> commandMap,
			ModelMap model) throws Exception {
		
		LoginVO user = null;
		
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		
		if (isAuthenticated) {
			user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		} else {
			user = new LoginVO();
			user.setUniqId("");
		}
		
		String returnValue = "bbs/EgovNoticeInqire"; // bbs/EgovNoticeList or common/popup/bbsList
		if ("popup".equals(commandMap.get("viewFlag"))) {
			returnValue = "common/popup/bbsRead";
		}
		
		if ("pub".equals(commandMap.get("view"))) {
			returnValue = "pub/bbs/NoticeInqire";
		}
		
		// 조회수 증가 여부 지정
		boardVO.setPlusCount(true);
		//boardVO.setLastUpdusrId(user.getUniqId());
		BoardVO vo = bbsMngService.selectBoardArticle(boardVO);
	
		model.addAttribute("result", vo);
		model.addAttribute("sessionUniqId", user.getUniqId());
	
		BoardMasterVO master = new BoardMasterVO();
		master.setBbsId(boardVO.getBbsId());
		//master.setUniqId(user.getUniqId());
		BoardMasterVO masterVo = bbsAttrbService.selectBBSMasterInf(master);
	
		model.addAttribute("brdMstrVO", masterVo);
		
		model.addAttribute("menu", commandMap.get("menu"));
		model.addAttribute("no", commandMap.get("no"));
		
		return returnValue;
	}

	/**
	 * 게시물 등록을 위한 등록페이지로 이동한다.
	 * 
	 * @param boardVO
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/bbs/addBoardArticle.do")
	public String addBoardArticle(
			@ModelAttribute("searchVO") BoardVO boardVO, 
			Map<String, Object> commandMap,
			ModelMap model) throws Exception {
		
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		
		String returnValue = "bbs/EgovNoticeRegist";
		if ("popup".equals(commandMap.get("viewFlag"))) {
			returnValue = "common/popup/bbsRegist";
		}
		if ("pub".equals(commandMap.get("view"))) {
			returnValue = "bbs/EgovNoticeRegist";
		}
		
		BoardMasterVO bdMstr = new BoardMasterVO();
	
		if (isAuthenticated) {
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			if (!user.getRoleCode().equals("ROLE_ADMIN")) {
				returnValue = "forward:/bbs/selectBoardList.do";
			}
			BoardMasterVO vo = new BoardMasterVO();
			vo.setBbsId(boardVO.getBbsId());
			vo.setUniqId(user.getUniqId());
	
			bdMstr = bbsAttrbService.selectBBSMasterInf(vo);
			model.addAttribute("bdMstr", bdMstr);
		} else {
			returnValue = "forward:/bbs/selectBoardList.do";
		}
	
		return returnValue;
	}

	/**
	 * 게시물을 등록한다.
	 * 
	 * @param boardVO
	 * @param board
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/bbs/insertBoardArticle.do")
	public String insertBoardArticle(
			final MultipartHttpServletRequest multiRequest, 
			@ModelAttribute("searchVO") BoardVO boardVO,
			@ModelAttribute("bdMstr") BoardMaster bdMstr, 
			@ModelAttribute("board") Board board, 
			BindingResult bindingResult, 
			SessionStatus status,
			Map<String, Object> commandMap,
			ModelMap model) {
	
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		
		if(null != board.getPopup_startdate()) board.setPopup_startdate(board.getPopup_startdate().replaceAll("/", ""));
		if(null != board.getPopup_enddate()) board.setPopup_enddate(board.getPopup_enddate().replaceAll("/", ""));

		String returnValue = "bbs/EgovNoticeRegist";
		if ("popup".equals(commandMap.get("viewFlag"))) {
			returnValue = "common/popup/bbsRegist";
		}
		
		if ("pub".equals(commandMap.get("view"))) {
			returnValue = "bbs/NoticeRegist";
		}
		try {
			if (isAuthenticated) {
				
				LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
				
					if (user.getRoleCode().equals("ROLE_ADMIN")) {
					
					beanValidator.validate(board, bindingResult);
					if (bindingResult.hasErrors()) {
						BoardMasterVO master = new BoardMasterVO();
						BoardMasterVO vo = new BoardMasterVO();
						
						vo.setBbsId(boardVO.getBbsId());
						vo.setUniqId(user.getUniqId());
				
						master = bbsAttrbService.selectBBSMasterInf(vo);
						
						model.addAttribute("bdMstr", master);
				
						return returnValue;
					}
				
					List<FileVO> result = null;
					String atchFileId = "";
					final Map<String, MultipartFile> files = multiRequest.getFileMap();
					if (!files.isEmpty()) {
						result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
						atchFileId = fileMngService.insertFileInfs(result);
					}
					board.setAtchFileId(atchFileId);
					board.setFrstRegisterId(user.getUniqId());
					board.setBbsId(board.getBbsId());
					
					board.setNtcrNm("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
					board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
					
					board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
					bbsMngService.insertBoardArticle(board);
					// 자료실 등록일 경우 공지사항에 자동 등록 2018.08.07 임우재 과장 요청
					if("BBSMSTR_000000000060".equals(board.getBbsId())) {
						board.setBbsId("BBSMSTR_000000000030");
						bbsMngService.insertBoardArticle(board);
					}
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		
		return "forward:/bbs/selectBoardList.do";
	}

	/**
	 * 게시물에 대한 답변 등록을 위한 등록페이지로 이동한다.
	 * 
	 * @param boardVO
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/bbs/addReplyBoardArticle.do")
	public String addReplyBoardArticle(
			@ModelAttribute("searchVO") BoardVO boardVO,
			Map<String, Object> commandMap,
			ModelMap model) 
		throws Exception {
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		
		String returnValue = "bbs/EgovNoticeReply";
		if ("popup".equals(commandMap.get("viewFlag"))) {
			returnValue = "common/popup/bbsReply";
		}
		
		if ("pub".equals(commandMap.get("view"))) {
			returnValue = "bbs/NoticeReply";
		}
		
		BoardMasterVO master = new BoardMasterVO();
		BoardMasterVO vo = new BoardMasterVO();
		
		vo.setBbsId(boardVO.getBbsId());
		vo.setUniqId(user.getUniqId());
		
		master = bbsAttrbService.selectBBSMasterInf(vo);
		
		model.addAttribute("bdMstr", master);
		model.addAttribute("result", boardVO);
	
		return returnValue;
	}

	/**
	 * 게시물에 대한 답변을 등록한다.
	 * 
	 * @param boardVO
	 * @param board
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/bbs/replyBoardArticle.do")
	public String replyBoardArticle(
			final MultipartHttpServletRequest multiRequest, 
			@ModelAttribute("searchVO") BoardVO boardVO,
			@ModelAttribute("bdMstr") BoardMaster bdMstr, 
			@ModelAttribute("board") Board board, 
			BindingResult bindingResult,
			Map<String, Object> commandMap,
			ModelMap model,
			SessionStatus status) throws Exception {

		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		
		String returnValue = "bbs/EgovNoticeReply";
		if ("popup".equals(commandMap.get("viewFlag"))) {
			returnValue = "common/popup/bbsReply";
		}
		
		if ("pub".equals(commandMap.get("view"))) {
			returnValue = "bbs/NoticeReply";
		}
		
		beanValidator.validate(board, bindingResult);
		if (bindingResult.hasErrors()) {
			BoardMasterVO master = new BoardMasterVO();
			BoardMasterVO vo = new BoardMasterVO();
			
			vo.setBbsId(boardVO.getBbsId());
			vo.setUniqId(user.getUniqId());
	
			master = bbsAttrbService.selectBBSMasterInf(vo);
			
			model.addAttribute("bdMstr", master);
			model.addAttribute("result", boardVO);
	
			return returnValue;
		}
	
		if (isAuthenticated) {
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			String atchFileId = "";
	
			if (!files.isEmpty()) {
			List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, "", "");
			atchFileId = fileMngService.insertFileInfs(result);
			}
	
			board.setAtchFileId(atchFileId);
			board.setReplyAt("Y");
			board.setFrstRegisterId(user.getUniqId());
			board.setBbsId(board.getBbsId());
			board.setParnts(Long.toString(boardVO.getNttId()));
			board.setSortOrdr(boardVO.getSortOrdr());
			board.setReplyLc(Integer.toString(Integer.parseInt(boardVO.getReplyLc()) + 1));
			
			board.setNtcrNm("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
			board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
			
			board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
			
			bbsMngService.insertBoardArticle(board);
		}
		
		return "forward:/bbs/selectBoardList.do";
	}

	/**
	 * 게시물 수정을 위한 수정페이지로 이동한다.
	 * 
	 * @param boardVO
	 * @param vo
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/bbs/forUpdateBoardArticle.do")
	public String selectBoardArticleForUpdt(
			@ModelAttribute("searchVO") BoardVO boardVO, 
			@ModelAttribute("board") BoardVO vo, 
			Map<String, Object> commandMap,
			ModelMap model)
		throws Exception {

		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
	
		String returnValue = "bbs/EgovNoticeUpdt";
		if ("popup".equals(commandMap.get("viewFlag"))) {
			returnValue = "common/popup/bbsModify";
		}
		
		if ("pub".equals(commandMap.get("view"))) {
			returnValue = "bbs/NoticeUpdt";
		}
		
		boardVO.setFrstRegisterId(user.getUniqId());
		
		BoardMaster master = new BoardMaster();
		BoardMasterVO bmvo = new BoardMasterVO();
		BoardVO bdvo = new BoardVO();
		
		vo.setBbsId(boardVO.getBbsId());
		
		master.setBbsId(boardVO.getBbsId());
		master.setUniqId(user.getUniqId());
	
		if (isAuthenticated) {
			bmvo = bbsAttrbService.selectBBSMasterInf(master);
			bdvo = bbsMngService.selectBoardArticle(boardVO);
		}
	
		model.addAttribute("result", bdvo);
		model.addAttribute("bdMstr", bmvo);
	
		return returnValue;
	}

	/**
	 * 게시물에 대한 내용을 수정한다.
	 * 
	 * @param boardVO
	 * @param board
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/bbs/updateBoardArticle.do")
	public String updateBoardArticle(
			final MultipartHttpServletRequest multiRequest, 
			@ModelAttribute("searchVO") BoardVO boardVO,
			@ModelAttribute("bdMstr") BoardMaster bdMstr, 
			@ModelAttribute("board") Board board, 
			BindingResult bindingResult, 
			Map<String, Object> commandMap,
			ModelMap model,
			SessionStatus status) 
		throws Exception {

		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();

		if(null != board.getPopup_startdate()) board.setPopup_startdate(board.getPopup_startdate().replaceAll("/", ""));
		if(null != board.getPopup_enddate()) board.setPopup_enddate(board.getPopup_enddate().replaceAll("/", ""));
		
		String returnValue = "bbs/EgovNoticeUpdt";
		if ("popup".equals(commandMap.get("viewFlag"))) {
			returnValue = "common/popup/bbsModify";
		}
		
		if ("pub".equals(commandMap.get("view"))) {
			returnValue = "bbs/NoticeUpdt";
		}
		
		String atchFileId = boardVO.getAtchFileId();
	
		beanValidator.validate(board, bindingResult);
		if (bindingResult.hasErrors()) {
	
			boardVO.setFrstRegisterId(user.getUniqId());
			
			BoardMaster master = new BoardMaster();
			BoardMasterVO bmvo = new BoardMasterVO();
			BoardVO bdvo = new BoardVO();
			
			master.setBbsId(boardVO.getBbsId());
			master.setUniqId(user.getUniqId());
	
			bmvo = bbsAttrbService.selectBBSMasterInf(master);
			bdvo = bbsMngService.selectBoardArticle(boardVO);
	
			model.addAttribute("result", bdvo);
			model.addAttribute("bdMstr", bmvo);
	
			return returnValue;
		}
		
		if (isAuthenticated) {
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				if ("".equals(atchFileId)) {
					List<FileVO> result = fileUtil.parseFileInf(files, "BBS_", 0, atchFileId, "");
					atchFileId = fileMngService.insertFileInfs(result);
					board.setAtchFileId(atchFileId);
				} else {
					FileVO fvo = new FileVO();
					fvo.setAtchFileId(atchFileId);
					int cnt = fileMngService.getMaxFileSN(fvo);
					List<FileVO> _result = fileUtil.parseFileInf(files, "BBS_", cnt, atchFileId, "");
					fileMngService.updateFileInfs(_result);
				}
			}
	
			board.setLastUpdusrId(user.getUniqId());
			
			board.setNtcrNm("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
			board.setPassword("");	// dummy 오류 수정 (익명이 아닌 경우 validator 처리를 위해 dummy로 지정됨)
			
			board.setNttCn(unscript(board.getNttCn()));	// XSS 방지
			
			bbsMngService.updateBoardArticle(board);
			
			if("BBSMSTR_000000000060".equals(board.getBbsId())) {
				board.setBbsId("BBSMSTR_000000000030");
				bbsMngService.updateBoardArticle(board);
			}
		}
		
		return "forward:/bbs/selectBoardList.do";
	}

	/**
	 * 게시물에 대한 내용을 삭제한다.
	 * 
	 * @param boardVO
	 * @param board
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/bbs/deleteBoardArticle.do")
	public String deleteBoardArticle(
			@ModelAttribute("searchVO") BoardVO boardVO, 
			@ModelAttribute("board") Board board,
			@ModelAttribute("bdMstr") BoardMaster bdMstr, 
			Map<String, Object> commandMap,
			ModelMap model) 
		throws Exception {
	
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
	
		if (isAuthenticated) {
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			board.setLastUpdusrId(user.getUniqId());
			
			bbsMngService.deleteBoardArticle(board);
			
			if("BBSMSTR_000000000060".equals(board.getBbsId())) {
				board.setBbsId("BBSMSTR_000000000030");
				bbsMngService.deleteBoardArticle(board);
			}
		}
	
		return "forward:/bbs/selectBoardList.do";
	}
}
