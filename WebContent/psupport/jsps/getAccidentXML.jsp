<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%>
<%@ include file="dbconn.jsp" %>
<%
//response.setContentType("text/xml; charset=utf-8");
try {
	String searchRiverDiv = request.getParameter("searchRiverDiv");
	String searchWpKind = request.getParameter("searchWpKind");
	String searchstep = request.getParameter("searchstep");
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");

// String format = request.getParameter("format");

	Statement stmt=null;
	
	sql = "select * from (SELECT A.WP_CODE, ";
	sql +="SUBSTR(A.REPORT_DATE,0,4)||'-' || SUBSTR(A.REPORT_DATE,5,2) ||'-'|| SUBSTR(A.REPORT_DATE,7,2)	 AS reportDate, ";
	sql +="SUBSTR(A.RECEIVE_DATE,0,4)||'-' || SUBSTR(A.RECEIVE_DATE,5,2) ||'-'|| SUBSTR(A.RECEIVE_DATE,7,2) AS receiveDate, ";
	sql +="A.RIVER_DIV, ";
	sql +="A.WP_KIND, ";
	sql +="A.WP_CONTENT, ";
	sql +="A.SUPPORT_KIND , ";
	sql +="A.ADDRESS, ";
	sql +="A.ADDR_DET, ";
	sql +="(SELECT WPS_STEP ";
	sql +="FROM T_WATER_POLLUTION_STEP ";
	sql +="WHERE WPS_CODE = (SELECT MAX(WPS_CODE) ";
	sql +="FROM T_WATER_POLLUTION_STEP ";
	sql +="WHERE WP_CODE = A.WP_CODE ";
	sql +="AND DEL_YN='N'";
	sql +="GROUP BY WP_CODE) ";
	sql +="AND WP_CODE = A.WP_CODE ";
	sql +="AND DEL_YN = 'N'";
	sql +=") AS WPS_STEP, ";
	sql +="A.LONGITUDE, ";
	sql +="A.LATITUDE ";
	sql +="FROM T_WATER_POLLUTION A, T_MEMBER B ";
	sql +="WHERE A.RECEIVER_ID = B.MEMBER_ID ";
	sql +="AND A.DEL_YN='N'";
	sql +="AND A.RECEIVE_DATE BETWEEN '"+startDate+"'||'0000' AND '"+endDate+"'||'2359' ";
	sql +=" ORDER BY A.RECEIVE_DATE DESC, A.WP_CODE DESC ) where 1=1 ";
	
	if(!(null == searchRiverDiv || 0 == searchRiverDiv.length() || ("all").equals(searchRiverDiv))){
		sql +=" AND RIVER_DIV = '"+searchRiverDiv+"'";
	}
	if(!(null == searchWpKind  || 0 == searchWpKind.length() || ("all").equals(searchWpKind))){
		sql +=" AND WP_KIND = '"+searchWpKind+"'";
	}
	if(!(null ==searchstep || 0 == searchstep.length() || ("all").equals(searchstep))){
		sql +=" AND WPS_STEP = '"+searchstep+"'";
	}
	
	System.out.println("getAccident >>>>> " + sql);
	
	try {
	//out.println(sql);
	stmt = conn.createStatement();
	rs = stmt.executeQuery(sql);

		out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
		out.println("<ACCIDENTS>");
		while(rs.next()) {
			out.println("<ACCIDENT>");
			out.println("<WPCODE>" + rs.getString(1) + "</WPCODE>");
			out.println("<REPORTDATE>" + rs.getString(2) + "</REPORTDATE>");
			out.println("<RECEIVEDATE>" + rs.getString(3) + "</RECEIVEDATE>");
			out.println("<RIVER_DIV>" + rs.getString(4) + "</RIVER_DIV>");
			out.println("<WPKIND>" + rs.getString(5) + "</WPKIND>");
			out.println("<WPCONTENT>" + rs.getString(6) + "</WPCONTENT>");
			out.println("<SUPPORTKIND>" + rs.getString(7) + "</SUPPORTKIND>");
			out.println("<ADDRESS>" + rs.getString(8) + "</ADDRESS>");
			out.println("<ADDRDET>" + rs.getString(9) + "</ADDRDET>");
			out.println("<WPSSTEP>" + rs.getString(10) + "</WPSSTEP>");
			out.println("<LONGITUDE>" + rs.getDouble(11) + "</LONGITUDE>");
			out.println("<LATITUDE>" + rs.getDouble(12) + "</LATITUDE>");
			out.println("</ACCIDENT>");
		}
		out.println("</ACCIDENTS>");
		closeConn(rs,stmt,conn);
	} catch(SQLException ex) {
		//System.out.println(ex);
		ex.printStackTrace();
	}
}
catch(Exception ex){
	//System.out.println(ex);
	ex.printStackTrace();
}
%>
<%!
public void closeConn(ResultSet rs, Statement stmt, Connection con) throws Exception {
	rs.close();
	con.close();
	stmt.close();
}
%>