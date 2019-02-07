<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@page import="com.softwarefx.chartfx.server.annotation.*"%>
<%@page import="com.softwarefx.*"%>
<%@page import="com.softwarefx.chartfx.server.adornments.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%-- 
    Document   : titlesandFont
    Created on : Apr 10, 2008, 3:25:18 PM
    Author     : Administrator
--%>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
          <div id="Panel1" style="font-family:Arial;font-size:9pt;width:800px;text-align: justify">
            This sample illustrates the use of titles, labels and fonts in different sections
            of the chart. Simply run the application and inspect the different text and font
            settings in different chart elements.
    
    </div>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Titles and Font</title>
    </head>
    <body>
<% 
	ChartServer chart1 = new ChartServer(pageContext, request, response);
	chart1.getData().setSeries(4);
	chart1.setGallery(Gallery.SCATTER);
	java.io.File file = new java.io.File(application.getRealPath("/") + "/data/bluepill.png");
	java.awt.image.BufferedImage image = null;
	try 
	{
		image = javax.imageio.ImageIO.read(file);
	} 
	catch (java.io.IOException e) 
	{
		e.printStackTrace();
	}	
	ImageBackground ib = new ImageBackground();
    ib.setImage(image);
            
	
	ib.setMode(com.softwarefx.chartfx.server.adornments.ImageMode.STRETCH);
	chart1.setPlotAreaBackground(ib);
	chart1.getSeries().get(0).setText("Competitor A");
	chart1.getSeries().get(1).setText("Our Product");
	chart1.getSeries().get(2).setText("Competitor B");
	chart1.getSeries().get(3).setText("Competitor C");
	chart1.getAxisY().getTitle().setText("# of incidents");
	chart1.getAxisY().getGrids().getMajor().setVisible(false);
	chart1.getAxisX().getTitle().setText("# of trials");
	chart1.getAxisX().getGrids().getMajor().setVisible(false);
	/* This is a sample for a bold Main Title */;
	TitleDockable td;
	td = new TitleDockable();
	td.setFont(new java.awt.Font("Arial",java.awt.Font.BOLD, 16));
	td.setTextColor(java.awt.Color.BLUE);
	td.setText("Blue Pill Pharmaceuticals, Inc.");
	chart1.getTitles().add(td);
	/* This is a sample for a SubTitle */;
	TitleDockable tdSub;
	tdSub = new TitleDockable();
	tdSub.setFont(new java.awt.Font("Arial",java.awt.Font.BOLD, 10));
	tdSub.setTextColor(java.awt.Color.GRAY);
	tdSub.setText("Drug Testing Analysis");
	chart1.getTitles().add(tdSub);
	/* This is a sample for a Rich Text Footer */;
	TitleDockable tdFooter;
	tdFooter = new TitleDockable();
	tdFooter.setFont(new java.awt.Font("Tahoma",java.awt.Font.BOLD, 12));
	tdFooter.setDock(DockArea.BOTTOM);
	tdFooter.setAlignment(com.softwarefx.StringAlignment.FAR);
	tdFooter.setTextColor(java.awt.Color.BLUE);
	tdFooter.setRichText(true);
	tdFooter.setText("Chart Created by: <b>John Doe</b> <i><font color=\'#999999\' family=\'Courier\'>Market Analyst</font></i>");
	chart1.getTitles().add(tdFooter);
	/* This is a sample for a multiline small print (legal disclaimer) in the bottom portion of the chart */;
	TitleDockable tdSmall;
	tdSmall = new TitleDockable();
	tdSmall.setFont(new java.awt.Font("Courier",java.awt.Font.BOLD, 7));
	tdSmall.setDock(DockArea.BOTTOM);
	tdSmall.setAlignment(com.softwarefx.StringAlignment.CENTER);
	tdSmall.setTextColor(java.awt.Color.DARK_GRAY);
	tdSmall.setPlotAreaOnly(true);
	tdSmall.setText("Information provided is subject to change without notice and does not represent a commitment on the part of Blue Pill \nPharmaceuticals. No part of this chart may be reproduced or transmitted in any form or by any means, electronic or \nmechanical, including photocopying, recording, or information storage and retrieval systems, for any purpose other than \nthe purchaser\'s personal use, without the express written permission of Blue Pill Pharmaceuticals, Inc.");
	chart1.getTitles().add(tdSmall);
	/* This code changes the second series label in the legend box to bold */;
	/* Please note the use of an indexer to determine the series we want to change the text for */;
	LegendItemAttributes itemAttribute;
	itemAttribute = new LegendItemAttributes();
	//itemAttribute.setFontStyle(com.softwarefx.FontStyle.BOLD);
	chart1.getLegendBox().getItemAttributes().set(((ILegendBoxItemCollection)chart1.getSeries()), 1, itemAttribute);
	/* This code shows th epoint labels for one series and changes the font for one particular point in the chart */;
	chart1.getSeries().get(2).getPointLabels().setVisible(true);
	chart1.getPoints().get(2, 5).getPointLabels().setFont(new java.awt.Font("Courier",java.awt.Font.BOLD, 16));
	chart1.getPoints().get(2, 5).getPointLabels().setVisible(true);
	chart1.getPoints().get(2, 5).getPointLabels().setTextColor(java.awt.Color.WHITE);
	chart1.setWidth(800);
	chart1.setHeight(600);
	chart1.renderControl();            
%>

    </body>
</html>
