package daewooInfo.alert.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.alert.bean.AlertMngVO;
import daewooInfo.alert.bean.AlertStepVO;
import daewooInfo.alert.bean.AlertTestVO;
import daewooInfo.alert.service.AlertMngService;
import daewooInfo.alert.service.AlertStepService;
import daewooInfo.alert.util.SendSMS;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.cmmn.service.TmsComUtlService;
import daewooInfo.common.util.EgovFileMngUtil;
import daewooInfo.common.util.fcc.StringUtil;
import daewooInfo.waterpollution.bean.WaterPollutionVO;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * 상황 접수, 전파 일지 관리를 위한 컨트롤러  클래스
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 * 
 * <pre>
 * << 개정이력(Modification Information) >>
 * 
 * 수정일			수정자			수정내용
 * -------		--------	---------------------------
 * 2010.6.28	김태훈			최초 생성
 * 
 * </pre>
 */
@Controller
public class AlertMngController {
	
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log log = LogFactory.getLog(AlertMngController.class);
	
	private static String ETC_FACT_CODE 	= "50A0001";	//사고접수사업장(기타사업장)
	private static String LAW_VALUE_OVER 	= "3";			//기준 초과 시 상수
	private static int BRANCH_NO 			= 1;			//측정소
	
	 
	/**
	 * @uml.property  name="alertMngService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertMngService")
	private AlertMngService alertMngService;
	 
	/**
	 * @uml.property  name="alertStepService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertStepService")
	private AlertStepService alertStepService;
	
	/**
	 * @uml.property  name="tmsComUtlService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "TmsComUtlService")
	private TmsComUtlService tmsComUtlService;
	
	/**
	 * @uml.property  name="fileUtil"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	/**
	 * 일지 목록을 가져온다. -> 상황완료된 사고리스트를 가져옵니다
	 *
	 * @param alertMngVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/alertMngList.do")
	public ModelAndView alertMngList(
			@ModelAttribute("alertStepVO") AlertStepVO alertStepVO
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/alert/alertMngList");
		
		return modelAndView;
	}
	
	
	@RequestMapping("/alert/getAlertMngList.do")
	public ModelAndView getAlertMngList(
			@ModelAttribute("alertStepVO") AlertStepVO alertStepVO
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		PaginationInfo paginationInfo = new PaginationInfo();
		
		try
		{
		
		alertStepVO.setIsComplete("Y");
		
		/** paging */
		//2014-10-27 mypark 페이징 처리
		alertStepVO.setPageUnit(20);
		//alertStepVO.setPageUnit(100000);
		paginationInfo.setCurrentPageNo(alertStepVO.getPageIndex());
		paginationInfo.setRecordCountPerPage(alertStepVO.getPageUnit());
		paginationInfo.setPageSize(alertStepVO.getPageSize());
		
		alertStepVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		alertStepVO.setLastIndex(paginationInfo.getLastRecordIndex());
		alertStepVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		
		int totCnt = alertStepService.getAlertStepListCount(alertStepVO);
		paginationInfo.setTotalRecordCount(totCnt);
		
		
		List<AlertStepVO> alertStepList = alertStepService.getAlertStepList(alertStepVO);
		
		
		modelAndView.addObject("paginationInfo", paginationInfo);
		modelAndView.addObject("alertStepVO", alertStepVO);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.addObject("alertStepList", alertStepList);
		
		modelAndView.setViewName("jsonView");
		}
		catch(Exception e)
		{
			//System.out.println("=======================================");
			//System.out.println(e.getMessage());
			//System.out.println("=======================================");
			e.printStackTrace();
			
		}
		
		return modelAndView;
	}
	
	/**
	 * 해당 일지를 가져온다.
	 * 
	 * @param mngId
	 * @param pageIndex
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/alertMngView.do")
	public ModelAndView alertMngView(
			@RequestParam(value="asId") String asId
			,@RequestParam(value="step") String step
			,@RequestParam(value="pageIndex", required=false) String pageIndex
			,@RequestParam(value="system", required=false) String system
			,@RequestParam(value="startDate", required=false) String startDate
			,@RequestParam(value="endDate", required=false) String endDate
			,@RequestParam(value="minOr", required=false) String minOr
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		WaterPollutionVO  View = new WaterPollutionVO ();
		
//		AlertMngVO vo = new AlertMngVO();
//		vo.setMngId(mngId);
//		
//		AlertMngVO alertMngVO =  alertMngService.getAlertMng(vo);
//		alertMngVO.setReceiptContent(StringUtil.replace(StringUtil.nullConvert(alertMngVO.getReceiptContent()), "\r", "<br>"));
//		alertMngVO.setSpreadContent(StringUtil.replace(StringUtil.nullConvert(alertMngVO.getSpreadContent()), "\r", "<br>") );
//		alertMngVO.setEtc(StringUtil.replace(StringUtil.nullConvert(alertMngVO.getEtc()), "\r", "<br>") );
//		
//		// 상황전파기관 조직 목록 가져오기
//		AlertMngVO vo2 = new AlertMngVO();
//		vo2.setFactCode(alertMngVO.getFactCode());
//		vo2.setBranchNo(alertMngVO.getBranchNo());
//		String spreadDeptStr  =  alertMngService.getAlertMngSpreadDept(vo2);
		
		
		modelAndView.addObject("asId", asId);
		modelAndView.addObject("step", step);
		modelAndView.addObject("pageIndex", pageIndex);
		modelAndView.addObject("startDate", startDate);
		modelAndView.addObject("endDate", endDate);
		modelAndView.addObject("system", system);
		modelAndView.addObject("minOr", minOr);
		
//		modelAndView.addObject("spreadDeptStr", spreadDeptStr);
//		modelAndView.addObject("alertMngVO", alertMngVO);
		
		modelAndView.setViewName("/alert/alertMngView");

		return modelAndView;
	}
	@RequestMapping("/alert/alertReg.do")
	public ModelAndView alertReg(
			@RequestParam(value="mngId", required=false) String mngId
			,@RequestParam(value="pageIndex", required=false) String pageIndex
			)throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		AlertMngVO vo = new AlertMngVO();
		
		// 코드테이블에서 상황접수 유형 코드를 가져온다 ( CODE : 31 )
		List<Map<String,String>> codes = (List<Map<String,String>>)tmsComUtlService.getCode("35");
		//신고인적사항구분 
		List<Map<String,String>> userKind = (List<Map<String,String>>)tmsComUtlService.getCode("41");
		//신고형태
		List<Map<String,String>> kind = (List<Map<String,String>>)tmsComUtlService.getCode("40");
		 
		modelAndView.addObject("codes", codes);
		modelAndView.addObject("userKind", userKind);
		modelAndView.addObject("kinds", kind);
		
		modelAndView.addObject("pageIndex", pageIndex);
		modelAndView.addObject("alertMngVO", vo);
		
		modelAndView.setViewName("/alert/alertReg");
		return modelAndView;
	}
	@RequestMapping("/alert/alertRegProc.do")
	public ModelAndView alertRegProc(
			final MultipartHttpServletRequest multiRequest, 
			HttpServletRequest req,
			HttpServletResponse res
			,@RequestParam(value="memberId", required=false) String members
			,@RequestParam(value="smsMsg", required=false) String smsMsg
			,@ModelAttribute("alertMngVO") AlertMngVO alertMngVO
			,@RequestParam(value="sugye2", required=false) String sugye2
			,@RequestParam(value="addr_det", required=false) String addr_det
			)throws Exception{ 
		
		
		String[] memberId = members.split(",");
		
		if(log.isDebugEnabled()){
			log.debug("!!!!!!!!!!!!!!사고조치 등록 시작 ");
		} 
		int smsResult = 0; 
		AlertMngVO vo 	= new AlertMngVO();  
		String minTime 	= alertMngVO.getReceiptDate1()+alertMngVO.getReceiptDate2()+alertMngVO.getReceiptDate3();
		
		if(!StringUtil.isEmpty(vo.getReceiptTelNo())) {
			String tmpTel[] = vo.getReceiptTelNo().split("-");
			vo.setReceiptTelNo1(tmpTel[0]);
			vo.setReceiptTelNo2(tmpTel[1]);
			vo.setReceiptTelNo3(tmpTel[2]);
		}  
		if(log.isDebugEnabled()){
			log.debug("!!!!!!!!!!!!!!222222!!!!!!!!!!!! ");
		} 
		AlertStepVO alertStepVO = new AlertStepVO();
		
		if(log.isDebugEnabled()){
			log.debug("alertMngVO.getRegKind()="+alertMngVO.getRegKind()); 
		} 
		
		
		
		//사고 접수 : 임의지정(TYPE1),측정지정(TYPE2)
		if(alertMngVO.getRegKind().equals("TYPE1")){
			alertStepVO.setFactCode(ETC_FACT_CODE);
			alertStepVO.setRiverId(sugye2);
			alertStepVO.setBranchNo(BRANCH_NO);
			alertStepVO.setAddress(alertMngVO.getAddress().replace("대한민국", ""));
			alertStepVO.setMapx(alertMngVO.getMapx());
			alertStepVO.setMapy(alertMngVO.getMapy());
			alertStepVO.setAddr_det(addr_det);
		}else{
			alertStepVO.setFactCode(alertMngVO.getFactCode());
			alertStepVO.setRiverId(alertMngVO.getSugye());
			alertStepVO.setBranchNo(Integer.parseInt(alertMngVO.getBranchNo()));
		}  
		alertStepVO.setItemCode("ETC");
		alertStepVO.setMinTime(minTime);
		alertStepVO.setMinOr(LAW_VALUE_OVER); 			//구분(1:관심,2:주의,3:경계)
		alertStepVO.setMemberName(alertMngVO.getReceiptName());
		alertStepVO.setMemberTel(alertMngVO.getReceiptTelNo1()+alertMngVO.getReceiptTelNo2()+alertMngVO.getReceiptTelNo3());
		alertStepVO.setMemberCategory(alertMngVO.getUserKind());
		alertStepVO.setReceiptType(alertMngVO.getReceiptType());
		alertStepVO.setItemType(alertMngVO.getItemType());
		alertStepVO.setAlertTest("0"); 				//실제발송 
		alertStepVO.setAlertStep("1");				//1단계
		alertStepVO.setAlertContents(alertMngVO.getAlertContents());
		alertStepVO.setAlertEtc(alertMngVO.getAlertEtc());
		alertStepVO.setAlertKind("A");
		alertStepVO.setAlertStepText(alertMngVO.getAlertContents());
		
		alertStepVO.setReceiptType(alertMngVO.getReceiptType());
		 
		try
		{
			smsResult = SendSMS.sendRegSms(alertStepVO.getFactCode(),Integer.toString(alertStepVO.getBranchNo()),memberId, smsMsg, alertMngVO.getMngTitle());
		}
		catch(Exception ex)
		{
			if(log.isDebugEnabled()){
				log.debug(ex.getMessage() + ex.getStackTrace());
			} 
		}
		
		if(log.isDebugEnabled()){
			log.debug("!!!!!!!!!!!!!!smsResult!!!!!!!!!!!!="+smsResult);
		} 
		
		
		try
		{
			int resultOk = 0; 
			if (smsResult < 0) {
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('경보 대상자가 없어서 SMS전송이  실패했습니다.');document.location.href='alertReg.do'</script>");
			}else{ 
				//사고조치 테이블에 입력 
				String asId 		= alertStepService.getMaxAsId();
				alertStepVO.setAsId(asId);
				
				if(log.isDebugEnabled()){
					log.debug("!!!!!!!!!!!!!!asId="+asId);
				} 
				if(log.isDebugEnabled()){
					log.debug("!!!!!!!!!!!!!!파일 업로드 !!!!!!");
				} 
				final Map<String, MultipartFile> files = multiRequest.getFileMap();
				if(files !=null){
					if (!files.isEmpty()) {
						List<FileVO> result =  fileUtil.parseAlertFileInf(files, "alert_", 0, "", ""); 
						String atchFileId   = alertStepService.insertAlertFileInfs(result);
						alertStepVO.setAtchFileId(atchFileId);
					}
					
				}
				if(log.isDebugEnabled()){
					log.debug("!!!!!!!!!!!!!!파일 업로드 끝!!!!!!");
				} 
				resultOk=alertStepService.insertAlertStep(alertStepVO);
				alertStepService.insertAlertStepSub(alertStepVO);
				if(log.isDebugEnabled()){
					log.debug("!!!!!!!!!!!!!!33333!!!!!!!!!!!! "); 
				} 
			} 
			if(resultOk  > 0) {
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('처리되었습니다.');document.location.href='alertReg.do'</script>");
			} else {
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('"+alertStepVO.getAlertStepText()+"');self.close();</script>"); 
			}
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return null;
	}
	
	
	
	/**
	 * 일지의 등록화면을 보여주거나 등록된 일지의 수정화면을 보여준다.
	 * 
	 * @param mngId
	 * @param pageIndex
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/alertMngWrite.do")
	public ModelAndView alertLaw(
			@RequestParam(value="mngId", required=false) String mngId
			,@RequestParam(value="pageIndex", required=false) String pageIndex
			) throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		AlertMngVO vo = new AlertMngVO();
		
		if(mngId != null && !mngId.equals("")) {
			vo.setMngId(mngId);		
			vo =  alertMngService.getAlertMng(vo);
			
			// 전화번호 자르기 처리
			if(!StringUtil.isEmpty(vo.getReceiptTelNo())) {
				String tmpTel[] = vo.getReceiptTelNo().split("-");
				
				vo.setReceiptTelNo1(tmpTel[0]);
				vo.setReceiptTelNo2(tmpTel[1]);
				vo.setReceiptTelNo3(tmpTel[2]);
			}
		}
		
		// 코드테이블에서 상황접수 유형 코드를 가져온다 ( CODE : 31 )
		List<Map<String,String>> codes = (List<Map<String,String>>)tmsComUtlService.getCode("31"); 
		modelAndView.addObject("codes", codes); 
		modelAndView.addObject("pageIndex", pageIndex);
		modelAndView.addObject("alertMngVO", vo);
		
		modelAndView.setViewName("/alert/alertMngWrite");
		return modelAndView;
	}
	
	/**
	 * 해당 일지의 등록이나 수정 처리를 한다.
	 * 
	 * @param req
	 * @param res
	 * @param alertMngVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/alertMngWriteProc.do")
	public ModelAndView alertMngWriteProc(
			HttpServletRequest req,
			HttpServletResponse res,
			@ModelAttribute("alertMngVO") AlertMngVO alertMngVO
			) throws Exception{
		
		int succ = 0;
		if(alertMngVO.getMngId() == null || alertMngVO.getMngId().equals("")) {
			int idx = alertMngService.getAlertMngPk();			
			alertMngVO.setMngId(""+idx);	
			
			// SMS 발송
			succ = SendSMS.sendSms(alertMngVO.getFactCode(), Integer.parseInt(alertMngVO.getBranchNo()), alertMngVO.getReceiptDate(), "3", alertMngVO.getSpreadContent(), "수동발령");
		} else {
			succ = 1;
		}
		
		alertMngService.mergeAlertMng(alertMngVO);
		
		// SMS 발송 성공여부에 따라 메시지를 달리 한다.
		if(succ == 0) {
			//return new ModelAndView("redirect:/alert/alertMngView.do?mngId="+alertMngVO.getMngId());
			res.setContentType("text/html; charset=UTF-8");
			res.getWriter().print("<script>alert('경보 대상자가 없어서 SMS전송이  실패했습니다.');document.location.href='alertMngView.do?mngId="+alertMngVO.getMngId()+"'</script>");
		} else {
			//return new ModelAndView("redirect:/alert/alertMngView.do?mngId="+alertMngVO.getMngId());
			res.setContentType("text/html; charset=UTF-8");
			res.getWriter().print("<script>alert('처리되었습니다.');document.location.href='alertMngView.do?mngId="+alertMngVO.getMngId()+"'</script>");			
		}
		return null;
	}
	
	/**
	 * 해당 일지를 삭제한다.
	 * 
	 * @param req
	 * @param res
	 * @param mngId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/alertMngDelete.do")
	public ModelAndView alertMngDelete(
			HttpServletRequest req
			,HttpServletResponse res
			,@RequestParam(value="mngId") String mngId
			) throws Exception{
		
		AlertMngVO vo = new AlertMngVO();
		vo.setMngId(mngId);
		
		alertMngService.deleteAlertMng(vo);
		
		res.setContentType("text/html; charset=UTF-8");
		res.getWriter().print("<script>alert('삭제되었습니다.');document.location.href='alertMngList.do'</script>");
		return null;
	}
	
	/**
	 * 리포트를 연다.
	 * 
	 * @param mrdpath
	 * @param param
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/common/rdView.do")
	public ModelAndView rdView(
			@RequestParam(value="mrdpath") String mrdpath
			,@RequestParam(value="param") String param
			) throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		//System.out.println("param - " + param);
				
		modelAndView.addObject("mrdpath", mrdpath);
		modelAndView.addObject("paramData", param);
		
		return modelAndView; //return String
	}
	
	/** 데이터 검증
	 * @param mngId
	 * @param pageIndex
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/alertTest.do")
	public ModelAndView alertTest(
			@ModelAttribute("alertTestVO") AlertTestVO alertTestVO
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		List<AlertTestVO> info =null;
		
		log.debug("searchTaksuVO.getStartDate() ="+alertTestVO.getStartDate());
		if(alertTestVO.getStartDate() !=null && alertTestVO.getEndDate() !=null){
			info = alertMngService.getTaksuTest(alertTestVO);
		}
		modelAndView.addObject("info", info);
		modelAndView.setViewName("/alert/alertTest");
		return modelAndView;
	}
	@RequestMapping("/alert/alertTestSearch.do")
	public ModelAndView alertTestSearch(
			) throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.setViewName("/alert/alertTestSearch");
		return modelAndView;
	}
	@RequestMapping("/alert/alertPopupMap.do")
	public ModelAndView alertPopupMap(
			) throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("/alert/alertPopupMap");
		return modelAndView;
	}
	
	@RequestMapping("/alert/alertMngHistDelete.do")
	public ModelAndView alertMngHistDelete( 
			 @ModelAttribute("alertStepVO") AlertStepVO alertStepVO
			,HttpServletResponse res
			) throws Exception{
		int cnt = alertMngService.alertMngHistDelete(alertStepVO);
		
		if(cnt > 0){
			res.setContentType("text/html; charset=UTF-8");
			res.getWriter().print("<script>alert('삭제되었습니다.');document.location.href='/alert/alertMngList.do'</script>");
		}else{
			res.setContentType("text/html; charset=UTF-8");
			res.getWriter().print("<script>alert('실패하였습니다');document.location.href='/alert/alertMngList.do'</script>");
		}
		
		return null;
	}
	
	/**
	 * 상황발생이력 상황종료 리포드 인쇄
	 * 
	 * @param asId
	 * @param step
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/alertMngPrintView.do")
	public ModelAndView alertMngPrintView(
			@RequestParam(value="asId") String asId
			,@RequestParam(value="step") String step
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("asId", asId);
		modelAndView.addObject("step", step);
		
		modelAndView.setViewName("/alert/alertMngPrintView");

		return modelAndView;
	}
	
}
