package daewooInfo.weather.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ibatis.sqlmap.engine.type.SimpleDateFormatter;

import daewooInfo.common.util.fcc.StringUtil;
import daewooInfo.waterpolmnt.waterinfo.bean.DetailViewVO;
import daewooInfo.waterpolmnt.waterinfo.bean.SearchTaksuVO;
import daewooInfo.waterpolmnt.waterinfo.bean.TaksuVO;
import daewooInfo.waterpolmnt.waterinfo.service.WaterinfoService;
import daewooInfo.weather.bean.ForecastInfoVO;
import daewooInfo.weather.bean.WarningDataVO;
import daewooInfo.weather.bean.WeatherInfoVO;
import daewooInfo.weather.bean.WeatherVO;
import daewooInfo.weather.service.WeatherService;
import egovframework.rte.ptl.mvc.tags.ui.pagination.PaginationInfo;

/**
 * @author DaeWoo Information Systems Co., Ltd. Technical Expert Team.
 *         loafzzang.
 * @version 1.0
 * @Class Name : MonitoringController.java
 * @Description : monitoring Controller Class
 * @Modification Information @ @ Modify Date author Modify Contents @
 *               -------------- ------------ ------------------------------- @
 *               2010. 1. 21 loafzzang new
 * @see Copyright (C) by DaeWoo Information Systems Co., Ltd. All right
 *      reserved.
 * @since 2010. 1. 21
 */

@Controller
public class WeatherController{
	/**
	 * @uml.property  name="logger"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	Log logger = LogFactory.getLog(WeatherController.class);
	
    /**
	 * @uml.property  name="weatherService"
	 * @uml.associationEnd  readOnly="true"
	 */
    @Resource(name = "weatherService")
    private WeatherService weatherService;

    // 기상 조회
    @RequestMapping("/weather/getWeatherInfo.do")
	public ModelAndView getWeatherInfo(
			@RequestParam(value="river_id", required = false) String river_id,
			@RequestParam(value="river_sq", required = false) String river_sq
	) throws Exception{
    	
    	ModelAndView modelAndView = new ModelAndView();
    	
    	if(river_id != null)
    	{
    		WeatherInfoVO weather = weatherService.getWeatherInfo(river_id, river_sq);
    		modelAndView.addObject("weather", weather);
    	}
    	else
    	{    	
    		List<WeatherInfoVO> weather = weatherService.getWeatherInfo(river_sq);
    		modelAndView.addObject("weather", weather);
    	}
    	
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
    
    @RequestMapping("/weather/getAreaCode.do")
    public ModelAndView getAreaCode(
    		@RequestParam(value="river_id", required=false) String river_id,
    		@RequestParam(value="sys_kind", required=false) String sys_kind,
    		@RequestParam(value="weather_kind", required=false) String weather_kind 
    )throws Exception
    {
    	ModelAndView modelAndView = new ModelAndView();
    	
    	List<WeatherInfoVO> weather = null;
    	List<ForecastInfoVO> forecast = null;
    	
    	if(weather_kind.equals("C"))
    	{
    		weather = weatherService.getAreaCode(river_id, sys_kind);
    		modelAndView.addObject("weather", weather);
    	}
    	else if(weather_kind.equals("T"))
    	{
    		forecast = weatherService.getAreaForecast(river_id, sys_kind);
    		modelAndView.addObject("weather", forecast);
    	}
    
    	
    	modelAndView.setViewName("jsonView");
    	
    	return modelAndView;
    }
    
    
    /**
     * 공구별 시간에 따른 기상정보
     */
    @RequestMapping("/weather/getCurrentWeather.do")
	public ModelAndView getCurrentWeather(
			@RequestParam(value="factCode") String factCode,
			@RequestParam(value="branchNo") String branchNo,
			@RequestParam(value="time", required = false) String time
	) throws Exception{
    	
    	ModelAndView modelAndView = new ModelAndView();
    	WeatherInfoVO weatherInfo = null;
    	
    	
    	if(branchNo != null && !branchNo.equals(""))
    		weatherInfo = weatherService.getCurrentWeather(factCode, branchNo, time);	//지정된 측정소에 대한 기상정보
    	else	
    		weatherInfo = weatherService.getCurrentWeather(factCode, time);	//1번 측정소에 대한 기상정보
    	
    	
    	modelAndView.addObject("weatherInfo", weatherInfo);
    	
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}

    /**
     * 해당 공구의 어제 기상정보를 불러옵니다.
     */
    @RequestMapping("/weather/getYesterdayWeather.do")
    public ModelAndView getYesterdayWeather(
    		@RequestParam(value="factCode") String factCode,
    		@RequestParam(value="branchNo") String branchNo
    ) throws Exception
    {
    	ModelAndView modelAndView = new ModelAndView();

    	//어제 날짜를 가져옴
    	Calendar cal = Calendar.getInstance();
        cal.add(Calendar.DATE, -1);
        
        String time = new String(new SimpleDateFormat("yyyyMMdd" ).format(cal.getTime()));

        //time 파라메터에 어제 날자를 넣어서 어제 기상정보를 가져옴
        WeatherInfoVO weatherInfo = weatherService.getCurrentWeather(factCode, branchNo, time);
        modelAndView.addObject("weatherInfo", weatherInfo);
    	
		modelAndView.setViewName("jsonView");
		
    	return modelAndView;
    }
    
    
    /**
     * 공구별 내일 기상 예보
     * @param river_id
     * @param river_sq
     * @return
     * @throws Exception
     */
    @RequestMapping("/weather/getForecast.do")
	public ModelAndView getTomorrowWeather(
			@RequestParam(value="factCode") String factCode
	) throws Exception{
    	
    	ModelAndView modelAndView = new ModelAndView();
    	
    	ForecastInfoVO forecastInfo = weatherService.getForecast(factCode);
    	
    	modelAndView.addObject("weatherInfo", forecastInfo);
    	
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
    
    /**
     * 현재 기상 특보를 가져옵니다.
     */
    @RequestMapping("/weather/getWeatherWarning.do")
	public ModelAndView getWeatherWarning() throws Exception{
    	
    	ModelAndView modelAndView = new ModelAndView();
    	
    	WarningDataVO warningData = weatherService.getWeatherWarning();
    	
    	modelAndView.addObject("warningData", warningData);
    	
		modelAndView.setViewName("jsonView");
		
		return modelAndView;
	}
  }
