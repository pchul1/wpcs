<%@ page contentType="text/xml"%>
<chartfx>
<%@page import="com.softwarefx.chartfx.gauge.*"%>
<%@page import="java.awt.*"%>
<%
try {
    com.softwarefx.chartfx.gauge.RadialGauge.initWeb(pageContext,request,response);
    com.softwarefx.chartfx.gauge.RadialGauge gauge = new com.softwarefx.chartfx.gauge.RadialGauge();
    
    String sValue = request.getParameter("v");
	String sBorder = request.getParameter("b");
	String sNeedle = request.getParameter("n");
	String sCap = request.getParameter("c");
	
	if (sValue == null)
		sValue = "45";
	if (sBorder == null)
		sBorder = "CircularBorder01";
	if (sNeedle == null)
		sNeedle = "Needle01";
	if (sCap == null)
		sCap = "Cap01";	

    //gauge.setBackColor = java.awt.Color.white;
    gauge.getBorder().setColor(java.awt.Color.gray);
    gauge.getBorder().setInsideColor( java.awt.Color.black) ;
    gauge.getBorder().setStyle(new RadialBorderStyle(sBorder));

    gauge.getMainScale().getBar().setVisible(false );
    gauge.getMainScale().setMax(100);

    // Setting the cap
    gauge.getMainScale().getCap().setStyle(new RadialCapStyle(sCap));
    gauge.getMainScale().getCap().setSize( 0.2F );
    gauge.getMainScale().getCap().setColor(new java.awt.Color(230, 232, 250));  // Color Silver

    //Setting the Main Indicator
	com.softwarefx.chartfx.gauge.Needle needle = (Needle) gauge.getMainIndicator();
	needle.setColor(new java.awt.Color(205, 127, 50));
	needle.setValue(sValue);
	needle.setStyle(new NeedleStyle(sNeedle));
	
    //Setting the MainScale
    gauge.getMainScale().setRadius(0.7F);

    //Setting the MainScale tickmarcs
    gauge.getMainScale().getTickmarks().getMajor().setColor(new java.awt.Color(230, 232, 250));
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setColor(new java.awt.Color(230, 232, 250));
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setFont(new GaugeFont("Tahoma", GaugeFontSize.SMALLER, java.awt.Font.BOLD));
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setOrientation(LabelOrientation.TANGENT);
    gauge.getMainScale().getTickmarks().getMajor().setSize(1.3F);
    gauge.getMainScale().getTickmarks().getMajor().setStyle(new TickmarkStyle("Tickmark01_2"));
    gauge.getMainScale().getTickmarks().getMedium().setColor(new java.awt.Color(105, 105, 105));  // Color DimGray
    gauge.getMainScale().getTickmarks().getMedium().getLabel().setFont(new GaugeFont("Tahoma", GaugeFontSize.SMALLER, java.awt.Font.PLAIN));
    gauge.getMainScale().getTickmarks().getMedium().getLabel().setPosition(Position.CENTER);
    gauge.getMainScale().getTickmarks().getMedium().setStep(5);
    gauge.getMainScale().getTickmarks().getMinor().setColor(new java.awt.Color(105, 105, 105));  // Color DimGray
    gauge.getMainScale().getTickmarks().getMinor().setSize(1F);

    //Creating and setting a new Scale
    RadialScale radialScale1 = new RadialScale();

    radialScale1.getBar().setColor(new java.awt.Color(105, 105, 105));  // Color DimGray
    radialScale1.getBar().setVisible(true);
    radialScale1.setMax(240);
    radialScale1.setRadius(0.6F);
    radialScale1.setThickness(0.059F);
    radialScale1.getTickmarks().getMajor().setStep(20);
    radialScale1.getTickmarks().getMajor().setPosition(Position.BOTTOM);
    radialScale1.getTickmarks().getMajor().setColor(new java.awt.Color(105, 105, 105));  // Color DimGray
    radialScale1.getTickmarks().getMajor().getLabel().setColor(new java.awt.Color(211, 211, 211));  // Color LightGray
    radialScale1.getTickmarks().getMajor().getLabel().setFont(new GaugeFont("Tahoma", GaugeFontSize.SMALLER, java.awt.Font.BOLD));
    radialScale1.getTickmarks().getMajor().getLabel().setPosition(Position.BOTTOM);
    radialScale1.getTickmarks().getMajor().setSize(1F);
    radialScale1.getTickmarks().getMajor().setStyle(new TickmarkStyle("Tickmark01_3"));
    radialScale1.getTickmarks().getMedium().setVisible(false);
    radialScale1.getTickmarks().getMinor().setVisible(false);
    gauge.getScales().add(radialScale1);

    //Creating and setting the titles
    Title title1 = new Title();
    title1.setAngle(315F);
    title1.getLayout().setTarget(LayoutTarget.ANCHOR_POINT);
    title1.getLayout().getAnchorPoint().setLocation(0.475,-0.5);
    title1.setText("MPH");
    title1.setColor(Color.gray);
    title1.setFont(new GaugeFont("Tahoma", GaugeFontSize.SMALLER, java.awt.Font.PLAIN));

    Title title2 = new Title();
    title2.setAngle(315F);
    title2.getLayout().setTarget(LayoutTarget.ANCHOR_POINT);
    title2.getLayout().getAnchorPoint().setLocation(0.3,-0.4);
    title2.setText("KPH");
    title2.setColor(Color.gray);
    title2.setFont(new GaugeFont("Tahoma", GaugeFontSize.SMALLEST, java.awt.Font.PLAIN));

    gauge.getTitles().add(title1);
    gauge.getTitles().add(title2);

    gauge.setWidth(350);
    gauge.setHeight(320);
    gauge.setToolTipEnabled(false);

	
    gauge.renderControl();
	}
	catch (java.lang.Exception e)
	{
		out.println("<error>");
		out.println(e.getMessage());
		out.println("</error>");
	}
%>
</chartfx>