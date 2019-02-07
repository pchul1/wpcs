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
	//관리자 외에 등록 된 측정소가 없을 경우 메인으로 이동
	if(user_roleCode != 'ROLE_ADMIN'){
		if(user_u_cnt == 0){
// 			alert('권한이 없습니다. 측정소를 등록해주세요.');
// 			window.location = "<c:url value='/main.do'/>";
		}
	}
//<![CDATA[
	$(document).ready(function(){
		var memFactCode = "${member.factCode}";
		var memRiverDiv = "${member.riverId}";
		
		//user 측정소권한에 따른 수계 고정
		if(user_roleCode == 'ROLE_ADMIN'){
			selectedSugyeInMemberId(user_riverid, 'riverDiv');
			
			adjustGongku();
		}else{
			selectedSugyeInMemberIdNew(id, 'U', 'riverDiv');
		}
		
		//메시지처리
		<c:if test="${not empty message }">
			alert("${message}");
		</c:if>
		
		//공통코드 등록 레이어
		$("#layerSelectData").draggable({
			containment: 'body',
			scroll: false
		});
		
		function addzero(n) {
			return n < 10 ? "0" + n : n + "";
		}
		
		var today = new Date();
		var year = "";
		var pre_year = today.getFullYear()-6;
		
		var month = "";
		
		if('${searchYear}' == ''){
			year = today.getFullYear();
		}else{
			year = '${searchYear}';
		}
		
		if('${searchMonth}' == ''){
			month = addzero(today.getMonth() + 1);
		}else{
			month = '${searchMonth}';
		}
		
		if(month=='01'){
			year = year-1;
		}
		for(var i=pre_year ; i<=year ; i++){
			var temp_year = "";
			if(i == year){
				temp_year = "<option value='"+i+"' selected>"+i+"</option>";
			}else{
				temp_year = "<option value='"+i+"'>"+i+"</option>";
			}
			$("#searchYear").append(temp_year);
		}
		var pre_month;
		if(month=='01'){
			pre_month = 12;
			month = 13;
		}else{
			pre_month = (today.getMonth() + 1)-1;
		}
		for(var i=1 ; i<=pre_month ; i++){
			var temp_month = "";
			var temp_i;
			if(i<10){
				temp_i = "0"+i;
			}else{
				temp_i = i;
			}
			if(i == pre_month){
			//if(i == month){
				temp_month = "<option value='"+temp_i+"' selected>"+temp_i+"</option>";
			}else{
				temp_month = "<option value='"+temp_i+"'>"+temp_i+"</option>";
			}
			$("#searchMonth").append(temp_month);
		}
		
		
	});
	
	var memFactCode = "${member.factCode}";
	var memRiverDiv = "${member.riverId}";
	
	$(function () {
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
		}
		
// 		adjustFactList();
		
		$('#riverDiv').change(function(){
			adjustGongku();		//수계 2  조회
			adjustBranchList();	//수계 3  조회
		});
		fnSearchDay();
	});
	
	var itemCnt;
	var curPageNo;
	
	//측정소가 전체가 아닐때만 그래프 버튼이 표시
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
		var riverDiv = $('#riverDiv').val();
		
		var factCode = $('#factCode');
		var branchNo = $('#branchNo');
		
		factCode.attr("style", "background:#ffffff;");
		branchNo.attr("style", "background:#ffffff;");
		
		$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>",
				{sugye:riverDiv, system:'U'},
				function (data, status){
				if(status == 'success'){
					factCode.loadSelect(data.gongku);
					factCode.attr("disabled", true);
					factCode.attr("style", "background:#e9e9e9;");
				
					adjustBranchListNew();
					
				} else { 
					alert("공구 목록 가져오기 실패");
					return;
				}
		});
	}
	
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
					factCode.loadSelect(data.gongku);
					factCode.attr("disabled", true);
					factCode.attr("style", "background:#e9e9e9;");
				
					adjustBranchList();
					
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
				branchNo.loadSelect(data.branch);
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
	
	function adjustBranchListNew()
	{	
		var url = "";
		
		if(user_roleCode == 'ROLE_ADMIN'){
			url = "<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>";
		}else{
			url = "<c:url value='/waterpolmnt/waterinfo/getBranchListNew.do'/>";
		}
		
		var factCode = $('#factCode').val();
		
		var branchNo = $('#branchNo');
		branchNo.attr("disabled", false);
		$.getJSON(url, {factCode:factCode}, function (data, status){
			if(status == 'success'){
				branchNo.loadSelect(data.branch);
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
	function clickTrEventDb(trObj){
		var tr = eval("document.getElementById(\"" + trObj.id + "\")");
		$(tr).parent().find("tr td").removeClass("tr_on");		
		$(tr).find("td").addClass("tr_on");
		popupData();
	}
	
	/* 데이터 조회 */
	function reloadData(pageNo){
		layerPopCloseAll();
		curPageNo = pageNo;
		
		//월 마지막 일자 구하기
		var newDay = new Date( $("#searchYear").val(), $("#searchMonth").val(), "");
	    var lastDay = newDay.getDate();
	    
// 		if( validation() == false ) return;
		
		var riverDiv = $("#riverDiv").val();
		var factCode = $("#factCode").val();
		var branchNo = $("#branchNo").val();
// 		var str_time = $("#startDate").val2()+""+$("#frTime").val()+"00";
// 		var end_time = $("#endDate").val2()+""+$("#toTime").val()+"59";
		var searchYear = $("#searchYear").val();
		var searchMonth = $("#searchMonth").val();
		var select_startday = $("#select_startday").val();
		var select_lastday = $("#select_lastday").val();
		var strange = $("#strange").val();

		var select_year = $("#searchYear").val();
		var select_month = $("#searchMonth").val();
		initializeSetting();
				
		if(factCode == null || factCode == "unknowned" || riverDiv == null || riverDiv == "unknowned"){
			alert("측정소 정보가 없습니다.");
			return;
		}
		
// 		setGraphBtn();
		showLoading();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getSelectDataList.do'/>",
			data:{
					river_div:riverDiv,
					fact_code:factCode,
					branch_no:branchNo,
					searchYear:searchYear,
					searchMonth:searchMonth,
					select_year:select_year,
					select_month:select_month,
					lastDay:lastDay,
					pageIndex:pageNo,
					strange:strange,
					select_startday:select_startday,
					select_lastday:select_lastday
			},
			dataType:"json",
			success:function(result){
// 				console.log("결과 값 확인 : ",result);
				
				$("#river_div").val(riverDiv);
				$("#fact_code").val(factCode);
				$("#branch_no").val(branchNo);
				$("#searchYear").val(searchYear);
				$("#searchMonth").val(searchMonth);
				
				var tot = result['detailViewList'].length;
				var pageInfo = result['paginationInfo'];
				
				// 조회 데이터 표출
				var html = "";
				
				html += "<table>";
				html += "	<colgroup>";
				html += "		<col width='40px' />";
				html += "		<col width='70px' />";
				html += "		<col width='110px' />";
				html += "		<col width='95px' />";
				html += "		<col width='65px' />";
				html += "		<col width='70px' />";
				html += "		<col width='70px' />";
				html += "		<col width='70px' />";
				html += "		<col width='70px' />";
				html += "		<col width='70px' />";
				html += "		<col width='70px' />";
				html += "	</colgroup>";
				
				html += "<thead>";
				html += "	<tr>";
				html += "		<th>NO</th>";
				html += "		<th>수계</th>";
				html += "		<th>측정소</th>";
				html += "		<th>수신일자</th>";
				html += "		<th>수신시간</th>";
				html += "		<th>탁도(NTU)</th>";
				html += "		<th>수온(℃)</th>";
				html += "		<th>pH</th>";
				html += "		<th>DO(mg/L)</th>";
				html += "		<th>EC(mS/cm)</th>";
				html += "		<th>Chl-a(μg/L)</th>";
				html += "	</tr>";
				html += "</thead>";
				html += "<tbody>";
				if( tot <= 0 ){
					html += "<tr><td colspan='11'>조회 결과가 없습니다.</td></tr>";
					$('#selectBtn').hide();
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						var trNo = i+1;
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						
						obj.tur = (obj.tur != null && obj.tur != '') ? obj.tur : '-';
						obj.tmp = (obj.tmp != null && obj.tmp != '') ? obj.tmp : '-';
						obj.phy = (obj.phy != null && obj.phy != '') ? obj.phy : '-';
						obj.dow = (obj.dow != null && obj.dow != '') ? obj.dow : '-';
						obj.con = (obj.con != null && obj.con != '') ? obj.con : '-';
						obj.tof = (obj.tof != null && obj.tof != '') ? obj.tof : '-';
						
						html += "	<tr id='tr"+trNo+"' class='tr"+i+"'  ondblclick='$(this).dblclick(clickTrEventDb(this));'></>";
						//html += "	<tr id='tr"+trNo+"' class='tr"+i+"' onclick='javascript:clickTrEvent(this)'></>";
						html += "		<td>"+obj.no+"</td>";
						html += "		<td>"+obj.river_name+"</td>";
						html += "		<td>"+obj.branch_name+"</td>";
						html += "		<td>"+obj.str_date+"</td>";
						html += "		<td>"+obj.str_time+"</td>";
						html += "		<td class='dt' style='"+stColor(obj.tur_sel, obj.tur_or, obj.tur_over, obj.tur_st)+"' "+clickEvent(obj.tur_sel, 'TUR00', i)+">"+obj.tur+"</td>";
						html += "		<td class='dt' style='"+stColor(obj.tmp_sel, obj.tmp_or, obj.tmp_over, obj.tmp_st)+"' "+clickEvent(obj.tmp_sel, 'TMP00', i)+">"+obj.tmp+"</td>";
						html += "		<td class='dt' style='"+stColor(obj.phy_sel, obj.phy_or, obj.phy_over, obj.phy_st)+"' "+clickEvent(obj.phy_sel, 'PHY00', i)+">"+obj.phy+"</td>";
						html += "		<td class='dt' style='"+stColor(obj.dow_sel, obj.dow_or, obj.dow_over, obj.dow_st)+"' "+clickEvent(obj.dow_sel, 'DOW00', i)+">"+obj.dow+"</td>";
						html += "		<td class='dt' style='"+stColor(obj.con_sel, obj.con_or, obj.con_over, obj.con_st)+"' "+clickEvent(obj.con_sel, 'CON00', i)+">"+obj.con+"</td>";
						html += "		<td class='dt' style='"+stColor(obj.tof_sel, obj.tof_or, obj.tof_over, obj.tof_st)+"' "+clickEvent(obj.tof_sel, 'TOF00', i)+">"+obj.tof+"</td>";
						html += "	</tr>";
					}
					html += "</tbody>";
					html += "</table>";
					$('#selectBtn').show();
				}
				$("#div_result").html(html);
				$("#div_result tbody tr:odd").addClass("even");	
				var maxDate = result['maxDate'];
				if(maxDate != null){
					$("#p_maxDate").html("▶ 조회 기간 내 최종 선별일 [ "+maxDate.substr(0,4)+"년 "+maxDate.substr(4,2)+"월 "+maxDate.substr(6,2)+"일 "+maxDate.substr(8,2)+":"+maxDate.substr(10,2)+" ]");
				}else{
					$("#p_maxDate").html("▶ 조회 기간 내에 선별 기록이 없습니다.");
				}
				
				// 페이징 정보
				var pageStr = makePaginationInfo(result['paginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);
				
				$("#p_total_cnt").html("[총 " + result['totCnt'] + "건] <span class='red'>※조회결과는 확정자료가 아닙니다.</span>");
				
				closeLoading();
				var stdCnt = result['stdCnt'];
				if(tot>0 && stdCnt==0) {
					alert("선별에 필요한 기준치 정보가 존재하지 않습니다.\n기준치 정보를 설정하세요");
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
				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				closeLoading();
			}
		});
	}
	
	function clickEvent(sel_seq, item_code, num){
		var returnVal = "";
		
		if(sel_seq != 0){
			returnVal += "onclick=\"selectData('"+sel_seq+"')\"";
		}else{
			returnVal += "onclick=\"onData('"+item_code+"', '"+num+"');\"";
		}
 		return returnVal;
	}
	
	var clickData = null;
	function onData(item_code, num){
		var str_date = $(".tr"+num+" td:nth-child(4)").html();
		var str_time = $(".tr"+num+" td:nth-child(5)").html();
		clickData = {sel_item:item_code, str_date:str_date, str_time:str_time };
	}
	
	function stColor(val_sel, val_or, val_over, val_st){
		var returnVal = "";
		
		if(val_sel != ""){
			returnVal += "background:#D9E5FF; ";
		}else if(val_over > 0){
			returnVal += "background:#FFD8D8; ";
		}
		if(val_or > 0){
			returnVal += "color:red;";
		}else{
			if(val_st > 0){
				returnVal += "font-weight:bold;";
				if(val_st == 1){returnVal += "color:#AB9C12;";}
				if(val_st == 2){returnVal += "color:#2F9D27;";}
				if(val_st == 3){returnVal += "color:#5CD1E5;";}
				if(val_st == 4){returnVal += "color:#6799FF;";}
				if(val_st == 5){returnVal += "color:#A6A6A6;";}
				if(val_st == 6){returnVal += "color:#F361A6;";}
				if(val_st == 7){returnVal += "color:#F361DC;";}
				if(val_st == 8){returnVal += "color:#810ab2;";}
				if(val_st == 9){returnVal += "color:#c84f05;";}
			}
		}
		return returnVal;
	}
	
	
	/* 초기값 셋팅 */
	function initializeSetting(){
		$('#deleteBtn').hide();
		$('#btnGoDeleteData').hide();
		$('#initializeSettingBtn').show();
		
		$("#cmd").val("");
		$("#sel_seq").val("");
		$("#del_yn option[value='Y']").attr("selected", true);
		$("#sel_item option[value='all']").attr("selected", true);
		$("#limit_yn option[value='N']").attr("selected", true);
		$("#strSelDate").val("");
		$("#endSelDate").val("");
		$("#frSelTime option[value='00']").attr("selected", true);
		$("#toSelTime option[value='00']").attr("selected", true);
		$("#frSelMin option[value='00']").attr("selected", true);
		$("#toSelMin option[value='00']").attr("selected", true);
		$("#sel_reason").val("");
		$("#img_preview").hide();
		$("#fileData").val("");
		$("#atch_file_id").val("");
		$("#img_preview").attr("src", "").hide();
		$("#sel_fact_code").val("");
		$("#sel_branch_no").val("");
		$("#sel_str_time").val("");
		$("#sel_end_time").val("");
		$("#file_yn").val("");
		$("#file_1").val("");
		$("#file_2").val("");
		$("#file_3").val("");
		$("#file_4").val("");
		$("#file_5").val("");
		
		$("#preView1").html("");
		$("#preView2").html("");
		$("#preView3").html("");
		$("#preView4").html("");
		$("#preView5").html("");
		
		clickData = null;
	}
	
	/* 팝업 */
	function popupData(){
		$("#sel_status option[value='']").attr("selected", true);
		$('#sel_status_detail').children().remove();
		
		$('[name=sel_status_detail]').append('<option value="">상세내용</option>');

		var obj = clickData;
		
		initializeSetting();//초기화
		
		var lastDay = ( new Date( $("#searchYear").val(), $("#searchMonth").val(), 0) ).getDate();

		if(obj != null){
			$("#sel_item option[value="+obj.sel_item+"]").attr("selected", "true");
			$("#strSelDate").val(obj.str_date);
			$("#endSelDate").val(obj.str_date);
			$("#frSelTime option[value="+obj.str_time.split(":")[0]+"]").attr("selected", "true");
			$("#toSelTime option[value="+obj.str_time.split(":")[0]+"]").attr("selected", "true");
			$("#frSelMin option[value="+obj.str_time.split(":")[1]+"]").attr("selected", "true");
			$("#toSelMin option[value="+obj.str_time.split(":")[1]+"]").attr("selected", "true");
		}else{
			$("#strSelDate").val($("#searchYear").val()+"/"+$("#searchMonth").val()+"/01");
			$("#endSelDate").val($("#searchYear").val()+"/"+$("#searchMonth").val()+"/"+lastDay);
// 			$("#frSelTime option[value="+obj.str_time.split(":")[0]+"]").attr("selected", "true");
			$("#toSelTime option[value=23]").attr("selected", "true");
// 			$("#frSelMin option[value="+obj.str_time.split(":")[1]+"]").attr("selected", "true");
			$("#toSelMin option[value=50]").attr("selected", "true");
		}
		
		var viewNo = 1;
		
		for(var i=0; i< 5; i++){
			var fileInfo = "";
			
			fileInfo += '<input name="file_'+viewNo+'" id="file_'+viewNo+'" type="file"  style="width:500px;"/>'
			$("#preView"+viewNo).html(fileInfo);
			
			viewNo = viewNo+1;
		}
		
		$("#btnGoSelectData").attr({ value:"저장", alt:"저장" });
		$("#cmd").val("Reg");
		layerPopOpen("layerSelectData");
	}
	
	function popupDataNew(){
		
	}
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerSelectData");
	}
	
	/* 선택된 선별 이력 팝업 */
	function selectData(sel_seq) {
		
		showLoading();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getDetailSelectDataInfo.do'/>",
			data:{
					sel_seq:sel_seq
			},
			dataType:"json",
			success:function(result){
// 				console.log("결과 값 확인 : ",result);
				
				initializeSetting();//초기화
				
				var obj = result['searchData'];
				var fileTot = result['fileList'].length;
				
				$("#del_yn option[value="+obj.del_yn+"]").attr("selected", "true");
				$("#sel_item option[value="+obj.sel_item+"]").attr("selected", "true");
				$("#limit_yn option[value="+obj.limit_yn+"]").attr("selected", "true");
				$("#strSelDate").val(obj.str_time.substr(0,4)+"/"+obj.str_time.substr(4,2)+"/"+obj.str_time.substr(6,2));
				$("#endSelDate").val(obj.end_time.substr(0,4)+"/"+obj.end_time.substr(4,2)+"/"+obj.end_time.substr(6,2));
				$("#frSelTime option[value="+obj.str_time.substr(8,2)+"]").attr("selected", "true");
				$("#toSelTime option[value="+obj.end_time.substr(8,2)+"]").attr("selected", "true");
				$("#frSelMin option[value="+obj.str_time.substr(10,2)+"]").attr("selected", "true");
				$("#toSelMin option[value="+obj.end_time.substr(10,2)+"]").attr("selected", "true");
				$("#sel_reason").val(obj.sel_reason);
				
				$("#sel_status option[value="+obj.status_code+"]").attr("selected", "true");
				
				fnStatusDetail(obj.status_code_detail);
				
				if(obj.atch_file_id != ""){
// 					$("#img_preview").attr("src", "<c:url value='/cmmn/selectImageFileInfs.do'/>?atchFileId=" + obj.atch_file_id + "&fileSn=0&thumbnailFlag=N").show();
					if(fileTot>0){
						var viewNo = 1;
						for(var i=0; i< fileTot; i++){
							var objFile = result['fileList'][i];
							var fileInfo = "";
							
							fileInfo += '<img src="<c:url value="/images/board/ico_file.gif"/>" alt="파일" style="padding-right:3px;"/>'
							fileInfo += '<a href="javascript:fn_egov_downFile(\''+objFile.atchFileId+'\',\''+objFile.fileSn+'\');">'+objFile.orignlFileNm+'</a>'
							fileInfo += '<img src="/images/util/bu5_close.gif" style="vertical-align:bottom;padding-left:3px;" onClick="fn_egov_deleteFile(\''+objFile.atchFileId+'\',\''+objFile.fileSn+'\','+viewNo+');">';
							
							$("#preView"+viewNo).html(fileInfo);
							
							viewNo = viewNo+1;
						}
						
						$("#atch_file_id").val(obj.atch_file_id);
					}
					
					for(var i=0; i< 6; i++){
						if(i>fileTot){
							var fileInfo = "";
							
							fileInfo += '<input name="file_'+viewNo+'" id="file_'+viewNo+'" type="file"  style="width:500px;"/>'
							$("#preView"+viewNo).html(fileInfo);
							
							viewNo = viewNo+1;
						}
					}
				}
				if(fileTot==0){
					var viewNo = 1;
					
					for(var i=0; i< 5; i++){
						var fileInfo = "";
						
						fileInfo += '<input name="file_'+viewNo+'" id="file_'+viewNo+'" type="file"  style="width:500px;"/>'
						$("#preView"+viewNo).html(fileInfo);
						
						viewNo = viewNo+1;
					}
				}
				
		 		$("#btnGoSelectData").attr({ value:"수정", alt:"수정" });
		 		$("#cmd").val("Mod");
		 		$("#sel_seq").val(sel_seq);
		 		
		 		$('#initializeSettingBtn').hide();
		 		$('#btnGoDeleteData').show();
				
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
				closeLoading();
			}
		});
		
	}
	
	
	/* 선별이력 저장 */
	function saveSelectData() {
		var fact_code = $('#fact_code').val();
		var branch_no = $('#branch_no').val();
		var str_time = $("#strSelDate").val2() + $("#frSelTime").val() + $("#frSelMin").val();
		var end_time = $("#endSelDate").val2() + $("#toSelTime").val() + $("#toSelMin").val();
		var del_yn = $("#del_yn").val();
		var sel_item = $("#sel_item").val();
		var sel_reason = $("#sel_reason").val();
		var sel_seq = $("#sel_seq").val();
		var cmd = $("#cmd").val();
		var limit_yn = $("#limit_yn").val();
		var atch_file_id = $("#atch_file_id").val();
		
		if(sel_reason == ""){
			alert("선별 사유를 입력하세요.");
			return;
		}
		
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
					limit_yn:limit_yn,
					atch_file_id:atch_file_id,
					cmd:cmd
			},
			dataType:"json",
			success:function(result){
// 				console.log("결과 값 확인 : ",result);
				
				var message = result['message'];
				
				closeLoading();
				if(message == "success"){
					reloadData(curPageNo);
				}else{
					if(message != "success"){
						if(message == "fail"){
							alert("등록에 실패하였습니다.");
						}else if(message == "being"){
							alert("같은 기간에 선별한 데이터가 있습니다.");
						}else if(message == "nodata"){
							alert("기간 내에 선별할 데이터가 없습니다.");
							reloadData(curPageNo);
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
				closeLoading();
			}
		});
	}
	
	function saveSelectDataNew() {
		var sel_reason = $("#sel_reason").val();
		var sel_seq = $("#sel_seq").val();
		var cmd = $("#cmd").val();
		
		$("#sel_fact_code").val($("#fact_code").val());
		$("#sel_branch_no").val($("#branch_no").val());
		$("#sel_str_time").val($("#strSelDate").val2() + $("#frSelTime").val() + $("#frSelMin").val());
		$("#sel_end_time").val($("#endSelDate").val2() + $("#toSelTime").val() + $("#toSelMin").val());
		
		
		if(sel_reason == ""){
			alert("선별 사유를 입력하세요.");
			return;
		}
		
		if(cmd == "Reg"){$("#sel_seq").val(0);}
		
 		if($("#file_1").val() != '' || $("#file_2").val() != '' || $("#file_3").val() != '' || $("#file_4").val() != '' || $("#file_5").val() != ''){
 			$("#file_yn").val("Y");
 		}
 		if(confirm("저장하시겠습니까?")){
			$("#selectDataform").ajaxSubmit({
		 	    url : '/waterpolmnt/waterinfo/saveSelectDataNew.do',
		 	   	dataType:"json",
				success:function(result){
// 					console.log("결과 값 확인 : ",result);
					
					var message = result['message'];
					closeLoading();
					if(message == "success"){
						alert("정상적으로 저장되었습니다.");
						reloadData(curPageNo);
					}else{
						if(message != "success"){
							if(message == "fail"){
								alert("등록에 실패하였습니다.");
							}else if(message == "being"){
								alert("같은 기간에 선별한 데이터가 있습니다.");
							}else if(message == "nodata"){
								alert("기간 내에 선별할 데이터가 없습니다.");
								reloadData(curPageNo);
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
					closeLoading();
				}
			});
		
 		}
	}
	
	/* 선별이력 전체 삭제 */
	function deleteSelectDataAll() {
		if(confirm("조회 기간 내의 선별 이력을 전부 삭제 하시겠습니까?")){
			var fact_code = $('#fact_code').val();
			var branch_no = $('#branch_no').val();
			var str_time = $("#str_time").val();
			var end_time = $("#end_time").val();
			
			showLoading();
			
			$.ajax({
				type:"post",
				url:"<c:url value='/waterpolmnt/waterinfo/deleteSelectDataAll.do'/>",
				data:{
						fact_code:fact_code,
						branch_no:branch_no,
						str_time:str_time,
						end_time:end_time
				},
				dataType:"json",
				success:function(result){
// 					console.log("결과 값 확인 : ",result);

					closeLoading();
					reloadData();
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
					closeLoading();
				}
			});
		}
	}
	
	/* 선별이력 삭제 */
	function deleteSelectData() {
		if(confirm("선별 이력을 삭제 하시겠습니까?")){
			var sel_seq = $("#sel_seq").val();

			showLoading();
			
			$.ajax({
				type:"post",
				url:"<c:url value='/waterpolmnt/waterinfo/deleteSelectData.do'/>",
				data:{
						sel_seq:sel_seq
				},
				dataType:"json",
				success:function(result){
// 					console.log("결과 값 확인 : ",result);

					closeLoading();
					reloadData();
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
					closeLoading();
				}
			});
		}
	}
	
	/* 데이터 확정 */
	function definiteData() {
		if(confirm("조회 기간 내의 선별 이력을 확정 하시겠습니까?")){
			var fact_code = $('#fact_code').val();
			var branch_no = $('#branch_no').val();
			var str_time = $("#str_time").val();
			var end_time = $("#end_time").val();
			var definite_type = "SET";
			
			showLoading();
			
			$.ajax({
				type:"post",
				url:"<c:url value='/waterpolmnt/waterinfo/insertDefiniteData.do'/>",
				data:{
						fact_code:fact_code,
						branch_no:branch_no,
						str_time:str_time,
						end_time:end_time,
						definite_type:definite_type
				},
				dataType:"json",
				success:function(result){
// 					console.log("결과 값 확인 : ",result);

					closeLoading();
					reloadData();
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
	
	function commonWork(strDateId, endDateId, frTimeId, toTimeId, frSelMinId, toSelMinId,n) {
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
			if($(n).attr("id") == strDateId) {endt.value = ""; endt.focus();}
			if($(n).attr("id") == endDateId) {stdt.value = ""; stdt.focus();}
		}
		
		if(endt.value != '' && strdate < endt.value) {
			alert("조회 기간은 한달 이내 입니다.\n\n다시 입력해 주십시오.");
			if($(n).attr("id") == strDateId) {endt.value = ""; endt.focus();}
			if($(n).attr("id") == endDateId) {stdt.value = ""; stdt.focus();}
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
	
	
	
	
	// 이미지 미리보기
	$.fn.setPreview = function(opt){
	    "use strict"
	    var defaultOpt = {
	        inputFile: $(this),
	        img: null,
	        w: 200,
	        h: 200
	    };
	    $.extend(defaultOpt, opt);
	 
	    var previewImage = function(){
	        if (!defaultOpt.inputFile || !defaultOpt.img) return;
	 
	        var inputFile = defaultOpt.inputFile.get(0);
	        var img       = defaultOpt.img.get(0);
	 
	        // FileReader
	        if (window.FileReader) {
	            // image 파일만
	            if (!inputFile.files[0].type.match(/image\//)) return;
	 
	            // preview
	            try {
	                var reader = new FileReader();
	                reader.onload = function(e){
	                    img.src = e.target.result;
// 	                    img.style.width  = defaultOpt.w+'px';
// 	                    img.style.height = defaultOpt.h+'px';
	                    img.style.display = '';
	                }
	                reader.readAsDataURL(inputFile.files[0]);
	            } catch (e) {
	                // exception...
	            }
	        // img.filters (MSIE)
	        } else if (img.filters) {
	            inputFile.select();
	            inputFile.blur();
	            var imgSrc = document.selection.createRange().text;
	 
// 	            img.style.width  = defaultOpt.w+'px';
// 	            img.style.height = defaultOpt.h+'px';
	            img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(enable='true',sizingMethod='scale',src=\""+imgSrc+"\")";            
	            img.style.display = '';
	        // no support
	        } else {
	            // Safari5, ...
	        }
	    };
	    // onchange
	    $(this).change(function(){
	    	if($(this).val() != ""){
	    		previewImage();
	    	}
	    });
	};
	$(document).ready(function(){
	    var opt = {
	        img: $('#img_preview'),
	        w: 200,
	        h: 200
	    };
	    $('#fileData').setPreview(opt);
	});

	
	// files, action URL, response를 받을 callback을 지정
	function ajaxFileUpload(files, action, callback){
		
	    // iframe의 name이자, form의 target
	    var target_name = 'iframe_upload';

	    // form 생성
	    var form = $('<form action="'+action+'" method="post" enctype="multipart/form-data" style="display:none;" target="'+target_name+'"></form>');
	    $('body').append(form);
	    
	    // 전송할 file element를 갖다 붙임
	    files.appendTo(form);

	    // iframe 생성
	    var iframe = $('<iframe src="javascript:false;" name="'+target_name+'" style="display:none;"></iframe>');
	    $('body').append(iframe);

	    // onload 이벤트 핸들러
	    // action에서 파일을 받아 처리한 결과값을 텍스트로 출력한다고 가정하고 iframe의 내부 데이터를 결과값으로 callback 호출
	    iframe.load(function(){
	        var doc = this.contentWindow ? this.contentWindow.document : (this.contentDocument ? this.contentDocument : this.document);
	        var root = doc.documentElement ? doc.documentElement : doc.body;
	        var result = root.textContent ? root.textContent : root.innerText;
	        callback(result);
	        // 전송처리 완료 후 생성했던 form, iframe 제거
	        
	        $(".fileDiv").append(files);
	        form.remove();
	        iframe.remove();
	    });
	    form.submit();
	}

	function fileUpload(){
		ajaxFileUpload($('#fileData'), '/waterpolmnt/waterinfo/FileUpload.do', function(result){
			$('#atch_file_id').val(result)
        });
	}
	
	function excelDown() {
		var riverDiv = $("#riverDiv").val();
		var factCode = $("#factCode").val();
		var branchNo = $("#branchNo").val();
// 		var str_time = $("#startDate").val2()+""+$("#frTime").val()+"00";
// 		var end_time = $("#endDate").val2()+""+$("#toTime").val()+"59";
		var searchYear = $("#searchYear").val();
		var searchMonth = $("#searchMonth").val();
		
		var select_startday = $("#select_startday").val();
		var select_lastday = $("#select_lastday").val();

		var strange = $("#strange").val();
		
		if(factCode == null || factCode == "unknowned" || riverDiv == null || riverDiv == "unknowned"){
			alert("측정소 정보가 없습니다.");
			return;
		}
		
		var param = "river_div=" + riverDiv + "&fact_code=" + factCode + "&branch_no=" + branchNo +
			"&searchYear=" + searchYear + "&searchMonth=" + searchMonth + "&strange=" + strange+ "&select_startday=" + select_startday + "&select_lastday=" + select_lastday;
		
		location.href="<c:url value='/waterpolmnt/waterinfo/getSelectDataListExcel.do'/>?"+param;
	}
	
	// 페이지 번호 클릭
	function linkPage(pageNo){
		curPageNo = pageNo;
		reloadData(pageNo);
	}
	
	function clickTrEvent(trObj) {
		var tr = eval("document.getElementById(\"" + trObj.id + "\")");
		$(tr).parent().find("tr td").removeClass("tr_on");		
		$(tr).find("td").addClass("tr_on");
    }

	
	function popupDataReport(){
		//월 마지막 일자 구하기
		var newDay = new Date( $("#searchYear").val(), $("#searchMonth").val(), "");
	    var lastDay = newDay.getDate();
	    
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 700;
		var winWidth = 800;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-40;
		var height = winHeight-40;
		
		var river_div = $('#river_div').val();
		var searchYear = $('#searchYear').val();
		var searchMonth = $('#searchMonth').val();
		var select_startday = $("#select_startday").val();
		var select_lastday = $("#select_lastday").val();
		
		var fact_code = $('#factCode').val();
		var branch_no = $('#branchNo').val();
		
		
		var param = "river_div="+river_div+"&searchYear="+searchYear+"&searchMonth="+searchMonth+"&fact_code="+fact_code+"&branch_no="+branch_no+"&lastDay="+lastDay;
	
		window.open("<c:url value='/waterpolmnt/waterinfo/selectDataReport_popup.do'/>?"+encodeURI(param),
		'selectDataReport','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}

	function fn_egov_downFile(atchFileId, fileSn){
		window.open("/cmmn/FileDown.do?atchFileId="+atchFileId+"&fileSn="+fileSn+"");
	}	
	
	function fn_egov_deleteFile(atchFileId, fileSn, viewNo) {
// // 		forms = document.getElementsByTagName("selectDataform");

// 		document.selectDataform.action = "/cmmn/deleteFileInfs.do?atchFileId="+atchFileId+"&fileSn="+fileSn+
// 		document.selectDataform.submit();
		
// 		window.open("/cmmn/deleteFileInfs.do?atchFileId="+atchFileId+"&fileSn="+fileSn+"");
		
// 		window.open("/cmmn/FileDown.do?atchFileId="+atchFileId+"&fileSn="+fileSn+"");

// 		$("#fileIframe").attr("src","/cmmn/deleteFileInfo.do?atchFileId="+atchFileId+"&fileSn="+fileSn+"&returnUrl=waterpolmnt/waterinfo/goSelectRIVER.do");
		if(confirm("파일을 삭제 하시겠습니까?")){
			ajaxFileDelete('/waterpolmnt/waterinfo/FileDelete.do?atchFileId='+atchFileId+'&fileSn='+fileSn, function(result){
				var fileInfo = "";
				
				fileInfo += '<input name="file_'+viewNo+'" id="file_'+viewNo+'" type="file"  style="width:500px;"/>'
				$("#preView"+viewNo).html(fileInfo);
				
				alert("정상적으로 삭제되었습니다.");
	        });
		}
	}
	
	// files, action URL, response를 받을 callback을 지정
	function ajaxFileDelete(action, callback){
		
	    // iframe의 name이자, form의 target
	    var target_name = 'iframe_delete';

	    // form 생성
	    var form = $('<form action="'+action+'" method="post" style="display:none;" target="'+target_name+'"></form>');
	    $('body').append(form);

	    // iframe 생성
	    var iframe = $('<iframe src="javascript:false;" name="'+target_name+'" style="display:none;"></iframe>');
	    $('body').append(iframe);

	    // onload 이벤트 핸들러
	    // action에서 파일을 받아 처리한 결과값을 텍스트로 출력한다고 가정하고 iframe의 내부 데이터를 결과값으로 callback 호출
	    iframe.load(function(){
	        var doc = this.contentWindow ? this.contentWindow.document : (this.contentDocument ? this.contentDocument : this.document);
	        var root = doc.documentElement ? doc.documentElement : doc.body;
	        var result = root.textContent ? root.textContent : root.innerText;
	        callback(result);
	        // 전송처리 완료 후 생성했던 form, iframe 제거
	        
	        form.remove();
	        iframe.remove();
	    });
	    form.submit();
	}
	
	function fnStatusDetail(val){
		var status = $('#sel_status').val();
		var sel_status_detail = $('#sel_status_detail');
		if(status != ''){
			$.getJSON("<c:url value='/waterpolmnt/waterinfo/goStatusCode.do'/>",
					{status:status},
					function (data, status){
					if(status == 'success'){
						
						sel_status_detail.loadSelect(data.statusList);
						if(val != ""){
							$("#sel_status_detail option[value="+val+"]").attr("selected", "true");
						}
					} else { 
						alert("선별사유 코드 가져오기 실패");
						return;
					}
			});
		}else{
			$('#sel_status_detail').children().remove();
			$('[name=sel_status_detail]').append('<option value="">상세내용</option>');
		}
	}
	
	function fnSearchMonth(){
		var searchYear = $('#searchYear').val();
		var today = new Date();
		var year = today.getFullYear();
		
		$("select[name='searchMonth']").find('option').each(function() {
		    $(this).remove();
		   });
		
		if(searchYear<year){
			for(var i=1 ; i<13 ; i++){
				var temp_month = "";
				var temp_i;
				
				if(i<10){
					temp_i = "0"+i;
				}else{
					temp_i = i;
				}
				
				temp_month = "<option value='"+temp_i+"'>"+temp_i+"</option>";
				$("#searchMonth").append(temp_month);
			}
		}
		
		if(searchYear==year){
			var month = addzero(today.getMonth() + 1);
			
			if(month=='01'){
				pre_month = 12;
				month = 13;
			}else{
				pre_month = (today.getMonth() + 1)-1;
			}
			
			for(var i=1 ; i<=month ; i++){
				var temp_month = "";
				var temp_i;
				if(i<10){
					temp_i = "0"+i;
				}else{
					temp_i = i;
				}
				//if(i == pre_month){
				if(i == month){
					temp_month = "<option value='"+temp_i+"' selected>"+temp_i+"</option>";
				}else{
					temp_month = "<option value='"+temp_i+"'>"+temp_i+"</option>";
				}
				$("#searchMonth").append(temp_month);
			}
		}
		
		fnSearchDay();
	}
	
	function fnSearchDay()
	{
		var searchYear = $('#searchYear').val();
		var searchMonth = $('#searchMonth').val();
		var today = new Date().getDate();
		var lastday = ( new Date(searchYear, searchMonth, 0) ).getDate();
		
		$("select[name='select_startday']").find('option').remove();
		$("select[name='select_lastday']").find('option').remove();

		for(var i=1 ; i<=lastday ; i++){
			var temp_day = "";
			var temp_i;
			
			if(i<10){
				temp_i = "0"+i;
			}else{
				temp_i = i;
			}
			
			$("#select_startday").append("<option value='"+temp_i+"'>"+temp_i+"</option>");
			if(i==lastday ){
				$("#select_lastday").append("<option value='"+temp_i+"' selected='selected'>"+temp_i+"</option>");
			}else{
				$("#select_lastday").append("<option value='"+temp_i+"'>"+temp_i+"</option>");
			}
		}
		
	}
	
	function searchdayCheck(){
		var searchYear = $('#searchYear').val();
		var searchMonth = $('#searchMonth').val();
		var select_startday = $('#select_startday').val();
		var select_lastday = $('#select_lastday').val();
		
		var lastday = ( new Date(searchYear, searchMonth, 0) ).getDate();
		if(select_startday > select_lastday)
		{
			alert("검색 기간 오류 입니다. 다시 선택해 주세요.");
			$("#select_lastday").val(lastday);
			$("#select_lastday").focus();
		}
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
									<span class="fieldName">구분</span>
									<select id="strange" class="width100">
										<option value="all">전체</option>
										<option value="over">이상데이터</option>
									</select>
								</li>
								<li>
									<span class="fieldName">선별기간</span>
									<select name="searchYear" id="searchYear" style="width: 60px" onchange="fnSearchMonth();">
									</select>년
									<select name="searchMonth" id="searchMonth" style="width: 50px" onchange="fnSearchDay();">
									</select>월
									<select name="select_startday" id="select_startday" style="width: 50px" onchange="searchdayCheck();">
									</select>일  ~ 
									<select name="select_lastday" id="select_lastday" style="width: 50px" onchange="searchdayCheck();">
									</select>일
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
						</div>
						</form:form>
						<!-- //하천 수질 조회 -->
						
						<div id="btArea">
							<input type="button" id="a_chartPopup" name="a_chartPopup" class="btn btn_graph" style="display:none" alt="그래프" />
							<input type="button" id="excel" name="excel" class="btn btn_excel" onclick="javascript:excelDown();" alt="엑셀"/>
							<ul class='info'>
<%-- 								<li><span id="p_total_cnt">▶ 검색결과 [총 ${totCnt}건]</span> </li> --%>
								<li class="li01_new">경보기준 이상</li>
								<li class="li02_new">정상</li>
								<li class="li03_new">전원이상</li>
								<li class="li04_new">점검보수중</li>
								<li class="li05_new">장비이상</li>
								<li class="li06_new">통신관련</li>
								<li class="li07_new">교정중</li>
								<li class="li08_new">시운전</li>
								<li class="li09_new">가동중지</li>
								<li class="li10_new">재전송</li>
								<li class="li11_new">환경변화</li>
							</ul>
						</div>
						
						<div class="table_wrapper">
							<div id="div_result">
								<table>
									<colgroup>
										<col width="40px" />
										<col width="70px" />
										<col width="110px" />
										<col width="95px" />
										<col width="65px" />
										<col width="70px" />
										<col width="70px" />
										<col width="70px" />
										<col width="70px" />
										<col width="70px" />
										<col width="70px" />
									</colgroup>
									<thead>
										<tr>
											<th>NO</th>
											<th>수계</th>
											<th>측정소</th>
											<th>수신일자</th>
											<th>수신시간</th>
											<th>탁도(NTU)</th>
											<th>수온(℃)</th>
											<th>pH</th>
											<th>DO(mg/L)</th>
											<th>EC(mS/cm)</th>
											<th>Chl-a(μg/L)</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
											<td></td>
										</tr>
									</tbody>
								</table>
							</div>
							
							<div class="paging">
								<div id="page_number">
									<ul class="paginate" id="pagination"></ul>
								</div>
							</div> 
							<div class="btn_area2" id="selectBtn">
							<span id="menuAuth1">
 								<!-- <input type="button" id="setData" name="setData" value="확정" class="btn btn_basic" onclick="javascript:definiteData();" alt="확정" style="float:right;"/> -->
								<input type="button" id="selectDataReport" name="selectDataReport" value="선별보고서" class="btn btn_basic" onclick="javascript:popupDataReport();" alt="선별보고서" style="float:right;"/>
								<input type="button" id="selectData" name="selectData" value="선별" class="btn btn_basic" onclick="javascript:popupData();" alt="선별" style="float:right;"/>
<!-- 								<input type="button" id="deleteData" name="deleteData" value="초기화" class="btn btn_basic" onclick="javascript:deleteSelectDataAll();" alt="초기화" style="float:right;"/> -->
							</span>
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
	<div id="layerSelectData" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnSelectDataModXbox" name="btnSelectDataModXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerSelectData');" alt="닫기" />
		</div>
<!-- 		<form id="selectDataform" name="selectDataform" method="post"> -->
			<form name="selectDataform" id="selectDataform" method="post" onsubmit="return false;" enctype="multipart/form-data">
			<input type="hidden" id="cmd" name="cmd"/>
			<input type="hidden" id="sel_seq" name="sel_seq"/>
			<input type="hidden" name="sel_fact_code" id="sel_fact_code"/>
			<input type="hidden" name="sel_branch_no" id="sel_branch_no"/>
			<input type="hidden" name="sel_str_time" id="sel_str_time"/>
			<input type="hidden" name="sel_end_time" id="sel_end_time"/>
			<input type="hidden" name="file_yn" id="file_yn"/>
			<input type="hidden" name="atch_file_id" id="atch_file_id"/>
			
			<table style="width:100%; float:left; text-align:left; margin-bottom:10px" summary="선별정보">
				<colgroup>
					<col width="80"/>
					<col width="80"/>
					<col width="80"/>
					<col width="140"/>
					<col width="80"/>
					<col width="140"/>
				</colgroup>
				<tr>
					<th>선별 구분</th>
					<td style="padding:4px">
						<select id="del_yn" class="width70" name="del_yn">
							<option value="Y">삭제</option>
							<option value="N">적용</option>
						</select>
					</td>
					<th>측정 항목</th>
					<td style="padding:4px">
						<select id="sel_item" class="width110" name="sel_item">
							<option value="all">전체</option>
							<option value="TUR00">탁도</option>
							<option value="DOW00">DO</option>
							<option value="TMP00">수온</option>
							<option value="PHY00">pH</option>
							<option value="CON00">전기전도도</option>
							<option value="TOF00">Chl-a</option>
						</select>
					</td>
					<th>데이터</th>
					<td style="padding:4px">
						<select id="limit_yn" class="width110" name="limit_yn">
							<option value="N">전체</option>
							<option value="Y">이상데이터</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>선별 기간</th>
					<td colspan="5" style="padding:4px">
						<input type="text" id="strSelDate" name="strSelDate" size="13" onchange="commonWork('strSelDate','endSelDate','frSelTime','toSelTime','frSelMin','toSelMin',this)" alt="조회시작일"/>
						<select id="frSelTime" name="frSelTime" onchange="commonWork('strSelDate','endSelDate','frSelTime','toSelTime','frSelMin','toSelMin',this)" style="width:45px">
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
						<select id="frSelMin" name="frSelMin" onchange="commonWork('strSelDate','endSelDate','frSelTime','toSelTime','frSelMin','toSelMin',this)" style="width:45px">
							<option value="00">00</option>
							<option value="10">10</option>
							<option value="20">20</option>
							<option value="30">30</option>
							<option value="40">40</option>
							<option value="50">50</option>
						</select>
						<span>~</span>
						<input type="text" id="endSelDate" name="endSelDate" size="13" onchange="commonWork('strSelDate','endSelDate','frSelTime','toSelTime','frSelMin','toSelMin',this)" alt="조회종료일"/>
						<select id="toSelTime" name="toSelTime" onchange="commonWork('strSelDate','endSelDate','frSelTime','toSelTime','frSelMin','toSelMin',this)" style="width:45px">
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
						<select id="toSelMin" name="toSelMin" onchange="commonWork('strSelDate','endSelDate','frSelTime','toSelTime','frSelMin','toSelMin',this)" style="width:45px">
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
					<td colspan="5" style="padding:4px">
						<select id="sel_status" style="width:90px;" name="sel_status" onchange="fnStatusDetail();">
							<option value="">선택안함</option>
							<option value="A">전원이상</option>
							<option value="B">점검보수중</option>
							<option value="C">장비이상</option>
							<option value="D">통신관련</option>
							<option value="E">교정중</option>
							<option value="F">시운전</option>
							<option value="G">가동중지</option>
							<option value="H">재전송</option>
							<option value="I">환경변화</option>
						</select>
						<select id="sel_status_detail" style="width:370px;" name="sel_status_detail">
							<option value="">상세내용</option>
						</select>
						<br />
						<textarea id="sel_reason" name="sel_reason" cols="80" rows="3" style="width:498px;"></textarea>
					</td>
				</tr>
				<tr>
					<th scope="col">첨부파일</th>
					<td colspan="5" style="text-align: left;padding:4px">
							<span id="preView1"></span><br />
							<span id="preView2"></span><br />
							<span id="preView3"></span><br />
							<span id="preView4"></span><br />
							<span id="preView5"></span>
					</td>
				</tr>
			</table>
		</form>
		<div id="btCarea" style="width:600px;">
			<input type="button" id="deleteBtn" value="사진 삭제" class="btn btn_white" onclick="javascript:;" alt="사진 삭제" />
			<input type="button" id="initializeSettingBtn" value="초기화" class="btn btn_white" onclick="javascript:initializeSetting();" alt="초기화" />
			<input type="button" value="취소" class="btn btn_white" onclick="javascript:layerPopClose('layerSelectData');" alt="취소" />
<!-- 			<input type="button" id="btnGoDeleteData" name="btnGoDeleteData" value="선별취소" class="btn btn_white" onclick="javascript:deleteSelectData();" alt="선별취소" /> -->
			<input type="button" id="btnGoSelectData" name="btnGoSelectData" value="저장" class="btn btn_white" onclick="javascript:saveSelectDataNew();" alt="저장" />
		</div>
	</div>
	<!-- //선택 수정 레이어 -->
	<iframe src="" width="0" height="0" frameborder="0" id="fileIframe"></iframe>
	<script language="javascript">
	function menuAuth(auth){
		var iauthC ="";
		var iauthU ="";
		var iauthD ="";
		if(auth == "C"){
			iauthC ="Y";
		}
		if(auth == "U"){
			iauthU ="Y";
		}
		if(auth == "D"){
			iauthD ="Y";
		}
		var menuAuth = ""	;
		$.ajax({	
			type:"post",
			url: "<c:url value='/admin/member/getUserAuthorCnt.do'/>",
			dataType:"json",
			async: false,
			data:{
				userId:$("#userId").val(),
				menuId:$("#naviMenuNo").val(),
				authC:iauthC,
				authU:iauthU,
				authD:iauthD
			},
			success : function(result){
				var tot = 0;
				 tot = result['getUserMenuAuthorCount'];
				 menuAuth = tot;
			}
		});
		return menuAuth;
	}
	
	if("1" == menuAuth("U")){
		$("#menuAuth1").show();
	}else{
		$("#menuAuth1").hide();
	}
	
	</script>
</body>
</html>