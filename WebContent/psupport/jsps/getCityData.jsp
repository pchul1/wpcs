<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*, net.sf.json.*"%><%@ include file="dbconn.jsp" %>

<%
response.setContentType("text/html; charset=utf-8");
try
{
	Statement stmt=null;
	sql = "SELECT RPAD(CODE, 10, '0') AS CODE,DO_NM,NORMAL,A1,A2,A3,A4,M,PHY,V2,V3,V4,V5,V6 FROM V_FACT_LOC_INFO_1D";
 
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