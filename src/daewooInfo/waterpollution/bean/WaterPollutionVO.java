package daewooInfo.waterpollution.bean;

import java.io.Serializable;

public class WaterPollutionVO  implements Serializable {
	
	private static final long serialVersionUID = 1L;
	
	//신고
	/**
	 * @uml.property  name="wpCode"
	 */
	private String wpCode;					//시쿼스
	
	/**
	 * @uml.property  name="reportDate"
	 */
	private String reportDate;				//신고일시
	/**
	 * @uml.property  name="reporterName"
	 */
	private String reporterName;			//신고자
	/**
	 * @uml.property  name="reporterTelNo"
	 */
	private String reporterTelNo;			//신고자연락처
	/**
	 * @uml.property  name="reporterDept"
	 */
	private String reporterDept;			//신고자소속
	
	//접수
	/**
	 * @uml.property  name="receiveDate"
	 */
	private String receiveDate;				//접수일시
	/**
	 * @uml.property  name="receiverId"
	 */
	private String receiverId;				//접수자 코드
	/**
	 * @uml.property  name="receiverName"
	 */
	private String receiverName;			//접수자 이름
	/**
	 * @uml.property  name="receiverTelNo"
	 */
	private String receiverTelNo;			//접수자 연락처
	/**
	 * @uml.property  name="receiverDept"
	 */
	private String receiverDept;				//접수자소속
	
	//사고내용관련
	/**
	 * @uml.property  name="wpKind"
	 */
	private String wpKind;					//사고유형코드
	/**
	 * @uml.property  name="riverDiv"
	 */
	private String riverDiv;				//수계
	/**
	 * @uml.property  name="regKind"
	 */
	private String regKind;				//등록기관
	/**
	 * @uml.property  name="riverDivName"
	 */
	private String riverDivName;				//수계 이름
	/**
	 * @uml.property  name="supportKind"
	 */
	private String supportKind;				//지원유형
	/**
	 * @uml.property  name="address"
	 */
	private String address;					//주소
	/**
	 * @uml.property  name="addrDet"
	 */
	private String addrDet;					//나머지주소
	/**
	 * @uml.property  name="wpContent"
	 */
	private String wpContent;				//사고내용
	
	/**
	 * @uml.property  name="smsContent"
	 */
	private String smsContent;				//SMS내용
	/**
	 * @uml.property  name="recvId"
	 */
	private String recvId;					//SMS전파 대상자
	/**
	 * @uml.property  name="recvName"
	 */
	private String recvName;				//SMS전파 대상자 이름
	/**
	 * @uml.property  name="recvDept"
	 */
	private String recvDept;				//SMS전파 부서
	
	//수습(조치)경과 관련
	/**
	 * @uml.property  name="wpsCode"
	 */
	private String wpsCode;					//수습경과 코드
	/**
	 * @uml.property  name="wpsStep"
	 */
	private String wpsStep;					//수습경과 단계
	/**
	 * @uml.property  name="wpsStepDate"
	 */
	private String wpsStepDate;
	/**
	 * @uml.property  name="wpsContent"
	 */
	private String wpsContent;
	/**
	 * @uml.property  name="wpsImg"
	 */
	private String wpsImg;
	/**
	 * @uml.property  name="filePath"
	 */
	private String filePath;
	/**
	 * @uml.property  name="reg_date"
	 */
	private String reg_date;
	
	private String startDate;
	//통계
	/**
	 * @uml.property  name="statsYear"
	 */
	private String statsYear;
	/**
	 * @uml.property  name="totalRcv"
	 */
	private String totalRcv;
	/**
	 * @uml.property  name="totalSpt"
	 */
	private String totalSpt;
	/**
	 * @uml.property  name="r01Rcv"
	 */
	private String r01Rcv;
	/**
	 * @uml.property  name="r01Spt"
	 */
	private String r01Spt;
	/**
	 * @uml.property  name="r02Rcv"
	 */
	private String r02Rcv;
	/**
	 * @uml.property  name="r02Spt"
	 */
	private String r02Spt;
	/**
	 * @uml.property  name="r03Rcv"
	 */
	private String r03Rcv;
	/**
	 * @uml.property  name="r03Spt"
	 */
	private String r03Spt;
	/**
	 * @uml.property  name="r04Rcv"
	 */
	private String r04Rcv;
	/**
	 * @uml.property  name="r04Spt"
	 */
	private String r04Spt;
	
	/**
	 * @uml.property  name="cnt"
	 */
	private String cnt;
	/**
	 * @uml.property  name="year"
	 */
	private String year;
	
	/**
	 * @uml.property  name="longituded"
	 */
	private String longituded;
	/**
	 * @uml.property  name="latiude"
	 */
	private String latiude;
	
	private String atchFileId;
	
	private String fileAtchPosblAt;
	
	private String SYS_KIND;
	private String CNT1;
	private String CNT2;
	private String A1;
	private String A2;
	private String A3;
	private String A4;
	private String M;
	private String CNT3;
	private String CNT4;
	private String CNT5;
	private String CNT6;
	
	private String sta;
	private String rcv;
	private String ing;
	private String end_n;
	private String end_y;
	
	/**
	 * @return
	 * @uml.property  name="longituded"
	 */
	public String getLongituded() {
		return longituded;
	}

	/**
	 * @param longituded
	 * @uml.property  name="longituded"
	 */
	public void setLongituded(String longituded) {
		this.longituded = longituded;
	}

	/**
	 * @return
	 * @uml.property  name="latiude"
	 */
	public String getLatiude() {
		return latiude;
	}

	/**
	 * @param latiude
	 * @uml.property  name="latiude"
	 */
	public void setLatiude(String latiude) {
		this.latiude = latiude;
	}
	
	/**
	 * @return
	 * @uml.property  name="wpCode"
	 */
	public String getWpCode() {
		return wpCode;
	}

	/**
	 * @param wpCode
	 * @uml.property  name="wpCode"
	 */
	public void setWpCode(String wpCode) {
		this.wpCode = wpCode;
	}

	/**
	 * @return
	 * @uml.property  name="reportDate"
	 */
	public String getReportDate() {
		return reportDate;
	}

	/**
	 * @param reportDate
	 * @uml.property  name="reportDate"
	 */
	public void setReportDate(String reportDate) {
		this.reportDate = reportDate;
	}

	/**
	 * @return
	 * @uml.property  name="reporterName"
	 */
	public String getReporterName() {
		return reporterName;
	}

	/**
	 * @param reporterName
	 * @uml.property  name="reporterName"
	 */
	public void setReporterName(String reporterName) {
		this.reporterName = reporterName;
	}	

	/**
	 * @return
	 * @uml.property  name="receiverTelNo"
	 */
	public String getReceiverTelNo() {
		return receiverTelNo;
	}

	/**
	 * @param receiverTelNo
	 * @uml.property  name="receiverTelNo"
	 */
	public void setReceiverTelNo(String receiverTelNo) {
		this.receiverTelNo = receiverTelNo;
	}
	/**
	 * @return
	 * @uml.property  name="receiveDate"
	 */
	public String getReceiveDate() {
		return receiveDate;
	}

	/**
	 * @param receiveDate
	 * @uml.property  name="receiveDate"
	 */
	public void setReceiveDate(String receiveDate) {
		this.receiveDate = receiveDate;
	}

	/**
	 * @return
	 * @uml.property  name="receiverId"
	 */
	public String getReceiverId() {
		return receiverId;
	}

	/**
	 * @param receiverId
	 * @uml.property  name="receiverId"
	 */
	public void setReceiverId(String receiverId) {
		this.receiverId = receiverId;
	}

	/**
	 * @return
	 * @uml.property  name="receiverName"
	 */
	public String getReceiverName() {
		return receiverName;
	}

	/**
	 * @param receiverName
	 * @uml.property  name="receiverName"
	 */
	public void setReceiverName(String receiverName) {
		this.receiverName = receiverName;
	}	

	/**
	 * @return
	 * @uml.property  name="reporterTelNo"
	 */
	public String getReporterTelNo() {
		return reporterTelNo;
	}

	/**
	 * @param reporterTelNo
	 * @uml.property  name="reporterTelNo"
	 */
	public void setReporterTelNo(String reporterTelNo) {
		this.reporterTelNo = reporterTelNo;
	}	

	/**
	 * @return
	 * @uml.property  name="wpKind"
	 */
	public String getWpKind() {
		return wpKind;
	}

	/**
	 * @param wpKind
	 * @uml.property  name="wpKind"
	 */
	public void setWpKind(String wpKind) {
		this.wpKind = wpKind;
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

	public String getRegKind() {
		return regKind;
	}

	public void setRegKind(String regKind) {
		this.regKind = regKind;
	}

	/**
	 * @return
	 * @uml.property  name="supportKind"
	 */
	public String getSupportKind() {
		return supportKind;
	}

	/**
	 * @param supportKind
	 * @uml.property  name="supportKind"
	 */
	public void setSupportKind(String supportKind) {
		this.supportKind = supportKind;
	}

	/**
	 * @return
	 * @uml.property  name="address"
	 */
	public String getAddress() {
		return address;
	}

	/**
	 * @param address
	 * @uml.property  name="address"
	 */
	public void setAddress(String address) {
		this.address = address;
	}

	/**
	 * @return
	 * @uml.property  name="addrDet"
	 */
	public String getAddrDet() {
		return addrDet;
	}

	/**
	 * @param addrDet
	 * @uml.property  name="addrDet"
	 */
	public void setAddrDet(String addrDet) {
		this.addrDet = addrDet;
	}

	/**
	 * @return
	 * @uml.property  name="wpContent"
	 */
	public String getWpContent() {
		return wpContent;
	}

	/**
	 * @param wpContent
	 * @uml.property  name="wpContent"
	 */
	public void setWpContent(String wpContent) {
		this.wpContent = wpContent;
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
	 * @uml.property  name="reporterDept"
	 */
	public String getReporterDept() {
		return reporterDept;
	}

	/**
	 * @param reporterDept
	 * @uml.property  name="reporterDept"
	 */
	public void setReporterDept(String reporterDept) {
		this.reporterDept = reporterDept;
	}

	/**
	 * @return
	 * @uml.property  name="receiverDept"
	 */
	public String getReceiverDept() {
		return receiverDept;
	}

	/**
	 * @param receiverDept
	 * @uml.property  name="receiverDept"
	 */
	public void setReceiverDept(String receiverDept) {
		this.receiverDept = receiverDept;
	}

	/**
	 * @return
	 * @uml.property  name="recvId"
	 */
	public String getRecvId() {
		return recvId;
	}

	/**
	 * @param recvId
	 * @uml.property  name="recvId"
	 */
	public void setRecvId(String recvId) {
		this.recvId = recvId;
	}
	
	/**
	 * @return
	 * @uml.property  name="recvName"
	 */
	public String getRecvName() {
		return recvName;
	}

	/**
	 * @param recvName
	 * @uml.property  name="recvName"
	 */
	public void setRecvName(String recvName) {
		this.recvName = recvName;
	}

	/**
	 * @return
	 * @uml.property  name="recvDept"
	 */
	public String getRecvDept() {
		return recvDept;
	}

	/**
	 * @param recvDept
	 * @uml.property  name="recvDept"
	 */
	public void setRecvDept(String recvDept) {
		this.recvDept = recvDept;
	}

	/**
	 * @return
	 * @uml.property  name="wpsCode"
	 */
	public String getWpsCode() {
		return wpsCode;
	}

	/**
	 * @param wpsCode
	 * @uml.property  name="wpsCode"
	 */
	public void setWpsCode(String wpsCode) {
		this.wpsCode = wpsCode;
	}

	/**
	 * @return
	 * @uml.property  name="wpsStep"
	 */
	public String getWpsStep() {
		return wpsStep;
	}

	/**
	 * @param wpsStep
	 * @uml.property  name="wpsStep"
	 */
	public void setWpsStep(String wpsStep) {
		this.wpsStep = wpsStep;
	}

	/**
	 * @return
	 * @uml.property  name="wpsStepDate"
	 */
	public String getWpsStepDate() {
		return wpsStepDate;
	}

	/**
	 * @param wpsStepDate
	 * @uml.property  name="wpsStepDate"
	 */
	public void setWpsStepDate(String wpsStepDate) {
		this.wpsStepDate = wpsStepDate;
	}

	/**
	 * @return
	 * @uml.property  name="wpsContent"
	 */
	public String getWpsContent() {
		return wpsContent;
	}

	/**
	 * @param wpsContent
	 * @uml.property  name="wpsContent"
	 */
	public void setWpsContent(String wpsContent) {
		this.wpsContent = wpsContent;
	}

	/**
	 * @return
	 * @uml.property  name="wpsImg"
	 */
	public String getWpsImg() {
		return wpsImg;
	}

	/**
	 * @param wpsImg
	 * @uml.property  name="wpsImg"
	 */
	public void setWpsImg(String wpsImg) {
		this.wpsImg = wpsImg;
	}
	/**
	 * @return
	 * @uml.property  name="filePath"
	 */
	public String getFilePath() {
		return filePath;
	}
	/**
	 * @param filePath
	 * @uml.property  name="filePath"
	 */
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	/**
	 * @return
	 * @uml.property  name="statsYear"
	 */
	public String getStatsYear() {
		return statsYear;
	}

	/**
	 * @param statsYear
	 * @uml.property  name="statsYear"
	 */
	public void setStatsYear(String statsYear) {
		this.statsYear = statsYear;
	}

	/**
	 * @return
	 * @uml.property  name="totalRcv"
	 */
	public String getTotalRcv() {
		return totalRcv;
	}

	/**
	 * @param totalRcv
	 * @uml.property  name="totalRcv"
	 */
	public void setTotalRcv(String totalRcv) {
		this.totalRcv = totalRcv;
	}

	/**
	 * @return
	 * @uml.property  name="totalSpt"
	 */
	public String getTotalSpt() {
		return totalSpt;
	}

	/**
	 * @param totalSpt
	 * @uml.property  name="totalSpt"
	 */
	public void setTotalSpt(String totalSpt) {
		this.totalSpt = totalSpt;
	}

	/**
	 * @return
	 * @uml.property  name="r01Rcv"
	 */
	public String getR01Rcv() {
		return r01Rcv;
	}

	/**
	 * @param rcv
	 * @uml.property  name="r01Rcv"
	 */
	public void setR01Rcv(String rcv) {
		r01Rcv = rcv;
	}

	/**
	 * @return
	 * @uml.property  name="r01Spt"
	 */
	public String getR01Spt() {
		return r01Spt;
	}

	/**
	 * @param spt
	 * @uml.property  name="r01Spt"
	 */
	public void setR01Spt(String spt) {
		r01Spt = spt;
	}

	/**
	 * @return
	 * @uml.property  name="r02Rcv"
	 */
	public String getR02Rcv() {
		return r02Rcv;
	}

	/**
	 * @param rcv
	 * @uml.property  name="r02Rcv"
	 */
	public void setR02Rcv(String rcv) {
		r02Rcv = rcv;
	}

	/**
	 * @return
	 * @uml.property  name="r02Spt"
	 */
	public String getR02Spt() {
		return r02Spt;
	}

	/**
	 * @param spt
	 * @uml.property  name="r02Spt"
	 */
	public void setR02Spt(String spt) {
		r02Spt = spt;
	}

	/**
	 * @return
	 * @uml.property  name="r03Rcv"
	 */
	public String getR03Rcv() {
		return r03Rcv;
	}

	/**
	 * @param rcv
	 * @uml.property  name="r03Rcv"
	 */
	public void setR03Rcv(String rcv) {
		r03Rcv = rcv;
	}

	/**
	 * @return
	 * @uml.property  name="r03Spt"
	 */
	public String getR03Spt() {
		return r03Spt;
	}

	/**
	 * @param spt
	 * @uml.property  name="r03Spt"
	 */
	public void setR03Spt(String spt) {
		r03Spt = spt;
	}

	/**
	 * @return
	 * @uml.property  name="r04Rcv"
	 */
	public String getR04Rcv() {
		return r04Rcv;
	}

	/**
	 * @param rcv
	 * @uml.property  name="r04Rcv"
	 */
	public void setR04Rcv(String rcv) {
		r04Rcv = rcv;
	}

	/**
	 * @return
	 * @uml.property  name="r04Spt"
	 */
	public String getR04Spt() {
		return r04Spt;
	}

	/**
	 * @param spt
	 * @uml.property  name="r04Spt"
	 */
	public void setR04Spt(String spt) {
		r04Spt = spt;
	}

	/**
	 * @return
	 * @uml.property  name="cnt"
	 */
	public String getCnt() {
		return cnt;
	}

	/**
	 * @param cnt
	 * @uml.property  name="cnt"
	 */
	public void setCnt(String cnt) {
		this.cnt = cnt;
	}

	/**
	 * @return
	 * @uml.property  name="year"
	 */
	public String getYear() {
		return year;
	}

	/**
	 * @param year
	 * @uml.property  name="year"
	 */
	public void setYear(String year) {
		this.year = year;
	}
	
	/**
	 * @return
	 * @uml.property  name="reg_date"
	 */
	public String getReg_date() {
		return reg_date;
	}

	/**
	 * @param reg_date
	 * @uml.property  name="reg_date"
	 */
	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
	}

	public String getRiverDivName() {
		return riverDivName;
	}

	public void setRiverDivName(String riverDivName) {
		this.riverDivName = riverDivName;
	}

	public String getSYS_KIND() {
		return SYS_KIND;
	}

	public void setSYS_KIND(String sYS_KIND) {
		SYS_KIND = sYS_KIND;
	}

	public String getCNT1() {
		return CNT1;
	}

	public void setCNT1(String cNT1) {
		CNT1 = cNT1;
	}

	public String getCNT2() {
		return CNT2;
	}
	
	public String getCNT3() {
		return CNT3;
	}

	public void setCNT2(String cNT2) {
		CNT2 = cNT2;
	}
	
	public void setCNT3(String cNT3) {
		CNT3 = cNT3;
	}

	public String getCNT4() {
		return CNT4;
	}

	public void setCNT4(String cNT4) {
		CNT4 = cNT4;
	}

	public String getCNT5() {
		return CNT5;
	}

	public void setCNT5(String cNT5) {
		CNT5 = cNT5;
	}

	public String getCNT6() {
		return CNT6;
	}

	public void setCNT6(String cNT6) {
		CNT6 = cNT6;
	}

	public String getA1() {
		return A1;
	}

	public void setA1(String a1) {
		A1 = a1;
	}

	public String getA2() {
		return A2;
	}

	public void setA2(String a2) {
		A2 = a2;
	}

	public String getA3() {
		return A3;
	}

	public void setA3(String a3) {
		A3 = a3;
	}

	public String getA4() {
		return A4;
	}

	public void setA4(String a4) {
		A4 = a4;
	}

	public String getM() {
		return M;
	}

	public void setM(String m) {
		M = m;
	}

	public String getSta() {
		return sta;
	}

	public void setSta(String sta) {
		this.sta = sta;
	}

	public String getRcv() {
		return rcv;
	}

	public void setRcv(String rcv) {
		this.rcv = rcv;
	}

	public String getIng() {
		return ing;
	}

	public void setIng(String ing) {
		this.ing = ing;
	}

	public String getEnd_n() {
		return end_n;
	}

	public void setEnd_n(String end_n) {
		this.end_n = end_n;
	}

	public String getEnd_y() {
		return end_y;
	}

	public void setEnd_y(String end_y) {
		this.end_y = end_y;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getAtchFileId() {
		return atchFileId;
	}

	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}

	public String getFileAtchPosblAt() {
		return fileAtchPosblAt;
	}

	public void setFileAtchPosblAt(String fileAtchPosblAt) {
		this.fileAtchPosblAt = fileAtchPosblAt;
	}
}
