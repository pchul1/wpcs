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

public class GaugeChartView extends AbstractView implements Ordered {
	private static final int BOTTOM_CENTER = 0;

	/**
	 * @uml.property  name="log"
	 * @uml.associationEnd  multiplicity="(1 1)"
	 */
	private Log log = LogFactory.getLog(GaugeChartView.class);
	
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
		
		String title = (String)model.get("title");
		String minVl = (String)model.get("minVl");
		String itemName = (String)model.get("itemName");
		String chartWidth = (String)model.get("width");
		String chartHeight = (String)model.get("height");
		if("null".equals(chartWidth)) chartWidth = "680";
		if("null".equals(chartHeight)) chartHeight = "500";
		
	    RadialGauge.initWeb(getServletContext(),request,response);
	    RadialGauge gauge = new RadialGauge();

	    //gauge.setBackColor = java.awt.Color.white;
	    gauge.getBorder().setColor(java.awt.Color.gray);
	    gauge.getBorder().setInsideColor( java.awt.Color.black) ;
	    gauge.getBorder().setStyle(RadialBorderStyle.getCircularBorder18());
	    
	    gauge.getMainScale().getBar().setVisible(false );
	    
	    gauge.getMainScale().setMax(100);
	    
	    if(minVl == null || "".equals(minVl)){
	    	minVl = "0";	    	
	    }
	    
	    //Setting first Section
	    Section section1 = new Section();
	    section1.setMin(0);
	    section1.setMax(50);
	    section1.getBar().setColor(Color.green);
	    section1.getTickmarks().setColor(Color.white);
	    gauge.getMainScale().getSections().add(section1);
	    
	    Section section2 = new Section();
	    section2.setMin(50);
	    section2.setMax(100);
	    section2.getBar().setColor(Color.yellow);
	    section2.getTickmarks().setColor(Color.white);
	    gauge.getMainScale().getSections().add(section2);
	    
	    InnerDigitalPanel innerDigitalPanel1 = new InnerDigitalPanel();
	    innerDigitalPanel1.getSize().setSize(0.7, 0.20);
	    innerDigitalPanel1.getDigitalPanel().setValue(minVl);
	    innerDigitalPanel1.getDigitalPanel().getAppearance().setStyle(DigitalCharacterStyle.getLed01());
	    innerDigitalPanel1.getDigitalPanel().getAppearance().setColor(new java.awt.Color(135,206,250));  // Color LightSkyBlue
	    innerDigitalPanel1.getDigitalPanel().getAppearance().setOffDigitTransparency((short)0);
	    innerDigitalPanel1.getDigitalPanel().getBorder().setStyle(LinearBorderStyle.getLinearBorder06());
	    innerDigitalPanel1.getDigitalPanel().getBorder().setColor(new java.awt.Color(105, 105, 105));  // Color DimGray
	    innerDigitalPanel1.getDigitalPanel().getBorder().setInsideColor(new java.awt.Color(64,64,64));
	    innerDigitalPanel1.getLayout().setTarget(LayoutTarget.ANCHOR_POINT);
	    innerDigitalPanel1.getLayout().getAnchorPoint().setLocation(0.0, -0.57);

	    innerDigitalPanel1.getDigitalPanel().setHeight(20);
	    innerDigitalPanel1.getDigitalPanel().setWidth(300);
	    gauge.getInnerGauges().add(innerDigitalPanel1);	    

	    // Setting the cap
	    gauge.getMainScale().getCap().setStyle(RadialCapStyle.getCap07());
	    gauge.getMainScale().getCap().setSize( 0.2F );
	    gauge.getMainScale().getCap().setColor(new java.awt.Color(230, 232, 250));  // Color Silver

	    //Setting the Main Indicator
	    gauge.getMainIndicator().setColor(new java.awt.Color(205, 127, 50));
	    gauge.getMainIndicator().setValue(minVl);

	    //Setting the MainScale
	    gauge.getMainScale().setRadius(0.7F);

	    //Setting the MainScale tickmarcs
	    gauge.getMainScale().getTickmarks().getMajor().setColor(new java.awt.Color(230, 232, 250));
	    gauge.getMainScale().getTickmarks().getMajor().getLabel().setColor(new java.awt.Color(230, 232, 250));
	    gauge.getMainScale().getTickmarks().getMajor().getLabel().setFont(new GaugeFont("Tahoma", GaugeFontSize.LARGEST, java.awt.Font.BOLD));
	    gauge.getMainScale().getTickmarks().getMajor().getLabel().setOrientation(LabelOrientation.TANGENT);
	    gauge.getMainScale().getTickmarks().getMajor().setSize(3F);
	    gauge.getMainScale().getTickmarks().getMajor().setStyle(TickmarkStyle.getTickmark01_2());
	    gauge.getMainScale().getTickmarks().getMedium().setColor(new java.awt.Color(105, 105, 105));  // Color DimGray
	    gauge.getMainScale().getTickmarks().getMedium().getLabel().setFont(new GaugeFont("Tahoma", GaugeFontSize.LARGER, java.awt.Font.PLAIN));
	    gauge.getMainScale().getTickmarks().getMedium().getLabel().setPosition(Position.CENTER);
	    gauge.getMainScale().getTickmarks().getMedium().setStep(5);
	    gauge.getMainScale().getTickmarks().getMinor().setColor(new java.awt.Color(105, 105, 105));  // Color DimGray
	    gauge.getMainScale().getTickmarks().getMinor().setSize(1F);


	    Needle needle1 =(Needle) gauge.getMainIndicator();
	    needle1.setStyle(NeedleStyle.getNeedle04());
	    needle1.setUseRangeColor(RangeType.SECTION);
	    needle1.setValue(minVl);
	    
	    //Creating and setting the titles
	    Title title1 = new Title();
	    title1.setAngle(315F);
	    title1.getLayout().setTarget(LayoutTarget.ANCHOR_POINT);
	    title1.getLayout().setAlignment(BOTTOM_CENTER) ;
	    title1.getLayout().getAnchorPoint().setLocation(0.475,-0.5);
	    title1.setText(itemName);
	    title1.setColor(Color.gray);
	    title1.setFont(new GaugeFont("Tahoma", GaugeFontSize.MEDIUM, java.awt.Font.PLAIN));

	    gauge.getTitles().add(title1);

	    int width = (int)Double.parseDouble(chartWidth);
	    int height = (int)Double.parseDouble(chartHeight);
	    gauge.setWidth(width);
	    gauge.setHeight(height);
	    gauge.setToolTipEnabled(false);

	    //서버에 capture 파일 생성
	    gauge.renderControl();
	    
	    //로컬에 capture 파일 생성
	    //gauge.renderToStream();
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
}
