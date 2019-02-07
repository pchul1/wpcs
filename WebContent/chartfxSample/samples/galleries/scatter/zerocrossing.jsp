<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Gallery: Scatter</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext,request,response);
chart1.setGallery(Gallery.SCATTER);

TextProvider txtProvider = new TextProvider();
txtProvider.open(application.getRealPath("/") + "/data/samplescatter3.txt");
chart1.getDataSourceSettings().getFields().add(new FieldMap("RelativeFatIntake", FieldUsage.XVALUE));
chart1.getDataSourceSettings().getFields().add(new FieldMap("Diet1", FieldUsage.VALUE));
chart1.getDataSourceSettings().getFields().add(new FieldMap("Diet2", FieldUsage.VALUE));
chart1.getDataSourceSettings().getFields().add(new FieldMap("Diet3", FieldUsage.VALUE));
chart1.getDataSourceSettings().setDataSource(txtProvider);
txtProvider.close();

chart1.setGallery(Gallery.SCATTER);
chart1.getAllSeries().setMarkerSize((short)4);
chart1.setAxesStyle(AxesStyle.NONE);
Axis axisy = chart1.getAxisY();
axisy.setMin(-30);
axisy.setStep(10);
axisy.setMax(50);
Axis axisx = chart1.getAxisX();
axisx.setMin(-20);
axisx.setStep(5);
axisx.setMax(20);
chart1.recalculateScale();

chart1.setWidth(600);
chart1.setHeight(400);
chart1.renderControl();
%>        
    </body>
</html>
