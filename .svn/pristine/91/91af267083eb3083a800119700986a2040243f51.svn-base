package daewooInfo.mobile.com.handler;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import daewooInfo.mobile.com.utl.LogInfoUtil;

/**
* <pre>
* 1. 패키지명 : daewooInfo.mobile.com.handler
* 2. 타입명 : MobileCommonInterceptor.java
* 3. 작성일 : 2014. 9. 12. 오후 5:35:51
* 4. 작성자 : kys
* 5. 설명 : 모바일 interceptor
* </pre>
*/
public class MobileCommonInterceptor extends HandlerInterceptorAdapter  {
	private static Logger log = Logger.getLogger(MobileCommonInterceptor.class);
	
    /* (non-Javadoc)
     * 모바일 인터셉터 ( 로그인 여부 체크)
     */
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    	try{
	    	if(null != LogInfoUtil.GetSessionLogin()){
	    		return true;
	    	}else{
	    		ModelAndView modelAndView = new ModelAndView("redirect:/mobile/alert.do?message=fail.common.login&return_url=/mobile/");
				throw new ModelAndViewDefiningException(modelAndView);
	    	}
    	}catch(Exception e){
    		ModelAndView modelAndView = new ModelAndView("redirect:/mobile/alert.do?message=fail.common.login&return_url=/mobile/");
			throw new ModelAndViewDefiningException(modelAndView);
    	}
    }  

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    }  

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {  
    }  
}
