<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*, net.sf.json.*"%><%@ include file="dbconn.jsp" %>

<%
response.setContentType("text/html; charset=utf-8");
try
{
	Statement stmt=null;
	sql = "SELECT   SYS_KIND,"+            
            "SUM(REG) cnt1,"+               
            "SUM(NORMAL) CNT2, "+
            "SUM(INTEREST) A1, "+
            "SUM(CAUTION) A2, "+
            "SUM(ALERT) A3, "+
            "SUM(OVER) A4, "+
            "SUM(NORECV) M "+
    "FROM (SELECT F1.FACT_CODE, D1.FACT_CODE, "+
                    "B1.BRANCH_NO, "+
                    "(SELECT CASE "+
                             "WHEN SUBSTR(TO_CHAR(SYSDATE - 60 / 24 / 60 * 3, 'YYYYMMDDHH24MI'), 1) < 5 THEN  SUBSTR(TO_CHAR(SYSDATE - 60 / 24 / 60 * 3, 'YYYYMMDDHH24MI'), 1, 11) || '0' "+
                             "ELSE SUBSTR(TO_CHAR(SYSDATE - 60 / 24 / 60 * 3, 'YYYYMMDDHH24MI'), 1, 11) || '5' END NOW "+
                    "FROM DUAL) MIN_TIME, "+
                    "(DECODE(D1.MIN_OR, '0', 1, 0,'1', 1, 0,'2', 1, 0,'3', 1, 0,'4', 1, 0)+DECODE(D1.FACT_CODE, NULL, 1, 0) )REG, "+
                    "DECODE(D1.MIN_OR, '0', 1, 0) NORMAL, "+
                    "DECODE(D1.MIN_OR, '1', 1, 0) INTEREST, "+
                    "DECODE(D1.MIN_OR, '2', 1, 0) CAUTION, "+
                    "DECODE(D1.MIN_OR, '3', 1, 0) ALERT, "+
                    "DECODE(D1.MIN_OR, '4', 1, 0) OVER, "+
                    "DECODE(D1.FACT_CODE, NULL, 1, 0) NORECV, "+
                    "F1.RIVER_DIV, "+
                    "F1.SYS_KIND "+
            "FROM T_FACT_INFO F1, "+
                    "T_FACT_BRANCH_INFO B1, "+
                    "( "+
                     "SELECT FACT_CODE, BRANCH_NO, "+
                            "MAX(CASE "+
                                "WHEN START_ALARM_DATE IS NULL THEN  MIN_OR "+
                                "WHEN ALARM_TYPE IN ('51', '52') THEN '1' "+
                                "WHEN ALARM_TYPE IN ('61', '62') THEN '2' "+
                                "WHEN ALARM_TYPE IN ('71', '72') THEN '3' "+
                             "END) MIN_OR  "+
                    "FROM (SELECT FACT_CODE, BRANCH_NO, ITEM_CODE, "+
                                 "MAX(MIN_TIME) MIN_TIME, "+
                                 "SUBSTR(MAX(LPAD(MIN_TIME,12,0)||MIN_OR),13) MIN_OR "+
                            "FROM T_MIN_DATA D "+
                            "WHERE D.MIN_TIME >= TO_CHAR(SYSDATE - 60/24/60*3, 'YYYYMMDDHH24MI') "+
                             "AND EXISTS (SELECT '1' "+
                                            "FROM T_FACT_MEASU_ITEM I "+
                                         "WHERE I.ITEM_USE_FLAG = 'Y' "+
                                            "AND I.FACT_CODE = D.FACT_CODE "+
                                            "AND I.BRANCH_NO = D.BRANCH_NO "+
                                            "AND I.ITEM_CODE = D.ITEM_CODE) "+
                            "GROUP BY FACT_CODE, BRANCH_NO, ITEM_CODE) A, "+
                        "ALARMHIST_TB B "+
                    "WHERE A.FACT_CODE = B.SITE_ID(+) "+
                    "AND A.MIN_TIME = SUBSTR(B.START_ALARM_DATE(+), 0, 12) "+
                    "AND A.MIN_TIME >= TO_CHAR(SYSDATE - 60/24/60 * 3, 'YYYYMMDDHH24MI') "+
                    "GROUP BY FACT_CODE, BRANCH_NO "+
                    ") D1 "+
             "WHERE B1.FACT_CODE = D1.FACT_CODE(+) "+
                "AND B1.FACT_CODE = F1.FACT_CODE "+
                "AND B1.BRANCH_NO = D1.BRANCH_NO(+) "+
                "AND B1.BRANCH_USE_FLAG = 'Y' "+
                "AND F1.FACT_USE_FLAG = 'Y' "+
                "AND F1.SYS_KIND IN ('U', 'A')) "+
     "GROUP BY  SYS_KIND ";
 
	
	JSONArray reJson = new JSONArray();
	
	try
	{
		stmt=conn.createStatement();
		rs=stmt.executeQuery(sql);
		while(rs.next())
		{
			JSONObject  jo  = new JSONObject();
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