<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Events: Pre Paint Marker</title>
    </head>
    <body>

<%!
public ChartServer chart1;
public class EventHandler implements PaintMarkerListener
{
    public void paintMarkerEventHandler(PaintMarkerEvent e) {
        int p = e.getPoint();
        e.setHandled(true);
        if (p == 3)
        {
            java.awt.Graphics2D g = e.getGraphics();
            g.setColor(java.awt.Color.BLACK);
            g.fill3DRect(e.getPosition().x-5, e.getPosition().y-5, 10, 10, false);
        }
    }
}
%><%chart1 = new ChartServer(application,request,response);
chart1.setGallery(Gallery.SCATTER);
java.util.EnumSet<ChartStyles> style = chart1.getExtraStyle(); 
style.add(ChartStyles.PAINT_MARKER);
chart1.setExtraStyle(style);
chart1.addPrePaintMarkerListener(new EventHandler());
//-----					 
chart1.getLegendBox().setVisible(false);
chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>