<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : label.doublelabeling
    Created on : Mar 14, 2008, 11:34:19 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Label: Double Labeling</title>
    </head>
    <body>
        <%
        ChartServer chart1 = new ChartServer(pageContext, request, response);
        chart1.getData().setSeries(2);
        chart1.getData().setPoints(9);
        java.util.Random r = new java.util.Random(1);
        for (int i = 0; i < 2; i++)
        for (int j = 0; j < 9; j++)
        chart1.getData().set(i, j,r.nextDouble()* 20);


        chart1.getAxisX().getGrids().getMajor().setVisible(false);
        chart1.getAxisY().getGrids().getMajor().setVisible(false);

        AxisX axis = new AxisX();
        axis.setVisible(true);
        axis.setMin(0);
        axis.setMax(9);
        axis.setPosition(AxisPosition.NEAR);
        axis.getLabelsFormat().setDecimals(0);
        axis.setStep(4);
        java.util.EnumSet<AxisStyles> style = axis.getStyle();
        style.add(AxisStyles.CENTERED);
        axis.setStyle(style);
        chart1.getLegendBox().setVisible(false);
        axis.getLabels().set(3,"Group1");
        axis.getLabels().set(5,"Group2");
        axis.getLabels().set(9,"Group3");
        axis.getLine().setColor(java.awt.Color.RED);
        axis.getGrids().getMajor().setColor(java.awt.Color.RED);
        axis.setCustomSteps(new double[] { 3, 2, 4 });
        chart1.getAxesX().add(axis);
        chart1.setWidth(600);
        chart1.setHeight(400);
        chart1.renderControl();
        %>
    </body>
</html>
