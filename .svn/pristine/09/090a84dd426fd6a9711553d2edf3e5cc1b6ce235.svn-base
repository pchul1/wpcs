<%@page import="com.softwarefx.chartfx.gauge.*,java.awt.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<HTML>
	<HEAD>
		<LINK href="../cfxgauges.css" type="text/css" rel="stylesheet">
	</HEAD>
	<body >
		<form id="Form1" method="post" runat="server">
			<br>
			<TABLE class="bodyTable" id="Table1" cellSpacing="4" cellPadding="2" width="80%">
				<TR>
					<TD>
						<P>&nbsp;</P>
						<P>
<%
   com.softwarefx.chartfx.gauge.DigitalPanel.initWeb(pageContext,request,response);
   com.softwarefx.chartfx.gauge.DigitalPanel gauge1 = new com.softwarefx.chartfx.gauge.DigitalPanel();
   
   gauge1.getBorder().setStyle(com.softwarefx.chartfx.gauge.LinearBorderStyle.getLinearBorder10());   
   gauge1.getBorder().setInsideColor(new java.awt.Color(143,188,143));  //DarkSeaGreen Color
   gauge1.getBorder().setColor(java.awt.Color.BLACK);
   
    com.softwarefx.chartfx.gauge.Title title1 = new com.softwarefx.chartfx.gauge.Title();
    title1.setText("M");
    title1.setColor(java.awt.Color.BLACK);
    title1.getLayout().setTarget(com.softwarefx.chartfx.gauge.LayoutTarget.ANCHOR_POINT);
    title1.getLayout().getAnchorPoint().setLocation(0.05, 0.2);
    gauge1.getTitles().add(title1);
    
    title1 = new com.softwarefx.chartfx.gauge.Title();
    title1.setText("C");
    title1.setColor(java.awt.Color.BLACK);
    title1.getLayout().setTarget(com.softwarefx.chartfx.gauge.LayoutTarget.ANCHOR_POINT);
    title1.getLayout().getAnchorPoint().setLocation(0.05, 0.375);
    gauge1.getTitles().add(title1);
    
    gauge1.getAppearance().getLayout().setAlignment(com.softwarefx.chartfx.gauge.ContentAlignment.MIDDLE_RIGHT);
    gauge1.getAppearance().setColor(java.awt.Color.BLACK);
   
   gauge1.setWidth(280);
   gauge1.setHeight(90);
   gauge1.renderControl();%>
						</P>
						<P>&nbsp;</P>
					</TD>
					<TD style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">This 7-Segment DidgitalPanel 
						simulates the screen of a digital calculator. Notice the two titles located in 
						the upper-left portion of the panel.</TD>
				</TR>
				<TR>
					<TD>
						<P>&nbsp;</P>
						<P>
<%
   com.softwarefx.chartfx.gauge.DigitalPanel.initWeb(pageContext,request,response);
   com.softwarefx.chartfx.gauge.DigitalPanel gauge2 = new com.softwarefx.chartfx.gauge.DigitalPanel();
   
   gauge2.setValue("VLO: 100.36");
   
   gauge2.getBorder().setStyle(com.softwarefx.chartfx.gauge.LinearBorderStyle.getLinearBorder06());   
   gauge2.getBorder().setInsideColor(java.awt.Color.GRAY); 
   gauge2.getBorder().setColor(java.awt.Color.BLACK);
   
    com.softwarefx.chartfx.gauge.Title title2 = new com.softwarefx.chartfx.gauge.Title();
    title2.setText("STOCK PRICES");
    title2.setColor(new java.awt.Color(30,30,30));
    title2.getLayout().setTarget(com.softwarefx.chartfx.gauge.LayoutTarget.ANCHOR_POINT);
    title2.getLayout().getAnchorPoint().setLocation(0.5, 0.9);
    gauge2.getTitles().add(title2);
    
    gauge2.getAppearance().setStyle(com.softwarefx.chartfx.gauge.DigitalCharacterStyle.getFourteenSegments06());
    gauge2.getAppearance().setOffDigitTransparency((short) 20);
    gauge2.getAppearance().setColor(new java.awt.Color(0,255,0));  //Lime Color.
    gauge2.getAppearance().setSize(0.8F); 
   
   gauge2.setWidth(280);
   gauge2.setHeight(90);
   gauge2.renderControl();
%>
						</P>
						<P>&nbsp;</P>
					</TD>
					<TD style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">
						<P>This 14 segment DigitalPanel displays alphanumeric messages.</P>
						<P>Text:
							<asp:textbox id="TextBox1" runat="server">VLO: 100.36</asp:textbox>&nbsp;&nbsp;&nbsp;
							<asp:button id="Button2" runat="server" Text="Submit"></asp:button></P>
					</TD>
				</TR>
				<TR>
					<TD>
						<P>&nbsp;</P>
						<P>
<%
   com.softwarefx.chartfx.gauge.DigitalPanel.initWeb(pageContext,request,response);
   com.softwarefx.chartfx.gauge.DigitalPanel gauge3 = new com.softwarefx.chartfx.gauge.DigitalPanel();
   
   gauge3.setValueFormat("dd/MM/yyy");
   gauge3.setValue("01/01/2005");
   
   gauge3.getBorder().setStyle(com.softwarefx.chartfx.gauge.LinearBorderStyle.getLinearBorder11());   
   gauge3.getBorder().setInsideColor(java.awt.Color.BLACK); 
   gauge3.getBorder().setColor(java.awt.Color.BLACK);
   gauge3.getBorder().setGlare(true);
   
   com.softwarefx.chartfx.gauge.Title title3 = new com.softwarefx.chartfx.gauge.Title();
   title3.setText("DIGITAL INFO CENTER");
   title3.setColor(new java.awt.Color(220,220,220));  //Gainsboro Color.
   title3.getLayout().setTarget(com.softwarefx.chartfx.gauge.LayoutTarget.ANCHOR_POINT);
   title3.getLayout().getAnchorPoint().setLocation(0.5, 0.125);
   gauge3.getTitles().add(title3);
    
    gauge3.getAppearance().setStyle(com.softwarefx.chartfx.gauge.DigitalCharacterStyle.getLed05());
    gauge3.getAppearance().setOffDigitTransparency((short) 30);
    gauge3.getAppearance().setColor(new java.awt.Color(0,191,255));  //DeepSkyBlue Color.
    gauge3.getAppearance().setSize(0.8F);
   
   gauge3.setWidth(280);
   gauge3.setHeight(90);
   gauge3.renderControl();%>
						</P>
						<P>&nbsp;</P>
					</TD>
					<TD style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">This DigitalPanel displays a text 
						message using LED markers. Note the rounded border in the drawing area using an 
						OffDigitTransparency to achieve a very realistic effect.</TD>
				</TR>
				<TR>
					<TD>
						<P>&nbsp;</P>
						<P>
<%
    com.softwarefx.chartfx.gauge.DigitalPanel.initWeb(pageContext,request,response);
    com.softwarefx.chartfx.gauge.DigitalPanel gauge4 = new com.softwarefx.chartfx.gauge.DigitalPanel();

    gauge4.setValueFormat("HH:MM:SS");
    gauge4.setValue("11:35:30 pm");

    gauge4.getBorder().setStyle(com.softwarefx.chartfx.gauge.LinearBorderStyle.getLinearBorder05());
    gauge4.getBorder().setInsideColor(java.awt.Color.BLACK);
    gauge4.getBorder().setColor(java.awt.Color.BLACK);
    gauge4.getBorder().setGlare(true);

    gauge4.getAppearance().setColor(new java.awt.Color(255,215,0));  //Gold Color.
    gauge4.getAppearance().setSize(0.7F);

    com.softwarefx.chartfx.gauge.BitmapImage gauge4Image1 = new com.softwarefx.chartfx.gauge.BitmapImage();

    javax.swing.ImageIcon ico = new javax.swing.ImageIcon(application.getRealPath("/gauges/DigitalPanel") + "/Images/alarmOn.png");
    java.awt.Image img = ico.getImage();
    gauge4Image1.setImage(img);
    gauge4Image1.getLayout().setTarget(com.softwarefx.chartfx.gauge.LayoutTarget.ANCHOR_POINT);
    gauge4Image1.getLayout().getAnchorPoint().setLocation(0.05F, 0.25F);
    gauge4.getImages().add(gauge4Image1);

    gauge4.setWidth(280);
    gauge4.setHeight(90);
    gauge4.renderControl();
%>
						</P>
						<P>&nbsp;</P>
					</TD>
					<TD style="FONT-SIZE: 10pt; FONT-FAMILY: Arial">
						<P>This 14-Segment DigitalPanel displays an image (Bell icon) in the drawing area 
							to simulate a digital alarm clock.</P>
						<P align="center"><asp:button id="Button1" runat="server" Width="105px" Text="Turn Off Alarm"></asp:button></P>
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
