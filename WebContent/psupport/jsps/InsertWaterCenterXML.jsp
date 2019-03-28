<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 String sID = request.getParameter("ID");
 String sNAME = new String((request.getParameter("NAME")).getBytes("8859_1"), "EUC-KR");
 String sTYPE = new String((request.getParameter("TYPE")).getBytes("8859_1"), "EUC-KR");
 String sMANAGE = new String((request.getParameter("MANAGE")).getBytes("8859_1"), "EUC-KR");
 String sMANAGER = new String((request.getParameter("MANAGER")).getBytes("8859_1"), "EUC-KR");
 String sPHONE = new String((request.getParameter("PHONE")).getBytes("8859_1"), "EUC-KR");
 String sRIVER_DIV = new String((request.getParameter("RIVER_DIV")).getBytes("8859_1"), "EUC-KR");
 String sPROC_QTY = request.getParameter("PROC_QTY");
 String sCONT_TERM = request.getParameter("CONT_TERM");
 String sLATITUDE = request.getParameter("LATITUDE");
 String sLONGITUDE = request.getParameter("LONGITUDE");
 String sADDRESS = new String((request.getParameter("ADDRESS")).getBytes("8859_1"), "EUC-KR");
 String sDO_CODE = request.getParameter("DO_CODE");
 String sCTY_CODE = request.getParameter("CTY_CODE");
 String sSUPPLY_REGION = new String((request.getParameter("SUPPLY_REGION")).getBytes("8859_1"), "EUC-KR");
 String sRUN_DAY = request.getParameter("RUN_DAY");
 Statement stmt=null;
 sql  = "INSERT INTO T_WATERDC_CENTER (ID,NAME,TYPE,MANAGE,MANAGER,PHONE,RIVER_DIV,PROC_QTY,CONT_TERM, LATITUDE, LONGITUDE, ADDRESS, DO_CODE, CTY_CODE, SUPPLY_REGION, RUN_DAY USE_YN)";   
 sql += "VALUES('"+sID+"','" +sNAME+ "','"+sTYPE+"','"+sMANAGE+"','"+ sMANAGER+"','" +sPHONE+"','" +sRIVER_DIV+"','" +sPROC_QTY+"','" +sCONT_TERM+"','"+sLATITUDE+"','"+sLONGITUDE+"','"+sADDRESS+"','"+sDO_CODE+"','"+sCTY_CODE+"','"+sSUPPLY_REGION+"','"+sRUN_DAY+"','Y')";
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
 //System.out.println(ex);
	ex.printStackTrace();
}
%>