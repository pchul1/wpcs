package daewooInfo.alert.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.bouncycastle.asn1.ocsp.Request;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.admin.cmmncode.bean.CmmnCode;
import daewooInfo.admin.cmmncode.service.CmmnCodeManageService;
import daewooInfo.alert.bean.AlertConfigVO;
import daewooInfo.alert.bean.AlertLawVO;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.service.AlertConfigService;
import daewooInfo.common.login.bean.LoginVO;

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
public class AlertConfigController {
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log log = LogFactory.getLog(AlertConfigController.class);
	
	/**
	 * @uml.property  name="alertConfigService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertConfigService")
    private AlertConfigService alertConfigService;	

	@RequestMapping("/alert/alertConfig.do")
	public ModelAndView alertConfig() throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();	
		modelAndView.setViewName("alert/alertConfig");
		
		return modelAndView; //return String
	}	
	
	/**
	 * 경보환경설정 목록을 가져온다.
	 * 
	 * @param system
	 * @param factCode
	 * @param branchNo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/getAlertConfigList.do")
    public ModelAndView getAlertConfigList( 
    		@RequestParam(value="system", required=false) String system
    		,@RequestParam(value="factCode", required=false) String factCode
    		,@RequestParam(value="branchNo", required=false) String branchNo
    		) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	

        AlertSearchVO vo = new AlertSearchVO();
        vo.setSystem(system);
        vo.setFactCode(factCode);
        vo.setBranchNo(Integer.parseInt(branchNo));

        List<AlertConfigVO> alertConfigList =  alertConfigService.getAlertConfigList(vo);

        modelAndView.addObject("alertConfigList", alertConfigList);
        modelAndView.setViewName("jsonView");

        return modelAndView;
    }	 
	@RequestMapping("/alert/saveAlertConfigData.do")
	public ModelAndView saveAlertConfigData(
			@RequestParam(value="factCode", required=false) 	String[] factCode
			,@RequestParam(value="branchNo", required=false) 	String[] branchNo		
			,@RequestParam(value="itemCode", required=false) 	String[] itemCode
			,@RequestParam(value="arsStr", required=false) 		String 	 arsStr			
			,@RequestParam(value="smsStr", required=false) 		String   smsStr
			,@RequestParam(value="alertTerm", required=false) 	String[] alertTerm
			,@RequestParam(value="used", required=false) 		String[] used	
			) throws Exception{ 
		
		ModelAndView modelAndView  = new ModelAndView(); 
		AlertConfigVO 			vo = null; 
		
		String[] arsArr = arsStr.split(",");
		String[] smsArr = smsStr.split(",");
		 
		for(int i=0; i<factCode.length; i++) {
			vo = new AlertConfigVO(); 
			vo.setArsFlag(arsArr[i]);
			vo.setSmsFlag(smsArr[i]);
			vo.setFactCode(factCode[i]);
			vo.setBranchNo(Integer.parseInt(branchNo[i]));
			vo.setItemCode(itemCode[i]); 
			vo.setAlertTerm(Integer.parseInt(alertTerm[i]));
			vo.setUsed(used[i]); 
//			alertConfigService.updateAlertConfig(vo);			
			alertConfigService.mergeAlertConfig(vo);			
		} 
        modelAndView.setViewName("jsonView");

        return modelAndView;
	} 	

	@RequestMapping("/alert/alertConfigTime.do")
	public String alertConfigTime(ModelMap model) throws Exception {
		model.addAttribute("View", alertConfigService.getAlertConfigTimeView());
		return "alert/alertConfigTime";
	}
	

	@RequestMapping("/alert/mergeAlertConfigTime.do")
	public String mergeAlertConfigTime(ModelMap model, AlertConfigVO vo) throws Exception {
		alertConfigService.mergeAlertConfigTime(vo);
		return "forward:/alert/alertConfigTime.do";
	}
}
