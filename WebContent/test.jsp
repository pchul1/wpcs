<%@page import="com.softwarefx.chartfx.server.*"%> <%@page contentType="text/html" pageEncoding="UTF-8"%>  <% ChartServer chart1 = new ChartServer(pageContext, request, response); chart1.getData().setSeries(1); chart1.getData().setPoints(10); chart1.getData().set(0, 0, 25); chart1.getData().set(0, 1, 45); chart1.getData().set(0, 2, 80); chart1.getData().set(0, 3, -21); chart1.getData().set(0, 4, 70); chart1.getData().set(0, 5, -56); chart1.getData().set(0, 6, -14); chart1.getData().set(0, 7, 67); chart1.getData().set(0, 8, 98); chart1.getData().set(0, 9, -43); chart1.setGallery(Gallery.BAR); chart1.setWidth(600); chart1.setHeight(400); chart1.getLegendBox().setVisible(false); chart1.renderControl(); %> 