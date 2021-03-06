<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp"/>
<jsp:useBean id="toDay" class="java.util.Date" />
<style>
#mainalert {
  background: -webkit-linear-gradient(white, #EEEEEC); /* For Safari 5.1 to 6.0 */
  background: -o-linear-gradient(white, #EEEEEC); /* For Opera 11.1 to 12.0 */
  background: -moz-linear-gradient(white, #EEEEEC); /* For Firefox 3.6 to 15 */
  background: linear-gradient(white, #EEEEEC); /* Standard syntax */
} 

#mainalert > li {padding-left:3px;color:blue;}
#mainalert > li > span {position: relative; left: -2px;top:2px;color:#666666;}
</style>
<script type="text/javascript">

var main_alert_length = 0;
var main_location = 0;

$(function(){

	if('<c:out value="${dailyWorkAppCheck}"/>'=='Y'){
		if(confirm("결재대기 중인 문서가 있습니다.")){
			location.href= "/mobile/sub/dailywork/receiveApprovalList.do";
		}
	}
	<c:forEach items="${SeminarAlrimList}" var="item">
		if(confirm("[교육알림]\r\n<c:out value="${item.alrimTitle}"/>")){
			var link = "/mobile/sub/seminar/MySeminarScheduleList.do";
			goAlrimLink(link,'<c:out value="${item.alrimId}"/>','<c:out value="${item.alrimMenuId}"/>');
		}
	</c:forEach>
	
	$(".menu_close").on("click",function(){
		$(".mobile_menu").css("display","none");
	});
	$("#menu_open").on("click",function(){
		$(".mobile_menu").css("display","");
	});
	
// 	mainline();
// 	var timer = setInterval(function () {
//         mainline();
//     }, 3000);

	<c:if test="${!empty userPhone}">
	sessionStorage.userPhone = '<c:out value="${userPhone}"/>';
	</c:if>
});

function onetouchclick(){
	if(sessionStorage.userPhone == undefined){
		if(confirm('원터치 신고 기능은 모바일앱에서 이용가능합니다. 앱을 다운 받으시겠습니까?'))
		{
			location.href='/mobile/download/waterkoreaWeb.apk';
		}		
	}else{
		location.href="/mobile/onetouch/firststep.do";
	}
}

//2014-09-12 mypark 알림 기능 확인
function goAlrimLink(link, alrimId, menuId) {
	if (link.indexOf("#") < 0) {
		$.ajax({
			type: "POST",
			url: "<c:url value='/common/alrim/AlrimUnCofirmUpdate.do'/>",
			data: {alrimId:alrimId, menuId:menuId},	
			dataType:"text",
			success : function(result){
				if(result != null) {
					location.href=link;
				}
			}
		});
	}
}

function mainline(){
	$.ajax({
		url:'/psupport/jsps/getAlertXML.jsp',
		dataType:"text",
		success:function(result){
//			console.log("getAlertXML result : ",result)
			var data = JSON.parse(result);
			main_data(data);
		},
		error:function(result){
		}
	});
}

function main_data(data){
		var main_alert_length = data.length -1;
		var html = "";
		
		var obj = data[main_location];
		if(null != obj.ALERT_LEVEL)
		{
			if(obj.ALERT_LEVEL == '1')
				obj.LEVEL_TEXT = '관심';
			else if(obj.ALERT_LEVEL == '2')
				obj.LEVEL_TEXT = '주의';
			else if(obj.ALERT_LEVEL == '3')
				obj.LEVEL_TEXT = '경계';
			else if(obj.ALERT_LEVEL == '4')
				obj.LEVEL_TEXT = '심각';
			else if(obj.ALERT_LEVEL == 'M')
				obj.LEVEL_TEXT = '미수신';
			else if(obj.ALERT_LEVEL == 'C')
				obj.LEVEL_TEXT = '점검중';
			else if(obj.ALERT_LEVEL == 'L')
				obj.LEVEL_TEXT = '위치이탈';
			
			if(obj.SYS_KIND == 'A')
				obj.SYS_KIND_TEXT = '국가수질자동측정망';
			else if(obj.SYS_KIND == 'U')
				obj.SYS_KIND_TEXT = '이동형측정기기';
			
			html += '<li><span>측정장비 : '+obj.SYS_KIND_TEXT+' <span></li>'
					+ '<li><span>수신시간 : '+obj.ALERT_TIME+' </span></li>'
					+ '<li><span>측정소 : '+obj.FACT_NAME+' </span></li>'
					+ '<li><span>'+obj.ALERT_MSG+'</span></li>'
			$("#mainalert").html(html); 
		}
		++main_location;
		if(main_location == main_alert_length) main_location = 0;
			
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
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0">
<div id="home"> 
	<div class="toolbar">
		<table style="width:100%">
			<tr>
				<td align="left" width="33%"><a id="menu_open" style="cursor:pointer;"><img src="/images/mobile/main/menu_icon.png" border="0"/></a></td>
				<td align="center" width="33%"><a href='/mobile/main/main.do'><img src="/images/mobile/main/header_logo.png" border="0"/></a></td>
				<td align="right" width="33%"><a href="#" onclick="logout(); return false;"><span style="top:2px;position:relative;"><img src="/images/mobile/main/login_icon.png" border="0"/></span> <span style="color:white;">로그아웃</span></a></td>
			</tr>
		</table>
	</div> 
	<div class="mobile_menu" style="display:none;z-index:9999;">
		<ul><li class="title menu_close" style="cursor:pointer;">
		<div style="float:left;cursor:pointer;" class="menu_close"><img src="/images/mobile/main/menu_icon.png" border="0" style="margin:3px 0 0 1px;"/><a style="float:right;padding-top:17px;padding-left:20px;">전체메뉴</a></div>
		<a style="float:right;padding-top:12px;cursor:pointer;font-size:20px;" class="menu_close">X</a></li></ul>
		<ul><li><a href="/mobile/sub/water/watersearch.do">수질현황</a></li></ul>
		<ul><li><a href="/mobile/sub/alert/alertMngSearch.do">상황관리</a></li></ul>
		<ul><li><a href="/mobile/sub/waterpollution/waterPollutionSearch.do">사고관리(오염등록)</a></li></ul>
		<ul><li><a href="/mobile/sub/ipusn/ipusn/ipusnlist.do">이동형측정기기 위치</a></li></ul>
		<ul><li><a href="/mobile/sub/waterinfo/office/officesearch.do">유관기관조회</a></li></ul>
		<ul><li><a href="/mobile/sub/waterinfo/ecompany/ecompanysearch.do">방제업체조회</a></li></ul>
		<ul><li><a href="/mobile/sub/warehouse/ware/waresearch.do">방제창고조회</a></li></ul>
		<ul><li><a href="/mobile/sub/warehouse/item/itemsearch.do">방제물품현황</a></li></ul>
		<ul><li><a href="/mobile/sub/manual/manual.do">방제지침서</a></li></ul>
		<ul><li><a href="/mobile/sub/ipusn/location/ipusnsearch.do">측정소위치조회</a></li></ul>
		<ul><li><a href="/mobile/sub/dailywork/dailyWorkSearch.do">업무일지</a></li></ul>
		<ul><li><a href="/mobile/sub/seminar/SeminarScheduleSearch.do">교육관리</a></li></ul>
		<ul><li><a href="/mobile/sub/sms/smsRegist.do">SMS전송</a></li></ul>
		<ul><li><a href="/mobile/sub/manual/solution.do">현장공유솔루션</a></li></ul>
	</div>
	<div>
		<img src="/images/mobile/main/main.gif" width="100%"/>
	</div>
	
	<div class="mainbox100">
		<div style="padding:7px 7px 0 7px;" >
			<a href="#" onclick="onetouchclick(); return false;"><img src="/images/mobile/main/onetouch.gif"  border="0" width="100%"/></a>
		</div>
	</div>
	<div style="width:100%;overflow: hidden;">
		<div class="mainbox100">
			<div style="padding:7px;">
				<div style="width:25%;float:left;">
					<div>
						<a href="/mobile/sub/water/watersearch.do"><img src="/images/mobile/main/main_icon1.gif" border="0" width="100%"/></a>
					</div>
				</div>
				<div style="width:25%;float:left;">
					<div>
						<a href="/mobile/sub/waterpollution/waterPollutionSearch.do"><img src="/images/mobile/main/main_icon2.gif"  border="0" width="100%"/></a>
					</div>
				</div>
				<div style="width:25%;float:left;">
					<div>
						<a href="/mobile/sub/alert/alertMngSearch.do"><img src="/images/mobile/main/main_icon3.gif"  border="0" width="100%"/></a>
					</div>
				</div>
				<div style="width:25%;float:left;">
					<div>
						<a href="/mobile/sub/dailywork/dailyWorkSearch.do"><img src="/images/mobile/main/main_icon4.gif"  border="0" width="100%"/></a>
					</div>
				</div>
			</div>
		</div>
	</div>
<!-- 	<div class="mainbox100" style="padding:7px;overflow: hidden;" > -->
<!-- 		<div style="border:1px solid #CCCCCC;font-size:12px;padding:5px 3px 9px 3px;overflow: hidden;" id="mainalert"> -->
			
<!-- 		</div> -->
<!-- 	</div> -->
</div> 
<jsp:include page="/WEB-INF/jsp/mobile/common/bottom.jsp"/>
</body>
</html>