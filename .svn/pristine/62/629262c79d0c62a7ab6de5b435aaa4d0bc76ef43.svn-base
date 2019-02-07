<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Bar: Thin Columns</title>
    </head>
    <body>
<%ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.getLegendBox().setVisible(false);
chart1.getView3D().setEnabled(true);
chart1.getView3D().setBoxThickness(8);
chart1.getView3D().setAngleX(25);
chart1.getView3D().setAngleY(35);
chart1.getView3D().setCluster(true);
chart1.getView3D().setPerspective(50);
chart1.getAllSeries().setVolume((short)30);
chart1.setGallery(Gallery.BAR);

chart1.getData().setSeries(5);
chart1.getData().setPoints(7);
chart1.getData().set(0, 0, 87556);
chart1.getData().set(0, 1, 142533);
chart1.getData().set(0, 2, 189027);
chart1.getData().set(0, 3, 221822);
chart1.getData().set(0, 4, 281009);
chart1.getData().set(0, 5, 208912);
chart1.getData().set(0, 6, 296235);
chart1.getData().set(1, 0, 92382);
chart1.getData().set(1, 1, 78234);
chart1.getData().set(1, 2, 107775);
chart1.getData().set(1, 3, 105334);
chart1.getData().set(1, 4, 115269);
chart1.getData().set(1, 5, 72265);
chart1.getData().set(1, 6, 122819);
chart1.getData().set(2, 0, 47392);
chart1.getData().set(2, 1, 49882);
chart1.getData().set(2, 2, 51322);
chart1.getData().set(2, 3, 47362);
chart1.getData().set(2, 4, 44657);
chart1.getData().set(2, 5, 49011);
chart1.getData().set(2, 6, 52773);
chart1.getData().set(3, 0, 108920);
chart1.getData().set(3, 1, 126810);
chart1.getData().set(3, 2, 72119);
chart1.getData().set(3, 3, 61922);
chart1.getData().set(3, 4, 143892);
chart1.getData().set(3, 5, 182934);
chart1.getData().set(3, 6, 100253);
chart1.getData().set(4, 0, 45291);
chart1.getData().set(4, 1, 69905);
chart1.getData().set(4, 2, 37662);
chart1.getData().set(4, 3, 32850);
chart1.getData().set(4, 4, 6453);
chart1.getData().set(4, 5, 27819);
chart1.getData().set(4, 6, 38994);

chart1.getPoints().get(6).setVolume((short) 90);
chart1.setWidth(600);
chart1.setHeight(400);
chart1.getLegendBox().setVisible(false);
chart1.renderControl();
%>        
    </body>
</html>