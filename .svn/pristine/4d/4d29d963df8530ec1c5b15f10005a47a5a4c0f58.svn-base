package daewooInfo.admin.onetouch.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import daewooInfo.admin.onetouch.bean.EmpOnetouchSmsVO;
import daewooInfo.admin.onetouch.service.EmpOnetouchSmsService;

@Controller
public class EmpOnetouchSmsController {
	
	/**
	 * 원터치 담당자 service 
	 */
	@Resource(name="EmpOnetouchSmsService")
	EmpOnetouchSmsService empOnetouchSmsService;

	/**
	 * 
	 * 원터치SMS담당자 LIST
	 * 
	 * @param empOnetouchSmsVO
	 * @param request
	 * @param model
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/onetouch/OnetouchSmsEmployee.do")
	public String selectEmpOnetouchSmsList(@ModelAttribute("empOnetouchSmsVO") EmpOnetouchSmsVO empOnetouchSmsVO , HttpServletRequest request , ModelMap model) throws Exception {
		model.addAttribute("List", empOnetouchSmsService.selectEmpOnetouchSmsList(empOnetouchSmsVO));
		model.addAttribute("param_s", empOnetouchSmsVO);
		return "/admin/onetouch/OnetouchSmsEmployee";
	}
	

	/**
	 * 
	 * 원터치SMS담당자 등록
	 * 
	 * @param empOnetouchSmsVO
	 * @param request
	 * @param model
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/onetouch/OnetouchSmsRegist.do")
	public String OnetouchSmsRegist(@ModelAttribute("empOnetouchSmsVO") EmpOnetouchSmsVO empOnetouchSmsVO , HttpServletRequest request , HttpServletResponse response, ModelMap model) throws Exception {
		empOnetouchSmsService.insertEmpOnetouchSms(empOnetouchSmsVO);

		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print("<script>alert('성공적으로 등록되었습니다.');document.location.href='/admin/onetouch/OnetouchSmsEmployee.do'</script>");
		
		return null;
	}
	

	/**
	 * 
	 * 원터치SMS담당자 삭제
	 * 
	 * @param empOnetouchSmsVO
	 * @param request
	 * @param model
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/onetouch/OnetouchSmsDelete.do")
	public String OnetouchSmsDelete(@ModelAttribute("empOnetouchSmsVO") EmpOnetouchSmsVO empOnetouchSmsVO , HttpServletRequest request , HttpServletResponse response, ModelMap model) throws Exception {
		empOnetouchSmsService.deleteEmpOnetouchSms(empOnetouchSmsVO, request);

		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print("<script>alert('성공적으로 삭제되었습니다.');document.location.href='/admin/onetouch/OnetouchSmsEmployee.do'</script>");
		
		return null;
	}
}