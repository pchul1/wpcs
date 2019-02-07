package daewooInfo.waterpolmnt.situationctl.view;

import java.awt.Color;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.core.Ordered;
import org.springframework.web.servlet.view.AbstractView;

import ChartFX.internal.WebForms.Gauge.HorizontalGauge;

import com.softwarefx.chartfx.gauge.DigitalCharacterStyle;
import com.softwarefx.chartfx.gauge.DimensionFloat;
import com.softwarefx.chartfx.gauge.GaugeFont;
import com.softwarefx.chartfx.gauge.GaugeFontSize;
import com.softwarefx.chartfx.gauge.InnerDigitalPanel;
import com.softwarefx.chartfx.gauge.LabelOrientation;
import com.softwarefx.chartfx.gauge.LayoutTarget;
import com.softwarefx.chartfx.gauge.LinearBorderStyle;
import com.softwarefx.chartfx.gauge.Needle;
import com.softwarefx.chartfx.gauge.NeedleStyle;
import com.softwarefx.chartfx.gauge.Position;
import com.softwarefx.chartfx.gauge.RadialBorderStyle;
import com.softwarefx.chartfx.gauge.RadialCapStyle;
import com.softwarefx.chartfx.gauge.RadialGauge;
import com.softwarefx.chartfx.gauge.RadialScale;
import com.softwarefx.chartfx.gauge.RangeType;
import com.softwarefx.chartfx.gauge.Section;
import com.softwarefx.chartfx.gauge.TickmarkStyle;
import com.softwarefx.chartfx.gauge.Title;

public class DoGaugeView extends AbstractView implements Ordered {

	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	private Log log = LogFactory.getLog(DoGaugeView.class);
	
	/**
	 * @uml.property  name="chartTemplatePath"
	 */
	private String chartTemplatePath;
	/**
	 * @uml.property  name="order"
	 */
	private int order = Integer.MAX_VALUE;
	
	@SuppressWarnings("unchecked")
	@Override
	protected void renderMergedOutputModel(Map model,
			HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		response.setContentType("text/html; charset=UTF-8");
		
		String minVl = (String)model.get("minVl");
		String minOr = (String)model.get("minOr");		
		String lawVl = (String)model.get("lawVl");
		String chartWidth = (String)model.get("width");
		String chartHeight = (String)model.get("height");
		if("null".equals(chartWidth)) chartWidth = "200";
		if("null".equals(chartHeight)) chartHeight = "25";

		if(minVl == null || minVl.trim().equals("-") || minVl.trim().equals(""))
			minVl = "0";
		if(lawVl == null || lawVl.trim().equals("-") || lawVl.trim().equals(""))
			lawVl = "0";
		
		minVl = minVl.replaceAll(",", "");
		
		float minVlF = Float.parseFloat(minVl);
		minVlF = (float)Math.round(minVlF * 10)/10;
		
		com.softwarefx.chartfx.gauge.HorizontalGauge.initWeb(getServletContext(),request,response);
	    com.softwarefx.chartfx.gauge.HorizontalGauge gauge = new com.softwarefx.chartfx.gauge.HorizontalGauge();

	    
	    //Setting the MainScale
	    gauge.getMainScale().getBar().setVisible(true);
	    gauge.getMainScale().setMin(0);
	    gauge.getMainScale().setMax(10);

	    
	    //Indicator Color
	    Color markerColor = null;
	    
//	    float value = Float.parseFloat(minVl);
//	    float lawValue = Float.parseFloat(lawVl);
//	    if(value <= lawValue)
//    	markerColor = new Color(199,56,0);
//    else
//    	markerColor = new Color(0,153,204);
	    
	    
	    markerColor = getPointColor(minOr);
	    

	    ///* 탁수만 기준치 표시함
	    // Setting the Main Indicator:
	    com.softwarefx.chartfx.gauge.Filler filler1 = new com.softwarefx.chartfx.gauge.Filler();
	    filler1.setValue(minVlF);
	    filler1.setStyle(com.softwarefx.chartfx.gauge.FillerStyle.getFiller04());
	    //filler1.setSize(1.0F);
	    filler1.setColor(markerColor);  
	    gauge.setMainIndicator(filler1);
	    
	    /*
	    //  Setting a Second Indicator:
	    com.softwarefx.chartfx.gauge.Marker marker1 = new com.softwarefx.chartfx.gauge.Marker();
	    marker1.setValue(lawVl);
	    marker1.setStyle(com.softwarefx.chartfx.gauge.MarkerStyle.getMarker04());
	    marker1.getLabel().setColor(new java.awt.Color(255,250,250)); 
	    marker1.setSize(1.0F);
	    marker1.getLabel().setVisible(true);
	    marker1.setColor(new java.awt.Color(199,56,0));
	    marker1.setPosition(0);
	    marker1.setVerticalPosition(1);
	    gauge.getMainScale().getIndicators().add(marker1);
	    */
	    
	    gauge.getMainScale().setSize(0.95F);
	    gauge.getMainScale().setThickness(0.4F);
	    gauge.getMainScale().getLayout().setTarget(com.softwarefx.chartfx.gauge.LayoutTarget.ANCHOR_POINT);
	    gauge.getMainScale().getLayout().getAnchorPoint().setLocation(0.5F, 0.50F);
	    gauge.getMainScale().setColor(new Color(235,235,235));
	    
//	    gauge.getMainScale().getTickmarks().getMajor().setColor(new java.awt.Color(83,95,105));  // Color Transparent
//	    gauge.getMainScale().getTickmarks().getMajor().getLabel().setFont(new com.softwarefx.chartfx.gauge.GaugeFont("Tahoma", com.softwarefx.chartfx.gauge.GaugeFontSize.MEDIUM, java.awt.Font.BOLD));
//	    gauge.getMainScale().getTickmarks().getMajor().getLabel().setColor(Color.black);  // Color Gainsboro
//	    gauge.getMainScale().getTickmarks().getMajor().setStep(2);
 
	    gauge.getMainScale().getTickmarks().getMajor().setVisible(false);
	    gauge.getMainScale().getTickmarks().getMedium().setVisible(false);
	    gauge.getMainScale().getTickmarks().getMinor().setVisible(false);

	    
	    //Setting the Border
	    gauge.getBorder().setVisible(false);


	 	//Setting the inner gauge
//	    com.softwarefx.chartfx.gauge.InnerDigitalPanel innerDigitalPanel1 = new com.softwarefx.chartfx.gauge.InnerDigitalPanel();
//	    innerDigitalPanel1.getDigitalPanel().getAppearance().setStyle(DigitalCharacterStyle.getSevenSegments01());
//	    innerDigitalPanel1.setSize(new DimensionFloat(0.5F, 0.5F));
//	    innerDigitalPanel1.getDigitalPanel().getBorder().setVisible(false);
//	    innerDigitalPanel1.getLayout().setTarget(com.softwarefx.chartfx.gauge.LayoutTarget.ANCHOR_POINT);
//	    innerDigitalPanel1.getLayout().getAnchorPoint().setLocation(0.9F, 0.52F);
//	    innerDigitalPanel1.setLinkToMainValue(true);
//	    innerDigitalPanel1.getDigitalPanel().getAppearance().setColor(new Color(199,56,0));
//	    gauge.getInnerGauges().add(innerDigitalPanel1);
	    
	    
	    int width = (int)Double.parseDouble(chartWidth);
	    int height = (int)Double.parseDouble(chartHeight);
	    gauge.setWidth(width);
	    gauge.setHeight(height);
	    gauge.setToolTipEnabled(false);
		
	    //서버에 capture 파일 생성
	    //gauge.renderControl();
	    
	    //로컬에 capture 파일 생성
	    gauge.renderToStream();
	}

	/**
	 * @return
	 * @uml.property  name="chartTemplatePath"
	 */
	public String getChartTemplatePath() {
		return chartTemplatePath;
	}


	/**
	 * @param chartTemplatePath
	 * @uml.property  name="chartTemplatePath"
	 */
	public void setChartTemplatePath(String chartTemplatePath) {
		this.chartTemplatePath = chartTemplatePath;
	}


	/**
	 * @param order
	 * @uml.property  name="order"
	 */
	public void setOrder(int order) {
		this.order = order;
	}
	
	/**
	 * @return
	 * @uml.property  name="order"
	 */
	public int getOrder() {
		return this.order;
	}
	
	public Color getPointColor(String minor)
	{
		if(minor == null)
			return Color.green;
		
		Color result = Color.green;
		
		if(minor.equals("0"))
		{
			float[] hsb = Color.RGBtoHSB(80, 180, 60, null);	
			result = Color.getHSBColor(hsb[0], hsb[1], hsb[2]);
		}
		else if(minor.equals("1"))
			result = new Color(20, 100, 255);
		else if(minor.equals("2"))
			result = Color.yellow;
		else if(minor.equals("3"))
			result = Color.orange;
		else if(minor.equals("4"))
			result = new Color(255,74,74);
		
		return result;
	}
}
