<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Events: Pre Paint</title>
    </head>
    <body>

<%!
public ChartServer chart1;
public class preEventHandler implements CustomPaintListener
{
    public void customPaintEventHandler (CustomPaintEvent e)
    {
        java.awt.Graphics2D g = e.getGraphics();
        g.setColor(java.awt.Color.BLACK);
        g.drawString("PrePaint Event", 20, 140);
        g.fill3DRect(20, 150, 100, 20, false);
    } 
}
%><%chart1 = new ChartServer(application,request,response);
chart1.addPrePaintListener(new preEventHandler());
chart1.setPlotAreaColor(java.awt.Color.WHITE);
//-----					 
chart1.getLegendBox().setVisible(false);
chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>