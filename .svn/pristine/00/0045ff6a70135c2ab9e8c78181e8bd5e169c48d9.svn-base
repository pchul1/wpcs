<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : waterlvlflux.jsp
	 * Description : 수위유량조회 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -----------	--------	---------------------------
	 * 2010.05.17	khany		최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 * 2014.11.17  mypark    그리드 걷어내고 테이블 처리
	 * 
	 * author khany
	 * since 2010.05.17
	 * 
	 * Copyright (C) 2010 by khany  All right reserved.
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
	var frDate = "<c:out value='${searchTaksuVO.frDate}'/>";
	var toDate = "<c:out value='${searchTaksuVO.toDate}'/>";
	var frTime = "<c:out value='${searchTaksuVO.frTime}'/>";
	var toTime = "<c:out value='${searchTaksuVO.toTime}'/>";
	
	var fact = "<c:out value='${searchTaksuVO.gongku}'/>";
	var sugye = 'R01';
	
	var item_1 = "<c:out value='${searchTaksuVO.item01}'/>";
	var item_2 = "<c:out value='${searchTaksuVO.item02}'/>";
	var item_3 = "<c:out value='${searchTaksuVO.item03}'/>";
	var item_4 = "<c:out value='${searchTaksuVO.item04}'/>";
	
	var dataView = null;
	var grid	 = null;
	var firstFlag = false;
	
	$(function () {		
		$("#sugye>option[value='"+sugye+"']").attr("selected", "selected");
		
		//user 수계에 따른 수계 고정
		selectedSugyeInMemberId(user_riverid , 'sugye');
		
		setDate();
		
		adjustGongku();
		
		$('#sugye').change(function(){
			adjustGongku();
		});
		
		$('#factCode').change(function(){
			setGraphBtn();
		});
				
		$("#legend").hide();
		$("#legendDetail").hide();
		
		//맵 처음 로드시 zoom
		firstZoom = 11;
		
	});
	
	//측정소가 전체가 아닐때만 그래프 버튼이 표시됩니다.
	function setGraphBtn() {
		if($('#factCode').val() == "all") {
			//$('#a_chartPopup').attr("href", "#");
			$("#a_chartPopup").css("display", "none");
			//$('#img_chartPopup').hide();
		} else {
			//$('#a_chartPopup').attr("href","javascript:chartPopup()");
			//$('#img_chartPopup').fadeIn('fast');
			$("#a_chartPopup").css("display", "block");
		}
	}
	
	function setDate() {
		//초기 시작값의 현재 시각 선택
		var date = new Date();
		var hour = date.getHours();
		
		//과학원 정보가 넘어오는 시간이 5시간정도 차이가 있음 2014.02.06
		t_time = hour-5>0?hour-5:0;
		time=hour<10?"0"+hour:hour;
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
		today = today.getFullYear()+ "/" + addzero(today.getMonth()+1) + "/" +addzero(today.getDate());
		
		function addzero(n) {
			return n < 10 ? "0" + n : n + "";
		}
		
		if(frDate != "" && frTime != "") {
			$("#startDate").val(frDate);
			$("#frTime>option[value='"+frTime+"']").attr("selected", "selected");
		} else {
			$("#startDate").val(yday);
		}
		
		if(toDate != "" && toTime != "") {
			$("#endDate").val(toDate);
			$("#toTime>option[value='"+toTime+"']").attr("selected", "selected");
		} else {
			$("#endDate").val(today);
		}
	}
	
	function adjustGongku() {
		var sugyeCd = $('#sugye').val();
		var dropDownSet = $('#factCode');
		
		if( sugyeCd == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#factCode>option:first").attr("selected", "true");
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getFlowFact.do'/>",
					{sugye:sugyeCd}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect(data.gongku);
					if(fact != "" ) {
						$("#factCode>option[value='"+fact+"']").attr("selected", "selected");
					} else {
						$("#factCode>option[value='"+data.gongku[0].VALUE+"']").attr("selected", "selected");
					}
					
					if(!firstFlag) {
						reloadData();
						firstFlag = true;
					}
					setGraphBtn();
					//adjustBranch();
				} else { 
					alert("지역 목록 가져오기 실패");
					return;
				}
			});
		}
	}
	
	//전체 수계의 값을 구해온다.
	function excelDown() {
		if( validation() == false ) return;
		var sugye = $("#sugye").val();
		var gongku = $("#factCode").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		var rType = $("#dataType").val();
		
		var param = "sugye=" + sugye + "&gongku=" + gongku +
				"&frDate=" + frDate + "&toDate=" + toDate + "&frTime=" + frTime + "&toTime=" + toTime +
				"&dataType=" + rType;
			
		location.href="<c:url value='/waterpolmnt/waterinfo/getFluxExcel.do'/>?"+param;
	}
	
	function chartPopup() {
		if( validation() == false ) return;
		
		var sugye = $("#sugye").val();
		var gongku = $("#factCode").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 506;
		var winWidth = 642;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-20;
		var height = winHeight-20;
		
		var rType = $("#dataType").val();
		
		var param = "sugye=" + sugye + "&gongku=" + gongku +
		"&frDate=" + frDate + "&toDate=" + toDate + "&frTime=" + frTime + "&toTime=" + toTime +
		"&dataType=" + rType + "&width=" + (winWidth-20) + "&height=" + (winHeight-40);
		
		//stats/getAccidentStatsChart.do
		window.open("<c:url value='/waterpolmnt/waterinfo/goFluxChart_popup.do'/>?"+encodeURI(param),
				'chartDetailViewRIVER','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function reloadData(pageNo){
		if( validation() == false ) return;
		
		showLoading(); 
		
		var sugye = $("#sugye").val();
		var gongku = $("#factCode").val();
		var sys = $("#sys").val();
		
		if(gongku == null || gongku == "unknowned")
			gongku = "all";
		if(sugye == null || sugye == "unknowned")
			sugye = "all";
		
		var rType = $("#dataType").val();
		
		if (pageNo == null) pageNo = 1;
		
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/waterinfo/getFlowData.do'/>",
			data: {gongku:gongku,
					sugye:sugye,
					frTime:frTime,
					toTime:toTime,
					frDate:frDate,
					toDate:toDate,
					pageIndex:pageNo
				},
			dataType:"json",
			success : function(result){
//  				console.log("결과 값 확인 : ",result);
				var tot = result['detailViewList'].length;
				var pageInfo = result['paginationInfo'];
				var dataHtml="";
				if( tot <= 0 ){
					dataHtml="<tr><td colspan='5'>조회 결과가 없습니다.</td></tr>";
					factClick(0,gongku);
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						
						obj.wl = (obj.wl != null && obj.wl != '') ? obj.wl : '-';
						obj.fw = (obj.fw != null && obj.fw != '') ? obj.fw : '-';
						var even = "";
						if(i%2 == 1){even = "even"}
						dataHtml +="<tr class='"+even+"' style='cursor:pointer;' onclick='factClick(" +i +", \"" + obj.fact_code+ "\")'>";
						dataHtml += "<td>" + obj.no +"</td>";
						dataHtml += "<td>" + obj.fact_name +"</td>";
						dataHtml += "<td>" + obj.rcv_date +"</td>";
						dataHtml += "<td>" + obj.wl +"</td>";
						dataHtml += "<td>" + obj.fw +"</td>";
						dataHtml += "</tr>";
					}
					
					factClick(0,result['detailViewList'][0].fact_code);
				}
				
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				// 페이징 정보
				var pageStr = makePaginationInfo(result['paginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);
				
				$("#p_total_cnt").html("총 " + result['totCnt'] + "건");
				
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
				var dataHtml="<tr><td colspan='5'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
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
	
	//페이지 번호 클릭
	function linkPage(pageNo){
		reloadData(pageNo);
	}
	
	//측정소 클릭시
	function factClick(idx, factCode) {
		$("#dataList tr td").removeClass("tr_on");
		$("#dataList tr:nth(" + idx + ") td").addClass("tr_on");
		chart(factCode);
		mapMove(factCode);
	}
	
	var lastLatitude = 0;
	var lastLongitude = 0;
	
	function mapMove(factCode) {
		// 추후 ARC GIS 공간검색으로 변경 되야 할듯
		$.getJSON("<c:url value='/waterpolmnt/waterinfo/getFlowFactLocation.do'/>", {fact_code:factCode}, function (data, status){
			if(status == 'success'){
				
				if(data['location'] == null) {
					$("#lblLocation").text("측정소 위치 (위치정보를 가져올 수 없습니다) ");
					return;
				}
				lastLatitude = data['location'].latitude;
				lastLongitude = data['location'].longitude;
				
				$kecoMap.model.moveCenter(lastLongitude, lastLatitude);
			} else {
				alert('위치정보를 가져올 수 없습니다.');
				return;
			}
		});
	}
	
	function chart_load() {
		$("#span_loading").css("display", "none");
	}
	
	function chart(factCode){
		$("#span_loading").show();
		var width = "480";
		var height = "230";
		document.listFrm.target = "chart";
		document.listFrm.gongku.value = factCode;
		document.listFrm.width.value = width;
		document.listFrm.height.value = height;
		document.listFrm.frDate.value = $("#startDate").val2();
		document.listFrm.toDate.value = $("#endDate").val2();
		document.listFrm.action = "<c:url value='/waterpolmnt/waterinfo/getFlowChart.do'/>";
		document.listFrm.submit();
	}
	
	var slideFlag = false;
	function slide() {
		if(!slideFlag) {
			$("#data_graph").css("height", "0px");
			$("#data_map").css("height", "501px");
			$("#map").css("height", "501px");
			
			setTimeout(function(){
				$kecoMap.view.map.resize();
				setTimeout(function(){$kecoMap.view.map.reposition();},500);
				}, 500);
			
			$("#pendingBtn").attr("src","<c:url value='/images/popup/btn_arrow_up.gif'/>");
			slideFlag = true;
		} else {
			$("#data_graph").css("height", "230px");
			$("#data_map").css("height", "271px");
			$("#map").css("height", "271px");
			
			setTimeout(function(){
				$kecoMap.view.map.resize();
				setTimeout(function(){$kecoMap.view.map.reposition();},500);
			}, 500);
			
			$("#pendingBtn").attr("src","<c:url value='/images/popup/btn_arrow_down.gif'/>");
			slideFlag = false;
		}
	}
	
	var lflag = false;
	
	function showLayerDiv() {
		lflag = !lflag;
		if(lflag) {
			$kecoMap.model.toolbaridx = 3
			$("#layerDiv").animate({bottom:1},500);
			setTimeout(function(){$("#layerDiv").show();}, 300);
		} else {
			$kecoMap.model.toolbaridx = -1
			$("#layerDiv").animate({bottom:-130},500);
			setTimeout(function(){$("#layerDiv").hide()}, 100);
		}
	}
	
// 	$(function () {
// 		setTimeout(function(){
// 			$('#11').attr('checked', true);
// 			$('#12').attr('checked', true);
// 			$kecoMap.model.updateLayerVisibility();
// 		}, 2000);
// 	});
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
						
						<!-- 그래프 데이터 전달용 Form -->
						<form:form commandName="searchTaksuVO" name="listFrm"  id="listFrm" method="post">
							<input type="hidden" name="pageIndex" id="pageIndex" value="${searchTaksuVO.pageIndex}"/>
							<input type="hidden" name="chukjeongso" id="chukjeongso"/>
							<input type="hidden" name="width"/>
							<input type="hidden" name="height"/>
							<input type="hidden" name="gongku" id="gongku"/>
							<input type="hidden" name="sugye" id="river_div"/>
							<input type="hidden" name="frDate" />
							<input type="hidden" name="toDate" />
							<div class="searchBox dataSearch">
							<ul>
								<li>
									<span class="fieldName">측정소 위치</span>
									<select class="fixWidth7" id="sugye">
										<option value="R01" selected="selected">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
									<span>&gt;</span>
									<select class="fixWidth11" id="factCode">
										<option value="all">전체</option>
									</select>
								</li>
								<li>
									<span class="fieldName">조회기간</span>
									<input type="text" id="startDate" name="startDate" value="<c:out value='${searchTaksuVO.frDate}'/>" onchange="commonWork()" size="13" alt="조회시작일"/>
									<select id="frTime" name="frTime" onchange="commonWork()" style="width:45px">
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
									<input type="text" id="endDate" name="endDate" value="<c:out value='${searchTaksuVO.toDate}'/>" onchange="commonWork()" size="13" alt="조회종료일"/>
									<select id="toTime" name="toTime" style="width:45px" onchange="commonWork()">
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
								</li>
								<!-- <li>
									<span>소항목</span>
									<ul class="checkList">
										<li id="sys0"><input type="checkbox" class="inputCheck" id="i1" checked="checked" /><label for="">유량</label></li>
										<li id="sys1"><input type="checkbox" class="inputCheck" id="i2" checked="checked"/><label for="">시우량</label></li>
										<li id="sys2"><input type="checkbox" class="inputCheck" id="i3" checked="checked"/><label for="">우량</label></li>
										<li id="sys3"><input type="checkbox" class="inputCheck" id="i4" checked="checked"/><label for="">수위</label></li>
									</ul>
								</li> -->
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
						</div>
						</form:form>
						<!-- //수위,유량 조회 -->
						
						<div id="btArea" >
							<span id="p_total_cnt">[총 ${totCnt}건]</span>
							<input type="button" id="a_chartPopup" name="a_chartPopup" style="display:none" class="btn btn_graph" onclick="javascript:chartPopup();" alt="그래프" />
							<input type="button" id="excel" name="excel" class="btn btn_excel" onclick="javascript:excelDown();" alt="엑셀" />
						</div>
						
						<div class="divisionBx" style="display:inline-block">
							<div class="div50" style="height: 552px;">
								<table summary="게시판 목록. 번호, 수계,측정소명, 경보발생시간, 경보단계, 경보내용가 담김">
									<colgroup>
										<col width="45" />
										<col width="110" />
										<col width="140" />
										<col width="90" />
										<col width="105" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">No</th>
											<th scope="col">측정소</th>
											<th scope="col">일자</th>
											<th scope="col">수위(m)</th>
											<th scope="col">유량(㎥/hr)</th>
										</tr>
									</thead>
									<tbody id="dataList">
									</tbody>
								</table>
								<!-- 2014-10-22 mypark 페이징 추가 -->
								<div class="paging">
									<div id="page_number">
										<ul class="paginate" id="pagination"></ul>
									</div>
								</div>
							</div>
							<div class="div50 last txtalignL">
								<div class="topBx" style="display:inline-block;">
									<span style="line-height:20px;"><img src="/images/common/bu_square.gif"/>&nbsp; 측정소 위치 &nbsp; <img id="pendingBtn" style='cursor:pointer' align="bottom" onclick='slide()' src="<c:url value='/images/popup/btn_arrow_down.gif'/>" alt="pending" /></span>
								</div>
<!--									<div id="data_map" class="data_map" style="width:480px;height:271px;border:solid 2px #CCC;"> -->
<%--										<c:import url="/WEB-INF/jsp/common/mapview_totalmnt.jsp" /> --%>
<!--									</div> -->
								<div id="data_map" class="data_map" style="position:relative; width:480px;height:271px;border:solid 2px #CCC;">
									<div id="map" class="claro" style="border:1px solid #000; width:100%; height:100%;">
										<div id="tool" style="right: 1px; top: 10px; width:150px; height:24px;  position: absolute;  z-index: 1000;"> 
											<div class="tool_bu1"><a href="javascript:$kecoMap.model.generalMap();" onmouseout="$kecoMap.controller.MM_swapImgRestore('Image1','/gis/images/tool_1_off.gif')" onMouseOver="$kecoMap.controller.MM_swapImage('Image1','/gis/images/tool_1_over1.gif',1)" ><img idx="0" src="/gis/images/tool_1_over1.gif" id="Image1" border="0" /></a></div>
											<div class="tool_bu1"><a href="javascript:$kecoMap.model.flightMap();" onmouseout="$kecoMap.controller.MM_swapImgRestore('Image2','/gis/images/tool_2_off.gif')" onMouseOver="$kecoMap.controller.MM_swapImage('Image2','/gis/images/tool_2_over1.gif',1)" ><img idx="1" src="/gis/images/tool_2_off.gif" id="Image2"  border="0" /></a></div>
											<div class="tool_bu2"><a href="javascript:showLayerDiv();" onmouseout="$kecoMap.controller.MM_swapImgRestore('Image3','/gis/images/btn_smapLegend_off.png')" onMouseOver="$kecoMap.controller.MM_swapImage('Image3','/gis/images/btn_smapLegend_over.png',1)" ><img idx="3" src="/gis/images/btn_smapLegend_off.png" id="Image3" border="0" /></a></div>
<!--										<input type="button" name="" value="기초시설물" class="smapLegend" onclick="javascript:showLayerDiv()"/> -->
<!--										<div class="tool_bu1"><a href="javascript:showLayerDiv()" onMouseOut="$kecoMap.controller.MM_swapImgRestore('Image2','/gis/images/tool_2_off.gif')" onMouseOver="$kecoMap.controller.MM_swapImage('Image2','/gis/images/tool_2_over1.gif',1)" ><img idx="1" src="/gis/images/tool_2_off.gif" id="Image2" width="42" height="24" border="0"></a></div> -->
										</div>
										<div id="layerDiv"style="position:absolute; bottom:-130px;right:1px;border:1px solid #0066cc; text-align:left;  width:180px;height:100px;background:#fff;overflow-y:auto;padding:10px;  z-index: 1000; display: none;}">
											<span class="title" style="font-size:14px;text-align:left;font-weight:600;height:32px;display:inline-block;">측정소 정보</span>
											<div id="chkInfoBx">
											</div>
										</div>
									</div>
									
									<link type="text/css" rel="stylesheet" href="http://js.arcgis.com/3.8/js/dojo/dijit/themes/claro/claro.css" />
									<link type="text/css" rel="stylesheet" href="http://js.arcgis.com/3.8/js/esri/css/esri.css" />
									<script type="text/javascript" src="/gis/gis/jsapi_vsdoc10_v36.js"></script>
									<script type="text/javascript" src="http://js.arcgis.com/3.8/"></script>
									<script type="text/javascript" src="/gis/js/common.js"></script>
									<script type="text/javascript" src="/gis/js/control.js"></script>
									<script type="text/javascript" src="/gis/js/kecoMap.js"></script>
									
									<div class="topBx mtop5" style="z-index:5;">
										<span style="line-height:20px;"><img src="/images/common/bu_square.gif"/>&nbsp; 변화추이 그래프</span>
									</div>
									<div id="data_graph" class="data_graph" style="width:480px;height:230px;border:solid 2px #CCC;overflow:hidden; z-index:5;">
										<span id="span_loading" style="position:absolute">그래프를 불러오는 중 입니다...</span>
										<iframe id="chart" name="chart" onload="chart_load()" src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="230px"></iframe>
									</div>
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