package daewooInfo.mobile.com.utl;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.lang.reflect.Field;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.bind.ServletRequestUtils;

/**
* <pre>
* 1. 패키지명 : daewooInfo.mobile.com.utl
* 2. 타입명 : ObjectUtil.java
* 3. 작성일 : 2014. 9. 12. 오후 5:39:56
* 4. 작성자 : kys
* 5. 설명 : StrUtil
* </pre>  
*/
public class ObjectUtil {
	/**
	* <pre>
	* 1. 메소드명 : getTimeString
	* 2. 작성일 : 2014. 9. 12. 오후 5:39:13
	* 3. 작성자 : kys
	* 4. 설명 : 오늘 날짜 YYYYMMDD 형식으로 가져오기
	* </pre>
	*/
	public static String getTimeString(String paramString) {
		SimpleDateFormat localSimpleDateFormat = new SimpleDateFormat(paramString);
		return localSimpleDateFormat.format(new GregorianCalendar().getTime());
	}
	
	public static String getDayofString(String paramString, String dayof){
	    DateFormat df = new SimpleDateFormat(paramString);
        Calendar cal = Calendar.getInstance();
        cal.setTime(new Date());
        cal.add(Calendar.DATE, Integer.parseInt(dayof));
         
        return df.format(cal.getTime()).toString();
	}

	
	/**
	* <pre>
	* 1. 메소드명 : isNumber
	* 2. 작성일 : 2014. 9. 12. 오후 5:39:53
	* 3. 작성자 : kys
	* 4. 설명 : 숫자 여부 체크
	* </pre>
	*/
	public static boolean isNumber(String str) {
        if (str == null)
            return false;
        Pattern p = Pattern.compile("([\\p{Digit}]+)(([.]?)([\\p{Digit}]+))?");
        Matcher m = p.matcher(str);
        return m.matches();
    }
	
	/**
	* <pre>
	* 1. 메소드명 : fileexist
	* 2. 작성일 : 2014. 9. 12. 오후 5:40:11
	* 3. 작성자 : kys
	* 4. 설명 : 파일 존재 여부 체크
	* </pre>
	*/
	public static boolean fileexist(HttpServletRequest request, String name){
		String path = request.getSession().getServletContext().getRealPath("/") + "images\\mobile\\manual\\";
		return new File(path+name).exists();
	}
	

	/**
	* <pre>
	* 1. 메소드명 : readFile
	* 2. 작성일 : 2014. 9. 12. 오후 5:40:11
	* 3. 작성자 : 파일 읽어오기
	* 4. 설명 : 파일 존재 여부 체크
	* </pre>
	*/
	public static String readFile(String paramString) throws Exception {
		File localFile = new File(paramString);
		if (localFile.exists()) {
			FileInputStream localFileInputStream = new FileInputStream(localFile);
			InputStreamReader localInputStreamReader = new InputStreamReader(localFileInputStream, "utf-8");
			BufferedReader localBufferedReader = new BufferedReader(localInputStreamReader);

			char[] arrayOfChar = new char[(int) localFile.length()];
			localBufferedReader.read(arrayOfChar);
			localBufferedReader.close();

			return new String(arrayOfChar);
		}
		return "";
	}

	
	
	/**
	 * @param String[] paramValueArr 
	 * @param params
	 * @return 파라미터 생성 
	 * @throws Exception
	 */
	public static String ParamString(String[] paramValueArr, String params) throws Exception {
		String str = "";
		
		String[] paramNameArr = params.split(","); 

		for(int i=0; i< paramNameArr.length ; i++){
			if(i == 0) str += "?";
			str += paramNameArr[i] + "=" + paramValueArr[i];
			if(i < paramNameArr.length -1) str += "&";
		}
		return str;
	}

	

	public static String RequestParamString(HttpServletRequest request, String params) throws Exception {
		return RequestParamString(request, params, true);
	}
	
	public static String RequestParamString(HttpServletRequest request, String params, Boolean firststart){

		String str = "";
		String[] paramNameArr = params.split(","); 
		
		for(int i=0; i< paramNameArr.length ; i++){
			if(firststart == true && i == 0) 
				str += "?";
			
			String name = paramNameArr[i];
			
			str += name + "=" + ServletRequestUtils.getStringParameter(request, name, "");
			
			if(i < paramNameArr.length -1) 
				str += "&";
		}
		return str;
	}
	
	public static <T> String ParamString(T object, String params) throws Exception {
		return ParamString(object, params, true);
	}
	
	public static <T> String ParamString(T object, String params, Boolean firststart) throws Exception {
		String str = "";
		String[] paramNameArr = params.split(","); 
		for(int i=0; i< paramNameArr.length ; i++){
			if(firststart == true && i == 0) 
				str += "?";
			
			String name = paramNameArr[i];
			
			//필드 이름 가져오기
			Field field = object.getClass().getDeclaredField(name);
			
			
			field.setAccessible(true);
			str += name + "=" + ((null == field.get(object)) ? "" : field.get(object));
			
			if(i < paramNameArr.length -1) 
				str += "&";
		}
		return str;
	}
}
