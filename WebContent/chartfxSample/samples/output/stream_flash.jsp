<%@page import="com.softwarefx.chartfx.server.*"%><%@page import="com.softwarefx.chartfx.server.writer.flash.*"%><%ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.setWidth(600);
chart1.setHeight(400);
chart1.getImageSettings().setInteractive(false);
FlashWriter writer = new FlashWriter();
chart1.setOutputWriter(writer);
chart1.renderToStream();%>