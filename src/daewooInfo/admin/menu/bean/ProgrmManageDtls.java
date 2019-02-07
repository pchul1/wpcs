package daewooInfo.admin.menu.bean;

/**
 * 프로그램변경요청 관리 생성을 위한 모델 클래스를 정의한다.
 * @author 공통서비스 개발팀 이 용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이용          최초 생성
 *
 * </pre>
 */

public class ProgrmManageDtls {

	/**
	 * 변경요청내용
	 * @uml.property  name="changerqesterCn"
	 */
	private String changerqesterCn;
	/**
	 * 처리자ID
	 * @uml.property  name="opetrId"
	 */
	private String opetrId;
	/**
	 * 처리일자
	 * @uml.property  name="processDe"
	 */
	private String processDe;
	/**
	 * @return
	 * @uml.property  name="changerqesterCn"
	 */
	public String getChangerqesterCn() {
		return changerqesterCn;
	}
	/**
	 * @param changerqesterCn
	 * @uml.property  name="changerqesterCn"
	 */
	public void setChangerqesterCn(String changerqesterCn) {
		this.changerqesterCn = changerqesterCn;
	}
	/**
	 * @return
	 * @uml.property  name="opetrId"
	 */
	public String getOpetrId() {
		return opetrId;
	}
	/**
	 * @param opetrId
	 * @uml.property  name="opetrId"
	 */
	public void setOpetrId(String opetrId) {
		this.opetrId = opetrId;
	}
	/**
	 * @return
	 * @uml.property  name="processDe"
	 */
	public String getProcessDe() {
		return processDe;
	}
	/**
	 * @param processDe
	 * @uml.property  name="processDe"
	 */
	public void setProcessDe(String processDe) {
		this.processDe = processDe;
	}
	/**
	 * @return
	 * @uml.property  name="processSttus"
	 */
	public String getProcessSttus() {
		return processSttus;
	}
	/**
	 * @param processSttus
	 * @uml.property  name="processSttus"
	 */
	public void setProcessSttus(String processSttus) {
		this.processSttus = processSttus;
	}
	/**
	 * @return
	 * @uml.property  name="progrmFileNm"
	 */
	public String getProgrmFileNm() {
		return progrmFileNm;
	}
	/**
	 * @param progrmFileNm
	 * @uml.property  name="progrmFileNm"
	 */
	public void setProgrmFileNm(String progrmFileNm) {
		this.progrmFileNm = progrmFileNm;
	}
	/**
	 * @return
	 * @uml.property  name="rqesterDe"
	 */
	public String getRqesterDe() {
		return rqesterDe;
	}
	/**
	 * @param rqesterDe
	 * @uml.property  name="rqesterDe"
	 */
	public void setRqesterDe(String rqesterDe) {
		this.rqesterDe = rqesterDe;
	}
	/**
	 * @return
	 * @uml.property  name="rqesterNo"
	 */
	public int getRqesterNo() {
		return rqesterNo;
	}
	/**
	 * @param rqesterNo
	 * @uml.property  name="rqesterNo"
	 */
	public void setRqesterNo(int rqesterNo) {
		this.rqesterNo = rqesterNo;
	}
	/**
	 * @return
	 * @uml.property  name="rqesterpersonId"
	 */
	public String getRqesterpersonId() {
		return rqesterpersonId;
	}
	/**
	 * @param rqesterpersonId
	 * @uml.property  name="rqesterpersonId"
	 */
	public void setRqesterpersonId(String rqesterpersonId) {
		this.rqesterpersonId = rqesterpersonId;
	}
	/**
	 * @return
	 * @uml.property  name="rqesterProcessCn"
	 */
	public String getRqesterProcessCn() {
		return rqesterProcessCn;
	}
	/**
	 * @param rqesterProcessCn
	 * @uml.property  name="rqesterProcessCn"
	 */
	public void setRqesterProcessCn(String rqesterProcessCn) {
		this.rqesterProcessCn = rqesterProcessCn;
	}
	/**
	 * @return
	 * @uml.property  name="rqesterSj"
	 */
	public String getRqesterSj() {
		return rqesterSj;
	}
	/**
	 * @param rqesterSj
	 * @uml.property  name="rqesterSj"
	 */
	public void setRqesterSj(String rqesterSj) {
		this.rqesterSj = rqesterSj;
	}
	/**
	 * 처리상태코드
	 * @uml.property  name="processSttus"
	 */
	private String processSttus;
	/**
	 * 프로그램파일명
	 * @uml.property  name="progrmFileNm"
	 */
	private String progrmFileNm;
	/**
	 * 요청일자
	 * @uml.property  name="rqesterDe"
	 */
	private String rqesterDe;
	/**
	 * 요청번호
	 * @uml.property  name="rqesterNo"
	 */
	private int rqesterNo;
	/**
	 * 요청자ID
	 * @uml.property  name="rqesterpersonId"
	 */
	private String rqesterpersonId;
	/**
	 * 요청처리내용
	 * @uml.property  name="rqesterProcessCn"
	 */
	private String rqesterProcessCn;
	/**
	 * 요청제목
	 * @uml.property  name="rqesterSj"
	 */
	private String rqesterSj;
}