<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : constant.lines
    Created on : Mar 17, 2008, 10:37:12 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Conditional Attributes: Constant Lines</title>
    </head>
    <body>
       <% 
    ChartServer chart1 = new ChartServer(pageContext, request, response);
    chart1.getLegendBox().setVisible(false);
    CustomGridLine custom1 = new CustomGridLine();
    custom1.setValue(45);
    custom1.setWidth(2);
    chart1.getAxisY().getCustomGridLines().add(custom1);
    chart1.setWidth(600);
    chart1.setHeight(400);
    chart1.renderControl();  
    %>
    </body>
</html>
