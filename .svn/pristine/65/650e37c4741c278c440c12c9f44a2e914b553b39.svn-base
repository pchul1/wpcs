package daewooInfo.admin.menu.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import daewooInfo.admin.menu.bean.ProgrmManageDtlVO;
import daewooInfo.admin.menu.bean.ProgrmManageVO;
import daewooInfo.admin.menu.service.EgovMenuManageService;
import daewooInfo.admin.menu.service.EgovProgrmManageService;
import daewooInfo.cmmn.bean.ComDefaultVO;
import daewooInfo.common.TmsMessageSource;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/** 
 * 프로그램목록 관리및 변경을 처리하는 비즈니스 구현 클래스
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 * 수정일	 		수정자			수정내용
 * -------		--------	---------------------------
 * 2009.03.20	이  용			최초 생성
 * 
 * </pre>
 */

@Controller
public class EgovProgrmManageController {

	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	protected Log log = LogFactory.getLog(this.getClass());

	/**
	 * Validator
	 * @uml.property  name="beanValidator"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Autowired
	private DefaultBeanValidator beanValidator;
	
	/**
	 * EgovPropertyService
	 * @uml.property  name="propertiesService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/**
	 * EgovProgrmManageService
	 * @uml.property  name="progrmManageService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "progrmManageService")
	private EgovProgrmManageService progrmManageService;
	
	/**
	 * @uml.property  name="menuManageService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "meunManageService")
	private EgovMenuManageService menuManageService;

	/**
	 * tmsMessageSource
	 * @uml.property  name="tmsMessageSource"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="tmsMessageSource")
	TmsMessageSource tmsMessageSource;
	
	/** EgovSndngMailRegistService */
	//@Resource(name = "sndngMailRegistService")
	//private EgovSndngMailRegistService sndngMailRegistService;
	
	/**
	 * 프로그램목록을 상세화면 호출 및 상세조회한다. 
	 * @param tmp_progrmNm  String
	 * @return 출력페이지정보 "admin/menu/EgovProgramListDetailSelectUpdt"
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/menu/EgovProgramListDetailSelect.do")
	public String selectProgrm(
			@RequestParam("tmp_progrmNm") String tmp_progrmNm ,
			@ModelAttribute("searchVO") ComDefaultVO searchVO, 
			ModelMap model)
			throws Exception {
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		}
		searchVO.setSearchKeyword(tmp_progrmNm);
		ProgrmManageVO progrmManageVO = progrmManageService.selectProgrm(searchVO);
		model.addAttribute("progrmManageVO", progrmManageVO);
		return "admin/menu/EgovProgramListDetailSelectUpdt";
	}
	
	/**
	 * 프로그램목록 리스트조회한다. 
	 * @param searchVO ComDefaultVO
	 * @return 출력페이지정보 "admin/menu/EgovProgramListManage"
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/menu/EgovProgramListManageSelect.do")
	public String selectProgrmList(
			@ModelAttribute("searchVO") ComDefaultVO searchVO, 
			ModelMap model)
			throws Exception { 
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		}
		// 내역 조회
		/** EgovPropertyService.sample */
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
		
		List list_progrmmanage = progrmManageService.selectProgrmList(searchVO);
		model.addAttribute("list_progrmmanage", list_progrmmanage);
		
		int totCnt = progrmManageService.selectProgrmListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "admin/menu/EgovProgramListManage";
		
	}
	
	/**
	 * 프로그램목록 멀티 삭제한다. 
	 * @param checkedProgrmFileNmForDel String
	 * @return 출력페이지정보 "forward:/admin/menu/EgovProgramListManageSelect.do"
	 * @exception Exception
	 */
	@RequestMapping("/admin/menu/EgovProgrmManageListDelete.do")
	public String deleteProgrmManageList(
			@RequestParam("checkedProgrmKoreanNmForDel") String checkedProgrmKoreanNmForDel ,
			@ModelAttribute("progrmManageVO") ProgrmManageVO progrmManageVO, 
			ModelMap model)
			throws Exception {
		String sLocationUrl = null;
		String resultMsg	= "";
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		}
		String [] delProgrmKoreanNm = checkedProgrmKoreanNmForDel.split(",");
		if (delProgrmKoreanNm == null || (delProgrmKoreanNm.length ==0)){ 
			resultMsg = tmsMessageSource.getMessage("fail.common.delete");
			sLocationUrl = "forward:/admin/menu/EgovProgramListManageSelect.do";
		}else{
			progrmManageService.deleteProgrmManageList(checkedProgrmKoreanNmForDel);
			resultMsg = tmsMessageSource.getMessage("success.common.delete");
			sLocationUrl ="forward:/admin/menu/EgovProgramListManageSelect.do";
		}
		model.addAttribute("resultMsg", resultMsg);
		//status.setComplete();
		return sLocationUrl ;
	}
	
	/**
	 * 프로그램목록을 등록화면으로 이동 및 등록 한다.
	 * @param progrmManageVO ProgrmManageVO
	 * @param commandMap	 Map
	 * @return 출력페이지정보 등록화면 호출시 "admin/menu/EgovProgramListRegist",
	 *		 출력페이지정보 등록처리시 "forward:/admin/menu/EgovProgramListManageSelect.do" 
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/menu/EgovProgramListRegist.do")
	public String insertProgrmList(
			Map commandMap, 
			@ModelAttribute("progrmManageVO") ProgrmManageVO progrmManageVO,
			BindingResult bindingResult,
			ModelMap model)
			throws Exception { 
		String resultMsg = "";
		String sLocationUrl = null;
		
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		}
		
		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");	
		if(sCmd.equals("insert")){
			beanValidator.validate(progrmManageVO, bindingResult);
			if (bindingResult.hasErrors()){
				sLocationUrl = "admin/menu/EgovProgramListRegist";
				return sLocationUrl;
			}
			if(progrmManageVO.getProgrmDc()==null || progrmManageVO.getProgrmDc().equals("")){progrmManageVO.setProgrmDc(" ");} 
			progrmManageService.insertProgrm(progrmManageVO);
			resultMsg = tmsMessageSource.getMessage("success.common.insert");
			sLocationUrl = "forward:/admin/menu/EgovProgramListManageSelect.do";
		}else{
			sLocationUrl = "admin/menu/EgovProgramListRegist"; 
		}
		
		List list_menulist = menuManageService.selectMenuList();
		resultMsg = tmsMessageSource.getMessage("success.common.select"); 
		model.addAttribute("list_menulist", list_menulist);
		
		model.addAttribute("resultMsg", resultMsg);
		return sLocationUrl; 
	}	
	
	/**
	 * 프로그램목록을 수정 한다. 
	 * @param progrmManageVO ProgrmManageVO
	 * @return 출력페이지정보 "forward:/admin/menu/EgovProgramListManageSelect.do" 
	 * @exception Exception
	 */
	/*프로그램목록수정*/
	@RequestMapping(value="/admin/menu/EgovProgramListDetailSelectUpdt.do")
	public String updateProgrmList(
			@ModelAttribute("progrmManageVO") ProgrmManageVO progrmManageVO,
			BindingResult bindingResult,
			ModelMap model)
			throws Exception { 
		
		String resultMsg = "";
		String sLocationUrl = null;
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		}
		
		beanValidator.validate(progrmManageVO, bindingResult);

		if (bindingResult.hasErrors()){
			sLocationUrl = "forward:/admin/menu/EgovProgramListDetailSelect.do";
			return sLocationUrl;
		}
		
		if(progrmManageVO.getProgrmDc()==null || progrmManageVO.getProgrmDc().equals("")) {
			progrmManageVO.setProgrmDc(" ");
		}
		
		progrmManageService.updateProgrm(progrmManageVO);
		resultMsg = tmsMessageSource.getMessage("success.common.update");
		sLocationUrl = "forward:/admin/menu/EgovProgramListManageSelect.do";
		model.addAttribute("resultMsg", resultMsg);
		return sLocationUrl; 
	}	
	
	/**
	 * 프로그램목록을 삭제 한다. 
	 * @param progrmManageVO ProgrmManageVO
	 * @return 출력페이지정보 "forward:/admin/menu/EgovProgramListManageSelect.do" 
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/menu/EgovProgramListManageDelete.do")
	public String deleteProgrmList(
			@ModelAttribute("progrmManageVO") 
			ProgrmManageVO progrmManageVO,
			ModelMap model)
			throws Exception {
		String resultMsg = "";
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		}
		progrmManageService.deleteProgrm(progrmManageVO);
		resultMsg = tmsMessageSource.getMessage("success.common.delete");
		model.addAttribute("resultMsg", resultMsg);
		return "forward:/admin/menu/EgovProgramListManageSelect.do";
	} 

	/**
	 * 프로그램변경요청목록 조회한다. 
	 * @param searchVO ComDefaultVO
	 * @return 출력페이지정보 "admin/menu/EgovProgramChangeRequst" 
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/menu/EgovProgramChangeRequstSelect.do")
	public String selectProgrmChangeRequstList(
			@ModelAttribute("searchVO") ComDefaultVO searchVO, 
			ModelMap model)
			throws Exception { 
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		}
		// 내역 조회
		/** EgovPropertyService.sample */
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
		
		List list_changerequst = progrmManageService.selectProgrmChangeRequstList(searchVO);
		model.addAttribute("list_changerequst", list_changerequst);

		int totCnt = progrmManageService.selectProgrmChangeRequstListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		 
		 return "admin/menu/EgovProgramChangeRequst";
	}

	/**
	 * 프로그램변경요청목록을 상세조회한다. 
	 * @param progrmManageDtlVO ProgrmManageDtlVO
	 * @return 출력페이지정보 "admin/menu/EgovProgramChangRequstDetailSelectUpdt" 
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/menu/EgovProgramChangRequstDetailSelect.do")
	public String selectProgrmChangeRequst(
			@ModelAttribute("progrmManageDtlVO") ProgrmManageDtlVO progrmManageDtlVO,
			ModelMap model)
			throws Exception {
		 // 0. Spring Security 사용자권한 처리
		 Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		 if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		 }
		 if(progrmManageDtlVO.getProgrmFileNm()== null||progrmManageDtlVO.getProgrmFileNm().equals("")){
			 String _FileNm = progrmManageDtlVO.getTmp_progrmNm();		
			 progrmManageDtlVO.setProgrmFileNm(_FileNm);
			 int _tmp_no = progrmManageDtlVO.getTmp_rqesterNo();		
			 progrmManageDtlVO.setRqesterNo(_tmp_no);
		 }
		 ProgrmManageDtlVO resultVO = progrmManageService.selectProgrmChangeRequst(progrmManageDtlVO);
		 model.addAttribute("progrmManageDtlVO", resultVO);
		 return "admin/menu/EgovProgramChangRequstDetailSelectUpdt";
	}
	
	/**
	 * 프로그램변경요청 화면을 호출및 프로그램변경요청을 등록한다. 
	 * @param progrmManageDtlVO ProgrmManageDtlVO
	 * @param commandMap		Map
	 * @return 출력페이지정보 등록화면 호출시 "admin/menu/EgovProgramChangRequstStre",
	 *		 출력페이지정보 등록처리시 "forward:/admin/menu/EgovProgramChangeRequstSelect.do" 
	 * @exception Exception
	 */
	/*프로그램변경요청등록*/
	@RequestMapping(value="/admin/menu/EgovProgramChangRequstStre.do")
	public String insertProgrmChangeRequst(
			Map commandMap, 
			@ModelAttribute("progrmManageDtlVO") ProgrmManageDtlVO progrmManageDtlVO, 
			BindingResult bindingResult,
			ModelMap model)
			throws Exception { 
		String resultMsg = "";
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		}
		//로그인 객체 선언
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		String sLocationUrl = null;
		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");	
		if(sCmd.equals("insert")){
			//beanValidator 처리
			beanValidator.validate(progrmManageDtlVO, bindingResult);
			if (bindingResult.hasErrors()){
				sLocationUrl = "admin/menu/EgovProgramChangRequstStre";
				return sLocationUrl;
			}
			if(progrmManageDtlVO.getChangerqesterCn()==null || progrmManageDtlVO.getChangerqesterCn().equals("")){progrmManageDtlVO.setChangerqesterCn("");}
			if(progrmManageDtlVO.getRqesterProcessCn()==null || progrmManageDtlVO.getRqesterProcessCn().equals("")){progrmManageDtlVO.setRqesterProcessCn("");}
			progrmManageService.insertProgrmChangeRequst(progrmManageDtlVO);
			resultMsg = tmsMessageSource.getMessage("success.common.insert");
			sLocationUrl = "forward:/admin/menu/EgovProgramChangeRequstSelect.do";
		}else{		
			/* MAX요청번호 조회 */
			ProgrmManageDtlVO tmp_vo = progrmManageService.selectProgrmChangeRequstNo(progrmManageDtlVO);			
			int _tmp_no = tmp_vo.getRqesterNo();
			progrmManageDtlVO.setRqesterNo(_tmp_no);
			progrmManageDtlVO.setRqesterPersonId(user.getId());
			sLocationUrl = "admin/menu/EgovProgramChangRequstStre";
		}
		model.addAttribute("resultMsg", resultMsg);
		return sLocationUrl; 
	}

	/**
	 * 프로그램변경 요청을 수정 한다. 
	 * @param progrmManageDtlVO  ProgrmManageDtlVO
	 * @return 출력페이지정보 "forward:/admin/menu/EgovProgramChangeRequstSelect.do" 
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/menu/EgovProgramChangRequstDetailSelectUpdt.do")
	public String updateProgrmChangeRequst(
			@ModelAttribute("progrmManageDtlVO") ProgrmManageDtlVO progrmManageDtlVO, 
			BindingResult bindingResult,
			ModelMap model)
			throws Exception { 
		String sLocationUrl = null;
		String resultMsg = "";
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		}
		//로그인 객체 선언
		LoginVO loginVO = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		//beanValidator 처리
		beanValidator.validate(progrmManageDtlVO, bindingResult);
		if (bindingResult.hasErrors()){
			sLocationUrl = "forward:/admin/menu/EgovProgramChangRequstDetailSelect.do";
			return sLocationUrl;
		}

		if(progrmManageDtlVO.getRqesterPersonId().equals(loginVO.getId())){
			if(progrmManageDtlVO.getChangerqesterCn()==null || progrmManageDtlVO.getChangerqesterCn().equals("")){progrmManageDtlVO.setChangerqesterCn(" ");}
			if(progrmManageDtlVO.getRqesterProcessCn()==null || progrmManageDtlVO.getRqesterProcessCn().equals("")){progrmManageDtlVO.setRqesterProcessCn(" ");}
			progrmManageService.updateProgrmChangeRequst(progrmManageDtlVO);
			resultMsg = tmsMessageSource.getMessage("success.common.update");
			sLocationUrl = "forward:/admin/menu/EgovProgramChangeRequstSelect.do";
		}else{
			resultMsg = "수정이 실패하였습니다. 변경요청 수정은 변경요청자만 수정가능합니다.";
			progrmManageDtlVO.setTmp_progrmNm(progrmManageDtlVO.getProgrmFileNm());		
			progrmManageDtlVO.setTmp_rqesterNo(progrmManageDtlVO.getRqesterNo());		
			sLocationUrl = "forward:/admin/menu/EgovProgramChangRequstDetailSelect.do";
		}
		model.addAttribute("resultMsg", resultMsg);
		return sLocationUrl; 
	}	

	/**
	 * 프로그램변경 요청을 삭제 한다. 
	 * @param progrmManageDtlVO  ProgrmManageDtlVO
	 * @return 출력페이지정보 "forward:/admin/menu/EgovProgramChangeRequstSelect.do" 
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/menu/EgovProgramChangRequstDelete.do")
	public String deleteProgrmChangeRequst(
			@ModelAttribute("progrmManageDtlVO") ProgrmManageDtlVO progrmManageDtlVO, 
			ModelMap model)
			throws Exception {
		String sLocationUrl = null;
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		}
		//로그인 객체 선언
		LoginVO loginVO = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		if(progrmManageDtlVO.getRqesterPersonId().equals(loginVO.getId())){
		//progrmManageDtlVO.setRqesterPersonId(user.getId());
			model.addAttribute("resultMsg", tmsMessageSource.getMessage("success.common.delete"));
			progrmManageService.deleteProgrmChangeRequst(progrmManageDtlVO);
			sLocationUrl = "forward:/admin/menu/EgovProgramChangeRequstSelect.do";
		}else{
			model.addAttribute("resultMsg", "삭제에 실패하였습니다. 변경요청자만 삭제가능합니다.");
			sLocationUrl = "forward:/admin/menu/EgovProgramChangRequstDetailSelect.do";
		}
		return sLocationUrl; 
	} 

	/**
	 * 프로그램변경 요청에 대한 처리 사항을 조회한다. 
	 * @param searchVO ComDefaultVO
	 * @return 출력페이지정보 "admin/menu/EgovProgramChangeRequstProcess" 
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/menu/EgovProgramChangeRequstProcessListSelect.do")
	public String selectProgrmChangeRequstProcessList(
			@ModelAttribute("searchVO") ComDefaultVO searchVO, 
			ModelMap model)
			throws Exception { 
		 // 0. Spring Security 사용자권한 처리
		 Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		 if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		 }
		 // 내역 조회
		 /** EgovPropertyService.sample */
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
		
		 List list_changerequst = progrmManageService.selectChangeRequstProcessList(searchVO);
		 model.addAttribute("list_changerequst", list_changerequst);

		 int totCnt = progrmManageService.selectChangeRequstProcessListTotCnt(searchVO);
		 paginationInfo.setTotalRecordCount(totCnt);
		 model.addAttribute("paginationInfo", paginationInfo);
		 
		 return "admin/menu/EgovProgramChangeRequstProcess";
	}
	
	/**
	 * 프로그램변경 요청에 대한 처리 사항을 상세조회한다. 
	 * @param progrmManageDtlVO ProgrmManageDtlVO
	 * @return 출력페이지정보 "admin/menu/EgovProgramChangRequstProcessDetailSelectUpdt" 
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/menu/EgovProgramChangRequstProcessDetailSelect.do")
	public String selectProgrmChangRequstProcess(
			@ModelAttribute("progrmManageDtlVO") ProgrmManageDtlVO progrmManageDtlVO,
			ModelMap model)
			throws Exception {
		 // 0. Spring Security 사용자권한 처리
		 Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		 if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		 }
		 if(progrmManageDtlVO.getProgrmFileNm()==null){
			 String _FileNm = progrmManageDtlVO.getTmp_progrmNm();		
			 progrmManageDtlVO.setProgrmFileNm(_FileNm);
			 int _Tmp_no = progrmManageDtlVO.getTmp_rqesterNo();		
			 progrmManageDtlVO.setRqesterNo(_Tmp_no);
		 }
		 ProgrmManageDtlVO resultVO = progrmManageService.selectProgrmChangeRequst(progrmManageDtlVO);
		 if(resultVO.getOpetrId()== null){
			 LoginVO user = 
				(LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
			 resultVO.setOpetrId(user.getId());
		 }
		 model.addAttribute("progrmManageDtlVO", resultVO);
		 return "admin/menu/EgovProgramChangRequstProcessDetailSelectUpdt";
	}	

	/**
	 * 프로그램변경요청처리 내용을 수정 한다. 
	 * @param progrmManageDtlVO ProgrmManageDtlVO 
	 * @return 출력페이지정보 "forward:/admin/menu/EgovProgramChangeRequstProcessListSelect.do" 
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/menu/EgovProgramChangRequstProcessDetailSelectUpdt.do")
	public String updateProgrmChangRequstProcess(
			@ModelAttribute("progrmManageDtlVO") ProgrmManageDtlVO progrmManageDtlVO, 
			BindingResult bindingResult,
			ModelMap model)
			throws Exception { 
		String sLocationUrl = null;
		boolean result = true;
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		}
		
		beanValidator.validate(progrmManageDtlVO, bindingResult);
		if (bindingResult.hasErrors()){
			sLocationUrl = "forward:/admin/menu/EgovProgramChangRequstProcessDetailSelect.do";
			return sLocationUrl;
		}

		LoginVO user = 
			(LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		if(progrmManageDtlVO.getOpetrId().equals(user.getId())){
			if(progrmManageDtlVO.getChangerqesterCn()==null || progrmManageDtlVO.getChangerqesterCn().equals("")){progrmManageDtlVO.setChangerqesterCn(" ");}
			if(progrmManageDtlVO.getRqesterProcessCn()==null || progrmManageDtlVO.getRqesterProcessCn().equals("")){progrmManageDtlVO.setRqesterProcessCn(" ");}
			progrmManageService.updateProgrmChangeRequstProcess(progrmManageDtlVO);
			model.addAttribute("resultMsg", tmsMessageSource.getMessage("success.common.update"));
			
			ProgrmManageDtlVO vo = new ProgrmManageDtlVO();
			vo = progrmManageService.selectRqesterEmail(progrmManageDtlVO);
			String sTemp = null;
			if(progrmManageDtlVO.getProcessSttus().equals("A")){
				sTemp = "신청중";
			}else if(progrmManageDtlVO.getProcessSttus().equals("P")){
				sTemp = "진행중";	
			}else if(progrmManageDtlVO.getProcessSttus().equals("R")){
				sTemp = "반려";
			}else if(progrmManageDtlVO.getProcessSttus().equals("C")){
				sTemp = "처리완료";
			}
			// 프로그램 변경요청 사항을 이메일로  발송한다.(메일연동솔루션 활용)
			/*
			SndngMailVO sndngMailVO = new SndngMailVO();
			sndngMailVO.setDsptchPerson(user.getId());
			sndngMailVO.setRecptnPerson(vo.getTmp_Email());
			sndngMailVO.setSj("프로그램변경요청  처리.");
			sndngMailVO.setEmailCn("프로그램 변경요청 사항이  "+sTemp+"(으)로 처리 되었습니다.");
			sndngMailVO.setAtchFileId(""); 
			result = sndngMailRegistService.insertSndngMail(sndngMailVO); 
			*/
			sLocationUrl = "forward:/admin/menu/EgovProgramChangeRequstProcessListSelect.do";
		}else{
			model.addAttribute("resultMsg", "수정이 실패하였습니다. 변경요청처리 수정은 변경처리해당 담당자만 처리가능합니다.");
			progrmManageDtlVO.setTmp_progrmNm(progrmManageDtlVO.getProgrmFileNm());
			progrmManageDtlVO.setTmp_rqesterNo(progrmManageDtlVO.getRqesterNo());
			sLocationUrl = "forward:/admin/menu/EgovProgramChangRequstProcessDetailSelect.do";
		}
		return sLocationUrl; 
	}	 

	/**
	 * 프로그램변경요청처리를 삭제 한다. 
	 * @param progrmManageDtlVO  ProgrmManageDtlVO
	 * @return 출력페이지정보 "forward:/admin/menu/EgovProgramChangeRequstProcessListSelect.do" 
	 * @exception Exception
	 */
	/*프로그램변경요청처리 삭제*/
	@RequestMapping(value="/admin/menu/EgovProgramChangRequstProcessDelete.do")
	public String deleteProgrmChangRequstProcess(
			@ModelAttribute("progrmManageDtlVO") ProgrmManageDtlVO progrmManageDtlVO, 
			ModelMap model)
			throws Exception {
		 // 0. Spring Security 사용자권한 처리
		 Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		 if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		 }
		 progrmManageService.deleteProgrmChangeRequst(progrmManageDtlVO);

		 return "forward:/admin/menu/EgovProgramChangeRequstProcessListSelect.do";
	}
	
	/**
	 * 프로그램변경이력리스트를 조회한다. 
	 * @param searchVO ComDefaultVO
	 * @return 출력페이지정보 "admin/menu/EgovProgramChgHst"
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/menu/EgovProgramChgHstListSelect.do")
	public String selectProgrmChgHstList(
			@ModelAttribute("searchVO") ComDefaultVO searchVO, 
			ModelMap model)
			throws Exception { 
		 // 0. Spring Security 사용자권한 처리
		 Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		 if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		 }
		 // 내역 조회
		 /** EgovPropertyService.sample */
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
		
		 List list_changerequst = progrmManageService.selectProgrmChangeRequstList(searchVO);
		 model.addAttribute("list_changerequst", list_changerequst);

		 int totCnt = progrmManageService.selectProgrmChangeRequstListTotCnt(searchVO);
		 paginationInfo.setTotalRecordCount(totCnt);
		 model.addAttribute("paginationInfo", paginationInfo);
		 
		 return "admin/menu/EgovProgramChgHst";
	} 

	/*프로그램변경이력상세조회*/ 
	/**
	 * 프로그램변경이력을 상세조회한다. 
	 * @param progrmManageDtlVO ProgrmManageDtlVO
	 * @return 출력페이지정보 "admin/menu/EgovProgramChgHstDetail"
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/menu/EgovProgramChgHstListDetailSelect.do")
	public String selectProgramChgHstListDetail(
			@ModelAttribute("progrmManageDtlVO") ProgrmManageDtlVO progrmManageDtlVO,
			ModelMap model)
			throws Exception {
		 // 0. Spring Security 사용자권한 처리
		 Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		 if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		 }
		 String _FileNm = progrmManageDtlVO.getTmp_progrmNm();
		 progrmManageDtlVO.setProgrmFileNm(_FileNm);
		 int _tmp_no = progrmManageDtlVO.getTmp_rqesterNo();
		 progrmManageDtlVO.setRqesterNo(_tmp_no);

		 ProgrmManageDtlVO resultVO = progrmManageService.selectProgrmChangeRequst(progrmManageDtlVO);
		 model.addAttribute("resultVO", resultVO);
		 return "admin/menu/EgovProgramChgHstDetail";
	}

	/**
	 * 프로그램파일명을 조회한다. 
	 * @param searchVO ComDefaultVO
	 * @return 출력페이지정보 "admin/menu/EgovFileNmSearch"
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/menu/EgovProgramListSearch.do")
	public String selectProgrmListSearch(
			@ModelAttribute("searchVO") ComDefaultVO searchVO, 
			ModelMap model)
			throws Exception { 
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		}
		// 내역 조회
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
		
		List list_progrmmanage = progrmManageService.selectProgrmList(searchVO);
		model.addAttribute("list_progrmmanage", list_progrmmanage);

		int totCnt = progrmManageService.selectProgrmListTotCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		model.addAttribute("paginationInfo", paginationInfo);
		
		return "admin/menu/EgovFileNmSearch";

	}
	
	/**
	 * 선택된 메뉴에 등록된 프로그램 목록 조회
	 * 
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	@SuppressWarnings("rawtypes")
	@RequestMapping(value = "/toProgramList.do", method = RequestMethod.POST)
	public ModelAndView ProgramList(ModelMap model, @RequestParam(value = "menuNo", required = false) int menuNo) throws Exception {
		
		
		List list = progrmManageService.selectRegistProgramList(menuNo);
		
		//model.addAttribute("programList", list);
		
		//return "admin/menu/EgovProgramList";
		ModelAndView mav = new ModelAndView();
		mav.addObject("result", list);
		mav.setViewName("jsonView");
		return mav;
	}
	
	@RequestMapping(value = "/ProgramDetailInfo.do", method = RequestMethod.POST)
	public ModelAndView ProgramList(@RequestParam(value = "menuNo") String menuNo, @RequestParam(value = "seq") String seq) throws Exception {
		ModelAndView mav = new ModelAndView();

		HashMap<String, Object> params = new HashMap<String, Object>();
		params.put("menuNo", menuNo);
		params.put("seq", seq);

		Object result = progrmManageService.selectRegistProgramList(params);
		mav.addObject("result", result);
		mav.setViewName("jsonView");
		return mav;
	}
	
	/**
	 * 프로그램목록을 수정 한다. 
	 * @param progrmManageVO ProgrmManageVO
	 * @return 출력페이지정보 "forward:/admin/menu/EgovProgramListManageSelect.do" 
	 * @exception Exception
	 */
	/*프로그램목록수정*/
	@RequestMapping(value="/admin/menu/updateProgramDetailInfo.do")
	public String updateProgramDetailInfo(
			@ModelAttribute("progrmManageVO") ProgrmManageVO progrmManageVO,
			BindingResult bindingResult,
			ModelMap model)
			throws Exception { 
		
		String resultMsg = "";
		String sLocationUrl = null;
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		}
		
		beanValidator.validate(progrmManageVO, bindingResult);

		if (bindingResult.hasErrors()){
			sLocationUrl = "forward:/admin/menu/EgovProgramListDetailSelect.do";
			return sLocationUrl;
		}
		
		if(progrmManageVO.getProgrmDc()==null || progrmManageVO.getProgrmDc().equals("")) {
			progrmManageVO.setProgrmDc(" ");
		}
		
		progrmManageService.updateProgramDetailInfo(progrmManageVO);
		resultMsg = tmsMessageSource.getMessage("success.common.update");
		sLocationUrl = "forward:/admin/menu/EgovProgramListManageSelect.do";
		model.addAttribute("resultMsg", resultMsg);
		return sLocationUrl; 
	}
	
	/***
	 * 화면에 조회된 프로그램을 삭제 (신규추가) , 2013-10-08 , 이강민
	 * @param menuNo
	 * @param SEQ
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/menu/ProgramDelete.do")
	public String deleteProgrm(@RequestParam(value="menuNo") int menuNo, @RequestParam(value="SEQ") int SEQ, ModelMap model)
			throws Exception {

		String resultMsg = "";
		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		}
		
		HashMap<String, Object> param = new HashMap<String, Object>();
		param.put("menuNo", menuNo);
		param.put("SEQ", SEQ);
		
		progrmManageService.deleteProgram(param);
		resultMsg = tmsMessageSource.getMessage("success.common.delete");
		model.addAttribute("resultMsg", resultMsg);
		return "forward:/admin/menu/EgovProgramListManageSelect.do";
	}
	
	/***
	 * 프로그램 신규 등록 메서드 (신규추가), 2013-10-08, 이강민
	 * @param commandMap
	 * @param progrmManageVO
	 * @param bindingResult
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/menu/ProgramRegist.do")
	public String insertProgrmInfo(
			Map commandMap, 
			@ModelAttribute("progrmManageVO") ProgrmManageVO progrmManageVO,
			BindingResult bindingResult,
			ModelMap model)
			throws Exception { 
		String resultMsg = "";
		String sLocationUrl = null;

		// 0. Spring Security 사용자권한 처리
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			return "common/login/LoginUser";
		}

		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
		if(sCmd.equals("insert")){
			beanValidator.validate(progrmManageVO, bindingResult);
			if (bindingResult.hasErrors()){
				sLocationUrl = "admin/menu/EgovProgramListRegist";
				return sLocationUrl;
			}
			if(progrmManageVO.getProgrmDc()==null || progrmManageVO.getProgrmDc().equals("")){progrmManageVO.setProgrmDc(" ");}
			
			HashMap<String, Object> param = new HashMap<String, Object>();
			param.put("menuNo", progrmManageVO.getMenuNo());
			param.put("upperMenuId", progrmManageVO.getUpperMenuId());
			
			String getSeq = (String) progrmManageService.getMaxSequence(param);
			
			if(getSeq != null) {
				progrmManageVO.setSEQ(getSeq);
			} else {
				progrmManageVO.setSEQ("0");
			}
			
			progrmManageService.insertProgrmInfo(progrmManageVO);
			resultMsg = tmsMessageSource.getMessage("success.common.insert");
			sLocationUrl = "forward:/admin/menu/EgovProgramListManageSelect.do";
		}else{
			sLocationUrl = "admin/menu/EgovProgramListRegist"; 
		}
		
		List list_menulist = menuManageService.selectMenuList();
		resultMsg = tmsMessageSource.getMessage("success.common.select");
		model.addAttribute("list_menulist", list_menulist);
		
		model.addAttribute("resultMsg", resultMsg);
		return sLocationUrl; 
	}
	
}