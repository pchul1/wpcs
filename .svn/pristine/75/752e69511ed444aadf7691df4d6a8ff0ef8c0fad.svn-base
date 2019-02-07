<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Gantt with Dates</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.getData().setSeries(1);
chart1.getData().setPoints(3);

java.util.Calendar calendar = new java.util.GregorianCalendar();
calendar.set(2008, 0, 1); 
java.util.Calendar calendarTemp = (java.util.GregorianCalendar) calendar.clone();

//Set Min and max for the Y Axis
chart1.getAxisY().setMin(Chart.dateToNumber(calendar));
calendarTemp.add(java.util.GregorianCalendar.DAY_OF_YEAR, 120);
chart1.getAxisY().setMax(Chart.dateToNumber(calendarTemp));
calendarTemp.add(java.util.GregorianCalendar.DAY_OF_YEAR, -120);

//Format the Y Axis
chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.DATE); 

// First activity: from day 0 to day 10
chart1.getData().getYFrom().set(0, 0, Chart.dateToNumber(calendar));
calendarTemp.add(java.util.GregorianCalendar.DAY_OF_YEAR, 10);
chart1.getData().set(0, 0, Chart.dateToNumber(calendarTemp));

// Second Activity: from day 30 to day 80
calendarTemp.add(java.util.GregorianCalendar.DAY_OF_YEAR, 20);
chart1.getData().getYFrom().set(0, 1, Chart.dateToNumber(calendarTemp));
calendarTemp.add(java.util.GregorianCalendar.DAY_OF_YEAR, 50);
chart1.getData().set(0, 1, Chart.dateToNumber(calendarTemp));

// Third Activity: from day 90 to day 110
calendarTemp.add(java.util.GregorianCalendar.DAY_OF_YEAR, 10);
chart1.getData().getYFrom().set(0, 2, Chart.dateToNumber(calendarTemp));
calendarTemp.add(java.util.GregorianCalendar.DAY_OF_YEAR, 20);
chart1.getData().set(0, 2, Chart.dateToNumber(calendarTemp));

chart1.getAxisX().getLabels().set(0,"Task 1");
chart1.getAxisX().getLabels().set(1,"Task 2");
chart1.getAxisX().getLabels().set(2,"Task 3");

chart1.setGallery(Gallery.GANTT);
chart1.getLegendBox().setVisible(false);
chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
