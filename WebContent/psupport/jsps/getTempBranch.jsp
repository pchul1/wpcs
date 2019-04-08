<%@page import="daewooInfo.mobile.com.utl.ObjectUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*, net.sf.json.*"%>
<%@ include file="dbconn.jsp" %><%

response.setContentType("text/html; charset=utf-8");
try {
	String userId = (String) request.getSession().getAttribute("userId");
	 
	Statement stmt=null;
	sql  = "SELECT OBJECTID, TEMP_SRNO, TITLE, CONTENT, REG_ID, REG_DATE, X, Y, ALL_YN, USE_YN FROM T_GIS_TEMP_BRANCH WHERE (USE_YN = '0' AND ALL_YN = '1') OR (REG_ID = '"+userId+"' AND USE_YN = '0')"; 
	
	JSONArray reJson = new JSONArray();

	try {
		stmt=conn.createStatement();
		rs=stmt.executeQuery(sql);
		
		while(rs.next()) {
			JSONObject jo = new JSONObject();
			ResultSetMetaData rmd = rs.getMetaData();
		
			for ( int i=1; i<=rmd.getColumnCount(); i++ ) {
				jo.put(rmd.getColumnName(i),rs.getString(rmd.getColumnName(i)));
			}
			reJson.add(jo);
		}
		out.println(reJson.toString());
	
		closeConn(rs,stmt,conn);
	} catch(SQLException ex) {
		ex.printStackTrace();
	}
}
catch(Exception ex)
{
	ex.printStackTrace();
}
%>