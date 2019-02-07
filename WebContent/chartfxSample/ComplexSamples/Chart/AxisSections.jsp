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
        <title>Axis Sections</title>
    </head>
<script>
    function UpdateChart(option, IdName, LabelIdName){	
        var color = document.getElementById(IdName).value;
		var bValue = false;
		if (document.getElementById(IdName).checked != null)
			bValue = document.getElementById(IdName).checked;
        var param = option + "," + color + "," + bValue + "," + LabelIdName;
        //alert(param);
        SFX_onCallbackReadyDelegate = SFX_UpdateControls;
		SFX_SendUserCallback('chart1',param ,false);	
    }  
    function SFX_UpdateControls(id,callbackReturn) {	
		if (callbackReturn != "") {
			//alert(callbackReturn);
			var stringArray = callbackReturn.split(",");
			document.getElementById(stringArray[1]).style.backgroundColor = stringArray[0];
		}							
	}    
	
			
		
</script>      
    <body>

<div>
    <span id="Label1" style="font-family: Arial; font-size: 9pt;">This sample illustrates
        the use of Axis Sections. There are 3 clearly identified sections that you can set
        attributes for.</span>
    <br />
    <table style="width: 752px; height: 88px">
        <tr>
            <td style="width: 9px; height: 147px">
                <div id="Panel1" style="width: 349px; text-decoration: none; height: 115px; font-size: 9pt;
                    font-family: Arial; color: Blue; border-width: 1px; border-style: Double; border-color: Silver;">
                    &nbsp;&nbsp; Safe Levels (Section1)<br />
                    <table style="width: 328px">
                        <tr>
                            <td align="right" style="width: 290px">
                                <span style="display: inline-block; color: Black; font-family: Arial; font-size: 9pt;
                                    width: 136px;">
                                    <input id="CheckBox1" type="checkbox" name="CheckBox1" checked="checked" onclick="UpdateChart(1,'CheckBox1','');" /><label
                                        for="CheckBox1">Gridlines Style:</label></span></td>
                            <td style="width: 69px">
                                <select name="GridLinesStyleList1" onchange="UpdateChart(2,'GridLinesStyleList1','');"
                                    id="GridLinesStyleList1" style="font-family: Arial; font-size: 9pt;">
                                    <option selected="selected" value="Solid">Solid</option>
                                    <option value="Dashed">Dashed</option>
                                    <option value="Dotted">Dotted</option>
                                </select>
                            </td>
                            <td align="right" style="width: 44px">
                                <span id="GridLinesLabelColor1" style="display: inline-block; color: Black; background-color: Red;
                                    font-family: Arial; font-size: 9pt; height: 16px;">Color:</span></td>
                            <td style="width: 42px">
                                <select name="GridLinesColorList1" onchange="UpdateChart(3,'GridLinesColorList1','GridLinesLabelColor1');"
                                    id="GridLinesColorList1" style="font-family: Arial; font-size: 9pt;">
                                    <option selected="selected"  value="RED">Red</option>
                                    <option value="PINK">Pink</option>
                                    <option value="BLUE">Blue</option>                                    
                                    <option value="YELLOW">Yellow</option>
                                    <option value="ORANGE">Orange</option>
                                    <option value="CYAN">Cyan</option>
                                    <option  value="GRAY">Gray</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 290px">
                            </td>
                            <td align="right" colspan="2">
                                <span id="BackColorLabelColor1" style="display: inline-block; color: Black; background-color: Pink;
                                    font-family: Arial; font-size: 9pt; height: 16px;">Background Color:</span></td>
                            <td style="width: 42px">
                                <select name="BackColorList1" onchange="UpdateChart(4,'BackColorList1','BackColorLabelColor1');"
                                    id="BackColorList1" style="font-family: Arial; font-size: 9pt;">
                                    <option selected="selected" value="PINK">Pink</option>
                                    <option value="MAGENTA">Magenta</option>
                                    <option value="YELLOW">Yellow</option>
                                    <option value="ORANGE">Orange</option>
                                    <option value="CYAN">Cyan</option>
                                    <option  value="GRAY">Gray</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 290px; height: 23px">
                            </td>
                            <td align="right" colspan="2" style="height: 23px">
                                <span id="TextColorLabel1" style="display: inline-block; color: Black; background-color: Red;
                                    font-family: Arial; font-size: 9pt; height: 16px;">Text Color:</span>&nbsp;
                            </td>
                            <td style="width: 42px">
                                <select name="TextColorList1" onchange="UpdateChart(5,'TextColorList1','TextColorLabel1');"
                                    id="TextColorList1" style="font-family: Arial; font-size: 9pt;">
                                    <option selected="selected" value="RED">Red</option>
                                    <option value="MAGENTA">Magenta</option>
                                    <option value="YELLOW">Yellow</option>
                                    <option value="ORANGE">Orange</option>
                                    <option value="CYAN">Cyan</option>
                                    <option  value="GRAY">Gray</option>                                 
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td style="width: 100px; height: 147px;">
                <div id="Panel2" style="width: 342px; text-decoration: none; height: 110px; font-size: 9pt;
                    font-family: Arial; color: Blue; border-width: 1px; border-style: Double; border-color: Silver;">
                    &nbsp;&nbsp; Warning Levels (Section 2)<br />
                    <table style="width: 320px">
                        <tr>
                            <td align="right" style="width: 157px">
                                <span style="display: inline-block; color: Black; font-family: Arial; font-size: 9pt;
                                    width: 136px;">
                                    <input id="CheckBox2" type="checkbox" name="CheckBox2" checked="checked" onclick="UpdateChart(6,'CheckBox2','');" /><label
                                        for="CheckBox2">Gridlines Style:</label></span></td>
                            <td style="width: 69px">
                                <select name="GridLinesStyleList2" onchange="UpdateChart(7,'GridLinesStyleList2','');"
                                    id="GridLinesStyleList2" style="font-family: Arial; font-size: 9pt;">
                                    <option selected="selected" value="Solid">Solid</option>
                                    <option value="Dashed">Dashed</option>
                                    <option value="Dotted">Dotted</option>
                                </select>
                            </td>
                            <td align="right" style="width: 44px">
                                <span id="lblColor2" style="display: inline-block; color: Black; background-color: Magenta;
                                    font-family: Arial; font-size: 9pt; height: 16px;">Color:</span></td>
                            <td style="width: 42px">
                                <select name="GridLinesColorList2" onchange="UpdateChart(8,'GridLinesColorList2','lblColor2');"
                                    id="GridLinesColorList2" style="font-family: Arial; font-size: 9pt;">
                                    <option value="ORANGE">Orange</option>
                                     <option selected="selected" value="MAGENTA">Magenta</option>
                                    <option value="YELLOW">Yellow</option>
                                    <option value="BLUE">Blue</option>
                                    <option value="CYAN">Cyan</option>
                                    <option  value="GRAY">Gray</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 157px">
                            </td>
                            <td align="right" colspan="2">
                                <span id="lblBkColor2" style="display: inline-block; color: Black; background-color: Orange;
                                    font-family: Arial; font-size: 9pt; height: 16px;">Background Color:</span>&nbsp;</td>
                            <td style="width: 42px">
                                <select name="BackColorList2" onchange="UpdateChart(9,'BackColorList2','lblBkColor2');"
                                    id="BackColorList2" style="font-family: Arial; font-size: 9pt;">
                                    <option selected="selected" value="ORANGE">Orange</option>
                                    <option value="MAGENTA">Magenta</option>                                    
                                    <option value="YELLOW">Yellow</option>
                                    <option value="BLUE">Blue</option>
                                    <option value="CYAN">Cyan</option>
                                    <option  value="GRAY">Gray</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 157px; height: 23px">
                            </td>
                            <td align="right" colspan="2" style="height: 23px">
                                <span id="lblTextColor2" style="display: inline-block; color: Black; background-color: Magenta;
                                    font-family: Arial; font-size: 9pt; height: 16px;">Text Color:</span>&nbsp;
                            </td>
                            <td style="width: 42px; height: 23px">
                                <select name="TextColorList2" onchange="UpdateChart(10,'TextColorList2','lblTextColor2');"
                                    id="TextColorList2" style="font-family: Arial; font-size: 9pt;">
                                    <option selected="selected" value="MAGENTA">Magenta</option>
                                    <option value="ORANGE">Orange</option>
                                    <option value="YELLOW">Yellow</option>
                                    <option value="BLUE">Blue</option>
                                    <option value="CYAN">Cyan</option>
                                    <option  value="GRAY">Gray</option>
                                </select>
                            </td>
                        </tr>
                    </table>
                </div>
            </td>
            <td style="width: 100px; height: 147px;">
                <div id="Panel3" style="width: 351px; text-decoration: none; height: 106px; font-size: 9pt;
                    font-family: Arial; color: Blue; border-width: 1px; border-style: Double; border-color: Silver;">
                    &nbsp;&nbsp; Alarm Levels (Section 3)<table style="width: 328px">
                        <tr>
                            <td align="right" style="width: 157px">
                                <span style="display: inline-block; color: Black; font-family: Arial; font-size: 9pt;
                                    width: 136px;">
                                    <input id="CheckBox3" type="checkbox" name="CheckBox3" checked="checked" onclick="UpdateChart(11,'CheckBox3','');" /><label
                                        for="CheckBox3">Gridlines Style:</label></span></td>
                            <td style="width: 69px">
                                <select name="GridLinesStyleList3" onchange="UpdateChart(12,'GridLinesStyleList3','');"
                                    id="GridLinesStyleList3" style="font-family: Arial; font-size: 9pt;">
                                    <option selected="selected" value="Solid">Solid</option>
                                    <option value="Dashed">Dashed</option>
                                    <option value="Dotted">Dotted</option>
                                </select>
                            </td>
                            <td align="right" style="width: 44px">
                                <span id="lblColor3" style="display: inline-block; color: Black; background-color: GRAY;
                                    font-family: Arial; font-size: 9pt; height: 16px;">Color:</span></td>
                            <td style="width: 42px">
                                <select name="GridLinesColorList3" onchange="UpdateChart(13,'GridLinesColorList3','lblColor3');"
                                    id="GridLinesColorList3" style="font-family: Arial; font-size: 9pt;">
                                    <option selected="selected" value="GRAY">Gray</option>                                    
                                    <option value="MAGENTA">Magenta</option>
                                    <option value="ORANGE">Orange</option>                                    
                                    <option value="BLUE">Blue</option>
                                    <option value="CYAN">Cyan</option>
                                    <option value="RED">Red</option>                                    
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 157px">
                            </td>
                            <td align="right" colspan="2">
                                <span id="lblBkColor3" style="display: inline-block; color: Black; background-color: Yellow;
                                    font-family: Arial; font-size: 9pt; height: 16px;">Background Color:</span></td>
                            <td style="width: 42px">
                                <select name="BackColorList3" onchange="UpdateChart(14,'BackColorList3','lblBkColor3');"
                                    id="BackColorList3" style="font-family: Arial; font-size: 9pt;">
                                    <option selected="selected" value="YELLOW">Yellow</option>
                                    <option value="RED">Red</option>         
                                    <option value="ORANGE">Orange</option>                                    
                                    <option value="BLUE">Blue</option>
                                    <option value="CYAN">Cyan</option>
                                    <option  value="GRAY">Gray</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td style="width: 157px; height: 23px">
                            </td>
                            <td align="right" colspan="2" style="height: 23px">
                                <span id="lblTextColor3" style="display: inline-block; color: Black; background-color: GRAY;
                                    font-family: Arial; font-size: 9pt; height: 16px;">Text Color:</span>&nbsp;
                            </td>
                            <td style="width: 42px">
                                <select name="TextColorList3" onchange="UpdateChart(15,'TextColorList3','lblTextColor3');"
                                    id="TextColorList3" style="font-family: Arial; font-size: 9pt;">
                                    <option selected="selected" value="GRAY">Gray</option>                                    
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
				String sValue = params[1];  //Color or Style
				String bValue = params[2];					
				switch(option) {
					case 1:  					
						ChangeSectionSettings(chart1,0,"","","","",bValue);
						break;
					case 2:  
						ChangeSectionSettings(chart1,0,"","","",sValue,"");
						break;	
					case 3:  
						ChangeSectionSettings(chart1,0,"","",sValue,"","");
						e.setResult(String.format("%s,%s",sValue ,params[3]));
						break;	
					case 4:  
						ChangeSectionSettings(chart1,0,"",sValue,"","","");
						e.setResult(String.format("%s,%s",sValue ,params[3]));
						break;
					case 5:  
						ChangeSectionSettings(chart1,0,sValue,"","","","");
						e.setResult(String.format("%s,%s",sValue ,params[3]));
						break;
					case 6:  
						ChangeSectionSettings(chart1,1,"","","","",bValue);
						break;													
					case 7:  		
						ChangeSectionSettings(chart1,1,"","","",sValue,"");			
						break;
					case 8:  
						ChangeSectionSettings(chart1,1,"","",sValue,"","");
						e.setResult(String.format("%s,%s",sValue ,params[3]));
						break;	
					case 9:  
						ChangeSectionSettings(chart1,1,"",sValue,"","","");
						e.setResult(String.format("%s,%s",sValue ,params[3]));
						break;
					case 10:  
						ChangeSectionSettings(chart1,1,sValue,"","","","");
						e.setResult(String.format("%s,%s",sValue ,params[3]));
						break;
					case 11:  
						ChangeSectionSettings(chart1,2,"","","","",bValue);
						break;
					case 12:  
						ChangeSectionSettings(chart1,2,"","","",sValue,"");
						break;
					case 13:  
						ChangeSectionSettings(chart1,2,"","",sValue,"","");
						e.setResult(String.format("%s,%s",sValue ,params[3]));
						break;	
					case 14:  
						ChangeSectionSettings(chart1,2,"",sValue,"","","");
						e.setResult(String.format("%s,%s",sValue ,params[3]));
						break;
					case 15:  
						ChangeSectionSettings(chart1,2,sValue,"","","","");
						e.setResult(String.format("%s,%s",sValue ,params[3]));
						break;																										
				}
               
	  } 	 
	  public void ChangeSectionSettings(ChartServer chart1,int SectionIndex,String sTextColor, String sBackColor, String sGridLinesColor,String GridStyle, String bValue){
		
		AxisSection section = chart1.getAxisY().getSections().get(SectionIndex);
		if (sBackColor != "")
			section.setBackColor(getColor(sBackColor));
		if (sGridLinesColor != "")
		section.getGrids().getMajor().setColor(getColor(sGridLinesColor));
		if (sTextColor != "")
			section.setTextColor(getColor(sTextColor));
		if (GridStyle.compareTo("Solid") == 0)
			section.getGrids().getMajor().setStyle(com.softwarefx.DashStyle.SOLID);	  
		if (GridStyle.compareTo("Dashed") == 0)
			section.getGrids().getMajor().setStyle(com.softwarefx.DashStyle.DASH);
		if (GridStyle.compareTo("Dotted") == 0)
			section.getGrids().getMajor().setStyle(com.softwarefx.DashStyle.DOT);
		if (bValue != "")
			section.getGrids().getMajor().setVisible(Boolean.valueOf(bValue));
	  }
	public Color getColor(String colorName) {
        try {
            // Find the field and value of colorName
            java.lang.reflect.Field field = Class.forName("java.awt.Color").getField(colorName);
            return (Color)field.get(null);
        } catch (Exception e) {
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

//Read Data
TextProvider txtProvider = new TextProvider();
//txtProvider.open(application.getRealPath("/data/AxisSectionData.txt") );
txtProvider.open("D:\\DATA1\\SMCube\\web\\2015_wpcs\\wpcs\\WebContent\\chartfxSample\\data\\AxisSectionData.txt");
chart1.getDataSourceSettings().getFields().add(new FieldMap("value", FieldUsage.VALUE));
chart1.getDataSourceSettings().getFields().add(new FieldMap("time",FieldUsage.XVALUE));
txtProvider.setDateFormat("M/d/yyyy h:mm:s tt");
chart1.getDataSourceSettings().setDataSource(txtProvider);
txtProvider.close();

chart1.getView3D().setEnabled(true);
chart1.getLegendBox().setVisible(false);
chart1.getSeries().get(0).setColor(Color.DARK_GRAY);
chart1.getAxisX().getLabelsFormat().setFormat(AxisFormat.TIME);
//chart1.getAxisX().getLabelsFormat().setFormat(AxisFormat.DATE_TIME);
    //chart1.getAxisX().getLabelsFormat().setCustomFormat("MMM-dd-yy");
chart1.getAxisY().setForceZero(false);
chart1.getAxisY().setMin(15);
chart1.getAxisY().setMax(60);
TitleDockable newTitle = new TitleDockable();
newTitle.setText("Pressure (psi) by Hour");
chart1.getTitles().add(newTitle);
chart1.getAllSeries().setMarkerShape(MarkerShape.NONE);

//Setting the SafeSection:
AxisSection SafeSection = new AxisSection();
chart1.getAxisY().getSections().add(SafeSection);
SafeSection.setBackColor(Color.PINK);
SafeSection.setFrom(15);
SafeSection.setTo(30);
SafeSection.getGrids().getMajor().setVisible(true);
SafeSection.getGrids().getMajor().setTickMark(TickMark.CROSS);
SafeSection.getGrids().getMajor().setWidth((short) 3);
SafeSection.getGrids().getMajor().setColor(Color.RED);
SafeSection.setTextColor(Color.RED);
SafeSection.getGrids().getMajor().setStyle(com.softwarefx.DashStyle.SOLID);

//Setting the WarningSection:
AxisSection WarningSection = new AxisSection();
chart1.getAxisY().getSections().add(WarningSection);
WarningSection.setBackColor(Color.ORANGE);
WarningSection.setFrom(30);
WarningSection.setTo(45);
WarningSection.getGrids().getMajor().setVisible(true);
WarningSection.getGrids().getMajor().setTickMark(TickMark.CROSS);
WarningSection.getGrids().getMajor().setWidth((short) 3);
WarningSection.getGrids().getMajor().setColor(Color.MAGENTA);
WarningSection.setTextColor(Color.MAGENTA);
WarningSection.getGrids().getMajor().setStyle(com.softwarefx.DashStyle.SOLID);

//Setting the AlarmSection:
AxisSection AlarmSection = new AxisSection();
chart1.getAxisY().getSections().add(AlarmSection);
AlarmSection.setBackColor(Color.YELLOW);
AlarmSection.setFrom(45);
AlarmSection.setTo(60);
AlarmSection.getGrids().getMajor().setVisible(true);
AlarmSection.getGrids().getMajor().setTickMark(TickMark.CROSS);
AlarmSection.getGrids().getMajor().setWidth((short) 3);
AlarmSection.getGrids().getMajor().setColor(Color.GRAY);
AlarmSection.setTextColor(java.awt.Color.GRAY);
AlarmSection.getGrids().getMajor().setStyle(com.softwarefx.DashStyle.SOLID);

chart1.recalculateScale(); 

chart1.setWidth(800);
chart1.setHeight(600);
chart1.renderControl();   
%>        
                        
    </body>
</html>
