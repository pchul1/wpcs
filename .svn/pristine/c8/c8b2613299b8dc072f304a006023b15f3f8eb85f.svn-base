<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.writer.svg.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Output: SVG</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.setWidth(600);
chart1.setHeight(400);
chart1.getImageSettings().setInteractive(false);
SvgWriter writer = new SvgWriter();
chart1.setOutputWriter(writer);
chart1.renderControl();
%>        
    </body>
</html>
