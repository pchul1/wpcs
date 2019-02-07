<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : factlimit.jsp
	 * Description : 측정소별 기준 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2014.09.11	smji		최초 생성
	 * 
	 * author smji
	 * since 2011.09.11
	 * `
	 * Copyright (C) 2010 by smji  All right reserved.
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
	var fact_name;
	var fact_code;
	var branch_no=1;
	var branch_name;
	var sys_kind;
	var isFirst = true;
	
	$(function(){
		var memFactCode = "${member.factCode}";
		var memRiverDiv = "${member.riverId}";
		
		//user 측정소권한에 따른 수계 고정
		if(user_roleCode == 'ROLE_ADMIN'){
			selectedSugyeInMemberId(user_riverid, 'sugye');
			selectedSugyeInMemberId(user_riverid, 'sugye_A');
			
			adjustGongku();
			adjustGongku_A();
		}else{
			selectedSugyeInMemberIdNew(id, 'U', 'sugye');
			selectedSugyeInMemberIdNew2(id, 'A', 'sugye_A');
		}
		
// 		$('#sugye_A').val($('#sugye').val());
		
		$('#sugye').change(function(){
			adjustGongku();
		});
		
		$('#factCode').change(function(){
			adjustBranchList();
		});
		
		$('#sugye_A').change(function(){
			adjustGongku_A();
		});
		
	});
	
	
	var firstFlag = false;
	
	function adjustGongku()
	{
		var sugyeCd = $('#sugye').val();
		var dropDownSet = $('#factCode');
		var dropDownSet_branchNo = $('#branchNo');
		
		dropDownSet.attr("disabled", false);
		dropDownSet.attr("style", "background:#ffffff;");
		$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>",
				{sugye:sugyeCd, system:"U"}, function (data, status){
			if(status == 'success'){
				dropDownSet.loadSelect(data.gongku);
				dropDownSet.attr("disabled", true);
				dropDownSet.attr("style", "background:#e9e9e9;");
				adjustBranchListNew();
			} else {
				alert("공구 목록 가져오기 실패");
				return;
			}
		});
	}
	
	function adjustGongku_A()
	{
		var sugyeCd = $('#sugye_A').val();
		var dropDownSet = $('#factCode_A');
		var dropDownSet_branchNo = $('#branchNo_A');
		dropDownSet.attr("disabled", false);
		dropDownSet.attr("style", "background:#ffffff;");
		$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuListNew.do'/>",
				{sugye:sugyeCd, system:'A'}, function (data, status){
			if(status == 'success'){
				dropDownSet.loadSelect(data.gongku);
// 				dropDownSet.attr("disabled", true);
// 				dropDownSet.attr("style", "background:#e9e9e9;");
				
// 				adjustBranchListNew_A();
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
				alert("측정소 목록 가져오기 실패");
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
		var dropDownSet = $('#branchNo');
		
		dropDownSet.attr("disabled", false);
		$.getJSON(url, {factCode:factCode}, function (data, status){
			if(status == 'success'){
				dropDownSet.loadSelect(data.branch);
				if(!firstFlag){
					reloadData();
					firstFlag = true;
				}
			} else {
				alert("측정소 목록 가져오기 실패");
				return;
			}
		});
		
		//2014-10-27 mypark 검색개선
		$('#factCode').hide();
	}
	
	function adjustBranchListNew_A()
	{
		var url = "";
		
		if(user_roleCode == 'ROLE_ADMIN'){
			url = "<c:url value='/waterpolmnt/waterinfo/getBranchList.do'/>";
		}else{
			url = "<c:url value='/waterpolmnt/waterinfo/getBranchListNew.do'/>";
		}
		var factCode = $('#factCode_A').val();
		var dropDownSet = $('#branchNo_A');
		dropDownSet.attr("disabled", false);
		$.getJSON(url, {factCode:factCode}, function (data, status){
			if(status == 'success'){
				dropDownSet.loadSelect(data.branch);
				if(!firstFlag){
					reloadData_A();
					firstFlag = true;
				}
			} else {
				alert("측정소 목록 가져오기 실패");
				return;
			}
		});
		
		//2014-10-27 mypark 검색개선
		$('#factCode_A').hide();
	}
	
	
	
// 	function adjustGongku_A()
// 	{
// 		var sugyeCd = $('#sugye_A').val();
// 		var dropDownSet = $('#factCode_A');
		
// 		dropDownSet.attr("disabled", false);
// 		$.getJSON("<c:url value='/waterpolmnt/waterinfo/getGongkuList.do'/>",
// 				{sugye:sugyeCd, system:'A'}, 
// 				function (data, status){
// 			if(status == 'success'){
// 				dropDownSet.loadSelect(data.gongku);
// 			} else {
// 				alert("공구 목록 가져오기 실패");
// 				return;
// 			}
// 		});
// 	}
	
	
	function saveData(){
		var item_list = $("input:hidden[name='item_code']");
		var success = 0;
		
		showLoading();
		
		for(var i=0; i<item_list.length; i++){
			var to_fact_code = $("#toFactCode").val();
			var to_branch_no = $("#toBranchNo").val();
			var item_code = item_list[i].value;
			var item_value_hi = $("[name='"+item_list[i].value+"_hi']").val();
			var item_value_lo = $("[name='"+item_list[i].value+"_lo']").val();
			
			$.ajax({
				type:"post",
				url:"<c:url value='/waterpolmnt/waterinfo/updateDetailViewLIMIT.do'/>",
				data:{
						to_fact_code:to_fact_code,
						to_branch_no:to_branch_no,
						item_code:item_code,
						item_value_hi:item_value_hi,
						item_value_lo:item_value_lo
				},
				dataType:"json",
				success:function(result){
					success++;
					if(success == item_list.length){
						closeLoading();
						reloadData();
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
				}
			});
			
		}
		
	}

	
	function applyData(){
		var from_fact_code = $("#fromFactCode").val();
		var to_fact_code = $("#toFactCode").val();
		var to_branch_no = $("#toBranchNo").val();
		
		if(confirm("기준값 정보를 적용시키겠습니까?")){
			
			showLoading();
			$.ajax({
				type:"post",
				url:"<c:url value='/waterpolmnt/waterinfo/applyDetailViewLIMIT.do'/>",
				data:{
						from_fact_code:from_fact_code, 
						to_fact_code:to_fact_code,
						to_branch_no:to_branch_no
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

	function modifyData(){
		$("#state").val("U");
		reloadData();
	}
	
	function reloadData(){
		
		showLoading();
		var compare = $("#compare").val();
		
		var fact_code = $("#factCode").val();
		var branch_no = $("#branchNo").val();
		var html = "";
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getDetailViewLIMIT_U.do'/>",
			data:{
					fact_code:fact_code,
					branch_no:branch_no
			},
			dataType:"json",
			success:function(result){
// 				console.log("결과 값 확인 : ",result);
				
				var tot = result['detailViewList'].length;
				
				$("#resultList tbody").empty();
				if(tot != 0){
					
					var state = $("#state").val();
					if(state == "U"){
						for(var i=0; i < tot; i++){
							var obj = result['detailViewList'][i];
							
							html += "<tr>";
							html += "<td><input type='hidden' name='item_code' value='"+obj.item_code+"'/>"+obj.item_name+"</td>";
							html += "<td><input type='text' name='"+obj.item_code+"_hi' value='"+obj.item_value_hi+"'/></td>";
							html += "<td><input type='text' name='"+obj.item_code+"_lo' value='"+obj.item_value_lo+"'/></td>";
							html += "</tr>";
						}
						$("#resultList tbody").append(html);
						
						$("#toFactCode").val(fact_code);
						$("#toBranchNo").val(branch_no);
						$("#resultTit").html($("#branchNo :selected").text()+" 기준값 정보");
						$("#state").val("");
						$(".btnModify").hide();
						$(".btnRegist").show();
					}else{
						for(var i=0; i < tot; i++){
							var obj = result['detailViewList'][i];
							var item_value_hi = obj.item_value_hi;
							var item_value_lo = obj.item_value_lo;
							if(item_value_hi == ""){item_value_hi = "-"};
							if(item_value_lo == ""){item_value_lo = "-"};
							
							html += "<tr>";
							html += "<td>"+obj.item_name+"</td>";
							html += "<td>"+item_value_hi+"</td>";
							html += "<td>"+item_value_lo+"</td>";
							html += "</tr>";
						}
						$("#resultList tbody").append(html);
						
						$("#toFactCode").val(fact_code);
						$("#toBranchNo").val(branch_no);
						$("#resultTit").html($("#branchNo :selected").text()+" 기준값 정보");
						$(".btnModify").show();
						$(".btnRegist").hide();
					}
				}else{
					$("#resultList tbody").append("<tr><td colspan='3'>조회 결과가 없습니다.</td></tr>");
					$(".btnModify").hide();
					$(".btnRegist").hide();
				}
				if(!listFrm.set_yn.checked){
					$("#compareResultDiv").hide();
					closeLoading();
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
				$("#resultList tbody").append("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
				if(compare != "Y"){
					$("#compareResultDiv").hide();
					closeLoading();
				}
			}
		});
		
		if(listFrm.set_yn.checked){
			reloadData_A();
		}
	}
	

	function reloadData_A(){
		
		var fact_code = $("#factCode_A").val();
		var html = "";
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpolmnt/waterinfo/getDetailViewLIMIT_A.do'/>",
			data:{
					fact_code:fact_code
			},
			dataType:"json",
			success:function(result){
// 				console.log("결과 값 확인 : ",result);
				
				var tot = result['detailViewList'].length;
				
				$("#resultList_A tbody").empty();
				if(tot != 0){
					for(var i=0; i < tot; i++){
						var obj = result['detailViewList'][i];
						var item_value_hi = obj.item_value_hi;
						var item_value_lo = obj.item_value_lo;
						if(item_value_hi == ""){item_value_hi = "-"};
						if(item_value_lo == ""){item_value_lo = "-"};
						
						html += "<tr>";
						html += "<td>"+obj.item_name+"</td>";
						html += "<td>"+item_value_hi+"</td>";
						html += "<td>"+item_value_lo+"</td>";
						html += "</tr>";
					}
					$("#resultList_A tbody").append(html);
					$("#fromFactCode").val(fact_code);
					$("#resultTit_A").html($("#factCode_A :selected").text()+" 기준값 정보");
				}else{
					$("#resultList_A tbody").append("<tr><td colspan='3'>조회 결과가 없습니다.</td></tr>");
				}
				$("#compareResultDiv").show();
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
				$("#resultList tbody").append("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
				$("#compareResultDiv").show();
				closeLoading();
			}
			
		});
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
						<form:form commandName="searchTaksuVO" name="listFrm"  id="listFrm" method="post">
							<input type="hidden" name="state" id="state"/>
							<input type="hidden" name="toFactCode" id="toFactCode"/>
							<input type="hidden" name="toBranchNo" id="toBranchNo"/>
							<input type="hidden" name="fromFactCode" id="fromFactCode"/>

							<div class="searchBox">
								<ul>
									<li>
										<span class="fieldName">측정소</span>
										<select class="fixWidth7" id="sugye">
											<option value="R01">한강</option>
											<option value="R02">낙동강</option>
											<option value="R03">금강</option>
											<option value="R04">영산강</option>
										</select>
										<span style="display:none;">&gt;</span>
										<select class="fixWidth11" id="factCode" style="display:none;">
											<option value="all">전체</option>
										</select>
										<span id="spanBranch">
											<span>&gt;</span>
											<select class="fixWidth11" id="branchNo" name="branchNo">
												<option value="all">전체</option>
											</select>
										</span>
									</li>
									<li>
										<span class="fieldName">비교측정소</span>
										<select class="fixWidth7" id="sugye_A">
											<option value="R01">한강</option>
											<option value="R02">낙동강</option>
											<option value="R03">금강</option>
											<option value="R04">영산강</option>
										</select>
										<span>&gt;</span>
										<select class="fixWidth11" id="factCode_A" style="display:none;">
											<option value="all">전체</option>
										</select>
<!-- 										<span id="spanBranch_A"> -->
<!-- 											<span>&gt;</span> -->
<!-- 											<select class="fixWidth11" id="branchNo_A" name="branchNo"> -->
<!-- 												<option value="all">전체</option> -->
<!-- 											</select> -->
<!-- 										</span> -->
										&nbsp;
										<input type="checkbox" name="set_yn" checked="checked" />&nbsp;조회포함
									</li>
									
								</ul>
							</div>
							<div class="btnSearchDiv">
								<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
							</div>
						</form:form>
						
						<div class="divisionBx">
							<div class="div50">
								<div class="topBx txtalignL">
									<span class="buSqu_tit" id="resultTit"></span>
								</div>
								<table summary="측정정보" id="resultList">
									<colgroup>
										<col width="" />
										<col width="185px" />
										<col width="185px" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">항목</th>
											<th scope="col">상한</th>
											<th scope="col">하한</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td colspan="3">조회 결과가 없습니다.</td>
										</tr>
									</tbody>
								</table>
								<br/>
								<div id="menuAuth1">
									<div id="btArea" class="btnModify">
										<input type="button" value="수정" class="btn btn_basic" onclick="javascript:modifyData();" alt="수정" />
									</div>
									<div id="btArea" class="btnRegist">
										<input type="button" value="저장" class="btn btn_basic" onclick="javascript:saveData();" alt="저장" />
										<input type="button" value="취소" class="btn btn_basic" onclick="javascript:reloadData();" alt="취소" />
									</div>
								</div>
							</div>
							
							<div class="div50 last" id="compareResultDiv" style="display:none;">
								<div class="topBx txtalignL">
									<span class="buSqu_tit" id="resultTit_A"></span>
								</div>
								<table summary="측정정보" id="resultList_A">
									<colgroup>
										<col width="" />
										<col width="185px" />
										<col width="185px" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">항목</th>
											<th scope="col">상한</th>
											<th scope="col">하한</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td colspan="3">조회 결과가 없습니다.</td>
										</tr>
									</tbody>
								</table>
								<br/>
								<div id="btArea">
									<span id="menuAuth2">
										<input type="button" id="btnApply" value="적용" class="btn btn_basic" onclick="javascript:applyData();" alt="적용" />
									</span>
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
		$("#menuAuth2").show();
	}else{
		$("#menuAuth1").hide();
		$("#menuAuth2").hide();
	}
	
	</script>
</body>
</html>