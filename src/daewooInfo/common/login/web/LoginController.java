package daewooInfo.common.login.web;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import daewooInfo.admin.keyword.bean.KeywordSearchVO;
import daewooInfo.admin.keyword.bean.KeywordVO;
import daewooInfo.admin.keyword.service.KeywordService;
import daewooInfo.admin.member.service.MemberService;
import daewooInfo.cmmn.bean.CmmnDetailCode;
import daewooInfo.cmmn.bean.DeptVO;
import daewooInfo.common.TmsMessageSource;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.login.bean.MemberVO;
import daewooInfo.common.login.service.LoginService;
import daewooInfo.common.menu.bean.MenuVO;
import daewooInfo.common.menu.service.MenuService;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.AesUtil;
import daewooInfo.common.util.sim.ClntInfo;
import daewooInfo.common.util.sim.FileScrty;
import daewooInfo.dailywork.service.DailyWorkService;
import daewooInfo.mobile.com.utl.LogInfoUtil;
import daewooInfo.waterpolmnt.waterinfo.service.WaterinfoService;

@Controller
public class LoginController {

	/**
	 * MemberService
	 * @uml.property  name="memberService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "memberService")
	private MemberService memberService;

	/**
	 * KeywordService
	 * @uml.property  name="keywordService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "keywordService")
	private KeywordService keywordService;
	
	/**
	 * LoginService
	 * @uml.property  name="loginService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "loginService")
	private LoginService loginService;
	
	/**
	 * @uml.property  name="dailyWorkService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "DailyWorkService")
    private DailyWorkService dailyWorkService;
	
	/**
	 * @uml.property  name="waterinfoService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "waterinfoService")
	private WaterinfoService waterinfoService;
	
	/**
	 * @uml.property  name="beanValidator"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Autowired
	private DefaultBeanValidator beanValidator;
	
	/**
	 * EgovMessageSource
	 * @uml.property  name="tmsMessageSource"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="tmsMessageSource")
	TmsMessageSource tmsMessageSource;
	
	@Resource(name="menuService")
	MenuService menuService;
	
	private static final int KEY_SIZE = 128;
    private static final int ITERATION_COUNT = 10000;
    private static final String IV = "F27D5C9927726BCEFE7510B1BDD3D137";
    private static final String SALT = "3FF2EC019C627B945225DEBAD71A01B6985FE84C95A70EB132882F88C0A59A55";
    private static final String PASSPHRASE = "waterkorea aes encoding algorithm";

	/**
	 * 패스워드 일괄 암호화 (임시)
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/common/login/batchPasswordMd5.do")
	public String batchPasswordMd5(HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception {
		
		loginService.batchPasswordMd5();
		
		return "index";
	}
	
	/**
	 * log
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log log = LogFactory.getLog(LoginController.class);
	
	/**
	 * 로그인 화면으로 들어간다.
	 * ---따로 로그인 페이지가 없다면 이부분은 필요없음.
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value="/common/login/LoginUser.do")
	public String loginUsrView(@ModelAttribute("loginVO") LoginVO loginVO,
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model) 
			throws Exception {
		/*
		GPKIHttpServletResponse gpkiresponse = null;
		GPKIHttpServletRequest gpkirequest = null;
		
		try{
		
			gpkiresponse=new GPKIHttpServletResponse(response); 
			gpkirequest= new GPKIHttpServletRequest(request);
			gpkiresponse.setRequest(gpkirequest);
			model.addAttribute("challenge", gpkiresponse.getChallenge());
			return "cmm/uat/uia/EgovLoginUsr";
			
		}catch(Exception e){
			return "cmm/egovError";
		}
		*/
		return "common/login/LoginUser";
	}
	
	/**
	 * 일반 로그인을 처리한다
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
	@RequestMapping(value="/common/login/actionLogin.do")
	public String actionLogin(@ModelAttribute("loginVO") LoginVO loginVO, 
								HttpServletRequest request,
								HttpServletResponse response, 
								ModelMap model)
			throws Exception {
		    
		AesUtil util = new AesUtil(KEY_SIZE, ITERATION_COUNT);
		String decryptId = util.decrypt(SALT, IV, PASSPHRASE, loginVO.getId());
        String decryptPassword = util.decrypt(SALT, IV, PASSPHRASE, loginVO.getPassword());
 
        loginVO.setId(decryptId);
        loginVO.setPassword(decryptPassword);

		// 접속IP
		String userIp = ClntInfo.getClntIP(request);
		loginVO.setIp(userIp);
				
		// 로그인 기본정보 가져오기 
		LoginVO resultId = loginService.checkWrongCount(loginVO);
		
		// 로그인 5회 오류시 로그인 X 하기
		if (Integer.parseInt(resultId.getWrongCount()) >= 5) {
			return "redirect:/err/biz_err02.jsp";
		}
		
		// 회원탈퇴 계정 로그인 X 하기
		if ("X".equals(resultId.getMemberState())){
			request.getSession().invalidate();
			return "redirect:/err/biz_err04.jsp";
		}
		
		// 휴면 계정 체크, 마지막 접속일이 30일이 지난 경우 휴면 처리
		if(Integer.parseInt(resultId.getLastLogin()) >= 0){
			request.getSession().invalidate();
			return "redirect:/err/biz_err05.jsp";
		}
		
		// 가입신청 대기중 승인 여부(APPROVAL_FLAG == S 승인대기상태), 승인 대기 ID도 비밀번호를 체크한다.
		if ("S".equals(resultId.getApprovalFlag())){
			if(resultId.getPassword().equals(FileScrty.encryptPassword(loginVO.getPassword()))){
				loginVO.setWrongCount("0"); // 패스워드 맞을 경우 wrongCount 초기화
				loginService.updateWrongCount(loginVO);
				
				// 세션에 값을 넣는 이유는 /acc/accountAppFinish.do 로의 URL직접 접근을 막기 위해서이다.
				request.getSession().setAttribute("urlAccessControl", "true");
				response.setContentType("text/html; charset=UTF-8");
				if(request.getRequestURL().indexOf("waterkorea.or.kr") >= 0){
					String printMessage = "<script>alert('계정승인 요청 중입니다. 계정신청 내역을 확인 하시겠습니까?');document.location.href='http://www.waterkorea.or.kr/acc/accountAppFinish.do?memberId="+loginVO.getId()+"';</script>";
					response.getWriter().print(printMessage);
				}else{
					String printMessage = "<script>alert('계정승인 요청 중입니다. 계정신청 내역을 확인 하시겠습니까?');document.location.href='/acc/accountAppFinish.do?memberId="+loginVO.getId()+"';</script>";
					//System.out.println("printMessage: " + printMessage);
					response.getWriter().print(printMessage);
				}
				return null;
			}else{
				loginService.updateWrongCount(loginVO); // 비밀번호 틀림 > wrongCount 1증가
				
				response.setContentType("text/html; charset=UTF-8");
				if(request.getRequestURL().indexOf("waterkorea.or.kr") >= 0){
					response.getWriter().print("<script>alert('로그인 정보가 올바르지 않습니다.');location.replace('http://www.waterkorea.or.kr/index.jsp');</script>");
				}else{
					response.getWriter().print("<script>alert('로그인 정보가 올바르지 않습니다.');location.replace('/index.jsp');</script>");
				}
				return null;
			}
		}
		
		// 1. 일반 로그인 처리
		LoginVO resultVO = loginService.actionLogin(loginVO);
		
		// 관리자 계정 외부 접속 제한
		// 2017-01-17 김경환 대리 요청으로 주석처리
		/*if("ROLE_ADMIN".equals(resultVO.getRoleCode()) && !userIp.startsWith("10.101.")){
			request.getSession().invalidate();
			return "redirect:/err/biz_err06.jsp";
		}*/
		
		boolean NormalityLogin = false;
		if(null != request.getSession().getAttribute("NormalityLogin") && null != request.getParameter("NormalityLogin")){
			if(request.getSession().getAttribute("NormalityLogin").toString().equals(request.getParameter("NormalityLogin").toString())){
				NormalityLogin = true;
			}
		}
		
	    
		request.getSession().setAttribute("NormalityLogin",null);
		
		if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("") ) {
			// 2. spring security 연동
			String return_str = "redirect:/j_spring_security_check.do?j_username=" + resultVO.getId() + "&j_password=" + resultVO.getUniqId();
			if(request.getRequestURL().indexOf("waterkorea.or.kr") >= 0)
			{
				return_str = "redirect:/j_spring_security_check.do?j_username=" + resultVO.getId() + "&j_password=" + resultVO.getUniqId() + "&spring-security-redirect=http://www.waterkorea.or.kr/init.do";
			}
			return return_str;
		} else {
			
			loginService.updateWrongCount(resultVO);
			
			response.setContentType("text/html; charset=UTF-8");
			if(request.getRequestURL().indexOf("waterkorea.or.kr") >= 0){
				response.getWriter().print("<script>alert('로그인 정보가 올바르지 않습니다.');location.replace('http://www.waterkorea.or.kr/index.jsp');</script>");
			}else{
				response.getWriter().print("<script>alert('로그인 정보가 올바르지 않습니다.');location.replace('/index.jsp');</script>");
			}
			return null;
		}
	}	

	/**
	 * 인증정보를 저장한다.
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
	@RequestMapping(value="/common/login/updateDn.do")
	public String updateDn(@ModelAttribute("loginVO") LoginVO loginVO, 
								ModelMap model)
			throws Exception {

		// 인증서 정보 업데이트
		loginService.updateDn(loginVO);
		
		return "index";
	}	
	
	/**
	 * 인증서 로그인을 처리한다
	 * @param vo - 주민번호가 담긴 LoginVO
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
	@RequestMapping(value="/common/login/actionCrtfctLogin.do")
	public String actionCrtfctLogin(@ModelAttribute("loginVO") LoginVO loginVO, 
			HttpServletRequest request,
			HttpServletResponse response,
			ModelMap model)
			throws Exception {
		
		// 접속IP
		String userIp = ClntInfo.getClntIP(request);
		loginVO.setIp(userIp);
		
		// 1. 인증서 로그인 처리
		LoginVO resultVO = loginService.actionCrtfctLogin(loginVO);
		
		if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("") ) {
			// 2. spring security 연동
			return "redirect:/j_spring_security_check.do?j_username=" + resultVO.getId() + "&j_password=" + resultVO.getUniqId();
		} else {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			//return "common/login/LoginUser";
			return "index";
		}
		
		/*
		// 1. GPKI 인증
		GPKIHttpServletResponse gpkiresponse = null;
		GPKIHttpServletRequest gpkirequest = null;
		String dn = "";
		try{
			gpkiresponse = new GPKIHttpServletResponse(response);
			gpkirequest = new GPKIHttpServletRequest(request);
			gpkiresponse.setRequest(gpkirequest);
			X509Certificate cert = null; 
			
			byte[] signData = null;
			byte[] privatekey_random = null;
			String signType = "";
			String queryString = "";
			
			cert = gpkirequest.getSignerCert();
			dn = cert.getSubjectDN();
			
			java.math.BigInteger b = cert.getSerialNumber();
			b.toString();
			int message_type =  gpkirequest.getRequestMessageType();
			if( message_type == gpkirequest.ENCRYPTED_SIGNDATA || message_type == gpkirequest.LOGIN_ENVELOP_SIGN_DATA ||
				message_type == gpkirequest.ENVELOP_SIGNDATA || message_type == gpkirequest.SIGNED_DATA){
				signData = gpkirequest.getSignedData();
				if(privatekey_random != null) {
					privatekey_random	= gpkirequest.getSignerRValue();
				}
				signType = gpkirequest.getSignType();
			}		
			queryString = gpkirequest.getQueryString();
		}catch(Exception e){
			return "cmm/egovError";
		}
		
		// 2. 업무사용자 테이블에서 dn값으로 사용자의 ID, PW를 조회하여 이를 일반로그인 형태로 인증하도록 함
		if (dn != null && !dn.equals("")) {
			
			loginVO.setDn(dn);
			LoginVO resultVO = loginService.actionCrtfctLogin(loginVO);
			if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {
				
				// 3. spring security 연동
				return "redirect:/j_spring_security_check.do?j_username=" + resultVO.getUserSe() + resultVO.getId() + "&j_password=" + resultVO.getUniqId();
			} else {
				model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
				return "cmm/uat/uia/EgovLoginUsr";
			}
		} else {
			model.addAttribute("message", egovMessageSource.getMessage("fail.common.login"));
			return "cmm/uat/uia/EgovLoginUsr";
		}

		return "common/login/LoginUser";
		*/
	}

	/**
	 * 로그인 후 메인 및 안내페이지 선택 호출
	 * @param 
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value="/init.do")
	public String actionInit(@ModelAttribute("MemberVO") MemberVO memberVO, 
			HttpServletRequest request, ModelMap model) 
			throws Exception {
		
		// 로그인 되어 있지 않다면.. index.jsp로 보낸다.
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			//return "common/login/LoginUser";
			return "index";
		}
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		
		request.getSession().setAttribute("userId", user.getId());
		//session timeout 설정
		//request.getSession().setMaxInactiveInterval(60*10); // 세션타임아웃 10분으로 설정
		
		List<String> authorities = TmsUserDetailsHelper.getAuthorities();
		
		memberVO.setMemberId(user.getId());
		MemberVO vo = memberService.selectMemberPrivacy(memberVO);
		
		String main_page = "";
		int passwordChangeCnt =  Integer.parseInt(vo.getPasswordChangeCnt());
		
		//개인정보동의를 하지 않았다면
		if("N".equals(vo.getPrivacyAgree())){
			main_page = "privacy";
		//비밀번호 변경 후 3개월이 지날경우
		}else{
			if(passwordChangeCnt >= 0){
				main_page = "password";
			}else{
				main_page = "main";
			}
		}
		
		//업무일지 받은결재 알림
		int dailyWorkAppCnt = dailyWorkService.getDailyWorkApprovalCnt(user.getId());
		String dailyWorkAppCheck = "N";
		
		if(dailyWorkAppCnt>0){
			dailyWorkAppCheck = "Y";
		}
		model.addAttribute("dailyWorkAppCheck", dailyWorkAppCheck);

		request.getSession().setAttribute("authorList", loginService.memberAuthorList(user.getId()));
		
		//데이터 선별 이력 확인 2014.11.07
		String dataSelectCheck = "N";
		
		model.addAttribute("dataSelectCheck", dataSelectCheck);
				
		// 메인 페이지 이동
		//String main_page = Globals.MAIN_PAGE;
		// 일단은 프로퍼티에서 가져오는거 말고 fix로 하자..
		
		if (main_page.startsWith("/")) {
			return "forward:" + main_page;
		} else {
			return main_page;
		}
	
	}

	/**
	 * 로그인 후 메인화면으로 들어간다
	 * @param 
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	//@RequestMapping(value="/common/login/actionMain.do")
	@RequestMapping(value="/main.do") 
	public String actionMain(@ModelAttribute("MemberVO") MemberVO memberVO, 
			HttpServletRequest request, ModelMap model) 
			throws Exception {
				
		// 로그인 되어 있지 않다면.. index.jsp로 보낸다.
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			//return "common/login/LoginUser";
			return "index";
		}
		
		MenuVO vo = new MenuVO();
		vo.setMenuUpperNo(11100);
		vo.setMenuNo(11120);
		vo.setRoleName(LogInfoUtil.GetSessionLogin().getRoleCode());
		model.addAttribute("TotalMntMainTS", menuService.selectMenu(vo));
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		List<String> authorities = TmsUserDetailsHelper.getAuthorities();
		
		//결재대기문서 확인
		int dailyWorkAppCnt = dailyWorkService.getDailyWorkApprovalCnt(user.getId());
		String dailyWorkAppCheck = "N";
		
		if(dailyWorkAppCnt>0){
			dailyWorkAppCheck = "Y";
		}
		
		model.addAttribute("dailyWorkAppCheck", dailyWorkAppCheck);
		
		//데이터 선별 이력 확인 2014.11.07
		String dataSelectCheck = "N";
		
		if(user.getId().equals("2thdev") || user.getId().equals("kecohq8")){
			int dataSelectCnt = waterinfoService.getDataSelectCnt("Y");
			
			if(dataSelectCnt>0){
				dataSelectCheck = "Y";
			}
		}
		
		request.getSession().setAttribute("authorList", loginService.memberAuthorList(user.getId()));
		
		model.addAttribute("dataSelectCheck", dataSelectCheck);
		
		// 메인 페이지 이동
		//String main_page = Globals.MAIN_PAGE;
		// 일단은 프로퍼티에서 가져오는거 말고 fix로 하자..
		String main_page = "main";
		
		if (main_page.startsWith("/")) {
			return "forward:" + main_page;
		} else {
			return main_page;
		}
	
	}
	
	@RequestMapping(value="/main2.do") 
	public String actionMain2(@ModelAttribute("MemberVO") MemberVO memberVO, 
			HttpServletRequest request, ModelMap model) 
			throws Exception {
				
		// 로그인 되어 있지 않다면.. index.jsp로 보낸다.
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			//return "common/login/LoginUser";
			return "index";
		}
		
		MenuVO vo = new MenuVO();
		vo.setMenuUpperNo(11100);
		vo.setMenuNo(11120);
		vo.setRoleName(LogInfoUtil.GetSessionLogin().getRoleCode());
		model.addAttribute("TotalMntMainTS", menuService.selectMenu(vo));
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		List<String> authorities = TmsUserDetailsHelper.getAuthorities();
		
		//결재대기문서 확인
		int dailyWorkAppCnt = dailyWorkService.getDailyWorkApprovalCnt(user.getId());
		String dailyWorkAppCheck = "N";
		
		if(dailyWorkAppCnt>0){
			dailyWorkAppCheck = "Y";
		}
		
		model.addAttribute("dailyWorkAppCheck", dailyWorkAppCheck);
		
		//데이터 선별 이력 확인 2014.11.07
		String dataSelectCheck = "N";
		
		if(user.getId().equals("2thdev") || user.getId().equals("kecohq8")){
			int dataSelectCnt = waterinfoService.getDataSelectCnt("Y");
			
			if(dataSelectCnt>0){
				dataSelectCheck = "Y";
			}
		}
		
		request.getSession().setAttribute("authorList", loginService.memberAuthorList(user.getId()));
		
		model.addAttribute("dataSelectCheck", dataSelectCheck);
		
		// 메인 페이지 이동
		//String main_page = Globals.MAIN_PAGE;
		// 일단은 프로퍼티에서 가져오는거 말고 fix로 하자..
		String main_page = "main2";
		
		if (main_page.startsWith("/")) {
			return "forward:" + main_page;
		} else {
			return main_page;
		}
	
	}

	/**
	 * 로그인 후 개인정보 동의화면으로  들어간다
	 * @param 
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value="/privacy.do")
	public String actionPrivacy(@ModelAttribute("MemberVO") MemberVO memberVO, 
			HttpServletRequest request, ModelMap model) 
			throws Exception {
				
		// 로그인 되어 있지 않다면.. index.jsp로 보낸다.
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			//return "common/login/LoginUser";
			return "index";
		}
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		List<String> authorities = TmsUserDetailsHelper.getAuthorities();
		
		String main_page = "privacy";
		
		// 메인 페이지 이동
		//String main_page = Globals.MAIN_PAGE;
		// 일단은 프로퍼티에서 가져오는거 말고 fix로 하자..
		
		if (main_page.startsWith("/")) {
			return "forward:" + main_page;
		} else {
			return main_page;
		}
	
	}

	/**
	 * 유저의 개인정보동의정보를 변경한다.
	 * @param loginVO
	 * @param memberVO
	 * @param model
	 * @return "/password"
	 * @throws Exception
	 */
	@RequestMapping(value="/common/updatePrivacy.do")
	public String updatePrivacy (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("memberVO") MemberVO memberVO
			, BindingResult bindingResult
			, Map commandMap
			, ModelMap model
			) throws Exception {
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		memberVO.setMemberId(user.getId());
		
		memberService.updatePrivacy(memberVO);
		model.addAttribute("message", tmsMessageSource.getMessage("success.request.msg"));
		
		return "redirect:/password.do";
	}	

	/**
	 * 로그인 후 비밀번호 변경 페이지로  들어간다
	 * @param 
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value="/password.do", method=RequestMethod.GET)
	public String actionPassword(@ModelAttribute("MemberVO") MemberVO memberVO, 
			HttpServletRequest request, ModelMap model) 
			throws Exception {
		
		// 로그인 되어 있지 않다면.. index.jsp로 보낸다.
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			//return "common/login/LoginUser";
			return "index";
		}
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		List<String> authorities = TmsUserDetailsHelper.getAuthorities();
		
		String userId = user.getId();
		memberVO.setMemberId(userId);
		MemberVO vo = memberService.selectMemberPrivacy(memberVO);

		String main_page = "";
		
		//비밀번호 변경 후 3개월이 지날경우
		int passwordChangeCnt =  Integer.parseInt(vo.getPasswordChangeCnt());
		if(passwordChangeCnt >= 0){
			main_page = "password";
		}else{
			main_page = "main";
		}
		
		model.addAttribute("privacy", vo);
		
		// 메인 페이지 이동
		//String main_page = Globals.MAIN_PAGE;
		// 일단은 프로퍼티에서 가져오는거 말고 fix로 하자..
		
		if (main_page.startsWith("/")) {
			return "forward:" + main_page;
		} else {
			return main_page;
		}
	
	}

	
	/**
	 * 유저의 비밀번호 정보를 변경한다.
	 * @param loginVO
	 * @param memberVO
	 * @param model
	 * @return "/password"
	 * @throws Exception
	 */
	@RequestMapping(value="/password.do", method=RequestMethod.POST)
	public String updatePassword (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("memberVO") MemberVO memberVO
			, @ModelAttribute("keywordVO") KeywordVO keywordVO
			, @ModelAttribute("keywordSearchVO") KeywordSearchVO keywordSearchVO
			, BindingResult bindingResult
			, Map commandMap
			, ModelMap model
			) throws Exception {
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		memberVO.setMemberId(user.getId());
		
		//데이터 처리 부분(비밀번호 암호화)

		
		//현재 패스워드
		memberVO.setPasswordOld(FileScrty.encryptPassword(memberVO.getPasswordOld()));	
		
		//변경할 패스워드
//		String keywordOriginal = memberVO.getPassword();
//		memberVO.setPassword(FileScrty.encryptPassword(keywordOriginal));
		
		// 현재 비밀번호가 맞는지 체크
		MemberVO resultVO = memberService.selectMemberPrivacy(memberVO);
		if(resultVO.getPassword().equals(memberVO.getPasswordOld())){
			
			//비밀번호 키워드 체크
			keywordSearchVO.setSearchKeyword(memberVO.getPassword());
			List resultList = keywordService.selectKeywordCheckList(keywordSearchVO);
			
			if (resultList.size() > 0){
				//금지된 문구가 들어가 비밀번호로 사용할 수 없다는 메시지 출력
				model.addAttribute("resultList", resultList);
				model.addAttribute("message", tmsMessageSource.getMessage("fail.keyword.pwsearch"));
				//return "password";
				return "password";
				//return "redirect:/password.do";
			}
			
			// 이전 비밀번호를 사용하지 못하도록 처리
			String newPassword = FileScrty.encryptPassword(memberVO.getPassword());
			if( newPassword.equals(memberVO.getPasswordOld()) ||
				newPassword.equals(resultVO.getPwdHistory1())|| 
				newPassword.equals(resultVO.getPwdHistory2())) {
				model.addAttribute("message", tmsMessageSource.getMessage("fail.keyword.lastpw"));
				return "password";
			}
			
			// 현재 비밀번호가 맞다면 비밀번호 변경 처리
			memberService.changePassword(memberVO);
			model.addAttribute("message", tmsMessageSource.getMessage("success.request.msg"));
		}else{
			//비밀번호가 같지않다면
			model.addAttribute("message", tmsMessageSource.getMessage("fail.now.pwsearch"));
			return "password";
			//return "redirect:/password.do";
		}
		model.addAttribute("memberFrm", memberVO);
		
		//return "redirect:/main.do"; // [DEVENV]
		return "redirect:http://www.waterkorea.or.kr/main.do"; // [PRODENV]
	}	
	
	/**
	 * 특정 페이지로 이동한다.
	 * @param 
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value="/common/page.do")
	public String actionPage(
			Map<String, Object> commandMap,
			ModelMap model) 
			throws Exception {
		
		// 로그인 되어 있지 않다면.. index.jsp로 보낸다.
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		if(!isAuthenticated) {
			model.addAttribute("message", tmsMessageSource.getMessage("fail.common.login"));
			//return "common/login/LoginUser";
			return "index";
		}
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		List<String> authorities = TmsUserDetailsHelper.getAuthorities();

		model.addAttribute("user", user);
		model.addAttribute("authorities", authorities);
		
		String view = (String)commandMap.get("id");
		
		//System.out.print(view);
		
		return view;
	}	
	
	/**
	 * 로그아웃한다.
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/common/login/actionLogout.do")
	public String actionLogout(HttpServletRequest request, ModelMap model) 
			throws Exception {
		
		String userIp = ClntInfo.getClntIP(request);
		
		//session invalidate
		request.getSession().invalidate();
		
		// 1. Security 연동
		return "redirect:/j_spring_security_logout.do";
	}
	
	/**
	 * 아이디/비밀번호 찾기 화면으로 들어간다
	 * @param 
	 * @return 아이디/비밀번호 찾기 페이지
	 * @exception Exception
	 */
	@RequestMapping(value="/uat/uia/egovIdPasswordSearch.do")
	public String idPasswordSearchView(ModelMap model) 
			throws Exception {
		
		/*
		// 1. 비밀번호 힌트 공통코드 조회
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("COM022");
		List code = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("pwhtCdList", code);
		*/
		return "cmm/uat/uia/EgovIdPasswordSearch";
	}
	
	/**
	 * 인증서안내 화면으로 들어간다
	 * @return 인증서안내 페이지
	 * @exception Exception
	 */
	@RequestMapping(value="/uat/uia/egovGpkiIssu.do")
	public String gpkiIssuView(ModelMap model) 
			throws Exception {
		return "cmm/uat/uia/EgovGpkiIssu";
	}
	
	/**
	 * 아이디를 찾는다.
	 * @param vo - 이름, 이메일주소, 사용자구분이 담긴 LoginVO
	 * @return result - 아이디
	 * @exception Exception
	 */
	@RequestMapping(value="/uat/uia/searchId.do")
	public String searchId(@ModelAttribute("loginVO") LoginVO loginVO, 
			ModelMap model)
			throws Exception {
		
		if (loginVO == null || loginVO.getName() == null || loginVO.getName().equals("")
			&& loginVO.getEmail() == null || loginVO.getEmail().equals("")
		) {
			return "cmm/egovError";
		}
		
		// 1. 아이디 찾기
		LoginVO resultVO = loginService.searchId(loginVO);
		
		if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {
			
			model.addAttribute("resultInfo", "아이디는 " + resultVO.getId() + " 입니다.");
			return "cmm/uat/uia/EgovIdPasswordResult";
		} else {
			model.addAttribute("resultInfo", tmsMessageSource.getMessage("fail.common.idsearch"));
			return "cmm/uat/uia/EgovIdPasswordResult";
		}
	}
	
	/**
	 * 비밀번호를 찾는다.
	 * @param vo - 아이디, 이름, 이메일주소, 비밀번호 힌트, 비밀번호 정답, 사용자구분이 담긴 LoginVO
	 * @return result - 임시비밀번호전송결과
	 * @exception Exception
	 */
	@RequestMapping(value="/uat/uia/searchPassword.do")
	public String searchPassword(@ModelAttribute("loginVO") LoginVO loginVO, 
			ModelMap model)
			throws Exception {
		
		if (loginVO == null || loginVO.getId() == null || loginVO.getId().equals("")
			&& loginVO.getName() == null || loginVO.getName().equals("")
			&& loginVO.getEmail() == null || loginVO.getEmail().equals("")
			&& loginVO.getPasswordHint() == null || loginVO.getPasswordHint().equals("")
			&& loginVO.getPasswordCnsr() == null || loginVO.getPasswordCnsr().equals("")
		) {
			return "cmm/egovError";
		}
		
		// 1. 비밀번호 찾기
		boolean result = loginService.searchPassword(loginVO);
		
		// 2. 결과 리턴
		if (result) {
			model.addAttribute("resultInfo", "임시 비밀번호를 발송하였습니다.");
			return "cmm/uat/uia/EgovIdPasswordResult";
		} else {
			model.addAttribute("resultInfo", tmsMessageSource.getMessage("fail.common.pwsearch"));
			return "cmm/uat/uia/EgovIdPasswordResult";
		}
	}
	
	/**
	 * 개발 시스템 구축 시 발급된 GPKI 서버용인증서에 대한 암호화데이터를 구한다.
	 * 최초 한번만 실행하여, 암호화데이터를 EgovGpkiVariables.js의 ServerCert에 넣는다.
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value="/uat/uia/getEncodingData.do")
	public void getEncodingData() 
			throws Exception {
		
		/*
		X509Certificate x509Cert = null;
		byte[] cert = null;
		String base64cert = null;
		try {
			x509Cert = Disk.readCert("/product/jeus/egovProps/gpkisecureweb/certs/SVR1311000011_env.cer");
			cert = x509Cert.getCert();
			Base64 base64 = new Base64();
			base64cert = base64.encode(cert); 
			log.info("+++ Base64로 변환된 인증서는 : " + base64cert);
			
		} catch (GpkiApiException e) {
			e.printStackTrace();
		}
		*/
	}
	
	/**
	 * 시/군 정보를 json형식으로 리턴해준다.
	 * @param 시/도 정보
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/pub/member/getAreaCtyCode.do")
	public ModelAndView getAreaCtyCode(
			@RequestParam("doCode") String doCode
	) throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		List<CmmnDetailCode> ctyCode = loginService.getAreaCtyCode(doCode);
		modelAndView.addObject("ctyCode", ctyCode);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 시/군 정보를 json형식으로 리턴해준다. (where deptCode)
	 * @param deptCode
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/pub/member/getAreaCtyCodeWhereDeptNo.do")
	public ModelAndView getAreaCtyCodeWhereDeptNo(
			@RequestParam("deptCode") String deptCode
	) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		List<CmmnDetailCode> ctyCode = loginService.getAreaCtyCodeWhereDeptNo(deptCode);
		modelAndView.addObject("ctyCode", ctyCode);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 부서 정보를 json형식으로 리턴해준다.
	 * @param upperDeptNo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/pub/member/getDeptCode.do")
	public ModelAndView getDeptCode(
			@RequestParam("upperDeptNo") String upperDeptNo
		) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		List<DeptVO> deptCode = loginService.getDeptCode(upperDeptNo);
		modelAndView.addObject("deptCode", deptCode);
		modelAndView.setViewName("jsonView");
		return modelAndView;
		
	}
	
	/**
	 * 아이디 중복체크
	 * @param request
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/pub/member/checkID.do")
	public String checkID(
			HttpServletRequest request,
			Map<String, Object> commandMap,
			ModelMap model
		) throws Exception {
		
		log.debug("\n\ncheckID\n\n");
		
		String checkID = (String)commandMap.get("checkID");
		
		int cnt = loginService.checkID(checkID);
		model.addAttribute("cnt", cnt);
		
		return "pub/member/checkID";
	}
	
	/**
	 * 아이디 중복체크 (json)
	 * @param request
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/pub/member/checkIDJSON.do")
	public ModelAndView checkIDJSON(
			HttpServletRequest request,
			Map<String, Object> commandMap,
			ModelMap model
		) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		String checkID = (String)commandMap.get("checkID");
		int cnt = loginService.checkID(checkID);
		modelAndView.addObject("checkID", cnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}

	
	/**
	 * 계정신청 완료화면
	 * @param request
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/pub/member/register.do")
	public String memberRegisterProcess(
			@ModelAttribute("memberVO") MemberVO memberVO,
			BindingResult bindingResult,
			HttpServletRequest request,
			Map<String, Object> commandMap,
			ModelMap model
		) throws Exception {
		
		String returnValue = "pub/member/memberRegisterOK";
		boolean isPass = true;
		
		String mode = (String)commandMap.get("mode");
		if (mode == null) mode = "";
		
		if (null != memberVO.getPassword() && null != memberVO.getPassword_confirm()) {
			if (!memberVO.getPassword().equals(memberVO.getPassword_confirm())) {
				// 패스워드가 다릅니다.
				returnValue = "pub/member/memberRegister";
				isPass = false;
				model.addAttribute("passwordMsg", "패스워드가 다릅니다.");
			}
		}
		
		// ID 중복체크
		if (null != memberVO.getMemberId()) {
			int cnt = loginService.checkID(memberVO.getMemberId());
			if (cnt > 0) {
				// 아이디가 중복됩니다.
				returnValue = "pub/member/memberRegister";
				model.addAttribute("idMsg", "아이디가 중복됩니다.");
				isPass = false;
			}
		}
		
		// 시/도, 시/군 정보를 가져온다.
		List<CmmnDetailCode> areaDoCode = loginService.getAreaDoCode();
		//List<Map<String,String>> areaCtyCode = loginService.getAreaCtyCode();
		List<CmmnDetailCode> areaCtyCodeAll = loginService.getAreaCtyCodeAll();
		
		// 수계, 공구 정보를 가져온다.
		List<CmmnDetailCode> factInfoCode = loginService.getFactInfoCode();
		
		// 관련기관 정보를 가져온다.
		List<CmmnDetailCode> organCode = loginService.getOrganCode();
		
		// 부서정보를 가져온다.
		List<DeptVO> deptCode = loginService.getDeptCode("0");
		
		// 담당 수계 정보를 가져온다.
		List<CmmnDetailCode> riverIdCode = loginService.getRiverIdCode();
		
		// 그룹정보를 가져온다.
		List<CmmnDetailCode> groupCode = loginService.getGroupCode();
		
		model.addAttribute("areaDoCode", areaDoCode);
		model.addAttribute("areaCtyCodeAll", areaCtyCodeAll);
		model.addAttribute("organCode", organCode);
		model.addAttribute("factInfoCode", factInfoCode);
		model.addAttribute("deptCode", deptCode);
		model.addAttribute("riverIdCode", riverIdCode);
		model.addAttribute("groupCode", groupCode);
		
		if (mode.equals("register")) {
			
			// controller를 한번 실행했다는 flag값
			model.addAttribute("process", "process");
			
			beanValidator.validate(memberVO, bindingResult);
			if (bindingResult.hasErrors()) {
				
				return "pub/member/memberRegister";
				
			} else {
			
				if (isPass) {
					String connectIp = ClntInfo.getClntIP(request);
					memberVO.setConnectIp(connectIp);
					
					if (null == memberVO.getDeptNo() || "".equals(memberVO.getDeptNo())) {
						memberVO.setDeptNo(memberVO.getDeptNoTmp());
					}
					
//					memberVO.setIhidNum(memberVO.getIhidNum()+memberVO.getIhidNum1());
					memberVO.setEmail(memberVO.getEmail()+"@"+memberVO.getEmail1());
					memberVO.setOfficeNo(memberVO.getOfficeNo()+"-"+memberVO.getOfficeNo1()+"-"+memberVO.getOfficeNo2());
					memberVO.setMobileNo(memberVO.getMobileNo()+"-"+memberVO.getMobileNo1()+"-"+memberVO.getMobileNo2());
					memberVO.setFaxNum(memberVO.getFaxNum()+"-"+memberVO.getFaxNum1()+"-"+memberVO.getFaxNum2());
					
					loginService.actionRegister(memberVO);
				}
			}
		} else {
			returnValue = "pub/member/memberRegister";
		}
		
		return returnValue;
	}
	
	/**
	 * ID찾기
	 * @param upperDeptNo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/common/login/getApprovalIdCheck.do")
	public ModelAndView getApprovalIdCheck(
		  @RequestParam(value="uId", required=false) String uId
		) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		String approvalFlag = loginService.getAccountFindId(uId);
		if(approvalFlag == null) approvalFlag = "X"; // 아이디가 없는 경우
		modelAndView.addObject("approvalFlag", approvalFlag);
		modelAndView.setViewName("jsonView");
		return modelAndView;
		
	}
	
//	/**
//	 * 유저의 비밀번호를 변경한다.
//	 * @param loginVO
//	 * @param memberVO
//	 * @param bindingResult
//	 * @param commandMap
//	 * @param model
//	 * @return "/admin/member/MemberModify"
//	 * @throws Exception
//	 */
//	@RequestMapping(value="/common/membermemberPassChange.do")
//	public String updatePasswordChange (@ModelAttribute("loginVO") LoginVO loginVO
//			, @ModelAttribute("memberVO") MemberVO memberVO
//			, BindingResult bindingResult
//			, Map commandMap
//			, ModelMap model
//			) throws Exception {
//		
//		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
//		memberVO.setMemberId(user.getId());
//		
//		String mode = (String)commandMap.get("mode");
//		if (mode == null) mode = "";
//		
//		if (mode.equals("")) {
//			
//			MemberVO vo = memberService.selectMemberDetail(memberVO);
//			
//			if (vo.getMobileNo() != null && !"".equals(vo.getMobileNo()) && vo.getMobileNo().split("-").length == 3) {
//				String mobile = vo.getMobileNo().split("-")[0];
//				String mobile1 = vo.getMobileNo().split("-")[1];
//				String mobile2 = vo.getMobileNo().split("-")[2];
//				
//				vo.setMobileNo(mobile);
//				vo.setMobileNo1(mobile1);
//				vo.setMobileNo2(mobile2);
//			}
//			
//			if (vo.getFaxNum() != null && !"".equals(vo.getFaxNum()) && vo.getFaxNum().split("-").length == 3) {
//				String fax = vo.getFaxNum().split("-")[0];
//				String fax1 = vo.getFaxNum().split("-")[1];
//				String fax2 = vo.getFaxNum().split("-")[2];
//				vo.setFaxNum(fax);
//				vo.setFaxNum1(fax1);
//				vo.setFaxNum2(fax2);
//			}
//			
//			if (vo.getOfficeNo() != null && !"".equals(vo.getOfficeNo()) && vo.getOfficeNo().split("-").length == 3) {
//				String office = vo.getOfficeNo().split("-")[0];
//				String office1 = vo.getOfficeNo().split("-")[1];
//				String office2 = vo.getOfficeNo().split("-")[2];
//				
//				vo.setOfficeNo(office);
//				vo.setOfficeNo1(office1);
//				vo.setOfficeNo2(office2);
//			}
//			
//			if (vo.getEmail() != null && !"".equals(vo.getEmail())) {
//				String email = vo.getEmail().split("@")[0];
//				String email1 = "";
//				if (vo.getEmail().split("@").length > 1) {
//					email1 = vo.getEmail().split("@")[1];
//				}
//				vo.setEmail(email);
//				vo.setEmail1(email1);
//				vo.setEmail2("");
//			}
//			
//			model.addAttribute("memberVO", vo);
//
//			return "/admin/member/InfoModify";
//			
//		} else if (mode.equals("Modify")) {
//			
//			memberVO.setEmail(memberVO.getEmail()+"@"+memberVO.getEmail1());
//			memberVO.setOfficeNo(memberVO.getOfficeNo()+"-"+memberVO.getOfficeNo1()+"-"+memberVO.getOfficeNo2());
//			memberVO.setMobileNo(memberVO.getMobileNo()+"-"+memberVO.getMobileNo1()+"-"+memberVO.getMobileNo2());
//			memberVO.setFaxNum(memberVO.getFaxNum()+"-"+memberVO.getFaxNum1()+"-"+memberVO.getFaxNum2());
//			
//			// 비밀번호를 변경할지 체크
//			String passwordChange = (String)commandMap.get("passwordChange");
//			if (passwordChange == null) passwordChange = "";
//			
//			log.debug("passwordChange : "+passwordChange);
//			if ("change".equals(passwordChange)) {
//				memberService.changePassword(memberVO);
//			}
//			
//			memberService.updateInfo(memberVO);
//			
//			return "/admin/member/SaveDone";
//			
//		} else {
//			return "forward:/admin/member/InfoModify.do";
//		}
//	}	
}

