<%@page import="com.softwarefx.chartfx.gauge.*"%>
<%@page import="java.awt.*"%>
<%
   DigitalPanel.initWeb(application,request,response);
   DigitalPanel gauge = new DigitalPanel();
   
   
   String sText = request.getParameter("s");
	
	if (sText != null)
		gauge.setValue(sText + "         ");
	else
		gauge.setValue("The Text goes here ......");
		
   gauge.getBorder().setStyle(LinearBorderStyle.getLinearBorder03());   
   gauge.getBorder().setInsideColor(java.awt.Color.BLACK); 
   gauge.getBorder().setColor(java.awt.Color.BLACK);
   gauge.getBorder().setGlare(true);   
   
   gauge.getAppearance().setStyle(com.softwarefx.chartfx.gauge.DigitalCharacterStyle.getLed03());
   gauge.getAppearance().setOffDigitTransparency((short) 0);
   gauge.getAppearance().setColor(new java.awt.Color(0,191,255));  //DeepSkyBlue Color.
   gauge.getAppearance().setSize(0.95F);
   
   gauge.setWidth(500);
   gauge.setHeight(70);
   response.setDateHeader("Expires", 0);
   gauge.renderControl();
   
   %>