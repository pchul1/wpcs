package daewooInfo.alert.web;

import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.alert.bean.AlertDataLawVo;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertStepVO;
import daewooInfo.alert.bean.SearchVO;
import daewooInfo.alert.service.AlertLawService;
import daewooInfo.alert.service.AlertStepService;
import daewooInfo.cmmn.bean.FileVO;
import daewooInfo.cmmn.service.TmsComUtlService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.mock.bean.ErrorCodeVO;
import daewooInfo.mock.service.MockService;
import daewooInfo.waterpolmnt.waterinfo.bean.RiverWater3HourWarningSearchVO;
import daewooInfo.waterpolmnt.waterinfo.bean.RiverWater3HourWarningVO;
import daewooInfo.waterpolmnt.waterinfo.service.WaterinfoService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;



/**
 * @author DaeWoo Information Systems Co., Ltd.  Technical Expert Team. khanian.
 * @version 1.0
 * @Class Name : .java
 * @Description :  Class
 * @Modification Information
 * @
 * @ Modify Date	 author				Modify Contents
 * @ --------------  ------------	-------------------------------
 * @ 2010. 5. 19	 khanian			  new
 * @see Copyright (C) by DaeWoo Information Systems Co., Ltd. All right reserved.
 * @since 2010. 1. 21
 */

@Controller
public class AlertStepController {
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log log = LogFactory.getLog(AlertStepController.class);
	
	/**
	 * @uml.property  name="sPLIT_STR"
	 */
	private final String SPLIT_STR = "|";
	
	/**
	 * @uml.property  name="alertStepService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertStepService")
	private AlertStepService alertStepService;
	
	/**
	 * @uml.property  name="alertLawService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertLawService")
	private AlertLawService alertLawService;
	
	 /**
	 * @uml.property  name="tmsComUtlService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "TmsComUtlService")
	 private TmsComUtlService tmsComUtlService;	
	
	 /**
	 * @uml.property  name="waterinfoService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "waterinfoService")
	 private WaterinfoService waterinfoService;
	 
	 /**
	 * @uml.property  name="mockService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "mockService")
	 private MockService mockService;	
	 
	 @RequestMapping("/alert/alertStepList.do")
	 public ModelAndView getAlertStepList() throws Exception{ 
	 
		ModelAndView modelAndView = new ModelAndView();	
		List<Map<String,String>> codes = (List<Map<String,String>>)tmsComUtlService.getCode("35");
				 
		modelAndView.addObject("codes", codes);	
		modelAndView.setViewName("alert/alertStepList");
		return modelAndView;
	} 
	 
	@RequestMapping("/alert/alertStepListView.do")
	public ModelAndView getAlertListView(
			@ModelAttribute("searchVO") SearchVO searchVO  
			) throws Exception{
		//System.out.println("er 1");
		ModelAndView	modelAndView	= new ModelAndView();	
		PaginationInfo paginationInfo	= new PaginationInfo();
		//System.out.println("er 2");
		//System.out.println("river id :" +searchVO.getRiverId());
		//System.out.println("receiptType : "+searchVO.getReceiptType());
		//System.out.println("system : "+searchVO.getSystem());
		//System.out.println("itemType : "+searchVO.getItemType());
		//System.out.println("todate : "+searchVO.getToDate());
		//System.out.println("fromDate : "+searchVO.getFromDate());
		
		if(searchVO.getPageIndex() == 0)
			searchVO.setPageIndex(1);
		/** paging */
		//System.out.println("er 3");
		 
		paginationInfo.setCurrentPageNo(searchVO.getPageIndex());
		//System.out.println(paginationInfo.getCurrentPageNo());
		paginationInfo.setRecordCountPerPage(searchVO.getPageUnit());
		//System.out.println(paginationInfo.getRecordCountPerPage());
		paginationInfo.setPageSize(searchVO.getPageSize());
		//System.out.println(paginationInfo.getPageSize());
		//System.out.println("er 4");
		searchVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		//System.out.println(searchVO.getFirstIndex());
		searchVO.setLastIndex(paginationInfo.getLastRecordIndex());
		//System.out.println(searchVO.getLastIndex());
		searchVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
		//System.out.println(searchVO.getRecordCountPerPage());
		searchVO.setRecordCountPerPage(20);
		//System.out.println("gggg : "+searchVO.getRecordCountPerPage());
		//System.out.println("er 5");
		
		if(searchVO.getMinTime() == null || searchVO.getMinTime().trim().equals(""))
			searchVO.setMinTime( new SimpleDateFormat("yyyyMMdd").format(System.currentTimeMillis()));
		//System.out.println("er 6");

		if(searchVO.getToDate() == null || searchVO.getToDate().trim().equals(""))
			searchVO.setToDate( new SimpleDateFormat("yyyyMMdd").format(System.currentTimeMillis())); 
		//System.out.println("er 7");
		if(searchVO.getFromDate() == null || searchVO.getFromDate().trim().equals(""))
			searchVO.setFromDate( new SimpleDateFormat("yyyyMMdd").format(System.currentTimeMillis())); 
		//System.out.println("frdate" + searchVO.getFromDate());
		//System.out.println("er 8");
		List<AlertStepVO> dataList			= alertStepService.getAlertStepList(searchVO);
		//System.out.println("er 14");
		int totCnt							= alertStepService.getAlertStepListCount(searchVO);
		//System.out.println("er 9");
		paginationInfo.setTotalRecordCount(totCnt);
		  
		//log.debug("####pagetTotal="+paginationInfo.getTotalRecordCount());
		modelAndView.addObject("dataList", dataList);
		//System.out.println("er 10");
		modelAndView.addObject("paginationInfo", paginationInfo);
		//System.out.println("er 11");
		modelAndView.addObject("totCnt", totCnt);
		//System.out.println("er 12");
		modelAndView.setViewName("jsonView");
		//System.out.println("er 13");
		return modelAndView;
	}
	
	@RequestMapping("/alert/alertStepSub.do")
	public ModelAndView getAlertStepSub(
			@RequestParam(value="asId", required=false) String asId,
			@RequestParam(value="step", required=false) String step
			) throws Exception {
		ModelAndView mav = new ModelAndView();	

		AlertStepVO alertStepVO = new AlertStepVO(); 
		alertStepVO.setAsId(asId); 
		AlertStepVO asData			= alertStepService.getAlertStep(alertStepVO);
		if(asData.getAtchFileId() !=null && asData.getAtchFileId() !=""){
			FileVO vo = new FileVO(); 
			vo.setAtchFileId(asData.getAtchFileId());
			FileVO  fvo =alertStepService.selectAlertFileInf(vo);
			mav.addObject("file", fvo.orignlFileNm);
		}
		List<AlertStepVO> dataList  = alertStepService.getAlertStepSubList(alertStepVO);
		
		//if("6".equals(step) || "7".equals(step) || "8".equals(step) ){
		//	step = "6";
		//}
		
		if("9".equals(step))
		{
			step = "1";
		}
		
		mav.addObject("asData", asData);
		mav.addObject("dataList", dataList);
		mav.addObject("step", step);
		mav.setViewName("alert/process_popup");

		return mav;
	}
	
	/**
	 * 사고조치단계 팝업 
	 * @param asId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/goAlertStepSub_popup.do")
	public ModelAndView getAlertStepSub_popup(
			@RequestParam(value="asId", required=false) String asId,
			@RequestParam(value="step", required=false) String step,
			@RequestParam(value="sys", required=false) String sys,
			@RequestParam(value="mngPrt", required=false) String mngPrt,
			@ModelAttribute("loginVO") LoginVO loginVO
	) throws Exception
	{
		ModelAndView mav = new ModelAndView();
		
		AlertStepVO alertStepVO = new AlertStepVO(); 
		alertStepVO.setAsId(asId); 
		AlertStepVO asData = alertStepService.getAlertStep(alertStepVO);

		alertStepVO.setAlertStep("all");
		String AllstepList = "";
		for(AlertStepVO vo: alertStepService.getAlertStepSubList(alertStepVO)){
			AllstepList += vo.getAlertStepNum();
		}
		
		mav.addObject("AllstepList", AllstepList);
		
		if(asData != null)
			sys = asData.getSystem();
		
		if(asData.getAtchFileId() !=null && asData.getAtchFileId() !=""){
			FileVO vo = new FileVO(); 
			vo.setAtchFileId(asData.getAtchFileId());
			FileVO  fvo =alertStepService.selectAlertFileInf(vo);
			mav.addObject("file", fvo.orignlFileNm);
		}
		
		if(asData.getAddress() != null && !"".equals(asData.getAddress()))
		{
			asData.setAddress(asData.getAddress().trim());
			String[] addrTmp = asData.getAddress().split(" ");
			
			if(addrTmp.length > 1)
			{
				asData.setAddr_short(addrTmp[0] + " " + addrTmp[1]);
			}
		}
		
		alertStepVO.setAlertStep(step);
		List<AlertStepVO> dataList  = alertStepService.getAlertStepSubList(alertStepVO);
		AlertStepVO data = null;
		
		if(dataList.size() > 0)
		{
			data = dataList.get(0);
		}
		
		//6(2-1) 측정기이상//7.(2-2)이상데이터(강우요인)//상황종료
		if("6".equals(step) || "7".equals(step) || "8".equals(step) || "10".equals(step) ){
			step = "6";
		}
		
		if("9".equals(step)){
			step = "1";
		}
		
		//상황종료이면 모든 처리 데이터를 가져옵니다...
		if("6".equals(step))
		{
			alertStepVO.setAlertStep("all");
			dataList  = alertStepService.getAlertStepSubList(alertStepVO);
			
			Map<String, String[]> resultMap = new HashMap<String, String[]>();
			
			//다른 데이터들 다 빼고...  마지막 데이터(내용)만 가져옴
			for(AlertStepVO stepVO : dataList)
			{
				if(stepVO.getAlertStepText() == null)
				{
					stepVO.setAlertStepText("");
				}
				stepVO.setAlertStepText(stepVO.getAlertStepText().replaceAll("\\<br>", "\r\n"));
				stepVO.setAlertStepText(stepVO.getAlertStepText().replaceAll("\\<br/>", "\r\n"));
				String[] tmp = stepVO.getAlertStepText().split("\\" + SPLIT_STR);
				
				String txt = tmp[tmp.length - 1];//마지막에 있는것이 조치내용
				
				stepVO.setAlertStepText(txt);
				
				if("2".equals(stepVO.getAlertStepNum()))
					stepVO.setAlertStepText("이상데이터 없음");
					
				if("7".equals(stepVO.getAlertStepNum()))
					stepVO.setAlertStepText("이상 데이터");
				
				if("5".equals(stepVO.getAlertStepNum()))
				{
					if("true".equals(txt))
						stepVO.setAlertStepText("경보발령 시각:"+tmp[0]+" / 추가로 상황전파됨");
					else
						stepVO.setAlertStepText("경보발령 시각:"+tmp[0]);
				}
				
				if("3".equals(stepVO.getAlertStepNum()) || "6".equals(stepVO.getAlertStepNum()))
				{
					stepVO.setGov(tmp[0]);
					stepVO.setPerson(tmp[1]);
					stepVO.setPhone(tmp[2]);
					stepVO.setMoveGov(tmp[6]);
				}
				else if("4".equals(stepVO.getAlertStepNum()) || "10".equals(stepVO.getAlertStepNum()))
				{
					stepVO.setAnalGov(tmp[0]);
					stepVO.setAnalPerson(tmp[1]);
					stepVO.setAnalPhone(tmp[2]);
				}
				else if("8".equals(stepVO.getAlertStepNum()))
				{
					stepVO.setProcGov(tmp[0]);
					stepVO.setProcPerson(tmp[1]);
					stepVO.setProcPhone(tmp[2]);
				}
				
				//상황종료이면
				if("6".equals(stepVO.getAlertStepNum()) || "7".equals(stepVO.getAlertStepNum()) || "8".equals(stepVO.getAlertStepNum()) || "10".equals(stepVO.getAlertStepNum()))
				{
					mav.addObject("endTime", stepVO.getAlertStepTimeStr());
				}
			}
		}
		
		
		//이전단계의 상황조치 데이터를 가져오는 부분
		boolean isReview = false;
		String[] reviewData = null;
		int asAlert = Integer.parseInt(asData.getAlertStep());	//현재 상황조치상태
		int popAlert = Integer.parseInt(step);	//확인하려는 팝업창의 상황조치 상태
		
		if(asAlert != 9) //전파대상자 없음 상태에서 1번팝업보고있으면 이전확인하는게 아님
		{
			if(asAlert > popAlert)	//이전 단계를 확인하려고 하고 있으면
			{
				isReview = true; 
				
				String reviewStep = (popAlert+1) + "";
				
				if(popAlert == 5)
					reviewStep = (popAlert + 3) + "";	//5. 상황조치의 처리기록은 T_IW_HIS_DET STEP '8'에 기록되어 있음
				
				if(popAlert == 1 && asAlert == 7)
					reviewStep = (popAlert + 6) + ""; //7. 이상데이터의 처리기록은 T_IW_HIS_DET STEP '7'에 기록되어 있음
				
				if(popAlert == 2 && asAlert == 6)
					reviewStep = (popAlert + 4) + ""; //6. 측정기이상의 처리기록은 T_IW_HIS_DET STEP '6'에 기록되어 있음
				
				if(popAlert == 3 && asAlert == 10)
					reviewStep = (popAlert + 7) + ""; //3. 시료이송에서 처리한 10.상황완료 기록은 T_IW_HIS_DET STEP '10'에 기록되어 있음
				
				alertStepVO.setAlertStep(reviewStep);	 // ex- 2.현장확인의 처리기록은 T_IW_HIS_DET에 STEP '3'에 기록되어있음
				List<AlertStepVO> reviewDataList  = alertStepService.getAlertStepSubList(alertStepVO);
				
				if(reviewDataList.size() > 0)
				{ 
					AlertStepVO reData = reviewDataList.get(0);
					if(reData.getAlertStepText() != null)
					{
						reData.setAlertStepText(reData.getAlertStepText().replaceAll("\\<br>", "\r\n"));
						reData.setAlertStepText(reData.getAlertStepText().replaceAll("\\<br/>", "\r\n"));
						reviewData = reData.getAlertStepText().split("\\" + SPLIT_STR);
					}
					else
						reviewData = new String[] {"-", "-"};
				}
			}
		}
		
		
		String viewName = "/alert/process_popup_sub0" + step;
		
		if("Y".equals(mngPrt))
			viewName = "/alert/alertMngPrintView";
		
		int acct_cnt = Integer.parseInt(asData.getAlertCount());
		int alertCnt = 0;
		String acctCnt = "";
		if(acct_cnt == 1)
		{
			acctCnt = "3시간";
			alertCnt = 3;
		}
		else if(acct_cnt == 2)
		{
			acctCnt = "9시간";
			alertCnt = 9;
		}
		else if(acct_cnt >= 3)
		{
			acctCnt = "21시간 이상";
			alertCnt = 21;
		}
		
		//경보발생쪽 볼려고 경보발생 리스트를 가져옵시다 -ㅅ-
		if("1".equals(step))
		{
			RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO = new RiverWater3HourWarningSearchVO();
		
			riverWater3HourWarningSearchVO.setAs_id(asId);
			riverWater3HourWarningSearchVO.setAlertTime(alertCnt);
			riverWater3HourWarningSearchVO.setSys_kind(sys);
			
			List<RiverWater3HourWarningVO> warningData =  waterinfoService.getRiverWater3HourWarningPopDetail(riverWater3HourWarningSearchVO);
			mav.addObject("warningData", warningData);
			
			//에러 코드 리스트
			List<ErrorCodeVO> errorCodeList = mockService.getErrorCode();
		
			mav.addObject("errorCodeList", errorCodeList);
		}
		
		//경보발령 페이지에서 보낸 SMS리스트 조회
		if("4".equals(step))
		{
			/* 경보같은거 안보낸답니다...
			alertStepVO.setAlertStep("4");	 //경보발령을 한 시간
			List<AlertStepVO> reviewDataList  = alertStepService.getAlertStepSubList(alertStepVO);
			
			AlertStepVO warnStepData =null;
			
			if(reviewDataList.size() > 0)
				warnStepData = reviewDataList.get(0);
			
			List<AlertSendDataVO> sendSMSList = null;
			
			if(warnStepData != null)
			{
				warnStepData.setFactCode(asData.getFactCode());
				warnStepData.setBranchNo(asData.getBranchNo());
				warnStepData.setItemCode(asData.getItemCode());
				sendSMSList= alertStepService.getSendWarningMsg(warnStepData);
			}
			mav.addObject("sendSMSList", sendSMSList);
			*/
		}
		
		//상황종료 페이지에 경보기준을 가져옵니다
		if("6".equals(step))
		{
			AlertSearchVO searchLaw = new AlertSearchVO();
			
			searchLaw.setFactCode(asData.getFactCode());
			searchLaw.setBranchNo(asData.getBranchNo());
			searchLaw.setItemCode(asData.getItemCode());
			
			AlertDataLawVo law = alertLawService.getFactLaw(searchLaw);
			mav.addObject("law", law);
			
			if(asData.getItemCode2() != null)
			{
				searchLaw.setItemCode(asData.getItemCode2());
				AlertDataLawVo law2 = alertLawService.getFactLaw(searchLaw);
				mav.addObject("law2", law2);
			}
			if(asData.getItemCode3() != null)
			{
				searchLaw.setItemCode(asData.getItemCode2());
				AlertDataLawVo law3 = alertLawService.getFactLaw(searchLaw);
				mav.addObject("law3", law3);
			}
		}
		
		LoginVO user = null;
		user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser(); 
		
		mav.addObject("alertCnt", alertCnt);
		mav.addObject("asData", asData);
		mav.addObject("dataList", dataList);
		mav.addObject("acctCnt", acctCnt);
		mav.addObject("data", data);
		mav.addObject("isReview", isReview);
		mav.addObject("reviewData", reviewData);
		
		mav.addObject("strName", user.getName());
		mav.addObject("DeptNo", user.getDeptNo());
		
		mav.setViewName(viewName);
		
		return mav;
	}
	
	@RequestMapping("/alert/addSmsSend.do")
	public ModelAndView addSmsSend(
			@RequestParam(value="asId") String asId,
			@RequestParam(value="memberId") String[] members,
			@RequestParam(value="msg") String msg
	) throws Exception
	{
		ModelAndView modelAndView = new ModelAndView();
		boolean sucess = true;
		
		try
		{
			AlertStepVO alertStepVO = new AlertStepVO(); 
			alertStepVO.setAsId(asId); 
			AlertStepVO asData			= alertStepService.getAlertStep(alertStepVO);
			
			sucess = alertStepService.addSendSMS(asData, members, msg);
		}
		catch(Exception ex)
		{
			sucess = false;
			log.debug(ex.getMessage());
		}
		
		modelAndView.addObject("sucess",sucess);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	
	@RequestMapping("/alert/addAlertStep.do")
	public ModelAndView addAlertStep (
			HttpServletRequest req,
			HttpServletResponse res,
			@ModelAttribute("AlertStepVO") AlertStepVO alertStepVO
	)
	throws Exception{
			
		//ModelAndView mav = new ModelAndView();	

		//1. 경보발생 -> 2.현장확인이 아닐 때
		//if(!"2".equals(alertStepVO.getAlertStep()))
		//{
			if("3".equals(alertStepVO.getAlertStep()))	 // 2.현장확인 -> 3.시료분석 OR 
			{
				String text = "";
				text += alertStepVO.getGov() + SPLIT_STR;
				text += alertStepVO.getPerson() + SPLIT_STR;
				text += alertStepVO.getPhone() + SPLIT_STR;
				text += alertStepVO.getDate() + " " + alertStepVO.getTime() + SPLIT_STR;
				text += alertStepVO.getReachDate() + " " + alertStepVO.getReachTime() + SPLIT_STR;
				text += alertStepVO.getFellowRider() + SPLIT_STR;
				text += ("1".equals(alertStepVO.getResult()) ? "시료채수" : "장비이상") + SPLIT_STR;
				text += alertStepVO.getAlertStepText();
				
			
				String tmpStep = alertStepVO.getAlertStep();
				String time = alertStepVO.getDate().replaceAll("/","") + alertStepVO.getTime().replaceAll(":", "");
				alertStepVO.setAlertTime(time);
				alertStepVO.setAlertStep("2");
				alertStepService.updateAlertTime(alertStepVO);
				
				alertStepVO.setAlertStep(tmpStep);
				alertStepVO.setAlertStepText(text);
				alertStepVO.setAlertTime(null);
				
			}
			if("6".equals(alertStepVO.getAlertStep()))	 // 2.현장확인 -> 3.시료분석 OR 
			{
				String text = "";
				text += alertStepVO.getGov() + SPLIT_STR;
				text += alertStepVO.getPerson() + SPLIT_STR;
				text += alertStepVO.getPhone() + SPLIT_STR;
				text += alertStepVO.getDate() + " " + alertStepVO.getTime() + SPLIT_STR;
				text += alertStepVO.getReachDate() + " " + alertStepVO.getReachTime() + SPLIT_STR;
				text += alertStepVO.getFellowRider() + SPLIT_STR;
				text += ("1".equals(alertStepVO.getResult()) ? "시료이송" : "장비이상") + SPLIT_STR;
				text += alertStepVO.getAlertStepText();
				
				
				String tmpStep = alertStepVO.getAlertStep();
				String time = alertStepVO.getDate().replaceAll("/","") + alertStepVO.getTime().replaceAll(":", "");
				alertStepVO.setAlertTime(time);
				alertStepVO.setAlertStep("2");
				alertStepService.updateAlertTime(alertStepVO);
				
				time = alertStepVO.getProcEndDate().replaceAll("/","") + alertStepVO.getProcEndTime().replaceAll(":", "");
				alertStepVO.setAlertTime(time);
				alertStepVO.setAlertStep(tmpStep);
				alertStepVO.setAlertStepText(text);
				
			}
			else if("4".equals(alertStepVO.getAlertStep()) || "10".equals(alertStepVO.getAlertStep())) //3.시료분석 -> 4.경보발령 OR 3.시료분석 -> 10.상황종료
			{
				String text = "";
				text += alertStepVO.getAnalGov() + SPLIT_STR;
				text += alertStepVO.getAnalPerson() + SPLIT_STR;
				text += alertStepVO.getAnalPhone() + SPLIT_STR;
				text += alertStepVO.getAnalDate() + " " + alertStepVO.getAnalTime() + SPLIT_STR;
				text += ("1".equals(alertStepVO.getAnalResult()) ? "경보발령" : "상황종료") + SPLIT_STR;
				text += alertStepVO.getAlertStepText();
				
				String tmpStep = alertStepVO.getAlertStep();
				String time = alertStepVO.getAnalDate().replaceAll("/","") + alertStepVO.getAnalTime().replaceAll(":", "");
				alertStepVO.setAlertTime(time);
				alertStepVO.setAlertStep("3");
				alertStepService.updateAlertTime(alertStepVO);
				
				if(!"10".equals(tmpStep))
				{
					alertStepVO.setAlertStep(tmpStep);
					alertStepVO.setAlertStepText(text);
					alertStepVO.setAlertTime(null);
				}
				else
				{
					time = alertStepVO.getProcEndDate().replaceAll("/","") + alertStepVO.getProcEndTime().replaceAll(":", "");
					alertStepVO.setAlertTime(time);
					alertStepVO.setAlertStep(tmpStep);
					alertStepVO.setAlertStepText(text);
				}
				//경보발령 SMS, ARS를 전송합니다//안합니다!
				//AlertStepVO asData	= alertStepService.getAlertStep(alertStepVO);
				//alertStepService.sendSMS(asData);
			}
			else if("5".equals(alertStepVO.getAlertStep())) //4.경보발령 -> 5. 상황조치
			{
				String text = "";
				text += alertStepVO.getWarnDate() + " " + alertStepVO.getWarnTime() + SPLIT_STR;
				text += alertStepVO.getIsSendSMS();
				
				
				String time = alertStepVO.getWarnDate().replaceAll("/","") + alertStepVO.getWarnTime().replaceAll(":", "");
				alertStepVO.setAlertTime(time);
				alertStepVO.setAlertStep("4");
				alertStepService.updateAlertTime(alertStepVO);
				
				alertStepVO.setAlertStep("5");
				alertStepVO.setAlertStepText(text);
				alertStepVO.setAlertTime(null);
				
				//String text = alertStepVO.getIsSendSMS();
				alertStepVO.setAlertStepText(text);
			}
			else if("7".equals(alertStepVO.getAlertStep()))//1.경보발생 -> 7.이상데이터(상황종료)
			{
				String time = alertStepVO.getDate().replaceAll("/","") + alertStepVO.getTime().replaceAll(":", "");
				alertStepVO.setAlertTime(time);
			}
			else if("8".equals(alertStepVO.getAlertStep()))	//5. 상황조치 -> 8. 상황종료
			{
				String text = "";
				text += alertStepVO.getProcGov() + SPLIT_STR;
				text += alertStepVO.getProcPerson() + SPLIT_STR;
				text += alertStepVO.getProcPhone() + SPLIT_STR;
				text += alertStepVO.getProcStartDate() + " " + alertStepVO.getProcStartTime() + SPLIT_STR;
				text += alertStepVO.getProcEndDate() + " " + alertStepVO.getProcEndTime() + SPLIT_STR;
				text += alertStepVO.getAlertStepText();
				
				  
				String time = alertStepVO.getProcStartDate().replaceAll("/","") + alertStepVO.getProcStartTime().replaceAll(":", "");
				alertStepVO.setAlertTime(time);
				alertStepVO.setAlertStep("5");
				alertStepService.updateAlertTime(alertStepVO);
				
				time = alertStepVO.getProcEndDate().replaceAll("/","") + alertStepVO.getProcEndTime().replaceAll(":", "");
				alertStepVO.setAlertStep("8");
				alertStepVO.setAlertStepText(text);
				alertStepVO.setAlertTime(time);
				
				
				alertStepVO.setAlertStepText(text);
			}
		//}
		//else
		//{
			//else
			//{
			//	alertStepVO.setAlertTime(null);
			//}
		//}
		
		alertStepService.updateAlertStep(alertStepVO);
		alertStepService.insertAlertStepSub(alertStepVO);
		
		res.setContentType("text/html; charset=UTF-8");
		
		String parameter = "?step=" + alertStepVO.getAlertStep();
		parameter += "&pageIndex=" + ServletRequestUtils.getStringParameter(req, "pageIndex", "");
		parameter += "&itemType=" + ServletRequestUtils.getStringParameter(req, "itemType", "");
		parameter += "&system=" + ServletRequestUtils.getStringParameter(req, "system", "");
		parameter += "&startDate=" + ServletRequestUtils.getStringParameter(req, "startDate", "");
		parameter += "&endDate=" + ServletRequestUtils.getStringParameter(req, "endDate", "");
		parameter += "&minOr=" + ServletRequestUtils.getStringParameter(req, "minOr", "");
		parameter += "&asId=" + alertStepVO.getAsId();
		parameter += "&cStep=" + alertStepVO.getAlertStep();
				
		res.getWriter().print("<script>alert('처리되었습니다.');top.location=\"/alert/alertMngView.do" + parameter + "\"</script>");
				
		
		return null;
	}
	

	/**
	 * @param req
	 * @param res
	 * @param alertStepVO
	 * @return 이전단계
	 * @throws Exception
	 */
	@RequestMapping("/alert/prevAlertStep.do")
	public String prevAlertStep (HttpServletRequest req,HttpServletResponse res,@ModelAttribute("AlertStepVO") AlertStepVO alertStepVO) throws Exception{

		alertStepService.prevAlertStep(alertStepVO);
		  
		res.setContentType("text/html; charset=UTF-8");
		
		String parameter = "?step=" + alertStepVO.getAlertStep();
		parameter += "&pageIndex=" + ServletRequestUtils.getStringParameter(req, "pageIndex", "");
		parameter += "&itemType=" + ServletRequestUtils.getStringParameter(req, "itemType", "");
		parameter += "&system=" + ServletRequestUtils.getStringParameter(req, "system", "");
		parameter += "&startDate=" + ServletRequestUtils.getStringParameter(req, "startDate", "");
		parameter += "&endDate=" + ServletRequestUtils.getStringParameter(req, "endDate", "");
		parameter += "&minOr=" + ServletRequestUtils.getStringParameter(req, "minOr", "");
		parameter += "&asId=" + alertStepVO.getAsId();
		parameter += "&cStep=" + alertStepVO.getAlertStep();
				
		res.getWriter().print("<script>alert('처리되었습니다.');top.location=\"/alert/alertMngView.do" + parameter + "\"</script>");
		return null;
	}

	/**
	 * 3분안에 등록된 사고발생접수건을 가져옵니다.
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/getRecentAlertReg.do")
	public ModelAndView getAlertListView() throws Exception{
		
		ModelAndView	modelAndView	= new ModelAndView();	

		AlertStepVO data = alertStepService.getRecentAlertReg();

		modelAndView.addObject("data", data);
		modelAndView.setViewName("jsonView"); 
		return modelAndView;
	}
	

	/**
	 * 3분안에 등록된 사고발생접수건을 가져옵니다.
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/getNewWarring.do")
	public ModelAndView getNewWarring(AlertStepVO vo) throws Exception{
		
		ModelAndView	modelAndView	= new ModelAndView();	
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		vo.setMemberId(user.getId());
		AlertStepVO data = alertStepService.getNewWarring(vo);

		modelAndView.addObject("data", data);
		modelAndView.setViewName("jsonView"); 
		return modelAndView;
	}
	
}