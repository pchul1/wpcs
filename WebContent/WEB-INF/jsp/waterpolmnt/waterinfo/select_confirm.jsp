<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : select_confirm.jsp
	 * Description : 데이터확정
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2014.11.11	kyr		최초 생성
	 * 
	 * author kyr
	 * since 2011.11.11
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
		layerPopCloseAll();
		
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
		
		$('#riverDiv').change(function(){
			
			adjustGongku();		//수계 2  조회
			//adjustBranchList();	//수계 3  조회
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
		for(var i=1 ; i<month ; i++){
			var temp_month = "";
			var temp_i;
			if(i<10){
				temp_i = "0"+i;
			}else{
				temp_i = i;
			}
			if(i == pre_month){
				temp_month = "<option value='"+temp_i+"' selected>"+temp_i+"</option>";
			}else{
				temp_month = "<option value='"+temp_i+"'>"+temp_i+"</option>";
			}
			$("#searchMonth").append(temp_month);
		}
		
	});
	
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
				branchNo.loadSelect_all(data.branch);
				$("#branchNo>option[value="+data.branch[0].VALUE+"]").attr("selected", "selected");
				
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
		var factCode = "";
		var branchNo = "";
		
		if($('#riverDiv option:selected').val() == 'all'){
			$('#factCode option:selected').val('all');
			factCode = $('#factCode').val();
			branchNo = $('#branchNo').val();
			$('#branchNo').attr('disabled', true);
		}else{
			factCode = $('#factCode').val();
			branchNo = $('#branchNo');
			branchNo.attr("disabled", false);			
		}
		/* var factCode = $('#factCode').val();
		var branchNo = $('#branchNo');
		branchNo.attr("disabled", false);
		
		if($('#riverDiv option:selected').val() == 'all'){
			$('#factCode option:selected').val('all');
			$('#branchNo').val('all');
			$('#branchNo').attr('disabled', true);
			factCode = $('#factCode').val();
			branchNo = $('#branchNo');		
		}
		 */
		$.getJSON(url, {factCode:factCode}, function (data, status){
			
			if(status == 'success'){
				if(factCode != 'all'){
					branchNo.loadSelect_all(data.branch);
					$("#branchNo>option[value="+data.branch[0].VALUE+"]").attr("selected", "selected");	
				}else if(factCode == 'all'){
					$("#branchNo>option[value=all]").attr("selected", "selected");
				}
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
	
	/* 데이터 조회 */
	function reloadData(pageNo){
		showLoading();
		
		$('#sel_seq').val("");					//seq 초기화
		$('#cancel_content').val("");		//취소사유 초기화
		$('#save_gubun').val("");	
		$('#fact_code').val("");
		$('#branch_no').val("");
		$('#status').val("");
		
		layerPopCloseAll();
		
		var riverDiv = $("#riverDiv").val();
		var factCode = $("#factCode").val();
		var branchNo = $("#branchNo").val();
		var searchYear = $("#searchYear").val();
		var searchMonth = $("#searchMonth").val();
		var select_year = $("#searchYear").val();
		var select_month = $("#searchMonth").val();
		
		if (pageNo == null) pageNo = 1;
	
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/goSelectConfirmList.do'/>",
			data:{
					river_div:riverDiv,
					fact_code:factCode,
					branch_no:branchNo,
					searchYear:searchYear,
					searchMonth:searchMonth,
					select_year:select_year,
					select_month:select_month,
					pageIndex:pageNo
			},
			dataType:"json",
			success:function(result){
// 				console.log("결과 값 확인 : ",result);
				
				var tot = result['detailViewList'].length;
				var pageInfo = result['paginationInfo'];
				
// 				if(tot == 0 || tot == 1){
// 					$("#main_display").css("height", "55px");
// 				}else if(tot<20){
// 					$("#main_display").css("height", (tot*27)+18 + "px");
// 				}else{
// 					$("#main_display").css("height", "558px");
// 				}
				
				// 조회 데이터 표출
				var html = "";
				var main_html = "";
				
				if( tot <= 0 ){
					main_html += "<tr><td colspan='7'>조회 결과가 없습니다.</td></tr>";
					$("#dateLists").html(main_html);
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						var trNo = i+1;
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						obj.no = no;
						
						var even = "";
						if(i%2 == 1){even = "even"}
						main_html += "	<tr id='tr"+trNo+"' class='tr"+i+"' onclick=\"javascript:clickTrEvent(this); clickData("+obj.sel_seq+",'"+obj.fact_code+"','"+obj.branch_no+"','"+obj.status+"');\"></>";
						main_html += "		<td>"+no+"</td>";
						main_html += "		<td>"+obj.river_name+"</td>";
						main_html += "		<td>"+obj.branch_name+"</td>";
						main_html += "		<td>"+obj.select_year+"년"+obj.select_month+"월</td>";
						main_html += "		<td style='cursor:pointer;' onclick=\"javascript:popupDataReport('"+obj.sel_seq+"','"+obj.fact_code+"','"+obj.branch_no+"');\">[선택]</td>";
						main_html += "		<td>"+obj.status_name+"</td>";
						main_html += "		<td>"+obj.reg_name+"</td>";
						main_html += "	</tr>";
					}
					$("#dateLists").html(main_html);
					$("#div_result tbody tr:odd").addClass("even");	
				}
				
				// 페이징 정보
				var pageStr = makePaginationInfo(result['paginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);
				
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
	
	function popupDataReport(sel_seq, fact_code, branch_no){
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
		
		var searchYear = $('#searchYear').val();
		var searchMonth = $('#searchMonth').val();
		
		var param = "searchYear="+searchYear+"&searchMonth="+searchMonth+"&fact_code="+fact_code+"&branch_no="+branch_no+"&sel_seq="+sel_seq+"&lastDay="+lastDay+"&pop_gubun=view";
	
		window.open("<c:url value='/waterpolmnt/waterinfo/selectDataReport_popup.do'/>?"+encodeURI(param),
		'selectDataReport','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function clickTrEvent(trObj) {
		var tr = eval("document.getElementById(\"" + trObj.id + "\")");
		$(tr).parent().find("tr td").removeClass("tr_on");		
		$(tr).find("td").addClass("tr_on");
    }
	
	function clickData(sel_seq, fact_code, branch_no, status){
		$('#sel_seq').val(sel_seq);
		$('#fact_code').val(fact_code);
		$('#branch_no').val(branch_no);
		$('#status').val(status);
	}
	
	function selectCancel(){
		var sel_seq = $('#sel_seq').val();
		var status = $('#status').val();
		$('#save_gubun').val("S");
		$('#cancel_content').val("");
		
		if(sel_seq == ''){
			alert("데이터를 선택해주세요.");
			return false;
		}
		
		if(status != 'S'){
			alert("확정 된 데이터는 선별취소 할 수 없습니다.");
			return false;
		}
		
		layerPopOpen("layerSelectData");
		
	}
	
	function saveSelectCancel(){
		var sel_seq = $('#sel_seq').val();
		var status = $('#status').val();
		var save_gubun = $('#save_gubun').val();
		var fact_code = $("#fact_code").val();
		var branch_no = $("#branch_no").val();
		var select_year = $('#searchYear').val();
		var select_month = $('#searchMonth').val();
		
		var cancel_content = $('#cancel_content').val();
		
		if(sel_seq == ''){
			alert("데이터를 선택해주세요.");
			return false;
		}
		
		if(cancel_content == ''){
			alert("취소사유를 입력해주세요.");
			return false;
		}
		
		if(save_gubun == 'S'){
			if(confirm("선별취소 하시겠습니까?")){
				showLoading();
				
				$.ajax({
					type:"post",
					url:"<c:url value='/waterpolmnt/waterinfo/cancelSelectDataInfo.do'/>",
					data:{
							sel_seq:sel_seq,
							cancel_content:cancel_content
					},
					dataType:"json",
					success:function(result){
// 						console.log("결과 값 확인 : ",result);
	
						closeLoading();
						alert("정상적으로 처리되었습니다.");
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
						dataView.getItemMetadata = function () {
							return {"columns":{0:{"colspan":"*"}}};
						}
						closeLoading();
					}
				});
			}
		}else if(save_gubun == 'C'){
			var definite_type = "DEL";
			
			if(confirm("확정취소 하시겠습니까?")){
				showLoading();
				
				$.ajax({
					type:"post",
					url:"<c:url value='/waterpolmnt/waterinfo/confirmCancelSelectDataInfo.do'/>",
					data:{
							sel_seq:sel_seq,
							cancel_content:cancel_content,
							fact_code:fact_code,
							branch_no:branch_no,
							select_year:select_year,
							select_month:select_month,
							definite_type:definite_type
					},
					dataType:"json",
					success:function(result){
// 						console.log("결과 값 확인 : ",result);

						closeLoading();
						alert("정상적으로 처리되었습니다.");
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
						dataView.getItemMetadata = function () {
							return {"columns":{0:{"colspan":"*"}}};
						}
						closeLoading();
					}
				});
			}
		}
	}
	
	function selectConfirm(){
		var sel_seq = $('#sel_seq').val();
		var status = $('#status').val();
		var fact_code = $("#fact_code").val();
		var branch_no = $("#branch_no").val();
		var select_year = $('#searchYear').val();
		var select_month = $('#searchMonth').val();
		var definite_type = "SET";
		
		if(sel_seq == ''){
			alert("데이터를 선택해주세요.");
			return false;
		}
		
		if(status != 'S'){
			alert("확정 하실 수 없습니다.");
			return false;
		}
		
		if(confirm("확정 하시겠습니까?")){
			showLoading();
			
			$.ajax({
				type:"post",
				url:"<c:url value='/waterpolmnt/waterinfo/confirmSelectDataInfo.do'/>",
				data:{
						sel_seq:sel_seq,
						fact_code:fact_code,
						branch_no:branch_no,
						select_year:select_year,
						select_month:select_month,
						definite_type:definite_type
				},
				dataType:"json",
				success:function(result){
// 					console.log("결과 값 확인 : ",result);

					closeLoading();
					alert("정상적으로 처리되었습니다.");
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
					dataView.getItemMetadata = function () {
						return {"columns":{0:{"colspan":"*"}}};
					}
					closeLoading();
				}
			});
		}
		
	}
	
	function confirmCancel(){
		var sel_seq = $('#sel_seq').val();
		var status = $('#status').val();
		$('#save_gubun').val("C");
		$('#cancel_content').val("");
		
		if(sel_seq == ''){
			alert("데이터를 선택해주세요.");
			return false;
		}
		
		if(status != 'E'){
			alert("확정 취소 할 수 없습니다.");
			return false;
		}
		if(sel_seq == ''){
			alert("데이터를 선택해주세요.");
			return false;
		}
		
		layerPopOpen("layerSelectData")
		
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
			
			for(var i=1 ; i<month ; i++){
				var temp_month = "";
				var temp_i;
				if(i<10){
					temp_i = "0"+i;
				}else{
					temp_i = i;
				}
				if(i == pre_month){
					temp_month = "<option value='"+temp_i+"' selected>"+temp_i+"</option>";
				}else{
					temp_month = "<option value='"+temp_i+"'>"+temp_i+"</option>";
				}
				$("#searchMonth").append(temp_month);
			}
		}
	}
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerSelectData");
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
						
						<!-- 선별 데이터 조회 현황 -->
						<form:form commandName="selectDataVO" name="listFrm"  id="listFrm" method="post">
						<input type="hidden" name="sel_seq" id="sel_seq"/>
						<input type="hidden" name="status" id="status"/>  
						<input type="hidden" name="save_gubun" id="save_gubun"/>  
						<input type="hidden" name="fact_code" id="fact_code"/>
						<input type="hidden" name="branch_no" id="branch_no"/>  
						  
						<div class="searchBox dataSearch">
							<ul>
								<li>
									<span class="fieldName">측정소 위치</span>
									<select id="riverDiv" class="width70">
									    <option value="all">전체</option>
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
									<span class="fieldName">선별기간</span>
									<select name="searchYear" id="searchYear" style="width: 60px" onchange="fnSearchMonth();">
									</select>
									<select name="searchMonth" id="searchMonth" style="width: 50px">
									</select>
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
						</div>
						</form:form>
						<!-- //하천 수질 조회 -->
						<div id="div_result">
							<div id="top_display" style="width:995px;">
								<table>
									<colgroup>
										<col width="80px" />
										<col width="140px" />
										<col width="160px" />
										<col width="180px" />
										<col width="160px" />
										<col width="100px" />
										<col />
									</colgroup>
									<thead id="headerList">
									<tr>
										<th scope="col">번호</th>
										<th scope="col">수계</th>
										<th scope="col">측정소</th>
										<th scope="col">선별기간</th>
										<th scope="col">선별사유서</th>
										<th scope="col">상태</th>
										<th scope="col">작성자</th>
									</tr>
									</thead>
									<tbody id="dateLists">
									</tbody>
								</table>
							</div>
							<div class="paging">
								<div id="page_number">
									<ul class="paginate" id="pagination"></ul>
								</div>
							</div> 
							<sec:authorize ifAnyGranted="ROLE_ADMIN">
							<div class="btn_area2" id="selectBtn">
							<span id="menuAuth1">
								<input type="button" id="confirmCancel" name="confirmCancel" value="확정취소" class="btn btn_basic" onclick="javascript:confirmCancel();" alt="확정취소" style="float:right;"/>
								<input type="button" id="selectConfirm" name="selectConfirm" value="확정" class="btn btn_basic" onclick="javascript:selectConfirm();" alt="확정" style="float:right;"/>
								<input type="button" id="selectCancel" name="selectCancel" value="선별취소" class="btn btn_basic" onclick="javascript:selectCancel();" alt="선별취소" style="float:right;"/>
							</span>
							</div>
							</sec:authorize>
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
			<form id="selectDataform" name="selectDataform" method="post">
			<table style="width:100%; float:left; text-align:left; margin-bottom:10px" summary="취소사유">
				<colgroup>
					<col width="100px;"/>
					<col width="300px;"/>
				</colgroup>
				<tr>
					<th style="width:100px;">취소사유</th>
					<td>
						<textarea id="cancel_content" name="cancel_content" rows="5" style="width:300px;"></textarea>
					</td>
				</tr>
			</table>
			</form>
			<div id="btCarea" style="width:400px;">
				<input type="button" id="btnGoSelectData" name="btnGoSelectData" value="저장" class="btn btn_white" onclick="javascript:saveSelectCancel();" alt="저장" />
			</div>
	</div>
	<!-- //선택 수정 레이어 -->
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