<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 String sID = request.getParameter("ID");
 String sNAME = new String((request.getParameter("NAME")).getBytes("8859_1"), "EUC-KR");
 String sRIVER_ID = request.getParameter("RIVER_ID");
 String sBASIN_LARGE = request.getParameter("BASIN_LARGE");
 String sBASIN_MIDDLE =request.getParameter("BASIN_MIDDLE");
 String sLATITUDE =request.getParameter("LATITUDE");
 String sLONGITUDE = request.getParameter("LONGITUDE");
 String sDO_CODE = request.getParameter("DO_CODE");
 String sCTY_CODE = request.getParameter("CTY_CODE");
 String sADDRESS = new String((request.getParameter("ADDRESS")).getBytes("8859_1"), "EUC-KR");

 Statement stmt=null;
 sql  = "UPDATE T_FACTORY_INDUST SET ID='"+ sID +"' ,NAME='"+ sNAME+"', RIVER_ID='"+ sRIVER_ID+"', BASIN_LARGE='"+ sBASIN_LARGE+"', BASIN_MIDDLE='"+sBASIN_MIDDLE+"',LATITUDE='"+sLATITUDE+ "',LONGITUDE='"+sLONGITUDE+"',DO_CODE='"+ sDO_CODE + "',CTY_CODE='"+ sCTY_CODE+ "',ADDRESS='"+sADDRESS+ "'";   
 sql += " WHERE ID='" +sID +"'";
 try
 {
  //out.println(sql);
  stmt=conn.createStatement();
  int i =stmt.executeUpdate(sql);
  closeConn(rs,stmt,conn);
 }
 catch(SQLException ex)
 {
  //System.out.println(ex);
  ex.printStackTrace();
	 out.println("<EX>" + ex + "</EX>");
 }
}
catch(Exception ex)
{
 //System.out.println(ex);
	ex.printStackTrace();
}
%>