package daewooInfo.waterpolmnt.situationctl.view;

import java.awt.Color;

import com.softwarefx.chartfx.server.MarkerShape;

public class ItemShape {
	

	/**
	 * 아이템의 단위를 구합니다.
	 * @param code
	 * @return
	 */
	public static String getItemUnit(String code)
	{
		String result = "";
		if(code.equals("TUR00") || code.equals("TUR")){
			result = "(NTU)";
		}			
		else if(code.equals("DOW00") || code.equals("DOW00") || code.equals("DOW") || code.equals("PO400") ||
				code.equals("CAD00") || code.equals("PLU00") || code.equals("COP00") || code.equals("ZIN00") ||
				code.equals("PHE00") || code.equals("PHL00") || code.equals("TOC00") || code.equals("TON00") || code.equals("TOP00") ||
				code.equals("NH400") || code.equals("NO300")) {
			result = "(mg/L)";
		}
		else if(code.equals("CON00") || code.equals("CON01") || code.equals("CON"))
		{			
			result = "(mS/cm)";
		}
		else if(code.equals("TMP00") || code.equals("TMP01") || code.equals("TMP"))
		{
			result = "(℃)";
		}
		else if(code.equals("IMP00") || code.equals("LIM00") || code.equals("RIM00"))
		{
			result = "(pulse)";
		}
		else if(code.equals("LTX00") || code.equals("RTX00") || code.equals("EVN00"))
		{
			result = "(TOX)";
		}
		else if(code.equals("TOX00"))	
		{
			result = "(%)";
		}
		else if(code.equals("TOF") || code.equals("TOF00") || code.equals("VOC01") || code.equals("VOC02") || code.equals("VOC03") || code.equals("VOC04") || code.equals("VOC05") ||
				code.equals("VOC06") || code.equals("VOC07") || code.equals("VOC08") || code.equals("VOC09") || code.equals("VOC10") || code.equals("VOC11") || code.equals("VOC12") ||
				code.equals("VOC13") || code.equals("VOC14") || code.equals("VOC15"))	
		{
			result = "(㎍/L)";	
		}		
		else if(code.equals("RIN00"))
		{
			result = "(mm/L)";
		}
		else if(code.equals("FLW00"))
		{
			result = "(cms)";
		}
		else if(code.equals("WLV00"))
		{
			result = "(cm)";
		}
		else if(code.equals("BOD00") || code.equals("COD00"))
		{
			result="(ppm)";
		}
		else if(code.equals("FLW"))
		{
			result ="(㎥/d)";
		}
		else if(code.equals("VAL"))
		{
			result ="(kg/d)";
		}
		else if(code.equals("AVG"))
		{
			result ="(mg/ℓ)";
		}
		
		return result;
	}
	
	
	/**
	 * 항목마다 정해진 그래프 마커(Marker)의 Shape를 리턴합니다.
	 * @param code
	 * @param sys
	 * @return
	 */
	public static MarkerShape getMarkerShape(String code, String sys)
	{
		MarkerShape marker = null;

		if(!"A".equals(sys))
		{
			//측정망이 아닐 때
			if("TUR00".equals(code) || "TUR".equals(code) || "FLW".equals(code) || "MAX".equals(code))
			{
				marker = MarkerShape.CIRCLE;
			}
			else if("DOW00".equals(code) || "DOW".equals(code) || "WLV".equals(code) || "BOD".equals(code) || "AVG".equals(code))
			{
				marker = MarkerShape.TRIANGLE;
			}
			else if("PHY00".equals(code) || "PHY".equals(code) || "MIN".equals(code))
			{
				marker = MarkerShape.RECT;
			}
			else if("CON00".equals(code) || "CON".equals(code) || "SUS".equals(code))
			{
				marker = MarkerShape.DIAMOND;
			}
			else if("TMP00".equals(code) || "TMP".equals(code) || "TON".equals(code))
			{
				marker = MarkerShape.INVERTED_TRIANGLE;
			}
			else if("TOP".equals(code))
			{
				marker = MarkerShape.CROSS;
			}
			else if("COD".equals(code))
			{
				marker = MarkerShape.HORIZONTAL_LINE;
			}
			else if("TOF00".equals(code) || "TOF".equals(code))
			{
				marker = MarkerShape.VERTICAL_LINE;
			}
		}
		else
		{
			//일반항목(내부)
			if("DOW00".equals(code) || "MAX".equals(code))
			{
				marker = MarkerShape.TRIANGLE;
			}
			if("PHY00".equals(code) || "AVG".equals(code))
			{
				marker = MarkerShape.RECT;
			}
			if("CON00".equals(code) || "MIN".equals(code))
			{
				marker = MarkerShape.DIAMOND;
			}
			if("TMP00".equals(code))
			{
				marker = MarkerShape.INVERTED_TRIANGLE;
			}
			
			if("TUR00".equals(code))
			{
				marker = MarkerShape.CIRCLE;
			}
			else if("DOW01".equals(code))
			{
				marker = MarkerShape.TRIANGLE;
			}
			else if("PHY01".equals(code))
			{
				marker = MarkerShape.RECT;
			}
			else if("CON01".equals(code))
			{
				marker = MarkerShape.DIAMOND;
			}
			else if("TMP01".equals(code))
			{
				marker = MarkerShape.INVERTED_TRIANGLE;
			}
			
			//생물성 물고기
			if("IMP00".equals(code))
			{
				marker = MarkerShape.CIRCLE;
			}
			
			
			if("LIM00".equals(code))
			{
				marker = MarkerShape.CIRCLE;
			}
			if("RIM00".equals(code))
			{
				marker = MarkerShape.TRIANGLE;
			}
			
			if("LTX00".equals(code))
			{
				marker = MarkerShape.CIRCLE;
			}
			if("RTX00".equals(code))
			{
				marker = MarkerShape.TRIANGLE;
			}
			
			
			if("TOX00".equals(code))
			{
				marker = MarkerShape.CIRCLE;
			}
			
			if("EVN00".equals(code))
			{
				marker = MarkerShape.CIRCLE;
			}
			
			if("TOF00".equals(code))
			{
				marker = MarkerShape.CIRCLE;
			}
			
			
			if("CAD00".equals(code))
			{
				marker = MarkerShape.CIRCLE;
			}
			if("PLU00".equals(code))
			{
				marker = MarkerShape.TRIANGLE;
			}
			if("COP00".equals(code))
			{
				marker = MarkerShape.RECT;
			}
			if("ZIN00".equals(code))
			{
				marker = MarkerShape.DIAMOND;
			}
			
			
			if("PHE00".equals(code))
			{
				marker = MarkerShape.CIRCLE;
			}
			if("PHL00".equals(code))
			{
				marker = MarkerShape.TRIANGLE;
			}
			
		
			if("TOC00".equals(code))
			{
				marker = MarkerShape.CIRCLE;
			}
			
			
			if("TON00".equals(code))
			{
				marker = MarkerShape.CIRCLE;
			}
			if("TOP00".equals(code))
			{
				marker = MarkerShape.TRIANGLE;
			}
			if("NH400".equals(code))
			{
				marker = MarkerShape.RECT;
			}
			if("NO300".equals(code))
			{
				marker = MarkerShape.DIAMOND;
			}
			if("PO400".equals(code))
			{
				marker = MarkerShape.INVERTED_TRIANGLE;
			}
			
			if("RIN00".equals(code))
			{
				marker = MarkerShape.CIRCLE;
			}
		}
		return marker;
	}
	
	/**
	 * 항목별로 정해진 라인 그래프의 색을 리턴합니다.
	 * @param code
	 * @param sys
	 * @return
	 */
	public static Color getSeriesColor(String code, String sys)
	{
		Color color = null;
		
    	
		if(!"A".equals(sys))
		{	
			if("TUR00".equals(code) || "TUR".equals(code) || "FLW".equals(code) || "MAX".equals(code))
			{
				color = new Color(0, 51, 204);
			}
			else if("DOW00".equals(code) || "DOW".equals(code) || "WLV".equals(code) || "BOD".equals(code) || "AVG".equals(code))
			{
				color = new Color(102, 204, 0);
			}
			else if("PHY00".equals(code) || "PHY".equals(code) || "MIN".equals(code) || "VAL".equals(code))
			{
				color = new Color(0, 204, 204);
			}
			else if("CON00".equals(code) || "CON".equals(code) || "SUS".equals(code))
			{
				color = new Color(255, 204, 0);
			}
			else if("TMP00".equals(code) || "TMP".equals(code) || "TON".equals(code))
			{
				color = new Color(255,102,102);
			}
			else if("TOP".equals(code))
			{
				color = new Color(153,0,153);
			}
			else if("COD".equals(code))
			{
				color = new Color(153,153,153);
			}
			else if("TOF00".equals(code) || "TOF".equals(code))
			{
				color = new Color(117,85,170);
			}
		}
		else
		{
			//일반항목(내부)
			if("DOW00".equals(code) || "MAX".equals(code))
			{
				color = new Color(102, 204, 0);
			}
			if("PHY00".equals(code) || "AVG".equals(code))
			{
				color = new Color(0, 204, 204);
			}
			if("CON00".equals(code) || "MIN".equals(code))
			{
				color = new Color(255, 204, 0);
			}
			if("TMP00".equals(code))
			{
				color = new Color(255,102,102);
			}
			
			//일반항목(외부)
			if("DOW01".equals(code))
			{
				color = new Color(102, 204, 0);
			}
			if("PHY01".equals(code))
			{
				color = new Color(0, 204, 204);
			}
			if("CON01".equals(code))
			{
				color = new Color(255, 204, 0);
			}
			if("TMP01".equals(code))
			{
				color = new Color(255,102,102);
			}
			if("TUR00".equals(code))
			{
				color = new Color(0, 51, 204);
			}
			
		
			//생물성 물고기
			if("IMP00".equals(code))
			{
				color = new Color(102, 204, 0);
			}
			
			
			if("LIM00".equals(code))
			{
				color = new Color(102, 204, 0);
			}
			if("RIM00".equals(code))
			{
				color = new Color(0, 204, 204);
			}
			
			if("LTX00".equals(code))
			{
				color = new Color(102, 204, 0);
			}
			if("RTX00".equals(code))
			{
				color = new Color(0, 204, 204);
			}
			
			
			if("TOX00".equals(code))
			{
				color = new Color(102, 204, 0);
			}
			
			if("EVN00".equals(code))
			{
				color = new Color(102, 204, 0);
			}
			
			if("TOF00".equals(code))
			{
				color = new Color(117,85,170);
			}
			
			
			if("CAD00".equals(code))
			{
				color = new Color(102, 204, 0);
			}
			if("PLU00".equals(code))
			{
				color = new Color(0, 204, 204);
			}
			if("COP00".equals(code))
			{
				color = new Color(255, 204, 0);
			}
			if("ZIN00".equals(code))
			{
				color = new Color(255,102,102);
			}
			
			
			if("PHE00".equals(code))
			{
				color = new Color(102, 204, 0);
			}
			if("PHL00".equals(code))
			{
				color = new Color(0, 204, 204);
			}
			
		
			if("TOC00".equals(code))
			{
				color = new Color(102, 204, 0);
			}
			
			
			if("TON00".equals(code))
			{
				color = new Color(102, 204, 0);
			}
			if("TOP00".equals(code))
			{
				color = new Color(0, 204, 204);
			}
			if("NH400".equals(code))
			{
				color = new Color(255, 204, 0);
			}
			if("NO300".equals(code))
			{
				color = new Color(255,102,102);
			}
			if("PO400".equals(code))
			{
				color = new Color(0, 51, 204);
			}
			
			if("RIN00".equals(code))
			{
				color = new Color(102, 204, 0);
			}

		}
		
		return color;
	}


	public static Double getItemMax(String code) {
		
		Double result = 0.0D;
		
		//일반항목(내부)
		if("DOW00".equals(code))
		{
			result = 20D;
		}
		if("PHY00".equals(code))
		{
			result = 10D;
		}
		if("CON00".equals(code) || "MIN".equals(code))
		{
			result = 5D;
		}
		if("TMP00".equals(code))
		{
			result = 30D;
		}
		
		//일반항목(외부)
		if("DOW01".equals(code))
		{
			result = 20D;
		}
		if("PHY01".equals(code))
		{
			result = 10D;
		}
		if("CON01".equals(code))
		{
			result = 5D;
		}
		if("TMP01".equals(code))
		{
			result = 30D;
		}
		if("TUR00".equals(code))
		{
			result = 1000D;
		}
		
	
		//생물성 물고기
		if("IMP00".equals(code))
		{
			result = 1000D;
		}
		
		
		if("LIM00".equals(code))
		{
			result = 1000D;
		}
		if("RIM00".equals(code))
		{
			result = 1000D;
		}
		
		if("LTX00".equals(code))
		{
			result = 10D;
		}
		if("RTX00".equals(code))
		{
			result = 10D;
		}
		
		
		if("TOX00".equals(code))
		{
			result = 10D;
		}
		
		if("EVN00".equals(code))
		{
			result = 10D;
		}
		
		if("TOF00".equals(code))
		{
			result = 100D;
		}
		
		
		if(code.startsWith("VOC"))
		{
			result = 150D;
		}
		
		if("CAD00".equals(code))
		{
			result = 100D;	
		}
		if("PLU00".equals(code))
		{
			result = 100D;
		}
		if("COP00".equals(code))
		{
			result = 100D;
		}
		if("ZIN00".equals(code))
		{
			result = 100D;
		}
		
		
		if("PHE00".equals(code))
		{
			result = 10D;
		}
		if("PHL00".equals(code))
		{
			result = 10D;
		}
		
	
		if("TOC00".equals(code))
		{
			result = 100D;
		}
		
		
		if("TON00".equals(code))
		{
			result = 10D;
		}
		if("TOP00".equals(code))
		{
			result = 2D;
		}
		if("NH400".equals(code))
		{
			result = 1D;
		}
		if("NO300".equals(code))
		{
			result = 5D;
		}
		if("PO400".equals(code))
		{
			result = 1D;
		}
		
		if("RIN00".equals(code))
		{
			result = 10D;
		}
		return result;
	}
}
