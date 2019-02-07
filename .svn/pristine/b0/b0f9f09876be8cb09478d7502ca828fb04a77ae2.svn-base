<%
    com.softwarefx.chartfx.gauge.RadialGauge.initWeb(application,request,response);
    com.softwarefx.chartfx.gauge.RadialGauge gauge = new com.softwarefx.chartfx.gauge.RadialGauge();

    gauge.setAntialiasing(com.softwarefx.chartfx.gauge.AntialiasingModes.GRAPHIC);
    gauge.getBorder().setColor(new java.awt.Color(64, 64, 64));
    gauge.getBorder().setInsideColor( java.awt.Color.black) ;
    gauge.getBorder().setStyle(com.softwarefx.chartfx.gauge.RadialBorderStyle.getCircularBorder10());

    com.softwarefx.chartfx.gauge.Needle needle1 =(com.softwarefx.chartfx.gauge.Needle) gauge.getMainIndicator();
    needle1.setStyle(com.softwarefx.chartfx.gauge.NeedleStyle.getNeedle06());
    needle1.setSize(0.7F);
    //needle1.setValue("20");
    needle1.setColor(java.awt.Color.white);  // Color WhiteSmoke

    gauge.getMainScale().getBar().setVisible(false);
    gauge.getMainScale().getCap().setVisible(false);
    gauge.getMainScale().setMax(12);
    gauge.getMainScale().setMaxAlwaysDisplayed(true);
    gauge.getMainScale().setRadius(0.89F);
    gauge.getMainScale().setStartAngle(90F);
    gauge.getMainScale().setSweepAngle(-360F);
    gauge.getMainScale().setThickness(0.1001F);

    gauge.getMainScale().getTickmarks().getMajor().setColor(java.awt.Color.white);
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setFont(new com.softwarefx.chartfx.gauge.GaugeFont("Arial", com.softwarefx.chartfx.gauge.GaugeFontSize.LARGER, java.awt.Font.PLAIN));
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setColor(java.awt.Color.white);
    gauge.getMainScale().getTickmarks().getMajor().getLabel().setPosition(com.softwarefx.chartfx.gauge.Position.CENTER);
    gauge.getMainScale().getTickmarks().getMajor().setStep(3);
    gauge.getMainScale().getTickmarks().getMajor().setSize(0.8F);
    gauge.getMainScale().getTickmarks().getMajor().setStyle(com.softwarefx.chartfx.gauge.TickmarkStyle.getNone());

    gauge.getMainScale().getTickmarks().getMedium().setStep(1);
    gauge.getMainScale().getTickmarks().getMedium().setSize(1.2F);
    gauge.getMainScale().getTickmarks().getMedium().setStyle(com.softwarefx.chartfx.gauge.TickmarkStyle.getTickmark04_3());
    gauge.getMainScale().getTickmarks().getMedium().setColor(java.awt.Color.white);

    gauge.getMainScale().getTickmarks().getMinor().setVisible(false);

    //Creating and setting a new scale
    com.softwarefx.chartfx.gauge.RadialScale radialScale1 = new com.softwarefx.chartfx.gauge.RadialScale();
    radialScale1.getBar().setVisible(false);
    //radialScale1.getCap().setVisible(false);
    radialScale1.setMax(60);
    radialScale1.setRadius(0.95F);
    radialScale1.setStartAngle(90F);
    radialScale1.setSweepAngle(-360F);
    radialScale1.setThickness(0.04F);

    radialScale1.getTickmarks().getMajor().setColor(java.awt.Color.white);
    radialScale1.getTickmarks().getMajor().getLabel().setVisible(false);
    radialScale1.getTickmarks().getMajor().setStep(5);
    radialScale1.getTickmarks().getMajor().setSize(0.8F);
    radialScale1.getTickmarks().getMajor().setStyle(com.softwarefx.chartfx.gauge.TickmarkStyle.getTickmark10_1());

    radialScale1.getTickmarks().getMedium().setVisible(false);

    radialScale1.getTickmarks().getMinor().setColor(java.awt.Color.white);
    radialScale1.getTickmarks().getMinor().setStep(1);
    radialScale1.getTickmarks().getMinor().setStyle(com.softwarefx.chartfx.gauge.TickmarkStyle.getTickmark02_2());

    gauge.getScales().add(radialScale1);

    // Setting the indicators for the new Scale
    needle1 = new com.softwarefx.chartfx.gauge.Needle();
    needle1.setStyle(com.softwarefx.chartfx.gauge.NeedleStyle.getNeedle06());
    needle1.setSize(0.85F);
    //needle1.setValue("20");
    needle1.setColor(java.awt.Color.white);
    radialScale1.getIndicators().add(needle1);

    needle1 = new com.softwarefx.chartfx.gauge.Needle();
    needle1.setStyle(com.softwarefx.chartfx.gauge.NeedleStyle.getNeedle18());
    needle1.setSize(0.93F);
    //needle1.setValue("25");
    needle1.setColor(java.awt.Color.red);
    radialScale1.getIndicators().add(needle1);

    java.util.Calendar cal = new java.util.GregorianCalendar();
    int hours = cal.get(cal.HOUR_OF_DAY) ;
    if (hours > 12)
        hours -= 12;
    gauge.getScales().getItem(0).getIndicators().getItem(0).setValue(String.valueOf(hours));
    gauge.getScales().getItem(1).getIndicators().getItem(0).setValue(String.valueOf(cal.get(cal.MINUTE)));
    gauge.getScales().getItem(1).getIndicators().getItem(1).setValue(String.valueOf(cal.get(cal.SECOND)));

    response.setDateHeader("Expires", 0);

    gauge.setWidth(200);
    gauge.setHeight(200);
    gauge.setToolTipEnabled(false);
    gauge.renderToStream();%>