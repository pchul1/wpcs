<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="com.softwarefx.chartfx.server.annotation.*"%>
<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.maps.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : mapcustomizeregion
    Created on : May 13, 2008, 9:27:34 AM
    Author     : Administrator
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customize Region</title>
    </head>
    <body>
        <%
        ChartServer chart1 = new ChartServer(pageContext, request, response);

        com.softwarefx.chartfx.server.maps.Map map = new com.softwarefx.chartfx.server.maps.Map();
        map.setMapSource(application.getRealPath("/") + "/chartfx70/Library/Regions/WesternEurope-Countries.svg");
          
        chart1.setDataSource(new TextProvider(application.getRealPath("/") + "/data/WesternEuropeData.txt"));
        map.setChart(chart1);
        com.softwarefx.chartfx.server.maps.MapRegion mr = map.findMapRegion("Italy");
        mr.getPointAttributes().setColor(java.awt.Color.RED);
        mr.getPointAttributes().getPointLabels().setVisible(true);
        mr.getPointAttributes().getPointLabels().setTextColor(java.awt.Color.GREEN);
        mr.getPointAttributes().getPointLabels().setFont(new java.awt.Font("Courier New",java.awt.Font.BOLD | java.awt.Font.ITALIC,30));
        chart1.setWidth(800);
        chart1.setHeight(600);
        chart1.renderControl();
        %>
    </body>
</html>
