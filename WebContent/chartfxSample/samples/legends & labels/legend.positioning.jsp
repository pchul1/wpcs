<%@page import="com.softwarefx.chartfx.server.*"%>

<%-- 
    Document   : legend.positioning
    Created on : Mar 14, 2008, 10:33:48 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Legend: Positioning</title>
    </head>
    <body>
        <% 
          ChartServer chart1 = new ChartServer(pageContext, request, response);
           chart1.getSeries().get(0).setText("Product A");
           chart1.getSeries().get(1).setText("Product B");
           chart1.getSeries().get(2).setText("Product C");
           chart1.getLegendBox().setVisible(true);
           chart1.getLegendBox().setBorder(DockBorder.EXTERNAL);
           chart1.getLegendBox().setDock(DockArea.BOTTOM);
           chart1.getLegendBox().setContentLayout(ContentLayout.SPREAD);
           chart1.setWidth(600);
           chart1.setHeight(400);
           chart1.renderControl();
        
        
        %>
    </body>
</html>
