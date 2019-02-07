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
        <title>Borders And Background</title>
    </head>
<script>
    function SetImage(){				
		document.getElementById("RadioButton3").checked = true;			
		var ImageIndex = document.getElementById("ImagesList").selectedIndex;
		var PlotAreaOnly = document.getElementById("CheckBox1").checked 		
		var param = "6," + ImageIndex + "," + PlotAreaOnly;
		SFX_SendUserCallback('chart1',param ,false);
    }
    function SetSolidColor(){					
		UpdateChart(5,'ColorList4');
		document.getElementById('RadioButton2').checked = true;	
    }
    function SetGradient(IdName){		
		document.getElementById("RadioButtonList1_1").checked = true;	
		document.getElementById("RadioButton1").checked = true;	
		var FromColor = document.getElementById("ColorList2").value;
		var ToColor = document.getElementById("ColorList3").value;
		var GradientType = document.getElementById("GradientList").value;
		var param = "10," + FromColor + "," + ToColor + "," + GradientType;
		SetLabelColor(IdName);
		SFX_SendUserCallback('chart1',param ,false);
    }
    
    function UpdateChart(option,IdName){	
        var value;
        var sValue =" ";
        value = -1;
        if (IdName!="None"){				
			sValue = document.getElementById(IdName).value;
			if (document.getElementById("RadioButtonList1_0").checked)
				value = 1;	
			else
				value = 2;
			if (IdName.substring(0,9) == "ColorList")
				SetLabelColor(IdName);
		}
		
        var param = option + "," + value + "," + sValue;
        if (option == 1)
			SFX_onCallbackReadyDelegate = SFX_UpdateControls;
		SFX_SendUserCallback('chart1',param ,false);	
    }
    function SFX_UpdateControls(id,callbackReturn) {		
		if (callbackReturn != "") {
			PopulateBorderTypes(callbackReturn);
		}
	}
	function PopulateBorderTypes(s){
	  if (s != "") {
		var DropDownList = document.getElementById("BorderTypeList");				
		for (var i=(DropDownList.options.length-1); i>=0; i--) { 
			DropDownList.options[i] = null; 			
		} 
		var stringArray = s.split(",");
		for (var i=0; i< stringArray.length; i++){
			DropDownList.options[i] = new Option(stringArray[i],stringArray[i],false,false);
		}
		UpdateChart(3,"BorderTypeList");
	  }
	}
	function SetLabelColor(Id){					
		var color = document.getElementById(Id).value;
		if (Id == "ColorList1")
			document.getElementById("lblBorderColor").style.backgroundColor = color;
		if (Id == "ColorList2")
			document.getElementById("lblFromColor").style.backgroundColor = color;
		if (Id == "ColorList3")
			document.getElementById("lblToColor").style.backgroundColor = color;
			
	}

</script>      
    <body onload="UpdateChart(1,'None');">

    <div>
        <span id="Label1" style="font-family: Arial; font-size: 9pt;">This sample illustrates
            the use of images and gradients in chart backgrounds as well as custom borders in
            the chart.</span><br />
        <table style="width: 768px; color: #0000ff; height: 136px">
            <tr>
                <td style="width: 84px; height: 168px">
                    <span style="font-size: 10pt; font-family: Arial">Borders</span><div id="Panel1"
                        style="color: Black; border-color: Silver; border-width: 1px; border-style: Double;
                        font-family: Arial; font-size: 9pt; height: 104px; width: 264px;" >
                        <table style="width: 256px; height: 104px">
                            <tr>
                                <td colspan="2" align="center" valign="middle">
                                    <table id="RadioButtonList1_Table" border="0" style="font-family: Arial; font-size: 9pt;" >
                                        <tr>
                                            <td>
                                                <input id="RadioButtonList1_0" type="radio" name="RadioButtonList1" value="Image Border"
                                                    checked="checked" onclick="UpdateChart(1,'None');"/><label for="RadioButtonList1_0">Image Border</label></td>
                                            <td>
                                                <input id="RadioButtonList1_1" type="radio" name="RadioButtonList1" value="Simple Border" onclick="UpdateChart(2,'None');"/><label
                                                        for="RadioButtonList1_1" >Simple Border</label></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 100px">
                                    <span id="lblBorderColor" style="background-color: Gray; font-family: Arial; font-size: 9pt;">
                                        Color:</span>&nbsp;</td>
                                <td style="width: 100px">
                                    <select name="ColorList1" onchange="UpdateChart(4,'ColorList1');"
                                        id="DropDownList3" style="font-family: Arial; font-size: 9pt; width: 72px;">
                                        <option value="GREEN">Green</option>
                                        <option value="BLUE">Blue</option>
                                        <option value="RED">Red</option>
                                        <option value="YELLOW">Yellow</option>
                                        <option value="ORANGE">Orange</option>
                                        <option value="CYAN">Cyan</option>
                                        <option selected="selected" value="GRAY">Gray</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" style="width: 100px">
                                    Border Type:
                                </td>
                                <td style="width: 100px">
                                    <select name="BorderTypeList" onchange="UpdateChart(3,'BorderTypeList');"
                                        id="BorderTypeList" style="font-family: Arial; font-size: 9pt; width: 136px;">
                                    </select>
                                </td>
                            </tr>
                        </table>
                    </div>
                </td>
                <td style="width: 100px; height: 168px">
                    <span style="font-size: 10pt; font-family: Arial">Background</span><div id="Panel2"
                        style="color: Black; border-color: Silver; border-width: 1px; border-style: Double;
                        font-family: Arial; font-size: 9pt; height: 104px; width: 500px;">
                        <table style="width: 504px; height: 104px">
                            <tr>
                                <td style="width: 124px" valign="middle">
                                    <span style="font-size: 9pt;">
                                        <input id="RadioButton1" type="radio" name="gpBackground" value="RadioButton1" onclick="SetGradient('RadioButton1');" /><label
                                            for="RadioButton1">Gradient</label></span></td>
                                <td style="width: 167px" align="right">
                                    <span id="lblFromColor" style="background-color: Blue; font-family: Arial;
                                        font-size: 9pt;">From Color:</span></td>
                                <td style="width: 103px">
                                    <select name="ColorList2" onchange="SetGradient('ColorList2');"
                                        id="DropDownList1" style="font-family: Arial; font-size: 9pt; width: 96px;">
                                        <option value="GREEN">Green</option>
                                        <option selected="selected" value="BLUE">Blue</option>
                                        <option value="RED">Red</option>
                                        <option value="YELLOW">Yellow</option>
                                        <option value="ORANGE">Orange</option>
                                        <option value="CYAN">Cyan</option>
                                        <option value="GRAY">Gray</option>
                                    </select>
                                </td>
                                <td style="width: 106px" align="right">
                                    <span id="lblToColor" style="background-color: Red; font-family: Arial; font-size: 9pt;">
                                        To Color:</span></td>
                                <td style="width: 85px">
                                    <select name="ColorList3" onchange="SetGradient('ColorList3');"
                                        id="DropDownList4" style="font-family: Arial; font-size: 9pt; width: 80px;">
                                        <option value="GREEN">Green</option>
                                        <option value="BLUE">Blue</option>
                                        <option selected="selected" value="RED">Red</option>
                                        <option value="YELLOW">Yellow</option>
                                        <option value="ORANGE">Orange</option>
                                        <option value="CYAN">Cyan</option>
                                        <option value="GRAY">Gray</option>
                                    </select>
                                </td>
                                <td style="width: 162px" align="center">
                                    <select name="DropDownList5" onchange="SetGradient('DropDownList5');"
                                        id="GradientList" style="font-family: Arial; font-size: 9pt; height: 24px; width: 72px;">                                        
                                        <option value="HORIZONTAL">HORIZONTAL</option>
                                        <option selected="selected"  value="VERTICAL">VERTICAL</option>
                                        <option value="BACKWARD_DIAGONAL">BACKWARD_DIAGONAL</option>
                                        <option value="FORWARD_DIAGONAL">FORWARD_DIAGONAL</option>
                                        <option value="RADIAL">RADIAL</option>
                                        <option value="ANGLED">ANGLED</option>
                                    </select>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 124px; height: 30px">
                                    <span style="font-size: 9pt;">
                                        <input id="RadioButton2" type="radio" name="gpBackground" value="RadioButton2" onclick="SetSolidColor();" /><label
                                            for="RadioButton2">Solid Color</label></span></td>
                                <td style="width: 167px; height: 30px;" align="right">
                                    <span id="lblBkColor" style="background-color: White; font-family: Arial; font-size: 9pt;">
                                        Color:</span>
                                </td>
                                <td style="width: 103px; height: 30px;">
                                    <select name="ColorList4" onchange="SetSolidColor();"
                                        id="DropDownList6" style="font-family: Arial; font-size: 9pt; width: 72px;">
                                        <option selected="selected" value="GREEN">Green</option>
                                        <option value="BLUE">Blue</option>
                                        <option value="RED">Red</option>
                                        <option value="YELLOW">Yellow</option>
                                        <option value="ORANGE">Orange</option>
                                        <option value="CYAN">Cyan</option>
                                        <option  value="GRAY">Gray</option>
                                    </select>
                                </td>
                                <td style="width: 106px; height: 30px;">
                                </td>
                                <td style="width: 85px; height: 30px;">
                                </td>
                                <td style="width: 162px; height: 30px;">
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 124px; height: 9px">
                                    <span style="font-family: Arial; font-size: 9pt;">
                                        <input id="RadioButton3" type="radio" name="gpBackground" value="RadioButton3" onclick="SetImage();" /><label
                                            for="RadioButton3">Image</label></span></td>
                                <td style="width: 167px; height: 9px">
                                </td>
                                <td style="height: 9px" colspan="2">
                                    <select name="ImagesList" onchange="SetImage();"
                                        id="DropDownList7" style="font-family: Arial; font-size: 9pt; width: 112px;">
                                        <option selected="selected" value="Beach">Beach</option>
                                        <option value="Mountains">Mountains</option>
                                        <option value="Tropical">Tropical</option>
                                        <option value="Snow">Snow</option>
                                    </select>
                                </td>
                                <td colspan="2" style="height: 9px">
                                    <span style="display: inline-block; font-family: Arial; font-size: 9pt; width: 144px;">
                                        <input id="CheckBox1" type="checkbox" name="CheckBox1" onclick="SetImage();" /><label
                                            for="CheckBox1">Apply to chart inside box only</label></span></td>
                            </tr>
                        </table>
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
				e.setResult("");
				String[] params = e.getParam().split(",");				
				int option = Integer.parseInt(params[0]);
				if (option == 10) 
				{
					String FromColor = params[1];
					String ToColor = params[2];
					String GradientType = params[3];
					SetGradientBackGround(chart1, FromColor,ToColor,GradientType);
					e.setResult(GetSimpleBorderTypes().substring(1));
				}
				else 
				{
					String sTextValue = params[2];
					int value = -1;
					boolean bValue = false;					
					if (params.length ==3 &&( params[2].compareTo("true")==0 || params[2].compareTo("false")==0))		
						bValue = Boolean.valueOf(params[2]);
					value = Integer.parseInt(params[1]);
					switch(option) 
					{
            				case 1:        
								String sResult = "";
								for (ImageBorderType imageBorderType : ImageBorderType.values()) 
								{
									  sResult += "," + imageBorderType.toString();
								}          			    
            					e.setResult(sResult.substring(1));							
               					break;
            				case 2:        
            					e.setResult(GetSimpleBorderTypes().substring(1));							
               					break;  
            				case 3:    
								if (value == 1) 
								{
									chart1.setBorder(new ImageBorder(ImageBorderType.valueOf(sTextValue)));
								}
								else 
								{
									chart1.setBorder(new SimpleBorder(SimpleBorderType.valueOf(sTextValue)));
								}							
               					break;      
               				case 4:    
								chart1.getBorder().setColor(getColor(sTextValue));
               					break;  
               				case 5:    
								chart1.setPlotAreaBackground(null);
               					chart1.setBackground(new SolidBackground());
								chart1.setBackColor(getColor(sTextValue));
               					break;             
               				case 6:    
               					SetImageBackground(chart1,value,bValue);
               					break;               					    					                   				                				               				               				      			             	
				   }
               }
               chart1.recalculateScale();
 
	  } 
    public void SetImageBackground(ChartServer chart1, int value, boolean bValue)
    {
		String ImageName = "beach.png";
		switch(value) 
		{
			case 0:
				ImageName = "beach.png";        						
				break;
			case 1:        						
				ImageName = "Mountains.png";
				break;  
			case 2:    						
				ImageName = "Snow.png";
				break;      
			case 3:    
				ImageName = "Tropical.png";
				break;             					    					                   				                				               				               				      			             	
		}
		javax.swing.ImageIcon ico = new javax.swing.ImageIcon("//javaserver/sidefx70/TestCarlos/Images/" + ImageName);
		java.awt.Image img = ico.getImage();
		ImageBackground ib = new ImageBackground();    
		ib.setImage(img);
		if (bValue)
		{ 
			chart1.setBackground(null);
			chart1.setPlotAreaBackground(ib);
		}
		else
		{
			chart1.setBackground(ib);   	
			chart1.setPlotAreaBackground(null);
		}
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
    public void SetGradientBackGround(ChartServer chart1,String FromColor, String ToColor, String GradientType) 
    { 
      GradientBackground g1 = new GradientBackground(com.softwarefx.chartfx.server.adornments.GradientType.valueOf(GradientType));
      g1.getColors().add(getColor(FromColor));
	  g1.getColors().add(getColor(ToColor));

      g1.getPosition().add(0f);
      g1.getPosition().add(0.3f);
      g1.getPosition().add(0.7f);
      g1.getPosition().add(1f);
      
      g1.getFactor().add(0f);
      g1.getFactor().add(0.2f);
      g1.getFactor().add(0.8f);
      g1.getFactor().add(1f);
      
      chart1.setBackground(g1);
      chart1.setPlotAreaBackground(null);
    }
    public String GetSimpleBorderTypes() 
    {    
		String sResult = "";
		for (SimpleBorderType simpleBorderType : SimpleBorderType.values()) 
		{
			  sResult += "," + simpleBorderType.toString();
		}     
		return sResult;
    }


}

%>
<%
	ChartServer chart1 = new ChartServer(pageContext,request,response);
	chart1.setID("chart1");
	chart1.setUseCallbacksForEvents(true);
	chart1.addUserCallbackListener(new UserCallBackEventHandler ());

	chart1.setGallery(Gallery.CUBE);
	chart1.getBorder().setColor(Color.GRAY);
	chart1.setBorder(new ImageBorder(ImageBorderType.EMBED));
	chart1.setWidth(788);
	chart1.setHeight(500);
	chart1.renderControl();
%>        
                        
    </body>
</html>
