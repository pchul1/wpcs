package daewooInfo.common.login.service;

import java.util.List;

import daewooInfo.cmmn.bean.CmmnDetailCode;
import daewooInfo.cmmn.bean.DeptVO;
import daewooInfo.common.login.bean.LoginVO;
import daewooInfo.common.login.bean.MemberVO;

public interface LoginService {
	
	void batchPasswordMd5() throws Exception;
	
	/**
	 * 일반 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    LoginVO actionLogin(LoginVO vo) throws Exception;

	/**
	 * 인증서 정보를 저장한다.
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    void updateDn(LoginVO vo) throws Exception;
    
    /**
	 * 인증서 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    LoginVO actionCrtfctLogin(LoginVO vo) throws Exception;
    
    /**
	 * 아이디를 찾는다.
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    LoginVO searchId(LoginVO vo) throws Exception;
    
    /**
	 * 비밀번호를 찾는다.
	 * @param vo LoginVO
	 * @return boolean
	 * @exception Exception
	 */
    boolean searchPassword(LoginVO vo) throws Exception;
    
    /**
     * 시/도 정보를 가져온다. 
     * @return
     * @throws Exception
     */
    List<CmmnDetailCode> getAreaDoCode() throws Exception;
    
    /**
     * 시/군 정보를 가져온다.
     * @return
     * @throws Exception
     */
    List<CmmnDetailCode> getAreaCtyCode(String doCode) throws Exception;

    /**
     * 시/군 정보를 가져온다. (where deptCode)
     * @param deptCode
     * @return
     * @throws Exception
     */
    List<CmmnDetailCode> getAreaCtyCodeWhereDeptNo(String deptCode) throws Exception;
    
    /**
     * 시/군 정보를 가져온다.
     * @return
     * @throws Exception
     */
    List<CmmnDetailCode> getAreaCtyCodeAll() throws Exception;
    
    /**
     * 관련 기관 코드를 가져온다.
     * @return
     * @throws Exception
     */
    List<CmmnDetailCode> getOrganCode() throws Exception;
    
    /**
     * 부서정보를 가져온다.
     * @return
     * @throws Exception
     */
    List<DeptVO> getDeptCode(String upperDeptNo) throws Exception;
    
    List<CmmnDetailCode> getGroupCode() throws Exception;
    
    /**
     * 수계정보를 가져온다.
     * @return
     * @throws Exception
     */
    List<CmmnDetailCode> getRiverIdCode() throws Exception;
    
    /**
     * 수계, 공구 정보를 가져온다.
     * @return
     * @throws Exception
     */
    List<CmmnDetailCode> getFactInfoCode() throws Exception;
    
    /**
     * ID 중복체크
     * @param checkID
     * @return
     * @throws Exception
     */
    int checkID(String checkID) throws Exception;
    
    /**
     * 계정신청을 처리한다.
     * @param bean
     * @return
     * @throws Exception
     */
    MemberVO actionRegister(MemberVO bean) throws Exception;


	void updateWrongCount(LoginVO paramLoginVO) throws Exception;

	int getWrongCount(LoginVO paramLoginVO) throws Exception;

	LoginVO checkWrongCount(LoginVO paramLoginVO) throws Exception;
	
	String getAccountFindId(String uId) throws Exception;
	

	/**
	 * 측정소 권한을 획득한다.
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    List<LoginVO> memberAuthorList(String uId) throws Exception;
}
