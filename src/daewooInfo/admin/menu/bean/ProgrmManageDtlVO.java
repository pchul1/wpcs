package daewooInfo.admin.menu.bean;

/** 
 * 프로그램변경관리 처리를 위한 VO 클래스르를 정의한다
 * @author 개발환경 개발팀 이용
 * @since 2009.06.01
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2009.03.20  이  용          최초 생성
 *
 * </pre>
 */

public class ProgrmManageDtlVO{

	/**
	 * 프로그램파일명
	 * @uml.property  name="progrmFileNm"
	 */
	private String progrmFileNm;
	/**
	 * 요청번호
	 * @uml.property  name="rqesterNo"
	 */
	private int rqesterNo;
	/**
	 * 요청제목
	 * @uml.property  name="rqesterSj"
	 */
	private String rqesterSj;
	/**
	 * 요청자ID
	 * @uml.property  name="rqesterPersonId"
	 */
	private String rqesterPersonId;
	/**
	 * 요청일자
	 * @uml.property  name="rqesterDe"
	 */
	private String rqesterDe;
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
	 * 처리상태코드
	 * @uml.property  name="processSttus"
	 */
	private String processSttus;
	/**
	 * 처리일자
	 * @uml.property  name="processDe"
	 */
	private String processDe;
	/**
	 * 요청처리내용
	 * @uml.property  name="rqesterProcessCn"
	 */
	private String rqesterProcessCn;

	/**
	 * 요청시작일자
	 * @uml.property  name="rqesterDeBegin"
	 */
	private String rqesterDeBegin;
	/**
	 * 요청종료일자
	 * @uml.property  name="rqesterDeEnd"
	 */
	private String rqesterDeEnd;
	
	/**
	 * 프로그램파일명
	 * @uml.property  name="tmp_progrmNm"
	 */
	private String tmp_progrmNm;
	/**
	 * 요청번호
	 * @uml.property  name="tmp_rqesterNo"
	 */
	private int tmp_rqesterNo;
    /**
	 * tmp_Email
	 * @uml.property  name="tmp_Email"
	 */
    private   String   tmp_Email;
	
	/**
	 * progrmFileNm attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="progrmFileNm"
	 */
	public String getProgrmFileNm() {
		return progrmFileNm;
	}
	/**
	 * progrmFileNm attribute 값을 설정한다.
	 * @param progrmFileNm  String
	 * @uml.property  name="progrmFileNm"
	 */
	public void setProgrmFileNm(String progrmFileNm) {
		this.progrmFileNm = progrmFileNm;
	}
	/**
	 * rqesterNo attribute를 리턴한다.
	 * @return  int
	 * @uml.property  name="rqesterNo"
	 */
	public int getRqesterNo() {
		return rqesterNo;
	}
	/**
	 * rqesterNo attribute 값을 설정한다.
	 * @param rqesterNo  int
	 * @uml.property  name="rqesterNo"
	 */
	public void setRqesterNo(int rqesterNo) {
		this.rqesterNo = rqesterNo;
	}
	/**
	 * rqesterSj attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="rqesterSj"
	 */
	public String getRqesterSj() {
		return rqesterSj;
	}
	/**
	 * rqesterSj attribute 값을 설정한다.
	 * @param rqesterSj  String
	 * @uml.property  name="rqesterSj"
	 */
	public void setRqesterSj(String rqesterSj) {
		this.rqesterSj = rqesterSj;
	}
	/**
	 * rqesterPersonId attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="rqesterPersonId"
	 */
	public String getRqesterPersonId() {
		return rqesterPersonId;
	}
	/**
	 * rqesterPersonId attribute 값을 설정한다.
	 * @param rqesterPersonId  String
	 * @uml.property  name="rqesterPersonId"
	 */
	public void setRqesterPersonId(String rqesterPersonId) {
		this.rqesterPersonId = rqesterPersonId;
	}
	/**
	 * rqesterDe attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="rqesterDe"
	 */
	public String getRqesterDe() {
		return rqesterDe;
	}
	/**
	 * rqesterDe attribute 값을 설정한다.
	 * @param rqesterDe  String
	 * @uml.property  name="rqesterDe"
	 */
	public void setRqesterDe(String rqesterDe) {
		this.rqesterDe = rqesterDe;
	}
	/**
	 * changerqesterCn attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="changerqesterCn"
	 */
	public String getChangerqesterCn() {
		return changerqesterCn;
	}
	/**
	 * changerqesterCn attribute 값을 설정한다.
	 * @param changerqesterCn  String
	 * @uml.property  name="changerqesterCn"
	 */
	public void setChangerqesterCn(String changerqesterCn) {
		this.changerqesterCn = changerqesterCn;
	}
	/**
	 * opetrId attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="opetrId"
	 */
	public String getOpetrId() {
		return opetrId;
	}
	/**
	 * opetrId attribute 값을 설정한다.
	 * @param opetrId  String
	 * @uml.property  name="opetrId"
	 */
	public void setOpetrId(String opetrId) {
		this.opetrId = opetrId;
	}
	/**
	 * processSttus attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="processSttus"
	 */
	public String getProcessSttus() {
		return processSttus;
	}
	/**
	 * processSttus attribute 값을 설정한다.
	 * @param processSttus  String
	 * @uml.property  name="processSttus"
	 */
	public void setProcessSttus(String processSttus) {
		this.processSttus = processSttus;
	}
	/**
	 * processDe attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="processDe"
	 */
	public String getProcessDe() {
		return processDe;
	}
	/**
	 * processDe attribute 값을 설정한다.
	 * @param processDe  String
	 * @uml.property  name="processDe"
	 */
	public void setProcessDe(String processDe) {
		this.processDe = processDe;
	}
	/**
	 * rqesterProcessCn attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="rqesterProcessCn"
	 */
	public String getRqesterProcessCn() {
		return rqesterProcessCn;
	}
	/**
	 * rqesterProcessCn attribute 값을 설정한다.
	 * @param rqesterProcessCn  String
	 * @uml.property  name="rqesterProcessCn"
	 */
	public void setRqesterProcessCn(String rqesterProcessCn) {
		this.rqesterProcessCn = rqesterProcessCn;
	}
	/**
	 * rqesterDeBegin attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="rqesterDeBegin"
	 */
	public String getRqesterDeBegin() {
		return rqesterDeBegin;
	}
	/**
	 * rqesterDeBegin attribute 값을 설정한다.
	 * @param rqesterDeBegin  String
	 * @uml.property  name="rqesterDeBegin"
	 */
	public void setRqesterDeBegin(String rqesterDeBegin) {
		this.rqesterDeBegin = rqesterDeBegin;
	}
	/**
	 * rqesterDeEnd attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="rqesterDeEnd"
	 */
	public String getRqesterDeEnd() {
		return rqesterDeEnd;
	}
	/**
	 * rqesterDeEnd attribute 값을 설정한다.
	 * @param rqesterDeEnd  String
	 * @uml.property  name="rqesterDeEnd"
	 */
	public void setRqesterDeEnd(String rqesterDeEnd) {
		this.rqesterDeEnd = rqesterDeEnd;
	}
	/**
	 * tmp_progrmNm attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="tmp_progrmNm"
	 */
	public String getTmp_progrmNm() {
		return tmp_progrmNm;
	}
	/**
	 * tmp_progrmNm attribute 값을 설정한다.
	 * @param tmp_progrmNm  String
	 * @uml.property  name="tmp_progrmNm"
	 */
	public void setTmp_progrmNm(String tmp_progrmNm) {
		this.tmp_progrmNm = tmp_progrmNm;
	}
	/**
	 * tmp_rqesterNo attribute를 리턴한다.
	 * @return  int
	 * @uml.property  name="tmp_rqesterNo"
	 */
	public int getTmp_rqesterNo() {
		return tmp_rqesterNo;
	}
	/**
	 * tmp_rqesterNo attribute 값을 설정한다.
	 * @param tmp_rqesterNo  int
	 * @uml.property  name="tmp_rqesterNo"
	 */
	public void setTmp_rqesterNo(int tmp_rqesterNo) {
		this.tmp_rqesterNo = tmp_rqesterNo;
	}

	/**
	 * tmp_Email attribute를 리턴한다.
	 * @return  String
	 * @uml.property  name="tmp_Email"
	 */
	public String getTmp_Email() {
		return tmp_Email;
	}
	/**
	 * tmp_Email attribute 값을 설정한다.
	 * @param tmp_Email  String
	 * @uml.property  name="tmp_Email"
	 */
	public void setTmp_Email(String tmp_Email) {
		this.tmp_Email = tmp_Email;
	}
}