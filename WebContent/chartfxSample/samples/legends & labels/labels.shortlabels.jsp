<%@page import="com.softwarefx.chartfx.server.*"%>
<%-- 
    Document   : labels.shortlabels
    Created on : Mar 14, 2008, 11:44:28 AM
    Author     : Administrator
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Labels: Short Labels</title>
    </head>
    <body>
       <%
       ChartServer chart1 = new ChartServer(pageContext, request, response);
       
      
        chart1.getData().setSeries(2);
        chart1.getData().setPoints(3);
        for (int i = 0; i < 3; i++)
    {
           chart1.getData().set(0, i, 10 + (i * 10));
           chart1.getData().set(1, i, 5 + (i * 20));
    }


    chart1.getAxisX().getLabels().set(0,"January");
    chart1.getAxisX().getLabels().set(1,"February");
    chart1.getAxisX().getLabels().set(2,"March");

    chart1.getAxisX().getKeyLabels().set(0,"Jan");
    chart1.getAxisX().getKeyLabels().set(1,"Feb");
    chart1.getAxisX().getKeyLabels().set(2,"Mar");

    chart1.getLegendBox().setVisible(true);
    LegendItemAttributes item = new LegendItemAttributes();
    item.setVisible(false);
    chart1.getLegendBox().getItemAttributes().set(chart1.getSeries(),item); 
    chart1.setWidth(600);
    chart1.setHeight(400);
    chart1.renderControl();
       %>
       
    </body>
</html>
