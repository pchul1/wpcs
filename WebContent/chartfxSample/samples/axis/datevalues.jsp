<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Axis: Date Labels</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);
chart1.getLegendBox().setVisible(false);

TextProvider txtProvider = new TextProvider();
txtProvider.open(application.getRealPath("/") + "/data/demosales.txt");
chart1.getDataSourceSettings().getFields().add(new FieldMap("Sales",FieldUsage.VALUE));
chart1.getDataSourceSettings().getFields().add(new FieldMap("Projected", FieldUsage.VALUE));
chart1.getDataSourceSettings().getFields().add(new FieldMap("ClosingDate",FieldUsage.XVALUE));
txtProvider.setDateFormat("M/d/yyyy h:mm:s tt");
chart1.getDataSourceSettings().setDataSource(txtProvider);
txtProvider.close();

chart1.getAxisX().getLabelsFormat().setFormat(AxisFormat.DATE_TIME);
chart1.getAxisX().getLabelsFormat().setCustomFormat("MMM-dd-yy");
    
chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
