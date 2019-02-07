package daewooInfo.cmmn.bean;

/*
create table T_CMN_WEBLOG(
	id varchar2(20),
	ip varchar2(25),
	uri varchar2(255),
	controller varchar2(100),
	params varchar2(500) default ' ',
	crtdate date
)

create table T_CMN_WEBLOG_URI(
	seq number,
	g1 varchar2(50),
	g2 varchar2(50),
	g3 varchar2(50),
	uri varchar2(255),
	params varchar2(500)  default ' '
)
 */
public class CmnLogCounterVO {
	/**
	 * @uml.property  name="id"
	 */
	private String id;
	/**
	 * @uml.property  name="ip"
	 */
	private String ip;
	/**
	 * @uml.property  name="uri"
	 */
	private String uri;
	/**
	 * @uml.property  name="controller"
	 */
	private String controller;
	/**
	 * @uml.property  name="params"
	 */
	private String params;
	
	/**
	 * @uml.property  name="frDate"
	 */
	private String frDate;
	/**
	 * @uml.property  name="toDate"
	 */
	private String toDate;
	
	/**
	 * @uml.property  name="loginCnt"
	 */
	private String loginCnt;
	/**
	 * @uml.property  name="loginDate"
	 */
	private String loginDate;
	
	/**
	 * @return
	 * @uml.property  name="id"
	 */
	public String getId() {
		return id;
	}
	/**
	 * @param id
	 * @uml.property  name="id"
	 */
	public void setId(String id) {
		this.id = id;
	}
	/**
	 * @return
	 * @uml.property  name="ip"
	 */
	public String getIp() {
		return ip;
	}
	/**
	 * @param ip
	 * @uml.property  name="ip"
	 */
	public void setIp(String ip) {
		this.ip = ip;
	}
	/**
	 * @return
	 * @uml.property  name="uri"
	 */
	public String getUri() {
		return uri;
	}
	/**
	 * @param uri
	 * @uml.property  name="uri"
	 */
	public void setUri(String uri) {
		this.uri = uri;
	}
	/**
	 * @return
	 * @uml.property  name="controller"
	 */
	public String getController() {
		return controller;
	}
	/**
	 * @param controller
	 * @uml.property  name="controller"
	 */
	public void setController(String controller) {
		this.controller = controller;
	}
	/**
	 * @return
	 * @uml.property  name="params"
	 */
	public String getParams() {
		return params;
	}
	/**
	 * @param params
	 * @uml.property  name="params"
	 */
	public void setParams(String params) {
		this.params = params;
	}
	
	/**
	 * @return
	 * @uml.property  name="frDate"
	 */
	public String getFrDate() {
		return frDate;
	}
	/**
	 * @param frDate
	 * @uml.property  name="frDate"
	 */
	public void setFrDate(String frDate) {
		this.frDate = frDate;
	}
	/**
	 * @return
	 * @uml.property  name="toDate"
	 */
	public String getToDate() {
		return toDate;
	}
	/**
	 * @param toDate
	 * @uml.property  name="toDate"
	 */
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	/**
	 * @return
	 * @uml.property  name="loginCnt"
	 */
	public String getLoginCnt() {
		return loginCnt;
	}
	/**
	 * @param loginCnt
	 * @uml.property  name="loginCnt"
	 */
	public void setLoginCnt(String loginCnt) {
		this.loginCnt = loginCnt;
	}
	/**
	 * @return
	 * @uml.property  name="loginDate"
	 */
	public String getLoginDate() {
		return loginDate;
	}
	/**
	 * @param loginDate
	 * @uml.property  name="loginDate"
	 */
	public void setLoginDate(String loginDate) {
		this.loginDate = loginDate;
	}
	@Override
	public String toString() {
		return "CmnLogCounterVO [id=" + id + ", ip=" + ip + ", uri=" + uri
				+ ", controller=" + controller + ", params=" + params + "]";
	}	
}
