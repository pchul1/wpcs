package daewooInfo.mobile.com.utl;

import javax.servlet.http.HttpServletRequest;

import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.security.util.TmsUserDetailsHelper;

public class LogInfoUtil {

	public static LoginVO GetSessionLogin() throws Exception
	{
		return (LoginVO)TmsUserDetailsHelper.getAuthenticatedUser();
	}
}
