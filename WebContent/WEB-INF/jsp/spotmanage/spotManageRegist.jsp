<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : spotManageRegist.jsp
	 * Description : 측정소 등록화면
	 * Modification Information
	 * 
	 * 수정일			 수정자		수정내용
	 * ----------	--------	---------------------------
	 * 2015.02.05	kyr		최초생성
	 * 
	 * author khany
	 * since 2015.02.05
	 * 
	 * Copyright (C) 2010 by khany All right reserved.
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
<script type="text/javascript" src="<c:url value='/gis/js/new_editMap.js'/>"></script>

<script type="text/javascript">
//<![CDATA[
    //시스템 장비 정보를 가져오기
	function getSysinfoList(){
		//사업장정보
		var searchSysKeyword = $("#searchSysKeyword").val();
		var searchSysKind = $("select[name=search_sys_kind]").val();
		showLoading();
		$.ajax({
			type:"post",
			url:"<c:url value='/spotmanage/getSysinfoList.do'/>",
			data:{
				searchSysKeyword:searchSysKeyword,
				searchSysKind:searchSysKind
				},
			dataType:"json",
			success:function(result){
				var html = "";
				var tot = result['sysinfoList'].length;
				layerPopOpen("sysinfoLayer");
				
				if( tot <= 0 ){
					html += "<tr><td colspan='5' style='text-align:center;'>조회 결과가 없습니다.</td></tr>";
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['sysinfoList'][i];
						var pageInfo = result['paginationInfo'];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						
						obj.no = no;
							
						trclass = "";
						if(i % 2 == 1) trclass = "class=\"even\"";

						html +="<tr "+trclass+">";
						html += "<td style='text-align:center; cursor:pointer;'><a onclick=\"javascript:setSysInfo('"+obj.sys_kind_name+"','"+obj.equip_code+"'); return false;\" >"+ obj.no +"</a></td>";
						html += "<td style='text-align:center; cursor:pointer;'><a onclick=\"javascript:setSysInfo('"+obj.sys_kind_name+"','"+obj.equip_code+"'); return false;\" >"+ obj.sys_kind_name +"</a></td>";
						html += "<td style='text-align:center; cursor:pointer;'><a onclick=\"javascript:setSysInfo('"+obj.sys_kind_name+"','"+obj.equip_code+"'); return false;\" >"+ obj.equip_code +"</a></td>";
						html += "<td style='text-align:center; cursor:pointer;'><a onclick=\"javascript:setSysInfo('"+obj.sys_kind_name+"','"+obj.equip_code+"'); return false;\" >"+ obj.equip_maker +"</a></td>";
						html += "<td style='text-align:center; cursor:pointer;'><a onclick=\"javascript:setSysInfo('"+obj.sys_kind_name+"','"+obj.equip_code+"'); return false;\" >"+ obj.equip_name +"</a></td>";
						html +="</tr>";
					}
				}
				$("#sysDataList").html(html);
				
				closeLoading();
			},
			error:function(result){
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21

				var html = "";
				html += "<tr><td colspan='5'>서버 접속에 실패하였습니다.</td></tr>";
				$("#sysDataList").html(html);
				
				closeLoading();
			}
		});
	}
   	//사업장 정보를 가져오기
	function getFactinfoList(){
		//사업장정보
		var searchKeyword = $("#searchKeyword").val();
		var searchCondition = $("#searchCondition").val();
		showLoading();
		$.ajax({
			type:"post",
			url:"<c:url value='/spotmanage/getFactinfoList.do'/>",
			data:{
					searchCondition:searchCondition,
					searchKeyword:searchKeyword
				},
			dataType:"json",
			success:function(result){
				var html = "";
				var tot = result['factinfoList'].length;
				layerPopOpen("factinfoLayer");
				
				if( tot <= 0 ){
					html += "<tr><td colspan='3'>조회 결과가 없습니다.</td></tr>";
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['factinfoList'][i];
						var pageInfo = result['paginationInfo'];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						
						obj.no = no;
							
						link = "setFactinfoCode('" + JSONtoString(obj) +"');";
						trclass = "";
						if(i % 2 == 1) trclass = "class=\"even\"";

						html +="<tr "+trclass+">";
						html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"+ obj.no +"</a></td>";
						html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"+ obj.fact_code +"</a></td>";
						html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"+ obj.fact_name +"</a></td>";
						html +="</tr>";
					}
				}
				$("#dataList1").html(html);
				
				closeLoading();
			},
			error:function(result){
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21

				var html = "";
				html += "<tr><td colspan='3'>서버 접속에 실패하였습니다.</td></tr>";
				$("#dataList1").html(html);
				
				closeLoading();
			}
		});
	}
   	
	//좌표 지정 팝업
	function lon_lat(){
		window.open("<c:url value='/addrMap.jsp'/>",'popupMap','resizable=yes,scrollbars=yes,width=960,height=800');
	}
	
	//관리자 검색  (정)
	function onSearch_member(){
		var searchKey = $('#branch_mgr_name').val();
		
		if(searchKey.length < 2)
			alert("2자리 이상 검색 가능합니다.");
		else{
			$.ajax({
				type : "POST",
				url : "<c:url value='/warehouse/getSearchMember.do'/>",
				data : {
					searchKeyword:searchKey,
					searchCondition:'name'
				},
				dataType : "json",
				success : function(result) {
					var tot = result['list'].length;
					var html = "";
					layerPopOpen("memberLayer");
					
					if( tot <= 0 ){
						html += "<tr><td colspan='4'>조회 결과가 없습니다.</td></tr>";
					}else{
						for(var i=0; i < tot; i++){
							var obj = result['list'][i];
							obj.no = i+1;
							
							link = "onSelMember('" + JSONtoString(obj) +"');";
							trclass = "";
							if(i % 2 == 1) trclass = "class=\"even\"";

							html +="<tr "+trclass+">";
							html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"+ obj.no +"</a></td>";
							html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"+ obj.deptName +"</a></td>";
							html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"+ obj.gradeName +"</a></td>";
							html += "<td><a onclick=\""+link+"; return false;\" href=\"#\">"+ obj.memberName +"</a></td>";
							html +="</tr>";
							
						}
					}
					$("#dataList2").html(html);
					closeLoading();
				},
				error:function(result){
					var html = "";
					html += "<tr><td colspan='4'>서버 접속에 실패하였습니다.</td></tr>";
					$("#dataList2").html(html);

					closeLoading();
				}
			});
		}
	}
	
	function setSysInfo(sys_name, equip_code){
		$("#sys_name").val(sys_name);
		$("#sys_equip_code").val(equip_code);
		layerPopCloseAll();
	}
	
	//사업장정보에서 선택한 코드를 텍스트박스에 입력
	function setFactinfoCode(objs){
		obj = JSON.parse(StringtoJson(objs));
		$("#fact_code").val(obj.fact_code);
		$("#fact_name").val(obj.fact_name);
		$("#river_div").val(obj.river_div);
		$("#river_no").val(obj.river_no);
		$("#sys_kind").val(obj.sys_kind);
// 		$("#branch_no").val(obj.branch_cnt);

		layerPopCloseAll();
		
	}
	
	function JSONtoString(object) {
	    var results = [];
	    for (var property in object) {
	        var value = object[property];
	        if (value)
	            results.push(property.toString() + ': ' + value);4
	        }
	                 
	        return '{' + results.join(', ') + '}';
	}
	
	function StringtoJson(object) {
		object = object.replace(/\s/g,"");
		object = object.replace(/\{/g,"{\"");
		object = object.replace(/\}/g,"\"}");
		object = object.replace(/\:/g,"\":\"");
		object = object.replace(/\,/g,"\",\"");
		return object;
	}
	
	// 좌표 및 주소 반영
	function applyLonLat(lon, lat, addr) {
		$('#latitude1').val(lat);
		$('#longitude1').val(lon);
		$("#fact_addr").val(addr.replace('대한민국 ',''));
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("sysinfoLayer");			//시스템
		layerPopClose("factinfoLayer");			//사업장명
		layerPopClose("layerMember");			//담당자등록
		layerPopClose("layerEquipInfoReg");		//장비등록
		layerPopClose("memberLayer");			//관리자명 검색
	}
	
	//담당자 불러오기
	function memberDiv(){
		if($("#factCode").html()==""){
			alert("지점을 선택하여주세요.");
			return;
		}
		layerPopOpen("layerMember");
		var branchName=$("#memIdSearchTxt").val();
		$("#MemberList").html("");
		var searchText;
		if($("#memIdSearchTxt").val()!=""){
			searchText = branchName;
		}else{
			searchText = "";
		}
		showLoading();
		
		var factCode = $("#factCode").html();
		var branchNo = $("#branchNo").val();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/spotmanage/getMemberList.do'/>",
			data:{
				factCode:factCode,
				branchNo:branchNo,
				searchText:searchText
			},
			dataType:"json",
			success:function(result){
				var tot = result['getMemberList'].length;
				var item;
				if(tot <= 0){
					item = "<tr><td colspan='3'>조회 결과가 없습니다.</td></tr>"
					$("#MemberList").html(item);
				}else{
					for(var i=0; i<tot; i++)
					{
						obj = result['getMemberList'][i];
						item = "<tr>"
						+ "<td id=mi"+i+">"+obj.memberId+"</td><td>"+obj.memberName+"</td>"
// 						+ "<td><a href='javascript:memberInsert("+i+")' style='selector-dummy:expression(this.hideFocus=false);' class='btn_mng'><span><em>추가</em></span></a>&nbsp;</td>"
						+ "<td><input type='button' id='btnMemberInsert' name='btnMemberInsert' value='추가' class='btn btn_basic' onclick='javascript:memberInsert("+i+")' alt='추가'/></td>"
						+ "</tr>";
						
						$("#MemberList").append(item);
						$("#MemberList tr:odd").attr("class","add"); 
					}
				}
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
				$("#MemberList").html("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}
	
	//담당자 등록하기
	function memberInsert(index){
		showLoading();
		
		var factCode = $("#factCode").html();
		var branchNo = $("#branchNo").val();
		var memberId = $("#mi"+index).html();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/spotmanage/branchmemberInsert.do'/>",
			data:{
				factCode:factCode,
				branchNo:branchNo,
				memberId:memberId
			},
			dataType:"json",
			success:function(result){
				$("#memList").html("");
				memberDiv();
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
				$("#MemberList").html("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
				closeLoading();
			}
		});
	}
	
	//담당자 삭제 쿼리
	function memDel(index){
		if(confirm("담당자를 삭제 하시겠습니까?")){
			showLoading();
			var factCode = $("#Dfc"+index).val();
			var branchNo = $("#Dbn"+index).val();
			var memberSeq = $("#Dms"+index).val();
			$.ajax({
				type:"post",
				url:"<c:url value='/spotmanage/branchmemberdel.do'/>",
				data:{
					factCode:factCode,
					branchNo:branchNo,
					memberSeq:memberSeq
				},
				dataType:"json",
				success:function(result){
					$("#memList").html("");
					memberDiv();
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
					$("#MemberList").html("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
					closeLoading();
				}
			});
		}
	}
	
	function getEquipInfoReg(){
		layerPopCloseAll();
		
		layerPopOpen("layerEquipInfoReg");
	}
	
	function saveEquipInfoReg(){
		var equipCode = $("#equipInfoRegForm [name=equip_code]").val();
		var equipMaker = $("#equipInfoRegForm [name=equip_maker]").val();
		var equipName = $("#equipInfoRegForm [name=equip_name]").val();
		
		if(equipCode == null || equipCode == ""){
			alert("장비코드를 넣어주세요.");
			return;
		}
		
		if(equipMaker == null || equipMaker == ""){
			alert("제조사를 넣어주세요.");
			return;
		}
		
		if(equipName == null || equipName == ""){
			alert("모델명을 넣어주세요.");
			return;
		}
		
		$('#equipInfoRegForm').ajaxForm({
			success:function(result){
				alert("저장되었습니다.");
				//getSystemList();
				layerPopCloseAll();
				
				getSysinfoList();
				
			}
		}).submit();
	}
	
	function onSelMember(objs){
		
		obj = JSON.parse(StringtoJson(objs));
		$('#branch_mgr_name').val(obj.memberName);
		$('#branch_mgr_tel_no').val(obj.mobileNo);
		$('#branch_mgr').val(obj.memberId);
		
		layerPopCloseAll();
		
// 		layerPopOpen("layerBranchModify");
	}
	
	function fnList(){
		document.factBranchForm.action = "<c:url value='/spotmanage/spotManage.do'/>";
		document.factBranchForm.submit();
	}
	
	//등록,수정
	function updateFactBranch(mode){
		var factCode = $("#fact_code").val();
		var sysKind = $("#sys_kind").val();
		var mode = mode;//$("#mode").val();
		var pageNo = $("#rpage").val();	//측정소 수정을 위한 페이지 확인
		var branchUseFlag = $("#branch_use_flag").val();
		var modeName = "수정";
		if(mode == "reg"){
			$.ajax({
				type:"post",
				url:"<c:url value='/spotmanage/getMaxBranchNo.do'/>?factCode="+factCode,
				dataType:"json",
				success:function(result){
// 					console.log("BranchNo : ", result);
					$("#branch_no").val(result.branchNo);
					modeName = "등록";
					factinfoaddormodify(modeName);
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
		}else{
			factinfoaddormodify(modeName);
		}
	}
	
function factinfoaddormodify(modeName){
	
	var factCode = $("#fact_code").val();
	var sysKind = $("#sys_kind").val();
	var mode = mode;//$("#mode").val();
	var pageNo = $("#rpage").val();	//측정소 수정을 위한 페이지 확인
	var branchUseFlag = $("#branch_use_flag").val();
	
	if(validateItem() == true){
		
		if (sysKind == "A" || sysKind == "U"){
			
			var date = new Date();
			date = date.getFullYear() + addzero(date.getMonth()+1) + addzero(date.getDate());
			
			var obj = {};
			
			obj.BRANCH_NO = $("#branch_no").val();
			obj.DATE_= date;
			obj.FACI_ADDR = $("#fact_addr").val();
			obj.FACI_NM = $("#fact_name").val() + "("+ $("#branch_name").val() + ")";
			obj.FACT_CODE = $("#fact_code").val();
			obj.RV_CD = $("#river_div").val();
			obj.Y = $("#latitude1").val();
			obj.X = $("#longitude1").val();
			obj.USE_FLAG = $("#branch_use_flag").val();
			if(obj.USE_FLAG == 'N'){
				obj.Y = '0';
				obj.X = '0';
			}
//				console.log("esri 등록정보 : ",obj);
			
			$editMap.model.addMemtPoint(sysKind, obj , function(result){
// 				console.log('[저장]editMap.result', result);
				
				if(result.callbacktype == 'S' || result.callbacktype == 'R'){
// 					console.log('[저장]', result.callbacktype);
					
					$('#factBranchForm').ajaxForm({
						success:function(result){
							alert(modeName + " 하였습니다.");
//								layerPopClose("layerBranchModify");
//								reloadData(pageNo);

							fnList();
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
					}).submit();
				}else{
					alert("서버 접속에 실패하였습니다.");
				}
			})
		}else{
			$('#factBranchForm').ajaxForm({
				success:function(result){
					alert(modeName + " 하였습니다.");
// 					layerPopClose("layerBranchModify");
// 					reloadData(pageNo);
					fnList();
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
			}).submit();
		}
	}
}	
	
function validateItem(){
	
		if($('#sys_name').val().length == 0){
			alert("시스템을 선택해 주세요");
			return false;
		}
		
		if($('#fact_name').val().length == 0){
			alert("사업장을 선택해 주세요");
			return false;
		}
		
		if($('#branch_name').val().length < 2){
			alert("측정소명을 넣어주세요(2자리이상)");
			return false;
		}
		
		if($("#latitude1").val().length == 0){
			alert('좌표를 선택해 주세요');
			return false;
		}
		
		if($("#branch_mgr_name").val().length == 0 || $("#branch_mgr_tel_no").val().length == 0){
			alert("관리자를 선택해주세요");
			return false;
		}
		
	//		if($("#leave_distance").val().length == 0){
	//			if (!confirm("유효거리를 설정하지 않았습니다.\n계속하시려면'예' 아니시면 아니오를 누르세요.")){
	//				return false;
	//			}
	//		}
		return true;
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
					<div class="table_wrapper">
						<form id="factBranchForm" name="factBranchForm" action="/spotmanage/updateFactbranchInfoAdd.do" method="post">
						<input type="hidden" id="river_div" name="river_div" />
						<input type="hidden" id="river_no" name="river_no" />
						<input type="hidden" id="sys_kind" name="sys_kind" />
						<input type="hidden" id="branch_mgr" name="branch_mgr" />
						<input type="hidden" id="branch_no" name="branch_no" />
						<input type="hidden" id="sys_equip_code" name="sys_equip_code" />
						<input type="hidden" id="mode" name="mode" />
						<table summary="지점정보">
						<caption>지점정보</caption>
						<colgroup>
							<col width="13%" />
							<col width="26%" />
							<col width="13%" />
							<col width="22%" />
							<col width="13%" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">시스템(*)</th>
								<td style="text-align:left;padding-left:5px;">
									<input type="text" id="sys_name" name="sys_name" readonly="readonly" onclick="javascript:getSysinfoList()" style="background-color:#f2f2f2;"/>
									<input type="button" id="btnSysSearch" name="btnSysSearch" value="검색" class="btn btn_search" onclick="javascript:getSysinfoList();" alt="검색"/>
								</td>
								<th scope="row">사업장명(*)</th>
								<td style="text-align:left;padding-left:5px;">
									<input type="text" id="fact_name" name="fact_name" readonly="readonly" onclick="javascript:getFactinfoList()" style="background-color:#f2f2f2;"/>
									<input type="button" id="btnFactSearch" name="btnFactSearch" value="검색" class="btn btn_search" onclick="javascript:getFactinfoList();" alt="검색"/>
								</td>
								<th scope="row">사업장 코드(*)</th>
								<td style="text-align:left;padding-left:5px;">
									<input type="text" id="fact_code" name="fact_code" readonly="readonly" style="background-color:#f2f2f2;" size="19"/>
								</td>
							</tr>
							<tr>
								<th scope="row">측정소명(*)</th>
								<td colspan="3" style="text-align:left;padding-left:5px;">
									<input type="text" id="branch_name" name="branch_name" style="width:250px; "/>
								</td>
								<th scope="row">사용여부(*)</th>
								<td style="text-align:left;padding-left:5px;">
									<select name="branch_use_flag" id="branch_use_flag">
										<option value="Y">사용</option>
										<option value="N">미사용</option>
									</select>
								</td>
							</tr>
							<tr>
								<th scope="row" rowspan="2">측정소 위치</th>
								<td colspan="5" style="text-align:left;padding-left:5px;">
									<input type="text" id='fact_addr' name="fact_addr" style="width:548px; background-color:#f2f2f2;" readonly="readonly" />
									<input type="button" id="btnlonlat" name="btnlonlat" value="지도" class="btn btn_search" onclick="javascript:lon_lat();" alt="지도"/>
								</td>
							</tr>
							<tr>
								<td colspan="5" style="text-align:left;padding-left:5px;">
								위도(Y좌표):<input type="text" id="latitude1" name="latitude" style="width:200px;background-color:#f2f2f2;" readonly="readonly" />&nbsp;&nbsp;
								경도(X좌표):<input type="text" id="longitude1" name="longitude" style="width:200px;background-color:#f2f2f2;" readonly="readonly" />
								</td>
							</tr>
							<tr>
								<th scope="row">관리자명</th>
								<td style="text-align:left;padding-left:5px;">
									<input type="text" id="branch_mgr_name" name="branch_mgr_name" value="" style="width:80px;"/>
									(두글자 이상 입력)
									<input type="button" id="btnMemberSearch" name="btnMemberSearch" value="검색" class="btn btn_search" onclick="javascript:onSearch_member()" alt="검색"/>
								</td>
								<th scope="row">관리자전화번호</th>
								<td style="text-align:left;padding-left:5px;" colspan="3">
									<input type="text" id="branch_mgr_tel_no" name="branch_mgr_tel_no" value="" style="width:200px;background-color:#f2f2f2;" readonly="readonly" />
								</td>
<!-- 								<th scope="row">담당자</th> -->
<!-- 								<td style="text-align:left;padding-left:5px;"> -->
<!-- 									<input type="button" id="btnMemberDive" name="btnMemberDive" value="담당자 등록" class="btn btn_search" onclick="javascript:memberDiv();" alt="담당자 등록"/> -->
<!-- 								</td> -->
							</tr>
<!-- 							<tr> -->
<!-- 								<th scope="row">담당자 명단</th> -->
<!-- 								<td colspan="5"> -->
<!-- 									<span id="memList"></span> -->
<!-- 								</td> -->
<!-- 							</tr> -->
						</tbody>
						</table>
						</form>
						<div style="padding-top:10px;">
							<input type="button" id="btnSave" value="저장" class="btn btn_basic" style="float:right" alt="저장" onclick="javascript:updateFactBranch('reg');"/>
							<input type="button" id="btnCancel" value="취소" class="btn btn_basic" style="float:right" alt="취소" onclick="javascript:fnList();"/>
						</div>
					</div>
					</div>
				</div>
				<!--tab Contnet End-->
			</div>
		</div>
		<!-- Body End-->
		
		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
	</div>
	<!--시스템 장비 검색 레이어-->
	<div id="sysinfoLayer" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnSysInfoXbox" name="btnSysInfoXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('sysinfoLayer');" alt="닫기"/>
		</div>
		<div style="background:#fff;text-align:right; padding-top:5px; padding-bottom:5px; padding-right:18px;">
			시스템 : 
			<select name="search_sys_kind">
			<option value="U">IP_USN</option>
			<option value="A">국가수질자동측정망</option>
			<option value="W">방류수질정보</option>
			</select>
			<input type="button" id="btnPopSysSearch" name="btnPopSysSearch" value="검색" class="btn btn_search" onclick="javascript:getSysinfoList();" alt="검색"/>
		</div>
		<div style="width:500px; height:300px;overflow-x:hidden;overflow-y:scroll;">
			<table>
				<col width='45' />
				<col width='110' />
				<col width='110' />
				<col width='110' />
				<col width='125' />
				<thead>
					<tr>
						<th scope='col'>NO</th>
						<th scope='col'>시스템</th>
						<th scope='col'>장비코드</th>
						<th scope='col'>제조사</th>
						<th scope='col'>모델명</th>
					</tr>
				</thead>
				<tbody id="sysDataList">
				</tbody>
			</table>
		</div>
		<br/>
		<center>
			<span style="color:#fff;">장비코드 : </span>
			<input type="text" id="searchSysKeyword" name="searchSysKeyword" style="width:200px;"/>
			<input type="button" id="btnPopSysSearch" name="btnPopSysSearch" value="검색" class="btn btn_search" onclick="javascript:getSysinfoList();" alt="검색"/>
			<input type="button" id="btnPopSysReg" name="btnPopSysReg" value="장비등록" class="btn btn_search" onclick="javascript:getEquipInfoReg();" alt="장비등록"/>
		</center>
	</div>
	<!--//시스템 장비 검색 레이어-->
	<!--측정소 검색 레이어-->
	<div id="factinfoLayer" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnFactInfoXbox" name="btnFactInfoXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('factinfoLayer');" alt="닫기"/>
		</div>
		<div style="width:500px; height:300px;overflow-x:hidden;overflow-y:scroll;">
			<table>
				<col width='45' />
				<col width='200' />
				<col width='255' />
				<thead>
					<tr>
						<th scope='col'>NO</th>
						<th scope='col'>사업장코드 </th>
						<th scope='col'>사업장명</th>
					</tr>
				</thead>
				<tbody id="dataList1">
				</tbody>
			</table>
		</div>
		<br/>
		<center>
			<select id="searchCondition" name="searchCondition">
				<option value="name">사업장명</option>
				<option value="code">사업장 코드</option>
			</select>
			<input type="text" id="searchKeyword" name="searchKeyword" style="width:100px;"/>
			
			<input type="button" id="btnPopFactSearch" name="btnPopFactSearch" value="검색" class="btn btn_search" onclick="javascript:getFactinfoList();" alt="검색"/>
		</center>
	</div>
	<!--//측정소 검색 레이어-->
	<!--//담당자 검색 레이어-->
	<div id="layerMember" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnMemXbox" name="btnMemXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerMember');" alt="닫기"/>
		</div>
		<div class="fixed-table-container-inner" style="height:200px">
			<table summary="사용자정보">
				<caption>사용자정보</caption>
				<colgroup>
					<col width="100px" />
					<col width="100px" />
					<col width="100px" />
				</colgroup>
				<thead>
					<tr>
						<th scope="col">아이디</th>
						<th scope="col">이름</th>
						<th scope="col">선택</th>
					</tr>
				</thead>
				<tbody id="MemberList"></tbody>
			</table>
		</div>
		<div id="btCarea">
			<input type="text" id="memIdSearchTxt" name="memIdSearchTxt" style="width:100px;" onkeydown="javascript: if(event.keyCode == 13) {memberDiv();}" title="검색"/>
			<input type="button" id="btnMemberSearch" name="btnMemberSearch" value="검색" class="btn btn_search" onclick="javascript:memberDiv();" alt="검색"/>
		</div>
	</div>
	<!--//담당자 검색 레이어-->
	<!--장비등록 레이어-->
	<div id="layerEquipInfoReg" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnEquipInfoRegXbox" name="btnEquipInfoRegXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerEquipInfoReg');" alt="닫기"/>
		</div>
		<form id="equipInfoRegForm" name="equipInfoRegForm" action="/spotmanage/saveEquipInfoReg.do" method="post">
		
			<table summary="장비등록">
				<caption>장비등록</caption>
				<colgroup>
					<col width="120px" />
					<col />
				</colgroup>
				<tbody>
					<tr>
						<th>시스템</th>
						<td>
							<select name="e_sys_kind">
								<option value="U">IP_USN</option>
								<option value="A">국가수질자동측정망</option>
								<option value="W">방류수질정보</option>
							</select>
						</td>
					</tr>
					<tr>
						<th>장비코드</th>
						<td><input type="text" name="equip_code" maxlength="10" /></td>
					</tr>
					<tr>
						<th>제조사</th>
						<td>
							<input type="text" name="equip_maker" maxlength="10" />
						</td>
					</tr>
					<tr>
						<th>모델명</th>
						<td>
							<input type="text" name="equip_name" maxlength="10" />
						</td>
					</tr>
				</tbody>
			</table>
		</form>
		<div id="btCarea">
			<input type="button" id="btnSaveEquipInfoReg" name="btnSaveEquipInfoReg" value="저장" class="btn btn_white" onclick="javascript:saveEquipInfoReg();" alt="저장"/>
		</div>
	</div>
	<!--//장비등록 레이어-->
	<!--관리자 검색 레이어-->
	<div id="memberLayer" class="divPopup" style="margin-top:50px;">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnMemberXbox" name="btnMemberXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('memberLayer');" alt="닫기"/>
		</div>
		<table style="width:500px; text-align:center;">
			<col width='45' />
			<col width='185' />
			<col width='150' />
			<col width='120' />
			<thead>
				<tr>
					<th scope='col'>NO          </th>
					<th scope='col'>부서    </th>
					<th scope='col'>직급</th>
					<th scope='col'>성명        </th>
				</tr>
			</thead>
			<tbody id="dataList2">
			</tbody>
		</table>
	</div>
	<!--//관리자 검색 레이어-->
</body>
</html>