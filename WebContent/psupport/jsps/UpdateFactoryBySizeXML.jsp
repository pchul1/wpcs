<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 String sID = request.getParameter("ID");
 String sCNT_1 = request.getParameter("CNT_1");
 String sDISC_AMT_1 = request.getParameter("DISC_AMT_1");
 String sLOAD_AMT_1 = request.getParameter("LOAD_AMT_1");
 String sCNT_2 = request.getParameter("CNT_2");
 String sDISC_AMT_2 = request.getParameter("DISC_AMT_2");
 String sLOAD_AMT_2 = request.getParameter("LOAD_AMT_2");
 String sCNT_3 = request.getParameter("CNT_3");
 String sDISC_AMT_3 = request.getParameter("DISC_AMT_3");
 String sLOAD_AMT_3 = request.getParameter("LOAD_AMT_3");
 String sCNT_4 = request.getParameter("CNT_4");
 String sDISC_AMT_4 = request.getParameter("DISC_AMT_4");
 String sLOAD_AMT_4 = request.getParameter("LOAD_AMT_4");
 String sCNT_5 = request.getParameter("CNT_5");
 String sDISC_AMT_5 = request.getParameter("DISC_AMT_5");
 String sLOAD_AMT_5 = request.getParameter("LOAD_AMT_5");
 
 Statement stmt=null;
 sql  = "UPDATE T_FACTORY_INDUST_SIZE SET CNT_1='"+sCNT_1+"', DISC_AMT_1='"+sDISC_AMT_1+"', LOAD_AMT_1='"+sLOAD_AMT_1+"',CNT_2='"+sCNT_2+"', DISC_AMT_2='"+sDISC_AMT_2+"', LOAD_AMT_2='"+sLOAD_AMT_2+"',CNT_3='"+sCNT_3+"', DISC_AMT_3='"+sDISC_AMT_3+"', LOAD_AMT_3='"+sLOAD_AMT_3+"',CNT_4='"+sCNT_4+"', DISC_AMT_4='"+sDISC_AMT_4+"', LOAD_AMT_4='"+sLOAD_AMT_4+"',CNT_5='"+sCNT_5+"', DISC_AMT_5='"+sDISC_AMT_5+"', LOAD_AMT_5='"+sLOAD_AMT_5+"'";   
 sql += " WHERE ID='" +sID +"'";
 try
 {
  //out.println(sql);
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
%>