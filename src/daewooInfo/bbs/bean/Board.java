package daewooInfo.bbs.bean;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name  : Board.java
 * @Description : 게시물에 대한 데이터 처리 모델
 * @Modification Information
 * 
 *     수정일         수정자                   수정내용
 *     -------          --------        ---------------------------
 *   2009.03.06       이삼섭                  최초 생성
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 02. 13
 * @version 1.0
 * @see 
 * 
 */
@SuppressWarnings("serial")
public class Board implements Serializable {
     
     
	/**
	 * 게시물 첨부파일 아이디
	 * @uml.property  name="atchFileId"
	 */
	private String atchFileId = "";
	/**
	 * 게시판 아이디
	 * @uml.property  name="bbsId"
	 */
	private String bbsId = "";
	/**
	 * 최초등록자 아이디
	 * @uml.property  name="frstRegisterId"
	 */
	private String frstRegisterId = "";
	/**
	 * 최초등록시점
	 * @uml.property  name="frstRegisterPnttm"
	 */
	private String frstRegisterPnttm = "";
	/**
	 * 최종수정자 아이디
	 * @uml.property  name="lastUpdusrId"
	 */
	private String lastUpdusrId = "";
	/**
	 * 최종수정시점
	 * @uml.property  name="lastUpdusrPnttm"
	 */
	private String lastUpdusrPnttm = "";
	/**
	 * 게시시작일
	 * @uml.property  name="ntceBgnde"
	 */
	private String ntceBgnde = "";
	/**
	 * 게시종료일
	 * @uml.property  name="ntceEndde"
	 */
	private String ntceEndde = "";
	/**
	 * 게시자 아이디
	 * @uml.property  name="ntcrId"
	 */
	private String ntcrId = "";
	/**
	 * 게시자명
	 * @uml.property  name="ntcrNm"
	 */
	private String ntcrNm = "";
	/**
	 * 게시물 내용
	 * @uml.property  name="nttCn"
	 */
	private String nttCn = "";
	/**
	 * 게시물 아이디
	 * @uml.property  name="nttId"
	 */
	private long nttId = 0L;
	/**
	 * 게시물 번호
	 * @uml.property  name="nttNo"
	 */
	private long nttNo = 0L;
	/**
	 * 게시물 제목
	 * @uml.property  name="nttSj"
	 */
	private String nttSj = "";
	/**
	 * 부모글번호
	 * @uml.property  name="parnts"
	 */
	private String parnts = "0";
	/**
	 * 패스워드
	 * @uml.property  name="password"
	 */
	private String password = "";
	/**
	 * 조회수
	 * @uml.property  name="inqireCo"
	 */
	private int inqireCo = 0;
	/**
	 * 답장여부
	 * @uml.property  name="replyAt"
	 */
	private String replyAt = "";
	/**
	 * 답장위치
	 * @uml.property  name="replyLc"
	 */
	private String replyLc = "0";
	/**
	 * 정렬순서
	 * @uml.property  name="sortOrdr"
	 */
	private long sortOrdr = 0L;
	/**
	 * 사용여부
	 * @uml.property  name="useAt"
	 */
	private String useAt = "";
	/**
	 * 게시 종료일
	 * @uml.property  name="ntceEnddeView"
	 */
	private String ntceEnddeView = ""; 
	/**
	 * 게시 시작일
	 * @uml.property  name="ntceBgndeView"
	 */
	private String ntceBgndeView = "";
	 

	private String popup_yn;
	private String popup_startdate;
	private String popup_enddate;
	private String email; 

	/*
	private String frstRegisterNm = "";
	
	public String getFrstRegisterNm() {
		return frstRegisterNm;
	}

	public void setFrstRegisterNm(String frstRegisterNm) {
		this.frstRegisterNm = frstRegisterNm;
	}
	*/
	/**
	 * atchFileId attribute를 리턴한다.
	 * @return  the atchFileId
	 * @uml.property  name="atchFileId"
	 */
	public String getAtchFileId() {
		return atchFileId;
	}

	/**
	 * atchFileId attribute 값을 설정한다.
	 * @param atchFileId  the atchFileId to set
	 * @uml.property  name="atchFileId"
	 */
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}

	/**
	 * bbsId attribute를 리턴한다.
	 * @return  the bbsId
	 * @uml.property  name="bbsId"
	 */
	public String getBbsId() {
		return bbsId;
	}

	/**
	 * bbsId attribute 값을 설정한다.
	 * @param bbsId  the bbsId to set
	 * @uml.property  name="bbsId"
	 */
	public void setBbsId(String bbsId) {
		this.bbsId = bbsId;
	}

	/**
	 * frstRegisterId attribute를 리턴한다.
	 * @return  the frstRegisterId
	 * @uml.property  name="frstRegisterId"
	 */
	public String getFrstRegisterId() {
		return frstRegisterId;
	}

	/**
	 * frstRegisterId attribute 값을 설정한다.
	 * @param frstRegisterId  the frstRegisterId to set
	 * @uml.property  name="frstRegisterId"
	 */
	public void setFrstRegisterId(String frstRegisterId) {
		this.frstRegisterId = frstRegisterId;
	}

	/**
	 * frstRegisterPnttm attribute를 리턴한다.
	 * @return  the frstRegisterPnttm
	 * @uml.property  name="frstRegisterPnttm"
	 */
	public String getFrstRegisterPnttm() {
		return frstRegisterPnttm;
	}

	/**
	 * frstRegisterPnttm attribute 값을 설정한다.
	 * @param frstRegisterPnttm  the frstRegisterPnttm to set
	 * @uml.property  name="frstRegisterPnttm"
	 */
	public void setFrstRegisterPnttm(String frstRegisterPnttm) {
		this.frstRegisterPnttm = frstRegisterPnttm;
	}

	/**
	 * lastUpdusrId attribute를 리턴한다.
	 * @return  the lastUpdusrId
	 * @uml.property  name="lastUpdusrId"
	 */
	public String getLastUpdusrId() {
		return lastUpdusrId;
	}

	/**
	 * lastUpdusrId attribute 값을 설정한다.
	 * @param lastUpdusrId  the lastUpdusrId to set
	 * @uml.property  name="lastUpdusrId"
	 */
	public void setLastUpdusrId(String lastUpdusrId) {
		this.lastUpdusrId = lastUpdusrId;
	}

	/**
	 * lastUpdusrPnttm attribute를 리턴한다.
	 * @return  the lastUpdusrPnttm
	 * @uml.property  name="lastUpdusrPnttm"
	 */
	public String getLastUpdusrPnttm() {
		return lastUpdusrPnttm;
	}

	/**
	 * lastUpdusrPnttm attribute 값을 설정한다.
	 * @param lastUpdusrPnttm  the lastUpdusrPnttm to set
	 * @uml.property  name="lastUpdusrPnttm"
	 */
	public void setLastUpdusrPnttm(String lastUpdusrPnttm) {
		this.lastUpdusrPnttm = lastUpdusrPnttm;
	}

	/**
	 * ntceBgnde attribute를 리턴한다.
	 * @return  the ntceBgnde
	 * @uml.property  name="ntceBgnde"
	 */
	public String getNtceBgnde() {
		return ntceBgnde;
	}

	/**
	 * ntceBgnde attribute 값을 설정한다.
	 * @param ntceBgnde  the ntceBgnde to set
	 * @uml.property  name="ntceBgnde"
	 */
	public void setNtceBgnde(String ntceBgnde) {
		this.ntceBgnde = ntceBgnde;
	}

	/**
	 * ntceEndde attribute를 리턴한다.
	 * @return  the ntceEndde
	 * @uml.property  name="ntceEndde"
	 */
	public String getNtceEndde() {
		return ntceEndde;
	}

	/**
	 * ntceEndde attribute 값을 설정한다.
	 * @param ntceEndde  the ntceEndde to set
	 * @uml.property  name="ntceEndde"
	 */
	public void setNtceEndde(String ntceEndde) {
		this.ntceEndde = ntceEndde;
	}

	/**
	 * ntcrId attribute를 리턴한다.
	 * @return  the ntcrId
	 * @uml.property  name="ntcrId"
	 */
	public String getNtcrId() {
		return ntcrId;
	}

	/**
	 * ntcrId attribute 값을 설정한다.
	 * @param ntcrId  the ntcrId to set
	 * @uml.property  name="ntcrId"
	 */
	public void setNtcrId(String ntcrId) {
		this.ntcrId = ntcrId;
	}

	/**
	 * ntcrNm attribute를 리턴한다.
	 * @return  the ntcrNm
	 * @uml.property  name="ntcrNm"
	 */
	public String getNtcrNm() {
		return ntcrNm;
	}

	/**
	 * ntcrNm attribute 값을 설정한다.
	 * @param ntcrNm  the ntcrNm to set
	 * @uml.property  name="ntcrNm"
	 */
	public void setNtcrNm(String ntcrNm) {
		this.ntcrNm = ntcrNm;
	}

	/**
	 * nttCn attribute를 리턴한다.
	 * @return  the nttCn
	 * @uml.property  name="nttCn"
	 */
	public String getNttCn() {
		return nttCn;
	}

	/**
	 * nttCn attribute 값을 설정한다.
	 * @param nttCn  the nttCn to set
	 * @uml.property  name="nttCn"
	 */
	public void setNttCn(String nttCn) {
		this.nttCn = nttCn;
	}

	/**
	 * nttId attribute를 리턴한다.
	 * @return  the nttId
	 * @uml.property  name="nttId"
	 */
	public long getNttId() {
		return nttId;
	}

	/**
	 * nttId attribute 값을 설정한다.
	 * @param nttId  the nttId to set
	 * @uml.property  name="nttId"
	 */
	public void setNttId(long nttId) {
		this.nttId = nttId;
	}

	/**
	 * nttNo attribute를 리턴한다.
	 * @return  the nttNo
	 * @uml.property  name="nttNo"
	 */
	public long getNttNo() {
		return nttNo;
	}

	/**
	 * nttNo attribute 값을 설정한다.
	 * @param nttNo  the nttNo to set
	 * @uml.property  name="nttNo"
	 */
	public void setNttNo(long nttNo) {
		this.nttNo = nttNo;
	}

	/**
	 * nttSj attribute를 리턴한다.
	 * @return  the nttSj
	 * @uml.property  name="nttSj"
	 */
	public String getNttSj() {
		return nttSj;
	}

	/**
	 * nttSj attribute 값을 설정한다.
	 * @param nttSj  the nttSj to set
	 * @uml.property  name="nttSj"
	 */
	public void setNttSj(String nttSj) {
		this.nttSj = nttSj;
	}

	/**
	 * parnts attribute를 리턴한다.
	 * @return  the parnts
	 * @uml.property  name="parnts"
	 */
	public String getParnts() {
		return parnts;
	}

	/**
	 * parnts attribute 값을 설정한다.
	 * @param parnts  the parnts to set
	 * @uml.property  name="parnts"
	 */
	public void setParnts(String parnts) {
		this.parnts = parnts;
	}

	/**
	 * password attribute를 리턴한다.
	 * @return  the password
	 * @uml.property  name="password"
	 */
	public String getPassword() {
		return password;
	}

	/**
	 * password attribute 값을 설정한다.
	 * @param password  the password to set
	 * @uml.property  name="password"
	 */
	public void setPassword(String password) {
		this.password = password;
	}

	/**
	 * inqireCo attribute를 리턴한다.
	 * @return  the inqireCo
	 * @uml.property  name="inqireCo"
	 */
	public int getInqireCo() {
		return inqireCo;
	}

	/**
	 * inqireCo attribute 값을 설정한다.
	 * @param inqireCo  the inqireCo to set
	 * @uml.property  name="inqireCo"
	 */
	public void setInqireCo(int inqireCo) {
		this.inqireCo = inqireCo;
	}

	/**
	 * replyAt attribute를 리턴한다.
	 * @return  the replyAt
	 * @uml.property  name="replyAt"
	 */
	public String getReplyAt() {
		return replyAt;
	}

	/**
	 * replyAt attribute 값을 설정한다.
	 * @param replyAt  the replyAt to set
	 * @uml.property  name="replyAt"
	 */
	public void setReplyAt(String replyAt) {
		this.replyAt = replyAt;
	}

	/**
	 * replyLc attribute를 리턴한다.
	 * @return  the replyLc
	 * @uml.property  name="replyLc"
	 */
	public String getReplyLc() {
		return replyLc;
	}

	/**
	 * replyLc attribute 값을 설정한다.
	 * @param replyLc  the replyLc to set
	 * @uml.property  name="replyLc"
	 */
	public void setReplyLc(String replyLc) {
		this.replyLc = replyLc;
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
	 * useAt attribute를 리턴한다.
	 * @return  the useAt
	 * @uml.property  name="useAt"
	 */
	public String getUseAt() {
		return useAt;
	}

	/**
	 * useAt attribute 값을 설정한다.
	 * @param useAt  the useAt to set
	 * @uml.property  name="useAt"
	 */
	public void setUseAt(String useAt) {
		this.useAt = useAt;
	}

	/**
	 * ntceEnddeView attribute를 리턴한다.
	 * @return  the ntceEnddeView
	 * @uml.property  name="ntceEnddeView"
	 */
	public String getNtceEnddeView() {
		return ntceEnddeView;
	}

	/**
	 * ntceEnddeView attribute 값을 설정한다.
	 * @param ntceEnddeView  the ntceEnddeView to set
	 * @uml.property  name="ntceEnddeView"
	 */
	public void setNtceEnddeView(String ntceEnddeView) {
		this.ntceEnddeView = ntceEnddeView;
	}

	/**
	 * ntceBgndeView attribute를 리턴한다.
	 * @return  the ntceBgndeView
	 * @uml.property  name="ntceBgndeView"
	 */
	public String getNtceBgndeView() {
		return ntceBgndeView;
	}

	/**
	 * ntceBgndeView attribute 값을 설정한다.
	 * @param ntceBgndeView  the ntceBgndeView to set
	 * @uml.property  name="ntceBgndeView"
	 */
	public void setNtceBgndeView(String ntceBgndeView) {
		this.ntceBgndeView = ntceBgndeView;
	}

	/**
	 * toString 메소드를 대치한다.
	 */
	public String toString(){
		return ToStringBuilder.reflectionToString(this);
	}

	public String getPopup_yn() {
		return popup_yn;
	}

	public void setPopup_yn(String popup_yn) {
		this.popup_yn = popup_yn;
	}

	public String getPopup_startdate() {
		return popup_startdate;
	}

	public void setPopup_startdate(String popup_startdate) {
		this.popup_startdate = popup_startdate;
	}

	public String getPopup_enddate() {
		return popup_enddate;
	}

	public void setPopup_enddate(String popup_enddate) {
		this.popup_enddate = popup_enddate;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
}
