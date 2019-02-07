<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : arrow
    Created on : Mar 18, 2008, 5:21:41 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Annotation: Arrow</title>
    </head>
    <body>
       <%
        ChartServer chart1 = new ChartServer(pageContext,request,response);
            
        com.softwarefx.chartfx.server.annotation.Annotations annot = new com.softwarefx.chartfx.server.annotation.Annotations();
        com.softwarefx.chartfx.server.annotation.AnnotationArrow arrow = new com.softwarefx.chartfx.server.annotation.AnnotationArrow();
        //annot.getList().add(arrow);
        arrow.getBorder().setColor(java.awt.Color.RED);
        arrow.getBorder().setWidth(4);
        arrow.setHeight(100);
        arrow.setWidth(-80);
        arrow.attach(2, 45);
        annot.getList().add(arrow);
        chart1.getExtensions().add(annot);

        chart1.setWidth(600);
        chart1.setHeight(400);
        chart1.renderControl();
%>
    </body>
</html>
