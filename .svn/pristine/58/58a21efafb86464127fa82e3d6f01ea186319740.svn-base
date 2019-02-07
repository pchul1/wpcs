<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Gantt</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.getData().setSeries(1);
chart1.getData().setPoints(9);

//Populating the chart1 
chart1.getData().getYFrom().set(0, 0,5);
chart1.getData().set(0, 0,25);
chart1.getAxisX().getLabels().set(0,"Act. 1");
chart1.getData().getYFrom().set(0, 1,25);
chart1.getData().set(0, 1,45);
chart1.getAxisX().getLabels().set(1,"Act. 2");
chart1.getData().getYFrom().set(0, 2,15);
chart1.getData().set(0, 2,80);
chart1.getAxisX().getLabels().set(2,"Act. 3");
chart1.getData().getYFrom().set(0, 3,37);
chart1.getData().set(0, 3,65);
chart1.getAxisX().getLabels().set(3,"Act. 4");
chart1.getData().getYFrom().set(0, 4, 32);
chart1.getData().set(0, 4,70);
chart1.getAxisX().getLabels().set(4,"Act. 5");
chart1.getData().getYFrom().set(0, 5,10);
chart1.getData().set(0, 5,65);
chart1.getAxisX().getLabels().set(5,"Act. 6");
chart1.getData().getYFrom().set(0, 6,80);
chart1.getData().set(0, 6,99);
chart1.getAxisX().getLabels().set(6,"Act. 7");
chart1.getData().getYFrom().set(0, 7,40);
chart1.getData().set(0, 7,67);
chart1.getAxisX().getLabels().set(7,"Act. 8");
chart1.getData().getYFrom().set(0, 8,67);
chart1.getData().set(0, 8,98);
chart1.getAxisX().getLabels().set(8,"Act. 9");

chart1.getAllSeries().setMultipleColors(true);
chart1.setGallery(Gallery.GANTT);
chart1.getAllSeries().getBorder().setEffect(BorderEffect.RAISED);
chart1.getAxisX().getGrids().getMajor().setVisible(false);
chart1.getLegendBox().setVisible(false);
chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
