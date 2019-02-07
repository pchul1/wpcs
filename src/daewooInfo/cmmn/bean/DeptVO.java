package daewooInfo.cmmn.bean;

import java.io.Serializable;

public class DeptVO implements Serializable {
	
	
	private String deptNo;
	private String upperDeptNo;
	/**
	 * @uml.property  name="deptNo"
	 */
	private String deptCode;
	/**
	 * @uml.property  name="deptName"
	 */
	private String deptName;
	/**
	 * @uml.property  name="deptDesc"
	 */
	private String deptDesc;
	/**
	 * @uml.property  name="upperDeptNo"
	 */
	private String upperDeptCode;
	/**
	 * @uml.property  name="childCnt"
	 */
	private String childCnt;
	/**
	 * @return
	 * @uml.property  name="deptName"
	 */
	public String getDeptName() {
		return deptName;
	}
	/**
	 * @param deptName
	 * @uml.property  name="deptName"
	 */
	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}
	/**
	 * @return
	 * @uml.property  name="deptDesc"
	 */
	public String getDeptDesc() {
		return deptDesc;
	}
	/**
	 * @param deptDesc
	 * @uml.property  name="deptDesc"
	 */
	public void setDeptDesc(String deptDesc) {
		this.deptDesc = deptDesc;
	}
	/**
	 * @return
	 * @uml.property  name="childCnt"
	 */
	public String getChildCnt() {
		return childCnt;
	}
	/**
	 * @param childCnt
	 * @uml.property  name="childCnt"
	 */
	public void setChildCnt(String childCnt) {
		this.childCnt = childCnt;
	}
	public String getDeptCode() {
		return deptCode;
	}
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}
	public String getUpperDeptCode() {
		return upperDeptCode;
	}
	public void setUpperDeptCode(String upperDeptCode) {
		this.upperDeptCode = upperDeptCode;
	}
	public String getDeptNo() {
		return deptNo;
	}
	public void setDeptNo(String deptNo) {
		this.deptNo = deptNo;
	}
	public String getUpperDeptNo() {
		return upperDeptNo;
	}
	public void setUpperDeptNo(String upperDeptNo) {
		this.upperDeptNo = upperDeptNo;
	}
}
