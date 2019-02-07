<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : annotation.arc
    Created on : Mar 18, 2008, 4:37:31 PM
    Author     : Administrator
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Annotation: Arc</title>
    </head>
    <body>
         <%
        ChartServer chart1 = new ChartServer(pageContext,request,response);
       
       
        com.softwarefx.chartfx.server.annotation.Annotations annot = new com.softwarefx.chartfx.server.annotation.Annotations();
        com.softwarefx.chartfx.server.annotation.AnnotationArc arc = new com.softwarefx.chartfx.server.annotation.AnnotationArc();
        arc.getBorder().setColor(java.awt.Color.red);
        arc.getBorder().setWidth(4);
        arc.setHeight(100);
        arc.setWidth(-80);
        arc.attach(2, 50);
        annot.getList().add(arc);
        chart1.getExtensions().add(annot);

        chart1.setWidth(600);
        chart1.setHeight(400);
        chart1.renderControl();
%>
    </body>
</html>
