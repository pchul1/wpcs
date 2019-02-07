<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="com.softwarefx.chartfx.server.annotation.*"%>
<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page import="com.softwarefx.chartfx.server.statistical.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : calculators
    Created on : Jun 25, 2008, 6:37:44 PM
    Author     : Administrator
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Calculators</title>
    </head>
    <body>
        <%
        ChartServer chart1 = new ChartServer(application,request,response);
        com.softwarefx.chartfx.server.statistical.Statistics statistics1 = new com.softwarefx.chartfx.server.statistical.Statistics();
        chart1.getExtensions().add(statistics1);
        statistics1.setChart(chart1);  
        TextProvider txtProvider = new TextProvider(application.getRealPath("/") + "/data/statistical_data.txt");
        chart1.setDataSource(txtProvider);
        
        chart1.setGallery(Gallery.SCATTER);

        double mean = statistics1.getCalculators().get(0).get(Analysis.MEAN);
        TitleDockable title = new TitleDockable();
        
        title.setText("The mean of this chart1 is: " + mean);
        chart1.getTitles().add(title);
        chart1.getLegendBox().setVisible(false);
        chart1.setWidth(800);
        chart1.setHeight(600);
        chart1.renderControl();
        %>
    </body>
</html>
