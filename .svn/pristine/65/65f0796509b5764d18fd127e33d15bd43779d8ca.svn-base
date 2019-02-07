package daewooInfo.mobile.alert.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.alert.bean.AlertDataLawVo;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertStepVO;
import daewooInfo.alert.service.AlertLawService;
import daewooInfo.alert.service.AlertMngService;
import daewooInfo.alert.service.AlertStepService;
import daewooInfo.cmmn.service.TmsComUtlService;
import daewooInfo.common.util.EgovFileMngUtil;
import daewooInfo.mobile.com.utl.LogInfoUtil;
import daewooInfo.mobile.com.utl.ObjectUtil;
import daewooInfo.mock.bean.ErrorCodeVO;
import daewooInfo.mock.service.MockService;
import daewooInfo.stats.bean.StatsSearchVO;
import daewooInfo.stats.bean.StatsVO;
import daewooInfo.stats.service.StatsService;
import daewooInfo.waterpolmnt.waterinfo.bean.RiverWater3HourWarningSearchVO;
import daewooInfo.waterpolmnt.waterinfo.bean.RiverWater3HourWarningVO;
import daewooInfo.waterpolmnt.waterinfo.service.WaterinfoService;

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
public class MobileAlertMngController {
	
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log log = LogFactory.getLog(MobileAlertMngController.class);
	
	private static String ETC_FACT_CODE 	= "50A0001";	//사고접수사업장(기타사업장)
	private static String LAW_VALUE_OVER 	= "3";			//기준 초과 시 상수
	private static int BRANCH_NO 			= 1;			//측정소
	
	@Resource(name = "alertMngService")
	private AlertMngService alertMngService;
	 
	@Resource(name = "statsService")
	private StatsService statsService;
	
	@Resource(name = "alertStepService")
	private AlertStepService alertStepService;
	
	@Resource(name = "TmsComUtlService")
	private TmsComUtlService tmsComUtlService;
	
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	@Resource(name = "alertLawService")
	private AlertLawService alertLawService;
	
	@Resource(name = "waterinfoService")
	private WaterinfoService waterinfoService;
	
	@Resource(name = "mockService")
	private MockService mockService;
	/**
	 * 일지 목록을 가져온다. -> 상황완료된 사고리스트를 가져옵니다
	 *
	 * @param alertMngVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/alert/alertMngSearch.do")
	public String alertMngSearch(@ModelAttribute("alertStepVO") AlertStepVO alertStepVO, ModelMap model) throws Exception{
		
		model.addAttribute("param_s", alertStepVO);
		return "/mobile/sub/alert/alertMngSearch";
	}

	/**
	 * 일지 목록을 가져온다. -> 상황완료된 사고리스트를 가져옵니다
	 *
	 * @param alertMngVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/alert/alertMngList.do")
	public String alertMngList(@ModelAttribute("statsSearchVO") AlertStepVO alertStepVO, ModelMap model) throws Exception{
		
		alertStepVO.setStartDate(alertStepVO.getStartDate().replaceAll("/", ""));
		alertStepVO.setEndDate(alertStepVO.getEndDate().replaceAll("/", ""));
		alertStepVO.setFirstIndex(0);
		alertStepVO.setRecordCountPerPage(100000);
		
		StatsSearchVO statsSearchVO = new StatsSearchVO();
		BeanUtils.copyProperties(statsSearchVO, alertStepVO);
		
		//조회조건
		alertStepVO.setIsComplete("Y");
		alertStepVO.setMinOr("0");
		
		List<StatsVO> preventStatsList =  statsService.getPreventStatsList(statsSearchVO);
		//시스템 통계
		model.addAttribute("StatsList", preventStatsList);
		model.addAttribute("List", alertStepService.getAlertStepList(alertStepVO));
		model.addAttribute("param_s", alertStepVO);
		
		return "/mobile/sub/alert/alertMngList";
	}
	
	/**
	 * step1 상황 일지를 가져온다.
	 * 
	 * @param alertStepVO
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/alert/alertMngView1.do")
	public String alertMngView1(@ModelAttribute("statsSearchVO") AlertStepVO alertStepVO, ModelMap model, HttpServletRequest request) throws Exception{
		this.StartCommonAlertMngView(alertStepVO, model, request);
		return "/mobile/sub/alert/alertMngView1";
	}
	
	@RequestMapping("/mobile/sub/alert/alertMngView9.do")
	public String alertMngView9(@ModelAttribute("statsSearchVO") AlertStepVO alertStepVO, ModelMap model, HttpServletRequest request) throws Exception{
		this.StartCommonAlertMngView(alertStepVO, model, request);
		return "/mobile/sub/alert/alertMngView1";
	}


	/**
	 * step2 상황 일지를 가져온다.
	 * 
	 * @param alertStepVO
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/alert/alertMngView2.do")
	public String alertMngView2(@ModelAttribute("statsSearchVO") AlertStepVO alertStepVO, ModelMap model, HttpServletRequest request) throws Exception{
		AlertStepVO asData = alertStepService.getAlertStep(alertStepVO);
		this.CommonAlertMngView(alertStepVO, asData, model, request);
		return "/mobile/sub/alert/alertMngView2";
	}
	

	/**
	 * step3 상황 일지를 가져온다.
	 * 
	 * @param alertStepVO
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/alert/alertMngView3.do")
	public String alertMngView3(@ModelAttribute("statsSearchVO") AlertStepVO alertStepVO, ModelMap model, HttpServletRequest request) throws Exception{
		AlertStepVO asData = alertStepService.getAlertStep(alertStepVO);
		this.CommonAlertMngView(alertStepVO, asData, model, request);
		return "/mobile/sub/alert/alertMngView3";
	}


	/**
	 * step4 상황 일지를 가져온다.
	 * 
	 * @param alertStepVO
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/alert/alertMngView4.do")
	public String alertMngView4(@ModelAttribute("statsSearchVO") AlertStepVO alertStepVO, ModelMap model, HttpServletRequest request) throws Exception{
		AlertStepVO asData = alertStepService.getAlertStep(alertStepVO);
		this.CommonAlertMngView(alertStepVO, asData, model, request);
		return "/mobile/sub/alert/alertMngView4";
	}
	

	/**
	 * step5 상황 일지를 가져온다.
	 * 
	 * @param alertStepVO
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/alert/alertMngView5.do")
	public String alertMngView5(@ModelAttribute("statsSearchVO") AlertStepVO alertStepVO, ModelMap model, HttpServletRequest request) throws Exception{
		AlertStepVO asData = alertStepService.getAlertStep(alertStepVO);
		this.CommonAlertMngView(alertStepVO, asData, model, request);
		return "/mobile/sub/alert/alertMngView5";
	}
	
	/**
	 * step6 상황 일지를 가져온다.
	 * 
	 * @param alertStepVO
	 * @param model
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/alert/alertMngView6.do")
	public String alertMngView6(@ModelAttribute("statsSearchVO") AlertStepVO alertStepVO, ModelMap model, HttpServletRequest request) throws Exception{
		this.EndCommonAlertMngView(alertStepVO, model, request);
		return "/mobile/sub/alert/alertMngView6";
	}
	@RequestMapping("/mobile/sub/alert/alertMngView7.do")
	public String alertMngView7(@ModelAttribute("statsSearchVO") AlertStepVO alertStepVO, ModelMap model, HttpServletRequest request) throws Exception{
		this.EndCommonAlertMngView(alertStepVO, model, request);
		return "/mobile/sub/alert/alertMngView6";
	}
	@RequestMapping("/mobile/sub/alert/alertMngView8.do")
	public String alertMngView8(@ModelAttribute("statsSearchVO") AlertStepVO alertStepVO, ModelMap model, HttpServletRequest request) throws Exception{
		this.EndCommonAlertMngView(alertStepVO, model, request);
		return "/mobile/sub/alert/alertMngView6";
	}
	@RequestMapping("/mobile/sub/alert/alertMngView10.do")
	public String alertMngView10(@ModelAttribute("statsSearchVO") AlertStepVO alertStepVO, ModelMap model, HttpServletRequest request) throws Exception{
		this.EndCommonAlertMngView(alertStepVO, model, request);
		return "/mobile/sub/alert/alertMngView6";
	}
	
	/**
	 * @param req
	 * @param res
	 * @param alertStepVO
	 * @return 상황 단계 진행
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/alert/addAlertStep.do")
	public String addAlertStep (HttpServletRequest req,HttpServletResponse res,@ModelAttribute("AlertStepVO") AlertStepVO alertStepVO) throws Exception{
		if("3".equals(alertStepVO.getAlertStep()))	 // 2.현장확인 -> 3.시료분석 OR 
		{
			String text = "";
			text += alertStepVO.getGov() + "|";
			text += alertStepVO.getPerson() + "|";
			text += alertStepVO.getPhone() + "|";
			text += alertStepVO.getDate() + " " + alertStepVO.getTime() + "|";
			text += alertStepVO.getReachDate() + " " + alertStepVO.getReachTime() + "|";
			text += alertStepVO.getFellowRider() + "|";
			text += ("1".equals(alertStepVO.getResult()) ? "시료채수" : "장비이상") + "|";
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
			text += alertStepVO.getGov() + "|";
			text += alertStepVO.getPerson() + "|";
			text += alertStepVO.getPhone() + "|";
			text += alertStepVO.getDate() + " " + alertStepVO.getTime() + "|";
			text += alertStepVO.getReachDate() + " " + alertStepVO.getReachTime() + "|";
			text += alertStepVO.getFellowRider() + "|";
			text += ("1".equals(alertStepVO.getResult()) ? "시료이송" : "장비이상") + "|";
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
			text += alertStepVO.getAnalGov() + "|";
			text += alertStepVO.getAnalPerson() + "|";
			text += alertStepVO.getAnalPhone() + "|";
			text += alertStepVO.getAnalDate() + " " + alertStepVO.getAnalTime() + "|";
			text += ("1".equals(alertStepVO.getAnalResult()) ? "경보발령" : "상황종료") + "|";
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
			text += alertStepVO.getWarnDate() + " " + alertStepVO.getWarnTime() + "|";
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
			text += alertStepVO.getProcGov() + "|";
			text += alertStepVO.getProcPerson() + "|";
			text += alertStepVO.getProcPhone() + "|";
			text += alertStepVO.getProcStartDate() + " " + alertStepVO.getProcStartTime() + "|";
			text += alertStepVO.getProcEndDate() + " " + alertStepVO.getProcEndTime() + "|";
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

		alertStepService.updateAlertStep(alertStepVO);
		alertStepService.insertAlertStepSub(alertStepVO);
		
		res.setContentType("text/html; charset=UTF-8");
		
		String param = ObjectUtil.ParamString(alertStepVO, "asId,alertStep"); 
		String link = "/mobile/sub/alert/alertMngView" + alertStepVO.getAlertStep() +".do";
		res.getWriter().print("<script>alert('처리되었습니다.');location.replace('" + link + param + "');</script>");
		return null;
	}
	
	/**
	 * @param req
	 * @param res
	 * @param alertStepVO
	 * @return 이전단계
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/alert/prevAlertStep.do")
	public String prevAlertStep (HttpServletRequest req,HttpServletResponse res,@ModelAttribute("AlertStepVO") AlertStepVO alertStepVO) throws Exception{

		alertStepService.prevAlertStep(alertStepVO);
		
		res.setContentType("text/html; charset=UTF-8");
		String param = ObjectUtil.ParamString(alertStepVO, "asId,alertStep"); 
		String link = "/mobile/sub/alert/alertMngView" + alertStepVO.getAlertStep() +".do";
		res.getWriter().print("<script>alert('처리되었습니다.');location.replace('" + link + param + "');</script>");
		return null;
	}
	
	/**
	 * 상황관리 단계 공통 함수
	 * 
	 * @param alertStepVO
	 * @param asData
	 * @param model
	 * @param request
	 * @throws Exception
	 */
	public void CommonAlertMngView(AlertStepVO alertStepVO, AlertStepVO asData, ModelMap model, HttpServletRequest request) throws Exception{
		// 주소 입력
		if(asData.getAddress() != null && !"".equals(asData.getAddress()))
		{
			asData.setAddress(asData.getAddress().trim());
			String[] addrTmp = asData.getAddress().split(" ");
			
			if(addrTmp.length > 1)
			{
				asData.setAddr_short(addrTmp[0] + " " + addrTmp[1]);
			}
		}

		 
		if(!("10".equals(alertStepVO.getAlertStep()) || "6".equals(alertStepVO.getAlertStep()) || "7".equals(alertStepVO.getAlertStep()) || "8".equals(alertStepVO.getAlertStep()))){
			List<AlertStepVO> dataList  = alertStepService.getAlertStepSubList(alertStepVO);
			AlertStepVO data = new AlertStepVO();
			if(dataList.size() > 0) data = dataList.get(0);
			model.addAttribute("dataList", dataList);
			model.addAttribute("data", data);
		}
		
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

		//이전단계의 상황조치 데이터를 가져오는 부분
		boolean isReview = false;
		String[] reviewData = null;
		int asAlert = Integer.parseInt(asData.getAlertStep());	//현재 상황조치상태
		int popAlert = Integer.parseInt(alertStepVO.getAlertStep());	//확인하려는 팝업창의 상황조치 상태
		  
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
						reviewData = reData.getAlertStepText().split("\\|");
					}
					else
						reviewData = new String[] {"-", "-"};
				}
			}
		}
		
		model.addAttribute("param_s",alertStepVO);
		model.addAttribute("isReview", isReview);
		model.addAttribute("reviewData", reviewData);
		
		model.addAttribute("strName", LogInfoUtil.GetSessionLogin().getName());
		model.addAttribute("DeptNo", LogInfoUtil.GetSessionLogin().getDeptNo());
		
		model.addAttribute("alertCnt", alertCnt);
		model.addAttribute("asData", asData);
		model.addAttribute("acctCnt", acctCnt);
		

		alertStepVO.setAlertStep("all");
		String AllstepList = "";
		for(AlertStepVO vo: alertStepService.getAlertStepSubList(alertStepVO)){
			AllstepList += vo.getAlertStepNum();
		}
		model.addAttribute("AllstepList", AllstepList);
	}

	/**
	 * 상황관리 시작 단계 공통 함수
	 * 
	 * @param alertStepVO
	 * @param asData
	 * @param model
	 * @param request
	 * @throws Exception
	 */
	public void StartCommonAlertMngView(AlertStepVO alertStepVO, ModelMap model, HttpServletRequest request) throws Exception{
		String sys = "";
		AlertStepVO asData = alertStepService.getAlertStep(alertStepVO);
		if(asData != null) sys = asData.getSystem();

		int acct_cnt = Integer.parseInt(asData.getAlertCount());
		int alertCnt = 0;
		
		if(acct_cnt == 1) alertCnt = 3;
		else if(acct_cnt == 2) alertCnt = 9;
		else if(acct_cnt >= 3) alertCnt = 21;
		
		RiverWater3HourWarningSearchVO riverWater3HourWarningSearchVO = new RiverWater3HourWarningSearchVO();
		
		riverWater3HourWarningSearchVO.setAs_id(alertStepVO.getAsId());
		riverWater3HourWarningSearchVO.setAlertTime(alertCnt);
		riverWater3HourWarningSearchVO.setSys_kind(sys);
		
		List<RiverWater3HourWarningVO> warningData =  waterinfoService.getRiverWater3HourWarningPopDetail(riverWater3HourWarningSearchVO);
		model.addAttribute("warningData", warningData);
		
		//에러 코드 리스트
		List<ErrorCodeVO> errorCodeList = mockService.getErrorCode();
	
		model.addAttribute("errorCodeList", errorCodeList);
		this.CommonAlertMngView(alertStepVO, asData, model, request);
	}
	
	/**
	 * 상황관리 종료 단계 공통 함수
	 * 
	 * @param alertStepVO
	 * @param asData
	 * @param model
	 * @param request
	 * @throws Exception
	 */
	public void EndCommonAlertMngView(AlertStepVO alertStepVO, ModelMap model, HttpServletRequest request) throws Exception{


		String step = alertStepVO.getAlertStep();
		AlertStepVO asData = alertStepService.getAlertStep(alertStepVO);
		alertStepVO.setAlertStep("all");
		
		List<AlertStepVO> dataList  = alertStepService.getAlertStepSubList(alertStepVO);
		
		//다른 데이터들 다 빼고...  마지막 데이터(내용)만 가져옴
		for(AlertStepVO stepVO : dataList)
		{
			if(stepVO.getAlertStepText() == null)
			{
				stepVO.setAlertStepText("");
			}
			stepVO.setAlertStepText(stepVO.getAlertStepText().replaceAll("\\<br>", "\r\n"));
			stepVO.setAlertStepText(stepVO.getAlertStepText().replaceAll("\\<br/>", "\r\n"));
			String[] tmp = stepVO.getAlertStepText().split("\\|");
			
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
				model.addAttribute("endTime", stepVO.getAlertStepTimeStr());
			}
		}
		

		AlertSearchVO searchLaw = new AlertSearchVO();
		
		searchLaw.setFactCode(asData.getFactCode());
		searchLaw.setBranchNo(asData.getBranchNo());
		searchLaw.setItemCode(asData.getItemCode());
		
		AlertDataLawVo law = alertLawService.getFactLaw(searchLaw);
		model.addAttribute("law", law);
		
		if(asData.getItemCode2() != null)
		{
			searchLaw.setItemCode(asData.getItemCode2());
			AlertDataLawVo law2 = alertLawService.getFactLaw(searchLaw);
			model.addAttribute("law2", law2);
		}
		if(asData.getItemCode3() != null)
		{
			searchLaw.setItemCode(asData.getItemCode2());
			AlertDataLawVo law3 = alertLawService.getFactLaw(searchLaw);
			model.addAttribute("law3", law3);
		}
		alertStepVO.setAlertStep(step);
		model.addAttribute("dataList", dataList);
		this.CommonAlertMngView(alertStepVO, asData, model, request);
	}
}
