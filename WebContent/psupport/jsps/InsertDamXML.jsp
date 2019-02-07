<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
	String sID = request.getParameter("ID");
	 String sNAME = new String((request.getParameter("NAME")).getBytes("8859_1"), "EUC-KR");
	 String sMANAGE = new String((request.getParameter("MANAGE")).getBytes("8859_1"), "EUC-KR");
	 String sMANAGE_PHONE = new String((request.getParameter("MANAGE_PHONE")).getBytes("8859_1"), "EUC-KR");
	 String sETC_PHONE = new String((request.getParameter("ETC_PHONE")).getBytes("8859_1"), "EUC-KR");
	 String sETC_MANAGE = new String((request.getParameter("ETC_MANAGE")).getBytes("8859_1"), "EUC-KR");
	 String sRIVER_DIV = new String((request.getParameter("RIVER_DIV")).getBytes("8859_1"), "EUC-KR");
	 String sNGI_MANAGE = request.getParameter("NGI_MANAGE");
	 String sNGI_PHONE = request.getParameter("NGI_PHONE");
	 String sRIVER_NM = new String((request.getParameter("RIVER_NM")).getBytes("8859_1"), "EUC-KR");
	 String sLATITUDE = request.getParameter("LATITUDE");
	 String sLONGITUDE = request.getParameter("LONGITUDE");
	 String sADDRESS = new String((request.getParameter("ADDRESS")).getBytes("8859_1"), "EUC-KR");
	 String sDO_CODE = request.getParameter("DO_CODE");
	 String sCTY_CODE = request.getParameter("CTY_CODE");
	 String sTYPE = new String((request.getParameter("TYPE")).getBytes("8859_1"), "EUC-KR");
	 String sKIND = new String((request.getParameter("KIND")).getBytes("8859_1"), "EUC-KR");
	 String sL_BANK_ADDRESS = new String((request.getParameter("L_BANK_ADDRESS")).getBytes("8859_1"), "EUC-KR");
	 String sR_BANK_ADDRESS = new String((request.getParameter("R_BANK_ADDRESS")).getBytes("8859_1"), "EUC-KR");
	 String sHEIGHT = request.getParameter("HEIGHT");
	 String sLENGTH = request.getParameter("LENGTH");
	 String sVOLUME = request.getParameter("VOLUME");
	 String sALTITUDE = request.getParameter("ALTITUDE");
	 String sBASIN_AREA = request.getParameter("BASIN_AREA");
	 String sSTORE_AREA = request.getParameter("STORE_AREA");
	 String sBASIN_ANNUAL_INFLOW = request.getParameter("BASIN_ANNUAL_INFLOW");
	 String sBASIN_ANNUAL_RAINFALL = request.getParameter("BASIN_ANNUAL_RAINFALL");
	 String sPLANED_FLOOD_LEVEL = request.getParameter("PLANED_FLOOD_LEVEL");
	 String sNORMAL_FULL_LEVEL = request.getParameter("NORMAL_FULL_LEVEL");
	 String sNORMAL_FULL_LEVEL_VOLUME = request.getParameter("NORMAL_FULL_LEVEL_VOLUME");
	 String sFLOOD_LIMIT_LEVEL = request.getParameter("FLOOD_LIMIT_LEVEL");
	 String sFLOOD_CONTROL_VOLUME = request.getParameter("FLOOD_CONTROL_VOLUME");
	 String sSTORE_WLEVEL_VOLUME = request.getParameter("STORE_WLEVEL_VOLUME");
	 String sSUPPLY_ENABLE_WLEVEL = request.getParameter("SUPPLY_ENABLE_WLEVEL");
	 String sTOTAL_STORE = request.getParameter("TOTAL_STORE");
	 String sVALID_STORE = request.getParameter("VALID_STORE");
	 String sMINIMUM_STORE = request.getParameter("MINIMUM_STORE");
	 String sEMERGENCY_SUPPLY = request.getParameter("EMERGENCY_SUPPLY");
	 String sRESERVOIR_LENGTH = request.getParameter("RESERVOIR_LENGTH");
	 String sDESIGNED_FLOOD = request.getParameter("DESIGNED_FLOOD");
	 String sMINIMUM_WL = request.getParameter("MINIMUM_WL");
	 String sDISCHARGE_WL = request.getParameter("DISCHARGE_WL");
 Statement stmt=null;
 sql  = "INSERT INTO T_DAM (ID,NAME,MANAGE,MANAGE_PHONE,ETC_PHONE,ETC_MANAGE,RIVER_DIV,NGI_MANAGE,NGI_PHONE,RIVER_NM, LATITUDE, LONGITUDE, ADDRESS, DO_CODE, CTY_CODE,TYPE, KIND, L_BANK_ADDRESS, R_BANK_ADDRESS,HEIGHT,LENGTH,VOLUME,ALTITUDE,BASIN_AREA,STORE_AREA,BASIN_ANNUAL_INFLOW,BASIN_ANNUAL_RAINFALL,PLANED_FLOOD_LEVEL,NORMAL_FULL_LEVEL,NORMAL_FULL_LEVEL_VOLUME,FLOOD_LIMIT_LEVEL,FLOOD_CONTROL_VOLUME,STORE_WLEVEL_VOLUME,SUPPLY_ENABLE_WLEVEL,TOTAL_STORE,VALID_STORE,MINIMUM_STORE,EMERGENCY_SUPPLY,RESERVOIR_LENGTH,DESIGNED_FLOOD,MINIMUM_WL,DISCHARGE_WL,USE_YN)";   

 sql += "VALUES('"+sID+"','" +sNAME+ "','"+sMANAGE+"','"+sMANAGE_PHONE+"','"+ sETC_PHONE+"','" +sETC_MANAGE+"','" +sRIVER_DIV+"','" +sNGI_MANAGE+"','" +sNGI_PHONE+"','"+sRIVER_NM+"','"+sLATITUDE+"','"+sLONGITUDE+"','"+sADDRESS+"','"+sDO_CODE+"','"+sCTY_CODE+"',";
 sql += "'"+sTYPE+"','"+sKIND+"','"+sL_BANK_ADDRESS+"','"+sR_BANK_ADDRESS+"','"+sHEIGHT+"','"+sLENGTH+"','"+sVOLUME+"','"+sALTITUDE+"','"+sBASIN_AREA+"',";
 sql += "'"+sSTORE_AREA+"','"+sBASIN_ANNUAL_INFLOW+"','"+sBASIN_ANNUAL_RAINFALL+"','"+sPLANED_FLOOD_LEVEL+"','"+sNORMAL_FULL_LEVEL+"','"+sNORMAL_FULL_LEVEL_VOLUME+"','"+sFLOOD_LIMIT_LEVEL+"',";
 sql += "'"+sFLOOD_CONTROL_VOLUME+"','"+sSTORE_WLEVEL_VOLUME+"','"+sSUPPLY_ENABLE_WLEVEL+"','"+sTOTAL_STORE+"','"+sVALID_STORE+"','"+sMINIMUM_STORE+"','"+sEMERGENCY_SUPPLY+"','"+sRESERVOIR_LENGTH+"','"+sDESIGNED_FLOOD+"',";
 sql += " '"+sMINIMUM_WL+"','"+sDISCHARGE_WL+"','Y')";
 
 
 try
 {
  out.println(sql);
  stmt=conn.createStatement();
  int i =stmt.executeUpdate(sql);
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