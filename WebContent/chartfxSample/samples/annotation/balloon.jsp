<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : balloon
    Created on : Mar 18, 2008, 5:40:54 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Annotation: Ballon</title>
    </head>
    <body>
      <%
        ChartServer chart1 = new ChartServer(pageContext,request,response);
        chart1.importChart(FileFormat.XML, application.getRealPath("/") + "/data/samples.cfx");
       
        
        com.softwarefx.chartfx.server.annotation.Annotations annot = new com.softwarefx.chartfx.server.annotation.Annotations();
        
        com.softwarefx.chartfx.server.annotation.AnnotationBalloon balloon = new com.softwarefx.chartfx.server.annotation.AnnotationBalloon();
       com.softwarefx.chartfx.server.annotation.AnnotationArrow arrow = new com.softwarefx.chartfx.server.annotation.AnnotationArrow();
        
        balloon.setArrowY(3);
       balloon.setArrowX(15);
            balloon.getBorder().setColor(java.awt.Color.red);
        balloon.getBorder().setWidth(2);
       balloon.setColor(java.awt.Color.white);
        balloon.setText("Balloon Text");
        
       balloon.setHeight(70);
       balloon.setWidth(-80);
        balloon.attach(1.6, 70);  
        annot.getList().add(arrow);
        annot.getList().add(balloon);
        chart1.getExtensions().add(annot);
        chart1.setWidth(600);
        chart1.setHeight(400);
        chart1.renderControl();
%>

    </body>
</html>
