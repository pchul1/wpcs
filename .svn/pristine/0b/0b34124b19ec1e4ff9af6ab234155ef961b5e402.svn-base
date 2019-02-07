<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.statistical.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="java.awt.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script type="text/javascript">
	function RBL_SelectedIndexChanged(aValue) {   
		var param = aValue;

        SFX_onCallbackReadyDelegate = SFX_UpdateControls;
		SFX_SendUserCallback('chart1', param, false);
	}
	
	function SFX_UpdateControls(id, callbackReturn) {	
		if (callbackReturn != "") {
			document.getElementById('Label1').innerHTML = callbackReturn;
		}
	}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>SPC</title>
</head> 
	<body>
		<div>
			<div id="table" style="width:696px">
           		<div id="RadioButtonList1" style="Font-family:Arial; Font-Size:9pt">
               		<input type="radio" name="group1" onclick="javascript:RBL_SelectedIndexChanged('p Chart');" checked/>p Chart&nbsp;&nbsp;&nbsp;&nbsp;
                  	<input type="radio" name="group1" onclick="javascript:RBL_SelectedIndexChanged('np Chart');"/>np Chart&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="group1" onclick="javascript:RBL_SelectedIndexChanged('x Chart');"/>x Chart&nbsp;&nbsp;&nbsp;&nbsp;
                    <input type="radio" name="group1" onclick="javascript:RBL_SelectedIndexChanged('r Chart');"/>r Chart
	        	</div>	          	        
	        </div>
			<div>
			<%
				ChartServer chart1 = new ChartServer(pageContext, request, response);
				chart1.setID("chart1");
				chart1.setUseCallbacksForEvents(true);						
				
				Statistics statistics1 = new Statistics();
				chart1.getExtensions().add(statistics1);
				
				TitleDockable td = new TitleDockable();
	            td.setFont(new Font("Arial", Font.BOLD, 14));
	            td.setTextColor(new Color(0, 0, 139));
	            td.setText("p Chart");
	            chart1.getTitles().add(td);

	            chart1.getAxisY().getTitle().setText("% Defective");
	            chart1.getAxisX().getTitle().setText("Date");

	            chart1.getAllSeries().setMarkerShape(MarkerShape.DIAMOND);
	            chart1.getAllSeries().setMarkerSize((short)2);
	            chart1.getAllSeries().getLine().setStyle(DashStyle.DASH);
	            chart1.getAllSeries().getLine().setWidth((short)2);
	            chart1.getLegendBox().setVisible(false);

	            statistics1.getLegendBox().setVisible(true);

	            statistics1.getGallery().setCurrent(Galleries.Gallery.PCHART);
	            ReadChartData(chart1, "pChartData.txt", false);
	            
	            //we'll be adding a Legend box with SPC studies. You can also add studies individually (See histogram settings)
	            statistics1.getStudies().add(StudyGroup.SPC);
	            
	            //Now lets make the sigma limits visible. Since we have already added the group we must find those studies and switch their visible property
	            /*StudyInteractive s1 = (StudyInteractive)statistics1.getStudies().find(StudyType.ANALYSIS, (int)Analysis.SIGMA_1);
	            s1.setVisible(true);
	            StudyInteractive s2 = (StudyInteractive)statistics1.getStudies().find(StudyType.ANALYSIS, (int)Analysis.SIGMA_2);
	            s2.setVisible(true);
	            StudyInteractive s3 = (StudyInteractive)statistics1.getStudies().find(StudyType.ANALYSIS, (int)Analysis.SIGMA_3);
	            s3.setVisible(true);*/
			
				chart1.setWidth(650);
			    chart1.setHeight(400);
			    chart1.renderControl();
			%>
			<%!
				public class UserCallBackEventHandler implements UserCallbackListener
				{
					public void userCallbackEventHandler (UserCallbackEvent e)
				  	{
						String message = "";
						String param = e.getParam().toString();	
										
						ChartServer chartServerSide = (ChartServer)e.getSource();						
						Statistics statisticServerSide = (Statistics)chartServerSide.getExtensions().get(0);
						
						if(param.equalsIgnoreCase("p Chart"))
				        {
							chartServerSide.getData().clear();
							chartServerSide.getTitles().get(0).setText("p Chart");
							chartServerSide.getAxisY().getTitle().setText("% Defective");
							chartServerSide.getAxisX().getTitle().setText("Date");
				            ReadChartData(chartServerSide, "pChartData.txt", false);
				            message = "The p chart is used when output is measured in terms of PASS/FAIL. The decision to adjust or continue a process is determined by the proportion of failed items based on the total number of items tested. The p Chart  will accept 2 series of data. One will consist of the number of failed items; the second is the total sample size.";
				            statisticServerSide.getGallery().setCurrent(Galleries.Gallery.PCHART);
				        }
						else if(param.equalsIgnoreCase("np Chart")) {
							chartServerSide.getData().clear();
							chartServerSide.getTitles().get(0).setText("np Chart");
							chartServerSide.getAxisY().getTitle().setText("% Defective");
							chartServerSide.getAxisX().getTitle().setText("Date");
				            ReadChartData(chartServerSide, "pChartData.txt",false);
				            message = "As with the p chart, the np chart will accept 2 series of data. One will consist of the number of failed items; the second is the total sample size. The np chart plots a proportion of defective items multiplied by the mean size of the samples i.e. [(defective/sample)*Mean(samples)]";
				            statisticServerSide.getGallery().setCurrent(Galleries.Gallery.NPCHART);
				        }
				        else if(param.equalsIgnoreCase("x Chart")) {
				        	chartServerSide.getData().clear();
				        	chartServerSide.getTitles().get(0).setText("x Chart");
				        	chartServerSide.getAxisY().getTitle().setText("Average");
				        	chartServerSide.getAxisX().getTitle().setText("Date");

				            ReadChartData(chartServerSide, "xChartData.txt",  true);
				            message = "The x Chart will only plot one point per configured data series. Each point displayed is actually the sample mean for all the observations (values) contained in the sample (series). Therefore, if you have 10 series of 50 points, your XChart will only display 10 values, the mean for each series.";
				            statisticServerSide.getGallery().setCurrent(Galleries.Gallery.XCHART);
				        }
				        else if(param.equalsIgnoreCase("r Chart")) {
				        	chartServerSide.getData().clear();
				        	chartServerSide.getTitles().get(0).setText("r Chart");
				        	chartServerSide.getAxisY().getTitle().setText("Range");
				        	chartServerSide.getAxisX().getTitle().setText("Date");
				            ReadChartData(chartServerSide, "xChartData.txt",  true);
				            message = "The r Chart is used in scenarios where the output is measured as a range. As with the XChart, the RChart will also plot one point per configured data series, however, the maximum range between observations is the value plotted for each series";
				            statisticServerSide.getGallery().setCurrent(Galleries.Gallery.RCHART);
				        }
				        
				        e.setResult(message);
				  	}
				}
			%>
			<%!
				private void ReadChartData(ChartServer aChart, String aFileName, boolean aTranspose)
			    {
			        /* This function reads from a txt file (XML Format) embedded as project resource.
			         * The file is read into a string and then loaded using the Chart FX Data Provider Load Method. 
			         * Optionally, you can read from an external XML File using the Load method of the
			         * Data Provider (see Chart FX Resource Center for additional information).
			         */        
					XmlDataProvider cfxXML = new XmlDataProvider();
			        cfxXML.setDateFormat("yyyy-MM-dd");
					cfxXML.load(getServletContext().getRealPath("/") + "data\\Statistics\\" + aFileName);
					
					//I need to transpose the data in certain chart types (x and r charts) as spc data is calculated based on series infromation...
			        if(aTranspose) {
			            aChart.getDataSourceSettings().getStyle().add(DataSourceStyles.TRANSPOSE);
			        }
			        					
					aChart.getDataSourceSettings().setDataSource(cfxXML);
			    }
			%>
			</div>
			<div id="Label1" style="font-family:Arial; text-align:justify; Font-Size:9pt;">
			</div>				
		</div>
	</body>
</html>