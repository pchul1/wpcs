<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Axis: Interlaced</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);
chart1.getLegendBox().setVisible(false);

Axis axis = chart1.getAxisY();
axis.setStep((short) 20);
axis.setMax((short) 100);
axis.setMin((short) 0);
axis.getGrids().setInterlaced(true);
axis.getGrids().getMajor().setVisible(true);
axis.getGrids().getMajor().setColor(new java.awt.Color(135, 206, 250));

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
