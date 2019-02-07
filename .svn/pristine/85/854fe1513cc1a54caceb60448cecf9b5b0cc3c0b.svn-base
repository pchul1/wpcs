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
									<P style="FONT-SIZE: 9pt; FONT-FAMILY: Arial" align="justify">Images and titles can 
										be positioned anywhere inside the drawing area of a linear scale. In the sample 
										shown below we have added an image to provide a more realistic effect to the 
										horizontal gauge. Images can be positioned relative to the border of the gauge 
										or in a specific anchor point that can be set using a visual designer in the 
										properties list.
									</P>
									<P>&nbsp;</P>
								</td>
							</tr>
							<tr>
								<td>
<%
    com.softwarefx.chartfx.gauge.HorizontalGauge.initWeb(pageContext,request,response);
    com.softwarefx.chartfx.gauge.HorizontalGauge gauge = new com.softwarefx.chartfx.gauge.HorizontalGauge();

    //Setting the images
    com.softwarefx.chartfx.gauge.BitmapImage gaugeImage1 = new com.softwarefx.chartfx.gauge.BitmapImage();
    javax.swing.ImageIcon ico = new javax.swing.ImageIcon(application.getRealPath("/gauges") + "/LinearGauges/images/battery.png");
    java.awt.Image img = ico.getImage();
    gaugeImage1.setImage(img);
    gaugeImage1.getLayout().setTarget(com.softwarefx.chartfx.gauge.LayoutTarget.ANCHOR_POINT);
    gaugeImage1.getLayout().getAnchorPoint().setLocation(0.04, 0.475);
    gauge.getImages().add(gaugeImage1);

    //Setting the MainScale
    gauge.getMainScale().getBar().setVisible(false);
    gauge.getMainScale().setMax(100);

    com.softwarefx.chartfx.gauge.Filler filler1 =(com.softwarefx.chartfx.gauge.Filler) gauge.getMainIndicator();
    filler1.setValue("72");
    filler1.setColor(java.awt.Color.YELLOW);

    gauge.getMainScale().getTickmarks().getMajor().setColor(java.awt.Color.white);  // Color Transparent
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setFont(new com.softwarefx.chartfx.gauge.GaugeFont("Tahoma", com.softwarefx.chartfx.gauge.GaugeFontSize.MEDIUM, java.awt.Font.BOLD));
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setColor(java.awt.Color.white);

    gauge.getMainScale().getTickmarks().getMedium().setColor(java.awt.Color.white);
    gauge.getMainScale().getTickmarks().getMedium().setSize(1.4F);
    gauge.getMainScale().getTickmarks().getMedium().setStep(10);

    gauge.getMainScale().getTickmarks().getMinor().getLabel().setFont(new com.softwarefx.chartfx.gauge.GaugeFont("Tahoma", com.softwarefx.chartfx.gauge.GaugeFontSize.MEDIUM, java.awt.Font.BOLD));
    gauge.getMainScale().getTickmarks().getMinor().getLabel().setColor(java.awt.Color.white);
    gauge.getMainScale().getTickmarks().getMinor().setColor(java.awt.Color.white);

    //Creating and setting Stripes
    com.softwarefx.chartfx.gauge.LinearStrip linearStrip1 = new com.softwarefx.chartfx.gauge.LinearStrip();
    linearStrip1.getBorder().setVisible(false);
    linearStrip1.setThickness(0.1F);
    linearStrip1.setMax(10);
    gauge.getMainScale().getStripes().add(linearStrip1);

    linearStrip1 = new com.softwarefx.chartfx.gauge.LinearStrip();
    linearStrip1.getBorder().setVisible(false);
    linearStrip1.setThickness(0.1F);
    linearStrip1.setMin(10);
    linearStrip1.setMax(20);
    gauge.getMainScale().getStripes().add(linearStrip1);

    //Setting the Border
    gauge.getBorder().setStyle(com.softwarefx.chartfx.gauge.LinearBorderStyle.getLinearBorder03());
    gauge.getBorder().setColor(java.awt.Color.black);
    gauge.getBorder().setInsideColor(java.awt.Color.black);

    //Setting the titles:
    com.softwarefx.chartfx.gauge.Title title1 = new com.softwarefx.chartfx.gauge.Title();
    title1.setText("Battery Life");
    title1.setColor(java.awt.Color.white);
    title1.getLayout().setTarget(com.softwarefx.chartfx.gauge.LayoutTarget.ANCHOR_POINT);
    title1.getLayout().getAnchorPoint().setLocation(0.5, 0.85);
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
