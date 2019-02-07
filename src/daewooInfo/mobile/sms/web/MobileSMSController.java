package daewooInfo.mobile.sms.web;

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
 * sms 전송
 * @author hoe-seop, choi
 * @since 2016.06.03
 * @version 1.0
 * @see
 *
 * <pre>
 *	
 *	수정일	  수정자			수정내용
 *  -------	--------	---------------------------
 *	2016.06.03  hoe-seop, choi		 최초 생성
 *
 * </pre>
 */
@Controller
public class MobileSMSController {	

	@Resource(name = "WaterPollutionService")
	private WaterPollutionService waterPollutionService;
	
	@Resource(name = "EgovFileMngUtil")
	private EgovFileMngUtil fileUtil;
	
	@Resource(name = "alrimService")
	private AlrimService alrimService;         

	/**
	 * 사고관리 등록화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/mobile/sub/sms/smsRegist.do")
	public String waterPollutionRegist(@ModelAttribute("waterPollutionSearchVO") WaterPollutionSearchVO waterPollutionSearchVO, ModelMap model ) throws Exception {

		return "/mobile/sub/sms/smsRegist";
	}
	
	/**
	 * SMS 발송 처리
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
	@RequestMapping("/mobile/sub/sms/smsRegProc.do")
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
//		System.out.println("member >>>>>>>>>>>>> " + members);
		String[] memberId = members.split(",");
//		System.out.println("length >>>>>>>>>>>>> " + memberId.length);
		
		int smsResult = 0;

		try{
			smsResult = SendSMS.sendRegSmsWaterPollution(wpCode,Integer.toString('0'), memberId, smsContent, "SMS전송");
		}
		catch(Exception ex){
		}
		
		try{
			if (smsResult <= 0 ) {
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('경보 대상자가 없어서 SMS전송이  실패했습니다.');document.location.replace('/mobile/sub/sms/smsRegist.do')</script>");
			} else {
				res.setContentType("text/html; charset=UTF-8");
				res.getWriter().print("<script>alert('전송되었습니다.');document.location.href='/mobile/sub/sms/smsRegist.do'</script>");
			}
		}catch(Exception e){
			e.printStackTrace();
		}		
		return null;
	}
}