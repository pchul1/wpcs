<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 String sDO_CODE = request.getParameter("DO_CODE");
 String sCTY_CODE = request.getParameter("CTY_CODE");
 String sNM = new String((request.getParameter("NM")).getBytes("8859_1"), "EUC-KR");
 Statement stmt=null;
 sql  = "SELECT NVL(ADDRESS,'정보없음')ADDRESS, NVL(BASIN_LARGE,0)BASIN_LARGE, NVL(BASIN_MIDDLE,0)BASIN_MIDDLE, NVL(BASIN_SMALL,0)BASIN_SMALL, NVL(CTY_CODE,'정보없음')CTY_CODE, NVL(D_PHONE,'정보없음')D_PHONE, NVL(DO_CODE,'정보없음')DO_CODE, NVL(FAX,'정보없음')FAX, ID, NVL(LATITUDE,0)LATITUDE, NVL(LONGITUDE,0)LONGITUDE, NVL(N_PHONE,'정보없음')N_PHONE, NVL(NM,'정보없음')NM, NVL(OWNER,'정보없음')OWNER, NVL(RIVER_DIV,'정보없음')RIVER_DIV, NVL(RIVER_NM,'정보없음')RIVER_NM, USE_YN, NVL(TYPE,'정보없음')TYPE, NVL(E_PHONE,'정보없음')E_PHONE FROM T_ECOMPANY WHERE 1=1";
 

 if(sDO_CODE == "" || sDO_CODE == null){}else{
	 sql += " AND DO_CODE LIKE '%" + sDO_CODE + "%'";
 };
 if(sCTY_CODE == "" || sCTY_CODE == null){}else{
	 sql += " AND CTY_CODE LIKE'%" + sCTY_CODE + "%'";
 };
 if(sNM == "" || sNM == null){}else{
	 sql += " AND NM LIKE '%" + sNM + "%'";
 };
 sql += "AND USE_YN ='Y' ORDER BY NM";
 try
 {
  //out.println(sql);
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<ECOMS>");
  while(rs.next())
  {
	  out.println("<ECOM>");
	   out.println("<ADDRESS>" + rs.getString(1) + "</ADDRESS>");
	   out.println("<BASIN_LARGE>" + rs.getInt(2) + "</BASIN_LARGE>");
	   out.println("<BASIN_MIDDLE>" + rs.getInt(3) + "</BASIN_MIDDLE>");
	   out.println("<BASIN_SMALL>" + rs.getInt(4) + "</BASIN_SMALL>");
	   out.println("<CTY_CODE>" + rs.getString(5) + "</CTY_CODE>");
	   out.println("<D_PHONE>" + rs.getString(6) + "</D_PHONE>");
	   out.println("<DO_CODE>" + rs.getString(7) + "</DO_CODE>");
	   out.println("<FAX>" + rs.getString(8) + "</FAX>");
	   out.println("<ID>" + rs.getString(9) + "</ID>");
	   out.println("<LATITUDE>" + rs.getDouble(10) + "</LATITUDE>");
	   out.println("<LONGITUDE>" + rs.getDouble(11) + "</LONGITUDE>");
	   out.println("<N_PHONE>" + rs.getString(12) + "</N_PHONE>");
	   out.println("<NM>" + rs.getString(13) + "</NM>");
	   out.println("<OWNER>" + rs.getString(14) + "</OWNER>");
	   out.println("<RIVER_DIV>" + rs.getString(15) + "</RIVER_DIV>");
	   out.println("<RIVER_NM>" + rs.getString(16) + "</RIVER_NM>");
	   out.println("<USE_YN>" + rs.getString(17) + "</USE_YN>");
	   out.println("<TYPE>" + rs.getString(18) + "</TYPE>");
	   out.println("<E_PHONE>" + rs.getString(19) + "</E_PHONE>");
	   out.println("</ECOM>");
  }
  out.println("</ECOMS>");
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