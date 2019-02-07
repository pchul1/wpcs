package daewooInfo.spotmanage.bean;

import daewooInfo.cmmn.bean.ComDefaultVO;

public class EqItemVO extends ComDefaultVO {
	/* 고유번호 */
	/**
	 * @uml.property  name="factCode"
	 */
	String factCode;      
	/**
	 * @uml.property  name="branchNo"
	 */
	String branchNo;      
	/**
	 * @uml.property  name="eqSeq"
	 */
	String eqSeq;          
	/* 생성일 수정일 */
	/**
	 * @uml.property  name="crtDate"
	 */
	String crtDate;        
	/**
	 * @uml.property  name="modDate"
	 */
	String modDate; 
	/* 설치장비이름 */
	/**
	 * @uml.property  name="eqName"
	 */
	String eqName;        
	/* 항목이름 */
	/**
	 * @uml.property  name="itemName"
	 */
	String itemName;      
	/* 도입일 */
	/**
	 * @uml.property  name="introDate"
	 */
	String introDate;      
	/* 제조사 고유번호 */
	/**
	 * @uml.property  name="conpanySeq"
	 */
	String conpanySeq;    
	/* 모델 고유번호 */
	/**
	 * @uml.property  name="modelSeq"
	 */
	String modelSeq;      
	/**
	 * @uml.property  name="memo"
	 */
	String memo;           
	/**
	 * @uml.property  name="userFlag"
	 */
	String userFlag;
	
	String eqCode;
	
	/* 철수일 */
	String outDate;  
	
	/* 장비이력연번 */
	
	String eqSeqHsNo;
	
	/**
	 * @return  the factCode
	 * @uml.property  name="factCode"
	 */
	public String getFactCode() {
		return factCode;
	}
	/**
	 * @param factCode  the factCode to set
	 * @uml.property  name="factCode"
	 */
	public void setFactCode(String factCode) {
		this.factCode = factCode;
	}
	/**
	 * @return  the branchNo
	 * @uml.property  name="branchNo"
	 */
	public String getBranchNo() {
		return branchNo;
	}
	/**
	 * @param branchNo  the branchNo to set
	 * @uml.property  name="branchNo"
	 */
	public void setBranchNo(String branchNo) {
		this.branchNo = branchNo;
	}
	/**
	 * @return  the eqSeq
	 * @uml.property  name="eqSeq"
	 */
	public String getEqSeq() {
		return eqSeq;
	}
	/**
	 * @param eqSeq  the eqSeq to set
	 * @uml.property  name="eqSeq"
	 */
	public void setEqSeq(String eqSeq) {
		this.eqSeq = eqSeq;
	}
	/**
	 * @return  the crtDate
	 * @uml.property  name="crtDate"
	 */
	public String getCrtDate() {
		return crtDate;
	}
	/**
	 * @param crtDate  the crtDate to set
	 * @uml.property  name="crtDate"
	 */
	public void setCrtDate(String crtDate) {
		this.crtDate = crtDate;
	}
	/**
	 * @return  the modDate
	 * @uml.property  name="modDate"
	 */
	public String getModDate() {
		return modDate;
	}
	/**
	 * @param modDate  the modDate to set
	 * @uml.property  name="modDate"
	 */
	public void setModDate(String modDate) {
		this.modDate = modDate;
	}
	/**
	 * @return  the eqName
	 * @uml.property  name="eqName"
	 */
	public String getEqName() {
		return eqName;
	}
	/**
	 * @param eqName  the eqName to set
	 * @uml.property  name="eqName"
	 */
	public void setEqName(String eqName) {
		this.eqName = eqName;
	}
	/**
	 * @return  the itemName
	 * @uml.property  name="itemName"
	 */
	public String getItemName() {
		return itemName;
	}
	/**
	 * @param itemName  the itemName to set
	 * @uml.property  name="itemName"
	 */
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	/**
	 * @return  the introDate
	 * @uml.property  name="introDate"
	 */
	public String getIntroDate() {
		return introDate;
	}
	/**
	 * @param introDate  the introDate to set
	 * @uml.property  name="introDate"
	 */
	public void setIntroDate(String introDate) {
		this.introDate = introDate;
	}
	/**
	 * @return  the conpanySeq
	 * @uml.property  name="conpanySeq"
	 */
	public String getConpanySeq() {
		return conpanySeq;
	}
	/**
	 * @param conpanySeq  the conpanySeq to set
	 * @uml.property  name="conpanySeq"
	 */
	public void setConpanySeq(String conpanySeq) {
		this.conpanySeq = conpanySeq;
	}
	/**
	 * @return  the modelSeq
	 * @uml.property  name="modelSeq"
	 */
	public String getModelSeq() {
		return modelSeq;
	}
	/**
	 * @param modelSeq  the modelSeq to set
	 * @uml.property  name="modelSeq"
	 */
	public void setModelSeq(String modelSeq) {
		this.modelSeq = modelSeq;
	}
	/**
	 * @return  the memo
	 * @uml.property  name="memo"
	 */
	public String getMemo() {
		return memo;
	}
	/**
	 * @param memo  the memo to set
	 * @uml.property  name="memo"
	 */
	public void setMemo(String memo) {
		this.memo = memo;
	}
	/**
	 * @return  the userFlag
	 * @uml.property  name="userFlag"
	 */
	public String getUserFlag() {
		return userFlag;
	}
	/**
	 * @param userFlag  the userFlag to set
	 * @uml.property  name="userFlag"
	 */
	public void setUserFlag(String userFlag) {
		this.userFlag = userFlag;
	}
	public String getEqCode() {
		return eqCode;
	}
	public void setEqCode(String eqCode) {
		this.eqCode = eqCode;
	}
	public String getOutDate() {
		return outDate;
	}
	public void setOutDate(String outDate) {
		this.outDate = outDate;
	}
	
	public String getEqSeqHsNo() {
		return eqSeqHsNo;
	}
	public void setEqSeqHsNo(String eqSeqHsNo) {
		this.eqSeqHsNo = eqSeqHsNo;
	}
	
	
		
}
