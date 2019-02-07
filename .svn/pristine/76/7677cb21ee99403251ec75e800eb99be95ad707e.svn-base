<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : ecompanyList.jsp
	 * Description : 방제업체 관리  화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2014.02.19	lkh			리뉴얼
	 * 
	 * author lkh
	 * since 2014.02.19
	 * 
	 * Copyright (C) 2014by lkh All right reserved.
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
	$(function () {
		selectedSugyeInMemberId(user_riverid , 'sugye');
		// 목록 데이터 가져오기
		reloadData();
		
		//수정 레이어
		$("#layerEcoMod").draggable({
			containment: 'body',
			scroll: false
		});
	});
	
	// 데이터 목록 불러오기
	function reloadData(pageNo){
		showLoading();
		
		var sugye = $("#sugye option:selected").val();
		var searchKeyword = $("#searchKeyword").val();
		
		if (pageNo == null) pageNo = 0;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/waterinfo/getEcompanyList.do'/>",
			data: {
					pageIndex:pageNo,
					sugye:sugye,
					searchKeyword:searchKeyword
				},
			dataType:"json",
			success : function(result){
				var tot = result['resultList'].length;
				var pageInfo = result['paginationInfo'];
				
				if( tot <= 0 ){
					$('#dataList').html("<tr><td colspan='2'>조회 결과가 없습니다.</td></tr>");
				}else{
					var item = "";
					
					for(var i=0; i < tot; i++){
						var obj = result['resultList'][i];
						var no = i+1;
						
						item += "<tr><td>" + no + "</td><td style='cursor:pointer;' onclick='javascript:getEcompanyDetailList("+obj.id+");'>" + obj.nm + "</td></tr>"
						
						
					}
					
					$("#dataList").html(item);
					$("#dataList tr:odd").attr("class","even");
					
					getEcompanyDetailList(result['resultList'][0].id);
					
				}

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
				$('#dataList').html("<tr><td colspan='2'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
				
				closeLoading();
			}
		});
	}
	
	// 페이지 번호 클릭
	function linkPage(pageNo){
		reloadData(pageNo);
	}
	
	// 좌표 지정 팝업
	function lon_lat(){
		window.open("<c:url value='/addrMap.jsp'/>",'popupMap','resizable=yes,scrollbars=yes,width=960,height=800');
	}
	
	// 좌표 및 주소 반영
	function applyLonLat(lon, lat, addr) {
		$("#longitude").val(lon);
		$("#latitude").val(lat);
		$("#address").val(addr.replace('한국 ',''));
	}
	
	function getEcompanyDetailList(sId) {
		
		$("#id_mod").val(sId);
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/waterinfo/getEcompanyDetailList.do'/>",
			data: {
					sId:sId
				},
			dataType:"json",
			success : function(result){
// 				console.log("getEcompanyDetailList : ",result);
				
				var tot = result['resultList'].length;
				
				if( tot <= 0 ){
					$('#dataList1').html("<tr><td colspan='3'>조회 결과가 없습니다.</td></tr>");
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['resultList'][i];
						
						var item = "";
						
						item = "<tr><th>ID</th><td>" + obj.id + "</td></tr>"
							+ "<tr><th>업체명</th><td>" + obj.nm + "</td></tr>"
							+ "<tr><th>담당자</th><td>" + obj.owner + "</td></tr>"
							+ "<tr><th>관련수계</th><td>" + obj.river_nm + "</td></tr>"
							+ "<tr><th>주간연락처</th><td>" + obj.d_phone + "</td></tr>"
							+ "<tr><th>야간연락처</th><td>" + obj.n_phone + "</td></tr>"
							+ "<tr><th>비상연락처</th><td>" + obj.e_phone + "</td></tr>"
							+ "<tr><th>업체구분</th><td>" + obj.type + "</td></tr>"
							+ "<tr><th>팩스</th><td>" + obj.fax + "</td></tr>"
							+ "<tr><th>위도</th><td>" + obj.latitude + "</td></tr>"
							+ "<tr><th>경도</th><td>" + obj.longitude + "</td></tr>"
							+ "<tr><th>주소</th><td>" + obj.address + "</td></tr>";
						
						// 수정을 위한 레이어에 값 입력
						$("#id").val(obj.id);
						$("#nm").val(obj.nm);
						$("#owner").val(obj.owner);
						$("#d_phone").val(obj.d_phone);
						$("#n_phone").val(obj.n_phone);
						$("#e_phone").val(obj.e_phone);
						$("#type").val(obj.type);
						$("#fax").val(obj.fax);
						$("#longitude").val(obj.longitude)
						$("#latitude").val(obj.latitude);
						$("#address").val(obj.address);
						//지도보기 참조
						$("#rlongitude").val(obj.longitude)
						$("#rlatitude").val(obj.latitude);
						
						$("#do_code").val(obj.do_code)
						$("#cty_code").val(obj.cty_code);
							
						$("#dataList1").html(item);
						
						$("#dataList1 tr:odd").attr("class","even");
						
						$("#river_div > option[value=" + obj.river_div + "]").attr("selected", true);
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
				$('#dataList1').html("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
			}
		});
	}
	
	function getEcompanyOwnItemList(sId) {
		
		if (sId == undefined || sId == null) sId = $("#id_mod").val();
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/waterinfo/getEcompanyOwnItemList.do'/>",
			data: {
					sId:sId
				},
			dataType:"json",
			success : function(result){
// 				console.log("EcompanyOwnItemList : ",result);
				var tot = result['resultList'].length;
				
				dataView1.setItems([]);
				
				$("#searchResult1").hide();
				$("#ecompanyOwnItemList").css("height", "180px");
// 				$('#itemDateList').html("<tr><td colspan='3'>조회 결과가 없습니다.</td></tr>");
				
				var data = [];
				
				if( tot <= 0 ){
					$("#searchResult1").show();
					$("#ecompanyOwnItemList").css("height", "25px");
					$("#resultText1").html("조회 결과가 없습니다.");
					
					closeLoading();
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['resultList'][i];
						
						obj.no = i + 1;
						
						data.push(obj);
					}
					
					dataView1.beginUpdate();
					dataView1.setItems(data, 'no');
					dataView1.endUpdate();
				}
				//총건수 표시
// 				$("#p_total_cnt").html("[총 " + result['totCnt'] + "건]");
				
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
				$("#searchResult1").show();
				$("#ecompanyOwnItemList").css("height", "25px");
				$("#resultText1").html("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				
				closeLoading();
			}
		});
	}
	
	function popupMapOpen(){
		var longitude = $("#rlongitude").val();
		var latitude = $("#rlatitude").val();
		
		window.open("/psupport/WPCS_POP.html?riverid=" + user_riverid + "&menuid=ecom&longitude=" + longitude + "&latitude=" + latitude,
				'wpcsView','width='+window.screen.width+',height='+window.screen.height+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left=0,top=0');
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerEcoMod");
	}
	
	function layerPopEditOpen(flag) {
		
		if (flag == 'reg') {
			// 등록을 위한 레이어에 초기화
			$("#id").attr({ value: "", style: "width:380px;background-color:#ffffff;", readonly: false });
			$("#nm").val("");
			$("#owner").val("");
			$("#d_phone").val("");
			$("#n_phone").val("");
			$("#e_phone").val("");
			$("#type").val("");
			$("#fax").val("");
			$("#longitude").val("")
			$("#latitude").val("");
			$("#address").val("");
			
// 			$("#btnRegist").attr({ value: "등록", onclick: "javascript:goEcomReg();", alt: "등록" });
			
			$("#river_div > option[value='all']").attr("selected", "true");
			
			$("#btnEcoReg").show();
			$("#btnEcoMod").hide();
		} else {
			$("#id").attr({ style: "width:380px;background-color:#f2f2f2;", readonly: true });
// 			$("#btnRegist").attr({ value: "수정", onclick: "javascript:goEcoMod();", alt: "수정" });
			
			var sId = $("#id_mod").val();
			getEcompanyDetailList(sId);
			
			$("#btnEcoReg").hide();
			$("#btnEcoMod").show();
		}
		layerPopOpen("layerEcoMod");
	}
	
	function validateEcompany() {
		
		if($("#id").val().length == 0) {
			alert('ID를 입력해 주세요.');
			return false;
		}
		
		if($("#nm").val().length == 0) {
			alert('업체명를 입력해 주세요.');
			return false;
		}
		
		if($("#owner").val().length == 0) {
			alert('담당자를 입력해 주세요.');
			return false;
		}
		
		if($("#d_phone").val().length == 0) {
			alert('주간전화번호를 입력해 주세요.');
			return false;
		}
		
		if($("#n_phone").val().length == 0) {
			alert('야간전화번호를 입력해 주세요.');
			return false;
		}
		
		if($("#e_phone").val().length == 0) {
			alert('비상전화번호를 입력해 주세요');
			return false;
		}
		
		if($("#type").val().length == 0) {
			alert('업체구분을 입력해 주세요.');
			return false;
		}
		
		if($("#fax").val().length == 0) {
			alert('팩스를 입력해 주세요.');
			return false;
		}
		
		if($("#latitude").val().length == 0 || $("#longitude").val().length == 0 || $("#address").val().length == 0) {
			alert('좌표를 선택해 주세요.');
			return false;
		}
		return true;
	}
	
	// 방제업체등록
	function goEcomReg(){
		var formEcompany = $("#ecoModForm");
		
		if(validateEcompany()) {
			$.ajax({
				type: "POST",
				url: "<c:url value='/waterpolmnt/waterinfo/insertEcompany.do'/>",
				data: formEcompany.serialize(),
				dataType:"json",
				success : function(result){
// 					console.log("Insert Ecompanyt 결과 값 확인 : ",result);
// 					console.log("duplicateCnt : ",result.duplicateCnt);
					
					if (result.duplicateCnt != undefined && result.duplicateCnt > 0) {
						alert("이미 사용중인 ID입니다.\n\n다시 시도해 주세요.");
					} else {
						
						if (!result.updateCnt) {
							alert("등록 되지 않았습니다.\n\n다시 시도해 주세요.");
						} else {
							alert("등록 되었습니다.");
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
	}
	
	// 방제업체 수정
	function goEcoMod(){
		
		if(validateEcompany) {
			var sId = $("#id_mod").val();
			var formEcompany = $("#ecoModForm");
			
			$.ajax({
				type: "POST",
				url: "<c:url value='/waterpolmnt/waterinfo/updatEcompany.do'/>",
				data: formEcompany.serialize(),
				dataType:"json",
				success : function(result){
// 					console.log("Mod Ecompany : ",result);
					
					if (!result.updateCnt) {
						alert("수정되지 않았습니다.\n\n다시 시도해 주세요.");
					} else {
						alert("수정 되었습니다.");
						getEcompanyDetailList(sId);
// 						getEcompanyOwnItemList(sId);
						layerPopCloseAll();
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
		} else {
			return false;
		}
	}
	
	// 방제업체 삭제
	function fnGoEcompanyDelete(){
		
		if (confirm('삭제하시겠습니까?')) {
			var sId = $("#id_mod").val();
			
			$.ajax({
				type: "POST",
				url: "<c:url value='/waterpolmnt/waterinfo/deleteEcompany.do'/>",
				data: {
					sId:sId
					},
				dataType:"json",
				success : function(result){
// 					console.log("Del Ecompany : ",result);
					
					if (result.updateCnt != 1) {
						alert("삭제되지 않았습니다.\n\n다시 시도해 주세요.");
					} else {
						alert("삭제되었습니다.");
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
					alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				}
			});
		}
	}
	
	//방제물품 추가
	function fnGoEcoOwnItemRegist(){
		var formEcompany = $("#ecoModForm");
	
		if(validateEcompany()) {
			$.ajax({
				type: "POST",
				url: "<c:url value='/waterpolmnt/waterinfo/insertEcompanyOwnItem.do'/>",
				data: formEcompany.serialize(),
				dataType:"json",
				success : function(result){
// 					console.log("Insert EcompanyOwnItem : ",result);
// 					console.log("duplicateCnt : ",result.duplicateCnt);
					
					if (result.duplicateCnt != undefined && result.duplicateCnt > 0) {
						alert("이미 사용중인 ID입니다.\n\n다시 시도해 주세요.");
					} else {
						
						if (!result.updateCnt) {
							alert("등록 되지 않았습니다.\n\n다시 시도해 주세요.");
						} else {
							alert("등록 되었습니다.");
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
	}
	
	// 방제물품 삭제
	function fnGoEcompanyOwnItemDelete(){
		
		if (confirm('삭제하시겠습니까?')) {
			var formDelEcomOwnItem = $("#DelEcomOwnItemForm");
			
			$.ajax({
				type: "POST",
				url: "<c:url value='/waterpolmnt/waterinfo/deleteEcompanyOwnItem.do'/>",
				data: formDelEcomOwnItem.serialize(),
				dataType:"json",
				success : function(result){
// 					console.log("Del EcompanyOwnItem : ",result);
					
					if (result.updateCnt != 1) {
						alert("삭제되지 않았습니다.\n\n다시 시도해 주세요.");
					} else {
						alert("삭제 되었습니다.");
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
					alert("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
				}
			});
		}
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
			<form id="hiddenForm">
				<input type="hidden" id="memberName" name="memberName"/>
			</form>
			
			<div id="content_wrapper">
			
				<!--left menu Start-->
				<c:import url="/common/menu/left.do" />
				<!--left menu End-->
				
				<!-- Content Start-->
				<div id="content">
				
					<!-- navi, tab menu Start-->
					<c:import url="/common/menu/navi.do" />
					<!-- navi, tab menu End-->
					
						<div class="searchBox dataSearch">
							<ul>
								<li>
									<span class="fieldName">수계</span>
									<select id="sugye">
										<option value="all">전체</option>
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
								</li>
								<li>
									<span class="fieldName">명칭</span>
									<input type="text" id="searchKeyword" name="searchKeyword" style="width: 195px; ime-mode:active;"/>
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
						</div>
						<div class="divisionBx" style="margin-top: 0px;">
							<div class="div40" style="margin-bottom: 15px;">
							
								<div id="btArea" >
									<span id="p_total_cnt">[총 ${totCnt}건]</span>
								</div>
								<div  style="overflow-x: hidden; overflow-y: scroll; width: 380px; height: 445px;">
								<table summary="방제업체정보">
									<colgroup>
										<col width="100" />
										<col />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">No.</th>
											<th scope="col">업체명</th>
										</tr>
									</thead>
									<tbody id="dataList">
										<tr><td>조회 결과가 없습니다.</td></tr>
									</tbody>
								</table>
								</div>
							</div>
							
							<div class="div60">
								<div id="btArea"/>
									<span><img src="/images/common/bu_square.gif"></img>&nbsp; 방제업체 상세정보</span>
								</div>
								<input type="hidden" id="id_mod" name="id_mod" value="" />
								<input type="hidden" id="rlongitude" name="rlongitude" value="" />
								<input type="hidden" id="rlatitude" name="rlatitude" value="" />
								<table summary="방제업체정보" style="height:445px;">
									<colgroup>
										<col width="200" />
										<col />
									</colgroup>
									<tbody id="dataList1">
										<tr><td>조회 결과가 없습니다.</td></tr>
									</tbody>
								</table>
								<!-- <div id="btArea" style="margin-top: 10px; margin-bottom: 10px;">
									<img src="/images/common/bu_square.gif"></img>&nbsp;&nbsp;<span id="titleText">방제물품</span>&nbsp;
									<input type="button" id="btnEcompanyOwnItemInset" name="btnEcompanyOwnItemInset" value="추가" class="btn btn_basic" onclick="javascript:insertEcompanyOwnItem();" alt="추가"/>
									<input type="button" id="btnEcompanyOwnItemDelete" name="btnEcompanyOwnItemDelete" value="삭제" class="btn btn_basic" onclick="javascript:getEcompanyOwnItemDel();" alt="삭제"/>
								</div>
								<div id="ecompanyOwnItemList" style="height: 180px;"></div>
								<table id="searchResult1" style="display:none" summary="결과정보"><tr><td><span id="resultText1">조회 결과가 없습니다.</span></td></tr></table>
								 -->
							</div>
						</div>
						<div style="float:right;margin-top:5px;">
							<span id="menuAuth1">
							<input type="button" id="btnEcoRegV" name="btnEcoRegV" value="등록" class="btn btn_basic" onclick="javascript:layerPopEditOpen('reg')" alt="등록"/>
							</span>
							<span id="menuAuth2">
							<input type="button" id="btnModifyEcompany" name="btnModifyEcompany" value="수정" class="btn btn_basic" onclick="javascript:layerPopEditOpen()" alt="수정" />
							</span>
							<span id="menuAuth3">
							<input type="button" id="btnDeleteEcompany" name="btnDeleteEcompany" value="삭제" class="btn btn_basic" onclick="javascript:fnGoEcompanyDelete()" alt="삭제"/>
							</span>
							<input type="button" id="btnMap" name="btnMap" value="지도보기" class="btn btn_basic" onclick="javascript:popupMapOpen()" alt="지도보기"/>
						</div>
					
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
	<!-- 방제업체 등록 레이어 -->
	<div id="layerEcoMod" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnEcoModXbox" name="btnEcoModXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerEcoMod');" alt="닫기" />
		</div>
		<form id="ecoModForm" name="ecoModForm" method="post">
			<input type="hidden" id="do_code" name="do_code" />
			<input type="hidden" id="cty_code" name="cty_code" />
			
			<table style="width:100%; float:left; margin-bottom:10px" summary="방제업체 정보">
				<colgroup>
					<col width="120" />
					<col /> 
				</colgroup>
				<thead>
					<tr>
						<th scope="row">ID</th>
						<td class="txtL"><input type="text" id="id" name="id" style="width:380px; background-color:#f2f2f2;" readonly="readonly" /></td>
					</tr>
					<tr>
						<th scope="row">업체명</th>
						<td class="txtL"><input type="text" id="nm" name="nm" style="width:380px" /></td>
					</tr>
					<tr>
						<th scope="row">담당자</th>
						<td class="txtL"><input type="text" id="owner" name="owner" style="width:380px" /></td>
					</tr>
					<tr>
						<th scope="row">관련수계</th>
						<td class="txtL">
							<select id="river_div" name="river_div" style="width:388px">
								<option value="all">전체</option>
								<option value="R01">한강</option>
								<option value="R02">낙동강</option>
								<option value="R03">금강</option>
								<option value="R04">영산강</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">주간전화번호</th>
						<td class="txtL"><input type="text" id="d_phone" name="d_phone" style="width:380px" /></td>
					</tr>
					<tr>
						<th scope="row">야간전화번호</th>
						<td class="txtL"><input type="text" id="n_phone" name="n_phone" style="width:380px" /></td>
					</tr>
					<tr>
						<th scope="row">비상전화번호</th>
						<td class="txtL"><input type="text" id="e_phone" name="e_phone" style="width:380px" /></td>
					</tr>
					<tr>
						<th scope="row">업체구분</th>
						<td class="txtL"><input type="text" id="type" name="type" style="width:380px" /></td>
					</tr>
					<tr>
						<th scope="row">팩스</th>
						<td class="txtL"><input type="text" id="fax" name="fax" style="width:380px" /></td>
					</tr>
					<tr>
						<th scope="row">좌표</th>
						<td class="txtL">
							<input type="text" id="latitude" name="latitude" style="width:144px; background-color:#f2f2f2;" readonly="readonly" />&nbsp;
							<input type="text" id="longitude" name="longitude" style="width:143px; background-color:#f2f2f2;" readonly="readonly" />
							<input type="button" id="btnLonlat" name="btnLonlat" value="좌표선택" class="btn btn_search" onclick="javascript:lon_lat();" alt="좌표선택"/>
						</td>
					</tr>
					<tr>
						<th scope="row">주소</th>
						<td class="txtL"><input type="text" id="address" name="address" style="width:380px; background-color:#f2f2f2;" readonly="readonly" /></td>
					</tr>
				</thead>
			</table>
		</form>
		<div id="btCarea">
			<input type="button" id="btnEcoReg" name="btnEcoReg" value="등록" class="btn btn_white" onclick="javascript:goEcomReg();" alt="등록" />
			<input type="button" id="btnEcoMod" name="btnEcoMod" value="수정" class="btn btn_white" onclick="javascript:goEcoMod();" alt="수정" />
		</div>
	</div>
	<!-- //등록 레이어 -->
	<script language="javascript">
	//menuId:$("#naviMenuNo").val(),
	//userId:$("#userId").val(),
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
	if("1" == menuAuth("C")){
		$("#menuAuth1").show();
	}else{
		$("#menuAuth1").hide();
	}
	if("1" == menuAuth("U")){
		$("#menuAuth2").show();
	}else{
		$("#menuAuth2").hide();
	}
	if("1" == menuAuth("D")){
		$("#menuAuth3").show();
	}else{
		$("#menuAuth3").hide();
	}
	
	
</script>
</body>
</html>