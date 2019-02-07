<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Axis: Color</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);
chart1.getLegendBox().setVisible(false);

chart1.getData().setSeries(1);
chart1.getData().setPoints(5);

String newLine;
chart1.getAxisX().setStep((short) 1);
newLine = "\n";
chart1.updateSizeNow();
chart1.setGallery(Gallery.BAR);
chart1.getAxisX().getLabels().set(0,"January" + newLine + "2007");
chart1.getAxisX().getLabels().set(1, "July" + newLine + "2007");
chart1.getAxisX().getLabels().set(2, "December" + newLine + "2007");
chart1.getAxisX().getLabels().set(3, "January" + newLine + "2008");
chart1.getAxisX().getLabels().set(4, "July" + newLine + "2008");

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
