<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Lines: Strip 3D</title>
    </head>
    <body>
<%
            ChartServer chart1 = new ChartServer(pageContext, request, response);
            chart1.setGallery(Gallery.LINES);
            
            chart1.getAllSeries().setMarkerShape(MarkerShape.NONE);
            chart1.getView3D().setEnabled(true);
            chart1.getView3D().setDepth((short)120);
            chart1.getView3D().setAngleX((short) 45);
            chart1.getView3D().setAngleY((short) 125);
            chart1.getView3D().setBoxThickness((short) 2);
            chart1.getView3D().setCluster(true);

            chart1.setWidth(600);
            chart1.setHeight(400);
            chart1.renderControl();
%>        
    </body>
</html>
