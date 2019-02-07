<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Curve: Strip 3D</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.setGallery(Gallery.CURVE);
chart1.getAllSeries().setMarkerShape(MarkerShape.NONE);

chart1.getView3D().setEnabled(true);
chart1.getView3D().setDepth((short)200);
chart1.getView3D().setAngleX((short) 30);
chart1.getView3D().setAngleY((short) 30);
chart1.getView3D().setBoxThickness((short) 5);
chart1.getView3D().setCluster(false);

chart1.getAxisX().getLabels().set(0, "Jan");
chart1.getAxisX().getLabels().set(1, "Feb");
chart1.getAxisX().getLabels().set(2, "Mar");
chart1.getAxisX().getLabels().set(3, "Apr");
chart1.getAxisX().getLabels().set(4, "May");
chart1.getAxisX().getLabels().set(5, "Jun");
chart1.getAxisX().getLabels().set(6, "Jul");
chart1.getAxisX().getLabels().set(7, "Aug");
chart1.getAxisX().getLabels().set(8, "Sep");
chart1.getAxisX().getLabels().set(9, "Oct");
chart1.getAxisX().getLabels().set(10, "Nov");
chart1.getAxisX().getLabels().set(11, "Dec");

chart1.getLegendBox().setVisible(false);

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
