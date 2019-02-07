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

    //gauge.setBackColor = java.awt.Color.white;
    gauge.getBorder().setColor(Color.gray);  // Color Silver
    gauge.getBorder().setGlare(true);
    gauge.getBorder().setInsideColor( java.awt.Color.black) ;
    gauge.getBorder().setStyle(RadialBorderStyle.getCircularBorder03());

    gauge.getMainScale().getPivot().setLocation(-0.625, 0);
    gauge.getMainScale().setStartAngle(45F);
    gauge.getMainScale().setSweepAngle(-90F);
    gauge.getMainScale().setMax(30);
    gauge.getMainScale().setMin(-30);
    gauge.getMainScale().setRadius(1F);

    Needle needle1 =(Needle) gauge.getMainIndicator();
    needle1.setStyle(NeedleStyle.getNeedle01());
    needle1.setSize(0.9F);
    needle1.setValue("20");

    gauge.getMainScale().getBar().setVisible(false);

    gauge.getMainScale().getCap().setStyle(RadialCapStyle.getCap14());
    gauge.getMainScale().getCap().setSize(0.2F);

    //Creating and setting the Strips
    RadialStrip radialStrip1 = new RadialStrip();
    radialStrip1.setColor(new java.awt.Color(105, 105, 105));  // Color DimGray
    radialStrip1.setMin(15);
    radialStrip1.setMax(30);
    gauge.getMainScale().getStripes().add(radialStrip1);

    RadialStrip radialStrip2 = new RadialStrip();
    radialStrip2.setColor(new java.awt.Color(220,220,220));  // Color GainsBoro
    radialStrip2.setMin(-30);
    radialStrip2.setMax(-15);
    gauge.getMainScale().getStripes().add(radialStrip2);

    gauge.getMainScale().getTickmarks().getMajor().setColor(Color.white);
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setFont(new GaugeFont("Tahoma", GaugeFontSize.SMALLER, java.awt.Font.BOLD));
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setColor(Color.white);
    gauge.getMainScale().getTickmarks().getMajor().setStep(30);
    gauge.getMainScale().getTickmarks().getMajor().setSize(1.7F);
    gauge.getMainScale().getTickmarks().getMajor().setStyle(TickmarkStyle.getTickmark02_4());
    
    gauge.getMainScale().getTickmarks().getMedium().setSize(1.1F);
    gauge.getMainScale().getTickmarks().getMedium().setStyle(TickmarkStyle.getTickmark10_1());
    gauge.getMainScale().getTickmarks().getMedium().setColor(new java.awt.Color(230, 232, 250));  // Color Silver
    
    gauge.getMainScale().getTickmarks().getMinor().setSize(1.6F);
    gauge.getMainScale().getTickmarks().getMinor().setStyle(TickmarkStyle.getTickmark11_2());
    gauge.getMainScale().getTickmarks().getMinor().setColor(Color.lightGray);

    //Setting the titles:

    Title title1 = new Title();
    title1.setText("AMP");
    title1.setColor(Color.white);
    title1.getLayout().setTarget(LayoutTarget.ANCHOR_POINT);
    title1.getLayout().getAnchorPoint().setLocation(-0.65, -0.3);
    gauge.getTitles().add(title1);

    title1 = new Title();
    title1.setText("+");
    title1.setColor(Color.white);
    title1.getLayout().setTarget(LayoutTarget.ANCHOR_POINT);
    title1.getLayout().getAnchorPoint().setLocation(-0.35, -0.55);
    gauge.getTitles().add(title1);

    title1 = new Title();
    title1.setText("-");
    title1.setColor(Color.white);
    title1.getLayout().setTarget(LayoutTarget.ANCHOR_POINT);
    title1.getLayout().getAnchorPoint().setLocation(-0.35, 0.6);
    gauge.getTitles().add(title1);

    //Setting the images
    BitmapImage gaugeImage1 = new BitmapImage();
    javax.swing.ImageIcon ico = new javax.swing.ImageIcon(application.getRealPath("/gauges") + "/RadialGauges/images/electricity.png");
    java.awt.Image img = ico.getImage();
    gaugeImage1.setImage(img);
    gaugeImage1.getLayout().setTarget(LayoutTarget.ANCHOR_POINT);
    gaugeImage1.getLayout().getAnchorPoint().setLocation(0.675, 0);
    gauge.getImages().add(gaugeImage1);

    gauge.setWidth(320);
    gauge.setHeight(350);
    gauge.setToolTipEnabled(false);
    gauge.renderControl();
%>
								</td>
								<td>
									<P style="FONT-SIZE: 9pt; FONT-FAMILY: Arial" align="justify">This realistic gauge 
										illustrates different Major (rectangles), Medium (circles) and Small tickmarks 
										(diamonds). In addition, the main scale starting and sweeping angles have been 
										changed so the gauge can be read horizontally. This is a very common technique 
										when combining more than one gauge or for gauges with other visual elements 
										like charts and grids.
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
