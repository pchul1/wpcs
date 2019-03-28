<%@page import="daewooInfo.mobile.com.utl.ObjectUtil"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 //String sSYS_KIND = request.getParameter("SYS_KIND").equals("")?"":request.getParameter("SYS_KIND");

 Statement stmt=null;
 sql  = "SELECT  A.FACT_CODE, A.BRANCH_NO, A.LONGITUDE, A.LATITUDE,A.INPUT_TIME,"; 
sql+="TO_CHAR(TO_DATE(A.INPUT_TIME, 'YYYYMMDDHH24MI'), 'YYYY-MM-DD HH24:MI'),";
sql+="A.STATUS_FLAG, A.BATTERY, B.FACT_CODE, B.BRANCH_NO, B.BRANCH_FNAME, B.BRANCH_NAME FROM T_IPUSN_GPS A, T_FACT_BRANCH_INFO B, (SELECT FACT_CODE, BRANCH_NO, MAX(INPUT_TIME)INPUT_TIME FROM T_IPUSN_GPS GROUP BY FACT_CODE,BRANCH_NO)C WHERE A.FACT_CODE = B.FACT_CODE AND A.BRANCH_NO = B.BRANCH_NO AND STATUS_FLAG='Y' AND B.BRANCH_USE_FLAG='Y' AND A.FACT_CODE=C.FACT_CODE AND A.BRANCH_NO = C.BRANCH_NO AND A.INPUT_TIME = C.INPUT_TIME AND SUBSTR( TO_NUMBER(A.INPUT_TIME),1,8) > '20110105' AND SUBSTR( TO_NUMBER(A.INPUT_TIME),1,8) <= '" + ObjectUtil.getTimeString("yyyyMMdd") + "'";
//System.out.println(sql);

 try
 {
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<IPUSNS>");
  while(rs.next())
  {
	   out.println("<IPUSN>");
	   out.println("<FACT_CODE>" + rs.getString(1) + "</FACT_CODE>");
	   out.println("<BRANCH_NO>" + rs.getInt(2) + "</BRANCH_NO>");
	   out.println("<LONGITUDE>" + rs.getDouble(3) + "</LONGITUDE>");
	   out.println("<LATITUDE>" + rs.getDouble(4) + "</LATITUDE>");
	   out.println("<INPUT_TIME>" + rs.getString(5) + "</INPUT_TIME>");
	   out.println("<UPDATE_TIME>" + rs.getString(6) + "</UPDATE_TIME>");
	   out.println("<STATUS_FLAG>" + rs.getString(7) + "</STATUS_FLAG>");
	   out.println("<BATTERY>" + rs.getString(8) + "</BATTERY>");
	   out.println("<FACT_CODE_BRANCH>" + rs.getString(9) + "</FACT_CODE_BRANCH>");
	   out.println("<BRANCH_NO_BRANCH>" + rs.getString(10) + "</BRANCH_NO_BRANCH>");
	   out.println("<BRANCH_FNAME>" + rs.getString(11) + "</BRANCH_FNAME>");
	   out.println("<BRANCH_NAME>" + rs.getString(12) + "</BRANCH_NAME>");
	   out.println("</IPUSN>");
  }
  out.println("</IPUSNS>");
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