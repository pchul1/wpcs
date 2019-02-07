<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 
 String sNO = request.getParameter("NO");
 String sFACT_CODE = request.getParameter("FACT_CODE");
 Statement stmt=null;
 sql  = "SELECT FACT_CODE, BRANCH_NO, NVL(BRANCH_MGR_TEL_NO, '정보없음')BRACNH_MGR_TEL_NO, NVL(BRANCH_MAP_X,0)BRANCH_MAP_X, NVL(BRANCH_MAP_Y,0)BRANCH_MAP_Y, NVL(BRANCH_IP,'정보없음')BRANCH_IP, NVL(BRANCH_PORT,'정보없음')BRANCH_PORT, NVL(BRANCH_COMM_NO,'정보없음')BRANCH_COMM_NO, NVL(LATITUDE,0)LATITUDE, NVL(LONGITUDE,0)LONGITUDE, NVL(CDMA_GROUP,'정보없음')CDMA_GROUP, NVL(CDMA_TEL_NO,'정보없음')CDMA_TEL_NO, NVL(GPS_DIST,'정보없음')GPS_DIST, NVL(BRANCH_NAME,'정보없음')BRANCH_NAME, NVL(BRANCH_FNAME,'정보없음')BRANCH_FNAME FROM T_FACT_BRANCH_INFO WHERE 1=1";	 
  
 sql += " AND FACT_CODE LIKE '%" + sFACT_CODE + "%' AND BRANCH_NO LIKE '%" + sNO + "%' AND BRANCH_USE_FLAG='Y'";

 try
 {
  //out.print(sql);
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<BRANCHS>");
  while(rs.next())
  {
	   out.println("<BRANCH>");
	   out.println("<FACT_CODE>" + rs.getString(1) + "</FACT_CODE>");
	   out.println("<BRANCH_NO>" + rs.getInt(2) + "</BRANCH_NO>");
	   out.println("<BRANCH_MGR_TEL_NO>" + rs.getString(3) + "</BRANCH_MGR_TEL_NO>");
	   out.println("<BRANCH_MAP_X>" + rs.getDouble(4) + "</BRANCH_MAP_X>");
	   out.println("<BRANCH_MAP_Y>" + rs.getDouble(5) + "</BRANCH_MAP_Y>");
	   out.println("<BRANCH_IP>" + rs.getString(6) + "</BRANCH_IP>");
	   out.println("<BRANCH_PORT>" + rs.getString(7) + "</BRANCH_PORT>");
	   out.println("<BRANCH_COMM_NO>" + rs.getString(8) + "</BRANCH_COMM_NO>");
	   out.println("<LATITUDE>" + rs.getDouble(9) + "</LATITUDE>");
	   out.println("<LONGITUDE>" + rs.getDouble(10) + "</LONGITUDE>");
	   out.println("<CDMA_GROUP>" + rs.getString(11) + "</CDMA_GROUP>");
	   out.println("<CDMA_TEL_NO>" + rs.getString(12) + "</CDMA_TEL_NO>");
	   out.println("<GPS_DIST>" + rs.getString(13) + "</GPS_DIST>");
	   out.println("<BRANCH_NAME>" + rs.getString(14) + "</BRANCH_NAME>");
	   out.println("<BRANCH_FNAME>" + rs.getString(15) + "</BRANCH_FNAME>");
	   
	   out.println("</BRANCH>");
  }
  out.println("</BRANCHS>");
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