<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Axis: Lable Formatting</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);
chart1.getLegendBox().setVisible(false);

chart1.getData().setSeries(1);
chart1.getData().setPoints(4);
chart1.getData().set(0, 0, 1245);
chart1.getData().set(0, 1, 720);
chart1.getData().set(0, 2, 1412);
chart1.getData().set(0, 3, 1054);

chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
chart1.getAxisY().getLabelsFormat().setDecimals((short) 1);

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
