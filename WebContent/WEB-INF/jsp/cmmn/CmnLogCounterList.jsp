<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : CmnLogCounterList.jsp
	 * Description : 사용자웹로그 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2011.12.26	bobylone	최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 * 
	 * author bobylone
	 * since 2011.12.26
	 * 
	 * Copyright (C) 2013 by bobylone  All right reserved.
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

<script type="text/javaScript">
//<![CDATA[
	$(function () {
		var rdDay =  $('input:radio[id="day"]:checked').length;
		var rdWeek =  $('input:radio[id="week"]:checked').length;
		var rdMonth =  $('input:radio[id="month"]:checked').length;
		var rdTerm =  $('input:radio[id="term"]:checked').length;
		var rdYear =  $('input:radio[id="year"]:checked').length;
		
		if(rdDay==0 && rdWeek==0 && rdMonth==0 && rdTerm==0 && rdYear==0 ){
			$('input:radio[id="week"]').attr("checked", true);
		}
		
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
		var yday = new Date(Date.parse(today) - 12 * 1000 * 60 * 60 * 12);
// 	    var yday = new Date() - 6; 
		
		yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());
		today = today.getFullYear()+ "/" + addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		
		function addzero(n) {
			return n < 10 ? "0" + n : n + "";
		}
		
		$("#startDate").val(yday);
		$("#endDate").val(today);
		
		fnTotalCnt();
		
		// 보고리스트
		$("#layerReport").draggable({
			containment: 'body',
			scroll: false
		});
	});
	
	// 시작날짜가 종료날짜보다 크지 않도록 유효성 검사
	function checkDate(oId,sId,eId){	//startDate, startDate, endDate
		var o = $("#"+oId);
		var s = $("#"+sId); 
		var e = $("#"+eId);
		var sd = parseInt(String(s.val()).replace(/[\D]/g,""),10);
		var ed = parseInt(String(e.val()).replace(/[\D]/g,""),10);
		
		if(o.attr("id") == s.attr("id")){
			e.val(sd>ed?s.val():e.val());
		}else if(o.attr("id") == e.attr("id")){
			s.val(sd>ed?e.val():s.val());
		}
	}
	
	// 방문자수 & 페이지 수
	function fnTotalCnt(){
		
		if( validation() == false ) return;
		
		showLoading();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/cmmn/getTotalCmnLogCounter.do'/>",
			data:{},
			dataType:"json",
			success:function(result){
// 				console.log("방문자수 & 페이지 수 : ", result);
				var tot = result['ConuterMap'].length;
				var Visitors = "";
				var pages = "";
				
				if( tot <= 0 ){
					Visitors = "0 / 0";		//해당일 방문자수 / 총누적 방문자수
					pages = "0 / 0";		//해당일 페이지 방문수 / 총누적 페이지 방문수
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['ConuterMap'][i];
						
						if(i==0){
							Visitors = obj.cnt;
						}else if(i==1){
							Visitors += " / " + obj.cnt;
						}else if(i==2){
							pages = obj.cnt;
						}else{
							pages += " / " + obj.cnt;
						}
					}
				}
				$("#Visitors").html(Visitors);
				$("#pages").html(pages);
				
				fnSearch();
			},
			error:function(result){
				var oraErrorCode = "";
				if (result.responseText != null ) {
					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				$("#Visitors").html("0 / 0");
				$("#pages").html("0 / 0");
				
				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				
				closeLoading();
			}
// 			error:function(result){
// 				$("#cnt").html("오늘의 방문자 : 0 ");
// 				$("#totalCnt").html("전체의 방문자 : 0 ");
// 				$("#cnt").html("데이터 요청중 에러가 발생 하였습니다!");
// 				closeLoading();
// 			}
		});
	}
	
	//조회 처리
	function fnSearch(){
		if( validation() == false ) return;
		
		getAvgPage();
		dayDateCal();
		showLoading();
		
		var frDate = $("#startDate").val();
		var toDate = $("#endDate").val();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/cmmn/getCmnLogCounterList.do'/>",
			data:{frDate:frDate,
				  toDate:toDate},
			dataType:"json",
			success:function(result){
				var tot = result['MenuConuterList'].length;
				var item = "";
				
				$("#dataList").html("");
				
				if( tot <= 0 ){
					$("#dataList").html("<tr><td colspan='4'>조회 결과가 없습니다</td></td>");
				}else{
					for(var i=0; i < tot; i++){
					
						var obj = result['MenuConuterList'][i];
						
						item += "<tr>"
							+ "<td>" + obj.g1 + "</td>"
							+ "<td>" + obj.g2 + "</td>"
							+ "<td>" + obj.g3 + "</td>"
							+ "<td>" + obj.cnt + "</td>"
							+ "</tr>";
					}
					$("#dataList").append(item);
					$("#dataList tr:odd").attr("class","add"); 
				}
				chart();
			},
			error:function(result){
				var oraErrorCode = "";
				if (result.responseText != null ) {
					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				$("#dataList").html("<tr><td colspan='4'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}
	
	// 일간 평균 방문자수 
	function getAvgPage(){
		if( validation() == false ) return;
		
		var frDate = $("#startDate").val();
		var toDate = $("#endDate").val();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/cmmn/getAvgPage.do'/>",
			data:{
				frDate:frDate,
				toDate:toDate
			},
			dataType:"json",
			success:function(result){
// 				console.log("일간 평균 방문자수 : ", result);
				var tot = result['AvgPageMap'].length;
				var item = "";
				
				var totalPage = result['AvgPageMap'][0].cnt;
				var totalVisit = result['AvgPageMap'][1].cnt;
				var totalDay = result['AvgPageMap'][2].cnt;
				
				var avgPage = Math.round(totalPage/totalDay * 10)/10;
				var avgVisit = Math.round(totalVisit/totalDay * 10)/10;
				
				$("#AvgPage").html(avgPage);
				$("#AvgVis").html(avgVisit);
			},
			error:function(result){
				var oraErrorCode = "";
				if (result.responseText != null ) {
					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
					if (matchedValue != null && matchedValue.length > 0) {
						oraErrorCode = matchedValue[0].replace('ORA-', '');
					}
				}
				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
			}
		});
	}
	
	function validation(){
		if( $('#startDate').val() == "" ){ alert("조회 시작일자를 선택하세요"); return false; }
		if( $('#endDate').val() == "" ){ alert("조회 종료일자를 선택하세요"); return false; }
		if(!commonWork()) {return false;}
	}
	
	function commonWork() {
		var stdt = document.getElementById("startDate");
		var endt = document.getElementById("endDate");
		var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;
		
		if(endt.value != '' && stdt.value > endt.value) {
			alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			stdt.value = "";
			endt.value = "";
			stdt.focus();
			return false;
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
		return true;
	}
	
	function dayDateCal(){
		var stdt = document.getElementById("startDate").value.split("/");
		var endt = document.getElementById("endDate").value.split("/");
		var startDt = new Date(Number(stdt[0]),Number(stdt[1])-1,Number(stdt[2]));
		var endDt = new Date(Number(endt[0]),Number(endt[1])-1,Number(endt[2]));
		
		/* 일수 */
		var resultDt = Math.floor(endDt.valueOf()/(24*60*60*1000)- startDt.valueOf()/(24*60*60*1000));
		
		$("#TermInfo").html(resultDt + 1);
// 		$("#viewDate").html(startDt + " ~ " + endDt + " : 상기 조회 조건");
		$("#viewDate").html($("#startDate").val() + " ~ " + $("#endDate").val() + " : 상기 조회 조건");
	}
	
	// 라디오 버튼으로 시간 선택시 조회시간 변경
	function setSearchDate(obj){
		//alert(obj.id+", "+$("#startDate").val()+", "+$("#endDate").val());
		var id = obj.id;
		var s = $("#startDate");
		var e = $("#endDate");
		var ea = e.val().split("/");
		var sd = new Date();
		var ed = new Date(parseInt(ea[0],10),parseInt(ea[1],10)-1,parseInt(ea[2],10));
		//var y = sd.getYear();var m = sd.getMonth();var d = sd.getDate();
		//alert(id+", "+d);
		switch(id){
		case 'day' :
			sd=ed;
			//sd.setDate(ed.getDate()-1);
			break;
		case 'week' :
			sd = new Date(ed.getFullYear(),ed.getMonth(),ed.getDate()-6)
			//sd.setDate(ed.getDate()-6);
			break;
		case 'month' :
			sd = new Date(ed.getFullYear(),ed.getMonth()-1,ed.getDate()+1)
			//sd.setMonth(ed.getFullYear()-1);
			//sd.setDate(ed.getDate()+1);
			break;
		case 'term' :
			var m = ed.getMonth();
			var q = m<3?0:(m<6?1:(m<9?2:3));
			sd = new Date(ed.getFullYear(),q*3,1);
			break;
		case 'year' :
			sd = new Date(ed.getFullYear()-1,ed.getMonth(),ed.getDate()+1)
			break;
		default :
			break;
		}
		var tm = sd.getMonth()+1;var td = sd.getDate();tm = tm<10?"0"+tm:tm;td = td<10?"0"+td:td;
		s.val(sd.getFullYear()+"/"+tm+"/"+td);
		tm = ed.getMonth()+1;td = ed.getDate();tm = tm<10?"0"+tm:tm;td = td<10?"0"+td:td;
		e.val(ed.getFullYear()+"/"+tm+"/"+td);
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerReport");
	}
	
	// 보고 저장 
	function saveReport(){
		/*파라미터 설정*/
		var start_date = $("#startDate").val();
		var end_date = $("#endDate").val();
		var report = $("#report").val();
		/* 파라미터 유효성 검사*/
		if(start_date == null || start_date == ""){alert("검색 날짜를 입력하세요!");$("#startDate").focus();return;}
		if(end_date == null || end_date == ""){alert("검색 날짜를 입력하세요!");$("#endDate").focus();return;}
		if(report == null || report == ""){alert("보고사항을 입력하세요!");$("#report").focus();return;}
		start_date = start_date.replace(/[\/]/g,"");
		end_date = end_date.replace(/[\/]/g,"");
		/* ajax 실행*/
		showLoading();
		$.ajax({
			type:"post",
			url:"<c:url value='/cmmn/saveWeblogReport.do'/>",
			data:{
				start_date:start_date
				,end_date:end_date
				,report:report
			},
			dataType:"json",
			success:function(result){
				alert("저장했습니다");
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
				//$("#addrList").html("<tr><td colspan='2' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}
	
	// 보고 리스트 선택 조회
	function setReportSearch(s,e,r){
		$("#startDate").val(s);
		$("#endDate").val(e);
		$("#report").val(r);
		
		fnSearch();
		layerPopCloseAll();
	}
	
	// 보고 리스트 불러오기 
	function getReportList(){
		dataView = new Slick.Data.DataView();
		
		var columns = [
						{ id: "no", name: "NO", field: "no", width: 45, resizable: false, cssClass: "slick-pointer" },
						{ id: "start_date", name: "시작일", field: "start_date", width: 110, resizable: false, cssClass: "slick-pointer" },
						{ id: "end_date", name: "종료일", field: "end_date", width: 110, resizable: false, cssClass: "slick-pointer" },
						{ id: "reg_date", name: "생성일", field: "reg_date", width: 125, resizable: false, cssClass: "slick-pointer" }
					];
		var options = {
				enableColumnReorder: false,
				enableCellNavigation: true,
				multiColumnSort: true
		};
		
		grid = new Slick.Grid("#dataList1", dataView, columns, options);
		grid.setSelectionModel(new Slick.RowSelectionModel());
		
		grid.onSelectedRowsChanged.subscribe(function() {
			grid.resetActiveCell();
			var obj = grid.getDataItem(grid.getSelectedRows());
			setReportSearch(obj.start_date, obj.end_date, obj.report);
		});
		
		dataView.onRowCountChanged.subscribe(function (e, args) {
			grid.updateRowCount();
			grid.render();
		});
		
		grid.onSort.subscribe(function (e, args) {
			var cols = args.sortCols;
			
			dataView.sort(function (dataRow1, dataRow2) {
				for (var i = 0, l = cols.length; i < l; i++) {
					var field = cols[i].sortCol.field;
					var sign = cols[i].sortAsc ? 1 : -1;
					var value1 = dataRow1[field], value2 = dataRow2[field];
					var result = (value1 == value2 ? 0 : (value1 > value2 ? 1 : -1)) * sign;
					if (result != 0) {
						return result;
					}
				}
				return 0;
			});
			grid.invalidate();
			grid.render();
		});
		
		showLoading();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/cmmn/getWeblogReportList.do'/>",
			data:{
			},
			dataType:"json",
			success:function(result){
// 				console.log("보고 리스트 불러오기  : ", result);
				var tot = result['reportList'].length;
				
				dataView.setItems([]);
				
				var height = sGridCmn(1,result['reportList'],10);
				$("#dataList1").css("height", height + "px");
				grid.resizeCanvas();
				
				var data = [];
				
				if( tot <= 0 ){
					dataView.getItemMetadata = function () {
						return {"columns":{0:{"colspan":"*"}}};
					}
					data.push({no:"조회 결과가 없습니다."});
					dataView.setItems(data, 'no');
					
					var height = sGridCmn(1,data,1);
					$("#dataList1").css("height", height + "px");
					grid.resizeCanvas();
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['reportList'][i];
						
						obj.no = i +1;
						
						data.push(obj);
					}
					dataView.beginUpdate();
					dataView.setItems(data, 'no');
					dataView.endUpdate();
				}
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
				dataView.getItemMetadata = function () {
					return {"columns":{0:{"colspan":"*"}}};
				}
				var data = [];
				data.push({no:"서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]"});
				dataView.setItems(data, 'no');
				
				var height = sGridCmn(1,data,1);
				$("#dataList1").css("height", height + "px");
				grid.resizeCanvas();
				
				closeLoading();
			}
		});
	}
	
	function chart(){
		var width = "938";
		var height = "150";
		
		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		
		document.chartForm.target = "chartFrame";
		document.chartForm.hiddenStartDate.value = startDate;
		document.chartForm.hiddenEndDate.value	= endDate;
		document.chartForm.width.value			= width;
		document.chartForm.height.value			= height;
		
		document.chartForm.action = "<c:url value='/cmmn/CmnLogCounterChart.do'/>";
		document.chartForm.submit();
		
		closeLoading();
	}
	
	function layerRepOpen(){
		layerPopOpen('layerReport');
		getReportList();
	}
//]]>
</script>
</head>

<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="layerFullBgDiv"></div>
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
						<form id="chartForm" name="chartForm" method="post">
							<input type="hidden" name="width"/>
							<input type="hidden" name="height"/>
							<input type="hidden" name="hiddenStartDate"/>
							<input type="hidden" name="hiddenEndDate"/>
						</form>
						<form name="Form" action="" method="post">
							<input type="hidden" name="codeId"/>
							<input type="hidden" name="code"/>
						</form>
						<form name="listForm" action="/admin/cmmncode/CmmnDetailCodeList.do" method="post">
							<div class="searchBox dataSearch">
							<ul>
								<li>
									<span class="fieldName">구분</span>
									<input type="radio" class="radio" id="week" name="radioGroup" onclick="setSearchDate(this);"/><label for="week">주간</label>
									<input type="radio" class="radio" id="month" name="radioGroup" onclick="setSearchDate(this);"/><label for="month">월간</label>
									<input type="radio" class="radio" id="term" name="radioGroup" onclick="setSearchDate(this);"/><label for="term">분기</label>
									<input type="radio" class="radio" id="year" name="radioGroup" onclick="setSearchDate(this);"/><label for="year">연간</label>
								</li>
								<li>
									<span class="fieldName">조회기간</span>
									<input type="text" value="${searchVO.startDate}" id="startDate" name="startDate" size="13" onchange="commonWork()" alt="조회시작일"/>
									<span>~</span>
									<input type="text"value="${searchVO.endDate}" id="endDate" name="endDate" size="13" onchange="commonWork()" alt="조회종료일"/>
								</li>
								<li class="last">
									<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" onclick="javascript:fnSearch();" alt="조회"/>
								</li>
							</ul>
						</div>
						<div class="topBx">
							<span id="viewDate"></span>
							<input type="button" id="btnReport" name="btnReport" value="보고" class="btn btn_basic" onclick="javascript:saveReport();" alt="보고" />
							<input type="button" id="btnPrint" name="btnPrint" value="인쇄" class="btn btn_basic" onclick="javascript:window.print();" alt="인쇄" />
							<input type="button" id="btnRepSch" name="btnRepSch" value="보고조회" class="btn btn_basic" onclick="javascript:layerRepOpen();" alt="보고조회" />
						</div>
						<div class="table_wrapper">
							<table>
								<colgroup>
									<col width="25%" />
									<col width="25%" />
									<col width="25%" />
									<col width="25%" />
								</colgroup>
								<thead>
									<tr>
										<th colspan="2"><center>(<span id="TermInfo"></span> 일간) 평균 접속량</center></th>
										<th colspan="2"><center>총 누적 접속량(해당일/총 누적)</center></th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th>페이지수</th>
										<td><div id="AvgPage"></div></td>
										<th>페이지수</th>
										<td><center><div id="pages"></div></center></td>
									</tr>
									<tr>
										<th>방문자수</th>
										<td><div id="AvgVis"></div></td>
										<th>방문자수</th>
										<td><center><div id="Visitors"></div></center></td>
									</tr>
									<tr>
										<td colspan="4">
											<div class="graph">
												<iframe id="chartFrame" name="chartFrame" src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="100%"></iframe>
											</div>
										</td>
									</tr>
									<tr>
										<th colspan="4">
											상세메뉴 이용현황
										</th>
									</tr>
									<tr>
										<td colspan="4">
											<table>
												<colgroup>
													<col width="250" />
													<col width="250" />
													<col width="250" />
													<col />
												</colgroup>
												<thead>
													<tr>
														<th>대분류</th>
														<th>중분류</th>
														<th>소분류</th>
														<th>방문자</th>
													</tr>
												</thead>
												<tbody id="dataList">
													<tr>
														<td colspan="4">
															<spring:message code="common.nodata.msg" />
														</td>
													</tr>
												</tbody>
											</table>
										</td>
									</tr>
								</tbody>
							</table>
							</div>
							<table style="margin-top:20px;">
								<tbody>
									<tr> 
										<th>
											운영자 보고사항
										</th>
									</tr>
									<tr>
										<td style="padding:0px;">
											<textarea id="report" name="report" style="width:980px; height:150px; border:0px;"></textarea>
										</td>
									</tr>
								</tbody>
							</table>
						</form>
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
	<!-- 레이어 -->
	<div id="layerReport" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnReportXbox" name="btnReportXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerReport');" alt="닫기" />
		</div>
		<div style="background:#fff;">
			<div id="btArea" style="padding:10px">
				<span>보고리스트</span>
			</div>
			<div id="dataList1" class="dataList" style="width:390px; text-align:center;"></div>
		</div>
	</div>
	<!-- //레이어 -->
</body>
</html>