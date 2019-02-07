<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : colorinmarker
    Created on : Mar 17, 2008, 10:56:33 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Visual Attributes: Color in Markers</title>
    </head>
    <body>
        <% 
    ChartServer chart1 = new ChartServer(pageContext, request, response);
    chart1.getLegendBox().setVisible(false);
    chart1.getData().setSeries(2);
    chart1.getData().setPoints(5);
    chart1.getData().set(0, 0, -10);
    chart1.getData().set(0, 1, 34);
    chart1.getData().set(0, 2, 42);
    chart1.getData().set(0, 3, 16);
    chart1.getData().set(1, 0, 45);
    chart1.getData().set(1, 1, 22);
    chart1.getData().set(1, 2, -27);
    chart1.getData().set(1, 3, 38);

   
    chart1.setAxesStyle(AxesStyle.FRAME_3D);
    chart1.getSeries().get(0).setGallery(Gallery.BAR);
    chart1.getSeries().get(1).setGallery(Gallery.LINES);

    //Set color for all points on series 0
    chart1.getPoints().get(0, 0).setColor(new java.awt.Color(240, 248, 255));
    chart1.getPoints().get(0, 1).setColor(new java.awt.Color(250, 235, 215));
    chart1.getPoints().get(0, 2).setColor(new java.awt.Color(245, 245, 220));
    chart1.getPoints().get(0, 3).setColor(new java.awt.Color(0, 0, 255));

    //Set color for all points on series 1
    chart1.getPoints().get(1, 0).setColor(new java.awt.Color(165, 42, 42));
    chart1.getPoints().get(1, 1).setColor(new java.awt.Color(95, 158, 160));
    chart1.getPoints().get(1, 2).setColor(new java.awt.Color(210, 105, 30));
    chart1.getPoints().get(1, 3).setColor(new java.awt.Color(220, 20, 60));

    chart1.getAllSeries().getBorder().setVisible(true);
    chart1.getAllSeries().getBorder().setEffect(BorderEffect.OPPOSITE);
    chart1.setWidth(600);
    chart1.setHeight(400);
    chart1.renderControl();       
        %>
    </body>
</html>
