package daewooInfo.warehouse.bean;

import java.io.Serializable;

public class SearchVO implements Serializable {
	
	/**
	 * @uml.property  name="whCode"
	 */
	private String whCode;
	/**
	 * @uml.property  name="itemCode"
	 */
	private String itemCode;
	/**
	 * @uml.property  name="itemCodeDet"
	 */
	private String itemCodeDet;
	/**
	 * @uml.property  name="startDate"
	 */
	private String itemCodeNum;
	
	private String startDate;
	/**
	 * @uml.property  name="endDate"
	 */
	private String endDate;
	
	/**
	 * @return
	 * @uml.property  name="whCode"
	 */
	public String getWhCode() {
		return whCode;
	}
	/**
	 * @param whCode
	 * @uml.property  name="whCode"
	 */
	public void setWhCode(String whCode) {
		this.whCode = whCode;
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
	 * @uml.property  name="itemCodeDet"
	 */
	public String getItemCodeDet() {
		return itemCodeDet;
	}
	/**
	 * @param itemCodeDet
	 * @uml.property  name="itemCodeDet"
	 */
	public void setItemCodeDet(String itemCodeDet) {
		this.itemCodeDet = itemCodeDet;
	}
	/**
	 * @return
	 * @uml.property  name="startDate"
	 */
	public String getStartDate() {
		return startDate;
	}
	/**
	 * @param startDate
	 * @uml.property  name="startDate"
	 */
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	/**
	 * @return
	 * @uml.property  name="endDate"
	 */
	public String getEndDate() {
		return endDate;
	}
	/**
	 * @param endDate
	 * @uml.property  name="endDate"
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	public String getItemCodeNum() {
		return itemCodeNum;
	}
	public void setItemCodeNum(String itemCodeNum) {
		this.itemCodeNum = itemCodeNum;
	}
	
	
}
