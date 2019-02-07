<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Visual Attributes: Color Palettes and Schemes</title>
    </head>
    <body>
<%

java.util.List palettes = new java.util.ArrayList(24);
palettes.add("ChartFX6.Alternate");
palettes.add("ChartFX6.ChartFX6");
palettes.add("ChartFX6.EarthTones");
palettes.add("ChartFX6.ModernBusiness");
palettes.add("ChartFX6.Windows");
palettes.add("DarkPastels.Pastels");
palettes.add("HighContrast.HighContrast");
palettes.add("Mesa.Mesa");
palettes.add("Nature.Adventure");
palettes.add("Nature.Sky");
palettes.add("Schemes.Classic");
palettes.add("Schemes.Colorful");
palettes.add("Schemes.Professional");
palettes.add("Schemes.Simple");
palettes.add("Schemes2.Autumn");
palettes.add("Schemes2.Brown Sugar");
palettes.add("Schemes2.Oceanica");
palettes.add("Schemes2.Slate");
palettes.add("Schemes3.Lilacs in Mist");
palettes.add("Schemes3.Rainy Day");
palettes.add("Schemes3.Sand & Sky");
palettes.add("Schemes3.Snowy Pine");
palettes.add("Schemes4.Black&Blue1");
palettes.add("Schemes4.Mocha");

ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.getLegendBox().setVisible(false);
chart1.setWidth(400);
chart1.setHeight(240);
chart1.setToolTips(false);
chart1.getImageSettings().setToolTips(ImageToolTipStyle.NONE);
chart1.getImageSettings().setInteractive(false);
TitleDockable t = new TitleDockable();
chart1.getTitles().add(t);

String pal;

for (int i=0; i < palettes.size(); i++)
{
    pal = palettes.get(i).toString();
    t.setText(pal);
    chart1.setPalette(pal);
    chart1.updateSizeNow();
    chart1.renderControl();
    out.println("&nbsp;");
}

%>        
    </body>
</html>
