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
									<P style="FONT-SIZE: 9pt; FONT-FAMILY: Arial" align="justify">Highlighting sections 
										in a scale can also be achieved using color stripes, which take a range of 
										values and a color (Solid or Gradient) to paint a color bar. In the sample 
										below we have created 3 gradient color stripes. It is important to note stripes 
										can be positioned using an offset from the scale, allowing you to position the 
										stripe inside or outside the scale. You can also control the width of each 
										stripe on a given scale. Also note the customized tickmarks.
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
    gauge.getBorder().setStyle(com.softwarefx.chartfx.gauge.LinearBorderStyle.getLinearBorder15());
    gauge.getBorder().setColor(java.awt.Color.black);
    gauge.getBorder().setInsideColor(java.awt.Color.black);
    
    //Setting the MainScale
    gauge.getMainScale().getBar().setVisible(false);
    
    gauge.getMainScale().getTickmarks().getMajor().setStyle(com.softwarefx.chartfx.gauge.TickmarkStyle.getTickmark07_2());
    gauge.getMainScale().getTickmarks().getMajor().setColor(new java.awt.Color(105, 105, 105));  // Color DimGray
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setColor(new java.awt.Color(220,220,220));  // Color Gainsboro
    gauge.getMainScale().getTickmarks().getMedium().setStyle(com.softwarefx.chartfx.gauge.TickmarkStyle.getTickmark12_3());

    // Setting the Stripes:
    com.softwarefx.chartfx.gauge.LinearStrip strip1 = new com.softwarefx.chartfx.gauge.LinearStrip(); //
    strip1.setColor(new java.awt.Color(127,255,0));  // Color Chartreuse
    strip1.setAlternateColor(new java.awt.Color(255,215,0));  // Color Gold
    strip1.getBorder().setVisible(false);
    strip1.setMax(45);
    strip1.setThickness(0.3F);
    strip1.setOffset(-0.05F);
    strip1.setFillType(com.softwarefx.chartfx.gauge.StripFillType.GRADIENT);
    gauge.getMainScale().getStripes().add(strip1);

    strip1 = new com.softwarefx.chartfx.gauge.LinearStrip();
    strip1.setColor(new java.awt.Color(255,215,0));  // Color Gold
    strip1.getBorder().setVisible(false);
    strip1.setMin(45);
    strip1.setMax(80);
    strip1.setThickness(0.3F);
    strip1.setOffset(-0.05F);
    strip1.setFillType(com.softwarefx.chartfx.gauge.StripFillType.GRADIENT);
    gauge.getMainScale().getStripes().add(strip1);

    strip1 = new com.softwarefx.chartfx.gauge.LinearStrip();
    strip1.setColor(java.awt.Color.orange);
    strip1.setAlternateColor(new java.awt.Color(255,69,0));  // Color OrangeRed
    strip1.getBorder().setVisible(false);
    strip1.setMin(80);
    strip1.setThickness(0.3F);
    strip1.setOffset(-0.05F);
    strip1.setFillType(com.softwarefx.chartfx.gauge.StripFillType.GRADIENT);
    gauge.getMainScale().getStripes().add(strip1);

    // Setting the Main Indicator:
    com.softwarefx.chartfx.gauge.Marker marker1 = new com.softwarefx.chartfx.gauge.Marker();
    marker1.setValue("35");
    marker1.setStyle(com.softwarefx.chartfx.gauge.MarkerStyle.getMarker04());
    gauge.setMainIndicator(marker1);

    //Setting the title:
    com.softwarefx.chartfx.gauge.Title title1 = new com.softwarefx.chartfx.gauge.Title();
    title1.setText("CLIPPING METER");
    title1.setColor(new java.awt.Color(230, 232, 250));  // Color Silver
    title1.getLayout().setTarget(com.softwarefx.chartfx.gauge.LayoutTarget.ANCHOR_POINT);
    title1.getLayout().getAnchorPoint().setLocation(0.5, 0.95);
    gauge.getTitles().add(title1);

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
