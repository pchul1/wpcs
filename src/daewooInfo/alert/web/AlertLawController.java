package daewooInfo.alert.web;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.alert.bean.AlertLawVO;
import daewooInfo.alert.bean.AlertSearchVO;
import daewooInfo.alert.service.AlertLawService;

/**
 * 경보기준설정을 위한 컨트롤러  클래스
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
public class AlertLawController {
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log log = LogFactory.getLog(AlertLawController.class);
	
	/**
	 * @uml.property  name="alertLawService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertLawService")
    private AlertLawService alertLawService;	
	
	@RequestMapping("/alert/alertLaw.do")
	public String alertLaw() throws Exception {
		return "alert/alertLaw"; //return String
	}	
	
	@RequestMapping("/alert/alertLawA.do")
	public String alertLawA() throws Exception {
		return "alert/alertLawA"; //return String
	}	
	
	/**
	 * 경보기준설정 목록을 가져온다.
	 * 
	 * @param factCode
	 * @param branchNo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/getAlertLawList.do")
    public ModelAndView getAlertLawList(
    		@RequestParam(value="factCode", required=false) String factCode
    		,@RequestParam(value="branchNo", required=false) String branchNo
    		) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	

        AlertSearchVO vo = new AlertSearchVO();
        vo.setFactCode(factCode);
        vo.setBranchNo(Integer.parseInt(branchNo));

        List<AlertLawVO> alertLawList =  alertLawService.getAlertLawList(vo);

        modelAndView.addObject("alertLawList", alertLawList);
        modelAndView.setViewName("jsonView");

        return modelAndView;
    }	
	
	
	/**
	 * 경보기준설정 목록을 가져온다.
	 * 
	 * @param factCode
	 * @param branchNo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/getAlertLawSubList.do")
    public ModelAndView getAlertLawSubList(
    		@RequestParam(value="factCode", required=false) String factCode
    		,@RequestParam(value="branchNo", required=false) String branchNo
    		,@RequestParam(value="fidItemCode", required=false) String fidItemCode
    		) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	

        AlertSearchVO vo = new AlertSearchVO();
        vo.setFactCode(factCode);
        vo.setBranchNo(Integer.parseInt(branchNo));
        vo.setFidItemCode(fidItemCode);

        List<AlertLawVO> alertLawList =  alertLawService.getAlertLawSubList(vo);

        modelAndView.addObject("alertLawList", alertLawList);
        modelAndView.setViewName("jsonView");

        return modelAndView;
    }	
	
	/**
	 * 경보기준설정 목록을 가져온다.
	 * 
	 * @param factCode
	 * @param branchNo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/getAlertLawSubList_empty.do")
    public ModelAndView getAlertLawSubList_empty(
    		@RequestParam(value="factCode", required=false) String factCode
    		,@RequestParam(value="branchNo", required=false) String branchNo
    		,@RequestParam(value="fidItemCode", required=false) String fidItemCode
    		) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	

        AlertSearchVO vo = new AlertSearchVO();
        vo.setFactCode(factCode);
        vo.setBranchNo(Integer.parseInt(branchNo));
        vo.setFidItemCode(fidItemCode);

        List<AlertLawVO> alertLawList =  alertLawService.getAlertLawSubList_empty(vo);

        modelAndView.addObject("alertLawList", alertLawList);
        modelAndView.setViewName("jsonView");

        return modelAndView;
    }	
	
	/**
	 * 경보기준설정을 추가하거나 갱신한다.
	 * 
	 * @param factCode
	 * @param branchNo
	 * @param itemCode
	 * @param lawHighValue
	 * @param lawLowValue
	 * @param lawAlarm1Value
	 * @param lawAlarm2Value
	 * @param lawApply
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/saveAlertLawData.do")
	public ModelAndView saveAlertTargetData(
			@RequestParam(value="factCode", required=false) String[] factCode
			,@RequestParam(value="branchNo", required=false) String[] branchNo
			,@RequestParam(value="itemCode", required=false) String[] itemCode			
			,@RequestParam(value="lawHighValue", required=false) String[] lawHighValue
			,@RequestParam(value="lawLowValue", required=false) String[] lawLowValue
			,@RequestParam(value="lawAlarm1Value", required=false) String[] lawAlarm1Value
			,@RequestParam(value="lawAlarm2Value", required=false) String[] lawAlarm2Value
			,@RequestParam(value="lawApply", required=false) String[] lawApply		
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		AlertLawVO vo = null;
		 
		for(int i=0; i<factCode.length; i++) {
			
			vo = new AlertLawVO(); 
			vo.setLawApply(lawApply[i]);
			vo.setFactCode(factCode[i]);
			vo.setBranchNo(Integer.parseInt(branchNo[i]));
			vo.setItemCode(itemCode[i]);		
			vo.setLawHighValue(Float.parseFloat(lawHighValue[i]));
			
			if(lawLowValue != null && lawLowValue.length > 0)
				vo.setLawLowValue(Float.parseFloat(lawLowValue[i]));
			else
				vo.setLawLowValue(0F);
			if(lawAlarm1Value != null && lawLowValue.length > 0)
				vo.setLawAlarm1Value(Float.parseFloat(lawAlarm1Value[i]));
			else
				vo.setLawAlarm1Value(0F);
			
			if(lawAlarm2Value != null && lawAlarm2Value.length > 0)
				vo.setLawAlarm2Value(Float.parseFloat(lawAlarm2Value[i])); 
			else
				vo.setLawAlarm2Value(0F);
			
//			alertLawService.updateFactLaw(vo);
			alertLawService.mergeAlertLaw(vo);
		} 
        modelAndView.setViewName("jsonView"); 
        return modelAndView;
	}
	
	
	/**
	 * VOC FID 항목에 따른 ECD항목의 기준설정을 추가하거나 갱신한다.
	 */
	@RequestMapping("/alert/saveAlertLawSubData.do")
	public ModelAndView saveAlertLawSubData(
			@RequestParam(value="factCode_sub", required=false) String[] factCode
			,@RequestParam(value="branchNo_sub", required=false) String[] branchNo
			,@RequestParam(value="itemCode_sub", required=false) String[] itemCode			
			,@RequestParam(value="fidItemCode_sub", required=false) String[] fidItemCode			
			,@RequestParam(value="lawHighValue_sub", required=false) String[] lawHighValue
			,@RequestParam(value="lawApply_sub", required=false) String[] lawApply		
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		AlertLawVO vo = null;
		 
		for(int i=0; i<factCode.length; i++) {
			
			vo = new AlertLawVO(); 
			
			vo.setLawApply(lawApply[i]);
			vo.setFactCode(factCode[i]);
			vo.setBranchNo(Integer.parseInt(branchNo[i]));
			vo.setItemCode(itemCode[i]);		
			vo.setFidItemCode(fidItemCode[i]);
			vo.setLawHighValue(Float.parseFloat(lawHighValue[i]));
			
			alertLawService.mergeAlertLawSub(vo);
		} 
        modelAndView.setViewName("jsonView"); 
        return modelAndView;
	}
	

	/**
	 * 경보기준설정을 삭제한다.(미사용)
	 * 
	 * @param lawId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/deleteAlertLawData.do")
	public ModelAndView deleteAlertLawData(
			@RequestParam(value="lawId", required=false) String[] lawId
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		AlertLawVO vo = new AlertLawVO();		
		
		for(int i=0; i<lawId.length; i++) {
			vo = new AlertLawVO();
			alertLawService.deleteAlertLaw(vo);
		}

        modelAndView.setViewName("jsonView");

        return modelAndView;
	}
}
