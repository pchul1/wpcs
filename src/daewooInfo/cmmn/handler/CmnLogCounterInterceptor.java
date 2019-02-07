package daewooInfo.cmmn.handler;

import java.util.Enumeration;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.Authentication;
import org.springframework.security.context.SecurityContext;
import org.springframework.security.context.SecurityContextHolder;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import signgate.crypto.util.Debug;

import daewooInfo.cmmn.bean.CmnLogCounterVO;
import daewooInfo.cmmn.service.CmnLogCounterService;
import egovframework.rte.fdl.string.EgovObjectUtil;

public class CmnLogCounterInterceptor extends HandlerInterceptorAdapter{
	
	private static Logger log = Logger.getLogger(CmnLogCounterInterceptor.class);
	
	/**
	 * @uml.property  name="cmnLogCounterService"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Autowired
	private CmnLogCounterService cmnLogCounterService;
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		
		try{
			CmnLogCounterVO vo = new CmnLogCounterVO();
			vo.setIp(request.getLocalAddr());
			vo.setUri(request.getRequestURI());
			vo.setController(handler.toString());
			
			Enumeration em = request.getParameterNames();
			StringBuilder sb = new StringBuilder();
			while(em.hasMoreElements()){
				String key = em.nextElement().toString();
				sb.append("&").append(key).append("=").append(request.getParameter(key));
				
			}
			
			if(sb.toString().equals("") || sb.toString() == null || sb.toString().length() > 500){
				vo.setParams("&");
			}else{
				vo.setParams(sb.toString());
			}
			
			SecurityContext context = SecurityContextHolder.getContext();
			Authentication authentication = context.getAuthentication();
			
			if (!EgovObjectUtil.isNull(authentication)) {
				String id = authentication.getName();
				vo.setId(id);
			}
			
			if(vo.getId() == null){
				
			}else if(vo.getId().equals("roleAnonymous")){
				
			}else{
				cmnLogCounterService.addLogCount(vo);
			}
			
//			if( !(vo.getId().equals("roleAnonymous") || vo.getId() == null) ){
//				cmnLogCounterService.addLogCount(vo);
//			}
			
		}catch(Exception e){
			log.error("CmnLogCounterInterceptor error",e);
		}
		
		//log.info(cmnLogCounterService);
		
		return super.preHandle(request, response, handler);
	}
}