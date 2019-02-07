package daewooInfo.waterpolmnt.airmntmng.web;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.admin.member.service.MemberService;
import daewooInfo.cmmn.bean.CmmnDetailCode;
import daewooInfo.cmmn.bean.ComDefaultCodeVO;
import daewooInfo.cmmn.service.EgovCmmUseService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.login.bean.MemberVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.waterpolmnt.airmntmng.bean.AirDataVO;
import daewooInfo.waterpolmnt.airmntmng.bean.AirPointMntVO;
import daewooInfo.waterpolmnt.airmntmng.bean.AirPointVO;
import daewooInfo.waterpolmnt.airmntmng.service.AirService;

/**
 * @author DaeWoo Information Systems Co., Ltd. Technical Expert Team.
 *         loafzzang.
 * @version 1.0
 * @Class Name : AlgasController.java
 * @Description : Alga Controller Class
 * @Modification Information @ @ Modify Date author Modify Contents @
 *               -------------- ------------ ------------------------------- @
 *               2010. 1. 21 loafzzang new
 * @see Copyright (C) by DaeWoo Information Systems Co., Ltd. All right
 *      reserved.
 * @since 2010. 1. 21
 */

@Controller
public class AirmntController {

	/**
	 * @uml.property  name="logger"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log logger = LogFactory.getLog(AirmntController.class);
	
    /**
	 * @uml.property  name="airService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "airService")
    private AirService airService;
    
    /**
	 * MemberService
	 * @uml.property  name="memberService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "memberService")
    private MemberService memberService;
	
	/**
	 * @uml.property  name="cmmUseService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "EgovCmmUseService")
    private EgovCmmUseService cmmUseService;
    
    @RequestMapping("/waterpolmnt/airmntmng/goAirinfo.do")
    public ModelAndView goAirinfo() throws Exception{
    	
    	ModelAndView modelAndView = new ModelAndView();
    	

    	//로긴 한 유저의 그룹
    	LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

    	MemberVO searchData = new MemberVO();
    	searchData.setMemberId(user.getId());
    	
    	MemberVO member = memberService.selectMemberDetail(searchData);
    	
    	String groupName = member.getGroupName();
    	
    	//항공감시 그룹의 이름을 공통코드에서 가져옴
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("39");
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);
		
		boolean isAirGroup = false;
		
		if(codeResult != null && groupName != null)
		{
			CmmnDetailCode c = (CmmnDetailCode)codeResult.get(0);
			if(c.getCodeDesc().trim().equals(groupName))
			{
				isAirGroup = true;
			}
		}
    	
    	modelAndView.addObject("isAirGroup", isAirGroup);
    	
    	modelAndView.setViewName("waterpolmnt/airmntmng/airinfo");
    	
    	return modelAndView;
    }
    
    
    @SuppressWarnings("unchecked")
    @RequestMapping("/waterpolmnt/airmntmng/insertAirMnt.do")
    public String insertAirMnt(
    		final MultipartHttpServletRequest multiRequest, 
    		@ModelAttribute("AirDataVO") AirDataVO airDataVO,
    		BindingResult bindingResult, 
    		SessionStatus status,
    		ModelMap model) throws Exception{
    	
    	String resultParam = "";

    	try
    	{
    		airService.insertAirMnt(airDataVO);
    		resultParam = "airmntreg=true";
    	}
    	catch(Exception e)
    	{
    		logger.debug(e.getStackTrace());
    		resultParam = "airmntreg=false";
    	}
    	
    	return "forward:/waterpolmnt/airmntmng/goAirinfo.do?" + resultParam;
    }
    
    
    
    /**
     * 지점 관리자 관리
     * @return
     * @throws Exception
     */
    @RequestMapping("/waterpolmnt/airmntmng/goAirPointMnt.do")
    public ModelAndView goAirPointMnt() throws Exception{
    	
    	List<AirPointMntVO> AirPointMntVO = airService.getAirPointMnt();
    	List<AirPointVO> AirPoint = airService.getAirPoint(new AirPointVO());
    	
    	
    	ModelAndView modelAndView = new ModelAndView();
    	
    
    	modelAndView.addObject("airPointMnt", AirPointMntVO);
    	modelAndView.addObject("airPoint", AirPoint);
    	
    	modelAndView.setViewName("waterpolmnt/airmntmng/air_point_mnt");

    	return modelAndView;
    }
    
    
    /**
     * 지점 리스트
     * @return
     * @throws Exception
     */
    @RequestMapping("/waterpolmnt/airmntmng/getAirPoint.do")
    public ModelAndView getAirPoint(
    		@RequestParam(value="value", required=false) String value
   ) throws Exception{
    	
    	AirPointVO param = new AirPointVO();
    	param.setValue(value);
    	
    	List<AirPointVO> airPointVO = airService.getAirPoint(param);
    	
    	ModelAndView modelAndView = new ModelAndView();
    	
    	modelAndView.addObject("airPoint", airPointVO);
    	modelAndView.setViewName("jsonView");
    	
    	return modelAndView;
    }
    
    @RequestMapping("/waterpolmnt/airmntmng/insertPointMap.do")
    public ModelAndView insertPointMap(
    		@RequestParam(value="uniq_id", required=false) String uniq_id,
    		@RequestParam(value="point_id", required=false) String point_id
	) throws Exception{
    	
    	AirPointMntVO airPointMntVO = new AirPointMntVO();
    	
    	airPointMntVO.setUniq_id(uniq_id);
    	airPointMntVO.setPoint_id(point_id);
    	
    	airService.insertPointMap(airPointMntVO);
    	
    	ModelAndView modelAndView = new ModelAndView();
    	
    	modelAndView.addObject("success", "OK");
    	modelAndView.setViewName("jsonView");
    	
    	return modelAndView;
    }
}
