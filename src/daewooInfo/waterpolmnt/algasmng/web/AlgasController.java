package daewooInfo.waterpolmnt.algasmng.web;

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
import daewooInfo.waterpolmnt.algasmng.bean.AlgaDataVO;
import daewooInfo.waterpolmnt.algasmng.bean.AlgaPointMntVO;
import daewooInfo.waterpolmnt.algasmng.bean.AlgaPointVO;
import daewooInfo.waterpolmnt.algasmng.service.AlgasService;

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
public class AlgasController {

	/**
	 * @uml.property  name="logger"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log logger = LogFactory.getLog(AlgasController.class);
	
    /**
	 * @uml.property  name="algasService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "algasService")
    private AlgasService algasService;
    
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
    
    @RequestMapping("/waterpolmnt/algasmng/goAlgainfo.do")
    public ModelAndView goAlgainfo() throws Exception{
    	
    	ModelAndView modelAndView = new ModelAndView();
    	
    	//로긴 한 유저의 그룹
    	LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();

    	MemberVO searchData = new MemberVO();
    	searchData.setMemberId(user.getId());
    	
    	MemberVO member = memberService.selectMemberDetail(searchData);
    	
    	String groupName = member.getGroupName();
    	
    	//항공감시 그룹의 이름을 공통코드에서 가져옴
    	ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("38");
		List codeResult = cmmUseService.selectCmmCodeDetail(vo);
		
		boolean isAlgaGroup = false;
		
		if(codeResult != null && groupName != null)
		{
			CmmnDetailCode c = (CmmnDetailCode)codeResult.get(0);
			if(c.getCodeDesc().trim().equals(groupName))
			{
				isAlgaGroup = true;
			}
		}
    	
    	modelAndView.addObject("isAlgaGroup", isAlgaGroup);
    	
    	modelAndView.setViewName("waterpolmnt/algasmng/algainfo");
    	
    	return modelAndView;
    }
    
    @SuppressWarnings("unchecked")
    @RequestMapping("/waterpolmnt/algasmng/insertAlgas.do")
    public String insertAlgas(
    		final MultipartHttpServletRequest multiRequest, 
    		@ModelAttribute("AlgaDataVO") AlgaDataVO algaDataVO,
    		BindingResult bindingResult, 
    		SessionStatus status,
    		ModelMap model) throws Exception{
    	
    	String resultParam = "";
    	
    	try
    	{
    		algasService.insertAlgaCast(algaDataVO);
    		resultParam = "algareg=true";
    	}
    	catch(Exception e)
    	{
    		logger.debug(e.getStackTrace());
    		resultParam = "algareg=false";
    	}
    	
    	return "forward:/waterpolmnt/algasmng/goAlgainfo.do?" + resultParam;
    }

    /**
     * 지점 관리자 관리
     * @return
     * @throws Exception
     */
    @RequestMapping("/waterpolmnt/algasmng/goAlgaPointMnt.do")
    public ModelAndView goAlgaPointMnt() throws Exception{
    	
    	List<AlgaPointMntVO> algaPointMntVO = algasService.getAlgaPointMnt();
    	List<AlgaPointVO> algaPoint = algasService.getAlgaPoint(new AlgaPointVO());
    	
    	ModelAndView modelAndView = new ModelAndView();
    	
    	modelAndView.addObject("algaPointMnt", algaPointMntVO);
    	modelAndView.addObject("algaPoint", algaPoint);
    	
    	modelAndView.setViewName("waterpolmnt/algasmng/alga_point_mnt");

    	return modelAndView;
    }
    
    
    /**
     * 지점 리스트
     * @return
     * @throws Exception
     */
    @RequestMapping("/waterpolmnt/algasmng/getAlgaPoint.do")
    public ModelAndView getAlgaPoint(
    		@RequestParam(value="value", required=false) String value
   ) throws Exception{
    	
    	AlgaPointVO param = new AlgaPointVO();
    	param.setValue(value);
    	
    	List<AlgaPointVO> algaPointVO = algasService.getAlgaPoint(param);
    	
    	ModelAndView modelAndView = new ModelAndView();
    	
    	modelAndView.addObject("algasPoint", algaPointVO);
    	modelAndView.setViewName("jsonView");
    	
    	return modelAndView;
    }
    
    @RequestMapping("/waterpolmnt/algasmng/insertPointMap.do")
    public ModelAndView insertPointMap(
    		@RequestParam(value="uniq_id", required=false) String uniq_id,
    		@RequestParam(value="point_id", required=false) String point_id
	) throws Exception{
    	
    	AlgaPointMntVO algaPointMntVO = new AlgaPointMntVO();
    	
    	algaPointMntVO.setUniq_id(uniq_id);
    	algaPointMntVO.setPoint_id(point_id);
    	
    	algasService.insertPointMap(algaPointMntVO);
    	
    	ModelAndView modelAndView = new ModelAndView();
    	
    	modelAndView.addObject("success", "OK");
    	modelAndView.setViewName("jsonView");
    	
    	return modelAndView;
    }
    
}
