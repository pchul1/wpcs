<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : marker.labels
    Created on : Mar 14, 2008, 10:44:00 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Labels: Marker Labels</title>
    </head>
    <body>
        <%
        ChartServer chart1 = new ChartServer(pageContext, request, response);
        chart1.setGallery(Gallery.BAR);
      
        chart1.getAllSeries().getPointLabels().setVisible(true);
        SeriesAttributes series = chart1.getSeries().get(0);
        series.getPointLabels().setAngle((short) 90);
        series.getPointLabels().setAlignment(com.softwarefx.StringAlignment.FAR);
        series.getPointLabels().setLineAlignment(com.softwarefx.StringAlignment.CENTER);
        series.setColor(new java.awt.Color(255, 255, 0));

        series = chart1.getSeries().get(1);
        series.getPointLabels().setAngle((short) 0);
        series.getPointLabels().setAlignment(com.softwarefx.StringAlignment.CENTER);
        series.getPointLabels().setLineAlignment(com.softwarefx.StringAlignment.FAR);
        series.setColor(new java.awt.Color(255, 165, 0));       
        chart1.setWidth(600);
        chart1.setHeight(400);
        chart1.renderControl();
        %>
        
    </body>
</html>
