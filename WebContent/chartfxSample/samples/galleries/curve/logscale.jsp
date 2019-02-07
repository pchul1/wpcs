<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Curve: Logarithmic Scale</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.setGallery(Gallery.CURVE);

chart1.getAllSeries().setMarkerShape(MarkerShape.NONE);
chart1.getAllSeries().getLine().setWidth((short)4);
chart1.getAxisY().setLogBase(10);

chart1.getAxisX().getGrids().getMajor().setVisible(false);
chart1.getAxisY().getGrids().getMajor().setVisible(true);
chart1.getAxisY().getGrids().getMajor().setColor(new java.awt.Color(233, 233, 233));

chart1.getAxisY().getLabelsFormat().setDecimals(2);
chart1.getLegendBox().setVisible(false);
chart1.getAxisY().setMin(0.9);
chart1.getAxisY().setMax(120);

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
