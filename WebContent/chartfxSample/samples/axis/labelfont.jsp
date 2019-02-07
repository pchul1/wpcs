<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Axis: Label Font</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);
chart1.getLegendBox().setVisible(false);

chart1.getAxisX().setTextColor(new java.awt.Color(255, 0, 0));
chart1.getAxisX().setFont(new java.awt.Font("Courier New",java.awt.Font.BOLD,14));

chart1.getAxisY().setTextColor(new java.awt.Color(0, 0, 255));
chart1.getAxisY().setFont(new java.awt.Font("Arial",java.awt.Font.ITALIC,12));

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
