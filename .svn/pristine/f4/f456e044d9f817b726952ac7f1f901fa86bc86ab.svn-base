<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Bar: Oblique</title>
    </head>
    <body>
<%ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.getLegendBox().setVisible(false);
chart1.getData().setSeries(6);
chart1.getData().setPoints(7);
java.util.Random r = new java.util.Random(1);
for (int i=0;i<6;i++)
    for (int j=0;j<7;j++)
        chart1.getData().set(i, j, r.nextDouble() * 20);

chart1.setGallery(Gallery.BAR);
chart1.getView3D().setEnabled(true);
chart1.getView3D().setAngleX((short) 45);
chart1.getView3D().setAngleY((short) 45);
chart1.getView3D().setPerspective((short) 60);
chart1.getView3D().setCluster(true);

chart1.getSeries().get(0).setText("2002");
chart1.getSeries().get(1).setText("2003");
chart1.getSeries().get(2).setText("2004");
chart1.getSeries().get(3).setText("2005");
chart1.getSeries().get(4).setText("2006");
chart1.getSeries().get(5).setText("2007");

chart1.setWidth(600);
chart1.setHeight(400);
chart1.getLegendBox().setVisible(false);
chart1.renderControl();
%>        
    </body>
</html>
