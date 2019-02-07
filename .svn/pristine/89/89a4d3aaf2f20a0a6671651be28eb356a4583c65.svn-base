package daewooInfo.mobile.water.web;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.mobile.com.service.MobileCommonCodeService;
import daewooInfo.waterpolmnt.situationctl.service.SituationctlService;
import daewooInfo.waterpolmnt.waterinfo.bean.CmnSearchVO;
import daewooInfo.waterpolmnt.waterinfo.bean.EcompanyDataVO;
import daewooInfo.waterpolmnt.waterinfo.bean.RelateOfficeDataVO;
import daewooInfo.waterpolmnt.waterinfo.service.WaterinfoService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
* <pre>
* 1. 패키지명 : wpcs.sub01_water.web
* 2. 타입명 : WaterController.java
* 3. 작성일 : 2014. 8. 21. 오후 1:22:49
* 4. 작성자 : kys
* 5. 설명 : 수질 오염 조회
* </pre>
*/
@Controller
public class MobileWaterInfoController {

	/**
	 * 공통 코드 서비스
	 */
    @Resource(name="MobileCommonCodeService")
    private MobileCommonCodeService mobileCommonCodeService;

	@Resource(name = "waterinfoService")
	private WaterinfoService waterinfoService;
	/**
	* <pre>
	* 1. 메소드명 : LoginView
	* 2. 작성일 : 2014. 8. 21. 오후 1:22:39
	* 3. 작성자 : kys
	* 4. 설명 : 수질현황 조회
	* </pre>
	*/
	@RequestMapping(value="/mobile/sub/waterinfo/office/officesearch")
	public String officesearch(ModelMap model) throws Exception {
		return "mobile/sub/waterinfo/office/officesearch";
	}	
	

	/**
	* <pre>
	* 1. 메소드명 : LoginView
	* 2. 작성일 : 2014. 8. 21. 오후 1:22:39
	* 3. 작성자 : kys
	* 4. 설명 : 수질현황 조회
	* </pre>
	*/
	@RequestMapping(value="/mobile/sub/waterinfo/office/officelist")
	public String officelist(CmnSearchVO cmnSearchVO , ModelMap model) throws Exception {
		
		/** paging */
		cmnSearchVO.setFirstIndex(0);
		cmnSearchVO.setRecordCountPerPage(100000);
		
		List<RelateOfficeDataVO> list =  waterinfoService.getRelOffList(cmnSearchVO);
		
		model.addAttribute("List", list);
		model.addAttribute("SidoName", mobileCommonCodeService.getSidoName(cmnSearchVO.getsDoCode()));
		model.addAttribute("SigunguName", mobileCommonCodeService.getSigunguName(cmnSearchVO.getsCtyCode()));
		
		model.addAttribute("param_s", cmnSearchVO);
		return "mobile/sub/waterinfo/office/officelist";
	}	
	
	@RequestMapping(value="/mobile/sub/waterinfo/office/officeview")
	public String officeview(CmnSearchVO cmnSearchVO , ModelMap model) throws Exception {

		List<RelateOfficeDataVO> list =  waterinfoService.getRelOffDetailList(cmnSearchVO);
		if(list == null || list.size() < 1){
			model.addAttribute("View", new RelateOfficeDataVO());
		}else{
			model.addAttribute("View", list.get(0));
		}
		model.addAttribute("param_s", cmnSearchVO);
		return "mobile/sub/waterinfo/office/officeview";
	}	
	

	/**
	 * 방제업체관리 검색
	 */
	@RequestMapping("/mobile/sub/waterinfo/ecompany/ecompanysearch")
	public String ecompanysearch(CmnSearchVO cmnSearchVO , ModelMap model) throws Exception{
	 
		model.addAttribute("param_s", cmnSearchVO);
		return "mobile/sub/waterinfo/ecompany/ecompanysearch";
	}

	/**
	 * 방제업체관리 목록
	 */
	@RequestMapping("/mobile/sub/waterinfo/ecompany/ecompanylist")
	public String ecompanyList(CmnSearchVO cmnSearchVO , ModelMap model) throws Exception{

		cmnSearchVO.setFirstIndex(0);
		cmnSearchVO.setRecordCountPerPage(100000);
		
		List<EcompanyDataVO> list =  waterinfoService.getEcompanyList(cmnSearchVO);

		model.addAttribute("List", list);
		model.addAttribute("sugyeName", mobileCommonCodeService.getCodeName("01", cmnSearchVO.getSugye()));
		model.addAttribute("param_s", cmnSearchVO);
		return "mobile/sub/waterinfo/ecompany/ecompanylist";
	}

	/**
	 * 단일방제업체 상세조회
	 */
	@RequestMapping("/mobile/sub/waterinfo/ecompany/ecompanyview")
	public String ecompanyview(CmnSearchVO cmnSearchVO , ModelMap model) throws Exception{
		EcompanyDataVO View = (EcompanyDataVO)waterinfoService.getEcompanyDetailList(cmnSearchVO).get(0);

		model.addAttribute("View", View);
		model.addAttribute("param_s", cmnSearchVO);

		return "mobile/sub/waterinfo/ecompany/ecompanyview";
	}
	

	/**
	 * 단일방제업체 맵
	 */
	@RequestMapping("/mobile/sub/waterinfo/ecompany/ecompanymap")
	public String ecompanymap(CmnSearchVO cmnSearchVO , ModelMap model) throws Exception{
		EcompanyDataVO View = (EcompanyDataVO)waterinfoService.getEcompanyDetailList(cmnSearchVO).get(0);

		model.addAttribute("View", View);
		model.addAttribute("param_s", cmnSearchVO);

		return "mobile/sub/waterinfo/ecompany/ecompanymap";
	}
}