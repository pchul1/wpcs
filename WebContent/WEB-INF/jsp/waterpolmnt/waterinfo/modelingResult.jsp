<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : riverwater_a.jsp
	 * Description : 수질측정망정보 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2010.05.17	khany		최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 * 2014.10.27  mypark     검색개선
	 * 2014.11.14  mypark    그리드 걷어내고 테이블 처리
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
		if(user_a_cnt == 0){
// 			alert('권한이 없습니다. 측정소를 등록해주세요.');
// 			window.location = "<c:url value='/main.do'/>";
		}
	}
//<![CDATA[
	$(document).ready(function(){
	//메시지처리
	<c:if test="${not empty message }">
		alert("${message}");
	</c:if>
	});
	
	var memFactCode = "${member.factCode}";
	var memRiverDiv = "${member.riverId}";
	var firstFlag = false;
	
	$(function () {
		//초기 시작값의 현재 시각 선택
		setDate();
		
		//user 측정소권한에 따른 수계 고정
		/* if(user_roleCode == 'ROLE_ADMIN'){
			selectedSugyeInMemberId(user_riverid, 'sugye');
			
			adjustGongku();
		}else{
			selectedSugyeInMemberIdNew(id, 'A', 'sugye');
		} */
		
		//시공사일경우 해당 공구만 선택할 수 있게
		/* if(memFactCode != null && memFactCode != "") {
			$("#sys > option[value=T]").attr("selected", "true");
			$("#sys").attr("disabled", "disabled");
			
			$("#sugye > option[value="+memRiverDiv+"]").attr("selected", "true");
			$("#sugye").attr("disabled", "disabled");
		} */
		
		/* $('#sugye').change(function(){
			adjustGongku();
		});
		
		$('#factCode').change(function(){
			adjustBranchList();
		}); */
		
		$("#dataList tr:odd").attr("class","add");
		
	});
	
	function setDate() {
		var date = new Date();
		/* var hour = date.getHours();
		time=hour<10?"0"+hour:hour;
		$("#toTime option[value="+time+"]").attr("selected", "true"); */
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
		/* var time = todayObj.getHours();
		var timeStr = addzero(time-2);
		if(time <= 0)
			timeStr = "00";
		$("#frTime > option[value=" + timeStr + "]").attr("selected", "selected"); */
		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}		
		$("#startDate").val(yday);
		$("#endDate").val(today);
	}
	
	var itemCnt;
	var sItemCnt;
	var itemArray , itemCode;
	
	//테이블 헤더 생성
	function makeHeader() {
		$("#dataTable").attr("class", "dataTable");
		$("#dataTable").css("width", "900");
		
		$("#table_over").addClass("table_over");
		$("#data_table").addClass("table_overWidth");
	}
	
	var tmpSys = "";
	var tmpBItem = "";
	
	function reloadData(pageNo){
		if( validation() == false ) return;
		//setGraphBtn();
		showLoading();
		$("#dataList").html("");
		var factCode = $("#factCode").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		
		//makeHeader();
		
		if (pageNo == null) pageNo = 1;
		var dataHtml = "";
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/modelingResultList.do'/>",
			data:{
					factCode:factCode,
					frDate:frDate,
					toDate:toDate,
					pageIndex:pageNo
			},
			dataType:"json",
			success:function(result){
// 				console.log("결과 값 확인 : ",result);
				var tot = result['detailViewList'].length;
				var pageInfo = result['paginationInfo'];
				if( tot <= 0 ){
					dataHtml="<tr><td colspan='8'>조회 결과가 없습니다.</td></tr>";
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						
						/* obj.tur0 = (obj.tur0 != null && obj.tur0 != '') ? obj.tur0 : '-';
						obj.phy0 = (obj.phy0 != null && obj.phy0 != '') ? obj.phy0 : '-';
						obj.dow0 = (obj.dow0 != null && obj.dow0 != '') ? obj.dow0 : '-';
						obj.con0 = (obj.con0 != null && obj.con0 != '') ? obj.con0 : '-';
						obj.tmp0 = (obj.tmp0 != null && obj.tmp0 != '') ? obj.tmp0 : '-';
						obj.tof0 = (obj.tof0 != null && obj.tof0 != '') ? obj.tof0 : '-';
						
						obj.tur = (obj.tur != null && obj.tur != '') ? obj.tur : '-';
						obj.phy = (obj.phy != null && obj.phy != '') ? obj.phy : '-';
						obj.dow = (obj.dow != null && obj.dow != '') ? obj.dow : '-';
						obj.con = (obj.con != null && obj.con != '') ? obj.con : '-';
						obj.tmp = (obj.tmp != null && obj.tmp != '') ? obj.tmp : '-';
						obj.tof = (obj.tof != null && obj.tof != '') ? obj.tof : '-';
						
						obj.tur2 = (obj.tur2 != null && obj.tur2 != '') ? obj.tur2 : '-';
						obj.phy2 = (obj.phy2 != null && obj.phy2 != '') ? obj.phy2 : '-';
						obj.dow2 = (obj.dow2 != null && obj.dow2 != '') ? obj.dow2 : '-';
						obj.con2 = (obj.con2 != null && obj.con2 != '') ? obj.con2 : '-';
						obj.tmp2 = (obj.tmp2 != null && obj.tmp2 != '') ? obj.tmp2 : '-';
						obj.tof2 = (obj.tof2 != null && obj.tof2 != '') ? obj.tof2 : '-'; */

						dataHtml += "<tr>";
						dataHtml += "<td>" + obj.no +"</td>";
						dataHtml += "<td>" + obj.factName +"</td>";
						dataHtml += "<td>" + obj.modelDate +"</td>";
						
						dataHtml += "<td>" + obj.mesuValu +"</td>";
						dataHtml += "<td>" + obj.predValu1 +"</td>";
						dataHtml += "<td>" + obj.predValu2 +"</td>";
						dataHtml += "<td>" + obj.nierFrom +"</td>";
						dataHtml += "<td>" + obj.nierTo +"</td>";
							
						dataHtml +="</tr>";
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
				var dataHtml="<tr><td colspan='8'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				closeLoading();
			}
		});
	}
	
	function validation(){
		if( $('#startDate').val() == "" ){ alert("조회 시작일자를 선택하세요"); return false; }
		if( $('#endDate').val() == "" ){ alert("조회 종료일자를 선택하세요"); return false; }
		//if(!timeCheck()) {return false;}
	}
	
	/* function timeCheck() {
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
	} */
	
	function commonWork(n) {
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
			if($(n).attr("id") == "startDate") {endt.value = ""; endt.focus();}
			if($(n).attr("id") == "endDate") {stdt.value = ""; stdt.focus();}
		}
		
		/* if(endt.value != '' && strdate < endt.value) {
			alert("조회 기간은 한달 이내 입니다.\n\n다시 입력해 주십시오.");
			if($(n).attr("id") == "startDate") {endt.value = ""; endt.focus();}
			if($(n).attr("id") == "endDate") {stdt.value = ""; stdt.focus();}
		} */
		
		//timeCheck();
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

	function chartPopup() {
		if( validation() == false ) return;
		if( $('#factCode').val() == "" ){ alert("조회지점을 선택하세요"); return false; }
		
		var factCode = $("#factCode").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 800;
		var winWidth = 1000;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-20;
		var height = winHeight-20;
		
		var param = "factCode=" + factCode 
			+ "&frDate=" + frDate 
			+ "&toDate=" + toDate 
			+ "&width=" + (winWidth-40) 
			+ "&height=" + (winHeight-40); 
		
		window.open("<c:url value='/waterpolmnt/waterinfo/modelingChart.do'/>?"+encodeURI(param), 
				'chartDetailViewModeling','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	// 페이지 번호 클릭	
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
					
					<!-- 하천 수질 조회 -->
					<form:form commandName="searchTaksuVO" name="listFrm" id="listFrm" method="post">
						<input type="hidden" name="pageIndex" id="pageIndex" value="${searchTaksuVO.pageIndex}"/>
						<input type="hidden" name="frDate" id="frDate"/>
						<input type="hidden" name="toDate" id="toDate"/>
							<div class="searchBox dataSearch">
							<ul>
								<li>
									<span class="fieldName">조회지점</span>
									<select class="fixWidth7" name="factCode" id="factCode">
											<option value="">전체</option>
											<option value="2011801">칠곡보</option>
											<option value="2011802">강정고령보</option>
											<option value="2017801">창령·함안보</option>
									</select>
									<!-- <span>&gt;</span>
										<select class="fixWidth11" id="factCode">
											<option value="all">전체</option>
										</select>
									<span style="display:none;">&gt;</span>
									<select class="fixWidth11" id="branchNo" name="branchNo" disabled="disabled" style="display:none;">
										<option value="all">전체</option>
									</select> -->
								</li>
								<li>
									<span class="fieldName">조회기간</span>
									<input type="text" size="13" id="startDate" name="startDate" onchange="commonWork(this)"/>
									<!-- <select id="frTime" name="frTime" onchange="commonWork(this)" style="width:45px">
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
									</select> -->
									<span>~</span>
									<input type="text" size="13" id="endDate" name="endDate" onchange="commonWork(this)"/>
									<!-- <select id="toTime" name="toTime" onchange="commonWork(this)" style="width:45px">
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
									</select> -->
									<!-- <label>&nbsp;최근 <input type="checkbox" name="lately" id="lately" checked="checked"/></label>	확인할것 -->
								</li>
								<!-- //측정망 전용페이지로 변경 - 2010. 10. 07
									<select id="minorCheck" name="minor">
										<option value="all">전체(기준초과)</option>
										<option value="0">정상</option>
										<option value="1">기준초과</option>
									</select>
										-->
								<!-- <li>
									<span class="fieldName">유효성구분</span>
									<select id="validFlag" name="valid">
										<option value="all" selected="selected">전체데이터</option>
										<option value="Y">유효데이터</option>
									</select>
								</li> -->
								<!-- <li>
									<span class="fieldName">항목구분</span>
									<select id="item" name="bItem" style="width:126px">
										<option value="all">전체</option>
										<option value="COM1">일반항목</option>
										<option value="BIO1">생물독성(물고기)</option>
										<option value="BIO2">생물독성(물벼룩1)</option>
										<option value="BIO3">생물독성(물벼룩2)</option>
										<option value="BIO4">생물독성(미생물)</option>
										<option value="BIO5">생물독성(조류)</option>
										<option value="CHLA">클로로필-a</option>
										<option value="VOCS">휘발성 유기화합물</option>
										<option value="METL">중금속</option>
										<option value="PHEN">페놀</option>
										<option value="ORGA">유기물질</option>
										<option value="NUTR">영양염류</option>
										<option value="RAIN">강수량계</option>
									</select>
								</li> -->
									<!-- 
										<dt><label for="">대항목</label></dt>
										<dd>
											<select id="bitem" name="bitem" disabled="true">
												<option value="1">일반항목</option>
											</select>
										</dd>
										<dt>소항목</dt>
										<dd>
											<ul class="checkList">
												<li id="sys0"><input type="checkbox" class="inputCheck" id="i1" checked="checked" /><label for="">탁도</label></li>
												<li id="sys1"><input type="checkbox" class="inputCheck" id="i2" checked="checked"/><label for="">DO</label></li>
												<li id="sys2"><input type="checkbox" class="inputCheck" id="i3" checked="checked"/><label for="">수온</label></li>
												<li id="sys3"><input type="checkbox" class="inputCheck" id="i4" checked="checked"/><label for="">pH</label></li>
												<li id="sys4"><input type="checkbox" class="inputCheck" id="i5" checked="checked"/><label for="">전기전도도</label></li>
											</ul>
										</dd>
										 -->
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
						</div>
						</form:form>
						<!-- //하천 수질 조회 -->
						<div id="btArea">
							<span id="p_total_cnt">[총 ${totCnt}건]</span>
							<input name="a_chartPopup" class="btn btn_graph" id="a_chartPopup" onclick="javascript:chartPopup()" type="button" alt="그래프">
							<!-- <input type="button" id="btnBasic" name="btnBasic" class="btn btn_excel" onclick="javascript:excelDown()" /> -->
						</div>
						<div class="table_wrapper">
							<div id="table_over">
								<span style="float:right;font-weight:bold;padding-right:5px">Chl-a(μg/L)</span>
								<table id="dataTable" summary="게시판 구분 , 기본정보, 수질정보가 담김">
									<colgroup id="colWidth">
										<col width='45' />
										<col width='160' />
										<col width='130' />
										<col width='130' />
										<col width='130' />
										<col width='130' />
										<col width='100' />
										<col width='100' />
									</colgroup>
									<thead>
										<tr>
											<th rowspan='2' scope='col'>NO</th>
											<th rowspan='2' scope='col'>지점명</th>
											<th rowspan='2' scope='col'>검사년월일</th>
											<th rowspan='2' scope='col'>실측값</th>
											<th rowspan='2' scope='col'>회귀분석</th>
											<th rowspan='2' scope='col'>요인분석+회귀분석</th>
											<th colspan='2' scope='col'>과학원예측범위</th>
										</tr>
										<tr>
											<th>최소</th>
											<th>최대</th>
										</tr>
									</thead>
									<tbody id="dataList">
									</tbody>
								</table>
							</div>
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