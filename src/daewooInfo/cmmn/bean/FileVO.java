package daewooInfo.cmmn.bean;

import java.io.Serializable;

import org.apache.commons.lang.builder.ToStringBuilder;

/**
 * @Class Name : FileVO.java
 * @Description : 파일정보 처리를 위한 VO 클래스
 * @Modification Information
 *
 *    수정일       수정자         수정내용
 *    -------        -------     -------------------
 *    2009. 3. 25.     이삼섭
 *
 * @author 공통 서비스 개발팀 이삼섭
 * @since 2009. 3. 25.
 * @version
 * @see
 *
 */
@SuppressWarnings("serial")
public class FileVO implements Serializable {

    /**
	 * 첨부파일 아이디
	 * @uml.property  name="atchFileId"
	 */
    public String atchFileId = "";
    /**
	 * 생성일자
	 * @uml.property  name="creatDt"
	 */
    public String creatDt = "";
    /**
	 * 파일내용
	 * @uml.property  name="fileCn"
	 */
    public String fileCn = "";
    /**
	 * 파일확장자
	 * @uml.property  name="fileExtsn"
	 */
    public String fileExtsn = "";
    /**
	 * 파일크기
	 * @uml.property  name="fileMg"
	 */
    public String fileMg = "";
    /**
	 * 파일연번
	 * @uml.property  name="fileSn"
	 */
    public String fileSn = "";
    /**
	 * 파일저장경로
	 * @uml.property  name="fileStreCours"
	 */
    public String fileStreCours = "";
    /**
	 * 원파일명
	 * @uml.property  name="orignlFileNm"
	 */
    public String orignlFileNm = "";
    /**
	 * 저장파일명
	 * @uml.property  name="streFileNm"
	 */
    public String streFileNm = "";

    /**
	 * atchFileId attribute를 리턴한다.
	 * @return  the atchFileId
	 * @uml.property  name="atchFileId"
	 */
    public String getAtchFileId() {
	return atchFileId;
    }

    /**
	 * atchFileId attribute 값을 설정한다.
	 * @param atchFileId  the atchFileId to set
	 * @uml.property  name="atchFileId"
	 */
    public void setAtchFileId(String atchFileId) {
	this.atchFileId = atchFileId;
    }

    /**
	 * creatDt attribute를 리턴한다.
	 * @return  the creatDt
	 * @uml.property  name="creatDt"
	 */
    public String getCreatDt() {
	return creatDt;
    }

    /**
	 * creatDt attribute 값을 설정한다.
	 * @param creatDt  the creatDt to set
	 * @uml.property  name="creatDt"
	 */
    public void setCreatDt(String creatDt) {
	this.creatDt = creatDt;
    }

    /**
	 * fileCn attribute를 리턴한다.
	 * @return  the fileCn
	 * @uml.property  name="fileCn"
	 */
    public String getFileCn() {
	return fileCn;
    }

    /**
	 * fileCn attribute 값을 설정한다.
	 * @param fileCn  the fileCn to set
	 * @uml.property  name="fileCn"
	 */
    public void setFileCn(String fileCn) {
	this.fileCn = fileCn;
    }

    /**
	 * fileExtsn attribute를 리턴한다.
	 * @return  the fileExtsn
	 * @uml.property  name="fileExtsn"
	 */
    public String getFileExtsn() {
	return fileExtsn;
    }

    /**
	 * fileExtsn attribute 값을 설정한다.
	 * @param fileExtsn  the fileExtsn to set
	 * @uml.property  name="fileExtsn"
	 */
    public void setFileExtsn(String fileExtsn) {
	this.fileExtsn = fileExtsn;
    }

    /**
	 * fileMg attribute를 리턴한다.
	 * @return  the fileMg
	 * @uml.property  name="fileMg"
	 */
    public String getFileMg() {
	return fileMg;
    }

    /**
	 * fileMg attribute 값을 설정한다.
	 * @param fileMg  the fileMg to set
	 * @uml.property  name="fileMg"
	 */
    public void setFileMg(String fileMg) {
	this.fileMg = fileMg;
    }

    /**
	 * fileSn attribute를 리턴한다.
	 * @return  the fileSn
	 * @uml.property  name="fileSn"
	 */
    public String getFileSn() {
	return fileSn;
    }

    /**
	 * fileSn attribute 값을 설정한다.
	 * @param fileSn  the fileSn to set
	 * @uml.property  name="fileSn"
	 */
    public void setFileSn(String fileSn) {
	this.fileSn = fileSn;
    }

    /**
	 * fileStreCours attribute를 리턴한다.
	 * @return  the fileStreCours
	 * @uml.property  name="fileStreCours"
	 */
    public String getFileStreCours() {
	return fileStreCours;
    }

    /**
	 * fileStreCours attribute 값을 설정한다.
	 * @param fileStreCours  the fileStreCours to set
	 * @uml.property  name="fileStreCours"
	 */
    public void setFileStreCours(String fileStreCours) {
	this.fileStreCours = fileStreCours;
    }

    /**
	 * orignlFileNm attribute를 리턴한다.
	 * @return  the orignlFileNm
	 * @uml.property  name="orignlFileNm"
	 */
    public String getOrignlFileNm() {
	return orignlFileNm;
    }

    /**
	 * orignlFileNm attribute 값을 설정한다.
	 * @param orignlFileNm  the orignlFileNm to set
	 * @uml.property  name="orignlFileNm"
	 */
    public void setOrignlFileNm(String orignlFileNm) {
	this.orignlFileNm = orignlFileNm;
    }

    /**
	 * streFileNm attribute를 리턴한다.
	 * @return  the streFileNm
	 * @uml.property  name="streFileNm"
	 */
    public String getStreFileNm() {
	return streFileNm;
    }

    /**
	 * streFileNm attribute 값을 설정한다.
	 * @param streFileNm  the streFileNm to set
	 * @uml.property  name="streFileNm"
	 */
    public void setStreFileNm(String streFileNm) {
	this.streFileNm = streFileNm;
    }

    /**
     * toString 메소드를 대치한다.
     */
    public String toString() {
	return ToStringBuilder.reflectionToString(this);
    }
	
}
