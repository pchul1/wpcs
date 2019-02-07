<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{

 Statement stmt=null;
 sql  = "SELECT ITEM_CODE, ITEM_NAME, ITEM_CODE_DET FROM T_ITEM_CODE ORDER BY ITEM_NAME";
 
 try
 {

  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<ECOMITEMS>");
  while(rs.next())
  {
	  out.println("<ECOMITEM>");
	   out.println("<ITEM_CODE>" + rs.getString(1) + "</ITEM_CODE>");
	   out.println("<ITEM_NAME>" + rs.getString(2) + "</ITEM_NAME>");
	   out.println("<ITEM_CODE_DET>" + rs.getString(3) + "</ITEM_CODE_DET>");
	   out.println("</ECOMITEM>");
  }
 
  out.println("</ECOMITEMS>");
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
%><%!
 public void closeConn(ResultSet rs, Statement stmt, Connection con) throws Exception
 {
  rs.close();
  con.close();
  stmt.close();
 }
%>