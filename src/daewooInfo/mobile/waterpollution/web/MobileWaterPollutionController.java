package daewooInfo.mobile.waterpollution.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.alert.util.SendSMS;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.common.alrim.bean.AlrimVO;
import daewooInfo.common.alrim.service.AlrimService;
import daewooInfo.common.util.EgovFileMngUtil;
import daewooInfo.mobile.com.utl.LogInfoUtil;
import daewooInfo.mobile.com.utl.ObjectUtil;
import daewooInfo.waterpollution.bean.WaterPollutionSearchVO;
import daewooInfo.waterpollution.bean.WaterPollutionStepVO;
import daewooInfo.waterpollution.bean.WaterPollutionVO;
import daewooInfo.waterpollution.service.WaterPollutionService;

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
public class MobileWaterPollutionController {	

	/**
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
	 * 사고관리 검색
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/waterpollution/waterPollutionSearch.do")
	public String waterPollutionSearch(ModelMap model ) throws Exception {
		return "/mobile/sub/waterpollution/waterPollutionSearch";
	}
	

	/**
	 * 사고관리 리스트
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/waterpollution/waterPollutionList.do")
	public String waterPollutionList(@ModelAttribute("waterPollutionSearchVO") WaterPollutionSearchVO waterPollutionSearchVO, ModelMap model ) throws Exception {
		
		waterPollutionSearchVO.setStartDate(waterPollutionSearchVO.getStartDate().replaceAll("/", ""));
		waterPollutionSearchVO.setEndDate(waterPollutionSearchVO.getEndDate().replaceAll("/", ""));
		waterPollutionSearchVO.setFirstIndex(0);
		waterPollutionSearchVO.setRecordCountPerPage(100000);
		
		model.addAttribute("List", waterPollutionService.getWaterPollutionList(waterPollutionSearchVO));
		model.addAttribute("param_s", waterPollutionSearchVO);
		
		return "/mobile/sub/waterpollution/waterPollutionList";
	}
	

	/**
	 * 사고관리 등록화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/waterpollution/waterPollutionRegist.do")
	public String waterPollutionRegist(@ModelAttribute("waterPollutionSearchVO") WaterPollutionSearchVO waterPollutionSearchVO, ModelMap model ) throws Exception {

		WaterPollutionVO  View = new WaterPollutionVO ();
		
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("wpCode",waterPollutionSearchVO.getWpCode());

		List list = waterPollutionService.getWaterPollutionDetail(map);
		if(list.size() > 0) View = (WaterPollutionVO )list.get(0);
		
		model.addAttribute("View", View);
		model.addAttribute("param_s", waterPollutionSearchVO);
		
		return "/mobile/sub/waterpollution/waterPollutionRegist";
	}
	
	/**
	 * 사고관리 등록 처리
	 * @param req
	 * @param res
	 * @param members
	 * @param smsContent
	 * @param riverDiv
	 * @param addrDet
	 * @param reportDate
	 * @param reportHour
	 * @param reportMin
	 * @param receiveDate
	 * @param receiveHour
	 * @param receiveMin
	 * @param waterPollutionVO
	 * @param waterPollutionStepVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/waterpollution/waterpollutionRegProc.do")
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
			
			,@RequestParam(value="searchRiverDiv",		required=false) String searchRiverDiv
			,@RequestParam(value="searchWpKind",		required=false) String searchWpKind
			,@RequestParam(value="searchWpsStep",	  required=false) String searchWpsStep
			,@RequestParam(value="startDate",	  required=false) String startDate
			,@RequestParam(value="endDate",		required=false) String endDate
			
			,@ModelAttribute("waterPollutionVO")	 WaterPollutionVO waterPollutionVO
			,@ModelAttribute("waterPollutionStepVO") WaterPollutionStepVO waterPollutionStepVO
			)throws Exception{ 
		

		String param = ObjectUtil.ParamString(new String[] {searchRiverDiv,searchWpKind,searchWpsStep,startDate,endDate}, 
														   "searchRiverDiv,searchWpKind,searchWpsStep,startDate,endDate");
		
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
		}
		catch(Exception ex){
		}
		
		try{
			int resultOk = 0; 
			if (smsResult < 0 ) {
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('경보 대상자가 없어서 SMS전송이  실패했습니다.');document.location.replace('/mobile/sub/waterpollution/waterPollutionList.do"+param+"')</script>");
			}else if(smsResult2 == 0){
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('SMS저장에 실패했습니다.');document.location.replace('/mobile/sub/waterpollution/waterPollutionList.do"+param+"')</script>");
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
				res.getWriter().print("<script>alert('처리되었습니다.');document.location.href='/mobile/sub/waterpollution/waterPollutionList.do"+param+"'</script>");
			} else{ 
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('ERROR');document.location.href='/mobile/sub/waterpollution/waterPollutionList.do"+param+"'</script>");
			} 
		}catch(Exception e){
			e.printStackTrace();
		}		
		return null;
	}
	
	/**
	 * 사고관리 상세화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/waterpollution/waterPollutionDetail.do")
	public String waterPollutionDetail(@ModelAttribute("waterPollutionSearchVO") WaterPollutionSearchVO waterPollutionSearchVO,ModelMap model ) throws Exception {

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("wpCode",waterPollutionSearchVO.getWpCode());

		List list = waterPollutionService.getWaterPollutionDetail(map);
		WaterPollutionVO  View = new WaterPollutionVO ();
		if(list.size() > 0) View = (WaterPollutionVO )list.get(0);
		
		List <WaterPollutionVO> wpSms= waterPollutionService.getWaterPollutionSms(map);
		List <WaterPollutionVO> wpStep= waterPollutionService.getWaterPollutionStep(map);
		model.addAttribute("View", View);
		model.addAttribute("SmsList", wpSms);
		model.addAttribute("StepList", wpStep);
		model.addAttribute("param_s", waterPollutionSearchVO);
		return "/mobile/sub/waterpollution/waterPollutionDetail";
	}

	/**
	 * 수습(조치)경과 수정.
	 * @param req
	 * @param res
	 * @param waterPollutionVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/waterpollution/waterPollutionModify.do")
	public ModelAndView waterPollutionModify(
			 HttpServletRequest req,
			 HttpServletResponse res
			,@ModelAttribute("waterPollutionStepVO") WaterPollutionSearchVO waterPollutionSearchVO
		)throws Exception{
		
		try{
			String param = "?";
			param += "searchRiverDiv=" +  waterPollutionSearchVO.getSearchRiverDiv();
			param += "&searchWpKind=" +  waterPollutionSearchVO.getSearchWpKind();
			param += "&searchWpsStep=" +  waterPollutionSearchVO.getSearchWpsStep();
			param += "&startDate=" +  waterPollutionSearchVO.getStartDate();
			param += "&endDate=" +  waterPollutionSearchVO.getEndDate();
			
			waterPollutionService.modifyWaterPollution(waterPollutionSearchVO);
			res.setContentType("text/html; charset=UTF-8");
			res.getWriter().print("<script>alert('수정되었습니다.'); document.location.replace('/mobile/sub/waterpollution/waterPollutionList.do"+param+"');</script>");
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 수질오염사고 수습(조치) 경과 추가 팝업페이지
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/waterpollution/waterPollutionStepPopup.do")
	public String waterPollutionStepPopup(@ModelAttribute("waterPollutionSearchVO") WaterPollutionSearchVO waterPollutionSearchVO, ModelMap model ) throws Exception {
		model.addAttribute("param_s", waterPollutionSearchVO);
		return "/mobile/sub/waterpollution/waterPollutionStepPopup";
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
	@RequestMapping("/mobile/sub/waterpollution/addWaterpollutionStep.do")
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
			
			List<FileVO> result = fileUtil.parseWpStepFileInf(files, "wpStep_", 0, "", "");
			if (result.size() >0 ) {
				String atchFileId	= waterPollutionService.insertWpsStepFileInfs(result);
				waterPollutionStepVO.setWpsImg(atchFileId); //
			}
			
			waterPollutionService.inserttWaterPollutionStepInfo(waterPollutionStepVO);
			
			res.setContentType("text/html; charset=UTF-8");
			
			String param = waterPollutionStepVO.getWpsCode() + "','" + 
						   waterPollutionStepVO.getWpsStepDate() + "','" + 
						   waterPollutionStepVO.getWpsContent().replaceAll("\r\n", "<br>") + "','" + 
						   waterPollutionStepVO.getWpsStep() + "','" + 
						   waterPollutionStepVO.getWpsImg();
			
			res.getWriter().print("<script>alert('저장되었습니다.'); window.parent.getWpStepData('"+param+"');</script>");
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
	@RequestMapping("/mobile/sub/waterpollution/waterPollutionStepModifyPopup.do")
	public String waterPollutionStepModifyPopup(@ModelAttribute("waterPollutionSearchVO") WaterPollutionSearchVO waterPollutionSearchVO , ModelMap model ) throws Exception {

		HashMap<String, String> map = new HashMap<String, String>();
		map.put("wpCode",waterPollutionSearchVO.getWpCode());
		map.put("wpsCode",waterPollutionSearchVO.getWpsCode());
		List <WaterPollutionVO> list = waterPollutionService.waterPollutionStepModifyInfo(map);
		WaterPollutionVO  View = new WaterPollutionVO ();
		if(null != list) View = (WaterPollutionVO )list.get(0);
		
		model.addAttribute("View", View);
		model.addAttribute("param_s", waterPollutionSearchVO);
		return "/mobile/sub/waterpollution/waterPollutionStepModifyPopup";
	}
	
	/**
	 * 사고조치단계 수정
	 * @param req
	 * @param res
	 * @param waterPollutionStepVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/waterpollution/modifyWaterPollutionStep.do")
	public ModelAndView modifyWaterPollutionStep(
			 final MultipartHttpServletRequest multiRequest,
			 HttpServletRequest req,
			 HttpServletResponse res
			,@RequestParam(value="wpsImg", required=false) String wpsImg
			,@ModelAttribute("waterPollutionStepVO") WaterPollutionStepVO waterPollutionStepVO
		)throws Exception{
				
		try{
			final Map<String, MultipartFile> files = multiRequest.getFileMap();
			
			if(wpsImg == null || wpsImg.equals("")) {
				List<FileVO> result = fileUtil.parseWpStepFileInf(files, "wpStep_", 0, "", ""); 
				if (result.size() >0 ) {
					String atchFileId	= waterPollutionService.insertWpsStepFileInfs(result);
					
					waterPollutionStepVO.setWpsImg(atchFileId);
				}
			}else{
				waterPollutionStepVO.setWpsImg(wpsImg);
			}
			
			waterPollutionService.modifyWaterPollutionStep(waterPollutionStepVO);
			
			res.setContentType("text/html; charset=UTF-8");

			String param = waterPollutionStepVO.getWpsCode() + "','" + 
						   waterPollutionStepVO.getWpsStepDate() + "','" + 
						   waterPollutionStepVO.getWpsContent().replaceAll("\r\n", "<br>") + "','" + 
						   waterPollutionStepVO.getWpsStep() + "','" + 
						   waterPollutionStepVO.getWpsImg();
			
			res.getWriter().print("<script>alert('수정되었습니다.'); window.parent.getWpStepModify('"+ param + "');</script>");
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * 수습(조치)경과 삭제
	 * @param req
	 * @param res
	 * @param waterPollutionVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/waterpollution/deleteWaterPollutionStep.do")
	public ModelAndView deleteWaterPollutionStep(
			 final MultipartHttpServletRequest multiRequest,
			 HttpServletRequest req,
			 HttpServletResponse res
			,@ModelAttribute("waterPollutionStepVO") WaterPollutionStepVO waterPollutionStepVO
		)throws Exception{
				
		try{
			waterPollutionService.deleteWaterPollutionStep(waterPollutionStepVO);
			
			res.setContentType("text/html; charset=UTF-8");
			res.getWriter().print("<script>alert('삭제되었습니다.'); window.parent.getWpStepDel('"+waterPollutionStepVO.getWpsCode()+"');</script>");
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
	@RequestMapping("/mobile/sub/waterpollution/deleteWaterPollutionStepImg.do")
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
	 * 사고관리 지도
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/waterpollution/waterMap.do")
	public String waterMap(ModelMap model , HttpServletRequest request) throws Exception {
		model.addAttribute("X", request.getParameter("X"));
		model.addAttribute("Y", request.getParameter("Y"));
		return "/mobile/sub/waterpollution/waterMap";
	}
	
}