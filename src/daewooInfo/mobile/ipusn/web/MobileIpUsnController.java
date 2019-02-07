package daewooInfo.mobile.ipusn.web;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import daewooInfo.ipusn.bean.IpUsnVO;
import daewooInfo.ipusn.service.IpUsnService;
import daewooInfo.mobile.com.service.MobileCommonCodeService;
import daewooInfo.mobile.com.utl.LogInfoUtil;

/**
* <pre>
* 1. 패키지명 : daewooInfo.mobile.ipusn.web
* 2. 타입명 : IpUsnController.java
* 3. 작성일 : 2014. 9. 4. 오후 4:21:22
* 4. 작성자 : kys
* 5. 설명 : IPUSN 정보
* </pre>
*/
@Controller
public class MobileIpUsnController {
	
	/**
	 * 공통 코드 서비스
	 */
    @Resource(name="MobileCommonCodeService")
    private MobileCommonCodeService mobileCommonCodeService;
    
    /**
	 * IPUSN 서비스
	 */
    @Resource(name="IpUsnService")
    private IpUsnService ipUsnService;
    
	/**
	* <pre>
	* 1. 메소드명 : selectIpusn
	* 2. 작성일 : 2014. 9. 4. 오후 4:19:59
	* 3. 작성자 : kys
	* 4. 설명 : IPUSN 조회
	* </pre>
	*/
	@RequestMapping(value="/mobile/sub/ipusn/ipusn/ipusnlist")
	public String selectIpusn(IpUsnVO ipUsnVO, ModelMap model, HttpServletRequest request) throws Exception {
		ipUsnVO.setFirstIndex(0);
		ipUsnVO.setLastIndex(10000);
		
		ipUsnVO.setUserId(LogInfoUtil.GetSessionLogin().getId());
		ipUsnVO.setUserGubun(LogInfoUtil.GetSessionLogin().getRoleCode());
		
		List<IpUsnVO> list = ipUsnService.getIpUsnList(ipUsnVO);
		
		//위치 이탈시 플래그 Y로 변경
		for(IpUsnVO listvo : list){
		    int gps_dist = Integer.parseInt(listvo.getGps_dist());
			double Lat1 = Double.parseDouble(listvo.getLatitude1());
			double Long1 = Double.parseDouble(listvo.getLongitude1());
			double Lat2 = Double.parseDouble(listvo.getLatitude2());
			double Long2 = Double.parseDouble(listvo.getLongitude2());
			 
	        double dDistance = Double.MIN_VALUE;
	        double dLat1InRad = Lat1 * (Math.PI / 180.0);
	        double dLong1InRad = Long1 * (Math.PI / 180.0);
	        double dLat2InRad = Lat2 * (Math.PI / 180.0);
	        double dLong2InRad = Long2 * (Math.PI / 180.0);
	
	        double dLongitude = dLong2InRad - dLong1InRad;
	        double dLatitude = dLat2InRad - dLat1InRad;
	
	        // Intermediate result a.
	        double a = Math.pow(Math.sin(dLatitude / 2.0), 2.0) + 
	            Math.cos(dLat1InRad) * Math.cos(dLat2InRad) * 
	            Math.pow(Math.sin(dLongitude / 2.0), 2.0);
	
	        double c = 2.0 * Math.atan2(Math.sqrt(a), Math.sqrt(1.0 - a));
	
	        Double kEarthRadiusKms = 6376.5;
	        dDistance = kEarthRadiusKms * c;
	        
        	dDistance = dDistance*1000;
	        	
			if(dDistance > gps_dist) {
				if(!"0".equals(listvo.getLatitude2())) {
					if("N".equals(listvo.getStatus_flag())) {
						IpUsnVO UpipUsnVO = new IpUsnVO();
						UpipUsnVO.setFact_code(listvo.getFact_code());
						UpipUsnVO.setBranch_no(listvo.getBranch_no());
						UpipUsnVO.setInput_time(listvo.getInput_time());
						ipUsnService.UpdateIpUsnStatusFlag(UpipUsnVO);
					}
				}
			}
		}
		
		model.addAttribute("List", list);
		model.addAttribute("param_s", ipUsnVO);
		return "mobile/sub/ipusn/ipusn/ipusnlist";
	}
	

	/**
	* <pre>
	* 1. 메소드명 : selectipusn2
	* 2. 작성일 : 2014. 9. 12. 오후 5:42:35
	* 3. 작성자 : kys
	* 4. 설명 : 상세보기
	* </pre>
	*/
	@RequestMapping(value="/mobile/sub/ipusn/ipusn/ipusnmap")
	public String selectipusn2(IpUsnVO ipUsnVO, ModelMap model) throws Exception {
		model.addAttribute("View", ipUsnService.getIpUsnMap(ipUsnVO));
		model.addAttribute("param_s", ipUsnVO);
		return "mobile/sub/ipusn/ipusn/ipusnmap"; 
	}
	

	/**
	* <pre>
	* 1. 메소드명 : selectipusn2
	* 2. 작성일 : 2014. 9. 12. 오후 5:42:35
	* 3. 작성자 : kys
	* 4. 설명 : 상세보기
	* </pre>
	*/
	@RequestMapping(value="/mobile/sub/ipusn/ipusn/ipusnview")
	public String selectipusnview(IpUsnVO ipUsnVO, ModelMap model) throws Exception {
		model.addAttribute("View", ipUsnService.getIpUsnView(ipUsnVO));
		model.addAttribute("param_s", ipUsnVO);
		return "mobile/sub/ipusn/ipusn/ipusnview"; 
	}

	/**
	* <pre>
	* 1. 메소드명 : UpdateIpUsnDeviceStatus
	* 2. 작성일 : 2014. 9. 12. 오후 5:42:41
	* 3. 작성자 : kys
	* 4. 설명 : 측정소정보 디바이스 정보 수정
	* </pre>
	*/
	@RequestMapping(value="/mobile/sub/ipusn/ipusn/UpdateIpUsnDeviceStatus")
	public String UpdateIpUsnDeviceStatus(IpUsnVO ipUsnVO, ModelMap model) throws Exception {
		
		int returnvalue = ipUsnService.UpdateIpUsnDeviceStatus(ipUsnVO);
		if(returnvalue > 0){
			String param = "success.common.update";
			param += "&return_url=/mobile/sub/ipusn/ipusn/ipusnlist.do";
			return "redirect:/mobile/alert.do?message="+param;
		}else{
			String param = "fail.common.update";
			param += "&return_url=/mobile/sub/ipusn/ipusn/ipusnlist.do";
			return "redirect:/mobile/alert.do?message="+param;
		} 
	}
	
	/**
	* <pre>
	* 1. 메소드명 : UpdateIpUsnLocationSet
	* 2. 작성일 : 2014. 9. 12. 오후 5:42:41
	* 3. 작성자 : kys
	* 4. 설명 : 측정소정보 플래그 수정
	* </pre>
	*/
	@RequestMapping(value="/mobile/sub/ipusn/ipusn/UpdateIpUsnLocationSet")
	public String UpdateIpUsnLocationSet(IpUsnVO ipUsnVO, ModelMap model) throws Exception {
		
		int returnvalue = ipUsnService.UpdateIpUsnLocationSet(ipUsnVO);
		if(returnvalue > 0){
			String param = "success.common.update";
			param += "&return_url=/mobile/sub/ipusn/ipusn/ipusnlist.do";
			return "redirect:/mobile/alert.do?message="+param;
		}else{
			String param = "fail.common.update";
			param += "&return_url=/mobile/sub/ipusn/ipusn/ipusnlist.do";
			return "redirect:/mobile/alert.do?message="+param;
		} 
	}
	

	/**
	* <pre>
	* 1. 메소드명 : selectipusnsearch
	* 2. 작성일 : 2014. 9. 12. 오후 5:43:05
	* 3. 작성자 : kys
	* 4. 설명 : 측정소위치 검색화면
	* </pre>
	*/
	@RequestMapping(value="/mobile/sub/ipusn/location/ipusnsearch")
	public String selectipusnsearch(IpUsnVO ipUsnVO, ModelMap model) throws Exception {
		model.addAttribute("param_s", ipUsnVO);
		return "mobile/sub/ipusn/location/ipusnsearch"; 
	}
	

	/**
	* <pre>
	* 1. 메소드명 : selectipusnlist
	* 2. 작성일 : 2014. 9. 12. 오후 5:43:18
	* 3. 작성자 : kys
	* 4. 설명 : 전체 측정소 검색 결과화면
	* </pre>
	*/
	@RequestMapping(value="/mobile/sub/ipusn/location/ipusnlist")
	public String selectipusnlist(IpUsnVO ipUsnVO, ModelMap model, HttpServletRequest request) throws Exception {
		
		String conditionText = mobileCommonCodeService.getCodeName("01", ipUsnVO.getRiver_div());
		conditionText += " / " + mobileCommonCodeService.getSyskindname(ipUsnVO.getSys()); 
		
		ipUsnVO.setId(LogInfoUtil.GetSessionLogin().getId());
		ipUsnVO.setRoleCode(LogInfoUtil.GetSessionLogin().getRoleCode());
		
		model.addAttribute("conditionText", conditionText);
		model.addAttribute("List", ipUsnService.getIpUsnLocationList(ipUsnVO));
		model.addAttribute("param_s", ipUsnVO);
		return "mobile/sub/ipusn/location/ipusnlist"; 
	}
	
	/**
	* <pre>
	* 1. 메소드명 : selectipusnview
	* 2. 작성일 : 2014. 9. 12. 오후 5:43:26
	* 3. 작성자 : kys
	* 4. 설명 : 전체 측정소 상세보기
	* </pre>
	*/
	@RequestMapping(value="/mobile/sub/ipusn/location/ipusnview")
	public String selectlocationipusnview(IpUsnVO ipUsnVO, ModelMap model) throws Exception {
		model.addAttribute("View", ipUsnService.getIpUsnLocationView(ipUsnVO));
		model.addAttribute("param_s", ipUsnVO);
		return "mobile/sub/ipusn/location/ipusnview"; 
	}
	
	/**
	* <pre>
	* 1. 메소드명 : selectipusnmap
	* 2. 작성일 : 2014. 9. 12. 오후 5:43:31
	* 3. 작성자 : kys
	* 4. 설명 : 측정소 지도 보기
	* </pre>
	*/
	@RequestMapping(value="/mobile/sub/ipusn/location/ipusnmap")
	public String selectipusnmap(IpUsnVO ipUsnVO, ModelMap model) throws Exception {
		model.addAttribute("View", ipUsnService.getIpUsnLocationView(ipUsnVO));
		model.addAttribute("param_s", ipUsnVO);
		return "mobile/sub/ipusn/location/ipusnmap"; 
	}
}