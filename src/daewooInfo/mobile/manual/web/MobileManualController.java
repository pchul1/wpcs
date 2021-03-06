package daewooInfo.mobile.manual.web;

import java.io.File;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import daewooInfo.mobile.com.utl.ObjectUtil;

/**
* <pre>
* 1. 패키지명 : daewooInfo.mobile.manual.web
* 2. 타입명 : MobileManualController.java
* 3. 작성일 : 2014. 9. 12. 오후 5:43:50
* 4. 작성자 : kys
* 5. 설명 : 모바일 메뉴얼
* </pre>
*/
@Controller
public class MobileManualController {

	/**
	* <pre>
	* 1. 메소드명 : manual
	* 2. 작성일 : 2014. 9. 12. 오후 5:43:57
	* 3. 작성자 : kys
	* 4. 설명 : 모바일 메뉴얼 메인
	* </pre>
	*/
	@RequestMapping("/mobile/sub/manual/manual.do")
	public String manual(ModelMap model) throws Exception {
		return "/mobile/sub/manual/manual";
	}
	

	/**
	* <pre>
	* 1. 메소드명 : manual_view
	* 2. 작성일 : 2014. 9. 12. 오후 5:44:03
	* 3. 작성자 : kys
	* 4. 설명 : 모바일 메뉴얼
	* </pre>
	*/
	@RequestMapping("/mobile/sub/manual/manual_view.do")
	public String manual_view(ModelMap model, HttpServletRequest request , HttpServletResponse response ) throws Exception {
		String name = (null == request.getParameter("name") || request.getParameter("name").length() < 1) ? "1" : request.getParameter("name");
		//숫자인지 문자인지 여부 체크
		if(!ObjectUtil.isNumber(name)) name="1";
		
		int img_number = Integer.parseInt(name);
		 
		model.addAttribute("prev", (ObjectUtil.fileexist(request, "p" + String.format("%03d", img_number-1) + ".png")) ? img_number-1 : 0);
		model.addAttribute("curr",  String.format("%03d", img_number) + ".png");
		model.addAttribute("next", (ObjectUtil.fileexist(request, "p" + String.format("%03d", img_number+1) + ".png")) ? img_number+1 : 9999);
		
		return "/mobile/sub/manual/manual_view";
	}
	
	/**
	* <pre>
	* 1. 메소드명 : manual
	* 2. 작성일 : 2014. 9. 12. 오후 5:43:57
	* 3. 작성자 : kys
	* 4. 설명 : 모바일 메뉴얼 메인
	* </pre>
	*/
	@RequestMapping("/mobile/sub/manual/solution.do")
	public String solution(ModelMap model) throws Exception {
		return "/mobile/sub/manual/solution";
	}
}