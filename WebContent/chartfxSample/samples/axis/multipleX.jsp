<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Axis: Multiple X</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);
chart1.setGallery(Gallery.BAR);
chart1.getLegendBox().setVisible(false);

chart1.getData().setSeries(1);
chart1.getData().setPoints(16);
java.util.Random r = new java.util.Random(1);
for (int i=0;i<16;i++)
    chart1.getData().set(0, i,r.nextDouble()* 10);

chart1.getAxisX().getGrids().getMajor().setVisible(false);
chart1.getAxisY().getGrids().getMajor().setVisible(false);
chart1.getAxisX().getLabels().set(0, "January");
chart1.getAxisX().getLabels().set(1, "February");
chart1.getAxisX().getLabels().set(2, "March");
chart1.getAxisX().getLabels().set(3, "April");
chart1.getAxisX().getLabels().set(4, "May");
chart1.getAxisX().getLabels().set(5, "June");
chart1.getAxisX().getLabels().set(6, "July");
chart1.getAxisX().getLabels().set(7, "August");
chart1.getAxisX().getLabels().set(8, "September");
chart1.getAxisX().getLabels().set(9, "October");
chart1.getAxisX().getLabels().set(10, "November");
chart1.getAxisX().getLabels().set(11, "December");
chart1.getAxisX().getLabels().set(12, "December2");
chart1.getAxisX().getLabels().set(13, "December3");
chart1.getAxisX().getLabels().set(14, "December4");
chart1.getAxisX().getLabels().set(15, "December5");
chart1.getAxisX().setLabelAngle((short) 90);

AxisX axis = new AxisX();
axis.setVisible(true);
axis.setMin(0);
axis.setMax(10);
axis.setStep(4);
axis.setPosition(AxisPosition.FAR);
//axis.getLabels().set(3,"1st Quarter");
//axis.getLabels().set(6,"2nd Quarter");
//axis.getLabels().set(9,"3rd Quarter");
//axis.getLabels().set(12,"4rd Quarter");
java.util.EnumSet<AxisStyles> style = axis.getStyle();
        style.add(AxisStyles.CENTERED);
        axis.setStyle(style);
        chart1.getLegendBox().setVisible(false);
        axis.getLabels().set(4,"Group1");
        axis.getLabels().set(8,"Group2");
        axis.getLabels().set(12,"Group3");
        axis.getLabels().set(16,"Group4");
chart1.getAxesX().add(axis);

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
