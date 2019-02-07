<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Lines: Multiple Styles</title>
    </head>
    <body>
<%
            ChartServer chart1 = new ChartServer(pageContext, request, response);
            chart1.setGallery(Gallery.LINES);

            java.util.Random r = new java.util.Random(1);
            chart1.getData().setSeries(2);
            chart1.getData().setPoints(15);
            for (int j = 0; j < 15; j++) {
                chart1.getData().set(0, j, (r.nextDouble() * 60));
                chart1.getData().set(1, j, ((r.nextDouble() * 80) + 50));
            }
            chart1.setGallery(Gallery.LINES);
            chart1.getAllSeries().setMarkerShape(MarkerShape.NONE);
            chart1.getAllSeries().getLine().setWidth((short) 3);


            chart1.getSeries().get(0).getLine().setStyle(com.softwarefx.DashStyle.DOT);
            chart1.getSeries().get(1).getLine().setStyle(com.softwarefx.DashStyle.DASH);

            chart1.setWidth(600);
            chart1.setHeight(400);
            chart1.renderControl();
%>        
    </body>
</html>
