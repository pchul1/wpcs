package daewooInfo.common.alrim.web;

import java.util.List;
import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.common.alrim.bean.AlrimVO;
import daewooInfo.common.alrim.dao.AlrimDAO;
import daewooInfo.common.alrim.service.AlrimService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import egovframework.rte.fdl.idgnr.EgovIdGnrService;

/**
 * 알림 안내 Controller 클래스
 * @author 박미영
 * @since 2014.09.04
 * @version 1.0
 * @see
 */
@Controller
public class AlrimController {

	/**
	 * log
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log log = LogFactory.getLog(AlrimController.class);
	
	/**
	 * AlrimService
	 * @uml.property  name="alrimService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "alrimService")
	private AlrimService alrimService;
	
    /**
	 * @uml.property  name="alrimDAO"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name="alrimDAO")
    private AlrimDAO alrimDAO;	
	
	/**
	 * @uml.property  name="idgenService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "alrimIdGnrService")
    private EgovIdGnrService idgenService;
	
	/**
	 * 알림 전체 목록 조회
	 * @param alrimVO
	 * @return 알림 목록 조회
	 * @exception Exception
	 */
	@RequestMapping(value="/common/alrim/AlrimCheckList.do")
	public ModelAndView AlrimCheckList(@ModelAttribute("alrimVO") AlrimVO alrimVO) throws Exception {
		
		ModelAndView modelAndView = new ModelAndView();
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		alrimVO.setAlrimApprovalId(user.getId());
		
		List<AlrimVO> alrimList = alrimService.selectAlrimList (alrimVO);	
		int totCnt = alrimService.selectAlrimListTotCount(alrimVO);
		
		modelAndView.addObject("resultList", alrimList);
		modelAndView.addObject("totCnt", totCnt);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
    /**
     * 알림 미확인 카운트 조회
     * 
     */
    public Integer selectUnConfirmAlrimCount(AlrimVO alrimVO) throws Exception {
		String alrimId = idgenService.getNextStringId();
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		alrimVO.setAlrimApprovalId(user.getId());
		int totCnt = alrimService.selectUnConfirmAlrimCount(alrimVO);
		return totCnt;
    }
	
    /**
     * 알림 내용 삽입 처리
     * 
     */
    public String insertAlrim(AlrimVO alrimVO1) throws Exception {
    	LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
    	String alrimInsertCheck = "";
		for(int i=0; i < 20; i++) {
	    	String alrimId = idgenService.getNextStringId();
	    	AlrimVO alrimVO = new AlrimVO();
	    	alrimVO.setAlrimApprovalId(user.getId());
			alrimVO.setAlrimId(alrimId);
			//테스트용
			alrimVO.setAlrimGubun("사고접수" + i );
			alrimVO.setAlrimTitle("사고가 접수되었습니다." + i );
			alrimVO.setAlrimLink("/bbs/selectBoardList.do?bbsId=BBSMSTR_000000000050");
			alrimVO.setAlrimMenuId(51130);
			alrimVO.setAlrimWriterId(user.getId());
			alrimInsertCheck = alrimDAO.insertAlrim(alrimVO);
			//
		}
		return alrimInsertCheck;
    }    
    
	/**
	 * 미확인 처리
	 * @param 
	 * @return 알림 목록 불러오기
	 * @exception Exception
	 */
	@RequestMapping("/common/alrim/AlrimUnCofirmUpdate.do")
	public ModelAndView unCheckAlrim(String link, String alrimId , String menuId) throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		AlrimVO alrimVO = new AlrimVO();
		if(!"".equals(alrimId))
			alrimVO.setAlrimId(alrimId);
		if(!"".equals(link))
			alrimVO.setAlrimLink(link);
		if(!"".equals(menuId))
			alrimVO.setAlrimMenuId(Integer.parseInt(menuId));
		alrimVO.setAlrimApprovalId(user.getId());
		alrimDAO.updateAlrim(alrimVO);
		modelAndView.addObject("msg", "updateOk");
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
}