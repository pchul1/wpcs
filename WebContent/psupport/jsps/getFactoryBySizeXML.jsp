<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 String sID = new String((request.getParameter("ID")).getBytes("8859_1"), "EUC-KR");
 

 Statement stmt=null;
 sql  = "SELECT ID, NVL(CNT_1,0)CNT_1, NVL(DISC_AMT_1,0)DISC_AMT_1, NVL(LOAD_AMT_1,0)LOAD_AMT_1, NVL(CNT_2,0)CNT_2, NVL(DISC_AMT_2,0)DISC_AMT, NVL(LOAD_AMT_2,0)LOAD_AMT_2, NVL(CNT_3,0)CNT_3, NVL(DISC_AMT_3,0)DISC_AMT_3, NVL(LOAD_AMT_3,0)LOAD_AMT_3, NVL(CNT_4,0)CNT_4, NVL(DISC_AMT_4,0)DISC_AMT_4, NVL(LOAD_AMT_4,0)LOAD_AMT_4, NVL(CNT_5,0)CNT_5, NVL(DISC_AMT_5,0)DISC_AMT_5, NVL(LOAD_AMT_5,0)LOAD_AMT_5, (CNT_1+CNT_2+CNT_3+CNT_4+CNT_5) CNT_T, (DISC_AMT_1+DISC_AMT_2+DISC_AMT_3+DISC_AMT_4+DISC_AMT_5) DISC_AMT_T, (LOAD_AMT_1+LOAD_AMT_2+LOAD_AMT_3+LOAD_AMT_4+LOAD_AMT_5) LOAD_AMT_T FROM T_FACTORY_INDUST_SIZE  WHERE 1=1"; 
 sql += "AND ID LIKE '%"+sID+"%'";
 //sql += "AND USE_YN='Y' ORDER BY NM";
 try
 {
  //out.println(sql);
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<SIZES>");
  while(rs.next())
  {
	   out.println("<SIZE>");
	   out.println("<ID>" + rs.getString(1) + "</ID>");
	   out.println("<CNT_1>" + rs.getInt(2) + "</CNT_1>");
	   out.println("<DISC_AMT_1>" + rs.getInt(3) + "</DISC_AMT_1>");
	   out.println("<LOAD_AMT_1>" + rs.getInt(4) + "</LOAD_AMT_1>");
	   out.println("<CNT_2>" + rs.getInt(5) + "</CNT_2>");
	   out.println("<DISC_AMT_2>" + rs.getInt(6) + "</DISC_AMT_2>");
	   out.println("<LOAD_AMT_2>" + rs.getInt(7) + "</LOAD_AMT_2>");
	   out.println("<CNT_3>" + rs.getInt(8) + "</CNT_3>");
	   out.println("<DISC_AMT_3>" + rs.getInt(9) + "</DISC_AMT_3>");
	   out.println("<LOAD_AMT_3>" + rs.getInt(10) + "</LOAD_AMT_3>");
	   out.println("<CNT_4>" + rs.getInt(11) + "</CNT_4>");
	   out.println("<DISC_AMT_4>" + rs.getInt(12) + "</DISC_AMT_4>");
	   out.println("<LOAD_AMT_4>" + rs.getInt(13) + "</LOAD_AMT_4>");
	   out.println("<CNT_5>" + rs.getInt(14) + "</CNT_5>");
	   out.println("<DISC_AMT_5>" + rs.getInt(15) + "</DISC_AMT_5>");
	   out.println("<LOAD_AMT_5>" + rs.getInt(16) + "</LOAD_AMT_5>");
	   out.println("<CNT_T>" + rs.getInt(17) + "</CNT_T>");
	   out.println("<DISC_AMT_T>" + rs.getInt(18) + "</DISC_AMT_T>");
	   out.println("<LOAD_AMT_T>" + rs.getInt(19) + "</LOAD_AMT_T>");
	   out.println("</SIZE>");
  }
  
  out.println("</SIZES>");
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