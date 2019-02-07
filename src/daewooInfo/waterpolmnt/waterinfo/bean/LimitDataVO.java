package daewooInfo.waterpolmnt.waterinfo.bean;

import daewooInfo.cmmn.bean.ComDefaultVO;

public class LimitDataVO extends ComDefaultVO{
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	private String fact_code;
	private String branch_no;
	private String item_code;
	private String item_name;
	private String item_value_hi;
	private String item_value_lo;
	private String msr_id;
	private String from_fact_code;
	private String to_fact_code;
	private String to_branch_no;

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
	public String getItem_code() {
		return item_code;
	}
	public void setItem_code(String item_code) {
		this.item_code = item_code;
	}
	public String getItem_name() {
		return item_name;
	}
	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}
	public String getItem_value_hi() {
		return item_value_hi;
	}
	public void setItem_value_hi(String item_value_hi) {
		this.item_value_hi = item_value_hi;
	}
	public String getItem_value_lo() {
		return item_value_lo;
	}
	public void setItem_value_lo(String item_value_lo) {
		this.item_value_lo = item_value_lo;
	}
	public String getMsr_id() {
		return msr_id;
	}
	public void setMsr_id(String msr_id) {
		this.msr_id = msr_id;
	}
	public String getFrom_fact_code() {
		return from_fact_code;
	}
	public void setFrom_fact_code(String from_fact_code) {
		this.from_fact_code = from_fact_code;
	}
	public String getTo_fact_code() {
		return to_fact_code;
	}
	public void setTo_fact_code(String to_fact_code) {
		this.to_fact_code = to_fact_code;
	}
	public String getTo_branch_no() {
		return to_branch_no;
	}
	public void setTo_branch_no(String to_branch_no) {
		this.to_branch_no = to_branch_no;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
