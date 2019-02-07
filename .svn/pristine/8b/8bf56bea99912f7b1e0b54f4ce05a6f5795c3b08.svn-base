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
        <title>Axis Labels</title>
    </head>
<script>
	function SubmitOnClick(){
		var Min = document.getElementById("TextBox_Min").value;
		var Max = document.getElementById("TextBox_Max").value;
		var Step = document.getElementById("StepList").value;
		var Scale = document.getElementById("ScaleList").value;
		var Title = document.getElementById("TextBox_Title").value;
		if (Title == "")
			Title ="%NONE%";
		var param = Min + "," + Max + "," + Step + "," + Scale + "," + Title;
        SFX_SendUserCallback('chart1',param ,false);	
	}
	function UpdateAxisYFormat(option){
		var Step = document.getElementById("StepList").value;
		var param = option + "," + Step;
        SFX_onCallbackReadyDelegate = SFX_UpdateControls;
        SFX_SendUserCallback('chart1',param ,false);	
	}
	function UpdateAxisXFormat(option,IdName){
		var value = "false";
		if (IdName == "checkBox1" || IdName == "checkBox2") 
			value = document.getElementById(IdName).checked;				
		if (IdName == "ColorList" || IdName == "FontList")
			value = document.getElementById(IdName).value;
		var param = option + "," + value;   
        SFX_SendUserCallback('chart1',param ,false);	
	}
    function SFX_UpdateControls(id,callbackReturn) {	
		if (callbackReturn != "") {
			 var stringArray = callbackReturn.split(",");
			 document.getElementById("TextBox_Min").value = stringArray[0];
			 document.getElementById("TextBox_Max").value = stringArray[1];
			 document.getElementById("TextBox_Title").value = stringArray[2];
		}
	}	
    
</script>      
    <body>
    <div>
        <span id="Label1" style="font-family: Arial; font-size: 10pt;">This sample illustrates
            how to format labels in both numerical and categorical axes.</span><br />
        <br />
        <table style="width: 920px">
            <tr>
                <td style="width: 28px; height: 183px">
                    <span style="font-family: Arial"><span style="font-size: 10pt">
                        <div id="Panel1" style="border-color: Silver; border-width: 1px; border-style: Double;
                            height: 171px; width: 435px;">
                            <table style="width: 428px">
                                <tr>
                                    <td colspan="6">
                                        <strong><span style="font-size: 10pt; font-family: Arial">Y axis (Numerical) Label Settings<br />
                                            <br />
                                        </span></strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 73px; text-align: right;">
                                        Format:</td>
                                    <td colspan="5">
                                        <span style="font-family: Arial; font-size: 10pt;">
                                            <input id="radioButton1" type="radio" name="Format" value="radioButton1" checked="checked" onclick="UpdateAxisYFormat(1);"/><label
                                                for="radioButton1">Number</label></span> &nbsp; <span style="font-family: Arial;
                                                    font-size: 10pt;">
                                                    <input id="radioButton2" type="radio" name="Format" value="radioButton2" onclick="UpdateAxisYFormat(2);" /><label
                                                        for="radioButton2">Currency</label></span> &nbsp;<span style="font-family: Arial;
                                                            font-size: 10pt;"><input id="radioButton3" type="radio" name="Format" value="radioButton3"
                                                                onclick="UpdateAxisYFormat(3);" /><label
                                                                    for="radioButton3">Percentage</label></span> &nbsp;
                                        <span style="font-family: Arial; font-size: 10pt;">
                                            <input id="radioButton4" type="radio" name="Format" value="radioButton4" onclick="UpdateAxisYFormat(4);" /><label
                                                for="radioButton4">Custom</label></span></td>
                                </tr>
                                <tr>
                                    <td style="width: 73px; height: 26px; text-align: right;">
                                        <span style="font-size: 10pt; font-family: Arial">Min: </span>
                                    </td>
                                    <td style="width: 100px; height: 26px">
                                        <input name="textBox_Min" type="text" value="0" id="textBox_Min" style="font-family: Arial;
                                            font-size: 10pt; width: 61px;" /></td>
                                    <td style="width: 36px; height: 26px; text-align: right;">
                                        <span style="font-size: 10pt; font-family: Arial">Max:</span></td>
                                    <td style="width: 100px; height: 26px">
                                        <input name="textBox_Max" type="text" value="5000000" id="textBox_Max" style="font-family: Arial;
                                            font-size: 10pt; width: 53px;" /></td>
                                    <td style="width: 100px; height: 26px; text-align: right;">
                                        <span style="font-size: 10pt; font-family: Arial">Step:</span></td>
                                    <td style="width: 137px; height: 26px">
                                        <select name="StepList" id="StepList" style="font-family: Arial; font-size: 10pt;
                                            width: 96px;">
                                            <option selected="selected" value="0">0</option>
                                            <option value="200000">200000</option>
                                            <option value="500000">500000</option>
                                            <option value="1000000">1000000</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 73px; height: 26px; text-align: right;">
                                        <span style="font-size: 10pt; font-family: Arial">Title:</span></td>
                                    <td colspan="3" style="height: 26px">
                                        <input name="textBox_Title" type="text" id="textBox_Title" style="font-family: Arial; font-size: 10pt;
                                            width: 174px;" /></td>
                                    <td style="width: 100px; height: 26px; text-align: right;">
                                        <span style="font-size: 10pt; font-family: Arial">Scale:</span></td>
                                    <td style="width: 137px; height: 26px">
                                        <select name="ScaleList" id="ScaleList" style="font-family: Arial; font-size: 10pt;
                                            width: 99px;">
                                            <option selected="selected" value="100">hundreds</option>
                                            <option value="1000">thousands</option>
                                            <option value="1000000">millions</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 73px">
                                    </td>
                                    <td style="width: 100px">
                                    </td>
                                    <td style="width: 36px">
                                    </td>
                                    <td style="width: 100px">
                                    </td>
                                    <td style="width: 100px">
                                    </td>
                                    <td style="width: 137px">
                                        <input type="submit" name="Button1" value="Submit" id="Button1" style="width: 99px;" onclick="SubmitOnClick()"/></td>
                                </tr>
                            </table>
                            <br />
                        </div>
                </td>
                <td style="width: 100px; height: 183px">
                    <div id="Panel2" style="border-color: Silver; border-width: 1px; border-style: Solid;
                        height: 165px; width: 432px;">
                        <span style="font-size: 10pt; font-family: Arial"></span><span style="font-size: 10pt;
                            font-family: Arial">
                            <table style="width: 430px">
                                <tr>
                                    <td colspan="4">
                                        <strong><span style="font-size: 10pt; font-family: Arial">X axis (Categorical) Label
                                            Settings</span></strong><br />
                                        <br />
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 3847px; height: 21px; text-align: right;">
                                        <span style="font-size: 10pt; font-family: Arial">Orientation:</span></td>
                                    <td colspan="3" style="height: 21px">
                                        <span style="font-family: Arial; font-size: 10pt;">
                                            <input id="radioButton5" type="radio" name="Orientation" value="radioButton5" checked="checked" onclick="UpdateAxisXFormat(5,'radioButton5');"/><label
                                                for="radioButton5">Horizontal</label></span> &nbsp; <span style="font-family: Arial;
                                                    font-size: 10pt;">
                                                    <input id="radioButton6" type="radio" name="Orientation" value="radioButton6" onclick="UpdateAxisXFormat(6,'radioButton6');" /><label
                                                        for="radioButton6">Vertical</label></span> &nbsp; <span style="font-family: Arial;
                                                            font-size: 10pt;">
                                                            <input id="radioButton7" type="radio" name="Orientation" value="radioButton7" onclick="UpdateAxisXFormat(7,'radioButton7');" /><label
                                                                for="radioButton7">Angled</label></span></td>
                                </tr>
                                <tr>
                                    <td style="width: 3847px; height: 21px">
                                    </td>
                                    <td style="width: 3362px; height: 21px">
                                        <span style="font-family: Arial; font-size: 10pt;">
                                            <input id="checkBox1" type="checkbox" name="checkBox1" onclick="UpdateAxisXFormat(8,'checkBox1');" /><label
                                                for="checkBox1">Staggered Labels</label></span></td>
                                    <td style="width: 3525px; height: 21px">
                                    </td>
                                    <td style="width: 1552px; height: 21px">
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 3847px; text-align: right;">
                                        Font:</td>
                                    <td style="width: 3362px">
                                        <span style="font-size: 10pt; font-family: Arial">&nbsp;<select name="FontList"
                                            onchange="UpdateAxisXFormat(9,'FontList');" id="FontList">
                                            <option selected="selected" value="0">Arial, 8pt</option>
                                            <option value="1">Arial, 10pt</option>
                                            <option value="2">Times New Roman, 10pt</option>
                                            <option value="3">Tahoma, 12pt</option>
                                        </select></span></td>
                                    <td style="width: 3525px; text-align: right;">
                                        Color:</td>
                                    <td style="width: 1552px">
                                        <select name="ColorList" onchange="UpdateAxisXFormat(10,'ColorList')"
                                            id="ColorList" style="width: 94px;">
											<option selected="selected" value="BLACK">Black</option>
											<option value="BLUE">Blue</option>
											<option value="RED">Red</option>
											<option value="YELLOW">Yellow</option>
											<option value="ORANGE">Orange</option>
											<option value="CYAN">Cyan</option>
											<option  value="GRAY">Gray</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="width: 3847px; text-align: right;">
                                    </td>
                                    <td style="width: 3362px">
                                        <span style="font-size: 10pt; font-family: Arial"><span style="font-family: Arial;
                                            font-size: 10pt;">
                                            <input id="checkBox2" type="checkbox" name="checkBox2" onclick="UpdateAxisXFormat(11,'checkBox2');" /><label
                                                for="checkBox2">Hide Axis Labels</label></span></span></td>
                                    <td style="width: 3525px">
                                    </td>
                                    <td style="width: 1552px">
                                    </td>
                                </tr>
                            </table>
                            &nbsp; &nbsp;</span>
                    </div>
                </td>
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
				if (params.length > 3)
				{
					double  Min = Double.parseDouble(params[0]);
					double  Max = Double.parseDouble(params[1]);
					int Step = Integer.parseInt(params[2]);
					int Scale = Integer.parseInt(params[3]);
					switch (Scale)	
					{
						case 100:							
							chart1.getAxisY().getTitle().setText("In Hundreds");
							chart1.getAxisY().getLabelsFormat().setDecimals(0);
							break;
						case 1000:							
							chart1.getAxisY().getTitle().setText("In Thousands");
							chart1.getAxisY().getLabelsFormat().setDecimals(0);
							break;
						case 1000000:							
							chart1.getAxisY().getTitle().setText("In Millions");
							chart1.getAxisY().getLabelsFormat().setDecimals(2);
							break;
					}
					chart1.getAxisY().setScaleUnit(Scale);
					chart1.getAxisY().setMin(Min);
					chart1.getAxisY().setMax(Max);
					chart1.getAxisY().setStep(Step);
					String Title = params[4];
					if (Title.compareTo("%NONE%") != 0)
						chart1.getAxisY().getTitle().setText(Title);									
				}
				else
				{					
					int option = Integer.parseInt(params[0]);
					int value = -1;
					String sValue = "";
					boolean bValue = false;
					try
					{
						value = Integer.parseInt(params[1]);										
					}
					catch (Exception ex)
					{
						sValue = params[1];
					}
					if (params[1].compareTo("true")==0 || params[1].compareTo("false")==0)
						bValue = Boolean.valueOf(params[1]);
					switch(option) 
					{
        					case 1:  
        						ClearCustomSettings(chart1, value);
        						chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.NUMBER);
        						e.setResult(GetResult(chart1));
        						break;
        					case 2:  
        						ClearCustomSettings(chart1, value);
        						chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.CURRENCY);
        						e.setResult(GetResult(chart1));
        						break;
        					case 3:  
        						ClearCustomSettings(chart1, value);        						
        						chart1.getAxisY().getLabelsFormat().setFormat(AxisFormat.PERCENTAGE);
        						e.setResult(GetResult(chart1));
        						break;        					
        					case 4:        						
        						chart1.getAxisY().setMin(0);
								chart1.getAxisY().setMax(5000000);
								chart1.getAxisY().setStep(1000000);
								chart1.getAxisY().getTitle().setText("");
								chart1.getAxisY().getLabels().set(0,"Very Poor");
								chart1.getAxisY().getLabels().set(1,"Poor");
								chart1.getAxisY().getLabels().set(2,"Average");
								chart1.getAxisY().getLabels().set(3,"Good");
								chart1.getAxisY().getLabels().set(4,"Very Good");
								chart1.getAxisY().getLabels().set(5,"Excellent");
								chart1.getAxisY().setLabelValue(1000000);
        						e.setResult(GetResult(chart1));
        						break; 
        					case 5:     						
        						chart1.getAxisX().setLabelAngle((short)0);
        						break;        						       							
        					case 6:     						
        						chart1.getAxisX().setLabelAngle((short)90);
        						break; 
        					case 7:     						
        						chart1.getAxisX().setLabelAngle((short)45);
        						break;     
        					case 8:     						
        						chart1.getAxisX().setStaggered(bValue);
        						break;
        					case 9:     					
								switch(value) 
								{
        							case 0:          						
        								chart1.getAxisX().setFont(new java.awt.Font("Arial",java.awt.Font.PLAIN,8));
        								break;        								
        							case 1:          						
        								chart1.getAxisX().setFont(new java.awt.Font("Arial",java.awt.Font.PLAIN,10));
        								break;        							
        							case 2:          						
        								chart1.getAxisX().setFont(new java.awt.Font("Times New Roman",java.awt.Font.PLAIN,10));
        								break;
        							case 3:          						
        								chart1.getAxisX().setFont(new java.awt.Font("Tahoma",java.awt.Font.PLAIN,12));
        								break;        							        							
        						}
        						break;
        					case 10:     						
        						chart1.getAxisX().setTextColor(getColor(sValue));
        						break; 
        					case 11:     						
        						chart1.getAxisX().setVisible(!bValue);
        						break;          						    						        						
				   }			
				}
               chart1.recalculateScale();
 
	  } 
	 public void ClearCustomSettings(ChartServer chart1, int step) 
	 {    
		chart1.getAxisY().getLabels().removeAll(chart1.getAxisY().getLabels());
		chart1.getAxisY().setLabelValue(1);
		chart1.getAxisY().setStep(step);
     }
	 public String GetResult(ChartServer chart1) 
	 {    
		String sResult = "";
		String Min = String.valueOf(chart1.getAxisY().getMin());
		String Max = String.valueOf(chart1.getAxisY().getMax());
		String Title = chart1.getAxisY().getTitle().getText();
		if (Title == null)
			Title = "";
		sResult = String.format("%s,%s,%s",Min,Max,Title);		
		return sResult;
    }    
    public Color getColor(String colorName) 
    {
        try {
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

	chart1.setGallery(Gallery.BAR);

	XmlDataProvider cfxXML = new XmlDataProvider();      
	//cfxXML.load(application.getRealPath("\\data\\ProductSales.txt")); 
	cfxXML.load("D:\\DATA1\\SMCube\\web\\2015_wpcs\\wpcs\\WebContent\\chartfxSample\\data\\ProductSales.txt"); 
	chart1.getDataSourceSettings().setDataSource(cfxXML);

	TitleDockable title = new TitleDockable();
	title.setText("Sales for XYZ Corp.");
	chart1.getTitles().add(title);

	chart1.setWidth(900);
	chart1.setHeight(500);
	chart1.renderControl();
%>         
                        
    </body>
</html>
