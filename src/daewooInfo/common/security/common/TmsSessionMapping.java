package daewooInfo.common.security.common;

import daewooInfo.common.security.userdetails.TmsUserDetails;
import daewooInfo.common.security.userdetails.jdbc.EgovUsersByUsernameMapping;
import daewooInfo.common.login.bean.LoginVO;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * mapRow 결과를 사용자 EgovUserDetails Object 에 정의한다.
 * 
 * @author ByungHun Woo
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    -------------    ----------------------
 *   2009.03.10  ByungHun Woo    최초 생성
 *   2009.03.20  이문준          UPDATE
 *
 * </pre>
 */

public class TmsSessionMapping extends EgovUsersByUsernameMapping {
	
	/**
	 * 사용자정보를 테이블에서 조회하여 EgovUsersByUsernameMapping 에 매핑한다.
	 * @param ds DataSource
	 * @param usersByUsernameQuery String
	 */
	public TmsSessionMapping(DataSource ds, String usersByUsernameQuery) {
        super(ds, usersByUsernameQuery);
    }

	/**
	 * mapRow Override
	 * @param rs ResultSet 결과
	 * @param rownum row num
	 * @return Object EgovUserDetails
	 * @exception SQLException
	 */
	@Override
    protected Object mapRow(ResultSet rs, int rownum) throws SQLException {
    	logger.debug("## EgovUsersByUsernameMapping mapRow ##");

        String strUserId    = rs.getString("user_id");
        String strPassWord  = rs.getString("password");
        boolean strEnabled  = rs.getBoolean("enabled");
        
        String strUserNm    = rs.getString("user_nm");
        String strUserEmail = rs.getString("user_email");
        String strUniqId    = rs.getString("uniq_id");
        String strRoleCode	= rs.getString("role_code");
        String strDeptNo    = rs.getString("dept_no");
        String strRiverId	= rs.getString("river_id");
        String strMobileNo	= rs.getString("MOBILE_NO");
        String strUserUcnt	= rs.getString("U_CNT");
        String strUserAcnt	= rs.getString("A_CNT");
        String strUserWcnt	= rs.getString("W_CNT");
    
        // 세션 항목 설정
        LoginVO loginVO = new LoginVO();
        loginVO.setId(strUserId);
        loginVO.setPassword(strPassWord);
        loginVO.setName(strUserNm);
        loginVO.setEmail(strUserEmail);
        loginVO.setUniqId(strUniqId);
        loginVO.setRoleCode(strRoleCode);
        loginVO.setDeptNo(strDeptNo);
        loginVO.setRiverId(strRiverId);
        loginVO.setMobileNo(strMobileNo);
        loginVO.setUserUcnt(strUserUcnt);
        loginVO.setUserAcnt(strUserAcnt);
        loginVO.setUserWcnt(strUserWcnt);

        return new TmsUserDetails(strUserId, strPassWord, strEnabled, loginVO);
    }
}
