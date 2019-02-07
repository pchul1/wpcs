package daewooInfo.admin.dept.bean;

/**
 * 부서관리, 부서 생성을 위한 모델 클래스를 정의한다.
 * @author kisspa
 * @since 2010.07.19
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 * 2010.07.19  kisspa          최초 생성
 *
 * </pre>
 */

public class DeptManageVO {
	
	/**
	 * @uml.property  name="deptNo"
	 */
	private int deptCode;
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
	private int upperDeptCode;
	/**
	 * @uml.property  name="deptOrder"
	 */
	private int deptSort;
	/**
	 * @uml.property  name="useFlag"
	 */
	private String useFlag;
	
	private String doCode;
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
	public int getUpperDeptCode() {
		return upperDeptCode;
	}
	public void setUpperDeptCode(int upperDeptCode) {
		this.upperDeptCode = upperDeptCode;
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
	public int getDeptCode() {
		return deptCode;
	}
	public void setDeptCode(int deptCode) {
		this.deptCode = deptCode;
	}
	public int getDeptSort() {
		return deptSort;
	}
	public void setDeptSort(int deptSort) {
		this.deptSort = deptSort;
	}
	public String getDoCode() {
		return doCode;
	}
	public void setDoCode(String doCode) {
		this.doCode = doCode;
	}
}