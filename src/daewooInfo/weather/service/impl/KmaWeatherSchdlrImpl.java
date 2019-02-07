package daewooInfo.weather.service.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.net.URLConnection;
import java.util.Iterator;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;

import daewooInfo.weather.bean.WeatherAreaVO;
import daewooInfo.weather.bean.WeatherInfoVO;
import daewooInfo.weather.dao.WeatherDAO;

public class KmaWeatherSchdlrImpl extends QuartzJobBean { 
	
	private static Log log = LogFactory.getLog(KmaWeatherSchdlrImpl.class);
	
	private WeatherDAO weatherDAO;
	private WeatherInfoVO weatherInfo;
	
	public void setWeatherDAO(WeatherDAO weatherDAO) {
		this.weatherDAO = weatherDAO;
	}

	private static final String serviceKey = "TMfAaTs9V9jHvy3%2BXn1PDnaTudQ7zPoBZOkbuTvdzbUliG3HKPTMGrNnwPQWvq%2FB2Ozicb5iKSyJbImysAdXsA%3D%3D";
//	private static final String serviceKey = "dWrKGsBHrUt3irffbcM6zeJwPHNXqP66j5Upnz8rM0mdMdUpvRLXGtzhpe4F20BZS2T8sllwCUwoBEEZozdaLg%3D%3D";
	private String stationId = "";
	
	public KmaWeatherSchdlrImpl() {
		this.weatherInfo = new WeatherInfoVO();
	}
    
	/**
	 * 
	 * @see org.springframework.scheduling.quartz.QuartzJobBean#executeInternal(org.quartz.JobExecutionContext)
	 */
	@Override
    protected void executeInternal(JobExecutionContext ctx) throws JobExecutionException {

		//log.debug("############################################Start KmaWeather by Scheduler!###########################################");
		System.out.println("############################################Start KmaWeather by Scheduler!###########################################");
		
		try {
			insertNowWeather();
		}catch(Exception e){
			e.printStackTrace();
			log.error(" KmaWeatherSchdlrImpl 스케줄러 executeInternal() 에러 : " + e.getMessage());
		}
		
	}	
	
	/**
	 * 보도자료 조회
	 * 
	 */
	private void insertNowWeather() throws Exception{	
		try {
			System.out.println("insertNowWeather Start ==>");

		    List<WeatherAreaVO> weatherArea = weatherDAO.getUAStationCodeList();
		    System.out.println("insertNowWeather End ==>" + weatherArea.size());
		    if (weatherArea != null)
		    {
		      for (Iterator iterator = weatherArea.iterator(); iterator.hasNext(); )
		      {
		        WeatherAreaVO area = (WeatherAreaVO)iterator.next();
		        try
		        {
		          if (area == null)
		            continue;
		          //System.out.println("========>" + area.getFactCode() + "/" + area.getBranch_no());
		          WeatherInfoVO weatherInfo = getCurrentWeather_fromAPI(area.getFactCode(), area.getBranch_no(), null);
		          if ((weatherInfo.getAnnounce_time() != null) && (!weatherInfo.getAnnounce_time().equals("")))
		            if (checkWeatherInsert(weatherInfo.getAnnounce_time(), area.getFactCode(), area.getBranch_no()))
		            {
		              weatherInfo.setFactCode(area.getFactCode());
		              weatherInfo.setBranch_no(area.getBranch_no());
		              this.weatherDAO.insertWeatherInfo(weatherInfo);
		            }
		            else {
		              WeatherInfoVO tmpWeatherInfo = getCurrentWeather(area.getFactCode(), area.getBranch_no(), null);
		              if ((tmpWeatherInfo.getCurrent_weather() == null) || (tmpWeatherInfo.getCurrent_weather().equals("")) || (tmpWeatherInfo.getTemp() == null) || (tmpWeatherInfo.getCurrent_weather().equals("")))
		              {
		                weatherInfo.setFactCode(area.getFactCode());
		                weatherInfo.setBranch_no(area.getBranch_no());
		                this.weatherDAO.updateWeatherInfo(weatherInfo);
		              }
		            }
		          log.info("[" + area.getFactCode() + ":" + area.getBranch_no() + "] 의 기상데이터 등록 성공]");
		        }
		        catch (Exception e)
		        {
		          log.error("[" + area.getFactCode() + "공구, " + area.getBranch_no() + "측정소  기상 데이터 DB등록 실패]", e);
		        }
		      }
		    }
		} catch(Exception e){
			e.printStackTrace();
			log.error(" KmaWeatherSchdlrImpl 스케줄러 insertNowWeather() 에러 : " + e.getMessage());
		}
	}
	
	public boolean checkWeatherInsert(String announceTime, String fact_code, String branch_no) {
	    String lastAnnounceTime = this.weatherDAO.getLastAnnounceTime(fact_code, branch_no);
	    
	    return (lastAnnounceTime == null) || (!lastAnnounceTime.equals(announceTime));
	}
	
	public boolean checkForecastInsert(String announceTime, String fact_code, String branch_no) {
	    String lastAnnounceTime = this.weatherDAO.getForecastAnnounceTime(fact_code, branch_no);
	    
	    return (lastAnnounceTime == null) || (!lastAnnounceTime.equals(announceTime));
	}
	
	public WeatherInfoVO getCurrentWeather_fromAPI(String factCode, String branch_no, String time)
	  {
	    WeatherAreaVO area = new WeatherAreaVO();
	    area = this.weatherDAO.getStationCode(factCode, branch_no);
	    if ((time != null) && (time.trim().equals("")))
	      time = null;
	    if (area != null)
	    {
	      try
	      {
	        if ((area.getStationId() != null) && (!area.getStationId().trim().equals("")) && !stationId.equals(area.getStationId()))
	        {
	        	String urlStr = "http://newsky2.kma.go.kr/service/GroundInfoService/CurrentWeather?"
	                    + "stnId=" + area.getStationId()
	                    + "&ServiceKey=" + KmaWeatherSchdlrImpl.serviceKey + "&_type=json";

	                URL url = new URL(urlStr); // 위 urlStr을 이용해서 URL 객체를 만들어줍니다.

	                URLConnection conn = url.openConnection(); 
	            	conn.setDoOutput(true); 
	            	conn.setReadTimeout(6000); 
	            	conn.setConnectTimeout(5000); 
	            	BufferedReader rd = new BufferedReader(new InputStreamReader(conn.getInputStream())); 
	            	
	                //BufferedReader bf;

	                String line = "";

	                String result="";

	     

	                //날씨 정보를 받아옵니다.

	                //bf = new BufferedReader(new InputStreamReader(url.openStream()));

	     

	                //버퍼에 있는 정보를 하나의 문자열로 변환.

	                while((line=rd.readLine())!=null){

	                    result=result.concat(line);

	                   // System.out.println(result);  // 받아온 데이터를 확인해봅니다.

	                }

	                

	                 // Json parser를 만들어 만들어진 문자열 데이터를 객체화 합니다. 

	            JSONParser parser = new JSONParser();

	            JSONObject obj = (JSONObject) parser.parse(result);

	             

	            // Top레벨 단계인 response 키를 가지고 데이터를 파싱합니다.

	            JSONObject parse_response = (JSONObject) obj.get("response");

	            // response 로 부터 body 찾아옵니다.

	            JSONObject parse_body = (JSONObject) parse_response.get("body");

	            // body 로 부터 items 받아옵니다.

	            JSONObject parse_items = (JSONObject) parse_body.get("items");

	             System.out.println("parse items >>>> " + parse_items.toJSONString());

	            // items로 부터 itemlist 를 받아오기 itemlist : 뒤에 [ 로 시작하므로 jsonarray이다

	             JSONObject weather = (JSONObject) parse_items.get("item");


	              String announce_time = ""+(weather.get("tm")==null?"":weather.get("tm"));
	              
	              String weatherStatusNumber = "" + (weather.get("weatherStatusNumber")==null?"":weather.get("weatherStatusNumber"));
	              
	              String visibility = ""+(weather.get("visibility")==null?"":weather.get("visibility"));
	              
	              String cloudAmount = ""+(weather.get("cloudAmount")==null?"":weather.get("cloudAmount"));
	              
	              String temp = "" + (weather.get("temperature")==null?"":weather.get("temperature"));
	              
	              String temp_max = "" + (weather.get("tamax")==null?"":weather.get("tamax"));
	              
	              String temp_min = "" + (weather.get("tamin")==null?"":weather.get("tamin"));
	              
	              //String dewPointTemperature = "" + weather.get("dewPointTemperature");
	              
	              String rain_fall = "" + (weather.get("rainfallDay")==null?"":weather.get("rainfallDay"));
	              
	              String snowcover = "" + (weather.get("snowcover")==null?"":weather.get("snowcover"));
	              
	              String humidity = ""+(weather.get("humidity")==null?"":weather.get("humidity"));
	              
	              String windDir = "" + (weather.get("windDirection")==null?"":weather.get("windDirection"));
	              
	              String windSpeed = ""+(weather.get("windSpeed")==null?"":weather.get("windSpeed"));
	              

	              rd.close();

	              String current_weather = "";
	              if ((cloudAmount != null) && (!cloudAmount.trim().equals(""))){
	            	  int value = Integer.parseInt(cloudAmount);
	            	  if(value<0) current_weather = "";
	            	  if(value>0 && value<=2) current_weather = "맑음";
	            	  if(value>2 && value<=5) current_weather = "구름조금";
	            	  if(value>5 && value<=8) current_weather = "구름많음";
	            	  if(value>8 && value<=10) current_weather = "흐림";
	            	  if(value>10) current_weather = "";
	            	  
	            	  weatherInfo.setCurrent_weather(current_weather);
	            	  weatherInfo.setWeather_sky(current_weather);
	              }
	              
	              if ((weatherStatusNumber != null) && (!weatherStatusNumber.trim().equals(""))){
	            	  weatherInfo.setWeather_code(weatherStatusNumber);
	              }
	            	  
              if ((announce_time != null) && (!announce_time.trim().equals("")))
  	            weatherInfo.setAnnounce_time(announce_time + "00");   
	          /*if ((value != null) && (!value.trim().equals("")))
	            weatherInfo.setCurrent_weather(value);*/
	          if ((visibility != null) && (!visibility.trim().equals("")))
	            weatherInfo.setVisibility(visibility);
	          if ((temp != null) && (!temp.trim().equals("")))
	            weatherInfo.setTemp(temp);
	          if ((temp_max != null) && (!temp_max.trim().equals("")))
	            weatherInfo.setTemp_max(temp_max);
	          if ((temp_min != null) && (!temp_min.trim().equals("")))
	            weatherInfo.setTemp_min(temp_min);
	          if ((rain_fall != null) && (!rain_fall.trim().equals("")))
	            weatherInfo.setRain_fall(rain_fall);
	          if ((humidity != null) && (!humidity.trim().equals("")))
	            weatherInfo.setHumidity(humidity);
	          if ((windDir != null) && (!windDir.trim().equals("")))
	            weatherInfo.setWind_dir(windDir);
	          if ((windSpeed != null) && (!windSpeed.trim().equals("")))
	            weatherInfo.setWind_speed(windSpeed);
	          if ((snowcover != null) && (!snowcover.trim().equals("")))
	            weatherInfo.setSnowcover(snowcover);

	          weatherInfo.setDiscomfort_index("");
	          weatherInfo.setRain_fall("");
	          weatherInfo.setSensible_temp("");
	          weatherInfo.setWeather_code("");
	          weatherInfo.setSnowcover("");
	          
	          stationId = area.getStationId();
	        }
	      }
	      catch (Exception e)
	      {
	    	  e.printStackTrace();
	        log.warn("[기상청 정시관측정보  웹서비스 [ GetCurrentWeather  ] 요청 실패!]\n\t\t" + e.getMessage());
	      }
	    }
	    else {
	      return null;
	    }
	    return weatherInfo;
	  }

	public WeatherInfoVO getCurrentWeather(String factCode, String time)
	{
	  return getCurrentWeather(factCode, "1", time);
	}
	
	public WeatherInfoVO getCurrentWeather(String factCode, String branch_no, String time)
	{
	  WeatherInfoVO weatherInfo = new WeatherInfoVO();
	  if ((time != null) && (time.trim().equals("")))
	    time = null;
	  if ((factCode != null) && (!factCode.trim().equals("")))
	  {
	    if ((time != null) && (time.length() <= 8))
	      time = time + "15";
	    weatherInfo.setAnnounce_time(time);
	    weatherInfo.setFactCode(factCode);
	    weatherInfo.setBranch_no(branch_no);
	    weatherInfo = this.weatherDAO.getCurrentWeather(weatherInfo);
	    if (weatherInfo != null)
	      weatherInfo.setFactCode(factCode);
	    else
	      weatherInfo = new WeatherInfoVO();
	  }
	  else {
	    return null;
	  }
	  return weatherInfo;
	}
}