<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<html>
    <head>
        <title>Title</title>
    </head>
<body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.setWidth(600);
chart1.setHeight(400);
chart1.getImageSettings().setInteractive(false);
            
java.io.ByteArrayOutputStream imgMapStream = new java.io.ByteArrayOutputStream();
java.io.OutputStreamWriter imgMap = new java.io.OutputStreamWriter(imgMapStream);

java.io.ByteArrayOutputStream  htmlTagStream = new java.io.ByteArrayOutputStream();
java.io.OutputStreamWriter htmlTag = new java.io.OutputStreamWriter(htmlTagStream);

String myChartName = "/chartfx70/temp/streamchart.png";
java.io.FileOutputStream contentStream = new java.io.FileOutputStream(application.getRealPath("/") + myChartName);

chart1.setID("chart1");

chart1.renderToStream(contentStream, imgMap, htmlTag);

htmlTag.flush();
imgMap.flush();
String sMap = imgMapStream.toString();
String sTag = htmlTagStream.toString();

// The image tag will look like this:
// <img id="chart1" src=""  WIDTH="600" HEIGHT="400"  usemap="#chart1Map" border="0"/>

// Replace the Image Source (src="") with the name and path of the image
String NewImgTag = sTag.replaceAll("src=\"\"", "src=\"/" + application.getServletContextName() + "/" + myChartName + "\"");

// Send Image Maps to output
out.println(sMap);
// send Image Tag to output
out.println(NewImgTag);
%>
</body>
</html>