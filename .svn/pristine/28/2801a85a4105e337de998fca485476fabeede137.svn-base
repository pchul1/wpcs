<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Axis: Time Labels</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);
chart1.getLegendBox().setVisible(false);

java.util.Random r = new java.util.Random(1);
chart1.getData().setSeries(1);
chart1.getData().setPoints(28);
for(int i=0;i<28;i++) 
    chart1.getData().set(0,i, r.nextDouble()*80);

java.util.GregorianCalendar cal = new java.util.GregorianCalendar();
for(int j=0;j<28;j++) 
{
    chart1.getAxisX().getLabels().set(j, java.text.DateFormat.getTimeInstance(3).format(cal.getTime()));
    cal.add(java.util.Calendar.MINUTE,15);
}
chart1.getAxisX().setStep((short) 4);
chart1.getAxisX().setFirstLabel((short) 3);
chart1.getAxisX().setMinorStep((short) 1);

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
