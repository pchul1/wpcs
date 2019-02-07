<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Combinations: Bar with Line</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.getData().setSeries(2);
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

chart1.getAxisX().getGrids().getMajor().setVisible(false);
chart1.getAxisY2().getGrids().getMajor().setVisible(false);

SeriesAttributes series = chart1.getSeries().get(0);
series.setGallery(Gallery.LINES);
series.setAxisY(chart1.getAxisY2());

series = chart1.getSeries().get(1);
series.setGallery(Gallery.BAR);

Axis axis = chart1.getAxisY2();
axis.setMin((float) 0.5);
axis.setMax(1);
axis.setStep(0.05);
axis.setVisible(true);
axis.getLabelsFormat().setDecimals(2);

chart1.getAxisY().setScaleUnit(1000);
   
chart1.getLegendBox().setVisible(false);    

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
