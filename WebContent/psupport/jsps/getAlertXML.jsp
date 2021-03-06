<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*, net.sf.json.*"%>
<%@ include file="dbconn.jsp" %>

<%
response.setContentType("text/html; charset=utf-8");
	try
	{
		Statement stmt=null;
// 		sql = "SELECT * FROM T_ALERT_INFO WHERE ALERT_LEVEL IN ('1', '2', '3', '4')";
		sql = "SELECT A.*,  NVL(B.LATITUDE,0) AS LATITUDE, NVL(B.LONGITUDE,0) AS LONGITUDE  FROM T_ALERT_INFO A,  T_FACT_BRANCH_INFO B  WHERE A.FACT_CODE = B.FACT_CODE  AND A.BRANCH_NO = B.BRANCH_NO  AND B.BRANCH_USE_FLAG = 'Y' AND A.ROWID IN  (SELECT MAX(ROWID)  FROM T_ALERT_INFO  GROUP BY FACT_CODE,  BRANCH_NO) AND TO_CHAR(ALERT_TIME,'YYYYMMDD') >= TO_CHAR(SYSDATE - 7,'YYYYMMDD') ORDER BY SYS_KIND DESC, ALERT_TIME DESC";
	
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
			
			//System.out.println("aaaaaaaaaaaaaaaaaaaaaa ==> " + sql);
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
