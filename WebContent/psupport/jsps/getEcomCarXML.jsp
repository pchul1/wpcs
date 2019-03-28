<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 //String sSYS_KIND = request.getParameter("SYS_KIND").equals("")?"":request.getParameter("SYS_KIND");

 Statement stmt=null;
 sql  = "SELECT CTY_CODE, DO_CODE, ID, LATITUDE, LONGITUDE, STATUS, UPDATE_TIME FROM T_ECOMCAR_GPS";

 try
 {
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<ECOMCARS>");
  while(rs.next())
  {
	   out.println("<ECOMCAR>");
	   out.println("<CTY_CODE>" + rs.getString(1) + "</CTY_CODE>");
	   out.println("<DO_CODE>" + rs.getString(2) + "</DO_CODE>");
	   out.println("<ID>" + rs.getString(3) + "</ID>");
	   out.println("<LATITUDE>" + rs.getDouble(4) + "</LATITUDE>");
	   out.println("<LONGITUDE>" + rs.getDouble(5) + "</LONGITUDE>");
	   out.println("<STATUS>" + rs.getString(6) + "</STATUS>");
	   out.println("<UPDATE_TIME>" + rs.getString(7) + "</UPDATE_TIME>");
	   out.println("</ECOMCAR>");
  }
  out.println("</ECOMCARS>");
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