<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%>
<%@ include file="dbconn.jsp" %>
<%
response.setContentType("text/xml; charset=utf-8");

try
{
	//String sSYS_KIND = request.getParameter("SYS_KIND").equals("")?"":request.getParameter("SYS_KIND");
	String sSYS_KIND = request.getParameter("SYS_KIND");
	String sID = request.getParameter("ID");
	String sSEQ = request.getParameter("SEQ");
	String sBRANCH_NO = request.getParameter("BRANCH_NO");
	Statement stmt = null;
	
	sql = "SELECT S.SEQ, S.ID, S.STREAM_CODE, S.TYPE, F.FACT_NAME, F.FACT_FNAME, F.RIVER_DIV, F.SYS_KIND, B.BRANCH_NAME,B.BRANCH_NO,B.LONGITUDE,B.LATITUDE,V.TMP00_VL, V.TUR00_VL, V.PHY00_VL, V.DOW00_VL, V.CON00_VL, V.TOC00_VL,V.TMP01_VL,	V.PHY01_VL, V.DOW01_VL, V.CON01_VL,	F.FACT_FNAME||S.BRANCH_NO AS FACT_FULL_NAME FROM ";
	sql +="(SELECT SEQ, TYPE, BRANCH_NO, RIVER_DIV, STREAM_CODE, ID FROM T_LOC_SEQ) S,(SELECT FACT_CODE, FACT_FNAME, FACT_NAME, RIVER_DIV, SYS_KIND FROM T_FACT_INFO) F,(SELECT FACT_CODE, BRANCH_NO, LONGITUDE, LATITUDE,BRANCH_NAME FROM T_FACT_BRANCH_INFO)B,(SELECT TMP00_VL, TUR00_VL, PHY00_VL, DOW00_VL, CON00_VL, TOC00_VL,TMP01_VL,	PHY01_VL, DOW01_VL, CON01_VL,FACT_CODE,BRANCH_NO FROM V_T_MIN_DATA) V,(SELECT ID,SEQ,RIVER_DIV, STREAM_CODE FROM T_LOC_SEQ WHERE ID LIKE '%"+sID+"%' AND BRANCH_NO LIKE '%"+sBRANCH_NO+"%')A";
	
	if(sSEQ.equals("0"))
	{
		sql += " WHERE S.SEQ < A.SEQ AND S.TYPE LIKE '%"+sSYS_KIND+"%' AND S.STREAM_CODE ='M' AND S.RIVER_DIV = A.RIVER_DIV	AND S.ID = F.FACT_CODE AND S.ID = B.FACT_CODE AND S.BRANCH_NO = B.BRANCH_NO AND S.BRANCH_NO = V.BRANCH_NO(+) AND S.ID = V.FACT_CODE(+) ORDER BY S.SEQ DESC ";
	}
	else if(sSEQ.equals("1"))
	{
		sql += " WHERE S.SEQ > A.SEQ AND S.TYPE LIKE '%"+sSYS_KIND+"%' AND S.STREAM_CODE ='M' AND S.RIVER_DIV = A.RIVER_DIV	AND S.ID = F.FACT_CODE AND S.ID = B.FACT_CODE AND S.BRANCH_NO = B.BRANCH_NO AND S.BRANCH_NO = V.BRANCH_NO(+) AND S.ID = V.FACT_CODE(+) ORDER BY S.SEQ ASC";
	}
	
	try
	{
		//System.out.println("getSeqXML sql : " + sql);
		stmt=conn.createStatement();
		rs=stmt.executeQuery(sql);
		
		out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
		out.println("<SQCS>");
		
		while(rs.next())
		{ 
			out.println("<SQC>");
			out.println("<SEQ>" + rs.getInt(1) + "</SEQ>");
			out.println("<ID>" + rs.getString(2) + "</ID>");
			out.println("<STREAM_CODE>" + rs.getString(3) + "</STREAM_CODE>");
			out.println("<TYPE>" + rs.getString(4) + "</TYPE>");
			out.println("<FACT_NAME>" + rs.getString(5) + "</FACT_NAME>");
			out.println("<FACT_FNAME>" + rs.getString(6) + "</FACT_FNAME>");
			out.println("<RIVER_DIV>" + rs.getString(7) + "</RIVER_DIV>");
			out.println("<SYS_KIND>" + rs.getString(8) + "</SYS_KIND>");
			out.println("<BRANCH_NAME>" + rs.getString(9) + "</BRANCH_NAME>");
			out.println("<BRANCH_NO>" + rs.getString(10) + "</BRANCH_NO>");
			out.println("<LONGITUDE>" + rs.getDouble(11) + "</LONGITUDE>");
			out.println("<LATITUDE>" + rs.getDouble(12) + "</LATITUDE>");
			out.println("<TMP00_VL>" + rs.getDouble(13) + "</TMP00_VL>");
			out.println("<TUR00_VL>" + rs.getDouble(14) + "</TUR00_VL>");
			out.println("<PHY00_VL>" + rs.getDouble(15) + "</PHY00_VL>");
			out.println("<DOW00_VL>" + rs.getDouble(16) + "</DOW00_VL>");
			out.println("<CON00_VL>" + rs.getDouble(17) + "</CON00_VL>");
			out.println("<TOC00_VL>" + rs.getDouble(18) + "</TOC00_VL>");
			out.println("<TMP01_VL>" + rs.getDouble(19) + "</TMP01_VL>");
			out.println("<PHY01_VL>" + rs.getDouble(20) + "</PHY01_VL>");
			out.println("<DOW01_VL>" + rs.getDouble(21) + "</DOW01_VL>");
			out.println("<CON01_VL>" + rs.getDouble(22) + "</CON01_VL>");
			out.println("<FACT_FULL_NAME>" + rs.getString(23) + "</FACT_FULL_NAME>");
			out.println("</SQC>");
			
		}
		out.println("</SQCS>");
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
<%!
public void closeConn(ResultSet rs, Statement stmt, Connection con) throws Exception
{
	rs.close();
	con.close();
	stmt.close();
}
%>