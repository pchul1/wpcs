<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : selectriver.jsp
	 * Description : IP-USN정보 선별 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2014.09.16	smji		최초 생성
	 * 
	 * author smji
	 * since 2011.09.16
	 * `
	 * Copyright (C) 2010 by smji  All right reserved.
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
		//메시지처리
		<c:if test="${not empty message }">
			alert("${message}");
		</c:if>
		
		//공통코드 등록 레이어
		$("#layerSelectData").draggable({
			containment: 'window',
			scroll: false
		});
		
		//초기 시작값의 현재 시각 선택
		var date = new Date();
		var hour = date.getHours();
		time=hour<10?"0"+hour:hour;
		t_time = hour-2>0?hour-2:0;
		fritime=t_time<10?"0"+t_time:t_time;
		fritime = "00";
		time = "23";
		$("#toTime option[value="+time+"]").attr("selected", "true");
		$("#frTime option[value="+fritime+"]").attr("selected", "true");
		
		var today = new Date(); 
		var yday = new Date(Date.parse(today) - 1 * 1000 * 60 * 60 * 12);
		
// 		yday = yday.getFullYear()+ "/" + addzero(yday.getMonth()+1-1) + "/" + addzero(yday.getDate());
		yday = "2014/07/01"
// 		today = today.getFullYear()+ "/" + addzero(today.getMonth()+1-1) + "/" + addzero(today.getDate());
		today = "2014/07/01"
		
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
			$("#sys > option[value=T]").attr("selected", "true");
			$("#sys").attr("disabled", "disabled");
			
			$("#sugye > option[value="+memRiverDiv+"]").attr("selected", "true");
			$("#sugye").attr("disabled", "disabled");
		}
		
		adjustGongku();
		
		$('#sugye').change(function(){
			adjustGongku();		//수계 2  조회
			adjustBranchList();	//수계 3  조회
		});
		
	});
	
	var itemCnt;
	
	//측정소가 전체가 아닐때만 그래프 버튼이 표시됩니다.
	function setGraphBtn()
	{
		if($('#branchNo').val() == "all")
		{
			$('#a_chartPopup').attr("onclick", "#");
			$('#a_chartPopup').hide();
		}
		else
		{
			$('#a_chartPopup').attr("onclick","javascript:chartPopup()");
			$('#a_chartPopup').fadeIn('fast');
		}
	}
	
	var firstFlag = false;
	
	function adjustGongku()
	{
		var sugyeCd = $('#sugye').val();
		
		var dropDownSet = $('#factCode');
		var dropDownSet_branchNo = $('#branchNo');
		
		dropDownSet.attr("style", "background:#ffffff;");
		dropDownSet_branchNo.attr("style", "background:#ffffff;");
		
		$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>",
				{sugye:sugyeCd, system:'U'},
				function (data, status){
				if(status == 'success'){
					if (data.gongku.length != 1) {
						dropDownSet.loadSelect_all(data.gongku);
					} else {
						dropDownSet.loadSelect(data.gongku);
						dropDownSet.attr("disabled", true);
						dropDownSet.attr("style", "background:#e9e9e9;");
					}
					
					if(memFactCode != null && memFactCode != "")
					{
						$("#factCode>option[value="+memFactCode+"]").attr("selected", "selected");
						$("#factCode").attr("disabled", "disabled");
					}
					
					adjustBranchList();
					
					if(memFactCode == 'all')
						dropDownSet_branchNo.attr("disabled", true);
				
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
		var sys_kind = $("#sys").val();
		
		var dropDownSet = $('#branchNo');
		dropDownSet.attr("disabled", false);
		var url = "<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>";
		$.getJSON(url, {factCode:factCode}, function (data, status){
			if(status == 'success'){
				dropDownSet.loadSelect(data.branch);
				if(!firstFlag){
					reloadData();
					firstFlag = true;
				}
			} else { 
				alert("공구 목록 가져오기 실패");
				return;
			}
		});
	}
	
	
	
	
	
	
	function reloadData(pageNo){
		layerPopCloseAll();
		
		var valueFormatter = function (row, cell, value, columnDef, dataContext) {
			var id_over = columnDef.field+"_over";
			var val_over= dataContext[id_over];
			
			var id_sel = columnDef.field+"_sel";
			var val_sel= dataContext[id_sel];
			
			if(val_sel != ""){
				return '<div style="width:100%; padding-right:5px; background:#B2CCFF; color:blue;">' + value + '</div>';
			}else{
				if(val_over > 0){
					return '<div style="width:100%; padding-right:5px; background:#FFA7A7; color:red;">' + value + '</div>';
				}else{
					return '<div style="width:100%; padding-right:5px;">' + value + '</div>';
				}
			}
		}
		
		dataView = new Slick.Data.DataView();
		
		var columns = [
						{ id: "no", name: "No", field: "no", width: 45, sortable: true },
						{ id: "river_name", name: "수계", field: "river_name", width: 80, sortable: true },
						{ id: "branch_name", name: "측정소", field: "branch_name", width: 120, sortable: true },
						{ id: "str_date", name: "수신일자", field: "str_date", width: 105, sortable: true },
						{ id: "str_time", name: "수신시간", field: "str_time", width: 70, sortable: true },
						{ id: "tur", name: "탁도(NTU)", field: "tur", width: 95, cssClass: "text-align-right", sortable: true, formatter: valueFormatter },
						{ id: "tmp", name: "수온(℃)", field: "tmp", width: 95, cssClass: "text-align-right", sortable: true, formatter: valueFormatter },
						{ id: "phy", name: "pH", field: "phy", width: 95, cssClass: "text-align-right", sortable: true, formatter: valueFormatter },
						{ id: "dow", name: "DO(mg/L)", field: "dow", width: 95, cssClass: "text-align-right", sortable: true, formatter: valueFormatter },
						{ id: "con", name: "EC(mS/cm)", field: "con", width: 95, cssClass: "text-align-right", sortable: true, formatter: valueFormatter },
						{ id: "tof", name: "Chl-a(μg/L)", field: "tof", width: 95, cssClass: "text-align-right20", sortable: true, formatter: valueFormatter },
						{ id: "tur_sel", name: "tur_sel" , field: "tur_sel", width: 0, minWidth: 0, maxWidth: 0, cssClass: "really-hidden", headerCssClass: "really-hidden" },
						{ id: "tmp_sel", name: "tmp_sel" , field: "tmp_sel", width: 0, minWidth: 0, maxWidth: 0, cssClass: "really-hidden", headerCssClass: "really-hidden" },
						{ id: "phy_sel", name: "phy_sel" , field: "phy_sel", width: 0, minWidth: 0, maxWidth: 0, cssClass: "really-hidden", headerCssClass: "really-hidden" },
						{ id: "dow_sel", name: "dow_sel" , field: "dow_sel", width: 0, minWidth: 0, maxWidth: 0, cssClass: "really-hidden", headerCssClass: "really-hidden" },
						{ id: "con_sel", name: "con_sel" , field: "con_sel", width: 0, minWidth: 0, maxWidth: 0, cssClass: "really-hidden", headerCssClass: "really-hidden" },
						{ id: "tof_sel", name: "tof_sel" , field: "tof_sel", width: 0, minWidth: 0, maxWidth: 0, cssClass: "really-hidden", headerCssClass: "really-hidden" }
					];
		var options = {
				enableCellNavigation: true,
				enableColumnReorder: false,
				multiColumnSort: true
		};
		
		grid = new Slick.Grid("#dataList", dataView, columns, options);
		
		grid.setSelectionModel(new Slick.RowSelectionModel());


		grid.onSelectedRowsChanged.subscribe(function(e, args) {
			grid.resetActiveCell();
		});
		
		grid.onClick.subscribe(function(e, args) {
			var cols = grid.getColumns();
			var field = cols[args.cell].field;
			var dataRow = grid.getDataItem(args.row);
			var sel_seq = 0;
			
			if(field == "tur"){
				sel_seq = dataRow.tur_sel;
			}else if(field == "tmp"){
				sel_seq = dataRow.tmp_sel;
			}else if(field == "phy"){
				sel_seq = dataRow.phy_sel;
			}else if(field == "dow"){
				sel_seq = dataRow.dow_sel;
			}else if(field == "con"){
				sel_seq = dataRow.con_sel;
			}else if(field == "tof"){
				sel_seq = dataRow.tof_sel;
			}
			
			if(sel_seq != 0){
				selectData(sel_seq);
			}else{
				dataRow.sel_item = field.toUpperCase()+"00";;
				popupData(dataRow);
			}
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
		
		if( validation() == false ) return;
		
		setGraphBtn();
		showLoading();
		
		var sugye = $("#sugye").val();
		var gongku = $("#factCode").val();
		var chukjeongso = $("#branchNo").val();
		var frDate = $("#startDate").val2();
		var toDate = $("#endDate").val2();
		var frTime = $("#frTime").val();
		var toTime = $("#toTime").val();
		var strange = $("#strange").val();
		
		if(gongku == null || gongku == "unknowned" || sugye == null || sugye == "unknowned"){
			alert("측정소 정보가 없습니다.");
			return;
		}
			
		if (pageNo == null) pageNo = 1;
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getSelectDataList.do'/>",
			data:{
					sugye:sugye,
					gongku:gongku,
					chukjeongso:chukjeongso,
					frDate:frDate,
					toDate:toDate,
					frTime:frTime,
					toTime:toTime,
					strange:strange,
					pageIndex:pageNo
			},
			dataType:"json",
			success:function(result){
				console.log("결과 값 확인 : ",result);
				
				$("#gongku").val(gongku);
				$("#chukjeongso").val(chukjeongso);
				
				var tot = result['detailViewList'].length;
				var pageInfo = result['paginationInfo'];
				
				dataView.setItems([]);
				$("#searchResult").hide();
				
				var height = sGridCmn(1,result['detailViewList'],20);
				$("#dataList").css("height", height + "px");
				grid.resizeCanvas();
				
				var data = [];
				
				
				if( tot <= 0 ){
					dataView.getItemMetadata = function () {
						return {"columns":{0:{"colspan":"*"}}};
					}
					data.push({no:"조회 결과가 없습니다."});
					dataView.setItems(data, 'no');
					
					var height = sGridCmn(1,data,1);
					$("#dataList").css("height", height + "px");
					grid.resizeCanvas();
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						
						var factNumber = "";
						
						if(sugye == 'R01')
							factNumber = obj.fact_name.replace('한강', '');
						else if(sugye == 'R02')
							factNumber = obj.fact_name.replace('낙동강', '');
						else if(sugye == 'R03')
							factNumber = obj.fact_name.replace('금강', '');
						else if(sugye == 'R04')
							factNumber = obj.fact_name.replace('영산강','');
							
						obj.factNumber = factNumber.replace("_", "");
						
						obj.tur = (obj.tur != null && obj.tur != '') ? obj.tur : '-';
						obj.tmp = (obj.tmp != null && obj.tmp != '') ? obj.tmp : '-';
						obj.phy = (obj.phy != null && obj.phy != '') ? obj.phy : '-';
						obj.dow = (obj.dow != null && obj.dow != '') ? obj.dow : '-';
						obj.con = (obj.con != null && obj.con != '') ? obj.con : '-';
						obj.tof = (obj.tof != null && obj.tof != '') ? obj.tof : '-';
						
						data.push(obj);
					}
					dataView.beginUpdate();
					dataView.setItems(data, 'no');
					dataView.endUpdate();
					
				}
				
				
				$("#p_total_cnt").html("[총 " + result['totCnt'] + "건] <span class='red'>※조회결과는 확정자료가 아닙니다.</span>");
				
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
				data.push({no:"서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]"});
				dataView.setItems(data, 'no');
				
				var height = sGridCmn(1,data,1);
				$("#dataList").css("height", height + "px");
				grid.resizeCanvas();
				
				closeLoading();
			}
		});
	}
	
	
	function initializeSetting(){
		$('#trImg_1').hide();
		$('#trImg_2').hide();
		$('#deleteBtn').hide();
		
		$("#cmd").val("");
		$("#sel_seq").val("");
		$("#del_yn option[value=Y]").attr("selected", "true");
		$("#sel_item option[value=all]").attr("selected", "true");
		$("#strSelDate").val("");
		$("#endSelDate").val("");
		$("#frSelTime option[value=00]").attr("selected", "true");
		$("#toSelTime option[value=00]").attr("selected", "true");
		$("#frSelMin option[value=00]").attr("selected", "true");
		$("#toSelMin option[value=00]").attr("selected", "true");
		$("#sel_reason").val("");
	}
	
	function popupData(obj){
		var gongku = $('#gongku').val();
		var chukjeongso = $('#chukjeongso').val();
		
		initializeSetting();//초기화
		
		if(obj != null){
			$("#sel_item option[value="+obj.sel_item+"]").attr("selected", "true");
			$("#strSelDate").val(obj.str_date);
			$("#endSelDate").val(obj.str_date);
			$("#frSelTime option[value="+obj.str_time.split(":")[0]+"]").attr("selected", "true");
			$("#toSelTime option[value="+obj.str_time.split(":")[0]+"]").attr("selected", "true");
			$("#frSelMin option[value="+obj.str_time.split(":")[1]+"]").attr("selected", "true");
			$("#toSelMin option[value="+obj.str_time.split(":")[1]+"]").attr("selected", "true");
		}
		
		$('#trImg_2').show();
		
		$("#btnGoSelectData").attr({ value:"저장", alt:"저장" });
		$("#cmd").val("Reg");
		
		layerPopOpen("layerSelectData");
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerSelectData");
	}
	
	
	function selectData(sel_seq) {
		
		showLoading();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getDetailSelectData.do'/>",
			data:{
					sel_seq:sel_seq
			},
			dataType:"json",
			success:function(result){
				console.log("결과 값 확인 : ",result);
				
				initializeSetting();//초기화
				
				var obj = result['searchData'];
				
				$("#del_yn option[value="+obj.del_yn+"]").attr("selected", "true");
				$("#sel_item option[value="+obj.sel_item+"]").attr("selected", "true");
				$("#strSelDate").val(obj.str_time.substr(0,4)+"/"+obj.str_time.substr(4,2)+"/"+obj.str_time.substr(6,2));
				$("#endSelDate").val(obj.end_time.substr(0,4)+"/"+obj.end_time.substr(4,2)+"/"+obj.end_time.substr(6,2));
				$("#frSelTime option[value="+obj.str_time.substr(8,2)+"]").attr("selected", "true");
				$("#toSelTime option[value="+obj.end_time.substr(8,2)+"]").attr("selected", "true");
				$("#frSelMin option[value="+obj.str_time.substr(10,2)+"]").attr("selected", "true");
				$("#toSelMin option[value="+obj.end_time.substr(10,2)+"]").attr("selected", "true");
				$("#sel_reason").val(obj.sel_reason);
				
				$('#trImg_2').show();
				
		 		$("#btnGoSelectData").attr({ value:"수정", alt:"수정" });
		 		$("#cmd").val("Mod");
		 		$("#sel_seq").val(sel_seq);
				
				closeLoading();
				
				layerPopOpen("layerSelectData");
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
	
	
	
	function saveSelectData() {
		var fact_code = $('#gongku').val();
		var branch_no = $('#chukjeongso').val();
		var str_time = $("#strSelDate").val2() + $("#frSelTime").val() + $("#frSelMin").val();
		var end_time = $("#endSelDate").val2() + $("#toSelTime").val() + $("#toSelMin").val();
		var del_yn = $("#del_yn").val();
		var sel_item = $("#sel_item").val();
		var sel_reason = $("#sel_reason").val();
		var sel_seq = $("#sel_seq").val();
		var cmd = $("#cmd").val();
		
		if(cmd == "Reg"){sel_seq = 0;}
		
		showLoading();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/saveSelectData.do'/>",
			data:{
					fact_code:fact_code,
					branch_no:branch_no,
					str_time:str_time,
					end_time:end_time,
					del_yn:del_yn,
					sel_item:sel_item,
					sel_reason:sel_reason,
					sel_seq:sel_seq,
					cmd:cmd
			},
			dataType:"json",
			success:function(result){
				console.log("결과 값 확인 : ",result);
				
				var message = result['message'];
				
				closeLoading();
				if(message == "success"){
					reloadData();
				}else{
					if(message != "success"){
						if(message == "fail"){
							alert("등록에 실패하였습니다.");
						}else if(message == "being"){
							alert("같은 기간에 선별한 데이터가 있습니디.");
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
		
		if(endt.value != '' && stdt.value > endt.value) {
			alert("조회 종료일이 시작일보다 빠릅니다.\n\n다시 입력해 주십시오.");
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
						
						<!-- 수질 조회 현황 -->
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
									<select class="fixWidth11" id="factCode" name="factCode">
										<option value="all">전체</option>
									</select>
									<span>&gt;</span>
									<select class="fixWidth11" id="branchNo" name="branchNo" _disabled="disabled">
										<option value="all">전체</option>
									</select>
								</li>
								<li>
									<input type="text" id="startDate" name="startDate" size="13" onchange="commonWork('startDate','endDate','frTime','toTime','','')" alt="조회시작일"/>
									<select id="frTime" name="frTime" onchange="commonWork('startDate','endDate','frTime','toTime','','')" style="width:45px">
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
									<input type="text" id="endDate" name="endDate" size="13" onchange="commonWork('startDate','endDate','frTime','toTime','','')" alt="조회종료일"/>
									<select id="toTime" name="toTime" onchange="commonWork('startDate','endDate','frTime','toTime','','')" style="width:45px">
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
									<select class="fixWidth7" id="strange">
										<option value="all">전체</option>
										<option value="over">이상데이터</option>
									</select>
								</li>
								<li class="last">
									<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" onclick="javascript:reloadData();" alt="조회"/>
								</li>
							</ul>
						</div>
						</form:form>
						<!-- //하천 수질 조회 -->
						
						<div id="btArea">
							<span id="p_total_cnt">[총 ${totCnt}건]</span>
							<input type="button" id="a_chartPopup" name="a_chartPopup" value="그래프" class="btn btn_basic" style="display:none" alt="그래프" />
							<input type="button" id="excel" name="excel" value="엑셀" class="btn btn_basic" onclick="javascript:excelDown();" alt="엑셀"/>
						</div>
						
						<div class="table_wrapper">
							<div id="dataList" class="dataList"></div>
							
						</div>
						
						<div>
							<input type="button" id="setData" name="setData" value="확정" class="btn btn_basic" onclick="javascript:;" alt="확정" style="float:right;"/>
							<input type="button" id="selectData" name="selectData" value="선별" class="btn btn_basic" onclick="javascript:popupData();" alt="선별" style="float:right;"/>
						</div>
						
						<div id="testdiv" class="testdiv"></div>
						
						
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
	<div id="layerSelectData" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnSelectDataModXbox" name="btnSelectDataModXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerSelectData');" alt="닫기" />
		</div>
		<form id="selectDataform" name="selectDataform" method="post">
			<input type=hidden id="cmd" name="cmd"/>
			<input type=hidden id="sel_seq" name="sel_seq"/>
			
			<table style="width:100%; float:left; text-align:left; margin-bottom:10px" summary="선별정보">
				<colgroup>
					<col width="100"/>
					<col width="200"/>
					<col width="100"/>
					<col width="200"/>
				</colgroup>
				<tr>
					<th>선별 구분</th>
					<td>
						<select id="del_yn" name="del_yn" style="width:126px;">
							<option value="Y">삭제</option>
							<option value="N">적용</option>
						</select>
					</td>
					<th>측정 항목</th>
					<td>
						<select id="sel_item" name="sel_item" style="width:126px">
							<option value="all">전체</option>
							<option value="TUR00">탁도</option>
							<option value="DOW00">DO</option>
							<option value="TMP00">수온</option>
							<option value="PHY00">pH</option>
							<option value="CON00">전기전도도</option>
							<option value="TOF00">Chl-a</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>선별 기간</th>
					<td colspan="3">
						<input type="text" id="strSelDate" name="strSelDate" size="13" onchange="commonWork('strSelDate','endSelDate','frSelTime','toSelTime','frSelMin','toSelMin')" alt="조회시작일"/>
						<select id="frSelTime" name="frSelTime" onchange="commonWork('strSelDate','endSelDate','frSelTime','toSelTime','frSelMin','toSelMin')" style="width:45px">
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
						<select id="frSelMin" name="frSelMin" onchange="commonWork('strSelDate','endSelDate','frSelTime','toSelTime','frSelMin','toSelMin')" style="width:45px">
							<option value="00">00</option>
							<option value="10">10</option>
							<option value="20">20</option>
							<option value="30">30</option>
							<option value="40">40</option>
							<option value="50">50</option>
						</select>
						<span>~</span>
						<input type="text" id="endSelDate" name="endSelDate" size="13" onchange="commonWork('strSelDate','endSelDate','frSelTime','toSelTime','frSelMin','toSelMin')" alt="조회종료일"/>
						<select id="toSelTime" name="toSelTime" onchange="commonWork('strSelDate','endSelDate','frSelTime','toSelTime','frSelMin','toSelMin')" style="width:45px">
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
						<select id="toSelMin" name="toSelMin" onchange="commonWork('strSelDate','endSelDate','frSelTime','toSelTime','frSelMin','toSelMin')" style="width:45px">
							<option value="00">00</option>
							<option value="10">10</option>
							<option value="20">20</option>
							<option value="30">30</option>
							<option value="40">40</option>
							<option value="50">50</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>선별 사유</th>
					<td colspan="3" style="padding:4px">
						<textarea id="sel_reason" name="sel_reason" cols="71" rows="3" style="width:479px;"></textarea>
					</td>
				</tr>
				<tr id="trImg_1">
					<th scope="col">첨부파일</th>
					<td colspan="3" id="trImg" style="text-align: left;"></td>
				</tr>
				<tr id="trImg_2">
					<th scope="col">첨부파일</th>
					<td colspan="3" style="text-align: left;">
						&nbsp;
						<input align="top" id="fileData" name="fileData" type="file" style="width:400px" onchange="fileUploadPreview(this, 'preView')" />
						<div id="preView" class="preView3" title="이미지미리보기"></div>
					</td>
				</tr>
			</table>
		</form>
		<div id="btCarea" style="width:600px;">
			<input type="button" id="deleteBtn" value="사진 삭제" class="btn btn_white" onclick="javascript:layerPopClose('layerSelectData');" alt="사진 삭제" />
			<input type="button" value="취소" class="btn btn_white" onclick="javascript:layerPopClose('layerSelectData');" alt="취소" />
			<input type="button" id="btnGoSelectData" name="btnGoSelectData" value="저장" class="btn btn_white" onclick="javascript:saveSelectData();" alt="저장" />
		</div>
	</div>
	<!-- //선택 수정 레이어 -->
	
</body>
</html>