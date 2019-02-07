package daewooInfo.spotmanage.bean;

public class MemberAddVO {
	/* 고유번호 아래 3개 */
	/**
	 * @uml.property  name="factCode"
	 */
	String factCode;
	/**
	 * @uml.property  name="branchNo"
	 */
	String branchNo;
	/**
	 * @uml.property  name="memberSeq"
	 */
	String memberSeq;
	/* 회원아이디 */
	/**
	 * @uml.property  name="memberId"
	 */
	String memberId;
	/* 회원이름 */
	/**
	 * @uml.property  name="memberName"
	 */
	String memberName;
	/* 검색 아이디 */
	/**
	 * @uml.property  name="searchText"
	 */
	String searchText;	
	
	
	/**
	 * @return
	 * @uml.property  name="searchText"
	 */
	public String getSearchText() {
		return searchText;
	}
	/**
	 * @param searchText
	 * @uml.property  name="searchText"
	 */
	public void setSearchText(String searchText) {
		this.searchText = searchText;
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
	 * @uml.property  name="memberSeq"
	 */
	public String getMemberSeq() {
		return memberSeq;
	}
	/**
	 * @param memberSeq
	 * @uml.property  name="memberSeq"
	 */
	public void setMemberSeq(String memberSeq) {
		this.memberSeq = memberSeq;
	}
	/**
	 * @return
	 * @uml.property  name="memberId"
	 */
	public String getMemberId() {
		return memberId;
	}
	/**
	 * @param memberId
	 * @uml.property  name="memberId"
	 */
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	/**
	 * @return
	 * @uml.property  name="memberName"
	 */
	public String getMemberName() {
		return memberName;
	}
	/**
	 * @param memberName
	 * @uml.property  name="memberName"
	 */
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	
}
