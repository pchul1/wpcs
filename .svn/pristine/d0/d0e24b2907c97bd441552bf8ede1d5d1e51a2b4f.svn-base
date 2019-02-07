<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<script>
<c:if test="${!empty param_s.message}">
alert('<spring:message code="${param_s.message}"/>');
</c:if>

<c:if test="${!empty param_s.return_url}">
location.replace('<c:out value="${param_s.return_url}"/>');
</c:if>
<c:if test="${empty param_s.return_url}">
history.back();
</c:if>
</script>
</head>
<body>
</body>
</html>