package daewooInfo.mobile.main.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import daewooInfo.common.alrim.bean.AlrimVO;
import daewooInfo.common.alrim.service.AlrimService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.dailywork.service.DailyWorkService;
import daewooInfo.mobile.com.utl.FileScrty;
import daewooInfo.mobile.com.utl.LogInfoUtil;
import daewooInfo.mobile.com.utl.ObjectUtil;


/**
* <pre>
* 1. 패키지명 : daewooInfo.mobile.main.web
* 2. 타입명 : MobileMainController.java
* 3. 작성일 : 2014. 9. 12. 오후 5:26:17
* 4. 작성자 : kys
* 5. 설명 : 메인 컨트롤러
* </pre>
*/
@Controller
public class MobileMainController {

	/**
	 * @uml.property  name="dailyWorkService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "DailyWorkService")
    private DailyWorkService dailyWorkService;
	
	@Resource(name = "alrimService")
	private AlrimService alrimService;
	
	
	@RequestMapping(value="/mobile/index")
	public String index(LoginVO loginVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		if(null != request.getParameter("userPhone")){
			String userPhone = FileScrty.decode(request.getParameter("userPhone"));
			userPhone = userPhone.replaceAll("\\+82", "0");
			userPhone = userPhone.substring(0, 3) + "-" + userPhone.substring(3, 7) + "-" + userPhone.substring(7, 11);
			model.addAttribute("userPhone",userPhone);
			
			//버전관리
			String NewApplication = "O";
			String Version = "1.1";
			
			request.getSession().setAttribute("version", request.getParameter("version"));
			
			if(null == request.getSession().getAttribute("version")){
				NewApplication = "X";
			}
			if(NewApplication.equals("O") && !Version.equals(request.getSession().getAttribute("version"))){
				NewApplication = "X";
			}
			
			model.addAttribute("NewApplication",NewApplication);
		}
		model.addAttribute("param_s", loginVO);
		return "mobile/index";
	}	
		
	/**
	* <pre>
	* 1. 메소드명 : LoginView
	* 2. 작성일 : 2014. 9. 12. 오후 5:26:24
	* 3. 작성자 : kys
	* 4. 설명 : 모바일 메인 화면
	* </pre>
	*/
	@RequestMapping(value="/mobile/main/main")
	public String LoginView(ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
		int dailyWorkAppCnt = dailyWorkService.getDailyWorkApprovalCnt(LogInfoUtil.GetSessionLogin().getId());
		String dailyWorkAppCheck = "N";
		
		if(dailyWorkAppCnt>0){
			dailyWorkAppCheck = "Y";
		}
		
		AlrimVO alrimVO =  new AlrimVO();
		alrimVO.setAlrimApprovalId(LogInfoUtil.GetSessionLogin().getId());
		
		model.addAttribute("SeminarAlrimList", alrimService.selectMobileSeminarAlrimList(alrimVO));
		model.addAttribute("dailyWorkAppCheck", dailyWorkAppCheck);
		return "mobile/main/main";
	}	
}