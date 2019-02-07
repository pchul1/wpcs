package daewooInfo.stats.bean;

/**
 * 상황전파통계 VO 클래스
 * @author 김태훈
 * @since 2010.06.28
 * @version 1.0
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일      수정자           수정내용
 *  -------    --------    ---------------------------
 *   2010.6.28  김태훈          최초 생성
 *
 * </pre>
 */
public class StatsSpreadVO {
	//수계번호
	/**
	 * @uml.property  name="riverId"
	 */
	private String riverId;
	
	//수계명
	/**
	 * @uml.property  name="riverName"
	 */
	private String riverName;
	
	//공구번호
	/**
	 * @uml.property  name="factCode"
	 */
	private String factCode;
	
	//공구명
	/**
	 * @uml.property  name="factName"
	 */
	private String factName;
	
	//측정소번호
	/**
	 * @uml.property  name="branchNo"
	 */
	private String branchNo;	
	
	//시간
	/**
	 * @uml.property  name="timeFrm"
	 */
	private String timeFrm;
	
	//시간
	/**
	 * @uml.property  name="time"
	 */
	private String time;
	
	//측정코드
	/**
	 * @uml.property  name="itemCode"
	 */
	private String itemCode;
	
	//측정기준명
	/**
	 * @uml.property  name="itemName"
	 */
	private String itemName;
	
	//SMS 성공
	/**
	 * @uml.property  name="smsSucc"
	 */
	private String smsSucc;
	
	//SMS 실패
	/**
	 * @uml.property  name="smsFail"
	 */
	private String smsFail;
	
	//ACS 성공
	/**
	 * @uml.property  name="acsSucc"
	 */
	private String acsSucc;

	//ACS 실패
	/**
	 * @uml.property  name="acsFail"
	 */
	private String acsFail;

	/**
	 * @return
	 * @uml.property  name="riverId"
	 */
	public String getRiverId() {
		return riverId;
	}

	/**
	 * @param riverId
	 * @uml.property  name="riverId"
	 */
	public void setRiverId(String riverId) {
		this.riverId = riverId;
	}

	/**
	 * @return
	 * @uml.property  name="riverName"
	 */
	public String getRiverName() {
		return riverName;
	}

	/**
	 * @param riverName
	 * @uml.property  name="riverName"
	 */
	public void setRiverName(String riverName) {
		this.riverName = riverName;
	}

	/**
	 * @return
	 * @uml.property  name="factCode"
	 */
	public String getFactCode() {
		return factCode;
	}

	/**
	 * @param factCode
	 * @uml.property  name="factCode"
	 */
	public void setFactCode(String factCode) {
		this.factCode = factCode;
	}

	/**
	 * @return
	 * @uml.property  name="factName"
	 */
	public String getFactName() {
		return factName;
	}

	/**
	 * @param factName
	 * @uml.property  name="factName"
	 */
	public void setFactName(String factName) {
		this.factName = factName;
	}

	/**
	 * @return
	 * @uml.property  name="branchNo"
	 */
	public String getBranchNo() {
		return branchNo;
	}

	/**
	 * @param branchNo
	 * @uml.property  name="branchNo"
	 */
	public void setBranchNo(String branchNo) {
		this.branchNo = branchNo;
	}

	/**
	 * @return
	 * @uml.property  name="timeFrm"
	 */
	public String getTimeFrm() {
		return timeFrm;
	}

	/**
	 * @param timeFrm
	 * @uml.property  name="timeFrm"
	 */
	public void setTimeFrm(String timeFrm) {
		this.timeFrm = timeFrm;
	}

	/**
	 * @return
	 * @uml.property  name="time"
	 */
	public String getTime() {
		return time;
	}

	/**
	 * @param time
	 * @uml.property  name="time"
	 */
	public void setTime(String time) {
		this.time = time;
	}

	/**
	 * @return
	 * @uml.property  name="itemCode"
	 */
	public String getItemCode() {
		return itemCode;
	}

	/**
	 * @param itemCode
	 * @uml.property  name="itemCode"
	 */
	public void setItemCode(String itemCode) {
		this.itemCode = itemCode;
	}

	/**
	 * @return
	 * @uml.property  name="itemName"
	 */
	public String getItemName() {
		return itemName;
	}

	/**
	 * @param itemName
	 * @uml.property  name="itemName"
	 */
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	/**
	 * @return
	 * @uml.property  name="smsSucc"
	 */
	public String getSmsSucc() {
		return smsSucc;
	}

	/**
	 * @param smsSucc
	 * @uml.property  name="smsSucc"
	 */
	public void setSmsSucc(String smsSucc) {
		this.smsSucc = smsSucc;
	}

	/**
	 * @return
	 * @uml.property  name="smsFail"
	 */
	public String getSmsFail() {
		return smsFail;
	}

	/**
	 * @param smsFail
	 * @uml.property  name="smsFail"
	 */
	public void setSmsFail(String smsFail) {
		this.smsFail = smsFail;
	}

	/**
	 * @return
	 * @uml.property  name="acsSucc"
	 */
	public String getAcsSucc() {
		return acsSucc;
	}

	/**
	 * @param acsSucc
	 * @uml.property  name="acsSucc"
	 */
	public void setAcsSucc(String acsSucc) {
		this.acsSucc = acsSucc;
	}

	/**
	 * @return
	 * @uml.property  name="acsFail"
	 */
	public String getAcsFail() {
		return acsFail;
	}

	/**
	 * @param acsFail
	 * @uml.property  name="acsFail"
	 */
	public void setAcsFail(String acsFail) {
		this.acsFail = acsFail;
	}
}
