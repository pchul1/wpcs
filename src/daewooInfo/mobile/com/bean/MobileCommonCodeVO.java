package daewooInfo.mobile.com.bean;

/**
* <pre>
* 1. 패키지명 : wpcs.com.service
* 2. 타입명 : DynamicSelectVO.java
* 3. 작성일 : 2014. 8. 20. 오후 5:22:13
* 4. 작성자 : kys
* 5. 설명 : 동적 셀렉트 박스 VO
* </pre>
*/
public class MobileCommonCodeVO {
	public String id;
	public String roleCode;
	public String value;
	public String name;
	public String branch_no;
	public String code_gbn;
	public String sys;
	public String code;
	public String common_code;
	public String common_code_category;
	
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getBranch_no() {
		return branch_no;
	}
	public void setBranch_no(String branch_no) {
		this.branch_no = branch_no;
	}
	public String getCode_gbn() {
		return code_gbn;
	}
	public void setCode_gbn(String code_gbn) {
		this.code_gbn = code_gbn;
	}
	public String getSys() {
		return sys;
	}
	public void setSys(String sys) {
		this.sys = sys;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getCommon_code() {
		return common_code;
	}
	public void setCommon_code(String common_code) {
		this.common_code = common_code;
	}
	public String getCommon_code_category() {
		return common_code_category;
	}
	public void setCommon_code_category(String common_code_category) {
		this.common_code_category = common_code_category;
	}
	public String getRoleCode() {
		return roleCode;
	}
	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
}
