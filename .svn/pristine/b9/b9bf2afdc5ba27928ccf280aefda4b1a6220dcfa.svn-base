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
		
	}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Polynomial Regression</title>
</head> 
	<body>
		<div>  
			<div id="table" style="width:696px">
                <div style="Font-Size:9pt; Font-family:Arial; width: 132px;">
                    Polynomial Degree:
              	</div>
           		<div id="RadioButtonList1" style="Font-family:Arial; Font-Size:9pt">
               		<input type="radio" name="group1" onclick="javascript:RBL_SelectedIndexChanged('2');" checked>2&nbsp;&nbsp;
                  	<input type="radio" name="group1" onclick="javascript:RBL_SelectedIndexChanged('3');"/>3&nbsp;&nbsp;
                    <input type="radio" name="group1" onclick="javascript:RBL_SelectedIndexChanged('4');"/>4&nbsp;&nbsp;
                    <input type="radio" name="group1" onclick="javascript:RBL_SelectedIndexChanged('5');"/>5&nbsp;&nbsp;
                    <input type="radio" name="group1" onclick="javascript:RBL_SelectedIndexChanged('6');"/>6&nbsp;&nbsp;
                    <input type="radio" name="group1" onclick="javascript:RBL_SelectedIndexChanged('7');"/>7&nbsp;&nbsp;
                    <input type="radio" name="group1" onclick="javascript:RBL_SelectedIndexChanged('8');"/>8&nbsp;&nbsp;
                    <input type="radio" name="group1" onclick="javascript:RBL_SelectedIndexChanged('9');"/>9&nbsp;&nbsp;
                    <input type="radio" name="group1" onclick="javascript:RBL_SelectedIndexChanged('10');"/>10
	        	</div>	          	        
	        </div>
	        <div>
			<%
				ChartServer chart1 = new ChartServer(pageContext, request, response);
				chart1.setID("chart1");
				chart1.setUseCallbacksForEvents(true);
				chart1.addUserCallbackListener(new UserCallBackEventHandler());
				
				ReadChartData(chart1);
				
				chart1.setGallery(Gallery.SCATTER);
				Statistics statistics1 = new Statistics();
				chart1.getExtensions().add(statistics1);
				
				TitleDockable td = new TitleDockable();
	            td.setFont(new Font("Arial", Font.BOLD, 14));
	            td.setTextColor(new Color(0, 0, 139));
	            td.setText("Polynomial Regression Scatter Chart");
	            chart1.getTitles().add(td);

	            chart1.getAxisY().getTitle().setText("Steam Usage");
	            chart1.getAxisX().getTitle().setText("Temperature");

	            

	            //other interesting chart settings
	            chart1.getAllSeries().getPointLabels().setVisible(true);
	            chart1.getAxisY().getDataFormat().setDecimals(2);

	            //Now lets add a 2-degree polynomial regression
	            StudyPolynomialRegression polyn = new StudyPolynomialRegression();
	            polyn.setVisible(true);
	            polyn.setText("Polynomial Regression");
	            polyn.setDegree(2);
	            statistics1.getStudies().add(polyn);

				chart1.getAxisX().setForceZero(false);
				chart1.getAxisX().setMin(15);
	            chart1.getAxisY().setForceZero(false);
			    chart1.getAxisY().setMin(5);
			    chart1.setWidth(650);
			    chart1.setHeight(400);
			    chart1.renderControl();
			%>
			<%!
				public class UserCallBackEventHandler implements UserCallbackListener
				{
					public void userCallbackEventHandler (UserCallbackEvent e)
				  	{		
						String param = e.getParam().toString();	
										
						ChartServer chartServerSide = (ChartServer)e.getSource();						
						Statistics statisticServerSide = (Statistics)chartServerSide.getExtensions().get(0);
						
						StudyPolynomialRegression polyn = (StudyPolynomialRegression)statisticServerSide.getStudies().get(0);
				        polyn.setDegree(Integer.parseInt(param));
				        
				        e.setResult(param);
				  	}
				}
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
					
					aChart.getDataSourceSettings().getFields().add(new FieldMap("Temperature", FieldUsage.XVALUE));
			        aChart.getDataSourceSettings().getFields().add(new FieldMap("Steam", FieldUsage.VALUE));
			        
					aChart.getDataSourceSettings().setDataSource(cfxXML);
			    }
			%>
			</div>
		</div>
	</body>
</html>