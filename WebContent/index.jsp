<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="daewooInfo.common.security.util.TmsUserDetailsHelper" %>
<%if(TmsUserDetailsHelper.isAuthenticated()) { %>
	<jsp:forward page="/main.do"/>
<%} else {%>
	<jsp:forward page="/index.do"/>
<%}%>