<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : itemCalcList.jsp
	 * Description : 방제물품정산관리 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2013.11.06	lkh			리뉴얼
	 * 
	 * author lkh
	 * since 2013.11.06
	 * 
	 * Copyright (C) 2013 by lkh All right reserved.
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
	var calcDate = "";			// 정산일
	var search_date_start = "";	// 검색 시작일
	var search_date_end = "";	// 검색 종료일
	
	$(function () {
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yymmdd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		
		$("#search_date_start").datepicker({  buttonText: '시작일' });
		$("#ListSearch_date_start").datepicker({  buttonText: '시작일' });
		
		$("#search_date_end").datepicker({  buttonText: '종료일' });
		$("#ListSearch_date_end").datepicker({  buttonText: '종료일' });
		
		$("#calcDate").datepicker({ buttonText: '정산일' });
		
		var today = new Date(); 
		var yday	 = new Date(Date.parse(today) - 120  * 1000 * 60 * 60 * 24);  // 120일 ..	4달전쯤.. 
		var listSday = new Date(Date.parse(today) - 365 * 1000 * 60 * 60 * 24); // 365일  1년 이전 날짜로 세팅 
// 		var listSday = new Date(Date.parse(today) - 365 * 1000 * 60 * 60 * 24 * 4); // 365일  1년 이전 날짜로 세팅 
		
		yday = yday.getFullYear()+ addzero(yday.getMonth()+1) + addzero(yday.getDate());
		today = today.getFullYear()+ addzero(today.getMonth()+1) + addzero(today.getDate());
		listSday = listSday.getFullYear()+ addzero(listSday.getMonth()+1) + addzero(listSday.getDate());
		
		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}
		
		if(search_date_start != null && search_date_start != ""){
			$("#search_date_start").val(search_date_start);
			$("#ListSearch_date_start").val(search_date_start);
		}else{
			$("#search_date_start").val(yday);
			$("#ListSearch_date_start").val(listSday);
		}
		
		if(search_date_end != null && search_date_end != ""){
			$("#search_date_end").val(search_date_end);
			$("#ListSearch_date_end").val(search_date_end);
		}else{
			$("#search_date_end").val(today);
			$("#ListSearch_date_end").val(today);
		}
		if(calcDate != null && calcDate != "")
			$("#calcDate").val(calcDate);
		else
			$("#calcDate").val(today);
		
		// dataLoad();
		sumCost();
		getWareHouseList();
		listSearch();
		
		//20140303 slickgrid 이광복 추가.
		dataView = new Slick.Data.DataView();
		
		var buttonFormatter = function (row, cell, value, columnDef, dataContext) {
			var s = "<input type='button' id='btnPrint' name='btnPrint' value='발행' class='btn btn_basic' onclick=javascript:calc_Printing('"+dataContext.costSdate+"','"+dataContext.costEdate+"') alt='발행' />";
			
			return s;
		};
		
		var columns = [
						{ id: "dateValue", name: "기간", field: "dateValue", width: 150,  sortable: true },
						{ id: "costDiv", name: "정산구분명", field: "costDiv", width: 180, sortable: true },
						{ id: "totalCost", name: "방재물품총비용", field: "totalCost", width: 150, sortable: true, cssClass: "text-align-right" },
						{ id: "choiceg", name: "발행", field: "choice", width: 90, formatter: buttonFormatter, /* sortable: true */}
					];
		var options = {
				enableCellNavigation: true,
				enableColumnReorder: false,
				multiColumnSort: true
		};
		
		grid = new Slick.Grid("#dataList", dataView, columns, options);
		
		grid.setSelectionModel(new Slick.RowSelectionModel());
		
		grid.onSelectedRowsChanged.subscribe(function() {
			grid.resetActiveCell();
		});
		
		dataView.onRowCountChanged.subscribe(function (e, args) {
			grid.updateRowCount();
			grid.render();
		});
		
		dataView.onRowsChanged.subscribe(function (e, args) {
			grid.invalidateRows(args.rows);
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
		$("#dataList tr:odd").attr("class","add");
	});
	
	// 입력폼 초기화
	function addRow(){
		
		$("#costDiv").val("");
		$("#totalItemCost").val("");
		$("#costResult").html("");
		
	}
	
	// 입력폼에 있는 값 삭제
	function delRow(){
		$("#mode").val("delete");
	}
	
	// 입력폼에 있는 데이터 저장 / 수정
	function save(){
		var calcDiv = $("#costDiv").val();
		var calcOption = $("#calcOption").val();
		var totalCost = $("#hidTotalItemCost").val();
		var search_date_start = $("#search_date_start").val();
		var search_date_end = $("#search_date_end").val();
		
		var pageNo = $("#pageNo").val();
		
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/mergeItemCalc.do'/>",
			data: {
					calcDiv:calcDiv,
					calcOption:calcOption,
					totalCost:totalCost,
					costSdate:search_date_start,
					costEdate:search_date_end
				},
			dataType:"json",
			success : function(result){
						alert('반영되었습니다.');
						listSearch();
			}
		});
		listSearch();
	}
	
	// 정산목록 불러오기 
	/*
	function getWareHouseCalcList(){
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/ItemCalcTotalList.do'/>", 
			data: {},
			dataType:"json",
			success : function(result){
				
				var tot = result['totalCalcList'].length;
				
				if( tot <= 0 ){
						$("#costTotalResult").html("<tr><td colspan='4'> 정산 내역 없음 </td></tr>");
					}else{
						
						$("#costTotalResult").html("");
					
						for(var i=0; i < tot; i++){
							var obj = result['totalCalcList'][i];
							var item = "<tr>" 
										+"<td style=\"text-align:center;\">"+obj.costSdate+"&nbsp;~&nbsp;"+obj.costEdate+"</td>"
										+"<td style=\"text-align:center;\">"+obj.costDiv+"&nbsp;</td>"
										+"<td style=\"text-align:right;\">"+comma(obj.totalCost)+" 원 &nbsp;</td>"
										+"<td style=\"text-align:center;\"><input type='button' value='보기' alt='보기' onClick='javaScript:alert("+obj.calc_seq+");'></td>"
									  +"</tr>";
							$("#costTotalResult").append(item);
						}
							$("#costTotalResult tr:odd").attr("class","add");
					}
				}
			});
		}
	*/
	// 확인Btn action
	function sumCost(){
		var costDiv = $("#costDiv").val();				// 정산구분
		var calcOption = $("#calcOption").val();		// 구분	 itemRele(출고) , itemStor(입고)
	// var calcFact = $("#wareHouse2").val();			// 창고구분
		var search_date_start = $("#search_date_start").val(); // 정산기간 (시작일)
		var search_date_end = $("#search_date_end").val();	// 정산기간 (종료일)
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/ItemCalcProc.do'/>",
			data: {
				calcDiv:costDiv,
				calcOption:calcOption,
				costSdate:search_date_start,
				costEdate:search_date_end
				},
			dataType:"json",
			success : function(result){
				var tot = result['costResultList'].length;
				
				if( tot <= 0 ){
					$("#costResult").html("<tr><td colspan='4'>조회 결과 없음 (정산기간, 구분을 확인해주세요.)</td></tr>");
				}else{
					$("#costResult").html("");
					var totalPrice = 0;
					for(var i=0; i < tot; i++){
						var obj = result['costResultList'][i];
						var item = "<tr>" 
									+ "<td style='text-align:center;'>" + obj.date_ + "&nbsp;</td>"
									+ "<td style='text-align:left;'>" + obj.item_name + "&nbsp;</td>"
									+ "<td style='text-align:right;'>" + obj.amt + "&nbsp;</td>"
									+ "<td style='text-align:right;'>" + comma(obj.item_price) + "&nbsp;</td>"
									+ "</tr>";
						$("#costResult").append(item);
						totalPrice = totalPrice + parseInt(obj.item_price);
					}
						$("#costResult tr:odd").attr("class","add");
						document.calCForm.totalItemCost.value = comma(totalPrice)+" 원";
						document.calCForm.hidTotalItemCost.value = totalPrice; 
				}
			}
		});
	}
	
	function listSearch(){
		showLoading();
		
		var search_Sdate = $("#ListSearch_date_start").val();
		var search_Edate = $("#ListSearch_date_end").val();
		var search_Text = $("#ListSearch_Text").val();
		var hidListNum = $("#hidListNum").val();
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/ItemCalcTotalList.do'/>", 
			data: {
				costSdate:search_Sdate,
				costEdate:search_Edate,
				calcTitle:search_Text,
				pageIndex:hidListNum
				},
			dataType:"json",
			success : function(result){
// 				console.log("ItemCalcTotalList : ",result);
				var tot = result['totalCalcList'].length;
				var pageInfo = result['paginationInfo'];
				
				dataView.setItems([]);
				$("#searchResult").hide();
				
				var height = sGridCmn(1,result['totalCalcList'],20);
// 				height += 17;	//컬럼의 width사이즈가 화면영역 보다 큰 경우 하단 스크롤을 위해 15를 더해준다.(예.기본 contants width가 900인데 이보다 큰경우)
				$("#dataList").css("height", height + "px");
				grid.resizeCanvas();
				
				var data = [];
				
				if( tot <= 0 ){
					$("#searchResult").show();
					$("#dataList").css("height", "25px");
					$("#resultText").html("조회 결과가 없습니다.");
				} else {
					for(var i=0; i < tot; i++){
						
						var obj = result['totalCalcList'][i];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						
						obj.dateValue = obj.costSdate + " ~ " + obj.costEdate;
						obj.totalCost = comma(obj.totalCost) + " 원 ";
						
						data.push(obj);
					}
					dataView.beginUpdate();
					dataView.setItems(data, 'no');
					dataView.endUpdate();
				}
				var pageStr = makePaginationInfo(result['paginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);
				
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
				$("#searchResult").show();
				$("#dataList").css("height", "25px");
				$("#resultText").html("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				
				closeLoading();
			}
		});
	}
	
	// 목록에서 클릭시 ...
	function clickItemList(p_calcDate, p_calcSeq, p_calcOrg, p_labCost, p_fuleCost, p_itemCost, p_equUseCost, p_tranCost, p_etcCost, p_totCost ){
		$("#calcDate").val(p_calcDate);
		$("#calcSeq").val(p_calcSeq);
		$("#calcOrg2").val(p_calcOrg);
		$("#labCost").val(comma(p_labCost));
		$("#fuleCost").val(comma(p_fuleCost));
		$("#itemCost").val(comma(p_itemCost));
		$("#equUseCost").val(comma(p_equUseCost));
		$("#tranCost").val(comma(p_tranCost));
		$("#etcCost").val(comma(p_etcCost));
		$("#totCost").val(comma(p_totCost));
		
		$("#mode").val("update");
	}
	
	// 데이터 목록 불러오기
	function dataLoad(pageNo){
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/itemCalcDataList.do'/>",
			data: {
					startDate:$('#search_date_start').val(),
					endDate:$('#search_date_end').val(),
					pageIndex:pageNo
				},
			dataType:"json",
			beforeSend : function(){
				$("#dataList").html("");
				$("#dataList").html("<tr><td colspan='10'>데이터를 불러오는 중 입니다...</td></tr>");	
				},
			success : function(result){
				var tot = result['list'].length;
				
				if( tot <= 0 ){
					$("#dataList").html("<tr><td colspan='10'>조회 결과 없음 (조회 기간등 검색 조건을 확인해주세요.)</td></tr>");
				}else{
					$("#dataList").html("");
					for(var i=0; i < tot; i++){
						var obj = result['list'][i];
						var item;
						
						item = "<tr style='cursor:hand' onclick=\"clickItemList('"+obj.calcDate+"','"+obj.calcSeq+"','"+obj.calcOrg+"','"+
								obj.labCost+"','"+obj.fuleCost+"','"+obj.itemCost+"','"+obj.equUseCost+"','"+obj.tranCost+"','"+obj.etcCost+"','"+obj.totCost+"')\">" 
								+"<td class='num'><span>"+obj.num+"</span></td>"
								+"<td>"+obj.calcDate+"</td>"
								+"<td>"+obj.calcOrg+"</td>"
								+"<td style=\"text-align:right;\">"+comma(obj.totCost)+"&nbsp;</td>"
								+"<td style=\"text-align:right;\">"+comma(obj.labCost)+"&nbsp;</td>"
								+"<td style=\"text-align:right;\">"+comma(obj.fuleCost)+"&nbsp;</td>"
								+"<td style=\"text-align:right;\">"+comma(obj.itemCost)+"&nbsp;</td>"
								+"<td style=\"text-align:right;\">"+comma(obj.equUseCost)+"&nbsp;</td>"
								+"<td style=\"text-align:right;\">"+comma(obj.tranCost)+"&nbsp;</td>"
								+"<td style=\"text-align:right;\">"+comma(obj.etcCost)+"&nbsp;</td>"
								+"</tr>";
								
						$("#dataList").append(item);
						
						$("#dataList tr:odd").attr("class","add");
					}
				}
				
				// 페이징 정보
				var pageStr = makePaginationInfo(result['paginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);
				
				// 총건수 표시
				$("#totcnt").html("[총 "+result['paginationInfo'].totalRecordCount+"건] <b>[단위:천원]</b>");					
			}
		});
	}
	
	function totCostSum()
	{
		var sum = eval(notNull($("#labCost").val())) + eval(notNull($("#fuleCost").val())) + eval(notNull($("#itemCost").val()));
		sum += eval(notNull($("#equUseCost").val()))+eval(notNull($("#tranCost").val()))+eval(notNull($("#etcCost").val()));
		
		$("#totCost").val(eval(sum));
		
		$("#totCost").val(comma($("#totCost").val()));
	}
	
	function getWareHouseList(){
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/selectWareHouseList.do'/>",
			data: "",	
			dataType:"json",
			success : function(result){
				// 창고 구분
				var dropDownSet2 = $('#wareHouse2');
				dropDownSet2.loadSelectWareHouse(result.list, '선택', 'whCode', 'whName');
			}
		});
	}
	
	function calc_Printing(s_date,e_date){
		window.open("<c:url value='/warehouse/ItemCalcPrintInfo.do?pre=Y&costSdate="+s_date+"&costEdate="+e_date+"'/>","Calc_pop","top=100px,left=100px,height=400px,width=670px,scrollbars=1");
	}
	
	function notNull(s){
		s = unNumberFormat(s);
		if (s == null || s == '') {
			return 0;
		} else {
			return s;
		}
	}
	
	// 페이지 번호 클릭
	function linkPage(pageNo){
		//  dataLoad(pageNo);
		$("#hidListNum").val(pageNo);
		listSearch();
	}
	
	function commonWork() {
		var stdt = document.getElementById("search_date_start");
		var endt = document.getElementById("search_date_end");
		var dateCheck = /^(19[7-9][0-9]|20\d{2})(0[0-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/;
		
		if(endt.value != '' && stdt.value > endt.value) {
			alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			stdt.value = "";
			endt.value = "";
			stdt.focus();
		}
		if(stdt.value !=''){
			if(dateCheck.test(stdt.value)!=true){
				alert("날짜 형식에 부적합 합니다.\nYYYYMMDD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
				stdt.value = "";
				stdt.focus;
				return false;
			}
		}
		if(endt.value !=''){
			if(dateCheck.test(endt.value)!=true){
				alert("날짜 형식에 부적합 합니다.\nYYYYMMDD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
				endt.value = "";
				endt.focus;
				return false;
			}
		}
	}
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
							
						<div class="divisionBx">
							<div class="div40">
								
								<!-- 등록 폼 -->
								<form name="calCForm" id="calCForm" action="" onsubmit="return false;">
									<!--  <input type="hidden" name="mode" id="mode" value="insert"/> -->
									<input type="hidden" name="calcOption" id="calcOption" value="itemRele"/>
									<input type="hidden" name="hidTotalItemCost" id="hidTotalItemCost" value="itemRele"/>
									
									<fieldset>
										<legend class="hidden_phrase">정산 등록</legend>
										
										<div class="searchBox" style="width:370px">
											<ul>
												<li>
													<span>물품 창고 등록(수정)</span>
												</li>
												<li class="last">
													<input type="button" id="btnAddRow" name="btnAddRow" value="신규" class="btn btn_basic" onclick="javascript:addRow();" alt="신규"/>
													<input type="button" id="btnSave" name="btnSave" value="저장" class="btn btn_basic" onclick="javascript:save();" alt="저장"/>
												</li>
											</ul>
										</div>
										
										<table summary="물품정보" style="text-align:left">
											<colgroup>
												<col width="110px" />
												<col />
											</colgroup>
											<thead>
												<tr>
												<th scope="row">정산구분명</th>
													<td>
														 <input style="width:240px;" type="text" id="costDiv" name="costDiv"/>
													</td>
												</tr>
												<!-- 
													<tr>
														<th scope="row">창고구분</th>
														<td>
															 <select class="fixWidth20" id="wareHouse2"/>
														</td>
													</tr>
												
												<tr>
													<th scope="row">구분</th>
													<td>
														 <select class="fixWidth20" id="calcOption" >
															<option value="itemRele" selected="selected">출고</option>
															<option value="itemStor">입고</option>
														 </select>
													</td>
												</tr>
												  -->
												<tr>
													<th scope="row">방재물품총비용</th>
													<td>
														 <input name="totalItemCost" id="totalItemCost" style="width:240px;" type="text" disabled="disabled" /> 
													</td>
												</tr>
												<tr>
													<th>정산기간</th>
													<td>
														<input type="text" class="inputText" size="10" id="search_date_start" name="search_date_start" onchange="commonWork()"/>
														<span>~</span>
														<input type="text" class="inputText" size="10" id="search_date_end" name="search_date_end" onchange="commonWork()"/>
														<input type="button" id="btnSumCost" name="btnSumCost" value="확인" class="btn btn_search" onclick="javascript:sumCost();" alt="확인"/>
													</td>
												</tr>
											</thead>
											<tbody id="sectionSpeedBody"></tbody>
										</table>
										<br/>
										<div class="overBox" style="height:300px">
											<table summary="물품정보">
												<colgroup>
													<col width="30px"  />
													<col width="110px" />
													<col width="20px" />
													<col width="30px" />
												</colgroup>
												<thead>
													<tr>
														<th scope="col">날짜</th>
														<th scope="col">물품명</th>
														<th scope="col">수량</th>
														<th scope="col">금액(원)</th>
													</tr>
												</thead>
												<tbody id="costResult"></tbody>
											</table>
										</div>
									</fieldset>
								</form>
							</div>
							
							<div class="div60">
								
								<form name="calCTotalListForm" id="calCTotalListForm" action="" onsubmit="return false;">
									<input type="hidden" id="hidListNum" name="hidListNum" value="1"/>
									<input type="hidden" id="calc_seq" />
									
									<fieldset>
										<legend class="hidden_phrase">정산 목록</legend>
										
										<div class="searchBox" style="width:570px">
											<ul>
												<li>
													<span>※정산기간</span>
													<input type="text" class="inputText" size="10" id="ListSearch_date_start" name="ListSearch_date_start" readonly="readonly"/>
													<span>~</span>
													<input type="text" class="inputText" size="10" id="ListSearch_date_end" name="ListSearch_date_end" readonly="readonly"/>
												</li>
												<li style="padding-left:10px;padding-right:0px;">
													<span>※정산구분명</span>
													<input type="text" id="ListSearch_Text" name="ListSearch_Text" maxlength="20" style="width:100px; height:16px;" />
												</li>
												<li class="last">
													<input type="button" id="btnListSearch" name="btnListSearch" value="검색" class="btn btn_search" onclick="javascript:listSearch();" alt="검색"/>
												</li>
											</ul>
										</div>
									</fieldset>
								</form>
								<div id="dataList" style="height: 300px;"></div>
								<table id="searchResult" style="display:none" summary="결과정보"><tr><td><span id="resultText">조회 결과가 없습니다.</span></td></tr></table>
								<div class="paging">
									<div id="page_number">
										<ul class="paginate" id="pagination"></ul>
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