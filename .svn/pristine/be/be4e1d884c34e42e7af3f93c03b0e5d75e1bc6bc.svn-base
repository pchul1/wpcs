<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Financial: High-Low-Close</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);
TextProvider txtProvider = new TextProvider();
txtProvider.open(application.getRealPath("/") + "/data/highlowclosedata.txt");
chart1.getDataSourceSettings().getFields().add(new FieldMap("date",FieldUsage.LABEL));
chart1.getDataSourceSettings().getFields().add(new FieldMap("high",FieldUsage.VALUE));
chart1.getDataSourceSettings().getFields().add(new FieldMap("low",FieldUsage.VALUE));
chart1.getDataSourceSettings().getFields().add(new FieldMap("close",FieldUsage.VALUE));
chart1.getDataSourceSettings().setDataSource(txtProvider);
txtProvider.close();

chart1.getAxisX().getLabelsFormat().setFormat(AxisFormat.DATE);

chart1.setGallery(Gallery.HIGH_LOW_CLOSE);
chart1.getSeries().get(2).setColor(new java.awt.Color(0, 0, 128));
chart1.getAxisY().setMin((short) 50);
            
chart1.getLegendBox().setVisible(false);
chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
