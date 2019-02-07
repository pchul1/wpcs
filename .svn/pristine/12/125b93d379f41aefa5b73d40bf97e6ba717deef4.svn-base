<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : colorinseries
    Created on : Mar 17, 2008, 11:06:15 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Visual Attributes: Color in Series</title>
    </head>
    <body>
         <% 
    ChartServer chart1 = new ChartServer(pageContext, request, response);
    chart1.getLegendBox().setVisible(false);
    chart1.getData().setSeries(2);
    chart1.getData().setPoints(5);

    
    chart1.getSeries().get(0).setColor(new java.awt.Color(255, 165, 0));
    chart1.getSeries().get(1).setColor(new java.awt.Color(123, 104, 238));

    chart1.setGallery(Gallery.BAR);
    chart1.getSeries().get(1).setGallery(Gallery.AREA);
    chart1.setWidth(600);
    chart1.setHeight(400);
    chart1.renderControl();       
        %>
    </body>
</html>
