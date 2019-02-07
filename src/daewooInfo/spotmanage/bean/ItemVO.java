package daewooInfo.spotmanage.bean;

import daewooInfo.cmmn.bean.ComDefaultVO;

public class ItemVO extends ComDefaultVO {
	/* 지점 고유 번호 */
	/**
	 * @uml.property  name="factCode"
	 */
	String factCode;
	/**
	 * @uml.property  name="branchNo"
	 */
	String branchNo;
	/* 아이템 고유 번호 */
	/**
	 * @uml.property  name="itemCode"
	 */
	String itemCode;
	/* 아이템이름 */
	/**
	 * @uml.property  name="itemName"
	 */
	String itemName;
	/* 단위 */
	/**
	 * @uml.property  name="itemUnit"
	 */
	String itemUnit;
	/* 유효자리 수 */
	/**
	 * @uml.property  name="valueFormat"
	 */
	String valueFormat;
	/* 사용 미사용  */
	/**
	 * @uml.property  name="useFlag"
	 */
	String useFlag;
	/* system 타입 */
	/**
	 * @uml.property  name="sysType"
	 */
	String sysType;
	
	/**
	 * @return
	 * @uml.property  name="sysType"
	 */
	public String getSysType() {
		return sysType;
	}
	/**
	 * @param sysType
	 * @uml.property  name="sysType"
	 */
	public void setSysType(String sysType) {
		this.sysType = sysType;
	}
	/**
	 * @return
	 * @uml.property  name="useFlag"
	 */
	public String getUseFlag() {
		return useFlag;
	}
	/**
	 * @param useFlag
	 * @uml.property  name="useFlag"
	 */
	public void setUseFlag(String useFlag) {
		this.useFlag = useFlag;
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
	public String getBranchNo() {
		return branchNo;
	}
	/**
	 * @param branchNo
	 * @uml.property  name="branchNo"
	 */
	public void setBranchNo(String branchNo) {
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
	 * @uml.property  name="itemUnit"
	 */
	public String getItemUnit() {
		return itemUnit;
	}
	/**
	 * @param itemUnit
	 * @uml.property  name="itemUnit"
	 */
	public void setItemUnit(String itemUnit) {
		this.itemUnit = itemUnit;
	}
	/**
	 * @return
	 * @uml.property  name="valueFormat"
	 */
	public String getValueFormat() {
		return valueFormat;
	}
	/**
	 * @param valueFormat
	 * @uml.property  name="valueFormat"
	 */
	public void setValueFormat(String valueFormat) {
		this.valueFormat = valueFormat;
	}
	
}
