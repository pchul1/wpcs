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

public class AlertLawVO {
	/**
	 * @uml.property  name="turHVal"
	 */
	private Float turHVal;
	/**
	 * @uml.property  name="phyHVal"
	 */
	private Float phyHVal;
	/**
	 * @uml.property  name="phyLVal"
	 */
	private Float phyLVal;
	/**
	 * @uml.property  name="conHVal"
	 */
	private Float conHVal;
	/**
	 * @uml.property  name="dowLVal"
	 */
	private Float dowLVal;
	
	/**
	 * @uml.property  name="lawId"
	 */
	private String lawId;
	/**
	 * @uml.property  name="factCode"
	 */
	private String factCode;
	/**
	 * @uml.property  name="branchNo"
	 */
	private int branchNo;		
	/**
	 * @uml.property  name="itemCode"
	 */
	private String itemCode;
	/**
	 * @uml.property  name="itemName"
	 */
	private String itemName;
	/**
	 * @uml.property  name="lawHighValue"
	 */
	private Float lawHighValue;
	/**
	 * @uml.property  name="lawLowValue"
	 */
	private Float lawLowValue;
	/**
	 * @uml.property  name="lawAlarm1Value"
	 */
	private Float lawAlarm1Value;
	/**
	 * @uml.property  name="lawAlarm2Value"
	 */
	private Float lawAlarm2Value;
	/**
	 * @uml.property  name="lawApply"
	 */
	private String lawApply;
	
	/**
	 * @uml.property  name="lawHighValueStr"
	 */
	private double lawHighValueStr; 
	/**
	 * @uml.property  name="lawLowValueStr"
	 */
	private double lawLowValueStr;
	/**
	 * @uml.property  name="lawAlarm1ValueStr"
	 */
	private double lawAlarm1ValueStr;
	/**
	 * @uml.property  name="lawAlarm2ValueStr"
	 */
	private double lawAlarm2ValueStr;
	
	/**
	 * @uml.property  name="val"
	 */
	private Float val;
	
	/**
	 * @uml.property  name="fidItemCode"
	 */
	private String fidItemCode;
	//2015-11-20 add by In-Con.
	private String drySeasonFromNm;
	
	private String drySeasonToNm;
	
	private double itemDryValueHi;
	
	private double itemDryValueLo;
	//2015-11-20 add by In-Con.
	
	public String getDrySeasonFromNm() {
		return drySeasonFromNm;
	}
	public void setDrySeasonFromNm(String drySeasonFromNm) {
		this.drySeasonFromNm = drySeasonFromNm;
	}
	public String getDrySeasonToNm() {
		return drySeasonToNm;
	}
	public void setDrySeasonToNm(String drySeasonToNm) {
		this.drySeasonToNm = drySeasonToNm;
	}
	public double getItemDryValueHi() {
		return itemDryValueHi;
	}
	public void setItemDryValueHi(double itemDryValueHi) {
		this.itemDryValueHi = itemDryValueHi;
	}
	public double getItemDryValueLo() {
		return itemDryValueLo;
	}
	public void setItemDryValueLo(double itemDryValueLo) {
		this.itemDryValueLo = itemDryValueLo;
	}
	/**
	 * @return
	 * @uml.property  name="fidItemCode"
	 */
	public String getFidItemCode() {
		return fidItemCode;
	}
	/**
	 * @param fidItemCode
	 * @uml.property  name="fidItemCode"
	 */
	public void setFidItemCode(String fidItemCode) {
		this.fidItemCode = fidItemCode;
	}
	/**
	 * @return
	 * @uml.property  name="lawLowValueStr"
	 */
	public double getLawLowValueStr() {
		return lawLowValueStr;
	}
	/**
	 * @param lawLowValueStr
	 * @uml.property  name="lawLowValueStr"
	 */
	public void setLawLowValueStr(double lawLowValueStr) {
		this.lawLowValueStr = lawLowValueStr;
	}
	/**
	 * @return
	 * @uml.property  name="lawAlarm1ValueStr"
	 */
	public double getLawAlarm1ValueStr() {
		return lawAlarm1ValueStr;
	}
	/**
	 * @param lawAlarm1ValueStr
	 * @uml.property  name="lawAlarm1ValueStr"
	 */
	public void setLawAlarm1ValueStr(double lawAlarm1ValueStr) {
		this.lawAlarm1ValueStr = lawAlarm1ValueStr;
	}
	/**
	 * @return
	 * @uml.property  name="lawAlarm2ValueStr"
	 */
	public double getLawAlarm2ValueStr() {
		return lawAlarm2ValueStr;
	}
	/**
	 * @param lawAlarm2ValueStr
	 * @uml.property  name="lawAlarm2ValueStr"
	 */
	public void setLawAlarm2ValueStr(double lawAlarm2ValueStr) {
		this.lawAlarm2ValueStr = lawAlarm2ValueStr;
	}
	/**
	 * @return
	 * @uml.property  name="lawHighValueStr"
	 */
	public double getLawHighValueStr() {
		return lawHighValueStr;
	}
	/**
	 * @param lawHighValueStr
	 * @uml.property  name="lawHighValueStr"
	 */
	public void setLawHighValueStr(double lawHighValueStr) {
		this.lawHighValueStr = lawHighValueStr;
	}
	/**
	 * @return
	 * @uml.property  name="val"
	 */
	public Float getVal() {
		return val;
	}
	/**
	 * @param val
	 * @uml.property  name="val"
	 */
	public void setVal(Float val) {
		this.val = val;
	}
	/**
	 * @return
	 * @uml.property  name="turHVal"
	 */
	public Float getTurHVal() {
		return turHVal;
	}
	/**
	 * @param turHVal
	 * @uml.property  name="turHVal"
	 */
	public void setTurHVal(Float turHVal) {
		this.turHVal = turHVal;
	}
	/**
	 * @return
	 * @uml.property  name="phyHVal"
	 */
	public Float getPhyHVal() {
		return phyHVal;
	}
	/**
	 * @param phyHVal
	 * @uml.property  name="phyHVal"
	 */
	public void setPhyHVal(Float phyHVal) {
		this.phyHVal = phyHVal;
	}
	/**
	 * @return
	 * @uml.property  name="phyLVal"
	 */
	public Float getPhyLVal() {
		return phyLVal;
	}
	/**
	 * @param phyLVal
	 * @uml.property  name="phyLVal"
	 */
	public void setPhyLVal(Float phyLVal) {
		this.phyLVal = phyLVal;
	}
	/**
	 * @return
	 * @uml.property  name="conHVal"
	 */
	public Float getConHVal() {
		return conHVal;
	}
	/**
	 * @param conHVal
	 * @uml.property  name="conHVal"
	 */
	public void setConHVal(Float conHVal) {
		this.conHVal = conHVal;
	}
	/**
	 * @return
	 * @uml.property  name="dowLVal"
	 */
	public Float getDowLVal() {
		return dowLVal;
	}
	/**
	 * @param dowLVal
	 * @uml.property  name="dowLVal"
	 */
	public void setDowLVal(Float dowLVal) {
		this.dowLVal = dowLVal;
	}
	/**
	 * @return
	 * @uml.property  name="lawId"
	 */
	public String getLawId() {
		return lawId;
	}
	/**
	 * @param lawId
	 * @uml.property  name="lawId"
	 */
	public void setLawId(String lawId) {
		this.lawId = lawId;
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
	 * @uml.property  name="itemName"
	 */
	public String getItemName() {
		return itemName;
	}
	/**
	 * @param itemName
	 * @uml.property  name="itemName"
	 */
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	/**
	 * @return
	 * @uml.property  name="lawHighValue"
	 */
	public Float getLawHighValue() {
		return lawHighValue;
	}
	/**
	 * @param lawHighValue
	 * @uml.property  name="lawHighValue"
	 */
	public void setLawHighValue(Float lawHighValue) {
		this.lawHighValue = lawHighValue;
	}
	/**
	 * @return
	 * @uml.property  name="lawLowValue"
	 */
	public Float getLawLowValue() {
		return lawLowValue;
	}
	/**
	 * @param lawLowValue
	 * @uml.property  name="lawLowValue"
	 */
	public void setLawLowValue(Float lawLowValue) {
		this.lawLowValue = lawLowValue;
	}
	/**
	 * @return
	 * @uml.property  name="lawAlarm1Value"
	 */
	public Float getLawAlarm1Value() {
		return lawAlarm1Value;
	}
	/**
	 * @param lawAlarm1Value
	 * @uml.property  name="lawAlarm1Value"
	 */
	public void setLawAlarm1Value(Float lawAlarm1Value) {
		this.lawAlarm1Value = lawAlarm1Value;
	}
	/**
	 * @return
	 * @uml.property  name="lawAlarm2Value"
	 */
	public Float getLawAlarm2Value() {
		return lawAlarm2Value;
	}
	/**
	 * @param lawAlarm2Value
	 * @uml.property  name="lawAlarm2Value"
	 */
	public void setLawAlarm2Value(Float lawAlarm2Value) {
		this.lawAlarm2Value = lawAlarm2Value;
	}
	/**
	 * @return
	 * @uml.property  name="lawApply"
	 */
	public String getLawApply() {
		return lawApply;
	}
	/**
	 * @param lawApply
	 * @uml.property  name="lawApply"
	 */
	public void setLawApply(String lawApply) {
		this.lawApply = lawApply;
	} 
	 
}	
