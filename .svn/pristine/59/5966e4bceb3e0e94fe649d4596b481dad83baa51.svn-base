<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Events: Point Label</title>
    </head>
    <body>

<%!
public ChartServer chart1;
public class EventHandler implements PointLabelListener {
    public  void pointLabelEventHandler(PointLabelEvent e) {
        double value1 = chart1.getData().getY().get(0,e.getPoint());
        if (value1 > 90)
            e.setText("High");
        else
            e.setText("Low");
    }
}
%><%chart1 = new ChartServer(application,request,response);
chart1.setGallery(Gallery.SCATTER);
chart1.getAllSeries().getPointLabels().setVisible(true);
chart1.getData().setSeries(1);
chart1.getData().setPoints(20);
chart1.getAxisY().setNotify(true);
chart1.addGetPointLabelListener(new EventHandler());
//-----					 
chart1.getLegendBox().setVisible(false);
chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>