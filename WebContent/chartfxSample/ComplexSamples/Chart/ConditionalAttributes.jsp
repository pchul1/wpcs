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
        <title>Conditional Attributes</title>
    </head>
<script>
    function UpdateChart(){	
        var cond = GetRadioCheckedValue("Group1");
        var Size = GetRadioCheckedValue("RadioButtonList1");
        var condValue = document.getElementById("TextBox1").value;
        var ShowLabels = document.getElementById("CheckBox1").checked;
        var MarkerShape = document.getElementById("MarkerShapeList").value;
        var Color = document.getElementById("ColorList").value;
        var param = cond + "," + condValue + "," + Size + "," + ShowLabels + "," + MarkerShape + "," + Color;        
        SFX_onCallbackReadyDelegate = SFX_UpdateControls;
		SFX_SendUserCallback('chart1',param ,false);	
    }	   
    function SFX_UpdateControls(id,callbackReturn) {	
		if (callbackReturn != "")
			alert(callbackReturn);							
	}       
	function GetRadioCheckedValue(RadioId){
		var radio = document.getElementsByName(RadioId);
		var length = radio.length;
		for (i=0; i<length; i++){
			if(radio[i].checked) 
				return radio[i].value
		}
		return 0;
	}
</script>      
    <body>

    <div>
        <div id="Panel2" style="font-family: Arial; font-size: 9pt; width: 744px;">
            This sample illustrates the use of conditional attributes. Based on the point's
            value, developers can control the way a markers look and callout conditions in the
            chart with minimal programming effort.
        </div>
        <div id="Panel1" style="border-color: Silver; border-width: 1px; border-style: Double;
            font-family: Arial; font-size: 9pt; text-decoration: none; width: 736px;">
            <table style="width: 736px; height: 1px">
                <tr>
                    <td align="right" style="width: 495px; height: 15px" valign="middle">
                        Highlight Points:</td>
                    <td colspan="2" style="width: 158px; height: 15px" valign="top">
                        <input id="RadioButton1" type="radio" name="Group1" value="1" checked="checked" /><label
                            for="RadioButton1">Greater than</label>&nbsp;<br />
                        <input id="RadioButton2" type="radio" name="Group1" value="2" /><label
                            for="RadioButton2">Lesser than</label>
                        &nbsp;
                    </td>
                    <td colspan="1" style="width: 6px; height: 15px" valign="middle">
                        <input name="TextBox1" type="text" value="30" id="TextBox1" style="height: 16px;
                            width: 64px;" /></td>
                    <td colspan="1" style="width: 541px; height: 15px" valign="middle">
                        &nbsp;with:&nbsp; <span style="display: inline-block; width: 120px;">
                            <input id="CheckBox1" type="checkbox" name="CheckBox1" /><label for="CheckBox1">Show
                                Labels</label></span></td>
                    <td align="right" colspan="3" style="height: 15px" valign="top">
                        <input type="submit" name="Button1" value="Display in Chart" id="Button1" style="height: 24px;
                            width: 112px;" onclick="UpdateChart();" /></td>
                </tr>
                <tr>
                    <td align="right" style="width: 495px; height: 5px" valign="middle">
                        Marker Size:</td>
                    <td align="left" colspan="3" style="height: 5px" valign="middle">
                        <table id="RadioButtonList1_Table" cellspacing="0" cellpadding="0" border="0" style="border-collapse: collapse;">
                            <tr>
                                <td>
                                    <input id="RadioButtonList1_0" type="radio" name="RadioButtonList1" value="1" /><label
                                        for="RadioButtonList1_0">Small</label></td>
                                <td>
                                    <input id="RadioButtonList1_1" type="radio" name="RadioButtonList1" value="3" /><label
                                        for="RadioButtonList1_1">Medium</label></td>
                                <td>
                                    <input id="RadioButtonList1_2" type="radio" name="RadioButtonList1" value="5" /><label
                                        for="RadioButtonList1_2">Large</label></td>
                            </tr>
                        </table>
                    </td>
                    <td align="center" colspan="1" style="width: 541px; height: 5px" valign="middle">
                        Marker:&nbsp;
                        <select name="MarkerShapeList" id="MarkerShapeList" style="width: 112px;">
                            <option value="CIRCLE">Circle</option>
                            <option selected="selected" value="MARBLE">Marble</option>
                            <option value="RECT">Rectangle</option>
                            <option value="CROSS">Cross</option>
                            <option value="DIAMOND">Diamond</option>
                            <option value="VERTICAL_LINE">Vertical Line</option>
                            <option value="X">X</option>
                        </select>
                    </td>
                    <td align="left" colspan="2" style="height: 5px" valign="middle">
                        &nbsp;Color:</td>
                    <td align="left" colspan="1" style="width: 89px; height: 5px" valign="middle">
                        <select name="ColorList" id="ColorList" style="width: 94px;">
                            <option selected="selected" value="BLACK">Black</option>
                            <option value="GRAY">Gray</option>                                    
                            <option value="MAGENTA">Magenta</option>
                            <option value="ORANGE">Orange</option>                                    
                            <option value="BLUE">Blue</option>
                            <option value="CYAN">Cyan</option>
                            <option value="RED">Red</option> 
                        </select>
                    </td>
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
			int iCond = Integer.parseInt(params[0]);
			int iCondValue;
			int iMarkerSize = Integer.parseInt(params[2]);
			boolean bShowLabels = Boolean.valueOf(params[3]);
			String sMarkerShape = params[4];
			String sColor = params[5];

			try 
			{
				iCondValue = Integer.parseInt(params[1]);
				if ((iCondValue > 100) | (iCondValue < 10))
					e.setResult("Please note that condition will not be visible since there are no points in the specified range. please enter a number between 10 and 100...");
			}
			catch(Exception ex)
			{
				e.setResult("Please enter a valid number to create a condition to be displayed in the chart");
				return;
			}
			chart1.getConditionalAttributes().removeAll(chart1.getConditionalAttributes());
			
			ConditionalAttributes condition1 = new ConditionalAttributes();
			if (iCond == 1)
			{
				condition1.getCondition().setFrom(iCondValue);
				condition1.getCondition().setTo(1000);
			}
			if (iCond == 2)
			{
				condition1.getCondition().setFrom(0);
				condition1.getCondition().setTo(iCondValue);				
			}
			condition1.setColor(getColor(sColor));
			condition1.getPointLabels().setVisible(bShowLabels);
			condition1.setMarkerSize((short)iMarkerSize);
			condition1.setMarkerShape(MarkerShape.valueOf(sMarkerShape));
			chart1.getConditionalAttributes().add(condition1);
			chart1.getConditionalAttributes().recalculate();
 
	  } 	 
	public Color getColor(String colorName) 
	{
        try 
        {
            // Find the field and value of colorName
            java.lang.reflect.Field field = Class.forName("java.awt.Color").getField(colorName);
            return (Color)field.get(null);
        } 
        catch (Exception e) 
        {
            return null;
        }
    }	  
}

%>
<%
	ChartServer chart1 = new ChartServer(pageContext,request,response);
	chart1.setID("chart1");
	chart1.setUseCallbacksForEvents(true);
	chart1.addUserCallbackListener(new UserCallBackEventHandler ());

	chart1.getData().setSeries(2);
	chart1.getData().setPoints(60);

	chart1.getAllSeries().setMarkerShape(MarkerShape.NONE);

	chart1.setWidth(740);
	chart1.setHeight(500);
	chart1.renderControl();
%>        
                        
    </body>
</html>
