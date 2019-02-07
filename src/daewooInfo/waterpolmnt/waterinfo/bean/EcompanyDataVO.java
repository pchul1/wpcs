package daewooInfo.waterpolmnt.waterinfo.bean;

import daewooInfo.cmmn.bean.ComDefaultVO;

public class EcompanyDataVO extends ComDefaultVO{
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * @uml.property  name="id"
	 */
	private String id;				//ID
	/**
	 * @uml.property  name="nm"
	 */
	private String nm;				//업체명
	/**
	 * @uml.property  name="address"
	 */
	private String address;			//주소
	/**
	 * @uml.property  name="owner"
	 */
	private String owner;			//담당자
	/**
	 * @uml.property  name="longitude"
	 */
	private String longitude;		//경도
	/**
	 * @uml.property  name="latitude"
	 */
	private String latitude;		//위도
	/**
	 * @uml.property  name="d_phone"
	 */
	private String d_phone;			//주간연락처
	/**
	 * @uml.property  name="n_phone"
	 */
	private String n_phone;			//야간연락처
	/**
	 * @uml.property  name="do_code"
	 */
	private String do_code;			//도코드
	/**
	 * @uml.property  name="cty_code"
	 */
	private String cty_code;		//시군구코드
	/**
	 * @uml.property  name="river_nm"
	 */
	private String river_nm;		//수계명
	/**
	 * @uml.property  name="river_div"
	 */
	private String river_div;		//수계ID
	/**
	 * @uml.property  name="basin_large"
	 */
	private String basin_large;		//대권역ID
	/**
	 * @uml.property  name="basin_middle"
	 */
	private String basin_middle;	//중권역ID
	/**
	 * @uml.property  name="basin_small"
	 */
	private String basin_small;		//소권역ID
	/**
	 * @uml.property  name="use_yn"
	 */
	private String use_yn;			//사용여부
	/**
	 * @uml.property  name="fax"
	 */
	private String fax;				//팩스
	/**
	 * @uml.property  name="type"
	 */
	private String type;			//업체구분
	/**
	 * @uml.property  name="e_phone"
	 */
	private String e_phone;			//비상연락처
	
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
	 * @uml.property  name="owner"
	 */
	public String getOwner() {
		return owner;
	}

	/**
	 * @param owner
	 * @uml.property  name="owner"
	 */
	public void setOwner(String owner) {
		this.owner = owner;
	}

	/**
	 * @return
	 * @uml.property  name="longitude"
	 */
	public String getLongitude() {
		return longitude;
	}

	/**
	 * @param longitude
	 * @uml.property  name="longitude"
	 */
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	/**
	 * @return
	 * @uml.property  name="latitude"
	 */
	public String getLatitude() {
		return latitude;
	}

	/**
	 * @param latitude
	 * @uml.property  name="latitude"
	 */
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}

	/**
	 * @return
	 * @uml.property  name="d_phone"
	 */
	public String getD_phone() {
		return d_phone;
	}

	/**
	 * @param d_phone
	 * @uml.property  name="d_phone"
	 */
	public void setD_phone(String d_phone) {
		this.d_phone = d_phone;
	}

	/**
	 * @return
	 * @uml.property  name="n_phone"
	 */
	public String getN_phone() {
		return n_phone;
	}

	/**
	 * @param n_phone
	 * @uml.property  name="n_phone"
	 */
	public void setN_phone(String n_phone) {
		this.n_phone = n_phone;
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
	 * @uml.property  name="river_nm"
	 */
	public String getRiver_nm() {
		return river_nm;
	}

	/**
	 * @param river_nm
	 * @uml.property  name="river_nm"
	 */
	public void setRiver_nm(String river_nm) {
		this.river_nm = river_nm;
	}

	/**
	 * @return
	 * @uml.property  name="river_div"
	 */
	public String getRiver_div() {
		return river_div;
	}

	/**
	 * @param river_div
	 * @uml.property  name="river_div"
	 */
	public void setRiver_div(String river_div) {
		this.river_div = river_div;
	}

	/**
	 * @return
	 * @uml.property  name="basin_large"
	 */
	public String getBasin_large() {
		return basin_large;
	}

	/**
	 * @param basin_large
	 * @uml.property  name="basin_large"
	 */
	public void setBasin_large(String basin_large) {
		this.basin_large = basin_large;
	}

	/**
	 * @return
	 * @uml.property  name="basin_middle"
	 */
	public String getBasin_middle() {
		return basin_middle;
	}

	/**
	 * @param basin_middle
	 * @uml.property  name="basin_middle"
	 */
	public void setBasin_middle(String basin_middle) {
		this.basin_middle = basin_middle;
	}

	/**
	 * @return
	 * @uml.property  name="basin_small"
	 */
	public String getBasin_small() {
		return basin_small;
	}

	/**
	 * @param basin_small
	 * @uml.property  name="basin_small"
	 */
	public void setBasin_small(String basin_small) {
		this.basin_small = basin_small;
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
	 * @uml.property  name="fax"
	 */
	public String getFax() {
		return fax;
	}

	/**
	 * @param fax
	 * @uml.property  name="fax"
	 */
	public void setFax(String fax) {
		this.fax = fax;
	}

	/**
	 * @return
	 * @uml.property  name="type"
	 */
	public String getType() {
		return type;
	}

	/**
	 * @param type
	 * @uml.property  name="type"
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return
	 * @uml.property  name="e_phone"
	 */
	public String getE_phone() {
		return e_phone;
	}

	/**
	 * @param e_phone
	 * @uml.property  name="e_phone"
	 */
	public void setE_phone(String e_phone) {
		this.e_phone = e_phone;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
