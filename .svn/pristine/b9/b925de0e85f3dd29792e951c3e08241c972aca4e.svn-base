<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 //String sSYS_KIND = request.getParameter("SYS_KIND").equals("")?"":request.getParameter("SYS_KIND");
 String sDO_CODE = request.getParameter("DO_CODE");
 String sCTY_CODE = request.getParameter("CTY_CODE");
 Statement stmt=null;
 sql  = "SELECT  CTY_CODE, DO_CODE, DO_NAME, CTY_NAME, CTY_USE, AREA_GBN, FACT_CODE FROM T_AREA WHERE 1=1";
 if(sDO_CODE == "" || sDO_CODE == null){
	 //sql += " AND SYS_KIND in ('T','U','W','A')";// AND DO_CODE = '' AND CTY_CODE = '' ORDER BY DO_NAME, CTY_NAME"
 }else{
	 sql += " AND DO_CODE='"+sDO_CODE+"'";
 };
 if(sCTY_CODE == "" || sCTY_CODE == null){}else{
	 sql += " AND CTY_CODE='" + sCTY_CODE + "'";
 };
 sql += " ORDER BY DO_NAME, CTY_NAME";
 try
 {
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<AREA>");
  while(rs.next())
  {
	  out.println("<DO>");
	   out.println("<CTY_CODE>" + rs.getString(1) + "</CTY_CODE>");
	   out.println("<DO_CODE>" + rs.getString(2) + "</DO_CODE>");
	   out.println("<DO_NAME>" + rs.getString(3) + "</DO_NAME>");
	   out.println("<CTY_NAME>" + rs.getString(4) + "</CTY_NAME>");
	   out.println("<CTY_USE>" + rs.getString(5) + "</CTY_USE>");
	   out.println("<AREA_GBN>" + rs.getString(6) + "</AREA_GBN>");
	   out.println("<FACT_CODE>" + rs.getString(7) + "</FACT_CODE>");
	   out.println("</DO>");
  }
  out.println("</AREA>");
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