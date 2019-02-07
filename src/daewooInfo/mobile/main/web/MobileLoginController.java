package daewooInfo.mobile.main.web;

import javax.annotation.Resource;
import javax.crypto.Cipher;
import javax.crypto.KeyGenerator;
import javax.crypto.SecretKey;
import javax.crypto.spec.SecretKeySpec;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.binary.Hex;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.support.SessionStatus;

import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.login.service.LoginService;
import daewooInfo.common.util.sim.ClntInfo;
import daewooInfo.mobile.com.utl.FileScrty;

/**
* <pre>
* 1. 패키지명 : daewooInfo.mobile.main.web
* 2. 타입명 : MobileLoginController.java
* 3. 작성일 : 2014. 9. 12. 오후 5:26:41
* 4. 작성자 : kys
* 5. 설명 : 로그인 컨트롤러
* </pre>
*/
@Controller 
public class MobileLoginController {
	
	@Resource(name="loginService")
	private LoginService loginService;
	
	/**
	* <pre>
	* 1. 메소드명 : LoginView
	* 2. 작성일 : 2014. 9. 12. 오후 5:26:52
	* 3. 작성자 : kys
	* 4. 설명 : 로그인 화면
	* </pre>
	*/
	@RequestMapping(value="/mobile/login")
	public String LoginView(LoginVO loginVO, ModelMap model, HttpServletRequest request) throws Exception {
		String userPhone = request.getParameter("userPhone");
		if(null != userPhone){
			request.getSession().setAttribute("userPhone", FileScrty.decode(userPhone));
		}
		model.addAttribute("param_s", loginVO);
		return "mobile/login";
	}

	/**
	* <pre>
	* 1. 메소드명 : selectActionLogin
	* 2. 작성일 : 2014. 9. 12. 오후 5:27:00
	* 3. 작성자 : kys
	* 4. 설명 : 로그인 처리 화면
	* </pre>
	*/
	@RequestMapping(value="/mobile/loginAction")
	public String selectActionLogin(LoginVO loginVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		 
		// 접속IP
		String userIp = ClntInfo.getClntIP(request);
		loginVO.setIp(userIp);
		
		// 1. 일반 로그인 처리
		LoginVO resultVO = loginService.actionLogin(loginVO);
				
		if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("") ) {
			// 2. spring security 연동
			String return_str = "redirect:/j_spring_security_check.do?j_username=" + resultVO.getId() + "&j_password=" + resultVO.getUniqId() + "&spring-security-redirect=/mobile/main/main.do";
			if(request.getRequestURL().indexOf("waterkorea.or.kr") >= 0)
			{
				return_str = "redirect:/j_spring_security_check.do?j_username=" + resultVO.getId() + "&j_password=" + resultVO.getUniqId() + "&spring-security-redirect=http://www.waterkorea.or.kr/mobile/main/main.do";
			}
			return return_str;
		} else {
			String param = "fail.common.login";
			return "redirect:/mobile/alert.do?message="+param;
		}
	}
	

	/**
	* <pre>
	* 1. 메소드명 : actionLogout
	* 2. 작성일 : 2014. 9. 12. 오후 3:44:58
	* 3. 작성자 : kys
	* 4. 설명 : 로그아웃
	* </pre>
	*/
	@RequestMapping(value="/mobile/actionLogout")
	public String actionLogout(HttpServletRequest request, ModelMap model,SessionStatus status) 
			throws Exception {
		//세션을 비운다.
		request.getSession().setAttribute("SPRING_SECURITY_CONTEXT", null);
		request.getSession().setAttribute("SPRING_SECURITY_LAST_USERNAME", null);
	   
		return "redirect:/mobile";
	}
}