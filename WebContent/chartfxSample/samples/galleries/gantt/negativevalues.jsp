<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Gantt: Negative Values</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.getData().setSeries(2);
chart1.getData().setPoints(9);
chart1.getData().set(0, 0,25);
chart1.getData().set(0, 1,45);
chart1.getData().set(0, 2,80);
chart1.getData().set(0, 3,65);
chart1.getData().set(0, 4,70);
chart1.getData().set(0, 5,65);
chart1.getData().set(0, 6,99);
chart1.getData().set(0, 7,67);
chart1.getData().set(0, 8,98);
chart1.getData().set(1, 0,-34);
chart1.getData().set(1, 1,-8);
chart1.getData().set(1, 2,-54);
chart1.getData().set(1, 3,-43);
chart1.getData().set(1, 4,-12);
chart1.getData().set(1, 5,-98);
chart1.getData().set(1, 6,-39);
chart1.getData().set(1, 7,-10);
chart1.getData().set(1, 8,-28);

chart1.setGallery(Gallery.GANTT);
chart1.getAllSeries().setStacked(Stacked.NORMAL);	
chart1.getView3D().setEnabled(true);
chart1.getView3D().setDepth((short) 30);
chart1.getAllSeries().getBorder().setVisible(false);
chart1.getLegendBox().setVisible(false);
chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
