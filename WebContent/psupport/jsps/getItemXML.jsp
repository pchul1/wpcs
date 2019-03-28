<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 String sBRANCH_NO = request.getParameter("NO");
 String sFACT_CODE = request.getParameter("FACT_CODE");
 
 Statement stmt=null;
 sql  = "SELECT	A.FACT_CODE, A.ITEM_CODE, A.BRANCH_NO, B.ITEM_NAME FROM T_FACT_ITEM A, T_ITEM B WHERE A.ITEM_CODE = B.ITEM_CODE";
 sql += " AND FACT_CODE LIKE '%" + sFACT_CODE + "%' AND BRANCH_NO LIKE '%" + sBRANCH_NO + "%'";

 try
 {
// out.println(sql); 
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<ITEMS>");
  while(rs.next())
  {
	   out.println("<ITEM>");
	   out.println("<FACT_CODE>" + rs.getString(1) + "</FACT_CODE>");
	   out.println("<ITEM_CODE>" + rs.getString(2) + "</ITEM_CODE>");
	   out.println("<BRANCH_NO>" + rs.getInt(3) + "</BRANCH_NO>");
	   out.println("<ITEM_NAME>" + rs.getString(4) + "</ITEM_NAME>");
	   out.println("</ITEM>");
  }
  
  out.println("</ITEMS>");
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