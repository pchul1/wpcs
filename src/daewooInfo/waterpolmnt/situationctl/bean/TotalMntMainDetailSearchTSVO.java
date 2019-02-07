package daewooInfo.waterpolmnt.situationctl.bean;


/**
 * @author DaeWoo Information Systems Co., Ltd.  Technical Expert Team. loafzzang.
 * @version 1.0
 * @Class Name : SearchVO.java
 * @Description :  Class
 * @Modification Information
 * @
 * @ Modify Date     author               Modify Contents
 * @ --------------   ------------   -------------------------------
 * @ 2010. 1. 27  loafzzang                   new
 * @see Copyright (C) by DaeWoo Information Systems Co., Ltd. All right reserved.
 * @since 2010. 1. 27
 */
public class TotalMntMainDetailSearchTSVO {
	/**/
	/**
	 * @uml.property  name="fact_code"
	 */
	private String fact_code;      
	/**
	 * @uml.property  name="branch_no"
	 */
	private String branch_no;   	
    /**
	 * @uml.property  name="sys"
	 */
    private String sys;
    /**
	 * @uml.property  name="river"
	 */
    private String river;
    /**
	 * @uml.property  name="step"
	 */
    private String step;
    /**
	 * @uml.property  name="item"
	 */
    private String item;
    /**
	 * @uml.property  name="orderby"
	 */
    private String orderby;
    /**
	 * @uml.property  name="compareDate"
	 */
    private String compareDate;
    
    
	/**
	 * @return
	 * @uml.property  name="compareDate"
	 */
	public String getCompareDate() {
		return compareDate;
	}
	/**
	 * @param compareDate
	 * @uml.property  name="compareDate"
	 */
	public void setCompareDate(String compareDate) {
		this.compareDate = compareDate;
	}
	/**
	 * @return
	 * @uml.property  name="orderby"
	 */
	public String getOrderby() {
		return orderby;
	}
	/**
	 * @param orderby
	 * @uml.property  name="orderby"
	 */
	public void setOrderby(String orderby) {
		this.orderby = orderby;
	}
	/**
	 * @return
	 * @uml.property  name="fact_code"
	 */
	public String getFact_code() {
		return fact_code;
	}
	/**
	 * @param fact_code
	 * @uml.property  name="fact_code"
	 */
	public void setFact_code(String fact_code) {
		this.fact_code = fact_code;
	}
	/**
	 * @return
	 * @uml.property  name="branch_no"
	 */
	public String getBranch_no() {
		return branch_no;
	}
	/**
	 * @param branch_no
	 * @uml.property  name="branch_no"
	 */
	public void setBranch_no(String branch_no) {
		this.branch_no = branch_no;
	}
    /**
	 * @return
	 * @uml.property  name="sys"
	 */
    public String getSys() {
		return sys;
	}
	/**
	 * @param sys
	 * @uml.property  name="sys"
	 */
	public void setSys(String sys) {
		this.sys = sys;
	}
	/**
	 * @return
	 * @uml.property  name="river"
	 */
	public String getRiver() {
		return river;
	}
	/**
	 * @param river
	 * @uml.property  name="river"
	 */
	public void setRiver(String river) {
		this.river = river;
	}
	/**
	 * @return
	 * @uml.property  name="step"
	 */
	public String getStep() {
		return step;
	}
	/**
	 * @param step
	 * @uml.property  name="step"
	 */
	public void setStep(String step) {
		this.step = step;
	}
	/**
	 * @return
	 * @uml.property  name="item"
	 */
	public String getItem() {
		return item;
	}
	/**
	 * @param item
	 * @uml.property  name="item"
	 */
	public void setItem(String item) {
		this.item = item;
	}
}
