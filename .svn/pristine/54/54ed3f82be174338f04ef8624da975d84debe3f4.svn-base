<%@page import="com.softwarefx.chartfx.gauge.*,java.awt.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <link REL="stylesheet" TYPE="text/css" href="../cfxgauges.css">
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

    //Setting the BackGround Image
    BitmapImage gaugeImage1 = new BitmapImage();
    javax.swing.ImageIcon ico = new javax.swing.ImageIcon(application.getRealPath("/gauges") + "/RadialGauges/images/custom.png");
    java.awt.Image img = ico.getImage();
    gaugeImage1.setImage(img);
    gauge.getImages().add(gaugeImage1);

    gauge.getBorder().setColor(Color.black);
    gauge.getBorder().setGlare(true);
    gauge.getBorder().setInsideColor( Color.black) ;
    gauge.getBorder().setStyle(RadialBorderStyle.getCircularBorder12());

    gauge.getMainScale().setStartAngle(180F);
    gauge.getMainScale().setSweepAngle(-180F);
    gauge.getMainScale().setMax(180);
    gauge.getMainScale().setRadius(0.89F);
    gauge.getMainScale().setThickness(0.042F);

    //Setting first Section
    Section section1 = new Section();
    section1.setMin(80);
    section1.getBar().setColor(Color.green);
    gauge.getMainScale().getSections().add(section1);

    //Setting second Section
    section1 = new Section();
    section1.setMax(80);
    section1.getBar().setColor(Color.red);
    gauge.getMainScale().getSections().add(section1);

    //Setting third Section
    section1 = new Section();
    section1.setMin(180);
    section1.getBar().setColor(Color.red);
    gauge.getMainScale().getSections().add(section1);
    
    // Set the needle
    Needle needle1 =(Needle) gauge.getMainIndicator();
    needle1.setStyle(NeedleStyle.getNeedle02());
    needle1.setSize(0.9F);
    needle1.setValue("125");
    needle1.setColor(new java.awt.Color(255, 215, 0));  // Color Gold

    gauge.getMainScale().getTickmarks().getMajor().setVisible(false);
    gauge.getMainScale().getTickmarks().getMedium().setVisible(false);
    gauge.getMainScale().getTickmarks().getMinor().setVisible(false);

    gauge.getMainScale().getCap().setVisible(true);
    gauge.getMainScale().getCap().setSize(0.3F);

    gauge.setWidth(320);
    gauge.setHeight(350);
    gauge.setToolTipEnabled(false);
    gauge.renderControl();%>
                                </td>
                                <td>    
                                    <P style="FONT-SIZE: 9pt; FONT-FAMILY: Arial" align="justify">In some cases gauges 
                                        are so complex that even a flexible API is not enough to meet your needs. This 
                                        is one such case. We wanted to simulate a fire extinguisher gauge that provides 
                                        complex visuals and scales. We created an image and a basic scale with color 
                                        stripes (red-green-red) and no tickmarks. Please note the photorealistic needle 
                                        shadow.&nbsp;
                                    </P>
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
</html>
