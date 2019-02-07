package daewooInfo.admin.access.web;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import daewooInfo.admin.access.bean.AccessManageVO;
import daewooInfo.admin.access.service.AccessManageService;
import daewooInfo.common.login.bean.LoginVO;

//import egovframework.com.cmm.LoginVO;
//import egovframework.com.cmm.util.EgovUserDetailsHelper;

/**
 * @Class Name : AccessManageInterceptor.java
 * @Description : 웹로그 생성을 위한 인터셉터 클래스
 * @Modification Information
 *
 *    수정일        수정자         수정내용
 *    -------      -------     -------------------
 *    2009. 3. 9.   이삼섭         최초생성
 *    2011. 7. 1.   이기하         패키지 분리(sym.log -> sym.log.wlg)
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 9.
 * @version
 * @see
 *
 */
public class AccessManagerInterceptor extends HandlerInterceptorAdapter {


	/** AccessManageService */
	@Resource(name = "accessManageService")
    private AccessManageService accessManageService;
	
	/**
	 * 웹 로그정보를 생성한다.
	 * 
	 * @param HttpServletRequest request, HttpServletResponse response, Object handler 
	 * @return 
	 * @throws Exception 
	 */
	@Override
	public void postHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler, ModelAndView modeAndView) throws Exception {
		
		AccessManageVO accessManageVO = new AccessManageVO();
		String reqURL = request.getRequestURI();
		String uniqId = "";
		
		accessManageVO.setType("PAGE");
    	/* Authenticated  */
//        Boolean isAuthenticated = EgovUserDetailsHelper.isAuthenticated();
//    	if(isAuthenticated.booleanValue()) {
//			LoginVO user = (LoginVO)EgovUserDetailsHelper.getAuthenticatedUser();
//			uniqId = user.getUniqId();
//    	}

//		accessManage.setUrl(reqURL);
//		accessManage.setRqesterId(uniqId);
//		accessManage.setRqesterIp(request.getRemoteAddr());
		
		accessManageService.insertAccessLogin(accessManageVO, request);
		
	}
}
