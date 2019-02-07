<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.galleries.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Pie: Labels Outside with no Lines</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);
chart1.getData().setSeries(1);
chart1.getData().setPoints(3);
chart1.getData().set(0,0,25);
chart1.getData().set(0,1,45);
chart1.getData().set(0,2,30);
chart1.setGallery(Gallery.PIE);
chart1.getAllSeries().getPointLabels().setVisible(true);
Pie pie = (Pie) chart1.getGalleryAttributes();
pie.setLabelsInside(false);
pie.setShowLines(false);
chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
