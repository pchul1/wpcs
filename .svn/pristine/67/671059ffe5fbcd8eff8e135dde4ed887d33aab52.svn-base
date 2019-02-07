<%@page import="java.sql.*"%><%@page import="java.sql.DriverManager"%><%
Connection conn=null;
PreparedStatement pstmt=null;
ResultSet rs=null;


int rsNum = 0;
String sql=null;
//String DB_URL="jdbc:oracle:thin:@10.101.164.221:1521:WPCS";
//real
String DB_URL = "jdbc:oracle:thin:@(DESCRIPTION=" +
 "(ADDRESS_LIST=" +
 "(ADDRESS=(PROTOCOL=TCP)" +
 "(HOST=10.101.164.221)" +
 "(PORT=1521)" +
 ")" +
 ")" +
 "(CONNECT_DATA=" +
 "(SERVICE_NAME=WPCS)" +
 "(SERVER=DEDICATED)" +
 ")" +
 ")";

//local
// String DB_URL = "jdbc:oracle:thin:@(DESCRIPTION=" +
//  "(ADDRESS_LIST=" +
//  "(ADDRESS=(PROTOCOL=TCP)" +
//  "(HOST=10.101.214.95)" +
//  "(PORT=1521)" +
//  ")" +
//  ")" +
//  "(CONNECT_DATA=" +
//  "(SERVICE_NAME=orcl)" +
//  "(SERVER=DEDICATED)" +
//  ")" +
//  ")";

String DB_USER="wpcs";
String DB_PASSWORD="wpcs";

try
{
	Class.forName("oracle.jdbc.OracleDriver");
}catch(Exception ex){out.print("Driver Loading error : " + ex);}

try
{
	conn=DriverManager.getConnection(DB_URL,DB_USER,DB_PASSWORD); 
}catch(Exception ex){out.print("Connection error : " + ex);}


%>