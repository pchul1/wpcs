<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
	String sITEM_CODE = new String((request.getParameter("ITEM_CODE")).getBytes("8859_1"), "EUC-KR");
	String sBRANCH_NO = new String((request.getParameter("BRANCH_NO")).getBytes("8859_1"), "EUC-KR");
	String sFACT_CODE = new String((request.getParameter("FACT_CODE")).getBytes("8859_1"), "EUC-KR");
	
	Statement stmt=null;
	sql = "DELETE FROM T_FACT_ITEM WHERE ITEM_CODE='"+sITEM_CODE+"' AND BRANCH_NO='"+sBRANCH_NO+"' AND FACT_CODE='"+sFACT_CODE+"'";

 try
 {
 // out.println(sql);
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
%><%!
 public void closeConn(ResultSet rs, Statement stmt, Connection con) throws Exception
 {
  rs.close();
  con.close();
  stmt.close();
 }
%>