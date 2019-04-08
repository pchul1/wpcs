<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%>
<%@ include file="dbconn.jsp" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>

<%
	response.setContentType("text/html; charset=utf-8");
try
{
	String userId = (String)request.getSession().getAttribute("userId");
	
	String type   = (String)request.getParameter("type");
	
	String title   = (String)request.getParameter("title");
	
	String content = (String)request.getParameter("content");
	String allYn = (String)request.getParameter("allYn");
	String useYn = (String)request.getParameter("useYn");
	String x = (String)request.getParameter("x");
	String y = (String)request.getParameter("y");
	String objectId = (String)request.getParameter("objectId");

	if("I".equals(type)){
		sql  = "INSERT INTO T_GIS_TEMP_BRANCH (OBJECTID,TEMP_SRNO,TITLE,CONTENT,REG_ID,REG_DATE,USE_YN,ALL_YN,X,Y)"+ 
				   "VALUES ((SELECT MAX(OBJECTID)+1 FROM T_GIS_TEMP_BRANCH),(SELECT MAX(TEMP_SRNO)+1 FROM T_GIS_TEMP_BRANCH),"+
							"'"+title+"','"+content+"','"+userId+"',(TO_CHAR(sysdate,'YYYYMMDDHH24MI')),'"+useYn+"','"+allYn+"',"+x+","+y+")";                                                                    
	}else{
		sql  = "UPDATE T_GIS_TEMP_BRANCH SET ALL_YN = '"+allYn+"', USE_YN = '"+useYn+"',TITLE = '"+title+"',CONTENT = '"+content+"' "+
				"WHERE OBJECTID = '"+objectId+"'"; 
	}
		Statement stmt=null;
	try {
		stmt=conn.createStatement();
		int i =stmt.executeUpdate(sql);
		out.println(i);
	} catch(SQLException ex) {
		ex.printStackTrace();
	}finally{
		closeConn(rs,stmt,conn);
	}
} catch(Exception ex) {
	ex.printStackTrace();
}
%>