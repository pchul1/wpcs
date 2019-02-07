<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : riverwater3hourwarning.jsp
	 * Description : 경보지속지점조회 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2010.05.17	khany		최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 * 2014.10.27  mypark    페이징 처리 및 검색 개선
	 * 2014.11.13  mypark    그리드 걷어내고 테이블 처리
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
	//관리자 외에 등록 된 측정소가 없을 경우 메인으로 이동
	if(user_roleCode != 'ROLE_ADMIN'){
		if(user_u_cnt == 0){
// 			alert('권한이 없습니다. 측정소를 등록해주세요.');
// 			window.location = "<c:url value='/main.do'/>";
		}
	}
//<![CDATA[
	var frDate = "${riverWater3HourWarningSearchVO.frDate}";
	var toDate = "${riverWater3HourWarningSearchVO.toDate}";
	var frTime = "${riverWater3HourWarningSearchVO.frTime}";
	var toTime = "${riverWater3HourWarningSearchVO.toTime}";
	
	var system = "${riverWater3HourWarningSearchVO.sys_kind}";
	var branch = "${riverWater3HourWarningSearchVO.branch_no}";
	var fact = "${riverWater3HourWarningSearchVO.fact_code}";
	var sugye = "${riverWater3HourWarningSearchVO.river_div}";
	
	var alert_level = "${riverWater3HourWarningSearchVO.alert_level}";
	
	var item_1 = "${riverWater3HourWarningSearchVO.item01}";
	var item_2 = "${riverWater3HourWarningSearchVO.item02}";
	var item_3 = "${riverWater3HourWarningSearchVO.item03}";
	var item_4 = "${riverWater3HourWarningSearchVO.item04}";
	var item_5 = "${riverWater3HourWarningSearchVO.item05}";
	
	var item1 = "TUR";
	var item2 = "DOW";
	var item3 = "TMP";
	var item4 = "PHY";
	var item5 = "CON";
	var reloadCheck = false;
	var alertTime = "${riverWater3HourWarningSearchVO.alertTime}";
	
	$(function () {
		$("#sys>option[value='"+system+"']").attr("selected", "selected");
		$("#sugye>option[value='"+sugye+"']").attr("selected", "selected");
		$("#alertTime>option[value='" + alertTime + "']").attr("selected", "selected");

		setDate();
		//user 측정소권한에 따른 수계 고정
		if(user_roleCode == 'ROLE_ADMIN'){
			selectedSugyeInMemberId(user_riverid, 'sugye');
			
			adjustGongku();
		}else{
			selectedSugyeInMemberIdNew(id, 'U', 'sugye');
		}
		
		$('#sugye').change(function(){
			adjustGongku();
		});
		
		$('#factCode').change(function(){
			adjustBranch();
		});
		//reloadData();
	});
	
	function setDate(){
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
		var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 24);
		yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" +  addzero(yday.getDate());
		today = today.getFullYear()+ "/" + addzero(today.getMonth()+1) +"/" + addzero(today.getDate());
		
		function addzero(n) {
			return n < 10 ? "0" + n : n + "";
		}
		
		if(frDate != "" && frTime != ""){
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
	
	function adjustGongku(){
		var sugyeCd = $('#sugye').val();
		var sys_kind = 'U';
		var dropDownSet = $('#factCode');
		var dropDownSet_branchNo = $('#branchNo');
		if( sugyeCd == 'all' || sys_kind == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#factCode>option:first").attr("selected", "true");
			dropDownSet_branchNo.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");
			//dropDownSet.emptySelect();
		}else{
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>",
					{sugye:sugyeCd, system:sys_kind}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect(data.gongku);
					
					adjustBranchListNew();
				} else {
					alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
	}
	
	//측정소 목록 가져오기
	function adjustBranch(){
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
					if(typeof(adjustItemList) == "function") {
						adjustItemList();
					}
					if(branch != "") {
						$("#branchNo>option[value='"+branch+"']").attr("selected", "selected");
					} else {
						$("#branchNo>option[value="+data.branch[0].VALUE+"]").attr("selected", "selected");
					}
					if(!reloadCheck){
						reloadCheck = true;
						reloadData(1);
					}
				} else { 
					 alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
		//2014-10-27 mypark 검색 개선
		$("#factCode").hide();
	}
	
	function adjustBranchListNew(){
		var url = "";
		
		if(user_roleCode == 'ROLE_ADMIN'){
			url = "<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>";
		}else{
			url = "<c:url value='/waterpolmnt/waterinfo/getBranchListNew.do'/>";
		}
		
		var factCode = $('#factCode').val();
		var sys_kind = $("#sys").val();
		var dropDownSet = $('#branchNo');
		if( factCode == 'all' || sys_kind == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");
		}else{
			dropDownSet.attr("disabled", false);
			$.getJSON(url, {factCode:factCode}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect_all(data.branch);
					if(typeof(adjustItemList) == "function") {
						adjustItemList();
					}
					if(branch != "") {
						$("#branchNo>option[value='"+branch+"']").attr("selected", "selected");
					} else {
						$("#branchNo>option[value="+data.branch[0].VALUE+"]").attr("selected", "selected");
					}
					if(!reloadCheck){
						reloadCheck = true;
						reloadData(1);
					}
				} else { 
					 alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
		//2014-10-27 mypark 검색 개선
		$("#factCode").hide();
	}
	
	function reloadData(pageNo){
		showLoading();
		if (pageNo == null) {
			pageNo = 1;
		}
		if( validation() == false ) return;
		var rType = $("#dataType").val();
		var sugye = $("#sugye").val();
		var gongku = $("#factCode").val();
		var chukjeongso = $("#branchNo").val();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var sys_kind = $("#sys").val();
		var alert_level = $("#alert_level").val();
		var rType = 2;
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getRiverWater3HourWarning.do'/>",
			data:{
					river_div:sugye, 
					fact_code:gongku,
					branch_no:chukjeongso,
					frDate:frDate,
					toDate:toDate,
					frTime:frTime,
					toTime:toTime,
					alert_level:alert_level,
					sys_kind:sys_kind,
					pageIndex:pageNo
			},
			dataType:"json",
			success:function(result){
//  				console.log("결과 값 확인 : ",result);
				var tot = result['dataList'].length;
				var pageInfo = result['paginationInfo'];
				var dataHtml="";
				var data = [];
				if( tot <= 0 ){
					dataHtml="<tr><td colspan='6'>조회 결과가 없습니다.</td></tr>";
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['dataList'][i];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						var factname = obj.fact_name.replace(obj.river_name, "");
						factname = factname.replace("_", "");
						factname = factname.replace("-", "");
						obj.factname = factname;
						obj.min_vl = (obj.min_vl == "") ? "-" : obj.min_vl;

						dataHtml += "<tr>";
						dataHtml += "<td>" + obj.no +"</td>";
						dataHtml += "<td>" + obj.river_name +"</td>";
						dataHtml += "<td>" + obj.branch_name +"</td>";
						dataHtml += "<td>" + obj.alert_time +"</td>";
						dataHtml += "<td>" + obj.alert_level +"</td>";
						dataHtml += "<td>" + obj.alert_msg +"</td>";
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
				$("#p_total_cnt").html("[총 " + result['totCnt'] + "건] <span class='red'>※조회결과는 확정자료가 아닙니다.</span>");
				closeLoading();
			},
			error:function(result){
				closeLoading();
				var oraErrorCode = "";
				if (result.responseText != null ) {
					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				var dataHtml="<tr><td colspan='6'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
			}
		});
	}
	
	function detailPopup(obj) {
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 600;
		var winWidth = 450;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		
		var alertTime = $("#alertTime").val();
		s_alertTime = $("#alertTime").val();
		
		var param = "alertTime="+s_alertTime+"&river_div="+obj.river_div+"&fact_code="+obj.fact_code+"&as_id="+obj.as_id+"&branch_no="+obj.branch_no + "&branch_name=" +obj.branch_name + "&sys_kind="+obj.sys_kind + "&frDate="+obj.frDate + "&toDate="+obj.toDate + "&frTime="+obj.frTime + "&toTime="+obj.toTime;
		param = encodeURI(param);
			
		var src = "<c:url value='/waterpolmnt/waterinfo/goRiverWater3HourWarningPopDetail.do'/>?" + param;
		//window.open(src, 
			//	'RiverWater3HourWarningDetail','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
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
			if(frTime > toTime){
				alert("종료시간이 시작시간보다 빠릅니다.\n\n다시 입력해 주십시오.");
				$("#frTime").val("");
				$("#toTime").val("");
				$("#frTime").focus();
				return false;
			}
		}
		return true;
	}
	
	function commonWork(n) {
		var stdt = document.getElementById("startDate");
		var endt = document.getElementById("endDate");
		var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;
		
		var date = new Date(stdt.value).getTime();
		var overdate =  new Date(date + (60*60*24*31)*1000);
		var strdate = overdate.getFullYear()+ "/" + addzero(overdate.getMonth()+1) + "/" + addzero(overdate.getDate());
		
		if(endt.value != '' && stdt.value > endt.value) {
			alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			if($(n).attr("id") == "startDate") {endt.value = ""; endt.focus();}
			if($(n).attr("id") == "endDate") {stdt.value = ""; stdt.focus();}
		}
		
		if(endt.value != '' && strdate < endt.value) {
			alert("조회 기간은 한달 이내 입니다.\n\n다시 입력해 주십시오.");
			if($(n).attr("id") == "startDate") {endt.value = ""; endt.focus();}
			if($(n).attr("id") == "endDate") {stdt.value = ""; stdt.focus();}
		}
		if(stdt.value !=''){
			if(dateCheck.test(stdt.value)!=true){
				alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
				stdt.value = "";
				stdt.focus;
				return false;
			}
		}
		if(endt.value !=''){
			if(dateCheck.test(endt.value)!=true){
				alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
				endt.value = "";
				endt.focus;
				return false;
			}
		}
		timeCheck();
	}
	
	
	function linkPage(pageNo){
		reloadData(pageNo);
	}
	
	function excelDown() {
		if( validation() == false ) return;
		var sugye = $("#sugye").val();
		var alert_level = $("#alert_level").val();
		var gongku = $("#factCode").val();
		var chukjeongso = $("#branchNo").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		var sys = $("#sys").val();
		var param = "river_div=" + sugye + "&fact_code=" + gongku + "&branch_no=" + chukjeongso +
		"&frDate=" + frDate + "&toDate=" + toDate + "&frTime=" + frTime + "&toTime=" + toTime + 
		"&sys_kind=" + sys + "&alert_level=" + alert_level;
		location.href="<c:url value='/waterpolmnt/waterinfo/getExcelWarning.do'/>?"+param;
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
					<form:form commandName="riverWater3HourWarningSearchVO" name="listFrm" id="listFrm" method="post">
						<input type="hidden" name="pageIndex" id="pageIndex" value="${riverWater3HourWarningSearchVO.pageIndex}"/>
						<input type="hidden" name="river_div" id="river_div"/>
						<input type="hidden" name="fact_code" id="fact_code"/>
						<input type="hidden" name="branch_no" id="branch_no"/>
						<input type="hidden" name="item01" id="item01"/>
						<input type="hidden" name="item02" id="item02"/>
						<input type="hidden" name="item03" id="item03"/>
						<input type="hidden" name="item04" id="item04"/>
						<input type="hidden" name="item05" id="item05"/>
						
						<div class="searchBox dataSearch">
							<ul>
								<li>
									<span class="fieldName">측정소 위치</span>
									<select class="fixWidth7" id="sugye">
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
									<span id="spanFact" style="display:none;">&gt;</span>
									<select class="fixWidth11"id="factCode" style="display:none;">
										<option value="all">전체</option>
									</select>
									<span  id="spanBranch">&gt;</span>
									<select class="fixWidth11" id="branchNo">
										<option value="all">전체</option>
									</select>
								</li>
								
								
								<li>
									<span class="fieldName">경보 단계</span>
									<select class="fixWidth7" id="alert_level">
										<option value="all">전체</option>
										<option value="1">관심</option>
										<option value="2">주의</option>
										<option value="3">경계</option>
										<option value="4">심각</option>
										<option value="L">위치이탈</option>
									</select>
								</li>
								
								<li style="display:none;">
									<select class="fixWidth13" id="sys" name="sys_kind">
										<option value="U" selected="selected">이동형측정기기</option>
									</select>
								</li>
								<li>
									<span class="fieldName">조회기간</span>
									<input type="text" size="13" id="startDate" name="startDate" onchange="commonWork(this)"/>
									<select id="frTime" name="frTime" onchange="commonWork(this)">
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
									<input type="text" size="13" id="endDate" name="endDate" onchange="commonWork(this)"/>
									<select id="toTime" name="toTime" onchange="commonWork(this)">
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
<!-- 								<li> -->
<!-- 									<span>경보시간</span> -->
<!-- 									<select id="alertTime" name="alertTime" style="fixWidth6"> -->
<!-- 										<option value="1">3</option> -->
<!-- 										<option value="2">6</option> -->
<!-- 										<option value="3">12</option> -->
<!-- 									</select> -->
<!-- 									<span>시간 지속</span> -->
<!-- 								</li> -->
								<!-- 항목선택이 사용되지 않음-display:none처리 (다시 쓰일수도 있기때문에) -->
								<li style="display:none">
									<span class="fieldName">대항목</span>
									<select id="bitem" name="bitem" disabled="disabled">
										<option value="1">일반항목</option>
									</select>
									<span class="fieldName">소항목</span>
										<ul class="checkList">
											<!--<li><input type="checkbox" id="chkItem1" checked="checked" /><label for="">탁도</label></li>
											<li><input type="checkbox" id="chkItem2" /><label for="">전기전도도</label></li>-->
											<li id="sys0"><input type="checkbox" id="i1" checked="checked" /><label for="">탁도</label></li>
											<li id="sys1"><input type="checkbox" id="i2" checked="checked"/><label for="">DO</label></li>
											<li id="sys2"><input type="checkbox" id="i3" checked="checked" /><label for="">수온</label></li>
											<li id="sys3"><input type="checkbox" id="i4" checked="checked"/><label for="">pH</label></li>
											<li id="sys4"><input type="checkbox" id="i5" checked="checked"/><label for="">전기전도도</label></li>
										</ul>
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
<!-- 							<a href="javascript:reloadData();" id="btnSearch" name="btnSearch" class="btn roundBox" style="float:right;">조회하기</a> -->
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
						</div>
						</form:form>
						<!-- //하천 수질 조회 -->
						
						<div id="btArea">
							<span id="p_total_cnt">[총 ${totCnt}건]</span>
							<input type="button" id="excel" name="excel" class="btn btn_excel" onclick="javascript:excelDown();" alt="엑셀"/>
						</div>
						<div class="table_wrapper">
							<table summary="게시판 목록. 번호, 수계,측정소명, 경보발생시간, 경보단계, 경보내용가 담김">
								<colgroup>
									<col width="45" />
									<col width="100" />
									<col width="110" />
									<col width="150" />
									<col width="75" />
									<col />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">No</th>
										<th scope="col">수계</th>
										<th scope="col">측정소명</th>
										<th scope="col">경보발생시간</th>
										<th scope="col">경보단계</th>
										<th scope="col">경보내용</th>
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