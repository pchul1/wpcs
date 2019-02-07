<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 //String sSYS_KIND = request.getParameter("SYS_KIND").equals("")?"":request.getParameter("SYS_KIND");
 String sNM = new String((request.getParameter("NM")).getBytes("8859_1"), "EUC-KR");//request.getParameter("NM");
 String sDO_CODE = request.getParameter("DO_CODE");
 String sCTY_CODE = request.getParameter("CTY_CODE");
 Statement stmt=null;
 sql  = "SELECT ID, NVL(NM,'정보없음')NM, NVL(LOC_ID,0)LOC_ID, NVL(UP_YMD,0)UP_YMD, NVL(SGG_CD,0)SGG_CD, NVL(DO_CODE,'정보없음')DO_CODE, NVL(CTY_CODE,'정보없음')CTY_CODE, NVL(PHONE,'정보없음')PHONE, NVL(RIVER_ID,'정보없음'), NVL(ADDRESS,'정보없음')ADDRESS, NVL(CHARGE,'정보없음')CHARGE, NVL(LONGITUDE,0)LONGITUDE, NVL(LATITUDE,0)LATITUDE, NVL(RUN_TYPE,'정보없음')RUN_TYPE, USE_YN, NVL(P_KIND,'정보없음')P_KIND, NVL(BASIN_LARGE,0)BASIN_LARGE, NVL(BASIN_MIDDLE,0)BASIN_MIDDLE, NVL(BASIN_SMALL,0)BASIN_SMALL  FROM T_FACTORY_CHEMIST WHERE 1=1"; 
 
 if(sNM == "" || sNM == null){}else{
	  sql += " AND NM LIKE '%"+sNM+"%'";
 };

 
 if(sDO_CODE == "" || sDO_CODE == null){}else{
	 sql += " AND DO_CODE LIKE '%" + sDO_CODE + "%'";
 };
 
 if(sCTY_CODE == "" || sCTY_CODE == null){}else{
	 sql += " AND CTY_CODE LIKE '%" + sCTY_CODE + "%'";
 };
 sql += "AND USE_YN='Y' ORDER BY NM";
 try
 {
	
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<FACTORYS>");
  while(rs.next())
  {
	  out.println("<FACTORY>");
	  out.println("<ID>" + rs.getInt(1) + "</ID>");
	   out.println("<NM>" + rs.getString(2) + "</NM>");
	   out.println("<LOC_ID>" + rs.getInt(3) + "</LOC_ID>");
	   out.println("<UP_YMD>" + rs.getInt(4) + "</UP_YMD>");
	   out.println("<SGG_CD>" + rs.getLong(5) + "</SGG_CD>");
	   out.println("<DO_CODE>" + rs.getString(6) + "</DO_CODE>");
	   out.println("<CTY_CODE>" + rs.getString(7) + "</CTY_CODE>");
	   out.println("<PHONE>" + rs.getString(8) + "</PHONE>");
	   out.println("<RIVER_ID>" + rs.getString(9) + "</RIVER_ID>");
	   out.println("<ADDRESS>" + rs.getString(10) + "</ADDRESS>");
	   out.println("<CHARGE>" + rs.getString(11) + "</CHARGE>");
	   out.println("<LONGITUDE>" + rs.getDouble(12) + "</LONGITUDE>");
	   out.println("<LATITUDE>" + rs.getDouble(13) + "</LATITUDE>");
	   out.println("<RUN_TYPE>" + rs.getString(14) + "</RUN_TYPE>");
	   out.println("<USE_YN>" + rs.getString(15) + "</USE_YN>");
	   out.println("<P_KIND>" + rs.getString(16) + "</P_KIND>");
	   out.println("<BASIN_LARGE>" + rs.getString(17) + "</BASIN_LARGE>");
	   out.println("<BASIN_MIDDLE>" + rs.getString(18) + "</BASIN_MIDDLE>");
	   out.println("<BASIN_SMALL>" + rs.getString(19) + "</BASIN_SMALL>");
	    out.println("</FACTORY>");
  }
  out.println("</FACTORYS>");
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