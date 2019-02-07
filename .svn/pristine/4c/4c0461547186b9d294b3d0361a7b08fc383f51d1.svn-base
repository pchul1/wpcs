<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="com.softwarefx.chartfx.server.annotation.*"%>
<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page import="com.softwarefx.chartfx.server.statistical.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : six_sigma
    Created on : Jun 25, 2008, 8:25:45 PM
    Author     : Administrator
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Six Sigma</title>
    </head>
    <body>
        <%
        ChartServer chart1 = new ChartServer(application,request,response);
        com.softwarefx.chartfx.server.statistical.Statistics statistics1 = new com.softwarefx.chartfx.server.statistical.Statistics();
       
        statistics1.setChart(chart1);  
        TextProvider txtProvider = new TextProvider(application.getRealPath("/") + "/data/statistical_data_sixsigma.txt");
        chart1.setDataSource(txtProvider);
        chart1.setGallery(Gallery.LINES);

        statistics1.getStudies().add(StudyGroup.SPC);
        statistics1.getCalculators().get(0).setLsl(120);
        statistics1.getCalculators().get(0).setUsl(220);

        StudyConstant lsl = (StudyConstant) statistics1.getStudies().find(StudyType.ANALYSIS,Analysis.getUnderlyingValue(Analysis.LSL));
        lsl.setVisible(true);
        lsl.setShowLabel(true);

        StudyConstant usl = (StudyConstant) statistics1.getStudies().find(StudyType.ANALYSIS,Analysis.getUnderlyingValue(Analysis.USL));
        usl.setVisible(true);
        usl.setShowLabel(true);

        StudyConstant mean = (StudyConstant) statistics1.getStudies().find(StudyType.ANALYSIS,Analysis.getUnderlyingValue(Analysis.MEAN));
        mean.setVisible(true);
        mean.setShowLabel(true);

        StudyStripe s1 = (StudyStripe) statistics1.getStudies().find(StudyType.ANALYSIS,Analysis.getUnderlyingValue(Analysis.SIGMA_1));
        s1.setVisible(true);

        StudyStripe s2 = (StudyStripe) statistics1.getStudies().find(StudyType.ANALYSIS,Analysis.getUnderlyingValue(Analysis.SIGMA_2));
        s2.setVisible(true);

        StudyStripe s3 = (StudyStripe) statistics1.getStudies().find(StudyType.ANALYSIS,Analysis.getUnderlyingValue(Analysis.SIGMA_3));
        s3.setVisible(true);

        statistics1.getLegendBox().setVisible(true);
        statistics1.getLegendBox().sizeToFit();
        chart1.getLegendBox().setVisible(false);
        chart1.setWidth(800);
        chart1.setHeight(600);
        chart1.renderControl();
        %>
    </body>
</html>
