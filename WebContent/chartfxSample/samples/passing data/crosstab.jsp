<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%-- 
    Document   : crosstab
    Created on : Mar 18, 2008, 9:16:10 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
        ChartServer chart1 = new ChartServer(pageContext,request,response);
        chart1.importChart(FileFormat.XML, application.getRealPath("/") + "/data/samples.cfx");
        TextProvider txtProvider = new TextProvider();

        txtProvider.open(application.getRealPath("/") + "/data/Crosstab.txt");
        //chart1.getDataSourceSettings().setDataSource(txtProvider);
        chart1.getDataSourceSettings().getFields().add(new FieldMap("Product", FieldUsage.COLUMN_HEADING));
        chart1.getDataSourceSettings().getFields().add(new FieldMap("SalesQuarter", FieldUsage.ROW_HEADING));
        chart1.getDataSourceSettings().getFields().add(new FieldMap("Sales", FieldUsage.VALUE));

       // chart1.getDataSourceSettings().setDataSource(txtProvider);
        
        CrosstabDataProvider cfxCT = new CrosstabDataProvider();
       // cfxCT.setSeparator("-");
        
        cfxCT.setDataSource(txtProvider);
        
        chart1.setDataSource(cfxCT);
        txtProvider.close();
        chart1.setGallery(Gallery.BAR);

        chart1.setWidth(600);
        chart1.setHeight(400);
        chart1.renderControl();
//com.softwarefx.chartfx.server.dataproviders.CrosstabDataProvider cfxCT = new com.softwarefx.chartfx.server.dataproviders.CrosstabDataProvider();
%>
    </body>
</html>
