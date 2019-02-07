<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.galleries.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Bubble: Maximun Bubble Size</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.setGallery(Gallery.BUBBLE);
chart1.getLegendBox().setVisible(false);

chart1.getData().setSeries(2);
chart1.getData().setPoints(4);
chart1.getData().set(0, 0, 70.55);
chart1.getData().set(1, 0, 77.47);
chart1.getData().set(0, 1, 53.34);
chart1.getData().set(1, 1, 45);
chart1.getData().set(0, 2, 57.95);
chart1.getData().set(1, 2, 55.07);
chart1.getData().set(0, 3, 28.96);
chart1.getData().set(1, 3, 81.45);
chart1.getData().set(0, 4,30.19);
chart1.getData().set(1, 4,60.9);
chart1.setGallery(Gallery.BUBBLE);
Bubble gallery = (Bubble) chart1.getGalleryAttributes();
gallery.setMaximumBubbleSize(50);

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
