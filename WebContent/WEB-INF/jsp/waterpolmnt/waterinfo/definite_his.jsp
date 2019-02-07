<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : definite_his.jsp
	 * Description : IP-USN정보 확정 이력 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2014.10.13	smji		최초 생성
	 * 
	 * author smji
	 * since 2011.10.13
	 * `
	 * Copyright (C) 2014 by smji  All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<!-- <html xmlns="http://www.w3.org/1999/xhtml"> -->
<html>

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<script type="text/javascript">
//<![CDATA[
	$(document).ready(function(){
		var memFactCode = "${member.factCode}";
		var memRiverDiv = "${member.riverId}";
		selectedSugyeInMemberId(user_riverid,'riverDiv');
		
		//메시지처리
		<c:if test="${not empty message }">
			alert("${message}");
		</c:if>
		
		//공통코드 등록 레이어
		$("#layerDefiniteDelete").draggable({
			containment: 'body',
			scroll: false
		});

		var date = new Date();
		var hour = date.getHours();
		time=hour<10?"0"+hour:hour;
		t_time = hour-2>0?hour-2:0;
		fritime=t_time<10?"0"+t_time:t_time;
		$("#toTime option[value="+time+"]").attr("selected", "true");
		$("#frTime option[value="+fritime+"]").attr("selected", "true");
		
		var today = new Date(); 
		var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 12);
		
		yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());
		today = today.getFullYear()+ "/" + addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		
		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}
		
		$("#startDate").val(yday);
		$("#endDate").val(today);
	});
	
	var memFactCode = "${member.factCode}";
	var memRiverDiv = "${member.riverId}";
	
	$(function () {
		//user deptNo에 따른 수계 고정
		selectedSugyeInMemberId(user_riverid , 'sugye');
		
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
		$("#strSelDate").datepicker({
			buttonText: '시작일'
		});
		$("#endSelDate").datepicker({
			buttonText: '종료일'
		});
		
		//시공사일경우 해당 공구만 선택할 수 있게
		if(memFactCode != null && memFactCode != "")
		{
			$("#riverDiv > option[value="+memRiverDiv+"]").attr("selected", "true");
			$("#riverDiv").attr("disabled", "disabled");
			
			$("#riverDiv2 > option[value="+memRiverDiv+"]").attr("selected", "true");
			$("#riverDiv2").attr("disabled", "disabled");
		}
		
		adjustFactList();
		adjustFactList2();
		
		$('#riverDiv').change(function(){
			adjustFactList();		//수계 2  조회
			adjustBranchList();	//수계 3  조회
		});
		
		$('#riverDiv2').change(function(){
			adjustFactList2();		//선택 수계 2  조회
			adjustBranchList2();	//선택 수계 3  조회
		});
		
	});
	
	var itemCnt;
	
	
	var firstFlag = false;
	
	function adjustFactList()
	{
		var riverDiv = $('#riverDiv').val();
		
		var factCode = $('#factCode');
		var branchNo = $('#branchNo');
		
		factCode.attr("style", "background:#ffffff;");
		branchNo.attr("style", "background:#ffffff;");
		
		$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>",
				{sugye:riverDiv, system:'U'},
				function (data, status){
				if(status == 'success'){
					if (data.gongku.length != 1) {
						factCode.loadSelect_all(data.gongku);
					} else {
						factCode.loadSelect(data.gongku);
						factCode.attr("disabled", true);
						factCode.attr("style", "background:#e9e9e9;");
					}
					
					if(memFactCode != null && memFactCode != "")
					{
						$("#factCode>option[value="+memFactCode+"]").attr("selected", "selected");
						$("#factCode").attr("disabled", "disabled");
					}
					
					adjustBranchList();
					
					if(memFactCode == 'all')
						branchNo.attr("disabled", true);
				
				} else { 
					alert("공구 목록 가져오기 실패");
					return;
				}
		});
	}
	
	//측정소 목록 가져오기
	function adjustBranchList()
	{	
		var factCode = $('#factCode').val();
		
		var branchNo = $('#branchNo');
		branchNo.attr("disabled", false);
		var url = "<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>";
		$.getJSON(url, {factCode:factCode}, function (data, status){
			if(status == 'success'){
				branchNo.loadSelect_all(data.branch);
				if(!firstFlag){
					reloadData();
					firstFlag = true;
				}
			} else { 
				alert("공구 목록 가져오기 실패");
				return;
			}
		});
		
		//2014-10-27 mypark 검색개선
		$('#factCode').hide();
	}
	
	
	function adjustFactList2()
	{
		var riverDiv = $('#riverDiv2').val();
		
		var factCode = $('#factCode2');
		var branchNo = $('#branchNo2');
		
		factCode.attr("style", "background:#ffffff;");
		branchNo.attr("style", "background:#ffffff;");
		
		$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>",
				{sugye:riverDiv, system:'U'},
				function (data, status){
				if(status == 'success'){
					if (data.gongku.length != 1) {
						factCode.loadSelect_all(data.gongku);
					} else {
						factCode.loadSelect(data.gongku);
						factCode.attr("disabled", true);
						factCode.attr("style", "background:#e9e9e9;");
					}
					
					if(memFactCode != null && memFactCode != "")
					{
						$("#factCode2>option[value="+memFactCode+"]").attr("selected", "selected");
						$("#factCode2").attr("disabled", "disabled");
					}
					
					adjustBranchList2();
					
					if(memFactCode == 'all')
						branchNo.attr("disabled", true);
				
				} else { 
					alert("공구 목록 가져오기 실패");
					return;
				}
		});
	}
	
	//측정소 목록 가져오기
	function adjustBranchList2()
	{	
		var factCode = $('#factCode2').val();
		
		var branchNo = $('#branchNo2');
		branchNo.attr("disabled", false);
		var url = "<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>";
		$.getJSON(url, {factCode:factCode}, function (data, status){
			if(status == 'success'){
				branchNo.loadSelect(data.branch);
			} else { 
				alert("공구 목록 가져오기 실패");
				return;
			}
		});
		
		//2014-10-27 mypark 검색개선
		$('#factCode2').hide();
	}
	
	
	var clickData;
	
	/* 데이터 조회 */
	function reloadData(){
		layerPopCloseAll();
		
		if( validation() == false ) return;
		
		var riverDiv = $("#riverDiv").val();
		var factCode = $("#factCode").val();
		var branchNo = $("#branchNo").val();
		var str_time = $("#startDate").val2()+"0000";
		var end_time = $("#endDate").val2()+"2359";
		var definite_type = $("#definite_type").val();
		
		if(factCode == null || factCode == "unknowned" || riverDiv == null || riverDiv == "unknowned"){
			alert("측정소 정보가 없습니다.");
			return;
		}
		
		showLoading();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getDefiniteHisList.do'/>",
			data:{
					river_div:riverDiv,
					fact_code:factCode,
					branch_no:branchNo,
					str_time:str_time,
					end_time:end_time,
					definite_type:definite_type
			},
			dataType:"json",
			success:function(result){
// 				console.log("결과 값 확인 : ",result);
				
				$("#river_div").val(riverDiv);
				$("#fact_code").val(factCode);
				$("#branch_no").val(branchNo);
				$("#str_time").val(str_time);
				$("#end_time").val(end_time);
				
				var tot = result['detailViewList'].length;
				if(tot == 0 || tot == 1){
					$("#main_display").css("height", "55px");
				}else if(tot<20){
					$("#main_display").css("height", (tot*27)+18 + "px");
				}else{
					$("#main_display").css("height", "558px");
				}
				
				// 조회 데이터 표출
				var html = "";
				var main_html = "";
				
				html += "<table>";
				html += "	<colgroup>";
				html += "		<col width='40px' />";
				html += "		<col width='70px' />";
				html += "		<col width='110px' />";
				html += "		<col width='320px' />";
				html += "		<col width='120px' />";
				html += "		<col width='195px' />";
				html += "		<col width='120px' />";
				html += "	</colgroup>";
				main_html = html;
				
				if( tot <= 0 ){
					main_html += "<table><tr><td colspan='7'>조회 결과가 없습니다.</td></tr></table>";
					$("#main_display").html(main_html);
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						
						var no = i+1;
						obj.no = no;
						
						var result_str_time = obj.str_time.substr(0,4)+"/"+obj.str_time.substr(4,2)+"/"+obj.str_time.substr(6,2)+" "+obj.str_time.substr(8,2)+":"+obj.str_time.substr(10,2);
						var result_end_time = obj.end_time.substr(0,4)+"/"+obj.end_time.substr(4,2)+"/"+obj.end_time.substr(6,2)+" "+obj.end_time.substr(8,2)+":"+obj.end_time.substr(10,2);
						obj.str_time = result_str_time+" ~ "+result_end_time;
						
						obj.reg_date = obj.reg_date.substr(0,4)+"/"+obj.reg_date.substr(4,2)+"/"+obj.reg_date.substr(6,2)+" "+obj.reg_date.substr(8,2)+":"+obj.reg_date.substr(10,2);
						
						var even = "";
						if(i%2 == 1){even = "even"}
						main_html += "	<tr class='tr"+i+" "+even+"' "+clickEvent(i)+">";
						main_html += "		<td>"+obj.no+"";
						main_html += "			<input type='hidden' class='river_div' value='"+obj.river_div+"'/>";
						main_html += "			<input type='hidden' class='fact_code' value='"+obj.fact_code+"'/>";
						main_html += "			<input type='hidden' class='branch_no' value='"+obj.branch_no+"'/>";
						main_html += "		</td>";
						main_html += "		<td>"+obj.river_name+"</td>";
						main_html += "		<td>"+obj.branch_name+"</td>";
						main_html += "		<td>"+obj.str_time+"</td>";
						main_html += "		<td>"+obj.reg_name+"</td>";
						main_html += "		<td>"+obj.reg_date+"</td>";
						main_html += "		<td style='"+stColor(obj.definite_type)+"'>"+obj.definite_type+"</td>";
						main_html += "	</tr>";
					}
					main_html += "</table>";
					$("#main_display").html(main_html);
				}
				
				$("#p_total_cnt").html("▶ 검색결과 [총 " + result['totCnt'] + "건]");
				
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
				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				closeLoading();
			}
		});
	}
	
	function clickEvent(num){
		var returnVal = "";
		
		returnVal += "onclick=\"onData('"+num+"');\"";
		return returnVal;
	}
	
	var clickData = null;
	function onData(num){
		var river_div = $(".tr"+num+" input.river_div").val();
		var fact_code = $(".tr"+num+" input.fact_code").val();
		var branch_no = $(".tr"+num+" input.branch_no").val();
		var str_time = $(".tr"+num+" td:nth-child(4)").html();
		clickData = {river_div:river_div, fact_code:fact_code, branch_no:branch_no, str_time:str_time };
	}
	
	function stColor(definite_type){
		var returnVal = "";
		
		if(definite_type == "확정취소"){
			returnVal += "color:red;";
		}
		return returnVal;
	}
	
	
	/* 초기값 셋팅 */
	function initializeSetting(){
		$("#strSelDate").val("");
		$("#endSelDate").val("");
		$("#frSelTime option[value=00]").attr("selected", "true");
		$("#toSelTime option[value=00]").attr("selected", "true");
		$("#riverDiv2").val($("#riverDiv").val());
		adjustFactList2();
		clickData = null;
	}
	
	/* 팝업 */
	function popupData(){
		
		var obj = clickData;
		
		initializeSetting();//초기화
		
		if(obj != null){
			var strSelDate = obj.str_time.substr(0,10);
			var frSelTime = obj.str_time.substr(11,2);
			var endSelDate = obj.str_time.substr(19,10);
			var toSelTime = obj.str_time.substr(30,2);
			
			$("#strSelDate").val(strSelDate);
			$("#endSelDate").val(endSelDate);
			$("#frSelTime option[value="+frSelTime+"]").attr("selected", "true");
			$("#toSelTime option[value="+toSelTime+"]").attr("selected", "true");
			
			$("#riverDiv2").val(obj.river_div);
			adjustFactList2();
			$("#branchNo2").val(obj.branch_no);
		}
		
		layerPopOpen("layerDefiniteDelete");
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerDefiniteDelete");
	}
	
	
	/* 확정취소 */
	function deleteDefiniteData() {
		if(confirm("기간 내의 확정을 취소 하시겠습니까?")){
			var riverDiv = $("#riverDiv2").val();
			var factCode = $("#factCode2").val();
			var branchNo = $("#branchNo2").val();
			var str_time = $("#strSelDate").val2()+$("#frSelTime").val()+"00";
			var end_time = $("#endSelDate").val2()+$("#toSelTime").val()+"59";
			var definite_type = "DEL";
			
			showLoading();
			
			$.ajax({
				type:"post",
				url:"<c:url value='/waterpolmnt/waterinfo/deleteDefiniteData.do'/>",
				data:{
						iver_div:riverDiv,
						fact_code:factCode,
						branch_no:branchNo,
						str_time:str_time,
						end_time:end_time,
						definite_type:definite_type
				},
				dataType:"json",
				success:function(result){
// 					console.log("결과 값 확인 : ",result);

					var message = result['message'];
					
					closeLoading();
					if(message == "success"){
						reloadData();
					}else{
						if(message != "success"){
							if(message == "fail"){
								alert("등록에 실패하였습니다.");
							}else if(message == "nodata"){
								alert("기간 내에 취소할 데이터가 없습니다.");
								reloadData();
							}
						}
					}
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
					dataView.getItemMetadata = function () {
						return {"columns":{0:{"colspan":"*"}}};
					}
					closeLoading();
				}
			});
		}
	}
	
	
	
	
	
	function validation(){
		if( $('#startDate').val() == "" ){ alert("조회 시작일자를 선택하세요"); return false; }
		if( $('#endDate').val() == "" ){ alert("조회 종료일자를 선택하세요"); return false; }
		if(!timeCheck("startDate", "endDate", "frTime", "toTime", "", "")) {return false;}
	}
	
	function timeCheck(strDateId, endDateId, frTimeId, toTimeId, frSelMinId, toSelMinId)
	{
		var stdt = document.getElementById(strDateId);
		var endt = document.getElementById(endDateId);
		
		if(stdt.value == endt.value)
		{
			var frTime = $("#"+frTimeId).val();
			var toTime = $("#"+toTimeId).val();
			
			if(frTime > toTime)
			{
				alert("조회 종료시간이 시작시간보다 빠릅니다.\n\n다시 입력해 주십시오.");
				$("#"+frTimeId).val("");
				$("#"+toTimeId).val("");
				$("#"+frTimeId).focus();
				
				return false;
			}
			else if((frSelMinId != "" && toSelMinId != "") &&  frTime == toTime)
			{
				var frSelMin = $("#"+frSelMinId).val();
				var toSelMin = $("#"+toSelMinId).val();
				
				if(frSelMin > toSelMin)
				{
					alert("조회 종료시간이 시작시간보다 빠릅니다.\n\n다시 입력해 주십시오.");
					$("#"+frSelMinId).val("");
					$("#"+toSelMinId).val("");
					$("#"+frSelMinId).focus();
					
					return false;
				}
			}
		}
		
		return true;
	}
	
	function commonWork(strDateId, endDateId, frTimeId, toTimeId, frSelMinId, toSelMinId) {
		var stdt = document.getElementById(strDateId);
		var endt = document.getElementById(endDateId);
		var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;
		
		
		if(stdt.value !=''){
			if(dateCheck.test(stdt.value)!=true){
				
				var returnValue = commonWork2(stdt.value, strDateId);
				
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
				
				var returnValue = commonWork2(endt.value, endDateId);
				
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
		var overdate = new Date(date + (60*60*24*31)*1000);
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
		
		timeCheck(strDateId, endDateId, frTimeId, toTimeId, frSelMinId, toSelMinId);
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
	
	function excelDown() {
		var riverDiv = $("#riverDiv").val();
		var factCode = $("#factCode").val();
		var branchNo = $("#branchNo").val();
		var str_time = $("#startDate").val2()+"0000";
		var end_time = $("#endDate").val2()+"2359";
		var definite_type = $("#definite_type").val();
		
		if(factCode == null || factCode == "unknowned" || riverDiv == null || riverDiv == "unknowned"){
			alert("측정소 정보가 없습니다.");
			return;
		}
		
		var param = "river_div=" + riverDiv + "&fact_code=" + factCode + "&branch_no=" + branchNo +
			"&str_time=" + str_time + "&end_time=" + end_time +
			"&definite_type=" + definite_type;
		
		location.href="<c:url value='/waterpolmnt/waterinfo/getDefiniteHisListExcel.do'/>?"+param;
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
						
						<!-- 선별 데이터 조회 현황 -->
						<form:form commandName="selectDataVO" name="listFrm"  id="listFrm" method="post">
							<input type="hidden" name="river_div" id="river_div"/>
							<input type="hidden" name="fact_code" id="fact_code"/>
							<input type="hidden" name="branch_no" id="branch_no"/>
							<input type="hidden" name="str_time" id="str_time"/>
							<input type="hidden" name="end_time" id="end_time"/>
							
						<div class="searchBox dataSearch">
							<ul>
								<li>
									<span class="fieldName">측정소 위치</span>
									<select id="riverDiv" class="width70">
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
									 <span style="display:none;">&gt;</span>
									<select id="factCode" class="width110" name="factCode" style="display:none;">
										<option value="all">전체</option>
									</select>
									<span>&gt;</span>
									<select id="branchNo" class="width110" name="branchNo" disabled="disabled">
										<option value="all">전체</option>
									</select>
								</li>
								<li>
									<span class="fieldName">확정구분</span>
									<select id="definite_type" class="width110">
										<option value="all">전체</option>
										<option value="SET">확정</option>
										<option value="DEL">확정취소</option>
									</select>
								</li>
								<li>
									<span class="fieldName">확정일시</span>
									<input type="text" id="startDate" name="startDate" size="13" onchange="commonWork('startDate','endDate','','','','')" alt="확정시작일"/>
									<span>~</span>
									<input type="text" id="endDate" name="endDate" size="13" onchange="commonWork('startDate','endDate','','','','')" alt="확정종료일"/>
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
						</div>
						</form:form>
						<!-- //하천 수질 조회 -->
						
						<div id="btArea">
							<span id="p_total_cnt">▶ 검색결과 [총 ${totCnt}건]</span>
							<input type="button" id="excel" name="excel" class="btn btn_excel" onclick="javascript:excelDown();" alt="엑셀"/>
						</div>
						
						<div id="div_result">
							<div id="top_display">
								<table>
									<colgroup>
										<col width="40px" />
										<col width="70px" />
										<col width="110px" />
										<col width="320px" />
										<col width="120px" />
										<col width="195px" />
										<col width="120px" />
									</colgroup>
									<tr>
										<th>NO</th>
										<th>수계</th>
										<th>측정소</th>
										<th>확정 데이터 기간</th>
										<th>작업자</th>
										<th>작업일자</th>
										<th>확정구분</th>
									</tr>
								</table>
							</div>
							
							<div id="main_display"   style="overflow-x: hidden;">
								<table>
									<colgroup>
										<col width="40px" />
										<col width="70px" />
										<col width="110px" />
										<col width="320px" />
										<col width="120px" />
										<col width="195px" />
										<col width="120px" />
									</colgroup>
									<tr>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
										<td></td>
									</tr>
								</table>
							</div>
							<div class="btn_area">
								<input type="button" id="selectData" name="selectData" value="확정취소" class="btn btn_basic" onclick="javascript:popupData();" alt="확정취소" style="float:right;"/>
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
	<!-- //선택 수정 레이어 -->
	<div id="layerDefiniteDelete" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnDefiniteDeleteBox" name="btnDefiniteDeleteBox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerDefiniteDelete');" alt="닫기" />
		</div>
		<form id="definiteDeleteform" name="definiteDeleteform" method="post">
			
			<table style="width:100%; float:left; text-align:left; margin-bottom:10px" summary="선별정보">
				<colgroup>
					<col width="120"/>
					<col width=""/>
				</colgroup>
				<tr>
					<th>측정소 선택</th>
					<td>
						<select id="riverDiv2" class="width70">
							<option value="R01">한강</option>
							<option value="R02">낙동강</option>
							<option value="R03">금강</option>
							<option value="R04">영산강</option>
						</select>
						 <span style="display:none;">&gt;</span>
						<select id="factCode2" class="width110" name="factCode2" style="display:none;">
							<option value="all">전체</option>
						</select>
						<span>&gt;</span>
						<select id="branchNo2" class="width110" name="branchNo2" disabled="disabled">
							<option value="all">전체</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>확정 기간</th>
					<td>
						<input type="text" id="strSelDate" name="strSelDate" size="13" onchange="commonWork('strSelDate','endSelDate','frSelTime','toSelTime','','')" alt="확정시작일"/>
						<select id="frSelTime" name="frSelTime" onchange="commonWork('strSelDate','endSelDate','frSelTime','toSelTime','','')" style="width:45px">
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
						<input type="text" id="endSelDate" name="endSelDate" size="13" onchange="commonWork('strSelDate','endSelDate','frSelTime','toSelTime','','')" alt="확정종료일"/>
						<select id="toSelTime" name="toSelTime" onchange="commonWork('strSelDate','endSelDate','frSelTime','toSelTime','','')" style="width:45px">
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
					</td>
				</tr>
			</table>
		</form>
		<div id="btCarea" style="width:600px;">
			<input type="button" id="initializeSettingBtn" value="초기화" class="btn btn_white" onclick="javascript:initializeSetting();" alt="초기화" />
			<input type="button" value="취소" class="btn btn_white" onclick="javascript:layerPopClose('layerDefiniteDelete');" alt="취소" />
			<input type="button" id="btnGoDeleteData" name="btnGoDeleteData" value="확정취소" class="btn btn_white" onclick="javascript:deleteDefiniteData();" alt="확정취소" />
		</div>
	</div>
	<!-- //선택 수정 레이어 -->
	
</body>
</html>