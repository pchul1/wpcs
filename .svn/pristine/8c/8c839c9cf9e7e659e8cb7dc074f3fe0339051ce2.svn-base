<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Area: Clustered 3D</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);

chart1.setGallery(Gallery.AREA);
chart1.getAllSeries().setMarkerShape(MarkerShape.NONE);
chart1.getAllSeries().setVolume((short)90); 
chart1.getView3D().setEnabled(true);
chart1.getView3D().setDepth(120);
chart1.getView3D().setAngleX(50);
chart1.getView3D().setAngleY(245);

chart1.getData().setSeries(4);
chart1.getData().setPoints(4);

chart1.getData().set(0, 0, 8.605);
chart1.getData().set(0, 1, 9.866);
chart1.getData().set(0, 2, 6.027);
chart1.getData().set(0, 3, 7.543);

chart1.getData().set(1, 0, 4.726);
chart1.getData().set(1, 1, 5.8921);
chart1.getData().set(1, 2, 3.199);
chart1.getData().set(1, 3, 7.382);

chart1.getData().set(2, 0, 6.772);
chart1.getData().set(2, 1, 8.885);
chart1.getData().set(2, 2, 3.056);
chart1.getData().set(2, 3, 6.332);

chart1.getData().set(3, 0, 1.802);
chart1.getData().set(3, 1, 9.012);
chart1.getData().set(3, 2, 2.982);
chart1.getData().set(3, 3, 7.532);

chart1.getSeries().get(0).setText("Jan");
chart1.getSeries().get(1).setText("Feb");
chart1.getSeries().get(2).setText("Mar");
chart1.getSeries().get(3).setText("Apr");

chart1.setWidth(600);
chart1.setHeight(400);
chart1.getLegendBox().setVisible(false);
chart1.renderControl();
%>        
    </body>
</html>
