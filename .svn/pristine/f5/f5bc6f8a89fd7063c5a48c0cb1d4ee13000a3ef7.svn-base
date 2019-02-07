<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Area: Zero Y Axis</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);

chart1.getData().setSeries(1);
chart1.getData().setPoints(5);

chart1.getData().set(0, 0, 25);
chart1.getData().getYFrom().set(0, 0, 0);
chart1.getData().set(0, 1, 45);
chart1.getData().getYFrom().set(0, 1, -10);
chart1.getData().set(0, 2, 80);
chart1.getData().getYFrom().set(0, 2, 15);
chart1.getData().set(0, 3, -21);
chart1.getData().getYFrom().set(0, 3, -30);
chart1.getData().set(0, 4, 70);
chart1.getData().getYFrom().set(0, 4, 10);
chart1.setGallery(Gallery.AREA);

for (int i=0;i<5;i++)
    chart1.getData().getX().set(i,i);

chart1.setWidth(600);
chart1.setHeight(400);
chart1.getLegendBox().setVisible(false);
chart1.renderControl();
%>        
    </body>
</html>
