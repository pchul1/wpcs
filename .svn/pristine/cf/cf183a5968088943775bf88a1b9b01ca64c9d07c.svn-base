<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : statsRiverOutlet.jsp
	 * Description : 지천별방류량 화면
	 * Modification Information
	 * 
	 * 수정일			 수정자		 수정내용
	 * ----------	--------	---------------------------
	 * 2013.10.20	lkh			 리뉴얼
	 * 
	 * author lkh
	 * since 2013.10.20
	 * 
	 * Copyright (C) 2013 by lkh  All right reserved.
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
	var sday = "${startDate}";
	var eday = "${endDate}";
	
	$(function () {
	
		showLoading();
		
		itemSetting();
		makeHeader();
		
		//user deptNo에 따른 수계 고정
// 		set_User_deptNo(user_dept_no, "sugye");
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
		
		var todayObj = new Date(); 
		var yday = new Date(todayObj.valueOf()-(24*60*60*1000));
		
		yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());
		var today = todayObj.getFullYear()+"/"+ addzero(todayObj.getMonth()+1) +"/"+ addzero(todayObj.getDate());
		
		var time = todayObj.getHours();
		
		var timeStr = addzero(time);
		if(time <= 0)
			timeStr = "00";
			
		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}
		
		// 최초검색일을 기존 입력값의 MAX를 가져와서 -30일한 것으로 설정(수질 TMS 자료) 최초 검색종료일은 기존 입력값의 MAX로 한다. 2014.01.22(김경환대리 요청)
		//$("#startDate").val(yday);
		//$("#endDate").val(today);
		$("#startDate").val(sday);
		$("#endDate").val(eday);
		
		$('#sugye')
			.change(function(){
				adjustGongku();
			});
		
		$('#gongku').change(function() {
			adjustBangryu();
		});
		
		$("#bangryu").change(function() {
			setGraphBtn(true);
		});
		
		$("#chart").click(function() {
			chart_popup();
		});
			
		adjustGongku();
		
		$("#dataList tr:odd").attr("class","add");
		
		//이광복추가. 20140228
		dataView = new Slick.Data.DataView();
		
		var columns = [
						{
							id: 'GUBUN',
							name: '구분',
							columns: [
									{ id: "no", name: "No", field: "no", width: 45, sortable: true }
							]
						},
						{
							id: 'INFO',
							name: '기본정보',
							columns: [
									{ id: "riverName", name: "지천", field: "riverName", width: 140,  sortable: true },
									{ id: "time", name: "측정일", field: "time", width: 140,  sortable: true }
							]
						},
						{
							id: 'BOD',
							name: 'BOD',
							columns: [
									{ id: "bodValue", name: "부하량", field: "bodValue", width: 100, sortable: true, cssClass: "text-align-right" },
									{ id: "bodFlow", name: "방류량", field: "bodFlow", width: 100, sortable: true, cssClass: "text-align-right" },
									{ id: "bodAvg", name: "농도", field: "bodAvg", width: 100, sortable: true, cssClass: "text-align-right" }
							]
						},
						{
							id: 'COD',
							name: 'COD',
							columns: [
										{ id: "codValue", name: "부하량", field: "codValue", width: 100, sortable: true, cssClass: "text-align-right" },
										{ id: "codFlow", name: "방류량", field: "codFlow", width: 100, sortable: true, cssClass: "text-align-right" },
										{ id: "codAvg", name: "농도", field: "codAvg", width: 100, sortable: true, cssClass: "text-align-right" }
							]
						},
						{
							id: 'SS',
							name: 'SS',
							columns: [
										{ id: "susValue", name: "부하량", field: "susValue", width: 100, sortable: true, cssClass: "text-align-right" },
										{ id: "susFlow", name: "방류량", field: "susFlow", width: 100, sortable: true, cssClass: "text-align-right" },
										{ id: "susAvg", name: "농도", field: "susAvg", width: 100, sortable: true, cssClass: "text-align-right" }
							]
						},
						{
							id: 'T-N',
							name: 'T-N',
							columns: [
										{ id: "tonValue", name: "부하량", field: "tonValue", width: 100, sortable: true, cssClass: "text-align-right" },
										{ id: "tonFlow", name: "방류량", field: "tonFlow", width: 100, sortable: true, cssClass: "text-align-right" },
										{ id: "tonAvg", name: "농도", field: "tonAvg", width: 100, sortable: true, cssClass: "text-align-right" }
							]
						},
						{
							id: 'T-P',
							name: 'T-P',
							columns: [
										{ id: "topValue", name: "부하량", field: "topValue", width: 100, sortable: true, cssClass: "text-align-right" },
										{ id: "topFlow", name: "방류량", field: "topFlow", width: 100, sortable: true, cssClass: "text-align-right" },
										{ id: "topAvg", name: "농도", field: "topAvg", width: 100, sortable: true, cssClass: "text-align-right" }
							]
						}
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
	});
	
	//itemArray 셋팅
	function itemSetting(sys)
	{
		itemCnt = 5;
		itemArray = new Array(itemCnt);
		itemCode = new Array(itemCnt);
		itemArray[0] = "BOD";	itemCode[0] = "BOD";
		itemArray[1] = "COD";	itemCode[1] = "COD";
		itemArray[2] = "SS";	itemCode[2] = "SUS";
		itemArray[3] = "T-N";	itemCode[3] = "T-N";
		itemArray[4] = "T-P";	itemCode[4] = "T-P";
	}
	
	//테이블 헤더 생성
	function makeHeader(sys)
	{
		var header;
		
		var overBox = $("#overBox");
		
		overBox.html("");
		
		var table = "<table class='dataTable' id='dataTable'>"
						+ "<colgroup>"
						+ "<col width='200px'/>"
						+ "<col width='105px'/>"
						+ "<col />"
						+ "</colgroup>"
						+ "<thead id='dataHeader'>"
						+ "</thead>"
						+ "<tbody id='dataList'>"
						+ "</tbody>"
						+ "</table>";
					
		overBox.html(table);
		
		$("#dataTable").attr("class", "");
		$("#dataTable").attr("class", "dataTable");
		
		$("#dataTable").css("width", "1500px");
		
		//헤더 생성
		$("#dataHeader").html("");
		header = "<tr>" + 
						"<th rowspan ='2' scope='col'>지천</th>" +
						"<th rowspan ='2' scope='col'>측정일</th>";
						
						for(var rowIdx=0;rowIdx<itemCnt;rowIdx++)
						{
							header += "<th colspan='3' scope='col'>"+itemArray[rowIdx]+"</th>";
						}
						
					header += "</tr><tr>"
					
					for(var rowIdx=0;rowIdx<itemCnt;rowIdx++)
					{
						header += "<th scope='col'>부하량</th>";
						header += "<th scope='col'>방류량</th>";
						header += "<th scope='col'>농도</th>";
					}
					
					header += "</tr>";
					
		$("#dataHeader").append(header);
		//$("#dataList").html("<tr><td colspan='"+(itemCnt + 6)+"'>데이터를 불러오는 중 입니다.</td></tr>");
		
	}
	
	//측정소가 전체가 아닐때만 그래프 버튼이 표시됩니다.
	function setGraphBtn(change)
	{
	
		if($("#bangryu").val() == "all")
		{
			$("#chart").hide();
			return;
		}
		
		if(change == true)
		{
			$("#chart").hide();
		}
		else
		{
			$("#chart").show();
		}
	}
	
	//유역 조회
	function adjustGongku()
	{
		var dropDownSet = $('#gongku');
		
		$.getJSON("<c:url value='/waterpolmnt/waterinfo/getTMSRiverD1List.do'/>",
			function (data, status){
				if(status == 'success'){
					
					dropDownSet.loadSelect(data.tms);
					adjustBangryu();
					
				} else {
					return;
				}
			});
	}
	
	//지천조회
	function adjustBangryu()
	{
		var sugye = $('#gongku').val();
		var dropDownSet = $('#bangryu');
		
		$.getJSON("<c:url value='/waterpolmnt/waterinfo/getTMSRiverD2List.do'/>",
				{sugye:sugye},
				function (data, status){
					if(status == 'success'){
						
						dropDownSet.loadSelect_all(data.tms);
						
						init();
						
					} else { 
						return;
					}
				});
	}
	
	function excelDown() {
		
		if( validation() == false ) return;
		
		var gongku = $("#gongku").val();
		var riverCode = $("#bangryu").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		
		var param = "riverDiv=" + gongku + 
						"&riverCode=" + riverCode +
						"&frDate=" + frDate +
						"&toDate=" + toDate;
			
		location.href="<c:url value='/stats/getRiverOutletExcel.do'/>?"+param;
	}
	
	var firstFlag = true;
	function init() {
		if(firstFlag) {
			reloadData(1);
			firstFlag = false;
		}
	}
	
	function reloadData(pageNo){
		
		if( validation() == false ) return;
		
		setGraphBtn();
		showLoading();
		
		var gongku = $("#gongku").val();
		var riverCode = $("#bangryu").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		
		if (pageNo == null) pageNo = 1;
		
		$.ajax({
			type:"post",
			url:"<c:url value='/stats/getRiverOutlet.do'/>",
			data:{riverDiv:gongku, 
					riverCode:riverCode,
					frDate:frDate,
					toDate:toDate,
					pageIndex:pageNo
			},
			dataType:"json",
			success:function(result){
				
				var tot = result['detailViewList'].length;
				var pageInfo = result['paginationInfo'];
				
				dataView.setItems([]);
				
				$("#searchResult").hide();
// 				$("#dataList").css("height", "525px");
				
				var height = sGridCmn(2,result['detailViewList'],20);
				height += 17;	//컬럼의 width사이즈가 화면영역 보다 큰 경우 하단 스크롤을 위해 15를 더해준다.(예.기본 contants width가 900인데 이보다 큰경우)
				$("#dataList").css("height", height + "px");
				grid.resizeCanvas();
				
				var data = [];
				
				if( tot <= "0" ){
					$("#searchResult").show();
					$("#dataList").css("height", "49px");
					$("#resultText").html("");
					$("#resultText").html("조회 결과가 없습니다.");
					
					closeLoading();
				} else {
					var idx = 0;
					
					for(var i=0; i < tot; i++){
						
						var obj = result['detailViewList'][i];
						
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						
						obj.bodValue = (obj.bodValue != null && obj.bodValue != '') ? obj.bodValue : '-';
						obj.bodFlow = (obj.bodFlow != null && obj.bodFlow != '') ? obj.bodFlow : '-';
						obj.bodAvg = (obj.bodAvg != null && obj.bodAvg != '') ? obj.bodAvg : '-';
						
						obj.codValue = (obj.codValue != null && obj.codValue != '') ? obj.codValue : '-';
						obj.codFlow = (obj.codFlow != null && obj.codFlow != '') ? obj.codFlow : '-';
						obj.codAvg = (obj.codAvg != null && obj.codAvg != '') ? obj.codAvg : '-';
						
						obj.susValue = (obj.susValue != null && obj.susValue != '') ? obj.susValue : '-';
						obj.susFlow = (obj.susFlow != null && obj.susFlow != '') ? obj.susFlow : '-';
						obj.susAvg = (obj.susAvg != null && obj.susAvg != '') ? obj.susAvg : '-';
						
						obj.tonValue = (obj.tonValue != null && obj.tonValue != '') ? obj.tonValue : '-';
						obj.tonFlow = (obj.tonFlow != null && obj.tonFlow != '') ? obj.tonFlow : '-';
						obj.tonAvg = (obj.tonAvg != null && obj.tonAvg != '') ? obj.tonAvg : '-';
						
						obj.topValue = (obj.topValue != null && obj.topValue != '') ? obj.topValue : '-';
						obj.topFlow = (obj.topFlow != null && obj.topFlow != '') ? obj.topFlow : '-';
						obj.topAvg = (obj.topAvg != null && obj.topAvg != '') ? obj.topAvg : '-';
						
						data.push(obj);
					}
					dataView.beginUpdate();
					dataView.setItems(data, 'no');
					dataView.endUpdate();
				}
				// 페이징 정보
				var pageStr = makePaginationInfo(result['paginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);
				
				$("#p_total_cnt").html("[총 " + result['totCnt'] + "건] <span class='red'>※조회결과는 확정자료가 아닙니다.</span> (부하량(kg/d), 방류량(㎥/d), 농도(mg/ℓ))");
				//측정망 전용페이지로 변경 - 2010. 10. 07
				
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
				$("#dataList").css("height", "49px");
				$("#resultText").html("");
				$("#resultText").html("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				
				closeLoading();
			}
		});
	}
	
	function chart_popup()
	{
		var gongku = $("#gongku").val();
		var riverCode = $("#bangryu").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 546;
		var winWidth = 642;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-20;
		var height = winHeight-20;
		
		var param = "riverDiv=" + gongku + 
					"&riverCode=" + riverCode + 
					"&frDate=" + frDate + 
					"&toDate=" + toDate;
				
		window.open("<c:url value='/stats/goRiverOutletGraph.do'/>?"+encodeURI(param), 
				'chartDetailViewRIVER','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function validation(){
		if( $('#startDate').val() == "" ){ alert("조회 시작일자를 선택하세요"); return false; }
		if( $('#endDate').val() == "" ){ alert("조회 종료일자를 선택하세요"); return false; }
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
						<form:form commandName="statsVO" name="listFrm" id="listFrm" method="post">
							<input type="hidden" name="pageIndex" id="pageIndex" value="${statsVO.pageIndex}"/>
							<input type="hidden" name="sugye" id="river_div"/>
							<input type="hidden" name="bangryu" id="branch_no"/>
						
						<div class="searchBox">
							<ul>
								<li>
									<select class="fixWidth11" id="gongku" name="gongku">
										<option value="all">전체</option>
									</select>
									<span>&gt;</span>
									<select class="fixWidth16" id="bangryu">
										<option value="all">전체</option>
									</select>
								</li>
								<li>
									<input type="text" size="13" id="startDate" name="frDate" onchange="commonWork()"/>
									<span>~</span>
									<input type="text" size="13" id="endDate" name="toDate" onchange="commonWork()"/>
								</li>
								<li class="last">
									<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" onclick="javascript:reloadData();"/>
								</li>
							</ul>
						</div>
						</form:form>
						<!-- //수질 조회 현황 -->
						
						<div id="btArea">
							<span id="p_total_cnt">[총 ${totCnt}건]</span>
							<input type="button" id="chart" name="chart" value="그래프" class="btn btn_basic" onclick="javascript:chart_popup();" style="display:none" />
							<input type="button" id="excel" name="excel" value="엑셀" class="btn btn_basic" onclick="javascript:excelDown();" />
						</div>
						
						<!-- //방류수 수질 조회 -->
						<div class="table_wrapper">
							<div id="dataList" style="height: 525px;"></div>
							<table id="searchResult" style="display:none" summary="이동형측정기기정보"><tr><td><span id="resultText">조회 결과가 없습니다.</span></td></tr></table>
							
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