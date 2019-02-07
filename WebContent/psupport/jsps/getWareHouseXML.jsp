<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
	String sRIVER_DIV = new String((request.getParameter("RIVER_DIV")).getBytes("8859_1"), "EUC-KR");

 Statement stmt=null;
 sql  ="SELECT  A.RIVER_DIV,A.WH_CODE, A.WH_NAME, A.ADMIN_DEPT, A.ADMIN_NAME, A.ADMIN_TELNO, A.ADDR, A.LON, A.LAT, A.CTY_CODE, A.USE_FLAG,B.STOR_DATE, B.STOR_AMT, B.REG_ID, B.ITEM_CODE, B.ITEM_CODE_DET,C.ITEM_NAME,C.ITEM_UNIT, C.ITEM_STAN,C.TYPE1_APPL_FLAG, C.TYPE2_APPL_FLAG, C.TYPE3_APPL_FLAG, C.TYPE4_APPL_FLAG, C.TYPE5_APPL_FLAG, C.TYPE6_APPL_FLAG, C.TYPE7_APPL_FLAG, C.TYPE8_APPL_FLAG, C.TYPE9_APPL_FLAG, C.TYPE10_APPL_FLAG, C.TYPE11_APPL_FLAG, C.TYPE12_APPL_FLAG, C.USE_FLAG ";
 sql  +=" FROM T_WAREHOUSE A,T_ITEM_STOR  B, T_ITEM_CODE  C,(SELECT MAX(STOR_DATE)STOR_DATE, ITEM_CODE , ITEM_CODE_NUM FROM T_ITEM_STOR GROUP BY ITEM_CODE, ITEM_CODE_NUM)D WHERE B.STOR_DATE=D.STOR_DATE AND B.ITEM_CODE = D.ITEM_CODE AND B.ITEM_CODE_NUM = D.ITEM_CODE_NUM AND A.WH_CODE=B.WH_CODE AND B.ITEM_CODE=C.ITEM_CODE AND B.ITEM_CODE_NUM=C.ITEM_CODE_NUM AND B.ITEM_CODE_DET=C.ITEM_CODE_DET AND A.RIVER_DIV ";
 sql  +="LIKE '%"+sRIVER_DIV+"%'  ORDER BY A.WH_CODE, B.ITEM_CODE, B.ITEM_CODE_DET ";

 try
 {
 //out.println(sql);
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<WAREHOUSES>");
  while(rs.next())
  {
	   out.println("<WAREHOUSE>");
	   out.println("<RIVER_DIV>" + rs.getString(1) + "</RIVER_DIV>");
	   out.println("<WH_CODE>" + rs.getString(2) + "</WH_CODE>");
	   out.println("<WH_NAME>" + rs.getString(3) + "</WH_NAME>");
	   out.println("<ADMIN_DEPT>" + rs.getString(4) + "</ADMIN_DEPT>");
	   out.println("<ADMIN_NAME>" + rs.getString(5) + "</ADMIN_NAME>");
	   out.println("<ADMIN_TELNO>" + rs.getString(6) + "</ADMIN_TELNO>");
	   out.println("<ADDR>" + rs.getString(7) + "</ADDR>");
	   out.println("<LON>" + rs.getDouble(8) + "</LON>");
	   out.println("<LAT>" + rs.getDouble(9) + "</LAT>");
	   out.println("<CTY_CODE>" + rs.getString(10) + "</CTY_CODE>");
	   out.println("<USE_FLAG>" + rs.getString(11) + "</USE_FLAG>");
	   out.println("<STOR_DATE>" + rs.getString(12) + "</STOR_DATE>");
	   out.println("<STOR_AMT>" + rs.getInt(13) + "</STOR_AMT>");
	   out.println("<REG_ID>" + rs.getString(14) + "</REG_ID>");
	   out.println("<ITEM_CODE>" + rs.getString(15) + "</ITEM_CODE>");
	   out.println("<ITEM_CODE_DET>" + rs.getString(16) + "</ITEM_CODE_DET>");
	   out.println("<ITEM_NAME>" + rs.getString(17) + "</ITEM_NAME>");
	   out.println("<ITEM_UNIT>" + rs.getString(18) + "</ITEM_UNIT>");
	   out.println("<ITEM_STAN>" + rs.getString(19) + "</ITEM_STAN>");
	   out.println("<TYPE1_APPL_FLAG>" + rs.getString(20) + "</TYPE1_APPL_FLAG>");
	   out.println("<TYPE2_APPL_FLAG>" + rs.getString(21) + "</TYPE2_APPL_FLAG>");
	   out.println("<TYPE3_APPL_FLAG>" + rs.getString(22) + "</TYPE3_APPL_FLAG>");
	   out.println("<TYPE4_APPL_FLAG>" + rs.getString(23) + "</TYPE4_APPL_FLAG>");
	   out.println("<TYPE5_APPL_FLAG>" + rs.getString(24) + "</TYPE5_APPL_FLAG>");
	   out.println("<TYPE6_APPL_FLAG>" + rs.getString(25) + "</TYPE6_APPL_FLAG>");
	   out.println("<TYPE7_APPL_FLAG>" + rs.getString(26) + "</TYPE7_APPL_FLAG>");
	   out.println("<TYPE8_APPL_FLAG>" + rs.getString(27) + "</TYPE8_APPL_FLAG>");
	   out.println("<TYPE9_APPL_FLAG>" + rs.getString(28) + "</TYPE9_APPL_FLAG>");
	   out.println("<TYPE10_APPL_FLAG>" + rs.getString(29) + "</TYPE10_APPL_FLAG>");
	   out.println("<TYPE11_APPL_FLAG>" + rs.getString(30) + "</TYPE11_APPL_FLAG>");
	   out.println("<TYPE12_APPL_FLAG>" + rs.getString(31) + "</TYPE12_APPL_FLAG>");
	   out.println("<USE_FLAG>" + rs.getString(32) + "</USE_FLAG>");
	   
	   out.println("</WAREHOUSE>");
  }
  out.println("</WAREHOUSES>");
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
