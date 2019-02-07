<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : stripes
    Created on : Mar 17, 2008, 10:50:50 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Conditional Attributes: Stripes</title>
    </head>
    <body>
       <% 
    ChartServer chart1 = new ChartServer(pageContext, request, response);
    chart1.getLegendBox().setVisible(false);
    AxisSection section = new AxisSection();
    section.setFrom(2);
    section.setTo(3);
    section.setBackColor(java.awt.Color.RED);
    chart1.getAxisX().getSections().add(section);
    chart1.setWidth(600);
    chart1.setHeight(400);
    chart1.renderControl();  
    %>
    </body>
</html>
