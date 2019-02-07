<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/** 
	 * Class Name : wareHouseRegistPopup.jsp
	 * Description : 창고현황  등록 /수정
	 * Modification Information
	 * 
	 * 수정일			 수정자		 수정내용
	 * -------		--------	---------------------------
	 * 2013.11.13	정승진			 최초 생성
	 *
	 * author 정승진
	 * since 2013.11.13
	 *
	 * Copyright (C) 2013 by lkh All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<title>한국환경공단 수질오염 방제정보 시스템</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/com.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/smcube/tab.css' />" />

<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
<c:import url="/WEB-INF/jsp/include/common/include_authUserPopup.jsp" />	<!-- 로그인 여부 -->
<script type="text/javascript" src="<c:url value='/js/JQuery/jquery.form.js'/>"></script>
<script type="text/javascript" src="http://js.arcgis.com/3.8/"></script>
<script src="/gis/js/define.js"></script>
<script type="text/javascript" src="<c:url value='/gis/js/editMap.js'/>"></script>

<script type="text/javaScript">

	var dicReqParam = {};
	$(function () {
		
		mode = $('#mode', opener.document).val();
	
		//수계선택
		$('#selectRiverDiv').change(function(){
			
			if($("#selectRiverDiv option:selected").text() != "선택"){
				//appendWareHouseCode();
			}
			
		});
		//운영기관
		$('#selectUpperDeptOp').change(function(){
			
			if($('#selectLocation option:selected').text() != "선택"){
				
				getDeptCode(0);
			}
		});
		
		//관리주체 
		$('#selectUpperDeptMgr').change(function(){
		
		if($('#selectLocation option:selected').text() != "선택"){
			
				getDeptCode(1);
			}
		});
		
		$('#selectCtyCode').change(function(){
			
			if($('#selectCtyCode option:selected').text() != "선택"){
				
				//appendWareHouseCode();
			}
		});
		$('#searchResult').hide();
		displayMode(mode);
		
	});
	
	function requestSearchMember(searchKey){
		
		if(searchKey.length < 2){
			alert("2자리 이상 검색 가능 합니다.");
		}
		else{
			$.ajax({
				type : "POST",
				url : "<c:url value='/warehouse/getSearchMember.do'/>",
				data : {
					searchKeyword:searchKey,
					searchCondition:'name'
				},
				dataType : "json",
				beforeSend : function() {
				},
				success : function(result) {
					dispSearchTable(result["list"]);
				}
			});
		}
	}
	
	// 신규 , 수정 초기 설정 
	function displayMode(mode){
	
		if(mode == 'regist'){
			getUpperDeptCode();
			getCtyCode();
			//getMaxWareHouseCode();
			getWareHouseCodeNo();
			getRiverCode();
			$('#txtWareHouseCode').attr("disabled", true);
			$('#inOutTitle').html('창고등록');
			$('#btntitle').html('<em>등록</em>');
		}
		else{
			getUpperDeptCode();
			getCtyCode();
			getRiverCode();
			getWareHouseData($('#whCodePopup',opener.document).val() , initDispInModify);
			$('#inOutTitle').html('창고수정');
			$('#btntitle').html('<em>수정</em>');
			$('#deleteWH').show();
		}
		
	}
	
	//수정 일 경우 데이터 조회 
	function getWareHouseData(whCode,callbackfunc){
		//수계
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/getSearchWareHouseList.do'/>",
			data: { 
					whCode:whCode
				},
			dataType:"json",
			beforeSend : function(){},
			success : function(result){
					
				// 아이템 데이터 세팅	
				var tot = result['list'].length;
				
				if( tot <= 0 ){
					alert("관련 된 정보가 존재 하지 않습니다.");
				}else{
					
					callbackfunc(result['list'][0]);
				}
			}
		});
	}
	
	//수정 일 경우 초기 데이터 설정 
	function initDispInModify(obj){
		
		$('#selectRiverDiv').attr("disabled", false);
		$('#selectDeptOp').attr("disabled", false);
		$('#selectUpperDeptOp').attr("disabled", false);
		$('#selectDeptMgr').attr("disabled", false);
		$('#selectUpperDeptMgr').attr("disabled", false);
		$('#selectCtyCode').attr("disabled", false);
		$('#txtWareHouseCode').attr("disabled", true);
		
		//창고코드	
		$('#txtWareHouseCode').val(obj.whCode);
		//창고명 
		$('#txtWareHouseName').val(obj.whName);
		//수계 
		$('#selectRiverDiv').val(obj.riverDiv);
		
		//운영부서 
		$('#selectUpperDeptOp').val(obj.upperAdminDept);
		getDeptCodeSync(0);
		$('#selectDeptOp').val(obj.adminDept);
		
		//관리주체
		$('#selectUpperDeptMgr').val(obj.upperAdminDeptSub);
		getDeptCodeSync(1);
		$('#selectDeptMgr').val(obj.adminDeptSub);
		
		//지역 
		//$('#selectCtyCode').html("<option value='"+obj.ctyCode+"'>"+obj.ctyName+"</option>");
		$('#selectCtyCode').val(obj.ctyCode);
		
		//담당자 (정) txtSearch01
		$("#txtSearch01").val(obj.adminName);
		$("#memberIdF").val(obj.adminId);
		
		//담당자 (부) txtSearch02
		$("#txtSearch02").val(obj.adminNameSub);
		$("#memberIdS").val(obj.adminIdSub);
		
		//연락처 
		$("#txtPhoneNo").val(obj.adminTelno);
		
		//주소
		$("#txtAddr").val(obj.addr);
		
		//좌표 
		$("#txtLonLat").val(obj.lon +","+obj.lat);
		$('#latiude').val(obj.lat);
		$('#longitude').val(obj.lon);
		
		//사용여부 
		$("#selectUseflag > option[value="+obj.useFlag+"]").attr("selected", "true");
		
	}
	
	//담당자 검색  (정)
	function onSearch_frist(){
		
		$('#searchMode').val('SearchF');
		requestSearchMember($('#txtSearch01').val());
	}
	//담당자 검색  (부)
	function onSearch_second(){
		
		$('#searchMode').val('SearchS');
		requestSearchMember($('#txtSearch02').val());
	}
	
	function dispSearchTable(arrResult){
		var tot = arrResult.length;
		
		//$('#searchResult').show();
		$('#memberLayer').show();
		$("#searchResultList").html("");
		
		if(tot == 0){
			$("#searchResultList").html("<tr><td colspan='7'>조회 결과가 없습니다</td></td>");
		}
		else{
			var item = '';
			for(var i = 0 ; i < tot ; i++){
				
				var obj = arrResult[i];
				
				item = "<tr style='cursor:pointer;' onclick=javascript:onSelMember('"+obj.memberName +"','"+obj.memberId +"','"+ obj.mobileNo+"')>"
					+ "<td style='text-align: center;'>"+obj.deptName+"</td>"
					+ "<td style='text-align: center;'>"+obj.gradeName+"</td>"
					+ "<td style='text-align: center;'>"+obj.memberName+"</td>"
					+ "</tr>";
				
				$("#searchResultList").append(item);
				$('#searchResult tr:odd').addClass('add');
			}
		}
	}
	
	function onSelMember(memberName, memberId, mobileNo){
		
		//alert(memberName +" :" + memberId +" :" + mobileNo);
		var mode = $('#searchMode').val();
		if(mode == 'SearchF'){
			$('#txtSearch01').val(memberName);
			$('#txtPhoneNo').val(mobileNo);
			$('#memberIdF').val(memberId);
		}
		else if(mode == 'SearchS'){
			$('#txtSearch02').val(memberName);
			$('#memberIdS').val(memberId);
		}
		
		$("#searchResultList").html("");
		//$('#searchResult').hide();
		layerController("member");
	}
	
	//창고 코드 생성 
	function appendWareHouseCode(){
		var ctycode = $("#selectCtyCode option:selected").val();
		
		if(ctycode == "undefined")
			ctycode = '';
		
		var rivercode = $("#selectRiverDiv option:selected").val().substring(1,3);
		
		$('#txtWareHouseCode').val("WH"+ rivercode +ctycode+wareHouseCode);
	}
	
	var wareHouseCode = '';
	//창고 순차 순번 가져오기 
	function getMaxWareHouseCode(){
		
		if(wareHouseCode == ''){
			
			$.ajax({
				type : "POST",
				url : "<c:url value='/warehouse/getMaxWareHouseCode.do'/>",
				data : {},
				dataType : "json",
				beforeSend : function() {
				},
				success : function(result) {
					
					var code = result["codes"];
					if (code == null) {
						wareHouseCode =  "001";
					} else {
						wareHouseCode = code;
					}
				}
			});
		}
	}
	
	function getWareHouseCodeNo(){
		wareHouseCode = $.now();
		$('#txtWareHouseCode').val("WH"+wareHouseCode);
	}
	
	
	//수계 
	function getRiverCode()
	{
		$.ajax({
			type : "POST",
			url : "<c:url value='/warehouse/getRiverCodeTwo.do'/>",
			data : {},
			dataType : "json",
			async: false,
			beforeSend : function() {},
			success : function(result) {
				
				var dropDownSet = $('#selectRiverDiv');
				dropDownSet.loadSelectWareHouse(result.codes, '선택', "RIVERCODE",'RIVERNAME');
				$('#selectRiverDiv').attr("disabled", false);
			}
		});
	}
	
	//운영기관,관리 주체 
	function getUpperDeptCode(){
		
		$.ajax({
			type : "POST",
			url : "<c:url value='/warehouse/getUpperDeptCode.do'/>",
			data : {},
			dataType : "json",
			async: false,
			beforeSend : function() {},
			success : function(result) {
				
				var dropDownSet = $('#selectUpperDeptOp');
				var dropDownSet02 =  $('#selectUpperDeptMgr');//
				
				dropDownSet.loadSelectWareHouse  (result.codes, '선택', "UPPERDEPTCODE",'UPPERDEPTNAME');
				dropDownSet02.loadSelectWareHouse(result.codes, '선택', "UPPERDEPTCODE",'UPPERDEPTNAME');
			}
		});
	}
	//운영부서/관리부서 
	function getDeptCode(type){
		
		var upperDeptCode = $("#selectUpperDeptOp option:selected").val();
		if(type == 1)
			upperDeptCode = $("#selectUpperDeptMgr option:selected").val();
		
		$.ajax({
			type : "POST",
			url : "<c:url value='/warehouse/getDeptCode.do'/>",
			data : {
				upperDeptCode:upperDeptCode
			},
			dataType : "json",
			beforeSend : function() {
			
			},
			success : function(result) {
				
				var list = new Array();
				if(result["codes"].length > 0)
					list = result["codes"];
				else
					list.push({"DEPTCODE":'', 'DEPTNAME':''});
				
				var dropDownSet = $('#selectDeptOp');
				if(type == 1)
					dropDownSet =  $('#selectDeptMgr');
					
				dropDownSet.loadSelectWareHouse(list, '선택', "DEPTCODE",'DEPTNAME');
			}
		});
	}

	function getDeptCodeSync(type){
		
		var upperDeptCode = $("#selectUpperDeptOp option:selected").val();
		if(type == 1)
			upperDeptCode = $("#selectUpperDeptMgr option:selected").val();
		
		$.ajax({
			type : "POST",
			url : "<c:url value='/warehouse/getDeptCode.do'/>",
			data : {
				upperDeptCode : upperDeptCode
			},
			dataType : "json",
			async: false,
			success : function(result) {
				
				var list = new Array();
				if(result["codes"].length > 0)
					list = result["codes"];
				else
					list.push({"DEPTCODE":'', 'DEPTNAME':''});
				
				var dropDownSet = $('#selectDeptOp');
				if(type == 1)
					dropDownSet =  $('#selectDeptMgr');
					
				dropDownSet.loadSelectWareHouse(list, '선택', "DEPTCODE",'DEPTNAME');
			}
		});
	}
	
	// 지역코드 불러오기
	function getCtyCode()
	{
		//alert('getCtyCode');
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/ctyCode.do'/>",
			data:{},
			dataType:"json",
			async: false,
			beforeSend:function(){
				$('#selectCtyCode').attr("disabled", true);
			},
			success:function(result){
				var dropDownSet = $('#selectCtyCode');
				dropDownSet.loadSelectWareHouse(result.codes, '선택', 'CTYCODE', 'CAPTION');
				$('#selectCtyCode').attr("disabled", false);
			}
		});
	}
	
	//좌표 지정 map open
	function onOpenMap(){
		window.open("<c:url value='/addrMap.jsp'/>",'popupMap','resizable=yes,scrollbars=yes,width=960,height=800');
	}
	
	// 좌표 및 주소 반영
	function applyLonLat(lon, lat, addr) {
		//txtLonLat txtAddr
		
		$('#latiude').val(lat);
		$('#longitude').val(lon);
		
		$('#txtLonLat').val(lon+" "+lat);
		$("#txtAddr").val(addr.replace('대한민국 ',''));
	}
	
	function vaildateItem(){
		
		//창고코드 
		var tempcode = $('#txtWareHouseCode').val();
		
		if(tempcode.length > 15){
			alert('창고코드가 잘 못 되었습니다.');
			return false;
		}
		//창고명 
		if($('#txtWareHouseName').val().length == 0){
			alert('창고명을 입력 해야 합니다.');
			return false;
		}
		
		//수계 
		if($("#selectRiverDiv option:selected").val().length == 0 || $("#selectRiverDiv option:selected").val() == '선택'){
			alert('수계를 선택 해야 합니다.');
			return false;
		}
		
		//운영기관
		if($("#selectDeptOp option:selected").val().length == 0 || $("#selectDeptOp option:selected").val() == '선택'){
			/*if($("#selectUpperDeptOp option:selected").val().length == 0 ||("#selectUpperDeptOp option:selected").val() == '선택'){
				alert('운영부서 혹은 운영기관를 선택 해야 합니다.');
				return false;
			}
			else{
				$('#deptOpCode').val($("#selectUpperDeptOp option:selected").val());
			}*/
			alert('운영기관을 선택 해야 합니다.');
			return false;
		}
		else{
			$('#deptOpCode').val($("#selectDeptOp option:selected").val());
		}
		//관리주체
		if($("#selectDeptMgr option:selected").val().length == 0 || $("#selectDeptMgr option:selected").val() == '선택'){
			/*if($("#selectUpperDeptMgr option:selected").val().length == 0 || $("#selectUpperDeptMgr option:selected").val() == '선택'){
				alert('관리부서 혹은 관리기관를 선택 해야 합니다.');
				return false;
			}else{
				$('#deptMgrCode').val($("#selectUpperDeptMgr option:selected").val());
			}*/
			alert('관리주체를 선택 해야 합니다.');
			return false;
		}else{
			$('#deptMgrCode').val($("#selectDeptMgr option:selected").val());
		}
		//ctycode 
		if($("#selectCtyCode option:selected").val().length == 0 || $("#selectCtyCode option:selected").val() == '선택'){
			alert('지역을 선택 해야 합니다.');
			return false;
		}
		
		//담당자 (정)
		if($("#memberIdF").val().length == 0){
			alert('담당자(정)을 검색 후 선택 해야 합니다.');
			return false;
		}
		
		//연락처 
		if($("#txtPhoneNo").val().length == 0){
			alert('연락처를 입력 해야 합니다.');
			return false;
		}
		
		//주소
		if($("#txtAddr").val().length == 0){
			alert('주소를 입력 해야 합니다.');
			return false;
		}
		
		//좌표 
		if($("#txtLonLat").val().length == 0){
			alert('좌표를 선택 해야 합니다.');
			return false;
		}
		
		//사용여부 
		if($("#selectUseflag option:selected").val().length == 0 || $("#selectUseflag option:selected").val() == '선택' ){
			alert('사용여부를 선택 해야 합니다.');
			return false;
		}
		return true;
	}
	
	var editMapObject = {};
	function saveAndUpage(callback){
		
		if(vaildateItem() == true){
			
			var mode = $('#mode', opener.document).val();
			//코드
			var whCode = $('#txtWareHouseCode').val();
			//창고
			var whName = $('#txtWareHouseName').val();
			//수계 
			var riverDiv = $("#selectRiverDiv option:selected").val();
			
			if(riverDiv == '선택')
				riverDiv = '';
			
			//운영기관 
			var adminDept = $('#deptOpCode').val();
			//관리주체 
			var adminDeptSub = $('#deptMgrCode').val();
			//지역 
			var ctycode = $("#selectCtyCode option:selected").val();
			
			if(ctycode == '선택')
				ctycode = '';
			
			//담당자(정)
			var adminName = $("#memberIdF").val();
			//담당자(부)
			var adminNameSub = $("#memberIdS").val();
			//연락처 
			var adminTelno = $("#txtPhoneNo").val();
			//주소 
			var addr = $("#txtAddr").val();
			//경도 
			var lon = $('#longitude').val();
			//위도
			var lat = $('#latiude').val();
			//사용여부 
			var useFlag = $("#selectUseflag option:selected").val();
			
			var pageNo = $("#pageNo").val(); 
			
			if (pageNo == null) pageNo = 1;
			
			// obj.WH_CODE = 창고코드
			// obj.WH_NAME = 창고명
			// obj.ADMIN_MGR = 관리자명
			// obj.ADMIN_TELN = 관리자 전화번호
			// obj.LON = 좌표(경도)
			// obj.LAT = 좌표(위도)
			// obj.USE_FLAG = Y  : default
			// obj.HOUSE_TYPE = W  : default
			
			editMapObject = {};
			editMapObject.WH_CODE = whCode;
			editMapObject.WH_NAME = whName;
			editMapObject.ADMIN_MGR = $('#txtSearch01').val(); 
			editMapObject.ADMIN_SUB_ = $('#txtSearch02').val();
			editMapObject.ADMIN_TELN = adminTelno;
			editMapObject.LON = lon;
			editMapObject.LAT = lat;
			editMapObject.USE_FLAG = useFlag;
			editMapObject.HOUSE_TYPE = 'W';
			
			$.ajax({
				type: "POST",
				url: "<c:url value='/warehouse/mergeWareHouse.do'/>",
				data: {
					whCode:whCode,
					whName:whName,
					riverDiv:riverDiv,
					adminDept:adminDept,
					adminDeptSub:adminDeptSub,
					ctyCode:ctycode,
					adminName:adminName,
					adminNameSub:adminNameSub,
					adminTelno:adminTelno,
					addr:addr,
					lon:lon,
					lat:lat,
					useFlag:useFlag
					},
				dataType:"json",
				beforeSend : function(){
					
					},
				success : function(result){
					
					callback(result);
				}
			});
		}
	}
	//t_warehouse 저장
	function onSave(){
		saveAndUpage(resultCallback);
	}
	
	function resultCallback(result){
		
		if (result.updateCnt == '1') {
			alert('반영되었습니다.');
			
			if($('#mode', opener.document).val() == 'regist'){
// 				console.log('[addWHPoint]' , editMapObject);
				$editMap.model.addWHPoint(editMapObject,editMapCallback);
			}
			else{
// 				console.log('updateWHPoint');
				$editMap.model.updateWHPoint(editMapObject,editMapCallback);
			}
			fnClosePopup();
			opener.dataLoad();
			
		} else {
			alert('반영되지 않았습니다.\n잠시후 다시 시도 해 보시기 바랍니다.');
		}
	}
	
	function onDelete(){
		var whCode = $('#txtWareHouseCode').val();
		
		if (confirm('삭제 후에는 입/출고 내역을 확인할 수 없습니다. \n재고가 있는 경우 삭제할 수 없습니다. 정말 삭제하시겠습니까?')) {
			
			showLoading();
			
			$.ajax({
				type: "POST",
				url: "<c:url value='/warehouse/deleteWareHouse.do'/>",
				data: {
					whCode:whCode
					},
				dataType:"json",
				async: false,
				success : function(result){
					if(result.status == 'hasItem'){
						alert('재고가 있는 창고는 삭제할 수 없습니다. \n재고를 먼저 정리해주세요.');
					}else if(result.status == 'success'){
						alert('창고가 삭제되었습니다.');
					}else{
						alert('오류가 발생하였습니다. 다시 시도해주세요.');
					}
				},
				error : function(result){
					if(result.err != null && jQuery.trim(result.err) != ''){
						alert("시스템 오류 \n"+result.err);
					}
				}
			});
			
			closeLoading();
			fnClosePopup();
			opener.dataLoad();
		}
	}
	
	function editMapCallback(result){
		
// 		console.log('[editMapCallback]' , result);
		
		if(result.callbacktype == "N")
			alert("GIS 좌표 저장에 실패 했습니다.");
		
		//opener.location.reload();
		//opener.dataLoad();
		//fnClosePopup();
		//opener.dataLoad();
	}
	//취소 
	function fnClosePopup(){
		self.close();
	}
	
	/** 레이어 열기,닫기등 처리
	* 파라미터 값으로 던진 레이어ID의 Display속성이 none이면 block으로 변경하고 block이면 none으로 변경 
	* 파라미터 값이 없으면 모든 divPopup 클래스의 레이어를 none처리
	* 사용할 레이어 ID는 [layerName]Layer 형식
	*/
	function layerController(layer){
		if(layer==null || layer==""){
			$("[class=divPopup]").css({"display":"none"});
			return false;
		}
		
		var divId = "#"+layer+"Layer";
		var divObj = $(divId);
		var divDis = divObj.css("display");
		
		if(divDis == "none"){
			var cssWHLT = ["100px","30px","c","m"];//WH사용안함, LT의 경우 c,m일때 가운데 정렬
			//레이어별 위치값 설정 시작
			//위치 세부 설정, Div 전환, a태그의 style을 변경을 위해
			if(layer == "factinfo"){
				$("#fact_code").blur();
				cssWHLT[2] = $("#tab_1_1").position().left;
				cssWHLT[3] = $("#tab_1_1").position().top;
			}
			//레이어 가운데 정렬
			if(cssWHLT[2]=="c")cssWHLT[2] = parseInt(($(window).width()/2)-(divObj.width()/2),10);
			if(cssWHLT[3]=="m")cssWHLT[3] = parseInt(($(window).height()/2)-(divObj.height()/2),10);
			//레이어별 위치값 설정 끝
			
			$("[class=divPopup]").css({"display":"none"});//해당 레이어 열기전 모든 레이어 닫기
			divObj.css("display","block");
			divObj.css({"left":cssWHLT[2],"top":cssWHLT[3]});
			$(divId+" tbody").html("");
			$(divId+" input").val("");
			$(divId+" textarea").val("");
			
			//레이어별 포커스 설정 시작
			//if(layer == "factinfo") $("#factinfoFrm [name=fact_code]").focus();
			//레이어별 포커스 설정 끝
			return true;
		}else{
			divObj.css("display","none");
		}
		return false;
	}
</script>
</head>

<body style="overflow-x:hidden;overflow-y:hidden;background-image: none;">
	<div id='loadingDiv' style="visibility:hidden;position:absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="" />
	</div>
	<div id="wrap" style="padding:10px;width:95%">
		<div id="container">
			
			<!-- Contents Begin Here -->
			<div id="content" class="sub_waterpolmnt" style="padding:0px;width:100%;">
				<div class="content_wrap page_alarmmng">
					<div class="con_tit_wrap">
						<h3><span id="inOutTitle">창고등록</span></h3>
					</div>
				</div>
				
				<div class="listView_write" style="padding:0px;width:100%;">
					<div class="popup_situReceive" style=" padding:15px 0; border:2px solid #2f8bc0; border-width:2px 0;">
						<fieldset class="first">
							<div class="tabDisplayArea"></div>
							<form id="hiddenForm" name="hiddenForm" method="post" >
								<input type="hidden" id="searchMode" name="mode" />
								<input type="hidden" id="memberIdF" name="mode" />
								<input type="hidden" id="memberIdS" name="mode" />
								<input type="hidden" id="longitude" name="mode" />
								<input type="hidden" id="latiude" name="mode" />
								<input type="hidden" id="deptOpCode" name="mode" />
								<input type="hidden" id="deptMgrCode" name="mode" />
								
								<table class="dataTable" style="width:100%; float:left;">
									<colgroup>
										<col width="120px"></col>
										<col></col>
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">창고코드</th>
											<td>
												<input type="text" id='txtWareHouseCode' name="txtWareHouseCode" value="" style="width:380px" readonly="readonly"/>
											</td>
										</tr>
										<tr>
											<th scope="row">창고명</th>
											<td>
												<input type="text" id="txtWareHouseName" name="txtWareHouseName" value="" style="width:380px"/>
											</td>
										</tr>
										<tr>
											<th scope="row">수계</th>
											<td>
												<select id="selectRiverDiv" name="selectRiverDiv" style="width:380px"></select>
											</td>
										</tr>
										<tr>
											<th scope="row">운영기관</th>
											<td>
												<select id="selectUpperDeptOp" style="width:188px">
													<option value="">선택</option>
												</select>&nbsp;
												<select id="selectDeptOp" style="width:188px">
													<option value="">선택</option>
												</select>
											</td>
										</tr>
										<tr>
											<th scope="row">관리주체</th>
											<td>
												<select id="selectUpperDeptMgr" style="width:188px">
													<option value="">선택</option>
												</select>&nbsp;
												<select id="selectDeptMgr" style="width:188px">
													<option value="">선택</option>
												</select>
											</td>
										</tr>
										<tr>
											<th scope="row">지역</th>
											<td>
												<select id="selectCtyCode" name="selectCtyCode" style="width:380px"></select>
											</td>
										</tr>
										<tr>
											<th scope="row">담당자(정)</th>
											<td>
												<input type="text" id="txtSearch01" name="txtSearch01" value="" style="width:210px"/>
												(두글자 이상 입력)
												<a onclick="javascript:onSearch_frist();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>조회</em></span></a>
											</td>
										</tr>
										<tr>
											<th scope="row">담당자(부)</th>
											<td>
												<input type="text" id="txtSearch02" name="txtSearch02" value="" style="width:210px"/>
												(두글자 이상 입력)
												<a onclick="javascript:onSearch_second();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>조회</em></span></a>
											</td>
										</tr>
										<tr>
											<th scope="row">연락처</th>
											<td><input type="text" id="txtPhoneNo" name="txtPhoneNo" value="" style="width:380px;background-color:#f2f2f2;" readonly="readonly"/></td>
										</tr>
										<tr>
											<th scope="row">주소</th>
											<td><input type="text" id="txtAddr" name="txtAddr" value="" style="width:380px;background-color:#f2f2f2;" readonly="readonly"/></td>
										</tr>
										<tr>
											<th scope="row">좌표</th>
											<td><input type="text" id="txtLonLat" name="txtLonLat" value="" style="width:295px;background-color:#f2f2f2;" readonly="readonly"/>
												<a onclick="javascript:onOpenMap();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>좌표선택</em></span></a>
											</td>
										</tr>
										<tr>
											<th scope="row">사용여부</th>
											<td>
												<select name="selectUseflag" id="selectUseflag" style="width:380px">
													<option value="Y">사용</option>
													<option value="N">미사용</option>
												</select>
											</td>
										</tr>
									</tbody>
								</table>
							</form>
							<div style="float:right;margin:20px 0px;">
								<a onclick="javascript:onSave();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span id="btntitle"><em>등록</em></span></a>&nbsp;
								<a onclick="javascript:onDelete();" style="selector-dummy:expression(this.hideFocus=false);display:none;" class="btn_mng" id="deleteWH"><span><em>삭제</em></span></a>&nbsp;
								<a onclick="javascript:window.close();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>닫기</em></span></a>
							</div>
						</fieldset>
					</div>
				</div>
			</div><!-- //content -->
			
	<!--레이어-->
	<div id="memberLayer" class="divPopup" style="margin-top:50px;">
		<table class="dataTable" style="width:100% !important;" summary="사용자정보">
			<colgroup>
				<col width="200px" />
				<col width="150px" />
				<col width="150px" />
			</colgroup>
			<thead>
			<tr>
				<th>관련기관</th>
				<th>직급</th>
				<th>성명</th>
			</tr>
			</thead>
		</table>
		<div style="border:0px solid #CCC !important;  overflow:auto; width:504px; height:400px; margin-top:0px; ">
			<table class="dataTable" style="width:100%;padding:7px;" summary="사용자정보데이터">
				<colgroup>
					<col width="200px" />
					<col width="150px" />
					<col width="150px" />
				</colgroup>
				<tbody id="searchResultList">
				</tbody>
			</table>
		</div>
	</div>
	<!--//레이어-->
	
		</div><!-- //Contents End Here -->
	</div><!-- //wrap -->
</body>
</html>