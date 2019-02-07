package daewooInfo.dailywork.bean;

import java.io.Serializable;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class CheckUseVO  implements Serializable {
	
    private String checkUseId;

    private String gubun;
    
    private String reportGubun;

    private String workDay;

    private String approvalId;

    private String approvalDate;

    private String state;
    
    private String weather;
    
    private String equipCode1;
    
    private String equipCode2;
    
    private String purpose;
    
    private String purposeName;
    
    private String usePurpose;
    
    private String usePurposeName;
    
    private String usePlace;
    
    private String voyageSection;
    
    private String voyageHour;
    
    private String voyageMin;
    
    private String fuelInject;
    
    private String issueComment;
    
    private String persons;
    
    private String participant;
    
    private String exprComment;
    
    private String photo1Id;
    
    private String photo2Id;
    
    private String photo3Id;
    
    private String photo1IdDelYn;
    
    private String photo2IdDelYn;
    
    private String photo3IdDelYn;

    private String regId;

    private String regDate;

    private String modId;

    private String modDate;

    private String approvalName;
    
    private String regName;
    
    private String gubunName; 
    
    private String dailyWorkseq;
    
    private String atchFileYn;
    
    private String atchFileId;
    
    private String approvalRequestId;
    
    private String approvalRequestDate;
    
    private String stateName;
    
    private String modifyGubun;
    
    private String modName;
    
    private MultipartFile file1;
    
    private MultipartFile file2;
    
    private MultipartFile file3;
    
	public String getCheckUseId() {
		return checkUseId;
	}

	public void setCheckUseId(String checkUseId) {
		this.checkUseId = checkUseId;
	}

	public String getGubun() {
		return gubun;
	}

	public void setGubun(String gubun) {
		this.gubun = gubun;
	}

	public String getReportGubun() {
		return reportGubun;
	}

	public void setReportGubun(String reportGubun) {
		this.reportGubun = reportGubun;
	}

	public String getWorkDay() {
		return workDay;
	}

	public void setWorkDay(String workDay) {
		this.workDay = workDay;
	}

	public String getApprovalId() {
		return approvalId;
	}

	public void setApprovalId(String approvalId) {
		this.approvalId = approvalId;
	}

	public String getApprovalDate() {
		return approvalDate;
	}

	public void setApprovalDate(String approvalDate) {
		this.approvalDate = approvalDate;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getWeather() {
		return weather;
	}

	public void setWeather(String weather) {
		this.weather = weather;
	}

	public String getEquipCode1() {
		return equipCode1;
	}

	public void setEquipCode1(String equipCode1) {
		this.equipCode1 = equipCode1;
	}

	public String getEquipCode2() {
		return equipCode2;
	}

	public void setEquipCode2(String equipCode2) {
		this.equipCode2 = equipCode2;
	}

	public String getPurpose() {
		return purpose;
	}

	public void setPurpose(String purpose) {
		this.purpose = purpose;
	}

	public String getPurposeName() {
		return purposeName;
	}

	public void setPurposeName(String purposeName) {
		this.purposeName = purposeName;
	}

	public String getUsePurpose() {
		return usePurpose;
	}

	public void setUsePurpose(String usePurpose) {
		this.usePurpose = usePurpose;
	}

	public String getUsePurposeName() {
		return usePurposeName;
	}

	public void setUsePurposeName(String usePurposeName) {
		this.usePurposeName = usePurposeName;
	}

	public String getUsePlace() {
		return usePlace;
	}

	public void setUsePlace(String usePlace) {
		this.usePlace = usePlace;
	}

	public String getVoyageSection() {
		return voyageSection;
	}

	public void setVoyageSection(String voyageSection) {
		this.voyageSection = voyageSection;
	}

	public String getVoyageHour() {
		return voyageHour;
	}

	public void setVoyageHour(String voyageHour) {
		this.voyageHour = voyageHour;
	}

	public String getVoyageMin() {
		return voyageMin;
	}

	public void setVoyageMin(String voyageMin) {
		this.voyageMin = voyageMin;
	}

	public String getFuelInject() {
		return fuelInject;
	}

	public void setFuelInject(String fuelInject) {
		this.fuelInject = fuelInject;
	}

	public String getIssueComment() {
		return issueComment;
	}

	public void setIssueComment(String issueComment) {
		this.issueComment = issueComment;
	}

	public String getPersons() {
		return persons;
	}

	public void setPersons(String persons) {
		this.persons = persons;
	}

	public String getParticipant() {
		return participant;
	}

	public void setParticipant(String participant) {
		this.participant = participant;
	}

	public String getExprComment() {
		return exprComment;
	}

	public void setExprComment(String exprComment) {
		this.exprComment = exprComment;
	}

	public String getPhoto1Id() {
		return photo1Id;
	}

	public void setPhoto1Id(String photo1Id) {
		this.photo1Id = photo1Id;
	}

	public String getPhoto2Id() {
		return photo2Id;
	}

	public void setPhoto2Id(String photo2Id) {
		this.photo2Id = photo2Id;
	}

	public String getPhoto3Id() {
		return photo3Id;
	}

	public void setPhoto3Id(String photo3Id) {
		this.photo3Id = photo3Id;
	}

	public String getPhoto1IdDelYn() {
		return photo1IdDelYn;
	}

	public void setPhoto1IdDelYn(String photo1IdDelYn) {
		this.photo1IdDelYn = photo1IdDelYn;
	}

	public String getPhoto2IdDelYn() {
		return photo2IdDelYn;
	}

	public void setPhoto2IdDelYn(String photo2IdDelYn) {
		this.photo2IdDelYn = photo2IdDelYn;
	}

	public String getPhoto3IdDelYn() {
		return photo3IdDelYn;
	}

	public void setPhoto3IdDelYn(String photo3IdDelYn) {
		this.photo3IdDelYn = photo3IdDelYn;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getModId() {
		return modId;
	}

	public void setModId(String modId) {
		this.modId = modId;
	}

	public String getModDate() {
		return modDate;
	}

	public void setModDate(String modDate) {
		this.modDate = modDate;
	}

	public String getApprovalName() {
		return approvalName;
	}

	public void setApprovalName(String approvalName) {
		this.approvalName = approvalName;
	}

	public String getRegName() {
		return regName;
	}

	public void setRegName(String regName) {
		this.regName = regName;
	}

	public String getGubunName() {
		return gubunName;
	}

	public void setGubunName(String gubunName) {
		this.gubunName = gubunName;
	}

	public String getDailyWorkseq() {
		return dailyWorkseq;
	}

	public void setDailyWorkseq(String dailyWorkseq) {
		this.dailyWorkseq = dailyWorkseq;
	}

	public String getAtchFileYn() {
		return atchFileYn;
	}

	public void setAtchFileYn(String atchFileYn) {
		this.atchFileYn = atchFileYn;
	}

	public String getAtchFileId() {
		return atchFileId;
	}

	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}

	public String getApprovalRequestId() {
		return approvalRequestId;
	}

	public void setApprovalRequestId(String approvalRequestId) {
		this.approvalRequestId = approvalRequestId;
	}

	public String getApprovalRequestDate() {
		return approvalRequestDate;
	}

	public void setApprovalRequestDate(String approvalRequestDate) {
		this.approvalRequestDate = approvalRequestDate;
	}

	public String getStateName() {
		return stateName;
	}

	public void setStateName(String stateName) {
		this.stateName = stateName;
	}

	public String getModifyGubun() {
		return modifyGubun;
	}

	public void setModifyGubun(String modifyGubun) {
		this.modifyGubun = modifyGubun;
	}

	public String getModName() {
		return modName;
	}

	public void setModName(String modName) {
		this.modName = modName;
	}

	public MultipartFile getFile1() {
		return file1;
	}

	public void setFile1(MultipartFile file1) {
		this.file1 = file1;
	}

	public MultipartFile getFile2() {
		return file2;
	}

	public void setFile2(MultipartFile file2) {
		this.file2 = file2;
	}

	public MultipartFile getFile3() {
		return file3;
	}

	public void setFile3(MultipartFile file3) {
		this.file3 = file3;
	}

}
