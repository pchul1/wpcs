<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Axis: Vertical Labels</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);
chart1.getLegendBox().setVisible(false);
chart1.getData().setSeries(1);
chart1.getData().setPoints(12);
java.util.Random r = new java.util.Random(1);
for (int i=0;i<12;i++)
    chart1.getData().set(0, i, r.nextDouble()* 80);

chart1.getAxisX().getLabels().set(0, "January");
chart1.getAxisX().getLabels().set(1, "February");
chart1.getAxisX().getLabels().set(2, "March");
chart1.getAxisX().getLabels().set(3, "April");
chart1.getAxisX().getLabels().set(4, "May");
chart1.getAxisX().getLabels().set(5, "June");
chart1.getAxisX().getLabels().set(6, "July");
chart1.getAxisX().getLabels().set(7, "August");
chart1.getAxisX().getLabels().set(8, "September");
chart1.getAxisX().getLabels().set(9, "October");
chart1.getAxisX().getLabels().set(10, "November");
chart1.getAxisX().getLabels().set(11, "December");

chart1.getAxisX().setLabelAngle((short) 90);
chart1.setGallery(Gallery.AREA);

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
