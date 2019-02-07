package daewooInfo.admin.security.bean;

import daewooInfo.cmmn.bean.ComDefaultVO;


/**
 * 권한그룹에 대한 model 클래스를 정의한다.
 * @author 공통서비스 개발팀 이문준
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이문준          최초 생성
 *
 * </pre>
 */

public class AuthorGroup extends ComDefaultVO {
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 권한그룹관리
	 * @uml.property  name="authorGroup"
	 * @uml.associationEnd  
	 */
	private AuthorGroup authorGroup;	
	/**
	 * 설정대상 사용자 ID
	 * @uml.property  name="userId"
	 */
	private String userId;
	/**
	 * 설정대상 사용자 명
	 * @uml.property  name="userNm"
	 */
	private String userNm;
	/**
	 * 설정대상 그룹 ID
	 * @uml.property  name="groupId"
	 */
	private String groupId;	
	/**
	 * 권한코드
	 * @uml.property  name="authorCode"
	 */
	private String authorCode;
	/**
	 * 등록 여부
	 * @uml.property  name="regYn"
	 */
	private String regYn;
	/**
	 * Uniq ID
	 * @uml.property  name="uniqId"
	 */
	private String uniqId;
	
	/**
	 * @uml.property  name="deptNo"
	 */
	private String deptNo;
	/**
	 * @uml.property  name="deptNoName"
	 */
	private String deptNoName;
	/**
	 * @uml.property  name="groupName"
	 */
	private String groupName;
	
	
	/**
	 * @return
	 * @uml.property  name="groupName"
	 */
	public String getGroupName() {
		return groupName;
	}
	/**
	 * @param groupName
	 * @uml.property  name="groupName"
	 */
	public void setGroupName(String groupName) {
		this.groupName = groupName;
	}
	/**
	 * @return
	 * @uml.property  name="deptNo"
	 */
	public String getDeptNo() {
		return deptNo;
	}
	/**
	 * @param deptNo
	 * @uml.property  name="deptNo"
	 */
	public void setDeptNo(String deptNo) {
		this.deptNo = deptNo;
	}
	/**
	 * @return
	 * @uml.property  name="deptNoName"
	 */
	public String getDeptNoName() {
		return deptNoName;
	}
	/**
	 * @param deptNoName
	 * @uml.property  name="deptNoName"
	 */
	public void setDeptNoName(String deptNoName) {
		this.deptNoName = deptNoName;
	}
	/**
	 * authorGroup attribute 를 리턴한다.
	 * @return  AuthorGroup
	 * @uml.property  name="authorGroup"
	 */
	public AuthorGroup getAuthorGroup() {
		return authorGroup;
	}
	/**
	 * authorGroup attribute 값을 설정한다.
	 * @param authorGroup  AuthorGroup
	 * @uml.property  name="authorGroup"
	 */
	public void setAuthorGroup(AuthorGroup authorGroup) {
		this.authorGroup = authorGroup;
	}
	/**
	 * userId attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="userId"
	 */
	public String getUserId() {
		return userId;
	}
	/**
	 * userId attribute 값을 설정한다.
	 * @param userId  String
	 * @uml.property  name="userId"
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
	/**
	 * userNm attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="userNm"
	 */
	public String getUserNm() {
		return userNm;
	}
	/**
	 * userNm attribute 값을 설정한다.
	 * @param userNm  String
	 * @uml.property  name="userNm"
	 */
	public void setUserNm(String userNm) {
		this.userNm = userNm;
	}
	/**
	 * groupId attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="groupId"
	 */
	public String getGroupId() {
		return groupId;
	}
	/**
	 * groupId attribute 값을 설정한다.
	 * @param groupId  String
	 * @uml.property  name="groupId"
	 */
	public void setGroupId(String groupId) {
		this.groupId = groupId;
	}
	/**
	 * authorCode attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="authorCode"
	 */
	public String getAuthorCode() {
		return authorCode;
	}
	/**
	 * authorCode attribute 값을 설정한다.
	 * @param authorCode  String
	 * @uml.property  name="authorCode"
	 */
	public void setAuthorCode(String authorCode) {
		this.authorCode = authorCode;
	}
	/**
	 * regYn attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="regYn"
	 */
	public String getRegYn() {
		return regYn;
	}
	/**
	 * regYn attribute 값을 설정한다.
	 * @param regYn  String
	 * @uml.property  name="regYn"
	 */
	public void setRegYn(String regYn) {
		this.regYn = regYn;
	}
	/**
	 * uniqId attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="uniqId"
	 */
	public String getUniqId() {
		return uniqId;
	}
	/**
	 * uniqId attribute 값을 설정한다.
	 * @param uniqId  String
	 * @uml.property  name="uniqId"
	 */
	public void setUniqId(String uniqId) {
		this.uniqId = uniqId;
	}
	

	
	
}