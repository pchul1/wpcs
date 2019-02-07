<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Passing Data: JDBC</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.setWidth(600);
chart1.setHeight(400);

java.sql.ResultSet rs = null;
java.sql.Connection conn = null;
String query = "";

try {
    Class.forName("org.hsqldb.jdbcDriver");
    String database = "jdbc:hsqldb:file:" + application.getRealPath("/") + "/data/sampledb/sampledb";
    conn = java.sql.DriverManager.getConnection(database ,"SA","");
    java.sql.Statement stmt = conn.createStatement();
    query = "SELECT * FROM SampleFinancial";
    rs = stmt.executeQuery(query);
} 
catch (Exception e) {
    out.println(e.getMessage());
}
/*
while(rs.next())
{
    out.println(rs.getDate(1) + " - " + rs.getInt(2) + " - " + rs.getInt(3) + "<br/>" );		
}
conn.close(); 
*/
JDBCDataProvider provider = new JDBCDataProvider(rs);
chart1.getDataSourceSettings().getFields().add(new FieldMap("Field1",FieldUsage.LABEL));
chart1.getDataSourceSettings().getFields().add(new FieldMap("Field2",FieldUsage.VALUE));
chart1.getDataSourceSettings().getFields().add(new FieldMap("Field3", FieldUsage.VALUE));
chart1.getDataSourceSettings().setDataSource(provider);

chart1.getAxisX().getLabelsFormat().setFormat(AxisFormat.DATE); 

SeriesAttributes series0 = chart1.getSeries().get(0);
series0.setGallery(Gallery.LINES); 
series0.getLine().setWidth((short) 2);
series0.setMarkerShape(MarkerShape.NONE); 
series0.setAxisY(chart1.getAxisY());

SeriesAttributes series1 = chart1.getSeries().get(1);
series1.setGallery(Gallery.AREA); 
series1.getBorder().setVisible(true);
series1.setAxisY(chart1.getAxisY2());

chart1.getAxisY().getGrids().getMajor().setVisible(true);
Axis axis = chart1.getAxisY2();
axis.setMax(200000000);
axis.setMin(0);
axis.setVisible(false);
chart1.getPlotAreaMargin().setRight(30);

chart1.recalculateScale();

chart1.getSeries().get(0).setText("Price");
chart1.getSeries().get(1).setText("Volume");


chart1.renderControl();
%>        
    </body>
</html>
