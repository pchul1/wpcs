<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
	String sRIVER_ID = request.getParameter("RIVER_ID");
	String sNAME = new String((request.getParameter("NAME")).getBytes("8859_1"), "EUC-KR");
	String sDO_CODE = request.getParameter("DO_CODE");
	String sCTY_CODE = request.getParameter("CTY_CODE");
Statement stmt=null;
 sql  = "SELECT A.ID, A.NAME, A.DO_CODE, A.CTY_CODE, NVL(A.RIVER_ID, '정보없음')RIVER_ID, NVL(A.ADDRESS, '정보없음')ADDRESS, NVL(A.LONGITUDE,0)LONGITUDE, NVL(A.LATITUDE,0)LATITUDE, NVL(A.BASIN_LARGE,0)BASIN_LARGE, NVL(A.BASIN_MIDDLE,0)BASIN_MIDDLE, NVL(A.BASIN_SMALL,0)BASIN_SMALL, B.BASIN_LARGE_NM, B.BASIN_MIDDLE_NM FROM T_FACTORY_INDUST A, (SELECT BASIN_LARGE, BASIN_MIDDLE, BASIN_LARGE_NM, BASIN_MIDDLE_NM FROM T_BASIN GROUP BY BASIN_LARGE, BASIN_MIDDLE, BASIN_LARGE_NM, BASIN_MIDDLE_NM) B WHERE A.BASIN_LARGE=B.BASIN_LARGE AND A.BASIN_MIDDLE= B.BASIN_MIDDLE";

 if(sRIVER_ID == "" || sRIVER_ID == null){}else{
	  sql += " AND RIVER_ID LIKE '%"+sRIVER_ID+"%'";
 };
 if(sNAME == "" || sNAME == null){}else{
	 sql += " AND NAME LIKE '%" + sNAME + "%'";
 };
 
 if(sDO_CODE == "" || sDO_CODE == null){}else{
	 sql += " AND A.DO_CODE LIKE '%" + sDO_CODE + "%'";
 };
 
 if(sCTY_CODE == "" || sCTY_CODE == null){}else{
	 sql += " AND A.CTY_CODE LIKE '%" + sCTY_CODE + "%'";
 };
 sql += "AND USE_YN='Y' ORDER BY NAME";
 try
 {
  //out.println(sql);
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<FACTORYS>");
  while(rs.next())
  {
	   out.println("<FACTORY>");
	   out.println("<ID>" + rs.getString(1) + "</ID>");
	   out.println("<NAME>" + rs.getString(2) + "</NAME>");
	   out.println("<DO_CODE>" + rs.getString(3) + "</DO_CODE>");
	   out.println("<CTY_CODE>" + rs.getString(4) + "</CTY_CODE>");
	   out.println("<RIVER_ID>" + rs.getString(5) + "</RIVER_ID>");
	   out.println("<ADDRESS>" + rs.getString(6) + "</ADDRESS>");
	   out.println("<LONGITUDE>" + rs.getDouble(7) + "</LONGITUDE>");
	   out.println("<LATITUDE>" + rs.getDouble(8) + "</LATITUDE>");
	   out.println("<BASIN_LARGE>" + rs.getInt(9) + "</BASIN_LARGE>");
	   out.println("<BASIN_MIDDLE>" + rs.getInt(10) + "</BASIN_MIDDLE>");
	   out.println("<BASIN_SMALL>" + rs.getInt(11) + "</BASIN_SMALL>");
	   out.println("<BASIN_LARGE_NM>" + rs.getString(12) + "</BASIN_LARGE_NM>");
	   out.println("<BASIN_MIDDLE_NM>" + rs.getString(13) + "</BASIN_MIDDLE_NM>");
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
%>