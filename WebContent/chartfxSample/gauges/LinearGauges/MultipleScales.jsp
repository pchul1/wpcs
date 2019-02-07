<%@page import="com.softwarefx.chartfx.gauge.*,java.awt.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<link REL="stylesheet" TYPE="text/css" href="../cfxgauges.css" />
	</head>
	<body>
		<form id="Form1" method="post" runat="server">
			<table width="696" border="0" cellspacing="0" cellpadding="0" class="bodyBorder">
				<tr>
					<td>
						<table border="0" cellpadding="2" cellspacing="2">
							<tr>
								<td>
									<P style="FONT-SIZE: 9pt; FONT-FAMILY: Arial" align="justify">Linear Gauges support 
										a collection of scales with different values, tickmarks and markers. These 
										scales can be positioned anywhere inside the drawing area. In the sample below, 
										a thermometer has been recreated showing a Fahrenheit and Celsius scale. 
									</P>
									<P>&nbsp;</P>
								</td>
							</tr>
							<tr>
								<td>
<%
    com.softwarefx.chartfx.gauge.HorizontalGauge.initWeb(pageContext,request,response);
    com.softwarefx.chartfx.gauge.HorizontalGauge gauge = new com.softwarefx.chartfx.gauge.HorizontalGauge();

    //Setting the MainScale
    gauge.getMainScale().getBar().setVisible(false);
    gauge.getMainScale().setMax(100);

    com.softwarefx.chartfx.gauge.Filler filler1 =(com.softwarefx.chartfx.gauge.Filler) gauge.getMainIndicator();
    filler1.setValue("45");
    filler1.setStyle(com.softwarefx.chartfx.gauge.FillerStyle.getFiller07());
    filler1.setColor(java.awt.Color.red);

    gauge.getMainScale().getTickmarks().getMajor().setColor(new java.awt.Color(0,0,0,0));  // Color Transparent
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setFont(new com.softwarefx.chartfx.gauge.GaugeFont("Tahoma", com.softwarefx.chartfx.gauge.GaugeFontSize.MEDIUM, java.awt.Font.BOLD));
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setColor(new java.awt.Color(220,220,220));  // Color Gainsboro

    gauge.getMainScale().getTickmarks().getMedium().setColor(new java.awt.Color(230, 232, 250));  // Color Silver
    gauge.getMainScale().getTickmarks().getMedium().setSize(1.5F);

    gauge.getMainScale().getTickmarks().getMinor().setColor(new java.awt.Color(230, 232, 250));  // Color Silver

    //Creating and setting a secondary Scale
    com.softwarefx.chartfx.gauge.LinearScale linearScale1 = new com.softwarefx.chartfx.gauge.LinearScale();
    linearScale1.setMax(40);
    linearScale1.setMin(-20);
    linearScale1.getLayout().setTarget(com.softwarefx.chartfx.gauge.LayoutTarget.ANCHOR_POINT);
    linearScale1.getLayout().getAnchorPoint().setLocation(0.5, 1.05);

    linearScale1.getBar().setVisible(false);

    linearScale1.getTickmarks().setColor(java.awt.Color.black);
    linearScale1.getTickmarks().getMajor().getLabel().setFont(new com.softwarefx.chartfx.gauge.GaugeFont("Tahoma", com.softwarefx.chartfx.gauge.GaugeFontSize.MEDIUM, java.awt.Font.BOLD));
    linearScale1.getTickmarks().getMajor().getLabel().setColor(new java.awt.Color(220,220,220));  // Color Gainsboro

    gauge.getScales().add(linearScale1);

    //Setting the Border
    gauge.getBorder().setStyle(com.softwarefx.chartfx.gauge.LinearBorderStyle.getThermometer01());
    gauge.getBorder().setColor(java.awt.Color.black);
    gauge.getBorder().setInsideColor(java.awt.Color.black);

    //Setting the titles:
    com.softwarefx.chartfx.gauge.Title title1 = new com.softwarefx.chartfx.gauge.Title();
    title1.setText("C");
    title1.setColor(java.awt.Color.white);
    title1.getLayout().setTarget(com.softwarefx.chartfx.gauge.LayoutTarget.ANCHOR_POINT);
    title1.getLayout().getAnchorPoint().setLocation(1, 0.8);
    gauge.getTitles().add(title1);

    title1 = new com.softwarefx.chartfx.gauge.Title();
    title1.setText("F");
    title1.setColor(java.awt.Color.white);
    title1.getLayout().setTarget(com.softwarefx.chartfx.gauge.LayoutTarget.ANCHOR_POINT);
    title1.getLayout().getAnchorPoint().setLocation(1, 0.25);
    gauge.getTitles().add(title1);

    gauge.setWidth(650);
    gauge.setHeight(120);
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
