<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : polygon
    Created on : Mar 19, 2008, 12:00:20 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Annotation: Polygon</title>
    </head>
    <body>
        <%
        ChartServer chart1 = new ChartServer(application,request,response);
chart1.importChart(FileFormat.XML, application.getRealPath("/") + "/data/samples.cfx");


com.softwarefx.chartfx.server.annotation.Annotations annot = new com.softwarefx.chartfx.server.annotation.Annotations();
        chart1.getExtensions().add(annot);
        
        com.softwarefx.chartfx.server.annotation.AnnotationPolygon poly = new com.softwarefx.chartfx.server.annotation.AnnotationPolygon();
        
        annot.getList().add(poly);

        java.awt.Point[] p = new java.awt.Point[4];
        p[0] = new java.awt.Point(250,50);
        p[1] = new java.awt.Point(320,150);
        p[2] = new java.awt.Point(300,250);
        p[3] = new java.awt.Point(200,100);
        
poly.setColor(java.awt.Color.red);

poly.setVertices(p);
poly.setClosed(true);
        chart1.setWidth(600);
        chart1.setHeight(400);
        chart1.renderControl();
        
        %>
    </body>
</html>
