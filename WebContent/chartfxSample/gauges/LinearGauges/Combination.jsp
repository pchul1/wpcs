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
									<P style="FONT-SIZE: 9pt; FONT-FAMILY: Arial" align="justify">
										Linear gauges also support inner gauges. In the example below, a DigitalPanel 
										has been added to the horizontal gauge and the value has been linked to the 
										MainIndicator of the horizontal gauge.
									</P>
									<P>&nbsp;</P>
								</td>
							</tr>
							<tr>
								<td>
<%
    com.softwarefx.chartfx.gauge.HorizontalGauge.initWeb(pageContext,request,response);
    com.softwarefx.chartfx.gauge.HorizontalGauge gauge = new com.softwarefx.chartfx.gauge.HorizontalGauge();

    //Setting the inner gauge
    com.softwarefx.chartfx.gauge.InnerDigitalPanel innerDigitalPanel1 = new com.softwarefx.chartfx.gauge.InnerDigitalPanel();
    innerDigitalPanel1.getDigitalPanel().getAppearance().setOffDigitTransparency((short) 70);
    innerDigitalPanel1.getDigitalPanel().getBorder().setVisible(false);
    innerDigitalPanel1.getLayout().setTarget(com.softwarefx.chartfx.gauge.LayoutTarget.ANCHOR_POINT);
    innerDigitalPanel1.setLinkToMainValue(true);
    innerDigitalPanel1.getLayout().getAnchorPoint().setLocation(0.875, 0.5);
    gauge.getInnerGauges().add(innerDigitalPanel1);

    gauge.getBorder().setInsideColor(java.awt.Color.black);
    gauge.getBorder().setColor(new java.awt.Color(105, 105, 105));  // Color DimGray
    gauge.getBorder().setStyle(com.softwarefx.chartfx.gauge.LinearBorderStyle.getLinearBorder08());

    //Setting the MainScale
    gauge.getMainScale().getLayout().setTarget(com.softwarefx.chartfx.gauge.LayoutTarget.ANCHOR_POINT);
    gauge.getMainScale().getLayout().getAnchorPoint().setLocation(0.375, 0.55);
    gauge.getMainScale().setMax(1000);
    gauge.getMainScale().setSize(0.7F);

    gauge.getMainScale().getBar().setVisible(false);

    com.softwarefx.chartfx.gauge.Filler filler1 =(com.softwarefx.chartfx.gauge.Filler) gauge.getMainIndicator();
    filler1.setValue("897");
    filler1.setColor(java.awt.Color.red);

    gauge.getMainScale().getTickmarks().getMajor().setColor(new java.awt.Color(230, 232, 250));  // Color Silver
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setColor(new java.awt.Color(220,220,220));  // Color GainsBoro

    gauge.getMainScale().getTickmarks().getMedium().setColor(new java.awt.Color(255,69,0));  // Color OrangeRed
    gauge.getMainScale().getTickmarks().getMedium().setStyle(com.softwarefx.chartfx.gauge.TickmarkStyle.getTickmark08_2());

    gauge.getMainScale().getTickmarks().getMinor().setColor(java.awt.Color.gray);

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
