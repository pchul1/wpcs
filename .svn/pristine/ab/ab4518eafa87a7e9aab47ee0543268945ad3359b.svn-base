<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : text
    Created on : Mar 19, 2008, 1:59:14 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Annotation: Text</title>
    </head>
    <body>
        <%
        ChartServer chart1 = new ChartServer(application,request,response);
        chart1.getLegendBox().setVisible(false);
        chart1.importChart(FileFormat.XML, application.getRealPath("/") + "/data/samples.cfx");
        com.softwarefx.chartfx.server.annotation.Annotations annot = new com.softwarefx.chartfx.server.annotation.Annotations();
        chart1.getExtensions().add(annot);
        
        chart1.getExtensions().add(annot);
        com.softwarefx.chartfx.server.annotation.AnnotationText text1 = new com.softwarefx.chartfx.server.annotation.AnnotationText();
        com.softwarefx.chartfx.server.annotation.AnnotationText text2 = new com.softwarefx.chartfx.server.annotation.AnnotationText();
        com.softwarefx.chartfx.server.annotation.AnnotationText text3 = new com.softwarefx.chartfx.server.annotation.AnnotationText();
        annot.getList().add(text1);
        annot.getList().add(text2);
        annot.getList().add(text3);

        // Annotation Text
        text1.setText("This is an Annotation Text");
        text1.setTextColor(java.awt.Color.white);
        text1.setColor(new java.awt.Color(0,0,0));
        text1.attach(3,50);

        // Non-clipped Text
        text2.setText("This text is not clipped");

        text2.setTextColor(java.awt.Color.red);
        text2.setColor(new java.awt.Color(0,0,0,0));
        text2.getBorder().setColor(new java.awt.Color(0,0,0,0));
        text2.setTop(150);
        text2.setLeft(440);

        // Clipped Text
        text3.setText("This text is clipped");

        text3.setTextColor(java.awt.Color.black);
        text3.setColor(new java.awt.Color(0,0,0,0));
        text3.getBorder().setColor(new java.awt.Color(0,0,0,0));
        text3.setTop(190);
        text3.setLeft(440);
        

        chart1.setWidth(600);
        chart1.setHeight(400);
        chart1.renderControl();
        %>
    </body>
</html>
