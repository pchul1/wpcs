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
			sql  = "INSERT INTO GIS_AUTO(OBJECTID, X, Y, DATE_, TIME, FACI_NM, FACI_ADDR, RV_CD, FACT_CODE, BRANCH_NO) "+ 
					   "VALUES((SELECT MAX(OBJECTID)+1 FROM GIS_AUTO), "+X+", "+Y+","+ 
					   "TO_CHAR(SYSDATE, 'YYYY/MM/DD'), TO_CHAR(SYSDATE, 'HH24:MI') , '"+FACI_NM+"', '"+FACI_ADDR+"', '"+RV_CD+"', '"+FACT_CODE+"', '"+BRANCH_NO+"')";			                                                                    
		}else if("U".equals(type)){
			sql  = "UPDATE GIS_AUTO SET X = '"+X+"', Y = '"+Y+"',FACI_NM = '"+FACI_NM+"',FACI_ADDR = '"+FACI_ADDR+"', FACT_CODE='"+FACT_CODE+"', BRANCH_NO='"+BRANCH_NO+"'"+
					" WHERE FACT_CODE='"+FACT_CODE+"' AND BRANCH_NO='"+BRANCH_NO+"'"; 
		}else if("D".equals(type)) {
			sql  = "DELETE FROM GIS_AUTO"+
					" WHERE FACT_CODE='"+FACT_CODE+"' AND BRANCH_NO='"+BRANCH_NO+"'";
		}
	}else{
		if("I".equals(type)){
			sql  = "INSERT INTO GIS_IPUSN(OBJECTID, X, Y, FACI_NM, FACI_ADDR, RV_CD, FACT_CODE, BRANCH_NO, USE_FLAG) "+ 
					   "VALUES((SELECT MAX(OBJECTID)+1 FROM GIS_AUTO), "+X+", "+Y+","+ 
					   "'"+FACI_NM+"', '"+FACI_ADDR+"', '"+RV_CD+"', '"+FACT_CODE+"', '"+BRANCH_NO+"','"+USE_FLAG+"')";			                                                                    
		}else if("U".equals(type)){
			sql  = "UPDATE GIS_IPUSN SET X = '"+X+"', Y = '"+Y+"',FACI_NM = '"+FACI_NM+"',FACI_ADDR = '"+FACI_ADDR+"', FACT_CODE='"+FACT_CODE+"', BRANCH_NO='"+BRANCH_NO+"', USE_FLAG='"+USE_FLAG+"'"+
					" WHERE FACT_CODE='"+FACT_CODE+"' AND BRANCH_NO='"+BRANCH_NO+"'"; 
		}else if("D".equals(type)) {
			sql  = "DELETE FROM GIS_IPUSN"+
					" WHERE FACT_CODE='"+FACT_CODE+"' AND BRANCH_NO='"+BRANCH_NO+"'";
		}
	}
	try
 	{
		Statement stmt=null;
		
		System.out.println(sql);
		
		stmt=conn.createStatement();
		int i =stmt.executeUpdate(sql);
		closeConn(rs,stmt,conn);
		
		out.println(i);
	}
	catch(SQLException ex)
	{
		ex.printStackTrace();
	}
}
catch(Exception ex)
{
	ex.printStackTrace();
}
%><%!
public void closeConn(ResultSet rs, Statement stmt, Connection con) throws Exception
{
	if(rs != null){
		rs.close();	
	}
	if(con != null){
		con.close();	
	}
	if(stmt != null){
		stmt.close();	
	}
}
%>