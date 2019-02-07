<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Events: Conditional Attributes</title>
    </head>
    <body>

<%!
public ChartServer chart1;
public class EventHandler implements ConditionalAttributesListener
{
    public  void conditionalAttributesEventHandler (ConditionalAttributesEvent e)
    {
        double value1 = chart1.getData().getY().get(0,e.getPoint());

        if (value1 > 90)
            e.setAttributes(0);
        else
            e.setAttributes(1);
    } 
}
%><%chart1 = new ChartServer(application,request,response);

chart1.setGallery(Gallery.SCATTER);
chart1.getData().setSeries(1);
chart1.getData().setPoints(20);

ConditionalAttributes condition1 = new ConditionalAttributes();
condition1.setColor(java.awt.Color.YELLOW);
chart1.getConditionalAttributes().add(condition1);

ConditionalAttributes condition2 = new ConditionalAttributes();
condition2.setColor(java.awt.Color.MAGENTA);
chart1.getConditionalAttributes().add(condition2);
chart1.addConditionalAttributesCallbackListener(new EventHandler());

chart1.getAxisY().setForceZero(false);
chart1.updateSizeNow();
//-----					 
chart1.getLegendBox().setVisible(false);
chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>