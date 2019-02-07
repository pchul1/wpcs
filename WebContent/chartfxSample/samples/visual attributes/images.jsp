<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Visual Attributes: Image Borders</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.getLegendBox().setVisible(false);

chart1.setToolTips(false);
chart1.getImageSettings().setToolTips(ImageToolTipStyle.NONE);
chart1.getImageSettings().setInteractive(false);

javax.swing.ImageIcon ico = new javax.swing.ImageIcon(application.getRealPath("/data") + "/chartfx.png");
java.awt.Image img = ico.getImage();
ImageBackground ib = new ImageBackground();
ib.setImage(img);
ib.setMode(ImageMode.CENTER);
chart1.setBackground(ib);

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
