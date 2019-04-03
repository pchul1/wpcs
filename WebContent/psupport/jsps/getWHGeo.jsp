<%@page import="daewooInfo.mobile.com.utl.ObjectUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*, net.sf.json.*"%>
<%@ include file="dbconn.jsp" %><%

response.setContentType("text/html; charset=utf-8");
try
{
	String userId = (String) request.getSession().getAttribute("userId");
	String rvCd = (String) request.getParameter("rvCd");
	 
	Statement stmt=null;
	sql  = "SELECT OBJECTID, WH_CODE, WH_NAME, ADMIN_MGR, ADMIN_SUB_, ADMIN_TELN, LON AS X, LAT AS Y, CTY_CODE, USE_FLAG, HOUSE_TYPE FROM T_GIS_WAREHOUSE WHERE  USE_FLAG = 'Y' ";
	
	JSONArray reJson = new JSONArray();
	try {
		stmt=conn.createStatement();
		rs=stmt.executeQuery(sql);
		
		while(rs.next()) {
			JSONObject jo = new JSONObject();
			ResultSetMetaData rmd = rs.getMetaData();
		
			for ( int i=1; i<=rmd.getColumnCount(); i++ )
			{
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