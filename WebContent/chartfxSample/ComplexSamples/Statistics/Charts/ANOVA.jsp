<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.statistical.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>ANOVA</title>
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
				
	        	statistics1.getStudies().add(StudyGroup.ANOVA);
		        statistics1.getLegendBox().setVisible(true);
	        	chart1.getAxisY().setForceZero(false);
			
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
					cfxXML.load(getServletContext().getRealPath("/") + "data\\Statistics\\ANOVAData.txt");
					aChart.getDataSourceSettings().setDataSource(cfxXML);
			    }
			%>				
		</div>
	</body>
</html>