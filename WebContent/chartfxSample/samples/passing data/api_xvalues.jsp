<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Passing Data: API</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.setWidth(600);
chart1.setHeight(400);

chart1.setGallery(Gallery.SCATTER);
chart1.getData().setSeries(2);
chart1.getData().setPoints(25);
java.util.Random r = new java.util.Random(1);
int j;
for (j=0;j<25;j++)
{
    chart1.getData().getX().set(0, j, r.nextInt(50));
    chart1.getData().getY().set(0, j,(r.nextDouble() * 20) + 8);
    chart1.getData().getX().set(1, j, r.nextInt(50));
    chart1.getData().getY().set(1, j,r.nextDouble() * 7);
}
chart1.getAxisY().setMax(30);
chart1.getLegendBox().setVisible(false);

chart1.renderControl();
%>        
    </body>
</html>
