<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%><%@ page import = "java.io.*, java.sql.*, java.util.*, java.net.*"%><%@ include file="dbconn.jsp" %><%
response.setContentType("text/xml; charset=utf-8");
try
{
 
 String sDO_CODE = request.getParameter("DO_CODE");
 String sCTY_CODE = request.getParameter("CTY_CODE");
 String sNM = new String((request.getParameter("NM")).getBytes("8859_1"), "EUC-KR");
 Statement stmt=null;
 sql = "SELECT ID, NVL(NM, '정보없음')NM, NVL(ADDRESS, '정보없음')ADDRESS, DO_CODE, CTY_CODE, NVL(DEPT,'정보없음')DEPT, NVL(DAY_TEL,'정보없음')DAY_TEL, NVL(NIGHT_TEL,'정보없음')NIGHT_TEL, NVL(DAY_FAX,'정보없음')DAY_FAX, NVL(NIGHT_FAX,'정보없음')NIGHT_FAX FROM T_RELATE_OFFICE WHERE 1=1";
 
 if(sDO_CODE == "" || sDO_CODE == null){}else{
	 sql += " AND DO_CODE LIKE '%" + sDO_CODE + "%'";
};

if(sCTY_CODE == "" || sCTY_CODE == null){}else{
	 sql += " AND CTY_CODE LIKE '%" + sCTY_CODE + "%'";
};
if(sNM == "" || sNM == null){}else{
	 sql += " AND NM LIKE '%" + sNM + "%'";
};
 sql += "AND USE_YN='Y' ORDER BY NM";
 try
 {
  stmt=conn.createStatement();
  rs=stmt.executeQuery(sql);
  out.println("<?xml version=\"1.0\" encoding=\"utf-8\" ?>");
  out.println("<ROFFICES>");
  while(rs.next()) 
  {
	  out.println("<ROFFICE>");
	   out.println("<ID>" + rs.getString(1) + "</ID>");
	   out.println("<NM>" + rs.getString(2) + "</NM>");
	   out.println("<ADDRESS>" + rs.getString(3) + "</ADDRESS>");
	   out.println("<DO_CODE>" + rs.getString(4) + "</DO_CODE>");
	   out.println("<CTY_CODE>" + rs.getString(5) + "</CTY_CODE>");
	   out.println("<DEPT>" + rs.getString(6) + "</DEPT>");
	   out.println("<DAY_TEL>" + rs.getString(7) + "</DAY_TEL>");
	   out.println("<NIGHT_TEL>" + rs.getString(8) + "</NIGHT_TEL>");
	   out.println("<DAY_FAX>" + rs.getString(9) + "</DAY_FAX>");
	   out.println("<NIGHT_FAX>" + rs.getString(10) + "</NIGHT_FAX>");
	   out.println("</ROFFICE>");
  }
  out.println("</ROFFICES>");
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