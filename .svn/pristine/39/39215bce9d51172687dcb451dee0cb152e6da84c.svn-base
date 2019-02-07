<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="com.softwarefx.chartfx.server.annotation.*"%>
<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.maps.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : mapsshowsthislevelonly
    Created on : Jun 23, 2008, 6:03:47 PM
    Author     : Administrator
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Show This Level Only</title>
    </head>
    <body>
        <%
        ChartServer chart1 = new ChartServer(pageContext,request,response);
        com.softwarefx.chartfx.server.maps.Map map = new com.softwarefx.chartfx.server.maps.Map();

        map.setMapSource(application.getRealPath("/") + "/chartfx70/Library/US/USA-Regions-StatesAbrev.svg"); 
        map.setChart(chart1);  
        chart1.setDataSource(new TextProvider(application.getRealPath("/") + "/data/US_CokeData.txt"));
        
        map.setLabelLinkFile(application.getRealPath("/") + "/data/US_LabelLinks.xml");
       

        TitleDockable title = new TitleDockable();

        title.setFont(new java.awt.Font("Arial",java.awt.Font.BOLD,10));
        title.setText("Multi Levels using ShowThisLevelOnly");
        chart1.getTitles().add(title);
        map.getLabelStylesSettings().setShowThisLevelOnly(true);
        
        chart1.getSeries().get(0).setColor(java.awt.Color.YELLOW);
        ConditionalAttributes cond1 = new ConditionalAttributes();
        ConditionalAttributes cond2 = new ConditionalAttributes();
        cond1.getCondition().setTo(3000);
        cond1.setColor(java.awt.Color.YELLOW);
        cond2.getCondition().setFrom(3000);
        cond2.setColor(new java.awt.Color(139, 58,58));
        
        chart1.getConditionalAttributes().add(cond1);
        chart1.getConditionalAttributes().add(cond2);
        chart1.getAllSeries().getPointLabels().setVisible(true);
        LegendItemAttributes ItemAttribute = new LegendItemAttributes();
        
        ItemAttribute.setVisible(false);
        chart1.getLegendBox().getItemAttributes().set(chart1.getSeries(), ItemAttribute);
        chart1.getLegendBox().setVisible(true);
        map.recalculate();
        chart1.setWidth(800);
        chart1.setHeight(600);
        chart1.renderControl();
        %>
    </body>
</html>
