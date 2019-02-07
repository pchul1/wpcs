<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Axis: Color</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);
chart1.getLegendBox().setVisible(false);

chart1.getAxisY().getGrids().getMinor().setTickMark(com.softwarefx.chartfx.server.TickMark.NONE);
chart1.getAxisX().getGrids().getMinor().setTickMark(com.softwarefx.chartfx.server.TickMark.NONE);

chart1.getAxisY().getGrids().getMajor().setVisible(false);
chart1.getAxisX().getGrids().getMajor().setVisible(false);

chart1.getAxisY().getGrids().getMajor().setTickMark(com.softwarefx.chartfx.server.TickMark.INSIDE);
chart1.getAxisY().getGrids().getMajor().setColor(java.awt.Color.RED);

chart1.getAxisX().getGrids().getMajor().setTickMark(com.softwarefx.chartfx.server.TickMark.OUTSIDE);
chart1.getAxisX().getGrids().getMajor().setColor(java.awt.Color.RED);

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
