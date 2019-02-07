<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : picture
    Created on : Mar 19, 2008, 11:04:22 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Annotation: Picture</title>
    </head>
    <body>
        <%
        ChartServer chart1 = new ChartServer(pageContext,request,response);
        javax.swing.ImageIcon ico = new javax.swing.ImageIcon(application.getRealPath("/") + "/data/cfx_logo_small.jpg");
        java.awt.Image img = ico.getImage(); 
        com.softwarefx.chartfx.server.annotation.Annotations annot = new com.softwarefx.chartfx.server.annotation.Annotations();
        chart1.getExtensions().add(annot);
        
        com.softwarefx.chartfx.server.annotation.AnnotationPicture pict = new com.softwarefx.chartfx.server.annotation.AnnotationPicture();
        annot.getList().add(pict);
        pict.setPicture(img);
        pict.setHeight(50);
        pict.setWidth(50);
        pict.setLeft(507);
        pict.setTop(30);
        pict.setColor(new java.awt.Color(0,0,0,0));
        pict.getBorder().setColor(new java.awt.Color(0,0,0,0));
        pict.setMode(com.softwarefx.chartfx.server.annotation.AnnImageMode.ORIGINAL);
        chart1.setWidth(600);
        chart1.setHeight(400);
        chart1.renderControl();
        
        %>
    </body>
</html>
