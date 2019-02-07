<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
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
        <title>Transparency</title>
    </head>
<script>
    function UpdateChart(IdName){	
        var value = 10;	
        GetRadioButtonValue();
        var transparencyValue = document.getElementById(IdName).value;		
        if (IdName != "ChartObjectsList")			
			value = document.getElementById("ChartObjectsList").selectedIndex;
		else {
			transparencyValue = document.getElementById("ChartObjectsList").selectedIndex;
			SFX_onCallbackReadyDelegate = SFX_UpdateControls;
		}
        var param = value + "," + transparencyValue;
		SFX_SendUserCallback('chart1',param ,false);	
    }
    function SFX_UpdateControls(id,callbackReturn) {
		if (callbackReturn != "") {
			document.getElementById("RadioButtonList1_" + callbackReturn).checked = true;			
		}
	}
	function GetRadioButtonValue(){
		var radio = document.getElementsByName("RadioButtonList1");		
		var i;
		for (i=0; i< radio.length; i++){
			if(radio[i].checked) {
				return radio[i].value;				
			}
		}
	}	
    
</script>      
    <body>
    <div>
        <div id="Panel1" style="font-family: Arial; font-size: 9pt; height: 50px; width: 784px;">
            This sample illustrates the effect of color transparency in a fairly complex 3D
            chart. We used several Chart FX features to create a chart with a background image,
            axis sections and other elements that take a color setting. With the controls dsiplayed
            below, you can set the transparency setting for each of these elements and see its
            effect in the chart.
        </div>
        <br />
        <div id="Panel2" style="color: Blue; border-color: Silver; border-width: 1px; border-style: Double;
            font-family: Arial; font-size: 9pt; width: 775px;">
            &nbsp;&nbsp; Transparency<br />
            <table style="font-size: 9pt; width: 776px; color: black; font-family: Arial; height: 40px">
                <tr>
                    <td style="width: 170px; height: 21px">
                        First, select a chart object:</td>
                    <td style="width: 53px; height: 21px">
                        <select name="ChartObjectsList" onchange="UpdateChart('ChartObjectsList')"
                            id="DropDownList1" style="font-family: Arial; font-size: 9pt; width: 160px;">
                            <option selected="selected" value="Series1">Series1</option>
                            <option value="Series2">Series2</option>
                            <option value="Legend Box">Legend Box</option>
                            <option value="3D Box">3D Box</option>
                            <option value="Chart Title">Chart Title</option>
                            <option value="Axis Section">Axis Section</option>
                        </select>
                    </td>
                    <td align="right" style="width: 221px; height: 21px">
                        Now, set its transparency level:</td>
                    <td align="center" style="width: 100px; height: 21px">
                        <table id="RadioButtonList1" border="0" style="font-family: Arial; font-size: 9pt;
                            height: 26px; width: 260px;">
                            <tr>
                                <td>
                                    <input id="RadioButtonList1_0" type="radio" name="RadioButtonList1" value="254" checked="checked" onclick="UpdateChart('RadioButtonList1_0')" /><label
                                        for="RadioButtonList1_0">Opaque</label></td>
                                <td>
                                    <input id="RadioButtonList1_1" type="radio" name="RadioButtonList1" value="192" onclick="UpdateChart('RadioButtonList1_1')" /><label
                                        for="RadioButtonList1_1">25%</label></td>
                                <td>
                                    <input id="RadioButtonList1_2" type="radio" name="RadioButtonList1" value="128" onclick="UpdateChart('RadioButtonList1_2')" /><label
                                        for="RadioButtonList1_2">50%</label></td>
                                <td>
                                    <input id="RadioButtonList1_3" type="radio" name="RadioButtonList1" value="64" onclick="UpdateChart('RadioButtonList1_3')" /><label
                                        for="RadioButtonList1_3">75%</label></td>
                                <td>
                                    <input id="RadioButtonList1_4" type="radio" name="RadioButtonList1" value="0" onclick="UpdateChart('RadioButtonList1_4')" /><label
                                        for="RadioButtonList1_4">Full</label></td>
                            </tr>
                        </table>
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
		e.setResult("");
		String[] params = e.getParam().split(",");
		int option = Integer.parseInt(params[0]);
		int transparencyValue = Integer.parseInt(params[1]);							
		switch(option) 
		{
			case 0:  
				chart1.getSeries().get(0).setColor(setNewColor(chart1.getSeries().get(0).getColor(),transparencyValue));        					     					
				break;         
			case 1:  
				chart1.getSeries().get(1).setColor(setNewColor(chart1.getSeries().get(1).getColor(),transparencyValue));        					     					
				break;  
			case 2:  
				chart1.getLegendBox().setBackColor(setNewColor(chart1.getLegendBox().getBackColor(),transparencyValue));        					     					
				break;  
			case 3:  
				chart1.setPlotAreaColor(setNewColor(chart1.getPlotAreaColor(),transparencyValue));        					     					
				break;  
			case 4:  
				chart1.getTitles().get(0).setTextColor(setNewColor(chart1.getTitles().get(0).getTextColor(),transparencyValue));
				break; 
			case 5:          					
				chart1.getAxisY().getSections().get(0).setBackColor(setNewColor(chart1.getAxisY().getSections().get(0).getBackColor(),transparencyValue));        					     					
				break;        					         					        					        					        					          					    					        
			case 10:   
				String sTransparencyValue = GetTransparencyValue(transparencyValue,chart1);
				e.setResult(sTransparencyValue);     						
				break;        					           				                				               				               				      			             	
		}
		chart1.recalculateScale();
	} 
    public String GetTransparencyValue(int index,ChartServer chart1) 
    {    
		String sResult = "";
		switch(index) {
				case 0:   
					sResult = LookForIndex(chart1.getSeries().get(0).getColor().getAlpha());     						
   					break;
				case 1:   
					sResult = LookForIndex(chart1.getSeries().get(1).getColor().getAlpha());     						
   					break;
				case 2:   
					sResult = LookForIndex(chart1.getLegendBox().getBackColor().getAlpha());     						
   					break;
				case 3:   
					sResult = LookForIndex(chart1.getPlotAreaColor().getAlpha());     						
   					break;
				case 4:   
					sResult = LookForIndex(chart1.getTitles().get(0).getTextColor().getAlpha());     						
   					break;  
   				case 5:   
					sResult = LookForIndex(chart1.getAxisY().getSections().get(0).getBackColor().getAlpha());     						
   					break; 
   										   					   					   					
		}
		return sResult;
    }
    public Color setNewColor(Color color, int transparencyValue) 
    {    
		return new Color(color.getRed(),color.getGreen(),color.getBlue(),transparencyValue);
    }
	private String LookForIndex(int Alpha)
	{
		switch (Alpha)
		{
			case 0:
				return "4";
			case 64:
				return "3";
			case 128:
				return "2";
			case 192:
				return "1";
			case 254:
				return "0";
		}
		return "0";
	}    

}

%>
<%
	ChartServer chart1 = new ChartServer(pageContext,request,response);
	chart1.setID("chart1");
	chart1.setUseCallbacksForEvents(true);
	chart1.addUserCallbackListener(new UserCallBackEventHandler ());

	chart1.getData().setSeries(2);
	chart1.getData().setPoints(24);
	AxisSection section = new AxisSection(30,70,new java.awt.Color(208, 197, 227));
	chart1.getAxisY().getSections().add(section);
	chart1.setGallery(Gallery.AREA);
	chart1.getView3D().setEnabled(true);

	TitleDockable title = new TitleDockable();
	title.setFont(new java.awt.Font("Arial",java.awt.Font.PLAIN,20));
	title.setText("Chart Title");
	title.setTextColor(new java.awt.Color(102, 102, 102));
	chart1.getTitles().add(title);

	chart1.getData().setSeries(2);
	chart1.getData().setPoints(24);
	java.util.Random r = new java.util.Random(1);
	int i;
	for (i=0;i<24;i++) {
		chart1.getData().set(0, i,r.nextDouble()* 50);
		chart1.getData().set(1, i,r.nextDouble()* 100);
	}

	javax.swing.ImageIcon ico = new javax.swing.ImageIcon(application.getRealPath("/") + "/data/BackgroundImage.png");
	java.awt.Image img = ico.getImage();
	ImageBackground ib = new ImageBackground();    
	ib.setImage(img);
	chart1.setBackground(ib);

	chart1.setWidth(780);
	chart1.setHeight(500);
	chart1.renderControl();
%>        
                        
    </body>
</html>
