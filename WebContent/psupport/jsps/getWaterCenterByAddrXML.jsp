<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 String sDO_CODE = request.getParameter("DO_CODE");
 String sCTY_CODE = request.getParameter("CTY_CODE");
 String sTYPE = request.getParameter("TYPE");
 String sNAME = new String((request.getParameter("NAME")).getBytes("8859_1"), "EUC-KR");
 Statement stmt=null;
 sql  = "SELECT ID, NVL(NAME,'정보없음')NAME, NVL(ADDRESS,'정보없음')ADDRESS, NVL(DO_CODE,'정보없음')DO_CODE, NVL(CTY_CODE,'정보없음')CTY_CODE, NVL(LONGITUDE,0)LONGITUDE, NVL(LATITUDE,0)LATITUDE, NVL(TYPE,'정보없음')TYPE, NVL(MANAGE,'정보없음')MANAGE, NVL(MANAGER,'정보없음')MANAGER, NVL(PHONE,'정보없음')PHONE, USE_YN, NVL(RIVER_DIV,'정보없음')RIVER_DIV, NVL(PROC_QTY,0)PROC_QTY, NVL(RIVER_NM,'정보없음')RIVER_NM, NVL(CONT_TERM,'정보없음')CONT_TERM, NVL(SUPPLY_REGION, '정보없음')SUPPLY_REGION, NVL(RUN_DAY, 0)RUN_DAY FROM T_WATERDC_CENTER WHERE 1=1"; 
 
 if(sDO_CODE == "" || sDO_CODE == null){}else
 {
	 sql += " AND DO_CODE LIKE '%" + sDO_CODE + "%'";
 }

 if(sCTY_CODE == "" || sCTY_CODE == null){}else
 {
	 sql += " AND CTY_CODE LIKE '%" + sCTY_CODE + "%'";
 }
 if(sTYPE == "" || sTYPE == null){}else
 {
	 sql += " AND TYPE LIKE '%" + sTYPE + "%'";
 }
 if(sNAME == "" || sNAME == null){}else
 {
	 sql += " AND NAME LIKE '%" + sNAME + "%'";
 }
 sql += " AND USE_YN = 'Y' ORDER BY NAME";
 try
 {
  //out.println(sql);
 stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<WCS>");
  while(rs.next())
  {
	  out.println("<WC>");
	   out.println("<ID>" + rs.getString(1) + "</ID>");
	   out.println("<NAME>" + rs.getString(2) + "</NAME>");
	   out.println("<ADDRESS>" + rs.getString(3) + "</ADDRESS>");
	   out.println("<DO_CODE>" + rs.getString(4) + "</DO_CODE>");
	   out.println("<CTY_CODE>" + rs.getString(5) + "</CTY_CODE>");
	   out.println("<LONGITUDE>" + rs.getDouble(6) + "</LONGITUDE>");
	   out.println("<LATITUDE>" + rs.getDouble(7) + "</LATITUDE>");
	   out.println("<TYPE>" + rs.getString(8) + "</TYPE>");
	   out.println("<MANAGE>" + rs.getString(9) + "</MANAGE>");
	   out.println("<MANAGER>" + rs.getString(10) + "</MANAGER>");
	   out.println("<PHONE>" + rs.getString(11) + "</PHONE>");
	   out.println("<USE_YN>" + rs.getString(12) + "</USE_YN>");
	   out.println("<RIVER_DIV>" + rs.getString(13) + "</RIVER_DIV>");
	   out.println("<PROC_QTY>" + rs.getInt(14) + "</PROC_QTY>");
	   out.println("<RIVER_NM>" + rs.getString(15) + "</RIVER_NM>");
	   out.println("<CONT_TERM>" + rs.getString(16) + "</CONT_TERM>");
	   out.println("<SUPPLY_REGION>" + rs.getString(17) + "</SUPPLY_REGION>");
	   out.println("<RUN_DAY>" + rs.getInt(18) + "</RUN_DAY>");
	   out.println("</WC>");
  }
  out.println("</WCS>");
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