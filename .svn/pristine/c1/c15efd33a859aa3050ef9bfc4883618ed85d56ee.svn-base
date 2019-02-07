<%@page import="com.softwarefx.chartfx.gauge.*,java.awt.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <link REL="stylesheet" TYPE="text/css" href="../cfxgauges.css"/>
    </head>
    <body>
        <form id="Form1" method="post" runat="server">
            <table width="696" border="0" cellspacing="0" cellpadding="0" class="bodyBorder">
                <tr>
                    <td>
                    <table border="0" cellpadding="2" cellspacing="2">
                        <tr>
                            <td>
<%
    com.softwarefx.chartfx.gauge.RadialGauge.initWeb(pageContext,request,response);
    com.softwarefx.chartfx.gauge.RadialGauge gauge = new com.softwarefx.chartfx.gauge.RadialGauge();

    gauge.setBackColor(Color.white);

    gauge.getBorder().setColor(java.awt.Color.black);
    gauge.getBorder().setInsideColor( java.awt.Color.black) ;
    gauge.getBorder().setStyle(RadialBorderStyle.getCircularBorder19());
    gauge.getBorder().setGlare(true);

    //Setting the images
    BitmapImage gaugeImage1 = new BitmapImage();
    javax.swing.ImageIcon ico = new javax.swing.ImageIcon(application.getRealPath("/gauges") + "/RadialGauges/images/gas.png");
    java.awt.Image img = ico.getImage();
    gaugeImage1.setImage(img);
    gaugeImage1.getLayout().setTarget(LayoutTarget.ANCHOR_POINT);
    gaugeImage1.getLayout().getAnchorPoint().setLocation(-0.2,0.35);

    BitmapImage gaugeImage2 = new BitmapImage();
    ico = new javax.swing.ImageIcon(application.getRealPath("/gauges") + "/RadialGauges/images/temp.png");
    img = ico.getImage();
    gaugeImage2.setImage(img);
    gaugeImage2.getLayout().setTarget(LayoutTarget.ANCHOR_POINT);
    gaugeImage2.getLayout().getAnchorPoint().setLocation(-0.225,-0.3);

    gauge.getImages().add(gaugeImage1);
    gauge.getImages().add(gaugeImage2);

    //Setting the MainScale
    gauge.getMainScale().getBar().setColor(Color.black);

    gauge.getMainScale().setRadius(0.65F);
    gauge.getMainScale().getPivot().setLocation(0,0.1);
    gauge.getMainScale().setStartAngle(90F);
    gauge.getMainScale().setSweepAngle(-90F);
    gauge.getMainScale().setMax(100);
    gauge.getMainScale().getCap().setSize(0.13F);

    //Setting a Section
    Section section1 = new Section();
    section1.setMaxAlwaysDisplayed(true);
    section1.setMin(75);
    section1.getBar().setColor(Color.red);
    gauge.getMainScale().getSections().add(section1);

    Needle needle1 =(Needle) gauge.getMainIndicator();
    needle1.setSize(0.75F);
    needle1.setValue("55");

    gauge.getMainScale().getTickmarks().getMajor().setColor(new java.awt.Color(0,0,0,0));  // Color transparent
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setVisible(false);
    gauge.getMainScale().getTickmarks().getMajor().setStyle(TickmarkStyle.getTickmark01_3());
    gauge.getMainScale().getTickmarks().getMedium().setColor(Color.gray);
    gauge.getMainScale().getTickmarks().getMedium().setStyle(TickmarkStyle.getTickmark01_3());
    gauge.getMainScale().getTickmarks().getMinor().setVisible(false);
    //gauge.getMainScale().getTickmarks().getMedium().setVisible(false);

    //Creating and setting a new scale
    RadialScale radialScale1 = new RadialScale();
    radialScale1.setStartAngle(0F);
    radialScale1.setSweepAngle(-90F);
    radialScale1.setMax(0);
    radialScale1.setMin(100);
    radialScale1.setRadius(0.65F);
    radialScale1.getPivot().setLocation(0,-0.1);

    radialScale1.getBar().setColor(Color.black);
    radialScale1.getCap().setSize(0.13F);

    //Creating and setting a Section for radialScale1
    Section section2 = new Section();
    section2.getBar().setColor(Color.red);
    section2.setMin(75);
    radialScale1.getSections().add(section2);

    //Creating and setting a Needle for radialScale1
    Needle needle2 = new Needle();
    needle2.setSize(0.75F);
    needle2.setValue("33");
    radialScale1.getIndicators().add(needle2);

    radialScale1.getTickmarks().getMajor().setColor(new java.awt.Color(0,0,0,0));  // Color transparent
    radialScale1.getTickmarks().getMajor().getLabel().setVisible(false);
    radialScale1.getTickmarks().getMajor().setStyle(TickmarkStyle.getTickmark01_3());
    radialScale1.getTickmarks().getMedium().setColor(Color.gray);
    radialScale1.getTickmarks().getMedium().setStyle(TickmarkStyle.getTickmark01_3());
    radialScale1.getTickmarks().getMinor().setVisible(false);
    gauge.getScales().add(radialScale1);

    //Setting the titles:

    Title title1 = new Title();
    title1.setText("H");
    title1.setColor(Color.white);
    title1.getLayout().setTarget(LayoutTarget.ANCHOR_POINT);
    title1.getLayout().getAnchorPoint().setLocation(0.8,-0.125);
    gauge.getTitles().add(title1);

    title1 = new Title();
    title1.setText("C");
    title1.setColor(Color.white);
    title1.getLayout().setTarget(LayoutTarget.ANCHOR_POINT);
    title1.getLayout().getAnchorPoint().setLocation(0,-0.9);
    gauge.getTitles().add(title1);

    title1 = new Title();
    title1.setText("F");
    title1.setColor(Color.white);
    title1.getLayout().setTarget(LayoutTarget.ANCHOR_POINT);
    title1.getLayout().getAnchorPoint().setLocation(0,0.87);
    gauge.getTitles().add(title1);

    title1 = new Title();
    title1.setText("E");
    title1.setColor(Color.white);
    title1.getLayout().setTarget(LayoutTarget.ANCHOR_POINT);
    title1.getLayout().getAnchorPoint().setLocation(0.8,0.1);
    gauge.getTitles().add(title1);

    gauge.setWidth(320);
    gauge.setHeight(350);
    gauge.setToolTipEnabled(false);
    gauge.renderControl();
%>
                            </td>
                            <td>
                                <P style="FONT-SIZE: 9pt; FONT-FAMILY: Arial" align="justify">This gauge illustrates how you can setup and locate multiple scales, needles and 
images. Any gauge element can be easily located in the drawing area based on a 
location relative to the border or specific anchor point. Open the properties 
dialog for any element and look for the Layout property. Notice how each scale 
in this sample has been modified so no tickmarks and custom labels are 
displayed, achieving a very realistic look. </P>
                                <P>&nbsp;</P>
                            </td>
                        </tr>
                    </table>
                    </td>
                </tr>
            </table>
            &nbsp;
        </form>
    </body>
</HTML>