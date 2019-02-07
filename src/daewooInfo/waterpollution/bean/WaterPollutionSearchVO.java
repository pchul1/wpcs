package daewooInfo.waterpollution.bean;

import java.io.Serializable;

public class WaterPollutionSearchVO extends WaterPollutionVO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * 검색수계
	 * @uml.property  name="searchRiverDiv"
	 */
    private String searchRiverDiv = "";
    
    /**
     * 검색비고
     * @uml.property  name="searchRegKind"
     */
    private String searchRegKind = "";
    
    /**
	 * 검색사고유형
	 * @uml.property  name="searchWpKind"
	 */
    private String searchWpKind = "";
    
    /* 접수/지원 */
    /**
	 * @uml.property  name="searchSupportKind"
	 */
    private String searchSupportKind;
    
    private String searchWpsStep;
    
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
	 * 검색사용여부
	 * @uml.property  name="searchUseYn"
	 */
    private String searchUseYn = "";
    
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
	 * @uml.property  name="num"
	 */
    private String num;

	/**
	 * searchUseYn attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="searchUseYn"
	 */
	public String getSearchUseYn() {
		return searchUseYn;
	}

	/**
	 * searchUseYn attribute 값을 설정한다.
	 * @param searchUseYn  String
	 * @uml.property  name="searchUseYn"
	 */
	public void setSearchUseYn(String searchUseYn) {
		this.searchUseYn = searchUseYn;
	}
	
	/**
	 * @return
	 * @uml.property  name="searchRiverDiv"
	 */
	public String getSearchRiverDiv() {
		return searchRiverDiv;
	}

	/**
	 * @param searchRiverDiv
	 * @uml.property  name="searchRiverDiv"
	 */
	public void setSearchRiverDiv(String searchRiverDiv) {
		this.searchRiverDiv = searchRiverDiv;
	}

	public String getSearchRegKind() {
		return searchRegKind;
	}

	public void setSearchRegKind(String searchRegKind) {
		this.searchRegKind = searchRegKind;
	}

	/**
	 * @return
	 * @uml.property  name="searchWpKind"
	 */
	public String getSearchWpKind() {
		return searchWpKind;
	}

	/**
	 * @param searchWpKind
	 * @uml.property  name="searchWpKind"
	 */
	public void setSearchWpKind(String searchWpKind) {
		this.searchWpKind = searchWpKind;
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

	/**
	 * @param endDate
	 * @uml.property  name="endDate"
	 */
	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	/**
	 * @return
	 * @uml.property  name="endDate"
	 */
	public String getEndDate() {
		return endDate;
	}

	/**
	 * @return
	 * @uml.property  name="num"
	 */
	public String getNum() {
		return num;
	}

	/**
	 * @param num
	 * @uml.property  name="num"
	 */
	public void setNum(String num) {
		this.num = num;
	}

	/**
	 * @return
	 * @uml.property  name="searchSupportKind"
	 */
	public String getSearchSupportKind() {
		return searchSupportKind;
	}
	/**
	 * @param searchSupportKind
	 * @uml.property  name="searchSupportKind"
	 */
	public void setSearchSupportKind(String searchSupportKind) {
		this.searchSupportKind = searchSupportKind;
	}

	public String getSearchWpsStep() {
		return searchWpsStep;
	}

	public void setSearchWpsStep(String searchWpsStep) {
		this.searchWpsStep = searchWpsStep;
	}
}
