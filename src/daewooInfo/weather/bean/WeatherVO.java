package daewooInfo.weather.bean;

public class  WeatherVO{

	/**
	 * 시간 구분 (HOUR_DIV) 0 : 오전부터 시작 1 : 오후부터 시작
	 * @uml.property  name="hourDiv"
	 */
	private String hourDiv;

	/**
	 * 현재 기온 (TODY_TEMP)
	 * @uml.property  name="temperature"
	 */
	private String temperature;

	/**
	 * 예상 기온 (TEMP1 ~ 4)
	 * @uml.property  name="suppositionTemperature1"
	 */
	private String suppositionTemperature1;

	/**
	 * 예상 기온 (TEMP1 ~ 4)
	 * @uml.property  name="suppositionTemperature2"
	 */
	private String suppositionTemperature2;

	/**
	 * 예상 기온 (TEMP1 ~ 4)
	 * @uml.property  name="suppositionTemperature3"
	 */
	private String suppositionTemperature3;

	/**
	 * 예상 기온 (TEMP1 ~ 4)
	 * @uml.property  name="suppositionTemperature4"
	 */
	private String suppositionTemperature4;

	/**
	 * @uml.property  name="current_weather"
	 */
	private String current_weather;
	/**
	 * 날씨 코드 DB010 : 맑음 DB020 : 구름조금 DB030 : 구름많음 DB040 : 흐림 (WTHR_CD1~4)
	 * @uml.property  name="forecast1"
	 */
	private String forecast1;

	/**
	 * 날씨 코드 DB010 : 맑음 DB020 : 구름조금 DB030 : 구름많음 DB040 : 흐림 (WTHR_CD1~4)
	 * @uml.property  name="forecast2"
	 */
	private String forecast2;

	/**
	 * 날씨 코드 DB010 : 맑음 DB020 : 구름조금 DB030 : 구름많음 DB040 : 흐림 (WTHR_CD1~4)
	 * @uml.property  name="forecast3"
	 */
	private String forecast3;

	/**
	 * 날씨 코드 DB010 : 맑음 DB020 : 구름조금 DB030 : 구름많음 DB040 : 흐림 (WTHR_CD1~4)
	 * @uml.property  name="forecast4"
	 */
	private String forecast4;
	
	/**
	 * @uml.property  name="forecastCode1"
	 */
	private String forecastCode1;

	/**
	 * @uml.property  name="forecastCode2"
	 */
	private String forecastCode2;

	/**
	 * @uml.property  name="forecastCode3"
	 */
	private String forecastCode3;

	/**
	 * @uml.property  name="forecastCode4"
	 */
	private String forecastCode4;

	/**
	 * 기상 정보를 등록한 시간 (RGST_DNT)
	 * @uml.property  name="registDate"
	 */
	private java.util.Date registDate;

	/**
	 * 현재 날씨코드 (TODY_WTHR_CD)
	 * @uml.property  name="todyWthrCd"
	 */
	private String todyWthrCd;
	
	/**
	 * @uml.property  name="todyWthr"
	 */
	private String todyWthr;

	/**
	 * @uml.property  name="factName"
	 */
	private String factName;
	
	/**
	 * @uml.property  name="riverId"
	 */
	private String riverId;
	
	/**
	 * @uml.property  name="regionName"
	 */
	private String regionName;
	
	/**
	 * @uml.property  name="announceTime"
	 */
	private String announceTime;
	
	/**
	 * @uml.property  name="rainfallProbability"
	 */
	private String rainfallProbability;
	
	/**
	 * @uml.property  name="windDirection"
	 */
	private String windDirection;
	
	/**
	 * @uml.property  name="branch_name"
	 */
	private String branch_name;
	
	
	

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
	 * @uml.property  name="current_weather"
	 */
	public String getCurrent_weather() {
		return current_weather;
	}



	/**
	 * @param current_weather
	 * @uml.property  name="current_weather"
	 */
	public void setCurrent_weather(String current_weather) {
		this.current_weather = current_weather;
	}



	/**
	 * @return
	 * @uml.property  name="announceTime"
	 */
	public String getAnnounceTime() {
		return announceTime;
	}



	/**
	 * @param announceTime
	 * @uml.property  name="announceTime"
	 */
	public void setAnnounceTime(String announceTime) {
		this.announceTime = announceTime;
	}



	/**
	 * @return
	 * @uml.property  name="rainfallProbability"
	 */
	public String getRainfallProbability() {
		return rainfallProbability;
	}



	/**
	 * @param rainfallProbability
	 * @uml.property  name="rainfallProbability"
	 */
	public void setRainfallProbability(String rainfallProbability) {
		this.rainfallProbability = rainfallProbability;
	}



	/**
	 * @return
	 * @uml.property  name="windDirection"
	 */
	public String getWindDirection() {
		return windDirection;
	}



	/**
	 * @param windDirection
	 * @uml.property  name="windDirection"
	 */
	public void setWindDirection(String windDirection) {
		this.windDirection = windDirection;
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
	 * @uml.property  name="todyWthr"
	 */
	public String getTodyWthr() {
		return todyWthr;
	}



	/**
	 * @param todyWthr
	 * @uml.property  name="todyWthr"
	 */
	public void setTodyWthr(String todyWthr) {
		this.todyWthr = todyWthr;
	}



	public WeatherVO(){}

	
	
	/**
	 * @return
	 * @uml.property  name="forecastCode1"
	 */
	public String getForecastCode1() {
		return forecastCode1;
	}



	/**
	 * @param forcastCode1
	 * @uml.property  name="forecastCode1"
	 */
	public void setForecastCode1(String forcastCode1) {
		this.forecastCode1 = forcastCode1;
	}



	/**
	 * @return
	 * @uml.property  name="forecastCode2"
	 */
	public String getForecastCode2() {
		return forecastCode2;
	}



	/**
	 * @param forecastCode2
	 * @uml.property  name="forecastCode2"
	 */
	public void setForecastCode2(String forecastCode2) {
		this.forecastCode2 = forecastCode2;
	}



	/**
	 * @return
	 * @uml.property  name="forecastCode3"
	 */
	public String getForecastCode3() {
		return forecastCode3;
	}



	/**
	 * @param forecastCode3
	 * @uml.property  name="forecastCode3"
	 */
	public void setForecastCode3(String forecastCode3) {
		this.forecastCode3 = forecastCode3;
	}



	/**
	 * @return
	 * @uml.property  name="forecastCode4"
	 */
	public String getForecastCode4() {
		return forecastCode4;
	}



	/**
	 * @param forecastCode4
	 * @uml.property  name="forecastCode4"
	 */
	public void setForecastCode4(String forecastCode4) {
		this.forecastCode4 = forecastCode4;
	}



	/**
	 * @return
	 * @uml.property  name="hourDiv"
	 */
	public String getHourDiv() {
		return hourDiv;
	}

	/**
	 * @param hourDiv
	 * @uml.property  name="hourDiv"
	 */
	public void setHourDiv(String hourDiv) {
		this.hourDiv = hourDiv;
	}

	/**
	 * @return
	 * @uml.property  name="temperature"
	 */
	public String getTemperature() {
		return temperature;
	}

	/**
	 * @param temperature
	 * @uml.property  name="temperature"
	 */
	public void setTemperature(String temperature) {
		this.temperature = temperature;
	}

	/**
	 * @return
	 * @uml.property  name="suppositionTemperature1"
	 */
	public String getSuppositionTemperature1() {
		return suppositionTemperature1;
	}

	/**
	 * @param suppositionTemperature1
	 * @uml.property  name="suppositionTemperature1"
	 */
	public void setSuppositionTemperature1(String suppositionTemperature1) {
		this.suppositionTemperature1 = suppositionTemperature1;
	}

	/**
	 * @return
	 * @uml.property  name="suppositionTemperature2"
	 */
	public String getSuppositionTemperature2() {
		return suppositionTemperature2;
	}

	/**
	 * @param suppositionTemperature2
	 * @uml.property  name="suppositionTemperature2"
	 */
	public void setSuppositionTemperature2(String suppositionTemperature2) {
		this.suppositionTemperature2 = suppositionTemperature2;
	}

	/**
	 * @return
	 * @uml.property  name="suppositionTemperature3"
	 */
	public String getSuppositionTemperature3() {
		return suppositionTemperature3;
	}

	/**
	 * @param suppositionTemperature3
	 * @uml.property  name="suppositionTemperature3"
	 */
	public void setSuppositionTemperature3(String suppositionTemperature3) {
		this.suppositionTemperature3 = suppositionTemperature3;
	}

	/**
	 * @return
	 * @uml.property  name="suppositionTemperature4"
	 */
	public String getSuppositionTemperature4() {
		return suppositionTemperature4;
	}

	/**
	 * @param suppositionTemperature4
	 * @uml.property  name="suppositionTemperature4"
	 */
	public void setSuppositionTemperature4(String suppositionTemperature4) {
		this.suppositionTemperature4 = suppositionTemperature4;
	}

	/**
	 * @return
	 * @uml.property  name="forecast1"
	 */
	public String getForecast1() {
		return forecast1;
	}

	/**
	 * @param forecast1
	 * @uml.property  name="forecast1"
	 */
	public void setForecast1(String forecast1) {
		this.forecast1 = forecast1;
	}

	/**
	 * @return
	 * @uml.property  name="forecast2"
	 */
	public String getForecast2() {
		return forecast2;
	}

	/**
	 * @param forecast2
	 * @uml.property  name="forecast2"
	 */
	public void setForecast2(String forecast2) {
		this.forecast2 = forecast2;
	}

	/**
	 * @return
	 * @uml.property  name="forecast3"
	 */
	public String getForecast3() {
		return forecast3;
	}

	/**
	 * @param forecast3
	 * @uml.property  name="forecast3"
	 */
	public void setForecast3(String forecast3) {
		this.forecast3 = forecast3;
	}

	/**
	 * @return
	 * @uml.property  name="forecast4"
	 */
	public String getForecast4() {
		return forecast4;
	}

	/**
	 * @param forecast4
	 * @uml.property  name="forecast4"
	 */
	public void setForecast4(String forecast4) {
		this.forecast4 = forecast4;
	}

	/**
	 * @return
	 * @uml.property  name="registDate"
	 */
	public java.util.Date getRegistDate() {
		return registDate;
	}

	/**
	 * @param registDate
	 * @uml.property  name="registDate"
	 */
	public void setRegistDate(java.util.Date registDate) {
		this.registDate = registDate;
	}

	/**
	 * @return
	 * @uml.property  name="todyWthrCd"
	 */
	public String getTodyWthrCd() {
		return todyWthrCd;
	}

	/**
	 * @param todyWthrCd
	 * @uml.property  name="todyWthrCd"
	 */
	public void setTodyWthrCd(String todyWthrCd) {
		this.todyWthrCd = todyWthrCd;
	}
}
