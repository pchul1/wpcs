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

    gauge.getBorder().setColor(java.awt.Color.gray);
    gauge.getBorder().setInsideColor( java.awt.Color.black) ;
    gauge.getBorder().setStyle(RadialBorderStyle.getCircularBorder06());

    InnerDigitalPanel innerDigitalPanel1 = new InnerDigitalPanel();
    innerDigitalPanel1.getSize().setSize(0.7, 0.20);
    innerDigitalPanel1.getDigitalPanel().setValue("60");
    innerDigitalPanel1.getDigitalPanel().getAppearance().setStyle(DigitalCharacterStyle.getLed01());
    innerDigitalPanel1.getDigitalPanel().getAppearance().setColor(new java.awt.Color(135,206,250));  // Color LightSkyBlue
    innerDigitalPanel1.getDigitalPanel().getAppearance().setOffDigitTransparency((short)0);
    innerDigitalPanel1.getDigitalPanel().getBorder().setStyle(LinearBorderStyle.getLinearBorder06());
    innerDigitalPanel1.getDigitalPanel().getBorder().setColor(new java.awt.Color(105, 105, 105));  // Color DimGray
    innerDigitalPanel1.getDigitalPanel().getBorder().setInsideColor(new java.awt.Color(64,64,64));
    innerDigitalPanel1.getLayout().setTarget(LayoutTarget.ANCHOR_POINT);
    innerDigitalPanel1.getLayout().getAnchorPoint().setLocation(0.025, -0.4);

    innerDigitalPanel1.getDigitalPanel().setHeight(20);
    innerDigitalPanel1.getDigitalPanel().setWidth(300);
    gauge.getInnerGauges().add(innerDigitalPanel1);

    //Setting the MainScale
    gauge.getMainScale().getBar().setVisible(false);
    gauge.getMainScale().setRadius(0.7F);
    gauge.getMainScale().setStartAngle(204F);
    gauge.getMainScale().setMax(160);
    gauge.getMainScale().setSweepAngle(-228F);

    gauge.getMainScale().getCap().setSize(0.2F);
    gauge.getMainScale().getCap().setColor(new java.awt.Color(230, 232, 250));  // Color Silver

    Needle needle1 =(Needle) gauge.getMainIndicator();
    needle1.setSize(0.9F);
    needle1.setValue("60");
    needle1.setStyle(NeedleStyle.getNeedle05());
    needle1.setColor(new java.awt.Color(70,130,180));  // Color SteelBlue

    gauge.getMainScale().getTickmarks().getMajor().setColor(new Color(230, 232, 250));  // Color Silver
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setFont(new GaugeFont("Tahoma", GaugeFontSize.SMALLER, java.awt.Font.BOLD));
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setColor(new java.awt.Color(230, 232, 250));  // Color Silver
    gauge.getMainScale().getTickmarks().getMajor().setSize(2.5F);
    gauge.getMainScale().getTickmarks().getMajor().setStep(10);
    gauge.getMainScale().getTickmarks().getMajor().setStyle(TickmarkStyle.getTickmark01_2());

    gauge.getMainScale().getTickmarks().getMedium().setColor(new java.awt.Color(105, 105, 105));  // Color DimGray

    gauge.getMainScale().getTickmarks().getMinor().setColor(new java.awt.Color(105, 105, 105));  // Color DimGray
    gauge.getMainScale().getTickmarks().getMinor().setSize(1F);
    gauge.getMainScale().getTickmarks().getMinor().setStyle(TickmarkStyle.getTickmark02_3());

    //Setting the titles:
    Title title1 = new Title();
    title1.setText("SPEED (mph)");
    title1.setColor(new java.awt.Color(220,220,220));  // Color Gainsboro
    title1.getLayout().setTarget(LayoutTarget.ANCHOR_POINT);
    title1.getLayout().getAnchorPoint().setLocation(0.05, -0.625);
    title1.setFont(new GaugeFont("Tahoma", GaugeFontSize.SMALLER, java.awt.Font.PLAIN));
    gauge.getTitles().add(title1);

    title1 = new Title();
    title1.setText("MADE IN THE US");
    title1.setColor(new java.awt.Color(105, 105, 105));  // Color DimGray
    title1.getLayout().setTarget(LayoutTarget.ANCHOR_POINT);
    title1.getLayout().getAnchorPoint().setLocation(0, -0.75);
    title1.setFont(new GaugeFont("Tahoma", GaugeFontSize.SMALLEST, java.awt.Font.PLAIN));
    gauge.getTitles().add(title1);

    gauge.setWidth(320);
    gauge.setHeight(350);
    gauge.setToolTipEnabled(false);
    gauge.renderControl();%>
								</td>
								<td>
									<P style="FONT-SIZE: 9pt; FONT-FAMILY: Arial" align="justify">
										This sample uses a DigitalPanel gauge in addition to the main Radial gauge. 
										This effect can be achieved using the innerGauge property. In addition, the 
										DigitalPanel gauge has been linked to the value in the Radial gauge in order to 
										minimize the programming required.
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
