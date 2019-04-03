<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%>
<%@ include file="dbconn.jsp" %>
<% request.setCharacterEncoding("utf-8"); %>
<% response.setContentType("text/html; charset=utf-8"); %>

<%
try
{
	String userId = (String)request.getSession().getAttribute("userId");
	String type   = (String)request.getParameter("type");
	String flag   = (String)request.getParameter("flag");
	
	String OBJECTID = (String)request.getParameter("OBJECTID");
	String X = (String)request.getParameter("X");
	String Y = (String)request.getParameter("Y");
	String FACT_CODE = (String)request.getParameter("FACT_CODE");
	String BRANCH_NO = (String)request.getParameter("BRANCH_NO");
	String FACI_NM = (String)request.getParameter("FACI_NM");
	String FACI_ADDR = (String)request.getParameter("FACI_ADDR");
	String RV_CD = (String)request.getParameter("RV_CD");
	String USE_FLAG = (String)request.getParameter("USE_FLAG");

	if("A".equals(type)){
		if("I".equals(flag)){
			sql  = "INSERT INTO T_GIS_AUTO(OBJECTID, X, Y, DATE_, TIME, FACI_NM, FACI_ADDR, RV_CD, FACT_CODE, BRANCH_NO, USE_FLAG) "+ 
					   "VALUES((SELECT MAX(OBJECTID)+1 FROM T_GIS_AUTO), "+X+", "+Y+","+ 
					   "TO_CHAR(SYSDATE, 'YYYY/MM/DD'), TO_CHAR(SYSDATE, 'HH24:MI') , '"+FACI_NM+"', '"+FACI_ADDR+"', '"+RV_CD+"', '"+FACT_CODE+"', '"+BRANCH_NO+"', '"+USE_FLAG+"')";			                                                                    
		}else if("U".equals(type)){
			sql  = "UPDATE T_GIS_AUTO SET X = '"+X+"', Y = '"+Y+"',FACI_NM = '"+FACI_NM+"',FACI_ADDR = '"+FACI_ADDR+"', FACT_CODE='"+FACT_CODE+"', BRANCH_NO='"+BRANCH_NO+"', USE_FLAG='"+USE_FLAG+"'"+
					" WHERE FACT_CODE='"+FACT_CODE+"' AND BRANCH_NO='"+BRANCH_NO+"'"; 
		}else if("D".equals(type)) {
			sql  = "DELETE FROM T_GIS_AUTO"+
					" WHERE FACT_CODE='"+FACT_CODE+"' AND BRANCH_NO='"+BRANCH_NO+"'";
		}
	}else{
		if("I".equals(type)){
			sql  = "INSERT INTO T_GIS_IPUSN(OBJECTID, X, Y, FACI_NM, FACI_ADDR, RV_CD, FACT_CODE, BRANCH_NO, USE_FLAG) "+ 
					   "VALUES((SELECT MAX(OBJECTID)+1 FROM T_GIS_AUTO), "+X+", "+Y+","+ 
					   "'"+FACI_NM+"', '"+FACI_ADDR+"', '"+RV_CD+"', '"+FACT_CODE+"', '"+BRANCH_NO+"','"+USE_FLAG+"')";			                                                                    
		}else if("U".equals(type)){
			sql  = "UPDATE T_GIS_IPUSN SET X = '"+X+"', Y = '"+Y+"',FACI_NM = '"+FACI_NM+"',FACI_ADDR = '"+FACI_ADDR+"', FACT_CODE='"+FACT_CODE+"', BRANCH_NO='"+BRANCH_NO+"', USE_FLAG='"+USE_FLAG+"'"+
					" WHERE FACT_CODE='"+FACT_CODE+"' AND BRANCH_NO='"+BRANCH_NO+"'"; 
		}else if("D".equals(type)) {
			sql  = "DELETE FROM T_GIS_IPUSN"+
					" WHERE FACT_CODE='"+FACT_CODE+"' AND BRANCH_NO='"+BRANCH_NO+"'";
		}
	}
	
	Statement stmt=null;
	
	try {
		stmt=conn.createStatement();
		int i =stmt.executeUpdate(sql);
		out.println(i);
	} catch(SQLException ex) {
		ex.printStackTrace();
	} finally{
		closeConn(rs,stmt,conn);
	}
} catch(Exception ex) {
	ex.printStackTrace();
}
%>