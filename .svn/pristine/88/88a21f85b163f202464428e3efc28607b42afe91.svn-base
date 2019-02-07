<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="com.softwarefx.chartfx.server.annotation.*"%>
<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.maps.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : mapconditionalattributessouthamerica
    Created on : May 12, 2008, 4:37:47 PM
    Author     : Administrator
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>South America Conditional Attributes</title>
    </head>
    <body>
        <%
            ChartServer chart1 = new ChartServer(pageContext,request,response);

            com.softwarefx.chartfx.server.maps.Map map = new com.softwarefx.chartfx.server.maps.Map();
            map.setChart(chart1);           
            map.setMapSource(application.getRealPath("/") + "/chartfx70/Library/Regions/SouthAmerica-Countries.svg");
      
            chart1.setDataSource(new TextProvider(application.getRealPath("/") + "/data/SouthAmerica2004Pop.txt"));
 
            ConditionalAttributes cond1 = new ConditionalAttributes();
            ConditionalAttributes cond2 = new ConditionalAttributes();
            ConditionalAttributes cond3 = new ConditionalAttributes();

            cond1.setColor(java.awt.Color.YELLOW);
            cond1.getCondition().setTo(10000000);
            cond1.setText("Under 10");
            chart1.getConditionalAttributes().add(cond1);
            cond2.getCondition().setTo(100000000);
            cond2.getCondition().setFrom(10000000);
            cond2.setColor(java.awt.Color.PINK);
            cond2.setText("10 - 100");
            chart1.getConditionalAttributes().add(cond2);
            cond3.getCondition().setFrom(100000000);
            cond3.setColor(new java.awt.Color(139,58,58));
            cond3.setText("More than 100");
            chart1.getConditionalAttributes().add(cond3);
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
