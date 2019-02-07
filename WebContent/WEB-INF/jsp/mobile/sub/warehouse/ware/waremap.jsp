<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pj" uri="ProjectJstlUtil"%>
<html style="height:100%;">
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="방제창고조회" name="title"/>
</jsp:include>
<!-- 실서버-->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=3728760A-A99F-39F6-96C8-74746BA4A738"></SCRIPT>	 -->
<!--  ????  -->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=C4246B58-A669-3643-A7FD-F545A61ECE20"></SCRIPT>    -->
<!-- 210.99.81.159:9090-->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=4EA77A23-29BC-37C9-A4EE-D3BCABCD9846"></SCRIPT> -->
<SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=C4246B58-A669-3643-A7FD-F545A61ECE20"></SCRIPT>	
<script type="text/javascript" src="/js/mobile/Vworld.js"></script>
<script type="text/javascript">
$(function(){
	vworldInit("map_canvas");
});

function map_start_function(){
	var point =GoogleToVworld('<c:out value="${View.lat}"/>', '<c:out value="${View.lon}"/>');
	createMarker(point.x,point.y,"<c:out value="${View.whName}"/>");
};

function goList(){
	document.forms['form1'].action = "warelist.do";
	document.forms['form1'].submit();
}
function goView(){
	document.forms['form1'].action = "wareview.do";
	document.forms['form1'].submit();
}
</script>
</head>
<body style="height:100%;">
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/warehouse/ware/waresearch.do" name="link"/>
		<jsp:param value="방제창고조회" name="title"/>
	</jsp:include>
<form method="post" name="form1">
	<input type="hidden" name="whCode" id="whCode" value=""<c:out value="${param_s.whCode}"/>"/>
	<input type="hidden" name="riverDiv" id="riverDiv" value="<c:out value="${param_s.riverDiv }"/>"/>
</form>
	<div id="registmap" style="height:100%;"> 
		
		<div id="mapcanvas" style="width:100%; height:80%;z-index:100;"> 
			<div id="map_canvas" style="width:100%; height:100%;"></div> 
		</div> 
	
	
		<table width="100%" cellpadding="0" cellspacing="0" style="margin-top:10px;">
		<tr>
			<td style="width:50%;" align="center">
				<ul class="sbtn" style="margin-right:5px;width:80%">
					<li style="width:90%;float:right;"><a href="#" onclick="goList()">목록</a></li> 
				</ul>
			</td>
			<td style="width:50%;" align="center">
				<ul class="sbtn" style="margin-left:5px;width:80%">
					<li style="width:90%;float:left;"><a href="#" onclick="goView()">상세정보</a></li> 
				</ul>
			</td>
		</tr>
		</table>
	</div>

</body>
</html>