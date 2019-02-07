<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pj" uri="ProjectJstlUtil"%>
<html style="height:100%;">
<head>
<!-- 실서버-->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=3728760A-A99F-39F6-96C8-74746BA4A738"></SCRIPT>	 -->
<!--  ????  -->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=C4246B58-A669-3643-A7FD-F545A61ECE20"></SCRIPT>    -->
<!-- 210.99.81.159:9090-->
<!-- <SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=4EA77A23-29BC-37C9-A4EE-D3BCABCD9846"></SCRIPT> -->
<SCRIPT language="JavaScript" type="text/javascript" src="http://map.vworld.kr/js/vworldMapInit.js.do?apiKey=C4246B58-A669-3643-A7FD-F545A61ECE20"></SCRIPT>	
<script language="javascript" type="text/javascript" src="/js/mobile/Vworld.js"></script>
<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<link rel="stylesheet" type="text/css" href="<c:url value='/gis/css/gis_style.css'/>"/>
<style type="text/css">
.nogood { color: red }
.good{ color: green } 
.device{ color: blue } 
</style>
<script type="text/javascript" charset="utf-8">
$(function(){
	vworldInit("map_canvas");
	goTime();
});

function map_start_function(){
	<c:forEach items="${resultList }" var="item">
	point = GoogleToVworld('${item.latitude1}', '${item.longitude1}');
	createMarkerNotCenter(point.x,point.y,"<c:out value="${item.branch_name}"/>");
	</c:forEach>
	map.setCenterAndZoom(map.getCenterXY().cx, map.getCenterXY().cy, 8);
	
	$(".olAlphaImg").on("mouseover",function(){
		$(".olPopup").css("display","none");
		$(this).trigger('click');
	});
};

function goTime(){
	$.datepicker.setDefaults({
		monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
		dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
		showMonthAfterYear:true,
		dateFormat: 'yy/mm/dd',
		showOn: 'both',
		buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
		buttonImageOnly: true
	});
	
	$("#startDate").datepicker({
		buttonText: '조회일자'
	});
	
	$("#endDate").datepicker({
		buttonText: '조회일자'
	});
	
	var today = new Date(); 
	today = today.getFullYear()+"/"+ addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
	
	var today2 = new Date(); 
	today2 = today2.getFullYear()+"/"+ addzero(today2.getMonth()+1) + "/01" ;
	
	//var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 24);
	//yday = yday.getFullYear()+ addzero(yday.getMonth()+1) + addzero(yday.getDate());
	
	//날짜 초기값 Setting	
	$("#startDate").val(today2);
	$("#endDate").val(today);
}

function addzero(n) {
	return n < 10 ? "0" + n : n + "";
}


function commonWork() {
	var stdt = document.getElementById("startDate");
	var endt = document.getElementById("endDate");
	var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;
	
	if(stdt.value !=''){
		if(dateCheck.test(stdt.value)!=true){
			
			var returnValue = commonWork2(stdt.value, "startDate");
			
			//숫자만 입력 체크를 통과못하면.
			if(returnValue != 'true'){
				alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
				stdt.value = "";
				stdt.focus;
				return false;
			}
		}
	}
	if(endt.value !=''){
		if(dateCheck.test(endt.value)!=true){
			
			var returnValue = commonWork2(endt.value, "endDate");
			
			//숫자만 입력 체크를 통과못하면.
			if(returnValue != 'true'){
				alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
				endt.value = "";
				endt.focus;
				return false;
			}
		}
	}
	
	if(endt.value != '' && stdt.value > endt.value) {
		alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
		stdt.value = "";
		endt.value = "";
		stdt.focus();
	}
}

function fnGoDetail(X,Y){
	var point = GoogleToVworld(X,Y);
	setCenterAndZoom(point.x,point.y);
}
</script>
</head>
<body style="height:100%;margin:0;overflow: hidden;">
<div class="mapBxTm" style="height:100%;margin:0;">
	<div id="ipusnmap" style="height:100%;"> 
		<div id="map_canvas" style="height:100%;"> 
		</div> 
	</div>
	<div id="search_result">
		<div id="resultToggle" style="margin-left: 593px;">
			<img src="/images/renewal2/toggle_bin.png" alt="닫기" />
		</div>
		<div id="result">
			<div id="resultDiv" style="overflow-x: scroll; overflow-y: scroll; width: 703px; height: 205px;">
				<table>
					<colgroup>
						<col width="60" />
						<col width="100" />
						<col width="120" />
						<col width="60" />
						<col width="60" />
						<col width="70" />
						<col width="150" />
						<col width="120" />
						<col width="250" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">No.</th>
							<th scope="col">수계</th>
							<th scope="col">지점명</th>
							<th scope="col">온도</th>
							<th scope="col">습도</th>
							<th scope="col">배터리</th>
							<th scope="col">접속시간</th>
							<th scope="col">위치</th>
							<th scope="col">장비상태</th>
						</tr>
					</thead>
					<tbody id="dataList">
					<c:forEach items="${resultList }" var="item" varStatus="count">
						<tr>
							<td align="center"><a href="#" onclick="fnGoDetail('${item.latitude1}', '${item.longitude1}'); return false;">${count.count}</a></td>
							<td align="center"><a href="#" onclick="fnGoDetail('${item.latitude1}', '${item.longitude1}'); return false;">${item.river_div_name}</a></td>
							<td align="center"><a href="#" onclick="fnGoDetail('${item.latitude1}', '${item.longitude1}'); return false;">${item.branch_name}</a></td>
							<td align="center"><a href="#" onclick="fnGoDetail('${item.latitude1}', '${item.longitude1}'); return false;">${item.temperature}</a></td>
							<td align="center"><a href="#" onclick="fnGoDetail('${item.latitude1}', '${item.longitude1}'); return false;">${item.humidity}</a></td>
							<td align="center"><a href="#" onclick="fnGoDetail('${item.latitude1}', '${item.longitude1}'); return false;">${item.battery}</a></td>
							<td align="center"><a href="#" onclick="fnGoDetail('${item.latitude1}', '${item.longitude1}'); return false;">${item.input_time}</a></td>
							<td align="center"><a href="#" onclick="fnGoDetail('${item.latitude1}', '${item.longitude1}'); return false;"><c:out value='${pj:SelectIpUsnDistance(item.latitude1, item.longitude1, item.latitude2, item.longitude2, "M", item.gps_dist,"Y")}' escapeXml="false"/></a></td>
							<td align="center"><a href="#" onclick="fnGoDetail('${item.latitude1}', '${item.longitude1}'); return false;"><c:out value="${pj:SelectIpUsnstr(item.device_st)}"/></a></td>
						</tr>
					</c:forEach>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div> 
</body>
</html>