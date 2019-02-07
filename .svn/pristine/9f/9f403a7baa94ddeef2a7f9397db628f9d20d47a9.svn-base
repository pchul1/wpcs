package daewooInfo.admin.access.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import daewooInfo.admin.access.bean.AccessManageVO;
import daewooInfo.admin.access.service.AccessManageService;
import daewooInfo.admin.member.bean.MemberSearchVO;
import daewooInfo.common.TmsMessageSource;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.login.service.LoginService;
import daewooInfo.mobile.com.utl.LogInfoUtil;
import daewooInfo.seminar.bean.SeminarSearchVO;
import daewooInfo.seminar.bean.SeminarVO;

import javax.servlet.http.HttpServletRequest;

import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

@Controller
public class AccessManageController {
	
	/** LoginService */
	@Resource(name = "loginService")
    private LoginService loginService;
	
	/** AccessManageService */
	@Resource(name = "accessManageService")
    private AccessManageService accessManageService;
	
	/** EgovPropertyService */
    @Resource(name = "propertiesService")
    protected EgovPropertyService propertiesService;
	
	/** EgovMessageSource */
    @Resource(name="tmsMessageSource")
    TmsMessageSource tmsMessageSource;
    
    @Autowired
	private DefaultBeanValidator beanValidator;
	
    /** log */
    Log log = LogFactory.getLog(AccessManageController.class);
    

    /**
	 * 접속이력현황을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @return "/admin/access/AccessLoginList"
     * @throws Exception
     */
    @RequestMapping(value="/admin/access/AccessLoginList.do")
	public String selectAccessLoginList (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") AccessManageVO searchVO			
			, ModelMap model
			) throws Exception {
    	
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	
    	String sDate = null;
    	String eDate = null;
    	if(null != searchVO.getSdate()){
    		sDate = searchVO.getSdate();
    		searchVO.setSdate(searchVO.getSdate().replaceAll("/", ""));
    	}
    	if(null != searchVO.getEdate()){
    		eDate = searchVO.getEdate();
    		searchVO.setEdate(searchVO.getEdate().replaceAll("/", ""));
    	}

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List accessList = accessManageService.selectAccessLoginList(searchVO);
        model.addAttribute("resultList", accessList);
        
        int totCnt = accessManageService.selectAccessLoginListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
        model.addAttribute("paginationInfo", paginationInfo);
        

    	if(null != sDate) searchVO.setSdate(sDate); 
    	if(null != eDate) searchVO.setEdate(eDate);
    	
        model.addAttribute("param_s", searchVO);
        
        return "/admin/access/AccessLoginList";
	}
   
    
    /**
	 * 개인정보취급현황을 조회한다.
     * @param loginVO
     * @param searchVO
     * @param model
     * @return "/admin/access/AccessIndiList"
     * @throws Exception
     */
    @RequestMapping(value="/admin/access/AccessIndiList.do")
	public String selectAccessIndiList (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") AccessManageVO searchVO			
			, ModelMap model
			) throws Exception {
    	
    	searchVO.setPageUnit(propertiesService.getInt("pageUnit"));
    	//searchVO.setPageSize(propertiesService.getInt("pageSize"));
    	searchVO.setPageSize(20);

    	String sDate = null;
    	String eDate = null;
    	if(null != searchVO.getSdate()){
    		sDate = searchVO.getSdate();
    		searchVO.setSdate(searchVO.getSdate().replaceAll("/", ""));
    	}
    	if(null != searchVO.getEdate()){
    		eDate = searchVO.getEdate();
    		searchVO.setEdate(searchVO.getEdate().replaceAll("/", ""));
    	}

    	/** pageing */
    	PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
        List accessList = accessManageService.selectAccessIndiList(searchVO);
        model.addAttribute("resultList", accessList);
        
        int totCnt = accessManageService.selectAccessIndiListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
    	
        model.addAttribute("paginationInfo", paginationInfo);
        
    	if(null != sDate) searchVO.setSdate(sDate); 
    	if(null != eDate) searchVO.setEdate(eDate);
        model.addAttribute("param_s", searchVO);
        
        return "/admin/access/AccessIndi";
	}
   
    /**
 	 * 개인정보취급현황 상세변경사항을 조회한다.
      * @param loginVO
      * @param searchVO
      * @param model
      * @return "/admin/access/AccessChangeList"
      * @throws Exception
      */
     @RequestMapping(value="/admin/access/AccessChangeList.do")
 	public String selectAccessHistoryList (@ModelAttribute("loginVO") LoginVO loginVO
 			, @ModelAttribute("searchVO") AccessManageVO searchVO
 			, HttpServletRequest request
 			, ModelMap model
 			) throws Exception {
     	
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
 		
        String seq = request.getParameter("seq");
        model.addAttribute("seq", seq);
        
        String memberId = request.getParameter("memberId");
        model.addAttribute("memberId", memberId);
        
        String hdate = request.getParameter("hdate");
        model.addAttribute("hdate", hdate);
 		
 		List accessList = accessManageService.selectAccessIndiList(searchVO);
        model.addAttribute("accessList", accessList);
 		
        List infoChangeList = accessManageService.selectAccessChangeInfoList(searchVO);
        model.addAttribute("resultList", infoChangeList);
         
        model.addAttribute("paginationInfo", paginationInfo);
         
        return "/admin/access/AccessChangeList";
 	}
     
 	/**
 	 * 개인정보취급현황 엑셀 다운로드
 	 * @param searchVO
 	 */
 	@RequestMapping(value="/admin/access/AccessIndiListExcel.do")
 	public ModelAndView selectAccessIndiListExcel (
 			@ModelAttribute("searchVO") AccessManageVO searchVO
 			, HttpServletRequest request
 	) throws Exception {
 		Map<String, Object> map = new HashMap<String, Object>();
 		ModelAndView mav = null;
 		
 		searchVO.setUserId(LogInfoUtil.GetSessionLogin().getId());
 		int totCnt = accessManageService.selectAccessIndiListTotCnt(searchVO);
 		
 		searchVO.setPageSize(propertiesService.getInt("pageSize"));
 		searchVO.setFirstIndex(0);
 		searchVO.setLastIndex(10000);
 		searchVO.setRecordCountPerPage(totCnt);
 		
 		List<AccessManageVO> data = accessManageService.selectAccessIndiList(searchVO);
 		
 		map.put("data", data);
 		map.put("searchVO", searchVO);
 		mav = new ModelAndView("ExcelViewAccessIndiList", "map", map);
 		return mav;
 	}
}