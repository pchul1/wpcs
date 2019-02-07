package daewooInfo.alert.bean;

/**
 * @author DaeWoo Information Systems Co., Ltd.  Technical Expert Team. khanian.
 * @version 1.0
 * @Class Name : .java
 * @Description :  Class
 * @Modification Information
 * @
 * @ Modify Date     author               Modify Contents
 * @ --------------  ------------   -------------------------------
 * @ 2010. 5. 19  	 khanian              new
 * @see Copyright (C) by DaeWoo Information Systems Co., Ltd. All right reserved.
 * @since 2010. 1. 21
 */

public class AlertStepLastVO {
	/**
	 * @uml.property  name="asId"
	 */
	private String asId;
	/**
	 * @uml.property  name="alertStep"
	 */
	private String alertStep;
	/**
	 * @uml.property  name="alertTime"
	 */
	private String alertTime;
	/**
	 * @uml.property  name="alertCount"
	 */
	private int alertCount;
	/**
	 * @uml.property  name="timeDiff"
	 */
	private double timeDiff;
	/**
	 * @uml.property  name="minOr"
	 */
	private String minOr;
	/**
	 * @uml.property  name="alertAutoProcess"
	 */
	private String alertAutoProcess; //자동경보작동여부 
	 
	/**
	 * @return
	 * @uml.property  name="alertAutoProcess"
	 */
	public String getAlertAutoProcess() {
		return alertAutoProcess;
	}
	/**
	 * @param alertAutoProcess
	 * @uml.property  name="alertAutoProcess"
	 */
	public void setAlertAutoProcess(String alertAutoProcess) {
		this.alertAutoProcess = alertAutoProcess;
	}
	/**
	 * @return
	 * @uml.property  name="asId"
	 */
	public String getAsId() {
		return asId;
	}
	/**
	 * @param asId
	 * @uml.property  name="asId"
	 */
	public void setAsId(String asId) {
		this.asId = asId;
	}
	/**
	 * @return
	 * @uml.property  name="alertStep"
	 */
	public String getAlertStep() {
		return alertStep;
	}
	/**
	 * @param alertStep
	 * @uml.property  name="alertStep"
	 */
	public void setAlertStep(String alertStep) {
		this.alertStep = alertStep;
	}
	/**
	 * @return
	 * @uml.property  name="alertTime"
	 */
	public String getAlertTime() {
		return alertTime;
	}
	/**
	 * @param alertTime
	 * @uml.property  name="alertTime"
	 */
	public void setAlertTime(String alertTime) {
		this.alertTime = alertTime;
	}
	/**
	 * @return
	 * @uml.property  name="alertCount"
	 */
	public int getAlertCount() {
		return alertCount;
	}
	/**
	 * @param alertCount
	 * @uml.property  name="alertCount"
	 */
	public void setAlertCount(int alertCount) {
		this.alertCount = alertCount;
	}
	/**
	 * @return
	 * @uml.property  name="timeDiff"
	 */
	public double getTimeDiff() {
		return timeDiff;
	}
	/**
	 * @param timeDiff
	 * @uml.property  name="timeDiff"
	 */
	public void setTimeDiff(double timeDiff) {
		this.timeDiff = timeDiff;
	}
	/**
	 * @return
	 * @uml.property  name="minOr"
	 */
	public String getMinOr() {
		return minOr;
	}
	/**
	 * @param minOr
	 * @uml.property  name="minOr"
	 */
	public void setMinOr(String minOr) {
		this.minOr = minOr;
	}	
}	
