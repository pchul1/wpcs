package daewooInfo.smsmanage.bean;

import daewooInfo.cmmn.bean.ComDefaultVO;

public class SmsTargetVO extends ComDefaultVO {
	private String sms_target_no;
	private String fact_code;
	private String branch_no;
	private String member_id;
	private String use_flag;
	private String reg_date;
	private String reg_id;
	private String recv_type;
	private String det_code;
	private String det_code_name;
	private String deptNoName;
	private String mobileNo;
	private String memberName;
	
	public String getSms_target_no() {
		return sms_target_no;
	}
	public void setSms_target_no(String sms_target_no) {
		this.sms_target_no = sms_target_no;
	}
	public String getFact_code() {
		return fact_code;
	}
	public void setFact_code(String fact_code) {
		this.fact_code = fact_code;
	}
	public String getBranch_no() {
		return branch_no;
	}
	public void setBranch_no(String branch_no) {
		this.branch_no = branch_no;
	}
	public String getMember_id() {
		return member_id;
	}
	public void setMember_id(String member_id) {
		this.member_id = member_id;
	}
	public String getUse_flag() {
		return use_flag;
	}
	public void setUse_flag(String use_flag) {
		this.use_flag = use_flag;
	}
	public String getReg_date() {
		return reg_date;
	}
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}
	public String getReg_id() {
		return reg_id;
	}
	public void setReg_id(String reg_id) {
		this.reg_id = reg_id;
	}
	public String getRecv_type() {
		return recv_type;
	}
	public void setRecv_type(String recv_type) {
		this.recv_type = recv_type;
	}
	public String getDet_code() {
		return det_code;
	}
	public void setDet_code(String det_code) {
		this.det_code = det_code;
	}
	public String getDet_code_name() {
		return det_code_name;
	}
	public void setDet_code_name(String det_code_name) {
		this.det_code_name = det_code_name;
	}
	public String getDeptNoName() {
		return deptNoName;
	}
	public void setDeptNoName(String deptNoName) {
		this.deptNoName = deptNoName;
	}
	public String getMobileNo() {
		return mobileNo;
	}
	public void setMobileNo(String mobileNo) {
		this.mobileNo = mobileNo;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
}
