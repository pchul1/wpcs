<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="com.softwarefx.chartfx.server.maps.*"%>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
Map map = new Map();


map.setChart(chart1);
map.setMapSource(application.getRealPath("/") + "/chartfx70/Library/Regions/WesternEurope-Countries.svg");



chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>