<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="방제지침서" name="title"/>
</jsp:include>
<style type="text/css">
	#idx h2 { font-size:14px; margin-left:30px; font-weight:normal; }
	#idx a { text-decoration:none; color:#333333; }
</style>
</head>
<body>

	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/manual/manual.do" name="link"/>
		<jsp:param value="방제지침서" name="title"/>
	</jsp:include>
    
	<div id="idx">
		<h1><a href="manual_view.do?name=1">제1장 개 요</a></h1>
			<h2><a href="manual_view.do?name=1">제1절 목적</a></h2>
			<h2><a href="manual_view.do?name=1">제2절 법적근거</a></h2>
			<h2><a href="manual_view.do?name=2">제3절 적용범위</a></h2>
		<h1><a href="manual_view.do?name=3">제2장 체계도</a></h1>
			<h2><a href="manual_view.do?name=3">제1절 수질오염 사고예방 체계</a></h2>
			<h2><a href="manual_view.do?name=5">제2절 사고대응 체계도</a></h2>
			<h2><a href="manual_view.do?name=6">제3절 공사 중 사고 현장 체계도</a></h2>
		<h1><a href="manual_view.do?name=11">제3장 수질오염사고 유형/예방/대처방안</a></h1>
			<h2><a href="manual_view.do?name=11">제1절 장비별 수질오염사고</a></h2>
			<h2><a href="manual_view.do?name=61">제2절 계절별 수질오염사고</a></h2>
			<h2><a href="manual_view.do?name=65">제3절 취/정수장 수질오염사고</a></h2>
			<h2><a href="manual_view.do?name=74">제4절 오염물질별 수질오염사고</a></h2>
	</div>

</body>
</html>