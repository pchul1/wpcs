<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : circle
    Created on : Mar 19, 2008, 10:10:44 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Annotation: Circle</title>
    </head>
    <body>
        <%
        ChartServer chart1 = new ChartServer(pageContext,request,response);
        chart1.importChart(FileFormat.XML, application.getRealPath("/") + "/data/samples.cfx");
            
        com.softwarefx.chartfx.server.annotation.Annotations annot = new com.softwarefx.chartfx.server.annotation.Annotations();
        com.softwarefx.chartfx.server.annotation.AnnotationCircle circle = new com.softwarefx.chartfx.server.annotation.AnnotationCircle();
        
        annot.getList().add(circle);
        chart1.getExtensions().add(annot);
        circle.setColor(java.awt.Color.white);
        circle.setHeight(40);
        circle.setWidth(40);
        circle.attach(3, 70);
        circle.getBorder().setColor(java.awt.Color.red);
        
        chart1.setWidth(600);
        chart1.setHeight(400);
        chart1.renderControl();
        %>
    </body>
</html>
