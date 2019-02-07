<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : perpointattributes
    Created on : Mar 17, 2008, 10:04:42 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Conditional Attributes: Per Point Attribute</title>
    </head>
    <body>
        <% 
    ChartServer chart1 = new ChartServer(pageContext, request, response);
    chart1.getLegendBox().setVisible(false);
    chart1.getData().setSeries(1);
    chart1.getData().setPoints(12);
    java.util.Random r = new java.util.Random(5);
    for (int i=0;i<12;i++)
    chart1.getData().set(0, i,r.nextDouble() * 1000);

    
    chart1.getAllSeries().setMarkerSize((short)2);
    chart1.getAllSeries().getBorder().setUseForLines(true);
    chart1.getAllSeries().getBorder().setEffect(BorderEffect.NONE);
    chart1.getSeries().get(0).getBorder().setColor(chart1.getSeries().get(0).getColor());

    PointAttributes point = chart1.getPoints().get(0,5);
    point.setMarkerSize((short)5);
    point.setMarkerShape(MarkerShape.TRIANGLE);
    point.setColor(java.awt.Color.red);
    point.getBorder().setVisible(false);
    point.setText("New Fiscal Year");

    CustomLegendItem CustomItem = new CustomLegendItem();
    CustomItem.setAttributes(point);
    chart1.getLegendBox().getCustomItems().add(CustomItem);

    chart1.getLegendBox().setVisible(true);
    LegendItemAttributes item = new LegendItemAttributes();
    item.setVisible(false);
    chart1.getLegendBox().getItemAttributes().set(chart1.getSeries(),item);;

    chart1.getLegendBox().sizeToFit();

    chart1.setWidth(600);
    chart1.setHeight(400);
    chart1.renderControl();  
    %>
    </body>
</html>
