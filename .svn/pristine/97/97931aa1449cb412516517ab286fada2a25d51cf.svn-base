package daewooInfo.cmmn.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.cmmn.service.EgovFileMngService;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;

/**
 * 파일 조회, 삭제, 다운로드 처리를 위한 컨트롤러 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일	  수정자		   수정내용
 *  -------	--------	---------------------------
 *   2009.3.25  이삼섭		  최초 생성
 *
 * </pre>
 */
@Controller
public class EgovFileMngController {

	/**
	 * @uml.property  name="fileService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileService;

	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Logger log = Logger.getLogger(this.getClass());

	/**
	 * 첨부파일에 대한 목록을 조회한다.
	 * 
	 * @param fileVO
	 * @param atchFileId
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmmn/selectFileInfs.do")
	public String selectFileInfs(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap, ModelMap model) throws Exception {
	String atchFileId = (String)commandMap.get("param_atchFileId");

	fileVO.setAtchFileId(atchFileId);
	 
	List<FileVO> result = fileService.selectFileInfs(fileVO);

	model.addAttribute("fileList", result);
	model.addAttribute("updateFlag", "N");
	model.addAttribute("fileListCnt", result.size());
	model.addAttribute("atchFileId", atchFileId);
	
	return "cmmn/EgovFileList";
	}

	/**
	 * 첨부파일 변경을 위한 수정페이지로 이동한다.
	 * 
	 * @param fileVO
	 * @param atchFileId
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmmn/selectFileInfsForUpdate.do")
	public String selectFileInfsForUpdate(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap,
		//SessionVO sessionVO,
		ModelMap model) throws Exception {

	String atchFileId = (String)commandMap.get("param_atchFileId");

	fileVO.setAtchFileId(atchFileId);

	List<FileVO> result = fileService.selectFileInfs(fileVO);
	
	model.addAttribute("fileList", result);
	model.addAttribute("updateFlag", "Y");
	model.addAttribute("fileListCnt", result.size());
	model.addAttribute("atchFileId", atchFileId);
	
	return "cmmn/EgovFileList";
	}
	
	/**
	 * 첨부파일 변경을 위한 수정페이지로 이동한다.
	 * 
	 * @param fileVO
	 * @param atchFileId
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmmn/selectFileInfsForUpdateNew.do")
	public String selectFileInfsForUpdateNew(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap,
		//SessionVO sessionVO,
		ModelMap model) throws Exception {

		String atchFileId = (String)commandMap.get("param_atchFileId");
	
		fileVO.setAtchFileId(atchFileId);
	
		List<FileVO> result = fileService.selectFileInfs(fileVO);
		
		model.addAttribute("fileList", result);
		model.addAttribute("updateFlag", "Y");
		model.addAttribute("fileListCnt", result.size());
		model.addAttribute("atchFileId", atchFileId);
		
		return "cmmn/EgovFileListNew";
	}

	/**
	 * 첨부파일에 대한 삭제를 처리한다.
	 * 
	 * @param fileVO
	 * @param returnUrl
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmmn/deleteFileInfs.do")
	public String deleteFileInf(@ModelAttribute("searchVO") FileVO fileVO, @RequestParam("returnUrl") String returnUrl,
		//SessionVO sessionVO,
		HttpServletRequest request,
		ModelMap model) throws Exception {

	Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();

	if (isAuthenticated) {
		fileService.deleteFileInf(fileVO);
	}

	//--------------------------------------------
	// contextRoot가 있는 경우 제외 시켜야 함
	//--------------------------------------------
	////return "forward:/cmm/fms/selectFileInfs.do";
	//return "forward:" + returnUrl;
	
	if ("".equals(request.getContextPath()) || "/".equals(request.getContextPath())) {
		return "forward:" + returnUrl;
	}
	
	if (returnUrl.startsWith(request.getContextPath())) {
		return "forward:" + returnUrl.substring(returnUrl.indexOf("/", 1));
	} else {
		return "forward:" + returnUrl;
	}
	////------------------------------------------
	}

	/**
	 * 이미지 첨부파일에 대한 목록을 조회한다.
	 * 
	 * @param fileVO
	 * @param atchFileId
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmmn/selectImageFileInfs.do")
	public String selectImageFileInfs(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap,
			//SessionVO sessionVO,
			ModelMap model) throws Exception {
		
		String atchFileId = (String)commandMap.get("atchFileId");
		String thumbnailFlag = (String)commandMap.get("thumbnailFlag");
		
		// 썸네일 이라고 표시 해준다.
		if (thumbnailFlag != null && "Y".equals(thumbnailFlag)) {
			model.addAttribute("thumbnailFlag", thumbnailFlag);
		}
	
		fileVO.setAtchFileId(atchFileId);
		List<FileVO> result = fileService.selectImageFileList(fileVO);
		
		model.addAttribute("fileList", result);
		
		if (result.size() > 0)
			return "cmmn/EgovImgFileList";
		else
			if (thumbnailFlag != null && "Y".equals(thumbnailFlag))
				return "cmmn/EgovNoImgFile";
			else
				return "cmmn/EgovImgFileList";
	}

	@RequestMapping("/cmmn/getImageFileInfs.do")
	public ModelAndView getImageFileInfs(@ModelAttribute("searchVO") FileVO fileVO, 
			Map<String, Object> commandMap,
			ModelMap model) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		String atchFileId = (String)commandMap.get("atchFileId");
	
		fileVO.setAtchFileId(atchFileId);
		List<FileVO> result = fileService.selectImageFileList(fileVO);

		modelAndView.addObject("fileList", result);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	@RequestMapping("/cmmn/delImageFileInfs.do")
	public ModelAndView delImageFileInfs(@ModelAttribute("searchVO") FileVO fileVO,
		HttpServletRequest request,
		ModelMap model) throws Exception {

		ModelAndView modelAndView = new ModelAndView();
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();

		if (isAuthenticated) {
			try {
				fileService.deleteFileInf(fileVO);
				modelAndView.addObject("delFileResult", "SUCCESS");
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 이미지 첨부파일에 대한 목록을 조회한다.
	 * 
	 * @param fileVO
	 * @param atchFileId
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmmn/selectCheckUseImageFile.do")
	public String selectCheckUseImageFile(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap,
			//SessionVO sessionVO,
			ModelMap model) throws Exception {
		
		String atchFileId = (String)commandMap.get("atchFileId");
		String thumbnailFlag = (String)commandMap.get("thumbnailFlag");
		
		// 썸네일 이라고 표시 해준다.
		if (thumbnailFlag != null && "Y".equals(thumbnailFlag)) {
			model.addAttribute("thumbnailFlag", thumbnailFlag);
		}
	
		fileVO.setAtchFileId(atchFileId);
		List<FileVO> result = fileService.selectImageFileList(fileVO);
		
		model.addAttribute("fileList", result);
		
		if (result.size() > 0)
			return "cmmn/EgovCheckUseImgFileList";
		else
			if (thumbnailFlag != null && "Y".equals(thumbnailFlag))
				return "cmmn/EgovNoImgFile";
			else
				return "cmmn/EgovCheckUseImgFileList";
	}
	
	/**
	 * 첨부파일에 대한 목록을 조회한다.
	 * 
	 * @param fileVO
	 * @param atchFileId
	 * @param sessionVO
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/cmmn/selectCheckUseDetailFile.do")
	public String selectCheckUseDetailFile(@ModelAttribute("searchVO") FileVO fileVO, Map<String, Object> commandMap, ModelMap model) throws Exception {
	String atchFileId = (String)commandMap.get("param_atchFileId");

	fileVO.setAtchFileId(atchFileId);
	 
	List<FileVO> result = fileService.selectFileInfs(fileVO);

	model.addAttribute("fileList", result);
	model.addAttribute("updateFlag", "N");
	model.addAttribute("fileListCnt", result.size());
	model.addAttribute("atchFileId", atchFileId);
	
	return "cmmn/EgovCheckUseDetailFile";
	}
	
}
