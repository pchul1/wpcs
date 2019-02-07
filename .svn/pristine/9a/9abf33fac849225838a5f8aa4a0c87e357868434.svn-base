<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="com.softwarefx.chartfx.server.annotation.*"%>
<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page import="com.softwarefx.chartfx.server.statistical.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : addgroup
    Created on : Jun 25, 2008, 2:25:54 PM
    Author     : Administrator
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Group</title>
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
       statistics1.getStudies().add(StudyGroup.CENTRAL_TENDENCY_MEDIAN);

       StudyConstant mean = (StudyConstant) statistics1.getStudies().find(StudyType.ANALYSIS, Analysis.getUnderlyingValue(Analysis.MEAN));
       mean.setVisible(true);

       StudyInteractive zscores = (StudyInteractive) statistics1.getStudies().find(StudyType.ANALYSIS, Analysis.getUnderlyingValue(Analysis.ZSCORES));
       zscores.setVisible(true);

       StudyConstant median = (StudyConstant) statistics1.getStudies().find(StudyType.ANALYSIS,Analysis.getUnderlyingValue(Analysis.MEDIAN));
       median.setVisible(true);

       StudyStripe lq = (StudyStripe) statistics1.getStudies().find(StudyType.ANALYSIS, Analysis.getUnderlyingValue(Analysis.LOWER_QUARTILE));
       lq.setVisible(true);

       StudyStripe uq = (StudyStripe) statistics1.getStudies().find(StudyType.ANALYSIS, Analysis.getUnderlyingValue(Analysis.UPPER_QUARTILE));
       uq.setVisible(true);
       statistics1.getLegendBox().setVisible(true);

       statistics1.getLegendBox().sizeToFit();
       chart1.getLegendBox().setVisible(false);
       chart1.setWidth(800);
       chart1.setHeight(600);
       chart1.renderControl();
       %>
    </body>
</html>
