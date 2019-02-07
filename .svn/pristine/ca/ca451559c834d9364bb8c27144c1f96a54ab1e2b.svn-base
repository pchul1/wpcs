package daewooInfo.mobile.com.utl;

public class ProjectJstlUtil {
        
    /**
    * <pre>
    * 1. 메소드명 : SelectWaterListColor
    * 2. 작성일 : 2014. 9. 12. 오후 5:36:33
    * 3. 작성자 : kys
    * 4. 설명 : 수질현황 리스트 값 색상
    * </pre>
    */
    public static String SelectWaterListColor(String str, String minOrVal){
    	
		String colorStr = "";
		if("0".equals(minOrVal)){	//정상
			colorStr = "<font color='green'>"+str+"</font>";
		}else if("1".equals(minOrVal)){	//관심
			colorStr = "<font color='blue'>"+str+"</font>";
		}else if("2".equals(minOrVal)){	//주의
			colorStr = "<font color='#F0D010'>"+str+"</font>";
		}else if("3".equals(minOrVal)){	//경계
			colorStr = "<font color='orange'>"+str+"</font>";
		}else if("4".equals(minOrVal)){	//심각
			colorStr = "<font color='red'>"+str+"</font>";
		}else{
			colorStr = str;
		}
		return colorStr;
    }

    /**
     * <pre>
     * 1. 메소드명 : SelectWaterListColor
     * 2. 작성일 : 2014. 9. 12. 오후 5:36:33
     * 3. 작성자 : kys
     * 4. 설명 : 수질현황 리스트  경보 색상
     * </pre>
     */
	public static String SelectStepColor(String str, String step){
		String colorStr = "";
		if("1".equals(step)){	//경보발생
			colorStr = "<font color='red'>"+str+"</font>";
		}else if("2".equals(step)){	//현장확인 ==> 경보발생>현장확인
			colorStr = "<font color='green'>"+str+"</font>";
		}else if("3".equals(step)){	//시료분석 ==> 경보발생>현장확인>시료분석
			colorStr = "<font color='blue'>"+str+"</font>";
		}else if("4".equals(step)){	//상황종료 ==> 경보발생>현장확인>상황종료(측정기이상)	
			colorStr = "<font color='#660099'>"+str+"</font>";
		}else if("6".equals(step)){	//상황종료 ==> 경보발생>현장확인>시료분석>상황종료(환경청통보)
			colorStr = "<font color='#F0D010'>"+str+"</font>";
		}else if("9".equals(step)){	//상황전파실패
			colorStr = "<font color='orange'>"+str+"</font>";
		}else if("10".equals(step)){	//상황전파실패
			colorStr = "<font color='orange'>"+str+"</font>";
		}else{
			colorStr = str;
		}
		return colorStr;
	}

    /**
     * <pre>
     * 1. 메소드명 : SelectWaterListColor
     * 2. 작성일 : 2014. 9. 12. 오후 5:36:33
     * 3. 작성자 : kys
     * 4. 설명 : IP_USN 위치 
     * </pre>
     */
	public static String SelectIpUsnstr(String device_st){ 
		if("OK".equals(device_st)) 		return "정상";
		else if("A0".equals(device_st)) return "전원이상 - 메인전원";
		else if("B0".equals(device_st)) return "점검/보수중 - 측정기기 보수";
		else if("B1".equals(device_st)) return "점검/보수중 - 측정기기 부품 교환(센서, 기타)";
		else if("B2".equals(device_st)) return "점검/보수중 - 측정기기 부품 교환";
		else if("B3".equals(device_st)) return "점검/보수중 - 측정기기 Overhaul cleaning";
		else if("B4".equals(device_st)) return "점검/보수중 - 측정기기 점검(정기, 수시)";
		else if("B5".equals(device_st)) return "점검/보수중 - 전송장비 점검/보수";
		else if("C0".equals(device_st)) return "장비이상 - 측정기기 이상";
		else if("E1".equals(device_st)) return "교정중 - 수동 교정";
		else if("E2".equals(device_st)) return "교정중 - 정도 관리";
		else if("F0".equals(device_st)) return "시운전 - 시운전";
		else if("G0".equals(device_st)) return "가동중지 - 가동중지(측정기)";
		else if("Z9".equals(device_st)) return "영구중단";
		return null;
	}
	
    /**
     * <pre>
     * 1. 메소드명 : SelectWaterListColor
     * 2. 작성일 : 2014. 9. 12. 오후 5:36:33
     * 3. 작성자 : kys
     * 4. 설명 : IP_USN 위치 
     * </pre>
     */
	public static String SelectIpUsnDistance(String latitude1, String longitude1, String latitude2, String longitude2, String mode, String _gps_dist, String jstlUtil){
		if("".equals(latitude2)){
			if("Y".equals(jstlUtil)) return "<span class='noexist'>위치불명</span>";
			else return "위치불명";
		}else{
		   int gps_dist = Integer.parseInt(_gps_dist);
			double Lat1 = Double.parseDouble(latitude1);
			double Long1 = Double.parseDouble(longitude1);
			double Lat2 = Double.parseDouble(latitude2);
			double Long2 = Double.parseDouble(longitude2);
			
	       double dDistance = Double.MIN_VALUE;
	       double dLat1InRad = Lat1 * (Math.PI / 180.0);
	       double dLong1InRad = Long1 * (Math.PI / 180.0);
	       double dLat2InRad = Lat2 * (Math.PI / 180.0);
	       double dLong2InRad = Long2 * (Math.PI / 180.0);
	
	       double dLongitude = dLong2InRad - dLong1InRad;
	       double dLatitude = dLat2InRad - dLat1InRad;
	
	       // Intermediate result a.
	       double a = Math.pow(Math.sin(dLatitude / 2.0), 2.0) + 
	           Math.cos(dLat1InRad) * Math.cos(dLat2InRad) * 
	           Math.pow(Math.sin(dLongitude / 2.0), 2.0);
	
	       // Intermediate result c (great circle distance in Radians).
	       double c = 2.0 * Math.atan2(Math.sqrt(a), Math.sqrt(1.0 - a));
	
	       // Distance.
	       // const Double kEarthRadiusMiles = 3956.0;
	       Double kEarthRadiusKms = 6376.5;
	       dDistance = kEarthRadiusKms * c;
	       mode = (mode==null)?"M":("".equals(mode))?"M":mode;
	       
	       if("M".equals(mode)){	//미터
	       	dDistance = dDistance*1000;
	       }else if("K".equals(mode)){	//킬로미터
	       	dDistance = dDistance;
	       }
	       	
			if(dDistance > gps_dist) {
				if("0".equals(latitude2)) {
					if("Y".equals(jstlUtil)) return "<span class='noexist'>위치없음</span>";
					else return "위치없음";
				} else {
					if("Y".equals(jstlUtil)) return "<span class='nogood'>위치이탈</span>";
					else return "위치이탈";
				}
			} else {
				if("Y".equals(jstlUtil)) return "<span class='good'>위치정상</span>";
				else return "위치정상";
			}
		}
	}
	
	public static String SelectAlertStepName(String SelectAlertStepName, String jstlUtil){
		if("1".equals(SelectAlertStepName)) return "경보발생";
		else if("2".equals(SelectAlertStepName)) return "현장확인";
		else if("3".equals(SelectAlertStepName)) return "시료분석";
		else if("4".equals(SelectAlertStepName)) return "경보발령";
		else if("5".equals(SelectAlertStepName)) return "상황조치";
		else if("6".equals(SelectAlertStepName)) return "상황종료-측정기이상";
		else if("7".equals(SelectAlertStepName)) return "상황종료-이상데이터";
		else if("8".equals(SelectAlertStepName)) return "상황종료";
		else if("9".equals(SelectAlertStepName)) return "경보등록";
		else if("10".equals(SelectAlertStepName)) return "상황종료-시료분석";
		return "";
	}
}
