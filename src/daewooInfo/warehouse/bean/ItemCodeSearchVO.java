package daewooInfo.warehouse.bean;

import java.io.Serializable;

public class ItemCodeSearchVO extends ItemCodeVO implements Serializable{
	
	/**
	 * @uml.property  name="searchUpperGroupCode"
	 */
	private String searchUpperGroupCode = "";
	/**
	 * @uml.property  name="searchGroupCode"
	 */
	private String searchGroupCode      = "";
	/**
	 * @uml.property  name="searchRiverId"
	 */
	private String searchRiverId        = "";
	/**
	 * @uml.property  name="searchWhCode"
	 */
	private String searchWhCode         = "";
	/**
	 * @uml.property  name="searchWhName"
	 */
	private String searchWhName         = "";
	/**
	 * @uml.property  name="searchType"
	 */
	private String searchType           = "";

	/**
	 * 검색조건
	 * @uml.property  name="searchCondition"
	 */
    private String searchCondition = "";
    
    /**
	 * 검색Keyword
	 * @uml.property  name="searchKeyword"
	 */
    private String searchKeyword = "";
    
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
    
    private String searchItemName;
    
    //추가
    private String itemCodeN;
    private String groupCodeN;
    private String upperGroupCodeN;
    private String type1ApplFlagYN;
    private String type2ApplFlagYN;
    private String type3ApplFlagYN;
    private String type4ApplFlagYN;
    private String type5ApplFlagYN;
    private String type6ApplFlagYN;
    private String type7ApplFlagYN;
    private String type8ApplFlagYN;
    private String type9ApplFlagYN;
    private String type10ApplFlagYN;
    private String type11ApplFlagYN;
    private String type12ApplFlagYN;
    private String searchFirstCode;
    private String searchSecondCode;
    private String searchThirdCode;
    private String chkFileId;
    private String fileUploadChk;
    private String imageDel;
    private String itemPurpose;
    private String itemDetail;
    private String itemStockType;
    
    
    public String getImageDel() {
		return imageDel;
	}

	public void setImageDel(String imageDel) {
		this.imageDel = imageDel;
	}

	public String getFileUploadChk() {
		return fileUploadChk;
	}

	public void setFileUploadChk(String fileUploadChk) {
		this.fileUploadChk = fileUploadChk;
	}

	public String getChkFileId() {
		return chkFileId;
	}

	public void setChkFileId(String chkFileId) {
		this.chkFileId = chkFileId;
	}

	public String getSearchFirstCode() {
		return searchFirstCode;
	}

	public void setSearchFirstCode(String searchFirstCode) {
		this.searchFirstCode = searchFirstCode;
	}

	public String getSearchSecondCode() {
		return searchSecondCode;
	}

	public void setSearchSecondCode(String searchSecondCode) {
		this.searchSecondCode = searchSecondCode;
	}

	public String getSearchThirdCode() {
		return searchThirdCode;
	}

	public void setSearchThirdCode(String searchThirdCode) {
		this.searchThirdCode = searchThirdCode;
	}

	private String atchFileId;

	public String getAtchFileId() {
		return atchFileId;
	}

	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}

	public String getType1ApplFlagYN() {
		return type1ApplFlagYN;
	}

	public void setType1ApplFlagYN(String type1ApplFlagYN) {
		this.type1ApplFlagYN = type1ApplFlagYN;
	}

	public String getType2ApplFlagYN() {
		return type2ApplFlagYN;
	}

	public void setType2ApplFlagYN(String type2ApplFlagYN) {
		this.type2ApplFlagYN = type2ApplFlagYN;
	}

	public String getType3ApplFlagYN() {
		return type3ApplFlagYN;
	}

	public void setType3ApplFlagYN(String type3ApplFlagYN) {
		this.type3ApplFlagYN = type3ApplFlagYN;
	}

	public String getType4ApplFlagYN() {
		return type4ApplFlagYN;
	}

	public void setType4ApplFlagYN(String type4ApplFlagYN) {
		this.type4ApplFlagYN = type4ApplFlagYN;
	}

	public String getType5ApplFlagYN() {
		return type5ApplFlagYN;
	}

	public void setType5ApplFlagYN(String type5ApplFlagYN) {
		this.type5ApplFlagYN = type5ApplFlagYN;
	}

	public String getType6ApplFlagYN() {
		return type6ApplFlagYN;
	}

	public void setType6ApplFlagYN(String type6ApplFlagYN) {
		this.type6ApplFlagYN = type6ApplFlagYN;
	}

	public String getType7ApplFlagYN() {
		return type7ApplFlagYN;
	}

	public void setType7ApplFlagYN(String type7ApplFlagYN) {
		this.type7ApplFlagYN = type7ApplFlagYN;
	}

	public String getType8ApplFlagYN() {
		return type8ApplFlagYN;
	}

	public void setType8ApplFlagYN(String type8ApplFlagYN) {
		this.type8ApplFlagYN = type8ApplFlagYN;
	}

	public String getType9ApplFlagYN() {
		return type9ApplFlagYN;
	}

	public void setType9ApplFlagYN(String type9ApplFlagYN) {
		this.type9ApplFlagYN = type9ApplFlagYN;
	}

	public String getType10ApplFlagYN() {
		return type10ApplFlagYN;
	}

	public void setType10ApplFlagYN(String type10ApplFlagYN) {
		this.type10ApplFlagYN = type10ApplFlagYN;
	}

	public String getType11ApplFlagYN() {
		return type11ApplFlagYN;
	}

	public void setType11ApplFlagYN(String type11ApplFlagYN) {
		this.type11ApplFlagYN = type11ApplFlagYN;
	}

	public String getType12ApplFlagYN() {
		return type12ApplFlagYN;
	}

	public void setType12ApplFlagYN(String type12ApplFlagYN) {
		this.type12ApplFlagYN = type12ApplFlagYN;
	}

	public String getItemCodeN() {
		return itemCodeN;
	}

	public void setItemCodeN(String itemCodeN) {
		this.itemCodeN = itemCodeN;
	}

	public String getGroupCodeN() {
		return groupCodeN;
	}

	public void setGroupCodeN(String groupCodeN) {
		this.groupCodeN = groupCodeN;
	}

	public String getUpperGroupCodeN() {
		return upperGroupCodeN;
	}

	public void setUpperGroupCodeN(String upperGroupCodeN) {
		this.upperGroupCodeN = upperGroupCodeN;
	}

	/**
	 * searchCondition attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="searchCondition"
	 */
	public String getSearchCondition() {
		return searchCondition;
	}

	/**
	 * searchCondition attribute 값을 설정한다.
	 * @param searchCondition  String
	 * @uml.property  name="searchCondition"
	 */
	public void setSearchCondition(String searchCondition) {
		this.searchCondition = searchCondition;
	}

	/**
	 * searchKeyword attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="searchKeyword"
	 */
	public String getSearchKeyword() {
		return searchKeyword;
	}

	/**
	 * searchKeyword attribute 값을 설정한다.
	 * @param searchKeyword  String
	 * @uml.property  name="searchKeyword"
	 */
	public void setSearchKeyword(String searchKeyword) {
		this.searchKeyword = searchKeyword;
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
	 * @uml.property  name="searchUpperGroupCode"
	 */
	public String getSearchUpperGroupCode() {
		return searchUpperGroupCode;
	}

	/**
	 * @param searchUpperGroupCode
	 * @uml.property  name="searchUpperGroupCode"
	 */
	public void setSearchUpperGroupCode(String searchUpperGroupCode) {
		this.searchUpperGroupCode = searchUpperGroupCode;
	}

	/**
	 * @return
	 * @uml.property  name="searchGroupCode"
	 */
	public String getSearchGroupCode() {
		return searchGroupCode;
	}

	/**
	 * @param searchGroupCode
	 * @uml.property  name="searchGroupCode"
	 */
	public void setSearchGroupCode(String searchGroupCode) {
		this.searchGroupCode = searchGroupCode;
	}

	/**
	 * @return
	 * @uml.property  name="searchRiverId"
	 */
	public String getSearchRiverId() {
		return searchRiverId;
	}

	/**
	 * @param searchRiverId
	 * @uml.property  name="searchRiverId"
	 */
	public void setSearchRiverId(String searchRiverId) {
		this.searchRiverId = searchRiverId;
	}

	/**
	 * @return
	 * @uml.property  name="searchWhCode"
	 */
	public String getSearchWhCode() {
		return searchWhCode;
	}

	/**
	 * @param searchWhCode
	 * @uml.property  name="searchWhCode"
	 */
	public void setSearchWhCode(String searchWhCode) {
		this.searchWhCode = searchWhCode;
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
	 * @uml.property  name="searchWhName"
	 */
	public String getSearchWhName() {
		return searchWhName;
	}

	/**
	 * @param searchWhName
	 * @uml.property  name="searchWhName"
	 */
	public void setSearchWhName(String searchWhName) {
		this.searchWhName = searchWhName;
	}

	public String getSearchItemName() {
		return searchItemName;
	}

	public void setSearchItemName(String searchItemName) {
		this.searchItemName = searchItemName;
	}

	public String getItemPurpose() {
		return itemPurpose;
	}

	public void setItemPurpose(String itemPurpose) {
		this.itemPurpose = itemPurpose;
	}

	public String getItemDetail() {
		return itemDetail;
	}

	public void setItemDetail(String itemDetail) {
		this.itemDetail = itemDetail;
	}

	public String getItemStockType() {
		return itemStockType;
	}

	public void setItemStockType(String itemStockType) {
		this.itemStockType = itemStockType;
	}
	
	
}