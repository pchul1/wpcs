<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 
 String sNO = request.getParameter("NO");
 String sFACT_CODE = request.getParameter("FACT_CODE");
 Statement stmt=null;
 sql  = "SELECT	A.FACT_CODE, A.BRANCH_NO, B.ITEM_CODE, B.ITEM_NAME FROM T_FACT_ITEM A, T_ITEM B WHERE A.ITEM_CODE = B.ITEM_CODE "; 
  
 sql += " AND FACT_CODE LIKE '%" + sFACT_CODE + "%' AND BRANCH_NO LIKE '%" + sNO + "%'";

 try
 {
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<ITEMLISTS>");
  while(rs.next())
  {
	   out.println("<ITEMLIST>");
	   out.println("<FACT_CODE>" + rs.getString(1) + "</FACT_CODE>");
	   out.println("<BRANCH_NO>" + rs.getInt(2) + "</BRANCH_NO>");
	   out.println("<ITEM_CODE>" + rs.getString(3) + "</ITEM_CODE>");
	   out.println("<ITEM_NAME>" + rs.getString(4) + "</ITEM_NAME>");
	   out.println("</ITEMLIST>");
  }
 
  out.println("</ITEMLISTS>");
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