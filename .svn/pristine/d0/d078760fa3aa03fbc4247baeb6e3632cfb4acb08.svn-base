<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.maps.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="java.awt.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Chart FX Extensions Pack (Maps) - Soda Sales</title>
</head>

<!-- Required for Tree View -->
<link rel="stylesheet" type="text/css" href="treeview/yui/css/screen.css">
<link rel="stylesheet" type="text/css" href="treeview/yui/css/menu/tree.css">
<style type="text/css">
	.menuLabel {
		font-family: arial;
		font-size: 12px;
		text-decoration: none;
		color: black;
    }

	.menuLabel:visited {
		font-family: arial;
		font-size: 12px;
		text-decoration: none;
		color: black;
    }

    .menuLabel:active {
    	font-family: arial;
    	font-size: 12px;
		text-decoration: none;
		font-weight: bold;
		color: black;
    }

    .menuLabel:link {
    	font-family: arial;
    	font-size: 12px;
		text-decoration: none;
		color: black;
    }

	.menuLabel:hover {
		font-family: arial;
		font-size: 12px;
		text-decoration: none;
	    font-weight: bold;
	    color: navy;
    }
</style>
<script type="text/javascript" src="treeview/yui/yahoo/yahoo.js" ></script>
<script type="text/javascript" src="treeview/yui/event/event.js"></script>
<script type="text/javascript" src="treeview/yui/dom/dom.js"></script>
<script type="text/javascript" src="treeview/yui/logger/logger.js"></script>
<script type="text/javascript" src="treeview/yui/treeview/treeview-debug.js" ></script>
<script type="text/javascript" src="treeview/yui/animation/animation.js"></script>
<!-- End Tree View -->

<script type="text/javascript">
	function treeEvent(aTreeSection) {
		var param = aTreeSection;

	 	SFX_onCallbackReadyDelegate = function SFX_UpdateControls(id, callbackReturn) {	
											if (callbackReturn != '') {
												document.getElementById('Label2').innerHTML = callbackReturn;			
											}					
										};
										
		SFX_SendUserCallback('chart1', param, false);			
	}
</script>
<body onload="treeInit()">
<div id="Gerardo">

</div>
<div>
	<div id="Panel1" style="font-family: Arial; font-size: 9pt; height: 50px; width: 784px;">
	    This sample uses soda sales to illustrate how a single data set can provide many different views in a map. 
	    To test, run the application and select the tree view at the left side of the page.
	</div>
	&nbsp; &nbsp;
	<div id="table">
		<div id="left" style="float:left; width:200px; height:490px">
			<div id="treeDiv1" style="height:200px"></div>
				<script type="text/JavaScript">
					var tree;
				
					function treeInit() {
						tree = new YAHOO.widget.TreeView("treeDiv1");
						tree.setExpandAnim(YAHOO.widget.TVAnim.FADE_IN);
						tree.setCollapseAnim(YAHOO.widget.TVAnim.FADE_OUT);
				
						var data = {label:"Soda Market Analysis", href:"javascript:treeEvent('Soda Market Analysis')"}
						var tmpNodeRoot = new YAHOO.widget.MenuNode(data, tree.getRoot(), false);
						tmpNodeRoot.labelStyle = "menuLabel";
				
							data = {label:"Sales by Region", href:"javascript:treeEvent('Sales by Region')"}
							var tmpNodeChild1 = new YAHOO.widget.MenuNode(data, tmpNodeRoot, false);
							tmpNodeChild1.labelStyle = "menuLabel";
				
							data = {label:"Overall Sales Winner", href:"javascript:treeEvent('Overall Sales Winner')"}
							var tmpNodeChild2 = new YAHOO.widget.MenuNode(data, tmpNodeRoot, false);
							tmpNodeChild2.labelStyle = "menuLabel";
				
							data = {label:"Totals by State (Density)", href:"javascript:treeEvent('Totals by State (Density)')"}
							var tmpNodeChild3 = new YAHOO.widget.MenuNode(data, tmpNodeRoot, false);
							tmpNodeChild3.labelStyle = "menuLabel";
				
								data = {label:"Coke", href:"javascript:treeEvent('Coke')"}
								var tmpNodeChild31 = new YAHOO.widget.MenuNode(data, tmpNodeChild3, false);
								tmpNodeChild31.labelStyle = "menuLabel";
				
								data = {label:"Diet Coke", href:"javascript:treeEvent('Diet Coke')"}
								var tmpNodeChild32 = new YAHOO.widget.MenuNode(data, tmpNodeChild3, false);
								tmpNodeChild32.labelStyle = "menuLabel";
				
								data = {label:"Sprite", href:"javascript:treeEvent('Sprite')"}
								var tmpNodeChild33 = new YAHOO.widget.MenuNode(data, tmpNodeChild3, false);
								tmpNodeChild33.labelStyle = "menuLabel";
				
								data = {label:"Cherry Coke", href:"javascript:treeEvent('Cherry Coke')"}
								var tmpNodeChild34 = new YAHOO.widget.MenuNode(data, tmpNodeChild3, false);
								tmpNodeChild34.labelStyle = "menuLabel";
				
						tree.draw();
					}
				</script>
			<div id="Label2" style="font-family:Arial; text-align:justify; Font-Size:Small; width:180px;">             	
            </div>
		</div>
		<div id="right" style="height:490px; width:578px;">
			<%!
				//Global variables
				//public ConditionalAttributesCollection _condList;
				public double _pTotal;
				public double _tSales;
				public double _sTotal;
			%>
			<%
				ChartServer chart1 = new ChartServer(pageContext, request, response);
				chart1.setID("chart1");
				chart1.setUseCallbacksForEvents(true);
				chart1.addUserCallbackListener(new UserCallBackEventHandler());
			
				Map map1 = new Map();
				map1.setMapSource(application.getRealPath("/") + "/chartfx70/Library/US/USA-Regions-StatesAbrev.svg");
				// Conversion table that links data to SVG
			    map1.setLabelLinkFile(application.getRealPath("/") + "data\\US_LabelLinks.xml");
				
				//set Map attributes
			    chart1.getLegendBox().setVisible(true);
			    chart1.getAllSeries().getPointLabels().setVisible(true);
			    
			    // Data used to populate the map
			    TextProvider cfxText = new TextProvider();		    
				cfxText.open(application.getRealPath("/") + "data\\MapSalesData.txt");
				chart1.getDataSourceSettings().setDataSource(cfxText);
				cfxText.close();   
					    
			    //Set DetailLevel to the first level (Regions)
			    map1.setDetailLevel(0);
			    map1.getLabelStylesSettings().setShowThisLevelOnly(true);
			
			    //Set DefaultRule Color: This RuleAttribute is selected when no rule applies
			    map1.getDefaultAttributes().setColor(Color.GREEN);
			    map1.getDefaultAttributes().getBorder().setColor(Color.BLACK);
			    
			    //Calc Sales total
			    _tSales = 0;
			    for (int i = 0; i <= chart1.getData().getSeries() - 1; i++)
			        for (int j = 0; j <= chart1.getData().getPoints() - 1; j++)
			            _tSales = _tSales + chart1.getData().get(i, j);			    			   
			    
		 		map1.setChart(chart1);
				
		      	chart1.setWidth(578);
		        chart1.setHeight(490);
		        chart1.renderControl();
			%>
			<%!
				private void ClearAttributes(ChartServer aChart, Map aMap) {
			        aChart.getConditionalAttributes().clear();
			    }
			
			    private void set_Study2Rules(ChartServer aChart, Map aMap, ColorBlender cb)
			    {
			        aChart.getConditionalAttributes().suspendUpdate();
			        ConditionalAttributes cond = new ConditionalAttributes();
			        cond.setColor(cb.nextColor());
			        cond.setText("Low");
			        cond.getCondition().setActive(false);

			        aChart.getConditionalAttributes().add(cond);
			
			        //create rule 1 for Diet Coke and add to collection
			        cond = new ConditionalAttributes();
			        cond.setColor(cb.nextColor());
			        cond.setText("Fair");	        
			        cond.getCondition().setActive(false);

			        aChart.getConditionalAttributes().add(cond);
			
			        //create rule 2 for Sprite and add to collection
			        cond = new ConditionalAttributes();
			        cond.setColor(cb.nextColor());
			        cond.setText("Average");
			        cond.getCondition().setActive(false);

			        aChart.getConditionalAttributes().add(cond);
			
			        //create rule 3 for CherryCoke and add to collection
			        cond = new ConditionalAttributes();
			        cond.setColor(cb.nextColor());
			        cond.getCondition().setActive(false);
			        cond.setText("Above Average");

			        aChart.getConditionalAttributes().add(cond);
			
			        //create rule 4 for Dr. Pepper and add to collection
			        cond = new ConditionalAttributes();
			        cond.setColor(cb.nextColor());
			        cond.setText("High");
			        cond.getCondition().setActive(false);

			        aChart.getConditionalAttributes().add(cond);
			        aChart.getConditionalAttributes().resumeUpdate();
			
			        aMap.setDetailLevel(1);	        
			
			        aChart.getLegendBox().getItemAttributes().get(aChart.getConditionalAttributes()).setVisible(true);
			        aChart.getLegendBox().getItemAttributes().get(aChart.getSeries()).setVisible(false);
			    }
			
			    private void SetSodaAttributes(ChartServer aChart, Map aMap, String aType, Color cFrom, Color cTo) {
			        //Set button flag
			        Color clrFrom = aMap.getDefaultAttributes().getColor();
			        Color clrTo = aMap.getDefaultAttributes().getColor();
			
			        clrFrom = cFrom;
			        clrTo = cTo;			
			
			        ColorBlender cb = new ColorBlender(clrFrom, clrTo, 5);
			
			        ClearAttributes(aChart, aMap);
			        set_Study2Rules(aChart, aMap, cb);
			
			        //Calc totals for Soda
			        _pTotal = 0;
			        for (int i = 0; i <= aChart.getData().getPoints() - 1; i++)
			            _pTotal = _pTotal + aChart.getData().get(0, i);
			
			        aMap.setDetailLevel(1);
			        
			        if(aType.equalsIgnoreCase("Coke")) {
			        	aChart.addConditionalAttributesCallbackListener(new CokeEventHandler());
		              	aMap.addWinnerCallbackListener(new CokeMapWinnerCallback());
			        }
			        else if(aType.equalsIgnoreCase("Diet Coke")) {
			        	aChart.addConditionalAttributesCallbackListener(new DietCokeEventHandler());
		              	aMap.addWinnerCallbackListener(new DietCokeMapWinnerCallback());
			        }
			        else if(aType.equalsIgnoreCase("Sprite")) {
			        	aChart.addConditionalAttributesCallbackListener(new SpriteEventHandler());
		              	aMap.addWinnerCallbackListener(new SpriteMapWinnerCallback());
			        }
			        else if(aType.equalsIgnoreCase("Cherry Coke")) {
			        	aChart.addConditionalAttributesCallbackListener(new CherryCokeEventHandler());
		              	aMap.addWinnerCallbackListener(new CherryCokeMapWinnerCallback());
			        }
			        else if(aType.equalsIgnoreCase("Totals by State (Density)")) {
			        	aChart.addConditionalAttributesCallbackListener(new TotalSalesEventHandler());
						aMap.addWinnerCallbackListener(new TotalSalesMapWinnerCallback());
			        }
			        
			        aMap.recalculate();
			    }
			%>
			<%!
				public class UserCallBackEventHandler implements UserCallbackListener
				{				
					public void userCallbackEventHandler (UserCallbackEvent e)
				  	{			
						String message = "";
						String param = e.getParam();
						ChartServer chartServerSide = (ChartServer)e.getSource();
						Map mapServerSide = (Map)chartServerSide.getExtensions().get(0);
						
						if(param.equalsIgnoreCase("Soda Market Analysis")) {
							message = "";
		                    mapServerSide.setDetailLevel(0); //Show regions
		                    chartServerSide.getLegendBox().getItemAttributes().get(chartServerSide.getConditionalAttributes()).setVisible(false);
		                    chartServerSide.getLegendBox().getItemAttributes().get(chartServerSide.getSeries()).setVisible(true);
						}
						else if(param.equalsIgnoreCase("Sales by Region")) {
							message = "This map presents sales data summarized by Region. Please note the underlying data is provided by state and Chart FX Maps automatically groups and summarizes data based on groups provided in the SVG file.\r\n\r\nTo drilldown right click a region and select the Detail Level -> More Detail option to view data by state.\r\n\r\nYou can also zoom in the map by right clicking a specific state in the map";
		                    mapServerSide.setDetailLevel(0); //Show regions
		                    chartServerSide.getLegendBox().getItemAttributes().get(chartServerSide.getConditionalAttributes()).setVisible(false);
		                    chartServerSide.getLegendBox().getItemAttributes().get(chartServerSide.getSeries()).setVisible(true);
						}
						else if(param.equalsIgnoreCase("Overall Sales Winner")) {
							message = "This map colors each state according to the best selling brand. Please note the underlying data provides 4 series and Chart FX maps automatically selects the winning series and applies the color associated to that series.\r\n\r\nInspect the code and note the very few lines of code that are needed to achieve this using Chart FX Maps.";
		                    mapServerSide.setDetailLevel(1); //Shows states
		                    chartServerSide.getLegendBox().getItemAttributes().get(chartServerSide.getConditionalAttributes()).setVisible(false);
		                    chartServerSide.getLegendBox().getItemAttributes().get(chartServerSide.getSeries()).setVisible(true);
						}
						else if(param.equalsIgnoreCase("Totals by State (Density)")) {
							message = "This map summarizes all states and presents a map indicating the sales penetration for ALL brands. This map can be used to determine which state sells the most sodas. This can be easily achieved using Conditional Attributes that associate a particular color based on the actual sales percentage.\r\n\r\nPlease note how the legend box changes to reflect not the brands but the actual sales level of each state (Text contained in the Conditional Attribute)";							
							SetSodaAttributes(chartServerSide, mapServerSide, "Totals by State (Density)", new Color(210,180,140), new Color(165,42,42));
						}
						else if(param.equalsIgnoreCase("Coke")) {
							message = "This map summarizes all states and presents a map indicating the sales penetration for Coke.";									
		                    SetSodaAttributes(chartServerSide, mapServerSide, "Coke", new Color(255,192,203), Color.RED);
						}
						else if(param.equalsIgnoreCase("Diet Coke")) {
							message = "This map summarizes all states and presents a map indicating the sales penetration for Diet Coke.";							
		           			SetSodaAttributes(chartServerSide, mapServerSide, "Diet Coke", new Color(173,216,230), Color.BLUE);				
						}
						else if(param.equalsIgnoreCase("Sprite")) {
							message = "This map summarizes all states and presents a map indicating the sales penetration for Sprite.";							
		                    SetSodaAttributes(chartServerSide, mapServerSide, "Sprite", new Color(144,238,144), new Color(0,128,0));
						}
						else if(param.equalsIgnoreCase("Cherry Coke")) {
							message = "This map summarizes all states and presents a map indicating the sales penetration for Cherry Coke.";							
			              	SetSodaAttributes(chartServerSide, mapServerSide, "Cherry Coke", new Color(230,230,250), new Color(128,0,128));
						}
						
						e.setResult(String.format(message));
				  	}
				}			
				
				public class CokeMapWinnerCallback implements WinnerCallbackListener {
					public void winnerCallbackEventHandler(WinnerDelegateEvent e) {
						e.setWinnerSeries(0);
					}
				}
				
				public class DietCokeMapWinnerCallback implements WinnerCallbackListener {
					public void winnerCallbackEventHandler(WinnerDelegateEvent e) {
						e.setWinnerSeries(1);
					}
				}
				
				public class SpriteMapWinnerCallback implements WinnerCallbackListener {
					public void winnerCallbackEventHandler(WinnerDelegateEvent e) {
						e.setWinnerSeries(2);
					}
				}
				
				public class CherryCokeMapWinnerCallback implements WinnerCallbackListener {
					public void winnerCallbackEventHandler(WinnerDelegateEvent e) {
						e.setWinnerSeries(3);
					}
				}
				
				public class TotalSalesMapWinnerCallback implements WinnerCallbackListener {
					public void winnerCallbackEventHandler(WinnerDelegateEvent e) {
						e.setWinnerSeries(-1);
					}
				}
			
				public class TotalSalesEventHandler implements ConditionalAttributesListener {
					public void conditionalAttributesEventHandler(ConditionalAttributesEvent e) {
						int nFactor;
						int _sTotal = 0;
						
						ChartServer chartServerSide = (ChartServer)e.getSource();
						Map mapServerSide = (Map)chartServerSide.getExtensions().get(0);
						
						
					    if (mapServerSide.getDetailLevel() == 0)
					        nFactor = 10;
					    else
					        nFactor = 1;										        
				        
					    
				        for (int i = 0; i < chartServerSide.getData().getSeries(); i++)
				            _sTotal += chartServerSide.getData().get(i, e.getPoint());
				
				        // Select the appropriate RuleAttribute (color) depending on the sales range
				        if (_sTotal / _tSales >= (.04 * nFactor))
				            e.setAttributes(4);
				        else if (_sTotal / _tSales < (.04 * nFactor) && _sTotal / _tSales >= (.03 * nFactor))
				            e.setAttributes(3);
				        else if (_sTotal / _tSales < (.03 * nFactor) && _sTotal / _tSales >= (.02 * nFactor))
				            e.setAttributes(2);
				        else if (_sTotal / _tSales < (.02 * nFactor) && _sTotal / _tSales >= (.01 * nFactor))
				            e.setAttributes(1);
				        else
				            e.setAttributes(0);					    
				    }
				}
			
				public class CokeEventHandler implements ConditionalAttributesListener
				{
					public void conditionalAttributesEventHandler (ConditionalAttributesEvent e) {
						ChartServer chartServerSide = (ChartServer)e.getSource();
						Map mapServerSide = (Map)chartServerSide.getExtensions().get(0);
						
						int nFactor;
					    if (mapServerSide.getDetailLevel() == 0)
					        nFactor = 10;
					    else
					        nFactor = 1;
					    
					    int prod = 0;
					    
					    ruleAttributeProduct(chartServerSide, e, nFactor, prod);
				    }
				}
				
				public class DietCokeEventHandler implements ConditionalAttributesListener
				{
					public void conditionalAttributesEventHandler (ConditionalAttributesEvent e) {
						ChartServer chartServerSide = (ChartServer)e.getSource();
						Map mapServerSide = (Map)chartServerSide.getExtensions().get(0);
						
						int nFactor;
					    if (mapServerSide.getDetailLevel() == 0)
					        nFactor = 10;
					    else
					        nFactor = 1;
					    
					    int prod = 1;
					    
					    ruleAttributeProduct(chartServerSide, e, nFactor, prod);
					}
				}
				
				public class SpriteEventHandler implements ConditionalAttributesListener
				{
					public void conditionalAttributesEventHandler (ConditionalAttributesEvent e) {
						ChartServer chartServerSide = (ChartServer)e.getSource();
						Map mapServerSide = (Map)chartServerSide.getExtensions().get(0);
						
						int nFactor;
					    if (mapServerSide.getDetailLevel() == 0)
					        nFactor = 10;
					    else
					        nFactor = 1;
					    
					    int prod = 2;
					    
					    ruleAttributeProduct(chartServerSide, e, nFactor, prod);
					}
				}
				
				public class CherryCokeEventHandler implements ConditionalAttributesListener
				{
					public void conditionalAttributesEventHandler (ConditionalAttributesEvent e) {
						ChartServer chartServerSide = (ChartServer)e.getSource();
						Map mapServerSide = (Map)chartServerSide.getExtensions().get(0);
						
						int nFactor;
					    if (mapServerSide.getDetailLevel() == 0)
					        nFactor = 10;
					    else
					        nFactor = 1;
					    
					    int prod = 3;
					    
					    ruleAttributeProduct(chartServerSide, e, nFactor, prod);
					}
				}
								
				public void ruleAttributeProduct(ChartServer aChartServerSide, ConditionalAttributesEvent aE, 
						int aNFactor, int aProd)
				{			
					// Select the appropriate RuleAttribute (color) depending on the sales range
					if (aChartServerSide.getData().get(aProd, aE.getPoint()) / _pTotal >= (.04 * aNFactor))
					aE.setAttributes(4);
					else if (aChartServerSide.getData().get(aProd, aE.getPoint()) / _pTotal < (.04 * aNFactor) && 
						aChartServerSide.getData().get(aProd, aE.getPoint()) / _pTotal >= (.03 * aNFactor))
					aE.setAttributes(3);
					else if (aChartServerSide.getData().get(aProd, aE.getPoint()) / _pTotal < (.03 * aNFactor) && 
						aChartServerSide.getData().get(aProd, aE.getPoint()) / _pTotal >= (.02 * aNFactor))
					aE.setAttributes(2);
					else if (aChartServerSide.getData().get(aProd, aE.getPoint()) / _pTotal < (.02 * aNFactor) && 
						aChartServerSide.getData().get(aProd, aE.getPoint()) / _pTotal >= (.01 * aNFactor))
					aE.setAttributes(1);
					else
					aE.setAttributes(0);
				}
			%>
		</div>
	</div>	
</div>
</body>
</html>