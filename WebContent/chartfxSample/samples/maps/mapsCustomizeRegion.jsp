<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="com.softwarefx.chartfx.server.maps.*"%>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
Map map = new Map();


map.setChart(chart1);
map.setMapSource(application.getRealPath("/chartfx70") + "/Library/Regions/WesternEurope-Countries.svg");       

chart1.setDataSource(new TextProvider(application.getRealPath("/") + "Data/mapdata/WesternEuropeData.txt"));                
chart1.getAllSeries().getPointLabels().setFont(new java.awt.Font("Courier New",java.awt.Font.PLAIN,15));
chart1.getAllSeries().getPointLabels().setVisible(true);

MapRegion mr = map.findMapRegion("Italy");
mr.getPointAttributes().setColor(java.awt.Color.red);

mr.getPointAttributes().getPointLabels().setTextColor(java.awt.Color.green);
mr.getPointAttributes().getPointLabels().setFont(new java.awt.Font("Courier New",java.awt.Font.BOLD | java.awt.Font.ITALIC,30));
map.recalculate();

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>