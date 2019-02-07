<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Combinations: Linear Regression</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.getData().setSeries(2);
chart1.getData().setPoints(10);
chart1.getData().set(0, 0,2.62);
chart1.getData().set(0, 1,10.82);
chart1.getData().set(0, 2,24.87);
chart1.getData().set(0, 3,18.71);
chart1.getData().set(0, 4,27.74);
chart1.getData().set(0, 5,56.47);
chart1.getData().set(0, 6,48.59);
chart1.getData().set(0, 7,57.54);
chart1.getData().set(0, 8,82.12);
chart1.getData().set(0, 9,88.89);
chart1.getData().set(1, 0,-4.03);
chart1.getData().set(1, 1,6.49);
chart1.getData().set(1, 2,16.24);
chart1.getData().set(1, 3,26.17);
chart1.getData().set(1, 4,35.9);
chart1.getData().set(1, 5,45.91);
chart1.getData().set(1, 6,55.65);
chart1.getData().set(1, 7,65.65);
chart1.getData().set(1, 8,75.39);
chart1.getData().set(1, 9,85.39);

chart1.getSeries().get(1).setGallery(Gallery.LINES);
chart1.getSeries().get(1).setMarkerShape(MarkerShape.RECT);
chart1.getSeries().get(0).setGallery(Gallery.SCATTER);
   
chart1.getLegendBox().setVisible(false);    

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
