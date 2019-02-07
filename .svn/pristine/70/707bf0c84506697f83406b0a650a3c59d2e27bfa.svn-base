<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * @Class Name : weatherinfo.jsp
	 * @Description : 기상예보이력 화면
	 * @Modification Information
	 * 
	 * 수정일				수정자			수정내용
	 * ----------		--------	---------------------------
	 * 2010.05.17		khany		최초 생성
	 * 2013.10.20		lkh			리뉴얼
	 * 2014.11.17  mypark    그리드 걷어내고 테이블 처리
	 * 
	 * author khany
	 * since 2010.05.17
	 * 
	 * Copyright (C) 2010 by khany All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>
<title>한국환경공단 수질오염 방제정보 시스템</title>
<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<script type="text/javascript">
//<![CDATA[
	var memFactCode = "${member.factCode}";
	var memRiverDiv = "${member.riverId}";
	var initSelectRiver = "${param.riverDiv}";
	var firstFlag = false;

	$(function () {
		setDate();
		
		if(initSelectRiver != null && initSelectRiver != "")
			$("#sugye > option[value="+initSelectRiver+"]").attr("selected", "true");
		
	// 	set_User_deptNo(user_dept_no, "sugye");
		selectedSugyeInMemberId(user_riverid , 'sugye');
	
		//시공사일경우 해당 공구만 선택할 수 있게
		if(memFactCode != null && memFactCode != "") {
			$("#sys > option[value=T]").attr("selected", "true");
			$("#sys").attr("disabled", "disabled");
			
			$("#sugye > option[value="+memRiverDiv+"]").attr("selected", "true");
			$("#sugye").attr("disabled", "disabled");
		}
		
		adjustGongku();

		$('#sys').change(function(){
			adjustGongku();
		});
		
		$('#sugye').change(function(){
			adjustGongku();
		});
		
		$('#factCode').change(function(){
			adjustBranchList();
		});
		
		//reloadData();
		
	});
	
	function setDate(){
		//초기 시작값의 현재 시각 선택
		var date = new Date();
		var hour = date.getHours();
		time=hour<10?"0"+hour:hour;
// 		t_time = hour-2>0?hour-2:0;
		t_time = "00";
		fritime=t_time<10?"0"+t_time:t_time;
		$("#toTime option[value="+time+"]").attr("selected", "true");
		$("#frTime option[value="+fritime+"]").attr("selected", "true");
		
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
			buttonText: '시작일'
			
		});
		$("#endDate").datepicker({
			buttonText: '종료일'
		});
				
		var today = new Date(); 
		var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 12);
	
		yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());
		today = today.getFullYear()+ "/" + addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
	
		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}
	
		$("#startDate").val(yday);
		$("#endDate").val(today);
	}
	
	function sysChange() {
		var sys_kind = $("#sys").val();
		if(sys_kind == "all") {
			$("#branchNo>option:first").attr("selected", "true");
			$("#factCode>option:first").attr("selected", "true");
			
			$("#branchNo").attr("disabled", "disabled");
			$("#factCode").attr("disabled", "disabled");
		} else {
			$("#branchNo>option:first").attr("selected", "true");
			$("#factCode>option:first").attr("selected", "true");
			
			$("#branchNo").attr("disabled", false);
			$("#factCode").attr("disabled", false);
		}
		
		if(sys_kind == "U") {
			$("#branchNo").show();
			//2014-10-22 mypark 검색 기능 개선
			//$("#spanBranch").show();
			$("#spanBranch").hide();
			$("#factCode").hide();
		} else {
			$("#branchNo").hide();
			$("#spanBranch").hide();
			//2014-10-22 mypark 검색 기능 개선
			$("#factCode").show();
		}
	}

	function adjustGongku() {
		//var sugyeCd = $('#sugye').val();
		//var sys_kind = $("#sys").val();
		
		var sugyeCd = $('#sugye').val();
		var sys_kind = $("#sys").val();
		
		var dropDownSet = $('#factCode');
		var dropDownSet_branchNo = $('#branchNo');
		
		dropDownSet.attr("style", "background:#ffffff;");
		
		if( sugyeCd == 'all' || sys_kind == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#factCode>option:first").attr("selected", "true");
			dropDownSet_branchNo.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");
			//dropDownSet.emptySelect();
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>", 
				{sugye:sugyeCd, system:sys_kind}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가
					if (data.gongku.length != 1) {
						dropDownSet.loadSelect_all(data.gongku);
					} else {
						dropDownSet.loadSelect(data.gongku);
						
						if (sys_kind == "U"){
							dropDownSet.attr("disabled", true);
							dropDownSet.attr("style", "background:#e9e9e9;");
						}
					}
					
					sysChange();
					
					if(memFactCode != null && memFactCode != "") {
						$("#factCode>option[value="+memFactCode+"]").attr("selected", "selected");
						$("#factCode").attr("disabled", "disabled");
					}
					
					adjustBranchList();
					
					if(memFactCode == 'all')  dropDownSet_branchNo.attr("disabled", true);
					
				} else {
					alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
	}
	
	//측정소 목록 가져오기
	function adjustBranchList() {
		var factCode = $('#factCode').val();
		var sys_kind = $("#sys").val();
		
		var dropDownSet = $('#branchNo');
		if( factCode == 'all' || sys_kind == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");
		}else{
			dropDownSet.attr("disabled", false);
			var url = "<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>";
			$.getJSON(url, {factCode:factCode}, function (data, status){
				if(status == 'success'){	 
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect_all(data.branch);
					
					$("#branchNo>option[value='"+data.branch[0].VALUE+"']").attr("selected", "selected");
					//$("#branchNo>option[value='"+branch+"']").attr("selected", "selected");
					
					if(!firstFlag) {
						reloadData();
						firstFlag = true;
					}
				} else {
					alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
	}
	
	function excelDown() {
		
		if( validation() == false ) return;
		
		var sugye = $("#sugye").val();
		var gongku = $("#factCode").val();
		var chukjeongso = $("#branchNo").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		var sys = $("#sys").val();
		
		var param = "river_div=" + sugye + "&factCode=" + gongku + "&branch_no=" + chukjeongso +
		"&frDate=" + frDate + "&toDate=" + toDate + "&frTime=" + frTime + "&toTime=" + toTime + 
		"&sys=" + sys + "&fcast_flag=N";
		
		location.href="<c:url value='/waterpolmnt/waterinfo/getWeatherInfoList_forExcel.do'/>?"+param;
	}
	
	function reloadData(pageNo){
		var imageFormatter = function (row, cell, value, columnDef, dataContext) {
			var vStr = getWeatherImgSrc(value);
			vStr = "<img src='"+vStr+"' />";
			return vStr;
		};
		
		if( validation() == false ) return;
		
		showLoading();
		
		var sugye = $("#sugye").val();
		var gongku = $("#factCode").val();
		var chukjeongso = $("#branchNo").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		var sys = $("#sys").val();
		
		var lately = $("#lately").is(":checked");
		var orderType1 = lately ? "desc" : "asc";
		
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getWeatherInfoList.do'/>",
			data:{river_div:sugye, 
					factCode:gongku,
					branch_no:chukjeongso,
					frDate:frDate,
					toDate:toDate,
					frTime:frTime,
					toTime:toTime,
					sys:sys,
					pageIndex:pageNo,
					orderType1:orderType1
				},
			dataType:"json",
			success:function(result){
				var tot = result['dataList'].length;
				var pageInfo = result['paginationInfo'];
				var dataHtml = "";
				if( tot <= 0 ){
					dataHtml="<tr><td colspan='13'>조회 결과가 없습니다.</td></tr>";
				} else {
					for(var i=0; i < tot; i++){
						var obj = result['dataList'][i];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						
						var factNumber = "";
						
						if(sugye == 'R01')
							factNumber = obj.factName.replace('한강', '');
						else if(sugye == 'R02')
							factNumber = obj.factName.replace('낙동강', '');
						else if(sugye == 'R03')
							factNumber = obj.factName.replace('금강', '');
						else if(sugye == 'R04')
							factNumber = obj.factName.replace('영산강','');
						
						if(obj.current_weather == null || obj.current_weather == "" || obj.current_weather == undefined)
							obj.current_weather = obj.weather_sky;
						
						var imgSrc = getWeatherImgSrc(obj.current_weather);
						
						obj.regionName = obj.regionName + "(" + factNumber+")";
						obj.temp = (obj.temp != null && obj.temp != '') ? obj.temp : '-';
						obj.humidity = (obj.humidity != null && obj.humidity != '') ? obj.humidity : '-';
						obj.rain_fall = (obj.rain_fall != null && obj.rain_fall != '') ? obj.rain_fall : '-';
						obj.snowcover = (obj.snowcover != null && obj.snowcover != '') ? obj.snowcover : '-';
						obj.wind_dir = (obj.wind_dir != null && obj.wind_dir != '') ? obj.wind_dir : '-';
						obj.wind_speed = (obj.wind_speed != null && obj.wind_speed != '') ? obj.wind_speed : '-';
						
						dataHtml +="<tr>";
						dataHtml += "<td>" + obj.no +"</td>";
						dataHtml += "<td>" + obj.river_name +"</td>";
						dataHtml += "<td>" + obj.regionName +"</td>";
						dataHtml += "<td>" + obj.branch_name +"</td>";
						dataHtml += "<td>" + obj.stationName +"</td>";
						dataHtml += "<td>" + obj.announce_time +"</td>";
						dataHtml += "<td>" + "<img src='"+imgSrc+"' />" +"</td>";
						dataHtml += "<td>" + obj.temp +"</td>";
						dataHtml += "<td>" + obj.humidity +"</td>";
						dataHtml += "<td>" + obj.rain_fall +"</td>";
						dataHtml += "<td>" + obj.snowcover +"</td>";
						dataHtml += "<td>" + obj.wind_dir +"</td>";
						dataHtml += "<td>" + obj.wind_speed +"</td>";
						dataHtml += "</tr>";
					}
				}
				
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				$("#dataList tr:odd").attr("class","even");
				
				// 페이징 정보
 				var pageStr = makePaginationInfo(result['paginationInfo']);
 				$("#pagination").empty();
 				$("#pagination").append(pageStr);
					
				$("#p_total_cnt").html("[총 " + result['totCnt'] + "건]");
				
				closeLoading();
			},
			error:function(result){
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null ) {
					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				
				var dataHtml="<tr><td colspan='13'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				closeLoading();
			}
		});
	}
	
	function validation(){
		if( $('#startDate').val() == "" ){ alert("조회 시작일자를 선택하세요"); return false; }
		if( $('#endDate').val() == "" ){ alert("조회 종료일자를 선택하세요"); return false; }
		if(!timeCheck()) {return false;}
	}
	
	function timeCheck() {
		var stdt = document.getElementById("startDate");
		var endt = document.getElementById("endDate");
		
		if(stdt.value == endt.value) {
			var frTime = $("#frTime").val();
			var toTime = $("#toTime").val();
			
			if(frTime > toTime) {
				alert("조회 종료시간이 시작시간보다 빠릅니다.\n\n다시 입력해 주십시오.");
				$("#frTime").val("");
				$("#toTime").val("");
				$("#frTime").focus();
				
				return false;
			}
		}
		
		return true;
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
		
		timeCheck();
	}
	
	//숫자만 입력했을때 자동완성을 위한 함수
	// 1. 8자리 체크
	// 2. 1000 년이후 체크
	// 3. 월 체크
	// 4. 일 체크
	function commonWork2(dateValue, inputId){
		var returnValue = "";
		var checkNum = "";
		
		for(var i=0 ; i<dateValue.length ; i++){
			var checkCode = dateValue.charCodeAt(i);
			
			//숫자로만 이루어져 있는지 여부 체크.
			if( checkCode >= 48 && checkCode <= 57 ){
				checkNum	= "true";
			}else{
				returnValue = "false";
				checkNum	= "false";
				break;
			}
		}
		
		//숫자로만 이루어져 있다면.
		if(checkNum == "true"){
			if( dateValue.length != 8){ //8자리가 아니면 false;
				returnValue = "false";
			}else{
				
				//년 비교
				if( !(1000 < Number(dateValue.substr(0,4)) && Number(dateValue.substr(0,4)) <= 9999 )){
					returnValue = "false";
				}else{
					var month = ["01","02","03","04","05","06","07","08","09","10","11","12"];
					var monthCheck = 'false';
					
					for(var j=0 ; j < month.length ; j++){
						if(Number(dateValue.substr(4,2)) == month[j]){
							monthCheck = 'true';
							break;
						}
					}
					
					//월 비교 통과했다면.
					if(monthCheck == 'true'){
						var day = ["01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23","24","25","26","27","28","29","30","31"];
						var dayCheck = 'false';
						
						for(var k=0 ; k < day.length ; k++){
							if(Number(dateValue.substr(6,2)) == day[k]){
								dayCheck = 'true';
								break;
							}
						}
						
						//일체크를 통과했다면.
						if(dayCheck == 'true'){
							var tempVar = dateValue.substr(0,4) + '/' + dateValue.substr(4,2) + '/' + dateValue.substr(6,2);
							document.getElementById(inputId).value = tempVar;
							returnValue = 'true';
						}else{
							returnValue = "false";
						}
						
					}else{
						returnValue = "false";
					}
				}
			}	
		}
		return returnValue;
	}

	// 페이지 번호 클릭	
	function linkPage(pageNo){
		reloadData(pageNo);
	} 

	function excelUploadPopup() {
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 145;
		var winWidth = 553;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-20;
		var height = winHeight-20;
		
		window.open("<c:url value='/waterpolmnt/waterinfo/goExcelUpload.do'/>", 
				'excelUploadPopup','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}


	function getWeatherImgSrc(code) {
		var src = "<c:url value='/images/content/'/>"
			switch(code) {
			case "맑음" : 
				src += "NB01.png";
				break;
			case "구름조금" :
				src += "NB02.png";
				break;
			case "진눈개비끝":
			case "소나기 끝":
			case "구름많음" :
				src += "NB03.png";
				break;
			case "소낙눈 끝":
			case "눈 끝남" :
			case "비 끝남" : 
			case "흐림" :
				src += "NB04.png";
				break;
			case "소나기" :
				src += "NB05.png";
				break;
			case "뇌우끝,비" :
			case "약한비단속" :
			case "약한비계속" :
			case "보통비계속" :
			case "보통비단속" :
			case "구름조금 비" :
			case "구름많음 비" :
			case "약한이슬비":
			case "보통이슬비":
			case "보통소나기":
			case "약한소나기":
			case "이슬비 끝":
			case "흐림 비":
			case "비" :
				src += "NB08.png";
				break;
			case "약한눈단속" :
			case "약한눈계속" :
			case "보통눈계속" :
			case "보통눈단속" :
			case "구름조금 눈":
			case "구름많음 눈":
			case "흐림 눈":
			case "눈" :
				src += "NB11.png";
				break;
			case "약진눈개비":
			case "강진눈개비":
			case "구름조금 비/눈":
			case "구름많음 비/눈":
			case "흐림 비/눈":
			case "비 또는 눈" : 
				src += "NB12.png";
				break;
			case "눈 또는 비" : 
				src += "NB13.png";
				break;
			case "뇌우" :
			case "천둥번개" : 
				src += "NB14.png";
				break;
			case "안개강해짐" :
			case "안개변화무" :
			case "안개 끝" :
			case "안개" :
				src += "NB15.png";
				break;
			case "박무" :
				src += "NB17.png";
				break;
			case "황사" :
				src += "NB16.png";
				break;
			case "안개엷어짐":
			case "연무" :
				src += "NB18.png";
				break;
			default :
				src += "NB01_N.png";
				break;
			}

		return src;
	}
//]]>
</script>

</head>
<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="wrap">
	
		<!-- Head Start-->
		<div id="header">
			<c:import url="/common/menu/header.do" />
		</div>
		<!-- Head End-->
		
		<!-- Body Start-->
		<div id="container">
			<div id="content_wrapper">
				
				<!--left menu Start-->
				<c:import url="/common/menu/left.do" />
				<!--left menu End-->
				
				<!-- Content Start-->
				<div id="content">
					
					<!-- navi, tab menu Start-->
					<c:import url="/common/menu/navi.do" />
					<!-- navi, tab menu End-->
					
					<!--tab Contnet Start-->
					<div class="tab_container">
					
					<!-- 하천 수질 조회 -->
					<form:form commandName="weatherInfoVO" name="listFrm"  id="listFrm" method="post">
						<input type="hidden" name="pageIndex" id="pageIndex" value="${searchTaksuVO.pageIndex}"/>
						<input type="hidden" name="branch_no" id="chukjeongso"/>
						<input type="hidden" name="factCode" id="gongku"/>
						<input type="hidden" name="sugye" id="river_div"/>
						<input type="hidden" name="frDate" id="frDate"/>
						<input type="hidden" name="toDate" id="toDate"/>
						
						<div class="searchBox dataSearch">
							<ul>
								<li>
									<span class="fieldName">시스템</span>
									<select class="fixWidth13" id="sys" name="sys">
											<option value="U" selected="selected">이동형측정기기</option>
<!-- 											<option value="T">탁수모니터링</option> -->
											<option value="A">국가수질자동측정망</option>
									</select>
								</li>
								<li>
									<span class="fieldName">측정소 위치</span>
									<select class="fixWidth7"  id="sugye">
										<option value="R01" selected="selected">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
									<span>&gt;</span>
									<select class="fixWidth11"  id="factCode">
										<option value="all">전체</option>
									</select>
									<span id='spanBranch' style="display:none">&gt;</span>
									<select class="fixWidth11" id="branchNo" name="branchNo" disabled="disabled" style="display:none">
										<option value="all">전체</option>
									</select>
								</li>
								
								<li>
									<span class="fieldName">조회기간</span>
									<input type="text" size="13" id="startDate" name="startDate" onchange="commonWork()"/>
									<select id="frTime" name="frTime" onchange="commonWork()">
										<option value="00">00</option>
										<option value="01">01</option>
										<option value="02">02</option>
										<option value="03">03</option>
										<option value="04">04</option>
										<option value="05">05</option>
										<option value="06">06</option>
										<option value="07">07</option>
										<option value="08">08</option>
										<option value="09">09</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
										<option value="13">13</option>
										<option value="14">14</option>
										<option value="15">15</option>
										<option value="16">16</option>
										<option value="17">17</option>
										<option value="18">18</option>
										<option value="19">19</option>
										<option value="20">20</option>
										<option value="21">21</option>
										<option value="22">22</option>
										<option value="23">23</option>
									</select>
									<span>~</span>
									<input type="text" size="13" id="endDate" name="endDate" onchange="commonWork()"/>
									<select id="toTime" name="toTime" onchange="commonWork()">
										<option value="00">00</option>
										<option value="01">01</option>
										<option value="02">02</option>
										<option value="03">03</option>
										<option value="04">04</option>
										<option value="05">05</option>
										<option value="06">06</option>
										<option value="07">07</option>
										<option value="08">08</option>
										<option value="09">09</option>
										<option value="10">10</option>
										<option value="11">11</option>
										<option value="12">12</option>
										<option value="13">13</option>
										<option value="14">14</option>
										<option value="15">15</option>
										<option value="16">16</option>
										<option value="17">17</option>
										<option value="18">18</option>
										<option value="19">19</option>
										<option value="20">20</option>
										<option value="21">21</option>
										<option value="22">22</option>
										<option value="23" selected="selected">23</option>
									</select>
<!-- 									<label>&nbsp;최근 <input type="checkbox" name="lately" id="lately" checked="checked"/></label> -->
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
						</div>
						</form:form>
						<!-- //하천 수질 조회 -->
						
						<div id="btArea">
							<span id="p_total_cnt">[총 ${totCnt}건]</span>
							<input type="button" id="btnBasic" name="btnBasic" class="btn btn_excel" onclick="javascript:excelDown()" />
						</div>
						<div class="table_wrapper">
							<table summary="게시판 목록. 번호, 수계,측정소명, 경보발생시간, 경보단계, 경보내용가 담김">
								<colgroup>
									<col width="40" />
									<col width="70" />
									<col width="105" />
									<col width="80" />
									<col width="80" />
									<col width="120" />
									<col width="60" />
									<col width="80" />
									<col width="80" />
									<col width="80" />
									<col width="80" />
									<col width="80" />
									<col width="95" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">No</th>
										<th scope="col">수계</th>
										<th scope="col">지역</th>
										<th scope="col">측정소</th>
										<th scope="col">측정  위치</th>
										<th scope="col">발표시간</th>
										<th scope="col">날씨</th>
										<th scope="col">기온(℃)</th>
										<th scope="col">습도(%)</th>
										<th scope="col">강우량(mm)</th>
										<th scope="col">적설량(cm)</th>
										<th scope="col">풍향</th>
										<th scope="col">풍속(km)</th>
									</tr>
								</thead>
								<tbody id="dataList">
								</tbody>
							</table>
 							<div class="paging">
								<div id="page_number">
									<ul class="paginate" id="pagination"></ul>
								</div>
							</div>
						</div>
					</div>
					<!--tab Contnet End-->
				</div>
				<!-- Content End-->
			</div>
		</div>
		<!-- Body End-->
		
		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
	</div>
</body>
</html>