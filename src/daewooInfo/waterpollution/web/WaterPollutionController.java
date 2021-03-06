package daewooInfo.waterpollution.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.admin.dept.service.DeptManageService;
import daewooInfo.alert.util.SendSMS;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.cmmn.service.EgovFileMngService;
import daewooInfo.common.TmsMessageSource;
import daewooInfo.common.alrim.bean.AlrimVO;
import daewooInfo.common.alrim.service.AlrimService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.EgovFileMngUtil;
import daewooInfo.common.util.fcc.StringUtil;
import daewooInfo.mobile.com.utl.LogInfoUtil;
import daewooInfo.mobile.com.utl.ObjectUtil;
import daewooInfo.waterpollution.bean.WaterPollutionReportSearchVO;
import daewooInfo.waterpollution.bean.WaterPollutionReportVO;
import daewooInfo.waterpollution.bean.WaterPollutionSearchVO;
import daewooInfo.waterpollution.bean.WaterPollutionStepVO;
import daewooInfo.waterpollution.bean.WaterPollutionVO;
import daewooInfo.waterpollution.service.WaterPollutionService;
import egovframework.rte.fdl.property.EgovPropertyService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 
 * 방제실적 관리
 * @author yik
 * @since 2013.04.20
 * @version 1.0
 * @see
 *
 * <pre>
 *	
 *	수정일	  수정자			수정내용
 *  -------	--------	---------------------------
 *	2013.04.20  yik		 최초 생성
 *
 * </pre>
 */
@Controller
public class WaterPollutionController {	

	/**
	 * EgovPropertyService
	 * @uml.property  name="propertiesService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "propertiesService")
	protected EgovPropertyService propertiesService;
	
	/**
	 * @uml.property  name="deptManageService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "deptManageService")
	private DeptManageService deptManageService;
	
	/**
	 * tmsMessageSource
	 * @uml.property  name="tmsMessageSource"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="tmsMessageSource")
	TmsMessageSource tmsMessageSource;
	
	/**
	 * @uml.property  name="waterPollutionService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "WaterPollutionService")
	private WaterPollutionService waterPollutionService;
	
	/**
	 * @uml.property  name="fileUtil"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	/**
	 * AlrimService
	 * @uml.property  name="alrimService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alrimService")
	private AlrimService alrimService;         
	
	/**
	 * @uml.property  name="fileMngService"
	 */
	@Resource(name = "EgovFileMngService")
	private EgovFileMngService fileMngService;
	
	/**
	 * log
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log log = LogFactory.getLog(WaterPollutionController.class);



	/**
	 * 사고관리 검색
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/waterPollutionMap.do")
	public String waterPollutionMap(ModelMap model, WaterPollutionSearchVO searchVO, HttpServletRequest request) throws Exception {
		//169D1986DF776F074463C93EDFCA4F49 
		//169D1986DF776F074463C93EDFCA4F49
		//System.out.println(request.getHeader("referer"));
		//System.out.println(request.getSession().getId());
		searchVO.setStartDate(ObjectUtil.getTimeString("yyyy") + "0101");
		searchVO.setEndDate(ObjectUtil.getTimeString("yyyyMMdd"));
		searchVO.setFirstIndex(0);
		searchVO.setRecordCountPerPage(10000);
		List list = waterPollutionService.getWaterPollutionList(searchVO);
		model.addAttribute("list", list);
		return "/waterpollution/waterPollutionMap";
	}
	
	
	/**
	 * 수질오염사고 목록 페이지
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/waterPollutionList.do")
	public ModelAndView waterPollutionList(
			Map<String, Object> commandMap
			, ModelMap model
			, HttpServletRequest request
			) throws Exception {
		
		String fromStats = "";
		String year = "";
		String riverDiv = "";
		String supportKind = "";
		String wpKind = "";
		String wpsStep = "";
		String statsStartDate = "";
		String statsEndDate = "";
		
		if(commandMap.get("fromStats") != null){
			fromStats		= (String) commandMap.get("fromStats");
			year			= (String) commandMap.get("year");
			riverDiv		= (String) commandMap.get("riverDiv");
			supportKind		= (String) commandMap.get("supportKind");
			wpKind			= (String) commandMap.get("wpKind");
			wpsStep			= (String) commandMap.get("wpsStep");
			statsStartDate	= (String) commandMap.get("statsStartDate");
			statsEndDate	= (String) commandMap.get("statsEndDate");
		}
	
		String sRiverDiv = request.getParameter("sRiverDiv");
		String sWpKind = request.getParameter("sWpKind");
		String sStartDate = request.getParameter("sStartDate");
		String sEndDate = request.getParameter("sEndDate");
		String sWpsStep = request.getParameter("sWpsStep");
		String sSupportKind = request.getParameter("sSupportKind");
		
		Map<String, String> searchCon = new HashMap();  
		 
		searchCon.put("sRiverDiv", sRiverDiv);
		searchCon.put("sWpKind", sWpKind);
		searchCon.put("sStartDate", sStartDate);
		searchCon.put("sEndDate", sEndDate);
		searchCon.put("sWpsStep", sWpsStep);
		searchCon.put("sSupportKind", sSupportKind);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject(fromStats);
		modelAndView.addObject(year);
		modelAndView.addObject(riverDiv);
		modelAndView.addObject(supportKind);
		modelAndView.addObject(wpKind);
		modelAndView.addObject(wpsStep);
		modelAndView.addObject(statsStartDate);
		modelAndView.addObject(statsEndDate);
		
		modelAndView.addObject("searchCon", searchCon);
		
		modelAndView.setViewName("/waterpollution/waterPollutionList");
		return modelAndView;
	}	
	
	/**
	 * 수질오염사고 목록 페이지 DATA
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/getWaterPollutionList.do")
	public ModelAndView getWaterPollutionList(
			  @ModelAttribute("loginVO") LoginVO loginVO
			  ,@ModelAttribute("searchVO") WaterPollutionSearchVO searchVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		//2014-10-27 mypark 페이징 처리
		//searchVO.setPageUnit(100000);
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List list = waterPollutionService.getWaterPollutionList(searchVO);
		int totCnt = waterPollutionService.getWaterPollutionListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("list", list);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 수질오염리포트  목록 페이지
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/waterPollutionReportList.do")
	public String waterPollutionReportList(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/waterpollution/waterPollutionReportList";
	}
	
	/**
	 * 수질오염리포트 상세 내용 가져오기
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/waterPollutionReportDetail.do")
	public ModelAndView waterPollutionReportDetail(
			@ModelAttribute("loginVO") LoginVO loginVO
			, @ModelAttribute("searchVO") WaterPollutionReportSearchVO searchVO
			) throws Exception {
		
		PaginationInfo paginationInfo = new PaginationInfo();
		
		/** paging */
		searchVO.setPageUnit(100000);
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List<WaterPollutionReportVO> list = waterPollutionService.getWaterPollutionReportList(searchVO);
		int totCnt = waterPollutionService.getWaterPollutionReportListCnt(searchVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("resultList", list);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}

	/**
	 * 수질오염리포트 수정 페이지
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/waterPollutionReportModify.do")
	public String waterPollutionModify(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/waterpollution/waterPollutionReportModify";
	}
	

	/**
	 * 수질오염리포트 삭제 페이지
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/waterPollutionDelete.do")
	public String waterPollutionDelete(@ModelAttribute("searchVO") WaterPollutionSearchVO searchVO
			,HttpServletResponse response
			,Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		waterPollutionService.deleteWaterPollution(searchVO);
		response.setContentType("text/html; charset=UTF-8");
		response.getWriter().print("<script>alert('삭제하였습니다.');document.location.href='/waterpollution/waterPollutionList.do'</script>");
		return null;
	}
	
	/**
	 * 수질오염사고 접수 페이지
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/waterPollutionRegist.do")
	public String waterPollutionRegist(@ModelAttribute("waterPollutionSearchVO") WaterPollutionSearchVO waterPollutionSearchVO, Map<String, Object> commandMap , ModelMap model ) throws Exception {
		WaterPollutionVO  View = new WaterPollutionVO ();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("wpCode",waterPollutionSearchVO.getWpCode());

		List list = waterPollutionService.getWaterPollutionDetail(map);
		if(list.size() > 0) View = (WaterPollutionVO )list.get(0);
		
		model.addAttribute("View", View);
		model.addAttribute("param_s", waterPollutionSearchVO);
		
		return "/waterpollution/waterPollutionRegist";
	}
	
	/**
	 * 로그인 사용자 정보 가져오기.
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/getLoginMemberInfo.do")
	public ModelAndView itemManageGroupCode(
			Map<String, Object> commandMap
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		LoginVO user = null;
		user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("user_id", user.getId());
		
		List codes = waterPollutionService.getLoginMemberInfo(map);
		
		modelAndView.addObject("codes", codes);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}	
	
	/*@RequestMapping("/waterpollution/waterpollutionRegProc.do")
	public ModelAndView waterpollutionRegProc(
			HttpServletRequest req,
			HttpServletResponse res
			,@RequestParam(value="wpCode",		 required=false) String wpCode
			,@RequestParam(value="memberId",		 required=false) String members
			,@RequestParam(value="smsContent",		 required=false) String smsContent
			,@RequestParam(value="riverDiv",		 required=false) String riverDiv
			,@RequestParam(value="addrDet",			 required=false) String addrDet
			,@RequestParam(value="reportDate",		required=false) String reportDate
			,@RequestParam(value="reportHour",		required=false) String reportHour
			,@RequestParam(value="reportMin",		required=false) String reportMin
			,@RequestParam(value="receiveDate",	  required=false) String receiveDate
			,@RequestParam(value="receiveHour",	  required=false) String receiveHour
			,@RequestParam(value="receiveMin",		required=false) String receiveMin
			,@ModelAttribute("waterPollutionVO")	 WaterPollutionVO waterPollutionVO
			,@ModelAttribute("waterPollutionStepVO") WaterPollutionStepVO waterPollutionStepVO
			)throws Exception{ 
		
		String[] memberId = members.split(",");
		
		int smsResult = 0;
		int smsResult2 = 0;

		boolean onetouchmode = true;
		if(null == wpCode){
			onetouchmode = false;
		}
		//신고 날짜 셋팅
		if(!onetouchmode){
			reportDate = reportDate.replaceAll("/", "");
			reportDate = reportDate + reportHour + reportMin;
			
			waterPollutionVO.setReportDate(reportDate);
			
			String tempWpCode = waterPollutionService.getWaterPollutionCode();
			wpCode = "WP" + tempWpCode;
		}
		
		receiveDate = receiveDate.replaceAll("/", "");
		receiveDate = receiveDate + receiveHour + receiveMin;
		waterPollutionVO.setReceiveDate(receiveDate);
		
		waterPollutionVO.setWpCode(wpCode);

		//SMS 먼저 저장
		try{
			smsResult = SendSMS.sendRegSmsWaterPollution(wpCode,Integer.toString('0'), memberId, smsContent, "수질오염사고접수");
			
			HashMap<String, String> map = new HashMap<String, String>();
			
			map.put("smsContent", smsContent);
			map.put("wpCode", wpCode);
			
			for(int i=0 ; i < memberId.length ; i++ ){
				map.put("memberId", memberId[i]);
				smsResult2 = waterPollutionService.inserttWaterPollutionSmsInfo(map);

				AlrimVO alrimVO = new AlrimVO();
				alrimVO.setAlrimGubun("P");			
				alrimVO.setAlrimTitle("사고가 접수 되었습니다.");			
				alrimVO.setAlrimLink("/waterpollution/waterPollutionDetail.do?wpCode="+wpCode);			
				alrimVO.setAlrimMenuId(32120);			
				alrimVO.setAlrimWriterId(LogInfoUtil.GetSessionLogin(req).getId());			
				alrimVO.setAlrimApprovalId(memberId[i]);
				alrimService.insertAlrim(alrimVO);
			}

			//log.debug("smsResult2>>>>>>>>>>>>>>>>>>>>>>>>>" + smsResult2);
		}
		catch(Exception ex){
			if(log.isDebugEnabled()){
				log.debug(ex.getMessage() + ex.getStackTrace());
			} 
		}
		
		try{
			int resultOk = 0; 
			if (smsResult < 0 ) {
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('경보 대상자가 없어서 SMS전송이  실패했습니다.');document.location.href='/waterpollution/waterPollutionList.do'</script>");
			}else if(smsResult2 == 0){
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('SMS저장에 실패했습니다.');document.location.href='/waterpollution/waterPollutionList.do'</script>");
			}else{			
				//원터치가 아닐경우 일반등록
				//원터치 일경우에는 수정
				if(!onetouchmode){
					waterPollutionService.inserttWaterPollutionInfo(waterPollutionVO);
					waterPollutionStepVO.setWpsCode("1");
				}
				else{
					waterPollutionService.modifyWaterPollution(waterPollutionVO);

					HashMap map = new HashMap<String, String>();
					map.put("wpCode", wpCode);
					String nextStep = waterPollutionService.getWaterPollutionNextStep(map);
					waterPollutionStepVO.setWpsCode(nextStep);
					
				}

				receiveDate = receiveDate.replaceAll("/", "");
				receiveDate = receiveDate + receiveHour + receiveMin;
				
				waterPollutionStepVO.setWpCode(wpCode);
				waterPollutionStepVO.setWpsStep("RCV");
				waterPollutionStepVO.setWpsStepDate(receiveDate.substring(0, 8));
				waterPollutionStepVO.setWpsContent("수질오염사고 접수");
				waterPollutionStepVO.setWpsImg("");
				
				waterPollutionService.inserttWaterPollutionStepInfo(waterPollutionStepVO);

				resultOk++;
			} 
			if(resultOk  > 0) {
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('처리되었습니다.');document.location.href='/waterpollution/waterPollutionList.do'</script>");
			} else{ 
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('ERROR');document.location.href='/waterpollution/waterPollutionList.do'</script>");
			} 
		}catch(Exception e){
			e.printStackTrace();
		}		
		return null;
	}
	*/
	@RequestMapping("/waterpollution/waterpollutionRegProc.do")
	public ModelAndView waterpollutionRegProc(
			final MultipartHttpServletRequest multiRequest
			, HttpServletResponse res
			,@RequestParam(value="wpCode",		 required=false) String wpCode
			,@RequestParam(value="memberId",		 required=false) String members
			,@RequestParam(value="smsContent",		 required=false) String smsContent
			,@RequestParam(value="riverDiv",		 required=false) String riverDiv
			,@RequestParam(value="addrDet",			 required=false) String addrDet
			,@RequestParam(value="reportDate",		required=false) String reportDate
			,@RequestParam(value="reportHour",		required=false) String reportHour
			,@RequestParam(value="reportMin",		required=false) String reportMin
			,@RequestParam(value="receiveDate",	  required=false) String receiveDate
			,@RequestParam(value="receiveHour",	  required=false) String receiveHour
			,@RequestParam(value="receiveMin",		required=false) String receiveMin
			,@ModelAttribute("waterPollutionVO")	 WaterPollutionVO waterPollutionVO
			,@ModelAttribute("waterPollutionStepVO") WaterPollutionStepVO waterPollutionStepVO
			)throws Exception{ 
		
		String[] memberId = members.split(",");
		
		int smsResult = 0;
		int smsResult2 = 0;

		boolean onetouchmode = true;
		if(null == wpCode){
			onetouchmode = false;
		}
		//신고 날짜 셋팅
		if(!onetouchmode){
			reportDate = reportDate.replaceAll("/", "");
			reportDate = reportDate + reportHour + reportMin;
			
			waterPollutionVO.setReportDate(reportDate);
			
			String tempWpCode = waterPollutionService.getWaterPollutionCode();
			wpCode = "WP" + tempWpCode;
		}
		
		receiveDate = receiveDate.replaceAll("/", "");
		receiveDate = receiveDate + receiveHour + receiveMin;
		waterPollutionVO.setReceiveDate(receiveDate);
		
		waterPollutionVO.setWpCode(wpCode);

		//SMS 먼저 저장
		try{
			smsResult = SendSMS.sendRegSmsWaterPollution(wpCode,Integer.toString('0'), memberId, smsContent, "수질오염사고접수");
			
			HashMap<String, String> map = new HashMap<String, String>();
			
			map.put("smsContent", smsContent);
			map.put("wpCode", wpCode);
			
			for(int i=0 ; i < memberId.length ; i++ ){
				map.put("memberId", memberId[i]);
				smsResult2 = waterPollutionService.inserttWaterPollutionSmsInfo(map);

				AlrimVO alrimVO = new AlrimVO();
				alrimVO.setAlrimGubun("P");			
				alrimVO.setAlrimTitle("사고가 접수 되었습니다.");			
				alrimVO.setAlrimLink("/waterpollution/waterPollutionDetail.do?wpCode="+wpCode);			
				alrimVO.setAlrimMenuId(32120);			
				alrimVO.setAlrimWriterId(LogInfoUtil.GetSessionLogin().getId());			
				alrimVO.setAlrimApprovalId(memberId[i]);
				alrimService.insertAlrim(alrimVO);
			}

			//log.debug("smsResult2>>>>>>>>>>>>>>>>>>>>>>>>>" + smsResult2);
		}
		catch(Exception ex){
			if(log.isDebugEnabled()){
				log.debug(ex.getMessage() + ex.getStackTrace());
			} 
		}
		
		try{
			int resultOk = 0; 
			if (smsResult < 0 ) {
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('경보 대상자가 없어서 SMS전송이  실패했습니다.');document.location.href='/waterpollution/waterPollutionList.do'</script>");
			}else if(smsResult2 == 0){
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('SMS저장에 실패했습니다.');document.location.href='/waterpollution/waterPollutionList.do'</script>");
			}else{			
				//원터치가 아닐경우 일반등록
				//원터치 일경우에는 수정
				if(!onetouchmode){
					
					//첨부파일 저장 
					List<FileVO> result = null;
					String atchFileId = "";
					final Map<String, MultipartFile> files = multiRequest.getFileMap();
					if (!files.isEmpty()) {
						result = fileUtil.parseFileInf(files, "FILE_", 0, "", "");
						atchFileId = fileMngService.insertFileInfs(result);
					}
					waterPollutionVO.setAtchFileId(atchFileId);
					
					waterPollutionService.inserttWaterPollutionInfo(waterPollutionVO);
					waterPollutionStepVO.setWpsCode("1");
				}
				else{
					waterPollutionService.modifyWaterPollution(waterPollutionVO);

					HashMap map = new HashMap<String, String>();
					map.put("wpCode", wpCode);
					String nextStep = waterPollutionService.getWaterPollutionNextStep(map);
					waterPollutionStepVO.setWpsCode(nextStep);
					
				}

				receiveDate = receiveDate.replaceAll("/", "");
				receiveDate = receiveDate + receiveHour + receiveMin;
				
				waterPollutionStepVO.setWpCode(wpCode);
				waterPollutionStepVO.setWpsStep("RCV");
				waterPollutionStepVO.setWpsStepDate(receiveDate.substring(0, 8));
				waterPollutionStepVO.setWpsContent("수질오염사고 접수");
				waterPollutionStepVO.setWpsImg("");
				
				
				
				waterPollutionService.inserttWaterPollutionStepInfo(waterPollutionStepVO);

				resultOk++;
			} 
			if(resultOk  > 0) {
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('처리되었습니다.');document.location.href='/waterpollution/waterPollutionList.do'</script>");
			} else{ 
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('ERROR');document.location.href='/waterpollution/waterPollutionList.do'</script>");
			} 
		}catch(Exception e){
			e.printStackTrace();
		}		
		return null;
	}
	
	/**
	 * 수질오염사고 상세 페이지
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/waterPollutionDetail.do")
	public ModelAndView waterPollutionDetail(
			 Map<String, Object> commandMap
			,@RequestParam(value="wpCode", required=false) String wpCode
			, ModelMap model
			) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("wpCode", wpCode);
		//System.out.println("######################### waterPollutionDetail s#########################");
		//System.out.println(commandMap);
		//System.out.println("######################### waterPollutionDetail s#########################");
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("wpCode",wpCode);
		map.put("memberId",user.getId());
		waterPollutionService.insertWaterPollutionCheckAlrim(map);
		
		WaterPollutionVO waterPollutionVO = new WaterPollutionVO();
		
		String atchFileId = waterPollutionService.selectWaterPollutionFile(wpCode);
		
		int cnt = waterPollutionService.selectWaterPollutionFileCnt(atchFileId);
		
		if(cnt>0){
			waterPollutionVO.setFileAtchPosblAt("N");
		}else{
			waterPollutionVO.setFileAtchPosblAt("Y");
		}
		
		waterPollutionVO.setAtchFileId(atchFileId);
		
		modelAndView.addObject("waterPollutionVO", waterPollutionVO);
		modelAndView.addObject("searchCon", commandMap);
		modelAndView.setViewName("waterpollution/waterPollutionDetail");
		
		return modelAndView;
	}
	
	/**
	 * 수질오염사고 상세 내용 가져오기
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/getWaterPollutionDetail.do")
	public ModelAndView getWaterPollutionDetail(
			 Map<String, Object> commandMap
			,@RequestParam(value="wpCode", required=false) String wpCode
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("wpCode",wpCode);
		
		List <WaterPollutionVO> wpDetail = waterPollutionService.getWaterPollutionDetail(map);

		modelAndView.addObject("wpDetail", wpDetail);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 수질오염사고 상세 SMS 가져오기
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/getWaterPollutionSms.do")
	public ModelAndView getWaterPollutionSms(
			 Map<String, Object> commandMap
			,@RequestParam(value="wpCode", required=false) String wpCode
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("wpCode",wpCode);
		
		List <WaterPollutionVO> wpSms= waterPollutionService.getWaterPollutionSms(map);
		
		//특수문자 치환
		for (int i=0; i < wpSms.size(); i++) {
			wpSms.get(i).setSmsContent(StringUtil.getHtmlStrCnvr(wpSms.get(i).getSmsContent()));
		}
		
		modelAndView.addObject("wpSms", wpSms);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 수질오염사고 상세 수습경과 가져오기
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/getWaterPollutionStep.do")
	public ModelAndView getWaterPollutionStep(
			 Map<String, Object> commandMap
			,@RequestParam(value="wpCode", required=false) String wpCode
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("wpCode",wpCode);
		
		List <WaterPollutionVO> wpSms= waterPollutionService.getWaterPollutionStep(map);
		
		modelAndView.addObject("wpStep", wpSms);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 수질오염사고 상세 수습경과별 이미지 가져오기
	 * @param commandMap
	 * @param wpCode
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/getWaterPollutionImg.do")
	public ModelAndView getWaterPollutionImg(
			 Map<String, Object> commandMap
			,@RequestParam(value="wpCode", required=false) String wpCode
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("wpCode",wpCode);
		
		List <WaterPollutionVO> wpImg= waterPollutionService.getWaterPollutionImg(map);
		
		modelAndView.addObject("wpImg", wpImg);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 수질오염사고 수습(조치) 경과 추가 팝업페이지
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/waterPollutionStepPopup.do")
	public String waterPollutionStepPopup(
			 Map<String, Object> commandMap
			,@RequestParam(value="wpCode", required=false) String wpCode
			, ModelMap model
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("wpCode", wpCode);
		
		return "/waterpollution/waterPollutionStepPopup";
	}
	
	/**
	 * 수질오염사고 수습(조치) 경과 추가하기
	 * @param req
	 * @param res
	 * @param wpCode
	 * @param wpsStep
	 * @param wpsContent
	 * @param waterPollutionStepVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/addWaterpollutionStep.do")
	public ModelAndView addWaterpollutionStep(
			 final MultipartHttpServletRequest multiRequest, 
			 HttpServletRequest req,
			 HttpServletResponse res
			,@RequestParam(value="wpCode",		 required=false) String wpCode
			,@RequestParam(value="wpsStep",		 required=false) String wpsStep
			,@RequestParam(value="wpsContent",	 required=false) String wpsContent
			,@ModelAttribute("waterPollutionStepVO") WaterPollutionStepVO waterPollutionStepVO
		)throws Exception{
				
		try{
			int resultOk = 0; 
			
			HashMap map = new HashMap<String, String>();
			map.put("wpCode", wpCode);
			
			//수습(조치)단계의 최대값 가져오기.
			String nextStep = waterPollutionService.getWaterPollutionNextStep(map);
			
			waterPollutionStepVO.setWpCode(wpCode);
			waterPollutionStepVO.setWpsCode(nextStep);
			waterPollutionStepVO.setWpsStep(wpsStep);
			waterPollutionStepVO.setWpsContent(wpsContent);
			
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			
			if(files !=null){
				if (!files.isEmpty()) {
					List<FileVO> result = fileUtil.parseWpStepFileInf(files, "wpStep_", 0, "", "");
					String atchFileId	= waterPollutionService.insertWpsStepFileInfs(result);
					//alertStepVO.setAtchFileId(atchFileId);
					
					waterPollutionStepVO.setWpsImg(atchFileId); //
				}
			}
			
			waterPollutionService.inserttWaterPollutionStepInfo(waterPollutionStepVO);
			
			resultOk++;

			if(resultOk  > 0) {
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('저장되었습니다.'); window.opener.getWpStepData('"+waterPollutionStepVO.getWpCode()+"');window.close();</script>");
//				res.getWriter().print("<script>alert('저장되었습니다.'); window.opener.location.reload();window.close();</script>");
			} else{ 
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('Error'); window.opener.location.reload(); window.close(); </script>"); 
			} 
		}catch(Exception e){
			e.printStackTrace();
		}		
		return null;
	}
	
	/**
	 * 수질오염사고 수습(조치) 경과 수정 팝업페이지
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/waterPollutionStepModifyPopup.do")
	public String waterPollutionStepModifyPopup(
			 Map<String, Object> commandMap
			,@RequestParam(value="wpCode", required=false) String wpCode
			,@RequestParam(value="wpsCode", required=false) String wpsCode
			, ModelMap model
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("wpCode", wpCode);
		modelAndView.addObject("wpsCode", wpsCode);
		
		return "/waterpollution/waterPollutionStepModifyPopup";
	}
	
	
	/**
	 * 수질오염사고 상세 수습경과 가져오기
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/waterPollutionStepModifyInfo.do")
	public ModelAndView waterPollutionStepModifyInfo(
			 Map<String, Object> commandMap
			,@RequestParam(value="wpCode", required=false) String wpCode
			,@RequestParam(value="wpsCode", required=false) String wpsCode
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("wpCode",wpCode);
		map.put("wpsCode",wpsCode);
		
		List <WaterPollutionVO> detail = waterPollutionService.waterPollutionStepModifyInfo(map);
		
		modelAndView.addObject("detail", detail);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 사고조치단계 수정
	 * @param req
	 * @param res
	 * @param waterPollutionStepVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/modifyWaterPollutionStep.do")
	public ModelAndView modifyWaterPollutionStep(
			 final MultipartHttpServletRequest multiRequest,
			 HttpServletRequest req,
			 HttpServletResponse res
			,@RequestParam(value="wpsImg", required=false) String wpsImg
			,@ModelAttribute("waterPollutionStepVO") WaterPollutionStepVO waterPollutionStepVO
		)throws Exception{
				
		try{
			int resultOk = 0;
			
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			
			if(wpsImg == null || wpsImg.equals("")) {
				if(files !=null){
					if (!files.isEmpty()) {
						List<FileVO> result = fileUtil.parseWpStepFileInf(files, "wpStep_", 0, "", ""); 
						String atchFileId	= waterPollutionService.insertWpsStepFileInfs(result);
						
						waterPollutionStepVO.setWpsImg(atchFileId);
					}
				}
			}else{
				waterPollutionStepVO.setWpsImg(wpsImg);
			}
			
			waterPollutionService.modifyWaterPollutionStep(waterPollutionStepVO);
			
			resultOk++;
			if(resultOk  > 0) {
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('수정되었습니다.'); window.opener.getWpStepData('"+waterPollutionStepVO.getWpCode()+"');window.close();</script>");
			} else{ 
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('Error'); window.opener.location.reload(); window.close(); </script>");
			} 
//			if(resultOk  > 0) {
//				res.setContentType("text/html; charset=UTF-8");
//				res.getWriter().print("<script>alert('수정되었습니다.'); window.opener.location.reload();window.close();</script>");
//			} else{ 
//				res.setContentType("text/html; charset=UTF-8");
//				res.getWriter().print("<script>alert('Error'); window.opener.location.reload(); window.close(); </script>");
//			} 
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 수습(조치)경과 수정.
	 * @param req
	 * @param res
	 * @param waterPollutionVO
	 * @return
	 * @throws Exception
	 */
	/*@RequestMapping("/waterpollution/waterPollutionModify.do")
	public ModelAndView waterPollutionModify(
			 HttpServletRequest req,
			 HttpServletResponse res
			,@ModelAttribute("waterPollutionStepVO") WaterPollutionVO waterPollutionVO
		)throws Exception{
		
		try{
			int resultOk = 0;
			
			waterPollutionService.modifyWaterPollution(waterPollutionVO);
			
			resultOk++;
			
			//"<c:url value='/waterpollution/waterPollutionDetail.do?wpCode='/>" + wpCode;
			
			if(resultOk  > 0){
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('수정되었습니다.'); document.location.href='/waterpollution/waterPollutionList.do';</script>");
//				res.getWriter().print("<script>alert('삭제되었습니다.'); document.location.href= '/waterpollution/waterPollutionDetail.do?wpCode="+waterPollutionVO.getWpCode()+"';</script>");
			} else{ 
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('Error');document.location.href='/waterpollution/waterPollutionList.do';</script>");
			
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	*/
	
	@RequestMapping("/waterpollution/waterPollutionModify.do")
	public ModelAndView waterPollutionModify(
			 final MultipartHttpServletRequest multiRequest,
			 HttpServletResponse res
			,@ModelAttribute("waterPollutionStepVO") WaterPollutionVO waterPollutionVO
		)throws Exception{
		
		try{
			int resultOk = 0;
			
			//첨부파일 저장 
			List<FileVO> result = null;
			String atchFileId = "";
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			if (!files.isEmpty()) {
				result = fileUtil.parseFileInf(files, "FILE_", 0, "", "");
				atchFileId = fileMngService.insertFileInfs(result);
			}
			waterPollutionVO.setAtchFileId(atchFileId);
			
			waterPollutionService.modifyWaterPollution(waterPollutionVO);
			
			resultOk++;
			
			//"<c:url value='/waterpollution/waterPollutionDetail.do?wpCode='/>" + wpCode;
			
			if(resultOk  > 0){
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('수정되었습니다.'); document.location.href='/waterpollution/waterPollutionList.do';</script>");
//				res.getWriter().print("<script>alert('삭제되었습니다.'); document.location.href= '/waterpollution/waterPollutionDetail.do?wpCode="+waterPollutionVO.getWpCode()+"';</script>");
			} else{ 
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('Error');document.location.href='/waterpollution/waterPollutionList.do';</script>");
			
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 수습(조치)경과 wps_code 수정.
	 * @param req
	 * @param res
	 * @param waterPollutionVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/waterPollutionModifyWps_code.do")
	public ModelAndView waterPollutionModifyWps_code(
			 HttpServletRequest req,
			 HttpServletResponse res
			 ,@RequestParam(value="wpCode", required=false) String wpCode
			,@RequestParam(value="modifyWpsCode", required=false) String modifyWpsCode
			,@RequestParam(value="wpsCode", required=false) String wpsCode
			,@RequestParam(value="reg_date", required=false) String reg_date
			
		)throws Exception{
		
		try{
			int resultOk = 0;
			
			HashMap<String, String> map = new HashMap<String,String>();
			map.put("modifyWpsCode", modifyWpsCode);
			map.put("wpsCode", wpsCode);
			map.put("reg_date", reg_date);
			map.put("wpCode", wpCode);
			
			waterPollutionService.modifyWaterPollutionStepWPS_Code(map);
			
			resultOk++;
			ModelAndView modelAndView = new ModelAndView();
			modelAndView.addObject("wpUpdate", resultOk);
			modelAndView.setViewName("jsonView");
			return modelAndView;
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 사진삭제
	 * @param commandMap
	 * @param wpCode
	 * @param wpsCode
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/deleteWaterPollutionStepImg.do")
	public ModelAndView deleteWaterPollutionStepImg(
			 Map<String, Object> commandMap
			,@RequestParam(value="wpCode", required=false) String wpCode
			,@RequestParam(value="wpsCode", required=false) String wpsCode
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("wpCode",wpCode);
		map.put("wpsCode",wpsCode);
		
		int result = waterPollutionService.deleteWaterPollutionStepImg(map);
		
		modelAndView.addObject("result", result);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 수습(조치)경과 삭제
	 * @param req
	 * @param res
	 * @param waterPollutionVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/deleteWaterPollutionStep.do")
	public ModelAndView deleteWaterPollutionStep(
			 final MultipartHttpServletRequest multiRequest,
			 HttpServletRequest req,
			 HttpServletResponse res
			,@ModelAttribute("waterPollutionStepVO") WaterPollutionStepVO waterPollutionStepVO
		)throws Exception{
				
		try{
			int resultOk = 0;
			
			waterPollutionService.deleteWaterPollutionStep(waterPollutionStepVO);
			
			resultOk++;
			
			if(resultOk  > 0) {

				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('삭제되었습니다.'); window.opener.getWpStepData('"+waterPollutionStepVO.getWpCode()+"');window.close();</script>");
//				res.getWriter().print("<script>alert('삭제되었습니다.'); window.opener.location.reload();window.close();</script>");	
				
			} else{ 
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('Error'); window.opener.location.reload(); window.close(); </script>"); 
			} 
		}catch(Exception e){
			e.printStackTrace();
		}		
		return null;
	}
	
	/**
	 * 수질오염사고 통계 페이지
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/waterPollutionStats.do")
	public String waterPollutionStats(
			Map<String, Object> commandMap
			, ModelMap model
			) throws Exception {
		
		return "/waterpollution/waterPollutionStats";
	}
	
	/**
	 * 수질오염사고 통계 페이지 DATA
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/getWaterPollutionStats.do")
	public ModelAndView getWaterPollutionStats(
			  @ModelAttribute("loginVO") LoginVO loginVO
			  ,@ModelAttribute("searchVO") WaterPollutionSearchVO searchVO
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		
		searchVO.setPageUnit(10);
		searchVO.setPageSize(propertiesService.getInt("pageSize"));

		/** pageing */
		PaginationInfo paginationInfo = new PaginationInfo();
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		paginationInfo.setPageSize(searchVO.getPageSize());
		
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		List list = waterPollutionService.getWaterPollutionStats(searchVO);
		//int totCnt = waterPollutionService.getWaterPollutionStats(searchVO);
		//paginationInfo.setTotalRecordCount(totCnt);
		
		modelAndView.addObject("list", list);
		//modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 수질오염사고 상세 페이지 출력팝업
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/waterPollutionDetailPrint.do")
	public String waterPollutionDetailPrint(
			 Map<String, Object> commandMap
			,@RequestParam(value="wpCode", required=false) String wpCode
			, ModelMap model
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("wpCode", wpCode);
		
		return "/waterpollution/waterPollutionDetailPrint";
	}
	
	/**
	 * 수질오염사고  통계 페이지 출력팝업
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/waterPollutionStatsPrint.do")
	public String waterPollutionStatsPrint(
			 Map<String, Object> commandMap
			,@RequestParam(value="startDate",		required=false) String startDate
			,@RequestParam(value="endDate",			required=false) String endDate
			,@RequestParam(value="searchRiverDiv",	required=false) String searchRiverDiv
			,@RequestParam(value="searchWpKind",	required=false) String searchWpKind
			, ModelMap model
			) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("startDate",		startDate);
		modelAndView.addObject("endDate",		endDate);
		modelAndView.addObject("searchRiverDiv", searchRiverDiv);
		modelAndView.addObject("searchWpKind",	searchWpKind);
		
		return "/waterpollution/waterPollutionStatsPrint";
	}
	
	//수계별 차트
	@RequestMapping("/waterpollution/waterPollutionStatsChartRiver.do")
	public ModelAndView waterPollutionStatsChartRiver(
			 @RequestParam(value="width", required=false) String width
			,@RequestParam(value="height", required=false) String height
			,@RequestParam(value="hiddenEndDate", required=false) String hiddenEndDate
			,@RequestParam(value="hiddenStartDate", required=false) String hiddenStartDate
			
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	

		WaterPollutionSearchVO waterPollutionSearchVO = new WaterPollutionSearchVO();
		
		//cmnLogCounterVO.setFrDate("2013/04/01");
		waterPollutionSearchVO.setStartDate(hiddenStartDate);
		waterPollutionSearchVO.setEndDate(hiddenEndDate);
	
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("river");
		
		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("수계별");
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 1;
		
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}
		
		waterPollutionSearchVO.setStartDate(hiddenStartDate);
		waterPollutionSearchVO.setEndDate(hiddenEndDate);
		
		List <WaterPollutionVO> graphDataListRiver  = waterPollutionService.getWaterPollutionStatsChartRiver(waterPollutionSearchVO);
		//List <WaterPollutionVO> graphDataListYear	= waterPollutionService.getWaterPollutionStatsChartYear(waterPollutionSearchVO);
		//List <WaterPollutionVO> graphDataListWpKind = waterPollutionService.getWaterPollutionStatsChartWpKind(waterPollutionSearchVO);
		
		int voCount = 0;
		
		for(WaterPollutionVO detailData : graphDataListRiver) {
			if(detailData.getCnt() != null){
				List data =  dataMap.get("river");
				Map valMap = new HashMap();
				valMap = new HashMap();
				valMap.put("x", detailData.getRiverDiv());
				valMap.put("y", detailData.getCnt());
				data.add(valMap);
				dataMap.put("river", data);
				voCount++;
			}
		}
		
		if(voCount == 0){
			itemNameList = new ArrayList<String>();
			itemCodeList = new ArrayList<String>();
			
			itemNameList.add("조회결과가 없습니다");
			itemCodeList.add("T");
			
			for(int i = 0 ; i < 20 ; i++)
			{
				List data = dataMap.get("T");
				
				Map valMap = new HashMap();
				valMap.put("x",  "");
				valMap.put("y", "0");
				data.add(valMap);
				dataMap.put("river", data);
				
				voCount ++;
			}
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		StringBuffer title = new StringBuffer();
		title.append("");
		
		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 4);  
		//modelAndView.addObject("sys", sys_kind);
		
		//if(sys_kind.equals("A"))
		//	modelAndView.addObject("legBox","N");
		//else
		modelAndView.addObject("legBox", "Y");
		
		modelAndView.setViewName("waterPollutionStatsChartRiverView");
		
		return modelAndView;
	}
	
	//년도별 차트
	@RequestMapping("/waterpollution/waterPollutionStatsChartYear.do")
	public ModelAndView waterPollutionStatsChartYear(
			 @RequestParam(value="width", required=false) String width
			,@RequestParam(value="height", required=false) String height
			,@RequestParam(value="hiddenEndDate", required=false) String hiddenEndDate
			,@RequestParam(value="hiddenStartDate", required=false) String hiddenStartDate
			
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	

		WaterPollutionSearchVO waterPollutionSearchVO = new WaterPollutionSearchVO();
		
		//cmnLogCounterVO.setFrDate("2013/04/01");
		waterPollutionSearchVO.setStartDate(hiddenStartDate);
		waterPollutionSearchVO.setEndDate(hiddenEndDate);
	
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("year");
		
		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("년도별");
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 1;
		
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}
		
		waterPollutionSearchVO.setStartDate(hiddenStartDate);
		waterPollutionSearchVO.setEndDate(hiddenEndDate);
		
		//List <WaterPollutionVO> graphDataListRiver  = waterPollutionService.getWaterPollutionStatsChartRiver(waterPollutionSearchVO);
		List <WaterPollutionVO> graphDataListYear	= waterPollutionService.getWaterPollutionStatsChartYear(waterPollutionSearchVO);
		//List <WaterPollutionVO> graphDataListWpKind = waterPollutionService.getWaterPollutionStatsChartWpKind(waterPollutionSearchVO);
		
		int voCount = 0;
		
		for(WaterPollutionVO detailData : graphDataListYear) {
			if(detailData.getCnt() != null){
				List data =  dataMap.get("year");
				Map valMap = new HashMap();
				valMap = new HashMap();
				valMap.put("x", detailData.getYear());
				valMap.put("y", detailData.getCnt());
				data.add(valMap);
				dataMap.put("year", data);
				voCount++;
			}
		}
		
		if(voCount == 0){
			itemNameList = new ArrayList<String>();
			itemCodeList = new ArrayList<String>();
			
			itemNameList.add("조회결과가 없습니다");
			itemCodeList.add("T");
			
			for(int i = 0 ; i < 20 ; i++)
			{
				List data = dataMap.get("T");
				
				Map valMap = new HashMap();
				valMap.put("x",  "");
				valMap.put("y", "0");
				data.add(valMap);
				dataMap.put("year", data);
				
				voCount ++;
			}
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		StringBuffer title = new StringBuffer();
		title.append("");
		
		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 4);  
		//modelAndView.addObject("sys", sys_kind);
		
		//if(sys_kind.equals("A"))
		//	modelAndView.addObject("legBox","N");
		//else
		modelAndView.addObject("legBox", "Y");
		
		modelAndView.setViewName("waterPollutionStatsChartYearView");
		
		return modelAndView;
	}
	
	//사고종류별 차트
	@RequestMapping("/waterpollution/waterPollutionStatsChartWpKind.do")
	public ModelAndView waterPollutionStatsChartWpKind(
			 @RequestParam(value="width", required=false) String width
			,@RequestParam(value="height", required=false) String height
			,@RequestParam(value="hiddenEndDate", required=false) String hiddenEndDate
			,@RequestParam(value="hiddenStartDate", required=false) String hiddenStartDate
			
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	

		WaterPollutionSearchVO waterPollutionSearchVO = new WaterPollutionSearchVO();
		
		//cmnLogCounterVO.setFrDate("2013/04/01");
		waterPollutionSearchVO.setStartDate(hiddenStartDate);
		waterPollutionSearchVO.setEndDate(hiddenEndDate);
	
		//itemCodeList
		List<String> itemCodeList = new ArrayList<String>();
		itemCodeList.add("wpKind");
		
		//itemNameList
		List<String> itemNameList = new ArrayList<String>();
		itemNameList.add("사고종류별");
		
		Map<String, List> dataMap = new HashMap();
		Map<String, String> constantMap = new HashMap();
		
		int itemCount = 1;
		
		for(String code : itemCodeList) {
			dataMap.put(code, new ArrayList());
			constantMap.put(code,null);
			//constantMap.put(code,new ArrayList());
			itemCount++;
		}
		
		waterPollutionSearchVO.setStartDate(hiddenStartDate);
		waterPollutionSearchVO.setEndDate(hiddenEndDate);
		
		//List <WaterPollutionVO> graphDataListRiver  = waterPollutionService.getWaterPollutionStatsChartRiver(waterPollutionSearchVO);
		//List <WaterPollutionVO> graphDataListYear	= waterPollutionService.getWaterPollutionStatsChartYear(waterPollutionSearchVO);
		List <WaterPollutionVO> graphDataListWpKind = waterPollutionService.getWaterPollutionStatsChartWpKind(waterPollutionSearchVO);
		
		int voCount = 0;
		
		for(WaterPollutionVO detailData : graphDataListWpKind) {
			if(detailData.getCnt() != null){
				List data =  dataMap.get("wpKind");
				Map valMap = new HashMap();
				valMap = new HashMap();
				valMap.put("x", detailData.getWpKind());
				valMap.put("y", detailData.getCnt());
				data.add(valMap);
				dataMap.put("wpKind", data);
				voCount++;
			}
		}		
		
		if(voCount == 0){
			itemNameList = new ArrayList<String>();
			itemCodeList = new ArrayList<String>();
			
			itemNameList.add("조회결과가 없습니다");
			itemCodeList.add("T");
			
			for(int i = 0 ; i < 20 ; i++)
			{
				List data = dataMap.get("T");
				
				Map valMap = new HashMap();
				valMap.put("x",  "");
				valMap.put("y", "0");
				data.add(valMap);
				dataMap.put("wpKind", data);
				
				voCount ++;
			}
		}
		
		Integer itemDataSize = new Integer(voCount/itemCount);
		
		StringBuffer title = new StringBuffer();
		title.append("");
		
		modelAndView.addObject("title", title.toString());
		modelAndView.addObject("itemNameList",itemNameList);
		modelAndView.addObject("itemCodeList",itemCodeList);
		modelAndView.addObject("itemDataSize",itemDataSize);
		modelAndView.addObject("width",width);
		modelAndView.addObject("height",height);
		modelAndView.addObject("itemDataMap", dataMap);
		modelAndView.addObject("constLine", "N");
		modelAndView.addObject("constantMap", constantMap);
		modelAndView.addObject("chartType", 4);
		//modelAndView.addObject("sys", sys_kind);
		
		//if(sys_kind.equals("A"))
		//	modelAndView.addObject("legBox","N");
		//else
		modelAndView.addObject("legBox", "Y");
		
		modelAndView.setViewName("waterPollutionStatsChartWpKindView");
		
		return modelAndView;
	}
	
	
	/**
	 * 수질오염사고 목록 페이지 DATA
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/getAlertCnt.do")
	public ModelAndView getAlertCnt() throws Exception {
		List list = waterPollutionService.getAlertCnt2();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 수질오염사고 목록 페이지 DATA
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/getAlertCnt2.do")
	public ModelAndView getAlertCnt2() throws Exception {
		List list = waterPollutionService.getAlertCnt2();
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	

	
	/**
	 * 수질오염사고 목록 페이지 DATA
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/getWaterPollutionStatus.do")
	public ModelAndView getWaterPollutionStatus(WaterPollutionSearchVO waterPollutionSearchVO) throws Exception {
		LoginVO user = null;
		user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		waterPollutionSearchVO.setRiverDiv(user.getRiverId());
		List list = waterPollutionService.getWaterPollutionStatus(waterPollutionSearchVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	

	
	/**
	 * 수질오염사고 목록 페이지 DATA
	 * @param commandMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/waterpollution/getWaterPollutionStatusList.do")
	public ModelAndView getWaterPollutionStatusList(WaterPollutionSearchVO waterPollutionSearchVO) throws Exception {
		LoginVO user = null;
		user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		waterPollutionSearchVO.setRiverDiv(user.getRiverId());
		List list = waterPollutionService.getWaterPollutionStatusList(waterPollutionSearchVO);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject(list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
}