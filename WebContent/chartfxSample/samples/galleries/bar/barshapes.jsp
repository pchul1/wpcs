<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Output: Default (DHTML)</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.getLegendBox().setVisible(false);
chart1.setWidth(400);
chart1.setHeight(240);
chart1.getData().setSeries(1);
chart1.getData().setPoints(5);
chart1.setGallery(Gallery.BAR);
chart1.setToolTips(false);
chart1.getImageSettings().setToolTips(ImageToolTipStyle.NONE);
chart1.getImageSettings().setInteractive(false);
TitleDockable t = new TitleDockable();
chart1.getTitles().add(t);

for (BarShape b : BarShape.values())
{
    t.setText(b.name());
    chart1.getAllSeries().setBarShape(b);
    chart1.renderControl();
	out.println("&nbsp;");
}
%>        
    </body>
</html>
