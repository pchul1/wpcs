<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Events: Axis Label Event</title>
    </head>
    <body>

<%!
public ChartServer chart1;
public class EventHandler implements com.softwarefx.chartfx.server.AxisLabelListener
{
    public void axisLabelEventHandler (AxisLabelEvent e)
	  { 
                if (e.getText().indexOf("80") != -1)
                {                    
                    e.setText("Control Point");
                }
	  } 
}
%>
<%
chart1 = new ChartServer(application,request,response);
chart1.getAxisY().setStep(10);
chart1.getAxisY().getLabelsFormat().setDecimals(0);
chart1.getAxisY().setNotify(true);
chart1.addGetAxisLabelListener(new EventHandler());
chart1.getPlotAreaMargin().setLeft(75);
chart1.getLegendBox().setVisible(false);
chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>