package daewooInfo.waterpolmnt.waterinfo.bean;

public class FlowDataVO {
	
	/**
	 * 측정소 코드
	 * @uml.property  name="fact_code"
	 */
	private String fact_code;
	/**
	 * 측정소 이름
	 * @uml.property  name="fact_name"
	 */
	private String fact_name;
	/**
	 * 수신시각
	 * @uml.property  name="rcv_date"
	 */
	private String rcv_date;
	/**
	 * 시우량
	 * @uml.property  name="value"
	 */
	private String value;
	/**
	 * 수계
	 * @uml.property  name="river_div"
	 */
	private String river_div;
	/**
	 * 수계 이름
	 * @uml.property  name="river_name"
	 */
	private String river_name;
	
	//유량
	/**
	 * @uml.property  name="fw"
	 */
	private String fw;
	//수위
	/**
	 * @uml.property  name="wl"
	 */
	private String wl;
	
	
	
	/**
	 * @return
	 * @uml.property  name="fw"
	 */
	public String getFw() {
		return fw;
	}
	/**
	 * @param fw
	 * @uml.property  name="fw"
	 */
	public void setFw(String fw) {
		this.fw = fw;
	}
	/**
	 * @return
	 * @uml.property  name="wl"
	 */
	public String getWl() {
		return wl;
	}
	/**
	 * @param wl
	 * @uml.property  name="wl"
	 */
	public void setWl(String wl) {
		this.wl = wl;
	}
	/**
	 * @return
	 * @uml.property  name="fact_name"
	 */
	public String getFact_name() {
		return fact_name;
	}
	/**
	 * @param fact_name
	 * @uml.property  name="fact_name"
	 */
	public void setFact_name(String fact_name) {
		this.fact_name = fact_name;
	}
	/**
	 * @return
	 * @uml.property  name="fact_code"
	 */
	public String getFact_code() {
		return fact_code;
	}
	/**
	 * @param fact_code
	 * @uml.property  name="fact_code"
	 */
	public void setFact_code(String fact_code) {
		this.fact_code = fact_code;
	}
	/**
	 * @return
	 * @uml.property  name="rcv_date"
	 */
	public String getRcv_date() {
		return rcv_date;
	}
	/**
	 * @param rcv_date
	 * @uml.property  name="rcv_date"
	 */
	public void setRcv_date(String rcv_date) {
		this.rcv_date = rcv_date;
	}
	/**
	 * @return
	 * @uml.property  name="value"
	 */
	public String getValue() {
		return value;
	}
	/**
	 * @param value
	 * @uml.property  name="value"
	 */
	public void setValue(String value) {
		this.value = value;
	}
	/**
	 * @return
	 * @uml.property  name="river_div"
	 */
	public String getRiver_div() {
		return river_div;
	}
	/**
	 * @param river_div
	 * @uml.property  name="river_div"
	 */
	public void setRiver_div(String river_div) {
		this.river_div = river_div;
	}
	/**
	 * @return
	 * @uml.property  name="river_name"
	 */
	public String getRiver_name() {
		return river_name;
	}
	/**
	 * @param river_name
	 * @uml.property  name="river_name"
	 */
	public void setRiver_name(String river_name) {
		this.river_name = river_name;
	}
	
	
}
