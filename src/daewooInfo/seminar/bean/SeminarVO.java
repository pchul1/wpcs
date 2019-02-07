package daewooInfo.seminar.bean;

import java.io.Serializable;

/**
 * 교육 참가현황 VO 클래스
 * @author 박미영
 * @since 2014.09.15
 * @version 1.0
 * @see
 */
public class SeminarVO implements Serializable {
	/**
	 * 교육 ID
	 */
	private String seminarId;
	/**
	 * 교육 제목
	 */
	private String seminarTitle;
	/**
	 * 교육 구분
	 */
	private String seminarGubun;
	/**
	 * 교육 담당자 ID
	 */
	private String seminarLectId;
	/**
	 * 교육 참여인원
	 */
	private int seminarCount;
	/**
	 * 교육 담당자 연락처
	 */
	private String seminarLectTel;
	/**
	 * 교육 담당자 이메일
	 */
	private String seminarLectEmail;
	/**
	 * 교육 주최
	 */
	private String seminarHost;
	/**
	 * 교육 신청상태
	 */
	private String seminarState;
	/**
	 * 교육 신청 불허 이유
	 */
	private String seminarReason;	
	/**
	 * 교육 장소
	 */
	private String seminarPlace;
	/**
	 * 교육 내용
	 */
	private String seminarBody;
	/**
	 * 교육 내용(입력)
	 */
	private String nttCn;
	/**
	 * 교육 기간 From
	 */
	private String seminarDateFrom;
	/**
	 * 교육 기간 To
	 */
	private String seminarDateTo;
	/**
	 * 교육 시간 From
	 */
	private String seminarTimeFrom;
	/**
	 * 교육 시간 To
	 */
	private String seminarTimeTo;
	/**
	 * 신청 기간 From
	 */
	private String seminarEntryDateFrom;
	/**
	 * 신청 기간 To
	 */
	private String seminarEntryDateTo;
	/**
	 * 신청 기간
	 */	
	private String seminarEntryDate;
	/**
	 * 조회수
	 */
	private int readCnt;
	/**
	 * 첨부파일
	 */
	private String atchFileId;
	/**
	 * 교육마감여부
	 */
	private String seminarClosingState;
	/**
	 * 등록자 ID
	 */
	private String writerId;
	/**
	 * 등록일자
	 */
	private String regDate;
	/**
	 * 수정자 ID
	 */
	private String modId;
	/**
	 * 수정일자
	 */
	private String modDate;
	/**
	 * 교육기간
	 */
	private String seminarDate;
	/**
	 * 교육 담당자명
	 */
	private String seminarLectName;
	/**
	 * 작성자명
	 */
	private String writerName;
	/**
	 * 교육 구분명
	 */
	private String seminarGubunName;
	/**
	 * 교육신청상태명
	 */
	private String seminarStateName;
	/**
	 * 사용여부
	 */
	private String useYn;
	
	/**
	 * 교육 ID 파라미터
	 */
	private String checkSeminarId;

	/**
	 * 교육 참여인원
	 */
	private int entryCount;

	/**
	 * 교육 마감여부명
	 */
	private String seminarClosingStateName;

	
	/**
	 * 교육 신청 ID 파라미터
	 */
	private String seminarEntryId;
	
	private String eduSeq;
	private String eduCode;
	private String eduName;
	private String gubun;
	private String eduDateFrom;
	private String eduDateTo;
	private String eduArea;
	private String eduPlace;
	private String lectureTime;
	private String eduSuper;
	private String finishYn;
	private String eduOrgName;
	
	/**
	 * @return the seminarId
	 */
	public String getSeminarId() {
		return seminarId;
	}
	/**
	 * @param seminarId the seminarId to set
	 */
	public void setSeminarId(String seminarId) {
		this.seminarId = seminarId;
	}
	/**
	 * @return the seminarTitle
	 */
	public String getSeminarTitle() {
		return seminarTitle;
	}
	/**
	 * @param seminarTitle the seminarTitle to set
	 */
	public void setSeminarTitle(String seminarTitle) {
		this.seminarTitle = seminarTitle;
	}
	/**
	 * @return the seminarGubun
	 */
	public String getSeminarGubun() {
		return seminarGubun;
	}
	/**
	 * @param seminarGubun the seminarGubun to set
	 */
	public void setSeminarGubun(String seminarGubun) {
		this.seminarGubun = seminarGubun;
	}
	/**
	 * @return the seminarLectId
	 */
	public String getSeminarLectId() {
		return seminarLectId;
	}
	/**
	 * @param seminarLectId the seminarLectId to set
	 */
	public void setSeminarLectId(String seminarLectId) {
		this.seminarLectId = seminarLectId;
	}
	/**
	 * @return the seminarCount
	 */
	public int getSeminarCount() {
		return seminarCount;
	}
	/**
	 * @param seminarCount the seminarCount to set
	 */
	public void setSeminarCount(int seminarCount) {
		this.seminarCount = seminarCount;
	}
	/**
	 * @return the seminarLectTel
	 */
	public String getSeminarLectTel() {
		return seminarLectTel;
	}
	/**
	 * @param seminarLectTel the seminarLectTel to set
	 */
	public void setSeminarLectTel(String seminarLectTel) {
		this.seminarLectTel = seminarLectTel;
	}
	/**
	 * @return the seminarLectEmail
	 */
	public String getSeminarLectEmail() {
		return seminarLectEmail;
	}
	/**
	 * @param seminarLectEmail the seminarLectEmail to set
	 */
	public void setSeminarLectEmail(String seminarLectEmail) {
		this.seminarLectEmail = seminarLectEmail;
	}
	/**
	 * @return the seminarHost
	 */
	public String getSeminarHost() {
		return seminarHost;
	}
	/**
	 * @param seminarHost the seminarHost to set
	 */
	public void setSeminarHost(String seminarHost) {
		this.seminarHost = seminarHost;
	}
	/**
	 * @return the seminarState
	 */
	public String getSeminarState() {
		return seminarState;
	}
	/**
	 * @param seminarState the seminarState to set
	 */
	public void setSeminarState(String seminarState) {
		this.seminarState = seminarState;
	}	
	/**
	 * @return the seminarReason
	 */
	public String getSeminarReason() {
		return seminarReason;
	}
	/**
	 * @param seminarReason the seminarReason to set
	 */
	public void setSeminarReason(String seminarReason) {
		this.seminarReason = seminarReason;
	}	
	/**
	 * @return the seminarPlace
	 */
	public String getSeminarPlace() {
		return seminarPlace;
	}
	/**
	 * @param seminarPlace the seminarPlace to set
	 */
	public void setSeminarPlace(String seminarPlace) {
		this.seminarPlace = seminarPlace;
	}
	/**
	 * @return the seminarBody
	 */
	public String getSeminarBody() {
		return seminarBody;
	}
	/**
	 * @param seminarBody the seminarBody to set
	 */
	public void setSeminarBody(String seminarBody) {
		this.seminarBody = seminarBody;
	}
	/**
	 * @return the seminarDateFrom
	 */
	public String getSeminarDateFrom() {
		return seminarDateFrom;
	}
	/**
	 * @param seminarDateFrom the seminarDateFrom to set
	 */
	public void setSeminarDateFrom(String seminarDateFrom) {
		this.seminarDateFrom = seminarDateFrom;
	}
	/**
	 * @return the seminarDateTo
	 */
	public String getSeminarDateTo() {
		return seminarDateTo;
	}
	/**
	 * @param seminarDateTo the seminarDateTo to set
	 */
	public void setSeminarDateTo(String seminarDateTo) {
		this.seminarDateTo = seminarDateTo;
	}
	/**
	 * @return the seminarTimeFrom
	 */
	public String getSeminarTimeFrom() {
		return seminarTimeFrom;
	}
	/**
	 * @param seminarTimeFrom the seminarTimeFrom to set
	 */
	public void setSeminarTimeFrom(String seminarTimeFrom) {
		this.seminarTimeFrom = seminarTimeFrom;
	}
	/**
	 * @return the seminarTimeTo
	 */
	public String getSeminarTimeTo() {
		return seminarTimeTo;
	}
	/**
	 * @param seminarTimeTo the seminarTimeTo to set
	 */
	public void setSeminarTimeTo(String seminarTimeTo) {
		this.seminarTimeTo = seminarTimeTo;
	}
	/**
	 * @return the seminarEntryDateFrom
	 */
	public String getSeminarEntryDateFrom() {
		return seminarEntryDateFrom;
	}
	/**
	 * @param seminarEntryDateFrom the seminarEntryDateFrom to set
	 */
	public void setSeminarEntryDateFrom(String seminarEntryDateFrom) {
		this.seminarEntryDateFrom = seminarEntryDateFrom;
	}
	/**
	 * @return the seminarEntryDateTo
	 */
	public String getSeminarEntryDateTo() {
		return seminarEntryDateTo;
	}
	/**
	 * @param seminarEntryDateTo the seminarEntryDateTo to set
	 */
	public void setSeminarEntryDateTo(String seminarEntryDateTo) {
		this.seminarEntryDateTo = seminarEntryDateTo;
	}
	/**
	 * @return the seminarEntryDate
	 */
	public String getSeminarEntryDate() {
		return seminarEntryDate;
	}
	/**
	 * @param seminarEntryDate the seminarEntryDate to set
	 */
	public void setSeminarEntryDate(String seminarEntryDate) {
		this.seminarEntryDate = seminarEntryDate;
	}
	/**
	 * @return the readCnt
	 */
	public int getReadCnt() {
		return readCnt;
	}
	/**
	 * @param readCnt the readCnt to set
	 */
	public void setReadCnt(int readCnt) {
		this.readCnt = readCnt;
	}
	/**
	 * @return the atchFileId
	 */
	public String getAtchFileId() {
		return atchFileId;
	}
	/**
	 * @param atchFileId the atchFileId to set
	 */
	public void setAtchFileId(String atchFileId) {
		this.atchFileId = atchFileId;
	}
	/**
	 * @return the seminarClosingState
	 */
	public String getSeminarClosingState() {
		return seminarClosingState;
	}
	/**
	 * @param seminarClosingState the seminarClosingState to set
	 */
	public void setSeminarClosingState(String seminarClosingState) {
		this.seminarClosingState = seminarClosingState;
	}
	/**
	 * @return the writerId
	 */
	public String getWriterId() {
		return writerId;
	}
	/**
	 * @param writerId the writerId to set
	 */
	public void setWriterId(String writerId) {
		this.writerId = writerId;
	}
	/**
	 * @return the regDate
	 */
	public String getRegDate() {
		return regDate;
	}
	/**
	 * @param regDate the regDate to set
	 */
	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}
	/**
	 * @return the modId
	 */
	public String getModId() {
		return modId;
	}
	/**
	 * @param modId the modId to set
	 */
	public void setModId(String modId) {
		this.modId = modId;
	}
	/**
	 * @return the modDate
	 */
	public String getModDate() {
		return modDate;
	}
	/**
	 * @param modDate the modDate to set
	 */
	public void setModDate(String modDate) {
		this.modDate = modDate;
	}
	/**
	 * @return the nttCn
	 */
	public String getNttCn() {
		return nttCn;
	}
	/**
	 * @param nttCn the nttCn to set
	 */
	public void setNttCn(String nttCn) {
		this.nttCn = nttCn;
	}
	/**
	 * @return the seminarDate
	 */
	public String getSeminarDate() {
		return seminarDate;
	}
	/**
	 * @param seminarDate the seminarDate to set
	 */
	public void setSeminarDate(String seminarDate) {
		this.seminarDate = seminarDate;
	}
	/**
	 * @return the seminarLectName
	 */
	public String getSeminarLectName() {
		return seminarLectName;
	}
	/**
	 * @param seminarLectName the seminarLectName to set
	 */
	public void setSeminarLectName(String seminarLectName) {
		this.seminarLectName = seminarLectName;
	}
	/**
	 * @return the writerName
	 */
	public String getWriterName() {
		return writerName;
	}
	/**
	 * @param writerName the writerName to set
	 */
	public void setWriterName(String writerName) {
		this.writerName = writerName;
	}
	/**
	 * @return the seminarGubunName
	 */
	public String getSeminarGubunName() {
		return seminarGubunName;
	}
	/**
	 * @param seminarGubunName the seminarGubunName to set
	 */
	public void setSeminarGubunName(String seminarGubunName) {
		this.seminarGubunName = seminarGubunName;
	}
	/**
	 * @return the seminarStateName
	 */
	public String getSeminarStateName() {
		return seminarStateName;
	}
	/**
	 * @param seminarStateName the seminarStateName to set
	 */
	public void setSeminarStateName(String seminarStateName) {
		this.seminarStateName = seminarStateName;
	}
	/**
	 * @return the useYn
	 */
	public String getUseYn() {
		return useYn;
	}
	/**
	 * @param useYn the useYn to set
	 */
	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}
	/**
	 * @return the checkSeminarId
	 */
	public String getCheckSeminarId() {
		return checkSeminarId;
	}
	/**
	 * @param checkSeminarId the checkSeminarId to set
	 */
	public void setCheckSeminarId(String checkSeminarId) {
		this.checkSeminarId = checkSeminarId;
	}
	/**
	 * @return the entryCount
	 */
	public int getEntryCount() {
		return entryCount;
	}
	/**
	 * @param entryCount the entryCount to set
	 */
	public void setEntryCount(int entryCount) {
		this.entryCount = entryCount;
	}
	/**
	 * @return the seminarClosingStateName
	 */
	public String getSeminarClosingStateName() {
		return seminarClosingStateName;
	}
	/**
	 * @param seminarClosingStateName the seminarClosingStateName to set
	 */
	public void setSeminarClosingStateName(String seminarClosingStateName) {
		this.seminarClosingStateName = seminarClosingStateName;
	}
	/**
	 * @return the seminarEntryId
	 */
	public String getSeminarEntryId() {
		return seminarEntryId;
	}
	/**
	 * @param seminarEntryId the seminarEntryId to set
	 */
	public void setSeminarEntryId(String seminarEntryId) {
		this.seminarEntryId = seminarEntryId;
	}
	public String getEduSeq() {
		return eduSeq;
	}
	public void setEduSeq(String eduSeq) {
		this.eduSeq = eduSeq;
	}
	public String getEduCode() {
		return eduCode;
	}
	public void setEduCode(String eduCode) {
		this.eduCode = eduCode;
	}
	public String getEduName() {
		return eduName;
	}
	public void setEduName(String eduName) {
		this.eduName = eduName;
	}
	public String getGubun() {
		return gubun;
	}
	public void setGubun(String gubun) {
		this.gubun = gubun;
	}
	public String getEduDateFrom() {
		return eduDateFrom;
	}
	public void setEduDateFrom(String eduDateFrom) {
		this.eduDateFrom = eduDateFrom;
	}
	public String getEduDateTo() {
		return eduDateTo;
	}
	public void setEduDateTo(String eduDateTo) {
		this.eduDateTo = eduDateTo;
	}
	public String getEduArea() {
		return eduArea;
	}
	public void setEduArea(String eduArea) {
		this.eduArea = eduArea;
	}
	public String getEduPlace() {
		return eduPlace;
	}
	public void setEduPlace(String eduPlace) {
		this.eduPlace = eduPlace;
	}
	public String getLectureTime() {
		return lectureTime;
	}
	public void setLectureTime(String lectureTime) {
		this.lectureTime = lectureTime;
	}
	public String getEduSuper() {
		return eduSuper;
	}
	public void setEduSuper(String eduSuper) {
		this.eduSuper = eduSuper;
	}
	public String getFinishYn() {
		return finishYn;
	}
	public void setFinishYn(String finishYn) {
		this.finishYn = finishYn;
	}
	public String getEduOrgName() {
		return eduOrgName;
	}
	public void setEduOrgName(String eduOrgName) {
		this.eduOrgName = eduOrgName;
	}
}