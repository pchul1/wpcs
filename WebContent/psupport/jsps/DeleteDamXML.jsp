<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
	String sID = request.getParameter("ID");
	Statement stmt=null;
	sql = "UPDATE T_DAM SET USE_YN = 'N' WHERE ID='" +sID +"'";

 try 
 {
  out.println(sql);
  stmt=conn.createStatement();
  int i =stmt.executeUpdate(sql);
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
 System.out.println(ex);
}
%>