<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
	 String sID = request.getParameter("ID");
	 String sNAME = new String((request.getParameter("NAME")).getBytes("8859_1"), "EUC-KR");
	 String sRIVER_ID = new String((request.getParameter("RIVER_ID")).getBytes("8859_1"), "EUC-KR");
	 String sBASIN_LARGE = new String((request.getParameter("BASIN_LARGE")).getBytes("8859_1"), "EUC-KR");
	 String sBASIN_MIDDLE = new String((request.getParameter("BASIN_MIDDLE")).getBytes("8859_1"), "EUC-KR");
	 String sLATITUDE = new String((request.getParameter("LATITUDE")).getBytes("8859_1"), "EUC-KR");
	 String sLONGITUDE = new String((request.getParameter("LONGITUDE")).getBytes("8859_1"), "EUC-KR");
	 String sDO_CODE = request.getParameter("DO_CODE");
	 String sCTY_CODE = request.getParameter("CTY_CODE");
	 String sADDRESS = new String((request.getParameter("ADDRESS")).getBytes("8859_1"), "EUC-KR");
 Statement stmt=null;
 sql  = "INSERT INTO T_FACTORY_INDUST(ID, NAME, RIVER_ID, BASIN_LARGE, BASIN_MIDDLE, LATITUDE, LONGITUDE, DO_CODE, CTY_CODE, ADDRESS, USE_YN)";
 sql += "VALUES('"+sID+"','" +sNAME+ "','"+sRIVER_ID+"','"+sBASIN_LARGE+"','"+ sBASIN_MIDDLE+"','" +sLATITUDE+"','" +sLONGITUDE+"','" +sDO_CODE+"','" +sCTY_CODE+"','" +sADDRESS+"','Y')";                                                                    
 
 try
 {
  //out.println(sql);
  stmt=conn.createStatement();
  int i =stmt.executeUpdate(sql);
  closeConn(rs,stmt,conn);
 }
 catch(SQLException ex)
 {
 // System.out.println(ex);
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