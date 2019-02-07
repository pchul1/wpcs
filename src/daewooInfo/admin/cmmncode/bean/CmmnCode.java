package daewooInfo.admin.cmmncode.bean;

import java.io.Serializable;

/**
 * 공통코드 모델 클래스
 * @author 공통서비스 개발팀 이중호
 * @since 2009.04.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.04.01  이중호          최초 생성
 *
 * </pre>
 */
public class CmmnCode implements Serializable {

	/*
	 * 코드ID
	 */
	/**
	 * @uml.property  name="codeId"
	 */
	private String codeId = "";
	
	/*
	 * 코드ID명
	 */
	/**
	 * @uml.property  name="codeIdName"
	 */
	private String codeIdName = "";
	
	/*
	 * 코드ID설명
	 */
	/**
	 * @uml.property  name="codeIdDesc"
	 */
	private String codeIdDesc = "";
	
	/*
	 * 사용여부
	 */
    /**
	 * @uml.property  name="useFlag"
	 */
    private String useFlag = "";

    /*
     * 최초등록자ID
     */
    /**
	 * @uml.property  name="regId"
	 */
    private String regId = "";
    
    /*
     * 최종수정자ID
     */
    /**
	 * @uml.property  name="modId"
	 */
    private String modId   = "";

	/**
	 * codeId attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="codeId"
	 */
	public String getCodeId() {
		return codeId;
	}

	/**
	 * codeId attribute 값을 설정한다.
	 * @param codeId  String
	 * @uml.property  name="codeId"
	 */
	public void setCodeId(String codeId) {
		this.codeId = codeId;
	}

	/**
	 * codeIdNm attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="codeIdName"
	 */
	public String getCodeIdName() {
		return codeIdName;
	}

	/**
	 * codeIdNm attribute 값을 설정한다.
	 * @param codeIdNm  String
	 * @uml.property  name="codeIdName"
	 */
	public void setCodeIdName(String codeIdName) {
		this.codeIdName = codeIdName;
	}

	/**
	 * codeIdDc attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="codeIdDesc"
	 */
	public String getCodeIdDesc() {
		return codeIdDesc;
	}

	/**
	 * codeIdDc attribute 값을 설정한다.
	 * @param codeIdDc  String
	 * @uml.property  name="codeIdDesc"
	 */
	public void setCodeIdDesc(String codeIdDesc) {
		this.codeIdDesc = codeIdDesc;
	}

	/**
	 * useAt attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="useFlag"
	 */
	public String getUseFlag() {
		return useFlag;
	}

	/**
	 * useAt attribute 값을 설정한다.
	 * @param useAt  String
	 * @uml.property  name="useFlag"
	 */
	public void setUseFlag(String useFlag) {
		this.useFlag = useFlag;
	}

	/**
	 * frstRegisterId attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="regId"
	 */
	public String getRegId() {
		return regId;
	}

	/**
	 * frstRegisterId attribute 값을 설정한다.
	 * @param frstRegisterId  String
	 * @uml.property  name="regId"
	 */
	public void setRegId(String regId) {
		this.regId = regId;
	}

	/**
	 * lastUpdusrId attribute 를 리턴한다.
	 * @return  String
	 * @uml.property  name="modId"
	 */
	public String getModId() {
		return modId;
	}

	/**
	 * lastUpdusrId attribute 값을 설정한다.
	 * @param lastUpdusrId  String
	 * @uml.property  name="modId"
	 */
	public void setModId(String modId) {
		this.modId = modId;
	}


}
