<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Data Compacting</title>
    </head>
    <body>
<%
ChartServer chart1 = new ChartServer(pageContext, request, response);
chart1.getLegendBox().setVisible(false);
chart1.setGallery(com.softwarefx.chartfx.server.Gallery.BAR);
chart1.getAxisX().getLabelsFormat().setFormat(AxisFormat.DATE);
chart1.getData().setSeries(1);
chart1.getData().setPoints(65);
java.util.Calendar cal = new java.util.GregorianCalendar();
cal.set(2000, 0, 13); 
for (int i = 0; i < 65; i++) {
    chart1.getData().getX().set(0, i, Chart.dateToNumber(cal.getTime()));
    int nMonth = cal.get(java.util.Calendar.MONTH);
    cal.add(java.util.GregorianCalendar.DAY_OF_YEAR, 1);
    if (cal.get(java.util.Calendar.DAY_OF_WEEK) == java.util.Calendar.SATURDAY) {
        cal.add(java.util.GregorianCalendar.DAY_OF_YEAR, 1);
    }

    if (cal.get(java.util.Calendar.DAY_OF_WEEK) == java.util.Calendar.SUNDAY) {
        cal.add(java.util.GregorianCalendar.DAY_OF_YEAR, 1);
    }

    double dValue = (i + 1) * 10;
    int nNewMonth = cal.get(java.util.Calendar.MONTH);

    if (nMonth != nNewMonth) {
        dValue *= 2;
    }

    chart1.getData().getY().set(0, i, dValue);
}
chart1.getAxisX().setStep(30);

TitleDockable t = new TitleDockable();
chart1.getTitles().add(t);
t.setText("No Data Compacting");

chart1.setWidth(450);
chart1.setHeight(250);
chart1.setToolTips(false);
chart1.getImageSettings().setToolTips(ImageToolTipStyle.NONE);
chart1.getImageSettings().setInteractive(false);
chart1.renderControl();
out.println("&nbsp;");

// Compacting by month, using the first value
chart1.getData().setCompactedBy(30);
chart1.getData().getY().setCompactFormula(com.softwarefx.chartfx.server.CompactFormulas.getFirst());
t.setText("Compacting Month First");
chart1.renderControl();
out.println("&nbsp;");

// Compacting by month, using the average value
chart1.getData().setCompactedBy(30);
chart1.getData().getY().setCompactFormula(com.softwarefx.chartfx.server.CompactFormulas.getAverage());
t.setText("Compacting by Average");
chart1.renderControl();
out.println("&nbsp;");

// Compacting by month, using the last  value
chart1.getData().setCompactedBy(30);
chart1.getData().getY().setCompactFormula(com.softwarefx.chartfx.server.CompactFormulas.getLast());
t.setText("Compacting Month Last");
chart1.renderControl();
out.println("&nbsp;");

%>        
    </body>
</html>
