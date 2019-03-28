<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
	 String sID = request.getParameter("ID");
	 String sNM = new String((request.getParameter("NM")).getBytes("8859_1"), "EUC-KR");
	 String sOWNER = new String((request.getParameter("OWNER")).getBytes("8859_1"), "EUC-KR");
	 String sRIVER_DIV = new String((request.getParameter("RIVER_DIV")).getBytes("8859_1"), "EUC-KR");
	 String sD_PHONE = new String((request.getParameter("D_PHONE")).getBytes("8859_1"), "EUC-KR");
	 String sN_PHONE = new String((request.getParameter("N_PHONE")).getBytes("8859_1"), "EUC-KR");
	 String sE_PHONE = new String((request.getParameter("E_PHONE")).getBytes("8859_1"), "EUC-KR");
	 String sTYPE = new String((request.getParameter("TYPE")).getBytes("8859_1"), "EUC-KR");
	 String sFAX = new String((request.getParameter("FAX")).getBytes("8859_1"), "EUC-KR");
	 String sLATITUDE = request.getParameter("LATITUDE");
	 String sLONGITUDE = request.getParameter("LONGITUDE");
	 String sADDRESS = new String((request.getParameter("ADDRESS")).getBytes("8859_1"), "EUC-KR");
	 String sDO_CODE = request.getParameter("DO_CODE");
	 String sCTY_CODE = request.getParameter("CTY_CODE");
 Statement stmt=null;
 sql  = "UPDATE T_ECOMPANY SET ID='"+ sID +"' ,NM='"+ sNM+"', OWNER='"+ sOWNER+"', RIVER_DIV='"+ sRIVER_DIV+"', D_PHONE='"+sD_PHONE+"',N_PHONE='"+sN_PHONE+ "',E_PHONE='"+sE_PHONE+"',TYPE='"+ sTYPE+ "',FAX='"+ sFAX+"', LATITUDE='"+sLATITUDE+"', LONGITUDE='" +sLONGITUDE+"', ADDRESS='"+sADDRESS+"', DO_CODE='"+sDO_CODE+"', CTY_CODE='"+sCTY_CODE+"'";   
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