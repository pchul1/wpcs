package daewooInfo.alert.web;

import java.util.HashMap;
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
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.alert.bean.AlertTargetVO;
import daewooInfo.alert.service.AlertTargetService;
import daewooInfo.cmmn.service.TmsComUtlService;

/**
 * 전파대상관리를 위한 컨트롤러  클래스
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
public class AlertTargetController {
	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log log = LogFactory.getLog(AlertTargetController.class);
	
	/**
	 * @uml.property  name="alertTargetService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alertTargetService")
    private AlertTargetService alertTargetService;
	
    /**
	 * @uml.property  name="tmsComUtlService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "TmsComUtlService")
    private TmsComUtlService tmsComUtlService;	
	
	@RequestMapping("/alert/alertTargetList.do")
	public String alertTargetList() throws Exception {
		return "alert/alertTargetList"; //return String
	}
	
	/**
	 * 전파대상 목록을 가져온다.
	 * 
	 * @param factCode
	 * @param branchNo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/getAlertTargetList.do")
    public ModelAndView getAlertTargetList(
    		@RequestParam(value="factCode", required=false) String factCode
    		,@RequestParam(value="branchNo", required=false) String branchNo
    		) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	

        AlertTargetVO vo = new AlertTargetVO();
        vo.setFactCode(factCode);
        vo.setBranchNo(Integer.parseInt(branchNo));

        List<AlertTargetVO> alertTargetList =  alertTargetService.getAlertTargetList(vo);

        modelAndView.addObject("alertTargetList", alertTargetList);
        modelAndView.setViewName("jsonView");

        return modelAndView;
    }
	
	/**
	 * 해당 전파대상을 가져온다.
	 * 
	 * @param atId
	 * @param factCode
	 * @param branchNo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/getAlertTarget.do")
	public ModelAndView getAlertTarget(
			@RequestParam(value="atId", required=false) String atId,
			@RequestParam(value="factCode", required=false) String factCode,
			@RequestParam(value="branchNo", required=false) String branchNo
	) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	
		
		AlertTargetVO vo = new AlertTargetVO();
		
		if(atId != null && !atId.equals("")) {
			vo.setAtId(atId);			
			vo =  alertTargetService.getAlertTarget(vo);
		} else {
			vo.setFactCode(factCode);
			vo.setBranchNo(Integer.parseInt(branchNo));
		}
		
		// 코드테이블에서 조직 코드를 가져온다 ( CODE : 32 )
		List<Map<String,String>> codes = (List<Map<String,String>>)tmsComUtlService.getCode("32");
		modelAndView.addObject("codes", codes);		
								
		modelAndView.addObject("alertTargetVO", vo);
        
        modelAndView.setViewName("/alert/alertTargetWrite");

        return modelAndView;
	}	
	
	/**
	 * 전파대상을 추가하거나 갱신한다.
	 * 
	 * @param req
	 * @param res
	 * @param alertTargetVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/saveAlertTargetData.do")
	public ModelAndView saveAlertTargetData(
			@RequestParam(value="atId", required=false) String[] atId		
			,@RequestParam(value="atArs", required=false) String[] atArs
			,@RequestParam(value="atSms", required=false) String[] atSms
			,@RequestParam(value="atDay", required=false) String[] atDay
			,@RequestParam(value="atNight", required=false) String[] atNight
			,@RequestParam(value="atRece", required=false) String[] atRece
			,@RequestParam(value="atClass", required=false) String[] atClass			
			,@RequestParam(value="atDepth", required=false) String[] atDepth			
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();		
		AlertTargetVO vo = new AlertTargetVO();
		
		for(int i=0; i<atId.length; i++) {
			
			if(atId[i] == null || atId[i].equals("")) {
				atId[i] = ""+alertTargetService.getAlertTargetPk();	    	
			}

			if(null != atId)vo.setAtId(atId[i]);
			if(null != atArs)vo.setAtArs(atArs[i]);
			if(null != atSms)vo.setAtSms(atSms[i]);
			if(null != atDay)vo.setAtDay(atDay[i]);
			if(null != atNight)vo.setAtNight(atNight[i]);
			if(null != atRece)vo.setAtRece(atRece[i]);
			if(null != atClass)vo.setAtClass(atClass[i]);
			if(null != atDepth)vo.setAtDepth(atDepth[i]);
			
			alertTargetService.mergeAlertTarget(vo);
		}

        modelAndView.setViewName("jsonView");

        return modelAndView;
	}	

	/**
	 * 전파대상을 삭제한다.
	 * 
	 * @param atIds
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/deleteAlertTargetData.do")
	public ModelAndView deleteAlertTargetData(
			@RequestParam(value="atIds", required=false) String[] atIds
			) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();
		AlertTargetVO vo = new AlertTargetVO();		
		
		for(int i=0; i<atIds.length; i++) {
			vo = new AlertTargetVO();
			vo.setAtId(atIds[i]);
			alertTargetService.deleteAlertTarget(vo);
		}

        modelAndView.setViewName("jsonView");

        return modelAndView;
	}
	
	
	/**
	 * 사용자 목록을 불러온다.
	 * 
	 * @param factCode
	 * @param branchNo
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/alertTargetUser.do")
    public ModelAndView alertTargetUser(
    		@RequestParam(value="factCode", required=false) String factCode
    		,@RequestParam(value="branchNo", required=false) String branchNo
    		) throws Exception{
		
		ModelAndView modelAndView = new ModelAndView();	

        List<HashMap<String,String>> userList =  alertTargetService.getAlertTargetUser();

        modelAndView.addObject("factCode", factCode);       
        modelAndView.addObject("branchNo", branchNo);       
        modelAndView.addObject("userList", userList);       
        modelAndView.setViewName("/alert/alertTargetUser");
        
		return modelAndView;
	}		
	
	/**
	 * 전파대상에 사용자를 추가한다.
	 * 
	 * @param req
	 * @param res
	 * @param alertTargetVO
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/alert/saveAlertTargetUser.do")
	public ModelAndView saveAlertTargetUser(
    		HttpServletRequest req,
    		HttpServletResponse res,
    		@RequestParam(value="factCode", required=false) String factCode,
    		@RequestParam(value="branchNo", required=false) String branchNo,    		
    		@RequestParam(value="chk", required=false) String[] uesrIds    		
			) throws Exception{
		

		AlertTargetVO alertTargetVO = new AlertTargetVO();
		
		alertTargetVO.setFactCode(factCode);
		alertTargetVO.setBranchNo(Integer.parseInt(branchNo));
		
		for(String id : uesrIds) {
			alertTargetVO.setAtMemberId(id);
			if(alertTargetService.getAlertTargetUserCheck(alertTargetVO) == 0) {				
				int idx = alertTargetService.getAlertTargetPk();		
				alertTargetVO.setAtId(""+idx);
				alertTargetService.mergeAlertTarget(alertTargetVO);    				
			}
		}
    

        //return new ModelAndView("redirect:/alert/alertMngView.do?mngId="+alertMngVO.getMngId());
		res.setContentType("text/html; charset=UTF-8");
		res.getWriter().print("<script>alert('사용자가 추가되었습니다.');opener.getAlertTargetList();self.close();</script>");

		return null;				
	}		
}
