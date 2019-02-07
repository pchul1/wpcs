<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Combinations: RangeBand</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
TextProvider txtProvider = new TextProvider();
txtProvider.open(application.getRealPath("/chartfxSample") + "/data/samplecombination1.txt");
chart1.getDataSourceSettings().getFields().add(new FieldMap("Year",FieldUsage.LABEL));
chart1.getDataSourceSettings().getFields().add(new FieldMap("Low2",FieldUsage.FROM_VALUE));
chart1.getDataSourceSettings().getFields().add(new FieldMap("Industry Range",FieldUsage.VALUE));
chart1.getDataSourceSettings().getFields().add(new FieldMap("Average",FieldUsage.VALUE));
chart1.getDataSourceSettings().getFields().add(new FieldMap("Our Company", FieldUsage.VALUE));
chart1.getDataSourceSettings().setDataSource(txtProvider);
txtProvider.close();

/* ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.setWidth(600);
chart1.setHeight(400);

java.util.List list1 = new java.util.ArrayList(5);
list1.add("Desktops");
list1.add("Laptops");
list1.add("Monitor");
list1.add("Keyboard");
list1.add("Mouse");

java.util.List list2 = new java.util.ArrayList(5);
list2.add(new Integer(20));
list2.add(new Integer(30));
list2.add(new Integer(20));
list2.add(new Integer(50));
list2.add(new Integer(40));

java.util.List list3 = new java.util.ArrayList(5);
list3.add(new Integer(50));
list3.add(new Integer(40));
list3.add(new Integer(50));
list3.add(new Integer(60));
list3.add(new Integer(30));


java.util.List list4 = new java.util.ArrayList();
list4.add(list1);
list4.add(list2);
list4.add(list3);

ListProvider lstDataProvider = new ListProvider(list4);
chart1.getDataSourceSettings().setDataSource(lstDataProvider); */

//chart1.setGallery(Gallery.AREA);
chart1.getSeries().get(0).setGallery(Gallery.BAR);

SeriesAttributes series = chart1.getSeries().get(1);
//series.setGallery(Gallery.LINES);
//series.setMarkerShape(MarkerShape.NONE);
//series.getLine().setStyle(com.softwarefx.DashStyle.DASH_DOT_DOT);

//series = chart1.getSeries().get(1);
series.setGallery(Gallery.LINES);
series.setMarkerShape(MarkerShape.CIRCLE);
series.getPointLabels().setVisible(true);
series.getPointLabels().setLineAlignment(com.softwarefx.StringAlignment.FAR);

chart1.getAxisY().getLabelsFormat().setDecimals(2);
chart1.getSeries().get(0).sendToBack();

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
