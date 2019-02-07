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
									<P style="FONT-SIZE: 9pt; FONT-FAMILY: Arial" align="justify">In some cases a 
										single indicator or filler is not enough to represent values in a linear gauge. 
										In the sample below two indicators have been created and synchronized in the 
										main scale. Each scale in a linear gauge supports a collection of indicators so 
										you can highlight one or more values.
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
    gauge.getBorder().setStyle(com.softwarefx.chartfx.gauge.LinearBorderStyle.getLinearBorder11());
    gauge.getBorder().setColor(java.awt.Color.black);
    gauge.getBorder().setInsideColor(java.awt.Color.black);

    //Setting the MainScale
    gauge.getMainScale().getLayout().setTarget(com.softwarefx.chartfx.gauge.LayoutTarget.ANCHOR_POINT);
    gauge.getMainScale().getLayout().getAnchorPoint().setLocation(0.5, 0.26);
    gauge.getMainScale().getBar().setVisible(false);

    // Setting the Main Indicator:
    com.softwarefx.chartfx.gauge.Marker marker1 = new com.softwarefx.chartfx.gauge.Marker();
    marker1.setValue("66");
    marker1.setStyle(com.softwarefx.chartfx.gauge.MarkerStyle.getMarker08());
    marker1.setSize(2.1F);
    marker1.setColor(new java.awt.Color(255,215,0));  // Color Gold
    gauge.setMainIndicator(marker1);

    //  Setting a Second Indicator:
    marker1 = new com.softwarefx.chartfx.gauge.Marker();
    marker1.setValue("90");
    marker1.setStyle(com.softwarefx.chartfx.gauge.MarkerStyle.getMarker06());
    marker1.setText("Max");
    marker1.getLabel().setPosition(com.softwarefx.chartfx.gauge.Position.BOTTOM);
    marker1.getLabel().setFont(new com.softwarefx.chartfx.gauge.GaugeFont("Tahoma", com.softwarefx.chartfx.gauge.GaugeFontSize.SMALLER, java.awt.Font.PLAIN));
    marker1.getLabel().setColor(new java.awt.Color(255,250,250));  // Color Snow
    marker1.getLabel().setVisible(true);
    marker1.setColor(java.awt.Color.red);
    gauge.getMainScale().getIndicators().add(marker1);

    gauge.getMainScale().getTickmarks().setColor(new java.awt.Color(255,250,250));  // Color Snow
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setPosition(com.softwarefx.chartfx.gauge.Position.BOTTOM);
    gauge.getMainScale().getTickmarks().getMajor().setStep(20);
    gauge.getMainScale().getTickmarks().getMajor().setStyle(com.softwarefx.chartfx.gauge.TickmarkStyle.getTickmark01_2());
    gauge.getMainScale().getTickmarks().getMedium().setSize(1.5F);

    //Creating and setting a secondary Scale
    com.softwarefx.chartfx.gauge.LinearScale linearScale1 = new com.softwarefx.chartfx.gauge.LinearScale();

    linearScale1.getLayout().setTarget(com.softwarefx.chartfx.gauge.LayoutTarget.ANCHOR_POINT);
    linearScale1.getLayout().getAnchorPoint().setLocation(0.5, 0.75);

    linearScale1.getBar().setVisible(false);

    linearScale1.getTickmarks().getMajor().setVisible(false);
    linearScale1.getTickmarks().getMedium().setVisible(false);
    linearScale1.getTickmarks().getMinor().setVisible(false);

    com.softwarefx.chartfx.gauge.Filler filler = new com.softwarefx.chartfx.gauge.Filler();
    filler.setValue("66");
    filler.setColor(java.awt.Color.yellow);
    filler.setStyle(com.softwarefx.chartfx.gauge.FillerStyle.getFiller01());
    linearScale1.getIndicators().add(filler);
    gauge.getScales().add(linearScale1);

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
