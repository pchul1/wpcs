<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="com.softwarefx.chartfx.server.annotation.*"%>
<%@page import="com.softwarefx.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : imagemarkerssample
    Created on : Apr 9, 2008, 10:59:19 AM
    Author     : Administrator
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Image Markers</title>
       <div id="Panel1" style="font-family:Arial;font-size:9pt;height:82px;width:800px;text-align: justify">
            This sample shows how to customize the markers to show images. We have selected
            randomly a number of countries in the world, showing the Life Expetancy Index and
            the GDP Per capita. This sample also shows how to customize highlighting to expand
            the selected item; simply hover over any of the flags to see a bigger flag and more
            information about the country, as a tooltip. In addition, two custom gridlines have
            been created to ceate a quadrant.
             <br />
            </div>
    </head>
    <body>
<%!
    public ChartServer chart1;
    public void ReadChartData(String cfxxmlpath)
    {        
        chart1.getDataSourceSettings().getFields().add(new FieldMap("LEI", FieldUsage.XVALUE));
        chart1.getDataSourceSettings().getFields().add(new FieldMap("GDPPC", FieldUsage.VALUE));
        chart1.getDataSourceSettings().getFields().add(new FieldMap("Country", FieldUsage.LABEL));        
        XmlDataProvider cfxXML = new XmlDataProvider();      
		cfxXML.load(cfxxmlpath);     
		chart1.getDataSourceSettings().setDataSource(cfxXML);
	}      
    public void CustomizeAxes()
    {
		chart1.getAxisX().setForceZero(false);
		chart1.getAxisY().setForceZero(false);
		chart1.getAxisY().getDataFormat().setCustomFormat("###,###,###");
		chart1.getAxisX().getDataFormat().setCustomFormat("###,###,###.##");
		chart1.getAxisY().getTitle().setText("GDP (Per Capita)");
		chart1.getAxisX().getTitle().setText("Life Expectancy Index (years)");
	}      
    public void CreateQuadrantText(String qText, StringAlignment xAlign, double xPos, StringAlignment yAlign, double yPos)
    {     
		Annotations annot = new Annotations();
		chart1.getExtensions().add(annot);
		AnnotationText quadrantText = new AnnotationText();
		annot.getList().add(quadrantText);
		quadrantText.setText(qText);
		quadrantText.setTextColor(new java.awt.Color(0,0,0,0));
		quadrantText.getBorder().setColor(new java.awt.Color(0, 0, 0, 0));

		quadrantText.setTextColor(java.awt.Color.BLACK);
		quadrantText.attach(xAlign, xPos, yAlign, yPos);       
	}
    public void AssignFlagsToCountries(String realpath)
    {
        String countryName;
        String iconName;
        javax.swing.ImageIcon icon;
        
        for(int i = 0; i < chart1.getData().getPoints(); i++)
        {
            countryName = chart1.getAxisX().getLabels().get(i).replace(" ", "_");
            iconName = "flag_" + countryName;
            icon = new javax.swing.ImageIcon(realpath + iconName + ".png");
            chart1.getPoints().get(0, i).setPicture(icon.getImage());
            chart1.getPoints().get(0, i).setMarkerShape(MarkerShape.PICTURE);
            chart1.getPoints().get(0, i).setMarkerSize((short)12);
            chart1.getPoints().get(0, i).setText(chart1.getAxisX().getLabels().get(i));
        }
	}   
%>
<% 
	chart1 = new ChartServer(pageContext, request, response);
	chart1.getLegendBox().setVisible(false);

	chart1.setGallery(Gallery.SCATTER);
	CustomizeAxes();
	ReadChartData(application.getRealPath("\\") + "\\data\\Countries.txt");
	AssignFlagsToCountries(application.getRealPath("\\") + "\\data\\");


	/*  Customize the highlight attribute to increase the image size when hovering over the flag */;
	chart1.getHighlight().getPointAttributes().setMarkerSize((short)24);
	/*  Customize the tooltip */;
	chart1.setToolTipFormat("%L\nLife Expectancy Index: %x years\nGDP Per Capita: %v");
	/*  Setup the custom grdilines to create a quadrant */;
	CustomGridLine customGrid1;
	customGrid1 = new CustomGridLine();
	customGrid1.setValue(((chart1.getAxisX().getMin()) + (((((chart1.getAxisX().getMax()) - (chart1.getAxisX().getMin()))) / 2.0))));
	customGrid1.setColor(java.awt.Color.GRAY);
	customGrid1.setWidth((short)2);
	chart1.getAxisX().getCustomGridLines().add(customGrid1);
	CustomGridLine customGrid2;
	customGrid2 = new CustomGridLine();
	customGrid2.setValue(((chart1.getAxisY().getMin()) + (((((chart1.getAxisY().getMax()) - (chart1.getAxisY().getMin()))) / 2.0))));
	customGrid2.setColor(java.awt.Color.GRAY);
	customGrid2.setWidth((short)2);
	chart1.getAxisY().getCustomGridLines().add(customGrid2);
	CreateQuadrantText("Least Developed", StringAlignment.NEAR, chart1.getAxisX().getMin(), StringAlignment.FAR, chart1.getAxisY().getMin()); 
	CreateQuadrantText("Most Developed", StringAlignment.FAR, chart1.getAxisX().getMax(), StringAlignment.NEAR, chart1.getAxisY().getMax());
	CreateQuadrantText("Developing", StringAlignment.FAR, chart1.getAxisX().getMax(), StringAlignment.FAR, chart1.getAxisY().getMin());

	chart1.getAxisX().getLabels().removeAll(chart1.getAxisX().getLabels());
	chart1.getImageSettings().setInteractive(true);
	chart1.setWidth(800);
	chart1.setHeight(600);
	chart1.renderControl();
%>
   
    </body>
</html>