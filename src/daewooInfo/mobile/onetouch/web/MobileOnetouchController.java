package daewooInfo.mobile.onetouch.web;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.mobile.com.utl.FileScrty;
import daewooInfo.mobile.com.utl.LogInfoUtil;
import daewooInfo.mobile.onetouch.service.MobileOnetouchService;
import daewooInfo.waterpollution.bean.WaterPollutionStepVO;
import daewooInfo.waterpollution.bean.WaterPollutionVO;
import daewooInfo.waterpollution.service.WaterPollutionService;

/**
* <pre>
* 1. 패키지명 : daewooInfo.mobile.manual.web
* 2. 타입명 : MobileOnetouchController.java
* 3. 작성일 : 2014. 9. 12. 오후 5:43:50
* 4. 작성자 : kys
* 5. 설명 : 모바일 원터치 클래스
* </pre>
*/
@Controller
public class MobileOnetouchController {

	@Resource(name="MobileOnetouchService")
	private MobileOnetouchService mobileOnetouchService;
	
	/**
	* <pre>
	* 1. 메소드명 : firststep
	* 2. 작성일 : 2014. 9. 12. 오후 5:43:57
	* 3. 작성자 : kys
	* 4. 설명 : 모바일 원터치 신고 개인정보 동의
	* </pre>
	*/
	@RequestMapping("/mobile/onetouch/firststep.do")
	public String firststep(ModelMap model, HttpServletRequest request) throws Exception {
		LoginVO login;
		try {
			login = LogInfoUtil.GetSessionLogin();
		} catch (Exception e) {
			login = null;
		}
	
		model.addAttribute("Login",  login);
		return "/mobile/onetouch/firststep";
	}
	
	/**
	* <pre>
	* 1. 메소드명 : firststep
	* 2. 작성일 : 2014. 9. 12. 오후 5:43:57
	* 3. 작성자 : kys
	* 4. 설명 : 모바일 원터치 신고 개인정보 동의
	* </pre>
	*/
	@RequestMapping("/mobile/onetouch/OnetouchStatement.do")
	public String OnetouchStatement(@ModelAttribute("waterPollutionVO") WaterPollutionVO waterPollutionVO
			, final MultipartHttpServletRequest multiRequest 
			, ModelMap model
			, HttpServletRequest request
			,HttpServletResponse response ) throws Exception {
		
		mobileOnetouchService.InsertOnetouchStatement(waterPollutionVO, new WaterPollutionStepVO(), request, multiRequest);
		

		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print("<script>alert('사고가 신고되었습니다.');location.replace('/mobile/');</script>");
		
		return null;
	}

	/**
	* <pre>
	* 1. 메소드명 : maplocationaddress
	* 2. 작성일 : 2014. 9. 17. 오후 4:33:26
	* 3. 작성자 : kys
	* 4. 설명 : google 좌표->주소 변환 
	* </pre>
	*/
	@RequestMapping("/mobile/onetouch/maplocationaddress.do")
	public String maplocationaddress(ModelMap model, HttpServletRequest request ) throws Exception {
		URL url = null;
		String requestMsg = "";
		String line="";
		BufferedReader input = null;
		
		String url_str = "http://maps.googleapis.com/maps/api/geocode/json";
		url_str += "?latlng=" + request.getParameter("X") + "," + request.getParameter("Y") + "&sensor=false&language=ko-KR";
		
		if(null != request.getParameter("X")){
			try {
				// Request
				url = new URL(url_str);
				// Response
				input = new BufferedReader(new InputStreamReader(url.openStream(), "utf-8"));
				while((line=input.readLine()) != null){
					requestMsg += line;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		model.addAttribute("map_result",requestMsg.replaceAll("\\\"", "\""));
		return "jsonView";
	}
	

	@RequestMapping("/test1.do")
	public String test(ModelMap model, HttpServletRequest request) throws Exception {
		return "/test";
	}
}