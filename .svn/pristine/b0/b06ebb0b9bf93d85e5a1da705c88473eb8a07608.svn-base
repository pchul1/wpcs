<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="java.awt.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : perseriesattributes
    Created on : Apr 22, 2008, 8:55:16 AM
    Author     : Administrator
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Per Series Attributes</title>
    </head>
    <body>
        <script>
    function UpdateChart(option,IdName){
		var value = document.getElementById(IdName).selectedIndex;
		var SeriesIndex = document.getElementById("ListBox1").selectedIndex;						
		if (IdName=="CheckBox1" || IdName=="CheckBox2")
			value = document.getElementById(IdName).checked;
		if (value == null)
			value = -1;					
		var param = option + "," + SeriesIndex + "," + value;
		var LastSeriesIndex = document.getElementById("ListBox1").options.length - 1;
		var b = (IdName == "btnUp" && SeriesIndex == 0) || (IdName == "btnDown" && SeriesIndex == LastSeriesIndex);
		DisplayButtons(SeriesIndex);
	
		if (!b) {
				SFX_onCallbackReadyDelegate = SFX_UpdateControls;
				SFX_SendUserCallback('chart1',param ,false);
			}
			else
				alert("Not allowed");
        
    }
    function SFX_UpdateControls(id,callbackReturn)
	{
	    if (callbackReturn != "") {			
			  var stringArray = callbackReturn.split(","); 	
			  if (stringArray.length < 4) {	  
				  if (stringArray[0] == "ReadyToChangeListBox") {
				     var SeriesIndex = parseInt(stringArray[1]);
				     var LastSeriesIndex = document.getElementById("ListBox1").options.length - 1;
					 if (stringArray[2] == "LastSeriesIndex"){
						swapOptions(SeriesIndex,LastSeriesIndex);
						DisplayButtons(SeriesIndex);
						}
					else {
						swapOptions(SeriesIndex,parseInt(stringArray[2]));
						DisplayButtons(parseInt(stringArray[2]));
						}						
				  }
				  if (stringArray[0] == "ReadyToChangeColor") {
					 SetLabelColor(parseInt(stringArray[1]));
				  }
				  if (stringArray[0] == "ReadyToUpdateShapeTD"){ 
					 SelectShape(stringArray[1]);
					 }
					 
			  }
			  else {			
					SetLabelColor(parseInt(stringArray[3]));
					document.getElementById("DropDownList1").selectedIndex = stringArray[0];
					document.getElementById("DropDownList5").selectedIndex = stringArray[1];
					document.getElementById("DropDownList2").selectedIndex = stringArray[2];
					document.getElementById("DropDownList4").selectedIndex = stringArray[3];
					if (stringArray[4] == "true")
						document.getElementById("CheckBox1").checked = true;
					else
						document.getElementById("CheckBox1").checked = false;
					if (stringArray[5] == "true")
						document.getElementById("CheckBox2").checked = true;
					else
						document.getElementById("CheckBox2").checked = false;
					SelectShape(stringArray[6]);
			  }
	    }
	}
	function DisplayButtons(SeriesIndex){
		var LastSeriesIndex = document.getElementById("ListBox1").options.length - 1;
		if (SeriesIndex < LastSeriesIndex)
			document.getElementById("btnSendToBack").style.visibility = "visible";
		else
			document.getElementById("btnSendToBack").style.visibility = "hidden";
			
		if (SeriesIndex > 0)
			document.getElementById("btnBringToFront").style.visibility = "visible";
		else
			document.getElementById("btnBringToFront").style.visibility = "hidden";
	}
	function SelectShape(shape){
		if (shape == "lines"){
			document.getElementById("tdBarShape1").style.visibility = "hidden";
			document.getElementById("tdBarShape2").style.visibility = "hidden";
			document.getElementById("tdMarkerShape1").style.visibility = "visible";
			document.getElementById("tdMarkerShape2").style.visibility = "visible";
		}
		if (shape == "bar"){
			document.getElementById("tdMarkerShape1").style.visibility = "hidden";
			document.getElementById("tdMarkerShape2").style.visibility = "hidden";
			document.getElementById("tdBarShape1").style.visibility = "visible";
			document.getElementById("tdBarShape2").style.visibility = "visible";
		}
		if (shape == "area"){
			document.getElementById("tdMarkerShape1").style.visibility = "hidden";
			document.getElementById("tdMarkerShape2").style.visibility = "hidden";
			document.getElementById("tdBarShape1").style.visibility = "hidden";
			document.getElementById("tdBarShape2").style.visibility = "hidden";
		}
		
	}	
	function SetLabelColor(i){		
		var label = document.getElementById("lblColor");
		switch(i) {
		case 1:
		  label.style.backgroundColor = 'green';
		  break;  
		case 2:
		  label.style.backgroundColor = 'blue';
		  break;  
		case 3:
		  label.style.backgroundColor = 'red';
		  break;  
		case 4:
		  label.style.backgroundColor = 'yellow';
		  break;  
		case 5:
		  label.style.backgroundColor = 'orange';
		  break;  
		case 6:
		  label.style.backgroundColor = 'cyan';
		  break;  		  
		}
	}
	function swapOptions(i,j) {
		var o = document.getElementById("ListBox1").options;
		var i_selected = o[i].selected;
		var j_selected = o[j].selected;
		var temp = new Option(o[i].text, o[i].value, o[i].defaultSelected, o[i].selected);
		var temp2= new Option(o[j].text, o[j].value, o[j].defaultSelected, o[j].selected);
		o[i] = temp2;
		o[j] = temp;
		o[i].selected = j_selected;
		o[j].selected = i_selected;
	}
		
    </script>  
 
     <div id="Panel2" style="font-family: Arial; font-size: 9pt; height: 32px; width: 568px;">
        This sample illustrates different settings that can be applied to individual series
        in the chart.
    </div>
    <div id="Panel1" style="color: Blue; border-color: Silver; border-width: 1px; border-style: Double;
        font-family: Arial; font-size: 9pt; height: 181px; width: 780px;">
        &nbsp;Series Attributes<br />
        <br />
        <table style="font-size: 9pt; color: black; font-family: Arial; height: 120px; width: 760px;">
            <tr>
                <td align="right" rowspan="4" style="width: 89px" valign="top">
                    Select a Series:</td>
                <td rowspan="4" style="width: 100px">
                    <select size="4" name="ListBox1" onchange="UpdateChart(1,'ListBox1');" id="ListBox1"
                        style="font-family: Arial; font-size: 9pt; height: 120px; width: 120px;">
                        <option selected="selected" value="Beers and Wine">Beers and Wine</option>
                        <option value="Electronics">Electronics</option>
                        <option value="Bedding and Linens">Bedding and Linens</option>
                        <option value="Toys and Sports">Toys and Sports</option>
                    </select>
                </td>
                <td style="width: 96px" align="right">
                    <input onclick="UpdateChart(8,'btnUp');" type="submit" name="btnUp" value="Up" id="btnUp" style="font-family: Arial;
                        font-size: 9pt; width: 88px;" /></td>
                <td style="width: 71px" align="right">
                    Gallery:</td>
                <td style="width: 133px">
                    <select name="DropDownList1" onchange="UpdateChart(2,'DropDownList1');"
                        id="DropDownList1" style="font-family: Arial; font-size: 9pt; width: 104px;">
                        <option selected="selected" value="Lines">Lines</option>
                        <option value="Bar">Bar</option>
                        <option value="Area">Area</option>
                        <option value="Curve">Curve</option>
                        <option value="Cube">Cube</option>
                        <option value="Step">Step</option>
                    </select>
                </td>
                <td style="width: 85px" align="right" id="tdMarkerShape1">
                    <span id="Label1" style="font-family: Arial; font-size: 9pt;">Marker Shape:</span></td>
                <td style="width: 81px" id="tdMarkerShape2">
                    <select name="DropDownList2" onchange="UpdateChart(3,'DropDownList2');"
                        id="DropDownList2" style="font-family: Arial; font-size: 9pt; width: 80px;">
                        <option value="None">None</option>
                        <option value="Rect">Rect</option>
                        <option value="Circle">Circle</option>
                        <option value="Triangle">Triangle</option>
                        <option value="Diamond">Diamond</option>
                        <option selected="selected" value="Marble">Marble</option>
                        <option value="HorizontalLine">HorizontalLine</option>
                        <option value="VerticalLine">VerticalLine</option>
                        <option value="Cross">Cross</option>
                        <option value="InvertedTriangle">InvertedTriangle</option>
                        <option value="X">X</option>
                        <option value="Picture">Picture</option>
                        <option value="Many">Many</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td style="width: 96px; height: 24px;" align="right">
                    <input onclick="UpdateChart(9,'btnDown');" type="submit" name="btnDown" value="Down" id="btnDown" style="font-family: Arial;
                        font-size: 9pt; width: 88px;" /></td>
                <td style="width: 71px; height: 24px;" align="right" abbr="lblColor">
                    <span id="lblColor" style="background-color: blue; font-family: Arial; font-size: 9pt;">
                        Color:</span></td>
                <td style="width: 133px; height: 24px;">
                    <select name="DropDownList4" onchange="UpdateChart(4,'DropDownList4');"
                        id="DropDownList4" style="font-family: Arial; font-size: 9pt; width: 104px;">
                        <option selected="selected" value="Select a Color">Select a Color</option>
                        <option value="Green">Green</option>
                        <option selected="selected" value="Blue">Blue</option>
                        <option value="Red">Red</option>
                        <option value="Yellow">Yellow</option>
                        <option value="Orange">Orange</option>
                        <option value="Cyan">Cyan</option>
                    </select>
                </td>
                <td style="width: 85px; visibility: hidden;" align="right" id="tdBarShape1">
                    <span id="Label1" style="font-family: Arial; font-size: 9pt;">Bar Shape:</span></td>
                <td style="width: 81px; visibility: hidden;" id="tdBarShape2">
                    <select name="DropDownList5" onchange="UpdateChart(5,'DropDownList5');"
                        id="DropDownList2" style="font-family: Arial; font-size: 9pt; width: 80px;">
                        <option value="Bar">Bar</option>
                        <option value="Cylinder">Cylinder</option>
                        <option value="Cone">Cone</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td style="width: 96px; height: 24px; visibility: hidden" align="right">
                    <input  onclick="UpdateChart(10,'btnBringToFront');" type="submit" name="btnBringToFront" value="Bring To Front" id="btnBringToFront"
                        style="font-family: Arial; font-size: 9pt; width: 88px;" /></td>
                <td style="height: 24px; width: 71px;" align="right">
                    &nbsp;</td>
                <td style="width: 133px; height: 24px;">
                    <span style="font-family: Arial; font-size: 9pt;">
                        <input id="CheckBox1" type="checkbox" name="CheckBox1" onclick="UpdateChart(6,'CheckBox1');" /><label
                            for="CheckBox1">Show Pont Labels</label></span></td>
                <td style="width: 85px; height: 24px;">
                </td>
                <td style="width: 81px; height: 24px;">
                </td>
            </tr>
            <tr>
                    <td style="width: 96px" align="right">
                        <input onclick="UpdateChart(11,'btnSendToBack');" type="submit" name="btnSendToBack" value="Send To Back" id="btnSendToBack" style="font-family:Arial;font-size:9pt;width:88px;" /></td>
                <td align="right" style="width: 71px">
                    &nbsp;&nbsp;
                </td>
                <td style="width: 133px">
                    <span style="font-family: Arial; font-size: 9pt;">
                        <input id="CheckBox2" type="checkbox" name="CheckBox2" onclick="UpdateChart(7,'CheckBox2');" /><label
                            for="CheckBox2">Show Y Axis</label></span></td>
                <td style="width: 85px">
                </td>
                <td style="width: 81px">
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
		int option = Integer.parseInt(params[0]);
		int SeriesIndex = Integer.parseInt(params[1]);					
		int value = -1;
		boolean bValue = false;
		
		if (params[2].compareTo("true")==0 || params[2].compareTo("false")==0)		
			bValue = Boolean.valueOf(params[2]);
		else
			value = Integer.parseInt(params[2]);	
		e.setResult("");
		switch(option) {
				case 1:            		
					String iGallery = GetGalleryIndex(chart1, SeriesIndex);
					String iBarShape = GetBarShapeIndex(chart1, SeriesIndex);
					String iMarkerShape = GetMarkerShapeIndex(chart1, SeriesIndex);
					String iColor = GetColorIndex(chart1, SeriesIndex);
					boolean bSeriesPointLabels = chart1.getSeries().get(SeriesIndex).getPointLabels().isVisible();
					boolean bShowYAxis = (chart1.getAxisY2() == chart1.getSeries().get(SeriesIndex).getAxisY());
					String sShape = "lines";
					if (iGallery == "1" || iGallery == "4")
						sShape = "bar";
					if (iGallery == "2")
						sShape = "area";
				    
					e.setResult(String.format("%s,%s,%s,%s,%s,%s,%s",iGallery,iBarShape,iMarkerShape, iColor, bSeriesPointLabels,bShowYAxis,sShape));							
   					break;
   				case 2:            		
   					sShape = "lines";
					if (value == 1 || value == 4)
						sShape = "bar";
					if (value == 2)
						sShape = "area";
   					e.setResult(String.format("%s,%s","ReadyToUpdateShapeTD",sShape));
					switch(value) {
						case 0: 
							chart1.getSeries().get(SeriesIndex).setGallery(Gallery.LINES);
						break;
						case 1: 
							chart1.getSeries().get(SeriesIndex).setGallery(Gallery.BAR);
						break;
						case 2: 
							chart1.getSeries().get(SeriesIndex).setGallery(Gallery.AREA);
						break;
						case 3: 
							chart1.getSeries().get(SeriesIndex).setGallery(Gallery.CURVE);
						break;
						case 4: 
							chart1.getSeries().get(SeriesIndex).setGallery(Gallery.CUBE);
						break;
						case 5: 
							chart1.getSeries().get(SeriesIndex).setGallery(Gallery.STEP);
						break;
					}
   					break;
   				 case 3:            		
					chart1.getSeries().get(SeriesIndex).setMarkerShape(MarkerShape.values()[value]);
   					break;	
   				 case 4:            		
   					e.setResult(String.format("%s,%s","ReadyToChangeColor",Integer.toString(value)));
					switch(value) {
						case 1: 
							chart1.getSeries().get(SeriesIndex).setColor(Color.GREEN);
						break;
						case 2: 
							chart1.getSeries().get(SeriesIndex).setColor(Color.BLUE);
						break;
						case 3: 
							chart1.getSeries().get(SeriesIndex).setColor(Color.RED);
						break;
						case 4: 
							chart1.getSeries().get(SeriesIndex).setColor(Color.YELLOW);
						break;
						case 5: 
							chart1.getSeries().get(SeriesIndex).setColor(Color.ORANGE);
						break;
						case 6: 
							chart1.getSeries().get(SeriesIndex).setColor(Color.CYAN);            						
						break;
					}
   					break;
   				case 5:            		
					switch(value) {
						case 0: 
							chart1.getSeries().get(SeriesIndex).setBarShape(BarShape.RECTANGLE);
						break;
						case 1: 
							chart1.getSeries().get(SeriesIndex).setBarShape(BarShape.CYLINDER);
						break;
						case 2: 
							chart1.getSeries().get(SeriesIndex).setBarShape(BarShape.CONE);
						break;
					}
   					break;
   				case 6:            		
					chart1.getSeries().get(SeriesIndex).getPointLabels().setVisible(bValue);              			    	
   					break;
   				case 7:     
   					if (bValue)
   						chart1.getSeries().get(SeriesIndex).setAxisY(chart1.getAxisY2());  		
   					else
   						chart1.getSeries().get(SeriesIndex).setAxisY(chart1.getAxisY());							
   					break; 
   				case 8:            		
					SeriesAttributesCollection series1 = chart1.getSeries(); 
					SeriesAttributes currentSeries1 = chart1.getSeries().get(SeriesIndex);
					series1.removeAt(SeriesIndex);							            			    	
					series1.insert(SeriesIndex-1,currentSeries1);
					e.setResult(String.format("%s,%s,%s","ReadyToChangeListBox",SeriesIndex ,SeriesIndex-1));
   					break; 
   				case 9:            		
					series1 = chart1.getSeries(); 
					currentSeries1 = chart1.getSeries().get(SeriesIndex);
					series1.removeAt(SeriesIndex);							            			    	
					series1.insert(SeriesIndex+1,currentSeries1);
					e.setResult(String.format("%s,%s,%s","ReadyToChangeListBox",SeriesIndex ,SeriesIndex+1));
   					break; 
   				case 10:            		
					chart1.getSeries().get(SeriesIndex).bringToFront();
					e.setResult(String.format("%s,%s,0","ReadyToChangeListBox",SeriesIndex));
   					break;  
   				case 11:            		
					chart1.getSeries().get(SeriesIndex).sendToBack();
					e.setResult(String.format("%s,%s,LastSeriesIndex","ReadyToChangeListBox",SeriesIndex));
   					break;                 				               				               				              				              				
		}
	  } 
	  public String GetGalleryIndex(ChartServer chart1, int iSeriesIndex)
	  {
			String sRet = "";	
			Gallery SeriesGallery = chart1.getSeries().get(iSeriesIndex).getGallery();	
			if (SeriesGallery == Gallery.LINES)
				sRet = "0";
			if (SeriesGallery == Gallery.BAR)
				sRet = "1";
			if (SeriesGallery == Gallery.AREA)
				sRet = "2";
			if (SeriesGallery == Gallery.CURVE)
				sRet = "3";
			if (SeriesGallery == Gallery.CUBE)
				sRet = "4";
			if (SeriesGallery == Gallery.STEP)
				sRet = "5";
			return sRet;
	  }
	  public String GetBarShapeIndex(ChartServer chart1, int iSeriesIndex)
	  {
			String sRet = "";		
			BarShape SeriesBarShape = chart1.getSeries().get(iSeriesIndex).getBarShape();
			if (SeriesBarShape == BarShape.RECTANGLE)
				sRet = "0";
			if (SeriesBarShape == BarShape.CYLINDER)
				sRet = "1";
			if (SeriesBarShape == BarShape.CONE)
				sRet = "2";
			return sRet;
	  }
	  public String GetMarkerShapeIndex(ChartServer chart1, int iSeriesIndex)
	  {
			String sRet = "";	
			MarkerShape SeriesMarkerShape = chart1.getSeries().get(iSeriesIndex).getMarkerShape();	
			int i = 0;
			for (MarkerShape markerShape : MarkerShape.values()) {
				  if (SeriesMarkerShape == markerShape){
					sRet = "" + i;
					break;
				  }
				  i++;				  
			}				
			return sRet;
	  }
	  public String GetColorIndex(ChartServer chart1, int iSeriesIndex)
	  {		
			Color SeriesColor = chart1.getSeries().get(iSeriesIndex).getColor();	
			String sRet = "";
			if (CompareColors(SeriesColor, Color.GREEN))
				sRet = "1";
			if (CompareColors(SeriesColor, Color.BLUE))
				sRet = "2";
			if (CompareColors(SeriesColor, Color.RED))
				sRet = "3";
			if (CompareColors(SeriesColor, Color.YELLOW))
				sRet = "4";
			if (CompareColors(SeriesColor, Color.ORANGE))
				sRet = "5";
			if (CompareColors(SeriesColor, Color.CYAN))
				sRet = "6";				
			return sRet;
	  }
	  public Boolean CompareColors(Color a, Color b)
	  {
		if (a.getGreen() == b.getGreen() && a.getRed() == b.getRed()  && a.getBlue() == b.getBlue() )
			return true;
		else
			return false;
	  }
}

%>
<%
	ChartServer chart1 = new ChartServer(pageContext,request,response);
	chart1.setID("chart1");
	chart1.setUseCallbacksForEvents(true);
	chart1.addUserCallbackListener(new UserCallBackEventHandler ());

	//Read Chart Data:
	chart1.getData().setSeries(4);
	chart1.getData().setPoints(10);

	chart1.getSeries().get(0).setColor(Color.BLUE);
	chart1.getSeries().get(1).setColor(Color.GREEN);
	chart1.getSeries().get(2).setColor(Color.RED);
	chart1.getSeries().get(3).setColor(Color.YELLOW);

	chart1.getSeries().get(0).setText("Beers and Wine");
	chart1.getSeries().get(1).setText("Electronics");
	chart1.getSeries().get(2).setText("Bedding and Linens");
	chart1.getSeries().get(3).setText("Toys and Sports");
		
	chart1.setWidth(784);
	chart1.setHeight(500);
	chart1.renderControl();
%>        
                        
    </body>
</html>
