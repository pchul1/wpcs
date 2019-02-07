package daewooInfo.spotmanage.web;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.EgovFileMngUtil;
import daewooInfo.smsmanage.bean.SmsBranchVO;
import daewooInfo.smsmanage.bean.SmsTargetVO;
import daewooInfo.smsmanage.bean.SmsVO;
import daewooInfo.smsmanage.service.SmsManageCounterService;
import daewooInfo.spotmanage.bean.AdminHistoryVO;
import daewooInfo.spotmanage.bean.BranchItemVO;
import daewooInfo.spotmanage.bean.EqItemVO;
import daewooInfo.spotmanage.bean.FactinfoVO;
import daewooInfo.spotmanage.bean.ItemVO;
import daewooInfo.spotmanage.bean.MemberAddVO;
import daewooInfo.spotmanage.bean.SpotInfoVO;
import daewooInfo.spotmanage.bean.SpotManageVO;
import daewooInfo.spotmanage.bean.SysEquipVO;
import daewooInfo.spotmanage.bean.UsnItemVO;
import daewooInfo.spotmanage.bean.ZipcodeVO;
import daewooInfo.spotmanage.service.SpotManageCounterService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @Class Name : SpotManageController.java
 * @Description : 지점 관리를 위한 Controller
 * @Modification Information
 * @ 수정일 수정자 수정내용
 * 
 * @author yong
 * @since 2012.01.25
 * @version 1.0
 * @see
 */
@Controller
public class SpotManageController {

	/**
	 * @uml.property  name="spotManageCounterService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "SpotManageCounterService")
	private SpotManageCounterService spotManageCounterService;
	/**
	 * @uml.property  name="fileUtil"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;

	@Resource(name = "SmsManageCounterService")
	private SmsManageCounterService smsManageCounterService;
	
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Logger log = Logger.getLogger(this.getClass());
	/* 데이터 처리 후 작업 위한 인덱스 값 */
	/**
	 * @uml.property  name="indexNum"
	 */
	String indexNum;

	/**
	 * Usn 등록 페이지 화면 호출
	 * 
	 * @return 출력페이지정보 "spotmanage/usninsertform"
	 * @exception Exception
	 */
	@RequestMapping(value = "/spotmanage/usninsertform.do")
	public String usninsertform(ModelMap model) throws Exception {

		return "/spotmanage/UsnInsertPopUp";
	}
	/**
	 * 설치장비 등록 페이지 화면 호출
	 * 
	 * @return 출력페이지정보 "spotmanage/eqinsertform"
	 * @exception Exception
	 */
	@RequestMapping(value = "/spotmanage/eqinsertform.do")
	public String eqinsertform(ModelMap model) throws Exception {
		return "/spotmanage/EqInsertPopUp";
	}
	
	/**
	 * 설치장비 등록 페이지 시스템구분에 따른 항목명 조회
	 * 
	 * @exception Exception
	 */
	@RequestMapping(value = "/spotmanage/getItemName.do")
	public ModelAndView getItemName(
			@ModelAttribute("spotManageVO") SpotManageVO spotManageVO)
			throws Exception {
		
		String itemName = spotManageCounterService.getItemName(spotManageVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("itemName", itemName);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}

	/**
	 * Usn 수정 페이지 화면 호출
	 * 
	 * @return 출력페이지정보 "spotmanage/usnupdateform"
	 * @exception Exception
	 */
	@RequestMapping(value = "/spotmanage/usnupdateform.do")
	public String usnupdateform(ModelMap model) throws Exception {

		return "/spotmanage/UsnUpdatePopUp";
	}
	/**
	 * Usn 수정 페이지 화면 호출
	 * 
	 * @return 출력페이지정보 "spotmanage/usnupdateform"
	 * @exception Exception
	 */
	@RequestMapping(value = "/spotmanage/equpdateform.do")
	public String eqUpDateForm(ModelMap model) throws Exception {
		
		return "/spotmanage/EqUpdatePopUp";
	}

	@RequestMapping(value = "/spotmanage/spotManage.do")
	public String spotManage(ModelMap model) throws Exception {
		return "/spotmanage/spotManage";
	}
	
	@RequestMapping(value = "/spotmanage/spotManageRegist.do")
	public String spotManageRegist(ModelMap model) throws Exception {
		return "/spotmanage/spotManageRegist";
	}

	@RequestMapping(value = "/spotmanage/fileDownform.do")
	public String fileDownform(ModelMap model) throws Exception {
		return "/spotmanage/FileDownPopUp";
	}
	
	@RequestMapping(value = "/spotmanage/spotManageInsertPop.do")
	public String spotManageInsertPop(ModelMap model) throws Exception {
		return "/spotmanage/spotManageInsertPop";
	}
	
	@RequestMapping(value = "/spotmanage/spotManageUpdatePop.do")
	public String spotManageUpdatePop(ModelMap model) throws Exception {
		return "/spotmanage/spotManageUpdatePop";
	}

	/**
	 * 지점관리 리스트 호출
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/spotmanage/getSpotmgrList.do")
	public ModelAndView getSpotmgrList(
			@ModelAttribute("spotManageVO") SpotManageVO spotManageVO)
			throws Exception {

		ModelAndView modelAndView = new ModelAndView();

		PaginationInfo paginationInfo = new PaginationInfo();
		
		if (spotManageVO.getPageIndex() == 0)
			spotManageVO.setPageIndex(1);

		/** paging */
		spotManageVO.setPageUnit(10);
		paginationInfo.setCurrentPageNo(spotManageVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(spotManageVO.getPageUnit());
		paginationInfo.setPageSize(spotManageVO.getPageSize());

		spotManageVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		spotManageVO.setLastIndex(paginationInfo.getLastRecordIndex());
		spotManageVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List refreshData = spotManageCounterService.getSpotMgrList(spotManageVO);
		int totCnt = spotManageCounterService.getSpotMgrCnt(spotManageVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("spotManageVO", spotManageVO);
		modelAndView.addObject("detailViewList", refreshData);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}

	/**
	 * 지점관리 상세보기
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/getSpotView.do")
	public ModelAndView getSpotView(
			@ModelAttribute("spotManageVO") SpotManageVO spotManageVO)
			throws Exception {
		SpotManageVO list = spotManageCounterService.getSpotView(spotManageVO);

		List memList = spotManageCounterService.getSpotMemList(spotManageVO);
		List sysItemList = spotManageCounterService.getSysItemList(spotManageVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("memList", memList);
		modelAndView.addObject("sysItemList", sysItemList);
		modelAndView.addObject("getSpotView", list);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}

	/**
	 * 지점관리 Usn List 호출
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/getUsnList.do")
	public ModelAndView getUsnList(
			@ModelAttribute("usnItemVO") UsnItemVO usnItemVO) throws Exception {
		PaginationInfo paginationInfo = new PaginationInfo();

		if (usnItemVO.getPageIndex() == 0)
			usnItemVO.setPageIndex(1);
		/** paging */
		usnItemVO.setPageUnit(50);
		paginationInfo.setCurrentPageNo(usnItemVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(usnItemVO.getPageUnit());
		paginationInfo.setPageSize(usnItemVO.getPageSize());

		usnItemVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		usnItemVO.setLastIndex(paginationInfo.getLastRecordIndex());
		usnItemVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		List list = spotManageCounterService.getUsnList(usnItemVO);

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("usnItemVO", usnItemVO);
		modelAndView.addObject("getUsnList", list);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}

	/**
	 * 지점관리 설치장비 리스트
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/getEqList.do")
	public ModelAndView getEqList(
			@ModelAttribute("EqItemVO") EqItemVO eqItemVO
			) throws Exception {
		PaginationInfo paginationInfo = new PaginationInfo();

		if (eqItemVO.getPageIndex() == 0)
			eqItemVO.setPageIndex(1);
		/** paging */
		eqItemVO.setPageUnit(50);
		paginationInfo.setCurrentPageNo(eqItemVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(eqItemVO.getPageUnit());
		paginationInfo.setPageSize(eqItemVO.getPageSize());

		eqItemVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		eqItemVO.setLastIndex(paginationInfo.getLastRecordIndex());
		eqItemVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List list = spotManageCounterService.getEqList(eqItemVO);

		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("usnItemVO", eqItemVO);
		modelAndView.addObject("getEqList", list);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}

	/**
	 * 지점관리 항목관리 리스트 호출
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/getItemList.do")
	public ModelAndView getItemList(
			@ModelAttribute("itemVO") ItemVO itemVO
			) throws Exception {
		List list = spotManageCounterService.getBranchItemCodeList(itemVO);

		BranchItemVO branchItemVO = new BranchItemVO();
		branchItemVO.setFactCode(itemVO.getFactCode());
		branchItemVO.setBranchNo(itemVO.getBranchNo());
		branchItemVO.setSysType(itemVO.getSysType());
		
		List branchItemList = spotManageCounterService.getBranchItemFullList(branchItemVO);
		PaginationInfo paginationInfo = new PaginationInfo();

		if (itemVO.getPageIndex() == 0)
			itemVO.setPageIndex(1);
		/** paging */
		itemVO.setPageUnit(50);
		paginationInfo.setCurrentPageNo(itemVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(itemVO.getPageUnit());
		paginationInfo.setPageSize(itemVO.getPageSize());

		itemVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		itemVO.setLastIndex(paginationInfo.getLastRecordIndex());
		itemVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("getItemList", list);
		modelAndView.addObject("branchItemList", branchItemList);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}

	/**
	 * 관리자 리스트 호출
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/getMemberList.do")
	public ModelAndView getMemberList(
			@ModelAttribute("spotManageVO") SpotManageVO spotManageVO)
			throws Exception {

		List list = spotManageCounterService.getMemberList(spotManageVO);

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.addObject("getMemberList", list);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}

	/**
	 * 관리자 등록
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/branchmemberInsert.do")
	public ModelAndView branchmemberInsert(
			@ModelAttribute("memberAddVO") MemberAddVO memberAddVO)
			throws Exception {

		spotManageCounterService.branchmemberInsert(memberAddVO);

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("jsonView");

		return modelAndView;
	}

	/**
	 * 관리자 삭제
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/branchmemberdel.do")
	public ModelAndView branchmemberdel(
			@ModelAttribute("memberAddVO") MemberAddVO memberAddVO)
			throws Exception {
		try{
			spotManageCounterService.branchmemberdel(memberAddVO);
		}catch(Exception e){
			e.printStackTrace();
		}

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("jsonView");

		return modelAndView;
	}

	/**
	 * usn 항목 등록
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/usnInsert.do")
	public ModelAndView usnInsert(
			final MultipartHttpServletRequest multiRequest,
			@ModelAttribute("usnItemVO") UsnItemVO usnItemVO,
			ModelMap model)
			throws Exception {
		List<FileVO> result = null;
		FileVO fileVO;
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet()
				.iterator();
		MultipartFile file;
		if (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
			file = entry.getValue();
			String orginFileName = file.getOriginalFilename();
			//System.out.println("orginFileName=====" + orginFileName);
			if (orginFileName != "") {
				//System.out.println("실행확인");
				result = fileUtil.parseFileInf(files, "BRA_", 0, "", "");
				fileVO = (FileVO) result.get(0);
				usnItemVO.setAtchFileId(fileVO.getAtchFileId());
				usnItemVO.setSavePath(fileVO.getFileStreCours());
				usnItemVO.setSaveFileName(fileVO.getStreFileNm());
				usnItemVO.setOrignlFileName(fileVO.getOrignlFileNm());
				usnItemVO.setFileExtsn(fileVO.getFileExtsn());
				usnItemVO.setFileMg(fileVO.getFileMg());
				usnItemVO.setFileContent(fileVO.getFileCn());
			}
		}
		spotManageCounterService.usnInsert(usnItemVO);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/spotmanage/selfClose");
		return modelAndView;
	}
	/**
	 * 설치 장비 등록
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/eqInsert.do")
	public ModelAndView eqInsert(
			@ModelAttribute("eqItemVO") EqItemVO eqItemVO
			)throws Exception {
		//System.out.println(eqItemVO);
		spotManageCounterService.eqInsert(eqItemVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}

	/**
	 * 요청 처리 후 부모창 데이터 갱신
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/getIndexNum.do")
	public ModelAndView getIndexNum() throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("indexNum", this.indexNum);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}

	/**
	 * usn수정 정보 가져오기
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/getUpdateView.do")
	public ModelAndView getUpdateView(
			@ModelAttribute("usnItemVO") UsnItemVO usnItemVO) throws Exception {

		UsnItemVO itemVO = spotManageCounterService.getUpdateView(usnItemVO);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("usnItemVO", itemVO);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}

	/**
	 * usn 항목 수정
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/usnUpdate.do")
	public ModelAndView usnUpdate(
			final MultipartHttpServletRequest multiRequest,
			@ModelAttribute("usnItemVO") UsnItemVO usnItemVO,
			ModelMap model)
			throws Exception {
		List<FileVO> result = null;
		FileVO fileVO;
		Map<String, MultipartFile> files = multiRequest.getFileMap();
		Iterator<Entry<String, MultipartFile>> itr = files.entrySet().iterator();
		MultipartFile file;
		if (itr.hasNext()) {
			Entry<String, MultipartFile> entry = itr.next();
			file = entry.getValue();
			String orginFileName = file.getOriginalFilename();
			if (orginFileName != "") {
				UsnItemVO fvo = spotManageCounterService.selectFileInfo(usnItemVO);
				if(fvo.getAtchFileId()!=null){
					File uFile = new File(fvo.getSavePath(), fvo.getSaveFileName());
					if(uFile.delete()){
						//System.out.println("이전파일 삭제");
					}else{
						//System.out.println("이전파일 삭제 실패");
					}
				}
				result = fileUtil.parseFileInf(files, "BRA_", 0, "", "");
				fileVO = (FileVO) result.get(0);
				usnItemVO.setAtchFileId(fileVO.getAtchFileId());
				usnItemVO.setSavePath(fileVO.getFileStreCours());
				usnItemVO.setSaveFileName(fileVO.getStreFileNm());
				usnItemVO.setOrignlFileName(fileVO.getOrignlFileNm());
				usnItemVO.setFileExtsn(fileVO.getFileExtsn());
				usnItemVO.setFileMg(fileVO.getFileMg());
				usnItemVO.setFileContent(fileVO.getFileCn());
			}
		}
		spotManageCounterService.usnUpdate(usnItemVO);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/spotmanage/selfClose");
		return modelAndView;
	}

	/**
	 * usn 항목 삭제처리 (업데이트)
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/usndel.do")
	public ModelAndView usndel(@ModelAttribute("usnItemVO") UsnItemVO usnItemVO)
			throws Exception {
		UsnItemVO fvo = spotManageCounterService.selectFileInfo(usnItemVO);
		if(fvo.getAtchFileId()!=null){
		File uFile = new File(fvo.getSavePath(), fvo.getSaveFileName());
			if(uFile.delete()){
				//System.out.println("이전파일 삭제");
			}else{
				//System.out.println("이전파일 삭제 실패");
			}
		}
		int result = spotManageCounterService.usndel(usnItemVO);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("result", result);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}
	/**
	 * 설치장비 삭제처리 (업데이트)
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/eqDel.do")
	public ModelAndView eqDel(
			@ModelAttribute("eqItemVO") EqItemVO eqItemVO
			)
			throws Exception {
		int result = spotManageCounterService.eqDel(eqItemVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("result", result);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}

	/**
	 * 첨부파일로 등록된 파일에 대하여 다운로드를 제공한다.
	 * 
	 * @param commandMap
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/FileDown.do")
	public String cvplFileDownload(HttpServletRequest request,
			HttpServletResponse response,
			@ModelAttribute("usnItemVO") UsnItemVO usnItemVO) throws Exception {
		Boolean isAuthenticated = TmsUserDetailsHelper.isAuthenticated();
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/spotmanage/selfClose");
		if (isAuthenticated) {
			
			UsnItemVO fvo = spotManageCounterService.selectFileInfo(usnItemVO);
			//System.out.println(fvo);
			File uFile = new File(fvo.getSavePath(), fvo.getSaveFileName());
			int fSize = (int) uFile.length();
			
			if (fSize > 0) {
				String mimetype = "application/x-msdownload";
				
				response.setBufferSize(fSize);
				response.setContentType(mimetype);
				setDisposition(fvo.getOrignlFileName(), request, response);
				response.setContentLength(fSize);
				
				BufferedInputStream in = null;
				BufferedOutputStream out = null;
				
				try {
					in = new BufferedInputStream(new FileInputStream(uFile));
					out = new BufferedOutputStream(response.getOutputStream());
					FileCopyUtils.copy(in, out);
					out.flush();
				} catch (Exception ex) {
					// ex.printStackTrace();
					// 다음 Exception 무시 처리
					// Connection reset by peer: socket write error
					log.debug("IGNORED: " + ex.getMessage());
				} finally {
					if (in != null) {
						try {
							in.close();
						} catch (Exception ignore) {
							// no-op
							log.debug("IGNORED: " + ignore.getMessage());
						}
					}
					if (out != null) {
						try {
							out.close();
						} catch (Exception ignore) {
							// no-op
							log.debug("IGNORED: " + ignore.getMessage());
						}
					}
				}
				
			} else {
				response.setContentType("application/x-msdownload");
				
				PrintWriter printwriter = response.getWriter();
				printwriter.println("<html>");
				printwriter.println("<br><br><br><h2>Could not get file name:<br/>"+ fvo.getOrignlFileName() + "</h2>");
				printwriter.println("<br><br><br><center><h3><a href='javascript: history.go(-1)'>Back</a></h3></center>");
				printwriter.println("<br><br><br>&copy; webAccess");
				printwriter.println("</html>");
				printwriter.flush();
				printwriter.close();
			}
		}
		return "/spotmanage/selfClose";
	}
	
	/**
	 * Disposition 지정하기.
	 * 
	 * @param filename
	 * @param request
	 * @param response
	 * @throws Exception
	 */
	private void setDisposition(String filename, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String browser = getBrowser(request);
		
		String dispositionPrefix = "attachment; filename=";
		String encodedFilename = null;
		
		if (browser.equals("MSIE")) {
			encodedFilename = URLEncoder.encode(filename, "UTF-8").replaceAll(
					"\\+", "%20");
		} else if (browser.equals("Firefox")) {
			encodedFilename = "\""
					+ new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Opera")) {
			encodedFilename = "\""
					+ new String(filename.getBytes("UTF-8"), "8859_1") + "\"";
		} else if (browser.equals("Chrome")) {
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < filename.length(); i++) {
				char c = filename.charAt(i);
				if (c > '~') {
					sb.append(URLEncoder.encode("" + c, "UTF-8"));
				} else {
					sb.append(c);
				}
			}
			encodedFilename = sb.toString();
		} else {
			// throw new RuntimeException("Not supported browser");
			throw new IOException("Not supported browser");
		}

		response.setHeader("Content-Disposition", dispositionPrefix
				+ encodedFilename);

		if ("Opera".equals(browser)) {
			response.setContentType("application/octet-stream;charset=UTF-8");
		}
	}

	/**
	 * 브라우저 구분 얻기.
	 * 
	 * @param request
	 * @return
	 */
	private String getBrowser(HttpServletRequest request) {
		String header = request.getHeader("User-Agent");
		if (header.indexOf("MSIE") > -1) {
			return "MSIE";
		} else if (header.indexOf("Chrome") > -1) {
			return "Chrome";
		} else if (header.indexOf("Opera") > -1) {
			return "Opera";
		}
		return "Firefox";
	}
	
	/**
	 * 측정장비등록 정보 가져오기
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/eqUpDateInfo.do")
	public ModelAndView eqUpDateForm(
			@ModelAttribute("eqItemVO") EqItemVO eqitemVO
			) throws Exception {
		
		EqItemVO itemVO = spotManageCounterService.eqUpDateForm(eqitemVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("eqItemVO", itemVO);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	/**
	 * 관리자 등록
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/equpdate.do")
	public ModelAndView equpdate(
			@ModelAttribute("eqItemVO") EqItemVO eqItemVO
			) throws Exception {

		spotManageCounterService.eqUpdate(eqItemVO);

		ModelAndView modelAndView = new ModelAndView();

		modelAndView.setViewName("jsonView");

		return modelAndView;
	}
	/**
	 * 관리자 등록
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/adminHistoryInsert.do")
	public ModelAndView adminHistoryInsert(
			@ModelAttribute("adminHistoryVO") AdminHistoryVO adminHistoryVO
			) throws Exception {
		
		spotManageCounterService.adminHistoryInsert(adminHistoryVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	/**
	 * 지점관리 관리이력 리스트
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/getAdminHistoryList.do")
	public ModelAndView getAdminHistoryList(
			@ModelAttribute("adminHistoryVO") AdminHistoryVO adminHistoryVO
			) throws Exception {
		List list = spotManageCounterService.getAdminHistoryList(adminHistoryVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("getAdminHistoryList", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	@RequestMapping(value = "/spotmanage/adminHistoryUpdate.do")
	public ModelAndView adminHistoryUpdate(
			@ModelAttribute("adminHistoryVO") AdminHistoryVO adminHistoryVO
			) throws Exception {
		spotManageCounterService.adminHistoryUpdate(adminHistoryVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	@RequestMapping(value = "/spotmanage/adminHistorydel.do")
	public ModelAndView adminHistorydel(
			@ModelAttribute("adminHistoryVO") AdminHistoryVO adminHistoryVO
			) throws Exception {
		spotManageCounterService.adminHistorydel(adminHistoryVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 주소 리스트 가져오기
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/getAddressList.do")
	public ModelAndView getAddressList(
			@ModelAttribute("zipcodeVO") ZipcodeVO zipcodeVO
			) throws Exception {
		List list = spotManageCounterService.getAddressList(zipcodeVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("getAddressList", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	/**
	 * 단일 저장
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/SingleSave.do")
	public ModelAndView singleSave(
			@ModelAttribute("branchItemVO") BranchItemVO branchItemVO
			) throws Exception {
		List list = spotManageCounterService.getBranchItemList(branchItemVO);
		if(list.size() <= 0 ){
			
		}else{
			boolean itemFlag = false;
			for(int i=0; i<list.size(); i++){
				BranchItemVO data = (BranchItemVO)list.get(i);
				if(data.getItemCode().equals(branchItemVO.getItemCode())){
					itemFlag = true;
				}	
			}
			//if(itemFlag){
				spotManageCounterService.singleSaveUpdate(branchItemVO);
			//}else{
			//	spotManageCounterService.singleSaveInsert(branchItemVO);
			//}
		}
		
		ModelAndView modelAndView = new ModelAndView();
		
		//modelAndView.addObject("getAddressList", list);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	/* 다중 입력  */
	@RequestMapping(value = "/spotmanage/goMultiSave.do")
	public ModelAndView MultiSave(
			@ModelAttribute("branchItemVO") BranchItemVO branchItemVO
			) throws Exception {
			//System.out.print("branchItemVO.getUserFlag():"+branchItemVO.getUserFlag().toString());
//		if(branchItemVO.getUserFlag().equals("update")){
//			spotManageCounterService.singleSaveUpdate(branchItemVO);
//		}else if(branchItemVO.getUserFlag().equals("insert")){
//			spotManageCounterService.singleSaveInsert(branchItemVO);
//		}
		spotManageCounterService.singleSaveUpdate(branchItemVO);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 지점 저장
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/saveBranchReg.do")
	public ModelAndView saveBranchReg(
			@ModelAttribute("factinfoVO") FactinfoVO factinfoVO
			) throws Exception {
		spotManageCounterService.saveFactinfo(factinfoVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 측정소 저장
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/saveFactbranchInfoAdd.do")
	public ModelAndView saveFactbranchInfoAdd(
			@ModelAttribute("factinfoVO") FactinfoVO factinfoVO
			) throws Exception {
		spotManageCounterService.saveFactbranchInfoAdd(factinfoVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 시스템 장비 리스트 호출
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/spotmanage/getSysinfoList.do")
	public ModelAndView getSysinfoList(
			@ModelAttribute("sysEquipVO") SysEquipVO sysEquipVO) throws Exception {

		ModelAndView modelAndView = new ModelAndView();

		PaginationInfo paginationInfo = new PaginationInfo();
		
		

		/** paging */
		if (sysEquipVO.getPageIndex() == 0)sysEquipVO.setPageIndex(1);
//		factinfoVO.setPageUnit(30);
		sysEquipVO.setPageUnit(100000);
		sysEquipVO.setPageSize(10);
		paginationInfo.setCurrentPageNo(sysEquipVO.getPageIndex());//선택한 페이지 번호
		paginationInfo.setRecordCountPerPage(sysEquipVO.getPageUnit());//페이지당 레코드 수
		paginationInfo.setPageSize(sysEquipVO.getPageSize());//페이수 번호 갯수

		sysEquipVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		sysEquipVO.setLastIndex(paginationInfo.getLastRecordIndex());
		sysEquipVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List list = spotManageCounterService.getSysinfoList(sysEquipVO);
		int totCnt = spotManageCounterService.getSysinfoListCnt(sysEquipVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		//modelAndView.addObject("spotManageVO", factinfoVO);
		modelAndView.addObject("sysinfoList", list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 지점관리 리스트 호출
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/spotmanage/getFactinfoList.do")
	public ModelAndView getFactinfoList(
			@ModelAttribute("factinfoVO") FactinfoVO factinfoVO) throws Exception {

		ModelAndView modelAndView = new ModelAndView();

		PaginationInfo paginationInfo = new PaginationInfo();
		
		

		/** paging */
		if (factinfoVO.getPageIndex() == 0)factinfoVO.setPageIndex(1);
//		factinfoVO.setPageUnit(30);
		factinfoVO.setPageUnit(100000);
		factinfoVO.setPageSize(10);
		paginationInfo.setCurrentPageNo(factinfoVO.getPageIndex());//선택한 페이지 번호
		paginationInfo.setRecordCountPerPage(factinfoVO.getPageUnit());//페이지당 레코드 수
		paginationInfo.setPageSize(factinfoVO.getPageSize());//페이수 번호 갯수

		factinfoVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		factinfoVO.setLastIndex(paginationInfo.getLastRecordIndex());
		factinfoVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List list = spotManageCounterService.getFactinfoList(factinfoVO);
		int totCnt = spotManageCounterService.getFactinfoListCnt(factinfoVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		//modelAndView.addObject("spotManageVO", factinfoVO);
		modelAndView.addObject("factinfoList", list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 측정소 리스트 호출
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/spotmanage/getFactbranchInfoAddList.do")
	public ModelAndView getFactbranchInfoAddList(
			@ModelAttribute("factinfoVO") FactinfoVO factinfoVO) throws Exception {

		ModelAndView modelAndView = new ModelAndView();

		PaginationInfo paginationInfo = new PaginationInfo();

		/** paging */
		if (factinfoVO.getPageIndex() == 0)factinfoVO.setPageIndex(1);
		factinfoVO.setPageUnit(30);
		factinfoVO.setPageSize(10);
		paginationInfo.setCurrentPageNo(factinfoVO.getPageIndex());//선택한 페이지 번호
		paginationInfo.setRecordCountPerPage(factinfoVO.getPageUnit());//페이지당 레코드 수
		paginationInfo.setPageSize(factinfoVO.getPageSize());//페이수 번호 갯수

		factinfoVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		factinfoVO.setLastIndex(paginationInfo.getLastRecordIndex());
		factinfoVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List list = spotManageCounterService.getFactbranchInfoAddList(factinfoVO);
		int totCnt = spotManageCounterService.getFactbranchInfoAddListCnt(factinfoVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		//modelAndView.addObject("spotManageVO", factinfoVO);
		modelAndView.addObject("getFactbranchInfoAddList", list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 측정소 가져오기
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/spotmanage/getFactbranchInfoAdd.do")
	public ModelAndView getFactbranchInfoAdd(
			@ModelAttribute("factinfoVO") FactinfoVO factinfoVO) throws Exception {

		ModelAndView modelAndView = new ModelAndView();
		
		List list = spotManageCounterService.getFactbranchInfoAdd(factinfoVO);
		
		modelAndView.addObject("getFactbranchInfoAdd", list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 측정소 수정
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/getMaxBranchNo.do")
	public ModelAndView getMaxBranchNo(
			@ModelAttribute("spotManageVO") SpotManageVO spotManageVO
			) throws Exception {
		String maxBranchNo = spotManageCounterService.getMaxBranchNo(spotManageVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("branchNo", maxBranchNo);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 측정소 수정
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/updateFactbranchInfoAdd.do")
	public ModelAndView updateFactbranchInfoAdd(
			@ModelAttribute("factinfoVO") FactinfoVO factinfoVO
			) throws Exception {
		spotManageCounterService.updateFactbranchInfoAdd(factinfoVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	/**
	 * 측정소 사용여부 저장
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/saveLoadData.do")
	public ModelAndView saveLoadData(
			@RequestParam(value="fact_code", required=false) 	String   fact_code
			,@RequestParam(value="branch_no", required=false) 	String 	 branch_no
			,@RequestParam(value="branchUseFlag", required=false) 	String   branchUseFlag) throws Exception {
		ModelAndView modelAndView  = new ModelAndView();
		FactinfoVO vo = new FactinfoVO(); 
		vo.setFact_code(fact_code);
		vo.setBranch_no(branch_no);
		vo.setBranch_use_flag(branchUseFlag);
		spotManageCounterService.saveLoadData(vo);
		
        modelAndView.setViewName("jsonView");

        return modelAndView;
	}
	
	/**
	 * 측정소 excel 출력
	 * 
	 * @return
	 * @throws Exception
	 */
    @RequestMapping("/spotmanage/getExcelSpotmgrList.do")
    public ModelAndView getExcelWarning(
    		@ModelAttribute("spotManageVO") SpotManageVO spotManageVO) throws Exception {
    	List<SpotManageVO> refreshData =  spotManageCounterService.getExcelSpotmgrList(spotManageVO);
		Map<String, Object> map = new HashMap<String, Object>();

		map.put("chart", refreshData);
		map.put("spotManageVO", spotManageVO);

		return new ModelAndView("ExcelViewFact", "chartMap", map);
    }
    
    /**
	 * 장비저장
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/saveEquipInfoReg.do")
	public ModelAndView saveEquipInfoReg(
			@ModelAttribute("sysEquipVO") SysEquipVO sysEquipVO
			) throws Exception {
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		sysEquipVO.setReg_id(user.getId());
		
		sysEquipVO.setSys_kind(sysEquipVO.getE_sys_kind());
		
		spotManageCounterService.saveEquipInfo(sysEquipVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}


	@RequestMapping(value = "/spotmanage/ListDetailSmsFact.do")
	public String ListDetailSmsFact(ModelMap model, SmsVO smsVO) throws Exception {
		smsManageCounterService.InitFactSmsConfig(smsVO);
		model.addAttribute("List", smsManageCounterService.getFactSmsList(smsVO));
		return "jsonView";
	}
	

	@RequestMapping(value = "/spotmanage/DetailFactSmsBranch.do")
	public String DetailFactSmsBranch(ModelMap model, SmsBranchVO smsBranchVO) throws Exception {
		model.addAttribute("Detail", smsManageCounterService.DetailFactSmsBranch(smsBranchVO));
		return "jsonView";
	}

	@RequestMapping(value = "/spotmanage/InsertFactSmsBranch.do")
	public String InsertSmsBranchConfig(ModelMap model, SmsBranchVO smsBranchVO) throws Exception {
		smsManageCounterService.MergeFactSmsBranch(smsBranchVO);
		return "jsonView";
	}
	


	@RequestMapping(value = "/spotmanage/FactSmsTargetList.do")
	public String FactSmsTargetList(ModelMap model, SmsTargetVO smsTargetVO) throws Exception {
		model.addAttribute("List", smsManageCounterService.FactSmsTargetList(smsTargetVO));
		return "jsonView";
	}
	
	
	
	@RequestMapping(value = "/spotmanage/spotCheckManage.do")
	public String spotCheckManage(ModelMap model) throws Exception {
		return "/spotmanage/spotCheckManage";
	}
	
	@RequestMapping(value = "/spotmanage/getEqHsList.do")
	public ModelAndView getEqHsList(
			@ModelAttribute("EqItemVO") EqItemVO eqItemVO
			) throws Exception {
		PaginationInfo paginationInfo = new PaginationInfo();

		if (eqItemVO.getPageIndex() == 0)
			eqItemVO.setPageIndex(1);
		/** paging */
		eqItemVO.setPageUnit(50);
		paginationInfo.setCurrentPageNo(eqItemVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(eqItemVO.getPageUnit());
		paginationInfo.setPageSize(eqItemVO.getPageSize());

		eqItemVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		eqItemVO.setLastIndex(paginationInfo.getLastRecordIndex());
		eqItemVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List list = spotManageCounterService.getEqHsList(eqItemVO);

		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("usnItemVO", eqItemVO);
		modelAndView.addObject("getEqHsList", list);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}
	
	
	
	@RequestMapping(value = "/spotmanage/usnHsInsert.do")
	public ModelAndView usnHsInsert(@ModelAttribute("usnItemVO") UsnItemVO usnItemVO)
			throws Exception {
		
		
		spotManageCounterService.usnHsInsert(usnItemVO);

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}
	
	/**
	 * 국가수질 측정지점 변경 정보 가져오기
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/spotmanage/getSpotInfoA.do")
	public ModelAndView getSpotInfoA(@ModelAttribute("spotInfoVO") SpotInfoVO spotInfoVO) throws Exception {
		PaginationInfo paginationInfo = new PaginationInfo();

		if (spotInfoVO.getPageIndex() == 0)
			spotInfoVO.setPageIndex(1);
		/** paging */
		spotInfoVO.setPageUnit(10);
		paginationInfo.setCurrentPageNo(spotInfoVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(spotInfoVO.getPageUnit());
		paginationInfo.setPageSize(spotInfoVO.getPageSize());

		spotInfoVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		spotInfoVO.setLastIndex(paginationInfo.getLastRecordIndex());
		spotInfoVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List spotInfoList = spotManageCounterService.getSpotInfoA(spotInfoVO);
		int totCnt = spotManageCounterService.getSpotInfoACnt(spotInfoVO);
		paginationInfo.setTotalRecordCount(totCnt);
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("spotInfoList", spotInfoList);
		modelAndView.setViewName("jsonView");

		return modelAndView;
	}
	
	@RequestMapping(value = "/spotmanage/saveSpotInfoA.do")
	public ModelAndView saveSpotInfoA(HttpServletResponse res, @RequestParam("factCode") String factCode,
			@ModelAttribute("spotInfoVO") SpotInfoVO spotInfoVO
			) throws Exception {
		
		int result  = 0;
		
		String [] sFactCode = factCode.split(":");
		
		for(int i = 0; i < sFactCode.length; i++){
			spotInfoVO.setFactCode(sFactCode[i]);
			result = spotManageCounterService.saveSpotInfoA(spotInfoVO);
		}
		if(result > 0){
			res.setContentType("text/html; charset=UTF-8");
			res.getWriter().print("<script>alert('성공적으로 저장되었습니다.');document.location.href='/spotmanage/spotManage.do'</script>");			
		}else{
			res.setContentType("text/html; charset=UTF-8");
			res.getWriter().print("<script>alert('ERROR');document.location.href='/spotmanage/spotManage.do'</script>");	
		}
		
		return null;
	}
}