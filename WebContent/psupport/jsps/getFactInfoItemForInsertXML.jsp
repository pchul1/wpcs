<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 String sEXCEPT_CODE = new String((request.getParameter("EXCEPT_CODE")).getBytes("8859_1"), "EUC-KR");
 String tmpArray[] = sEXCEPT_CODE.split(",");
 String strReuslt="'99999999";
 Statement stmt=null;
 for (int i=0;i<tmpArray.length;i++){
	 //+sEXCEPT_CODE+;
 strReuslt += tmpArray[i]+"','"; 
};
strReuslt += "99999999'";
 sql  = "SELECT ITEM_CODE, ITEM_NAME, ITEM_MNAME FROM T_ITEM WHERE TO_CHAR(ITEM_CODE) NOT IN ("+strReuslt+") ORDER BY ITEM_MNAME";
 
 try
 {
//out.println("tmpArray[1]="+tmpArray[1]); 
  //out.println("sEXCEPT_CODE="+sEXCEPT_CODE); 
  //out.println("strReuslt="+strReuslt);
  //out.println("sql="+sql);
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<FACTITEMS>");
  while(rs.next())
  {
	  out.println("<FACTITEM>");
	   out.println("<ITEM_CODE>" + rs.getString(1) + "</ITEM_CODE>");
	   out.println("<ITEM_NAME>" + rs.getString(2) + "</ITEM_NAME>");
	   out.println("<ITEM_MNAME>" + rs.getString(3) + "</ITEM_MNAME>");
	   out.println("</FACTITEM>");
  }
 
  out.println("</FACTITEMS>");
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