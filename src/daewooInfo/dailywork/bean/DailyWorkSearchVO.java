package daewooInfo.dailywork.bean;

import java.io.Serializable;

public class DailyWorkSearchVO extends DailyWorkVO implements Serializable{
	
    /**
	 * 현재페이지
	 * @uml.property  name="pageIndex"
	 */
    private int pageIndex = 1;
    
    /**
	 * 페이지갯수
	 * @uml.property  name="pageUnit"
	 */
    private int pageUnit = 10;
    
    /**
	 * 페이지사이즈
	 * @uml.property  name="pageSize"
	 */
    private int pageSize = 10;

    /**
	 * firstIndex
	 * @uml.property  name="firstIndex"
	 */
    private int firstIndex = 1;

    /**
	 * lastIndex
	 * @uml.property  name="lastIndex"
	 */
    private int lastIndex = 1;

    /**
	 * recordCountPerPage
	 * @uml.property  name="recordCountPerPage"
	 */
    private int recordCountPerPage = 10;
    
	/**
	 * 검색기간
	 * @uml.property  name="startDate"
	 */
    private String startDate = "";
    /**
	 * @uml.property  name="endDate"
	 */
    private String endDate   = "";
    
    /**
	 * 검색 상태
	 * @uml.property  name="searchStatus"
	 */
    private String searchState = "";
    
    private String searchGubun = "";
    
    private String searchCnd = "";
    
    private String searchWrd = "";
    
    private String userId = "";
	
    private String roleCode = "";
    
    private String deptNo = "";
    
    
	/**
	 * pageIndex attribute 를 리턴한다.
	 * @return  int
	 * @uml.property  name="pageIndex"
	 */
	public int getPageIndex() {
		return pageIndex;
	}

	/**
	 * pageIndex attribute 값을 설정한다.
	 * @param pageIndex  int
	 * @uml.property  name="pageIndex"
	 */
	public void setPageIndex(int pageIndex) {
		this.pageIndex = pageIndex;
	}

	/**
	 * pageUnit attribute 를 리턴한다.
	 * @return  int
	 * @uml.property  name="pageUnit"
	 */
	public int getPageUnit() {
		return pageUnit;
	}

	/**
	 * pageUnit attribute 값을 설정한다.
	 * @param pageUnit  int
	 * @uml.property  name="pageUnit"
	 */
	public void setPageUnit(int pageUnit) {
		this.pageUnit = pageUnit;
	}

	/**
	 * pageSize attribute 를 리턴한다.
	 * @return  int
	 * @uml.property  name="pageSize"
	 */
	public int getPageSize() {
		return pageSize;
	}

	/**
	 * pageSize attribute 값을 설정한다.
	 * @param pageSize  int
	 * @uml.property  name="pageSize"
	 */
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}

	/**
	 * firstIndex attribute 를 리턴한다.
	 * @return  int
	 * @uml.property  name="firstIndex"
	 */
	public int getFirstIndex() {
		return firstIndex;
	}

	/**
	 * firstIndex attribute 값을 설정한다.
	 * @param firstIndex  int
	 * @uml.property  name="firstIndex"
	 */
	public void setFirstIndex(int firstIndex) {
		this.firstIndex = firstIndex;
	}

	/**
	 * lastIndex attribute 를 리턴한다.
	 * @return  int
	 * @uml.property  name="lastIndex"
	 */
	public int getLastIndex() {
		return lastIndex;
	}

	/**
	 * lastIndex attribute 값을 설정한다.
	 * @param lastIndex  int
	 * @uml.property  name="lastIndex"
	 */
	public void setLastIndex(int lastIndex) {
		this.lastIndex = lastIndex;
	}

	/**
	 * recordCountPerPage attribute 를 리턴한다.
	 * @return  int
	 * @uml.property  name="recordCountPerPage"
	 */
	public int getRecordCountPerPage() {
		return recordCountPerPage;
	}

	/**
	 * recordCountPerPage attribute 값을 설정한다.
	 * @param recordCountPerPage  int
	 * @uml.property  name="recordCountPerPage"
	 */
	public void setRecordCountPerPage(int recordCountPerPage) {
		this.recordCountPerPage = recordCountPerPage;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getSearchState() {
		return searchState;
	}

	public void setSearchState(String searchState) {
		this.searchState = searchState;
	}

	public String getSearchGubun() {
		return searchGubun;
	}

	public void setSearchGubun(String searchGubun) {
		this.searchGubun = searchGubun;
	}

	public String getSearchCnd() {
		return searchCnd;
	}

	public void setSearchCnd(String searchCnd) {
		this.searchCnd = searchCnd;
	}

	public String getSearchWrd() {
		return searchWrd;
	}

	public void setSearchWrd(String searchWrd) {
		this.searchWrd = searchWrd;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getRoleCode() {
		return roleCode;
	}

	public void setRoleCode(String roleCode) {
		this.roleCode = roleCode;
	}

	public String getDeptNo() {
		return deptNo;
	}

	public void setDeptNo(String deptNo) {
		this.deptNo = deptNo;
	}

	
	
}
