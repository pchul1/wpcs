package daewooInfo.psupport.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import m2soft.rdsystem.server.core.rddbagent.util.HttpResult;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import daewooInfo.common.TmsMessageSource;

@Controller
public class PSupportController {

	/**
	 * @uml.property  name="tmsMessageSource"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="tmsMessageSource")
    TmsMessageSource tmsMessageSource;
	
	/**
	 * param을 인자로 받아서 바로 jsp로 리턴해줌.
	 * ex) /psupport/psupport.do?param=psupport/list
	 *     WEB-INF/jsp/psupport/list.jsp
	 *     
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/psupport/psupport.do")
    public String recentlyBoardList(
    		Map<String, Object> commandMap,
    		ModelMap model) throws Exception {
		
    	String view = (String)commandMap.get("param");
    	
    	return view;
    }
}
