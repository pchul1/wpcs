<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
	String sFACT_CODE = new String((request.getParameter("FACT_CODE")).getBytes("8859_1"), "EUC-KR");
	String sBRANCH_NO = new String((request.getParameter("BRANCH_NO")).getBytes("8859_1"), "EUC-KR");
 Statement stmt=null;
 sql  = "INSERT INTO T_FACT_BRANCH_INFO(FACT_CODE, BRANCH_NO,BRANCH_USE_FLAG)";
 sql += "VALUES('"+sFACT_CODE+"','" +sBRANCH_NO+ "','Y')";                                             
 
 try
 {
  //out.println(sql);
  stmt=conn.createStatement();
  int i =stmt.executeUpdate(sql);
  closeConn(rs,stmt,conn);
 
 }
 catch(SQLException ex)
 {
  System.out.println(ex);
 }
}
catch(Exception ex)
{
 System.out.println(ex);
}
%>