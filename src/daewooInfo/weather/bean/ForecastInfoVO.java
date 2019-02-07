package daewooInfo.weather.bean;

public class ForecastInfoVO {
	
	 
	/**
	 * 측정소 이름
	 * @uml.property  name="branch_name"
	 */
	private String branch_name;
	/**
	 * 측정소번호
	 * @uml.property  name="branch_no"
	 */
	private String branch_no;
	/**
	 * factCode
	 * @uml.property  name="factCode"
	 */
	private String factCode;
	/**
	 * 해당 공구 이름
	 * @uml.property  name="factName"
	 */ 
	private String factName;
	/**
	 * 발표시간
	 * @uml.property  name="announce_time"
	 */
	private String announce_time;
	/**
	 * 예상 일기
	 * @uml.property  name="current_weather"
	 */
	private String current_weather;
	/**
	 * 예상 기온
	 * @uml.property  name="temp"
	 */
	private String temp;
	/**
	 * 풍향
	 * @uml.property  name="wind_dir"
	 */
	private String wind_dir;
	/**
	 * WEATHER_CODE
	 * @uml.property  name="weather_code"
	 */
	private String weather_code;
	/**
	 * 하늘상황
	 * @uml.property  name="weather_sky"
	 */
	private String weather_sky;
	/**
	 * 강수확률
	 * @uml.property  name="rainfall_probability"
	 */
	private String rainfall_probability;
	/**
	 * 지역이름
	 * @uml.property  name="regionName"
	 */
	private String regionName;
	

	
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
	 * @uml.property  name="weather_sky"
	 */
	public String getWeather_sky() {
		return weather_sky;
	}
	/**
	 * @param weather_sky
	 * @uml.property  name="weather_sky"
	 */
	public void setWeather_sky(String weather_sky) {
		this.weather_sky = weather_sky;
	}
	/**
	 * @return
	 * @uml.property  name="announce_time"
	 */
	public String getAnnounce_time() {
		return announce_time;
	}
	/**
	 * @param announce_time
	 * @uml.property  name="announce_time"
	 */
	public void setAnnounce_time(String announce_time) {
		this.announce_time = announce_time;
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
	 * @uml.property  name="temp"
	 */
	public String getTemp() {
		return temp;
	}
	/**
	 * @param temp
	 * @uml.property  name="temp"
	 */
	public void setTemp(String temp) {
		this.temp = temp;
	}
	/**
	 * @return
	 * @uml.property  name="wind_dir"
	 */
	public String getWind_dir() {
		return wind_dir;
	}
	/**
	 * @param wind_dir
	 * @uml.property  name="wind_dir"
	 */
	public void setWind_dir(String wind_dir) {
		this.wind_dir = wind_dir;
	}
	/**
	 * @return
	 * @uml.property  name="weather_code"
	 */
	public String getWeather_code() {
		return weather_code;
	}
	/**
	 * @param weather_code
	 * @uml.property  name="weather_code"
	 */
	public void setWeather_code(String weather_code) {
		this.weather_code = weather_code;
	}
	/**
	 * @return
	 * @uml.property  name="rainfall_probability"
	 */
	public String getRainfall_probability() {
		return rainfall_probability;
	}
	/**
	 * @param rainfall_probability
	 * @uml.property  name="rainfall_probability"
	 */
	public void setRainfall_probability(String rainfall_probability) {
		this.rainfall_probability = rainfall_probability;
	}
	
	
}
