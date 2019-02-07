<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 String sID = request.getParameter("ID");
 String sID_CNT = request.getParameter("ID_CNT");
 String sOCCU_AMT = request.getParameter("OCCU_AMT");
 String sDISC_AMT = request.getParameter("DISC_AMT");
 String sORGA_PROD_OCCU_AMT = request.getParameter("ORGA_PROD_OCCU_AMT");
 String sORGA_PROD_DISC_AMT = request.getParameter("ORGA_PROD_DISC_AMT");
 
 
 Statement stmt=null;
 sql  = "UPDATE T_FACTORY_INDUST_CNT SET ID_CNT='"+sID_CNT+"', OCCU_AMT='"+sOCCU_AMT+"', DISC_AMT='"+sDISC_AMT+"',ORGA_PROD_OCCU_AMT='"+sORGA_PROD_OCCU_AMT+"', ORGA_PROD_DISC_AMT='"+sORGA_PROD_DISC_AMT+"'";  
 sql += " WHERE ID='" +sID +"'";
 try
 {
 // out.println(sql);
  stmt=conn.createStatement();
  int i =stmt.executeUpdate(sql);
  closeConn(rs,stmt,conn);
 }
 catch(SQLException ex)
 {
 // System.out.println(ex);
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