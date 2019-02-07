<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : labels.clusteredz.axis
    Created on : Mar 14, 2008, 11:59:31 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        
    ChartServer chart1 = new ChartServer(pageContext, request, response);
    chart1.getData().setSeries(2);
    chart1.getData().setPoints(6);
    java.util.Random r = new java.util.Random(1);
    chart1.getLegendBox().setVisible(false);
    int i,j;
    for (i=0;i<3;i++)
    for (j=0;j<6;j++)
    {
        chart1.getData().set(i, j, r.nextDouble() * 100);
        chart1.getSeries().get(i).setText("S" + java.lang.Integer.toString(i+1));
    }
    
    chart1.getView3D().setEnabled(true);
    chart1.getView3D().setCluster(true);
    chart1.setWidth(600);
    chart1.setHeight(400);
    chart1.renderControl();
    %>
    </body>
</html>
