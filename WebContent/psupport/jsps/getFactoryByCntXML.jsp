<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 String sID = new String((request.getParameter("ID")).getBytes("8859_1"), "EUC-KR");
 

 Statement stmt=null;
 sql  = "SELECT ID, NVL(OCCU_AMT,0)OCCU_AMT, NVL(DISC_AMT,0)DISC_AMT, NVL(ORGA_PROD_OCCU_AMT,0)ORGA_PROD_OCCU_AMT, NVL(ORGA_PROD_DISC_AMT,0)ORGA_PROD_DISC_AMT, NVL(ID_CNT,0)ID_CNT FROM T_FACTORY_INDUST_CNT  WHERE 1=1"; 
 sql += "AND ID LIKE '%"+sID+"%'";
 //sql += "AND USE_YN='Y' ORDER BY NM";
 try
 {
  //out.println(sql);
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<CNTS>");
  while(rs.next())
  {
	   out.println("<CNT>");
	   out.println("<ID>" + rs.getString(1) + "</ID>");
	   out.println("<OCCU_AMT>" + rs.getInt(2) + "</OCCU_AMT>");
	   out.println("<DISC_AMT>" + rs.getInt(3) + "</DISC_AMT>");
	   out.println("<ORGA_PROD_OCCU_AMT>" + rs.getInt(4) + "</ORGA_PROD_OCCU_AMT>");
	   out.println("<ORGA_PROD_DISC_AMT>" + rs.getInt(5) + "</ORGA_PROD_DISC_AMT>");
	   out.println("<ID_CNT>" + rs.getInt(6) + "</ID_CNT>");
	   out.println("</CNT>");
  }
  
  out.println("</CNTS>");
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