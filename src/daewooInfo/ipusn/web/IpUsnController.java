package daewooInfo.ipusn.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.admin.member.service.MemberService;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.cmmn.service.EgovCmmUseService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.EgovFileMngUtil;
import daewooInfo.ipusn.bean.IpUsnVO;
import daewooInfo.ipusn.service.IpUsnService;
import daewooInfo.mobile.com.service.MobileCommonCodeService;
import daewooInfo.waterpolmnt.waterinfo.web.WaterinfoController;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
* <pre>
* 1. 패키지명 : daewooInfo.mobile.ipusn.web
* 2. 타입명 : IpUsnController.java
* 3. 작성일 : 2014. 9. 4. 오후 4:21:22
* 4. 작성자 : kys
* 5. 설명 : IPUSN 정보
* </pre>
*/
@Controller
public class IpUsnController {
	/**
	 * @uml.property  name="logger"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log logger = LogFactory.getLog(WaterinfoController.class);
	
	 /**
	 * EgovPropertyService
	 * @uml.property  name="propertiesService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/**
	 * @uml.property  name="cmmUseService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovCmmUseService")
	private EgovCmmUseService cmmUseService;
	
	/**
	 * MemberService
	 * @uml.property  name="memberService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "memberService")
	private MemberService memberService;
	
	/**
	 * 공통 코드 서비스
	 */
    @Resource(name="MobileCommonCodeService")
    private MobileCommonCodeService mobileCommonCodeService;
    
    /**
	 * IPUSN 서비스
	 */
    @Resource(name="IpUsnService")
    private IpUsnService ipUsnService;

	/**
	 * @uml.property  name="fileUtil"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertyService;
	
	/**
	* <pre>
	* 1. 메소드명 : selectmrdipusnlist
	* 2. 작성일 : 2014. 9. 12. 오후 2:53:38
	* 3. 작성자 : kys
	* 4. 설명 : 웹 페이지 IP-USN 모니터링
	* </pre>
	*/
	@RequestMapping(value="/ipusn/getipusnlist")
	public String selectmrdipusnlist(@ModelAttribute("IpUsnVO")IpUsnVO ipUsnVO, ModelMap model) throws Exception {
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		
		ipUsnVO.setUserGubun(user.getRoleCode());
		ipUsnVO.setUserId(user.getId());
		
		ipUsnVO.setPageSize(propertyService.getInt("pageSize"));
		
		ipUsnVO.setFirstIndex(0);
		ipUsnVO.setLastIndex(10000);
		
		List<IpUsnVO> list = ipUsnService.getIpUsnList(ipUsnVO);
		model.addAttribute("resultList", list);
		return "jsonView"; 
	}
	

	/**
	* <pre>
	* 1. 메소드명 : selectmrdipusnmap
	* 2. 작성일 : 2014. 9. 12. 오후 2:53:38
	* 3. 작성자 : kys
	* 4. 설명 : 위치 맵 서비스
	* </pre>
	*/
	@RequestMapping(value="/ipusn/getipusnmap")
	public String selectmrdipusnmap(@ModelAttribute("IpUsnVO")IpUsnVO ipUsnVO, ModelMap model) throws Exception {
		model.addAttribute("View", ipUsnService.getIpUsnLocationView(ipUsnVO));
		return "ipusn/getipusnmap"; 
	}
	
	/**
	* <pre>
	* 1. 메소드명 : getExcelipusnlist
	* 2. 작성일 : 2014. 9. 18. 오후 5:31:32
	* 3. 작성자 : kys
	* 4. 설명 : 엑셀 다운로드
	* </pre>
	*/
	@RequestMapping("/ipusn/getExcelipusnlist")
	public ModelAndView getExcelipusnlist(@ModelAttribute("IpUsnVO") IpUsnVO ipUsnVO) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		ipUsnVO.setUserId(user.getId());
		
		ipUsnVO.setFirstIndex(0);
		ipUsnVO.setLastIndex(100000);
		map.put("title", "IP-USN 위치정보");
		map.put("menu", new String[]{"순번","수계","지점명","온도","습도","배터리","접속시간","위치","장비상태"});
		map.put("List", ipUsnService.getIpUsnList(ipUsnVO));
		return new ModelAndView("ExcelViewIpusn",map);
	}

	/**
	* <pre>
	* 1. 메소드명 : ipusnbranchhistorylist
	* 2. 작성일 : 2014. 9. 12. 오후 2:53:38
	* 3. 작성자 : kys
	* 4. 설명 : 지점 히스토리 정보
	* </pre>
	*/
	@RequestMapping(value="/ipusn/ipusnbranchhistorylist")
	public String ipusnbranchhistorylist(IpUsnVO ipUsnVO, ModelMap model) throws Exception {
		model.addAttribute("param_s", ipUsnVO);
		return "ipusn/ipusnbranchhistorylist"; 
	}
	
	/**
	* <pre>
	* 1. 메소드명 : selectipusnbranchhistorylist
	* 2. 작성일 : 2014. 9. 12. 오후 2:53:38
	* 3. 작성자 : kys
	* 4. 설명 : 지점 히스토리 정보 
	* </pre>
	*/
	@RequestMapping(value="/ipusn/getipusnbranchhistorylist")
	public String selectipusnbranchhistorylist(IpUsnVO ipUsnVO, ModelMap model) throws Exception {

		ipUsnVO.setPageSize(propertyService.getInt("pageSize"));
		PaginationInfo paginationInfo = new PaginationInfo();
		
		int totCnt = ipUsnService.IpUsnBranchHistoryTotCount(ipUsnVO);
		paginationInfo.setCurrentPageNo((ipUsnVO.getPageIndex() <= 0) ? 1 : ipUsnVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(ipUsnVO.getPageUnit());
		paginationInfo.setPageSize(ipUsnVO.getPageSize());
		
		ipUsnVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		ipUsnVO.setLastIndex(paginationInfo.getLastRecordIndex());
		ipUsnVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<IpUsnVO> list = ipUsnService.IpUsnBranchHistoryList(ipUsnVO);
		
		paginationInfo.setTotalRecordCount(totCnt);
		
		model.addAttribute("totCnt", totCnt);
		model.addAttribute("PaginationInfo", paginationInfo);
		model.addAttribute("resultList", list);
		model.addAttribute("param_s", ipUsnVO);
		return "jsonView"; 
	}

	
	/**
	* <pre>
	* 1. 메소드명 : selectExcelipusnbranchhistorylist
	* 2. 작성일 : 2014. 9. 12. 오후 2:53:38
	* 3. 작성자 : kys
	* 4. 설명 : 지점 히스토리 정보 
	* </pre>
	*/
	@RequestMapping(value="/ipusn/getExcelipusnbranchhistorylist")
	public ModelAndView selectExcelipusnbranchhistorylist(IpUsnVO ipUsnVO, ModelMap model) throws Exception {
		ipUsnVO.setFirstIndex(0);
		ipUsnVO.setLastIndex(100000);
		List<IpUsnVO> list = ipUsnService.IpUsnBranchHistoryList(ipUsnVO);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("title", list.get(0).getBranch_name() + " 위치정보");
		map.put("menu", new String[]{"순번","수계","지점명","온도","습도","배터리","접속시간","위치","장비상태"});
		map.put("List", list);
		return new ModelAndView("ExcelViewIpusn",map);
	}
	
	

	/**
	* <pre>
	* 1. 메소드명 : ipusn_dump
	* 2. 작성일 : 2014. 9. 12. 오후 2:53:38
	* 3. 작성자 : kys
	* 4. 설명 : 지점 히스토리 정보 
	* </pre>
	*/
	@RequestMapping(value="/ipusn/ipusn_dump")
	public ModelAndView ipusn_dump(IpUsnVO ipUsnVO, ModelAndView model, MultipartHttpServletRequest multiRequest, HttpServletRequest request, HttpServletResponse response) throws Exception {
		final Map<String, MultipartFile> files = multiRequest.getFileMap();
		
		List<FileVO> result = fileUtil.parseWpStepFileInf(files, "IPUSN_", 0, "", "");
		if (result.size() >0 ) {
			FileVO filevo = result.get(0);
			ipUsnVO.setFile(filevo.getFileStreCours() + "/" + filevo.getStreFileNm());
			ipUsnService.IpUsnDump(ipUsnVO);
		}

		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print("<script>alert('성공적으로 등록되었습니다.');document.location.href='/common/page.do?id=common/ipusn_dump'</script>");
		return null;
	}
	

	
	/**
	* <pre>
	* 1. 메소드명 : getipusnMaplist
	* 2. 작성일 : 2014. 9. 12. 오후 2:53:38
	* 3. 작성자 : kys
	* 4. 설명 : IP-USN 위치정보
	* </pre>
	*/
	@RequestMapping(value="/ipusn/getipusnMaplist")
	public String getipusnMaplist(@ModelAttribute("IpUsnVO")IpUsnVO ipUsnVO, ModelMap model) throws Exception {
		
		ipUsnVO.setPageSize(propertyService.getInt("pageSize"));
		
		ipUsnVO.setFirstIndex(0);
		ipUsnVO.setLastIndex(10000);
		
		List<IpUsnVO> list = ipUsnService.getIpUsnList(ipUsnVO);
		model.addAttribute("resultList", list);
		return "ipusn/getipusnMaplist"; 
	}
}