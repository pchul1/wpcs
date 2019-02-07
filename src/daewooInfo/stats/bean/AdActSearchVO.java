package daewooInfo.stats.bean;

import java.io.Serializable;

public class AdActSearchVO implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * @uml.property  name="num"
	 */
	private String num = "";
    
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
	 * @uml.property  name="smsContent"
	 */
    private String smsContent;
    /**
	 * @uml.property  name="regId"
	 */
    private String regId;
    /**
	 * @uml.property  name="regName"
	 */
    private String regName;
    /**
	 * @uml.property  name="adActDate"
	 */
    private String adActDate;
    /**
	 * @uml.property  name="factCode"
	 */
    private String factCode;
    /**
	 * @uml.property  name="factName"
	 */
    private String FactName;
    /**
	 * @uml.property  name="branchNo"
	 */
    private String branchNo;
    /**
	 * @uml.property  name="branchName"
	 */
    private String branchName;
    /**
	 * @uml.property  name="riverDiv"
	 */
    private String riverDiv;
    /**
	 * @uml.property  name="riverName"
	 */
    private String riverName;
    /**
	 * @uml.property  name="adActKind"
	 */
    private String adActKind;
    /**
	 * @uml.property  name="sysKind"
	 */
    private String sysKind;
    /**
	 * @uml.property  name="regDate"
	 */
    private String regDate;
    /**
	 * @uml.property  name="statsDiv"
	 */
    private String statsDiv;
    /**
	 * @uml.property  name="kind"
	 */
    private String kind;
    /**
	 * @uml.property  name="statsDate"
	 */
    private String statsDate;
    
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
	 * @return
	 * @uml.property  name="smsContent"
	 */
	public String getSmsContent() {
		return smsContent;
	}

	/**
	 * @param smsContent
	 * @uml.property  name="smsContent"
	 */
	public void setSmsContent(String smsContent) {
		this.smsContent = smsContent;
	}

	/**
	 * @return
	 * @uml.property  name="regId"
	 */
	public String getRegId() {
		return regId;
	}

	/**
	 * @param regId
	 * @uml.property  name="regId"
	 */
	public void setRegId(String regId) {
		this.regId = regId;
	}

	/**
	 * @return
	 * @uml.property  name="regName"
	 */
	public String getRegName() {
		return regName;
	}

	/**
	 * @param regName
	 * @uml.property  name="regName"
	 */
	public void setRegName(String regName) {
		this.regName = regName;
	}

	/**
	 * @return
	 * @uml.property  name="adActDate"
	 */
	public String getAdActDate() {
		return adActDate;
	}

	/**
	 * @param adActDate
	 * @uml.property  name="adActDate"
	 */
	public void setAdActDate(String adActDate) {
		this.adActDate = adActDate;
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
	 * @uml.property  name="factName"
	 */
	public String getFactName() {
		return FactName;
	}

	/**
	 * @param factName
	 * @uml.property  name="factName"
	 */
	public void setFactName(String factName) {
		FactName = factName;
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
	 * @uml.property  name="branchName"
	 */
	public String getBranchName() {
		return branchName;
	}

	/**
	 * @param branchName
	 * @uml.property  name="branchName"
	 */
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}

	/**
	 * @return
	 * @uml.property  name="riverDiv"
	 */
	public String getRiverDiv() {
		return riverDiv;
	}

	/**
	 * @param riverDiv
	 * @uml.property  name="riverDiv"
	 */
	public void setRiverDiv(String riverDiv) {
		this.riverDiv = riverDiv;
	}

	/**
	 * @return
	 * @uml.property  name="riverName"
	 */
	public String getRiverName() {
		return riverName;
	}

	/**
	 * @param riverName
	 * @uml.property  name="riverName"
	 */
	public void setRiverName(String riverName) {
		this.riverName = riverName;
	}

	/**
	 * @return
	 * @uml.property  name="adActKind"
	 */
	public String getAdActKind() {
		return adActKind;
	}

	/**
	 * @param adActKind
	 * @uml.property  name="adActKind"
	 */
	public void setAdActKind(String adActKind) {
		this.adActKind = adActKind;
	}

	/**
	 * @return
	 * @uml.property  name="sysKind"
	 */
	public String getSysKind() {
		return sysKind;
	}

	/**
	 * @param sysKind
	 * @uml.property  name="sysKind"
	 */
	public void setSysKind(String sysKind) {
		this.sysKind = sysKind;
	}

	/**
	 * @return
	 * @uml.property  name="regDate"
	 */
	public String getRegDate() {
		return regDate;
	}

	/**
	 * @param regDate
	 * @uml.property  name="regDate"
	 */
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	/**
	 * @param statsDiv
	 * @uml.property  name="statsDiv"
	 */
	public void setStatsDiv(String statsDiv) {
		this.statsDiv = statsDiv;
	}

	/**
	 * @return
	 * @uml.property  name="statsDiv"
	 */
	public String getStatsDiv() {
		return statsDiv;
	}

	/**
	 * @param kind
	 * @uml.property  name="kind"
	 */
	public void setKind(String kind) {
		this.kind = kind;
	}

	/**
	 * @return
	 * @uml.property  name="kind"
	 */
	public String getKind() {
		return kind;
	}

	/**
	 * @param statsDate
	 * @uml.property  name="statsDate"
	 */
	public void setStatsDate(String statsDate) {
		this.statsDate = statsDate;
	}

	/**
	 * @return
	 * @uml.property  name="statsDate"
	 */
	public String getStatsDate() {
		return statsDate;
	}	
}
