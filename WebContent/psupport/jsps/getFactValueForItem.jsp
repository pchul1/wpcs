<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*, net.sf.json.*"%><%@ include file="dbconn.jsp" %>

<%
response.setContentType("text/html; charset=utf-8");
try
{
	Statement stmt=null;
	sql = "SELECT ADM_CD,A.BRANCH_NO,A.FACT_CODE,FACT_NAME,MIN_OR,MIN_TIME,PHY,RIVER_DIV,SYS_KIND,V2,V3,V4,V5,V6,X,Y FROM V_FACT_LOC_INFO_NEW A, (SELECT OBJECTID, FACT_CODE, BRANCH_NO,X,Y FROM T_GIS_AUTO WHERE USE_FLAG = 'Y' UNION SELECT OBJECTID, FACT_CODE, BRANCH_NO,X,Y FROM T_GIS_TMS WHERE 1=1 UNION SELECT OBJECTID, FACT_CODE, BRANCH_NO,X,Y FROM T_GIS_IPUSN WHERE 1=1 AND USE_FLAG = 'Y') B WHERE A.FACT_CODE = B.FACT_CODE AND A.BRANCH_NO = B.BRANCH_NO";
	JSONArray reJson = new JSONArray();
	try
	{
		stmt=conn.createStatement();
		rs=stmt.executeQuery(sql);
		while(rs.next())
		{
			JSONObject  jo  = new JSONObject();
			ResultSetMetaData rmd = rs.getMetaData();
		
			for ( int i=1; i<=rmd.getColumnCount(); i++ )
			{
				jo.put(rmd.getColumnName(i),rs.getString(rmd.getColumnName(i)));
			}
			reJson.add(jo);
		}
		out.println(reJson.toString());
	
		closeConn(rs,stmt,conn);
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
%>