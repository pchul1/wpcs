<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Passing Data: from Arrays</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.setWidth(600);
chart1.setHeight(400);

int[] series1 = { 12, 15, 10 };
int[] series2 = { 20, 25, 7 };
String[] labels = { "Yes", "No", "Don't know" };
java.lang.Object[] allArrays = new java.lang.Object[3];

//Load Array of Arrays
allArrays[0] = series1;
allArrays[1] = series2;
allArrays[2] = labels;

ListProvider lstDataProvider = new ListProvider(allArrays);
chart1.getDataSourceSettings().setDataSource(lstDataProvider);

chart1.getSeries().get(0).setText("Blue");
chart1.getSeries().get(1).setText("Red");

chart1.setGallery(Gallery.BAR);

chart1.renderControl();
%>        
    </body>
</html>
