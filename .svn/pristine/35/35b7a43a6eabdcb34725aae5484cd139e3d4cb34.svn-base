<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : wareHouseList.jsp
	 * Description : 방제물품 창고관리 목록 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * ----------	--------	---------------------------
	 * 2012.11.07	윤일권			최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 * 
	 * author 윤일권 
	 * since 2012.11.07
	 * 
	 * Copyright (C) 2012by 윤일권  All right reserved.
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
	var options = {
				enableColumnReorder: false,
				multiColumnSort: false,
				enableCellNavigation: true
	}
	var whNames = new Array();
	
	$(function () {
		//수계
		getRiverCode();
		//운영기관 
		getDeptCode();
		//관리주체
		getDeptSubCode();
		//지역코드 가져오기
		//getCtyCode();
		getDoCode();
		//창고목록
		getWHNames();
		
		getItemCode(0);
		getItemCode(1);
		
		$('#selectRiverDiv').change(function(){
			getWHNames();
			getItemCodeInWH();
		});
		
		$('#selectDept').change(function(){
			getWHNames();
			getItemCodeInWH();
		});
		
		$('#selectDeptSub').change(function(){
			getWHNames();
			getItemCodeInWH();
		});
		
		$('#selectDoCode').change(function(){
			getWHNames();
			getItemCodeInWH();
		});
		
		$('#selectWareHouseName').change(function(){
			getItemCodeInWH();
		});
		
		/* 대분류 중분류 삭제 2016.12.22 KANG JI NAM
		//대분류
		getUpperGroupCode();
		
		//창고현황 대분류 선택
		$('#selectUpperGroupCodeW').change(function() {
			
			if ($("#selectUpperGroupCodeW option:selected").text() != "대분류") {
				getGroupCode(0);
			}
		});
		
		//재고현황 대분류 선택
		$('#selectUpperGroupCodeS').change(function() {
			
			if ($("#selectUpperGroupCodeS option:selected").text() != "대분류") {
				getGroupCode(1);
			}
		});
		
		//창고현황 중분류 
		$('#selectGroupCodeW').change(function(){
			
			if ($("#selectGroupCodeW option:selected").text() != "중분류") {
				getItemCode(0);
			}
		});
		
		//재고현황 중분류 
		$('#selectGroupCodeS').change(function(){
			
			if ($("#selectGroupCodeS option:selected").text() != "중분류") {
				getItemCode(1);
			}
		});
		*/
		
		// 목록 데이터 가져오기
		dataLoad();
		
	});
	
	var listRiver = new Array();
	
	//수계 
	function getRiverCode(){
		
		$.ajax({
			type : "POST",
			url : "<c:url value='/warehouse/getRiverCodeTwo.do'/>",
			data : {},
			dataType : "json",
			beforeSend : function() {},
			success : function(result) {
				listRiver= [];
				listRiver=result['codes'];
				var dropDownSet = $('#selectRiverDiv');
				dropDownSet.loadSelectWareHouse(result.codes, '수계', "RIVERCODE",'RIVERNAME');
				$('#selectRiverDiv').attr("disabled", false);
				
				selectedSugyeInMemberId(user_riverid , 'selectRiverDiv');
			}
		});
	}
	
	//운영기관
	function getDeptCode(){
		
		$.ajax({
			type : "POST",
			url : "<c:url value='/warehouse/getDeptCode.do'/>",
			data : {
				
				upperDeptCode:''
			},
			dataType : "json",
			beforeSend : function() {},
			success : function(result) {
				
				var dropDownSet = $('#selectDept');
				dropDownSet.loadSelectWareHouse(result.codes, '담당부서', "DEPTCODE",'DEPTNAME');
			}
		});
	}
	//관리주체
	function getDeptSubCode(){
		
		$.ajax({
			type : "POST",
			url : "<c:url value='/warehouse/getDeptCode.do'/>",
			data : {
				
				upperDeptCode:''
			},
			dataType : "json",
			beforeSend : function() {},
			success : function(result) {
				
				var dropDownSet = $('#selectDeptSub');
				dropDownSet.loadSelectWareHouse(result.codes, '담당부서', "DEPTCODE",'DEPTNAME');
			}
		});
	}
	
	// 지역코드 불러오기
	function getCtyCode(){
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/ctyCode.do'/>",
			data:{},
			dataType:"json",
			beforeSend:function(){
				$('#selectCtyCode').attr("disabled", true);	
			},
			success:function(result){
				var dropDownSet = $('#selectCtyCode');
				dropDownSet.loadSelectWareHouse(result.codes, '지역코드', 'CTYCODE', 'CAPTION');
				$('#selectCtyCode').attr("disabled", false);
			}
		});
	}
	
	function getDoCode(){
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/doCode.do'/>",
			data:{},
			dataType:"json",
			beforeSend:function(){
				$('#selectDoCode').attr("disabled", true);	
			},
			success:function(result){
				var dropDownSet = $('#selectDoCode');
				dropDownSet.loadSelectWareHouse(result.codes, '지역코드', 'DOCODE', 'CAPTION');
				$('#selectDoCode').attr("disabled", false);
			}
		});
	}
	
	//창고명 
	function getWHNames(){
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/selectWareHouseList.do'/>",
			data:{
				riverDiv : $('#selectRiverDiv').val(),
				adminDept : $('#selectDept').val(),
				adminDeptSub : $('#selectDeptSub').val(),
				doCode : $('#selectDoCode').val()
			},
			dataType:"json",
			beforeSend:function(){
				$('#selectWareHouseName').attr("disabled", true);	
			},
			success:function(result){

				if (result.list == ''){
					$('#selectWareHouseName').html("<option value=''>창고명</option>");
					$('#selectWareHouseName').attr("disabled", false);
				}else {
					var dropDownSet = $('#selectWareHouseName');
					dropDownSet.loadSelectWareHouse(result.list, '창고명', 'whCode', 'whName');
					$('#selectWareHouseName').attr("disabled", false);
				}
			}
		});
		
		/*
		var dropDownSet = $('#selectWareHouseName');
		dropDownSet.loadSelectWareHouse(whNames, '창고명', 'whCode' , 'whName');
		$('#selectWareHouseName').attr("disabled", false);
		*/
	}
	
	/* 대분류 중분류 삭제 2016.12.22 KANG JI NAM
	//대분류 코드 불러오기
	function getUpperGroupCode(){
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/itemManageUpperGroupCode.do'/>",
			data:{},
			dataType:"json",
			beforeSend:function(){
				//$('#popupUpperGroupCode').attr("disabled", true);
			},
			success:function(result){
				
				if (result.codes == ''){
					$('#selectUpperGroupCodeW').html("<option value=''>대분류</option>");
					$('#selectUpperGroupCodeS').html("<option value=''>대분류</option>");
				}
				else {
					var dropDownSetW = $('#selectUpperGroupCodeW');
					var dropDownSetS = $('#selectUpperGroupCodeS');
					
					dropDownSetW.loadSelectWareHouse(result.codes, '대분류', "VALUE", 'CAPTION');
					dropDownSetS.loadSelectWareHouse(result.codes, '대분류', "VALUE", 'CAPTION');
					
					$('#selectUpperGroupCodeW').attr("disabled", false);
					$('#selectUpperGroupCodeS').attr("disabled", false);
				}
			}
		});
	}
	
	//중분류 코드  불러오기 
	//ntype 0:창고현황 1:재고현황 
	function getGroupCode(ntype) {
		var upperGroupCode = $("#selectUpperGroupCodeW option:selected").val();
		if(ntype == 1)
			upperGroupCode = $("#selectUpperGroupCodeS option:selected").val();
			
		if (upperGroupCode == '') {
			if(ntype == 0)
				$('#selectGroupCodeW').html("<option value=''>중분류</option>");
			else
				$('#selectGroupCodeS').html("<option value=''>중분류</option>");
			
		} else {
			$.ajax({
				type : "POST",
				url : "<c:url value='/warehouse/itemManageGroupCode.do'/>",
				data : {
					upperGroupCode : upperGroupCode
				},
				dataType : "json",
				beforeSend : function() {},
				success : function(result) {
					
					if (result.codes == ''){
						
						if(ntype == 0)
							$('#selectGroupCodeW').html("<option value=''>중분류</option>");
						else
							$('#selectGroupCodeS').html("<option value=''>중분류</option>");
					}
					else {
						var dropDownSet = $('#selectGroupCodeW');
						
						if(ntype == 1)
							dropDownSet = $('#selectGroupCodeS');
						
						dropDownSet.loadSelectWareHouse(result.codes, '중분류','VALUE', 'CAPTION');
						
						
						dropDownSet.attr("disabled", false);
					}
				}
			});
		}
	}
	*/
	
	//물품 코드 불러오기
	//ntype =1 : 재고 현황 , 0 : 창고현황
	function getItemCode(ntype){
		/* 대분류 중분류 삭제 2016.12.22 KANG JI NAM
		var groupCode = $("#selectGroupCodeW option:selected").val();
		if(ntype == 1)
			groupCode = $("#selectGroupCodeS option:selected").val();
		
		if(groupCode == ''){
			
			if(ntype == 1)
				$('#selectItemCodeS').html("<option value=''>물품명</option>");
			else
				$('#selectItemCodeW').html("<option value=''>물품명</option>");
			
		}else{
		}*/
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/itemConditionCode.do'/>",
			data:{},
			dataType:"json",
			beforeSend:function(){},
			success:function(result){
				
				if (result.codes == ''){
					if(ntype == 0)
						$('#selectItemCodeW').html("<option value=''>물품명</option>");
					else
						$('#selectItemCodeS').html("<option value=''>물품명</option>");
				}
					
				else {
					var dropDownSet = $('#selectItemCodeW');
					if(ntype == 1)
						dropDownSet = $('#selectItemCodeS');
					
					dropDownSet.loadSelectWareHouse(result.codes, '물품명', 'VALUE', 'CAPTION');
					dropDownSet.attr("disabled", false);
				}
			}
		});
	}
	
	//물품 코드 불러오기
	function getItemCodeInWH(){
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/itemCodeInWareHouse.do'/>",
			data:{
				riverDiv : $('#selectRiverDiv').val(),
				adminDept : $('#selectDept').val(),
				adminDeptSub : $('#selectDeptSub').val(),
				doCode : $('#selectDoCode').val(),
				whCode : $('#selectWareHouseName').val()
			},
			dataType:"json",
			beforeSend:function(){},
			success:function(result){
				
				if (result.codes == ''){
					$('#selectItemCodeW').html("<option value=''>물품명</option>");
					
				}else {
					var dropDownSet = $('#selectItemCodeW');
					
					dropDownSet.loadSelectWareHouse(result.codes, '물품명', 'VALUE', 'CAPTION');
					dropDownSet.attr("disabled", false);
				}
			}
		});
	}
	
	//수계명 검색 
	function getRiverName(rivercode){
		var riverName = rivercode;
		$.each( listRiver, function( key, value ) {
			// alert( key + ": " + value['RIVERCODE'] + ":" + value['RIVERNAME'] + ":" + rivercode);
			
			if(rivercode == value['RIVERCODE']){
//				alert( value['RIVERCODE'] + ":" + rivercode + ":" +value['RIVERNAME']);
				riverName =  value['RIVERNAME'];
			}
		});
		return riverName;
	}
	
	//member id to member name 
	//담당(정) 직원의 전화번호 가져오는 함수
	function getMemberName(nm, memberId , callBack){
		$('#memberName').val(memberId);
		//직원선택
		if(memberId != ''){
			var membrename = 'None';
			$.ajax({
				type:"POST",
				url:"<c:url value='/warehouse/getAdminTelNo.do'/>",
				data:{
					memberId : memberId},
				dataType:"json",
				beforeSend:function(){},
				success:function(result){
					callBack(nm, result['codes'][0]['memberName'])
				}
			});
		}
	}
	
	
	var listWHObject = new Array();
	// 데이터 목록 불러오기
	function dataLoad(pageNo){
		showLoading();
		
		// 창고 클릭 초기화
		$('#whCodeS').val("");
		
		//수계
		$('#mode').val('select');
		var riverDiv	= $("#selectRiverDiv option:selected").val();
		if(riverDiv == '수계')
			riverDiv='';
		
		var adminDept	= $("#selectDept option:selected").val();
		if (adminDept == '담당부서')
			adminDept = '';
		
		var adminDeptSub	= $("#selectDeptSub option:selected").val();
		if (adminDeptSub == '담당부서')
			adminDeptSub = '';
		
		
		//var ctyCode	= $("#selectCtyCode option:selected").val();
		//if (ctyCode == '지역코드')
		//	ctyCode = '';
		
		var doCode	= $("#selectDoCode option:selected").val();
		if (doCode == '지역코드')
			doCode = '';
		
		var whName		= $("#selectWareHouseName option:selected").text();
		if (whName == '창고명')
			whName = '';
		
		var itemCode	= $("#selectItemCodeW option:selected").val();
		if (itemCode == '물품명')
			itemCode = '';
		
		/* 대분류 중분류 삭제 2016.12.22 KANG JI NAM
		if(itemCode.length == 0){
			itemCode = $("#selectGroupCodeW option:selected").val();
			
			if (itemCode == '중분류')
				itemCode = '';
			
			if(itemCode.length == 0){
				itemCode = $("#selectUpperGroupCodeW option:selected").val();
				
				if (itemCode == '대분류')
					itemCode = '';
			}
		}
		*/
		var bWhNameRefresh = false;
		if(whName == '창고명')
			whName='';
		
		if(riverDiv.length == 0 && adminDept.length == 0 && doCode.length == 0 && whName.length == 0 && itemCode.length == 0){
			bWhNameRefresh = true;
			whNames=[];
		}
		
		if (pageNo == null) pageNo = 0;
		

		var itemCodeNum = "";
		if(itemCode != ""){
			itemCodeNum = itemCode.split('-')[1];
			itemCode = itemCode.split('-')[0];
		}
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/getSearchWareHouseList.do'/>",
			data: { 
					pageIndex:pageNo,
					riverDiv:riverDiv,
					adminDept:adminDept,
					adminDeptSub:adminDeptSub,
					doCode:doCode,
					whName:whName,
					itemCode:itemCode,
					itemCodeNum:itemCodeNum
				},	
			dataType:"json",
			success : function(result){
				//console.log("getSearchWareHouseList 결과 값 확인 : ",result);
				var tot = result['list'].length;
				var pageInfo = result['paginationInfo'];
				
				if( tot <= 0 ){
					$('#selectedWhName').val("");
					$("#dataList1").html("");
					$('#dataList').html("<tr><td colspan='8'>조회 결과가 없습니다.</td></tr>");
				}else{
					var item="";
					var menuAuthCnt = "";
					menuAuthCnt = menuAuth("U");
					for(var i=0; i < tot; i++){
						var obj = result['list'][i];
						
						
						trclass = "";
						if(i % 2 == 1) trclass = "class=\"even\"";
						var trNo = i+1;
						
						item += "<tr  "+trclass+" id='wtr"+trNo+"' class='tr"+i+"'  style='cursor:pointer;' onclick=\"clickTrEvent(this);clickItemList('"+obj.whCode+"','"+obj.whName+"'"+")\">"			                   	 
								+"<td><span>"+obj.num+"</span></td>"
		                 		+"<td>"+obj.whName+"</td>"
		                 		+"<td>"+obj.riverName+"</td>"
		                 		+"<td>"+obj.adminDeptName+"</td>"
		                 		+"<td>"+obj.adminName+"</td>"
		                 		+"<td>"+obj.adminTelno+"</td>"
		                 		+"<td>"+obj.useFlag+"</td>"
		                 		+"<td>";
		                if(user_roleCode == 'ROLE_ADMIN'){ 	
		                	if(menuAuthCnt == '1' ){
			                	item +="<input type='button' id='btnModifyW' name='btnModifyW' value='수정' class='btn btn_basic' onclick=javascript:onModifyW('"+obj.whCode+"') alt='수정' />";
		                	}
		                } 		
		                item +="</td>"
	                 		 	+"</tr>";
						
					}
					$('#selectedWhName').val("");
					$("#dataList1").html("");
              		$("#dataList").html(item);
              		$("#dataList tr:odd").attr("class","even");
					
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
				$('#dataList').html("<tr><td colspan='8'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
				
				closeLoading();
			}
		});
		
	}
	
	
	function clickTrEvent(trObj) {
		var tr = eval("document.getElementById(\"" + trObj.id + "\")");
		$(tr).parent().find("tr td").removeClass("tr_on");
		$(tr).find("td").addClass("tr_on");
	}
	
	
	var listStockObject = new Array();
	
	//재고 현황 데이터 로딩 
	function dataLoadStockList(){
		var whCode = $('#whCodeS').val();
		var itemCode = $("#selectItemCodeS option:selected").val();
		
		if(itemCode == '물품명')
			itemCode='';
		
		/* 대분류 중분류 삭제 2016.12.22 KANG JI NAM
		if(itemCode.length == 0){
			itemCode = $("#selectGroupCodeS option:selected").val();
			if(itemCode == '중분류')
				itemCode='';
			if(itemCode.length == 0){
				itemCode = $("#selectUpperGroupCodeS option:selected").val();
				if(itemCode == '대분류')
					itemCode='';
			}
		}
		*/
		
		if(whCode.length == 0){
			alert("창고 리스트에서 창고를 선택해야 합니다.");
			return false;
		}
		
		var itemCodeNum;
		if(itemCode != ""){
			itemCodeNum = itemCode.split('-')[1];
			itemCode = itemCode.split('-')[0];
		}
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/getSearchItemStockList.do'/>",
			data: { 
						itemCode:itemCode,
						itemCodeNum:itemCodeNum,
						whCode:whCode
				},	
			dataType:"json",
			success : function(result){
				var tot = result['list'].length;
				
				if( tot <= 0 ){
					$('#dataList1').html("<tr><td colspan='6'>조회 결과가 없습니다.</td></tr>");
				}else{
					var item="";
					var menuAuthCnt = menuAuth("C")
					
					
					for(var i=0; i < tot; i++){
						var obj = result['list'][i];
						
						
						
	                   	item += "<tr>"			                   	 
								+"<td class='num'><span>"+obj.num+"</span></td>"
		                 		+"<td>"+obj.itemName+"</td>"
		                 		+"<td>"+obj.itemCnt+"</td>"
		                 		+"<td>"+obj.inCnt+"</td>"
		                 		+"<td>"+obj.outCnt+"</td>"
		                 		+"<td>";
                 		if(menuAuthCnt == '1'){
               			item +="<input type='button' id='btnListIn' name='btnListIn' value='입고' class='btn btn_basic' style='z-index:5;' onclick=javascript:onStockListInOut('"+obj.itemCnt+"','in','" + obj.itemCode + "-" + obj.itemCodeNum + "') alt='입고' />	<input type='button' id='btnListOut' name='btnListOut' value='출고' class='btn btn_basic' style='z-index:5;' onclick=javascript:onStockListInOut('"+obj.itemCnt+"','out','" + obj.itemCode + "-" + obj.itemCodeNum + "') alt='출고' />";
                 		}
                 		item +"</td>"
                		 	+"</tr>";

	                 	$("#dataList1").html(item);

	              		$("#dataList1 tr:odd").attr("class","even");
						
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
				$('#dataList').html("<tr><td colspan='8'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></tr>");
				
				closeLoading();
			}
		});
	}
	
	function setMemName(nm, result){
		$("#"+nm).text(result);
	}
	
	// 공통 함수
	function changeBoolean(bool){
		var rtnVal = "N";
		if (bool == true) {
			rtnVal = "Y";
		}
		return rtnVal;
	}
	
	function checkUndefined(dest){
		
		if (typeof dest === "undefined") {
			return '';
		}
		return dest;
	}
	//action ...
	
	// 목록에서 클릭시 재고현황 
	function clickItemList(whCode, whName){
		$('#whCodeS').val(whCode);
		$('#whCodePopupS').val(whCode);
		$('#whNamePopupS').val(whName);
		
		$('#selectedWhName').val(whName);
		
		dataLoadStockList(0);
	}
	
	// 재고현황 리스트 선택 시 재고 이력 도출 
	function clickItemListS(index){
		$('#whCodePopupH').val(listStockObject[index].whCode);
		$('#itemCodePopupH').val(listStockObject[index].itemCode);
		
		window.open("<c:url value='/warehouse/wareHouseManageRegistPopup.do'/>", 
				'popupInOutHistory','width=550,height=400,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,left=100,top=50');
	}
	
	//창고 수정 
	function onModifyW(whCode){
		
		$('#mode').val('upate');
		$('#whCodePopup').val(whCode);
		
		window.open("<c:url value='/warehouse/wareHouseRegistModifyPopup.do'/>", 
				'popupWareHouseUpdate','width=550,height=600,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,left=100,top=50');
	}
	
	// 페이지 번호 클릭
	function linkPage(pageNo){
		dataLoad(pageNo);
	}
	
	//창고 검색 버튼 실행
	function onWareHouseSearch(){
		dataLoad();
	}
	
	//재고현황 popup
	function popup_stock(mode , modeRegUpdate,itemCode){
		
		var whcode = $('#whCodeS').val();
		
		if(whcode.length != ''){
			
			$('#mode').val(mode);
			$('#modeRegUpdate').val(modeRegUpdate);
			
			window.open("<c:url value='/warehouse/wareHouseStockRegistPopup.do'/>?itemCode="+itemCode,
					'popupWareHouseStockReg','width=550,height=570,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,left=100,top=50');
		}
		else{
			alert('창고를 선택 해야 합니다.');
		}
	}
	
	//재고현황 입고 버튼 실행 
	function onInWareHouse(){
		popup_stock('inReg','regist');
	}
	
	//재고현황 출고 버튼 실행 
	function onOutWareHouse(){
		popup_stock('outReg','regist');
	}
	
	//재고현황 검색 버튼 실행 
	function onSearchStockList(){
		dataLoadStockList(1);
	}
	
	//재고현황 리스트 입출고 버튼 실행 시
	function onStockListInOut(itemCnt,inOut,itemCode){
//		alert(nidx +":"+ inOut +":"+listStockObject[nidx].itemCode);
		
// 		$('#itemCodePopupS').val(listStockObject[nidx].itemCode);
		
		if(inOut == 'out'){
			if(itemCnt > 0)
				popup_stock('outReg','update',itemCode);
			else
				alert('재고가 부족 합니다.');
		}
		else{
			popup_stock('inReg','update',itemCode);
		}
	}
	
	//창고 등록 창
	function popup_wareHouseReg(mode) {
		$('#mode').val(mode);
		
		window.open("<c:url value='/warehouse/wareHouseRegistModifyPopup.do'/>", 
				'popupWareHouseReg','width=550,height=600,toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,left=100,top=50');
	}
	
	// 좌표 지정 팝업
	function lon_lat(){
		window.open("<c:url value='/addrMap.jsp'/>",'popupMap','resizable=yes,scrollbars=yes,width=960,height=800');
	}
	
	// 좌표 및 주소 반영
	function applyLonLat(lon, lat, addr) {
		$("#lon").val(lon);
		$("#lat").val(lat);
		$("#addr").val(addr.replace('한국 ',''));
	}
//]]>
</script>
</head>

<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="wrap">
		<form id="hiddenForm">
			<input type="hidden" id="mode" name="mode"/>
			<input type="hidden" id="modeRegUpdate" name="modeRegUpdate"/>
			<input type="hidden" id="whCodePopup" name="whCodePopup"/>
			<input type="hidden" id="whCodePopupS" name="whCodePopupS"/>
			<input type="hidden" id="whNamePopupS" name="whNamePopupS"/>
			<input type="hidden" id="whCodeS" name="whCodeS"/>
			<input type="hidden" id="itemCodePopupS" name="itemCodePopupS"/>
			<input type="hidden" id="whCodePopupH" name="whCodePopupS"/>
			<input type="hidden" id="itemCodePopupH" name="whNamePopupS"/>
		</form>
		
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
									<select id="selectRiverDiv" name="selectRiverDiv" style="">
										<option value="">수계</option>
									</select>
								</li>
								<li>
									<span class="fieldName">운영기관</span>
									<select id="selectDept" name="selectDept" style="width:100px">
										<option value="">담당부서</option>
									</select>
								</li>
								<li>
									<span class="fieldName">관리주체</span>
									<select id="selectDeptSub" name="selectDeptSub" style="width:100px">
										<option value="">담당부서</option>
									</select>
								</li>
								<li>
									<span class="fieldName">지역코드</span>
									<!-- <select id="selectCtyCode" name="selectCtyCode" style=""> -->
									<select id="selectDoCode" name="selectDoCode" style="width:100px">
										<option value="">지역코드</option>
									</select>
								</li>
								<li>
									<span class="fieldName">창고명</span>
									<select id="selectWareHouseName" name="selectWareHouseName" style="width:180px">
										<option value="">창고명</option>
									</select>
								</li>
								<!-- 대분류 중분류 삭제 2016.12.22 KANG JI NAM
								<li>
									<span class="fieldName">대분류</span>
									<select id="selectUpperGroupCodeW" name="selectUpperGroupCodeW" style="">
										<option value="">대분류</option>
									</select>
								</li>
								<li>
									<span class="fieldName">중분류</span>
									<select id="selectGroupCodeW" name="selectGroupCodeW" style="">
										<option value="">중분류</option>
									</select>
								</li>
								 -->
								<li>
									<span class="fieldName">물품명</span>
									<select id="selectItemCodeW" name="selectItemCodeW" style="width:180px">
										<option value="">물품명</option>
									</select>
								</li>
							</ul>
						</div>
						
						<div class="btnSearchDiv">
							<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:onWareHouseSearch();" alt="조회하기" style="float:right;"/>
						</div>
					<!--top Search Start-->
					<!--tab Contnet Start-->
					<div class="table_wrapper">
						<div style="text-align:left;">
						<span>창고현황</span>
						</div>
						<table summary="창고현황">
							<colgroup>
								<col width="60" />
								<col width="180" />
								<col />
								<col width="150" />
								<col width="110" />
								<col width="150" />
								<col width="100" />
								<col width="110" />
							</colgroup>
							<thead>
							<tr>
								<th scope="col">NO</th>
								<th scope="col">창고명</th>
								<th scope="col">수계</th>
								<th scope="col">운영기관</th>
								<th scope="col">담당자</th>
								<th scope="col">연락처</th>
								<th scope="col">사용여부</th>
								<th scope="col">선택</th>
							</tr>
							</thead>
							<tbody  id="dataList"></tbody>
						</table>
						<div id="menuAuth1"	>
						<div style="float:right;margin-top:5px;margin-bottom:10px;">
							<input type="button" id="btnReg" name="btnReg" value="등록" class="btn btn_basic" onclick='javascript:popup_wareHouseReg("regist")' alt="등록" />
						</div>
					</div>
					
				<!-- 재고 현환 시작  -->
					
					<div class="searchBox dataSearch">
						<ul>
						<!--
							<li>
								<b>재고현황</b>
							</li>
							-->
							
							<!-- 대분류 중분류 삭제 2016.12.22 KANG JI NAM
							<li>
								<span class="fieldName">대분류</span>
								<select id="selectUpperGroupCodeS" name="selectUpperGroupCodeS" style="">
									<option value="">대분류</option>
								</select>
							</li>
							<li>
								<span class="fieldName">중분류</span>
								<select id="selectGroupCodeS" name="selectGroupCodeS" style="">
									<option value="">중분류</option>
								</select>
							</li>
							 -->
							<li>
								<span class="fieldName">물품명</span>
								<select id="selectItemCodeS" name="selectItemCodeS" style="">
									<option value="">물품명</option>
								</select>
							</li>
						</ul>
					</div>
					<div class="btnSearchDiv">
						<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:onSearchStockList();" alt="조회하기" style="float:right;"/>
					</div>
					<!--top Search End-->
					
					<!--tab Contnet Start-->
					<div class="table_wrapper">
						<div style="text-align:left;">
						<span>재고현황: 
							<input type="text" size="50" id="selectedWhName" name="selectedWhName" readonly="readonly" style="color:red;border:none;border-right:1px; border-top:1px; boder-left:1px; boder-bottom:1px;"/>
						</span>
						</div>
						<table summary="재고현황">
							<colgroup>
								<col width="60" />
								<col width="180" />
								<col />
								<col width="150" />
								<col width="150" />
								<col width="110" />
							</colgroup>
							<thead>
							<tr>
								<th scope="col">NO</th>
								<th scope="col">물품명</th>
								<th scope="col">현재재고</th>
								<th scope="col">입고</th>
								<th scope="col">출고</th>
								<th scope="col">선택</th>
							</tr>
							</thead>
							<tbody  id="dataList1">
							<tr>
								<td colspan="6">창고현황에서 창고를 선택해 주세요.</td>
							</tr>
							</tbody>
						</table>
						<div id="menuAuth2"	>
							<div style="float:right;margin-top:5px;margin-bottom:5px;">
								<input type="button" id="inWareHoue" name="inWareHoue" value="신규입고" class="btn btn_basic" onclick="javascript:onInWareHouse()" alt="신규입고"/>
								<!-- <input type="button" id="outWareHouse" name="outWareHouse" value="출고" class="btn btn_basic" onclick="javascript:onOutWareHouse()" alt="출고"/> -->
							</div>
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
	
	if("1" == menuAuth("C")){
		$("#menuAuth1").show();
		$("#menuAuth2").show();
	}else{
		$("#menuAuth1").hide();
		$("#menuAuth2").hide();
	}
	
	</script>
</body>
</html>