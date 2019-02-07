package daewooInfo.bbs.bean;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;


/**
 * 게시물 관리를 위한 VO 클래스
 * @author 공통서비스개발팀 이삼섭
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일	  수정자		   수정내용
 *  -------	  --------	---------------------------
 *   2009.3.19  이삼섭		  최초 생성
 *   2009.06.29  한성곤		2단계 기능 추가 (댓글관리, 만족도조사)
 *
 * </pre>
 */
@SuppressWarnings("serial")
public class BoardVO extends Board implements Serializable {

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
	 * 상위 답변 위치
	 * @uml.property  name="parntsReplyLc"
	 */
	private String parntsReplyLc = "";

	/**
	 * 게시판 유형코드
	 * @uml.property  name="bbsTyCode"
	 */
	private String bbsTyCode = "";
	
	/**
	 * 게시판 속성코드
	 * @uml.property  name="bbsAttrbCode"
	 */
	private String bbsAttrbCode = "";

	/**
	 * 게시판 명
	 * @uml.property  name="bbsNm"
	 */
	private String bbsNm = "";

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
	 * 답장가능여부
	 * @uml.property  name="replyPosblAt"
	 */
	private String replyPosblAt = "";
	
	/**
	 * 조회 수 증가 여부
	 * @uml.property  name="plusCount"
	 */
	private boolean plusCount = false;
	
	//---------------------------------
	// 2009.06.29 : 2단계 기능 추가
	//---------------------------------
	/**
	 * 하위 페이지 인덱스 (댓글 및 만족도 조사 여부 확인용)
	 * @uml.property  name="subPageIndex"
	 */
	private String subPageIndex = "";
	////-------------------------------
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
	 * parntsReplyLc attribute를 리턴한다.
	 * @return  the parntsReplyLc
	 * @uml.property  name="parntsReplyLc"
	 */
	public String getParntsReplyLc() {
	return parntsReplyLc;
	}

	/**
	 * parntsReplyLc attribute 값을 설정한다.
	 * @param parntsReplyLc  the parntsReplyLc to set
	 * @uml.property  name="parntsReplyLc"
	 */
	public void setParntsReplyLc(String parntsReplyLc) {
	this.parntsReplyLc = parntsReplyLc;
	}

	/**
	 * bbsTyCode attribute를 리턴한다.
	 * @return  the bbsTyCode
	 * @uml.property  name="bbsTyCode"
	 */
	public String getBbsTyCode() {
	return bbsTyCode;
	}

	/**
	 * bbsTyCode attribute 값을 설정한다.
	 * @param bbsTyCode  the bbsTyCode to set
	 * @uml.property  name="bbsTyCode"
	 */
	public void setBbsTyCode(String bbsTyCode) {
	this.bbsTyCode = bbsTyCode;
	}

	/**
	 * bbsAttrbCode attribute를 리턴한다.
	 * @return  the bbsAttrbCode
	 * @uml.property  name="bbsAttrbCode"
	 */
	public String getBbsAttrbCode() {
	return bbsAttrbCode;
	}

	/**
	 * bbsAttrbCode attribute 값을 설정한다.
	 * @param bbsAttrbCode  the bbsAttrbCode to set
	 * @uml.property  name="bbsAttrbCode"
	 */
	public void setBbsAttrbCode(String bbsAttrbCode) {
	this.bbsAttrbCode = bbsAttrbCode;
	}

	/**
	 * bbsNm attribute를 리턴한다.
	 * @return  the bbsNm
	 * @uml.property  name="bbsNm"
	 */
	public String getBbsNm() {
	return bbsNm;
	}

	/**
	 * bbsNm attribute 값을 설정한다.
	 * @param bbsNm  the bbsNm to set
	 * @uml.property  name="bbsNm"
	 */
	public void setBbsNm(String bbsNm) {
	this.bbsNm = bbsNm;
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
	 * replyPosblAt attribute를 리턴한다.
	 * @return  the replyPosblAt
	 * @uml.property  name="replyPosblAt"
	 */
	public String getReplyPosblAt() {
	return replyPosblAt;
	}

	/**
	 * replyPosblAt attribute 값을 설정한다.
	 * @param replyPosblAt  the replyPosblAt to set
	 * @uml.property  name="replyPosblAt"
	 */
	public void setReplyPosblAt(String replyPosblAt) {
	this.replyPosblAt = replyPosblAt;
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
	 * subPageIndex attribute를 리턴한다.
	 * @return  the subPageIndex
	 * @uml.property  name="subPageIndex"
	 */
	public String getSubPageIndex() {
		return subPageIndex;
	}

	/**
	 * subPageIndex attribute 값을 설정한다.
	 * @param subPageIndex  the subPageIndex to set
	 * @uml.property  name="subPageIndex"
	 */
	public void setSubPageIndex(String subPageIndex) {
		this.subPageIndex = subPageIndex;
	}

	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString() {
	return ToStringBuilder.reflectionToString(this);
	}
}
