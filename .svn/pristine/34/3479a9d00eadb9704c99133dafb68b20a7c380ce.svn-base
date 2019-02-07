<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html xmlns="http://www.w3.org/1999/xhtml" style="height:100%;">
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="사고관리" name="title"/>
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

function show_error(error){
	var message;
	switch(error.code) { 
		case error.PERMISSION_DENIED: 
			message="설정메뉴에서 위치정보 사용을 승인하신 후 다시 시도해 주세요." 
			break; 
		case error.POSITION_UNAVAILABLE: 
			message="일시적으로 내위치를 확인할 수 없습니다. 사용기기의 '위치정보' 사용 설정을 확인해 주시기 바랍니다." 
			break; 
		case error.TIMEOUT: 
			message="일시적으로 내위치를 확인할 수 없습니다. 사용기기의 '위치정보' 사용 설정을 확인해 주시기 바랍니다."
			break; 
		case error.UNKNOWN_ERROR: 
			message="기타 에라" 
			break; 
	} 
}

function map_start_function(){
	
	<c:if test="${empty X}">
		if (navigator.geolocation) {
			  navigator.geolocation.getCurrentPosition(initialize, show_error,{maximumAge:Infinity, timeout:10000, enableHighAccuracy: true});
			  navigator.geolocation.getCurrentPosition(initialize, show_error,{maximumAge:Infinity, timeout:10000, enableHighAccuracy: false});
			  navigator.geolocation.getCurrentPosition(initialize, show_error,{maximumAge:0, timeout:10000, enableHighAccuracy: true});
			  navigator.geolocation.getCurrentPosition(initialize, show_error,{maximumAge:0, timeout:10000, enableHighAccuracy: false});
			  navigator.geolocation.getCurrentPosition(initialize, show_error,{maximumAge:10000, timeout:10000, enableHighAccuracy: true});
			  navigator.geolocation.getCurrentPosition(initialize, show_error,{maximumAge:10000, timeout:10000, enableHighAccuracy: false});
			  

			  navigator.geolocation.getCurrentPosition(initialize, show_error,{timeout:10000});
			  navigator.geolocation.getCurrentPosition(initialize, show_error,{timeout:10000});
			  navigator.geolocation.getCurrentPosition(initialize, show_error,{timeout:10000,enableHighAccuracy: true});
			  navigator.geolocation.getCurrentPosition(initialize, show_error,{timeout:10000,enableHighAccuracy: false});

			  navigator.geolocation.getCurrentPosition(initialize, show_error,{maximumAge:10000,enableHighAccuracy: false});
			  navigator.geolocation.getCurrentPosition(initialize, show_error,{maximumAge:10000,enableHighAccuracy: true});
			  navigator.geolocation.getCurrentPosition(initialize, show_error,{maximumAge:0,enableHighAccuracy: false});
			  navigator.geolocation.getCurrentPosition(initialize, show_error,{maximumAge:0,enableHighAccuracy: true});
			  navigator.geolocation.getCurrentPosition(initialize, show_error,{maximumAge:Infinity,enableHighAccuracy: false});
			  navigator.geolocation.getCurrentPosition(initialize, show_error,{maximumAge:Infinity,enableHighAccuracy: true});
			  

			  navigator.geolocation.getCurrentPosition(initialize, show_error,{maximumAge:10000,timeout:10000});
			  navigator.geolocation.getCurrentPosition(initialize, show_error,{maximumAge:0,timeout:10000});
			  navigator.geolocation.getCurrentPosition(initialize, show_error,{maximumAge:Infinity,timeout:10000});
		  setTimeout("start()", 1000);
		}
		
	</c:if>
	<c:if test="${!empty X}">
		start("");
	</c:if>
}

var layer_marker = null;

var x = "";
var y ="";
function initialize(position){
	x = position.coords.latitude;
	y = position.coords.longitude;
}

var timestatus = 0;
function start() {
	if('<c:out value="${X}"/>' != ''){
		x = '<c:out value="${X}"/>';
		y = '<c:out value="${Y}"/>';
	}
	
	if(x != ""){
		var value = {};
		value.x = x;
		value.y = y;
		setValue(value);
		  
		var point = GoogleToVworld(x, y);
		layer_marker = addMarker(point.x,point.y,"현재위치");
		map.setCenterAndZoom(point.x, point.y, 13);
		click_start();

	}else if(timestatus <= 11){
		timestatus++;
		setTimeout("start()", 1000);
	}else{
		if(message != ""){
			alert(message);	
			timestatus = 0;
		}
	}
}

function click_start(){
	//화면 클릭시 맵 마커 생성
	var pointOptions = {persist:true}
	markerControl = new OpenLayers.Control.Measure(OpenLayers.Handler.Point,{handlerOptions:pointOptions});
	markerControl.events.on({"measure": mapclick});
	map.addControl(markerControl);
	map.init();
    markerControl.activate();
}


function mapclick(event){
	if(layer_marker != null){
		layer_marker.hide();
	}
	map.init();	
	var temp = event.geometry;	
	var pos = new OpenLayers.LonLat(temp.x, temp.y);
	
	layer_marker = addMarker(pos.lon, pos.lat,"오류신고지역입니다.");
	var point = VworldToGoogle(pos.lon, pos.lat);
	
	setValue(point);
	click_start();
}

function setValue(point){
	$("#map_x").val(point.x);
	$("#map_y").val(point.y);
}

function form_submit(){
	var map_x = $('#map_x').val();
	var map_y = $('#map_y').val();
	if(!map_x){alert('위치를 지정해주세요.');return;}

	PointToAddr(map_x,map_y);
	//document.form1.submit();
}

function Pointmessage(addr){
	$('#addr').val(addr);
	var map_x = $('#map_x').val();
	var map_y = $('#map_y').val();
	  
	$(parent.document).find("#latiude").val(map_x);
	$(parent.document).find("#longituded").val(map_y);
	$(parent.document).find("#address").val(addr);
	window.parent.popupClose();
}
</script>
</head>
<body style="height:100%;">
	<form name="form1" method="post">
		<input type="hidden" id="map_x" name="map_x" value=""/> 
		<input type="hidden" id="map_y" name="map_y" value=""/>
		<input type="hidden" id="addr" name="addr" value=""/>
	</form>
	<div id="registmap" style="height:100%;"> 
		
		<div id="mapcanvas" style="width:100%; height:80%;z-index:100;"> 
			<div id="map_canvas" style="width:100%; height:100%;"></div> 
		</div> 
	
		<div style="width:100%;text-align:center;margin-top:10px;">
			<ul class="sbtn" style="width:100%"> 
				<li style="width:90%">
					<a href="#" onclick="form_submit(); return false;">위치 반영</a> 
				</li> 
			</ul>
		</div>
	</div>
</body>
</html>