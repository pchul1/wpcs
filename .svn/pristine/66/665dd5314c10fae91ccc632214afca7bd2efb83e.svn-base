<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Axis: Grid Lines</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);
chart1.getLegendBox().setVisible(false);

chart1.setAxesStyle(AxesStyle.FLAT_FRAME);
chart1.getAxisY().setStep((short) 20);
chart1.getAxisY().setMinorStep(5);
chart1.getAxisY().setMax(100);
chart1.getAxisY().setMin(0);
chart1.getAxisY().getGrids().getMinor().setTickMark(TickMark.CROSS);
chart1.getAxisY().getGrids().getMajor().setColor(new java.awt.Color(255, 127, 80));

chart1.getAxisX().setMinorStep(0.5);
chart1.getAxisX().getGrids().getMinor().setVisible(true);
chart1.getAxisX().getGrids().getMinor().setTickMark(TickMark.OUTSIDE);
chart1.getAxisX().getGrids().getMinor().setStyle(DashStyle.DASH);


chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
