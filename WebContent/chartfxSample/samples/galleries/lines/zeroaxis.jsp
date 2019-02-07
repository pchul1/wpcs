<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Lines</title>
    </head>
    <body>
<%
    ChartServer chart1 = new ChartServer(pageContext, request, response);
    chart1.setGallery(Gallery.LINES);
            
    chart1.getData().setSeries(1);
    chart1.getData().setPoints(20);
    chart1.getData().getX().set(0, 0, -0.86);
    chart1.getData().getY().set(0, 0, -0.41);
    chart1.getData().getX().set(0, 1, -0.77);
    chart1.getData().getY().set(0, 1, -0.24);
    chart1.getData().getX().set(0, 2, -0.65);
    chart1.getData().getY().set(0, 2, -0.23);
    chart1.getData().getX().set(0, 3, -0.55);
    chart1.getData().getY().set(0, 3, -0.16);
    chart1.getData().getX().set(0, 4, -0.49);
    chart1.getData().getY().set(0, 4, -0.08);
    chart1.getData().getX().set(0, 5, -0.43);
    chart1.getData().getY().set(0, 5, -0.06);
    chart1.getData().getX().set(0, 6, -0.3);
    chart1.getData().getY().set(0, 6, -0.16);
    chart1.getData().getX().set(0, 7, -0.22);
    chart1.getData().getY().set(0, 7, -0.14);
    chart1.getData().getX().set(0, 8, -0.06);
    chart1.getData().getY().set(0, 8, -0.06);
    chart1.getData().getX().set(0, 9, -0.02);
    chart1.getData().getY().set(0, 9, -0.04);
    chart1.getData().getX().set(0, 10, 0.12);
    chart1.getData().getY().set(0, 10, -0.08);
    chart1.getData().getX().set(0, 11, 0.23);
    chart1.getData().getY().set(0, 11, 0.05);
    chart1.getData().getX().set(0, 12, 0.34);
    chart1.getData().getY().set(0, 12, 0.02);
    chart1.getData().getX().set(0, 13, 0.44);
    chart1.getData().getY().set(0, 13, 0.05);
    chart1.getData().getX().set(0, 14, 0.51);
    chart1.getData().getY().set(0, 14, -0.01);
    chart1.getData().getX().set(0, 15, 0.58);
    chart1.getData().getY().set(0, 15, 0.11);
    chart1.getData().getX().set(0, 16, 0.67);
    chart1.getData().getY().set(0, 16, 0.09);
    chart1.getData().getX().set(0, 17, 0.77);
    chart1.getData().getY().set(0, 17, 0.17);
    chart1.getData().getX().set(0, 18, 0.93);
    chart1.getData().getY().set(0, 18, 0.14);
    chart1.getData().getX().set(0, 19, 0.95);
    chart1.getData().getY().set(0, 19, 0.21);

    chart1.getAllSeries().setMarkerShape(MarkerShape.NONE);
    
    chart1.getAxisY().getLabelsFormat().setDecimals(2);
    chart1.getLegendBox().setVisible(false);

    chart1.setWidth(600);
    chart1.setHeight(400);
    chart1.renderControl();
%>        
    </body>
</html>
