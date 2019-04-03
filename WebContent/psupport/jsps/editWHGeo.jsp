<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%>
<%@ include file="dbconn.jsp" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>

<%
try
{
	String userId = (String)request.getSession().getAttribute("userId");
	String flag   = (String)request.getParameter("flag");
	
	String WH_CODE = (String)request.getParameter("WH_CODE");
	String WH_NAME = (String)request.getParameter("WH_NAME");
	String ADMIN_MGR = (String)request.getParameter("ADMIN_MGR");
	String ADMIN_SUB_ = (String)request.getParameter("ADMIN_SUB_");
	String ADMIN_TELN = (String)request.getParameter("ADMIN_TELN");
	String LON = (String)request.getParameter("LON");
	String LAT = (String)request.getParameter("LAT");
	String USE_FLAG = (String)request.getParameter("USE_FLAG");
	String HOUSE_TYPE = (String)request.getParameter("HOUSE_TYPE");

	if("I".equals(flag)){
		sql  = "INSERT INTO T_GIS_WAREHOUSE(OBJECTID, LON, LAT, WH_CODE, WH_NAME, ADMIN_MGR, ADMIN_SUB_, ADMIN_TELN, USE_FLAG, HOUSE_TYPE)"+ 
				   "VALUES((SELECT MAX(OBJECTID)+1 FROM T_GIS_WAREHOUSE), '"+LON+"', '"+LAT+"',"+
				   "'"+WH_CODE+"', '"+WH_CODE+"', '"+WH_CODE+"', '"+WH_CODE+"', '"+WH_CODE+"', '"+USE_FLAG+"', '"+HOUSE_TYPE+"')";			                                                                    
	}else if("U".equals(flag)){
		sql  = "UPDATE T_GIS_WAREHOUSE SET LON = '"+LON+"', LAT = '"+LAT+"',WH_NAME = '"+WH_NAME+"',ADMIN_MGR = '"+ADMIN_MGR+"', ADMIN_SUB_='"+ADMIN_SUB_+", ADMIN_TELN='"+ADMIN_TELN+"', USE_FLAG='"+USE_FLAG+"', HOUSE_TYPE='"+HOUSE_TYPE+"'"+
				"WHERE WH_CODE='"+WH_CODE+"'"; 
	}else if("D".equals(flag)) {
		sql  = "DELETE FROM T_GIS_WAREHOUSE"+
				"WHERE WH_CODE='"+WH_CODE+"'";
	}
	Statement stmt=null;
	
	try {
		stmt=conn.createStatement();
		int i =stmt.executeUpdate(sql);
		out.println(i);
	} catch(SQLException ex) {
		ex.printStackTrace();
	} finally{
		closeConn(rs,stmt,conn);
	}
}
catch(Exception ex)
{
	ex.printStackTrace();
}
%>