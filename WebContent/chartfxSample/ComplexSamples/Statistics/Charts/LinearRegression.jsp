<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.statistical.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="java.awt.*"%>
<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">   
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Linear Regression</title>
	</head>
	<body>
		<div>
			<%
				ChartServer chart1 = new ChartServer(pageContext, request, response);
				chart1.setID("chart1");
				chart1.setUseCallbacksForEvents(true);				
				chart1.setGallery(Gallery.SCATTER);
				Statistics statistics1 = new Statistics();
				chart1.getExtensions().add(statistics1);	
			
				TitleDockable td = new TitleDockable();
	            td.setFont(new Font("Arial", Font.BOLD, 14));
	            td.setTextColor(new Color(0, 0, 139));
	            td.setText("Linear Regression Scatter Chart");
	            chart1.getTitles().add(td);
	
	            chart1.getAxisY().getTitle().setText("Steam Usage");
	            chart1.getAxisX().getTitle().setText("Temperature");
	
	            chart1.getAxisX().setForceZero(false);
	            chart1.getAxisY().setForceZero(false);
	
	            chart1.getDataSourceSettings().getFields().add(new FieldMap("Temperature", FieldUsage.XVALUE));           
	            chart1.getDataSourceSettings().getFields().add(new FieldMap("Steam", FieldUsage.VALUE));
	
	            ReadChartData(chart1);
	
	            //other interesting chart settings
	            chart1.getAllSeries().getPointLabels().setVisible(true);
	            chart1.getAxisY().getDataFormat().setDecimals(2);
	
	            //Now lets add some statistical studies
	            statistics1.getStudies().add(StudyGroup.XYCORRELATION);
	            statistics1.getStudies().add(Analysis.LINEAR_REGRESSION_M);
	            statistics1.getStudies().add(Analysis.LINEAR_REGRESSION_B);
	            statistics1.getLegendBox().setVisible(true);
	
	            //Lets add a subtitle with the resulting regression line 
	            //First lets get the values
	            double m = statistics1.getCalculators().get(0).get(Analysis.LINEAR_REGRESSION_M);
	            double b = statistics1.getCalculators().get(0).get(Analysis.LINEAR_REGRESSION_B);
	            TitleDockable tdSub = new TitleDockable();
	            tdSub.setFont(new Font("Arial", Font.ITALIC, 10));
	            tdSub.setTextColor(new Color(112, 128, 144));
	            
	            //Now let's output the formula as a subtitle in the chart
	            DecimalFormat dfFourPlaces = new DecimalFormat("#0.0000");
	            tdSub.setText("y = " + dfFourPlaces.format(m) + "X + " + dfFourPlaces.format(b));
	            chart1.getTitles().add(tdSub);
	
	            //Now let's find the regression line and change some of its visual attributes
                    StudyLine Regline = (StudyLine)statistics1.getStudies().find(StudyType.ANALYSIS, Analysis.getUnderlyingValue(Analysis.REGRESSION_LINE));
	            Regline.getLine().setColor(new Color(0, 100, 0));
	            Regline.getLine().setWidth(2);
	            Regline.getLine().setStyle(DashStyle.DASH_DOT_DOT);
	            Regline.setVisible(true);
	            
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
					cfxXML.load(getServletContext().getRealPath("/") + "data\\Statistics\\LinearRegressionData.txt");
					aChart.getDataSourceSettings().setDataSource(cfxXML);
			    }
			%>
		</div>
	</body>
</html>