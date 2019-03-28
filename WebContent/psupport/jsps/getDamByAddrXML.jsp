<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 
 String sDO_CODE = request.getParameter("DO_CODE");
 String sCTY_CODE = request.getParameter("CTY_CODE");
 String sNAME = new String((request.getParameter("NAME")).getBytes("8859_1"), "EUC-KR");
 Statement stmt=null;
 sql  = "SELECT NVL(ADDRESS,'정보없음')ADDRESS, NVL(CTY_CODE,'정보없음')CTY_CODE, NVL(DO_CODE,'정보없음')DO_CODE, NVL(ETC_MANAGE,'정보없음')ETC_MANAGE, NVL(ETC_PHONE,'정보없음')ETC_PHONE, ID, NVL(LATITUDE,0)LATITUDE, NVL(LONGITUDE,0)LONGITUDE, NVL(MANAGE,'정보없음')MANAGE, NVL(NAME,'정보없음')NAME, NVL(NGI_MANAGE,'정보없음')NGI_MANAGE, NVL(NGI_PHONE,'정보없음')NGI_PHONE, NVL(RIVER_DIV,'정보없음')RIVER_DIV, NVL(RIVER_NM,'정보없음')RIVER_NM, USE_YN, NVL(MANAGE_PHONE,'정보없음')MANAGE_PHONE,";
 sql += "NVL(TYPE,'정보없음')TYPE,NVL(KIND,'정보없음')KIND,NVL(L_BANK_ADDRESS,'정보없음')L_BANK_ADDRESS,NVL(R_BANK_ADDRESS,'정보없음')R_BANK_ADDRESS";
 sql += ",NVL(HEIGHT,0)HEIGHT, NVL(LENGTH,0)LENGTH, NVL(VOLUME,0)VOLUME, NVL(ALTITUDE,0)ALTITUDE, NVL(BASIN_AREA,0)BASIN_AREA, NVL(STORE_AREA,0)STORE_AREA, NVL(BASIN_ANNUAL_INFLOW,0)BASIN_ANNUAL_INFLOW, NVL(BASIN_ANNUAL_RAINFALL,0)BASIN_ANNUAL_RAINFALL, NVL(PLANED_FLOOD_LEVEL,0)PLANED_FLOOD_LEVEL";
 sql += ",NVL(NORMAL_FULL_LEVEL,0)NORMAL_FULL_LEVEL, NVL(NORMAL_FULL_LEVEL_VOLUME,0)NORMAL_FULL_LEVEL_VOLUME, NVL(FLOOD_LIMIT_LEVEL,0)FLOOD_LIMIT_LEVEL, NVL(FLOOD_CONTROL_VOLUME,0)FLOOD_CONTROL_VOLUME, NVL(STORE_WLEVEL_VOLUME,0)STORE_WLEVEL_VOLUME, NVL(SUPPLY_ENABLE_WLEVEL,0)SUPPLY_ENABLE_WLEVEL, NVL(TOTAL_STORE,0)TOTAL_STORE, NVL(VALID_STORE,0)VALID_STORE";
 sql += ",NVL(MINIMUM_STORE,0)MINIMUM_STORE, NVL(EMERGENCY_SUPPLY,0)EMERGENCY_SUPPLY, NVL(RESERVOIR_LENGTH,0)RESERVOIR_LENGTH, NVL(DESIGNED_FLOOD,0)DESIGNED_FLOOD, NVL(MINIMUM_WL,0)MINIMUM_WL, NVL(DISCHARGE_WL,0)DISCHARGE_WL FROM T_DAM WHERE 1=1";
 
 if(sDO_CODE == "" || sDO_CODE == null){}else{
	 sql += " AND DO_CODE LIKE '%" + sDO_CODE + "%'";
};

if(sCTY_CODE == "" || sCTY_CODE == null){}else{
	 sql += " AND CTY_CODE LIKE '%" + sCTY_CODE + "%'";
};
if(sNAME == "" || sNAME == null){}else{
	 sql += " AND NAME LIKE '%" + sNAME + "%'";
};
 sql += "AND USE_YN='Y' ORDER BY NAME ";
 try
 {
	// out.println(sql);
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<DAMS>");
  while(rs.next()) 
  {
	  out.println("<DAM>");
	   out.println("<ADDRESS>" + rs.getString(1) + "</ADDRESS>");
	   out.println("<CTY_CODE>" + rs.getString(2) + "</CTY_CODE>");
	   out.println("<DO_CODE>" + rs.getString(3) + "</DO_CODE>");
	   out.println("<ETC_MANAGE>" + rs.getString(4) + "</ETC_MANAGE>");
	   out.println("<ETC_PHONE>" + rs.getString(5) + "</ETC_PHONE>");
	   out.println("<ID>" + rs.getInt(6) + "</ID>");
	   out.println("<LATITUDE>" + rs.getDouble(7) + "</LATITUDE>");
	   out.println("<LONGITUDE>" + rs.getDouble(8) + "</LONGITUDE>");
	   out.println("<MANAGE>" + rs.getString(9) + "</MANAGE>");
	   out.println("<NAME>" + rs.getString(10) + "</NAME>");
	   out.println("<NGI_MANAGE>" + rs.getString(11) + "</NGI_MANAGE>");
	   out.println("<NGI_PHONE>" + rs.getString(12) + "</NGI_PHONE>");
	   out.println("<RIVER_DIV>" + rs.getString(13) + "</RIVER_DIV>");
	   out.println("<RIVER_NM>" + rs.getString(14) + "</RIVER_NM>");
	   out.println("<USE_YN>" + rs.getString(15) + "</USE_YN>");
	   out.println("<MANAGE_PHONE>" + rs.getString(16) + "</MANAGE_PHONE>");
	   out.println("<TYPE>" + rs.getString(17) + "</TYPE>");
	   out.println("<KIND>" + rs.getString(18) + "</KIND>");
	   out.println("<L_BANK_ADDRESS>" + rs.getString(19) + "</L_BANK_ADDRESS>");
	   out.println("<R_BANK_ADDRESS>" + rs.getString(20) + "</R_BANK_ADDRESS>");
	   out.println("<HEIGHT>" + rs.getDouble(21) + "</HEIGHT>");
	   out.println("<LENGTH>" + rs.getDouble(22) + "</LENGTH>");
	   out.println("<VOLUME>" + rs.getDouble(23) + "</VOLUME>");
	   out.println("<ALTITUDE>" + rs.getDouble(24) + "</ALTITUDE>");
	   out.println("<BASIN_AREA>" + rs.getDouble(25) + "</BASIN_AREA>");
	   out.println("<STORE_AREA>" + rs.getDouble(26) + "</STORE_AREA>");
	   out.println("<BASIN_ANNUAL_INFLOW>" + rs.getDouble(27) + "</BASIN_ANNUAL_INFLOW>");
	   out.println("<BASIN_ANNUAL_RAINFALL>" + rs.getDouble(28) + "</BASIN_ANNUAL_RAINFALL>");
	   out.println("<PLANED_FLOOD_LEVEL>" + rs.getDouble(29) + "</PLANED_FLOOD_LEVEL>");
	   out.println("<NORMAL_FULL_LEVEL>" + rs.getDouble(30) + "</NORMAL_FULL_LEVEL>");
	   out.println("<NORMAL_FULL_LEVEL_VOLUME>" + rs.getDouble(31) + "</NORMAL_FULL_LEVEL_VOLUME>");
	   out.println("<FLOOD_LIMIT_LEVEL>" + rs.getDouble(32) + "</FLOOD_LIMIT_LEVEL>");
	   out.println("<FLOOD_CONTROL_VOLUME>" + rs.getDouble(33) + "</FLOOD_CONTROL_VOLUME>");
	   out.println("<STORE_WLEVEL_VOLUME>" + rs.getDouble(34) + "</STORE_WLEVEL_VOLUME>");
	   out.println("<SUPPLY_ENABLE_WLEVEL>" + rs.getDouble(35) + "</SUPPLY_ENABLE_WLEVEL>");
	   out.println("<TOTAL_STORE>" + rs.getDouble(36) + "</TOTAL_STORE>");
	   out.println("<VALID_STORE>" + rs.getDouble(37) + "</VALID_STORE>");
	   out.println("<MINIMUM_STORE>" + rs.getDouble(38) + "</MINIMUM_STORE>");
	   out.println("<EMERGENCY_SUPPLY>" + rs.getDouble(39) + "</EMERGENCY_SUPPLY>");
	   out.println("<RESERVOIR_LENGTH>" + rs.getDouble(40) + "</RESERVOIR_LENGTH>");
	   out.println("<DESIGNED_FLOOD>" + rs.getDouble(41) + "</DESIGNED_FLOOD>");
	   out.println("<MINIMUM_WL>" + rs.getDouble(42) + "</MINIMUM_WL>");
	   out.println("<DISCHARGE_WL>" + rs.getDouble(43) + "</DISCHARGE_WL>");
	   out.println("</DAM>");
  }
  out.println("</DAMS>");
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