<%@page import="com.softwarefx.chartfx.server.*"%><%@page import="com.softwarefx.chartfx.server.writer.svg.*"%><%ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.setWidth(600);
chart1.setHeight(400);
chart1.getImageSettings().setInteractive(false);
SvgWriter writer = new SvgWriter();
chart1.setOutputWriter(writer);
chart1.renderToStream();%>