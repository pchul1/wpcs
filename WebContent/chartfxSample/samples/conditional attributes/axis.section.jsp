<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : axis.section
    Created on : Mar 17, 2008, 10:23:57 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Conditional Attributes: Axis Section</title>
    </head>
    <body>
              <% 
    ChartServer chart1 = new ChartServer(pageContext, request, response);
    chart1.getLegendBox().setVisible(false);
    chart1.getData().setSeries(1);
    chart1.getData().setPoints(24);
    java.util.Random r = new java.util.Random(1);
    for (int i=0;i<24;i++)
    chart1.getData().set(0, i,r.nextDouble() * 100);

    chart1.setGallery(Gallery.SCATTER);
    chart1.setPalette("Nature.Sky");
    chart1.getAxisX().getGrids().getMajor().setVisible(false);
    chart1.getAxisY().getGrids().getMajor().setVisible(false);

    // Customizing first section
    AxisSection section1 = new AxisSection();
    section1.setFrom(4);
    section1.setTo(10);
    java.util.EnumSet<com.softwarefx.FontStyle> style = section1.getFontStyle();
    style.add(com.softwarefx.FontStyle.BOLD);
    style.add(com.softwarefx.FontStyle.ITALIC);
    section1.setFontStyle(style);
    section1.getGrids().getMajor().setVisible(true);
    section1.setTextColor(new java.awt.Color(138,43,226));
    section1.setBackColor(new java.awt.Color(138,43,226,32));
    section1.getGrids().getMajor().setStyle(com.softwarefx.DashStyle.DASH_DOT);
    chart1.getAxisX().getSections().add(section1);

    // Customizing second section
    AxisSection section2 = new AxisSection();
    section2.setFrom(14);
    section2.setTo(22);
    section2.setFontStyle(style);
    section2.getGrids().getMajor().setVisible(true);
    section2.setTextColor(java.awt.Color.red);
    section2.setBackColor(new java.awt.Color(255,0,0,32));
    section2.getGrids().getMajor().setColor(section2.getTextColor());
    section2.getGrids().getMajor().setWidth(2);
    chart1.getAxisX().getSections().add(section2);
    chart1.setWidth(600);
    chart1.setHeight(400);
    chart1.renderControl();  
    %>
    </body>
</html>
