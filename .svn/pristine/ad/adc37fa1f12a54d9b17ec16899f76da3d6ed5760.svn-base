<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*, net.sf.json.*"%>
<%@ include file="dbconn.jsp" %>

<%
response.setContentType("text/html; charset=utf-8");
try
{
	Statement stmt=null;
	sql = "SELECT A.WH_CODE , B.ITEM_CODE, B.ITEM_NAME , B.ITEM_NAME||' ['||B.ITEM_UNIT||'] : '||A.ITEM_CNT||' '||B.ITEM_STAN AS MSG "+
			" FROM T_ITEM_STOCK A, T_ITEM_CODE B "+
			" WHERE A.ITEM_CODE = B.ITEM_CODE AND  A.ITEM_CODE_NUM = B.ITEM_CODE_NUM ";
	
	//System.out.println("getWH >>>> " + sql);
	
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
<%!
	public void closeConn(ResultSet rs, Statement stmt, Connection con) throws Exception
	{
		rs.close();
		con.close();
		stmt.close();
	}
%>