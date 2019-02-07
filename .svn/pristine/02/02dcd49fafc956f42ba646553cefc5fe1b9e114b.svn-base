<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>

<%-- 
    Document   : gradient
    Created on : Mar 17, 2008, 11:34:57 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Transparency: Gradient</title>
    </head>
    <body>
         <% 
    ChartServer chart1 = new ChartServer(pageContext, request, response);
    chart1.getLegendBox().setVisible(false);
        GradientBackground g1 = new GradientBackground(GradientType.FORWARD_DIAGONAL);

    g1.getColors().set(0,new java.awt.Color(65,105,225));
    g1.getColors().set(1,new java.awt.Color(245,245,220));
    g1.getColors().set(2,new java.awt.Color(143,188,143));

    g1.getPosition().set(0,0);
    g1.getPosition().set(1, (float)0.5);
    g1.getPosition().set(2,1);

    chart1.setBackground(g1);

    chart1.setGallery(Gallery.LINES);

    chart1.setPlotAreaColor(new java.awt.Color(106, 90, 205, 80));
    chart1.setWidth(600);
    chart1.setHeight(400);
    chart1.renderControl();
    %>
    </body>
</html>
