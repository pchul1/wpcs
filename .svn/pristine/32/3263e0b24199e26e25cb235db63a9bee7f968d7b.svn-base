<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="java.awt.*"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : perseriesattributes
    Created on : Apr 22, 2008, 8:55:16 AM
    Author     : Administrator--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Aditional Axes</title>
    </head>
<script>
    function UpdateChart(IdName){	
        var seriesIndex = document.getElementById("SeriesList").selectedIndex;
		var AxisOption = document.getElementById("AxisList").selectedIndex;
        var param = seriesIndex + "," + AxisOption;
        SFX_onCallbackReadyDelegate = SFX_UpdateControls;
		SFX_SendUserCallback('chart1',param ,false);	
    }	
    function SFX_UpdateControls(id,callbackReturn) {	
		if (callbackReturn != "")
			alert(callbackReturn);							
	}    
</script>      
    <body>

    <div>
        <div id="Panel1" style="font-family: Arial; font-size: 9pt; text-decoration: none;
            width: 632px;">
            This sample illustrates how additional axes can be created to better display data
            in the chart. The chart below provides sales figures for product categories that
            have different sales levels and using a single Y axis doesn't allow end users to
            properly view and analyze data. In addition, please note an additional X axis that
            was created on the top portion of the chart to highlight quarters in the year.
        </div>
        <div id="Panel2" style="color: Blue; border-color: Silver; border-width: 1px; border-style: Double;
            font-family: Arial; font-size: 9pt; height: 69px; width: 618px;">
            &nbsp; &nbsp; Additional Y Axes<br />
            <table style="font-size: 9pt; width: 528px; color: black; font-family: Arial; height: 24px">
                <tr>
                    <td align="right" style="width: 178px; height: 21px">
                        send:&nbsp;
                    </td>
                    <td align="right" style="width: 156px; height: 21px">
                        <select name="SeriesList" id="SeriesList" style="font-family: Arial; font-size: 9pt;
                            width: 136px;">
                            <option selected="selected" value="Books">Books</option>
                            <option value="Beers">Beers</option>
                            <option value="Electronics">Electronics</option>
                            <option value="Furniture">Furniture</option>
                            <option value="Toys">Toys</option>
                            <option value="Clothing">Clothing</option>
                        </select>
                    </td>
                    <td align="right" style="width: 119px; height: 21px">
                        Series to &nbsp;</td>
                    <td style="width: 182px; height: 21px">
                        <select name="AxisList" id="AxisList" style="font-family: Arial; font-size: 9pt;
                            width: 120px;" >
                            <option value="Primary Y Axis">Primary Y Axis</option>
                            <option selected="selected" value="New Y Axis...">New Y Axis...</option>
                        </select>
                    </td>
                    <td align="center" style="width: 101px; height: 21px" valign="middle">
                        <input type="submit" name="Button1" value="Do it!" id="Button1" style="font-family: Arial;
                            font-size: 9pt; width: 56px;" onclick="UpdateChart()"/></td>
                </tr>
            </table>
        </div>
    </div>  
   
<%!
public class UserCallBackEventHandler  implements com.softwarefx.chartfx.server.UserCallbackListener
{
	public void userCallbackEventHandler (UserCallbackEvent e)
	  { 	  
				ChartServer chart1 = (ChartServer)e.getSource();		
				String[] params = e.getParam().split(",");
				int seriesIndex = Integer.parseInt(params[0]);
				int axisOption = Integer.parseInt(params[1]);
				switch(axisOption) {
					case 0:  
						if (chart1.getSeries().get(seriesIndex).getAxisY().equals(chart1.getAxisY())) {
							e.setResult("Series has already been assigned to the Primary Y Axis, please select another one...");
							break;
						}
						AxisY currentYAxis = chart1.getSeries().get(seriesIndex).getAxisY();
						chart1.getSeries().get(seriesIndex).setAxisY(chart1.getAxisY());
						// Remove the newly created Y axis as it will no longer be used 
						chart1.getAxesY().remove(currentYAxis);						
						break;
					case 1:  
						if (!chart1.getSeries().get(seriesIndex).getAxisY().equals(chart1.getAxisY())) {
							e.setResult("Series has already been assigned to a different Y Axis, please select another one...");
							break;
						}			
						AxisY AddlAxisY = new AxisY();
						AddlAxisY.setTextColor(chart1.getSeries().get(seriesIndex).getColor());
						AddlAxisY.setVisible(true);
						AddlAxisY.setPosition(AxisPosition.FAR);
						AddlAxisY.setForceZero(false);
						chart1.getAxesY().add(AddlAxisY);
						chart1.getSeries().get(seriesIndex).setAxisY(AddlAxisY);
						break;						
				}
               chart1.recalculateScale();
 
	  } 	 
}

%>
<%
	ChartServer chart1 = new ChartServer(pageContext,request,response);
	chart1.setID("chart1");
	chart1.setUseCallbacksForEvents(true);
	chart1.addUserCallbackListener(new UserCallBackEventHandler ());


	//Read external Data:
	XmlDataProvider cfxXML = new XmlDataProvider();
	//cfxXML.load(application.getRealPath("/data/ProductSalesData.txt"));
	cfxXML.load("D:\\waterkorea\\SMCube\\web\\2015_wpcs\\wpcs\\WebContent\\chartfxSample\\data\\ProductSalesData.txt");
	chart1.getDataSourceSettings().setDataSource(cfxXML);

	// Adding new X Axis
	AxisX axis = new AxisX();
	axis.setMin(0);
	axis.setMax(16);
	axis.setStep(4);
	axis.getLabels().set(4,"Q1");
	axis.getLabels().set(8,"Q2");
	axis.getLabels().set(12,"Q3");
	axis.getLabels().set(16,"Q4");
	axis.setPosition(AxisPosition.FAR);
	axis.getGrids().setInterlaced(true);
	axis.getGrids().setInterlacedColor(new Color(235, 248, 250, 128));
	java.util.EnumSet<AxisStyles> style = axis.getStyle();
	style.add(AxisStyles.CENTERED);
	axis.setStyle(style);
	chart1.getAxesX().add(axis);

	chart1.getAxisX().getGrids().getMajor().setVisible(false);
	chart1.setWidth(624);
	chart1.setHeight(500);
	chart1.renderControl();   
%>        
                        
    </body>
</html>
