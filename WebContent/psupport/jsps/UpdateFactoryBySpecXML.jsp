<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 String sID = request.getParameter("ID");
 String sCU_CNT = request.getParameter("CU_CNT");
 String sCU_LOAD_AMT = request.getParameter("CU_LOAD_AMT");
 String sPB_CNT = request.getParameter("PB_CNT");
 String sPB_LOAD_AMT = request.getParameter("PB_LOAD_AMT");
 String sHG_CNT = request.getParameter("HG_CNT");
 String sHG_LOAD_AMT = request.getParameter("HG_LOAD_AMT");
 String sCN_CNT = request.getParameter("CN_CNT");
 String sCN_LOAD_AMT = request.getParameter("CN_LOAD_AMT");
 String sAS_CNT = request.getParameter("AS_CNT");
 String sAS_LOAD_AMT = request.getParameter("AS_LOAD_AMT");
 String sYUGI_CNT = request.getParameter("YUGI_CNT");
 String sYUGI_LOAD_AMT = request.getParameter("YUGI_LOAD_AMT");
 String sCR6_CNT = request.getParameter("CR6_CNT");
 String sCR6_LOAD_AMT = request.getParameter("CR6_LOAD_AMT");
 String sCD_CNT = request.getParameter("CD_CNT");
 String sCD_LOAD_AMT = request.getParameter("CD_LOAD_AMT");
 String sPCE_CNT = request.getParameter("PCE_CNT");
 String sPCE_LOAD_AMT = request.getParameter("PCE_LOAD_AMT");
 String sTCE_CNT = request.getParameter("TCE_CNT");
 String sTCE_LOAD_AMT = request.getParameter("TCE_LOAD_AMT");
 String sC6H5OH_CNT = request.getParameter("C6H5OH_CNT");
 String sC6H5OH_LOAD_AMT = request.getParameter("C6H5OH_LOAD_AMT");
 String sPCB_CNT = request.getParameter("PCB_CNT");
 String sPCB_LOAD_AMT = request.getParameter("PCB_LOAD_AMT");
 String sSE_CNT = request.getParameter("SE_CNT");
 String sSE_LOAD_AMT = request.getParameter("SE_LOAD_AMT");
 String sC6H6_CNT = request.getParameter("C6H6_CNT");
 String sC6H6_LOAD_AMT = request.getParameter("C6H6_LOAD_AMT");
 String sCCI4_CNT = request.getParameter("CCI4_CNT");
 String sCCI4_LOAD_AMT = request.getParameter("CCI4_LOAD_AMT");
 String sCH2CL2_CNT = request.getParameter("CH2CL2_CNT");
 String sCH2CL2_LOAD_AMT = request.getParameter("CH2CL2_LOAD_AMT");
 String sDCE_CNT = request.getParameter("DCE_CNT");
 String sDCE_LOAD_AMT = request.getParameter("DCE_LOAD_AMT");
 String sEDC_CNT = request.getParameter("EDC_CNT");
 String sEDC_LOAD_AMT = request.getParameter("EDC_LOAD_AMT");
 String sCHCI3_CNT = request.getParameter("CHCI3_CNT");
 String sCHCI3_LOAD_AMT = request.getParameter("CHCI3_LOAD_AMT");
 
  
 Statement stmt=null;
 sql  = "UPDATE T_FACTORY_INDUST_SPEC SET CU_CNT='"+sCU_CNT+"', CU_LOAD_AMT='"+sCU_LOAD_AMT+"', PB_CNT='"+sPB_CNT+"',PB_LOAD_AMT='"+sPB_LOAD_AMT+"', HG_CNT='"+sHG_CNT+"',";
 sql += "HG_LOAD_AMT='"+sHG_LOAD_AMT+"', CN_CNT='"+sCN_CNT+"', CN_LOAD_AMT='"+sCN_LOAD_AMT+"',AS_CNT='"+sAS_CNT+"', AS_LOAD_AMT='"+sAS_LOAD_AMT+"',";
 sql += "YUGI_CNT='"+sYUGI_CNT+"', YUGI_LOAD_AMT='"+sYUGI_LOAD_AMT+"', CR6_CNT='"+sCR6_CNT+"',CR6_LOAD_AMT='"+sCR6_LOAD_AMT+"', CD_CNT='"+sCD_CNT+"',";
 sql += "CD_LOAD_AMT='"+sCD_LOAD_AMT+"', PCE_CNT='"+sPCE_CNT+"', PCE_LOAD_AMT='"+sPCE_LOAD_AMT+"',TCE_CNT='"+sTCE_CNT+"', TCE_LOAD_AMT='"+sTCE_LOAD_AMT+"',";
 sql += "C6H5OH_CNT='"+sC6H5OH_CNT+"', C6H5OH_LOAD_AMT='"+sC6H5OH_LOAD_AMT+"', PCB_CNT='"+sPCB_CNT+"',PCB_LOAD_AMT='"+sPCB_LOAD_AMT+"', SE_CNT='"+sSE_CNT+"',";
 sql += "SE_LOAD_AMT='"+sSE_LOAD_AMT+"', C6H6_CNT='"+sC6H6_CNT+"', C6H6_LOAD_AMT='"+sC6H6_LOAD_AMT+"',CCI4_CNT='"+sCCI4_CNT+"', CCI4_LOAD_AMT='"+sCCI4_LOAD_AMT+"',";
 sql += "CH2CL2_CNT='"+sCH2CL2_CNT+"', CH2CL2_LOAD_AMT='"+sCH2CL2_LOAD_AMT+"', DCE_CNT='"+sDCE_CNT+"',DCE_LOAD_AMT='"+sDCE_LOAD_AMT+"', EDC_CNT='"+sEDC_CNT+"', EDC_LOAD_AMT='"+sEDC_LOAD_AMT+"', CHCI3_CNT='"+sCHCI3_CNT+"', CHCI3_LOAD_AMT='"+sCHCI3_LOAD_AMT+"'";  
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
%><%!
 public void closeConn(ResultSet rs, Statement stmt, Connection con) throws Exception
 {
  rs.close();
  con.close();
  stmt.close();
 }
%>