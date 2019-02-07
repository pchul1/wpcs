<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.galleries.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Pie: Stacked</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);
chart1.setBackground(new SolidBackground(java.awt.Color.WHITE));


chart1.getData().setSeries(2);
chart1.getData().setPoints(3);
chart1.getData().set(0,0,10);
chart1.getData().set(1,0,20);
chart1.getData().set(0,1,30);
chart1.getData().set(1,1,40);
chart1.getData().set(0,2,30);
chart1.getData().set(1,2,40);

// set properties for inner pie
chart1.setGallery(Gallery.PIE);
Pie pie = (Pie) chart1.getGalleryAttributes();
pie.setShadows(true);

chart1.setGallery(Gallery.DOUGHNUT);
pie = (Pie) chart1.getGalleryAttributes();
pie.setStacked(true);
pie.setDoughnutThickness((short)20);
pie.setShowLines(false);
// Optional Shadow 2d
pie.setShadows(true);
SeriesAttributes series = chart1.getSeries().get(0);
series.setVolume((short)100);

// set properties for inner Pie
series = chart1.getSeries().get(1);
series.setGallery(Gallery.PIE);
series.setVolume((short)80);
series.getPointLabels().setTextColor(java.awt.Color.WHITE);

// set border properties to simulate exploding

chart1.getAllSeries().getBorder().setEffect(BorderEffect.NONE);
chart1.getAllSeries().getBorder().setColor(chart1.getBackColor());

chart1.getLegendBox().setVisible(false);
chart1.getAllSeries().getPointLabels().setVisible(true);

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
