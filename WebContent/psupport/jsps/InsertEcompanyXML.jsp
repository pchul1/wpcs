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
 sql  = "INSERT INTO T_ECOMPANY(ID, NM, OWNER, RIVER_DIV, D_PHONE, N_PHONE, E_PHONE, TYPE, FAX, LATITUDE, LONGITUDE, ADDRESS, DO_CODE, CTY_CODE, USE_YN)";
 sql += "VALUES('"+sID+"','" +sNM+ "','"+sOWNER+"','"+sRIVER_DIV+"','"+ sD_PHONE+"','" +sN_PHONE+"','" +sE_PHONE+"','" +sTYPE+"','" +sFAX+"','"+sLATITUDE+"','"+sLONGITUDE+"','"+sADDRESS+"','"+sDO_CODE+"','"+sCTY_CODE+"','Y')";                                                                    
 
 try
 {
  //out.println(sql);
  stmt=conn.createStatement();
  int i =stmt.executeUpdate(sql);
  closeConn(rs,stmt,conn);
 }
 catch(SQLException ex)
 {
	 out.println("<EX>" + ex + "</EX>");
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