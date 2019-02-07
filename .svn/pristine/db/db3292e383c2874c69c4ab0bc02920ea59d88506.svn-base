package daewooInfo.mobile.water.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import daewooInfo.mobile.com.service.MobileCommonCodeService;
import daewooInfo.waterpolmnt.situationctl.bean.WatersysMntMainDetailSearchTSVO;
import daewooInfo.waterpolmnt.situationctl.bean.WatersysMntMainDetailTSVO;
import daewooInfo.waterpolmnt.situationctl.service.SituationctlService;

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
public class WaterController {

	/**
	 * 공통 코드 서비스
	 */
    @Resource(name="MobileCommonCodeService")
    private MobileCommonCodeService mobileCommonCodeService;


	/**
	 * water쪽 데이터 서비스
	 */
	@Resource(name = "situationctlService")
	private SituationctlService situationctlService;
    
	/**
	* <pre>
	* 1. 메소드명 : SelectWater
	* 2. 작성일 : 2014. 9. 12. 오후 5:30:21
	* 3. 작성자 : kys
	* 4. 설명 : 수질현황 검색화면
	* </pre>
	*/
	@RequestMapping(value="/mobile/sub/water/watersearch")
	public String SelectWater(ModelMap model) throws Exception {
		return "mobile/sub/water/watersearch";
	}	

	/**
	* <pre>
	* 1. 메소드명 : SelectWaterList
	* 2. 작성일 : 2014. 9. 12. 오후 5:30:40
	* 3. 작성자 : kys
	* 4. 설명 : 수질현황 검색결과화면
	* </pre>
	*/
	@RequestMapping(value="/mobile/sub/water/waterview")
	public String SelectWaterList(WatersysMntMainDetailSearchTSVO watersysMntMainDetailSearchTSVO, ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {

		//조회조건 
		String conditionText = mobileCommonCodeService.getCodeName(watersysMntMainDetailSearchTSVO.getSugye())+" / "+mobileCommonCodeService.getBranchName(watersysMntMainDetailSearchTSVO.getBranch());
		conditionText += " / " + mobileCommonCodeService.getSyskindname(watersysMntMainDetailSearchTSVO.getSys());
		
		if("1".equals(watersysMntMainDetailSearchTSVO.getTime_type())) conditionText += " / 분자료";
		else if("2".equals(watersysMntMainDetailSearchTSVO.getTime_type())) conditionText += " / 시간자료";
		
//		if("A".equals(watersysMntMainDetailSearchTSVO.getSys())) 
//			watersysMntMainDetailSearchTSVO.setAuto(mobileCommonCodeService.getAutoCodeDiv(watersysMntMainDetailSearchTSVO.getItem_code()));
		
		if(null != watersysMntMainDetailSearchTSVO.getAuto()) 
			conditionText += "<br>대분류:"+mobileCommonCodeService.getCodeName(watersysMntMainDetailSearchTSVO.getAuto())+"";

		// 시,분 조회 테이블명
		if(watersysMntMainDetailSearchTSVO.getTime_type().equals("1")) watersysMntMainDetailSearchTSVO.setTime_type("MIN");
		else watersysMntMainDetailSearchTSVO.setTime_type("HOUR");
		
		//측정소 및 지점코드 분리
		String[] buffer = watersysMntMainDetailSearchTSVO.getBranch().split(":");
		watersysMntMainDetailSearchTSVO.setFact_code(buffer[0]);
		watersysMntMainDetailSearchTSVO.setBranch_no(buffer[1]);

		List<WatersysMntMainDetailTSVO> list = situationctlService.getWaterMobilesysMntMainDetail(watersysMntMainDetailSearchTSVO);
		
		model.addAttribute("List",list);
		model.addAttribute("condition",conditionText);
		model.addAttribute("param_s",watersysMntMainDetailSearchTSVO);
		return "mobile/sub/water/waterview";
	}	
}