<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : dischargewater.jsp
	 * Description : 방류수수질정보 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2010.05.17	khany		최초 생성
	 * 2013.10.20	lkh			리뉴얼
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
	//관리자 외에 등록 된 측정소가 없을 경우 메인으로 이동
	if(user_roleCode != 'ROLE_ADMIN'){
		if(user_w_cnt == 0){
// 			alert('권한이 없습니다. 측정소를 등록해주세요.');
// 			window.location = "<c:url value='/main.do'/>";
		}
	}
//<![CDATA[
	$(function () {
// 		set_User_deptNo(user_dept_no, "sugye");
		setDate();
		
		//user 측정소권한에 따른 수계 고정
		if(user_roleCode == 'ROLE_ADMIN'){
			selectedSugyeInMemberId(user_riverid, 'sugye');
			
			adjustGongku();
		}else{
			selectedSugyeInMemberIdNew(id, 'W', 'sugye');
		}
		
// 		adjustGongku();
		$('#sugye').change(function(){
			adjustGongku();
		});
		
		$('#gongku').change(function() {
			adjustBangryu();
		});
		
		$("#dataType").change(function() {
			if($("#dataType").val() == "1") {
				var todayObj = new Date(); 
				var yday = new Date();
				yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());
				var today = todayObj.getFullYear()+"/"+ addzero(todayObj.getMonth()+1) +"/"+ addzero(todayObj.getDate());
				var time = todayObj.getHours();
				var timeStr = addzero(time-5);
				if(time <= 0)  timeStr = "00";
				$("#frTime > option[value=" + timeStr + "]").attr("selected", "selected");
			}
		});
		
	});
	
	function setDate(){
		var date = new Date();
		var hour = date.getHours();
		time=hour<10?"0"+hour:hour;
		$("#toTime option[value="+time+"]").attr("selected", "true");
		
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
		
		var todayObj = new Date(); 
		var yday = new Date();
		
		yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());
		var today = todayObj.getFullYear()+"/"+ addzero(todayObj.getMonth()+1) +"/"+ addzero(todayObj.getDate());
		
		var time = todayObj.getHours();
		
		var timeStr = addzero(time-2);
		if(time <= 0) timeStr = "00";
		
		$("#frTime > option[value=" + timeStr + "]").attr("selected", "selected");
		
		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}
		
		$("#startDate").val(yday);
		$("#endDate").val(today);
	}
	
	//측정소가 전체가 아닐때만 그래프 버튼이 표시됩니다.
	function setGraphBtn() {
		if($('#gongku').val() == "all") {
			$('#a_chartPopup').attr("href", "#");
			$('#img_chartPopup').hide();
		} else {
			$('#a_chartPopup').attr("href","javascript:chartPopup()");
			$('#img_chartPopup').fadeIn('fast');
		}
	}
	
	function adjustGongku() {
		var sugyeCd = $('#sugye').val();
		var dropDownSet = $('#gongku');
		var dropDownSet_branchNo = $('#bangryu');
		if( sugyeCd == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#gongku>option:first").attr("selected", "true");
			dropDownSet_branchNo.attr("disabled", true);
			$("#bangryu>option:first").attr("selected", "true");
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getTMSListNew.do'/>", {sugye:sugyeCd}, function (data, status){
				if(status == 'success'){	 
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect(data.tms);
					// $("#gongku>option[value='"+fact+"']").attr("selected", "selected");	
					adjustBangryu();
					//if(fact == 'all')
					//	dropDownSet_branchNo.attr("disabled", true);
				} else { 
					 alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
	}
	
	function adjustGongkuInit() {
		showLoading();
		var sugyeCd = $('#sugye').val();
		var dropDownSet = $('#gongku');
		var dropDownSet_branchNo = $('#bangryu');
		
		if( sugyeCd == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#gongku>option:first").attr("selected", "true");
			dropDownSet_branchNo.attr("disabled", true);
			$("#bangryu>option:first").attr("selected", "true");
		}else{
			dropDownSet.attr("disabled", false);
			$.ajax({
				type: "POST",
				url: "<c:url value='/waterpolmnt/waterinfo/getTMSList.do'/>",
				data: { sugye:sugyeCd },	
				dataType:"json",
				beforeSend : function(){},
				success : function(result){
					// 아이템 데이터 세팅
					var tot = result['tms'].length;
					for(var i=0; i < tot; i++){
						var obj = result['tms'][i];
						var item;
						item = "<option value='"+obj.VALUE + "'>"+ obj.CAPTION + "</option>";
						$("#gongku").append(item);
					}
				}
			});
		}	
		setTimeout(gongkuInit, 1250);
	}
	
	function gongkuInit(){
		$("#gongku").val('11F0041');
		adjustBangryu();
		reloadData();
	}
	
	function adjustBangryu() {
		var factCd = $('#gongku').val();
		var dropDownSet = $('#bangryu');
		
		if( factCd == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#gongku>option:first").attr("selected", "true");
			$("#bangryu>option:first").attr("selected", "true");
			setGraphBtn();
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getWastList.do'/>", {factCode:factCd}, function (data, status){
				if(status == 'success'){	 
						dropDownSet.loadSelect_all(data.wast);
						//$("#branchNo>option[value='"+branch+"']").attr("selected", "selected");
						setGraphBtn();
				} else { 
					alert("방류구 목록 가져오기 실패");
					return;
				}
			});
		}
	}
	
	function excelDown() {
		
		if( validation() == false ) return;
		
		var sugye = $("#sugye").val();
		var gongku = $("#gongku").val();
		var bangryu = $("#bangryu").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		//var sys = $("#sys").val();
		var item1=item2=item3=item4=item5=item6=item7="x";
		
		if($("#i1").is(":checked")) {
			item1 = "PHY";
		}else{
			item1 = "xxx";
		}
		if($("#i2").is(":checked")) {
			item2 = "BOD";
		}else{
			item2 = "xxx";
		}
		if($("#i3").is(":checked")) {
			item3 = "COD";
		}else{
			item3 = "xxx";
		}
		if($("#i4").is(":checked")) {
			item4 = "SUS";
		}else{
			item4 = "xxx";
		}		
		if($("#i5").is(":checked")) {
			item5 = "TON";
		}else{
			item5 = "xxx";
		}
		if($("#i6").is(":checked")) {
			item6 = "TOP";
		}else{
			item6 = "xxx";
		}
		if($("#i7").is(":checked")) {
			item7 = "FLW";
		}else{
			item7 = "xxx";
		}
		
		var rType = $("#dataType").val();
		
		var param = "sugye=" + sugye + "&gongku=" + gongku + "&bangryu=" + bangryu +
		"&frDate=" + frDate + "&toDate=" + toDate + "&frTime=" + frTime + "&toTime=" + toTime + 
		 "&item01=" + item1 + "&item02=" + item2 + "&item03=" + item3 + "&item04=" + item4 + "&item05=" + item5 +
		 "&item06=" + item6 + "&item07=" + item7 +
		 "&dataType=" + rType;
			
		location.href="<c:url value='/waterpolmnt/waterinfo/getExcelDetalViewDISCHARGE.do'/>?"+param;
	}
	
	function chartPopup() {
		
		if( validation() == false ) return;
		
		var sugye = $("#sugye").val();
		var gongku = $("#gongku").val();
		var bangryu = $("#bangryu").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		//var sys = $("#sys").val();
		var item1=item2=item3=item4=item5=item6=item7="x";
		var bItem = $("#item").val(); //대항목 선택값
		
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 546;
		var winWidth = 642;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-20;
		var height = winHeight-20;
		
		if($("#i1").is(":checked")) {
			item1 = "PHY";
		}else{
			item1 = "xxx";
		}
		if($("#i2").is(":checked")) {
			item2 = "BOD";
		}else{
			item2 = "xxx";
		}
		if($("#i3").is(":checked")) {
			item3 = "COD";
		}else{
			item3 = "xxx";
		}
		if($("#i4").is(":checked")) {
			item4 = "SUS";
		}else{
			item4 = "xxx";
		}		
		if($("#i5").is(":checked")) {
			item5 = "TON";
		}else{
			item5 = "xxx";
		}
		if($("#i6").is(":checked")) {
			item6 = "TOP";
		}else{
			item6 = "xxx";
		}
		if($("#i7").is(":checked")) {
			item7 = "FLW";
		}else{
			item7 = "xxx";
		}
		
		var rType = $("#dataType").val();
		
		var param = "sugye=" + sugye 
				+ "&gongku=" + gongku 
				+ "&bangryu=" + bangryu 
				+ "&frDate=" + frDate 
				+ "&toDate=" + toDate 
				+ "&frTime=" + frTime 
				+ "&toTime=" + toTime 
				+ "&item01=" + item1 
				+ "&item02=" + item2 
				+ "&item03=" + item3 
				+ "&item04=" + item4 
				+ "&item05=" + item5 
				+ "&item06=" + item6 
				+ "&item07=" + item7 
				+ "&dataType=" + rType 
				+ "&width=" + (winWidth-40) 
				+ "&height=" + (winHeight-40)
				+ "&item=" + bItem;
				
		//stats/getAccidentStatsChart.do
		window.open("<c:url value='/waterpolmnt/waterinfo/goChartDischarge.do'/>?"+encodeURI(param), 
				'chartDetailViewDISCHARGE','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function reloadData(pageNo){
		if( validation() == false ) return;
		showLoading();
		
		var sugye = $("#sugye").val();
		var gongku = $("#gongku").val();
		var branchNo = $("#bangryu").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		//var sys = $("#sys").val();
		var item1=item2=item3=item4=item5=item6=item7="x";
		
		if($("#i1").is(":checked")) {
			item1 = "PHY";
		}else{
			item1 = "xxx";
		}
		if($("#i2").is(":checked")) {
			item2 = "BOD";
		}else{
			item2 = "xxx";
		}
		if($("#i3").is(":checked")) {
			item3 = "COD";
		}else{
			item3 = "xxx";
		}
		if($("#i4").is(":checked")) {
			item4 = "SUS";
		}else{
			item4 = "xxx";
		}		
		if($("#i5").is(":checked")) {
			item5 = "TON";
		}else{
			item5 = "xxx";
		}
		if($("#i6").is(":checked")) {
			item6 = "TOP";
		}else{
			item6 = "xxx";
		}
		if($("#i7").is(":checked")) {
			item7 = "FLW";
		}else{
			item7 = "xxx";
		}
		
		if (pageNo == null) pageNo = 1;
		
		$("#pageIndex").val(pageNo);
		$("#river_div").val(sugye);
		$("#branch_no").val(branchNo);
		$("#gongku").val(gongku);
		$("#item01").val(item1);
		$("#item02").val(item2);
		$("#item03").val(item3);
		$("#item04").val(item4);
		$("#item05").val(item5);
		$("#item06").val(item6);
		$("#item07").val(item7);
		
		var rType = $("#dataType").val();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getDetailViewDISCHARGE.do'/>",
			data:{
					sugye:sugye, 
					gongku:gongku,
					chukjeongso:branchNo,
					frDate:frDate,
					toDate:toDate,
					frTime:frTime,
					toTime:toTime,
					//sys:sys,
					item01:item1,
					item02:item2,
					item03:item3,
					item04:item4,
					item05:item5,
					item06:item6,
					item07:item7,
					pageIndex:pageNo,
					dataType:rType
			},
			dataType:"json",
			success:function(result){
				//console.log("결과 값 확인 : ",result);
				var tot = result['detailViewList'].length;
				var pageInfo = result['paginationInfo'];
				var dataHtml="";
				if( tot <= 0 ){
					dataHtml="<tr><td colspan='12'>조회 결과가 없습니다.</td></tr>";
				}else{
					var idx = 0;
					for(var i=0; i < tot; i++) {
						var obj = result['detailViewList'][i];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						obj.date = obj.strdate + " " + obj.strtime;
						
						if(obj.branch_name != undefined && obj.branch_name != '') {
							if(obj.branch_name[0] == '-')
								obj.wast = obj.branch_name.replace('-','');
							else
								obj.wast = obj.branch_name;
						}
						
						obj.phy = (obj.phy != null && obj.phy != '') ? obj.phy : '-';
						obj.bod = (obj.bod != null && obj.bod != '') ? obj.bod : '-';
						obj.cod = (obj.cod != null && obj.cod != '') ? obj.cod : '-';
						obj.sus = (obj.sus != null && obj.sus != '') ? obj.sus : '-';
						obj.ton = (obj.ton != null && obj.ton != '') ? obj.ton : '-';
						obj.top = (obj.top != null && obj.top != '') ? obj.top : '-';
						obj.flw = (obj.flw != null && obj.flw != '') ? obj.flw : '-';
						
						dataHtml += "<tr>";
						dataHtml += "<td>" + obj.no +"</td>";
						dataHtml += "<td>" + obj.river_name +"</td>";
						dataHtml += "<td>" + obj.factname +"</td>";
						dataHtml += "<td>" + obj.wast +"</td>";
						dataHtml += "<td>" + obj.date +"</td>";
						dataHtml += "<td>" + obj.phy +"</td>";
						dataHtml += "<td>" + obj.bod +"</td>";
						dataHtml += "<td>" + obj.cod +"</td>";
						dataHtml += "<td>" + obj.sus +"</td>";
						dataHtml += "<td>" + obj.ton +"</td>";
						dataHtml += "<td>" + obj.top +"</td>";
						dataHtml += "<td>" + obj.flw +"</td>";
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
				
				$("#p_total_cnt").html("[총 " + result['totCnt'] + "건] <span class='red'> ※조회결과는 확정자료가 아닙니다.</span>");
				
				closeLoading();
			},
			error:function(result){
				var data = [];
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
				var oraErrorCode = "";
				if (result.responseText != null ) {
					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				var dataHtml="<tr><td colspan='12'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
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
		
		var date = new Date(stdt.value).getTime();
		var overdate =  new Date(date + (60*60*24*31)*1000);
		var strdate = overdate.getFullYear()+ "/" + addzero(overdate.getMonth()+1) + "/" + addzero(overdate.getDate());
		
		if(endt.value != '' && stdt.value > endt.value) {
			alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			stdt.value = "";
			endt.value = "";
			stdt.focus();
		}
		
		if(endt.value != '' && strdate < endt.value) {
			alert("조회 기간은 한달 이내 입니다.\n\n다시 입력해 주십시오.");
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
	
	function linkPage(pageNo){
		reloadData(pageNo);
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
					
					<!-- 방류수 수질 조회 -->
					<form:form commandName="searchTaksuVO" name="listFrm"  id="listFrm" method="post">		
						<input type="hidden" name="pageIndex" id="pageIndex" value="${searchTaksuVO.pageIndex}"/>	
						<input type="hidden" name="sugye" id="river_div"/>
						<input type="hidden" name="bangryu" id="branch_no"/>
						<input type="hidden" name="item01" id="item01"/>
						<input type="hidden" name="item02" id="item02"/>
						<input type="hidden" name="item03" id="item03"/>
						<input type="hidden" name="item04" id="item04"/>
						<input type="hidden" name="item05" id="item05"/>
						<input type="hidden" name="item06" id="item06"/>
						<input type="hidden" name="item07" id="item07"/>
						
						<div class="searchBox dataSearch">
							<ul>
								<li>
									<span class="fieldName">측정소 위치</span>
									<select class="fixWidth11" id="sugye">
										<!-- <option value="all">전체</option> -->
										<option value="11" selected="selected">서울특별시</option>
										<option value="26">부산광역시</option>
										<option value="27">대구광역시</option>
										<option value="28">인천광역시</option>
										<option value="29">광주광역시</option>
										<option value="30">대전광역시</option>
										<option value="31">울산광역시</option>
										<option value="41">경기도</option>
										<option value="42">강원도</option>
										<option value="43">충청북도</option>
										<option value="44">충청남도</option>
										<option value="45">전라북도</option>
										<option value="46">전라남도</option>
										<option value="47">경상북도</option>
										<option value="48">경상남도</option>
										<option value="49">제주도</option>
									</select>
									<span>&gt;</span>
										<select class="fixWidth11" id="gongku" name="gongku">
											<option value="all">전체</option>
										</select>
									<span>&gt;</span>
									<select class="fixWidth11"  id="bangryu">
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
								</li>
								<li>
									<span class="fieldName">수집주기</span>
									<select id="dataType" name="dataType">
										<option id="rDataType" name="rDataType" value="2">5분자료</option>
										<option id="rDataType" name="rDataType" value="1">1시간자료</option>
									</select>
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
							<input type="button" id="btnBasic" name="btnBasic" class="btn btn_excel" onclick="javascript:excelDown()" alt="엑셀"/>
						</div>
						<div class="table_wrapper">
							<table summary="게시판 목록. 번호, 수계,측정소명, 경보발생시간, 경보단계, 경보내용가 담김">
								<colgroup>
									<col width="45" />
									<col width="80" />
									<col width="110" />
									<col width="60" />
									<col width="120" />
									<col width="80" />
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
										<th scope="col">권역</th>
										<th scope="col">측정소</th>
										<th scope="col">방류구</th>
										<th scope="col">일자</th>
										<th scope="col">pH</th>
										<th scope="col">BOD(ppm)</th>
										<th scope="col">COD(ppm)</th>
										<th scope="col">SS(mg/L)</th>
										<th scope="col">T-N(mg/L)</th>
										<th scope="col">T-P(mg/L)</th>
										<th scope="col">유량(㎥/hr)</th>
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