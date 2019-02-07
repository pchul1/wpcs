<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : custom.markerlabels
    Created on : Mar 14, 2008, 10:58:59 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Labels: Custon Markers Labels</title>
    </head>
    <body>
    <%
        ChartServer chart1 = new ChartServer(pageContext, request, response);
        
        chart1.getData().setSeries(1);
        chart1.getData().setPoints(3);
        chart1.getData().set(0, 0, 20);
        chart1.getData().set(0, 1, 45);
        chart1.getData().set(0, 2, 30);

        chart1.getAllSeries().getPointLabels().setFormat("I represent the " + "%p" + "%%" + "\n" + "of " + "%t" + " on " + "%l");
        chart1.getAllSeries().getPointLabels().setVisible(true);

        chart1.setGallery(Gallery.PIE);
        chart1.getView3D().setEnabled(true);
        chart1.getPoints().get(2).setSeparateSlice((short) 35);
        chart1.getLegendBox().setVisible(false);
        chart1.getAxisX().getLabels().set(0, "Jan");
        chart1.getAxisX().getLabels().set(1, "Feb");
        chart1.getAxisX().getLabels().set(2, "Mar");
      
        chart1.setWidth(600);
        chart1.setHeight(400);
        chart1.renderControl();
        %>
    </body>
</html>
