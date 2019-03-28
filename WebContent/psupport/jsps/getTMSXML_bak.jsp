<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.* , net.sf.json.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/html; charset=utf-8");
try
{
	Statement stmt=null;
	sql = "SELECT FACTCODE AS FACT_CODE, FACTNAME, BRANCHNO AS BRANCH_NO, BRANCH_NAME, MINTIME, STRDATE, STRTIME, MINRTIME, MINDUMP, ";
	sql += "TO_CHAR(SUM(PHY), 'FM999,990.00') PHY, ";
	sql += "TO_CHAR(SUM(BOD), 'FM999,990.00') BOD, ";
	sql += "TO_CHAR(SUM(COD), 'FM999,990.00') COD, ";
	sql += "TO_CHAR(SUM(SUS), 'FM999,990.00') SUS, ";
	sql += "TO_CHAR(SUM(TOP), 'FM999,990.00') TOP, ";
	sql += "TO_CHAR(SUM(TON), 'FM999,990.00') TON, ";
	sql += "TO_CHAR(SUM(FLW), 'FM999,990') FLW, ";
	sql += "SUM(PHY_OR) PHY_OR, ";
	sql += "SUM(BOD_OR) BOD_OR, ";
	sql += "SUM(COD_OR) COD_OR, ";
	sql += "SUM(SUS_OR) SUS_OR, ";
	sql += "SUM(TOP_OR) TOP_OR, ";
	sql += "SUM(TON_OR) TON_OR, ";
	sql += "SUM(FLW_OR) FLW_OR, ";
	sql += "MAX(MINST) MINST, MAX(MINAB) MINAB "; 
	sql += "		,'R'||MAX(AREA_GBN) AS RIVER_DIV ";
	sql += "		,DECODE(MAX(AREA_GBN),'01','수도권','02','충청/강원','03','영남','04','호남') AS RIVER_NAME ";
	sql += "		,'W' AS SYS_KIND ";
	sql += "		,'수질TMS' AS	SYS_KIND_NAME ";
	sql += "		FROM ( SELECT A.ITEM_CODE AS ITEMCODE, ";
	sql += "			B.ITEM_NAME AS ITEMNAME, ";
	sql += "			A.FACT_CODE AS FACTCODE, ";
	sql += "			C.FACT_NAME AS FACTNAME, ";
	sql += "			A.WAST_NO	AS BRANCHNO, ";
	sql += "			A.WAST_NO BRANCH_NAME, ";
	sql += "			A.MIN_TIME	AS MINTIME , ";
	sql += "			TO_CHAR(TO_DATE(A.MIN_TIME,'YYYYMMDDHH24MI'),'YYYY/MM/DD') AS STRDATE, ";
	sql += "			TO_CHAR(TO_DATE(A.MIN_TIME,'YYYYMMDDHH24MI'),'HH24:MI') AS STRTIME, ";
	sql += "			A.MIN_RTIME AS MINRTIME, ";
	sql += "			A.MIN_DUMP	AS MINDUMP , ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'PHY', MIN_VL) PHY, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'BOD', MIN_VL) BOD, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'COD', MIN_VL) COD, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3),'SUS', MIN_VL) SUS, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'TOP', MIN_VL) TOP, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3),'TON', MIN_VL) TON, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'FLW', MIN_VL) FLW, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'PHY', MIN_OR) PHY_OR, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'BOD', MIN_OR) BOD_OR, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'COD', MIN_OR) COD_OR, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'SUS', MIN_OR) SUS_OR, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'TOP', MIN_OR) TOP_OR, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'TON', MIN_OR) TON_OR, ";
	sql += "			DECODE(SUBSTR(A.ITEM_CODE, 0, 3), 'FLW', MIN_OR) FLW_OR, ";
	sql += "			A.MIN_ST AS MINST, ";
	sql += "			A.MIN_AB AS MINAB, ";
	sql += "			AREA.AREA_GBN ";
	sql += "		FROM WTMSC_MIN_REAL_LAST@TMS A, "; 
	sql += "			 WTMSC_ITEM@TMS B, ";
	sql += "			 WTMSC_FACT@TMS C, ";
	sql += "			 WTMSC_FACT_WAST@TMS D, ";
	sql += "			 WTMSC_AREA@TMS AREA ";
	sql += "		WHERE A.ITEM_CODE = B.ITEM_CODE ";
	sql += "			AND A.FACT_CODE = C.FACT_CODE ";
	sql += "			AND C.FACT_CODE = D.FACT_CODE ";
	sql += "			AND A.WAST_NO = D.WAST_NO ";
	sql += "			AND D.WAST_USED = 'Y' ";
	sql += "			AND C.FACT_USED = 'Y' ";
	sql += "			AND AREA.CTY_CODE = C.CTY_CODE ) ";
	sql += "GROUP BY FACTCODE, FACTNAME, BRANCHNO, BRANCH_NAME, STRDATE, STRTIME, ";
	sql += "		 MINTIME, STRDATE, STRTIME, MINRTIME, MINDUMP ";
	sql += "ORDER BY STRDATE DESC, STRTIME DESC, FACTNAME ASC, BRANCHNO ASC ";
	/* System.out.println("<script>");
	System.out.println("alert('" + sql + "');");
	System.out.println("</script>"); */
	System.out.println("getTMSXML >>>>>>>>>> " + sql);
	JSONArray reJson = new JSONArray();
	
	try
	{
		stmt=conn.createStatement();
		rs=stmt.executeQuery(sql);
		while(rs.next())
		{
		JSONObject jo = new JSONObject();
			ResultSetMetaData rmd = rs.getMetaData();
		
			for ( int i=1; i<=rmd.getColumnCount(); i++ )
			{
				jo.put(rmd.getColumnName(i),rs.getString(rmd.getColumnName(i)));
			}
			reJson.add(jo);
		}
		out.println(reJson.toString());
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
