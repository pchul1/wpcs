<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Area: Stacked 3D</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);

chart1.getData().setSeries(2);
chart1.getData().setPoints(8);
java.util.Random r = new java.util.Random(1);
for (int i = 0 ;i<=1;i++)
	for (int j = 0;j<=7;j++)
		chart1.getData().set(i, j, r.nextDouble() * 100);
chart1.getView3D().setEnabled(true);
chart1.getAllSeries().setStacked(Stacked.STACKED_100);;
chart1.setGallery(Gallery.AREA);
chart1.getLegendBox().setVisible(false);

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
