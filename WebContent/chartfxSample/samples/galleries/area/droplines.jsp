<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Area: Drop-lines</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);

chart1.getData().setSeries(1);
chart1.getData().setPoints(10);
chart1.setGallery(Gallery.AREA);
chart1.getAllSeries().getBorder().setBetweenSegments(true);
chart1.getLegendBox().setVisible(false);

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
