package daewooInfo.admin.cmmncode.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springmodules.validation.commons.DefaultBeanValidator;

import daewooInfo.admin.cmmncode.bean.CmmnCode;
import daewooInfo.admin.cmmncode.bean.CmmnCodeVO;
import daewooInfo.admin.cmmncode.service.CmmnCodeManageService;
import daewooInfo.cmmn.bean.CmmnDetailCode;
import daewooInfo.common.login.bean.LoginVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 
 * 공통코드에 관한 요청을 받아 서비스 클래스로 요청을 전달하고 서비스클래스에서 처리한 결과를 웹 화면으로 전달을 위한 Controller를 정의한다
 * @author kisspa
 * @since 2010.06.18
 * @version 1.0
 * @see
 *
 * <pre>
 * 
 * 수정일			수정자			수정내용
 * -------		--------	---------------------------
 * 2010.06.18	kisspa		최초 생성
 *
 * </pre>
 */
@Controller
public class CmmnCodeManageController {

	/**
	 * @uml.property  name="cmmnCodeManageService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "CmmnCodeManageService")
	private CmmnCodeManageService cmmnCodeManageService;

	/**
	 * EgovPropertyService
	 * @uml.property  name="propertiesService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;

	/**
	 * @uml.property  name="beanValidator"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Autowired
	private DefaultBeanValidator beanValidator;
	
	/**
	 * 공통코드를 삭제한다.
	 * @param loginVO
	 * @param cmmnCode
	 * @param model
	 * @return "forward:/admin/cmmncode/CcmCmmnCodeList.do"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/cmmncode/CmmnCodeRemove.do")
	public String deleteCmmnCode (@ModelAttribute("loginVO") LoginVO loginVO
			, CmmnCode cmmnCode
			, ModelMap model
			) throws Exception {
		cmmnCodeManageService.deleteCmmnCode(cmmnCode);
		return "forward:/admin/cmmncode/CmmnCodeList.do";
	}

	/**
	 * 공통코드를 등록한다.
	 * @param loginVO
	 * @param cmmnCode
	 * @param bindingResult
	 * @param model
	 * @return "/admin/cmmncode/CmmnCodeRegist"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/cmmncode/CmmnCodeRegist.do")
	public String insertCmmnCode (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("cmmnCode") CmmnCode cmmnCode
			, BindingResult bindingResult
			, ModelMap model
			) throws Exception {
		
		beanValidator.validate(cmmnCode, bindingResult);
		if (bindingResult.hasErrors()){
			
			return "/admin/cmmncode/CmmnCodeRegist";
		}
		
		cmmnCode.setRegId(loginVO.getUniqId());
		cmmnCodeManageService.insertCmmnCode(cmmnCode);
		return "forward:/admin/cmmncode/CmmnCodeList.do";
	}
	
	/**
	 * 공통상세코드 상세항목을 조회한다.
	 * @param loginVO
	 * @param cmmnDetailCode
	 * @param model
	 * @return "/admin/cmmncode/CmmnCodeList"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/cmmncode/CmmnCodeDetail.do")
	public ModelAndView CmmnCodeDetail (
			  @ModelAttribute("loginVO") LoginVO loginVO
			, CmmnCode cmmnCode
			, ModelMap model
			) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		
		List list = cmmnCodeManageService.selectCmmnCodeDetail(cmmnCode);
		
		modelAndView.addObject("resultList", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 *  공통코드 목록을 조회
	 * 
	 * @return "/admin/cmmncode/CmmnCodeList"
	 * @exception Exception
	 */
	@RequestMapping(value="/admin/cmmncode/CmmnCodeList.do")
	public String selectCmmnCodeList(ModelMap model) throws Exception {
		return "/admin/cmmncode/CmmnCodeList";
	}
	
	/**
	 * 공통코드 목록을 조회한다.
	 * @param loginVO
	 * @param searchVO
	 * @param model
	 * @return "/admin/cmmncode/CmmnCodeList"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/cmmncode/getCmmnCodeList.do")
	public ModelAndView getCmmnCodeList (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") CmmnCodeVO searchVO
			, ModelMap model
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		List CmmnCodeList =cmmnCodeManageService.selectCmmnCodeList(searchVO);
		model.addAttribute("resultList", CmmnCodeList);
		
		int totCnt =cmmnCodeManageService.selectCmmnCodeListTotCnt(searchVO);
		
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("CmmnDetailCodeVO", searchVO);
		modelAndView.addObject("resultList", CmmnCodeList);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 공통코드를 수정한다.
	 * @param loginVO
	 * @param cmmnCode
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/admin/cmmncode/CmmnCodeModify"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/cmmncode/CmmnCodeModify.do")
	public String updateCmmnCode (@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("cmmnCode") CmmnCode cmmnCode
			, BindingResult bindingResult
			, Map commandMap
			, ModelMap model
			) throws Exception {
		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
		if (sCmd.equals("")) {
			List vo =cmmnCodeManageService.selectCmmnCodeDetail(cmmnCode);
			model.addAttribute("cmmnCode", vo);
			
			return "/admin/cmmncode/CmmnCodeModify";
		} else if (sCmd.equals("Modify")) {
			beanValidator.validate(cmmnCode, bindingResult);
			if (bindingResult.hasErrors()){
				List vo =cmmnCodeManageService.selectCmmnCodeDetail(cmmnCode);
				model.addAttribute("cmmnCode", vo);
				
				return "/admin/cmmncode/CmmnCodeModify";
			}
			
			cmmnCode.setModId(loginVO.getUniqId());
			cmmnCodeManageService.updateCmmnCode(cmmnCode);
			return "forward:/admin/cmmncode/CmmnCodeList.do";
		} else {
			return "forward:/admin/cmmncode/CmmnCodeList.do";
		}
	}
	
	/**
	 * 공통상세코드를 등록 및 수정
	 * @param loginVO
	 * @param cmmnDetailCode
	 * @param cmmnCode
	 * @param bindingResult
	 * @param model
	 * @return "/admin/cmmncode/CmmnCodeList"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/cmmncode/updCmnCodeCat.do")
	public ModelAndView updCmnCode (
		  @ModelAttribute("loginVO") LoginVO loginVO
		, @ModelAttribute("cmmnCode") CmmnCode cmmnCode
		, BindingResult bindingResult
		, Map commandMap
		, ModelMap model
		, HttpServletRequest req
		, HttpServletResponse res
		) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
	//	System.out.println("sCmd============ : " + sCmd);
		if (cmmnCode.getCodeId() == null
				||cmmnCode.getCodeId().equals("")
				||sCmd.equals("")) {
			modelAndView.addObject("cmmnCode", cmmnCode);
			modelAndView.addObject("updateCnt", 0);
			modelAndView.setViewName("jsonView");
			
			return modelAndView;
		} else {
			beanValidator.validate(cmmnCode, bindingResult);
			if (bindingResult.hasErrors()){
				modelAndView.addObject("resultList", cmmnCode);
				modelAndView.addObject("updateCnt", 0);
				modelAndView.setViewName("jsonView");
				
				return modelAndView;
			}
			cmmnCode.setRegId(loginVO.getUniqId());
			cmmnCode.setModId(loginVO.getUniqId());
			
			int updateCnt = 0;
			
			if ("Mod".equals(sCmd)){
				updateCnt = cmmnCodeManageService.updateCmmnDetailCode(cmmnCode);
			} else {
				int duplicateCnt = cmmnCodeManageService.dupCmnCode(cmmnCode);
				
				if (duplicateCnt > 0) {
	//				res.setContentType("text/html; charset=UTF-8");
	//				res.getWriter().print("<script>alert('코드가 중복 됩니다. 다른 코드를 사용하세요.');self.close();</script>");
	//				
					modelAndView.addObject("resultList", cmmnCode);
					modelAndView.addObject("duplicateCnt", duplicateCnt);
					modelAndView.setViewName("jsonView");
					
					return modelAndView;
				} else {
					updateCnt = cmmnCodeManageService.updateCmmnDetailCode(cmmnCode);
				}
			}
			
			modelAndView.addObject("cmmnDetailCode", cmmnCode);
			modelAndView.addObject("updateCnt", updateCnt);
			modelAndView.setViewName("jsonView");
			
			return modelAndView;
		}
	}
	
	
}