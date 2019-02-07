<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : conditional.attributes
    Created on : Mar 17, 2008, 10:33:30 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Conditional Atributes</title>
    </head>
    <body>
        <% 
    ChartServer chart1 = new ChartServer(pageContext, request, response);
    chart1.getData().setSeries(1);
    chart1.getData().setPoints(20);
    chart1.getData().set(0,0,5);
    chart1.getData().set(0,1,75);
    chart1.getData().set(0,2,28);
    chart1.getData().set(0,3,37);
    chart1.getData().set(0,4,90);
    chart1.getData().set(0,5,7);
    chart1.getData().set(0,6,55);
    chart1.getData().set(0,7,85);
    chart1.getData().set(0,8,38);
    chart1.getData().set(0,9,47);
    chart1.getData().set(0,10,98);
    chart1.getData().set(0,11,71);
    chart1.getData().set(0,12,58);
    chart1.getData().set(0,13,17);
    chart1.getData().set(0,14,40);
    chart1.getData().set(0,15,77);
    chart1.getData().set(0,16,80);
    chart1.getData().set(0,17,15);
    chart1.getData().set(0,18,20);
    chart1.getData().set(0,19,7);

    ConditionalAttributes condition1 = new ConditionalAttributes();
    condition1.setColor(java.awt.Color.GRAY);
    condition1.setMarkerSize((short) 5);
    condition1.setMarkerShape(MarkerShape.CIRCLE);
    condition1.getCondition().setTo(20);
    condition1.getCondition().setToOpen(true);
    condition1.setText("Underqualified");
    chart1.getConditionalAttributes().add(condition1);

    ConditionalAttributes condition2 = new ConditionalAttributes();
    condition2.setColor(java.awt.Color.RED);
    condition2.setMarkerSize((short) 5);
    condition2.setMarkerShape(MarkerShape.TRIANGLE);
    condition2.getCondition().setFrom(80);
    condition2.setText("Overqualified");
    chart1.getConditionalAttributes().add(condition2);

    // Populating the Chart1

    LegendItemAttributes ItemAttribute = new LegendItemAttributes();
    ItemAttribute.setVisible(false);
    chart1.getLegendBox().getItemAttributes().set(chart1.getSeries(),ItemAttribute);
    CustomGridLine constant1 = new CustomGridLine();
    constant1.setValue(20);
    constant1.setColor(java.awt.Color.GRAY);
    CustomGridLine constant2 = new CustomGridLine();
    constant2.setValue(80);
    constant2.setColor(java.awt.Color.RED);

    chart1.getAxisY().getCustomGridLines().add(constant1);
    chart1.getAxisY().getCustomGridLines().add(constant2);

    chart1.getLegendBox().setVisible(true);

    chart1.setGallery(Gallery.SCATTER);
    chart1.setWidth(600);
    chart1.setHeight(400);
    chart1.renderControl();  
    %>
    </body>
</html>
