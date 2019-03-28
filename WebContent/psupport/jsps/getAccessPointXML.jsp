<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 //String sSYS_KIND = request.getParameter("SYS_KIND").equals("")?"":request.getParameter("SYS_KIND");
 String sFACT_CODE = request.getParameter("FACT_CODE");
 String sBRANCH_NO = request.getParameter("BRANCH_NO");
 Statement stmt=null;
 
 sql = "SELECT ID, SEQ, LATITUDE, LONGITUDE, ETC, BRANCH_NO FROM T_ACCESS_POINT WHERE ID='"+sFACT_CODE+"' AND BRANCH_NO='"+sBRANCH_NO+"' ";

 try
 {
//out.println(sql);
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<APLISTS>");
  while(rs.next())
  {
	  out.println("<APLIST>");
	   out.println("<ID>" + rs.getString(1) + "</ID>");
	   out.println("<SEQ>" + rs.getInt(2) + "</SEQ>");
	   out.println("<LATITUDE>" + rs.getDouble(3) + "</LATITUDE>");
	   out.println("<LONGITUDE>" + rs.getDouble(4) + "</LONGITUDE>");
	   out.println("<ETC>" + rs.getString(5) + "</ETC>");
	   out.println("<BRANCH_NO>" + rs.getString(6) + "</BRANCH_NO>");
	   out.println("</APLIST>");
  }
  out.println("</APLISTS>");
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