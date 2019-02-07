<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Passing Data: from XML File</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.setWidth(600);
chart1.setHeight(400);

XmlDataProvider cfxXML = new XmlDataProvider();
cfxXML.load(application.getRealPath("/") + "/data/ProductSales.xml");
chart1.getDataSourceSettings().getFields().add(new FieldMap("ProductB", FieldUsage.FROM_VALUE));
chart1.getDataSourceSettings().getFields().add(new FieldMap("ProductC", FieldUsage.VALUE));
chart1.getDataSourceSettings().setDataSource(cfxXML);
chart1.setGallery(Gallery.BAR);
chart1.getLegendBox().setVisible(false);

chart1.renderControl();
%>        
    </body>
</html>
