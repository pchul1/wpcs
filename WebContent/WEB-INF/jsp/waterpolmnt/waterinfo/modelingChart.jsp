<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="com.softwarefx.chartfx.server.*"%>
<%@page import="com.softwarefx.chartfx.server.dataproviders.*"%>
<%@ include file="/psupport/jsps/dbconn.jsp" %>

<%
response.setContentType("text/html; charset=utf-8");
String factCode = request.getParameter("factCode");
String frDate = request.getParameter("frDate");
String toDate = request.getParameter("toDate");
String width = request.getParameter("width");
String height = request.getParameter("height");

try
{
	Statement stmt=null;
	sql = "SELECT	TO_CHAR(TO_DATE(MODEL_DATE,'YYYYMMDD'),'YYYY.MM.DD') AS modelDate " +
		  "		    ,MESU_VALU AS mesuValu " +
		  "		    ,ROUND(PRED_VALU1,1) as predValu1 " +
		  "		    ,ROUND(PRED_VALU2,1) as predValu2 " +
		  "		    ,NIER_FROM as nierFrom " +
		  "		    ,NIER_TO as nierTo " +
		  "  FROM	T_MODELING " +
		  " WHERE	1 = 1 " +
		  "   AND	FACT_CODE = '" + factCode + "'" +
		  "   AND	MODEL_DATE >= '" + frDate + "'" +
		  "   AND	MODEL_DATE <= '" + toDate + "'" +
		  " ORDER	BY MODEL_SEQ";
	
	try
	{
		stmt=conn.createStatement();
		rs=stmt.executeQuery(sql);
		
	
		ChartServer chart1 = new ChartServer(pageContext,request,response);

		JDBCDataProvider provider = new JDBCDataProvider(rs);
		chart1.getDataSourceSettings().getFields().add(new FieldMap("modelDate",FieldUsage.LABEL));
		chart1.getDataSourceSettings().getFields().add(new FieldMap("nierFrom", FieldUsage.FROM_VALUE));
		chart1.getDataSourceSettings().getFields().add(new FieldMap("nierTo", FieldUsage.VALUE));
		chart1.getDataSourceSettings().getFields().add(new FieldMap("mesuValu",FieldUsage.VALUE));
		chart1.getDataSourceSettings().getFields().add(new FieldMap("predValu1", FieldUsage.VALUE));
		chart1.getDataSourceSettings().getFields().add(new FieldMap("predValu2", FieldUsage.VALUE));
		chart1.getDataSourceSettings().setDataSource(provider);

		chart1.getSeries().get(0).setGallery(Gallery.BAR);
		chart1.getSeries().get(0).setColor(new java.awt.Color(255, 165, 0));
		chart1.getSeries().get(0).setText("과학원예측범위");
        chart1.getSeries().get(1).setText("실측값");
        chart1.getSeries().get(2).setText("회귀분석");
        chart1.getSeries().get(3).setText("요인분석+회귀분석");
		
		SeriesAttributes series = chart1.getSeries().get(1);

		series.setGallery(Gallery.LINES);
		series.setMarkerShape(MarkerShape.CIRCLE);
		series.getPointLabels().setVisible(true);
		series.getPointLabels().setLineAlignment(com.softwarefx.StringAlignment.FAR);

		chart1.getAxisY().getLabelsFormat().setDecimals(1);
		chart1.getAxisX().setLabelAngle((short)270);
		chart1.getLegendBox().setFont(new java.awt.Font("굴림",java.awt.Font.PLAIN,10));
		chart1.getLegendBox().setDock(DockArea.BOTTOM);
		chart1.getLegendBox().setContentLayout(ContentLayout.SPREAD);
		chart1.getSeries().get(0).sendToBack();
		chart1.setWidth(Integer.parseInt(width));
		chart1.setHeight(Integer.parseInt(height));

		chart1.renderControl();
		
		//closeConn(rs,stmt,conn);
	}
	catch(SQLException ex)
	{
		//System.out.println(ex);
		ex.printStackTrace();
	}
}
catch(Exception ex)
{
	//System.out.println(ex);
	ex.printStackTrace();
}

%><%!
	public void closeConn(ResultSet rs, Statement stmt, Connection con) throws Exception
	{
		rs.close();
		con.close();
		stmt.close();
	}
%>