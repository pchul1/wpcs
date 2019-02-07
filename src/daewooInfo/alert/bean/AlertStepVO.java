package daewooInfo.alert.bean;

import daewooInfo.cmmn.bean.ComDefaultVO;

/**
 * @author DaeWoo Information Systems Co., Ltd.  Technical Expert Team. khanian.
 * @version 1.0
 * @Class Name : .java
 * @Description :  Class
 * @Modification Information
 * @
 * @ Modify Date     author               Modify Contents
 * @ --------------  ------------   -------------------------------
 * @ 2010. 5. 19  	 khanian              new
 * @see Copyright (C) by DaeWoo Information Systems Co., Ltd. All right reserved.
 * @since 2010. 1. 21
 */

public class AlertStepVO extends ComDefaultVO{
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * @uml.property  name="asId"
	 */
	private String asId;
	/**
	 * @uml.property  name="riverId"
	 */
	private String riverId;
	/**
	 * @uml.property  name="riverDiv"
	 */
	private String riverDiv;
	/**
	 * @uml.property  name="system"
	 */
	private String system;
	/**
	 * @uml.property  name="factCode"
	 */
	private String factCode;
	/**
	 * @uml.property  name="factName"
	 */
	private String factName;
	/**
	 * @uml.property  name="branchNo"
	 */
	private int branchNo;
	/**
	 * @uml.property  name="branchName"
	 */
	private String branchName;
	/**
	 * @uml.property  name="itemCode"
	 */
	private String itemCode;
	/**
	 * @uml.property  name="itemName"
	 */
	private String itemName;
	/**
	 * @uml.property  name="itemCode2"
	 */
	private String itemCode2;
	/**
	 * @uml.property  name="itemName2"
	 */
	private String itemName2;	
	/**
	 * @uml.property  name="itemCode3"
	 */
	private String itemCode3;
	/**
	 * @uml.property  name="itemName3"
	 */
	private String itemName3;
	/**
	 * @uml.property  name="minTime"
	 */
	private String minTime;
	/**
	 * @uml.property  name="minTimeStr"
	 */
	private String minTimeStr;
	/**
	 * @uml.property  name="oMinTime"
	 */
	private String oMinTime;
	/**
	 * @uml.property  name="minOr"
	 */
	private String minOr;
	/**
	 * @uml.property  name="minOrNum"
	 */
	private String minOrNum;
	/**
	 * @uml.property  name="minVl"
	 */
	private Float minVl;
	/**
	 * @uml.property  name="minVl2"
	 */
	private Float minVl2;
	/**
	 * @uml.property  name="minVl3"
	 */
	private Float minVl3;
	/**
	 * @uml.property  name="alertStep"
	 */
	private String alertStep;
	
	/**
	 * @uml.property  name="alertStep"
	 */
	private String prevalertStep;
	
	/**
	 * @uml.property  name="alertStepNum"
	 */
	private String alertStepNum;
	/**
	 * @uml.property  name="alertStepTime"
	 */
	private String alertStepTime;
	/**
	 * @uml.property  name="alertStepTimeStr"
	 */
	private String alertStepTimeStr;
	/**
	 * @uml.property  name="alertStepText"
	 */
	private String alertStepText;
	/**
	 * @uml.property  name="alertTest"
	 */
	private String alertTest;
	/**
	 * @uml.property  name="codeGubun"
	 */
	private String codeGubun; 
	
	/**
	 * @uml.property  name="factAddr"
	 */
	private String factAddr;
	
	/**
	 * @uml.property  name="excessItemCode"
	 */
	private String excessItemCode;
	/**
	 * @uml.property  name="excessMinVl"
	 */
	private Float  excessMinVl; 
	/**
	 * @uml.property  name="excessItemCode_2"
	 */
	private String excessItemCode_2;
	/**
	 * @uml.property  name="excessMinVl_2"
	 */
	private Float  excessMinVl_2; 
	/**
	 * @uml.property  name="memberId"
	 */
	private String memberId;
	/**
	 * @uml.property  name="memberName"
	 */
	private String memberName;
	/**
	 * @uml.property  name="memberTel"
	 */
	private String memberTel;
	/**
	 * @uml.property  name="memberCategory"
	 */
	private String memberCategory;
	/**
	 * @uml.property  name="receiptType"
	 */
	private String receiptType; 
	/**
	 * @uml.property  name="itemTypeName"
	 */
	private String itemTypeName; 
	/**
	 * @uml.property  name="itemType"
	 */
	private String itemType;
	/**
	 * @uml.property  name="itemTypeCode"
	 */
	private String itemTypeCode;
	/**
	 * @uml.property  name="address"
	 */
	private String address;
	/**
	 * @uml.property  name="addr_short"
	 */
	private String addr_short;
	/**
	 * @uml.property  name="addr_det"
	 */
	private String addr_det;
//	private String address_full;
	/**
	 * @uml.property  name="atchFileId"
	 */
	private String atchFileId;
	/**
	 * @uml.property  name="mapx"
	 */
	private String mapx;
	/**
	 * @uml.property  name="mapy"
	 */
	private String mapy; 
	
	/**
	 * @uml.property  name="alertContents"
	 */
	private String alertContents;
	/**
	 * @uml.property  name="alertEtc"
	 */
	private String alertEtc; 
	/**
	 * @uml.property  name="alertKind"
	 */
	private String alertKind; 
	/**
	 * @uml.property  name="alertCount"
	 */
	private String alertCount; 
	/**
	 * @uml.property  name="stateKind"
	 */
	private String stateKind;
	/**
	 * @uml.property  name="alertTime"
	 */
	private String alertTime;
	
	/**
	 * @uml.property  name="toDate"
	 */
	private String toDate;
	/**
	 * @uml.property  name="fromDate"
	 */
	private String fromDate;
	
	/**
	 * @uml.property  name="step1"
	 */
	private String step1;
	/**
	 * @uml.property  name="step2"
	 */
	private String step2;
	/**
	 * @uml.property  name="step3"
	 */
	private String step3;
	/**
	 * @uml.property  name="step4"
	 */
	private String step4;
	/**
	 * @uml.property  name="step5"
	 */
	private String step5;
	/**
	 * @uml.property  name="step6"
	 */
	private String step6;
	/**
	 * @uml.property  name="step7"
	 */
	private String step7;
	/**
	 * @uml.property  name="step8"
	 */
	private String step8;
	/**
	 * @uml.property  name="step9"
	 */
	private String step9;
	/**
	 * @uml.property  name="step10"
	 */
	private String step10;

	/**
	 * @uml.property  name="regName"
	 */
	private String regName;
	
	//상황조치절차에 관련
	/**
	 * @uml.property  name="gov"
	 */
	private String gov;	//담당기관
	/**
	 * @uml.property  name="person"
	 */
	private String person;	//담당자
	/**
	 * @uml.property  name="phone"
	 */
	private String phone;	//연락처
	/**
	 * @uml.property  name="date"
	 */
	private String date;		//출동시간(date)
	/**
	 * @uml.property  name="time"
	 */
	private String time;		//출동시간(time)
	/**
	 * @uml.property  name="reachDate"
	 */
	private String reachDate;
	/**
	 * @uml.property  name="reachTime"
	 */
	private String reachTime;
	/**
	 * @uml.property  name="fellowRider"
	 */
	private String fellowRider;	//동승자
	/**
	 * @uml.property  name="result"
	 */
	private String result;	//확인결과
	/**
	 * @uml.property  name="moveGov"
	 */
	private String moveGov;	//이송기관
	/**
	 * @uml.property  name="chargePerson"
	 */
	private String chargePerson;	//인수자
	
	
	/**
	 * @uml.property  name="analGov"
	 */
	private String analGov; //분석기관
	/**
	 * @uml.property  name="analPerson"
	 */
	private String analPerson; //분석자
	/**
	 * @uml.property  name="analPhone"
	 */
	private String analPhone; //분석자 연락처
	/**
	 * @uml.property  name="analDate"
	 */
	private String analDate; //분석시간(date);
	/**
	 * @uml.property  name="analTime"
	 */
	private String analTime; //분석시간(time);
	/**
	 * @uml.property  name="analResult"
	 */
	private String analResult; //분석결과
	
	
	/**
	 * @uml.property  name="procGov"
	 */
	private String procGov; //조치기관;
	/**
	 * @uml.property  name="procPerson"
	 */
	private String procPerson; //조차 담당자;
	/**
	 * @uml.property  name="procPhone"
	 */
	private String procPhone; //조치 연락처;
	/**
	 * @uml.property  name="procStartDate"
	 */
	private String procStartDate; //조치시작시간(Date)
	/**
	 * @uml.property  name="procStartTime"
	 */
	private String procStartTime;	//조치시작시간(Time)
	/**
	 * @uml.property  name="procEndDate"
	 */
	private String procEndDate; //조치완료시간(Date)
	/**
	 * @uml.property  name="procEndTime"
	 */
	private String procEndTime; //조치완료 시간(Time)

	/**
	 * @uml.property  name="warnDate"
	 */
	private String warnDate;
	/**
	 * @uml.property  name="warnTime"
	 */
	private String warnTime;
	
	/**
	 * @uml.property  name="isSendSMS"
	 */
	private String isSendSMS;
	
	/**
	 * @uml.property  name="isComplete"
	 */
	private String isComplete;
	
	
	/**
	 * @uml.property  name="norecvMin"
	 */
	private int norecvMin;
	
	/**
	 * @uml.property  name="startDate"
	 */
	private String startDate;
	/**
	 * @uml.property  name="endDate"
	 */
	private String endDate;
	
	private String wpCode;
	
	private String alertDelayTime;
	/**
	 * @return
	 * @uml.property  name="addr_short"
	 */
	final public String getAddr_short() {
		return addr_short;
	}
	/**
	 * @param addr_short
	 * @uml.property  name="addr_short"
	 */
	final public void setAddr_short(String addr_short) {
		this.addr_short = addr_short;
	}
	/**
	 * @return
	 * @uml.property  name="regName"
	 */
	final public String getRegName() {
		return regName;
	}
	/**
	 * @param regName
	 * @uml.property  name="regName"
	 */
	final public void setRegName(String regName) {
		this.regName = regName;
	}
	/**
	 * @return
	 * @uml.property  name="norecvMin"
	 */
	final public int getNorecvMin() {
		return norecvMin;
	}
	/**
	 * @param norecvMin
	 * @uml.property  name="norecvMin"
	 */
	final public void setNorecvMin(int norecvMin) {
		this.norecvMin = norecvMin;
	}
	/**
	 * @return
	 * @uml.property  name="branchName"
	 */
	final public String getBranchName() {
		return branchName;
	}
	/**
	 * @param branchName
	 * @uml.property  name="branchName"
	 */
	final public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	/**
	 * @return
	 * @uml.property  name="itemCode2"
	 */
	final public String getItemCode2() {
		return itemCode2;
	}
	/**
	 * @param itemCode2
	 * @uml.property  name="itemCode2"
	 */
	final public void setItemCode2(String itemCode2) {
		this.itemCode2 = itemCode2;
	}
	/**
	 * @return
	 * @uml.property  name="itemName2"
	 */
	final public String getItemName2() {
		return itemName2;
	}
	/**
	 * @param itemName2
	 * @uml.property  name="itemName2"
	 */
	final public void setItemName2(String itemName2) {
		this.itemName2 = itemName2;
	}
	/**
	 * @return
	 * @uml.property  name="itemCode3"
	 */
	final public String getItemCode3() {
		return itemCode3;
	}
	/**
	 * @param itemCode3
	 * @uml.property  name="itemCode3"
	 */
	final public void setItemCode3(String itemCode3) {
		this.itemCode3 = itemCode3;
	}
	/**
	 * @return
	 * @uml.property  name="itemName3"
	 */
	final public String getItemName3() {
		return itemName3;
	}
	/**
	 * @param itemName3
	 * @uml.property  name="itemName3"
	 */
	final public void setItemName3(String itemName3) {
		this.itemName3 = itemName3;
	}
	/**
	 * @return
	 * @uml.property  name="minVl2"
	 */
	final public Float getMinVl2() {
		return minVl2;
	}
	/**
	 * @param minVl2
	 * @uml.property  name="minVl2"
	 */
	final public void setMinVl2(Float minVl2) {
		this.minVl2 = minVl2;
	}
	/**
	 * @return
	 * @uml.property  name="minVl3"
	 */
	final public Float getMinVl3() {
		return minVl3;
	}
	/**
	 * @param minVl3
	 * @uml.property  name="minVl3"
	 */
	final public void setMinVl3(Float minVl3) {
		this.minVl3 = minVl3;
	}
	/**
	 * @return
	 * @uml.property  name="excessItemCode_2"
	 */
	final public String getExcessItemCode_2() {
		return excessItemCode_2;
	}
	/**
	 * @param excessItemCode_2
	 * @uml.property  name="excessItemCode_2"
	 */
	final public void setExcessItemCode_2(String excessItemCode_2) {
		this.excessItemCode_2 = excessItemCode_2;
	}
	/**
	 * @return
	 * @uml.property  name="excessMinVl_2"
	 */
	final public Float getExcessMinVl_2() {
		return excessMinVl_2;
	}
	/**
	 * @param excessMinVl_2
	 * @uml.property  name="excessMinVl_2"
	 */
	final public void setExcessMinVl_2(Float excessMinVl_2) {
		this.excessMinVl_2 = excessMinVl_2;
	}
	/**
	 * @return
	 * @uml.property  name="itemTypeCode"
	 */
	final public String getItemTypeCode() {
		return itemTypeCode;
	}
	/**
	 * @param itemTypeCode
	 * @uml.property  name="itemTypeCode"
	 */
	final public void setItemTypeCode(String itemTypeCode) {
		this.itemTypeCode = itemTypeCode;
	}
	/**
	 * @return
	 * @uml.property  name="addr_det"
	 */
	final public String getAddr_det() {
		return addr_det;
	}
	/**
	 * @param addr_det
	 * @uml.property  name="addr_det"
	 */
	final public void setAddr_det(String addr_det) {
		this.addr_det = addr_det;
	}
	final public static long getSerialVersionUID() {
		return serialVersionUID;
	}
	/**
	 * @return
	 * @uml.property  name="isComplete"
	 */
	final public String getIsComplete() {
		return isComplete;
	}
	/**
	 * @param isComplete
	 * @uml.property  name="isComplete"
	 */
	final public void setIsComplete(String isComplete) {
		this.isComplete = isComplete;
	}
	/**
	 * @return
	 * @uml.property  name="alertStepTimeStr"
	 */
	final public String getAlertStepTimeStr() {
		return alertStepTimeStr;
	}
	/**
	 * @param alertStepTimeStr
	 * @uml.property  name="alertStepTimeStr"
	 */
	final public void setAlertStepTimeStr(String alertStepTimeStr) {
		this.alertStepTimeStr = alertStepTimeStr;
	}
	/**
	 * @return
	 * @uml.property  name="minTimeStr"
	 */
	final public String getMinTimeStr() {
		return minTimeStr;
	}
	/**
	 * @param minTimeStr
	 * @uml.property  name="minTimeStr"
	 */
	final public void setMinTimeStr(String minTimeStr) {
		this.minTimeStr = minTimeStr;
	}
	/**
	 * @return
	 * @uml.property  name="riverDiv"
	 */
	final public String getRiverDiv() {
		return riverDiv;
	}
	/**
	 * @param riverDiv
	 * @uml.property  name="riverDiv"
	 */
	final public void setRiverDiv(String riverDiv) {
		this.riverDiv = riverDiv;
	}
	/**
	 * @return
	 * @uml.property  name="warnDate"
	 */
	final public String getWarnDate() {
		return warnDate;
	}
	/**
	 * @param warnDate
	 * @uml.property  name="warnDate"
	 */
	final public void setWarnDate(String warnDate) {
		this.warnDate = warnDate;
	}
	/**
	 * @return
	 * @uml.property  name="warnTime"
	 */
	final public String getWarnTime() {
		return warnTime;
	}
	/**
	 * @param warnTime
	 * @uml.property  name="warnTime"
	 */
	final public void setWarnTime(String warnTime) {
		this.warnTime = warnTime;
	}
	/**
	 * @return
	 * @uml.property  name="reachDate"
	 */
	final public String getReachDate() {
		return reachDate;
	}
	/**
	 * @param reachDate
	 * @uml.property  name="reachDate"
	 */
	final public void setReachDate(String reachDate) {
		this.reachDate = reachDate;
	}
	/**
	 * @return
	 * @uml.property  name="reachTime"
	 */
	final public String getReachTime() {
		return reachTime;
	}
	/**
	 * @param reachTime
	 * @uml.property  name="reachTime"
	 */
	final public void setReachTime(String reachTime) {
		this.reachTime = reachTime;
	}
	/**
	 * @return
	 * @uml.property  name="step1"
	 */
	final public String getStep1() {
		return step1;
	}
	/**
	 * @param step1
	 * @uml.property  name="step1"
	 */
	final public void setStep1(String step1) {
		this.step1 = step1;
	}
	/**
	 * @return
	 * @uml.property  name="step2"
	 */
	final public String getStep2() {
		return step2;
	}
	/**
	 * @param step2
	 * @uml.property  name="step2"
	 */
	final public void setStep2(String step2) {
		this.step2 = step2;
	}
	/**
	 * @return
	 * @uml.property  name="step3"
	 */
	final public String getStep3() {
		return step3;
	}
	/**
	 * @param step3
	 * @uml.property  name="step3"
	 */
	final public void setStep3(String step3) {
		this.step3 = step3;
	}
	/**
	 * @return
	 * @uml.property  name="step4"
	 */
	final public String getStep4() {
		return step4;
	}
	/**
	 * @param step4
	 * @uml.property  name="step4"
	 */
	final public void setStep4(String step4) {
		this.step4 = step4;
	}
	/**
	 * @return
	 * @uml.property  name="step5"
	 */
	final public String getStep5() {
		return step5;
	}
	/**
	 * @param step5
	 * @uml.property  name="step5"
	 */
	final public void setStep5(String step5) {
		this.step5 = step5;
	}
	/**
	 * @return
	 * @uml.property  name="step6"
	 */
	final public String getStep6() {
		return step6;
	}
	/**
	 * @param step6
	 * @uml.property  name="step6"
	 */
	final public void setStep6(String step6) {
		this.step6 = step6;
	}
	/**
	 * @return
	 * @uml.property  name="step7"
	 */
	final public String getStep7() {
		return step7;
	}
	/**
	 * @param step7
	 * @uml.property  name="step7"
	 */
	final public void setStep7(String step7) {
		this.step7 = step7;
	}
	/**
	 * @return
	 * @uml.property  name="step8"
	 */
	final public String getStep8() {
		return step8;
	}
	/**
	 * @param step8
	 * @uml.property  name="step8"
	 */
	final public void setStep8(String step8) {
		this.step8 = step8;
	}
	/**
	 * @return
	 * @uml.property  name="step9"
	 */
	final public String getStep9() {
		return step9;
	}
	/**
	 * @param step9
	 * @uml.property  name="step9"
	 */
	final public void setStep9(String step9) {
		this.step9 = step9;
	}
	/**
	 * @return
	 * @uml.property  name="step10"
	 */
	final public String getStep10() {
		return step10;
	}
	/**
	 * @param step10
	 * @uml.property  name="step10"
	 */
	final public void setStep10(String step10) {
		this.step10 = step10;
	}
	/**
	 * @return
	 * @uml.property  name="toDate"
	 */
	final public String getToDate() {
		return toDate;
	}
	/**
	 * @param toDate
	 * @uml.property  name="toDate"
	 */
	final public void setToDate(String toDate) {
		this.toDate = toDate;
	}
	/**
	 * @return
	 * @uml.property  name="fromDate"
	 */
	final public String getFromDate() {
		return fromDate;
	}
	/**
	 * @param fromDate
	 * @uml.property  name="fromDate"
	 */
	final public void setFromDate(String fromDate) {
		this.fromDate = fromDate;
	}
	final public String getOMinTime() {
		return oMinTime;
	}
	final public void setOMinTime(String minTime) {
		oMinTime = minTime;
	}
	/**
	 * @return
	 * @uml.property  name="isSendSMS"
	 */
	final public String getIsSendSMS() {
		return isSendSMS;
	}
	/**
	 * @param isSendSMS
	 * @uml.property  name="isSendSMS"
	 */
	final public void setIsSendSMS(String isSendSMS) {
		this.isSendSMS = isSendSMS;
	}
	/**
	 * @return
	 * @uml.property  name="factAddr"
	 */
	final public String getFactAddr() {
		return factAddr;
	}
	/**
	 * @param factAddr
	 * @uml.property  name="factAddr"
	 */
	final public void setFactAddr(String factAddr) {
		this.factAddr = factAddr;
	}
	/**
	 * @return
	 * @uml.property  name="minOrNum"
	 */
	final public String getMinOrNum() {
		return minOrNum;
	}
	/**
	 * @param minOrNum
	 * @uml.property  name="minOrNum"
	 */
	final public void setMinOrNum(String minOrNum) {
		this.minOrNum = minOrNum;
	}
	/**
	 * @return
	 * @uml.property  name="alertStepNum"
	 */
	final public String getAlertStepNum() {
		return alertStepNum;
	}
	/**
	 * @param alertStepNum
	 * @uml.property  name="alertStepNum"
	 */
	final public void setAlertStepNum(String alertStepNum) {
		this.alertStepNum = alertStepNum;
	}
	/**
	 * @return
	 * @uml.property  name="procGov"
	 */
	final public String getProcGov() {
		return procGov;
	}
	/**
	 * @param procGov
	 * @uml.property  name="procGov"
	 */
	final public void setProcGov(String procGov) {
		this.procGov = procGov;
	}
	/**
	 * @return
	 * @uml.property  name="procPerson"
	 */
	final public String getProcPerson() {
		return procPerson;
	}
	/**
	 * @param procPerson
	 * @uml.property  name="procPerson"
	 */
	final public void setProcPerson(String procPerson) {
		this.procPerson = procPerson;
	}
	/**
	 * @return
	 * @uml.property  name="procPhone"
	 */
	final public String getProcPhone() {
		return procPhone;
	}
	/**
	 * @param procPhone
	 * @uml.property  name="procPhone"
	 */
	final public void setProcPhone(String procPhone) {
		this.procPhone = procPhone;
	}
	/**
	 * @return
	 * @uml.property  name="procStartDate"
	 */
	final public String getProcStartDate() {
		return procStartDate;
	}
	/**
	 * @param procStartDate
	 * @uml.property  name="procStartDate"
	 */
	final public void setProcStartDate(String procStartDate) {
		this.procStartDate = procStartDate;
	}
	/**
	 * @return
	 * @uml.property  name="procStartTime"
	 */
	final public String getProcStartTime() {
		return procStartTime;
	}
	/**
	 * @param procStartTime
	 * @uml.property  name="procStartTime"
	 */
	final public void setProcStartTime(String procStartTime) {
		this.procStartTime = procStartTime;
	}
	/**
	 * @return
	 * @uml.property  name="procEndDate"
	 */
	final public String getProcEndDate() {
		return procEndDate;
	}
	/**
	 * @param procEndDate
	 * @uml.property  name="procEndDate"
	 */
	final public void setProcEndDate(String procEndDate) {
		this.procEndDate = procEndDate;
	}
	/**
	 * @return
	 * @uml.property  name="procEndTime"
	 */
	final public String getProcEndTime() {
		return procEndTime;
	}
	/**
	 * @param procEndTime
	 * @uml.property  name="procEndTime"
	 */
	final public void setProcEndTime(String procEndTime) {
		this.procEndTime = procEndTime;
	}
	/**
	 * @return
	 * @uml.property  name="analGov"
	 */
	final public String getAnalGov() {
		return analGov;
	}
	/**
	 * @param analGov
	 * @uml.property  name="analGov"
	 */
	final public void setAnalGov(String analGov) {
		this.analGov = analGov;
	}
	/**
	 * @return
	 * @uml.property  name="analPerson"
	 */
	final public String getAnalPerson() {
		return analPerson;
	}
	/**
	 * @param analPerson
	 * @uml.property  name="analPerson"
	 */
	final public void setAnalPerson(String analPerson) {
		this.analPerson = analPerson;
	}
	/**
	 * @return
	 * @uml.property  name="analPhone"
	 */
	final public String getAnalPhone() {
		return analPhone;
	}
	/**
	 * @param analPhone
	 * @uml.property  name="analPhone"
	 */
	final public void setAnalPhone(String analPhone) {
		this.analPhone = analPhone;
	}
	/**
	 * @return
	 * @uml.property  name="analDate"
	 */
	final public String getAnalDate() {
		return analDate;
	}
	/**
	 * @param analDate
	 * @uml.property  name="analDate"
	 */
	final public void setAnalDate(String analDate) {
		this.analDate = analDate;
	}
	/**
	 * @return
	 * @uml.property  name="analTime"
	 */
	final public String getAnalTime() {
		return analTime;
	}
	/**
	 * @param analTime
	 * @uml.property  name="analTime"
	 */
	final public void setAnalTime(String analTime) {
		this.analTime = analTime;
	}
	/**
	 * @return
	 * @uml.property  name="analResult"
	 */
	final public String getAnalResult() {
		return analResult;
	}
	/**
	 * @param analResult
	 * @uml.property  name="analResult"
	 */
	final public void setAnalResult(String analResult) {
		this.analResult = analResult;
	}
	/**
	 * @return
	 * @uml.property  name="date"
	 */
	final public String getDate() {
		return date;
	}
	/**
	 * @param date
	 * @uml.property  name="date"
	 */
	final public void setDate(String date) {
		this.date = date;
	}
	/**
	 * @return
	 * @uml.property  name="gov"
	 */
	final public String getGov() {
		return gov;
	}
	/**
	 * @param gov
	 * @uml.property  name="gov"
	 */
	final public void setGov(String gov) {
		this.gov = gov;
	}
	/**
	 * @return
	 * @uml.property  name="person"
	 */
	final public String getPerson() {
		return person;
	}
	/**
	 * @param person
	 * @uml.property  name="person"
	 */
	final public void setPerson(String person) {
		this.person = person;
	}
	/**
	 * @return
	 * @uml.property  name="phone"
	 */
	final public String getPhone() {
		return phone;
	}
	/**
	 * @param phone
	 * @uml.property  name="phone"
	 */
	final public void setPhone(String phone) {
		this.phone = phone;
	}
	/**
	 * @return
	 * @uml.property  name="time"
	 */
	final public String getTime() {
		return time;
	}
	/**
	 * @param time
	 * @uml.property  name="time"
	 */
	final public void setTime(String time) {
		this.time = time;
	}
	/**
	 * @return
	 * @uml.property  name="fellowRider"
	 */
	final public String getFellowRider() {
		return fellowRider;
	}
	/**
	 * @param fellowRider
	 * @uml.property  name="fellowRider"
	 */
	final public void setFellowRider(String fellowRider) {
		this.fellowRider = fellowRider;
	}
	/**
	 * @return
	 * @uml.property  name="result"
	 */
	final public String getResult() {
		return result;
	}
	/**
	 * @param result
	 * @uml.property  name="result"
	 */
	final public void setResult(String result) {
		this.result = result;
	}
	/**
	 * @return
	 * @uml.property  name="moveGov"
	 */
	final public String getMoveGov() {
		return moveGov;
	}
	/**
	 * @param moveGov
	 * @uml.property  name="moveGov"
	 */
	final public void setMoveGov(String moveGov) {
		this.moveGov = moveGov;
	}
	/**
	 * @return
	 * @uml.property  name="chargePerson"
	 */
	final public String getChargePerson() {
		return chargePerson;
	}
	/**
	 * @param chargePerson
	 * @uml.property  name="chargePerson"
	 */
	final public void setChargePerson(String chargePerson) {
		this.chargePerson = chargePerson;
	}
	/**
	 * @return
	 * @uml.property  name="alertTime"
	 */
	final public String getAlertTime() {
		return alertTime;
	}
	/**
	 * @param alertTime
	 * @uml.property  name="alertTime"
	 */
	final public void setAlertTime(String alertTime) {
		this.alertTime = alertTime;
	}
	/**
	 * @return
	 * @uml.property  name="stateKind"
	 */
	final public String getStateKind() {
		return stateKind;
	}
	/**
	 * @param stateKind
	 * @uml.property  name="stateKind"
	 */
	final public void setStateKind(String stateKind) {
		this.stateKind = stateKind;
	}
	/**
	 * @return
	 * @uml.property  name="alertCount"
	 */
	final public String getAlertCount() {
		return alertCount;
	}
	/**
	 * @param alertCount
	 * @uml.property  name="alertCount"
	 */
	final public void setAlertCount(String alertCount) {
		this.alertCount = alertCount;
	}
	/**
	 * @return
	 * @uml.property  name="alertKind"
	 */
	final public String getAlertKind() {
		return alertKind;
	}
	/**
	 * @param alertKind
	 * @uml.property  name="alertKind"
	 */
	final public void setAlertKind(String alertKind) {
		this.alertKind = alertKind;
	}
	/**
	 * @return
	 * @uml.property  name="mapx"
	 */
	final public String getMapx() {
		return mapx;
	}
	/**
	 * @param mapx
	 * @uml.property  name="mapx"
	 */
	final public void setMapx(String mapx) {
		this.mapx = mapx;
	}
	/**
	 * @return
	 * @uml.property  name="mapy"
	 */
	final public String getMapy() {
		return mapy;
	}
	/**
	 * @param mapy
	 * @uml.property  name="mapy"
	 */
	final public void setMapy(String mapy) {
		this.mapy = mapy;
	}
	/**
	 * @return
	 * @uml.property  name="alertContents"
	 */
	final public String getAlertContents() {
		return alertContents;
	}
	/**
	 * @param alertContents
	 * @uml.property  name="alertContents"
	 */
	final public void setAlertContents(String alertContents) {
		this.alertContents = alertContents;
	}
	/**
	 * @return
	 * @uml.property  name="alertEtc"
	 */
	final public String getAlertEtc() {
		return alertEtc;
	}
	/**
	 * @param alertEtc
	 * @uml.property  name="alertEtc"
	 */
	final public void setAlertEtc(String alertEtc) {
		this.alertEtc = alertEtc;
	}
	/**
	 * @return
	 * @uml.property  name="memberId"
	 */
	final public String getMemberId() {
		return memberId;
	}
	/**
	 * @param memberId
	 * @uml.property  name="memberId"
	 */
	final public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	/**
	 * @return
	 * @uml.property  name="atchFileId"
	 */
	final public String getAtchFileId() {
		return atchFileId;
	}
	/**
	 * @param atchFileId
	 * @uml.property  name="atchFileId"
	 */
	final public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	/**
	 * @return
	 * @uml.property  name="excessItemCode"
	 */
	final public String getExcessItemCode() {
		return excessItemCode;
	}
	/**
	 * @param excessItemCode
	 * @uml.property  name="excessItemCode"
	 */
	final public void setExcessItemCode(String excessItemCode) {
		this.excessItemCode = excessItemCode;
	}
	/**
	 * @return
	 * @uml.property  name="excessMinVl"
	 */
	final public Float getExcessMinVl() {
		return excessMinVl;
	}
	/**
	 * @param excessMinVl
	 * @uml.property  name="excessMinVl"
	 */
	final public void setExcessMinVl(Float excessMinVl) {
		this.excessMinVl = excessMinVl;
	}
	/**
	 * @return
	 * @uml.property  name="itemTypeName"
	 */
	final public String getItemTypeName() {
		return itemTypeName;
	}
	/**
	 * @param itemTypeName
	 * @uml.property  name="itemTypeName"
	 */
	final public void setItemTypeName(String itemTypeName) {
		this.itemTypeName = itemTypeName;
	}
	/**
	 * @return
	 * @uml.property  name="address"
	 */
	final public String getAddress() {
		return address;
	}
	/**
	 * @param address
	 * @uml.property  name="address"
	 */
	final public void setAddress(String address) {
		this.address = address;
	}
	/**
	 * @return
	 * @uml.property  name="itemType"
	 */
	final public String getItemType() {
		return itemType;
	}
	/**
	 * @param itemType
	 * @uml.property  name="itemType"
	 */
	final public void setItemType(String itemType) {
		this.itemType = itemType;
	}
	/**
	 * @return
	 * @uml.property  name="receiptType"
	 */
	final public String getReceiptType() {
		return receiptType;
	}
	/**
	 * @param receiptType
	 * @uml.property  name="receiptType"
	 */
	final public void setReceiptType(String receiptType) {
		this.receiptType = receiptType;
	}
	/**
	 * @return
	 * @uml.property  name="memberName"
	 */
	final public String getMemberName() {
		return memberName;
	}
	/**
	 * @param memberName
	 * @uml.property  name="memberName"
	 */
	final public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	/**
	 * @return
	 * @uml.property  name="memberTel"
	 */
	final public String getMemberTel() {
		return memberTel;
	}
	/**
	 * @param memberTel
	 * @uml.property  name="memberTel"
	 */
	final public void setMemberTel(String memberTel) {
		this.memberTel = memberTel;
	}
	/**
	 * @return
	 * @uml.property  name="memberCategory"
	 */
	final public String getMemberCategory() {
		return memberCategory;
	}
	/**
	 * @param memberCategory
	 * @uml.property  name="memberCategory"
	 */
	final public void setMemberCategory(String memberCategory) {
		this.memberCategory = memberCategory;
	}
	/**
	 * @return
	 * @uml.property  name="asId"
	 */
	final public String getAsId() {
		return asId;
	}
	/**
	 * @param asId
	 * @uml.property  name="asId"
	 */
	final public void setAsId(String asId) {
		this.asId = asId;
	}
	/**
	 * @return
	 * @uml.property  name="riverId"
	 */
	final public String getRiverId() {
		return riverId;
	}
	/**
	 * @param riverId
	 * @uml.property  name="riverId"
	 */
	final public void setRiverId(String riverId) {
		this.riverId = riverId;
	}
	/**
	 * @return
	 * @uml.property  name="system"
	 */
	final public String getSystem() {
		return system;
	}
	/**
	 * @param system
	 * @uml.property  name="system"
	 */
	final public void setSystem(String system) {
		this.system = system;
	}
	/**
	 * @return
	 * @uml.property  name="factCode"
	 */
	final public String getFactCode() {
		return factCode;
	}
	/**
	 * @param factCode
	 * @uml.property  name="factCode"
	 */
	final public void setFactCode(String factCode) {
		this.factCode = factCode;
	}
	/**
	 * @return
	 * @uml.property  name="factName"
	 */
	final public String getFactName() {
		return factName;
	}
	/**
	 * @param factName
	 * @uml.property  name="factName"
	 */
	final public void setFactName(String factName) {
		this.factName = factName;
	}
	/**
	 * @return
	 * @uml.property  name="branchNo"
	 */
	final public int getBranchNo() {
		return branchNo;
	}
	/**
	 * @param branchNo
	 * @uml.property  name="branchNo"
	 */
	final public void setBranchNo(int branchNo) {
		this.branchNo = branchNo;
	}
	/**
	 * @return
	 * @uml.property  name="itemCode"
	 */
	final public String getItemCode() {
		return itemCode;
	}
	/**
	 * @param itemCode
	 * @uml.property  name="itemCode"
	 */
	final public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}
	/**
	 * @return
	 * @uml.property  name="itemName"
	 */
	final public String getItemName() {
		return itemName;
	}
	/**
	 * @param itemName
	 * @uml.property  name="itemName"
	 */
	final public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	/**
	 * @return
	 * @uml.property  name="minTime"
	 */
	final public String getMinTime() {
		return minTime;
	}
	/**
	 * @param minTime
	 * @uml.property  name="minTime"
	 */
	final public void setMinTime(String minTime) {
		this.minTime = minTime;
	}
	/**
	 * @return
	 * @uml.property  name="minOr"
	 */
	final public String getMinOr() {
		return minOr;
	}
	/**
	 * @param minOr
	 * @uml.property  name="minOr"
	 */
	final public void setMinOr(String minOr) {
		this.minOr = minOr;
	}
	/**
	 * @return
	 * @uml.property  name="minVl"
	 */
	final public Float getMinVl() {
		return minVl;
	}
	/**
	 * @param minVl
	 * @uml.property  name="minVl"
	 */
	final public void setMinVl(Float minVl) {
		this.minVl = minVl;
	}
	/**
	 * @return
	 * @uml.property  name="alertStep"
	 */
	final public String getAlertStep() {
		return alertStep;
	}
	/**
	 * @param alertStep
	 * @uml.property  name="alertStep"
	 */
	final public void setAlertStep(String alertStep) {
		this.alertStep = alertStep;
	}
	/**
	 * @return
	 * @uml.property  name="alertStepTime"
	 */
	final public String getAlertStepTime() {
		return alertStepTime;
	}
	/**
	 * @param alertStepTime
	 * @uml.property  name="alertStepTime"
	 */
	final public void setAlertStepTime(String alertStepTime) {
		this.alertStepTime = alertStepTime;
	}
	/**
	 * @return
	 * @uml.property  name="alertStepText"
	 */
	final public String getAlertStepText() {
		return alertStepText;
	}
	/**
	 * @param alertStepText
	 * @uml.property  name="alertStepText"
	 */
	final public void setAlertStepText(String alertStepText) {
		this.alertStepText = alertStepText;
	}
	/**
	 * @return
	 * @uml.property  name="alertTest"
	 */
	final public String getAlertTest() {
		return alertTest;
	}
	/**
	 * @param alertTest
	 * @uml.property  name="alertTest"
	 */
	final public void setAlertTest(String alertTest) {
		this.alertTest = alertTest;
	}
	/**
	 * @return
	 * @uml.property  name="codeGubun"
	 */
	final public String getCodeGubun() {
		return codeGubun;
	}
	/**
	 * @param codeGubun
	 * @uml.property  name="codeGubun"
	 */
	final public void setCodeGubun(String codeGubun) {
		this.codeGubun = codeGubun;
	}
	/**
	 * @return
	 * @uml.property  name="startDate"
	 */
	final public String getStartDate() {
		return startDate;
	}
	/**
	 * @param startDate
	 * @uml.property  name="startDate"
	 */
	final public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	/**
	 * @return
	 * @uml.property  name="endDate"
	 */
	final public String getEndDate() {
		return endDate;
	}
	/**
	 * @param endDate
	 * @uml.property  name="endDate"
	 */
	final public void setEndDate(String endDate) {
		this.endDate = endDate;
	}
	final public String getPrevalertStep() {
		return prevalertStep;
	}
	final public void setPrevalertStep(String prevalertStep) {
		this.prevalertStep = prevalertStep;
	}
	final public String getWpCode() {
		return wpCode;
	}
	final public void setWpCode(String wpCode) {
		this.wpCode = wpCode;
	}
	final public String getAlertDelayTime() {
		return alertDelayTime;
	}
	final public void setAlertDelayTime(String alertDelayTime) {
		this.alertDelayTime = alertDelayTime;
	}
}	
