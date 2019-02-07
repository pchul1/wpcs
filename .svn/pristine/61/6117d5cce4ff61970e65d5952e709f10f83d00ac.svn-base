<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%>
<%@ include file="dbconn.jsp" %>
<%
response.setContentType("text/xml; charset=utf-8");

try
{
// 	String sSYS_KIND = request.getParameter("SYS_KIND").equals("")?"":request.getParameter("SYS_KIND");
	String sID = request.getParameter("ID");
	String sBRANCH_NO = request.getParameter("BRANCH_NO");
// 	String sSEQ = request.getParameter("SEQ");
	Statement stmt=null;
// 	sql  = "SELECT A.ID, A.NAME, A.ADDRESS, A.DO_CODE, A.CTY_CODE, A.MANAGE, A.RIVER_NM, A.RIVER_DIV, A.LONGITUDE, A.LATITUDE, A.NGI_MANAGE, A.NGI_PHONE, A.ETC_MANAGE, A.ETC_PHONE, A.USE_YN, C.YMDH, C.SWL, C.INF, C.OTF, C.SFW, C.ECPC,  C.ITEM_CODE FROM T_DAM A,  (SELECT MAX(ID) ID FROM T_LOC_SEQ WHERE SEQ<"; 

// 	sql += "(SELECT SEQ FROM T_LOC_SEQ WHERE ID LIKE '%" +sID + "%')";
// 	sql += " AND TYPE='D') B, (SELECT TDM.DMOBSCD, TDM.YMDH,SWL, INF, OTF, SFW, ECPC, ITEM_CODE, ID FROM T_DMHR TDM, (  SELECT DMOBSCD ID, MAX(YMDH) YMDH FROM T_DMHR GROUP BY DMOBSCD) TDMAX  WHERE TDM.DMOBSCD=TDMAX.ID AND TDM.YMDH=TDMAX.YMDH) C WHERE A.ID=B.ID AND A.ID=C.ID(+)";
// 	sql += " ORDER BY NAME";
	sql="SELECT A.ID, A.NAME, A.ADDRESS, A.DO_CODE, A.CTY_CODE, A.MANAGE, A.RIVER_NM, A.RIVER_DIV, A.LONGITUDE, A.LATITUDE, A.NGI_MANAGE, A.NGI_PHONE, A.ETC_MANAGE, A.ETC_PHONE, A.USE_YN, C.YMDH, C.SWL, C.INF, C.OTF, C.SFW, C.ECPC,  C.ITEM_CODE FROM T_DAM A,  (SELECT AAA.ID,AAA.SEQ,AAA.RIVER_DIV FROM T_LOC_SEQ AAA, (SELECT SEQ,RIVER_DIV FROM T_LOC_SEQ  WHERE ID LIKE '%"+sID+"%' AND BRANCH_NO LIKE '%"+sBRANCH_NO+"%'  ) BBB WHERE AAA.SEQ<BBB.SEQ AND AAA.TYPE='D' AND AAA.RIVER_DIV=BBB.RIVER_DIV AND AAA.STREAM_CODE='M') B, (SELECT TDM.DMOBSCD, TDM.YMDH,SWL, INF, OTF, SFW, ECPC, ITEM_CODE, ID FROM T_DMHR TDM, (  SELECT DMOBSCD ID, MAX(YMDH) YMDH FROM T_DMHR GROUP BY DMOBSCD) TDMAX  WHERE TDM.DMOBSCD=TDMAX.ID AND TDM.YMDH=TDMAX.YMDH) C WHERE A.ID=B.ID AND A.ID=C.ID(+)";
	
	//System.out.println("getDamBySeq sql : " + sql);
	
	try
	{
		stmt=conn.createStatement();
		
		rs=stmt.executeQuery(sql);
		
		out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
		out.println("<DAMS>");
		
		while(rs.next())
		{ 
			out.println("<DAM>");
			out.println("<ID>" + rs.getInt(1) + "</ID>");
			out.println("<NAME>" + rs.getString(2) + "</NAME>");
			out.println("<ADDRESS>" + rs.getString(3) + "</ADDRESS>");
			out.println("<DO_CODE>" + rs.getString(4) + "</DO_CODE>");
			out.println("<CTY_CODE>" + rs.getString(5) + "</CTY_CODE>");
			out.println("<MANAGE>" + rs.getString(6) + "</MANAGE>");
			out.println("<RIVER_NM>" + rs.getString(7) + "</RIVER_NM>");
			out.println("<RIVER_DIV>" + rs.getString(8) + "</RIVER_DIV>");
			out.println("<LONGITUDE>" + rs.getDouble(9) + "</LONGITUDE>");
			out.println("<LATITUDE>" + rs.getDouble(10) + "</LATITUDE>");
			out.println("<NGI_MANAGE>" + rs.getString(11) + "</NGI_MANAGE>");
			out.println("<NGI_PHONE>" + rs.getString(12) + "</NGI_PHONE>");
			out.println("<ETC_MANAGE>" + rs.getString(13) + "</ETC_MANAGE>");
			out.println("<ETC_PHONE>" + rs.getString(14) + "</ETC_PHONE>");
			out.println("<USE_YN>" + rs.getString(15) + "</USE_YN>");
			out.println("<YMDH>" + rs.getString(16) + "</YMDH>");
			out.println("<SWL>" + rs.getDouble(17) + "</SWL>");
			out.println("<INF>" + rs.getDouble(18) + "</INF>");
			out.println("<OTF>" + rs.getDouble(19) + "</OTF>");
			out.println("<SFW>" + rs.getInt(20) + "</SFW>");
			out.println("<ECPC>" + rs.getInt(21) + "</ECPC>");
			out.println("<ITEM_CODE>" + rs.getString(22) + "</ITEM_CODE>");
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
%><%!
public void closeConn(ResultSet rs, Statement stmt, Connection con) throws Exception
{
	rs.close();
	con.close();
	stmt.close();
}
%>