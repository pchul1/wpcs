<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : labels.datadriven
    Created on : Mar 14, 2008, 1:53:39 PM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Labels: Datadriven</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);
java.util.Calendar cal = new java.util.GregorianCalendar();
cal.set(2007,0,1);

int nDays = 365; //912; // 2 and half years
int j;

java.util.Random r = new java.util.Random(1);
chart1.getData().setSeries(1);
chart1.getData().setPoints(nDays);
for (j=0;j<nDays;j++)
{
    chart1.getData().getY().set(0, j, r.nextDouble() * 100);
    chart1.getData().getX().set(0, j, chart1.dateToNumber(cal));
    cal.add(java.util.Calendar.DATE,1);
}
chart1.getAllSeries().setMarkerShape(MarkerShape.NONE);
chart1.getLegendBox().setVisible(false);
chart1.getAxisX().setLabelAngle((short) 90);
chart1.getAxisX().getLabelsFormat().setFormat(AxisFormat.DATE);
chart1.setToolTips(false);
chart1.getImageSettings().setToolTips(ImageToolTipStyle.NONE);
chart1.getImageSettings().setInteractive(false);

chart1.setWidth(200);
chart1.setHeight(250);
chart1.renderControl();
out.println("&nbsp;");

chart1.setWidth(300);
chart1.setHeight(250);
chart1.renderControl();
out.println("&nbsp;");

chart1.setWidth(400);
chart1.setHeight(250);
chart1.renderControl();
%>
    </body>
</html>
