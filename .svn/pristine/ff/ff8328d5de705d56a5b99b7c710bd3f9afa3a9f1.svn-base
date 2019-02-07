package daewooInfo.edu.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.cmmn.service.EgovFileMngService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.EgovFileMngUtil;
import daewooInfo.edu.bean.EduSearchVO;
import daewooInfo.edu.service.EduManageService;
import daewooInfo.stats.bean.StatsSearchVO;
import daewooInfo.stats.bean.StatsVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 
 * 교육 및 교육 신청자 관리
 * @author kisspa
 * @since 2010.09.02
 * @version 1.0
 * @see
 *
 * <pre>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2010.09.02  kisspa          최초 생성
 *
 * </pre>
 */

@Controller
public class EduManageController {

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
	 * @uml.property  name="eduManageService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EduManageService")
    private EduManageService eduManageService;

    /**
	 * EgovPropertyService
	 * @uml.property  name="propertiesService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;

	/**
	 * log
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
    Log log = LogFactory.getLog(EduManageController.class);
	
	/**
	 * 교육 화면..
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/edu/eduList")
	public String eduList(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/edu/eduList";
	}
	
	/**
	 * 교육 목록 데이터
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/edu/eduDataList")
	public ModelAndView eduDataList(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") EduSearchVO searchVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		searchVO.setPageUnit(10);
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List<EduSearchVO> list = eduManageService.eduDataList(searchVO);
		int totCnt = eduManageService.eduDataListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("list", list);
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 교육 정보 삭제
	 * @param loginVO
	 * @param searchVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/edu/deleteEdu")
	public ModelAndView deleteEdu(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") EduSearchVO searchVO
			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		int updateCnt = 0;
		updateCnt = eduManageService.deleteEdu(searchVO);
		
		modelAndView.addObject("updateCnt", updateCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 교육 정보 merge into
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping("/edu/mergeEdu")
	public ModelAndView mergeEdu(
			HttpServletRequest request
			, @ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") EduSearchVO searchVO
			, SessionStatus status
			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		// 파일 저장
		List<FileVO> result = null;
	    String atchFileId = "";
	    
	    if (request instanceof MultipartHttpServletRequest) {
	    	
	    	MultipartHttpServletRequest multiRequest = (MultipartHttpServletRequest)request;
	    	
		    final Map<String, MultipartFile> files = multiRequest.getFileMap();
		    if (!files.isEmpty()) {
				result = fileUtil.parseFileInf(files, "EDU_", 0, "", "");
				atchFileId = fileMngService.insertFileInfs(result);
				searchVO.setAtchFileId(atchFileId);
		    }
	    }
		
	    if (searchVO.getAtchFileId().length() > 20) {
	    	searchVO.setAtchFileId(searchVO.getAtchFileId().split(",")[0]);
	    }
	    
		int updateCnt = 0;
		updateCnt = eduManageService.mergeEdu(searchVO);
		
		modelAndView.addObject("updateCnt", updateCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 교육 신청자 목록 화면..
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/edu/eduMemberList")
	public String eduMemberList(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		EduSearchVO vo = new EduSearchVO();
		List<EduSearchVO> eduList = eduManageService.eduDataListAll(vo);
		model.addAttribute("eduList", eduList);
		
		model.addAttribute("eduSeq", commandMap.get("eduSeq"));
		
		return "/edu/eduMemberList";
	}
	
	/**
	 * 교육 신청자 목록 데이터
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/edu/eduMemberDataList")
	public ModelAndView eduMemberDataList(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") EduSearchVO searchVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<EduSearchVO> list = eduManageService.eduMemberDataList(searchVO);
		int totCnt = eduManageService.eduMemberDataListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("list", list);
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 교육 신청자 엑셀 다운로드
	 * @param loginVO
	 * @param searchVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/edu/eduMemberDataExcel.do")
    public ModelAndView eduMemberDataExcel(
    		@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") EduSearchVO searchVO
    ) throws Exception {
    	
    	//getData
        String[] menu = {"NO","교육명","성명","부서","연락처"};
    	
        searchVO.setPageUnit(10000);
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<EduSearchVO> excelDataList = eduManageService.eduMemberDataList(searchVO);
		int totCnt = eduManageService.eduMemberDataListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        
        Map<String, Object> map = new HashMap<String, Object>();
    	map.put("menu", menu);
    	map.put("chart", excelDataList);
    	map.put("title", excelDataList.get(0).getTitle());
    	map.put("strDate", excelDataList.get(0).getStrDate());
    	map.put("endDate", excelDataList.get(0).getEndDate());
     
    	return new ModelAndView("excelEduView", "chartMap", map);
    }
	
	/**
	 * 교육 대상자 정보 삭제
	 * @param loginVO
	 * @param searchVO
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/edu/deleteEduMember")
	public ModelAndView deleteEduMember(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") EduSearchVO searchVO
			, Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		int updateCnt = 0;
		updateCnt = eduManageService.deleteEduMember(searchVO);
		
		modelAndView.addObject("updateCnt", updateCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 교육 대상자 정보 merge into
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/edu/mergeEduMember")
	public ModelAndView mergeEduMember(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") EduSearchVO searchVO
			, Map<String, Object> commandMap
			) throws Exception {
		
		String msg = "";
		String memberID = "";
		int updateCnt = 0;
		
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		ModelAndView modelAndView = new ModelAndView();
		
		if (isAuthenticated) {
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			memberID = user.getId();
			
			searchVO.setMemberId(memberID);
			
			
			// 이미 교육을 신청하였는지 체크한다.
			int isEduRigisterCnt = eduManageService.isEduRigisterCnt(searchVO);
			
			if (isEduRigisterCnt > 0) {
				
				msg = "alreadlyRegister";
				
			} else {
				
				// 정원이 초과하였는지 체크한다.
				int isOverCapacityCnt = eduManageService.isOverCapacityCnt(searchVO);
				
				if (isOverCapacityCnt > 0) {
					
					updateCnt = eduManageService.insertEduMember(searchVO);
					msg = "eduRegisterOK";
					
				} else {
					
					msg = "overCapacity";					
					
				}
			}
		}

		modelAndView.addObject("msg", msg);
		modelAndView.addObject("updateCnt", updateCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 교육 신청화면 (목록 & 상세 & 신청)
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/edu/eduListReq")
	public String eduListReq(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/edu/eduListReq";
	}
	
	/**
	 * 나의 교육 신청 현황
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/edu/myEduList")
	public String myEduList(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/edu/myEduList";
	}
	
	/**
	 * 나의 신청한 교육 목록 데이터
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/edu/myEduDataList")
	public ModelAndView myEduDataList(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") EduSearchVO searchVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		String memberID = "";
		
		if (isAuthenticated) {
			LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			memberID = user.getId();
			
			searchVO.setMemberId(memberID);
		
			searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
	    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
	
	    	/** pageing */
	    	PaginationInfo paginationInfo = new PaginationInfo();
			paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
			paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
			paginationInfo.setPageSize(searchVO.getPageSize());
			
			searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
			searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
			searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
			
	        List<EduSearchVO> list = eduManageService.myEduDataList(searchVO);
			int totCnt = eduManageService.myEduDataListCnt(searchVO);
			paginationInfo.setTotalRecordCount(totCnt);
		
			modelAndView.addObject("list", list);
			modelAndView.addObject("paginationInfo", paginationInfo);
		}
		
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
}