<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : itemSearchList.jsp
	 * Description : 방제물품현황관리 화면
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
	$(function () {
		// 입력폼에서 물품코드 선택시..
		$('#itemCode2').change(getItemCodeDetail);
		
		// 창고목록을 가져온다.
		getWareHouseList();
		
		// 물품코드를 가져온다.
		getItemCodeList();
		
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yymmdd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		
		dataLoad();
		
		dataView = new Slick.Data.DataView();
		
		var columns = [
						{ id: "whName", name: "창고명", field: "whName", width: 100/* , sortable: true */ },
						{ id: "adminDept", name: "담당부서", field: "adminDept", width: 100/* , sortable: true */ },
						{ id: "adminName", name: "담당자", field: "adminName", width: 95/* , sortable: true */ },
						{ id: "adminTelno", name: "연락처", field: "adminTelno", width: 100/* , sortable: true */ },
						{ id: "addr", name: "주소", field: "addr", width: 180/* , sortable: true */ }
					];
		var options = {
				enableColumnReorder: false,
				multiColumnSort: false,
				enableCellNavigation: true
		};
		
		grid = new Slick.Grid("#dataList", dataView, columns, options);
		grid.setSelectionModel(new Slick.RowSelectionModel());
		
		grid.onSelectedRowsChanged.subscribe(function() {
			grid.resetActiveCell();
		});
		
		// wire up model events to drive the grid
		dataView.onRowCountChanged.subscribe(function (e, args) {
			grid.updateRowCount();
			grid.render();
		});
		
		var CommaFormatter = function (row, cell, value, columnDef, dataContext) {
			if (value === null || value === "" || !(value > 0)) {
				return value;
			} else {
				return comma(value);
			}
		}
		
		dataView1 = new Slick.Data.DataView();
		
		var columns1 = [
						{ id: "nog", name: "NO", field: "no", width: 45, sortable: true },
						{ id: "itemName", name: "물품명", field: "itemName", width: 200, sortable: true },
						{ id: "itemStan", name: "규격", field: "itemStan", width: 90, sortable: true },
						{ id: "itemUnit", name: "단위", field: "itemUnit", width: 90, sortable: true },
						{ id: "amt", name: "수량", field: "amt", width: 150, cssClass: "text-align-right", formatter: CommaFormatter, sortable: true }
					];
		
		grid1 = new Slick.Grid("#dataList1", dataView1, columns1, options);
		grid1.setSelectionModel(new Slick.RowSelectionModel());
		
		grid1.onSelectedRowsChanged.subscribe(function() {
			grid1.resetActiveCell();
		});
		
		// wire up model events to drive the grid
		dataView1.onRowCountChanged.subscribe(function (e, args) {
			grid1.updateRowCount();
			grid1.render();
		});
		
		function comparer(a,b) {
			var x = a[sortcol], y = b[sortcol];
			
			if(sortcol == 'whName' || sortcol == 'adminDept' || sortcol == 'adminName' || sortcol == 'adminTelno' || sortcol == 'addr')
				return (x == y ? 0 : (x > y ? 1 : -1));
			else
			{
				x = parseFloat(x);
				y = parseFloat(y);
				
				if(isNaN(x) && isNaN(y))
					return 0;
				else if(isNaN(x))
					return -1;
				else if(isNaN(y))
					return 1;
				return (x == y ? 0 : (x > y ? 1 : -1));
			}
		}
		
		function comparer1(a,b) {
			var x = a[sortcol], y = b[sortcol];
			
			if(sortcol == 'itemName' || sortcol == 'itemStan' || sortcol == 'itemUnit' || sortcol == 'amt' || sortcol == 'no')
				return (x == y ? 0 : (x > y ? 1 : -1));
			else
			{
				x = parseFloat(x);
				y = parseFloat(y);
				
				if(isNaN(x) && isNaN(y))
					return 0;
				else if(isNaN(x))
					return -1;
				else if(isNaN(y))
					return 1;
				return (x == y ? 0 : (x > y ? 1 : -1));
			}
		}
		
		var sortcol = "";
		var sortdir = 1;
		
		grid.onSort.subscribe(function(e, args) {
			sortdir = args.sortAsc ? 1 : -1;
			sortcol = args.sortCol.field;
			
			dataView.sort(comparer, args.sortAsc);
		});
		grid1.onSort.subscribe(function(e, args) {
			sortdir = args.sortAsc ? 1 : -1;
			sortcol = args.sortCol.field;
			dataView1.sort(comparer1, args.sortAsc);
		});
	});
	
	// 입력폼 초기화
	function addRow(){
		$("#mode").val("insert");
		
		$("#wareHouse2").val('');
		$("#itemCode2").val('');
		$("#itemStan").val('');
		$("#itemUnit").val('');
		$("#itemAmt").val('');
		
		$("#wareHouse2").attr("disabled", false);
	}
	// 입력폼에 있는 값 삭제
	function delRow(){
		if (confirm('삭제하시겠습니까?')) {
			$("#mode").val("delete");
			
			var mode = $("#mode").val();
			var whCode = $("#wareHouse2").val();
			var itemCode = $("#itemCode2").val().split('_')[0];
			var itemCodeDet = $("#itemCode2").val().split('_')[1];
			var itemAmt = $("#itemAmt").val();
			
			var pageNo = $("#pageNo").val(); 
			if (pageNo == null) pageNo = 1;
			
			$.ajax({
				type: "POST",
				url: "<c:url value='/warehouse/deleteSearchList.do'/>",
				data: {whCode:whCode, 
					itemCode:itemCode,
					itemCodeDet:itemCodeDet
					},
				dataType:"json",
				beforeSend : function(){
					
					},
				success : function(result){
					if (result.updateCnt == '1') {
						alert('삭제되었습니다.');
						addRow();
						dataLoad(pageNo);
					} else {
						alert('삭제되지 않았습니다.\n잠시후 다시 시도 해 보시기 바랍니다.');
					}
				}
			});
		}
	}
	
	// 입력폼에 있는 데이터 저장 / 수정
	function save(){
		var mode = $("#mode").val();
		var whCode = $("#wareHouse2").val();
		var itemCode = $("#itemCode2").val().split('_')[0];
		var itemCodeDet = $("#itemCode2").val().split('_')[1];
		var calcOption = $("#calcOption").val();
		var itemAmt = $("#itemAmt").val();
		var itemDesc = $("#itemDesc").val();
		
		if (whCode == null || itemCode == null || itemCodeDet == null || itemAmt == null || itemDesc == null) {
			alert('수정 및 입력하려는 데이터가 정확하지 않습니다.');
			return;
		}
		if(calcOption == 'itemRele'){
			if($("#hidAmt").val()-itemAmt < 0 ){ alert('수량이 부족합니다.'); return; }
		}
		var pageNo = $("#pageNo").val(); 
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/mergeWareHouseItemStor.do'/>",
			data: {
					whCode:whCode,
					itemCode:itemCode,
					itemCodeDet:itemCodeDet,
					amt:itemAmt,
					regId:user_id,
					calcOption:calcOption,
					itemDesc:itemDesc
				},
			dataType:"json",
			success : function(result){
				if (result.updateCnt == '1') {
					alert('반영되었습니다.');
					addRow();
					dataLoad(pageNo);
				} else {
					alert('반영되지 않았습니다.\n잠시후 다시 시도 해 보시기 바랍니다.');
				}
			}
		});
	}
	
	// 입력폼에서 물품코드 선택시 물품 상세코드를 가져온다.
	function getItemCodeDetail()
	{
		var itemCode = $("#itemCode2").val().split('_')[0];
		var itemCodeDet = $("#itemCode2").val().split('_')[1];
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/getWareHouseItemCodeDetailList.do'/>",
			data: {itemCode:itemCode, itemCodeDet:itemCodeDet},
			dataType:"json",
			beforeSend : function(){
				},
			success : function(result){
				if (result.list != '') {
					$("#itemStan").val(result.list[0]['itemStan']);
					$("#itemUnit").val(result.list[0]['itemUnit']);
				} else {
					$("#itemStan").val('');
					$("#itemUnit").val('');
				}
			}
		});
	}
	
	// 창고목록을 가져온다.
	function getWareHouseList()
	{
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/selectWareHouseList.do'/>",
			data: "",	
			dataType:"json",
			beforeSend : function(){
				$('#wareHouse').attr("disabled", true);	
				},
			success : function(result){
				//var tot = result['list'].length;
				var dropDownSet = $('#wareHouse');
				dropDownSet.loadSelectWareHouse(result.list, '전체', 'whCode', 'whName');
				$('#wareHouse').attr("disabled", false);
				
				// 입력폼에 있는 창고 구분
				var dropDownSet2 = $('#wareHouse2');
				dropDownSet2.loadSelectWareHouse(result.list, '선택', 'whCode', 'whName');
			}
		});
	}
	
	// 물품코드를 가져온다.
	function getItemCodeList()
	{
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/selectWareHouseItemCodeList.do'/>",
			data: "",
			dataType:"json",
			beforeSend : function(){
				$('#itemCode').attr("disabled", true);
				},				
			success : function(result){
				var dropDownSet = $('#itemCode');
				dropDownSet.loadSelectWareHouse(result.list, '전체', 'itemCode', 'itemName');
				$('#itemCode').attr("disabled", false);
				
				// 입력폼의 물품코드
				var dropDownSet2 = $('#itemCode2');
				dropDownSet2.loadSelectWareHouse(result.list, '선택', 'itemCode', 'itemName', 'itemCodeDet');
			}
		});
	}
	
	// 목록에서 클릭시 ...
	function clickItemList(p_itemCode, p_itemCodeDet, p_amt, p_itemStan, p_itemUnit,p_itemAmt){
		var p_whCode = $("#wareHouse").val();
		if (p_whCode != "") {
			
			$("#wareHouse2").attr("disabled", true);
			
			$("#wareHouse2").val(p_whCode);
			$("#itemCode2").val(p_itemCode+"_"+p_itemCodeDet);
			$("#itemStan").val(p_itemStan);
			$("#itemUnit").val(p_itemUnit);
			$("#hidAmt").val(p_itemAmt);
			
			$("#mode").val("update");
			
		} else {
			alert("검색조건에서 창고구분을 '전체'로 하시면 수정 하실 수 없습니다.");
		}
	}
	
	// 데이터 목록 불러오기
	function dataLoad(pageNo){
		showLoading();
		
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/itemSearchDataList.do'/>",
			data: {whCode:$('#wareHouse').val(),
					itemCode:$('#itemCode').val(),
					pageIndex:pageNo
				},	
			dataType:"json",
			success : function(result){
// 				console.log("itemSearchDataList : ",result);
				dataView.setItems([]);
				dataView1.setItems([]);
				
				$("#searchResult").hide();
				
				var data = [];
				
				var whInfo = result['whInfo'];
				if (whInfo == null) {
					$("#searchResult").show();
					$("#dataList").css("height", "25px");
					$("#resultText").html("조회 결과가 없습니다.");
				}else{
					$("#dataList").css("height", "52px");
					
					var obj = result['whInfo'];
					
					data.push(obj);
					
					dataView.beginUpdate();
					dataView.setItems(data, 'whName');
					dataView.endUpdate();
				}
				// 아이템 데이터 세팅
				var tot = result['list'].length;
				var pageInfo = result['paginationInfo'];
				
				var data1 = [];
				
				$("#searchResult1").hide();
				
				var height = sGridCmn(1,result['list'],15);
// 				height += 17;	//컬럼의 width사이즈가 화면영역 보다 큰 경우 하단 스크롤을 위해 15를 더해준다.(예.기본 contants width가 900인데 이보다 큰경우)
				$("#dataList1").css("height", height + "px");
				grid1.resizeCanvas();
				
				if( tot <= 0 ){
					$("#searchResult1").show();
					$("#dataList1").css("height", "25px");
					$("#resultText1").html("조회 결과가 없습니다.");
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['list'][i];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						
						data1.push(obj);
					}
					dataView1.beginUpdate();
					dataView1.setItems(data1, 'no');
					dataView1.endUpdate();
				}
				
				// 페이징 정보
//				var pageStr = makePaginationInfo(result['paginationInfo']);
//				$("#pagination").empty();
//				$("#pagination").append(pageStr);
				
				// 총건수 표시
				$("#totcnt").html("[총 "+result['paginationInfo'].totalRecordCount+"건]");
				
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
				
				$("#searchResult1").show();
				$("#dataList1").css("height", "25px");
				$("#resultText1").html("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				
				closeLoading();
			}
		});
	}
	
	// 페이지 번호 클릭
	function linkPage(pageNo){
		dataLoad(pageNo);
		$("#pageNo").val(pageNo);
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
						
						<div class="divisionBx" style="margin-top:0px; margin-bottom:20px; display:inline-block;">
							<div class="div40">
							
								<!-- 등록 폼 -->
								<form name="insertForm" action="" onsubmit="return false;">
									<input type="hidden" name="mode" id="mode" value="insert"/>
									<input type="hidden" name="pageNo" id="pageNo" value="1"/>
									<input type="hidden" name="hidAmt" id="hidAmt"/>
									
									<fieldset>
										<legend class="hidden_phrase">물품현황 관리</legend>
										
										<div class="searchBox" style="width:370px">
											<ul>
												<li style="padding-left:0px;padding-right:0px">
													<span>물품 창고 등록(수정)</span>
												</li>
												<li class="last" style="padding-right:0px">
													<input type="button" id="btnAddRow" name="btnAddRow" value="신규" class="btn btn_basic" onclick="javascript:addRow();" alt="신규"/>
													<input type="button" id="btnDelRow" name="btnSave" value="삭제" class="btn btn_basic" onclick="javascript:delRow();" alt="삭제"/>
													<input type="button" id="btnSave" name="btnSave" value="저장" class="btn btn_basic" onclick="javascript:save();" alt="저장"/>
												</li>
											</ul>
										</div>
										
										<div class="overBox" style="height:400px">
											<table summary="물품정보" style="text-align:left">
												<colgroup>
													<col width="110px" />
													<col />
												</colgroup>
												<thead>
													<tr>
														<th scope="row">창고구분</th>
														<td>
															<select class="fixWidth20" id="wareHouse2"/>
														</td>
													</tr>
													<tr>
														<th scope="row">물품구분</th>
														<td>
															<select class="fixWidth20" id="itemCode2"/>
														</td>
													</tr>
													<tr>
														<th scope="row">규격</th>
														<td>
															<input style="width:240px;background-color:#F0F0F0;border:1px solid #ccc;" type="text" id="itemStan" readonly="readonly"/>
														</td>
													</tr>
													<tr>
														<th scope="row">단위</th>
														<td>
															<input style="width:240px;background-color:#F0F0F0;border:1px solid #ccc;" type="text" id="itemUnit" readonly="readonly"/>
														</td>
													</tr>
													<tr>
														<th scope="row">입출고 구분</th>
														<td>
															 <select class="fixWidth20" id="calcOption" >
																<option value="itemRele" selected="selected">출고</option>
																<option value="itemStore">입고</option>
															 </select>
														</td>
													</tr>
													<tr>
														<th scope="row">수량</th>
														<td>
															<input style="width:240px;" type="text" id="itemAmt" onkeydown="OnlyNumberCheck(this.value);"/>
														</td>
													</tr>
													<tr>
														<th scope="row">설명</th>
														<td align="left">
															<textarea id="itemDesc" style="width:260px;height:100px;border:1px solid #ccc;"></textarea>
														</td>
													</tr>
												</thead>
												<tbody id="sectionSpeedBody"></tbody>
											</table>
										</div>
									</fieldset>
								</form>
								<!-- //유량 등록 -->
							</div>
								
							<!-- 목록폼 -->
							<div class="div60">
										
								<form action="" onsubmit="return false;">
								
									<div class="searchBox" style="width:570px">
										<ul>
											<li>
												<span>창고구분</span>
												<select id="wareHouse" onchange="javascript:dataLoad()"></select>
											</li>
											<li>
												<span>물품구분</span>
												<select id="itemCode" onchange="javascript:dataLoad()"></select>
											</li>
											<li class="last">
												<input type="button" id="btnSearch" name="btnSearch" value="검색" class="btn btn_search" onclick="javascript:dataLoad();" alt="검색"/>
											</li>
										</ul>
									</div>
								</form>
								
								<form action="" onsubmit="return false;">
									<div id="dataList" style="height: 52px;"></div>
									<table id="searchResult" style="display:none" summary="결과정보"><tr><td><span id="resultText">조회 결과가 없습니다.</span></td></tr></table>
									<br/>
									<div align="right" id="totcnt"></div>
									<div id="dataList1" style="height: 400px;"></div>
									<table id="searchResult1" style="display:none" summary="결과정보"><tr><td><span id="resultText1">조회 결과가 없습니다.</span></td></tr></table>
									<!-- <div class="paging">
										<div id="page_number">
											<ul class="paginate" id="pagination"></ul>
										</div>
									</div> -->
								</form>
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