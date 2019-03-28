<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 //String sSYS_KIND = request.getParameter("SYS_KIND").equals("")?"":request.getParameter("SYS_KIND");
 String sBASIN_LARGE = request.getParameter("BASIN_LARGE");
 
 Statement stmt=null;
 sql  = "SELECT BASIN_LARGE, BASIN_MIDDLE, BASIN_LARGE_NM, BASIN_MIDDLE_NM FROM T_BASIN WHERE 1=1 ";
 sql += " AND BASIN_LARGE='"+sBASIN_LARGE+"'AND BASIN_MIDDLE_NM IS NOT NULL group by BASIN_LARGE, BASIN_MIDDLE, BASIN_LARGE_NM, BASIN_MIDDLE_NM  ORDER BY BASIN_MIDDLE_NM";
 
 try
 {
	// out.println(sql);
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<BASIN>");
  while(rs.next())
  {
	  out.println("<MIDDLE>");
	   out.println("<BASIN_LARGE>" + rs.getInt(1) + "</BASIN_LARGE>");
	   out.println("<BASIN_MIDDLE>" + rs.getInt(2) + "</BASIN_MIDDLE>");
	   out.println("<BASIN_LARGE_NM>" + rs.getString(3) + "</BASIN_LARGE_NM>");
	   out.println("<BASIN_MIDDLE_NM>" + rs.getString(4) + "</BASIN_MIDDLE_NM>");
	   out.println("</MIDDLE>");
  }
  out.println("</BASIN>");
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