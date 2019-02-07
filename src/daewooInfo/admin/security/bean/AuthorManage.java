package daewooInfo.admin.security.bean;

import daewooInfo.cmmn.bean.ComDefaultVO;

/**
 * 권한관리에 대한 model 클래스를 정의한다.
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

public class AuthorManage extends ComDefaultVO {

	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	/**
	 * 권한관리
	 * @uml.property  name="authorManage"
	 * @uml.associationEnd  
	 */	
	private AuthorManage authorManage;
	/**
	 * 권한코드
	 * @uml.property  name="authorCode"
	 */
	private String authorCode;
	/**
	 * 권한등록일자
	 * @uml.property  name="authorCreatDe"
	 */
	private String authorCreatDe;
	/**
	 * 권한코드설명
	 * @uml.property  name="authorDc"
	 */
	private String authorDc;
	/**
	 * 권한 명
	 * @uml.property  name="authorNm"
	 */
	private String authorNm;
	
	/**
	 * authorManage attribute 를 리턴한다.
	 * @return  AuthorManage
	 * @uml.property  name="authorManage"
	 */
	public AuthorManage getAuthorManage() {
		return authorManage;
	}
	/**
	 * authorManage attribute 값을 설정한다.
	 * @param authorManage  AuthorManage
	 * @uml.property  name="authorManage"
	 */
	public void setAuthorManage(AuthorManage authorManage) {
		this.authorManage = authorManage;
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
	 * authorCreatDe attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="authorCreatDe"
	 */
	public String getAuthorCreatDe() {
		return authorCreatDe;
	}
	/**
	 * authorCreatDe attribute 값을 설정한다.
	 * @param authorCreatDe  String
	 * @uml.property  name="authorCreatDe"
	 */
	public void setAuthorCreatDe(String authorCreatDe) {
		this.authorCreatDe = authorCreatDe;
	}
	/**
	 * authorDc attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="authorDc"
	 */
	public String getAuthorDc() {
		return authorDc;
	}
	/**
	 * authorDc attribute 값을 설정한다.
	 * @param authorDc  String
	 * @uml.property  name="authorDc"
	 */
	public void setAuthorDc(String authorDc) {
		this.authorDc = authorDc;
	}
	/**
	 * authorNm attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="authorNm"
	 */
	public String getAuthorNm() {
		return authorNm;
	}
	/**
	 * authorNm attribute 값을 설정한다.
	 * @param authorNm  String
	 * @uml.property  name="authorNm"
	 */
	public void setAuthorNm(String authorNm) {
		this.authorNm = authorNm;
	}
	


	

}
