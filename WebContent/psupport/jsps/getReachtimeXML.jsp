<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 //String sSYS_KIND = request.getParameter("SYS_KIND").equals("")?"":request.getParameter("SYS_KIND");
 String sCodes = request.getParameter("CODES");
 String[] sCode = sCodes.split(",");
 String sParam="'";
 for(int i=0;i<sCode.length;i++){
	 sParam += sCode[i];
	 if(i==sCode.length-1){sParam += "'";}else{sParam += "','";};
 }
 Statement stmt=null;
 
 sql="SELECT FACT_CODE, LONGITUDE, LATITUDE, SOW FROM";
sql+="(SELECT FACT_CODE, LONGITUDE, LATITUDE, B.SOW FROM T_FACT_INFO A, T_SOW B WHERE A.FACT_CODE=B.ID UNION SELECT C.ID FACT_CODE, LONGITUDE, LATITUDE,D.SOW  FROM T_WATERDC_CENTER C, T_SOW D WHERE C.ID=D.ID)";
sql+="WHERE FACT_CODE IN ("+sParam+")";

//out.println(sql);
 try
 {
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<RTLISTS>");
  while(rs.next())
  {
	  out.println("<RTLIST>");
	   out.println("<FACT_CODE>" + rs.getString(1) + "</FACT_CODE>");
	   out.println("<LONGITUDE>" + rs.getDouble(2) + "</LONGITUDE>");
	   out.println("<LATITUDE>" + rs.getDouble(3) + "</LATITUDE>");
	   out.println("<SPEED>" + rs.getString(4) + "</SPEED>");
	   out.println("</RTLIST>");
  }
  out.println("</RTLISTS>");
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