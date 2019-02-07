<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.galleries.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Contour: With Lines</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.setGallery(Gallery.CONTOUR);

chart1.getLegendBox().setVisible(true);
chart1.getData().setSeries(20);
chart1.getData().setPoints(20);
for(int i=0; i < 20; i++)
{
    for(int j = 0; j < 20; j++)
       chart1.getData().set(i, j, ((java.lang.Math.sin((i * 2 * 3.1416) / 19) * java.lang.Math.cos(((j + 5) * 2 * 3.1416) / 19)) * 100));
}
SeriesAttributes series = chart1.getSeries().get(0);
series.setColor(new java.awt.Color(15, 213, 239));
series.setAlternateColor(new java.awt.Color(1, 128, 1));

Surface gallery = (Surface) chart1.getGalleryAttributes();
gallery.setShowContourLines(true);

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
