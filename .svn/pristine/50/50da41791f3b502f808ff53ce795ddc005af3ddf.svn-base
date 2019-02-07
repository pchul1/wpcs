<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
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
<script type="text/javascript" src="/js/mobile/Vworld.js"></script>
<script type="text/javascript" charset="utf-8">
$(function(){
	vworldInit("map_canvas");
});

function map_start_function(){
	point = GoogleToVworld('<c:out value="${View.latitude2}"/>', '<c:out value="${View.longitude2}"/>');
	createMarker(point.x,point.y,"<c:out value="${View.branch_name}"/>");
	
	var point = GoogleToVworld('<c:out value="${View.latitude1}"/>', '<c:out value="${View.longitude1}"/>');
	createMarker(point.x,point.y,"<c:out value="${View.branch_name}"/>");
};

function locationCenter(n){
	var point ;
	if(n == 1){
		point = GoogleToVworld('<c:out value="${View.latitude1}"/>', '<c:out value="${View.longitude1}"/>');
		setCenterAndZoom(point.x,point.y);
	}else{
		point = GoogleToVworld('<c:out value="${View.latitude2}"/>', '<c:out value="${View.longitude2}"/>');
		setCenterAndZoom(point.x,point.y);
	}
}

</script>
</head>
<body style="height:100%;">
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/ipusn/ipusn/ipusnlist.do" name="link"/>
		<jsp:param value="이동형측정기기 위치" name="title"/>
	</jsp:include>
	<div id="ipusnmap" style="height:100%;"> 
	    
		<div id="map_canvas" style="height:80%;z-index:100;"> 
		</div> 
		
		<div style="float:left; width:50%;text-align:center; margin-top:10px;">
			<ul class="sbtn"> 
				<li style="width:90%"><a href="#" onclick="locationCenter(1); return false;">현재위치</a></li> 
			</ul>
		</div>
		<div style="float:left; width:50%;text-align:center;margin-top:10px;">
			<ul class="sbtn">
				<li style="width:90%"><a href="#" onclick="locationCenter(2); return false;">설치위치</a></li>
			</ul>
		</div> 
		
		<div style="clear:both;width:100%;text-align:center;margin-top:10px;">
			<ul class="sbtn">  
				<li style="width:90%"><a href='<c:url value="/mobile/sub/ipusn/ipusn/UpdateIpUsnLocationSet.do?fact_code=${View.fact_code}&branch_no=${View.branch_no}&latitude=${View.latitude2}&longitude=${View.longitude2}"/>' onclick="return confirm('설치위치를 재설정 하시겠습니까?')">설치위치 재설정</a></li>
			</ul>
		</div> 
	</div> 

</body>
</html>