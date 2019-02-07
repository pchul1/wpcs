<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="현장공유솔루션" name="title"/>
</jsp:include>
<style type="text/css">
	#idx h2 { font-size:14px; margin-left:30px; font-weight:normal; }
	#idx a { text-decoration:none; color:#333333; }
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/manual/solution.do" name="link"/>
		<jsp:param value="현장공유솔루션" name="title"/>
	</jsp:include>
    
	<div id="idx">
		<h1><a title="새창" href="/pds/EMISView-v1.0.0.1-20180914144221.apk" target="_blank">현장공유솔루션(안드로이드 버전)</a></h1>
		<h1><a title="새창" href="/pds/SSL_VPN_manual.pdf" target="_blank">SSL-VPN 매뉴얼</a></h1>
	</div>

</body>
</html>