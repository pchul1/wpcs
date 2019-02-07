package daewooInfo.waterpolmnt.waterinfo.bean;

import java.io.Serializable;

public class CmnSearchVO implements Serializable{
	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * @uml.property  name="sId"
	 */
	private String sId;
	/**
	 * @uml.property  name="searchType"
	 */
	private String searchType;
    /**
	 * @uml.property  name="sugye"
	 */
    private String sugye;
    /**
	 * @uml.property  name="dctype"
	 */
    private String dctype;
    /**
	 * @uml.property  name="searchKeyword"
	 */
    private String searchKeyword;
    /**
	 * @uml.property  name="basinLarge"
	 */
    private String basinLarge;
    /**
	 * @uml.property  name="sDoCode"
	 */
    private String sDoCode;
    /**
	 * @uml.property  name="sCtyCode"
	 */
    private String sCtyCode;
    /**
	 * @uml.property  name="sEcompanyId"
	 */
    private String sEcompanyId;
    
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
	 * @uml.property  name="num"
	 */
    private String num;

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
	 * @uml.property  name="sId"
	 */
	public String getsId() {
		return sId;
	}

	/**
	 * @param sId
	 * @uml.property  name="sId"
	 */
	public void setsId(String sId) {
		this.sId = sId;
	}

	/**
	 * @return
	 * @uml.property  name="searchType"
	 */
	public String getSearchType() {
		return searchType;
	}

	/**
	 * @param searchType
	 * @uml.property  name="searchType"
	 */
	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	/**
	 * @return
	 * @uml.property  name="sugye"
	 */
	public String getSugye() {
		return sugye;
	}

	/**
	 * @param sugye
	 * @uml.property  name="sugye"
	 */
	public void setSugye(String sugye) {
		this.sugye = sugye;
	}
	

	/**
	 * @return
	 * @uml.property  name="dctype"
	 */
	public String getDctype() {
		return dctype;
	}

	/**
	 * @param dctype
	 * @uml.property  name="dctype"
	 */
	public void setDctype(String dctype) {
		this.dctype = dctype;
	}

	/**
	 * @return
	 * @uml.property  name="searchKeyword"
	 */
	public String getSearchKeyword() {
		return searchKeyword;
	}

	/**
	 * @param searchKeyword
	 * @uml.property  name="searchKeyword"
	 */
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
	}

	/**
	 * @return
	 * @uml.property  name="basinLarge"
	 */
	public String getBasinLarge() {
		return basinLarge;
	}

	/**
	 * @param basinLarge
	 * @uml.property  name="basinLarge"
	 */
	public void setBasinLarge(String basinLarge) {
		this.basinLarge = basinLarge;
	}

	/**
	 * @return
	 * @uml.property  name="sDoCode"
	 */
	public String getsDoCode() {
		return sDoCode;
	}

	/**
	 * @param sDoCode
	 * @uml.property  name="sDoCode"
	 */
	public void setsDoCode(String sDoCode) {
		this.sDoCode = sDoCode;
	}

	/**
	 * @return
	 * @uml.property  name="sCtyCode"
	 */
	public String getsCtyCode() {
		return sCtyCode;
	}

	/**
	 * @param sCtyCode
	 * @uml.property  name="sCtyCode"
	 */
	public void setsCtyCode(String sCtyCode) {
		this.sCtyCode = sCtyCode;
	}

	/**
	 * @return
	 * @uml.property  name="sEcompanyId"
	 */
	public String getsEcompanyId() {
		return sEcompanyId;
	}

	/**
	 * @param sEcompanyId
	 * @uml.property  name="sEcompanyId"
	 */
	public void setsEcompanyId(String sEcompanyId) {
		this.sEcompanyId = sEcompanyId;
	}
}
