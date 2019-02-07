<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Axis: Date to Number</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);
chart1.getLegendBox().setVisible(false);

chart1.getData().setSeries(1);
chart1.getData().setPoints(10);
java.util.Calendar cal = new java.util.GregorianCalendar();

chart1.getAxisX().getLabelsFormat().setFormat(AxisFormat.LONG_DATE);
chart1.getAxisX().getLabelsFormat().setCustomFormat("MM - yyyy");
chart1.getAxisX().setLabelAngle((short) 90);

for(int i=1; i<=11; i++) 
{
    chart1.getData().set(0,i-1,i);
    chart1.getData().getX().set(0,i-1,Chart.dateToNumber(cal.getTime()));
    cal.add(java.util.GregorianCalendar.DAY_OF_YEAR, i);
}

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
