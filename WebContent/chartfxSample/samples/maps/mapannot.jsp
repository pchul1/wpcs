<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="com.softwarefx.chartfx.server.annotation.*"%>
<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.maps.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : map
    Created on : Apr 21, 2008, 10:21:37 AM
    Author     : Administrator
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Annotation</title>
    </head>
    <body>
        <%
        ChartServer chart1 = new ChartServer(pageContext,request,response);

        com.softwarefx.chartfx.server.maps.Map map = new com.softwarefx.chartfx.server.maps.Map();

        map.setMapSource(application.getRealPath("/") + "\\chartfx70\\Library\\Regions\\WesternEurope-Countries.svg"); 
        map.setChart(chart1);  
    
        chart1.getAllSeries().getPointLabels().setVisible(true);

        Annotations annot = new Annotations();
        AnnotationBalloon balloon = new AnnotationBalloon();
        com.softwarefx.chartfx.server.maps.MapRegion mrsp = map.findMapRegion("Spain");
        annot.getList().add(balloon);
		balloon.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, 16));
        balloon.setText("Spain");
        balloon.setTop(mrsp.getBoundary().getTop() + 150);
        balloon.setLeft(mrsp.getBoundary().getLeft()+ 120);

        balloon.setHeight(50);
        balloon.setWidth(130);
        balloon.setArrowY(3);
        balloon.setArrowX(15);
       
        balloon.getBorder().setColor(java.awt.Color.black);
        balloon.getBorder().setWidth(2);
      
        balloon.setColor(new java.awt.Color(240,255,240));  //Color Honeydrew
     
        map.getAnnotationObjectsList().add(balloon);
       
        AnnotationBalloon balloon2 = new AnnotationBalloon();
        com.softwarefx.chartfx.server.maps.MapRegion mrfin = map.findMapRegion("Finland");
        annot.getList().add(balloon2);
		balloon2.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, 16));
        balloon2.setText("Finland");
        balloon2.setTop(mrfin.getBoundary().getTop() + 30);
        balloon2.setLeft(mrfin.getBoundary().getLeft()+ 70);

        balloon2.setHeight(50);
        balloon2.setWidth(130);
        balloon2.setArrowY(3);
        balloon2.setArrowX(15);
       
        balloon2.getBorder().setColor(java.awt.Color.black);
        balloon2.getBorder().setWidth(2);
      
        balloon2.setColor(new java.awt.Color(240,255,240));  //Color Honeydrew
     
        map.getAnnotationObjectsList().add(balloon2);
        AnnotationArc arc = new AnnotationArc();

        arc.getBorder().setColor(java.awt.Color.red);
        arc.getBorder().setWidth(4);
        
        arc.setHeight(100);
        arc.setWidth(3);
        arc.getBorder().setStyle(DashStyle.DASH);
        arc.setHeight(- mrsp.getBoundary().getTop());
        arc.setWidth(mrfin.getBoundary().getLeft());
        arc.setTop(mrfin.getBoundary().getTop() + 70);
        arc.setLeft(mrsp.getBoundary().getLeft()+ 40);
        annot.getList().add(arc);
        map.getAnnotationObjectsList().add(arc);
       
        AnnotationBalloon balloon3 = new AnnotationBalloon();
   
        annot.getList().add(balloon3);
		balloon3.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, 16));
        balloon3.setText("2000 miles \n Distance");
        balloon3.setTop(160);
        balloon3.setLeft(50);

        balloon3.setHeight(80);
        balloon3.setWidth(170);
        balloon3.setArrowY(3);
        balloon3.setArrowX(15);
      
        balloon3.getBorder().setColor(java.awt.Color.RED);
        balloon3.getBorder().setWidth(2);
      
        balloon3.setColor(new java.awt.Color(240,255,240));  //Color Honeydrew
        balloon3.setWordWrap(false);
      // map.setSmoothFlags(SmoothFlags.FILL | SmoothFlags.BORDER);
        map.getAnnotationObjectsList().add(balloon3);
 
        chart1.setWidth(800);
        chart1.setHeight(600);
        chart1.renderControl();
%>

    </body>
</html>
