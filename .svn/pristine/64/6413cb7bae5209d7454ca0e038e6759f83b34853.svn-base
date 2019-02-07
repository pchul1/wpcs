<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
	String sFACT_CODE = new String((request.getParameter("FACT_CODE")).getBytes("8859_1"), "EUC-KR");//request.getParameter("NM");
	
	Statement stmt=null;
// 	sql = "SELECT ID, NVL(NAME,'정보없음')NM, ''LOC_ID, '' UP_YMD,'' SGG_CD, NVL(DO_CODE,'정보없음')DO_CODE, NVL(CTY_CODE,'정보없음')CTY_CODE, '' PHONE, NVL(RIVER_ID,'정보없음'), NVL(ADDRESS,'정보없음')ADDRESS, '' CHARGE, NVL(LONGITUDE,0)LONGITUDE, NVL(LATITUDE,0)LATITUDE, '' RUN_TYPE, USE_YN, '' P_KIND, NVL(BASIN_LARGE,0)BASIN_LARGE, NVL(BASIN_MIDDLE,0)BASIN_MIDDLE, NVL(BASIN_SMALL,0)BASIN_SMALL  FROM T_FACTORY_INDUST WHERE 1=1";
	sql = "SELECT  ID, NVL(NAME,'정보없음')NM, ''LOC_ID, '' UP_YMD,'' SGG_CD, NVL(DO_CODE,'정보없음')DO_CODE, NVL(CTY_CODE,'정보없음')CTY_CODE, '' PHONE, DECODE(RIVER_ID,'R01', '한강','R02', '낙동강', 'R03', '금강', 'R04', '영산강',  '', '정보없음' ), NVL(ADDRESS,'정보없음')ADDRESS, '' CHARGE, NVL(LONGITUDE,0)LONGITUDE, NVL(LATITUDE,0)LATITUDE, '' RUN_TYPE, USE_YN, '' P_KIND, NVL(BASIN_LARGE,0)BASIN_LARGE, NVL(BASIN_MIDDLE,0)BASIN_MIDDLE, NVL(BASIN_SMALL,0)BASIN_SMALL FROM T_FACTORY_INDUST WHERE BASIN_MIDDLE IN (SELECT BASIN_MIDDLE FROM T_BASIN WHERE CTY_CODE IN (SELECT CTY_CODE FROM T_FACT_INFO WHERE FACT_CODE LIKE '%"+sFACT_CODE+"%'))";
// 	sql += " AND BASIN_MIDDLE='"+sBASIN_MIDDLE+"'";
	sql += "AND USE_YN='Y' ORDER BY NM";
	try
	{
		//System.out.println("getFactoryByAccidentXML sql : " + sql);
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