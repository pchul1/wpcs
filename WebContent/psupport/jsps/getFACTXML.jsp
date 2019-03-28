<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%>
<%@ include file="dbconn.jsp" %>
<%
response.setContentType("text/xml; charset=utf-8");
try
{
	String lon = request.getParameter("lon");
	String lan = request.getParameter("lan");

	Statement stmt=null;
	sql = " SELECT FN_GET_MIN_DEGREE_FACT("+lan+","+lon+") FROM dual ";
	
	try
	{
		//System.out.println("getFACTXML sql : " + sql);
		stmt=conn.createStatement();
		rs=stmt.executeQuery(sql);
		
// 		if(format == null || format.toUpperCase().equals("XML"))
// 		{
		out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
		
		while(rs.next())
		{
			out.println("<ITEMS>"+rs.getString(1)+"</ITEMS>");
		}
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