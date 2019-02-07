<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Visual Attributes: Image Borders</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.getLegendBox().setVisible(false);
chart1.setWidth(400);
chart1.setHeight(240);
chart1.setToolTips(false);
chart1.getImageSettings().setToolTips(ImageToolTipStyle.NONE);
chart1.getImageSettings().setInteractive(false);
TitleDockable t = new TitleDockable();
chart1.getTitles().add(t);

for (GradientType g : GradientType.values())
{
    try {
        t.setText(g.name());
        chart1.setBackground(new GradientBackground(g));
        chart1.updateSizeNow();
        chart1.renderControl();
        out.println("&nbsp;");
    }
    catch (Exception e) {
        out.println(g.name() + " FAILED!");
    }
}

%>        
    </body>
</html>
