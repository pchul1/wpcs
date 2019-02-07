package daewooInfo.weather.service;

import java.util.List;

import daewooInfo.waterpolmnt.waterinfo.bean.SearchTaksuVO;
import daewooInfo.weather.bean.ForecastInfoVO;
import daewooInfo.weather.bean.HourRainfallVO;
import daewooInfo.weather.bean.WarningDataVO;
import daewooInfo.weather.bean.WeatherAreaVO;
import daewooInfo.weather.bean.WeatherInfoVO;
import daewooInfo.weather.bean.WeatherVO;

/**
 * @author  hyun
 */
public interface WeatherService {
	
	WeatherInfoVO getWeatherInfo(String river_id, String river_sq);
	
	List<WeatherInfoVO> getWeatherInfo(String river_sq);
	
	List<WeatherInfoVO> getAreaCode(String river_id, String sys_kind);
	
	//공구별 구역코드정보를 불러옵니다. (SEQ순서)
	List<ForecastInfoVO> getAreaForecast(String river_id, String sys_kind);
	
	/**
	 * FACT_CODE 공구의 Time 시간의 기상정보를 가져옵니다.
	 * @param factCode
	 * @param time
	 * @return
	 */
	WeatherInfoVO getCurrentWeather(String factCode, String time);
	WeatherInfoVO getCurrentWeather(String factCode, String branchNo, String time);
	
	/**
	 * 기상예보를 가져옵니다
	 * @param factCode
	 * @param time
	 * @return
	 */
	ForecastInfoVO getForecast(String factCode);
	
	
	/**
	 * 현재 기상특보를 가져옵니다.
	 * @return
	 * @uml.property  name="weatherWarning"
	 * @uml.associationEnd  
	 */
	WarningDataVO getWeatherWarning();
	
	/**
	 * 마지막 SQ를 가져옵니다.
	 * @param river_id
	 * @return
	 */
	Integer getLastSeq(String river_id);
	
	
	/**
	 * 기상 이력 조회용
	 * @param weatherInfoVO
	 * @return
	 */
	public List<WeatherInfoVO> getWeatherInfoList(WeatherInfoVO weatherInfoVO) throws Exception;
	

	public int getWeatherInfoList_cnt(WeatherInfoVO weatherInfoVO) throws Exception;
	
	public List<WeatherInfoVO> getWeatherInfoList_forExcel(WeatherInfoVO weatherInfoVO) throws Exception;
	
	
	/**
	 * 기상 특보 조회용
	 * @param weatherInfoVO
	 * @return
	 */
	public List<WarningDataVO> getWeatherWarnList(WarningDataVO warningDataVO) throws Exception;

	public int getWeatherWarnList_cnt(WarningDataVO warningDataVO) throws Exception;
	
	/**
	 * 기상 특보 조회용 (엑셀)
	 * @param weatherInfoVO
	 * @return
	 */
	public List<WarningDataVO> getWeatherWarnList_forExcel(WarningDataVO warningDataVO) throws Exception;
	
	
	/**
	 * 기상 시간강우량 조회용
	 */
	public List<HourRainfallVO> getHourRainfallList(HourRainfallVO hourRainfallVO) throws Exception;
	

	public int getHourRainfallList_cnt(HourRainfallVO hourRainfallVO) throws Exception;
	
	/**
	 * 기상 특보 조회용 (엑셀)
	 */
	public List<HourRainfallVO> getHourRainfallList_forExcel(HourRainfallVO hourRainfallVO) throws Exception;
	
	
	/**
	 * 특정 시간의 특정공구의 시강우량
	 */
	public HourRainfallVO getFactHourRainfall(SearchTaksuVO searchTaksuVO) throws Exception;
}
