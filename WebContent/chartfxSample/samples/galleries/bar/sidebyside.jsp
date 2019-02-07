<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Bar: Side by Side</title>
    </head>
    <body>
<%ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.getLegendBox().setVisible(false);
chart1.getData().setSeries(1);
chart1.getData().setPoints(3);
java.util.Random r = new java.util.Random(1);
for (int i=0;i<3;i++)
    for (int j=0;j<3;j++)
        chart1.getData().set(i, j, r.nextDouble()* 100);
chart1.setGallery(Gallery.BAR);
chart1.getAllSeries().getBorder().setVisible(true);
chart1.getAllSeries().getBorder().setEffect(BorderEffect.RAISED);
chart1.setAxesStyle(AxesStyle.MATH);

chart1.setWidth(600);
chart1.setHeight(400);
chart1.getLegendBox().setVisible(false);
chart1.renderControl();
%>        
    </body>
</html>
