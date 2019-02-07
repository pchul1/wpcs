<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : Legendbox.User
    Created on : Mar 14, 2008, 1:57:23 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Conditional Attributes: Custom Item</title>
    </head>
    <body>
       <%
    ChartServer chart1 = new ChartServer(pageContext, request, response);
    LegendItemAttributes ItemAttribute = new LegendItemAttributes();
    
    chart1.getData().setSeries(1);
    chart1.getData().setPoints(5);
    chart1.getData().set(0, 0, 72);
    chart1.getData().set(0, 1, 42);
    chart1.getData().set(0, 2, 20);
    chart1.getData().set(0, 3, 35);
    chart1.getData().set(0, 4, 90);
        
    ConditionalAttributes condition1 = new ConditionalAttributes();
    condition1.setColor(java.awt.Color.GREEN);
    condition1.getCondition().setTo(40);
    condition1.getCondition().setToOpen(true);
    condition1.setText("Normal");
    chart1.getConditionalAttributes().add(condition1);

    ConditionalAttributes condition2 = new ConditionalAttributes();
    condition2.setColor(java.awt.Color.RED);
    condition2.getCondition().setFrom(70);
    condition2.setText("Warning");
    chart1.getConditionalAttributes().add(condition2);
    
     ConditionalAttributes condition3 = new ConditionalAttributes();
    condition3.setColor(java.awt.Color.YELLOW);
    condition3.getCondition().setFrom(40);
    condition3.getCondition().setTo(70);
    condition3.getCondition().setToOpen(true);
    condition3.getCondition().setFromOpen(true);
    condition3.setText("Caution");
    chart1.getConditionalAttributes().add(condition3);
        
    ItemAttribute.setVisible(false);
    chart1.getLegendBox().getItemAttributes().set(chart1.getSeries(),ItemAttribute);
    CustomGridLine constant1 = new CustomGridLine();
    constant1.setValue(40);
    constant1.setColor(java.awt.Color.YELLOW);
    CustomGridLine constant2 = new CustomGridLine();
    constant2.setValue(70);
    constant2.setColor(java.awt.Color.RED);

    chart1.getAxisY().getCustomGridLines().add(constant1);
    chart1.getAxisY().getCustomGridLines().add(constant2);
    chart1.getAxisX().getGrids().getMajor().setVisible(false);
    chart1.getAxisY().getGrids().getMajor().setVisible(false);
        chart1.getLegendBox().setVisible(true);
        chart1.setGallery(Gallery.BAR);
        chart1.setWidth(600);
        chart1.setHeight(400);
        chart1.renderControl();
       %>
    </body>
</html>
