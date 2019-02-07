<%@page import="com.softwarefx.chartfx.gauge.*,java.awt.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <link REL="stylesheet" TYPE="text/css" href="../cfxgauges.css"/>
    </head>
    <body>
        <form id="Form1" method="post" runat="server">
            <table width="696" border="0" cellspacing="0" cellpadding="0" class="bodyBorder">
                <tr>
                    <td>
                    <table border="0" cellpadding="2" cellspacing="2">
                        <tr>
                            <td>
<%
    com.softwarefx.chartfx.gauge.RadialGauge.initWeb(pageContext,request,response);
    com.softwarefx.chartfx.gauge.RadialGauge gauge = new com.softwarefx.chartfx.gauge.RadialGauge();

    //gauge.setBackColor = java.awt.Color.white;
    gauge.getBorder().setColor(java.awt.Color.gray);
    gauge.getBorder().setInsideColor( java.awt.Color.black) ;
    gauge.getBorder().setStyle(RadialBorderStyle.getCircularBorder18());

    gauge.getMainScale().getBar().setVisible(false );
    gauge.getMainScale().setMax(100);

    // Setting the cap
    gauge.getMainScale().getCap().setStyle(RadialCapStyle.getCap02());
    gauge.getMainScale().getCap().setSize( 0.2F );
    gauge.getMainScale().getCap().setColor(new java.awt.Color(230, 232, 250));  // Color Silver

    //Setting the Main Indicator
    gauge.getMainIndicator().setColor(new java.awt.Color(205, 127, 50));
    gauge.getMainIndicator().setValue("45");

    //Setting the MainScale
    gauge.getMainScale().setRadius(0.7F);

    //Setting the MainScale tickmarcs
    gauge.getMainScale().getTickmarks().getMajor().setColor(new java.awt.Color(230, 232, 250));
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setColor(new java.awt.Color(230, 232, 250));
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setFont(new GaugeFont("Tahoma", GaugeFontSize.SMALLER, java.awt.Font.BOLD));
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setOrientation(LabelOrientation.TANGENT);
    gauge.getMainScale().getTickmarks().getMajor().setSize(1.3F);
    gauge.getMainScale().getTickmarks().getMajor().setStyle(TickmarkStyle.getTickmark01_2());
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
    radialScale1.getTickmarks().getMajor().setStyle(TickmarkStyle.getTickmark01_3());
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

    gauge.setWidth(320);
    gauge.setHeight(350);
    gauge.setToolTipEnabled(false);
    gauge.renderControl();
%>
                            </td>
                            <td>
                                <P style="FONT-SIZE: 9pt; FONT-FAMILY: Arial" align="justify">This gauge 
                                simulates a  vehicle speedometer with MPH (miles per hour) and KPH (Kilometers 
                                per hour) and uses two scales in a radial frame. </P>
                                <P>&nbsp;</P>
                            </td>
                        </tr>
                    </table>
                    </td>
                </tr>
            </table>
            &nbsp;
        </form>
    </body>
</HTML>