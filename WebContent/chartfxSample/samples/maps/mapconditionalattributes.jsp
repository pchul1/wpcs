<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="com.softwarefx.chartfx.server.annotation.*"%>
<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.maps.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : mapconditionalattributes
    Created on : May 12, 2008, 3:31:03 PM
    Author     : Administrator
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Europe Conditional Attribute</title>
    </head>
    <body>
       <%
            ChartServer chart1 = new ChartServer(pageContext,request,response);

            com.softwarefx.chartfx.server.maps.Map map = new com.softwarefx.chartfx.server.maps.Map();
            map.setChart(chart1);           
            map.setMapSource(application.getRealPath("/") + "/chartfx70/Library/Regions/Europe.svg");
           
            chart1.setDataSource(new TextProvider(application.getRealPath("/") + "/data/Europe2004Pop.txt"));
            


            ConditionalAttributes cond1 = new ConditionalAttributes();
            ConditionalAttributes cond2 = new ConditionalAttributes();
            ConditionalAttributes cond3 = new ConditionalAttributes();

            cond1.setColor(new java.awt.Color(173, 216, 230));
            cond1.setText("Under 25%");
            chart1.getConditionalAttributes().add(cond1);
            cond2.setColor(new java.awt.Color(30, 144, 255));
            cond2.setText("50% - 75%");
            chart1.getConditionalAttributes().add(cond2);
            cond3.setColor(new java.awt.Color(72, 61, 139));
            cond3.setText("More than 75%");
            chart1.getConditionalAttributes().add(cond3);
            int i;
            for (i = 0; i < chart1.getData().getPoints(); i++)
            {       
                if ((map.getVisibleMapRegions().get(i) != null))
                {
                   com.softwarefx.chartfx.server.maps.MapRegion region = map.getVisibleMapRegions().get(i);
                
        double val0  = map.getData().get(0, i);
        double val1  = map.getData().get(1, i);
        //Set Rules to Map
        double dPercentage = (val1/val0)*100;
        if (dPercentage <= 25)
        	region.getPointAttributes().setColor(chart1.getConditionalAttributes().get(0).getColor());                        
        else if (dPercentage <= 75)
        	region.getPointAttributes().setColor(chart1.getConditionalAttributes().get(1).getColor());
        else
            region.getPointAttributes().setColor(chart1.getConditionalAttributes().get(2).getColor());
    
                }
            }
            chart1.setWidth(800);
            chart1.setHeight(600);
            chart1.renderControl();
%>
    </body>
</html>
