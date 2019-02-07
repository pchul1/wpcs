<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : alertList.jsp
	 * Description : 측정소별 감시 화면
	 * Modification Information
	 * 
	 * 수정일			 수정자		수정내용
	 * -------		--------	---------------------------
	 * 2010.05.17	khany		최초 생성
	 * 2013.11.06	lkh			리뉴얼
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

	var fact_name;
	var fact_code;
	var branch_no=1;
	var branch_name;
	var sys_kind;
	var itemCnt;
	var itemArray;
	var itemCode;
	var isFirst = true;
	
	$(function(){
		$("#loadingDiv").dialog({
			modal:true,
			open:function()
			{
				$(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar-close").hide();
				$(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar").hide();
				$(this).parents(".ui-dialog:first").find(".ui-dialog-resizing").hide();
				$(this).parents(".ui-dialog:first").find(".ui-dialog-buttonpane").hide();
				$(this).parents(".ui-dialog:first").find(".ui-dialog-dragging").hide();
				$(this).parents(".ui-dialog:first").css("width", "85px");
				$(this).parents(".ui-dialog:first").css("height", "75px");
				$(this).parents(".ui-dialog:first").css("overflow", "hidden");
				$("#loadingDiv").css("float", "left");
			},
			width:85,
			height:75,
			showCaption:false,
			resizable:false
		});

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
		var yday = new Date(Date.parse(todayObj) - 2 * 1000 * 60 * 60 * 12);

		yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1) + "/" + addzero(yday.getDate());
		var today = todayObj.getFullYear()+"/"+ addzero(todayObj.getMonth()+1) +"/"+ addzero(todayObj.getDate());

		function addzero(n) {
			return n < 10 ? "0" + n : n + "";
		}
		
		var time = todayObj.getHours();
		var timeStr = addzero(time);
		
		if(time <= 0)
			timeStr = "00";
		
		$("#frTime > option[value=" + timeStr + "]").attr("selected", "selected");
		$("#toTime > option[value=" + timeStr + "]").attr("selected", "selected");
		
		$("#startDate").val(yday);
		$("#endDate").val(today);
		
		//fact_code = '${param.fact_code}';
		//sys_kind = '${param.sys_kind}';
		//fact_name = '${param.fact_name}'; 
		//branch_no = '${param.branch_no}'
		
//		fact_code = '41T1004';
//		sys_kind = 'T';
//		fact_name = '';
//		branch_no='1';
			
		if(sys_kind == "A")
		{
			//$("#dataTable_before").attr("class", "dataTable_broad");
			$("#dataTable_before").css({"width":"3600px","border-collapse":"collapse"});
			//$("#dataTableHeader_before").attr("class", "dataTable_broad");
			$("#dataTableHeader_before").css({"width":"3600px","border-collapse":"collapse"});
			
			//$("#dataTable_next").attr("class", "dataTable_broad");
			$("#dataTable_next").css({"width":"3600px","border-collapse":"collapse"});
			//$("#dataTableHeader_next").attr("class", "dataTable_broad");
			$("#dataTableHeader_next").css({"width":"3600px","border-collapse":"collapse"});
			
			//$("#dataTable").attr("class", "dataTable_broad");
			$("#dataTable").css({"width":"3600px","border-collapse":"collapse"});
			//$("#dataTableHeader").attr("class", "dataTable_broad");
			$("#dataTableHeader").css({"width":"3600px","border-collapse":"collapse"});
				 
			$("#overBoxHeader").css("overflow-y","scroll");
			$("#overBoxHeader_next").css("overflow-y","scroll");
			$("#overBoxHeader_before").css("overflow-y","scroll");
			
			$("#overBox").css("height", "426px");
			// $("#overBox_before").css("height", "494px");
			//$("#overBox_next").css("height", "494px");
		}
		
		selectedSugyeInMemberId(user_riverid,'sugye');
		adjustGongku();
		
		$('#sys').change(function(){
			adjustGongku();
		});
		
		$('#sugye')
		.change(function(){
			adjustGongku();
		});
		
		$('#factCode').change(function(){
			adjustBranchList();
		});
		
		//reloadData();
		$("#branch_no").change(function() { 
			showLoading();
			branch_no = this.value;
			chart();
// 			refresh();
			refresh_all();
		});
		
		$("#branch_no_before").change(function() {
			showLoading();
			chart(); 
// 			refresh_before(true);
			refresh_all();
		});

		$("#branch_no_next").change(function() {
			showLoading();
			chart(); 
// 			refresh_next(true);
			refresh_all();
		});

		$("#graphItem").change(function() {
			showLoading();
			chart();
		});
		
		//slickgrid 20140310 이광복 추가.
 		dataView1 = new Slick.Data.DataView();
			
		var columns = [
						{
							id: 'info',
							name: '기본정보',
							columns: [
										{ id: "datetime", name: "시간", field: "datetime", width: 140, sortable: true },
										{ id: "branch_name", name: "측정소", field: "branch_name", width: 170, sortable: true }
									]
						},
						{
							id: 'info2',
							name: '수질정보',
							columns: [
										{ id: "tur", name: "탁도(NTU)", field: "tur", width: 130, sortable: true, cssClass: "text-align-right" },
										{ id: "tmp", name: "수온(℃)", field: "tmp", width: 130, sortable: true, cssClass: "text-align-right" },
										{ id: "phy", name: "pH", field: "phy", width: 130, sortable: true, cssClass: "text-align-right" },
										{ id: "dow", name: "DO(mg/L)", field: "dow", width: 130, sortable: true, cssClass: "text-align-right" },
										{ id: "con", name: "EC(mS/cm)", field: "con", width: 130, sortable: true, cssClass: "text-align-right" }
							]
						}
					];
		var options = {
				enableCellNavigation: true,
				enableColumnReorder: false,
				multiColumnSort: true
		};
		
		grid1 = new Slick.Grid("#dataList1", dataView1, columns, options);
		
		grid1.setSelectionModel(new Slick.RowSelectionModel());
		
		grid1.onSelectedRowsChanged.subscribe(function() {
			grid1.resetActiveCell();
		});
		
		dataView1.onRowCountChanged.subscribe(function (e, args) {
			grid1.updateRowCount();
			grid1.render();
		});
		
		dataView1.onRowsChanged.subscribe(function (e, args) {
			grid1.invalidateRows(args.rows);
			grid1.render();
		});
		
		grid1.onSort.subscribe(function (e, args) {
			var cols = args.sortCols;
		
			dataView1.sort(function (dataRow1, dataRow2) {
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
			grid1.invalidate();
			grid1.render();
		});
		
	});
	
	function sysChange()
	{
		var sys_kind = $("#sys").val();
		
		if(sys_kind == "all")
		{
			$("#branchNo>option:first").attr("selected", "true");
			$("#factCode>option:first").attr("selected", "true");
			
			$("#branchNo").attr("disabled", "disabled");
			$("#factCode").attr("disabled", "disabled");
		}
		else
		{
			$("#branchNo>option:first").attr("selected", "true");
			$("#factCode>option:first").attr("selected", "true");
			
			$("#branchNo").attr("disabled", false);
			if(sys_kind != "U")
				$("#factCode").attr("disabled", false);
		}
		
		if(sys_kind == "U")
		{
			$("#spanBranch").show();
			$("#branch_no").hide();
			$("#branch_no_next").hide();
			$("#branch_no_before").hide();
		}
		else
		{
			$("#spanBranch").hide();
			$("#branch_no").show();
			$("#branch_no_next").show();
			$("#branch_no_before").show();
		}
	}
	
	var firstFlag = false;
	
	function adjustGongku()
	{
		//var sugyeCd = $('#sugye').val();
		//var sys_kind = $("#sys").val();
		
		var sugyeCd = $('#sugye').val();
		var sys_kind = $("#sys").val();
		var dropDownSet = $('#factCode');
		var dropDownSet_branchNo = $('#branchNo');
		if( sugyeCd == 'all' || sys_kind == 'all' ){
			dropDownSet.attr("disabled", true);
			$("#factCode>option:first").attr("selected", "true");
			dropDownSet_branchNo.attr("disabled", true);
			$("#branchNo>option:first").attr("selected", "true");
			//dropDownSet.emptySelect();
		}else{
			dropDownSet.attr("disabled", false);
			dropDownSet.attr("style", "background:#ffffff;");
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>",
					{sugye:sugyeCd, system:sys_kind}, function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
// 					console.log("dropDownSet.attr():",dropDownSet.attr());
					dropDownSet.loadSelect(data.gongku);
					if (sys_kind == "U"){
						dropDownSet.attr("disabled", true);
						dropDownSet.attr("style", "background:#e9e9e9;");
					}
					
					sysChange();
					
					adjustBranchList();
				} else {
					alert("공구 목록 가져오기 실패");
					return;
				}
			});
		}
	}
	
	//측정소 목록 가져오기
	function adjustBranchList()
	{
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
					//console.log("결과:",data);
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect(data.branch);
					if(!firstFlag)
					{
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
	
	function showLoading()
	{
		$("#loadingDiv").dialog("open");
	}
	
	function chartLoaded()
	{
		$("#loadingDiv").dialog("close");
	}
	
	function getItemDropDown(sk){
		var sys = sk;
		var itemCode = "";
		
		if(sys == 'U' || sys == 'all'){
			itemCode = "22";
		}else if(sys == 'T'){
			itemCode = "23";
		}else if(sys == 'A'){
			itemCode = "37";
		}
		
		var dropDownSet = $('#graphItem');
		
		dropDownSet.attr("disabled", false);
		
		$.getJSON("<c:url value='/cmmn/getCode.do'/>", {code_id:itemCode}, function (data, status){
			if(status == 'success'){	 
				//item 객체에 SELECT 옵션내용 추가.
				dropDownSet.loadSelectDepth_factdetail(data.codes, sys);
			} else { 
				//alert("ERROR!");
				return;
			}
		});
	}
	
	function reloadData(){
		
		if( validation() == false ) return;
		
		showLoading();
		
		fact_code = $("#factCode").val();
		sys_kind = $("#sys").val();
		fact_name = '';
		
		itemSetting(sys_kind);
		makeHeader();
		
		getItemDropDown(sys_kind);
		getBranchList(fact_code);
	}
	
	//itemArray 셋팅
	function itemSetting(sys_kind)
	{
		if(sys_kind == "T")
		{
			itemCnt = 5;
			itemArray = new Array(itemCnt);
			itemCode = new Array(itemCnt);
			itemArray[0] = "탁도(NTU)";	itemCode[0] = "TUR";
			itemArray[1] = "수온(℃)";	itemCode[1] = "TMP";
			itemArray[2] = "pH";	itemCode[2] = "PHY";
			itemArray[3] = "DO(mg/L)";	itemCode[3] = "DOW";
			itemArray[4] = "EC(mS/cm)";	itemCode[4] = "CON";
		}
		if(sys_kind == "U")
		{
			itemCnt = 6;
			itemArray = new Array(itemCnt);
			itemCode = new Array(itemCnt);
			itemArray[0] = "탁도<br/><font style='font-size:10px'>(NTU)</font>";	itemCode[0] = "TUR";
			itemArray[1] = "수온<br/><font style='font-size:10px'>(℃)</font>";	itemCode[1] = "TMP";
			itemArray[2] = "pH";	itemCode[2] = "PHY";
			itemArray[3] = "DO<br/><font style='font-size:10px'>(mg/L)</font>";	itemCode[3] = "DOW";
			itemArray[4] = "EC<br/><font style='font-size:10px'>(mS/cm)</font>";	itemCode[4] = "CON";
			itemArray[5] = "Chl-a<br/><font style='font-size:10px'>(μg/L)</font>";	itemCode[4] = "TOF";
		}
		else if(sys_kind=="A")
		{
			itemCnt = 41;
			itemArray = new Array(itemCnt);
			itemCode = new Array(itemCnt);
			itemArray[0] = "탁도<br/>(NTU)";		itemCode[0] = "TUR00";
			itemArray[1] = "pH";			itemCode[1] = "PHY00";
			itemArray[2] = "DO<br/>(mg/L)";		itemCode[2] = "DOW00";
			itemArray[3] = "EC<br/>(mS/cm)";	itemCode[3] = "CON00";
			itemArray[4] = "수온<br/>(℃)";	itemCode[4] = "TMP00";
			//itemArray[5] = "pH2";			itemCode[5] = "PHY01";
			//itemArray[6] = "DO2<br/>(mg/L)";		itemCode[6] = "DOW01";
			//itemArray[7] = "EC2<br/>(mS/cm)";	itemCode[7] = "CON01";
			//itemArray[8] = "수온2<br/>(℃)";	itemCode[8] = "TMP01";
			itemArray[5] = "총유기탄소";	itemCode[5] = "TOC00";
			itemArray[6] = "임펄스<br/>";	itemCode[6] = "IMP00";
			itemArray[7] = "임펄스<br/>(좌)";	itemCode[7] = "LIM00";
			itemArray[8] = "임펄스<br/>(우)";	itemCode[8] = "RIM00";
			itemArray[9] = "독성지수<br/>(좌)";	itemCode[9] = "LTX00";
			itemArray[10] = "독성지수<br/>(우)";	itemCode[10] = "RTX00";
			itemArray[11] = "미생물<br/>독성지수(%)";	itemCode[11] = "TOX00";
			itemArray[12] = "조류<br/>독성지수";		itemCode[12] = "EVN00";
			itemArray[13] = "염화메틸렌";	itemCode[13] = "VOC01";
			itemArray[14] = "1.1.1-트리클로로에테인";	itemCode[14] = "VOC02";
			itemArray[15] = "벤젠";		itemCode[15] = "VOC03";
			itemArray[16] = "사염화탄소";	itemCode[16] = "VOC04";
			itemArray[17] = "트리클로로에틸렌";	itemCode[17] = "VOC05";
			itemArray[18] = "톨루엔";		itemCode[18] = "VOC06";
			itemArray[19] = "테트라클로로에티렌";	itemCode[19] = "VOC07";
			itemArray[20] = "에틸벤젠";	itemCode[20] = "VOC08";
			itemArray[21] = "m,p-자일렌";	itemCode[21] = "VOC09";
			itemArray[22] = "o-자일렌"; itemCode[22] = "VOC10";
			itemArray[23] = "[ECD]염화메틸렌";	itemCode[23] = "VOC11";
			itemArray[24] = "[ECD]1.1.1-트리클로로에테인";	itemCode[24] = "VOC12";
			itemArray[25] = "[ECD]사염화탄소";	itemCode[25] = "VOC13";
			itemArray[26] = "[ECD]트리클로로에틸렌";	itemCode[26] = "VOC14";
			itemArray[27] = "[ECD]테트라클로로에티렌";	itemCode[27] = "VOC15";
			itemArray[28] = "총질소";	itemCode[28] = "TON00";
			itemArray[29] = "총인";	itemCode[29] = "TOP00";
			itemArray[30] = "암모니아성질소";	itemCode[30] = "NH400";
			itemArray[31] = "질산성질소";	itemCode[31] = "NO300";
			itemArray[32] = "인산염인";	itemCode[32] = "PO400";
			itemArray[33] = "클로로필-a";		itemCode[33] = "TOF00";
			itemArray[34] = "카드뮴";	itemCode[34] = "CAD00";
			itemArray[35] = "납";	itemCode[35] = "PLU00";
			itemArray[36] = "구리";	itemCode[36] = "COP00";
			itemArray[37] = "아연";	itemCode[37] = "ZIN00";
			itemArray[38] = "페놀1";	itemCode[38] = "PHE00";
			itemArray[39] = "페놀2";	itemCode[39] = "PHL00";
			itemArray[40] = "강수량";	itemCode[40] = "RIN00";
		}
	}

	//테이블 헤더 생성
	function makeHeader()
	{
		var header;

		if(sys_kind != "A")
		{
			//시스템에 따른 테이블 헤더 형식 변경
			//이전 공구
			$("#overBoxHeader_before").html("");

			var table_before = "	<table id='dataTableHeader_before' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
				table_before += "<colgroup><col width='90px' /><col width='80px' /><col width='80px' /><col width='80px' /><col width='80px' /><col width='80px' /></colgroup>";
				table_before += "<thead id='valueDataHeader1_before'></thead>";
				table_before += "</table>";
				
			$("#overBoxHeader_before").html(table_before);

			//선택 공구
			$("#overBoxHeader").html("");

			var table = "	<table id='dataTableHeader' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
				table += "<colgroup><col width='90px' /><col width='80px' /><col width='80px' /><col width='80px' /><col width='80px' /><col width='80px' /></colgroup>";
				table += "<thead id='valueDataHeader'></thead>";
				table += "</table>";
				
			$("#overBoxHeader").html(table);

			//다음 공구
			$("#overBoxHeader_next").html("");

			var table_next = "	<table id='dataTableHeader_next' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
				table_next += "<colgroup><col width='90px' /><col width='80px' /><col width='80px' /><col width='80px' /><col width='80px' /><col width='80px' /></colgroup>";
				table_next += "<thead id='valueDataHeader1_next'></thead>";
				table_next += "</table>";
				
			$("#overBoxHeader_next").html(table_next);
			
			//헤더 생성
			$("#valueDataHeader").html("");
			$("#valueDataHeader1_before").html("");
			$("#valueDataHeader1_next").html("");
			
			header = "<tr>" + 
						"<th rowspan ='2' scope='col'>시간</th>" +
						"<th colspan ='"+itemCnt+"' scope='col'>수질정보</th>" +
						"</tr>" + 
						"<tr>";
						
						for(var rowIdx=0;rowIdx<itemCnt;rowIdx++)
						{
							header += "<th scope='col'>"+itemArray[rowIdx]+"</th>";
						}
						
						header += "</tr>";
						
			$("#valueDataHeader").append(header);
			$("#valueDataHeader1_before").append(header);
			$("#valueDataHeader1_next").append(header);
			
			$("#valueDataList").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러오는 중 입니다.</td></tr>");
			$("#valueDataList_before").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러오는 중 입니다.</td></tr>");
			$("#valueDataList_next").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러오는 중 입니다.</td></tr>");
			
		}
		else if(sys_kind == "A")	 //측정망일 경우
		{
			//시스템에 따른 테이블 헤더 형식 변경
			//이전 공구
			$("#overBoxHeader_before").html("");

			var table_before = "	<table style='width:3600px; border-collapse:collapse;' id='dataTableHeader_before' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
				table_before += "<colgroup><col width='90px' /><col width='80px' /><col width='80px' /><col width='80px' /><col width='80px' />";

				for(var idx = 0 ; idx < 40 ; idx ++)
				{
					table_before += "<col width='80px'/>";
				}
				
				table_before += "<col width='80px'/></colgroup>";
				table_before += "<thead id='valueDataHeader1_before'></thead>";
				table_before += "</table>";
				
			$("#overBoxHeader_before").html(table_before);

			//선택 공구
			$("#overBoxHeader").html("");

			var table = "	<table style='width:3600px; border-collapse:collapse;' id='dataTableHeader' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
				table += "<colgroup><col width='90px' /><col width='80px' /><col width='80px' /><col width='80px' /><col width='80px' />";

				for(var idx = 0 ; idx < 40 ; idx ++)
				{
						table += "<col width='80px'/>";
				}
				
				table += "<col width='80px'/></colgroup>";
				table += "<thead id='valueDataHeader'></thead>";
				table += "</table>";
				
			$("#overBoxHeader").html(table);

			//다음 공구
			$("#overBoxHeader_next").html("");

			var table_next = "	<table style='width:3600px; border-collapse:collapse;' id='dataTableHeader_next' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
				table_next += "<colgroup><col width='90px' /><col width='80px' /><col width='80px' /><col width='80px' /><col width='80px' />";

				for(var idx = 0 ; idx < 40 ; idx ++)
				{
						table_next += "<col width='80px'/>";
				}
				
				table_next += "<col width='80px'/></colgroup>";
				table_next += "<thead id='valueDataHeader1_next'></thead>";
				table_next += "</table>";
				
			$("#overBoxHeader_next").html(table_next);
			
			//헤더 생성
			$("#valueDataHeader").html("");
			$("#valueDataHeader1_before").html("");
			$("#valueDataHeader1_next").html("");
			header = "<tr>" +
					"<th rowspan ='2' scope='col'>시간</th>" +
					"<th colspan ='5' scope='col'>일반항목</th>"+
					//"<th colspan ='4' scope='col'>일반항목<br/>(외부)</th>"+
					"<th colspan='1' scope='col'>유기물질</th>" +
					"<th colspan='1' scope='col'>생물독성<br/>(물고기)</th>" + 
					"<th colspan='2' scope='col'>생물독성<br/>(물벼룩1)</th>" +
					"<th colspan='2' scope='col'>생물독성<br/>(물벼룩2)</th>" +
					"<th colspan='1' scope='col'>생물독성<br/>(미생물)</th>" +
					"<th colspan='1' scope='col'>생물독성<br/>(조류)</th>" +
					"<th colspan='15' scope='col'>휘발성<br/>유기화합물</th>" +
					"<th colspan='5' scope='col'>영양염류</th>" +
					"<th colspan='1' scope='col'>클로로필-a</th>" +
					"<th colspan='4' scope='col'>중금속</th>" +
					"<th colspan='2' scope='col'>페놀</th>" +
					"<th colspan='1' scope='col'>강수량계</th>" +
					"</tr>" + 
					"<tr>";
					
						for(var rowIdx=0;rowIdx<itemCnt;rowIdx++)
						{
							header += "<th scope='col'>"+itemArray[rowIdx]+"</th>";
						}
						
						header += "</tr>";
						
			$("#valueDataHeader").append(header);
			$("#valueDataHeader1_before").append(header);
			$("#valueDataHeader1_next").append(header);
			
			$("#valueDataList").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러오는 중 입니다.</td></tr>");
			$("#valueDataList_before").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러오는 중 입니다.</td></tr>");
			$("#valueDataList_next").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러오는 중 입니다.</td></tr>");
		}
		else
		{
			$("#valueDataHeader2_before").hide();
			$("#valueDataHeader2_next").hide();
		}
	}
	
	function getBranchList(fc){
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>",
			data:{factCode:fc},
			dataType:"json",
			success:function(result) {
				//branch_name = result['branch'][0].CAPTION;
				//$("#fact_branch_cnt").text(result['branch'].length);
				$("#branch_no").loadSelect(result['branch']);
				
				//브랜치 로드 까지 완료되어야 데이터를 불러올 수 있음
				refresh_all();
// 				refresh();
				
// 				refresh_before();
// 				refresh_next();
				chart();
			},
			error:function(result){
			}
		});
	}

	//처음 로딩할때 한번만 실행됨
	var beforeFlag = true;
	var nextFlag = true;
	
	function getBranchList_before(factCode,selectBranchNo){
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>",
			data:{factCode:factCode},
			dataType:"json",
			success:function(result) {
				//branch_name = result['branch'][0].CAPTION;
				//$("#fact_branch_cnt").text(result['branch'].length);
				$("#branch_no_before").loadSelect(result['branch']);
				beforeFlag = false;
				
				if(selectBranchNo != null)
				{
					if($("#branch_no_before").val() != selectBranchNo)
					{
						refresh_before(true);
					}
				}
			},
			error:function(result){
			}
		});
	}

	function getBranchList_next(factCode,selectBranchNo){
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>",
			data:{factCode:factCode},
			dataType:"json",
			success:function(result) {
				//branch_name = result['branch'][0].CAPTION;
				//$("#fact_branch_cnt").text(result['branch'].length);
				$("#branch_no_next").loadSelect(result['branch']);
				nextFlag = false;
				
				if(selectBranchNo != null)
				{
					if($("#branch_no_next").val() != selectBranchNo)
					{
						refresh_next(true);
					}
				}
			},
			error:function(result){
			}
		});
	}
	
	//이전 공구
	function refresh_before(isBranchChange){

		fact_code = $("#factCode").val();
		sys_kind = $("#sys").val();

		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();

		$("#valueDataList_before").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러옵니다...</td></tr>");
		
		var branch_no = $("#branch_no_before").val();

		if(branch_no == null || branch_no == "")
		{
			branch_no = "1";
		}

		//IP-USN같은 경우에는 검색조건에 설정된 측정소 번호로 조회함
		if(sys_kind == "U")
			branch_no = $("#branchNo").val();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/situationctl/getWatersysMntMainDetail_next.do'/>",
			data:{fact_code:fact_code,
					branch_no:branch_no,
					sys_kind:sys_kind,
					frDate:frDate,
					toDate:toDate,
					frTime:frTime,
					toTime:toTime,
					isNext:"N"},
			dataType:"json",
			success:function(result){
// 				console.log("before_dataload 결과:",result);
				before_dataload_success(result, isBranchChange, branch_no)
			},
			error:function(result){
				$("#valueDataList_before").html("");
				$("#valueDataList_before").html("<tr><td colspan='"+(itemCnt + 1)+"'>서버 접속에 실패하였습니다!</td></tr>");
			}
		});
	}


	function before_dataload_success(result, isBranchChange, branch_no)
	{
		//if(beforeFlag && result != null && result['factCode'] != null)
		//{
		var sys_kind = $("#sys").val();

		if(sys_kind != "U")
		{
			//공구 변경시 다시 불러오지 않습니다
			if(isBranchChange == null || isBranchChange == false)
				getBranchList_before(result['factCode'], branch_no);

			
			var factName = result['factName'];
			
			if(factName != null && factName != undefined && factName != "")
				$("#factName_before").text(factName);
			else
				$("#factName_before").text("없음");
		}
		else
		{
			var factName = result['branchName'];

			if(factName != null && factName != undefined && factName != "")
				$("#factName_before").text(factName);
			else
				$("#factName_before").text("없음");
		}
			
		//}

			$("#overBox_before").html("");

			
			//데이터 테이블 형식 생성(측정망, 다른 망과 형식이 다르기 때문)
			if(sys_kind != "A")	
			{
				var dataTable_before = "<table id='dataTable_before' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
				dataTable_before += "<colgroup><col width='90px' /><col width='80px' /><col width='80px' /><col width='80px' /><col width='80px' /><col width='80px' /></colgroup>";
				dataTable_before += "<tbody id='valueDataList_before'></tbody>";
				dataTable_before += "</table>";
				$("#overBox_before").html(dataTable_before);

				if(sys_kind == "U")
				{
					$("#dataTable_before").css("width","565px");
					$("#dataTableHeader_before").css("width", "565px");
					$("#overBox_before").css("overflow-y","scroll");
					$("#overBoxHeader_before").css("overflow-y", "scroll");
				}
				
				
				
				
				
				//slickgrid 20140310 이광복 추가.
				dataView = new Slick.Data.DataView();
				var columns = [
								{ id: "datetime", name: "시간", field: "datetime", width: 90, sortable: true },
								{
									id: 'info',
									name: '수질정보',
									columns: [
												{ id: "tur", name: "탁도(NTU)", field: "tur", width: 80, sortable: true, cssClass: "text-align-right" },
												{ id: "tmp", name: "수온(℃)", field: "tmp", width: 80, sortable: true, cssClass: "text-align-right" },
												{ id: "phy", name: "pH", field: "phy", width: 80, sortable: true, cssClass: "text-align-right" },
												{ id: "dow", name: "DO(mg/L)", field: "dow", width: 80, sortable: true, cssClass: "text-align-right" },
												{ id: "con", name: "EC(mS/cm)", field: "con", width: 80, sortable: true, cssClass: "text-align-right" }
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
				
			}
			else
			{
				var dataTable_before = "<table style='width:3600px; border-collapse:collapse;' id='dataTable_before' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
				dataTable_before += "<colgroup><col width='90px' /><col width='80px' /><col width='80px' /><col width='80px' /><col width='80px' />";

				for(var idx = 0 ; idx < 40 ; idx ++)
				{
					dataTable_before += "<col width='80px'/>";
				}
				dataTable_before += "<col width='80px'/></colgroup>";
				dataTable_before += "<tbody id='valueDataList_before'></tbody>";
				dataTable_before += "</table>";
				$("#overBox_before").html(dataTable_before);
				
				//slickgrid 20140310 이광복 추가.
				dataView = new Slick.Data.DataView();
				
				var numberFormatter = function (row, cell, value, columnDef, dataContext) {  
				    try { 
				    	var vId = columnDef.field + "_or";
				    	var vVal= dataContext[vId];
				    	
						switch(vVal)
						{
							case "0":
								return '<font color="green">' + value + '</font>';
								break;
							case "1" :
								return '<font color="blue">' + value + '</font>';
								break;
							case "2" :
								return '<font color="#F0D010">' + value + '</font>';
								break;
							case "3" :
								return '<font color="orange">' + value + '</font>';
								break; 
							case "4" :
								return '<font color="red">' + value + '</font>';
								break;
							default :
								return '<font color="green">' + value + '</font>';
								break;
						}
						
				    } catch (e) {  
				        return '';
				    }  
				} 
				
				var columns = [
								{ id: "datetime", name: "시간", field: "datetime", width: 90, sortable: true },
				                {
				                    id: "COM1",
				                    name: "일반항목",
				                    columns: [
												{ id: "tur", name: "탁도(NTU)", field: "tur", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },	//탁도
												{ id: "phy", name: "pH", field: "phy", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },	//PH
												{ id: "dow", name: "DO(mg/L)", field: "dow", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },	//DO
												{ id: "con", name: "EC(mS/cm)", field: "con", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },	//EC
												{ id: "tmp", name: "수온(℃)", field: "tmp", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }	//수온
				                    ]
				                },
				                {
				                    id: 'ORGA',
				                    name: '유기물질',
				                    columns: [
												{ id: "toc", name: "총유기탄소", field: "toc", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }	//총유기탄소
				                    ]
				                },

				                {
				                    id: 'BIO1',
				                    name: '생물독성(물고기)',
				                    columns: [
												{ id: "imp", name: "임펄스", field: "imp", width: 100, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
				                    ]
				                },

				                {
				                    id: 'BIO2',
				                    name: '생물독성(물벼룩1)',
				                    columns: [
												{ id: "lim", name: "임펄스(좌)", field: "lim", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "rim", name: "임펄스(우)", field: "rim", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
				                    ]
				                },
								
				                {
				                    id: 'BIO3',
				                    name: '생물독성(물벼룩2)',
				                    columns: [
												{ id: "ltx", name: "독성지수(좌)", field: "ltx", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "rtx", name: "독성지수(우)", field: "rtx", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
				                    ]
				                },

				                {
				                    id: 'BIO4',
				                    name: '생물독성(미생물)',
				                    columns: [
												{ id: "tox", name: "미생물독성지수(%)", field: "tox", width: 110, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
				                    ]
				                },

				                {
				                    id: 'BIO5',
				                    name: '생물독성(조류)',
				                    columns: [
												{ id: "evn", name: "조류독성지수", field: "evn", width: 90, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
				                    ]
				                },

				                {
				                    id: 'VOCS',
				                    name: '휘발성유기화합물',
				                    columns: [
												{ id: "voc1", name: "염화메틸렌", field: "voc1", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "voc2", name: "1.1.1-트리클로로에테인", field: "voc2", width: 130, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "voc3", name: "벤젠", field: "voc3", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "voc4", name: "사염화탄소", field: "voc4", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "voc5", name: "트리클로로에틸렌", field: "voc5", width: 100, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "voc6", name: "톨루엔", field: "voc6", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "voc7", name: "테트라클로로에티렌", field: "voc7", width: 110, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "voc8", name: "에틸벤젠", field: "voc8", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "voc9", name: "m,p-자일렌", field: "voc9", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "voc10", name: "o-자일렌", field: "voc10", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "voc11", name: "[ECD]염화메틸렌", field: "voc11", width: 100, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "voc12", name: "[ECD]1.1.1-트리클로로에테인", field: "voc12", width: 170, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "voc13", name: "[ECD]사염화탄소", field: "voc13", width: 100, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "voc14", name: "[ECD]트리클로로에틸렌", field: "voc14", width: 130, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "voc15", name: "[ECD]테트라클로로에티렌", field: "voc15", width: 140, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
				                    ]
				                },
				                
				                {
				                    id: 'NUTR',
				                    name: '영양염류',
				                    columns: [
												{ id: "ton", name: "총질소", field: "ton", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "top", name: "총인", field: "top", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "nh4", name: "암모니아성질소", field: "nh4", width: 90, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "no3", name: "질산성질소", field: "no3", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "po4", name: "인산염인", field: "po4", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
				                    ]
				                },
								
				                {
				                    id: 'CHLA',
				                    name: '클로로필-a',
				                    columns: [
												{ id: "tof", name: "클로로필-a", field: "tof", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
				                    ]
				                },
								
				                {
				                    id: 'METL',
				                    name: '중금속',
				                    columns: [
								                { id: "cad", name: "카드뮴", field: "cad", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "plu", name: "납", field: "plu", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "cop", name: "구리", field: "cop", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "zin", name: "아연", field: "zin", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
				                    ]
				                },

				                {
				                    id: 'PHEN',
				                    name: '페놀',
				                    columns: [
												{ id: "phe", name: "페놀1", field: "phe", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
												{ id: "phl", name: "페놀2", field: "phl", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
				                    ]
				                },

				                {
				                    id: 'RAIN',
				                    name: '강수량계',
				                    columns: [
												{ id: "rin", name: "강수량", field: "rin", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
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
			}
		
		var tot = result['refreshData'].length;
		var trClass;
		
		dataView.setItems([]);
		 
		$("#searchResult").hide();
		$("#dataList").css("height", "400px");
		
		var data = [];

		if( tot <= "0" ){
			
			$("#searchResult").show();
			//$("#dataList").css("height", "100px");
		} else {
			var idx = 0;
			for(var i=0; i < tot; i++){
				var obj = result['refreshData'][i];

				var no = 0;
				no = i + 1;
				obj.no = no;
				obj.datetime = obj.min_time.substring(5,16);
				
				if(sys_kind != "A")
				{
					obj.tur = (obj.tur != null && obj.tur != '') ? obj.tur : '-';
					obj.tmp = (obj.tmp != null && obj.tmp != '') ? obj.tmp : '-';
					obj.phy = (obj.phy != null && obj.phy != '') ? obj.phy : '-';
					obj.dow = (obj.dow != null && obj.dow != '') ? obj.dow : '-';
					obj.con = (obj.con != null && obj.con != '') ? obj.con : '-';
					obj.tof = (obj.tof != null && obj.tof != '') ? obj.tof : '-';
				}
				
				if(sys_kind == "A")
				{
					obj.tur = (obj.tur != null && obj.tur != '') ? obj.tur : '-';
					obj.phy = (obj.phy != null && obj.phy != '') ? obj.phy : '-';
					obj.dow = (obj.dow != null && obj.dow != '') ? obj.dow : '-';
					obj.con = (obj.con != null && obj.con != '') ? obj.con : '-';
					obj.tmp = (obj.tmp != null && obj.tmp != '') ? obj.tmp : '-';
					obj.toc = (obj.toc != null && obj.toc != '') ? obj.toc : '-';

					obj.imp = (obj.imp != null && obj.imp != '') ? obj.imp : '-';
					obj.lim = (obj.lim != null && obj.lim != '') ? obj.lim : '-';
					obj.rim = (obj.rim != null && obj.rim != '') ? obj.rim : '-';

					obj.ltx = (obj.ltx != null && obj.ltx != '') ? obj.ltx : '-';
					obj.rtx = (obj.rtx != null && obj.rtx != '') ? obj.rtx : '-';

					obj.tox = (obj.tox != null && obj.tox != '') ? obj.tox : '-';
					obj.evn = (obj.evn != null && obj.evn != '') ? obj.evn : '-';

					obj.voc1 = (obj.voc1 != null && obj.voc1 != '') ? obj.voc1 : '-';
					obj.voc2 = (obj.voc2 != null && obj.voc2 != '') ? obj.voc2 : '-';
					obj.voc3 = (obj.voc3 != null && obj.voc3 != '') ? obj.voc3 : '-';
					obj.voc4 = (obj.voc4 != null && obj.voc4 != '') ? obj.voc4 : '-';
					obj.voc5 = (obj.voc5 != null && obj.voc5 != '') ? obj.voc5 : '-';
					obj.voc6 = (obj.voc6 != null && obj.voc6 != '') ? obj.voc6 : '-';
					obj.voc7 = (obj.voc7 != null && obj.voc7 != '') ? obj.voc7 : '-';
					obj.voc8 = (obj.voc8 != null && obj.voc8 != '') ? obj.voc8 : '-';
					obj.voc9 = (obj.voc9 != null && obj.voc9 != '') ? obj.voc9 : '-';
					obj.voc10 = (obj.voc10 != null && obj.voc10 != '') ? obj.voc10 : '-';
					obj.voc11 = (obj.voc11 != null && obj.voc11 != '') ? obj.voc11 : '-';
					obj.voc12 = (obj.voc12 != null && obj.voc12 != '') ? obj.voc12 : '-';
					obj.voc13 = (obj.voc13 != null && obj.voc13 != '') ? obj.voc13 : '-';
					obj.voc14 = (obj.voc14 != null && obj.voc14 != '') ? obj.voc14 : '-';
					obj.voc15 = (obj.voc15 != null && obj.voc15 != '') ? obj.voc15 : '-';
					
					obj.tof = (obj.tof != null && obj.tof != '') ? obj.tof : '-';
					obj.ton = (obj.ton != null && obj.ton != '') ? obj.ton : '-';
					obj.top = (obj.top != null && obj.top != '') ? obj.top : '-';
					obj.nh4 = (obj.nh4 != null && obj.nh4 != '') ? obj.nh4 : '-';
					
					
					obj.no3 = (obj.no3 != null && obj.no3 != '') ? obj.no3 : '-';
					obj.po4 = (obj.po4 != null && obj.po4 != '') ? obj.po4 : '-';

					obj.cad = (obj.cad != null && obj.cad != '') ? obj.cad : '-';
					obj.plu = (obj.plu != null && obj.plu != '') ? obj.plu : '-';

					obj.cop = (obj.cop != null && obj.cop != '') ? obj.cop : '-';
					obj.zin = (obj.zin != null && obj.zin != '') ? obj.zin : '-';
					obj.phe = (obj.phe != null && obj.phe != '') ? obj.phe : '-';
					obj.phl = (obj.phl != null && obj.phl != '') ? obj.phl : '-';

					obj.rin = (obj.rin != null && obj.rin != '') ? obj.rin : '-';
				}

				data.push(obj);
			}
			dataView.beginUpdate();
			dataView.setItems(data, 'no');
			dataView.endUpdate();
		}
		
		//chart();
	}

	//다음 공구
	function refresh_next(isBranchChange){
		
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		
		fact_code = $("#factCode").val();
		sys_kind = $("#sys").val();
		
		$("#valueDataList_next").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러옵니다...</td></tr>");
		
		var branch_no = $("#branch_no_next").val();
		
		if(branch_no == null || branch_no == "")
		{
			branch_no = "1";
		}

		//IP-USN같은 경우에는 검색조건에 설정된 측정소 번호로 조회함
		if(sys_kind == "U")
			branch_no = $("#branchNo").val();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/situationctl/getWatersysMntMainDetail_next.do'/>",
			data:{fact_code:fact_code,
					branch_no:branch_no,
					sys_kind:sys_kind,
					frDate:frDate,
					toDate:toDate,
					frTime:frTime,
					toTime:toTime,
					isNext:"Y"},
			dataType:"json",
			success:function(result){next_dataload_success(result, isBranchChange, branch_no)},
			error:function(result){
				$("#valueDataList_next").html("");
				$("#valueDataList_next").html("<tr><td colspan='"+(itemCnt + 1)+"'>서버 접속에 실패하였습니다!</td></tr>");
			}
		});
	}
	
	function next_dataload_success(result, isBranchChange, branch_no)
	{
		var sys_kind = $("#sys").val();
		
		if(sys_kind != "U")
		{
			//공구 변경조회시 다시 불러오지 않습니다
			if(isBranchChange == null || isBranchChange == false)
				getBranchList_next(result['factCode'], branch_no);
			
			var factName = result['factName'];
			
			if(factName != null && factName != undefined && factName != "")
				$("#factName_next").text(factName);
			else
				$("#factName_next").text("없음");
		}
		else
		{
			var factName = result['branchName'];
			
			if(factName != null && factName != undefined && factName != "")
				$("#factName_next").text(factName);
			else
				$("#factName_next").text("없음");
		}
		
		//if(nextFlag && result != null && result['factCode'] != null)
		//{
			
		$("#overBox_next").html("");
		
		//데이터 테이블 형식 생성(측정망, 다른 망의 형식이 다르기 때문)
		if(sys_kind != "A")
		{
			var dataTable_next = "<table id='dataTable_next' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
			dataTable_next += "<colgroup><col width='90px' /><col width='80px' /><col width='80px' /><col width='80px' /><col width='80px' /><col width='80px' /></colgroup>";
			dataTable_next += "<tbody id='valueDataList_next'></tbody>";
			dataTable_next += "</table>";
			$("#overBox_next").html(dataTable_next);
			
			if(sys_kind == "U")
			{
				$("#dataTable_next").css("width","565px");
				$("#dataTableHeader_next").css("width", "565px");
				$("#overBox_next").css("overflow-y","scroll");
				$("#overBoxHeader_next").css("overflow-y", "scroll");
			}
			
			
			//slickgrid 20140310 이광복 추가.
	 		dataView2 = new Slick.Data.DataView();
				
			var columns = [
							{ id: "datetime", name: "시간", field: "datetime", width: 90, sortable: true },
							{
								id: 'info',
								name: '수질정보',
								columns: [
											{ id: "tur", name: "탁도(NTU)", field: "tur", width: 80, sortable: true, cssClass: "text-align-right" },
											{ id: "tmp", name: "수온(℃)", field: "tmp", width: 80, sortable: true, cssClass: "text-align-right" },
											{ id: "phy", name: "pH", field: "phy", width: 80, sortable: true, cssClass: "text-align-right" },
											{ id: "dow", name: "DO(mg/L)", field: "dow", width: 80, sortable: true, cssClass: "text-align-right" },
											{ id: "con", name: "EC(mS/cm)", field: "con", width: 80, sortable: true, cssClass: "text-align-right" }
								]
							}
						];
			var options = {
					enableCellNavigation: true,
					enableColumnReorder: false,
					multiColumnSort: true
			};

			grid2 = new Slick.Grid("#dataList2", dataView2, columns, options);
			
			grid2.setSelectionModel(new Slick.RowSelectionModel());
			
			grid2.onSelectedRowsChanged.subscribe(function() {
				grid2.resetActiveCell();
			});
			
			dataView2.onRowCountChanged.subscribe(function (e, args) {
				grid2.updateRowCount();
				grid2.render();
			});
			
			dataView2.onRowsChanged.subscribe(function (e, args) {
				grid2.invalidateRows(args.rows);
				grid2.render();
			});
			
			grid2.onSort.subscribe(function (e, args) {
				var cols = args.sortCols;

				dataView2.sort(function (dataRow1, dataRow2) {
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
				grid2.invalidate();
				grid2.render();
			});
			
			
		}
		else
		{
			var dataTable_next = "<table style='width:3600px; border-collapse:collapse;' id='dataTable_next' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
			dataTable_next += "<colgroup><col width='90px' /><col width='80px' /><col width='80px' /><col width='80px' /><col width='80px' />";
			
			for(var idx = 0 ; idx < 40 ; idx ++)
			{
				dataTable_next += "<col width='80px'/>";
			}
			dataTable_next += "<col width='80px'/></colgroup>";
			dataTable_next += "<tbody id='valueDataList_next'></tbody>";
			dataTable_next += "</table>";
			
			$("#overBox_next").html(dataTable_next);
			
			
			//slickgrid 20140310 이광복 추가.
	 		dataView2 = new Slick.Data.DataView();
				
			var numberFormatter = function (row, cell, value, columnDef, dataContext) {  
			    try { 
			    	var vId = columnDef.field + "_or";
			    	var vVal= dataContext[vId];
			    	
					switch(vVal)
					{
						case "0":
							return '<font color="green">' + value + '</font>';
							break;
						case "1" :
							return '<font color="blue">' + value + '</font>';
							break;
						case "2" :
							return '<font color="#F0D010">' + value + '</font>';
							break;
						case "3" :
							return '<font color="orange">' + value + '</font>';
							break; 
						case "4" :
							return '<font color="red">' + value + '</font>';
							break;
						default :
							return '<font color="green">' + value + '</font>';
							break;
					}
					
			    } catch (e) {  
			        return '';
			    }  
			} 
			
			var columns = [
							{ id: "datetime", name: "시간", field: "datetime", width: 90, sortable: true },
			                {
			                    id: "COM1",
			                    name: "일반항목",
			                    columns: [
											{ id: "tur", name: "탁도(NTU)", field: "tur", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },	//탁도
											{ id: "phy", name: "pH", field: "phy", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },	//PH
											{ id: "dow", name: "DO(mg/L)", field: "dow", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },	//DO
											{ id: "con", name: "EC(mS/cm)", field: "con", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },	//EC
											{ id: "tmp", name: "수온(℃)", field: "tmp", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }	//수온
			                    ]
			                },
			                {
			                    id: 'ORGA',
			                    name: '유기물질',
			                    columns: [
											{ id: "toc", name: "총유기탄소", field: "toc", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }	//총유기탄소
			                    ]
			                },

			                {
			                    id: 'BIO1',
			                    name: '생물독성(물고기)',
			                    columns: [
											{ id: "imp", name: "임펄스", field: "imp", width: 100, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },

			                {
			                    id: 'BIO2',
			                    name: '생물독성(물벼룩1)',
			                    columns: [
											{ id: "lim", name: "임펄스(좌)", field: "lim", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "rim", name: "임펄스(우)", field: "rim", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },
							
			                {
			                    id: 'BIO3',
			                    name: '생물독성(물벼룩2)',
			                    columns: [
											{ id: "ltx", name: "독성지수(좌)", field: "ltx", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "rtx", name: "독성지수(우)", field: "rtx", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },

			                {
			                    id: 'BIO4',
			                    name: '생물독성(미생물)',
			                    columns: [
											{ id: "tox", name: "미생물독성지수(%)", field: "tox", width: 110, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },

			                {
			                    id: 'BIO5',
			                    name: '생물독성(조류)',
			                    columns: [
											{ id: "evn", name: "조류독성지수", field: "evn", width: 90, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },

			                {
			                    id: 'VOCS',
			                    name: '휘발성유기화합물',
			                    columns: [
											{ id: "voc1", name: "염화메틸렌", field: "voc1", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc2", name: "1.1.1-트리클로로에테인", field: "voc2", width: 130, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc3", name: "벤젠", field: "voc3", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc4", name: "사염화탄소", field: "voc4", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc5", name: "트리클로로에틸렌", field: "voc5", width: 100, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc6", name: "톨루엔", field: "voc6", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc7", name: "테트라클로로에티렌", field: "voc7", width: 110, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc8", name: "에틸벤젠", field: "voc8", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc9", name: "m,p-자일렌", field: "voc9", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc10", name: "o-자일렌", field: "voc10", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc11", name: "[ECD]염화메틸렌", field: "voc11", width: 100, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc12", name: "[ECD]1.1.1-트리클로로에테인", field: "voc12", width: 170, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc13", name: "[ECD]사염화탄소", field: "voc13", width: 100, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc14", name: "[ECD]트리클로로에틸렌", field: "voc14", width: 130, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc15", name: "[ECD]테트라클로로에티렌", field: "voc15", width: 140, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },
			                
			                {
			                    id: 'NUTR',
			                    name: '영양염류',
			                    columns: [
											{ id: "ton", name: "총질소", field: "ton", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "top", name: "총인", field: "top", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "nh4", name: "암모니아성질소", field: "nh4", width: 90, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "no3", name: "질산성질소", field: "no3", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "po4", name: "인산염인", field: "po4", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },
							
			                {
			                    id: 'CHLA',
			                    name: '클로로필-a',
			                    columns: [
											{ id: "tof", name: "클로로필-a", field: "tof", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },
							
			                {
			                    id: 'METL',
			                    name: '중금속',
			                    columns: [
							                { id: "cad", name: "카드뮴", field: "cad", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "plu", name: "납", field: "plu", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "cop", name: "구리", field: "cop", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "zin", name: "아연", field: "zin", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },

			                {
			                    id: 'PHEN',
			                    name: '페놀',
			                    columns: [
											{ id: "phe", name: "페놀1", field: "phe", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "phl", name: "페놀2", field: "phl", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },

			                {
			                    id: 'RAIN',
			                    name: '강수량계',
			                    columns: [
											{ id: "rin", name: "강수량", field: "rin", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                }

						];
			var options = {
					enableCellNavigation: true,
					enableColumnReorder: false,
					multiColumnSort: true
			};

			grid2 = new Slick.Grid("#dataList2", dataView2, columns, options);
			
			grid2.setSelectionModel(new Slick.RowSelectionModel());
			
			grid2.onSelectedRowsChanged.subscribe(function() {
				grid2.resetActiveCell();
			});
			
			dataView2.onRowCountChanged.subscribe(function (e, args) {
				grid2.updateRowCount();
				grid2.render();
			});
			
			dataView2.onRowsChanged.subscribe(function (e, args) {
				grid2.invalidateRows(args.rows);
				grid2.render();
			});
			
			grid2.onSort.subscribe(function (e, args) {
				var cols = args.sortCols;

				dataView2.sort(function (dataRow1, dataRow2) {
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
				grid2.invalidate();
				grid2.render();
			});			
			
		}

		if(result == null || result['refreshData'] == null || result['refreshData'].length == 0)
		{
			$("#searchResult2").show();
// 			$("#dataList2").css("height", "100px");
 			return;
		}
		var tot = result['refreshData'].length;
 		var trClass;
 		
		dataView2.setItems([]);
		 
		$("#searchResult2").hide();
		$("#dataList2").css("height", "400px");
		
		var data = [];

		if( tot <= "0" ){
			$("#searchResult2").show();
			//$("#dataList").css("height", "100px");
		} else {
			var idx = 0;
			for(var i=0; i < tot; i++){
				var obj = result['refreshData'][i];
				var no = 0;
				
				no = i + 1;
				obj.no = no;

				obj.datetime = obj.min_time.substring(5,16);
						
				if(sys_kind != "A")
				{
					obj.tur = (obj.tur != null && obj.tur != '') ? obj.tur : '-';
					obj.tmp = (obj.tmp != null && obj.tmp != '') ? obj.tmp : '-';
					obj.phy = (obj.phy != null && obj.phy != '') ? obj.phy : '-';
					obj.dow = (obj.dow != null && obj.dow != '') ? obj.dow : '-';
					obj.con = (obj.con != null && obj.con != '') ? obj.con : '-';
					obj.tof = (obj.tof != null && obj.tof != '') ? obj.tof : '-';
				}
				
				// 20140310 이광복
				if(sys_kind == "A")
				{
// 					item += getRows(obj, i, "_next");
					obj.tur = (obj.tur != null && obj.tur != '') ? obj.tur : '-';
					obj.phy = (obj.phy != null && obj.phy != '') ? obj.phy : '-';
					obj.dow = (obj.dow != null && obj.dow != '') ? obj.dow : '-';
					obj.con = (obj.con != null && obj.con != '') ? obj.con : '-';
					obj.tmp = (obj.tmp != null && obj.tmp != '') ? obj.tmp : '-';
					obj.toc = (obj.toc != null && obj.toc != '') ? obj.toc : '-';

					obj.imp = (obj.imp != null && obj.imp != '') ? obj.imp : '-';
					obj.lim = (obj.lim != null && obj.lim != '') ? obj.lim : '-';
					obj.rim = (obj.rim != null && obj.rim != '') ? obj.rim : '-';

					obj.ltx = (obj.ltx != null && obj.ltx != '') ? obj.ltx : '-';
					obj.rtx = (obj.rtx != null && obj.rtx != '') ? obj.rtx : '-';

					obj.tox = (obj.tox != null && obj.tox != '') ? obj.tox : '-';
					obj.evn = (obj.evn != null && obj.evn != '') ? obj.evn : '-';

					obj.voc1 = (obj.voc1 != null && obj.voc1 != '') ? obj.voc1 : '-';
					obj.voc2 = (obj.voc2 != null && obj.voc2 != '') ? obj.voc2 : '-';
					obj.voc3 = (obj.voc3 != null && obj.voc3 != '') ? obj.voc3 : '-';
					obj.voc4 = (obj.voc4 != null && obj.voc4 != '') ? obj.voc4 : '-';
					obj.voc5 = (obj.voc5 != null && obj.voc5 != '') ? obj.voc5 : '-';
					obj.voc6 = (obj.voc6 != null && obj.voc6 != '') ? obj.voc6 : '-';
					obj.voc7 = (obj.voc7 != null && obj.voc7 != '') ? obj.voc7 : '-';
					obj.voc8 = (obj.voc8 != null && obj.voc8 != '') ? obj.voc8 : '-';
					obj.voc9 = (obj.voc9 != null && obj.voc9 != '') ? obj.voc9 : '-';
					obj.voc10 = (obj.voc10 != null && obj.voc10 != '') ? obj.voc10 : '-';
					obj.voc11 = (obj.voc11 != null && obj.voc11 != '') ? obj.voc11 : '-';
					obj.voc12 = (obj.voc12 != null && obj.voc12 != '') ? obj.voc12 : '-';
					obj.voc13 = (obj.voc13 != null && obj.voc13 != '') ? obj.voc13 : '-';
					obj.voc14 = (obj.voc14 != null && obj.voc14 != '') ? obj.voc14 : '-';
					obj.voc15 = (obj.voc15 != null && obj.voc15 != '') ? obj.voc15 : '-';
					
					obj.tof = (obj.tof != null && obj.tof != '') ? obj.tof : '-';
					obj.ton = (obj.ton != null && obj.ton != '') ? obj.ton : '-';
					obj.top = (obj.top != null && obj.top != '') ? obj.top : '-';
					obj.nh4 = (obj.nh4 != null && obj.nh4 != '') ? obj.nh4 : '-';
					
					
					obj.no3 = (obj.no3 != null && obj.no3 != '') ? obj.no3 : '-';
					obj.po4 = (obj.po4 != null && obj.po4 != '') ? obj.po4 : '-';

					obj.cad = (obj.cad != null && obj.cad != '') ? obj.cad : '-';
					obj.plu = (obj.plu != null && obj.plu != '') ? obj.plu : '-';

					obj.cop = (obj.cop != null && obj.cop != '') ? obj.cop : '-';
					obj.zin = (obj.zin != null && obj.zin != '') ? obj.zin : '-';
					obj.phe = (obj.phe != null && obj.phe != '') ? obj.phe : '-';
					obj.phl = (obj.phl != null && obj.phl != '') ? obj.phl : '-';

					obj.rin = (obj.rin != null && obj.rin != '') ? obj.rin : '-';
				}
				
				data.push(obj);
			}
			dataView2.beginUpdate();
			dataView2.setItems(data, 'no');
			dataView2.endUpdate();
		}
		//chart();
	}
	
	/*******************************************************************/
	//20140312 이광복 추가
	function refresh_all()
	{
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();

		var branch_no = $("#branch_no").val();

		var beforeBranchNo = $("#branch_no_before").val();
		var nextBranchNo = $("#branch_no_next").val();
		
		var sys_kind = $("#sys").val();
		
		if(branch_no == null || branch_no == "")
			branch_no = "1";

		if(beforeBranchNo == null || beforeBranchNo == "")
			beforeBranchNo = "1";

		if(nextBranchNo == null || nextBranchNo == "")
			nextBranchNo = "1";

		//IP-USN같은 경우에는 검색조건에 설정된 측정소 번호로 조회함
		if(sys_kind == "U")
			branch_no = $("#branchNo").val();

		$("#valueDataList").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러옵니다...</td></tr>");

		$("#searchResult1").hide();
		$("#dataList1").css("height", "49px");
		$("#searchResult1_1").show();

		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/situationctl/getWatersysMntMainDetail_all.do'/>",
			data:{fact_code:fact_code,
					branch_no:branch_no,
					frDate:frDate,
					frTime:frTime,
					toDate:toDate,
					toTime:toTime,
					beforeBranchNo:beforeBranchNo,
					nextBranchNo:nextBranchNo,
					sys_kind:sys_kind},
			dataType:"json",
			success:dataload_success,
			error:function(result){
				$("#valueDataList").html("");
				$("#valueDataList").html("<tr><td colspan='"+(itemCnt + 1)+"'>서버 접속에 실패하였습니다!</td></tr>");
				chartLoaded();
			}
		});
	}
	
	function refresh(){

		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();

		var branch_no= $("#branch_no").val();

		var sys_kind = $("#sys").val();
		
		if(branch_no == null || branch_no == "")
			branch_no = "1";

		//IP-USN같은 경우에는 검색조건에 설정된 측정소 번호로 조회함
		if(sys_kind == "U")
			branch_no = $("#branchNo").val();

		$("#valueDataList").html("<tr><td colspan='"+(itemCnt + 1)+"'>데이터를 불러옵니다...</td></tr>");
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/situationctl/getWatersysMntMainDetail.do'/>",
			data:{fact_code:fact_code,
					branch_no:branch_no,
					frDate:frDate,
					frTime:frTime,
					toDate:toDate,
					toTime:toTime,
					sys_kind:sys_kind},
			dataType:"json",
			success:dataload_success,
			error:function(result){
				$("#valueDataList").html("");
				$("#valueDataList").html("<tr><td colspan='"+(itemCnt + 1)+"'>서버 접속에 실패하였습니다!</td></tr>");
				chartLoaded();
			}
		});
	}

	function dataload_success(result)
	{
		if(result == null || result['refreshData'] == null || result['refreshData'].length == 0)
		{
			$("#searchResult1_1").hide();
			$("#searchResult1").show();
 			$("#dataList1").css("height", "49px");
 			return;
		}

		var tot = result['refreshData'].length;
		var trClass;
		
		$("#overBox").html("");
		
		//데이터 테이블 형식 생성(측정망, 다른 망의 형식이 다르기 때문)
		if(sys_kind != "A")	
		{
			var dataTable = "<table id='dataTable' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
			dataTable += "<colgroup><col width='90px' /><col width='80px' /><col width='80px' /><col width='80px' /><col width='80px' /><col width='80px' /></colgroup>";
			dataTable += "<tbody id='valueDataList'></tbody>";
			dataTable += "</table>";
			$("#overBox").html(dataTable);
			
			if(sys_kind == "U")
			{
				$("#dataTable").css("width","565px");
				$("#dataTableHeader").css("width", "565px");
				$("#overBox").css("overflow-y","scroll");
				$("#overBoxHeader").css("overflow-y", "scroll");
			}
			
			$("#dataList1").css("height", "400px");
			//slickgrid 20140310 이광복 추가.
	 		dataView1 = new Slick.Data.DataView();
				
			var columns = [
							{
								id: 'info',
								name: '기본정보',
								columns: [
											{ id: "datetime", name: "시간", field: "datetime", width: 140, sortable: true },
											{ id: "branch_name", name: "측정소", field: "branch_name", width: 170, sortable: true }
								          ]
							},
							{
								id: 'info2',
								name: '수질정보',
								columns: [
											{ id: "tur", name: "탁도(NTU)", field: "tur", width: 130, sortable: true, cssClass: "text-align-right" },
											{ id: "tmp", name: "수온(℃)", field: "tmp", width: 130, sortable: true, cssClass: "text-align-right" },
											{ id: "phy", name: "pH", field: "phy", width: 130, sortable: true, cssClass: "text-align-right" },
											{ id: "dow", name: "DO(mg/L)", field: "dow", width: 130, sortable: true, cssClass: "text-align-right" },
											{ id: "con", name: "EC(mS/cm)", field: "con", width: 130, sortable: true, cssClass: "text-align-right" }
								]
							}
						];
			var options = {
					enableCellNavigation: true,
					enableColumnReorder: false,
					multiColumnSort: true
			};

			
			grid1 = new Slick.Grid("#dataList1", dataView1, columns, options);
			
			grid1.setSelectionModel(new Slick.RowSelectionModel());
			
			grid1.onSelectedRowsChanged.subscribe(function() {
				grid1.resetActiveCell();
			});
			
			dataView1.onRowCountChanged.subscribe(function (e, args) {
				grid1.updateRowCount();
				grid1.render();
			});
			
			dataView1.onRowsChanged.subscribe(function (e, args) {
				grid1.invalidateRows(args.rows);
				grid1.render();
			});
			
			grid1.onSort.subscribe(function (e, args) {
				var cols = args.sortCols;

				dataView1.sort(function (dataRow1, dataRow2) {
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
				grid1.invalidate();
				grid1.render();
			});
			
		}
		else
		{
			var dataTable = "<table style='width:3600px; border-collapse:collapse;' id='dataTable' oncontextmenu='return false' ondragstart='return false' onselectstart='return false'>";
			dataTable += "<colgroup><col width='90px' /><col width='80px' /><col width='80px' /><col width='80px' /><col width='80px' />";
			
			for(var idx = 0 ; idx < 40 ; idx ++)
			{
				dataTable += "<col width='80px'/>";
			}
			dataTable += "<col width='80px'/></colgroup>";
			dataTable += "<tbody id='valueDataList'></tbody>";
			dataTable += "</table>";
			
			$("#overBox").html(dataTable);
			
			
			$("#dataList1").css("height", "400px");
			//slickgrid 20140310 이광복 추가.
	 		dataView1 = new Slick.Data.DataView();
				
			var numberFormatter = function (row, cell, value, columnDef, dataContext) {  
			    try { 
			    	var vId = columnDef.field + "_or";
			    	var vVal= dataContext[vId];
			    	
					switch(vVal)
					{
						case "0":
							return '<font color="green">' + value + '</font>';
							break;
						case "1" :
							return '<font color="blue">' + value + '</font>';
							break;
						case "2" :
							return '<font color="#F0D010">' + value + '</font>';
							break;
						case "3" :
							return '<font color="orange">' + value + '</font>';
							break; 
						case "4" :
							return '<font color="red">' + value + '</font>';
							break;
						default :
							return '<font color="green">' + value + '</font>';
							break;
					}
					
			    } catch (e) {  
			        return '';
			    }  
			} 
			
			var columns = [
							{
								id: 'info',
								name: '기본정보',
								columns: [
											{ id: "datetime", name: "시간", field: "datetime", width: 100, sortable: true },
											{ id: "branch_name", name: "측정소", field: "branch_name", width: 100, sortable: true }
								          ]
							},
			                {
			                    id: "COM1",
			                    name: "일반항목",
			                    columns: [
											{ id: "tur", name: "탁도(NTU)", field: "tur", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },	//탁도
											{ id: "phy", name: "pH", field: "phy", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },	//PH
											{ id: "dow", name: "DO(mg/L)", field: "dow", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },	//DO
											{ id: "con", name: "EC(mS/cm)", field: "con", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },	//EC
											{ id: "tmp", name: "수온(℃)", field: "tmp", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }	//수온
			                    ]
			                },
			                {
			                    id: 'ORGA',
			                    name: '유기물질',
			                    columns: [
											{ id: "toc", name: "총유기탄소", field: "toc", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }	//총유기탄소
			                    ]
			                },

			                {
			                    id: 'BIO1',
			                    name: '생물독성(물고기)',
			                    columns: [
											{ id: "imp", name: "임펄스", field: "imp", width: 100, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },

			                {
			                    id: 'BIO2',
			                    name: '생물독성(물벼룩1)',
			                    columns: [
											{ id: "lim", name: "임펄스(좌)", field: "lim", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "rim", name: "임펄스(우)", field: "rim", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },
							
			                {
			                    id: 'BIO3',
			                    name: '생물독성(물벼룩2)',
			                    columns: [
											{ id: "ltx", name: "독성지수(좌)", field: "ltx", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "rtx", name: "독성지수(우)", field: "rtx", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },

			                {
			                    id: 'BIO4',
			                    name: '생물독성(미생물)',
			                    columns: [
											{ id: "tox", name: "미생물독성지수(%)", field: "tox", width: 110, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },

			                {
			                    id: 'BIO5',
			                    name: '생물독성(조류)',
			                    columns: [
											{ id: "evn", name: "조류독성지수", field: "evn", width: 90, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },

			                {
			                    id: 'VOCS',
			                    name: '휘발성유기화합물',
			                    columns: [
											{ id: "voc1", name: "염화메틸렌", field: "voc1", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc2", name: "1.1.1-트리클로로에테인", field: "voc2", width: 130, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc3", name: "벤젠", field: "voc3", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc4", name: "사염화탄소", field: "voc4", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc5", name: "트리클로로에틸렌", field: "voc5", width: 100, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc6", name: "톨루엔", field: "voc6", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc7", name: "테트라클로로에티렌", field: "voc7", width: 110, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc8", name: "에틸벤젠", field: "voc8", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc9", name: "m,p-자일렌", field: "voc9", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc10", name: "o-자일렌", field: "voc10", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc11", name: "[ECD]염화메틸렌", field: "voc11", width: 100, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc12", name: "[ECD]1.1.1-트리클로로에테인", field: "voc12", width: 170, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc13", name: "[ECD]사염화탄소", field: "voc13", width: 100, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc14", name: "[ECD]트리클로로에틸렌", field: "voc14", width: 130, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "voc15", name: "[ECD]테트라클로로에티렌", field: "voc15", width: 140, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },
			                
			                {
			                    id: 'NUTR',
			                    name: '영양염류',
			                    columns: [
											{ id: "ton", name: "총질소", field: "ton", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "top", name: "총인", field: "top", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "nh4", name: "암모니아성질소", field: "nh4", width: 90, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "no3", name: "질산성질소", field: "no3", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "po4", name: "인산염인", field: "po4", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },
							
			                {
			                    id: 'CHLA',
			                    name: '클로로필-a',
			                    columns: [
											{ id: "tof", name: "클로로필-a", field: "tof", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },
							
			                {
			                    id: 'METL',
			                    name: '중금속',
			                    columns: [
							                { id: "cad", name: "카드뮴", field: "cad", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "plu", name: "납", field: "plu", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "cop", name: "구리", field: "cop", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "zin", name: "아연", field: "zin", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },

			                {
			                    id: 'PHEN',
			                    name: '페놀',
			                    columns: [
											{ id: "phe", name: "페놀1", field: "phe", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter },
											{ id: "phl", name: "페놀2", field: "phl", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                },

			                {
			                    id: 'RAIN',
			                    name: '강수량계',
			                    columns: [
											{ id: "rin", name: "강수량", field: "rin", width: 80, cssClass: "text-align-right", sortable: true, formatter: numberFormatter }
			                    ]
			                }

						];
			var options = {
					enableCellNavigation: true,
					enableColumnReorder: false,
					multiColumnSort: true
			};

			
			grid1 = new Slick.Grid("#dataList1", dataView1, columns, options);
			
			grid1.setSelectionModel(new Slick.RowSelectionModel());
			
			grid1.onSelectedRowsChanged.subscribe(function() {
				grid1.resetActiveCell();
			});
			
			dataView1.onRowCountChanged.subscribe(function (e, args) {
				grid1.updateRowCount();
				grid1.render();
			});
			
			dataView1.onRowsChanged.subscribe(function (e, args) {
				grid1.invalidateRows(args.rows);
				grid1.render();
			});
			
			grid1.onSort.subscribe(function (e, args) {
				var cols = args.sortCols;

				dataView1.sort(function (dataRow1, dataRow2) {
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
				grid1.invalidate();
				grid1.render();
			});			
			
		}
		
		if(sys_kind != "U")
		{
			//공구 변경시 다시 불러오지 않습니다
// 			if(isBranchChange == null || isBranchChange == false)
				getBranchList_before(result['beforeFactCode'], branch_no);

			
			var factName = result['beforeFactName'];
			
			if(factName != null && factName != undefined && factName != "")
				$("#factName_before").text(factName);
			else
				$("#factName_before").text("없음");
		}
		else
		{
			var factName = result['beforeBranchName'];

			if(factName != null && factName != undefined && factName != "")
				$("#factName_before").text(factName);
			else
				$("#factName_before").text("없음");
		}
		
		if(sys_kind != "U")
		{
			//공구 변경조회시 다시 불러오지 않습니다
// 			if(isBranchChange == null || isBranchChange == false)
				getBranchList_next(result['nextFactCode'], branch_no);
			
			var factName = result['nextFactName'];
			
			if(factName != null && factName != undefined && factName != "")
				$("#factName_next").text(factName);
			else
				$("#factName_next").text("없음");
		}
		else
		{
			var factName = result['nextBranchName'];
			
			if(factName != null && factName != undefined && factName != "")
				$("#factName_next").text(factName);
			else
				$("#factName_next").text("없음");
		}
		
		if(sys_kind != "U")
		{
			var factName = $("#factCode option:selected").text();
			$("#factName").text(factName);
		}
		else
		{
			var factName = $("#branchNo option:selected").text();
			
			try{
				factName = factName.split("-")[0];
			}catch(Exception)
			{}
			
			$("#factName").text(factName);
		}

		//이광복 수정. 20140310

		if(result == null || result['refreshData'] == null || result['refreshData'].length == 0)
		{
// 			$("#valueDataList").html("");
// 			$("#valueDataList").html("<tr><td colspan='"+(itemCnt + 1)+"'>조회 결과가 없습니다</td></tr>");

			chartLoaded();
//			return;
		}

// 		branch_name = result['refreshData'][0].branch_name;
			
// 		$("#valueDataList").html("");
	
		dataView1.setItems([]);
		 
		$("#searchResult1").hide();
		$("#dataList1").css("height", "400px");
		
		var data = [];			
		if( tot <= "0" ){
// 			$("#valueDataList").html("<tr><td colspan='"+(itemCnt + 1)+"'>조회 결과가 없습니다</td></tr>");
	
		//for(var i=0; i<1000; i++){
		//	$("#dataList").append("<tr code=1234 branchNo='1'><td colspan='"+(2 + itemCnt)+"'>"+i+"조회 결과가 없습니다</td></tr>");
		//}	
		$("#searchResult1").show();
		//$("#dataList1").css("height", "100px");
		} else {
			$("#searchResult1_1").hide();
			var idx = 0;
			for(var i=0; i < tot; i++){
				var obj = result['refreshData'][i];
// 				var item;
				
// 				branch_name = obj.min_time;

// 				item = "<tr code='"+obj.fact_code+"' branchNo='"+obj.branch_no+ "'>"
// 						+"<td>"+obj.min_time.substring(5,16)+"</td>";
				var no = 0;
				no = i + 1;
				obj.no = no;

				obj.datetime = obj.min_time.substring(5,16);

				if(sys_kind != "A")
				{
// 					item += "<td class='num'><span id='tur"+i+"'>" + ((obj.tur == "") ? "-" : obj.tur)+ "</span></td>"
// 					+"<td class='num'><span id='tmp"+i+"'>" + ((obj.tmp == "") ? "-" : obj.tmp)+ "</span></td>"
// 					+"<td class='num'><span id='phy"+i+"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
// 					+"<td class='num'><span id='dow"+i+"'>" + ((obj.dow == "") ? "-" : obj.dow)+ "</span></td>"
// 					+"<td class='num'><span id='con"+i+"'>" + ((obj.con == "") ? "-" : obj.con)+ "</span></td>";

// 					if(sys_kind == "U")
// 						item += "<td class='num'><span id='tof"+i+"'>" + ((obj.tof == "") ? "-" : obj.tof)+ "</span></td>";
					obj.tur = (obj.tur != null && obj.tur != '') ? obj.tur : '-';
					obj.tmp = (obj.tmp != null && obj.tmp != '') ? obj.tmp : '-';
					obj.phy = (obj.phy != null && obj.phy != '') ? obj.phy : '-';
					obj.dow = (obj.dow != null && obj.dow != '') ? obj.dow : '-';
					obj.con = (obj.con != null && obj.con != '') ? obj.con : '-';
					obj.tof = (obj.tof != null && obj.tof != '') ? obj.tof : '-';
				}

				if(sys_kind == "A")
				{
// 					item += getRows(obj, i , "");
					obj.tur = (obj.tur != null && obj.tur != '') ? obj.tur : '-';
					obj.phy = (obj.phy != null && obj.phy != '') ? obj.phy : '-';
					obj.dow = (obj.dow != null && obj.dow != '') ? obj.dow : '-';
					obj.con = (obj.con != null && obj.con != '') ? obj.con : '-';
					obj.tmp = (obj.tmp != null && obj.tmp != '') ? obj.tmp : '-';
					obj.toc = (obj.toc != null && obj.toc != '') ? obj.toc : '-';

					obj.imp = (obj.imp != null && obj.imp != '') ? obj.imp : '-';
					obj.lim = (obj.lim != null && obj.lim != '') ? obj.lim : '-';
					obj.rim = (obj.rim != null && obj.rim != '') ? obj.rim : '-';

					obj.ltx = (obj.ltx != null && obj.ltx != '') ? obj.ltx : '-';
					obj.rtx = (obj.rtx != null && obj.rtx != '') ? obj.rtx : '-';

					obj.tox = (obj.tox != null && obj.tox != '') ? obj.tox : '-';
					obj.evn = (obj.evn != null && obj.evn != '') ? obj.evn : '-';

					obj.voc1 = (obj.voc1 != null && obj.voc1 != '') ? obj.voc1 : '-';
					obj.voc2 = (obj.voc2 != null && obj.voc2 != '') ? obj.voc2 : '-';
					obj.voc3 = (obj.voc3 != null && obj.voc3 != '') ? obj.voc3 : '-';
					obj.voc4 = (obj.voc4 != null && obj.voc4 != '') ? obj.voc4 : '-';
					obj.voc5 = (obj.voc5 != null && obj.voc5 != '') ? obj.voc5 : '-';
					obj.voc6 = (obj.voc6 != null && obj.voc6 != '') ? obj.voc6 : '-';
					obj.voc7 = (obj.voc7 != null && obj.voc7 != '') ? obj.voc7 : '-';
					obj.voc8 = (obj.voc8 != null && obj.voc8 != '') ? obj.voc8 : '-';
					obj.voc9 = (obj.voc9 != null && obj.voc9 != '') ? obj.voc9 : '-';
					obj.voc10 = (obj.voc10 != null && obj.voc10 != '') ? obj.voc10 : '-';
					obj.voc11 = (obj.voc11 != null && obj.voc11 != '') ? obj.voc11 : '-';
					obj.voc12 = (obj.voc12 != null && obj.voc12 != '') ? obj.voc12 : '-';
					obj.voc13 = (obj.voc13 != null && obj.voc13 != '') ? obj.voc13 : '-';
					obj.voc14 = (obj.voc14 != null && obj.voc14 != '') ? obj.voc14 : '-';
					obj.voc15 = (obj.voc15 != null && obj.voc15 != '') ? obj.voc15 : '-';
					
					obj.tof = (obj.tof != null && obj.tof != '') ? obj.tof : '-';
					obj.ton = (obj.ton != null && obj.ton != '') ? obj.ton : '-';
					obj.top = (obj.top != null && obj.top != '') ? obj.top : '-';
					obj.nh4 = (obj.nh4 != null && obj.nh4 != '') ? obj.nh4 : '-';
					
					
					obj.no3 = (obj.no3 != null && obj.no3 != '') ? obj.no3 : '-';
					obj.po4 = (obj.po4 != null && obj.po4 != '') ? obj.po4 : '-';

					obj.cad = (obj.cad != null && obj.cad != '') ? obj.cad : '-';
					obj.plu = (obj.plu != null && obj.plu != '') ? obj.plu : '-';

					obj.cop = (obj.cop != null && obj.cop != '') ? obj.cop : '-';
					obj.zin = (obj.zin != null && obj.zin != '') ? obj.zin : '-';
					obj.phe = (obj.phe != null && obj.phe != '') ? obj.phe : '-';
					obj.phl = (obj.phl != null && obj.phl != '') ? obj.phl : '-';

					obj.rin = (obj.rin != null && obj.rin != '') ? obj.rin : '-';
				}
				
				data.push(obj);
			}
			dataView1.beginUpdate();
			dataView1.setItems(data, 'no');
			dataView1.endUpdate();
		}
		//chart();
	}

	function setMinOr_Color(minorVal, tdObj)
	{
		tdObj.css("font-weight", "bold");
		
		switch(minorVal)
		{
			case "0":
				tdObj.css("color", "green");
				break;
			case "1" :
				tdObj.css("color", "blue");
				break;
			case "2" :
				tdObj.css("color", "#F0D010");
				break;
			case "3" :
				tdObj.css("color", "orange");
				break; 
			case "4" :
				tdObj.css("color", "red");
				break;
			default :
				//tdObj.css("color", "black");
				tdObj.css("color", "green");
				break;
		}
	}

	function chart(){
// 		var width = "1180";
		var width = "1010";
		var height = "210";
		var item = $("#graphItem").val();

		var fact_code = $("#factCode").val();
		var sys_kind = $("#sys").val();
		var fact_name = '';
		var branch_no= $("#branch_no").val();

		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		
		
		var branch_no_before = $("#branch_no_before").val();
		var branch_no_next = $("#branch_no_next").val();
		
// 		console.log("sys_kind",sys_kind);
		if(sys_kind == "U") 
			branch_no = $("#branchNo").val();
		else
			width = "978";
		
		document.chartForm.target = "chart";
		document.chartForm.factCode.value = fact_code;
		document.chartForm.branchNo.value = branch_no;
		document.chartForm.branchNo_before.value = branch_no_before;
		document.chartForm.branchNo_next.value = branch_no_next;
		document.chartForm.branchName.value = branch_name;
		document.chartForm.sys_kind.value = sys_kind;
		document.chartForm.frDate.value = frDate;
		document.chartForm.frTime.value = frTime;
		document.chartForm.toDate.value = toDate;
		document.chartForm.toTime.value = toTime;
		document.chartForm.item.value = item;
		document.chartForm.width.value = width;
		document.chartForm.height.value = height;
		
		document.chartForm.action = "<c:url value='/waterpolmnt/situationctl/getWatersysMntDetailGraph.do?'/>";
		
		document.chartForm.submit();
	}

	function getRows(obj, i, div)
	{
		var item = "";
		
		item += ""
		+"<td class='num'><span id='tur"+ div+i+"'>" + ((obj.tur == "") ? "-" : obj.tur)+ "</span></td>"
		+"<td class='num'><span id='phy" + div + i +"'>" + ((obj.phy == "") ? "-" : obj.phy)+ "</span></td>"
		+"<td class='num'><span id='dow"+ div+i+"'>" + ((obj.dow == "") ? "-" : obj.dow)+ "</span></td>"
		+"<td class='num'><span id='con"+ div+i+"'>" + ((obj.con == "") ? "-" : obj.con)+ "</span></td>"
		+"<td class='num'><span id='tmp"+ div+i+"'>" + ((obj.tmp == "") ? "-" : obj.tmp)+ "</span></td>"
		//+"<td class='num'><span id='phy2_"+ div+i+"'>" + ((obj.phy2 == "") ? "-" : obj.phy2)+ "</span></td>"
		//+"<td class='num'><span id='dow2_"+ div+i+"'>" + ((obj.dow2 == "") ? "-" : obj.dow2)+ "</span></td>"
		//+"<td class='num'><span id='con2_"+ div+i+"'>" + ((obj.con2 == "") ? "-" : obj.con2)+ "</span></td>"
		//+"<td class='num'><span id='tmp2_"+ div+i+"'>" + ((obj.tmp2 == "") ? "-" : obj.tmp2)+ "</span></td>"
		+"<td class='num'><span id='toc"+ div+i+"'>" + ((obj.toc == "") ? "-" : obj.toc)+ "</span></td>"
		+"<td class='num'><span id='imp"+ div+i+"'>" + ((obj.imp == "") ? "-" : obj.imp)+ "</span></td>"
		+"<td class='num'><span id='lim"+ div+i+"'>" + ((obj.lim == "") ? "-" : obj.lim)+ "</span></td>"
		+"<td class='num'><span id='rim"+ div+i+"'>" + ((obj.rim == "") ? "-" : obj.rim)+ "</span></td>"
		+"<td class='num'><span id='ltx"+ div+i+"'>" + ((obj.ltx == "") ? "-" : obj.ltx)+ "</span></td>"
		+"<td class='num'><span id='rtx"+ div+i+"'>" + ((obj.rtx == "") ? "-" : obj.rtx)+ "</span></td>"
		+"<td class='num'><span id='tox"+ div+i+"'>" + ((obj.tox == "") ? "-" : obj.tox)+ "</span></td>"
		+"<td class='num'><span id='evn"+ div+i+"'>" + ((obj.evn == "") ? "-" : obj.evn)+ "</span></td>"
		+"<td class='num'><span id='voc1_"+ div+i+"'>" + ((obj.voc1 == "") ? "-" : obj.voc1)+ "</span></td>"
		+"<td class='num'><span id='voc2_"+ div+i+"'>" + ((obj.voc2 == "") ? "-" : obj.voc2)+ "</span></td>"
		+"<td class='num'><span id='voc3_"+ div+i+"'>" + ((obj.voc3 == "") ? "-" : obj.voc3)+ "</span></td>"
		+"<td class='num'><span id='voc4_"+ div+i+"'>" + ((obj.voc4 == "") ? "-" : obj.voc4)+ "</span></td>"
		+"<td class='num'><span id='voc5_"+ div+i+"'>" + ((obj.voc5 == "") ? "-" : obj.voc5)+ "</span></td>"
		+"<td class='num'><span id='voc6_"+ div+i+"'>" + ((obj.voc6 == "") ? "-" : obj.voc6)+ "</span></td>"
		+"<td class='num'><span id='voc7_"+ div+i+"'>" + ((obj.voc7 == "") ? "-" : obj.voc7)+ "</span></td>"
		+"<td class='num'><span id='voc8_"+ div+i+"'>" + ((obj.voc8 == "") ? "-" : obj.voc8)+ "</span></td>"
		+"<td class='num'><span id='voc9_"+ div+i+"'>" + ((obj.voc9 == "") ? "-" : obj.voc9)+ "</span></td>"
		+"<td class='num'><span id='voc10_"+ div+i+"'>" + ((obj.voc10 == "") ? "-" : obj.voc10)+ "</span></td>"
		+"<td class='num'><span id='voc11_"+ div+i+"'>" + ((obj.voc11 == "") ? "-" : obj.voc11)+ "</span></td>"
		+"<td class='num'><span id='voc12_"+ div+i+"'>" + ((obj.voc12 == "") ? "-" : obj.voc12)+ "</span></td>"
		+"<td class='num'><span id='voc13_"+ div+i+"'>" + ((obj.voc13 == "") ? "-" : obj.voc13)+ "</span></td>"
		+"<td class='num'><span id='voc14_"+ div+i+"'>" + ((obj.voc14 == "") ? "-" : obj.voc14)+ "</span></td>"
		+"<td class='num'><span id='voc15_"+ div+i+"'>" + ((obj.voc15 == "") ? "-" : obj.voc15)+ "</span></td>"
		+"<td class='num'><span id='ton"+ div+i+"'>" + ((obj.ton == "") ? "-" : obj.ton)+ "</span></td>"
		+"<td class='num'><span id='top"+ div+i+"'>" + ((obj.top == "") ? "-" : obj.top)+ "</span></td>"
		+"<td class='num'><span id='nh4"+ div+i+"'>" + ((obj.nh4 == "") ? "-" : obj.nh4)+ "</span></td>"
		+"<td class='num'><span id='no3"+ div+i+"'>" + ((obj.no3 == "") ? "-" : obj.no3)+ "</span></td>"
		+"<td class='num'><span id='po4"+ div+i+"'>" + ((obj.po4 == "") ? "-" : obj.po4)+ "</span></td>"
		+"<td class='num'><span id='tof"+ div+i+"'>" + ((obj.tof == "") ? "-" : obj.tof)+ "</span></td>"
		+"<td class='num'><span id='cad"+ div+i+"'>" + ((obj.cad == "") ? "-" : obj.cad)+ "</span></td>"
		+"<td class='num'><span id='plu"+ div+i+"'>" + ((obj.plu == "") ? "-" : obj.plu)+ "</span></td>"
		+"<td class='num'><span id='cop"+ div+i+"'>" + ((obj.cop == "") ? "-" : obj.cop)+ "</span></td>"
		+"<td class='num'><span id='zin"+ div+i+"'>" + ((obj.zin == "") ? "-" : obj.zin)+ "</span></td>"
		+"<td class='num'><span id='phe"+ div+i+"'>" + ((obj.phe == "") ? "-" : obj.phe)+ "</span></td>"
		+"<td class='num'><span id='phl"+ div+i+"'>" + ((obj.phl == "") ? "-" : obj.phl)+ "</span></td>"
		+"<td class='num'><span id='rin"+ div+i+"'>" + ((obj.rin == "") ? "-" : obj.rin)+ "</span></td>";

		return item;
	}

	function setMinor_list(obj, i, div)
	{
		setMinOr_Color(obj.tur_or, $("#tur" + div + i));
		setMinOr_Color(obj.tmp_or, $("#tmp" + div + i));
		setMinOr_Color(obj.phy_or, $("#phy"+ div + i));
		setMinOr_Color(obj.dow_or, $("#dow"+ div + i));
		setMinOr_Color(obj.con_or, $("#con"+ div + i));

		setMinOr_Color(obj.phy2_or, $("#phy2_"+ div + i));
		setMinOr_Color(obj.dow2_or, $("#dow2_"+ div + i));
		setMinOr_Color(obj.con2_or, $("#con2_"+ div + i));
		setMinOr_Color(obj.tmp2_or, $("#tmp2_"+ div + i));
		
		setMinOr_Color(obj.imp_or, $("#imp"+ div + i));
		setMinOr_Color(obj.lim_or, $("#lim"+ div + i));
		setMinOr_Color(obj.rim_or, $("#rim"+ div + i));
		setMinOr_Color(obj.ltx_or, $("#ltx"+ div + i));
		setMinOr_Color(obj.rtx_or, $("#rtx"+ div + i));
		setMinOr_Color(obj.tox_or, $("#tox"+ div + i));
		setMinOr_Color(obj.evn_or, $("#evn"+ div + i));
		setMinOr_Color(obj.tof_or, $("#tof"+ div+ i));
		
		setMinOr_Color(obj.voc1_or, $("#voc1_" + div+ i));
		setMinOr_Color(obj.voc2_or, $("#voc2_" + div+ i));
		setMinOr_Color(obj.voc3_or, $("#voc3_" + div+ i));
		setMinOr_Color(obj.voc4_or, $("#voc4_" + div+ i));
		setMinOr_Color(obj.voc5_or, $("#voc5_" + div+ i));
		setMinOr_Color(obj.voc6_or, $("#voc6_" + div+ i));
		setMinOr_Color(obj.voc7_or, $("#voc7_" + div+ i));
		setMinOr_Color(obj.voc8_or, $("#voc8_" + div+ i));
		setMinOr_Color(obj.voc9_or, $("#voc9_" + div+ i));
		setMinOr_Color(obj.voc10_or, $("#voc10_" + div+ i));
		setMinOr_Color(obj.voc11_or, $("#voc11_" + div+ i));
		setMinOr_Color(obj.voc12_or, $("#voc12_" + div+ i));
		setMinOr_Color(obj.voc13_or, $("#voc13_" + div+ i));
		setMinOr_Color(obj.voc14_or, $("#voc14_" + div+ i));
		setMinOr_Color(obj.voc15_or, $("#voc15_" + div+ i));

		setMinOr_Color(obj.cad_or, $("#cad" + div+ i));
		setMinOr_Color(obj.plu_or, $("#plu" + div+ i));
		setMinOr_Color(obj.cop_or, $("#cop" + div+ i));
		setMinOr_Color(obj.zin_or, $("#zin" + div+ i));

		setMinOr_Color(obj.phe_or, $("#phe" + div+ i));
		setMinOr_Color(obj.phl_or, $("#phl" + div+ i));

		setMinOr_Color(obj.toc_or, $("#toc" + div+ i));
		
		setMinOr_Color(obj.ton_or, $("#ton" + div+ i));
		setMinOr_Color(obj.top_or, $("#top" + div+ i));
		setMinOr_Color(obj.nh4_or, $("#nh4" + div+ i));
		setMinOr_Color(obj.no3_or, $("#no3" + div+ i));
		setMinOr_Color(obj.po4_or, $("#po4" + div+ i));

		setMinOr_Color(obj.rin_or, $("#rin" + div+ i));
	}



	function validation(){
		if( $('#startDate').val() == "" ){ alert("조회 시작일자를 선택하세요"); return false; }
		if( $('#endDate').val() == "" ){ alert("조회 종료일자를 선택하세요"); return false; }
		if(!timeCheck()) {return false;}
	}

	function timeCheck()
	{
		var stdt = document.getElementById("startDate");
		var endt = document.getElementById("endDate");
		
		if(stdt.value == endt.value)
		{
			var frTime = $("#frTime").val();
			var toTime = $("#toTime").val();

			if(frTime > toTime)
			{
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
		
		if(endt.value != '' && stdt.value > endt.value) {
			alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			stdt.value = "";
			endt.value = "";
			stdt.focus();
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
						
						<form id="chartForm" name="chartForm" method="post">
							<input type="hidden" name="factCode" />
							<input type="hidden" name="branchNo" />
							<input type="hidden" name="branchNo_before"/>
							<input type="hidden" name="branchNo_next"/>
							<input type="hidden" name="branchName" />
							<input type="hidden" name="sys_kind" />
							<input type="hidden" name="frDate" />
							<input type="hidden" name="frTime" />
							<input type="hidden" name="toDate" />
							<input type="hidden" name="toTime" />
							<input type="hidden" name="width"/>
							<input type="hidden" name="height"/>
							<input type="hidden" name="item"/>
						</form>
						<!-- 하천 수질 조회 -->
						<form:form commandName="searchTaksuVO" name="listFrm"  id="listFrm" method="post">
							<input type="hidden" name="pageIndex" id="pageIndex" value="${searchTaksuVO.pageIndex}"/>
							<input type="hidden" name="chukjeongso" id="chukjeongso"/>
							<input type="hidden" name="gongku" id="gongku"/>
							<input type="hidden" name="sugye" id="river_div"/>
							<input type="hidden" name="frDate" id="frDate"/>
							<input type="hidden" name="toDate" id="toDate"/>
							<input type="hidden" name="item01" id="item01"/>
							<input type="hidden" name="item02" id="item02"/>
							<input type="hidden" name="item03" id="item03"/>
							<input type="hidden" name="item04" id="item04"/>
							<input type="hidden" name="item05" id="item05"/>
						
							<div class="searchBox">
								<ul>
									<li>
										<select class="fixWidth7" id="sugye">
											<option value="R01">한강</option>
											<option value="R02">낙동강</option>
											<option value="R03">금강</option>
											<option value="R04">영산강</option>
										</select>
										<span>&gt;</span>
										<select class="fixWidth11" id="factCode">
											<option value="all">전체</option>
										</select>
										<span id="spanBranch" style="display:none">
											<span>&gt;</span>
											<select class="fixWidth11" id="branchNo" name="branchNo" disabled="disabled">
												<option value="all">전체</option>
											</select>
										</span>
									</li>
									<li>
										<select class="fixWidth13" id="sys" name="sys">
											<option value="U" selected="selected">이동형측정기기</option>
<!--											<option value="T">탁수모니터링</option> -->
											<option value="A">국가수질자동측정망</option>
										</select>
									</li>
									<li>
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
									<li class="last">
										<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" onclick="javascript:reloadData();" alt="조회" />
									</li>
								</ul>
							</div>
						</form:form>
						<!-- //수질 조회 현황 -->

						<div id="btArea"><span class="red">※조사결과는 확정자료가 아닙니다</span></div>
						
									<div class="listBox">
										<ul>
											<li>
												<span id='factName_before' class="buSqu_tit txtalignL">-</span>
												<span>&nbsp;</span>
												<select id="branch_no_before">
													<option value="1"></option>
												</select>
												<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
												<span id='factName' class="buSqu_tit txtalignL">-</span>
												<span>&nbsp;</span>
												<select id="branch_no"></select>
												<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>
												<span id='factName_next' class="buSqu_tit txtalignL">-</span>
												<span>&nbsp;</span>
												<select id="branch_no_next">
													<option value="1"></option>
												</select>
											</li>
										</ul>
									</div>
									
									<form action="">
									
								<div id="dataList1" style="height: 400px;"></div>
								<table id="searchResult1" style="display:none" summary="이동형측정기기정보"><tr><td><span id="resultText">조회 결과가 없습니다.</span></td></tr></table>
								<table id="searchResult1_1" style="display:none" summary="이동형측정기기정보"><tr><td><span id="resultText">데이터를 불러오는 중 입니다.....</span></td></tr></table>
										
										<script type="text/javascript">
											function scrollX()
											{		
												document.getElementById("overBoxHeader").scrollLeft = document.getElementById("overBox").scrollLeft;
											}
										</script>
									</form>
						<br />
						<!-- 20100721 추가 -->
						<div class="table_wrapper" style="clear:both;border:1px solid #b7b7b7;padding:5px;">
							<div style="width:120px;padding-bottom:5px;padding-top:10px;text-align:right;float:right;position:absolute;padding-left:850px">
								<select id="graphItem" style="width:82px">
									<option value="TUR00">탁도</option>
									<option value="TMP00">수온</option>
									<option value="PHY00">pH</option>
									<option value="DOW00">용존산소</option>
									<option value="CON00">전기전도도</option>
								</select>
							</div>
							<div class="overBox" style="overflow-x:auto;overflow-y:none;">
<!-- 								<iframe id="chart" name="chart" src="" onload="chartLoaded()" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="1180px" height="210px"></iframe> -->
								<iframe id="chart" name="chart" src="" onload="chartLoaded()" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="978px" height="210px"></iframe>
							</div>
						</div>
						<!-- //20100721 추가 -->
						
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