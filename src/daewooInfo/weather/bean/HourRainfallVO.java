package daewooInfo.weather.bean;

import daewooInfo.cmmn.bean.ComDefaultVO;

public class HourRainfallVO extends ComDefaultVO{
	
	/**
	 * serialVersionUID
	 */
	private static final long serialVersionUID = 1L;
	
	/**
	 * 측정소번호
	 * @uml.property  name="branch_no"
	 */
	private String branch_no;
	/**
	 * 해당 지역 이름
	 * @uml.property  name="regionName"
	 */
	private String regionName;
	/**
	 * 해당 공구 코드
	 * @uml.property  name="factCode"
	 */
	private String factCode;
	/**
	 * 해당 공구 이름
	 * @uml.property  name="factName"
	 */
	private String factName;
	/**
	 * 측정소 이름
	 * @uml.property  name="branch_name"
	 */
	private String branch_name;
	
	/**
	 * @uml.property  name="measu_date"
	 */
	private String measu_date;
	
	/**
	 * @uml.property  name="measu_time"
	 */
	private String measu_time;
	
	/**
	 * @uml.property  name="hour_rainfall"
	 */
	private String hour_rainfall;
	
	/**
	 * @uml.property  name="acc_rainfall"
	 */
	private String acc_rainfall;
	
	/*
	 * 검색용
	 */
	/**
	 * @uml.property  name="frDate"
	 */
	private String frDate;
    /**
	 * @uml.property  name="toDate"
	 */
    private String toDate;
    /**
	 * @uml.property  name="frTime"
	 */
    private String frTime;
    /**
	 * @uml.property  name="toTime"
	 */
    private String toTime;
    /**
	 * @uml.property  name="sys"
	 */
    private String sys;

    /**
	 * @uml.property  name="river_name"
	 */
    private String river_name;
    
    /**
	 * @uml.property  name="river_div"
	 */
    private String river_div;
    
    /**
	 * @uml.property  name="fcast_flag"
	 */
    private String fcast_flag;

    private String stationName;
    
    private String userId;
    
    private String userGubun;
    
	/**
	 * @return
	 * @uml.property  name="branch_no"
	 */
	public String getBranch_no() {
		return branch_no;
	}

	/**
	 * @param branch_no
	 * @uml.property  name="branch_no"
	 */
	public void setBranch_no(String branch_no) {
		this.branch_no = branch_no;
	}

	/**
	 * @return
	 * @uml.property  name="regionName"
	 */
	public String getRegionName() {
		return regionName;
	}

	/**
	 * @param regionName
	 * @uml.property  name="regionName"
	 */
	public void setRegionName(String regionName) {
		this.regionName = regionName;
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
	 * @uml.property  name="branch_name"
	 */
	public String getBranch_name() {
		return branch_name;
	}

	/**
	 * @param branch_name
	 * @uml.property  name="branch_name"
	 */
	public void setBranch_name(String branch_name) {
		this.branch_name = branch_name;
	}

	/**
	 * @return
	 * @uml.property  name="measu_date"
	 */
	public String getMeasu_date() {
		return measu_date;
	}

	/**
	 * @param measu_date
	 * @uml.property  name="measu_date"
	 */
	public void setMeasu_date(String measu_date) {
		this.measu_date = measu_date;
	}

	/**
	 * @return
	 * @uml.property  name="measu_time"
	 */
	public String getMeasu_time() {
		return measu_time;
	}

	/**
	 * @param measu_time
	 * @uml.property  name="measu_time"
	 */
	public void setMeasu_time(String measu_time) {
		this.measu_time = measu_time;
	}

	/**
	 * @return
	 * @uml.property  name="hour_rainfall"
	 */
	public String getHour_rainfall() {
		return hour_rainfall;
	}

	/**
	 * @param hour_rainfall
	 * @uml.property  name="hour_rainfall"
	 */
	public void setHour_rainfall(String hour_rainfall) {
		this.hour_rainfall = hour_rainfall;
	}

	/**
	 * @return
	 * @uml.property  name="acc_rainfall"
	 */
	public String getAcc_rainfall() {
		return acc_rainfall;
	}

	/**
	 * @param acc_rainfall
	 * @uml.property  name="acc_rainfall"
	 */
	public void setAcc_rainfall(String acc_rainfall) {
		this.acc_rainfall = acc_rainfall;
	}

	/**
	 * @return
	 * @uml.property  name="frDate"
	 */
	public String getFrDate() {
		return frDate;
	}

	/**
	 * @param frDate
	 * @uml.property  name="frDate"
	 */
	public void setFrDate(String frDate) {
		this.frDate = frDate;
	}

	/**
	 * @return
	 * @uml.property  name="toDate"
	 */
	public String getToDate() {
		return toDate;
	}

	/**
	 * @param toDate
	 * @uml.property  name="toDate"
	 */
	public void setToDate(String toDate) {
		this.toDate = toDate;
	}

	/**
	 * @return
	 * @uml.property  name="frTime"
	 */
	public String getFrTime() {
		return frTime;
	}

	/**
	 * @param frTime
	 * @uml.property  name="frTime"
	 */
	public void setFrTime(String frTime) {
		this.frTime = frTime;
	}

	/**
	 * @return
	 * @uml.property  name="toTime"
	 */
	public String getToTime() {
		return toTime;
	}

	/**
	 * @param toTime
	 * @uml.property  name="toTime"
	 */
	public void setToTime(String toTime) {
		this.toTime = toTime;
	}

	/**
	 * @return
	 * @uml.property  name="sys"
	 */
	public String getSys() {
		return sys;
	}

	/**
	 * @param sys
	 * @uml.property  name="sys"
	 */
	public void setSys(String sys) {
		this.sys = sys;
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
	 * @uml.property  name="fcast_flag"
	 */
	public String getFcast_flag() {
		return fcast_flag;
	}

	/**
	 * @param fcast_flag
	 * @uml.property  name="fcast_flag"
	 */
	public void setFcast_flag(String fcast_flag) {
		this.fcast_flag = fcast_flag;
	}

	public static long getSerialVersionUID() {
		return serialVersionUID;
	}

	public String getStationName() {
		return stationName;
	}

	public void setStationName(String stationName) {
		this.stationName = stationName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserGubun() {
		return userGubun;
	}

	public void setUserGubun(String userGubun) {
		this.userGubun = userGubun;
	}
	
	
}
