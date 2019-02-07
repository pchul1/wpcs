<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html style="height:100%">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=0">
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="원터치 신고" name="title"/>
</jsp:include>
<!-- 실서버-->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=3728760A-A99F-39F6-96C8-74746BA4A738"></SCRIPT>	 -->
<!--  ????  -->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=C4246B58-A669-3643-A7FD-F545A61ECE20"></SCRIPT>    -->
<!-- 210.99.81.159:9090-->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=4EA77A23-29BC-37C9-A4EE-D3BCABCD9846"></SCRIPT> -->
<SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=C4246B58-A669-3643-A7FD-F545A61ECE20"></SCRIPT>	
<script type="text/javascript" src="/js/mobile/Vworld.js?accca32"></script>
<script type="text/javascript">
	
var x = "";
var y ="";
var message;

$(function(){
	phoneNum();
});

function firststep(){
	if(confirm("신고 하시겠습니까?")){
	    var options = null;
	    
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
	}
}

function show_error(error){
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

var timestatus = 0;
function start(){
	if(x != ""){
		
		PointToAddr_Onetouch(x,y);
	}else if(timestatus <= 11){
		timestatus++;
		setTimeout("start()", 1000);
	}else{
		alert(message);
		timestatus = 0;
	}
}

function initialize(position) {  
	x = position.coords.latitude;
	y = position.coords.longitude;
	$("#latiude").val(x);
	$("#longituded").val(y);
}
  
function Pointmessage(n){
	$("#latiude").val(x);
	$("#longituded").val(y);
	$("#address").val(n);
	document.frm1.submit();
}

function phoneNum(){
	userPhone = sessionStorage.userPhone.replace("+82","0");
	$("#reporterTelNo").val(userPhone);
}
function logout(){
	if(confirm('로그아웃 하시겠습니까?')){
		location.href = "/mobile/actionLogout.do";
	} else{
		return false;
	}
}
</script> 
</head>
<body style="height:100%">
<form action="OnetouchStatement.do" method="post" name="frm1" enctype="multipart/form-data">

	<input type="hidden" name="smsMsg" id="smsMsg">
	<input type="hidden" name="wpContent" id="wpContent" value="모바일 원터치 수질오염신고">
	<input type="hidden" name="longituded" id="longituded">
	<input type="hidden" name="latiude" id="latiude">
	<input type="hidden" name="address" id="address">
	<input type="hidden" name="reporterTelNo" id="reporterTelNo">
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div style="position:relative;width:100%;height:100%;" id="wrap">
		<div class="toolbar">
			<table style="width:100%">
				<c:if test="${empty Login}">
				<tr>
					<td align="left" width="33%"><a href="tel:1666-0128"><span style="top:1px;position:relative;"><img src="/images/mobile/main/phone.png" border="0"/></span> 신고전화</a></td>
					<td align="center" width="33%"><a href="/mobile" style="font-size:15px;color:#fff;">원터치 신고</a></td>
					<td align="right" width="33%"><a href="/mobile/login.do"><span style="top:0px;position:relative;"><img src="/images/mobile/main/login_icon.png" border="0"/></span> <span style="top:-1px;position:relative;color:white;">로그인</span></a></td>
				</tr>
				</c:if>
				<c:if test="${!empty Login}">
				<tr>
					<td align="left" width="33%"><a id="menu_open" href="javascript:history.back();"><img src="/images/mobile/prev.png" border="0"/></a></td>
					<td align="center" width="33%"><a href="/mobile" style="font-size:15px;color:#fff;">원터치 신고</a></td>
					<td align="right" width="33%"><a href="#" onclick="logout(); return false;"><span style="top:2px;position:relative;"><img src="/images/mobile/main/login_icon.png" border="0"/></span> <span style="color:white;">로그아웃</span></a></td>
				</tr>
				</c:if>
			</table>
		</div>
		<div style="margin:10px;height:50%">
			<div style="font-size:20px;height:70px;font-weight:bold;">개인정보 수집·이용 동의</div>
			<div style="height:60px;">수집주체 : 한국환경공단</div>
			<div style="height:60px;">수집목적 : 개인정보 제공에 동의하실 경우, 사고발생시 신고자 및 사고위치에 대한 정보가 수질오염방제정보시스템 사고현황에 자동으로 입력됩니다.(신고자 정보는 시스템 관리자만 접근 가능함)</div>
			<div style="height:60px;">수집항목 : 신고자 성명, 신고위치, 연락처</div>
			<div style="height:60px;">보유 및 이용기간 : 준영구(파기 요청시까지)</div>
			<div style="height:60px;">기타 : 본 개인정보 수집·이용에 대한 동의를 거부할 수 있으며, 동의하지 않을 경우 수질오염방제정보시스템 사고현황 신고자 정보는 익명으로 처리됩니다.</div>
			<div style="height:40px;">본 서비스 이용을 위한 개인정보제공에 동의하십니까?</div>
		</div>
		<div class="write" style="margin-bottom:10px;">
			<table summary="접수정보" style="text-align:left">
				<colgroup> 
					<col width="90px" /> 
					<col width="*" /> 
				</colgroup>
				<tr>
					<th>파일첨부</th>
					<td>
						<input align="top" id="fileData" name="fileData" type="file"/>
					</td>
				</tr>
			</table>
		</div>
		<div style="float:left; width:50%;text-align:center;">
			<ul class="sbtn"> 
				<li style="width:90%"><a href="#" onclick="history.back(); return false;">취소</a></li>
			</ul>
		</div>
		<div style="float:left; width:50%;text-align:center;">
			<ul class="sbtn">
				<li style="width:90%"><a href="#" onclick="firststep(); return false;">확인</a></li>
			</ul>
		</div> 
	</div>
</form>
<jsp:include page="/WEB-INF/jsp/mobile/common/bottom.jsp"/>
</body>
</html>