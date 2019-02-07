package daewooInfo.alert.bean;

/**
 * @author DaeWoo Information Systems Co., Ltd.  Technical Expert Team. khanian.
 * @version 1.0
 * @Class Name : .java
 * @Description :  Class
 * @Modification Information
 * @
 * @ Modify Date     author               Modify Contents
 * @ --------------  ------------   -------------------------------
 * @ 2010. 3. 26  	 khanian              new
 * @see Copyright (C) by DaeWoo Information Systems Co., Ltd. All right reserved.
 * @since 2010. 1. 21
 */

public class AlertDataVO {
	/**
	 * @uml.property  name="alertId"
	 */
	private String alertId;
	/**
	 * @uml.property  name="userId"
	 */
	private String userId;
	
	/**
	 * @uml.property  name="schedule"
	 */
	private double schedule;
	/**
	 * @uml.property  name="subject"
	 */
	private String subject;
	/**
	 * @uml.property  name="nowDate"
	 */
	private String nowDate;
	/**
	 * @uml.property  name="sendDate"
	 */
	private String sendDate;
	/**
	 * @uml.property  name="callBack"
	 */
	private String callBack;
	/**
	 * @uml.property  name="destInfo"
	 */
	private String destInfo;
	/**
	 * @uml.property  name="smsMsg"
	 */
	private String smsMsg;
	/**
	 * @uml.property  name="toName"
	 */
	private String toName;
	/**
	 * @uml.property  name="toTel"
	 */
	private String toTel;
	/**
	 * @uml.property  name="part"
	 */
	private String part;
	/**
	 * @uml.property  name="factCode"
	 */
	private String factCode;
	/**
	 * @uml.property  name="branchNo"
	 */
	private int branchNo;
	/**
	 * @uml.property  name="minTime"
	 */
	private String minTime;
	/**
	 * @uml.property  name="itemCode"
	 */
	private String itemCode;
	/**
	 * @uml.property  name="minVl"
	 */
	private Float minVl;
	/**
	 * @uml.property  name="minOr"
	 */
	private String minOr;
	/**
	 * @uml.property  name="riverId"
	 */
	private String riverId;
	
	/**
	 * @uml.property  name="memberId"
	 */
	private String memberId;
	
	/**
	 * @uml.property  name="itemCodeArr"
	 */
	private String[] itemCodeArr;
	/**
	 * @uml.property  name="minVlArr"
	 */
	private Float[] minVlArr;
	
	
	/**
	 * @return
	 * @uml.property  name="riverId"
	 */
	public String getRiverId() {
		return riverId;
	}
	/**
	 * @param riverId
	 * @uml.property  name="riverId"
	 */
	public void setRiverId(String riverId) {
		this.riverId = riverId;
	}
	/**
	 * @return
	 * @uml.property  name="alertId"
	 */
	public String getAlertId() {
		return alertId;
	}
	/**
	 * @return
	 * @uml.property  name="userId"
	 */
	public void setAlertId(String alertId) {
		this.alertId = alertId;
	}
	/**
	 * @return
	 * @uml.property  name="userId"
	 */
	public String getUserId() {
		return userId;
	}
	/**
	 * @param userId
	 * @uml.property  name="userId"
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
	/**
	 * @return
	 * @uml.property  name="schedule"
	 */
	public double getSchedule() {
		return schedule;
	}
	/**
	 * @param schedule
	 * @uml.property  name="schedule"
	 */
	public void setSchedule(double schedule) {
		this.schedule = schedule;
	}
	/**
	 * @return
	 * @uml.property  name="subject"
	 */
	public String getSubject() {
		return subject;
	}
	/**
	 * @param subject
	 * @uml.property  name="subject"
	 */
	public void setSubject(String subject) {
		this.subject = subject;
	}
	/**
	 * @return
	 * @uml.property  name="nowDate"
	 */
	public String getNowDate() {
		return nowDate;
	}
	/**
	 * @param nowDate
	 * @uml.property  name="nowDate"
	 */
	public void setNowDate(String nowDate) {
		this.nowDate = nowDate;
	}
	/**
	 * @return
	 * @uml.property  name="sendDate"
	 */
	public String getSendDate() {
		return sendDate;
	}
	/**
	 * @param sendDate
	 * @uml.property  name="sendDate"
	 */
	public void setSendDate(String sendDate) {
		this.sendDate = sendDate;
	}
	/**
	 * @return
	 * @uml.property  name="callBack"
	 */
	public String getCallBack() {
		return callBack;
	}
	/**
	 * @param callBack
	 * @uml.property  name="callBack"
	 */
	public void setCallBack(String callBack) {
		this.callBack = callBack;
	}
	/**
	 * @return
	 * @uml.property  name="destInfo"
	 */
	public String getDestInfo() {
		return destInfo;
	}
	/**
	 * @param destInfo
	 * @uml.property  name="destInfo"
	 */
	public void setDestInfo(String destInfo) {
		this.destInfo = destInfo;
	}
	/**
	 * @return
	 * @uml.property  name="smsMsg"
	 */
	public String getSmsMsg() {
		return smsMsg;
	}
	/**
	 * @param smsMsg
	 * @uml.property  name="smsMsg"
	 */
	public void setSmsMsg(String smsMsg) {
		this.smsMsg = smsMsg;
	}
	/**
	 * @return
	 * @uml.property  name="toName"
	 */
	public String getToName() {
		return toName;
	}
	/**
	 * @param toName
	 * @uml.property  name="toName"
	 */
	public void setToName(String toName) {
		this.toName = toName;
	}
	/**
	 * @return
	 * @uml.property  name="toTel"
	 */
	public String getToTel() {
		return toTel;
	}
	/**
	 * @param toTel
	 * @uml.property  name="toTel"
	 */
	public void setToTel(String toTel) {
		this.toTel = toTel;
	}
	/**
	 * @return
	 * @uml.property  name="part"
	 */
	public String getPart() {
		return part;
	}
	/**
	 * @param part
	 * @uml.property  name="part"
	 */
	public void setPart(String part) {
		this.part = part;
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
	public int getBranchNo() {
		return branchNo;
	}
	/**
	 * @param branchNo
	 * @uml.property  name="branchNo"
	 */
	public void setBranchNo(int branchNo) {
		this.branchNo = branchNo;
	}
	/**
	 * @return
	 * @uml.property  name="minTime"
	 */
	public String getMinTime() {
		return minTime;
	}
	/**
	 * @param minTime
	 * @uml.property  name="minTime"
	 */
	public void setMinTime(String minTime) {
		this.minTime = minTime;
	}
	/**
	 * @return
	 * @uml.property  name="itemCode"
	 */
	public String getItemCode() {
		return itemCode;
	}
	/**
	 * @param itemCode
	 * @uml.property  name="itemCode"
	 */
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}
	/**
	 * @return
	 * @uml.property  name="minVl"
	 */
	public Float getMinVl() {
		return minVl;
	}
	/**
	 * @param minVl
	 * @uml.property  name="minVl"
	 */
	public void setMinVl(Float minVl) {
		this.minVl = minVl;
	}
	/**
	 * @return
	 * @uml.property  name="minOr"
	 */
	public String getMinOr() {
		return minOr;
	}
	/**
	 * @param minOr
	 * @uml.property  name="minOr"
	 */
	public void setMinOr(String minOr) {
		this.minOr = minOr;
	}
	/**
	 * @return
	 * @uml.property  name="itemCodeArr"
	 */
	public String[] getItemCodeArr() {
		return itemCodeArr;
	}
	/**
	 * @param itemCodeArr
	 * @uml.property  name="itemCodeArr"
	 */
	public void setItemCodeArr(String[] itemCodeArr) {
		this.itemCodeArr = itemCodeArr;
	}
	/**
	 * @return
	 * @uml.property  name="minVlArr"
	 */
	public Float[] getMinVlArr() {
		return minVlArr;
	}
	/**
	 * @param minVlArr
	 * @uml.property  name="minVlArr"
	 */
	public void setMinVlArr(Float[] minVlArr) {
		this.minVlArr = minVlArr;
	}
	
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}	
	
}	
