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
import daewooInfo.admin.cmmncode.service.CmmnDetailCodeManageService;
import daewooInfo.cmmn.bean.CmmnDetailCode;
import daewooInfo.cmmn.bean.CmmnDetailCodeVO;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.itemmanage.bean.ItemGroupVO;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 
 * 공통상세코드에 관한 요청을 받아 서비스 클래스로 요청을 전달하고 서비스클래스에서 처리한 결과를 웹 화면으로 전달을 위한 Controller를 정의한다
 * @author kisspa
 * @since 2010.06.18
 * @version 1.0
 * @see
 *
 * <pre>
 * 
 * 수정일	 		수정자			수정내용
 * -------		--------	---------------------------
 * 2010.06.18	kisspa		최초 생성
 *
 * </pre>
 */
@Controller
public class CmmnDetailCodeManageController {
	
	/**
	 * @uml.property  name="cmmnDetailCodeManageService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "CmmnDetailCodeManageService")
	private CmmnDetailCodeManageService cmmnDetailCodeManageService;
	
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
	 * 공통상세코드 상세항목을 조회한다.
	 * @param loginVO
	 * @param cmmnDetailCode
	 * @param model
	 * @return "cmm/sym/ccm/CmmnDetailCodeDetail"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/cmmncode/CmmnDetailCodeDetail.do")
	public String selectCmmnDetailCodeDetail (
			  @ModelAttribute("loginVO") LoginVO loginVO
			, CmmnDetailCode cmmnDetailCode
			, ModelMap model
			) throws Exception {
		List vo = cmmnDetailCodeManageService.selectCmmnDetailCodeDetail(cmmnDetailCode);
		model.addAttribute("result", vo);
		
		return "/admin/cmmncode/CmmnDetailCodeDetail";
	}
	
	/**
	 * 공통상세코드 상세항목을 조회한다.
	 * @param loginVO
	 * @param cmmnDetailCode
	 * @param model
	 * @return "/admin/cmmncode/CmmnDetailCodeDetail"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/cmmncode/detailCmnCode.do")
	public ModelAndView detailCmnCode (
			  @ModelAttribute("loginVO") LoginVO loginVO
			, CmmnDetailCode cmmnDetailCode
			, ModelMap model
			) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		
		List list = cmmnDetailCodeManageService.selectCmmnDetailCodeDetail(cmmnDetailCode);
		
		modelAndView.addObject("cmmnDetailCode", cmmnDetailCode);
		modelAndView.addObject("resultList", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 공통상세코드 호출
	 * 
	 * @return "/admin/cmmncode/CmmnDetailCodeList"
	 * @exception Exception
	 */
	@RequestMapping(value = "/admin/cmmncode/CmmnDetailCodeList.do")
	public String selectCmmnDetailCodeList(ModelMap model) throws Exception {
		return "/admin/cmmncode/CmmnDetailCodeList";
	}
	
	/**
	 * 공통상세코드 목록을 조회한다.
	 * @param loginVO
	 * @param searchVO
	 * @param model
	 * @return "/admin/cmmncode/getCmmnDetailCodeList"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/cmmncode/getCmmnDetailCodeList.do")
	public ModelAndView getCmmnDetailCodeList (
			  @ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") CmmnDetailCodeVO searchVO
//			, ModelMap model
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		List CmmnCodeList = cmmnDetailCodeManageService.selectCmmnDetailCodeList(searchVO);
		int totCnt = cmmnDetailCodeManageService.selectCmmnDetailCodeListTotCnt(searchVO);
		
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("CmmnDetailCodeVO", searchVO);
		modelAndView.addObject("resultList", CmmnCodeList);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 공통상세코드를 삭제한다.
	 * @param loginVO
	 * @param cmmnDetailCode
	 * @param model
	 * @return "forward:/admin/cmmncode/CmmnDetailCodeList.do"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/cmmncode/CmmnDetailCodeRemove.do")
	public String deleteCmmnDetailCode (@ModelAttribute("loginVO") LoginVO loginVO
			, CmmnDetailCode cmmnDetailCode
			, ModelMap model
			) throws Exception {
		cmmnDetailCodeManageService.deleteCmmnDetailCode(cmmnDetailCode);
		return "forward:/admin/cmmncode/CmmnDetailCodeList.do";
	}
	
	/**
	 * 공통상세코드를 등록한다.
	 * @param loginVO
	 * @param cmmnDetailCode
	 * @param cmmnCode
	 * @param bindingResult
	 * @param model
	 * @return "/admin/cmmncode/CmmnDetailCodeList"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/cmmncode/getCmnCodeReg.do")
	public ModelAndView getCmnCodeReg (
			  @ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("cmmnDetailCode") CmmnDetailCode cmmnDetailCode
			, @ModelAttribute("cmmnCode") CmmnCode cmmnCode
			) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		
		CmmnCodeVO searchCodeVO;
		searchCodeVO = new CmmnCodeVO();
		searchCodeVO.setRecordCountPerPage(999999);
		searchCodeVO.setFirstIndex(0);
		searchCodeVO.setSearchCondition("clCode");
		
		List CmnCodeList = cmmnCodeManageService.selectCmmnCodeList(searchCodeVO);
		
		modelAndView.addObject("searchCodeVO", searchCodeVO);
		modelAndView.addObject("cmnCodeList", CmnCodeList);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 공통상세코드를 등록한다.
	 * @param loginVO
	 * @param cmmnDetailCode
	 * @param cmmnCode
	 * @param bindingResult
	 * @param model
	 * @return "/admin/cmmncode/CmmnDetailCodeRegist"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/cmmncode/CmmnDetailCodeRegist.do")
	public String insertCmmnDetailCode (
			  @ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("cmmnDetailCode") CmmnDetailCode cmmnDetailCode
			, @ModelAttribute("cmmnCode") CmmnCode cmmnCode
			, BindingResult bindingResult
			, Map commandMap
			, ModelMap model
			) throws Exception {
		
		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
		if (cmmnDetailCode.getCodeId() == null
				||cmmnDetailCode.getCodeId().equals("")
				||cmmnDetailCode.getCode() == null
				||cmmnDetailCode.getCode().equals("")
				||sCmd.equals("")) {
				
				CmmnCodeVO searchCodeVO;
				searchCodeVO = new CmmnCodeVO();
				searchCodeVO.setRecordCountPerPage(999999);
				searchCodeVO.setFirstIndex(0);
				searchCodeVO.setSearchCondition("clCode");
				
				List CmmnCodeList = cmmnCodeManageService.selectCmmnCodeList(searchCodeVO);
				model.addAttribute("cmmnCodeList", CmmnCodeList);
				
				return "/admin/cmmncode/CmmnDetailCodeRegist";
		} else if (sCmd.equals("Regist")) {
			
			beanValidator.validate(cmmnDetailCode, bindingResult);
			if (bindingResult.hasErrors()){
				
				CmmnCodeVO searchCodeVO;
				searchCodeVO = new CmmnCodeVO();
				searchCodeVO.setRecordCountPerPage(999999);
				searchCodeVO.setFirstIndex(0);
				
				List CmmnCodeList = cmmnCodeManageService.selectCmmnCodeList(searchCodeVO);
				model.addAttribute("cmmnCodeList", CmmnCodeList);
				
				return "/admin/cmmncode/CmmnDetailCodeRegist";
			}
			
			cmmnDetailCode.setRegId(loginVO.getUniqId());
			cmmnDetailCodeManageService.insertCmmnDetailCode(cmmnDetailCode);
			return "forward:/admin/cmmncode/CmmnDetailCodeList.do";
		} else {
			return "forward:/admin/cmmncode/CmmnDetailCodeList.do";
		}
	}
	
	/**
	 * 공통상세코드를 수정한다.
	 * @param loginVO
	 * @param cmmnDetailCode
	 * @param bindingResult
	 * @param commandMap
	 * @param model
	 * @return "/admin/cmmncode/CmmnDetailCodeModify"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/cmmncode/CmmnDetailCodeModify.do")
	public String updateCmmnDetailCode (
			  @ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("cmmnDetailCode") CmmnDetailCode cmmnDetailCode
			, BindingResult bindingResult
			, Map commandMap
			, ModelMap model
			) throws Exception {
		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
		if (sCmd.equals("")) {
			List vo = cmmnDetailCodeManageService.selectCmmnDetailCodeDetail(cmmnDetailCode);
			model.addAttribute("cmmnDetailCode", vo);
			
			return "/admin/cmmncode/CmmnDetailCodeModify";
		} else if (sCmd.equals("Mod")) {
			beanValidator.validate(cmmnDetailCode, bindingResult);
			if (bindingResult.hasErrors()){
				List vo = cmmnDetailCodeManageService.selectCmmnDetailCodeDetail(cmmnDetailCode);
				model.addAttribute("cmmnDetailCode", vo);
				
				return "/admin/cmmncode/CmmnDetailCodeModify";
			}
			
			cmmnDetailCode.setModId(loginVO.getUniqId());
			cmmnDetailCodeManageService.updateCmmnDetailCode(cmmnDetailCode);
			return "forward:/admin/cmmncode/CmmnDetailCodeList.do";
		} else {
			return "forward:/admin/cmmncode/CmmnDetailCodeList.do";
		}
	}
	
	/**
	 * 공통상세코드를 등록 및 수정
	 * @param loginVO
	 * @param cmmnDetailCode
	 * @param cmmnCode
	 * @param bindingResult
	 * @param model
	 * @return "/admin/cmmncode/getCmmnDetailCodeList"
	 * @throws Exception
	 */
	@RequestMapping(value="/admin/cmmncode/updCmnCode.do")
	public ModelAndView updCmnCode (
		  @ModelAttribute("loginVO") LoginVO loginVO
		, @ModelAttribute("cmmnDetailCode") CmmnDetailCode cmmnDetailCode
//		, @ModelAttribute("cmmnCode") CmmnCode cmmnCode
		, BindingResult bindingResult
		, Map commandMap
		, ModelMap model
		, HttpServletRequest req
		, HttpServletResponse res
		) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		String sCmd = commandMap.get("cmd") == null ? "" : (String)commandMap.get("cmd");
	//	System.out.println("sCmd============ : " + sCmd);
		if (cmmnDetailCode.getCodeId() == null
				||cmmnDetailCode.getCodeId().equals("")
				||cmmnDetailCode.getCode() == null
				||cmmnDetailCode.getCode().equals("")
				||sCmd.equals("")) {
			modelAndView.addObject("cmmnDetailCode", cmmnDetailCode);
			modelAndView.addObject("updateCnt", 0);
			modelAndView.setViewName("jsonView");
			
			return modelAndView;
		} else {
			beanValidator.validate(cmmnDetailCode, bindingResult);
			if (bindingResult.hasErrors()){
				modelAndView.addObject("resultList", cmmnDetailCode);
				modelAndView.addObject("updateCnt", 0);
				modelAndView.setViewName("jsonView");
				
				return modelAndView;
			}
			cmmnDetailCode.setRegId(loginVO.getUniqId());
			cmmnDetailCode.setModId(loginVO.getUniqId());
			
			int updateCnt = 0;
			
			if ("Mod".equals(sCmd)){
				updateCnt = cmmnDetailCodeManageService.updateCmmnDetailCode(cmmnDetailCode);
			} else {
				int duplicateCnt = cmmnDetailCodeManageService.dupCmnCode(cmmnDetailCode);
				
				if (duplicateCnt > 0) {
	//				res.setContentType("text/html; charset=UTF-8");
	//				res.getWriter().print("<script>alert('코드가 중복 됩니다. 다른 코드를 사용하세요.');self.close();</script>");
	//				
					modelAndView.addObject("resultList", cmmnDetailCode);
					modelAndView.addObject("duplicateCnt", duplicateCnt);
					modelAndView.setViewName("jsonView");
					
					return modelAndView;
				} else {
					updateCnt = cmmnDetailCodeManageService.updateCmmnDetailCode(cmmnDetailCode);
				}
			}
			
			modelAndView.addObject("cmmnDetailCode", cmmnDetailCode);
			modelAndView.addObject("updateCnt", updateCnt);
			modelAndView.setViewName("jsonView");
			
			return modelAndView;
		}
	}
}