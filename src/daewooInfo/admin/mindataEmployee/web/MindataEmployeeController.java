package daewooInfo.admin.mindataEmployee.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import daewooInfo.admin.mindataEmployee.bean.MindataEmployeeVO;
import daewooInfo.admin.mindataEmployee.service.MindataEmployeeService;
import daewooInfo.mobile.com.utl.ObjectUtil;

@Controller
public class MindataEmployeeController {
	
	/**
	 * 원터치 담당자 service 
	 */
	@Resource(name="MindataEmployeeService")
	MindataEmployeeService mindataEmployeeService;

	/**
	 * 
	 * 데이터 선별자 LIST
	 * 
	 * @param mindataEmployeeVO
	 * @param request
	 * @param model
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/mindataEmployee/MindataEmployee.do")
	public String selectMindataEmployeeList(@ModelAttribute("mindataEmployeeVO") MindataEmployeeVO mindataEmployeeVO , HttpServletRequest request , ModelMap model) throws Exception {
		mindataEmployeeVO.setGubun("S");
		model.addAttribute("List", mindataEmployeeService.selectMindataEmployeeList(mindataEmployeeVO));
		model.addAttribute("param_s", mindataEmployeeVO);
		return "/admin/mindataEmployee/MindataEmployee";
	}
	


	/**
	 * 
	 * 데이터 확정자 LIST
	 * 
	 * @param mindataEmployeeVO
	 * @param request
	 * @param model
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/mindataEmployee/MindataDecideEmployee.do")
	public String selectMindataDecideEmployeeList(@ModelAttribute("mindataEmployeeVO") MindataEmployeeVO mindataEmployeeVO , HttpServletRequest request , ModelMap model) throws Exception {
		mindataEmployeeVO.setGubun("E");
		model.addAttribute("List", mindataEmployeeService.selectMindataEmployeeList(mindataEmployeeVO));
		model.addAttribute("param_s", mindataEmployeeVO);
		return "/admin/mindataEmployee/MindataDecideEmployee";
	}
	

	/**
	 * 
	 * 데이터 선별자 /확정자 등록
	 * 
	 * @param mindataEmployeeVO
	 * @param request
	 * @param model
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/mindataEmployee/MindataEmployeeRegist.do")
	public String MindataEmployeeRegist(@ModelAttribute("mindataEmployeeVO") MindataEmployeeVO mindataEmployeeVO , HttpServletRequest request , HttpServletResponse response, ModelMap model) throws Exception {
		mindataEmployeeService.insertMindataEmployee(mindataEmployeeVO);
		
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print("<script>alert('성공적으로 등록되었습니다.');document.location.replace('" + mindataEmployeeVO.getReturn_url() + "');</script>");
		
		return null;
	}
	

	/**
	 * 
	 * 데이터 선별자 /확정자 삭제
	 * 
	 * @param mindataEmployeeVO
	 * @param request
	 * @param model
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/mindataEmployee/MindataEmployeeDelete.do")
	public String MindataEmployeeDelete(@ModelAttribute("mindataEmployeeVO") MindataEmployeeVO mindataEmployeeVO , HttpServletRequest request , HttpServletResponse response, ModelMap model) throws Exception {
		mindataEmployeeService.deleteMindataEmployee(mindataEmployeeVO, request);

		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print("<script>alert('성공적으로 삭제되었습니다.');document.location.replace('" + mindataEmployeeVO.getReturn_url() + "');</script>");
		
		return null;
	}
	

	/**
	 * 
	 * 데이터 선별자  알림 날짜
	 * 
	 * @param mindataEmployeeVO
	 * @param request
	 * @param model
	 * @return 
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/mindataEmployee/MindataDefiniteDate.do")
	public String MindataDefiniteDate(@ModelAttribute("mindataEmployeeVO") MindataEmployeeVO mindataEmployeeVO , HttpServletRequest request , HttpServletResponse response, ModelMap model) throws Exception {
		mindataEmployeeService.updateMindataDefiniteDate(mindataEmployeeVO, request);
		  
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print("<script>alert('성공적으로 일자가 변경되었습니다.');document.location.replace('" + mindataEmployeeVO.getReturn_url() + "');</script>");
		
		return null;
	}
}