package daewooInfo.cmmn.handler;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import daewooInfo.common.menu.bean.MenuVO;
import daewooInfo.common.menu.bean.MyMenuVO;
import daewooInfo.common.menu.service.MenuService;
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
public class LoginCheckInterceptor extends HandlerInterceptorAdapter  {
	private static Logger log = Logger.getLogger(LoginCheckInterceptor.class);
	
	
	@Resource(name="menuService")
	private MenuService menuService;
	
	
    /* (non-Javadoc)
     * 인터셉터 (로그인 여부 체크)
     * 로그인 링크 필요 여부 체크함.
     * URL 페턴이 뒤죽박죽이어서  T_PROGRAM_INFO 의 메뉴 링크를 검색해와서 
     */
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

    	MenuVO vo =  new MyMenuVO();
		
		String url = request.getRequestURI();
		if(null != request.getQueryString())
		{
			url += "?" + request.getQueryString();
		}
		vo.setUrl(url);
		vo = menuService.selectMenuCheck(vo);
		if(null!= vo || "/main.do".equals(request.getRequestURI()))
		{
			try{
	    		if(null != vo){
	    			request.getSession().setAttribute("clickMenu",vo.getMenuNo() + "");
	    		}
	    		
		    	if(null != LogInfoUtil.GetSessionLogin()){
		    		return true;
		    	}else{
		    		ModelAndView modelAndView = new ModelAndView("redirect:/loginFail.do?message=fail.common.login&return_url=/");
					throw new ModelAndViewDefiningException(modelAndView);
		    	}
	    	}catch(Exception e){
	    		// Session Timeout
	    		ModelAndView modelAndView = new ModelAndView("redirect:/sessionTimeout.do?message=fail.session.timeout&return_url=/");
				throw new ModelAndViewDefiningException(modelAndView);
	    	}
		}
		return true;
    }  

    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
    }  

    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {  
    }  
}
