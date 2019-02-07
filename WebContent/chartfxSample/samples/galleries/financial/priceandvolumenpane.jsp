<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Financial: Price and Volume Pane</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);

TextProvider txtProvider = new TextProvider();
txtProvider.open(application.getRealPath("/") + "/data/financial1.txt");
chart1.getDataSourceSettings().getFields().add(new FieldMap("Field1",FieldUsage.LABEL));
chart1.getDataSourceSettings().getFields().add(new FieldMap("Field2",FieldUsage.VALUE));
chart1.getDataSourceSettings().getFields().add(new FieldMap("Field3", FieldUsage.VALUE));
chart1.getDataSourceSettings().setDataSource(txtProvider);
txtProvider.close();

chart1.getAxisX().getLabelsFormat().setFormat(AxisFormat.DATE);

SeriesAttributes series0 = chart1.getSeries().get(0);
series0.setGallery(Gallery.LINES);
series0.getLine().setWidth((short) 2);
series0.setMarkerShape(MarkerShape.NONE);
series0.setAxisY(chart1.getAxisY());

SeriesAttributes series1 = chart1.getSeries().get(1);
series1.setGallery(Gallery.AREA);
series1.getBorder().setVisible(true);

chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.CURRENCY);

chart1.recalculateScale();

Pane pane1 = chart1.getPanes().get(0);
pane1.setProportion(15);
pane1.getTitle().setText("Price");

Pane pane2 = new Pane();
pane2.setProportion(8);
pane2.getTitle().setText("Volume (in Millions)");
pane2.getAxisY().setScaleUnit(1000000);
pane2.getAxisY().getLabelsFormat().setDecimals(0);
pane2.getAxisY().setPosition(AxisPosition.NEAR);
chart1.getPanes().add(pane2);
series0.setPane(chart1.getPanes().get(0));
series1.setPane(chart1.getPanes().get(1));

chart1.getLegendBox().setVisible(false);
chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
