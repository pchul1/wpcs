<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Axis: Multiple Y</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);
chart1.getLegendBox().setVisible(false);

chart1.getData().setSeries(3);
chart1.getData().setPoints(5);
chart1.getData().set(0,0,0.5);
chart1.getData().set(0,1,0.75);
chart1.getData().set(0,2,0.91);
chart1.getData().set(0,3,0.98);
chart1.getData().set(0,4,0.72);
chart1.getData().set(1,0,232815);
chart1.getData().set(1,1,678192);
chart1.getData().set(1,2,655234);
chart1.getData().set(1,3,891230);
chart1.getData().set(1,4,533988);
chart1.getData().set(2,0,100);
chart1.getData().set(2,1,200);
chart1.getData().set(2,2,150);
chart1.getData().set(2,3,150);
chart1.getData().set(2,4,299);

chart1.getAxisX().getGrids().getMajor().setVisible(false);
chart1.getAxisY2().getGrids().getMajor().setVisible(false);

SeriesAttributes series = chart1.getSeries().get(1);
series.setGallery(Gallery.BAR);

AxisY axis = new AxisY();
axis.setVisible(true);
axis.setMin((float) 0.5);
axis.setStep((float) 0.05);
axis.setMax((short) 1);
axis.getLabelsFormat().setDecimals(2);
axis.setTextColor(java.awt.Color.BLUE);
axis.getGrids().getMajor().setColor(java.awt.Color.BLUE);
chart1.getAxesY().add(axis);

series = chart1.getSeries().get(0);
series.setGallery(Gallery.LINES);
series.setAxisY(axis);

axis = new AxisY();
axis.setVisible(true);
axis.setMin((float) 100);
axis.setMax(300);
axis.setTextColor(java.awt.Color.RED);
axis.getGrids().getMajor().setColor(java.awt.Color.RED);
chart1.getAxesY().add(axis);

series = chart1.getSeries().get(2);
series.setGallery(Gallery.AREA);
series.setAxisY(axis);

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
