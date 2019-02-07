<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Gantt: Horinzontal Bars</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.getData().setSeries(2);
chart1.getData().setPoints(6);
java.util.Random r = new java.util.Random(1);
for (int i=0;i<2;i++)
    for (int j=0;j<6;j++)
        {
             chart1.getData().set(i, j, r.nextDouble()  * 100);
             chart1.getAxisX().getLabels().set(j,"Prod " + j);
        }
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
