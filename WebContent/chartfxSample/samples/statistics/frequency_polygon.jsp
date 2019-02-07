<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="com.softwarefx.chartfx.server.annotation.*"%>
<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page import="com.softwarefx.chartfx.server.statistical.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : frequency_polygon
    Created on : Jun 25, 2008, 7:14:40 PM
    Author     : Administrator
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Frequency Polygon</title>
    </head>
    <body>
        <%
        ChartServer chart1 = new ChartServer(application,request,response);
        
        com.softwarefx.chartfx.server.statistical.Statistics statistics1 = new com.softwarefx.chartfx.server.statistical.Statistics();
       
        statistics1.setChart(chart1);  
        TextProvider txtProvider = new TextProvider(application.getRealPath("/") + "/data/statistical_data.txt");
        chart1.setDataSource(txtProvider);
        
        chart1.setGalleryAttributes(statistics1.getGallery().getFrequencyPolygon());
        chart1.getLegendBox().setVisible(false);
        chart1.setWidth(800);
        chart1.setHeight(600);
        chart1.renderControl();
        %>
    </body>
</html>
