<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html style="height:100%;">
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="이동형측정기기 위치" name="title"/>
</jsp:include>
<!-- 실서버-->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=3728760A-A99F-39F6-96C8-74746BA4A738"></SCRIPT>	 -->
<!--  ????  -->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=C4246B58-A669-3643-A7FD-F545A61ECE20"></SCRIPT>    -->
<!-- 210.99.81.159:9090-->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=4EA77A23-29BC-37C9-A4EE-D3BCABCD9846"></SCRIPT> -->
<SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=C4246B58-A669-3643-A7FD-F545A61ECE20"></SCRIPT>	
<script language="javascript" type="text/javascript" src="/js/mobile/Vworld.js"></script>
<script type="text/javascript" charset="utf-8">
$(function(){
	vworldInit("map_canvas");
});

function map_start_function(){
	point = GoogleToVworld('${View.latitude}', '${View.longitude}');
	createMarker(point.x,point.y,"${View.branch_name}");
};

</script>
</head>
<body style="height:100%;">
	<div id="ipusnmap" style="height:100%;"> 
		<div id="map_canvas" style="height:100%;"> 
		</div> 
	</div> 
</body>
</html>