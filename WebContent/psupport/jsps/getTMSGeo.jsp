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
	sql  = "SELECT OBJECTID, X, Y, FACI_NM, FACI_ADDR, RV_CD, FACT_CODE, BRANCH_NO FROM GIS_TMS WHERE 1=1";
	if(!"A".equals(rvCd)){
		sql += " AND RV_CD = '"+rvCd+"'";
	}
	
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
	} catch(SQLException ex) {
		ex.printStackTrace();
	} finally{
		closeConn(rs,stmt,conn);
	}
} catch(Exception ex) {
	ex.printStackTrace();
}
%>

