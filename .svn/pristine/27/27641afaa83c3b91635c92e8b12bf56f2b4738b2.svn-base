<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : custom.markers
    Created on : Mar 17, 2008, 11:14:27 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Visual Attributes: Marker Pictures</title>
    </head>
    <body>
             <% 
    ChartServer chart1 = new ChartServer(pageContext, request, response);
    
    chart1.getData().setSeries(2);
    chart1.getData().setPoints(5);
    chart1.getDataGrid().setVisible(true);

    
    chart1.getAllSeries().setMarkerShape(MarkerShape.NONE);
    chart1.updateSizeNow();

    chart1.getAllSeries().setMarkerShape(MarkerShape.PICTURE);
    chart1.getAllSeries().setMarkerSize((short)8);
    chart1.getLegendBox().setVisible(true);


   javax.swing.ImageIcon ico = new javax.swing.ImageIcon(application.getRealPath("/") + "/data/workstation2.png");
    java.awt.Image img = ico.getImage();
    chart1.getSeries().get(0).setPicture(img);

    chart1.setWidth(600);
    chart1.setHeight(400);
    chart1.renderControl();       
        %>
    </body>
</html>
