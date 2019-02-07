<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="com.softwarefx.chartfx.server.annotation.*"%>
<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.maps.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : mapselectionwinnerseries
    Created on : Jun 25, 2008, 4:52:03 PM
    Author     : Administrator
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Winner Series</title>
    </head>
    <body>
        <%
        ChartServer chart1 = new ChartServer(pageContext,request,response);

        com.softwarefx.chartfx.server.maps.Map map = new com.softwarefx.chartfx.server.maps.Map();
        
        map.setMapSource(application.getRealPath("/") + "/chartfx70/Library/US/USA-StatesAbrev.svg");
        
        chart1.setDataSource(new TextProvider(application.getRealPath("/") + "/data/US_results.txt"));
        
        map.setLabelLinkFile(application.getRealPath("/") + "/data/US_LabelLinks.xml");
        chart1.getDataGrid().setVisible(true);
        chart1.getLegendBox().setVisible(true);
      
        chart1.getSeries().get(0).setColor(java.awt.Color.BLUE);
        chart1.getSeries().get(1).setColor(java.awt.Color.RED);
        map.setChart(chart1);
        chart1.setWidth(800);
        chart1.setHeight(600);
        chart1.renderControl();
        %>
    </body>
</html>
