<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : group
    Created on : Mar 19, 2008, 10:26:59 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Annotation: Group</title>
    </head>
    <body>
        <%
        ChartServer chart1 = new ChartServer(pageContext,request,response);
         chart1.importChart(FileFormat.XML, application.getRealPath("/") + "/data/samples.cfx");   
        com.softwarefx.chartfx.server.annotation.Annotations annot = new com.softwarefx.chartfx.server.annotation.Annotations();
        chart1.getExtensions().add(annot);
        com.softwarefx.chartfx.server.annotation.AnnotationCircle circle1 = new com.softwarefx.chartfx.server.annotation.AnnotationCircle();
        circle1.setHeight(30);
        circle1.setWidth(30);
        circle1.getBorder().setColor(java.awt.Color.black);
        circle1.attach(1, 50);
        
        com.softwarefx.chartfx.server.annotation.AnnotationCircle circle2 = new com.softwarefx.chartfx.server.annotation.AnnotationCircle();
        circle2.setHeight(30);
        circle2.setWidth(30);
        circle2.getBorder().setColor(java.awt.Color.black);
        circle2.attach(2, 50);
        com.softwarefx.chartfx.server.annotation.AnnotationCircle circle3 = new com.softwarefx.chartfx.server.annotation.AnnotationCircle();
        circle3.setHeight(30);
        circle3.setWidth(30);
        circle3.getBorder().setColor(java.awt.Color.black);
        circle3.attach(3, 50);
        com.softwarefx.chartfx.server.annotation.AnnotationGroup group = new com.softwarefx.chartfx.server.annotation.AnnotationGroup();
        annot.getList().add(group);
     
        group.getList().add(circle1);
        group.getList().add(circle2);
        group.getList().add(circle3);

group.setColor(java.awt.Color.yellow);
group.recalcBounds();
        chart1.setWidth(600);
        chart1.setHeight(400);
        chart1.renderControl();
        
        
        %>
    </body>
</html>
