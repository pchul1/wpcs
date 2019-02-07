<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : font
    Created on : Mar 14, 2008, 3:33:54 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Datagrid: Fonts</title>
    </head>
    <body>
        <% 
        ChartServer chart1 = new ChartServer(pageContext, request, response);
        chart1.getData().setSeries(3);
        chart1.getData().setPoints(12);
        java.util.Random r = new java.util.Random(1);
        for (int i = 0;i<3;i++)
        for (int j = 0;j<12;j++)
        chart1.getData().set(i, j,r.nextDouble() * 100);
        chart1.getDataGrid().setVisible(true);
        chart1.getDataGrid().setFont(new java.awt.Font("Courier New",java.awt.Font.PLAIN,8));
        chart1.getDataGrid().setShowMarkers(true);

        chart1.getSeries().get(0).setText("A");
        chart1.getSeries().get(1).setText("B");
        chart1.getSeries().get(2).setText("C");
        chart1.setGallery(Gallery.AREA);
        chart1.getLegendBox().setVisible(false);
        chart1.setWidth(600);
        chart1.setHeight(400);
        chart1.renderControl();
%>
    </body>
</html>
