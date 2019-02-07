<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="com.softwarefx.chartfx.server.annotation.*"%>
<%@page import="com.softwarefx.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : testforjava
    Created on : Mar 25, 2008, 6:23:13 PM
    Author     : Administrator
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
   <html>
   <head>
   <title>Population Pyramids</title>
        <div id="Panel1" style="font-family:Arial;font-size:9pt;height:82px;width:800px;text-align: justify">
	    This sample shows how to create a chart with the scale in the center, which is very
            useful to compare the behavior of two sets of data that are similar by nature, e.g.
            population by gender. To achieve this, we created two panes with enough separation,
            and used annotation objects for the labels. Due to the implementation of the labels
            with annotation objects, some of the Chart FX features can not be applied, and thus
            hav been removd from the UI. We have also used the same point attribute for each
            point in the chart, so highlighting a point in one of the series (e.g. female) will
            also highlight the same point in the other series.<br />
            <br />
            </div>
</head>
<body>
<%!
    public ChartServer chart1;
    public void ReadChartData(String cfxxmlpath)
    {
        chart1.getDataSourceSettings().getFields().add(new FieldMap("Range", FieldUsage.LABEL));
        chart1.getDataSourceSettings().getFields().add(new FieldMap("Male", FieldUsage.VALUE));
        chart1.getDataSourceSettings().getFields().add(new FieldMap("Female", FieldUsage.VALUE));
        XmlDataProvider cfxXML = new XmlDataProvider();
        cfxXML.load(cfxxmlpath);
        chart1.getDataSourceSettings().setDataSource(cfxXML);
	}
%>
<% 
        chart1 = new ChartServer(pageContext, request, response);
        chart1.getLegendBox().setVisible(false);
        chart1.setGallery(Gallery.GANTT);
            
        ReadChartData(application.getRealPath("/") + "/data/PopulationData.txt");
            
        chart1.getAxisX().setStep(1);
        chart1.getAxisX().setVisible(false);
		/*  Configure the main Y axis */
        chart1.getAxisY().setScaleUnit(1000);
        chart1.getAxisY().getDataFormat().setDecimals(3);
		/*  Create a secondary pane for the female data */
        Pane pane;
        pane = new Pane();
        pane.getAxisY().setInverted(true);
        pane.getAxisY().setScaleUnit(1000);
        pane.getAxisY().getDataFormat().setDecimals(3);
        pane.setSeparation(40);
        chart1.getPanes().add(pane);
        chart1.getSeries().get(1).setPane(pane);

        AnnotationText text;
     	Annotations annot1 = new Annotations();
    	for(int i = 0; i < chart1.getData().getPoints(); i++)
        {
		    /*  Configure the points of both series to use the same point attribute. This is done to */     
		    /*  synchronize the highlighting of each point. */	     
	        PointAttributes point = new PointAttributes();
	        chart1.getPoints().set(0, i, point);
	        chart1.getPoints().set(1, i, point);
	     
	    	/*  Create the annotation texts that will be used as the labels */	   
	        text = new AnnotationText();
	        annot1.getList().add(text);
			text.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, 12));
	        text.setText(chart1.getAxisX().getLabels().get(i));
	
	        text.attach(StringAlignment.FAR, i + 1, StringAlignment.CENTER, 0);
	     
	        text.setWidth((short)40);
	        text.setHeight(15);
	        text.setAlign(com.softwarefx.StringAlignment.CENTER);
	        text.getBorder().setColor(new java.awt.Color(0,0,0,0));
    	}
    	AnnotationText text1 = new AnnotationText();
        AnnotationText text2 = new AnnotationText();    
        annot1.getList().add(text1);
        annot1.getList().add(text2);
		text1.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, 12));
        text1.setText("Male");
        text1.setTextColor(java.awt.Color.BLACK);
        text1.getBorder().setColor(new java.awt.Color(0, 0, 0, 0));
        text1.setTop(18);
        text1.setLeft(35);    
		text2.setFont(new java.awt.Font("Arial", java.awt.Font.PLAIN, 12));
        text2.setText("Female");
        text2.setTextColor(java.awt.Color.BLACK);
        text2.setColor(new java.awt.Color(0,0,0,0));
        text2.getBorder().setColor(new java.awt.Color(0,0,0,0));
        text2.setTop(18);
        text2.setLeft(670);
            
        chart1.getExtensions().add(annot1);
		/*  Hide the labels from the standard axis */
		
		/*chart1.getAxisX().setStyle(((chart1.getAxisX().getStyle()) | (AxisStyles.HideText)));
		chart1.getAxisX().setStyle(arg0)
		*/
		/*Create the titles */
        TitleDockable title;
        title = new TitleDockable("U.S. Population (in millions)");
    	/*title.setRichText(true);*/
        chart1.getTitles().add(title);
        chart1.getAxisX().getTitle().setText("Age Ranges");
           
        chart1.setWidth(800);
        chart1.setHeight(600);
        chart1.renderControl();
%>
</body>
</html>


