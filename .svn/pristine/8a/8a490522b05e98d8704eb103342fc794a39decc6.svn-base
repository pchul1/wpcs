<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Misc: Drill-Down</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);
chart1.setGallery(Gallery.BAR);
chart1.getLegendBox().setVisible(false);

TitleDockable title = new TitleDockable();
title.setAlignment(StringAlignment.CENTER);
title.setFont(new java.awt.Font("Times New Roman",java.awt.Font.BOLD,16));
title.setText("Drill Down");
title.setTextColor(new java.awt.Color(0,0,0));
chart1.getTitles().add(title);

title = new TitleDockable();
title.setText("Click on any series bar to drill-down");
chart1.getTitles().add(title);

chart1.getData().setSeries(2);
chart1.getData().setPoints(5);

chart1.getData().set(0, 0,  70.00);
chart1.getData().set(1, 0,  77.00);
chart1.getData().set(0, 1,  53.34);
chart1.getData().set(1, 1,  45);
chart1.getData().set(0, 2,  57.95);
chart1.getData().set(1, 2,  55.07);
chart1.getData().set(0, 3,  28.96);
chart1.getData().set(1, 3,  81.45);
chart1.getData().set(0, 4,  30.19);
chart1.getData().set(1, 4,  60.9);

chart1.getAxisX().getLabels().set(0,  "Jan");
chart1.getAxisX().getLabels().set(1,  "Feb");
chart1.getAxisX().getLabels().set(2,  "Mar");
chart1.getAxisX().getLabels().set(3,  "Apr");
chart1.getAxisX().getLabels().set(4,  "May");

chart1.getPoints().get(0, 0).setText("Tag string 1");
chart1.getPoints().get(0, 1).setText("Tag string 2");
chart1.getPoints().get(0, 2).setText("Tag string 3");
chart1.getPoints().get(0, 3).setText("Tag string 4");
chart1.getPoints().get(0, 4).setText("Tag string 5");

chart1.getPoints().get(1, 0).setText("Tag string 6");
chart1.getPoints().get(1, 1).setText("Tag string 7");
chart1.getPoints().get(1, 2).setText("Tag string 8");
chart1.getPoints().get(1, 3).setText("Tag string 9");
chart1.getPoints().get(1, 4).setText("Tag string 10");

chart1.setToolTipFormat("Series: %S, Value: %v");
chart1.getAllSeries().getLink().setUrl("drilldownto.jsp?MyParam=1&Series Index=%S&Points Index=%N&Value=%v&Label=%l&Tag String=%L");

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
