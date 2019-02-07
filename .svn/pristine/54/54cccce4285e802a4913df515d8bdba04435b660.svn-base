<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="com.softwarefx.chartfx.server.annotation.*"%>
<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page import="com.softwarefx.chartfx.server.statistical.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : customize_group
    Created on : Jun 25, 2008, 7:04:00 PM
    Author     : Administrator
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Customize Group</title>
    </head>
    <body>
       <%
       ChartServer chart1 = new ChartServer(application,request,response);
       com.softwarefx.chartfx.server.statistical.Statistics statistics1 = new com.softwarefx.chartfx.server.statistical.Statistics();
       
       statistics1.setChart(chart1);  
       TextProvider txtProvider = new TextProvider(application.getRealPath("/") + "/data/statistical_data.txt");
       chart1.setDataSource(txtProvider);
       chart1.setGallery(Gallery.SCATTER);

       statistics1.getStudies().add(StudyGroup.CENTRAL_TENDENCY_MEAN);

       StudyConstant mean = (StudyConstant) statistics1.getStudies().find(StudyType.ANALYSIS,Analysis.getUnderlyingValue(Analysis.MEAN));
       mean.setVisible(true);
       mean.setIndented(false);
       mean.setColor(java.awt.Color.red);

       StudyInteractive zscores = (StudyInteractive) statistics1.getStudies().find(StudyType.ANALYSIS, Analysis.getUnderlyingValue(Analysis.ZSCORES));
       zscores.setVisible(true);

       Study stddev = (Study) statistics1.getStudies().find(StudyType.ANALYSIS, Analysis.getUnderlyingValue(Analysis.STANDARD_DEVIATION));
       stddev.setBold(true);

//Customize name and number of decimals
       Study stderr = (Study) statistics1.getStudies().find(StudyType.ANALYSIS,Analysis.getUnderlyingValue(Analysis.STANDARD_ERROR));
       stderr.setText("Std. Err.");
       stderr.setDecimals(6);

//Remove a study from a group
       Study kurtosis = (Study) statistics1.getStudies().find(StudyType.ANALYSIS,Analysis.getUnderlyingValue(Analysis.KURTOSIS));
       statistics1.getStudies().remove(kurtosis);

       statistics1.getLegendBox().setVisible(true);
       statistics1.getLegendBox().sizeToFit();
       chart1.getLegendBox().setVisible(false);
       chart1.setWidth(800);
       chart1.setHeight(600);
       chart1.renderControl();
       %>
    </body>
</html>
