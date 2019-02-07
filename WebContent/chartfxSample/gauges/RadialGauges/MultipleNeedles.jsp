<%@page import="com.softwarefx.chartfx.gauge.*,java.awt.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link REL="stylesheet" TYPE="text/css" href="../cfxgauges.css">
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

    gauge.getBorder().setColor(Color.black);
    gauge.getBorder().setInsideColor( Color.black) ;
    gauge.getBorder().setStyle(RadialBorderStyle.getCircularBorder09());

    gauge.getMainScale().setStartAngle(90F);
    gauge.getMainScale().setSweepAngle(-360F);
    gauge.getMainScale().setMax(12);
    gauge.getMainScale().setRadius(0.89F);
    gauge.getMainScale().setMaxAlwaysDisplayed(true);
    gauge.getMainScale().setThickness(0.1001F);

    gauge.getMainScale().getBar().setVisible(false);

    Needle needle1 =(Needle) gauge.getMainIndicator();
    needle1.setStyle( NeedleStyle.getNeedle02());
    needle1.setSize(0.75F);
    needle1.setValue("20");

    needle1.setColor(new java.awt.Color(245, 245, 245));  // Color WhiteSmoke

    gauge.getMainScale().getTickmarks().getMajor().setColor(Color.white);
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setFont(new GaugeFont("Arial", GaugeFontSize.LARGER, java.awt.Font.PLAIN));
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setColor(new java.awt.Color(245, 245, 245));  // Color WhiteSmoke
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setPosition(Position.CENTER);
    gauge.getMainScale().getTickmarks().getMajor().setStep(3);
    gauge.getMainScale().getTickmarks().getMajor().setStyle(TickmarkStyle.getNone());

    gauge.getMainScale().getTickmarks().getMedium().setStep(1);
    gauge.getMainScale().getTickmarks().getMedium().setSize(1.54F);
    gauge.getMainScale().getTickmarks().getMedium().setStyle(TickmarkStyle.getTickmark01_3());
    gauge.getMainScale().getTickmarks().getMedium().setColor(new java.awt.Color(230, 232, 250));  // Color Silver
    gauge.getMainScale().getTickmarks().getMinor().setVisible(false);

    //Creating and setting a new scale
    RadialScale radialScale1 = new RadialScale();

    radialScale1.getBar().setVisible(false);

    radialScale1.setStartAngle(90F);
    radialScale1.setSweepAngle(-360F);
    radialScale1.setMax(60);
    radialScale1.setRadius(1F);
    radialScale1.setThickness(0.0583F);

    // Setting the indicators for the new Scale
    needle1 = new Needle();
    needle1.setStyle(NeedleStyle.getNeedle02());
    needle1.setSize(0.9F);
    needle1.setValue("20");
    needle1.setColor(new java.awt.Color(245, 245, 245));  // Color WhiteSmoke
    radialScale1.getIndicators().add(needle1);

    needle1 = new Needle();
    needle1.setSize(0.93F);
    needle1.setValue("25");
    needle1.setColor(new java.awt.Color(245, 245, 245));  // Color WhiteSmoke
    radialScale1.getIndicators().add(needle1);

    radialScale1.getTickmarks().getMajor().setColor(new java.awt.Color(245, 245, 245));  // Color WhiteSmoke
    radialScale1.getTickmarks().getMajor().getLabel().setVisible(false);
    radialScale1.getTickmarks().getMajor().setStep(5);
    radialScale1.getTickmarks().getMajor().setSize(1F);
    radialScale1.getTickmarks().getMajor().setStyle(TickmarkStyle.getTickmark10_1());

    radialScale1.getTickmarks().getMedium().setVisible(false);

    radialScale1.getTickmarks().getMinor().setColor(new java.awt.Color(245, 245, 245));  // Color WhiteSmoke
    radialScale1.getTickmarks().getMinor().setStep(1);

    gauge.getScales().add(radialScale1);

    gauge.setWidth(320);
    gauge.setHeight(350);
    gauge.setToolTipEnabled(false);
    gauge.renderControl();%>
								</td>
								<td>
									<P style="FONT-SIZE: 9pt; FONT-FAMILY: Arial" align="justify">Radial Gauges support 
										a collection of scales and needles. In this sample we're simulating an analog 
										clock with three needles: the hour, the minutes and the seconds.
									</P>
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
</html>
