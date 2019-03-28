<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
	String sFACT_NAME = new String((request.getParameter("FACT_NAME")).getBytes("8859_1"), "EUC-KR");
	String sFACT_FNAME = new String((request.getParameter("FACT_FNAME")).getBytes("8859_1"), "EUC-KR");
	String sFACT_CODE = new String((request.getParameter("FACT_CODE")).getBytes("8859_1"), "EUC-KR");
	String sRIVER_DIV = new String((request.getParameter("RIVER_DIV")).getBytes("8859_1"), "EUC-KR");
	String sFACT_MGR = new String((request.getParameter("FACT_MGR")).getBytes("8859_1"), "EUC-KR");
	String sFACT_MGR_TEL_NO = new String((request.getParameter("FACT_MGR_TEL_NO")).getBytes("8859_1"), "EUC-KR");
	String sFACT_DAY_TEL_NO = new String((request.getParameter("FACT_DAY_TEL_NO")).getBytes("8859_1"), "EUC-KR");
	String sFACT_NIGHT_TEL_NO = new String((request.getParameter("FACT_NIGHT_TEL_NO")).getBytes("8859_1"), "EUC-KR");
	String sFACT_FAX_NO = new String((request.getParameter("FACT_FAX_NO")).getBytes("8859_1"), "EUC-KR");
	String sFACT_ENV_MGR = new String((request.getParameter("FACT_ENV_MGR")).getBytes("8859_1"), "EUC-KR");
	String sFACT_ENV_MGR_TEL = new String((request.getParameter("FACT_ENV_MGR_TEL")).getBytes("8859_1"), "EUC-KR");
	String sFACT_ENV_MGR_EMAIL = new String((request.getParameter("FACT_ENV_MGR_EMAIL")).getBytes("8859_1"), "EUC-KR");
	String sORD_ORG_NAME = new String((request.getParameter("ORD_ORG_NAME")).getBytes("8859_1"), "EUC-KR");
	String sINST_COMP_NAME = new String((request.getParameter("INST_COMP_NAME")).getBytes("8859_1"), "EUC-KR");
	String sINST_COMP_MGR_NAME = new String((request.getParameter("INST_COMP_MGR_NAME")).getBytes("8859_1"), "EUC-KR");
	String sINST_COMP_MGR_TEL = new String((request.getParameter("INST_COMP_MGR_TEL")).getBytes("8859_1"), "EUC-KR");
	String sSYS_KIND = new String((request.getParameter("SYS_KIND")).getBytes("8859_1"), "EUC-KR");
	String sFACT_IP = new String((request.getParameter("FACT_IP")).getBytes("8859_1"), "EUC-KR");
	String sFACT_PORT = new String((request.getParameter("FACT_PORT")).getBytes("8859_1"), "EUC-KR");
	String sFACT_COMM_NO = new String((request.getParameter("FACT_COMM_NO")).getBytes("8859_1"), "EUC-KR");
	String sBRANCH_CNT = new String((request.getParameter("BRANCH_CNT")).getBytes("8859_1"), "EUC-KR");
	String sFACT_STA_LONGITUDE = new String((request.getParameter("FACT_STA_LONGITUDE")).getBytes("8859_1"), "EUC-KR");
	String sFACT_STA_LATITUDE = new String((request.getParameter("FACT_STA_LATITUDE")).getBytes("8859_1"), "EUC-KR");
	String sFACT_END_LONGITUDE = new String((request.getParameter("FACT_END_LONGITUDE")).getBytes("8859_1"), "EUC-KR");
	String sFACT_END_LATITUDE = new String((request.getParameter("FACT_END_LATITUDE")).getBytes("8859_1"), "EUC-KR");
	String sFACT_ADDR = new String((request.getParameter("FACT_ADDR")).getBytes("8859_1"), "EUC-KR");
	String sDO_CODE = new String((request.getParameter("DO_CODE")).getBytes("8859_1"), "EUC-KR");
	String sCTY_CODE = new String((request.getParameter("CTY_CODE")).getBytes("8859_1"), "EUC-KR");
	
	
	
 Statement stmt=null;

 sql  = "UPDATE T_FACT_INFO SET FACT_NAME='"+sFACT_NAME+"',FACT_FNAME='"+sFACT_FNAME+"',FACT_CODE='"+sFACT_CODE+"',RIVER_DIV='"+sRIVER_DIV+"',FACT_MGR='"+sFACT_MGR+"',FACT_MGR_TEL_NO='"+sFACT_MGR_TEL_NO+"',FACT_DAY_TEL_NO='"+sFACT_DAY_TEL_NO+"',FACT_NIGHT_TEL_NO='"+sFACT_NIGHT_TEL_NO+"',FACT_FAX_NO='"+sFACT_FAX_NO+"',FACT_ENV_MGR='"+sFACT_ENV_MGR+"',";
 sql += "FACT_ENV_MGR_TEL='"+sFACT_ENV_MGR_TEL+"',FACT_ENV_MGR_EMAIL='"+sFACT_ENV_MGR_EMAIL+"',ORD_ORG_NAME='"+sORD_ORG_NAME+"',INST_COMP_NAME='"+sINST_COMP_NAME+"',INST_COMP_MGR_NAME='"+sINST_COMP_MGR_NAME+"',INST_COMP_MGR_TEL='"+sINST_COMP_MGR_TEL+"',SYS_KIND='"+sSYS_KIND+"',FACT_IP='"+sFACT_IP+"',FACT_PORT='"+sFACT_PORT+"',FACT_COMM_NO='"+sFACT_COMM_NO+"',BRANCH_CNT='"+sBRANCH_CNT+"',FACT_STA_LONGITUDE='"+sFACT_STA_LONGITUDE+"',FACT_STA_LATITUDE='"+sFACT_STA_LATITUDE+"',FACT_END_LONGITUDE='"+sFACT_END_LONGITUDE+"',FACT_END_LATITUDE='"+sFACT_END_LATITUDE+"',";
 sql +="FACT_ADDR='"+sFACT_ADDR+"',DO_CODE='"+sDO_CODE+"',CTY_CODE='"+sCTY_CODE+"'";   
 sql += " WHERE FACT_CODE='" +sFACT_CODE +"'";

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