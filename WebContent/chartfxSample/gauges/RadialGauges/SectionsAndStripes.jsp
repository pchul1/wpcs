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
    gauge.getBorder().setColor(new java.awt.Color(230, 232, 250));  // Color Silver
    gauge.getBorder().setGlare(true);
    gauge.getBorder().setInsideColor(java.awt.Color.black) ;
    gauge.getBorder().setStyle(RadialBorderStyle.getSemiCircularBorder07());
    gauge.getBorder().setGlare(false);

    //Setting the MainScale
    gauge.getMainScale().setMax(300);

    //Setting first Section
    Section section1 = new Section();
    section1.setMin(210);
    section1.setMax(270);
    section1.getBar().setColor(Color.yellow);
    section1.getTickmarks().setColor(Color.white);
    gauge.getMainScale().getSections().add(section1);

    //Setting second Section
    section1 = new Section();
    section1.setMin(270);
    section1.setMax(300);
    section1.getBar().setColor(Color.red);
    section1.getTickmarks().setColor(Color.white);
    gauge.getMainScale().getSections().add(section1);

    gauge.getMainScale().getBar().setVisible(false);

    gauge.getMainScale().getCap().setStyle(RadialCapStyle.getRotatingCap02());
    gauge.getMainScale().getCap().setColor(Color.darkGray);

    Needle needle1 =(Needle) gauge.getMainIndicator();
    needle1.setStyle(NeedleStyle.getNeedle10());
    needle1.setUseRangeColor(RangeType.SECTION);
    needle1.setValue("240");

    gauge.getMainScale().getTickmarks().getMajor().setColor(Color.darkGray);
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setFont(new GaugeFont("Tahoma", GaugeFontSize.SMALLER, java.awt.Font.BOLD));
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setColor(Color.white);
    gauge.getMainScale().getTickmarks().getMajor().setStep(30);
    gauge.getMainScale().getTickmarks().getMajor().setStyle(TickmarkStyle.getTickmark01_2());
    gauge.getMainScale().getTickmarks().getMedium().setColor(new java.awt.Color(230, 232, 250));  // Color Silver
    gauge.getMainScale().getTickmarks().getMinor().setColor(Color.gray);

    //Setting the titles:

    Title title1 = new Title();
    title1.setText("PSI");
    title1.setColor(new java.awt.Color(211, 211, 211));  // Color LightGray
    title1.setFont(new GaugeFont("Tahoma", GaugeFontSize.SMALLER, java.awt.Font.BOLD));
    title1.getLayout().setTarget(LayoutTarget.ANCHOR_POINT);
    title1.getLayout().getAnchorPoint().setLocation(0,0.225);
    gauge.getTitles().add(title1);

    gauge.setWidth(320);
    gauge.setHeight(350);
    gauge.setToolTipEnabled(false);
    gauge.renderControl();
%>
								</td>
								<td>
									<P style="FONT-SIZE: 9pt; FONT-FAMILY: Arial" align="justify">This gauge 
										illustrates how to create and customize scale sections and stripes. In this 
										sample a section has been created between values 210 and 300 to indicate 
										warning levels. The needle will change colors according to the color of the 
										stripe it is pointing at to highlight the condition.
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
