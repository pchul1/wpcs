<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
	 String sBRANCH_NAME = new String((request.getParameter("BRANCH_NAME")).getBytes("8859_1"), "EUC-KR");
	 String sBRANCH_FNAME = new String((request.getParameter("BRANCH_FNAME")).getBytes("8859_1"), "EUC-KR");
	 String sFACT_CODE = new String((request.getParameter("FACT_CODE")).getBytes("8859_1"), "EUC-KR");
	 String sBRANCH_NO = new String((request.getParameter("BRANCH_NO")).getBytes("8859_1"), "EUC-KR");
	 String sBRANCH_MGR_TEL_NO = new String((request.getParameter("BRANCH_MGR_TEL_NO")).getBytes("8859_1"), "EUC-KR");
	 String sBRANCH_IP = new String((request.getParameter("BRANCH_IP")).getBytes("8859_1"), "EUC-KR");
	 String sBRANCH_PORT = new String((request.getParameter("BRANCH_PORT")).getBytes("8859_1"), "EUC-KR");
	 String sLATITUDE = new String((request.getParameter("LATITUDE")).getBytes("8859_1"), "EUC-KR");
	 String sLONGITUDE = new String((request.getParameter("LONGITUDE")).getBytes("8859_1"), "EUC-KR");
	 String sCDMA_GROUP = new String((request.getParameter("CDMA_GROUP")).getBytes("8859_1"), "EUC-KR");
	 String sCDMA_TEL_NO = new String((request.getParameter("CDMA_TEL_NO")).getBytes("8859_1"), "EUC-KR");
	 String sGPS_DIST = new String((request.getParameter("GPS_DIST")).getBytes("8859_1"), "EUC-KR");
	 
 Statement stmt=null;
 sql  = "INSERT INTO T_FACT_BRANCH_INFO(BRANCH_NAME, BRANCH_FNAME, FACT_CODE, BRANCH_NO, BRANCH_MGR_TEL_NO, BRANCH_IP,BRANCH_PORT,LATITUDE,LONGITUDE,CDMA_GROUP,CDMA_TEL_NO,GPS_DIST, BRANCH_USE_FLAG)";
 sql += "VALUES('"+sBRANCH_NAME+"','" +sBRANCH_FNAME+ "','"+sFACT_CODE+"','"+sBRANCH_NO+"','" +sBRANCH_MGR_TEL_NO+ "','"+sBRANCH_IP+"','"+sBRANCH_PORT+"','" +sLATITUDE+ "','"+sLONGITUDE+"','"+sCDMA_GROUP+"','" +sCDMA_TEL_NO+ "','"+sGPS_DIST+"','Y')";
                                                                    
 
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
%><%!
 public void closeConn(ResultSet rs, Statement stmt, Connection con) throws Exception
 {
  rs.close();
  con.close();
  stmt.close();
 }
%>