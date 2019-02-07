<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 String sID = request.getParameter("ID");
 String sNM = new String((request.getParameter("NM")).getBytes("8859_1"), "EUC-KR");
 String sADDRESS = new String((request.getParameter("ADDRESS")).getBytes("8859_1"), "EUC-KR");
 String sDEPT = new String((request.getParameter("DEPT")).getBytes("8859_1"), "EUC-KR");
 String sDO_CODE = new String((request.getParameter("DO_CODE")).getBytes("8859_1"), "EUC-KR");
 String sCTY_CODE = new String((request.getParameter("CTY_CODE")).getBytes("8859_1"), "EUC-KR");
 String sDAY_TEL = new String((request.getParameter("DAY_TEL")).getBytes("8859_1"), "EUC-KR");
 String sNIGHT_TEL = new String((request.getParameter("NIGHT_TEL")).getBytes("8859_1"), "EUC-KR");
 String sDAY_FAX = new String((request.getParameter("DAY_FAX")).getBytes("8859_1"), "EUC-KR");
 String sNIGHT_FAX = new String((request.getParameter("NIGHT_FAX")).getBytes("8859_1"), "EUC-KR");

 Statement stmt=null;
 sql  = "UPDATE T_RELATE_OFFICE SET ID='"+ sID +"' ,NM='"+ sNM+"', ADDRESS='"+ sADDRESS+"', DO_CODE='"+ sDO_CODE+"', CTY_CODE='"+sCTY_CODE+"',DEPT='"+sDEPT+ "',DAY_TEL='"+sDAY_TEL+ "', NIGHT_TEL='"+sNIGHT_TEL+"', DAY_FAX='"+sDAY_FAX+"', NIGHT_FAX='"+sNIGHT_FAX+"'";   
 sql += " WHERE ID='" +sID +"'";
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
	out.println("<EX>" + ex + "</EX>");
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