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
// 	sql  = "SELECT A.ID, A.NAME, A.ADDRESS, A.DO_CODE, A.CTY_CODE, A.LONGITUDE, A.LATITUDE, A.TYPE, A.MANAGE, A.MANAGER, A.PHONE, A.USE_YN, A.RIVER_DIV, A.PROC_QTY, A.RIVER_NM, A.CONT_TERM FROM T_WATERDC_CENTER A,  (SELECT MIN(ID) ID FROM T_LOC_SEQ WHERE SEQ>"; 
	
// 	sql += "(SELECT SEQ FROM T_LOC_SEQ WHERE ID LIKE '%" + sID + "')";
// 	sql += " AND TYPE='C') B WHERE A.ID=B.ID";]
	
	
	sql="SELECT A.ID, A.NAME, A.ADDRESS, A.DO_CODE, A.CTY_CODE, A.LONGITUDE, A.LATITUDE, A.TYPE, A.MANAGE, A.MANAGER, A.PHONE, A.USE_YN, A.RIVER_DIV, A.PROC_QTY, A.RIVER_NM, A.CONT_TERM FROM T_WATERDC_CENTER A,  (SELECT A.ID, A.RIVER_DIV,A.SEQ, B.SEQ,B.RIVER_DIV FROM T_LOC_SEQ A , (SELECT SEQ, RIVER_DIV FROM  T_LOC_SEQ  WHERE ID LIKE '%"+sID+"%' AND BRANCH_NO LIKE '%"+sBRANCH_NO+"%'  ) B WHERE B.RIVER_DIV=A.RIVER_DIV AND TYPE='C' AND STREAM_CODE='M') B WHERE A.ID=B.ID";
// 	sql += " ORDER BY NAME";

	try
	{
		//System.out.println("getWaterCenterBySeq sql : " + sql);
		stmt=conn.createStatement();
		rs = stmt.executeQuery(sql);
		
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
%><%!
public void closeConn(ResultSet rs, Statement stmt, Connection con) throws Exception
{
	rs.close();
	con.close();
	stmt.close();
}
%>