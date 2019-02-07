package daewooInfo.seminar.bean;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;


/**
 * 게시물 검색을 위한 VO 클래스
 * @author mypark
 * @since 2014.09.22
 * @version 1.0
 * @see
 */
@SuppressWarnings("serial")
public class SeminarSearchVO extends SeminarVO implements Serializable {

	/**
	 * 검색시작일
	 * @uml.property  name="searchBgnDe"
	 */
	private String searchBgnDe = "";
	
	/**
	 * 검색조건
	 * @uml.property  name="searchCnd"
	 */
	private String searchCnd = "";
	
	/**
	 * 검색종료일
	 * @uml.property  name="searchEndDe"
	 */
	private String searchEndDe = "";
	
	/**
	 * 검색단어
	 * @uml.property  name="searchWrd"
	 */
	private String searchWrd = "";
	
	/**
	 * 검색조건(상태)
	 * @uml.property  name="searchStatus"
	 */
	private String searchStatus = "";
	
	/**
	 * 검색조건(구분)
	 * @uml.property  name="searchGubun"
	 */
	private String searchGubun = "";

	/**
	 * 정렬순서(DESC,ASC)
	 * @uml.property  name="sortOrdr"
	 */
	private long sortOrdr = 0L;

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
	 * 레코드 번호
	 * @uml.property  name="rowNo"
	 */
	private int rowNo = 0;

	/**
	 * 최초 등록자명
	 * @uml.property  name="frstRegisterNm"
	 */
	private String frstRegisterNm = "";

	/**
	 * 최종 수정자명
	 * @uml.property  name="lastUpdusrNm"
	 */
	private String lastUpdusrNm = "";

	/**
	 * 유효여부
	 * @uml.property  name="isExpired"
	 */
	private String isExpired = "N";

	/**
	 * 상위 정렬 순서
	 * @uml.property  name="parntsSortOrdr"
	 */
	private String parntsSortOrdr = "";

	/**
	 * 파일첨부가능여부
	 * @uml.property  name="fileAtchPosblAt"
	 */
	private String fileAtchPosblAt = "";
	
	/**
	 * 첨부가능파일숫자
	 * @uml.property  name="posblAtchFileNumber"
	 */
	private int posblAtchFileNumber = 0;
	
	/**
	 * 조회 수 증가 여부
	 * @uml.property  name="plusCount"
	 */
	private boolean plusCount = false;

	/**
	 * 검색조건(마감여부)
	 * @uml.property  name="searchClosingState"
	 */
	private String searchClosingState = "";	
	
	/**
	 * 검색조건(링크)
	 */
	private String urlStr = "";
	
	/**
	 * 검색조건(모드)
	 */
	private String mode = "";
	
	/**
	 * 검색년월(시작)
	 * @uml.property  name="searchYmBgn"
	 */
	private String searchYmBgn = "";
	
	/**
	 * 검색년월(끝)
	 * @uml.property  name="searchYmEnd"
	 */
	private String searchYmEnd = "";
	
	/**
	 * 검색년도
	 * @uml.property  name="searchYear"
	 */
	private String searchYear = "";
	
	/**
	 * 검색월
	 * @uml.property  name="searchMonth"
	 */
	private String searchMonth = "";
	
	/**
	 * 로그인 유저의 소속 정보
	 * @uml.property  name="searchDept"
	 */
	private String searchDept = "";
	
	/**
	 * 검색(소속 정보 코드)
	 * @uml.property  name="searchDeptId"
	 */
	private String searchDeptId = "";
	
	/**
	 * 검색(회원 ID)
	 * @uml.property  name="searchMemId"
	 */
	private String searchMemId = "";
	
	/**
	 * 검색(교육 ID)
	 * @uml.property  name="searchSeminarId"
	 */
	private String searchSeminarId = "";
	
	/**
	 * 검색(업데이트용 신청상태)
	 * @uml.property  name="searchUClosingState"
	 */
	private String searchUClosingState = "";
	
	/**
	 * searchBgnDe attribute를 리턴한다.
	 * @return  the searchBgnDe
	 * @uml.property  name="searchBgnDe"
	 */
	public String getSearchBgnDe() {
		return searchBgnDe;
	}

	/**
	 * searchBgnDe attribute 값을 설정한다.
	 * @param searchBgnDe  the searchBgnDe to set
	 * @uml.property  name="searchBgnDe"
	 */
	public void setSearchBgnDe(String searchBgnDe) {
		this.searchBgnDe = searchBgnDe;
	}

	/**
	 * searchCnd attribute를 리턴한다.
	 * @return  the searchCnd
	 * @uml.property  name="searchCnd"
	 */
	public String getSearchCnd() {
		return searchCnd;
	}

	/**
	 * searchCnd attribute 값을 설정한다.
	 * @param searchCnd  the searchCnd to set
	 * @uml.property  name="searchCnd"
	 */
	public void setSearchCnd(String searchCnd) {
		this.searchCnd = searchCnd;
	}

	/**
	 * searchEndDe attribute를 리턴한다.
	 * @return  the searchEndDe
	 * @uml.property  name="searchEndDe"
	 */
	public String getSearchEndDe() {
		return searchEndDe;
	}

	/**
	 * searchEndDe attribute 값을 설정한다.
	 * @param searchEndDe  the searchEndDe to set
	 * @uml.property  name="searchEndDe"
	 */
	public void setSearchEndDe(String searchEndDe) {
		this.searchEndDe = searchEndDe;
	}

	/**
	 * searchWrd attribute를 리턴한다.
	 * @return  the searchWrd
	 * @uml.property  name="searchWrd"
	 */
	public String getSearchWrd() {
		return searchWrd;
	}

	/**
	 * searchWrd attribute 값을 설정한다.
	 * @param searchWrd  the searchWrd to set
	 * @uml.property  name="searchWrd"
	 */
	public void setSearchWrd(String searchWrd) {
		this.searchWrd = searchWrd;
	}

	/**
	 * @return the searchStatus
	 */
	public String getSearchStatus() {
		return searchStatus;
	}

	/**
	 * @param searchStatus the searchStatus to set
	 */
	public void setSearchStatus(String searchStatus) {
		this.searchStatus = searchStatus;
	}	
	
	/**
	 * @return the searchGubun
	 */
	public String getSearchGubun() {
		return searchGubun;
	}

	/**
	 * @param searchGubun the searchGubun to set
	 */
	public void setSearchGubun(String searchGubun) {
		this.searchGubun = searchGubun;
	}

	/**
	 * sortOrdr attribute를 리턴한다.
	 * @return  the sortOrdr
	 * @uml.property  name="sortOrdr"
	 */
	public long getSortOrdr() {
	return sortOrdr;
	}

	/**
	 * sortOrdr attribute 값을 설정한다.
	 * @param sortOrdr  the sortOrdr to set
	 * @uml.property  name="sortOrdr"
	 */
	public void setSortOrdr(long sortOrdr) {
	this.sortOrdr = sortOrdr;
	}

	/**
	 * searchUseYn attribute를 리턴한다.
	 * @return  the searchUseYn
	 * @uml.property  name="searchUseYn"
	 */
	public String getSearchUseYn() {
	return searchUseYn;
	}

	/**
	 * searchUseYn attribute 값을 설정한다.
	 * @param searchUseYn  the searchUseYn to set
	 * @uml.property  name="searchUseYn"
	 */
	public void setSearchUseYn(String searchUseYn) {
	this.searchUseYn = searchUseYn;
	}

	/**
	 * pageIndex attribute를 리턴한다.
	 * @return  the pageIndex
	 * @uml.property  name="pageIndex"
	 */
	public int getPageIndex() {
	return pageIndex;
	}

	/**
	 * pageIndex attribute 값을 설정한다.
	 * @param pageIndex  the pageIndex to set
	 * @uml.property  name="pageIndex"
	 */
	public void setPageIndex(int pageIndex) {
	this.pageIndex = pageIndex;
	}

	/**
	 * pageUnit attribute를 리턴한다.
	 * @return  the pageUnit
	 * @uml.property  name="pageUnit"
	 */
	public int getPageUnit() {
	return pageUnit;
	}

	/**
	 * pageUnit attribute 값을 설정한다.
	 * @param pageUnit  the pageUnit to set
	 * @uml.property  name="pageUnit"
	 */
	public void setPageUnit(int pageUnit) {
	this.pageUnit = pageUnit;
	}

	/**
	 * pageSize attribute를 리턴한다.
	 * @return  the pageSize
	 * @uml.property  name="pageSize"
	 */
	public int getPageSize() {
	return pageSize;
	}

	/**
	 * pageSize attribute 값을 설정한다.
	 * @param pageSize  the pageSize to set
	 * @uml.property  name="pageSize"
	 */
	public void setPageSize(int pageSize) {
	this.pageSize = pageSize;
	}

	/**
	 * firstIndex attribute를 리턴한다.
	 * @return  the firstIndex
	 * @uml.property  name="firstIndex"
	 */
	public int getFirstIndex() {
	return firstIndex;
	}

	/**
	 * firstIndex attribute 값을 설정한다.
	 * @param firstIndex  the firstIndex to set
	 * @uml.property  name="firstIndex"
	 */
	public void setFirstIndex(int firstIndex) {
	this.firstIndex = firstIndex;
	}

	/**
	 * lastIndex attribute를 리턴한다.
	 * @return  the lastIndex
	 * @uml.property  name="lastIndex"
	 */
	public int getLastIndex() {
	return lastIndex;
	}

	/**
	 * lastIndex attribute 값을 설정한다.
	 * @param lastIndex  the lastIndex to set
	 * @uml.property  name="lastIndex"
	 */
	public void setLastIndex(int lastIndex) {
	this.lastIndex = lastIndex;
	}

	/**
	 * recordCountPerPage attribute를 리턴한다.
	 * @return  the recordCountPerPage
	 * @uml.property  name="recordCountPerPage"
	 */
	public int getRecordCountPerPage() {
	return recordCountPerPage;
	}

	/**
	 * recordCountPerPage attribute 값을 설정한다.
	 * @param recordCountPerPage  the recordCountPerPage to set
	 * @uml.property  name="recordCountPerPage"
	 */
	public void setRecordCountPerPage(int recordCountPerPage) {
	this.recordCountPerPage = recordCountPerPage;
	}

	/**
	 * rowNo attribute를 리턴한다.
	 * @return  the rowNo
	 * @uml.property  name="rowNo"
	 */
	public int getRowNo() {
	return rowNo;
	}

	/**
	 * rowNo attribute 값을 설정한다.
	 * @param rowNo  the rowNo to set
	 * @uml.property  name="rowNo"
	 */
	public void setRowNo(int rowNo) {
	this.rowNo = rowNo;
	}

	/**
	 * frstRegisterNm attribute를 리턴한다.
	 * @return  the frstRegisterNm
	 * @uml.property  name="frstRegisterNm"
	 */
	public String getFrstRegisterNm() {
	return frstRegisterNm;
	}

	/**
	 * frstRegisterNm attribute 값을 설정한다.
	 * @param frstRegisterNm  the frstRegisterNm to set
	 * @uml.property  name="frstRegisterNm"
	 */
	public void setFrstRegisterNm(String frstRegisterNm) {
	this.frstRegisterNm = frstRegisterNm;
	}

	/**
	 * lastUpdusrNm attribute를 리턴한다.
	 * @return  the lastUpdusrNm
	 * @uml.property  name="lastUpdusrNm"
	 */
	public String getLastUpdusrNm() {
	return lastUpdusrNm;
	}

	/**
	 * lastUpdusrNm attribute 값을 설정한다.
	 * @param lastUpdusrNm  the lastUpdusrNm to set
	 * @uml.property  name="lastUpdusrNm"
	 */
	public void setLastUpdusrNm(String lastUpdusrNm) {
	this.lastUpdusrNm = lastUpdusrNm;
	}

	/**
	 * isExpired attribute를 리턴한다.
	 * @return  the isExpired
	 * @uml.property  name="isExpired"
	 */
	public String getIsExpired() {
	return isExpired;
	}

	/**
	 * isExpired attribute 값을 설정한다.
	 * @param isExpired  the isExpired to set
	 * @uml.property  name="isExpired"
	 */
	public void setIsExpired(String isExpired) {
	this.isExpired = isExpired;
	}

	/**
	 * parntsSortOrdr attribute를 리턴한다.
	 * @return  the parntsSortOrdr
	 * @uml.property  name="parntsSortOrdr"
	 */
	public String getParntsSortOrdr() {
	return parntsSortOrdr;
	}

	/**
	 * parntsSortOrdr attribute 값을 설정한다.
	 * @param parntsSortOrdr  the parntsSortOrdr to set
	 * @uml.property  name="parntsSortOrdr"
	 */
	public void setParntsSortOrdr(String parntsSortOrdr) {
	this.parntsSortOrdr = parntsSortOrdr;
	}

	/**
	 * fileAtchPosblAt attribute를 리턴한다.
	 * @return  the fileAtchPosblAt
	 * @uml.property  name="fileAtchPosblAt"
	 */
	public String getFileAtchPosblAt() {
	return fileAtchPosblAt;
	}

	/**
	 * fileAtchPosblAt attribute 값을 설정한다.
	 * @param fileAtchPosblAt  the fileAtchPosblAt to set
	 * @uml.property  name="fileAtchPosblAt"
	 */
	public void setFileAtchPosblAt(String fileAtchPosblAt) {
	this.fileAtchPosblAt = fileAtchPosblAt;
	}

	/**
	 * posblAtchFileNumber attribute를 리턴한다.
	 * @return  the posblAtchFileNumber
	 * @uml.property  name="posblAtchFileNumber"
	 */
	public int getPosblAtchFileNumber() {
	return posblAtchFileNumber;
	}

	/**
	 * posblAtchFileNumber attribute 값을 설정한다.
	 * @param posblAtchFileNumber  the posblAtchFileNumber to set
	 * @uml.property  name="posblAtchFileNumber"
	 */
	public void setPosblAtchFileNumber(int posblAtchFileNumber) {
	this.posblAtchFileNumber = posblAtchFileNumber;
	}

	/**
	 * plusCount attribute를 리턴한다.
	 * @return  the plusCount
	 * @uml.property  name="plusCount"
	 */
	public boolean isPlusCount() {
		return plusCount;
	}

	/**
	 * plusCount attribute 값을 설정한다.
	 * @param plusCount  the plusCount to set
	 * @uml.property  name="plusCount"
	 */
	public void setPlusCount(boolean plusCount) {
		this.plusCount = plusCount;
	}

	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString() {
	return ToStringBuilder.reflectionToString(this);
	}
	
	/**
	 * @return the searchClosingState
	 */
	public String getSearchClosingState() {
		return searchClosingState;
	}

	/**
	 * @param searchClosingState the searchClosingState to set
	 */
	public void setSearchClosingState(String searchClosingState) {
		this.searchClosingState = searchClosingState;
	}

	/**
	 * @return the urlStr
	 */
	public String getUrlStr() {
		return urlStr;
	}

	/**
	 * @param urlStr the urlStr to set
	 */
	public void setUrlStr(String urlStr) {
		this.urlStr = urlStr;
	}

	/**
	 * @return the searchYmBgn
	 */
	public String getSearchYmBgn() {
		return searchYmBgn;
	}

	/**
	 * @param searchYmBgn the searchYmBgn to set
	 */
	public void setSearchYmBgn(String searchYmBgn) {
		this.searchYmBgn = searchYmBgn;
	}

	/**
	 * @return the searchYmEnd
	 */
	public String getSearchYmEnd() {
		return searchYmEnd;
	}

	/**
	 * @param searchYmEnd the searchYmEnd to set
	 */
	public void setSearchYmEnd(String searchYmEnd) {
		this.searchYmEnd = searchYmEnd;
	}

	/**
	 * @return the searchYear
	 */
	public String getSearchYear() {
		return searchYear;
	}

	/**
	 * @param searchYear the searchYear to set
	 */
	public void setSearchYear(String searchYear) {
		this.searchYear = searchYear;
	}

	/**
	 * @return the searchMonth
	 */
	public String getSearchMonth() {
		return searchMonth;
	}

	/**
	 * @param searchMonth the searchMonth to set
	 */
	public void setSearchMonth(String searchMonth) {
		this.searchMonth = searchMonth;
	}

	/**
	 * @return the mode
	 */
	public String getMode() {
		return mode;
	}

	/**
	 * @param mode the mode to set
	 */
	public void setMode(String mode) {
		this.mode = mode;
	}

	/**
	 * @return the searchDept
	 */
	public String getSearchDept() {
		return searchDept;
	}

	/**
	 * @param searchDept the searchDept to set
	 */
	public void setSearchDept(String searchDept) {
		this.searchDept = searchDept;
	}

	/**
	 * @return the searchDeptId
	 */
	public String getSearchDeptId() {
		return searchDeptId;
	}

	/**
	 * @param searchDeptId the searchDeptId to set
	 */
	public void setSearchDeptId(String searchDeptId) {
		this.searchDeptId = searchDeptId;
	}

	/**
	 * @return the searchMemId
	 */
	public String getSearchMemId() {
		return searchMemId;
	}

	/**
	 * @param searchMemId the searchMemId to set
	 */
	public void setSearchMemId(String searchMemId) {
		this.searchMemId = searchMemId;
	}

	/**
	 * @return the searchSeminarId
	 */
	public String getSearchSeminarId() {
		return searchSeminarId;
	}

	/**
	 * @param searchSeminarId the searchSeminarId to set
	 */
	public void setSearchSeminarId(String searchSeminarId) {
		this.searchSeminarId = searchSeminarId;
	}

	/**
	 * @return the searchUClosingState
	 */
	public String getSearchUClosingState() {
		return searchUClosingState;
	}

	/**
	 * @param searchUClosingState the searchUClosingState to set
	 */
	public void setSearchUClosingState(String searchUClosingState) {
		this.searchUClosingState = searchUClosingState;
	}
}