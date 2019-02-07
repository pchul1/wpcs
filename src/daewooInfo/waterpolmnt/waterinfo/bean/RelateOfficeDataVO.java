package daewooInfo.waterpolmnt.waterinfo.bean;

import daewooInfo.cmmn.bean.ComDefaultVO;

public class RelateOfficeDataVO extends ComDefaultVO{
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * @uml.property  name="id"
	 */
	private String id;			//ID
	/**
	 * @uml.property  name="nm"
	 */
	private String nm;			//유관기관명
	/**
	 * @uml.property  name="address"
	 */
	private String address;		//주소
	/**
	 * @uml.property  name="do_code"
	 */
	private String do_code;		//도코드값
	/**
	 * @uml.property  name="cty_code"
	 */
	private String cty_code;	//시군구코드값
	/**
	 * @uml.property  name="dept"
	 */
	private String dept;		//부서명
	/**
	 * @uml.property  name="use_yn"
	 */
	private String use_yn;
	/**
	 * @uml.property  name="day_tel"
	 */
	private String day_tel;		//주간전화번호
	/**
	 * @uml.property  name="night_tel"
	 */
	private String night_tel;	//야간전화번호
	/**
	 * @uml.property  name="day_fax"
	 */
	private String day_fax;		//주간 팩스
	/**
	 * @uml.property  name="night_fax"
	 */
	private String night_fax;	//야간 팩스
	
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
	 * @uml.property  name="nm"
	 */
	public String getNm() {
		return nm;
	}

	/**
	 * @param nm
	 * @uml.property  name="nm"
	 */
	public void setNm(String nm) {
		this.nm = nm;
	}

	/**
	 * @return
	 * @uml.property  name="address"
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * @param address
	 * @uml.property  name="address"
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * @return
	 * @uml.property  name="do_code"
	 */
	public String getDo_code() {
		return do_code;
	}

	/**
	 * @param do_code
	 * @uml.property  name="do_code"
	 */
	public void setDo_code(String do_code) {
		this.do_code = do_code;
	}

	/**
	 * @return
	 * @uml.property  name="cty_code"
	 */
	public String getCty_code() {
		return cty_code;
	}

	/**
	 * @param cty_code
	 * @uml.property  name="cty_code"
	 */
	public void setCty_code(String cty_code) {
		this.cty_code = cty_code;
	}

	/**
	 * @return
	 * @uml.property  name="dept"
	 */
	public String getDept() {
		return dept;
	}

	/**
	 * @param dept
	 * @uml.property  name="dept"
	 */
	public void setDept(String dept) {
		this.dept = dept;
	}

	/**
	 * @return
	 * @uml.property  name="use_yn"
	 */
	public String getUse_yn() {
		return use_yn;
	}

	/**
	 * @param use_yn
	 * @uml.property  name="use_yn"
	 */
	public void setUse_yn(String use_yn) {
		this.use_yn = use_yn;
	}

	/**
	 * @return
	 * @uml.property  name="day_tel"
	 */
	public String getDay_tel() {
		return day_tel;
	}

	/**
	 * @param day_tel
	 * @uml.property  name="day_tel"
	 */
	public void setDay_tel(String day_tel) {
		this.day_tel = day_tel;
	}

	/**
	 * @return
	 * @uml.property  name="night_tel"
	 */
	public String getNight_tel() {
		return night_tel;
	}

	/**
	 * @param night_tel
	 * @uml.property  name="night_tel"
	 */
	public void setNight_tel(String night_tel) {
		this.night_tel = night_tel;
	}

	/**
	 * @return
	 * @uml.property  name="day_fax"
	 */
	public String getDay_fax() {
		return day_fax;
	}

	/**
	 * @param day_fax
	 * @uml.property  name="day_fax"
	 */
	public void setDay_fax(String day_fax) {
		this.day_fax = day_fax;
	}

	/**
	 * @return
	 * @uml.property  name="night_fax"
	 */
	public String getNight_fax() {
		return night_fax;
	}

	/**
	 * @param night_fax
	 * @uml.property  name="night_fax"
	 */
	public void setNight_fax(String night_fax) {
		this.night_fax = night_fax;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
