package daewooInfo.smsmanage.bean;

import daewooInfo.cmmn.bean.ComDefaultVO;

public class SmsDetVO extends ComDefaultVO {
	/* 고유번호 */
	/**
	 * @uml.property  name="detCode"
	 */
	String detCode;          
	/* 검출내용 */
	/**
	 * @uml.property  name="detContent"
	 */
	String detContent;         
	/* 검출세부내용 */
	/**
	 * @uml.property  name="detDetailContent"
	 */
	String detDetailContent;  
	/* 검출주기 */
	/**
	 * @uml.property  name="detCycle"
	 */
	String detCycle;           
	/* 사용여부 */
	/**
	 * @uml.property  name="dpYn"
	 */
	String dpYn;               
	/* 등록일&수정일 */
	/**
	 * @uml.property  name="crtDate"
	 */
	String crtDate;            
	/**
	 * @uml.property  name="modDate"
	 */
	String modDate;
	/* 삭제여부 */
	/**
	 * @uml.property  name="userYn"
	 */
	String userYn;
	/* 시스템 */
	/**
	 * @uml.property  name="sysKind"
	 */
	String sysKind;
	
	/**
	 * @return
	 * @uml.property  name="sysKind"
	 */
	public String getSysKind() {
		return sysKind;
	}
	/**
	 * @param sysKind
	 * @uml.property  name="sysKind"
	 */
	public void setSysKind(String sysKind) {
		this.sysKind = sysKind;
	}
	/**
	 * @return
	 * @uml.property  name="userYn"
	 */
	public String getUserYn() {
		return userYn;
	}
	/**
	 * @param userYn
	 * @uml.property  name="userYn"
	 */
	public void setUserYn(String userYn) {
		this.userYn = userYn;
	}
	/**
	 * @return
	 * @uml.property  name="detCode"
	 */
	public String getDetCode() {
		return detCode;
	}
	/**
	 * @param detCode
	 * @uml.property  name="detCode"
	 */
	public void setDetCode(String detCode) {
		this.detCode = detCode;
	}
	/**
	 * @return
	 * @uml.property  name="detContent"
	 */
	public String getDetContent() {
		return detContent;
	}
	/**
	 * @param detContent
	 * @uml.property  name="detContent"
	 */
	public void setDetContent(String detContent) {
		this.detContent = detContent;
	}
	/**
	 * @return
	 * @uml.property  name="detDetailContent"
	 */
	public String getDetDetailContent() {
		return detDetailContent;
	}
	/**
	 * @param detDetailContent
	 * @uml.property  name="detDetailContent"
	 */
	public void setDetDetailContent(String detDetailContent) {
		this.detDetailContent = detDetailContent;
	}
	/**
	 * @return
	 * @uml.property  name="detCycle"
	 */
	public String getDetCycle() {
		return detCycle;
	}
	/**
	 * @param detCycle
	 * @uml.property  name="detCycle"
	 */
	public void setDetCycle(String detCycle) {
		this.detCycle = detCycle;
	}
	/**
	 * @return
	 * @uml.property  name="dpYn"
	 */
	public String getDpYn() {
		return dpYn;
	}
	/**
	 * @param dpYn
	 * @uml.property  name="dpYn"
	 */
	public void setDpYn(String dpYn) {
		this.dpYn = dpYn;
	}
	/**
	 * @return
	 * @uml.property  name="crtDate"
	 */
	public String getCrtDate() {
		return crtDate;
	}
	/**
	 * @param crtDate
	 * @uml.property  name="crtDate"
	 */
	public void setCrtDate(String crtDate) {
		this.crtDate = crtDate;
	}
	/**
	 * @return
	 * @uml.property  name="modDate"
	 */
	public String getModDate() {
		return modDate;
	}
	/**
	 * @param modDate
	 * @uml.property  name="modDate"
	 */
	public void setModDate(String modDate) {
		this.modDate = modDate;
	}           
}
