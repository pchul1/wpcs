<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : report.jsp
	 * Description : 수질오염리포트 화면
	 * Modification Information
	 * 
	 * 수정일			 수정자		수정내용
	 * -------		--------	---------------------------
	 * 2010.06.18	kisspa		 최초 생성
	 * 2011.12.20	bobylone	수질오염 등록 안되는 오류 수정 (파라미터(owner=${user.id}) 추가)
	 * 2013.10.20	lkh			리뉴얼
	 *
	 * author kisspa
	 * since 2010.07.02
	 *
	 * Copyright (C) 2010 by kisspa All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html style="margin:0;padding:0;overflow:hidden;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>
<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<script type="text/javascript">
$(function(){
	var contentheight = 475 - $("#titlediv").height()
	$("#contentdiv").height(contentheight);
});
</script>
</head>
<body style="border:5px solid #07AFFA;height:98%;">
<div style="margin:20px;height:100%;">
	<div style="font-size: 20pt; margin-bottom: 10px; border-bottom: 2px solid #666666;">공지사항</div>
	<div style="font-size:15pt;font-weight:bold;margin:10px 0;overflow:hidden;" id="titlediv"><c:out value="${popupView.nttSj}" escapeXml="false" /></div>
	<div style="width:100%;height:70%;overflow-y:scroll;overflow-x:inherit;border:1px solid #666666;" id="contentdiv"><c:out value="${popupView.nttCn}" escapeXml="false" /></div>
	<div style="position:absolute;bottom:15px;right:25px;cursor:pointer;" onclick="setCookie('popup<c:out value="${popupView.nttId}" escapeXml="false" />','O',1);window.close();">하루동안 다시보지 않기 X</div>
</div>
</body>
</html>