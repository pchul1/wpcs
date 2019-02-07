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
        <title>Panes</title>
    </head>
<script>
    function UpdateChart(option, IdName){	
        var galleryIndex = document.getElementById("GalleryList").selectedIndex;
		var bValue = false;
		if (document.getElementById(IdName).checked != null)
			bValue = document.getElementById(IdName).checked;
        var param = option + "," + galleryIndex + "," + bValue;
		SFX_SendUserCallback('chart1',param ,false);	
    }   
</script>      
    <body>

<div>
    <div id="Panel1" style="font-family: Arial; font-size: 9pt; height: 50px; width: 688px;">
        Panes are among the most useful features to plot data with different datasets, with
        panes you can have different chart sections with independent axis, scales and visual
        attributes. Run the sample and use the controls displayed below to change pane attributes.
    </div>
    <table style="width: 688px; height: 144px">
        <tr>
            <td style="width: 78px; height: 96px;" valign="top">
                <div id="Panel3" style="color: Blue; border-color: Silver; border-width: 1px; border-style: Groove;
                    font-family: Arial; font-size: 9pt; height: 114px; width: 336px;">
                    Pressure Pane &nbsp;<table style="width: 328px; height: 88px; color: black;">
                        <tr>
                            <td align="right" style="font-size: 9pt; width: 100px; color: black; font-family: Arial;
                                height: 21px" valign="middle">
                                &nbsp;Pane Size:</td>
                            <td colspan="2" style="font-size: 9pt; font-family: Arial; height: 21px" valign="middle">
                                <table id="RadioButtonList1" cellspacing="0" cellpadding="0" border="0" style="color: Black;
                                    height: 24px; width: 144px; border-collapse: collapse;">
                                    <tr>
                                        <td>
                                            <input id="RadioButtonList1_0" type="radio" name="RadioButtonList1" value="Small"
                                                checked="checked" onclick="UpdateChart(1,'RadioButtonList1_0');" /><label for="RadioButtonList1_0">Small</label></td>
                                        <td>
                                            <input id="RadioButtonList1_1" type="radio" name="RadioButtonList1" value="Medium"
                                                onclick="UpdateChart(2,'RadioButtonList1_1');" /><label
                                                    for="RadioButtonList1_1">Medium</label></td>
                                        <td>
                                            <input id="RadioButtonList1_2" type="radio" name="RadioButtonList1" value="Large"
                                                onclick="UpdateChart(3,'RadioButtonList1_2');" /><label
                                                    for="RadioButtonList1_2">Large</label></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="font-size: 9pt; width: 100px; font-family: Arial; height: 21px;
                                text-align: right">
                                <span style="display: inline-block; color: Black; font-family: Arial; font-size: Small;
                                    width: 72px;">
                                    <input id="CheckBox1" type="checkbox" name="CheckBox1" checked="checked" onclick="UpdateChart(4,'CheckBox1');" /><label
                                        for="CheckBox1">GridLines</label></span></td>
                            <td align="center" style="font-size: 9pt; width: 90px; font-family: Arial; height: 21px;
                                text-align: center">
                                <span style="display: inline-block; color: Black; font-family: Arial; font-size: Small;
                                    width: 72px;">
                                    <input id="CheckBox2" type="checkbox" name="CheckBox2" onclick="UpdateChart(5,'CheckBox2');" /><label
                                        for="CheckBox2">Interlaced</label></span></td>
                            <td align="center" style="font-size: 9pt; width: 111px; font-family: Arial; height: 21px;
                                text-align: center">
                                <input id="CheckBox3" type="checkbox" name="CheckBox3" onclick="UpdateChart(6,'CheckBox3');" /><label
                                    for="CheckBox3">Y Axis Decimals</label></td>
                        </tr>
                    </table>
                </div>
            </td>
            <td style="width: 100px; height: 96px;" valign="top">
                <div id="Panel4" style="color: Blue; border-color: Silver; border-width: 1px; border-style: Groove;
                    font-family: Arial; font-size: 9pt; height: 115px; width: 336px;">
                    &nbsp;Temperature Pane<br />
                    <table style="width: 312px; color: black; height: 88px">
                        <tr>
                            <td align="right" style="width: 100px; height: 28px;" valign="middle">
                                Pane Size:</td>
                            <td align="center" style="width: 115px; height: 28px;" valign="middle">
                                <table id="RadioButtonList2" cellspacing="0" cellpadding="0" border="0" style="color: Black;
                                    height: 24px; width: 144px; border-collapse: collapse;">
                                    <tr>
                                        <td>
                                            <input id="RadioButtonList2_0" type="radio" name="RadioButtonList2" value="Small"
                                                checked="checked" onclick="UpdateChart(7,'RadioButtonList2_0');"/><label for="RadioButtonList2_0">Small</label></td>
                                        <td>
                                            <input id="RadioButtonList2_1" type="radio" name="RadioButtonList2" value="Medium"
                                                onclick="UpdateChart(8,'RadioButtonList2_1');" /><label
                                                    for="RadioButtonList2_1">Medium</label></td>
                                        <td>
                                            <input id="RadioButtonList2_2" type="radio" name="RadioButtonList2" value="Large"
                                                onclick="UpdateChart(9,'RadioButtonList2_2');" /><label
                                                    for="RadioButtonList2_2">Large</label></td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td align="right" style="width: 100px; height: 8px;" valign="middle">
                                Gallery:</td>
                            <td style="width: 115px; height: 8px;" valign="middle">
                                &nbsp;
                                <select name="GalleryList" onchange="UpdateChart(10,'GalleryList');"
                                    id="GalleryList" style="width: 104px;">
                                    <option selected="selected"  value="Lines">Lines</option>
                                    <option value="Bar">Bar</option>
                                    <option value="Curve">Curve</option>
                                    <option value="Cube">Cube</option>
                                    <option value="Step">Step</option>
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
		int galleryIndex = Integer.parseInt(params[1]);
		boolean bValue = Boolean.valueOf(params[2]);			
		switch(option) {
			case 1:  	
				chart1.getPanes().get(0).setProportion(1);
				break;
			case 2:  
				chart1.getPanes().get(0).setProportion(5);
				break;						
			case 3:  
				chart1.getPanes().get(0).setProportion(10);
				break;
			case 4:  
				chart1.getPanes().get(0).getAxisY().getGrids().getMajor().setVisible(bValue);
				chart1.getAxisX().getGrids().getMajor().setVisible(bValue);
				break;
			case 5:  
				chart1.getPanes().get(0).getAxisY().getGrids().setInterlaced(bValue);
				break;
			case 6:  
				if (bValue)
					chart1.getPanes().get(0).getAxisY().getLabelsFormat().setDecimals(2);
				else
					chart1.getPanes().get(0).getAxisY().getLabelsFormat().setDecimals(0);							
				break;
			case 7:  
				chart1.getPanes().get(1).setProportion(1);					
				break;
			case 8:  
				chart1.getPanes().get(1).setProportion(5);					
				break;
			case 9:  
				chart1.getPanes().get(1).setProportion(10);					
				break;
			case 10:  
				ChangePaneGallery(galleryIndex, chart1);
				break;																																																					
		}
		chart1.recalculateScale(); 
	  } 	 
	  public void ChangePaneGallery(int index,ChartServer chart1) 
	  {  
			switch(index) 
			{
					case 0:   
						chart1.getSeries().get(1).setGallery(Gallery.LINES);    						
						break;
					case 1:   
						chart1.getSeries().get(1).setGallery(Gallery.BAR);
						break;
					case 2:   
						chart1.getSeries().get(1).setGallery(Gallery.CURVE);
						break;
					case 3:   
						chart1.getSeries().get(1).setGallery(Gallery.CUBE);
						break;
					case 4:   
						chart1.getSeries().get(1).setGallery(Gallery.STEP);
						break;  										   					   					   					
			}
    }	  
}

%>
<%
	ChartServer chart1 = new ChartServer(pageContext,request,response);
	chart1.setID("chart1");
	chart1.setUseCallbacksForEvents(true);
	chart1.addUserCallbackListener(new UserCallBackEventHandler ());

	Pane pane1 = chart1.getPanes().get(0);
	pane1.getTitle().setText("Pressure");
	chart1.getLegendBox().setVisible(false);

	Pane pane2 = new Pane();
	chart1.getPanes().add(pane2);
	chart1.getSeries().get(1).setPane(pane2);
	pane2.getTitle().setText("Temperature");
	pane2.getAxisY().setForceZero(false);

	chart1.setWidth(688);
	chart1.setHeight(500);
	chart1.renderControl();
%>        
                        
    </body>
</html>
