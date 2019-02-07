package daewooInfo.status.web;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import daewooInfo.ipusn.bean.IpUsnVO;
import daewooInfo.status.bean.StatusVO;
import daewooInfo.status.service.StatusService;
import daewooInfo.waterpolmnt.waterinfo.web.WaterinfoController;

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
public class StatusController {
	/**
	 * @uml.property  name="logger"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log logger = LogFactory.getLog(WaterinfoController.class);
	
	/**
	 * 공통 코드 서비스
	 */
    @Resource(name="StatusService")
    private StatusService statusService;

    /**
	* <pre>
	* 1. 메소드명 : selectmrdipusnlist
	* 2. 작성일 : 2014. 9. 12. 오후 2:53:38
	* 3. 작성자 : kys
	* 4. 설명 : 웹 페이지 IP-USN 모니터링
	* </pre>
	*/
	@RequestMapping(value="/status/statusView")
	public String selectmrdipusnlist(IpUsnVO ipUsnVO, ModelMap model) throws Exception {
		model.addAttribute("Water",statusService.Water());
		model.addAttribute("Nier",statusService.Nier());
		model.addAttribute("Weather",statusService.Weather());
		StatusVO TMS = new StatusVO();

		//DB링크를 이용하여 데이터를 조회하나 커넥션 문제가 생길 우려가 있어 try catch 문으로 처리
		try{
			TMS = statusService.TMS();
		}catch (Exception e) {
		}
		model.addAttribute("TMS",TMS);
		return "/status/statusView"; 
	}
}