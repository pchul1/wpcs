<%@page import="daewooInfo.mobile.com.utl.ObjectUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*, net.sf.json.*"%>
<%@ include file="dbconn.jsp" %><%

response.setContentType("text/html; charset=utf-8");
try
{
	String userId = (String) request.getSession().getAttribute("userId");
	String flag = (String) request.getParameter("flag");
	String factCode = (String) request.getParameter("factCode");
	String branchNo = (String) request.getParameter("branchNo");
	 
	Statement stmt=null;
	sql  = "SELECT OBJECTID, X, Y, FACI_NM, FACI_ADDR, RV_CD, FACT_CODE, BRANCH_NO FROM T_GIS_AUTO WHERE  ";
	if("U".equals(flag)){
		sql  = "SELECT OBJECTID, X, Y, FACI_NM, FACI_ADDR, RV_CD, FACT_CODE, BRANCH_NO, USE_FLAG FROM T_GIS_IPUSN WHERE  ";
	}
	sql += "FACT_CODE = '"+factCode+"' AND BRANCH_NO = '"+branchNo+"'";
	
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
catch(Exception ex) {
	ex.printStackTrace();
}
%>