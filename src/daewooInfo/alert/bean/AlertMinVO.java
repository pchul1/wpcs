package daewooInfo.alert.bean;

/**
 * @author DaeWoo Information Systems Co., Ltd.  Technical Expert Team. khanian.
 * @version 1.0
 * @Class Name : .java
 * @Description :  Class
 * @Modification Information
 * @
 * @ Modify Date     author               Modify Contents
 * @ --------------  ------------   -------------------------------
 * @ 2010. 4. 14  	 khanian              new
 * @see Copyright (C) by DaeWoo Information Systems Co., Ltd. All right reserved.
 * @since 2010. 1. 21
 */

public class AlertMinVO {
	/**
	 * @uml.property  name="factCode"
	 */
	private String factCode;
	/**
	 * @uml.property  name="branchNo"
	 */
	private int branchNo;
	/**
	 * @uml.property  name="minTime"
	 */
	private String minTime;
	/**
	 * @uml.property  name="tur"
	 */
	private Float tur;
	/**
	 * @uml.property  name="phy"
	 */
	private Float phy;
	/**
	 * @uml.property  name="con"
	 */
	private Float con;
	/**
	 * @uml.property  name="dow"
	 */
	private Float dow;
	/**
	 * @uml.property  name="itemCode"
	 */
	private String itemCode;
	/**
	 * @uml.property  name="minVl"
	 */
	private Float minVl; 
	/**
	 * @uml.property  name="timeDiff"
	 */
	private int timeDiff;
	
	private Float tmp;
	
	private Float tof;
	
	public Float getTmp() {
		return tmp;
	}
	public void setTmp(Float tmp) {
		this.tmp = tmp;
	}
	public Float getTof() {
		return tof;
	}
	public void setTof(Float tof) {
		this.tof = tof;
	}
	/**
	 * @return
	 * @uml.property  name="timeDiff"
	 */
	public int getTimeDiff() {
		return timeDiff;
	}
	/**
	 * @param timeDiff
	 * @uml.property  name="timeDiff"
	 */
	public void setTimeDiff(int timeDiff) {
		this.timeDiff = timeDiff;
	}
	/**
	 * @return
	 * @uml.property  name="minVl"
	 */
	public Float getMinVl() {
		return minVl;
	}
	/**
	 * @param minVl
	 * @uml.property  name="minVl"
	 */
	public void setMinVl(Float minVl) {
		this.minVl = minVl;
	}
	/**
	 * @return
	 * @uml.property  name="itemCode"
	 */
	public String getItemCode() {
		return itemCode;
	}
	/**
	 * @param itemCode
	 * @uml.property  name="itemCode"
	 */
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}
	/**
	 * @return
	 * @uml.property  name="factCode"
	 */
	public String getFactCode() {
		return factCode;
	}
	/**
	 * @param factCode
	 * @uml.property  name="factCode"
	 */
	public void setFactCode(String factCode) {
		this.factCode = factCode;
	}
	/**
	 * @return
	 * @uml.property  name="branchNo"
	 */
	public int getBranchNo() {
		return branchNo;
	}
	/**
	 * @param branchNo
	 * @uml.property  name="branchNo"
	 */
	public void setBranchNo(int branchNo) {
		this.branchNo = branchNo;
	}
	/**
	 * @return
	 * @uml.property  name="minTime"
	 */
	public String getMinTime() {
		return minTime;
	}
	/**
	 * @param minTime
	 * @uml.property  name="minTime"
	 */
	public void setMinTime(String minTime) {
		this.minTime = minTime;
	}
	/**
	 * @return
	 * @uml.property  name="tur"
	 */
	public Float getTur() {
		return tur;
	}
	/**
	 * @param tur
	 * @uml.property  name="tur"
	 */
	public void setTur(Float tur) {
		this.tur = tur;
	}
	/**
	 * @return
	 * @uml.property  name="phy"
	 */
	public Float getPhy() {
		return phy;
	}
	/**
	 * @param phy
	 * @uml.property  name="phy"
	 */
	public void setPhy(Float phy) {
		this.phy = phy;
	}
	/**
	 * @return
	 * @uml.property  name="con"
	 */
	public Float getCon() {
		return con;
	}
	/**
	 * @param con
	 * @uml.property  name="con"
	 */
	public void setCon(Float con) {
		this.con = con;
	}
	/**
	 * @return
	 * @uml.property  name="dow"
	 */
	public Float getDow() {
		return dow;
	}
	/**
	 * @param dow
	 * @uml.property  name="dow"
	 */
	public void setDow(Float dow) {
		this.dow = dow;
	}

}	
