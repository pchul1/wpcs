package daewooInfo.alert.web;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.bean.AlertTaksuConfigVO;
import daewooInfo.alert.service.AlertTaksuConfigService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;

/**
 * 경보환경설정을 위한 컨트롤러  클래스
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------       --------    ---------------------------
 *   2010.6.28  김태훈          최초 생성
 *
 * </pre>
 */
@Controller
public class AlertTaksuConfigController {
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log log = LogFactory.getLog(AlertTaksuConfigController.class);
	
	/**
	 * @uml.property  name="alertTakSuConfigService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertTakSuConfigService")
    private AlertTaksuConfigService alertTakSuConfigService;	

	@RequestMapping("/alert/alertTaksuConfig.do")
	public ModelAndView alertTaksuConfig() throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();		
	
		modelAndView.setViewName("alert/alertTaksuConfig");
		
		return modelAndView; //return String
	}		
	
	/**
	 * 탁수 경보환경설정 목록을 가져온다.
	 * 
	 * @param system
	 * @param factCode
	 * @param branchNo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/getAlertTaksuConfigList.do")
    public ModelAndView getAlertTaksuConfigList() throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	

		List<AlertTaksuConfigVO> alertTaksuConfigList =  alertTakSuConfigService.getAlertTaksuConfig();

        modelAndView.addObject("alertTaksuConfigList", alertTaksuConfigList);
        modelAndView.setViewName("jsonView");

        return modelAndView;
    }		
	
	/**
	 * 탁수 경보환경설정을 추가하거나 갱신한다.
	 * 
	 * @param factCode
	 * @param alertFlag
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/saveAlertTaksuConfig.do")
	public ModelAndView saveAlertTaksuConfig(
			@RequestParam(value="factCode", required=false) String factCode
			,@RequestParam(value="alertFlag", required=false) String alertFlag
			,@RequestParam(value="alertEtcFlag", required=false) String alertEtcFlag
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		AlertTaksuConfigVO vo = new AlertTaksuConfigVO();
		String memberId = "";
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		memberId = user.getId();

		vo.setFactCode(factCode);
		vo.setAlertFlag(alertFlag);	
		vo.setAlertEtcFlag(alertEtcFlag);
		alertTakSuConfigService.mergeAlertTaksuConfig(vo);

		vo = new AlertTaksuConfigVO();
		vo.setFactCode(factCode);
		vo.setAlertFlag(alertFlag);
		vo.setMemberId(memberId);
		vo.setAlertEtcFlag(alertEtcFlag);
		alertTakSuConfigService.insertAlertTaksuConfigHist(vo);

        modelAndView.setViewName("jsonView");

        return modelAndView;
	}		
	
	@RequestMapping("/alert/alertTaksuConfigHist.do")
	public ModelAndView alertTaksuConfigHist() throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();		

		modelAndView.setViewName("alert/alertTaksuConfigHist");
		
		return modelAndView; //return String
	}			
	
	/**
	 * 탁수 경보환경설정 목록을 가져온다.
	 * 
	 * @param system
	 * @param factCode
	 * @param branchNo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/getAlertTaksuConfigHistList.do")
    public ModelAndView getAlertTaksuConfigHistList(
			@RequestParam(value="factCode", required=false) String factCode
			,@RequestParam(value="sugye", required=false) String sugye
			,@RequestParam(value="startDate", required=false) String startDate    		
			,@RequestParam(value="endDate", required=false) String endDate
    		) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	

		AlertSearchVO vo = new AlertSearchVO();
		vo.setSugye(sugye);
		vo.setFactCode(factCode);
		vo.setStartDate(startDate);
		vo.setEndDate(endDate);
		
		List<AlertTaksuConfigVO> alertTaksuConfigHistList =  alertTakSuConfigService.getAlertTaksuConfigHist(vo);

        modelAndView.addObject("alertTaksuConfigHistList", alertTaksuConfigHistList);
        modelAndView.setViewName("jsonView");

        return modelAndView;
    }		
}
