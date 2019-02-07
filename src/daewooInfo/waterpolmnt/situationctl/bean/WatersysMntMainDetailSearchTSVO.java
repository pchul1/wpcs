package daewooInfo.waterpolmnt.situationctl.bean;


/**
 * @author DaeWoo Information Systems Co., Ltd.  Technical Expert Team. loafzzang.
 * @version 1.0
 * @Class Name : SearchVO.java
 * @Description :  Class
 * @Modification Information
 * @
 * @ Modify Date		author			Modify Contents
 * @ --------------		------------	-------------------------------
 * @ 2010. 1. 27		loafzzang		new
 * @see Copyright (C) by DaeWoo Information Systems Co., Ltd. All right reserved.
 * @since 2010. 1. 27
 */
public class WatersysMntMainDetailSearchTSVO {
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
	 * @uml.property  name="branch_name"
	 */
	private String branch_name;
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
	 * @uml.property  name="sys_kind"
	 */
	private String sys_kind;
	/**
	 * @uml.property  name="isNext"
	 */
	private String isNext;
	
	/**
	 * @uml.property  name="frDate"
	 */
	private String frDate;
	/**
	 * @uml.property  name="toDate"
	 */
	private String toDate;
	/**
	 * @uml.property  name="frTime"
	 */
	private String frTime;
	/**
	 * @uml.property  name="toTime"
	 */
	private String toTime;
	
	/**
	 * @uml.property  name="nextFactCode"
	 */
	private String nextFactCode;
	/**
	 * @uml.property  name="curFactCode"
	 */
	private String curFactCode;
	/**
	 * @uml.property  name="beforeFactCode"
	 */
	private String beforeFactCode;
	
	/**
	 * @uml.property  name="nextBranchNo"
	 */
	private String nextBranchNo;
	/**
	 * @uml.property  name="curBranchNo"
	 */
	private String curBranchNo;
	/**
	 * @uml.property  name="beforeBranchNo"
	 */
	private String nearAll;
	
	private String sugye;
	
	private String beforeBranchNo;
	
	private String branch;
	
	private String auto;
	
	private String time_type;
	
	private String item_code;
	
	//2014-10-21 mypark 페이징 추가
	/**
	 * 현재페이지
	 * @uml.property  name="pageIndex"
	 */
	private int pageIndex = 1;

	/**
	 * 페이지갯수
	 * @uml.property  name="pageUnit"
	 */
	private int pageUnit = 20;

	/**
	 * 페이지사이즈
	 * @uml.property  name="pageSize"
	 */
	private int pageSize = 10;

	/**
	 * 첫페이지 인덱스
	 * @uml.property  name="firstIndex"
	 */
	private int firstIndex = 1;

	/**
	 * 마지막페이지 인덱스
	 * @uml.property  name="lastIndex"
	 */
	private int lastIndex = 1;

	/**
	 * 페이지당 레코드 개수
	 * @uml.property  name="recordCountPerPage"
	 */
	private int recordCountPerPage = 10;
	
	/**
	 * @return
	 * @uml.property  name="nextFactCode"
	 */
	public String getNextFactCode() {
		return nextFactCode;
	}
	/**
	 * @param nextFactCode
	 * @uml.property  name="nextFactCode"
	 */
	public void setNextFactCode(String nextFactCode) {
		this.nextFactCode = nextFactCode;
	}
	/**
	 * @return
	 * @uml.property  name="curFactCode"
	 */
	public String getCurFactCode() {
		return curFactCode;
	}
	/**
	 * @param curFactCode
	 * @uml.property  name="curFactCode"
	 */
	public void setCurFactCode(String curFactCode) {
		this.curFactCode = curFactCode;
	}
	/**
	 * @return
	 * @uml.property  name="beforeFactCode"
	 */
	public String getBeforeFactCode() {
		return beforeFactCode;
	}
	/**
	 * @param beforeFactCode
	 * @uml.property  name="beforeFactCode"
	 */
	public void setBeforeFactCode(String beforeFactCode) {
		this.beforeFactCode = beforeFactCode;
	}
	/**
	 * @return
	 * @uml.property  name="nextBranchNo"
	 */
	public String getNextBranchNo() {
		return nextBranchNo;
	}
	/**
	 * @param nextBranchNo
	 * @uml.property  name="nextBranchNo"
	 */
	public void setNextBranchNo(String nextBranchNo) {
		this.nextBranchNo = nextBranchNo;
	}
	/**
	 * @return
	 * @uml.property  name="curBranchNo"
	 */
	public String getCurBranchNo() {
		return curBranchNo;
	}
	/**
	 * @param curBranchNo
	 * @uml.property  name="curBranchNo"
	 */
	public void setCurBranchNo(String curBranchNo) {
		this.curBranchNo = curBranchNo;
	}
	/**
	 * @return
	 * @uml.property  name="beforeBranchNo"
	 */
	public String getBeforeBranchNo() {
		return beforeBranchNo;
	}
	/**
	 * @param beforeBranchNo
	 * @uml.property  name="beforeBranchNo"
	 */
	public void setBeforeBranchNo(String beforeBranchNo) {
		this.beforeBranchNo = beforeBranchNo;
	}
	/**
	 * @return
	 * @uml.property  name="frDate"
	 */
	public String getFrDate() {
		return frDate;
	}
	/**
	 * @param frDate
	 * @uml.property  name="frDate"
	 */
	public void setFrDate(String frDate) {
		this.frDate = frDate;
	}
	/**
	 * @return
	 * @uml.property  name="toDate"
	 */
	public String getToDate() {
		return toDate;
	}
	/**
	 * @param toDate
	 * @uml.property  name="toDate"
	 */
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	/**
	 * @return
	 * @uml.property  name="frTime"
	 */
	public String getFrTime() {
		return frTime;
	}
	/**
	 * @param frTime
	 * @uml.property  name="frTime"
	 */
	public void setFrTime(String frTime) {
		this.frTime = frTime;
	}
	/**
	 * @return
	 * @uml.property  name="toTime"
	 */
	public String getToTime() {
		return toTime;
	}
	/**
	 * @param toTime
	 * @uml.property  name="toTime"
	 */
	public void setToTime(String toTime) {
		this.toTime = toTime;
	}
	/**
	 * @return
	 * @uml.property  name="branch_name"
	 */
	public String getBranch_name() {
		return branch_name;
	}
	/**
	 * @param branch_name
	 * @uml.property  name="branch_name"
	 */
	public void setBranch_name(String branch_name) {
		this.branch_name = branch_name;
	}
	/**
	 * @return
	 * @uml.property  name="sys_kind"
	 */
	public String getSys_kind() {
		return sys_kind;
	}
	/**
	 * @param sys_kind
	 * @uml.property  name="sys_kind"
	 */
	public void setSys_kind(String sys_kind) {
		this.sys_kind = sys_kind;
	}
	/**
	 * @return
	 * @uml.property  name="isNext"
	 */
	public String getIsNext() {
		return isNext;
	}
	/**
	 * @param isNext
	 * @uml.property  name="isNext"
	 */
	public void setIsNext(String isNext) {
		this.isNext = isNext;
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
	public String getSugye() {
		return sugye;
	}
	public void setSugye(String sugye) {
		this.sugye = sugye;
	}
	public String getBranch() {
		return branch;
	}
	public void setBranch(String branch) {
		this.branch = branch;
	}
	public String getAuto() {
		return auto;
	}
	public void setAuto(String auto) {
		this.auto = auto;
	}
	public String getTime_type() {
		return time_type;
	}
	public void setTime_type(String time_type) {
		this.time_type = time_type;
	}
	public String getItem_code() {
		return item_code;
	}
	public void setItem_code(String item_code) {
		this.item_code = item_code;
	}
	/**
	 * @return the pageIndex
	 */
	public int getPageIndex() {
		return pageIndex;
	}
	/**
	 * @param pageIndex the pageIndex to set
	 */
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}
	/**
	 * @return the pageUnit
	 */
	public int getPageUnit() {
		return pageUnit;
	}
	/**
	 * @param pageUnit the pageUnit to set
	 */
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}
	/**
	 * @return the pageSize
	 */
	public int getPageSize() {
		return pageSize;
	}
	/**
	 * @param pageSize the pageSize to set
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	/**
	 * @return the firstIndex
	 */
	public int getFirstIndex() {
		return firstIndex;
	}
	/**
	 * @param firstIndex the firstIndex to set
	 */
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}
	/**
	 * @return the lastIndex
	 */
	public int getLastIndex() {
		return lastIndex;
	}
	/**
	 * @param lastIndex the lastIndex to set
	 */
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}
	/**
	 * @return the recordCountPerPage
	 */
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}
	/**
	 * @param recordCountPerPage the recordCountPerPage to set
	 */
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}
	public String getNearAll() {
		return nearAll;
	}
	public void setNearAll(String nearAll) {
		this.nearAll = nearAll;
	}
}