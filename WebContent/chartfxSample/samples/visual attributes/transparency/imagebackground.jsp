<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>

<%-- 
    Document   : imagebackground
    Created on : Mar 17, 2008, 11:56:52 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Transparency: With Image Background</title>
    </head>
    <body>
        <%
    ChartServer chart1 = new ChartServer(application,request,response);
    com.softwarefx.chartfx.server.dataproviders.TextProvider txtProvider
    = new com.softwarefx.chartfx.server.dataproviders.TextProvider();
    chart1.getLegendBox().setVisible(false); 
    
    javax.swing.ImageIcon ico = new javax.swing.ImageIcon(application.getRealPath("/") + "/data/newspaper.jpg");
    java.awt.Image img = ico.getImage();
    ImageBackground ib = new ImageBackground();
    ib.setImage(img);
    chart1.setBackground(ib);
    chart1.setPlotAreaColor(new java.awt.Color(235, 235, 205, 100));
    chart1.getAxisX().getGrids().getMajor().setVisible(false);
    
    txtProvider.open(application.getRealPath("/") + "/data/financial1.txt");
    chart1.getDataSourceSettings().getFields().add(new FieldMap("Field1",FieldUsage.LABEL));
    chart1.getDataSourceSettings().getFields().add(new FieldMap("Field2",FieldUsage.VALUE));
    chart1.getDataSourceSettings().getFields().add(new FieldMap("Field3", FieldUsage.VALUE));
    chart1.getDataSourceSettings().setDataSource(txtProvider);
    txtProvider.close();
    
    
    chart1.getAxisX().getLabelsFormat().setFormat(AxisFormat.DATE);

    SeriesAttributes series0 = chart1.getSeries().get(0);
    series0.setGallery(Gallery.LINES);
    series0.getLine().setWidth((short) 2);
    series0.setMarkerShape(MarkerShape.NONE);
    series0.setAxisY(chart1.getAxisY());

    SeriesAttributes series1 = chart1.getSeries().get(1);
    series1.setGallery(Gallery.AREA);
    series1.getBorder().setVisible(true);
    series1.setAxisY(chart1.getAxisY2());

    chart1.getAxisY().getGrids().getMajor().setVisible(true);
    Axis axis = chart1.getAxisY2();
    axis.setMax(200000000);
    axis.setMin(0);
    axis.setVisible(false);
    chart1.getPlotAreaMargin().setRight(30);

    chart1.recalculateScale();
   
    chart1.setWidth(600);
    chart1.setHeight(400);
    chart1.renderControl();
%>
    </body>
</html>
