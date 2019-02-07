<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.maps.*"%>
<%@page import="com.softwarefx.chartfx.server.annotation.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="java.awt.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%-- 
    Document   : Elections
    Created on : May 13, 2008, 9:27:34 AM
    Author     : Administrator
--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Chart FX Maps - US 2000 Presidential Election Results</title>
</head>
<script type="text/javascript">
	function mapRegion_Click(aRegion) {
		var param = aRegion;
		
		SFX_onCallbackReadyDelegate = SFX_UpdateControls;
		SFX_SendUserCallback("chart1", param, false); 
	}

    function USViewButton_Click(aAction) {    
        var param = "US View";  
        
        SFX_onCallbackReadyDelegate = SFX_UpdateControls;
		SFX_SendUserCallback("chart1", param, false);	
    } 
     
    function SFX_UpdateControls(id, callbackReturn) {	
		if (callbackReturn != '') {
			if(callbackReturn != "US View...") {
				document.getElementById("USViewButton").style.visibility = "visible";
			}		
		}							
	}    		
</script>
<body>
<div>
	<div id="Panel1" style="font-family: Arial; font-size: 9pt; height: 50px; width: 784px;">
	    This sample uses the US 2000 election data and illustrates how to set conditional attributes [see code behind] in a map to set specific colors to different 
	    elements in the map. Also, the user can drilldown to a more specific map by double clicking the states in which the election was too close to call. 
	    Please note the annotation object, Legend box and special colors used to highlight states in which this condition occurred.
	</div>
	<div id="Panel2" style="font-family: Arial; font-size: 9pt; height: 50px; width: 784px;">            
		<table style="width: 742px">
            <tr>
                <td align="right" style="width: 637px; height: 33px">
        		</td>
                <td align="right" style="width: 100px; height: 33px">
        			<input type="submit" name="USViewButton" id="USViewButton" value="US View" style="font-family: Arial;
	                    font-size:9pt; width:56px; visibility:hidden;" onclick="USViewButton_Click('US View')"/>
        		</td>
       		</tr>
        </table>	 
	</div>
	<%!
		//===============================================================================
		// ConfigureUSMap Method
		//===============================================================================
		public void configureUSMap(ChartServer aChart1, Map aMap1, String aAppRealPath) { 
			aChart1.getTitles().get(2).setText("By State");
		    
		    //Clear Labels, Set MapSource, configure data and labellinks
		    aChart1.getData().clear();
		    aMap1.setMapSource(aAppRealPath + "/chartfx70/Library/US/USA-StatesAbrev.svg");

		    TextProvider cfxText = new TextProvider();		    
		    cfxText.open(aAppRealPath + "data\\US_results.txt");
		    aChart1.getDataSourceSettings().setDataSource(cfxText);
		    cfxText.close();
			
		    aMap1.setLabelLinkFile(aAppRealPath + "data\\US_LabelLinks.xml");
		
		    //display DataEditor and UserLegendBox
		    aChart1.getDataGrid().setVisible(true);
		    aChart1.getLegendBox().setBorder(DockBorder.NONE);
		    aChart1.getLegendBox().setVisible(true);
		    aChart1.getLegendBox().getItemAttributes().get(aChart1.getSeries()).setVisible(false);
		    aChart1.getAllSeries().getPointLabels().setFormat("%l - Total Vote: %v");
		    
		  	//Method Annotation Balloon
			add_annotation_balloon(aMap1);
	            
	        //Create conditional attributes
	        ConditionalAttributesCollection m_condList = aChart1.getConditionalAttributes();
	        m_condList.clear();

	        ConditionalAttributes cond1 = new ConditionalAttributes();
	        cond1.setColor(aChart1.getSeries().get(0).getColor());
	        cond1.getCondition().setActive(false);
	        cond1.setText("Republican");

	        ConditionalAttributes cond2 = new ConditionalAttributes();
	        cond2.setColor(aChart1.getSeries().get(1).getColor());
	        cond2.getCondition().setActive(false);
	        cond2.setText("Democrat");

	        ConditionalAttributes cond3 = new ConditionalAttributes();
	        cond3.setColor(new Color(255, 215, 0)); //Gold color
	        cond3.getCondition().setActive(false);
	        cond3.setText("Too close to call!");

	        m_condList.addRange(new ConditionalAttributes[] { cond1, cond2, cond3 });
		}	

		//===============================================================================
    	// Annotation Balloon Method
    	//===============================================================================        
    	private void add_annotation_balloon(Map aMap1) {
    		//Find Florida to attach annotation object
        	MapRegion mr = aMap1.findMapRegion("FLORIDA");
        	AnnotationObject annObj = mr.getBoundary();

	        //create and place annotation balloon in map
	        AnnotationBalloon balloon = new AnnotationBalloon();
	        balloon.setText("Click FL\nor NM to see\nCounty results.");
	        balloon.setTop(annObj.getTop() - 20);
	        balloon.setLeft(annObj.getLeft() + 150);
	        balloon.setHeight(120);
	        balloon.setWidth(150);
	        balloon.setTailCorner(BalloonTailCorner.BOTTOM_LEFT);
	        balloon.getBorder().setColor(Color.BLACK);
	        balloon.setColor(new Color(255, 215, 0)); //Gold color
	        balloon.setFont(new Font("Arial", Font.PLAIN, 14));
	        aMap1.getAnnotationObjectsList().add(balloon);
		}
		
    	//===============================================================================
		// Link State Method
		//===============================================================================
		private void add_link_state(ChartServer aChart1, Map aMap1) {
			// Create the URL for FL and NM to allow drill down
            MapRegion mr = aMap1.findMapRegion("FLORIDA");
            aChart1.getPoints().get(mr.getPoint()).getLink().setUrl("javascript:mapRegion_Click('FL')");
            mr = aMap1.findMapRegion("NEW MEXICO");
            aChart1.getPoints().get(mr.getPoint()).getLink().setUrl("javascript:mapRegion_Click('NM')");
		}
	%>
	<%
		ChartServer chart1 = new ChartServer(pageContext, request, response);
		chart1.setID("chart1");
		chart1.setUseCallbacksForEvents(true);
		chart1.addUserCallbackListener(new UserCallBackEventHandler());
		chart1.addConditionalAttributesCallbackListener(new EventHandler());		
		
		Map map1 = new Map();
        map1.setMapSource(application.getRealPath("/chartfx70") + "\\Library\\US\\USA-StatesAbrev.svg");
        map1.setChart(chart1);
        
      	//Titles and other visuals
        TitleDockable title = new TitleDockable();
        title.setText("US 2000 Presidential Election");
        title.setFont(new Font("Arial", 12, Font.BOLD));
        chart1.getTitles().add(title);
        
        map1.setTitleFont(new Font("Arial", Font.PLAIN, 10));

        TitleDockable subtitle = new TitleDockable();
        subtitle.setText(" George Bush (Republican) vs. Al Gore (Democrat)");
        subtitle.setFont(new Font("Arial", Font.ITALIC, 10));
        chart1.getTitles().add(subtitle);

        TitleDockable footer = new TitleDockable();
        footer.setFont(new Font("Arial", Font.PLAIN, 10));
        footer.setAlignment(StringAlignment.CENTER);
        footer.setDock(DockArea.BOTTOM);
        chart1.getTitles().add(footer);
        
        map1.setTitleFont(new Font("Arial", Font.PLAIN, 10)); 
        
      	//Method ConfigureUSMap
        configureUSMap(chart1, map1, application.getRealPath("/"));  
      	
      	//Method Link State
        add_link_state(chart1, map1);             
      	
      	chart1.setWidth(800);
        chart1.setHeight(600);
        chart1.renderControl();
	%>
	<%!
		public class UserCallBackEventHandler implements UserCallbackListener
		{
			public void userCallbackEventHandler (UserCallbackEvent e)
		  	{
				String param = e.getParam();
				ChartServer chartServerSide = (ChartServer)e.getSource();
				Map mapServerSide = (Map)chartServerSide.getExtensions().get(0);
				
				if(param.equalsIgnoreCase("US View")) {
					configureUSMap(chartServerSide, mapServerSide, getServletContext().getRealPath("/"));
					
					e.setResult("US View...");			
				} 
				else if(param.equalsIgnoreCase("FL")) {
					//Clear Labels, Set MapSource, configure data and labellinks
				    chartServerSide.getData().clear();
				    mapServerSide.setMapSource(getServletContext().getRealPath("/") + "data\\US\\Counties\\FL Counties.svg");

				    TextProvider cfxText = new TextProvider();		    
				    cfxText.open(getServletContext().getRealPath("/") + "data\\fl_county.txt");
				    chartServerSide.getDataSourceSettings().setDataSource(cfxText);
				    cfxText.close();
					
				    chartServerSide.getTitles().get(2).setText("Florida Vote by County. Press US View button on top to go back...");
					
					e.setResult("FL...");
				} 
				else if(param.equalsIgnoreCase("NM")) {
					
					//Clear Labels, Set MapSource, configure data and labellinks
				    chartServerSide.getData().clear();
				    mapServerSide.setMapSource(getServletContext().getRealPath("/") + "data\\US\\Counties\\NM Counties.svg");

				    TextProvider cfxText = new TextProvider();		    
				    cfxText.open(getServletContext().getRealPath("/") + "data\\nm_county.txt");
				    chartServerSide.getDataSourceSettings().setDataSource(cfxText);
				    cfxText.close();
					
				    chartServerSide.getTitles().get(2).setText("New Mexico Vote by County. Press US View button on top to go back...");
					
					e.setResult("NM...");
				}							
		  	}
		}
	
		public class EventHandler implements ConditionalAttributesListener
    	{
			public void conditionalAttributesEventHandler (ConditionalAttributesEvent e)
		    {
				ChartServer chartServerSide = (ChartServer)e.getSource();
				
				//Set Conditional Attributes to Map
	            //Please note this is done in teh event to allow calculation of percentage based on the underlying voting numbers contained in the chart
	            double diff = java.lang.Math.abs(chartServerSide.getData().get(0, e.getPoint()) - chartServerSide.getData().get(1, e.getPoint()));
	            double diffPercent = (diff / (chartServerSide.getData().get(0, e.getPoint()) + chartServerSide.getData().get(1, e.getPoint()))) * 100;
	
	            if (diffPercent < 0.1) {
	                e.setAttributes(2);
	            }
	            else if (chartServerSide.getData().get(0, e.getPoint()) > chartServerSide.getData().get(1, e.getPoint())) {
	                e.setAttributes(0);
	            }
	            else {
	                e.setAttributes(1);
	            }
		    }
    	}
	%>	
</div>
</body>
</html>