<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%

String a= request.getParameter("name") ;

//String a= "한글" ;
out.println("Real Date : "+a+"<p>") ;
//System.out.println(a) ;

byte[] b= null ;
String c= null ;

// No Encoding GetBytes
b= a.getBytes() ;
c= new String(b) ;
out.println("No Encoding GetBytes, No Encoding String : "+c+"<br>") ;

c= new String(b, "EUC-KR") ;
out.println("No Encoding GetBytes, EUC-KR Encoding String : "+c+"<br>") ;

c= new String(b, "UTF-8") ;
out.println("No Encoding GetBytes, UTF-8 Encoding String : "+c+"<br>") ;

c= new String(b, "ISO-8859-1") ;
out.println("No Encoding GetBytes, ISO-8859-1 Encoding String : "+c+"<br>") ;

out.println("<p>") ;

// Encoding EUC-KR GetBytes
b= a.getBytes("EUC-KR") ;
c= new String(b) ;
out.println("EUC-KR Encoding GetBytes, No Encoding String : "+c+"<br>") ;

c= new String(b, "EUC-KR") ;
out.println("EUC-KR Encoding GetBytes, EUC-KR Encoding String : "+c+"<br>") ;

c= new String(b, "UTF-8") ;
out.println("EUC-KR Encoding GetBytes, UTF-8 Encoding String : "+c+"<br>") ;

c= new String(b, "ISO-8859-1") ;
out.println("EUC-KR Encoding GetBytes, ISO-8859-1 Encoding String : "+c+"<br>") ;

out.println("<p>") ;

// Encoding UTF-8 GetBytes
b= a.getBytes("UTF-8") ;
c= new String(b) ;
out.println("UTF-8 Encoding GetBytes, No Encoding String : "+c+"<br>") ;

c= new String(b, "EUC-KR") ;
out.println("UTF-8 Encoding GetBytes, EUC-KR Encoding String : "+c+"<br>") ;

c= new String(b, "UTF-8") ;
out.println("UTF-8 Encoding GetBytes, UTF-8 Encoding String : "+c+"<br>") ;

c= new String(b, "ISO-8859-1") ;
out.println("UTF-8 Encoding GetBytes, ISO-8859-1 Encoding String : "+c+"<br>") ;

out.println("<p>") ;

// Encoding ISO-8859-1 GetBytes
b= a.getBytes("ISO-8859-1") ;
c= new String(b) ;
out.println("ISO-8859-1 Encoding GetBytes, No Encoding String : "+c+"<br>") ;

c= new String(b, "EUC-KR") ;
out.println("ISO-8859-1 Encoding GetBytes, EUC-KR Encoding String : "+c+"<br>") ;

c= new String(b, "UTF-8") ;
out.println("ISO-8859-1 Encoding GetBytes, UTF-8 Encoding String : "+c+"<br>") ;

c= new String(b, "ISO-8859-1") ;
out.println("ISO-8859-1 Encoding GetBytes, ISO-8859-1 Encoding String : "+c+"<br>") ;

out.println("<p>") ;

%>



