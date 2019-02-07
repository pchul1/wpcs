<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : header.footer
    Created on : Mar 17, 2008, 9:47:07 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Titles: Header & Footer</title>
    </head>
    <body>
    <%
         ChartServer chart1 = new ChartServer(pageContext, request, response);
         chart1.getLegendBox().setVisible(false);
         chart1.getData().setSeries(1);
         chart1.getData().setPoints(6);
         chart1.getData().set(0,0, 41);
         chart1.getData().set(0,1, 44);
         chart1.getData().set(0,2, 34);
         chart1.getData().set(0,3, 24);
         chart1.getData().set(0,4, 17);
         chart1.getData().set(0,5, 23);

    
        TitleDockable title = new TitleDockable();
        title.setAlignment(com.softwarefx.StringAlignment.CENTER);
        title.setFont(new java.awt.Font("Times New Roman",java.awt.Font.BOLD,16));
        title.setText("PRODUCT SALES CHART");
        title.setTextColor(new java.awt.Color(165, 42, 42));
        chart1.getTitles().add(title);

        title = new TitleDockable();
        title.setAlignment(com.softwarefx.StringAlignment.CENTER);
        title.setFont(new java.awt.Font("Times New Roman",java.awt.Font.BOLD,12));
        title.setText("By Region. Second Quarter 2002");
        title.setTextColor(new java.awt.Color(0, 0, 0));
        chart1.getTitles().add(title);

        title = new TitleDockable();
        title.setAlignment(com.softwarefx.StringAlignment.FAR);
        title.setFont(new java.awt.Font("Times New Roman",java.awt.Font.ITALIC,12));
        title.setText("Chart created by John Doe");
        title.setTextColor(new java.awt.Color(0, 0, 0));
        title.setDock(DockArea.BOTTOM);
        title.setIndentation(10);
        chart1.getTitles().add(title);



         chart1.setGallery(Gallery.DOUGHNUT);
         chart1.getAllSeries().getPointLabels().setVisible(true);
         chart1.getView3D().setEnabled(true);
         chart1.setWidth(600);
         chart1.setHeight(400);
         chart1.renderControl();  
    
    
    %>
    </body>
</html>
