<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="com.softwarefx.chartfx.server.annotation.*"%>
<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page import="com.softwarefx.chartfx.server.statistical.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : box_whiskers
    Created on : Jun 25, 2008, 6:21:32 PM
    Author     : Administrator
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Box Whiskers</title>
    </head>
    <body>
        <%
        ChartServer chart1 = new ChartServer(application,request,response);
        
        com.softwarefx.chartfx.server.statistical.Statistics statistics1 = new com.softwarefx.chartfx.server.statistical.Statistics();
       
        statistics1.setChart(chart1);  
        TextProvider txtProvider = new TextProvider(application.getRealPath("/") + "/data/statistical_data_boxplot.txt");
        chart1.setDataSource(txtProvider);
        chart1.setGalleryAttributes(statistics1.getGallery().getBoxPlot());
        statistics1.getGallery().getBoxPlot().setNotched(false);
        statistics1.getGallery().getBoxPlot().setShowOutliers(true);
        chart1.getLegendBox().setVisible(false);
        chart1.setWidth(800);
        chart1.setHeight(600);
        chart1.renderControl();
        %>
    </body>
</html>
