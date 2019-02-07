package daewooInfo.weather.service.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import daewooInfo.waterpolmnt.waterinfo.bean.SearchTaksuVO;
import daewooInfo.weather.bean.ForecastInfoVO;
import daewooInfo.weather.bean.HourRainfallVO;
import daewooInfo.weather.bean.WarningDataVO;
import daewooInfo.weather.bean.WeatherAreaVO;
import daewooInfo.weather.bean.WeatherInfoVO;
import daewooInfo.weather.dao.WeatherDAO;
import daewooInfo.weather.service.WeatherService;
import egovframework.rte.fdl.cmmn.AbstractServiceImpl;



@Service("weatherService")
public class WeatherServiceImpl extends AbstractServiceImpl implements WeatherService{
	
	/**
	 * @uml.property  name="weatherDao"
	 * @uml.associationEnd  readOnly="true"
	 */
	@Resource(name="weatherDAO")
	private WeatherDAO weatherDao;

	public WeatherServiceImpl(){}
	
	
	/**
	 * DB에서 현재 기상정보를 불러옴
	 */
	public WeatherInfoVO getCurrentWeather(String factCode, String time)
	{
		return getCurrentWeather(factCode, "1", time);
	}
	
	
	/**
	 * DB에서 현재 기상정보를 불러옴
	 */
	public WeatherInfoVO getCurrentWeather(String factCode, String branch_no, String time)
	{
		WeatherInfoVO weatherInfo = new WeatherInfoVO();

		if(time != null && time.trim().equals("")) time = null;
		
		if(factCode != null && !factCode.trim().equals(""))
		{
			if(time != null && time.length() <= 8)
				time = time + "15";	//yyyyMMdd 까지만 입력되어잇는경우 15시로 검색
			
			//검색조건
			weatherInfo.setAnnounce_time(time);
			weatherInfo.setFactCode(factCode);
			weatherInfo.setBranch_no(branch_no);
			
			weatherInfo = weatherDao.getCurrentWeather(weatherInfo);
			
			if(weatherInfo != null)
			{
				weatherInfo.setFactCode(factCode);
			}
			else
				weatherInfo = new WeatherInfoVO(); //DB에 입력된 값이 없어도 controller에서 null exception 발생 안하게 하기위해 생성...
		}
		else
		{
			return null;
		}
		
		return weatherInfo;
	}
	
	
	/**
	 * DB에서 내일 기상 예보를 불러옴
	 */
	public ForecastInfoVO getForecast(String factCode)
	{
		return getForecast(factCode, "1");
	}
	
	
	/**
	 * DB에서 내일 기상 예보를 불러옴
	 */
	public ForecastInfoVO getForecast(String factCode, String branch_no)
	{
		ForecastInfoVO forecastInfo = new ForecastInfoVO();

		if(factCode != null && !factCode.trim().equals("")) 
		{
			forecastInfo.setFactCode(factCode);
			forecastInfo.setBranch_no(branch_no);
			
			forecastInfo = weatherDao.getForecast(forecastInfo);
			
			if(forecastInfo != null)
			{
				forecastInfo.setFactCode(factCode);
				forecastInfo.setBranch_no(branch_no);
			}
			else
				forecastInfo = new ForecastInfoVO(); //DB에 입력된 값이 없어도 controller에서 null exception 발생 안하게...
			
		}
		else
		{
			return null;
		}
		
		return forecastInfo;
	}

	/**
	 *마지막 SQ를 가져옵니다
	 */
	public Integer getLastSeq(String river_id)
	{
		return weatherDao.getLastSeq(river_id);
	}
	
	/**
	 * DB에서 기상특보를 가져옵니다.
	 */
	public WarningDataVO getWeatherWarning()
	{
		WarningDataVO data = null;
		
		data = weatherDao.getWeatherWarn();
		
		return data;
	}
	
	

	
	//공구별 구역코드정보를 불러옵니다. (SEQ순서)
	public List<WeatherInfoVO> getAreaCode(String river_id, String sys_kind)
	{
		WeatherInfoVO weatherVO = new WeatherInfoVO();
		
		List<WeatherAreaVO> areaVOList = weatherDao.getAreaCode(river_id, sys_kind);
		
		List<WeatherInfoVO> result = new ArrayList<WeatherInfoVO>();
		
		for(WeatherAreaVO area : areaVOList)
		{
			if(area.getFactCode() != null)
			{
				weatherVO = this.getCurrentWeather(area.getFactCode(), area.getBranch_no(), null);//new WeatherInfoVO();
				
				if(weatherVO != null)
				{
					weatherVO.setRegionName(area.getStationName());
					weatherVO.setFactName(area.getFactName());
					weatherVO.setBranch_name(area.getBranch_name());
				}
				
				result.add(weatherVO);
			}
		}
		
		return result;
	}
	
	//공구별 구역코드정보를 불러옵니다. (SEQ순서)
	public List<ForecastInfoVO> getAreaForecast(String river_id, String sys_kind)
	{
		ForecastInfoVO weatherVO = new ForecastInfoVO();
		
		List<WeatherAreaVO> areaVOList = weatherDao.getAreaCode(river_id, sys_kind);
		
		List<ForecastInfoVO> result = new ArrayList<ForecastInfoVO>();
		
		for(WeatherAreaVO area : areaVOList)
		{
			if(area.getFactCode() != null)
			{
				weatherVO = this.getForecast(area.getFactCode(), area.getBranch_no());//new WeatherInfoVO();
				
				if(weatherVO != null)
				{
					weatherVO.setRegionName(area.getStationName());
					weatherVO.setFactName(area.getFactName());
					weatherVO.setBranch_name(area.getBranch_name());
				}
				
				result.add(weatherVO);
			}
		}
		
		return result;
	}
	
	
	//현재 기상정보를 가져옵니다.
	public WeatherInfoVO getWeatherInfo(String river_id, String river_sq)
	{
		WeatherInfoVO weatherVO = new WeatherInfoVO();
		
		WeatherAreaVO weatherAreaVO = new WeatherAreaVO();
		weatherAreaVO.setRiverId(river_id);
		weatherAreaVO.setRiverSq(river_sq);
		weatherAreaVO.setSys_kind("all");
		
		weatherAreaVO = weatherDao.getRegionCode(weatherAreaVO);
		
		if(weatherAreaVO != null)
		{
			weatherVO = this.getCurrentWeather(weatherAreaVO.getFactCode(), weatherAreaVO.getBranch_no(), null);
			
			if(weatherVO != null)
			{
				weatherVO.setRegionName(weatherAreaVO.getStationName());
				weatherVO.setFactName(weatherAreaVO.getFactName());
				weatherVO.setBranch_name(weatherAreaVO.getBranch_name());
			}
		}
		
		return weatherVO;
	}
	
	
	//현재 기상정보를 가져옵니다.
	public List<WeatherInfoVO> getWeatherInfo(String river_sq)
	{
		List<WeatherInfoVO> result = new ArrayList<WeatherInfoVO>();
		
		for(int i = 0 ; i < 4 ; i++)
		{
			WeatherInfoVO weatherVO;

			WeatherAreaVO weatherAreaVO = new WeatherAreaVO();
			
			weatherAreaVO.setRiverSq(river_sq);
			weatherAreaVO.setRiverId("R0" + (i+1));
			
			weatherAreaVO = weatherDao.getRegionCode(weatherAreaVO);
			
			
			if(weatherAreaVO != null && weatherAreaVO.getFactCode() != null)
			{
				weatherVO = this.getCurrentWeather(weatherAreaVO.getFactCode(), null);
				weatherVO.setRegionName(weatherAreaVO.getStationName());
				weatherVO.setFactName(weatherAreaVO.getFactName());
				weatherVO.setBranch_name(weatherAreaVO.getBranch_name());
				
				result.add(weatherVO);
			}
			else
			{
				result.add(null);
			}
		}
		
		return result;
	}
	

	//하늘 상황 코드에 대한 정보를 가져옵니다
	private String getWeatherCode(String code)
	{
		String result = "";
		
		if(code.equals("DB010")) 
		{
			result = "맑음";
		}
		else if(code.equals("DB020"))
		{
			result = "구름조금";
		}
		else if(code.equals("DB021"))
		{
			result = "구름조금 비";
		}
		else if(code.equals("DB022"))
		{
			result = "구름조금 비/눈";
		}
		else if(code.equals("DB023"))
		{
			result = "구름조금 눈";
		}
		else if(code.equals("DB030"))
		{
			result = "구름많음";
		}
		else if (code.equals("DB031"))
		{
			result = "구름많음 비";
		}
		else if (code.equals("DB032"))
		{
			result = "구름많음 비/눈";
		}
		else if (code.equals("DB033"))
		{
			result = "구름많음 눈";
		}
		else if (code.equals("DB040"))
		{
			result = "흐림";
		}
		else if (code.equals("DB041"))
		{
			result = "흐림 비";
		}
		else if (code.equals("DB042"))
		{
			result = "흐림 비/눈";
		}
		else if (code.equals("DB043"))
		{
			result = "흐림 눈";
		}
		else
		{
			result = "Error";
		}
		
		return result;
	}
	
	
	/**
	 * 기상 이력 조회용
	 * @param weatherInfoVO
	 * @return
	 */
	public List<WeatherInfoVO> getWeatherInfoList(WeatherInfoVO weatherInfoVO) throws Exception{
		
		List<WeatherInfoVO> result = null;
		
		result = weatherDao.getWeatherInfoList(weatherInfoVO);
		
		return result;
    }
	

	public int getWeatherInfoList_cnt(WeatherInfoVO weatherInfoVO) throws Exception{
		
		int result = 0;
		
		result = weatherDao.getWeatherInfoList_cnt(weatherInfoVO);
		
		return result;
    }
	
	/**
	 * 기상 이력 조회용 (엑셀)
	 * @param weatherInfoVO
	 * @return
	 */
	public List<WeatherInfoVO> getWeatherInfoList_forExcel(WeatherInfoVO weatherInfoVO) throws Exception{
		
		List<WeatherInfoVO> result = null;
		
		result = weatherDao.getWeatherInfoList_forExcel(weatherInfoVO);
		
		return result;
    }
	
	
	/**
	 * 기상 특보 조회용
	 */
	public List<WarningDataVO> getWeatherWarnList(WarningDataVO warningDataVO) throws Exception{
		
		List<WarningDataVO> result = null;
		
		result = weatherDao.getWeatherWarnList(warningDataVO);
		
		return result;
    }
	

	public int getWeatherWarnList_cnt(WarningDataVO warningDataVO) throws Exception{
		
		int result = 0;
		
		result = weatherDao.getWeatherWarnList_cnt(warningDataVO);
		
		return result;
    }
	
	/**
	 * 기상 특보 조회용 (엑셀)
	 */
	public List<WarningDataVO> getWeatherWarnList_forExcel(WarningDataVO warningDataVO) throws Exception{
		
		List<WarningDataVO> result = null;
		
		result = weatherDao.getWeatherWarnList_forExcel(warningDataVO);
		
		return result;
    }
	
	
	/**
	 * 기상 시간강우량 조회용
	 */
	public List<HourRainfallVO> getHourRainfallList(HourRainfallVO hourRainfallVO) throws Exception{
		
		List<HourRainfallVO> result = null;
		
		result = weatherDao.getHourRainfallList(hourRainfallVO);
		
		return result;
    }
	

	public int getHourRainfallList_cnt(HourRainfallVO hourRainfallVO) throws Exception{
		
		int result = 0;
		
		result = weatherDao.getHourRainfallList_cnt(hourRainfallVO);
		
		return result;
    }
	
	/**
	 * 기상 특보 조회용 (엑셀)
	 */
	public List<HourRainfallVO> getHourRainfallList_forExcel(HourRainfallVO hourRainfallVO) throws Exception{
		
		List<HourRainfallVO> result = null;
		
		result = weatherDao.getHourRainfallList_forExcel(hourRainfallVO);
		
		return result;
    }
	
	
	/**
	 * 특정 시간의 특정공구의 시강우량
	 */
	public HourRainfallVO getFactHourRainfall(SearchTaksuVO searchTaksuVO) throws Exception {
		
		return weatherDao.getFactHourRainfall(searchTaksuVO);
	}
	
	
	public static void main(String[] args) throws Exception{
		
		
		//String test = "201006101700";
		
		//test = test.substring(8);
		//WeatherServiceImpl test = new WeatherServiceImpl();
		
		//WeatherInfoVO t = test.getCurrentWeather_fromWS("41T1003", null);
		
//		SurfaceServiceImplService service = new SurfaceServiceImplServiceLocator();
//		SurfaceServiceImpl surface = service.getSurfaceService();
//		
//		CurrentWeatherModel model = surface.getCurrentWeather("108", null);
//		
//		WarningServiceImplService wService = new WarningServiceImplServiceLocator();
//		WarningServiceImpl warning = wService.getWarningService();
//		
////		
//		WeatherWarningModel[] model = warning.getWeatherWarning("20100621");
//		ForecastServiceImplService fService = new ForecastServiceImplServiceLocator();
//		ForecastServiceImpl forecast = fService.getForecastService();
//		
//		WeatherServiceImpl test = new WeatherServiceImpl();
//		test.getTest("11B10101", "108");
		
//		WeatherWarningListModel[] model = warning.getWeatherWarningList(null);
//		TyphoonInformationListModel[] tModel = warning.getTyphoonInformationList("20090720");
//		WeeklyForecastV2Model testModel = forecast.getWeeklyForecast("20100612", "108");
//
//		StationFixedTimeObservationModel[] model = surface.getStationFixedTimeObservation("108", "20100501");
////		
		return;
	}
}
