package daewooInfo.seminar.bean;

import java.io.Serializable;

/**
 * 교육관리 VO 클래스
 * @author 박미영
 * @since 2014.09.15
 * @version 1.0
 * @see
 */
public class SeminarEntryVO implements Serializable {
	/**
	 * 교육참가현황 ID
	 */
	private String seminarEntryId;
	/**
	 * 교육일정 ID
	 */
	private String seminarId;	
	/**
	 * 참가자 회원 ID
	 */
	private String seminarMemId;
	/**
	 * 참가여부
	 */
	private String entryYn;
	/**
	 * 참가제외이유
	 */
	private String entryReason;
	/**
	 * 등록자 ID
	 */
	private String writerId;	
	/**
	 * 등록일자
	 */
	private String entryRegDate;
	/**
	 * 수정자 ID
	 */
	private String modId;
	/**
	 * 수정일자
	 */
	private String modDate;
	/**
	 * 참가자 이름
	 */
	private String seminarMemName;
	/**
	 * 참가자 연락처
	 */
	private String memTel;
	/**
	 * 참가자 이메일
	 */
	private String memEmail;
	/**
	 * 참가자 소속
	 */
	private String memDeptName;
	/**
	 * 교육명
	 */
	private String seminarTitle;

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
	 * @return the seminarMemId
	 */
	public String getSeminarMemId() {
		return seminarMemId;
	}
	/**
	 * @param seminarMemId the seminarMemId to set
	 */
	public void setSeminarMemId(String seminarMemId) {
		this.seminarMemId = seminarMemId;
	}
	/**
	 * @return the entryYn
	 */
	public String getEntryYn() {
		return entryYn;
	}
	/**
	 * @param entryYn the entryYn to set
	 */
	public void setEntryYn(String entryYn) {
		this.entryYn = entryYn;
	}
	/**
	 * @return the entryReason
	 */
	public String getEntryReason() {
		return entryReason;
	}
	/**
	 * @param entryReason the entryReason to set
	 */
	public void setEntryReason(String entryReason) {
		this.entryReason = entryReason;
	}
	/**
	 * @return the entryRegDate
	 */
	public String getEntryRegDate() {
		return entryRegDate;
	}
	/**
	 * @param entryRegDate the entryRegDate to set
	 */
	public void setEntryRegDate(String entryRegDate) {
		this.entryRegDate = entryRegDate;
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
	 * @return the seminarMemName
	 */
	public String getSeminarMemName() {
		return seminarMemName;
	}
	/**
	 * @param seminarMemName the seminarMemName to set
	 */
	public void setSeminarMemName(String seminarMemName) {
		this.seminarMemName = seminarMemName;
	}
	/**
	 * @return the memTel
	 */
	public String getMemTel() {
		return memTel;
	}
	/**
	 * @param memTel the memTel to set
	 */
	public void setMemTel(String memTel) {
		this.memTel = memTel;
	}
	/**
	 * @return the memEmail
	 */
	public String getMemEmail() {
		return memEmail;
	}
	/**
	 * @param memEmail the memEmail to set
	 */
	public void setMemEmail(String memEmail) {
		this.memEmail = memEmail;
	}
	/**
	 * @return the memDeptName
	 */
	public String getMemDeptName() {
		return memDeptName;
	}
	/**
	 * @param memDeptName the memDeptName to set
	 */
	public void setMemDeptName(String memDeptName) {
		this.memDeptName = memDeptName;
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
}