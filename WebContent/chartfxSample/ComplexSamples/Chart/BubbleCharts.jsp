<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="com.softwarefx.chartfx.server.annotation.*"%>
<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : bubblecharts
    Created on : Apr 17, 2008, 1:52:52 PM
    Author     : Administrator
--%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title>Bubble Charts</title>
    </head>
    <body>
            <div id="Panel1" style="font-family:Arial;font-size:9pt;width:839px;text-align: justify">	
				The following sample illustrates a Bubble chart plotting 3 different variables.
				In the example, several companies are being analyzed based on their Rank (Y Axis),
				Relative Strength (X Axis) and PE Ratio (Bubble size). In addition, a conditional
				attribute has been defined to color the bubble based on its PE ratio and two custom
				gridlines have been added to create a quadrant. The resulting chart is a very effective
				investment tool as it is very easy to see which companies have better rank and strentgh
				and a lower PE. The color cue also helps in finding those markers with a low PE
				ratio.
			</div>
<%
	chart1 = new ChartServer(pageContext, request, response);
	chart1.setGallery(Gallery.BUBBLE);
	chart1.getImageSettings().setInteractive(false);
	ReadChartData(application.getRealPath("/") + "/data/CompanyData.txt");
	chart1.getAllSeries().setVolume((short)500);
	chart1.getAxisY().getGrids().getMajor().setVisible(false);
	chart1.getAxisX().getGrids().getMajor().setVisible(false);
	chart1.getAxisY().setNotify(true);
	chart1.getAxisY().setMax(100);
	chart1.getSeries().get(1).setAxisY(chart1.getAxisY2());
	chart1.getAxisY2().setForceZero(false);
	chart1.getAxisY2().setVisible(false);
	chart1.getAxisY2().setNotify(true);
	chart1.getAxisY().getTitle().setText("Rank");
	chart1.getAxisX().getTitle().setText("Relative Strength");
	chart1.getSeries().get(0).getPointLabels().setFormat("%L");
	chart1.getSeries().get(0).getPointLabels().setTextColor(java.awt.Color.DARK_GRAY);
	chart1.getSeries().get(0).getPointLabels().setLineAlignment(com.softwarefx.StringAlignment.CENTER);
	chart1.getSeries().get(0).getPointLabels().setAlignment(com.softwarefx.StringAlignment.CENTER);
	chart1.getAxisX().setStep(0.1);
	chart1.getAxisX().getLabelsFormat().setDecimals(2);
	/* Now let's hide the standard Legend Box Items */;
	LegendItemAttributes legendItem;
	legendItem = new LegendItemAttributes();
	legendItem.setVisible(false);
	chart1.getLegendBox().getItemAttributes().set(((ILegendBoxItemCollection)chart1.getSeries()), legendItem);        
	int[] peRanges = {0, 12, 18, 27, 40, 50, 70};    
	java.awt.Color[] peColors = {new java.awt.Color(60, 179, 113 ), new java.awt.Color(152, 251, 152) , new java.awt.Color(173, 216, 230), java.awt.Color.YELLOW, java.awt.Color.ORANGE, new java.awt.Color(250, 128, 114 ), new java.awt.Color(147, 112, 219)};
	int i = 0;
	for (int pe : peRanges)
	{
		ConditionalAttributes peCond = new ConditionalAttributes();		
		peCond.getCondition().setFrom(peRanges[i]);
		if (i < peRanges.length - 1)
		{
			peCond.getCondition().setTo(peRanges[i + 1]);
			peCond.getCondition().setToOpen(true);
			peCond.setText("PE (" + peRanges[i] + "-" + peRanges[i + 1] + ")");
		}
		else
		{
			peCond.getCondition().setTo(Double.POSITIVE_INFINITY);
			peCond.setText("PE>=" + peRanges[i]);peCond.setSeries(1);
	    
		}
        // This is necessary to create the conditional attribute based on the size of the bubble (Series 1)
        peCond.setSeries(1);
                
		peCond.setColor(peColors[i]);
		peCond.getPointLabels().setVisible(true);
		chart1.getConditionalAttributes().add(peCond);
		i++;
	}
	chart1.addConditionalAttributesCallbackListener(new EventHandler());
	chart1.getConditionalAttributes().recalculate();

	/* Let's setup the custom gridlines to create a quadrant */;
	CustomGridLine customGrid1;
	customGrid1 = new CustomGridLine();
	customGrid1.setValue(0.5);
	customGrid1.setColor(chart1.getAxisX().getLine().getColor());
	customGrid1.setWidth((short)1);
	chart1.getAxisX().getCustomGridLines().add(customGrid1);
	CustomGridLine customGrid2;
	customGrid2 = new CustomGridLine();
	customGrid2.setValue(50);
	customGrid2.setColor(chart1.getAxisX().getLine().getColor());
	customGrid2.setWidth((short)1);
	chart1.getAxisY().getCustomGridLines().add(customGrid2);
	/* This code will prevent Custom Gridlines to be displayed in the toolbox */;

	LegendItemAttributes customgridLegendItem;
	customgridLegendItem = new LegendItemAttributes();
	customgridLegendItem.setVisible(false);
	chart1.getLegendBox().getItemAttributes().set(((ILegendBoxItemCollection)chart1.getAxisX().getCustomGridLines()), customgridLegendItem);
	chart1.getLegendBox().getItemAttributes().set(((ILegendBoxItemCollection)chart1.getAxisY().getCustomGridLines()), customgridLegendItem);

	CreateQuadrantText("Stay away unless PE is very low", StringAlignment.NEAR, chart1.getAxisX().getMin(), StringAlignment.FAR, chart1.getAxisY().getMin()); 
	CreateQuadrantText("Best Companies! Look for low PE", StringAlignment.FAR, chart1.getAxisX().getMax(), StringAlignment.NEAR, chart1.getAxisY().getMax());
	CreateQuadrantText("Good strebgth but low ranked", StringAlignment.FAR, chart1.getAxisX().getMax(), StringAlignment.FAR, chart1.getAxisY().getMin());
	CreateQuadrantText("Good Rank but not very strong", StringAlignment.NEAR, chart1.getAxisX().getMin(), StringAlignment.NEAR, chart1.getAxisY().getMax());
	chart1.setWidth(800);
	chart1.setHeight(600);
	chart1.renderControl();
 %>
<%!
    public ChartServer chart1;
    public class EventHandler implements ConditionalAttributesListener
    {
    public  void conditionalAttributesEventHandler (ConditionalAttributesEvent e)
    {
        e.setSeries(0);
    }
    }
    public void ReadChartData(String cfxxmlpath)
    {
        chart1.getDataSourceSettings().getFields().add(new FieldMap("Symbol", FieldUsage.LABEL));
        chart1.getDataSourceSettings().getFields().add(new FieldMap("Strength", FieldUsage.XVALUE));
        chart1.getDataSourceSettings().getFields().add(new FieldMap("Rank", FieldUsage.VALUE));
        chart1.getDataSourceSettings().getFields().add(new FieldMap("PE", FieldUsage.VALUE));
        XmlDataProvider cfxXML = new XmlDataProvider();
      
        cfxXML.load(cfxxmlpath);
      
        chart1.getDataSourceSettings().setDataSource(cfxXML);
        int i = 0;          
        chart1.getAxisX().getLabels().removeAll(chart1.getAxisX().getLabels());
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
       quadrantText.sizeToFit();
       quadrantText.setTextColor(java.awt.Color.BLACK);
       quadrantText.attach(xAlign, xPos, yAlign, yPos);
       quadrantText.setVisible(true);
	}
%>        
    </body>
</html>
