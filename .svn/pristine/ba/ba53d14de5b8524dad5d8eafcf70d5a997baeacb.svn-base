<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{

 String sECOMPANY_ID= new String((request.getParameter("ECOMPANY_ID")).getBytes("8859_1"), "EUC-KR");
 
 Statement stmt=null;
 sql  = "SELECT A.ECOMPANY_ID, A.ITEM_CODE, A.ITEM_CODE_DET , B.ITEM_NAME, NVL(B.ITEM_UNIT, 'EA')ITEM_UNIT FROM T_ECOMPANY_OWN_ITEM A, T_ITEM_CODE B  WHERE A.ITEM_CODE = B.ITEM_CODE AND A.ITEM_CODE_DET = B.ITEM_CODE_DET AND A.ITEM_CODE_NUM = B.ITEM_CODE_NUM  ";
 sql += " AND ECOMPANY_ID LIKE '%" +sECOMPANY_ID+ "%'";
 sql += "ORDER BY ITEM_NAME";
 try
 {
	// out.println(sql);
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<ITEMS>");
  while(rs.next())
  {
	   out.println("<ITEM>");
	   out.println("<ID>" + rs.getString(1) + "</ID>");
	   out.println("<ITEM_CODE>" + rs.getString(2) + "</ITEM_CODE>");
	   out.println("<ITEM_CODE_DET>" + rs.getString(3) + "</ITEM_CODE_DET>");
	   out.println("<ITEM_NAME>" + rs.getString(4) + "</ITEM_NAME>");
	   out.println("<ITEM_UNIT>" + rs.getString(5) + "</ITEM_UNIT>");
	   out.println("</ITEM>");
  }
  out.println("</ITEMS>");
  closeConn(rs,stmt,conn);
 }
 catch(SQLException ex)
 {
 // System.out.println(ex);
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