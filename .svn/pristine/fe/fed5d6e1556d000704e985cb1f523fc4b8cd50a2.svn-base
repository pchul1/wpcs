<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : relateOfficeList.jsp
	 * Description : 유관기관 관리 목록 화면
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
// 		selectedSugyeInMemberId(user_riverid , 'sugye');

		getSearchDoCodeList();
		// 목록 데이터 가져오기
		reloadData();
		
		//유관기관 수정 레이어
		$("#layerRelOffMod").draggable({
			containment: 'body',
			scroll: false
		});
	});
	
	// 데이터 목록 불러오기
	function reloadData(pageNo){
		showLoading();
		
		var sDoCode = $("#sDoCode").val();
		var sCtyCode = $("#sCtyCode").val();
		var searchKeyword = $("#searchKeyword").val();
		
		if (pageNo == null) pageNo = 0;
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/waterinfo/getRelOffList.do'/>",
			data: {
					pageIndex:pageNo,
					sDoCode:sDoCode,
					sCtyCode:sCtyCode,
					searchKeyword:searchKeyword
				},
			dataType:"json",
			success : function(result){
// 				console.log("결과 값 확인 : ",result);
				
				var tot = result['resultList'].length;
				var pageInfo = result['paginationInfo'];
				
				if( tot <= 0 ){
					$('#dataList').html("<tr><td colspan='2' class='txtC'>조회 결과가 없습니다.</td></tr>");
				}else{
					var item = "";
					for(var i=0; i < tot; i++){
						var obj = result['resultList'][i];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						
						obj.no = no;
						
						item += "<tr style='cursor:pointer;' onclick=\"getRelOffDetailList('"+obj.id+"'"+")\">"			                   	 		                   	 
						+"<td style='text-align:center;'><span>"+obj.no+"</span></td>"
                 		+"<td class='txtL'>"+obj.nm+"</td>"
             		 	+"</tr>";

		          		$("#dataList").html(item);
		          		$("#dataList tr:odd").attr("class","even");
					}
// 					itemList(result['resultList'][0].id);
				}
				
				// 페이징 정보
				var pageStr = makePaginationInfo(result['paginationInfo']);
				$("#pagination").empty();
				$("#pagination").append(pageStr);
				
				// 총건수 표시
				$("#p_total_cnt").html("[총 " + result['totCnt'] + "건]");
				
				getRelOffDetailList(result['resultList'][0].id);
				
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
				$('#dataList').html("<tr><td colspan='2' class='txtC'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
				
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
	
	function getRelOffDetailList(sId) {
		
		$("#id_mod").val(sId);
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/waterinfo/getRelOffDetailList.do'/>",
			data: {
					sId:sId
				},
			dataType:"json",
			success : function(result){
// 				console.log("RelOffDetailList : ",result);
				
				var tot = result['resultList'].length;
				
				if( tot <= 0 ){
					$('#dataList1').html("<tr><td colspan='3' class='txtC'>조회 결과가 없습니다.</td></tr>");
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['resultList'][i];
						
						var item = "";
						var item1 = "";
						
						item = "<tr><th>ID</th><td class='txtL'>" + obj.id + "</td></tr>"
							+ "<tr><th>기관명</th><td class='txtL'>" + obj.nm + "</td></tr>"
							+ "<tr><th>부서명</th><td class='txtL'>" + obj.dept + "</td></tr>"
							+ "<tr><th>주간전화번호</th><td class='txtL'>" + obj.day_tel + "</td></tr>"
							+ "<tr><th>야간전화번호</th><td class='txtL'>" + obj.night_tel + "</td></tr>"
							+ "<tr><th>주간팩스</th><td class='txtL'>" + obj.day_fax + "</td></tr>"
							+ "<tr><th>야간팩스</th><td class='txtL'>" + obj.night_fax + "</td></tr>"
							+ "<tr><th>주소</th><td class='txtL'>" + obj.address + "</td></tr>";
							
						// 수정을 위한 레이어에 값 입력
						$("#id").val(obj.id);
						$("#nm").val(obj.nm);
						$("#dept").val(obj.dept);
						$("#day_tel").val(obj.day_tel);
						$("#night_tel").val(obj.night_tel);
						$("#day_fax").val(obj.day_fax);
						$("#night_fax").val(obj.night_fax);
						$("#do_code").val(obj.do_code)
						$("#cty_code").val(obj.cty_code);
						$("#address").val(obj.address);
						
						$("#dataList1").html(item);
						
						getDoCodeList(obj.do_code);
						getCtyCodeList(obj.do_code, obj.cty_code);
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
				$('#dataList1').html("<tr><td colspan='3' class='txtC'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
			}
		});
	}
	
	function getSearchDoCodeList() {
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/waterinfo/getDoCodeList.do'/>",
			data: {},
			dataType:"json",
			success : function(result){
// 				console.log("SearchDoCodeList : ",result);
				
				// 시도 구분
				var dropDownSet = $('#sDoCode');
				dropDownSet.loadSelectCmn(result.resultList,'전체', 'do_code', 'do_name');
				
				//$("#sDoCode > option[value="+sDoCode+"]").attr("selected", true);
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
				$('#sDoCode').html("<option value='all'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</option>");
			}
		});
	}
	
	function getSearchCtyCodeList(sDoCode) {
		
		if (sDoCode == undefined || sDoCode == null) sDoCode = "all";
		
		$('#sCtyCode').attr({ disabled: false, style: "background-color:#ffffff;" });
		
		if (sDoCode != "all") {
			$.ajax({
				type: "POST",
				url: "<c:url value='/waterpolmnt/waterinfo/getCtyCodeList.do'/>",
				data: {
					sDoCode:sDoCode
					},
				dataType:"json",
				success : function(result){
// 					console.log("SearchCtyCodeList : ",result);
					
					// 시군구 구분
					var dropDownSet = $('#sCtyCode');
					dropDownSet.loadSelectCmn(result.resultList,'선택', 'cty_code', 'cty_name');
					
// 					$("#sCtyCode > option[value="+sCtyCode+"]").attr("selected", true);
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
					$('#sCtyCode').html("<option value='all'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</option>");
				}
			});
		} else {
			$('#sCtyCode').html("<option value='all'>선택</option>");
			$('#sCtyCode').attr({ disabled: true, style: "background-color:#f2f2f2;"});
// 			$('#cty_code').attr("style","width:188px; background-color:#f2f2f2;");
		}
	}
	
	function getDoCodeList(sDoCode) {
		
		if (sDoCode == undefined || sDoCode == null) sDoCode = "all";
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/waterpolmnt/waterinfo/getDoCodeList.do'/>",
			data: {},
			dataType:"json",
			success : function(result){
// 				console.log("getDoCodeList : ",result);
				
				// 시도 구분
				var dropDownSet = $('#do_code');
				dropDownSet.loadSelectCmn(result.resultList,'전체', 'do_code', 'do_name');
				
				$("#do_code > option[value="+sDoCode+"]").attr("selected", true);
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
				$('#do_code').html("<option value='all'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</option>");
			}
		});
	}
	
	function getCtyCodeList(sDoCode, sCtyCode) {
		
		if (sDoCode == undefined || sDoCode == null) sDoCode = "all";
		if (sCtyCode == undefined || sCtyCode == null) sCtyCode = "all";
		
		$('#cty_code').attr("disabled",false);
		$('#cty_code').attr("style","width:188px; background-color:#ffffff;");
		
		if (sDoCode != "all") {
			$.ajax({
				type: "POST",
				url: "<c:url value='/waterpolmnt/waterinfo/getCtyCodeList.do'/>",
				data: {
					sDoCode:sDoCode
					},
				dataType:"json",
				success : function(result){
// 					console.log("getCtyCodeList : ",result);
					
					// 시군구 구분
					var dropDownSet = $('#cty_code');
					dropDownSet.loadSelectCmn(result.resultList,'선택', 'cty_code', 'cty_name');
					
					$("#cty_code > option[value="+sCtyCode+"]").attr("selected", true);
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
					$('#cty_code').html("<option value='all'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</option>");
				}
			});
		} else {
			$('#cty_code').html("<option value='all'>선택</option>");
			$('#cty_code').attr("disabled",true);
			$('#cty_code').attr("style","width:188px; background-color:#f2f2f2;");
		}
	}
	
	function popupMapOpen(){
		var longitude = $("#rlongitude").val();
		var latitude = $("#rlatitude").val();
		
		window.open("/psupport/WPCS_POP.html?riverid=" + user_riverid + "&menuid=rela&longitude=" + longitude + "&latitude=" + latitude,
				'wpcsView','width='+window.screen.width+',height='+window.screen.height+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left=0,top=0');
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerRelOffMod");
	}
	
	function LayerPopEditOpen(flag) {
		
		if (flag == 'reg') {
			// 등록을 위한 레이어에 초기화
			$("#id").attr({ value: "", style: "width:380px;background-color:#ffffff;", readonly: false });
			$("#nm").val("");
			$("#dept").val("");
			$("#day_tel").val("");
			$("#night_tel").val("");
			$("#day_fax").val("");
			$("#night_fax").val("");
			$("#cty_code").val("");
			$("#address").val("");
			
// 			$("#btnRegist").attr({ value: "등록", onclick: "javascript:goRelOffReg();", alt: "등록" });
			
			getDoCodeList();
			$('#cty_code').html("<option value='all'>선택</option>");
			$('#cty_code').attr({ disabled: true, style: "width:188px; background-color:#f2f2f2;" });
			
			$("#btnRelOffReg").show();
			$("#btnRelOffMod").hide();
		} else {
			$("#id").attr({ style: "width:380px;background-color:#f2f2f2;", readonly: true });
// 			$("#btnRegist").attr({ value: "수정", onclick: "javascript:goRelOffMod();", alt: "수정" });
			
			var sId = $("#id_mod").val();
			getRelOffDetailList(sId);
			
			$("#btnRelOffReg").hide();
			$("#btnRelOffMod").show();
		}
		layerPopOpen("layerRelOffMod");
	}
	
	function validateRelOff() {
		
		if($("#id").val().length == 0) {
			alert('ID를 입력해 주세요.');
			return false;
		}
		
		if($("#nm").val().length == 0) {
			alert('기관명를 입력해 주세요.');
			return false;
		}
		
		if($("dept").val().length == 0) {
			alert('부서명를 입력해 주세요.');
			return false;
		}
		
		if($("day_tel").val().length == 0) {
			alert('주간전화번호를 입력해 주세요.');
			return false;
		}
		
		if($("night_tel").val().length == 0) {
			alert('야간전화번호를 입력해 주세요.');
			return false;
		}
		
		if($("day_fax").val().length == 0) {
			alert('주간팩스를 입력해 주세요.');
			return false;
		}
		
		if($("night_fax").val().length == 0) {
			alert('야간팩스를 입력해 주세요.');
			return false;
		}
		
		if($("#do_code option:selected").val() == 'all' || $("#cty_code option:selected").val() == 'all') {
			alert('주소를 선택해 주세요.');
			return false;
		}
		
		if($("address").val().length == 0) {
			alert('상세주소를 입력해 주세요.');
			return false;
		}
		return true;
	}
	
	// 유관기관등록
	function goRelOffReg(){
		var $formRelOff = $("#modifyRelOffForm");
	
		if(validateRelOff()) {
			$.ajax({
				type: "POST",
				url: "<c:url value='/waterpolmnt/waterinfo/insertRelOff.do'/>",
				data: $formRelOff.serialize(),
				dataType:"json",
				success : function(result){
// 					console.log("Insert RelOfft 결과 값 확인 : ",result);
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
	
	// 유관기관 수정
	function goRelOffMod(){
		
		if(validateRelOff) {
			var sId = $("#id_mod").val();
			var formRelOff = $("#modifyRelOffForm");
			
			$.ajax({
				type: "POST",
				url: "<c:url value='/waterpolmnt/waterinfo/updatRelOff.do'/>",
				data: formRelOff.serialize(),
				dataType:"json",
				success : function(result){
// 					console.log("Mod RelOfft 결과 값 확인 : ",result);
					
					if (!result.updateCnt) {
						alert("수정되지 않았습니다.\n\n다시 시도해 주세요.");
					} else {
						alert("수정 되었습니다.");
						getRelOffDetailList(sId);
// 						itemList(sId);
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
	
	// 유관기관 삭제
	function fnGoRelOffDelete(){
		
		if (confirm('삭제하시겠습니까?')) {
			var sId = $("#id_mod").val();
			
			$.ajax({
				type: "POST",
				url: "<c:url value='/waterpolmnt/waterinfo/deleteRelOff.do'/>",
				data: {
					sId:sId
					},
				dataType:"json",
				success : function(result){
// 					console.log("Del RelOff 결과 값 확인 : ",result);
					
					if (result.updateCnt != 1) {
						alert("수정되지 않았습니다.\n\n다시 시도해 주세요.");
					} else {
						alert("수정 되었습니다.");
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
									<span class="fieldName">특별시/도</span>
									<select id="sDoCode" onchange="javascript:getSearchCtyCodeList(this.value)">
										<option value="all">전체</option>
									</select>
								</li>
								<li>
									<span class="fieldName">시군구</span>
									<select id="sCtyCode" style="background-color:#f2f2f2;" disabled="disabled">
										<option value="all">선택</option>
									</select>
								</li>
								<li>
									<span class="fieldName">기관명</span>
									<input type="text" id="searchKeyword" name="searchKeyword" style="width: 195px; ime-mode:active;"/>
								</li>
							</ul>
						</div>
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:reloadData();" alt="조회하기" style="float:right;"/>
						</div>
						
						<div class="divisionBx" id="btArea" style="margin-top: 0px;">
							<div class="div40" style="margin-bottom: 5px;">
							
								<div id="btSmallArea" style="margin-bottom: 5px;">
									<span id="p_total_cnt">[총 ${totCnt}건]</span>
								</div>
								<div>
									<table>
										<colgroup>
											<col width="80" />
											<col />
										</colgroup>
										<thead>
										<tr>
											<th scope="col">NO</th>
											<th scope="col">기관명</th>
										</tr>
										</thead>
										<tbody  id="dataList">
										<tr>
											<td colspan="2" class='txtC'>조회 결과가 없습니다.</td>
										</tr>
										</tbody>
									</table>
								</div>
								<div class="paging">
									<div id="page_number">
										<ul class="paginate" id="pagination"></ul>
									</div>
								</div>
								<div>
									<input type="button" id="btnRelOffRegList" name="btnRelOffRegList" value="등록" class="btn btn_basic" onclick="javascript:LayerPopEditOpen('reg')" alt="등록"/>
								</div>
							</div>
							
							<div class="div60" style="padding-bottom:5px;">
								<div id="btSmallArea" style="margin-bottom: 5px;">
									<span><img src="/images/common/bu_square.gif"></img>&nbsp; 유관기관 상세정보</span>
<!-- 									<input type="button" id="btnMap" name="btnMap" value="지도보기" class="btn btn_basicM" onclick="javascript:popupMapOpen()" alt="지도보기" /> -->
								</div>
								<input type="hidden" id="id_mod" name="id_mod" value="" />
								<input type="hidden" id="rlongitude" name="rlongitude" value="" />
								<input type="hidden" id="rlatitude" name="rlatitude" value="" />
								<table summary="유관기관정보">
									<colgroup>
										<col width="200" />
										<col />
									</colgroup>
									<tbody id="dataList1">
										<tr><td class='txtC'>조회 결과가 없습니다.</td></tr>
									</tbody>
								</table>
							</div>
							<div>
								<input type="button" id="btnModifyRelOff" name="btnModifyRelOff" value="수정" class="btn btn_basic" onclick="javascript:LayerPopEditOpen()" alt="수정" />
								<input type="button" id="btnDeleteRelOff" name="btnDeleteRelOff" value="삭제" class="btn btn_basic" onclick="javascript:fnGoRelOffDelete()" alt="삭제" />
							</div>
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
	<!-- 유관기관 등록 레이어 -->
	<div id="layerRelOffMod" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnRelOffModXbox" name="btnRelOffModXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerRelOffMod');" alt="닫기" />
		</div>
		<form id="modifyRelOffForm" name="modifyRelOffForm" method="post">
			
			<table style="width:100%; float:left; margin-bottom:10px" summary="유관기관 정보">
				<colgroup>
					<col width="120" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">ID</th>
						<td class="txtL"><input type="text" id="id" name="id" style="width:380px; background-color:#f2f2f2;" readonly="readonly" /></td>
					</tr>
					<tr>
						<th scope="row">기관명</th>
						<td class="txtL"><input type="text" id="nm" name="nm" style="width:380px" /></td>
					</tr>
					<tr>
						<th scope="row">부서명</th>
						<td class="txtL"><input type="text" id="dept" name="dept" style="width:380px" /></td>
					</tr>
					<tr>
						<th scope="row">주간전화번호</th>
						<td class="txtL"><input type="text" id="day_tel" name="day_tel" style="width:380px" /></td>
					</tr>
					<tr>
						<th scope="row">야간전화번호</th>
						<td class="txtL"><input type="text" id="night_tel" name="night_tel" style="width:380px" /></td>
					</tr>
					<tr>
						<th scope="row">주간팩스</th>
						<td class="txtL"><input type="text" id="day_fax" name="day_fax" style="width:380px" /></td>
					</tr>
					<tr>
						<th scope="row">야간팩스</th>
						<td class="txtL"><input type="text" id="night_fax" name="night_fax" style="width:380px" /></td>
					</tr>
					<tr>
						<th scope="row">주소</th>
						<td class="txtL">
							<select id="do_code" name="do_code" style="width:190px;" onchange="javascript:getCtyCodeList(this.value)">
								<option value="all">선택</option>
							</select>
							&nbsp;
							<select id="cty_code" name="cty_code" style="width:190px">
								<option value="all">선택</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">상세주소</th>
						<td class="txtL"><input type="text" id="address" name="address" style="width:380px; _background-color:#f2f2f2;" /></td>
					</tr>
				</tbody>
			</table>
		</form>
		<div id="btCarea">
			<input type="button" id="btnRelOffReg" name="btnRelOffReg" value="등록" class="btn btn_white" onclick="javascript:goRelOffReg();" alt="등록" />
			<input type="button" id="btnRelOffMod" name="btnRelOffMod" value="수정" class="btn btn_white" onclick="javascript:goRelOffMod();" alt="수정" />
		</div>
	</div>
	<!-- //등록 레이어 -->
</body>
</html>