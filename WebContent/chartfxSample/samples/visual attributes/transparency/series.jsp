<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : series
    Created on : Mar 17, 2008, 11:26:43 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Transparency: Series</title>
    </head>
    <body>
       <% 
    ChartServer chart1 = new ChartServer(pageContext, request, response);
    chart1.getLegendBox().setVisible(false);
    chart1.getData().setSeries(3);
    chart1.getData().setPoints(5);
    chart1.getData().set(0, 0, 45);
    chart1.getData().set(0, 1, 80);
    chart1.getData().set(0, 2, 90);
    chart1.getData().set(0, 3, 145);
    chart1.getData().set(0, 4, 56);
    chart1.getData().set(1, 0, 12);
    chart1.getData().set(1, 1, 36);
    chart1.getData().set(1, 2, 89);
    chart1.getData().set(1, 3, 10);
    chart1.getData().set(1, 4, 16);
    chart1.getData().set(2, 0, 59);
    chart1.getData().set(2, 1, 136);
    chart1.getData().set(2, 2, 76);
    chart1.getData().set(2, 3, 39);
    chart1.getData().set(2, 4, 28);

    
    chart1.getView3D().setEnabled(true);
    chart1.getView3D().setAngleX(30);
    chart1.getView3D().setAngleY(30);

    chart1.getSeries().get(0).setColor(new java.awt.Color(0, 0, 128, 130));

    chart1.setGallery(Gallery.AREA);
    chart1.setWidth(600);
    chart1.setHeight(400);
    chart1.renderControl();
    %>
    </body>
</html>
