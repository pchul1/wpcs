package daewooInfo.admin.access.bean;

import java.io.Serializable;

import org.springframework.stereotype.Repository;

import daewooInfo.cmmn.bean.ComDefaultVO;
import daewooInfo.common.login.bean.LoginVO;

@Repository("accessManageVO")
public class AccessManageVO extends ComDefaultVO implements Serializable{

	//T_FILTER_ACCESS-정보접근 관련
	private String hseq;
	private String loginId;
	private String memberId;
    private String type;
    private String tableNm;
    private String menuNm;
    private String ip;
    private String regDate;
    private String connectIp;

    //기간조회
    private String sdate="";
    private String edate="";

    //T_MEMBER_LOG
//	private String password;
//	private String password_confirm;
//	private String passwordOld;
//	private String memberName;
//	private String ihidNum;
//	private String ihidNum1;
//	private String zip;
//	private String address;
//	private String detailAddress;
//	private String mobileNo;
//	private String mobileNo1;
//	private String mobileNo2;
//	private String groupId;
//	private String groupName;
//	private String faxNum;
//	private String faxNum1;
//	private String faxNum2;
//	private String email;
//	private String email1;
//	private String email2;
//	private String memberStatus;
//	private String uniqId;
//	private String officeNo;
//	private String officeNo1;
//	private String officeNo2;
//	private String officeName;
//	private String deptName;
//	private String gradeName;
//	private String deptNoTmp;
//	private String deptNo;
//	private String deptNoName;
//	private String doCode;
//	private String doCodeName;
//	private String ctyCode;
//	private String ctyCodeName;
//	private String factCode;
//	private String factCodeName;
//	private String organCode;
//	private String organCodeName;
//	private String connectIp;
//	private String roleName;
//	private String riverId;
//	private String privacyAgree;
//	private String privacyAgreeNm;
//	private String privacyDt;
//	private String passwordDt;
//	private String passwordChangeCnt;
//	private String passwordChange;
//	private String passwordChangeYn;
//	private String currDt;
//
	//AccessHistory
	private String columnName;
	private String afterHistory;
	private String befHistory;
	private String hdate;
	private String changeCheck;


    private String dmlType;
    private String dmlDate;

    //T_FILTER_LOGIN
    private long seq = 0;    //시퀀스번호
    private String userId = "";    //유저ID
    private String uip = "";    //아이피
    private String udomain = "";    //도메인
    private String upage = "";    //페이지
    private String ubrowser = "";    //브라우저
    private String uos = "";    //OS

	public String getHseq() {
		return hseq;
	}
	public void setHseq(String hseq) {
		this.hseq = hseq;
	}
	public String getLoginId() {
		return loginId;
	}
	public void setLoginId(String loginId) {
		this.loginId = loginId;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getTableNm() {
		return tableNm;
	}
	public void setTableNm(String tableNm) {
		this.tableNm = tableNm;
	}
	public String getMenuNm() {
		return menuNm;
	}
	public void setMenuNm(String menuNm) {
		this.menuNm = menuNm;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getConnectIp() {
		return connectIp;
	}
	public void setConnectIp(String connectIp) {
		this.connectIp = connectIp;
	}
	public String getRegDate() {
		return regDate;
	}
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	public String getDmlType() {
		return dmlType;
	}
	public void setDmlType(String dmlType) {
		this.dmlType = dmlType;
	}
	public String getDmlDate() {
		return dmlDate;
	}
	public void setDmlDate(String dmlDate) {
		this.dmlDate = dmlDate;
	}

	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public String getAfterHistory() {
		return afterHistory;
	}
	public void setAfterHistory(String afterHistory) {
		this.afterHistory = afterHistory;
	}
	public String getBefHistory() {
		return befHistory;
	}
	public void setBefHistory(String befHistory) {
		this.befHistory = befHistory;
	}
	public String getHdate() {
		return hdate;
	}
	public void setHdate(String hdate) {
		this.hdate = hdate;
	}
	public String getChangeCheck() {
		return changeCheck;
	}
	public void setChangeCheck(String changeCheck) {
		this.changeCheck = changeCheck;
	}
	public long getSeq() {
		return seq;
	}
	public void setSeq(long seq) {
		this.seq = seq;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUip() {
		return uip;
	}
	public void setUip(String uip) {
		this.uip = uip;
	}
	public String getUdomain() {
		return udomain;
	}
	public void setUdomain(String udomain) {
		this.udomain = udomain;
	}
	public String getUpage() {
		return upage;
	}
	public void setUpage(String upage) {
		this.upage = upage;
	}
	public String getUbrowser() {
		return ubrowser;
	}
	public void setUbrowser(String ubrowser) {
		this.ubrowser = ubrowser;
	}
	public String getUos() {
		return uos;
	}
	public void setUos(String uos) {
		this.uos = uos;
	}
	public String getSdate() {
		return sdate;
	}
	public void setSdate(String sdate) {
		this.sdate = sdate;
	}
	public String getEdate() {
		return edate;
	}
	public void setEdate(String edate) {
		this.edate = edate;
	}

}
