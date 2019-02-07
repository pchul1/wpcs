<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.galleries.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Radar</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);
chart1.setGallery(Gallery.RADAR);
chart1.getData().setSeries(2);
chart1.getData().setPoints(5);
chart1.getData().set(0, 0, 55);
chart1.getData().set(0, 1, 75);
chart1.getData().set(0, 2, 48);
chart1.getData().set(0, 3, 97);
chart1.getData().set(0, 4, 90);
chart1.getData().set(1, 0, 20);
chart1.getData().set(1, 1, 21);
chart1.getData().set(1, 2, 39);
chart1.getData().set(1, 3, 79);
chart1.getData().set(1, 4, 15);

chart1.getLegendBox().setVisible(false);
        
chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
