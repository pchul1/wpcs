<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 String sID = new String((request.getParameter("ID")).getBytes("8859_1"), "EUC-KR");
 

 Statement stmt=null;
 sql  = "SELECT ID, CU_CNT, CU_LOAD_AMT, PB_CNT, PB_LOAD_AMT, HG_CNT, HG_LOAD_AMT, CN_CNT, CN_LOAD_AMT, AS_CNT, AS_LOAD_AMT, YUGI_CNT, YUGI_LOAD_AMT, CR6_CNT, CR6_LOAD_AMT,";
 sql += "CD_CNT, CD_LOAD_AMT, PCE_CNT, PCE_LOAD_AMT, TCE_CNT, TCE_LOAD_AMT, C6H5OH_CNT, C6H5OH_LOAD_AMT, PCB_CNT, PCB_LOAD_AMT, SE_CNT, SE_LOAD_AMT, C6H6_CNT, C6H6_LOAD_AMT,";
 sql += "CCI4_CNT, CCI4_LOAD_AMT, CH2CL2_CNT, CH2CL2_LOAD_AMT, DCE_CNT, DCE_LOAD_AMT, EDC_CNT, EDC_LOAD_AMT, CHCI3_CNT, CHCI3_LOAD_AMT,";
 sql += "(CU_CNT+PB_CNT+HG_CNT+CN_CNT+ AS_CNT+YUGI_CNT+CR6_CNT+CD_CNT+PCE_CNT+TCE_CNT+C6H5OH_CNT+ PCB_CNT+ SE_CNT+ C6H6_CNT+ CCI4_CNT+ CH2CL2_CNT+ DCE_CNT+ EDC_CNT+ CHCI3_CNT) CNT_T,"; 
 sql += "(CU_LOAD_AMT+ PB_LOAD_AMT+ HG_LOAD_AMT+ CN_LOAD_AMT+ AS_LOAD_AMT+ YUGI_LOAD_AMT+ CR6_LOAD_AMT+ CD_LOAD_AMT+ PCE_LOAD_AMT+ TCE_LOAD_AMT+ C6H5OH_LOAD_AMT+ PCB_LOAD_AMT+SE_LOAD_AMT+C6H6_LOAD_AMT+ CCI4_LOAD_AMT+ CH2CL2_LOAD_AMT+ DCE_LOAD_AMT+ EDC_LOAD_AMT+ CHCI3_LOAD_AMT) LOAD_AMT_T FROM T_FACTORY_INDUST_SPEC WHERE 1=1";
 
  
 
 sql += "AND ID LIKE '%"+sID+"%'";
 //sql += "AND USE_YN='Y' ORDER BY NM";
 try
 {
//out.println(sql);
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<SPECS>");
  while(rs.next())
  {
	   out.println("<SPEC>");
	   out.println("<ID>" + rs.getString(1) + "</ID>");
	   out.println("<CU_CNT>" + rs.getInt(2) + "</CU_CNT>");	
	   out.println("<CU_LOAD_AMT>" + rs.getInt(3) + "</CU_LOAD_AMT>");
	   out.println("<PB_CNT>" + rs.getInt(4) + "</PB_CNT>");
	   out.println("<PB_LOAD_AMT>" + rs.getInt(5) + "</PB_LOAD_AMT>");
	   out.println("<HG_CNT>" + rs.getInt(6) + "</HG_CNT>");
	   out.println("<HG_LOAD_AMT>" + rs.getInt(7) + "</HG_LOAD_AMT>");
	   out.println("<CN_CNT>" + rs.getInt(8) + "</CN_CNT>");
	   out.println("<CN_LOAD_AMT>" + rs.getInt(9) + "</CN_LOAD_AMT>");
	   out.println("<AS_CNT>" + rs.getInt(10) + "</AS_CNT>");
	   out.println("<AS_LOAD_AMT>" + rs.getInt(11) + "</AS_LOAD_AMT>");
	   out.println("<YUGI_CNT>" + rs.getInt(12) + "</YUGI_CNT>");
	   out.println("<YUGI_LOAD_AMT>" + rs.getInt(13) + "</YUGI_LOAD_AMT>");
	   out.println("<CR6_CNT>" + rs.getInt(14) + "</CR6_CNT>");
	   out.println("<CR6_LOAD_AMT>" + rs.getInt(15) + "</CR6_LOAD_AMT>");
	   out.println("<CD_CNT>" + rs.getInt(16) + "</CD_CNT>");
	   out.println("<CD_LOAD_AMT>" + rs.getInt(17) + "</CD_LOAD_AMT>");
	   out.println("<PCE_CNT>" + rs.getInt(18) + "</PCE_CNT>");
	   out.println("<PCE_LOAD_AMT>" + rs.getInt(19) + "</PCE_LOAD_AMT>");
	   out.println("<TCE_CNT>" + rs.getInt(20) + "</TCE_CNT>");
	   out.println("<TCE_LOAD_AMT>" + rs.getInt(21) + "</TCE_LOAD_AMT>");
	   out.println("<C6H5OH_CNT>" + rs.getInt(22) + "</C6H5OH_CNT>");
	   out.println("<C6H5OH_LOAD_AMT>" + rs.getInt(23) + "</C6H5OH_LOAD_AMT>");
	   out.println("<PCB_CNT>" + rs.getInt(24) + "</PCB_CNT>");
	   out.println("<PCB_LOAD_AMT>" + rs.getInt(25) + "</PCB_LOAD_AMT>");
	   out.println("<SE_CNT>" + rs.getInt(26) + "</SE_CNT>");
	   out.println("<SE_LOAD_AMT>" + rs.getInt(27) + "</SE_LOAD_AMT>");
	   out.println("<C6H6_CNT>" + rs.getInt(28) + "</C6H6_CNT>");
	   out.println("<C6H6_LOAD_AMT>" + rs.getInt(29) + "</C6H6_LOAD_AMT>");
	   out.println("<CCI4_CNT>" + rs.getInt(30) + "</CCI4_CNT>");
	   out.println("<CCI4_LOAD_AMT>" + rs.getInt(31) + "</CCI4_LOAD_AMT>");
	   out.println("<CH2CL2_CNT>" + rs.getInt(32) + "</CH2CL2_CNT>");
	   out.println("<CH2CL2_LOAD_AMT>" + rs.getInt(33) + "</CH2CL2_LOAD_AMT>");
	   out.println("<DCE_CNT>" + rs.getInt(34) + "</DCE_CNT>");
	   out.println("<DCE_LOAD_AMT>" + rs.getInt(35) + "</DCE_LOAD_AMT>");
	   out.println("<EDC_CNT>" + rs.getInt(36) + "</EDC_CNT>");
	   out.println("<EDC_LOAD_AMT>" + rs.getInt(37) + "</EDC_LOAD_AMT>");
	   out.println("<CHCI3_CNT>" + rs.getInt(38) + "</CHCI3_CNT>");
	   out.println("<CHCI3_LOAD_AMT>" + rs.getInt(39) + "</CHCI3_LOAD_AMT>");
	   out.println("<CNT_T>" + rs.getInt(40) + "</CNT_T>");
	   out.println("<AMT_T>" + rs.getInt(41) + "</AMT_T>");
	   out.println("</SPEC>");
  }
  
  out.println("</SPECS>");
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