<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : rectangle
    Created on : Mar 19, 2008, 12:09:38 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Annotation: Rectangle</title>
    </head>
    <body>
         <%
        ChartServer chart1 = new ChartServer(application,request,response);
        chart1.importChart(FileFormat.XML, application.getRealPath("/") + "/data/samples.cfx");


        com.softwarefx.chartfx.server.annotation.Annotations annot = new com.softwarefx.chartfx.server.annotation.Annotations();
        chart1.getExtensions().add(annot);
        
        chart1.getExtensions().add(annot);
    
        com.softwarefx.chartfx.server.annotation.AnnotationRectangle rect = new com.softwarefx.chartfx.server.annotation.AnnotationRectangle();
        annot.getList().add(rect);
        rect.setColor(java.awt.Color.yellow);
        rect.getBorder().setColor(java.awt.Color.red);
        rect.attach(1.0, 60.0, 3.0, 40.0);

        chart1.setWidth(600);
        chart1.setHeight(400);
        chart1.renderControl();
        %>
    </body>
</html>
