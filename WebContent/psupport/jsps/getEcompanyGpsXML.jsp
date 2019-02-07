<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 //String sSYS_KIND = request.getParameter("SYS_KIND").equals("")?"":request.getParameter("SYS_KIND");

 Statement stmt=null;
 sql  = "SELECT  A.MEMBER_ID, A.MOBILE_NO, A.MEMBER_NAME, A.GRADE_NAME,A.ADDR, A.DET_ADDR, B.MEMBER_ID, B.LATITUDE, B.LONGITUDE,";
 sql+="TO_CHAR(TO_DATE(B.REG_DATE, 'YYYYMMDDHH24MISS'), 'YYYY-MM-DD HH24:MI:SS') UPDATE_TIME";
 sql+=" FROM T_MEMBER A, T_PHONE_LOCATION B , (SELECT MEMBER_ID, MAX(REG_DATE) REG_DATE FROM T_PHONE_LOCATION GROUP BY MEMBER_ID) C WHERE A.MEMBER_ID = B.MEMBER_ID  AND B.MEMBER_ID=C.MEMBER_ID AND B.REG_DATE=C.REG_DATE";
 
 try
 {
  //out.println(sql);
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<ECOMGPSS>");
  while(rs.next())
  {
	   out.println("<ECOMGPS>");
	   out.println("<MEMBER_ID>" + rs.getString(1) + "</MEMBER_ID>");
	   out.println("<MOBILE_NO>" + rs.getString(2) + "</MOBILE_NO>");
	   out.println("<MEMBER_NAME>" + rs.getString(3) + "</MEMBER_NAME>");
	   out.println("<GRADE_NAME>" + rs.getString(4) + "</GRADE_NAME>");
	   out.println("<ADDR>" + rs.getString(5) + "</ADDR>");
	   out.println("<DET_ADDR>" + rs.getString(6) + "</DET_ADDR>");
	   out.println("<MEMBER_ID_PHONE>" + rs.getString(7) + "</MEMBER_ID_PHONE>");
	   out.println("<LATITUDE>" + rs.getDouble(8) + "</LATITUDE>");
	   out.println("<LONGITUDE>" + rs.getDouble(9) + "</LONGITUDE>");
	   out.println("<UPDATE_TIME>" + rs.getString(10) + "</UPDATE_TIME>");
	   out.println("</ECOMGPS>");
  }
  out.println("</ECOMGPSS>");
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
%><%!
 public void closeConn(ResultSet rs, Statement stmt, Connection con) throws Exception
 {
  rs.close();
  con.close();
  stmt.close();
 }
%>