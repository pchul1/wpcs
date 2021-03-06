package daewooInfo.weather.dao;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Repository;

import daewooInfo.waterpolmnt.waterinfo.bean.SearchTaksuVO;
import daewooInfo.weather.bean.ForecastInfoVO;
import daewooInfo.weather.bean.HourRainfallVO;
import daewooInfo.weather.bean.WarningDataVO;
import daewooInfo.weather.bean.WeatherAreaVO;
import daewooInfo.weather.bean.WeatherInfoVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

@Repository("weatherDAO")
public class WeatherDAO extends EgovAbstractDAO{

	public WeatherDAO(){}
	
	public WeatherAreaVO getRegionCode(WeatherAreaVO vo)
	{
		return (WeatherAreaVO)selectByPk("weatherDAO.getRegionCode",vo);
	}
	
	public String getWeatherCode(String code)
	{
		return (String)selectByPk("weatherDAO.getWeatherCode", code);
	}
	
	public List<WeatherAreaVO> getAreaCode(String river, String sys_kind)
	{
		HashMap paraMap = new HashMap();
		paraMap.put("river", river);
		paraMap.put("sys_kind", sys_kind);
		return list("weatherDAO.getAreaCode", paraMap);
	}
	
	
	/**
	 * FACT_CODE에 대한 기상예보 지역 코드
	 * @param factCode
	 * @return
	 */
	public WeatherAreaVO getStationCode(String factCode, String branch_no)
	{
		HashMap paraMap = new HashMap();
		paraMap.put("fact_code", factCode);
		paraMap.put("branch_no", branch_no);
		paraMap.put("sys_kind", "all");
		return (WeatherAreaVO)selectByPk("weatherDAO.getStationCode", paraMap);
	}
	
	/**
	 * FACT_CODE에 대한 기상예보 지역 코드 (전부출력)
	 * @param factCode
	 * @return
	 */
	public List<WeatherAreaVO> getStationCodeList()
	{
		HashMap paraMap = new HashMap();
		paraMap.put("fact_code", "all");
		paraMap.put("sys_kind", "all");
		return list("weatherDAO.getStationCode", paraMap);
	}
	
	/**
	 * FACT_CODE에 대한 기상예보 지역 코드 (전부출력)
	 * @param factCode
	 * @return
	 */
	public List<WeatherAreaVO> getUAStationCodeList()
	{
		HashMap paraMap = new HashMap();
		paraMap.put("fact_code", "all");
		paraMap.put("sys_kind", "all");
		return list("weatherDAO.getUAStationCode", paraMap);
	}
	
	
	/**
	 * 기상정보 DB입력
	 * @param weatherInfo
	 */
	public void insertWeatherInfo(WeatherInfoVO weatherInfo)
	{
		 insert("weatherDAO.insertWeatherInfo", weatherInfo);
	}
	
	/**
	 * 기상정보 Update
	 * @param weatherInfo
	 */
	public void updateWeatherInfo(WeatherInfoVO weatherInfo)
	{
		insert("weatherDAO.updateWeatherInfo", weatherInfo);
	}
	
	/**
	 * 기상예보 DB입력
	 * @param weatherInfo
	 */
	public void insertForecast(WeatherInfoVO weatherInfo)
	{
		 insert("weatherDAO.insertForecast", weatherInfo);
	}
	
	/**
	 * 마지막으로 등록된 기상정보의 발표시간을 가져옴
	 * @param fact_code
	 * @return
	 */
	public String getLastAnnounceTime(String fact_code, String branch_no)
	{
		HashMap paraMap = new HashMap();
		paraMap.put("fact_code", fact_code);
		paraMap.put("branch_no", branch_no);
		return (String)selectByPk("weatherDAO.getLastAnnounceTime", paraMap);
	}
	
	
	/**
	 * 마지막으로 등록된 기상예보의 발표시간을 가져옴
	 * @param fact_code
	 * @return
	 */
	public String getForecastAnnounceTime(String fact_code, String branch_no)
	{
		HashMap paraMap = new HashMap();
		paraMap.put("fact_code", fact_code);
		paraMap.put("branch_no", branch_no);
		return (String)selectByPk("weatherDAO.getForecastAnnounceTime", paraMap);
	}
	
	/**
	 * 기상정보를 DB에서 가져옵니다 (Announce_time(yyyyMMdd)로 이전 정보를 검색해 볼수 있습니다)
	 * @param weatherInfoVO
	 * @return
	 */
	public WeatherInfoVO getCurrentWeather(WeatherInfoVO weatherInfoVO)
	{
		return (WeatherInfoVO)selectByPk("weatherDAO.getCurrentWeather", weatherInfoVO);
	}
	
	/**
	 * 내일 기상예보를 DB에서 가져옵니다
	 * @param weatherInfoVO
	 * @return
	 */
	public ForecastInfoVO getForecast(ForecastInfoVO forecastInfo)
	{
		return (ForecastInfoVO)selectByPk("weatherDAO.getForecast", forecastInfo);
	}
	
	/**
	 * 최대 SQ를 구합니다
	 */
	public Integer getLastSeq(String river_id)
	{
		HashMap paraMap = new HashMap();
		paraMap.put("river_id", river_id);
		
		return (Integer)selectByPk("weatherDAO.getLastSeq", paraMap);
	}
	
	/**
	 * 기상특보를 가져옵니다.
	 * @return
	 */
	public WarningDataVO getWeatherWarn()
	{
		return (WarningDataVO)selectByPk("weatherDAO.getWeatherWarn", null);
	}
	
	/**
	 * 기상특보를 DB에 등록합니다.
	 * @param weatherWarn
	 */
	public void insertWeatherWarn(WarningDataVO weatherWarn)
	{
		insert("weatherDAO.insertWeatherWarn", weatherWarn);
	}
	
	/**
	 * 마지막으로 등록된 기상특보의 발표시간을 가져옴
	 * @param fact_code
	 * @return
	 */
	public String getWarningAnnounceTime()
	{
		return (String)selectByPk("weatherDAO.getWarningAnnounceTime", null);
	}
	
	
	
	/**
	 * 기상 이력 조회용
	 * @param weatherInfoVO
	 * @return
	 */
	public List<WeatherInfoVO> getWeatherInfoList(WeatherInfoVO weatherInfoVO) {
    	return list("weatherDAO.getWeatherInfoList", weatherInfoVO);
    }
	
	/**
	 * 기상 이력 조회 레코드 수
	 * @param weatherInfoVO
	 * @return
	 */
	public int getWeatherInfoList_cnt(WeatherInfoVO weatherInfoVO)
	{
		return (Integer)selectByPk("weatherDAO.getWeatherInfoList_cnt", weatherInfoVO);
	}
	
	
	/**
	 * 기상 정보 엑셀출력용
	 * @param weatherInfoVO
	 * @return
	 */
	public List<WeatherInfoVO> getWeatherInfoList_forExcel(WeatherInfoVO weatherInfoVO) {
    	return list("weatherDAO.getWeatherInfoList_forExcel", weatherInfoVO);
    }
	
	
	/**
	 * 기상 특보 조회용
	 */
	public List<WarningDataVO> getWeatherWarnList(WarningDataVO warningDataVO) {
    	return list("weatherDAO.getWeatherWarnList", warningDataVO);
    }
	
	/**
	 * 기상 특보 조회 레코드 수
	 */
	public int getWeatherWarnList_cnt(WarningDataVO warningDataVO)
	{
		return (Integer)selectByPk("weatherDAO.getWeatherWarnList_cnt", warningDataVO);
	}
	
	
	/**
	 * 기상 특보 엑셀출력용
	 */
	public List<WarningDataVO> getWeatherWarnList_forExcel(WarningDataVO warningDataVO) {
    	return list("weatherDAO.getWeatherWarnList_forExcel", warningDataVO);
    }
	
	
	
	/**
	 * 기상 시간강우량 조회용
	 */
	public List<HourRainfallVO> getHourRainfallList(HourRainfallVO hourRainfallVO) {
    	return list("weatherDAO.getHourRainfallList", hourRainfallVO);
    }
	
	/**
	 * 기상 시간강우량 조회 레코드 수
	 */
	public int getHourRainfallList_cnt(HourRainfallVO hourRainfallVO)
	{
		return (Integer)selectByPk("weatherDAO.getHourRainfallList_cnt", hourRainfallVO);
	}
	
	
	/**
	 * 기상 시간강우량 엑셀출력용
	 */
	public List<HourRainfallVO> getHourRainfallList_forExcel(HourRainfallVO hourRainfallVO) {
    	return list("weatherDAO.getHourRainfallList_forExcel", hourRainfallVO);
    }
	
	
	/**
	 * 특정 시간의 특정공구의 시강우량
	 */
	public HourRainfallVO getFactHourRainfall(SearchTaksuVO searchTaksuVO)
	{
		return (HourRainfallVO)selectByPk("weatherDAO.getFactHourRainfall", searchTaksuVO);
	}
}
