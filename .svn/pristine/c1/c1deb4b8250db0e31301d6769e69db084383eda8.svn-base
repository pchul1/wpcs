package daewooInfo.stats.web;


import java.util.HashMap;
import java.util.List;
import java.util.Calendar;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.admin.member.service.MemberService;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.login.bean.MemberVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;
import daewooInfo.common.util.fcc.StringUtil;
import daewooInfo.stats.bean.ThematicMapSearchVO;
import daewooInfo.stats.bean.ThematicMapVO;
import daewooInfo.stats.service.ThematicMapService;

/**
 * 주제도 위한 컨트롤러  클래스
 * @author kyr
 * @since 2014.10.14
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *	
 *	수정일	  수정자			수정내용
 *  -------		--------	---------------------------
 *	2014.10.14  kyr		  최초 생성
 *
 * </pre>
 */
@Controller
public class ThematicMapController {
	/**
	 * @uml.property  name="thematicMapService"
	 */
	@Resource(name = "thematicMapService")
    private ThematicMapService thematicMapService;
	
	/**
	 * @uml.property  name="logger"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log logger = LogFactory.getLog(ThematicMapController.class);
	
	/**
	 * MemberService
	 * @uml.property  name="memberService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name = "memberService")
	private MemberService memberService;

	/**
	 * 주제도 화면을 보여준다.
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/thematicMap.do")
	public ModelAndView thematicMap(
			@ModelAttribute("thematicMapSearchVO") ThematicMapSearchVO thematicMapSearchVO 
			) throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		
		MemberVO searchData = new MemberVO();
		searchData.setMemberId(user.getId());
		MemberVO member = memberService.selectMemberDetail(searchData);
		
		thematicMapSearchVO.setSearchMemberId(user.getId());
		
		if(StringUtil.isEmpty(thematicMapSearchVO.getSearchItem())){
			thematicMapSearchVO.setSearchItem("T");
		}
		
		Calendar now = Calendar.getInstance();
		
		String year = String.valueOf(now.get(Calendar.YEAR));
		
		if(StringUtil.isEmpty(thematicMapSearchVO.getSearchCompareYear())){
			thematicMapSearchVO.setSearchCompareYear(year);
		}
		
//		List bermList = thematicMapService.getBermSettingInfo(thematicMapSearchVO);
//		
//		modelAndView.addObject("getBermSettingInfo", bermList);
		modelAndView.addObject("member", member);
		modelAndView.addObject("searchVO", thematicMapSearchVO);
		modelAndView.setViewName("stats/thematicMap");
		
		return modelAndView;
	}  

	/**
	 * 사용자별 범례정보 가져오기
	 */
	@RequestMapping("/stats/getBermSettingInfo.do")
	public ModelAndView getBermSettingInfo(
			@RequestParam(value="item", required=false) String item
		)throws Exception {
		ModelAndView modelAndView = new ModelAndView();
		
		ThematicMapSearchVO searchVO = new ThematicMapSearchVO();
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		
		searchVO.setSearchMemberId(user.getId());
		searchVO.setSearchItem(item);
		
		List list = thematicMapService.getBermSettingInfo(searchVO);

		modelAndView.addObject("getBermSettingInfo", list);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 범례정보 저장
	 * 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/stats/saveBermSettingInfo.do")
	public ModelAndView saveBermSettingInfo(
			 @ModelAttribute("thematicMapVO") ThematicMapVO thematicMapVO
			,@ModelAttribute("thematicMapSearchVO") ThematicMapSearchVO thematicMapSearchVO 
			) throws Exception {
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		
		thematicMapVO.setMemberId(user.getId());
		
		
		thematicMapVO.setBerm1Set(thematicMapVO.getBerm1Set().trim());
		thematicMapVO.setBerm2Set(thematicMapVO.getBerm2Set().trim());
		thematicMapVO.setBerm3Set(thematicMapVO.getBerm3Set().trim());
		thematicMapVO.setBerm4Set(thematicMapVO.getBerm4Set().trim());
		thematicMapVO.setBerm5Set(thematicMapVO.getBerm5Set().trim());
		thematicMapVO.setBerm6Set(thematicMapVO.getBerm6Set().trim());
		
		thematicMapService.saveBermSettingInfo(thematicMapVO);
		
		ModelAndView modelAndView = new ModelAndView();
		
		modelAndView.addObject("searchVO", thematicMapSearchVO);
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
	
	
	/**
	 * 확정데이터 조회
	 * @param 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/stats/getThematicMapDetail.do")
	public ModelAndView getThematicMapDetail(
			@ModelAttribute("searchVO") ThematicMapSearchVO searchVO
	)
	throws Exception{
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		
		searchVO.setSearchMemberId(user.getId());
		searchVO.setRoleCode(user.getRoleCode());
		
		ModelAndView modelAndView = new ModelAndView();
		
		String factCode = thematicMapService.getFactCodeValue(searchVO.getSearchSugye());
		
		searchVO.setSearchFactCode(factCode);
		searchVO.setSearchNsDays(searchVO.getSearchDays().trim().replaceAll("/", "")+searchVO.getSearchTime()+"00");
		searchVO.setSearchNeDays(searchVO.getSearchDays().trim().replaceAll("/", "")+searchVO.getSearchTime()+"59");
		
		searchVO.setSearchCsDays(searchVO.getSearchCompareYear()+searchVO.getSearchNsDays().substring(4,8)+searchVO.getSearchTime()+"00");
		searchVO.setSearchCeDays(searchVO.getSearchCompareYear()+searchVO.getSearchNsDays().substring(4,8)+searchVO.getSearchTime()+"59");
		
		List<ThematicMapVO> refreshData =  thematicMapService.getThematicMapDetail(searchVO);
		
		List bermDataList =  thematicMapService.getBermDataList(searchVO);
		List bermSettingList = thematicMapService.getBermSettingInfo(searchVO);
		
		modelAndView.addObject("detailViewList", refreshData);
		modelAndView.addObject("bermDataList", bermDataList);
		modelAndView.addObject("bermSettingList", bermSettingList);
		modelAndView.setViewName("jsonView");
		return modelAndView;
	}
	
	/**
	 * 주제도 엑셀 다운로드
	 * 2014.10.30
	 * kyr
	 */
	@RequestMapping("/stats/thematicMapExcel.do")
	public ModelAndView selectsThematicMapExcel(
			@ModelAttribute("searchVO") ThematicMapSearchVO searchVO
	) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		ModelAndView mav = null;
		
		String factCode = thematicMapService.getFactCodeValue(searchVO.getSearchSugye());
		
		searchVO.setSearchFactCode(factCode);
		searchVO.setSearchNsDays(searchVO.getSearchDays().trim().replaceAll("/", "")+searchVO.getSearchTime()+"00");
		searchVO.setSearchNeDays(searchVO.getSearchDays().trim().replaceAll("/", "")+searchVO.getSearchTime()+"59");
		
		searchVO.setSearchCsDays(searchVO.getSearchCompareYear()+searchVO.getSearchNsDays().substring(4,8)+searchVO.getSearchTime()+"00");
		searchVO.setSearchCeDays(searchVO.getSearchCompareYear()+searchVO.getSearchNsDays().substring(4,8)+searchVO.getSearchTime()+"59");
		
		List<ThematicMapVO> refreshData =  thematicMapService.getThematicMapDetail(searchVO);
		
		LoginVO user = (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
		
		searchVO.setSearchMemberId(user.getId());
		
		List bermDataList =  thematicMapService.getBermDataList(searchVO);
		List bermSettingList = thematicMapService.getBermSettingInfo(searchVO);
		
		map.put("detailViewList", refreshData);
		map.put("bermDataList", bermDataList);
		map.put("bermSettingList", bermSettingList);
		
		map.put("searchVO", searchVO);
		
		mav = new ModelAndView("ExcelViewThematicMap", "map", map);
		return mav;
	}
			
}
