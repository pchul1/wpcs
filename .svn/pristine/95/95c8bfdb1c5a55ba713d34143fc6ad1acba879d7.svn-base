<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.statistical.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="java.awt.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Histogram</title>
</head> 
	<body>
		<div>  
			<%
				ChartServer chart1 = new ChartServer(pageContext, request, response);
				chart1.setID("chart1");
				chart1.setUseCallbacksForEvents(true);				
				
				ReadChartData(chart1);
				
				Statistics statistics1 = new Statistics();
				chart1.getExtensions().add(statistics1);
				
				
			    //Main Title            
			    TitleDockable td = new TitleDockable();
			    td.setFont(new Font("Arial", Font.BOLD, 14));
			    td.setTextColor(new Color(0, 0, 139));
			    td.setText("Capability Analysis");
			    chart1.getTitles().add(td);
			
			    //Axes Titles
			    chart1.getAxisY().getTitle().setText("Frequency");
			    chart1.getAxesX().get(0).getTitle().setText("Intervals");
			
			    statistics1.getGallery().setCurrent(Galleries.Gallery.HISTOGRAM);
			    statistics1.getLegendBox().setVisible(true);
			
			    //we'll be adding and configuring histogram studies individually
			    statistics1.getGallery().getHistogram().setDataMax(85);
			    statistics1.getGallery().getHistogram().setDataMin(65);
			    statistics1.getGallery().getHistogram().setIntervals(20);
			    statistics1.getGallery().getHistogram().setLimitLeft(5);
			    statistics1.getGallery().getHistogram().setLimitRight(14);
			    statistics1.getGallery().getHistogram().setShowLimits(true);
			    statistics1.getGallery().getHistogram().setLimitsColor(Color.RED);
			    chart1.getAllSeries().setVolume((short)100);
			    chart1.getLegendBox().setVisible(false);
			    statistics1.getCalculators().get(0).setLsl(60);
			    statistics1.getCalculators().get(0).setUsl(80);
			    statistics1.getStudies().add(Analysis.CPK);
			    statistics1.getStudies().add(Analysis.CP);
			    statistics1.getStudies().add(Analysis.KURTOSIS);
			    statistics1.getStudies().add(Analysis.PP);
			    statistics1.getStudies().add(Analysis.PPK);
			    statistics1.getStudies().add(Analysis.SKEWNESS);
			    statistics1.getStudies().add(Analysis.VARIANCE);
			    statistics1.getStudies().add(Analysis.MEAN);
			
			    //Now lets add some studies that requires casting to setup additional properties like color
			    StudyStripe lq = (StudyStripe)statistics1.getStudies().add(Analysis.LOWER_QUARTILE);
			    lq.setColor(new Color(144, 238, 144));
			    lq.setVisible(true);
			    StudyStripe uq = (StudyStripe)statistics1.getStudies().add(Analysis.UPPER_QUARTILE);
			    uq.setColor(new Color(255, 255, 224));
			    uq.setVisible(true);
			
			
			    Study n = statistics1.getStudies().add(Analysis.N);
			    n.setDecimals(0);
			    statistics1.getStudies().add(Analysis.SIGMA_1);
			    Study lsl = statistics1.getStudies().add(Analysis.LSL);
			    lsl.setDecimals(0);
			    Study usl = statistics1.getStudies().add(Analysis.USL);
			    usl.setDecimals(0);
			
			    //Alternatively you could've add a group of studies by adding the following code.
			    //Statistics1.Studies.Add(StudyGroup.CentralTendencyMean);
			
			    //Lets now make use of custom studies to add a study that allows the end user to show/hide the normal curve
			    //this can be easily done with property setting and a checkbox in the application. However, we want to add 
			    //such functionality in the actual Statistical legendbox
			    StudyCustom customStudy = new StudyCustom(1, "Normal Distribution");
			    customStudy.setInteractive(true);
			    customStudy.setColor(Color.BLUE);
			    customStudy.setBold(false);
			    customStudy.setVisible(true);
			    customStudy.setIndented(true);
			    statistics1.getStudies().add(customStudy);
			    
			    chart1.setWidth(650);
			    chart1.setHeight(400);
			    chart1.renderControl();
			%>
			<%!
				private void ReadChartData(ChartServer aChart)
			    {
			        /* This function reads from a txt file (XML Format) embedded as project resource.
			         * The file is read into a string and then loaded using the Chart FX Data Provider Load Method. 
			         * Optionally, you can read from an external XML File using the Load method of the
			         * Data Provider (see Chart FX Resource Center for additional information).
			         */        
					XmlDataProvider cfxXML = new XmlDataProvider();
			        cfxXML.setDateFormat("yyyy-MM-dd");
					cfxXML.load(getServletContext().getRealPath("/") + "data\\Statistics\\CapabilityAnalysisData.txt");
					aChart.getDataSourceSettings().setDataSource(cfxXML);
			    }
			%>
		</div>
	</body>
</html>