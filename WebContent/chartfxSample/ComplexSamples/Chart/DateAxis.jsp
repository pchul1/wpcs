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
        <title>Date Axis</title>
    </head>
<script>
    function UpdateChart(IdName){	
        var value = document.getElementById("DropDownList1").selectedIndex;
		var bvalue = document.getElementById("CheckBox1").checked;
        var param = value + "," + bvalue;
		SFX_SendUserCallback('chart1',param ,false);	
    }	
    
</script>      
    <body>

    <div>
        <div id="Panel1" style="font-family: Arial; font-size: 9pt; height: 56px; width: 776px;">
            This sample demonstrates the use of dates in the X axis. When dates are present
            they are passed as XValues allowing you to automatically display labels in weeks,
            months, quarters or years using the Axis Step property. This behavior is controlled
            by the Combobox displayed below. The Compact Data option demonstrates how Chart
            FX can compact data using a summary function. In this case, when the Compact Data
            option is checked, Chart FX will reduce the number of points calculating the Average
            price.
        </div>
        <br />
        <table style="width: 776px;">
            <tr>
                <td align="right" style="width: 2266px;">
                    &nbsp;&nbsp;<span id="Label2" style="font-family: Arial; font-size: 9pt;">Display Labels:</span></td>
                <td align="center" style="width: 153px;">
                    <select name="DropDownList1" onchange="UpdateChart('DropDownList1');"
                        id="DropDownList1" style="font-family: Arial; font-size: 9pt; width: 104px;">
                        <option selected="selected" value="Weekly">Weekly</option>
                        <option value="15-days">15-days</option>
                        <option value="Monthly">Monthly</option>
                        <option value="Yearly">Yearly</option>
                    </select>
                    &nbsp;</td>
                <td style="width: 236px">
                    <span style="display: inline-block; font-family: Arial; font-size: 9pt; width: 176px;">
                        <input id="CheckBox1" type="checkbox" name="CheckBox1" onclick="UpdateChart('CheckBox1');" /><label
                            for="CheckBox1">Compact Data</label></span></td>
            </tr>
        </table>
    </div>
   
<%!
public class UserCallBackEventHandler  implements com.softwarefx.chartfx.server.UserCallbackListener
{
	public void userCallbackEventHandler (UserCallbackEvent e)
	  { 	  
		ChartServer chart1 = (ChartServer)e.getSource();		
		String[] params = e.getParam().split(",");
		int value = Integer.parseInt(params[0]);
		boolean bValue = Boolean.valueOf(params[1]);
		CompactData(chart1, value, bValue); 
        chart1.recalculateScale();
 
	  } 	 
	 public void CompactData(ChartServer chart1, int value, boolean bValue)
	 {
		chart1.getData().getY().setCompactFormula(CompactFormulas.getAverage());
		int CompactNumber = 0;
		switch(value) 
		{
			case 0:    
				chart1.getAxisX().setStep((short) 0);
				chart1.getAxisX().getLabelsFormat().setCustomFormat("dd");  
				chart1.getAxisX().setStaggered(false);
				chart1.getAxisX().setLabelAngle((short)90);
				if (bValue)
					CompactNumber = 7;
				break;
			case 1:      
				chart1.getAxisX().getLabelsFormat().setCustomFormat("MM-dd");  
				chart1.getAxisX().setLabelAngle((short)90);			
				chart1.getAxisX().setStep((short) 15);
				if (bValue)
					CompactNumber = 15;
				break;
			case 2:      
				chart1.getAxisX().setStaggered(false);
				chart1.getAxisX().setLabelAngle((short)0);			
				chart1.getAxisX().setStep((short) 30);
				if (bValue)
					CompactNumber = 30;
				break;				
			case 3:      				
				chart1.getAxisX().setLabelAngle((short)0);			
				chart1.getAxisX().setStep((short) 365);
				if (bValue)
					CompactNumber = 365;
				break;				
		}	
		
		chart1.getData().compact(CompactNumber);
	 }
}

%>
<%
	ChartServer chart1 = new ChartServer(pageContext,request,response);
	chart1.setID("chart1");
	chart1.setUseCallbacksForEvents(true);
	chart1.addUserCallbackListener(new UserCallBackEventHandler ());

	TextProvider txtProvider = new TextProvider();
	txtProvider.open(application.getRealPath("/") + "/data/marketdata.txt");
	txtProvider.setDateFormat("M/d/yyyy h:mm:s tt");
	chart1.getDataSourceSettings().getFields().add(new FieldMap("date",FieldUsage.LABEL));
	chart1.getDataSourceSettings().getFields().add(new FieldMap("open",FieldUsage.VALUE));   
	chart1.getDataSourceSettings().setDataSource(txtProvider);
	txtProvider.close();

	chart1.getAxisX().getLabelsFormat().setFormat(AxisFormat.DATE_TIME);
	chart1.getAxisX().getLabelsFormat().setCustomFormat("MMM-dd-yy");

	chart1.getAxisY().setForceZero(false);
	chart1.getAxisY().getLabelsFormat().setDecimals((short)2);

	TitleDockable title = new TitleDockable();
	title.setText("Stock Price for XYZ Corp.");
	chart1.getTitles().add(title);

	chart1.getAllSeries().setMarkerSize((short)2);
	chart1.getAllSeries().setMarkerShape(MarkerShape.MARBLE);

	chart1.setWidth(780);
	chart1.setHeight(500);
	chart1.renderControl();
%>        
                        
    </body>
</html>
