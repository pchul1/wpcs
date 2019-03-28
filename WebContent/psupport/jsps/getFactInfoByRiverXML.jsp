<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 //String sSYS_KIND = request.getParameter("SYS_KIND").equals("")?"":request.getParameter("SYS_KIND");
 String sSYS_KIND = request.getParameter("SYS_KIND");
 String sRIVER_DIV = request.getParameter("RIVER_DIV");
 String sFACT_NAME = new String((request.getParameter("FACT_NAME")).getBytes("8859_1"), "EUC-KR");//request.getParameter("NM");
 Statement stmt=null;
 sql  = "SELECT FACT_CODE, FACT_NAME, NVL(FACT_FNAME,'정보없음')FACT_FNAME, NVL(BRANCH_CNT,0)BRANCH_CNT, NVL(FACT_MGR,'정보없음')FACT_MGR, NVL(FACT_ADDR,'정보없음')FACT_ADDR, NVL(FACT_MGR_TEL_NO,'정보없음')FACT_MGR_TEL_NO, NVL(FACT_DAY_TEL_NO,'정보없음')FACT_DAY_TEL_NO,";
 sql +=" NVL(FACT_NIGHT_TEL_NO,'정보없음')FACT_NIGHT_TEL_NO, NVL(FACT_FAX_NO,'정보없음')FACT_FAX_NO,NVL(FACT_ENV_MGR,'정보없음')FACT_ENV_MGR, NVL(FACT_ENV_MGR_TEL,'정보없음')FACT_ENV_MGR_TEL, NVL(FACT_ENV_MGR_EMAIL,'정보없음')FACT_ENV_MGR_EMAIL, NVL(ORD_ORG_NAME,'정보없음')ORD_ORG_NAME, NVL(FACT_MOR_FLAG,'정보없음')FACT_MOR_FLAG, NVL(INST_COMP_NAME,'정보없음')INST_COMP_NAME,";
 sql +=" NVL(INST_COMP_MGR_NAME,'정보없음')INST_COMP_MGR_NAME, NVL(INST_COMP_MGR_TEL,'정보없음')INST_COMP_MGR_TEL, NVL(FACT_EXT_FLAG,'정보없음')FACT_EXT_FLAG, NVL(RIVER_DIV,'정보없음')RIVER_DIV, NVL(SYS_KIND,'정보없음')SYS_KIND, NVL(FACT_IP,'정보없음')FACT_IP, NVL(FACT_PORT,'정보없음')FACT_PORT, NVL(FACT_COMM_NO,'정보없음')FACT_COMM_NO,NVL(FACT_STA_LONGITUDE,0)FACT_STA_LONGITUDE, NVL(FACT_STA_LATITUDE,0)FACT_STA_LATITUDE, NVL(FACT_END_LONGITUDE,0)FACT_END_LONGITUDE, NVL(FACT_END_LATITUDE,0)FACT_END_LATITUDE, DO_CODE, CTY_CODE, FACT_USE_FLAG FROM T_FACT_INFO WHERE 1=1";
 
 if(sSYS_KIND == "" || sSYS_KIND == null){
	// sql += " AND SYS_KIND in ('T','U','W','A')";
 }else{
	 sql += " AND SYS_KIND LIKE '%"+sSYS_KIND+"%'";
 };
 if(sRIVER_DIV == "" || sRIVER_DIV == null){}else{
	 sql += " AND RIVER_DIV LIKE '%" + sRIVER_DIV + "%'";
 };
 if(sFACT_NAME == "" || sFACT_NAME == null){}else{
	 sql += " AND FACT_NAME LIKE '%" + sFACT_NAME + "%'";
 };
 sql += " AND FACT_USE_FLAG = 'Y' ORDER BY FACT_NAME";
 try
 {
	// out.println(sql);
	 stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<FACTS>");
  while(rs.next())
  {
	  out.println("<FACT>");
	   out.println("<FACT_CODE>" + rs.getString(1) + "</FACT_CODE>");
	   out.println("<FACT_NAME>" + rs.getString(2) + "</FACT_NAME>");
	   out.println("<FACT_FNAME>" + rs.getString(3) + "</FACT_FNAME>");
	   out.println("<BRANCH_CNT>" + rs.getInt(4) + "</BRANCH_CNT>");
	   out.println("<FACT_MGR>" + rs.getString(5) + "</FACT_MGR>");
	   out.println("<FACT_ADDR>" + rs.getString(6) + "</FACT_ADDR>");
	   out.println("<FACT_MGR_TEL_NO>" + rs.getString(7) + "</FACT_MGR_TEL_NO>");
	   out.println("<FACT_DAY_TEL_NO>" + rs.getString(8) + "</FACT_DAY_TEL_NO>");
	   out.println("<FACT_NIGHT_TEL_NO>" + rs.getString(9) + "</FACT_NIGHT_TEL_NO>");
	   out.println("<FACT_FAX_NO>" + rs.getString(10) + "</FACT_FAX_NO>");
	   out.println("<FACT_ENV_MGR>" + rs.getString(11) + "</FACT_ENV_MGR>");
	   out.println("<FACT_ENV_MGR_TEL>" + rs.getString(12) + "</FACT_ENV_MGR_TEL>");
	   out.println("<FACT_ENV_MGR_EMAIL>" + rs.getString(13) + "</FACT_ENV_MGR_EMAIL>");
	   out.println("<ORD_ORG_NAME>" + rs.getString(14) + "</ORD_ORG_NAME>");
	   out.println("<FACT_MOR_FLAG>" + rs.getString(15) + "</FACT_MOR_FLAG>");
	   out.println("<INST_COMP_NAME>" + rs.getString(16) + "</INST_COMP_NAME>");
	   out.println("<INST_COMP_MGR_NAME>" + rs.getString(17) + "</INST_COMP_MGR_NAME>");
	   out.println("<INST_COMP_MGR_TEL>" + rs.getString(18) + "</INST_COMP_MGR_TEL>");
	   out.println("<FACT_EXT_FLAG>" + rs.getString(19) + "</FACT_EXT_FLAG>");
	   out.println("<RIVER_DIV>" + rs.getString(20) + "</RIVER_DIV>");
	   out.println("<SYS_KIND>" + rs.getString(21) + "</SYS_KIND>");
	   out.println("<FACT_IP>" + rs.getString(22) + "</FACT_IP>");
	   out.println("<FACT_PORT>" + rs.getString(23) + "</FACT_PORT>");
	   out.println("<FACT_COMM_NO>" + rs.getString(24) + "</FACT_COMM_NO>");
	   out.println("<FACT_STA_LONGITUDE>" + rs.getDouble(25) + "</FACT_STA_LONGITUDE>");
	   out.println("<FACT_STA_LATITUDE>" + rs.getDouble(26) + "</FACT_STA_LATITUDE>");
	   out.println("<FACT_END_LONGITUDE>" + rs.getDouble(27) + "</FACT_END_LONGITUDE>");
	   out.println("<FACT_END_LATITUDE>" + rs.getDouble(28) + "</FACT_END_LATITUDE>");
	   out.println("<DO_CODE>" + rs.getString(29) + "</DO_CODE>");
	   out.println("<CTY_CODE>" + rs.getString(30) + "</CTY_CODE>");
	   out.println("<FACT_USE_FLAG>" + rs.getString(31) + "</FACT_USE_FLAG>");
	    out.println("</FACT>");
  }
  out.println("</FACTS>");
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
%>