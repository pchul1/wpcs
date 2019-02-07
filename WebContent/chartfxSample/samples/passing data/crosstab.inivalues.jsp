<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%-- 
    Document   : crosstab.inivalues
    Created on : Mar 18, 2008, 2:52:49 PM
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
        String accessDBURLPrefix = "jdbc:odbc:Driver={Microsoft Access Driver (*.mdb)};DBQ=";
        String accessDBURLSuffix = ";DriverID=22;READONLY=false}";
        String accessDBFilename = application.getRealPath("/") + "/data/Samples.mdb";
        String databaseURL = accessDBURLPrefix + accessDBFilename + accessDBURLSuffix;

        java.sql.ResultSet rs = null;
        java.sql.Connection conn = null;
        Class.forName("sun.jdbc.odbc.JdbcOdbcDriver");
        conn = java.sql.DriverManager.getConnection(databaseURL, "", "");
        String query = "SELECT * from ProductSales";
        java.sql.Statement stmt = conn.createStatement(java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,java.sql.ResultSet.CONCUR_READ_ONLY);
        rs = stmt.executeQuery(query);

        com.softwarefx.chartfx.server.dataproviders.JDBCDataProvider provider = 
	new com.softwarefx.chartfx.server.dataproviders.JDBCDataProvider(rs);
        chart1.getDataSourceSettings().getFields().add(new FieldMap("InitialSales", FieldUsage.FROM_VALUE));
        chart1.getDataSourceSettings().getFields().add(new FieldMap("Sales", FieldUsage.VALUE));
        chart1.getDataSourceSettings().getFields().add(new FieldMap("Product", FieldUsage.LABEL));
        chart1.getDataSourceSettings().setDataSource(provider);
        conn.close();
        chart1.setGallery(Gallery.GANTT);
        chart1.setWidth(600);
        chart1.setHeight(400);
       chart1.renderControl();
        %>
    </body>
</html>
