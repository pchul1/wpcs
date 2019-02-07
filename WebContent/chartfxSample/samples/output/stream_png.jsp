<%@page import="com.softwarefx.chartfx.server.*"%><%ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderToStream();%>