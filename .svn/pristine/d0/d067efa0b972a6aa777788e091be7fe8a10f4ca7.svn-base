<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : CmmnCodeList.jsp
	 * Description : 공통코드카테고리관리 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2010.06.18	kisspa		최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 * 
	 * author kisspa
	 * since 2010.06.18
	 * 
	 * Copyright (C) 2010 by kisspa All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
	$(function(){
		reloadData();
		
		//공통코드 등록 레이어
		$("#layerCmnCode").draggable({
			containment: 'body',
			scroll: false
		});
	});
	
	//리스트 가져오기
	function reloadData(){
		showLoading();
		
		var searchCondition = $("#searchCondition").val();
		var searchKeyword = $("#searchKeyword").val();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/admin/cmmncode/getCmmnCodeList.do'/>",
			data:{
				searchCondition:searchCondition,
				searchKeyword:searchKeyword
			},
			dataType:"json",
			success : function(result){
// 					console.log("getCmmnCodeList : ",result);
				
				var tot = result['resultList'].length;
// 				var pageInfo = result['paginationInfo'];

				var dataHtml="";
				
				if( tot <= 0 ){
					dataHtml="<tr><td colspan='4'>조회 결과가 없습니다.</td></tr>";
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['resultList'][i];
						
						obj.no = i + 1;
						obj.useflagNm = (obj.useFlag == "Y") ? "사용" : "미사용";
						
						dataHtml += "<tr>";
						dataHtml += "<td><a href=\"javascript:detailCmnCode('"+obj.codeId+"');\">" + obj.no +"</a></td>";
						dataHtml += "<td><a href=\"javascript:detailCmnCode('"+obj.codeId+"');\">" + obj.codeId +"</a></td>";
						dataHtml += "<td><a href=\"javascript:detailCmnCode('"+obj.codeId+"');\">" + obj.codeIdName +"</a></td>";
						dataHtml += "<td><a href=\"javascript:detailCmnCode('"+obj.codeId+"');\">" + obj.useflagNm +"</a></td>";
						dataHtml += "</tr>";
					}
				}
				
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				$("#dataList tr:odd").attr("class","even");
				
				// 총건수 표시
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
				
				var dataHtml="<tr colspan='4'><td>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "</td></tr>";
				$("#dataList").html("");
				$('#dataList').append(dataHtml);
				closeLoading();
			}
		});
	}
	//페이징 처리 함수
// 	function linkPage(pageNo){
// 		document.listForm.pageIndex.value = pageNo;
// 		document.listForm.action = "<c:url value='/admin/cmmncode/CmmnCodeList.do'/>";
// 		document.listForm.submit();
// 	}
	
	//조회 처리 
// 	function fnSearch(){
// 		document.listForm.pageIndex.value = 1;
// 		document.listForm.submit();
// 	}
	
// 	//등록 처리 함수
// 	function fnRegist(){
// 		location.href = "<c:url value='/admin/cmmncode/CmmnCodeRegist.do'/>";
// 	}
	
// 	//수정 처리 함수
// 	function fnModify(){
// 		location.href = "";
// 	}
	
// 	//상세회면 처리 함수
// 	function fnDetail(codeId){
// 		var varForm = document.all["Form"];
// 		varForm.action = "<c:url value='/admin/cmmncode/CmmnCodeDetail.do'/>";
// 		varForm.codeId.value = codeId;
// 		varForm.submit();
// 	}
	
// 	//삭제 처리 함수
// 	function fnDelete(){
// 		//
// 	}
	
	function detailCmnCode(codeId) {
		$("#btnGoCmnCode").attr({ value:"수정", alt:"수정" });
		$("#cmd").val("Mod");
		$("#codeId").attr({ "style":"display:block;background-color:#f2f2f2", "readonly":true });
		$("#codeIdName").attr({ "style":"display:block;background-color:#f2f2f2", "readonly":true });
		layerPopOpen("layerCmnCode");
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/admin/cmmncode/CmmnCodeDetail.do'/>",
			data: {
				codeId:codeId
			},
			dataType:"json",
			success : function(result){
// 				console.log("CmmnCodeDetail : ",result);
				var tot = result['resultList'].length;
// 				console.log("tot : ", tot);
				
				if( tot <= 0 ){
					alert("조회 결과가 없습니다.");
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['resultList'][i];
// 						console.log("codeId : ",obj.codeId);
						$("#codeId").val(obj.codeId);
						$("#codeIdName").val(obj.codeIdName);
						$("#codeIdDesc").val(obj.codeIdDesc);
						
						if (obj.useFlag =="Y")
							$("#useFlag>option:first").attr("selected", true);
						else
							$("#useFlag>option:last").attr("selected", true);
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
				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
			}
		});
	}
	
	function cmnCodeReg() {
		$("#cmmnDetailCode").each( function() {
			this.reset();
		});
		getCmnCodeReg();
	}
	
	function getCmnCodeReg() {
		$("#btnGoCmnCode").attr({ value:"등록", alt:"등록" });
		$("#cmd").val("Reg");
		$("#codeId").attr({ "style":"background-color:#fff", "readonly":false });
		$("#codeIdName").attr({ "style":"background-color:#fff", "readonly":false });
		layerPopOpen("layerCmnCode");
		
// 		$.ajax({
// 			type: "POST",
// 			url: "<c:url value='/admin/cmmncode/getCmnCodeReg.do'/>",
// 			data: {},
// 			dataType:"json",
// 			success : function(result){
// // 				console.log("getCmnCodeReg : ",result);
// 				$("#codeId").loadSelectCode(result.cmnCodeList);
// 			},
// 			error:function(result){
// 				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
// 				var oraErrorCode = "";
// 				if (result.responseText != null ) {
// 					var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
// 					if (matchedValue != null && matchedValue.length > 0) {
// 						oraErrorCode = matchedValue[0].replace('ORA-', '');
// 					}
// 				}
// 				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
// 			}
// 		});
	}
	
	//SELECT OPTION 등록
// 	$.fn.loadSelectCode = function(optionsDataArray) {
		
// 		return this.emptySelect().each(function(){
// 			if (this.tagName=='SELECT') {
// 				var selectElement = this;
// 				$.each(optionsDataArray,function(idx, optionData){
					
// 					var option = new Option(optionData.codeIdName, optionData.codeId);
					
// 					if ($.browser.msie) {
// 						selectElement.add(option);
// 					}
// 					else {
// 						selectElement.add(option,null);
// 					}
// 				});
// 			}
// 		});
// 	};
	
	
	function goCmnCode(form){
		var cmd = $("#cmd").val();
		var $cmmnDetailCode = $("#cmmnDetailCode");
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/admin/cmmncode/updCmnCodeCat.do'/>",
			data: $cmmnDetailCode.serialize(),
			dataType:"json",
			success : function(result){
// 				console.log("updCmnCode : ",result);
// 				console.log("updateCnt : ",result.updateCnt);
				
				if (result.duplicateCnt != undefined && result.updateCnt > 0) {
					alert("코드ID가 중복됩니다.\n\n다른 코드ID를 사용해 주세요.");
				}else{
					if (result.updateCnt == undefined || result.updateCnt < 1) {
						if (cmd == "Mod")
							alert("수정되지 않았습니다.\n\n다시 시도해 주세요.");
						else
							alert("등록되지 않았습니다.\n\n다시 시도해 주세요.");
					} else {
						if (cmd == "Mod")
							alert("수정 되었습니다.");
						else {
							alert("등록 되었습니다.");
						}
						reloadData();
						layerPopCloseAll();
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
				alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
			}
		});
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerCmnCode");
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
						
						<form name="Form" action="" method="post">
							<input type=hidden name="codeId">
						</form>
						<form name="listForm" action="<c:url value='/admin/cmmncode/CmmnCodeList.do'/>" method="post">
						
						<div style="text-align:left;">
							<span id="p_total_cnt">[총 ${totCnt}건]</span>
							<span style="padding-left:595px;">
							검색 :
							<select name="searchCondition" class="select">
								<option selected value=''>--선택하세요--</option>
								<option value='1' <c:if test="${searchVO.searchCondition == '1'}">selected="selected"</c:if>>코드ID</option>
								<option value='2' <c:if test="${searchVO.searchCondition == '2'}">selected="selected"</c:if>>코드ID명</option>
							</select>
							<input name="searchKeyword" type="text"  class="fixWidth13" value="${searchVO.searchKeyword}"  maxlength="35" >
							<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" onclick="javascript:reloadData();"/>
							</span>
						</div>
						<div class="table_wrapper">
							<div style="overflow:auto; max-height:568px;">
								<table summary="공통코드카테고리관리 조회 결과 리스트">
									<colgroup>
										<col width="45" />
										<col width="160" />
										<col width="633" />
										<col width="135" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">No.</th>
											<th scope="col">코드카테고리ID</th>
											<th scope="col">코드카테고리ID명</th>
											<th scope="col">사용여부</th>
										</tr>
									</thead>
									<tbody id="dataList">
									</tbody>
								 </table>
							 </div>
							 <div style="float:right;margin-top:5px;">
								<input type="button" id="btnSearch" name="btnSearch" value="등록" class="btn btn_basic" onclick="javascript:cmnCodeReg();" alt="등록" />
							</div>
						</div>
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
	<!-- 공통코드 등록 레이어 -->
	<div id="layerCmnCode" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnCmnCodeModXbox" name="btnCmnCodeModXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerCmnCode');" alt="닫기" />
		</div>
		<form id="cmmnDetailCode" name="cmmnDetailCode" method="post">
			<input type=hidden id="cmd" name="cmd">
			
			<table style="width:100%; float:left; text-align:left; margin-bottom:10px" summary="코드정보">
				<colgroup>
					<col width="150">
					<col>
				</colgroup>
				<tr>
					<th>코드ID<span class="red">*</span></th>
					<td class="txtL"><input type="text" id="codeId" name="codeId" readonly="readonly" /></td>
				</tr>
				<tr>
					<th>코드ID명<span class="red">*</span></th>
					<td class="txtL"><input type="text" id="codeIdName" name="codeIdName" /></td>
				</tr>
				<tr>
					<th>코드ID설명<span class="red">*</span></th>
					<td class="txtL" style="padding-top:5px; padding-bottom:5px;">
						<textarea id="codeIdDesc" name="codeIdDesc" cols="50" rows="3"></textarea>
					</td>
				</tr>
				<tr>
					<th>사용여부</th>
					<td class="txtL">
						<select id="useFlag" name="useFlag">
							<option value="Y">사용</option>
							<option value="N">미사용</option>
						</select>
					</td>
				</tr>
			</table>
		</form>
		<div id="btCarea">
			<input type="button" id="btnGoCmnCode" name="btnGoCmnCode" value="등록" class="btn btn_white" onclick="javascript:goCmnCode(document.cmmnDetailCode);" alt="등록" />
		</div>
	</div>
	<!-- //공통코드 등록 레이어 -->
</body>
</html>