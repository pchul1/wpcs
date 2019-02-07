<%@page import="com.softwarefx.chartfx.server.*, com.softwarefx.chartfx.server.adornments.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Bar: Stacked</title>
    </head>
    <body>
<%ChartServer chart1 = new ChartServer(pageContext,request,response);
//chart1.getLegendBox().setVisible(false);
chart1.getData().setSeries(2);
chart1.getData().setPoints(16);
java.util.Random r = new java.util.Random(1);
for (int i=0;i<chart1.getData().getSeries();i++)
    for (int j=0;j<chart1.getData().getPoints();j++)
        chart1.getData().set(i, j, r.nextDouble() * 20);
chart1.setGallery(Gallery.BAR);
chart1.getAllSeries().setStacked(Stacked.NORMAL);

//외곽 테두리 없애기
		SimpleBorder myBorder = new SimpleBorder();
		myBorder.setType(SimpleBorderType.NONE);
		chart1.setBorder(myBorder);

		//그라데이션 없애기
		GradientBackground myBorder1 = new GradientBackground();
		myBorder1.setEffectArea(0);
		chart1.setBackground(myBorder1);
		chart1.getToolBar().setVisible(false); 

		
		chart1.getAxisX().getGrids().getMajor().setVisible(false);
		chart1.getAxisY().getGrids().getMajor().setVisible(false);
		chart1.getAxisX().getLabels().set(0, "유류유출");
		chart1.getAxisX().getLabels().set(1, "물고기폐사");
		chart1.getAxisX().getLabels().set(2, "화학물질");
		chart1.getAxisX().getLabels().set(3, "기타");
		chart1.getAxisX().getLabels().set(4, "유류유출");
		chart1.getAxisX().getLabels().set(5, "물고기폐사");
		chart1.getAxisX().getLabels().set(6, "화학물질");
		chart1.getAxisX().getLabels().set(7, "기타");
		chart1.getAxisX().getLabels().set(8, "유류유출");
		chart1.getAxisX().getLabels().set(9, "물고기폐사");
		chart1.getAxisX().getLabels().set(10, "화학물질");
		chart1.getAxisX().getLabels().set(11, "기타");
		chart1.getAxisX().getLabels().set(12, "유류유출");
		chart1.getAxisX().getLabels().set(13, "물고기폐사");
		chart1.getAxisX().getLabels().set(14, "화학물질");
		chart1.getAxisX().getLabels().set(15, "기타");
		chart1.getAxisX().setLabelAngle((short) 45);
		
AxisX axis = new AxisX();
axis.setVisible(true);
axis.setMin(0);
axis.setMax(16);
axis.setStep(4);
axis.setPosition(AxisPosition.FAR);
//axis.getGrids().setInterlaced(true);
//axis.getGrids().getMajor().setVisible(true);
//axis.getGrids().getMajor().setColor(new java.awt.Color(135, 206, 250));
//axis.getLabels().set(3,"1st Quarter");
//axis.getLabels().set(6,"2nd Quarter");
//axis.getLabels().set(9,"3rd Quarter");
//axis.getLabels().set(12,"4rd Quarter");
java.util.EnumSet<AxisStyles> style = axis.getStyle();
        style.add(AxisStyles.CENTERED);
        axis.setStyle(style);
        chart1.getLegendBox().setVisible(false);
        axis.getLabels().set(4,"한강");
        axis.getLabels().set(8,"낙동강");
        axis.getLabels().set(12,"금강");
        axis.getLabels().set(16,"영산강");
chart1.getAxesX().add(axis);

chart1.setWidth(357);
chart1.setHeight(212);
chart1.getLegendBox().setVisible(false);
chart1.renderControl();
%>        
    </body>
</html>
