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
									<P style="FONT-SIZE: 9pt; FONT-FAMILY: Arial" align="justify">One of the most 
										useful features in a linear gauge scale are sections. These sections allow you 
										to customize any setting in a portion of the scale. Sections are a very 
										flexible way to to change tickmarks, labels or color bars. We have created two 
										sections in which we have changed the font size and tickmarks, among other 
										settings.
									</P>
									<P>&nbsp;</P>
								</td>
							</tr>
							<tr>
								<td>
<%
    com.softwarefx.chartfx.gauge.HorizontalGauge.initWeb(pageContext,request,response);
    com.softwarefx.chartfx.gauge.HorizontalGauge gauge = new com.softwarefx.chartfx.gauge.HorizontalGauge();

    //Setting the Border
    gauge.getBorder().setStyle(com.softwarefx.chartfx.gauge.LinearBorderStyle.getLinearBorder01());
    gauge.getBorder().setColor(java.awt.Color.black);
    gauge.getBorder().setInsideColor(java.awt.Color.black);

    //Setting the MainScale
    gauge.getMainScale().setMax(50);
    gauge.getMainScale().setMin(-50);

    gauge.getMainScale().getBar().setVisible(false);

    // Setting the sections:
    com.softwarefx.chartfx.gauge.Section section1 = new com.softwarefx.chartfx.gauge.Section();
    section1.getBar().setColor(new java.awt.Color(127,255,212));  // Color Aguamarine
    section1.setMax(-40);
    section1.setMin(-50);
    gauge.getMainScale().getSections().add(section1);

    section1 = new com.softwarefx.chartfx.gauge.Section();
    section1.getBar().setColor(new java.awt.Color(127,255,212));  // Color Aguamarine
    section1.setMax(50);
    section1.setMin(40);
    gauge.getMainScale().getSections().add(section1);

    section1 = new com.softwarefx.chartfx.gauge.Section();
    section1.getBar().setColor(new java.awt.Color(0,255,127));  // Color SpringGreen
    section1.setMax(40);
    section1.setMin(30);
    gauge.getMainScale().getSections().add(section1);

    section1 = new com.softwarefx.chartfx.gauge.Section();
    section1.getBar().setColor(new java.awt.Color(50,205,50));  // Color LimeGreen
    section1.setMax(0);
    section1.setMin(30);
    gauge.getMainScale().getSections().add(section1);

    section1 = new com.softwarefx.chartfx.gauge.Section();
    section1.getBar().setColor(new java.awt.Color(50,205,50));  // Color LimeGreen
    section1.setMax(0);
    section1.setMin(-30);
    gauge.getMainScale().getSections().add(section1);

    section1 = new com.softwarefx.chartfx.gauge.Section();
    section1.getBar().setColor(new java.awt.Color(0,255,127));  // Color SpringGreen
    section1.setMax(-30);
    section1.setMin(-40);
    gauge.getMainScale().getSections().add(section1);

    // Setting the Main Indicator:
    com.softwarefx.chartfx.gauge.Marker marker1 = new com.softwarefx.chartfx.gauge.Marker();
    marker1.setValue("0");
    marker1.setStyle(com.softwarefx.chartfx.gauge.MarkerStyle.getMarker07());
    marker1.setColor(new java.awt.Color(255,215,0));  // Color Gold
    gauge.setMainIndicator(marker1);

    gauge.getMainScale().getTickmarks().getMajor().setColor(java.awt.Color.white);
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setFont(new com.softwarefx.chartfx.gauge.GaugeFont("Tahoma", com.softwarefx.chartfx.gauge.GaugeFontSize.MEDIUM, java.awt.Font.BOLD));
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setColor(java.awt.Color.white);
    gauge.getMainScale().getTickmarks().getMedium().setVisible(false);

    //Setting the title:
    com.softwarefx.chartfx.gauge.Title title1 = new com.softwarefx.chartfx.gauge.Title();
    title1.setText("PPM Meter");
    title1.setColor(java.awt.Color.white);
    title1.setAngle(90F);
    title1.getLayout().setTarget(com.softwarefx.chartfx.gauge.LayoutTarget.ANCHOR_POINT);
    title1.getLayout().getAnchorPoint().setLocation(0.075, 0.975);
    gauge.getTitles().add(title1);
    
    gauge.getMainIndicator().setValue("0");

    gauge.setWidth(650);
    gauge.setHeight(100);
    gauge.setToolTipEnabled(false);
    gauge.renderControl();%>
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
