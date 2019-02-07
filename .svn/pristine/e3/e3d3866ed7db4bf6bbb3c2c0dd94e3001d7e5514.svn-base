<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Grid Lines</title>
    </head>
    <body>
    <script>
    function UpdateChart(option,IdName){
		var param = option + "," + document.getElementById(IdName).checked;
        SFX_SendUserCallback('chart1',param ,false);
    }
    </script>     

        <div id="Panel1" style="font-family:Arial;font-size:9pt;text-decoration:none;height:50px;width:688px;">
            Gridlines and Tickmarks are important axis elements, they allow end users to quickly
            extrapolate data and discover important trends in the chart. This sample shows how
            you can customize gridlines and tickmarks as well as using Axis Sections and Custom
            Gridlines to highlight data in different sections of the chart. To properly illustrate
            gridlines and tickmarks we're displaying a scatter plot where both x and y are numerical
            axes.
		</div>

        <table style="width: 672px; height: 120px">
            <tr>
                <td style="width: 100px; height: 116px;">
                    <div id="Panel2" style="color:Blue;border-color:Silver;border-width:1px;border-style:Double;font-family:Arial;font-size:9pt;height:80px;width:208px;">
	
                        &nbsp;&nbsp; Y Axis<br />
                        <table style="width: 208px">
                            <tr>
                                <td style="width: 205px; height: 22px">
                                    <span style="color:Black;font-family:Arial;font-size:9pt;"><input id="CheckBoxYMajor" type="checkbox" name="CheckBoxYMajor" onclick="UpdateChart(1,'CheckBoxYMajor');" /><label for="CheckBoxYMajor">Major Gridlines</label></span></td>
                                <td align="right" style="width: 100px; height: 22px">
                                    <span style="color:Black;font-family:Arial;font-size:9pt;"><input id="CheckBoxYTickmarks" type="checkbox" name="CheckBoxYTickmarks" onclick="UpdateChart(2,'CheckBoxYTickmarks');" /><label for="CheckBoxYTickmarks">Tickmarks</label></span></td>
                            </tr>
                            <tr>
                                <td style="width: 205px">
                                    <span style="color:Black;font-family:Arial;font-size:9pt;"><input id="CheckBoxYMinor" type="checkbox" name="CheckBoxYMinor" onclick="UpdateChart(3,'CheckBoxYMinor');" /><label for="CheckBoxYMinor">Minor Gridlines</label></span></td>
                                <td align="right" style="width: 100px">
                                    <span style="color:Black;font-family:Arial;font-size:9pt;"><input id="CheckBoxYInterlaced" type="checkbox" name="CheckBoxYInterlaced" onclick="UpdateChart(4,'CheckBoxYInterlaced');" /><label for="CheckBoxYInterlaced">Interlaced</label></span></td>
                            </tr>
                        </table>
                    
</div>
                </td>
                <td style="width: 100px; height: 116px;">
                    <div id="Panel3" style="color:Blue;border-color:Silver;border-width:1px;border-style:Double;font-family:Arial;font-size:9pt;height:80px;width:208px;">
	
                        &nbsp; X Axis<br />
                        <table style="width: 208px">
                            <tr>
                                <td style="width: 205px; height: 22px">
                                    <span style="color:Black;font-family:Arial;font-size:9pt;"><input id="CheckBoxXMajor" type="checkbox" name="CheckBoxXMajor" onclick="UpdateChart(5,'CheckBoxXMajor');" /><label for="CheckBoxXMajor">Major Gridlines</label></span></td>
                                <td align="right" style="width: 100px; height: 22px">
                                    <span style="color:Black;font-family:Arial;font-size:9pt;"><input id="CheckBoxXTickmarks" type="checkbox" name="CheckBoxXTickmarks" onclick="UpdateChart(6,'CheckBoxXTickmarks');" /><label for="CheckBoxXTickmarks">Tickmarks</label></span></td>
                            </tr>
                            <tr>
                                <td style="width: 205px; height: 22px;">
                                    <span style="color:Black;font-family:Arial;font-size:9pt;"><input id="CheckBoxXMinor" type="checkbox" name="CheckBoxXMinor" onclick="UpdateChart(7,'CheckBoxXMinor');" /><label for="CheckBoxXMinor">Minor Gridlines</label></span></td>
                                <td align="right" style="width: 100px; height: 22px;">
                                    <span style="color:Black;font-family:Arial;font-size:9pt;"><input id="CheckBoxXInterlaced" type="checkbox" name="CheckBoxXInterlaced" onclick="UpdateChart(8,'CheckBoxXInterlaced');" /><label for="CheckBoxXInterlaced">Interlaced</label></span></td>
                            </tr>
                        </table>
                    
</div>
                </td>
                <td style="width: 100px; height: 116px;">
                    <div id="Panel4" style="color:Blue;border-color:Silver;border-width:1px;border-style:Double;font-family:Arial;font-size:9pt;height:80px;width:246px;">
	
                        &nbsp;&nbsp; Custom Gridlines &amp; Sections<table style="width: 240px">
                            <tr>
                                <td style="width: 170px; height: 47px">
                                    <span style="color:Black;font-family:Arial;font-size:9pt;"><input id="CheckBoxCustomGrid" type="checkbox" name="CheckBoxCustomGrid" onclick="UpdateChart(9,'CheckBoxCustomGrid');" /><label for="CheckBoxCustomGrid">Custom Grids</label></span></td>
                                <td align="right" style="width: 212px; height: 47px">
                                    <span style="color:Black;font-family:Arial;font-size:9pt;"><input id="CheckBoxCustomSection" type="checkbox" name="CheckBoxCustomSection" onclick="UpdateChart(10,'CheckBoxCustomSection');" /><label for="CheckBoxCustomSection">Custom Sections</label></span></td>
                            </tr>
                        </table>
                    
</div>
                </td>
            </tr>
        </table>

<%!

public class UserCallBackEventHandler  implements com.softwarefx.chartfx.server.UserCallbackListener
{
	public void userCallbackEventHandler (UserCallbackEvent e)
	  { 
			ChartServer chart1 = (ChartServer)e.getSource();
			int option = Integer.parseInt(e.getParam().split(",")[0]);
			boolean value = (e.getParam().split(",")[1].compareTo("true") == 0);
	        switch(option) 
	        {
        			case 1:
        			   if (value)
        					chart1.getAxisY().getGrids().getMajor().setVisible(true);
        				else
        					chart1.getAxisY().getGrids().getMajor().setVisible(false);	
           				break;
					case 2:
        			   if (value) 
        			   {
        					chart1.getAxisY().getGrids().getMinor().setTickMark(TickMark.CROSS);
        					chart1.getAxisY().getGrids().getMajor().setTickMark(TickMark.CROSS);
        				}
        				else 
        				{
        					chart1.getAxisY().getGrids().getMinor().setTickMark(TickMark.NONE);	
        					chart1.getAxisY().getGrids().getMajor().setTickMark(TickMark.NONE);	
        				}
           				break;
					case 3:
        			   if (value)
        					chart1.getAxisY().getGrids().getMinor().setVisible(true);
        				else
        					chart1.getAxisY().getGrids().getMinor().setVisible(false);	
           				break;
					case 4:
        			   if (value)
        					chart1.getAxisY().getGrids().setInterlaced(true);
        				else
        					chart1.getAxisY().getGrids().setInterlaced(false);
           				break;
           				
           			case 5:
        			   if (value)
        					chart1.getAxisX().getGrids().getMajor().setVisible(true);
        				else
        					chart1.getAxisX().getGrids().getMajor().setVisible(false);	
           				break;
					case 6:
        			   if (value)
        			   {
        					chart1.getAxisX().getGrids().getMinor().setTickMark(TickMark.CROSS);
        					chart1.getAxisX().getGrids().getMajor().setTickMark(TickMark.CROSS);
        				}
        				else 
        				{
        					chart1.getAxisX().getGrids().getMinor().setTickMark(TickMark.NONE);	
        					chart1.getAxisX().getGrids().getMajor().setTickMark(TickMark.NONE);	
        				}
           				break;
					case 7:
        			   if (value)
        					chart1.getAxisX().getGrids().getMinor().setVisible(true);
        				else
        					chart1.getAxisX().getGrids().getMinor().setVisible(false);	
           				break;
					case 8:
        			   if (value)
        					chart1.getAxisX().getGrids().setInterlaced(true);
        				else
        					chart1.getAxisX().getGrids().setInterlaced(false);
           				break;
           				
           			case 9:
        			   if (value)
        			   {
							//Create the custom gridline for the x axis (vertical custom gridline)
							CustomGridLine customGrid1 = new CustomGridLine();
							customGrid1.setValue((short)55);
							customGrid1.setColor(java.awt.Color.BLACK);
							customGrid1.setWidth((short) 4);
							customGrid1.setText("Vertical Quadrant");
							chart1.getAxisX().getCustomGridLines().add(customGrid1);

							//Create the custom gridline for the y axis (horizontal custom gridline)
							CustomGridLine customGrid2 = new CustomGridLine();
							customGrid2.setValue((short)75);
							customGrid2.setColor(java.awt.Color.BLACK);
							customGrid2.setWidth((short) 2);
							customGrid2.setText("Horizontal Quadrant");
							chart1.getAxisY().getCustomGridLines().add(customGrid2);            			   
        			   }
        			   else 
        			   {
        					chart1.getAxisY().getCustomGridLines().removeAll(chart1.getAxisY().getCustomGridLines());
        					chart1.getAxisX().getCustomGridLines().removeAll(chart1.getAxisX().getCustomGridLines());
        			   }
        				
           				break;
					case 10:
        			   if (value) 
        			   {
							// Create sections on both x and y axis with custom gridlines
							AxisSection YSection1 = new AxisSection();
							chart1.getAxisY().getSections().add(YSection1);
							YSection1.setBackColor(new java.awt.Color(178, 123, 89));
							YSection1.setFrom(0);
							YSection1.setTo(75);
							YSection1.getGrids().getMinor().setVisible(true);
							YSection1.getGrids().getMinor().setColor(java.awt.Color.WHITE);
							
							AxisSection YSection2 = new AxisSection();
							chart1.getAxisY().getSections().add(YSection2);
							YSection2.setBackColor(new java.awt.Color(198, 143, 199));
							YSection2.setFrom(75);
							YSection2.setTo(150);
							
							AxisSection XSection1 = new AxisSection();
							chart1.getAxisX().getSections().add(XSection1);
							XSection1.setBackColor(new java.awt.Color( 120, 139, 38));
							XSection1.setFrom(0);
							XSection1.setTo(55);
							XSection1.getGrids().getMajor().setVisible(false);
							
							AxisSection XSection2 = new AxisSection();
							chart1.getAxisX().getSections().add(XSection2);
							XSection2.setBackColor(new java.awt.Color(109, 105, 8));
							XSection2.setFrom(55);
							XSection2.setTo(110);        			   
        			   }
        			   else 
        			   {
        					chart1.getAxisX().getSections().removeAll(chart1.getAxisX().getSections());
        					chart1.getAxisY().getSections().removeAll(chart1.getAxisY().getSections());
        			   }
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
	chart1.getAxisY().getGrids().getMajor().setVisible(false);	
	chart1.getAxisY().getGrids().getMajor().setTickMark(TickMark.NONE);		
	chart1.getAxisY().getGrids().getMinor().setTickMark(TickMark.NONE);	
	chart1.getAxisX().getGrids().getMajor().setVisible(false);
	chart1.getAxisX().getGrids().getMajor().setTickMark(TickMark.NONE);		
	chart1.getAxisX().getGrids().getMinor().setTickMark(TickMark.NONE);

	chart1.setToolTips(true);
	chart1.getLegendBox().setVisible(false);
	chart1.getData().setPoints(300);
	chart1.getData().setSeries(1);
	chart1.setGallery(Gallery.SCATTER);
	chart1.getAxisY().setMin(0);
	chart1.getAxisY().setMax(150);
	chart1.getAxisY().setStep(50);
	chart1.getAxisY().setMinorStep(10);
	chart1.getAxisX().setMinorStep(5);	
		
	chart1.setWidth(700);
	chart1.setHeight(500);
	chart1.renderControl();
%>        
    </body>
</html>