<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : wareHouseStockRegistPopup.jsp
	 * Description : 재고입출고등록 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2013.11.16	jsj			최초 생성
	 * 
	 * author jsj
	 * since 2013.11.16
	 * version 1.0
	 * see
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
<link rel="stylesheet" type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" />

<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
<c:import url="/WEB-INF/jsp/include/common/include_authUserPopup.jsp" />	<!-- 로그인 여부 -->
<script type="text/javascript" src="<c:url value='/js/JQuery/jquery.form.js'/>"></script>

<script type="text/javaScript">
//<![CDATA[
	var dicReqParam = {};
	var retainCnt = 0;
	
	$(function(){ 
		dicReqParam['regId'] = "<sec:authentication property="principal.userVO.id"/>";
		//alert("id : " + dicReqParam['regId']);
		
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yymmdd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		
		$("#dateStock").datepicker({
			buttonText: '출동일'
		});
		
		var today = new Date(); 
		var todayStr = today.getFullYear()+ "/" + addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		var time = addzero(today.getHours()) + ":" + addzero(today.getMinutes());
		
		function addzero(n) {
			 return n < 10 ? "0" + n : n + "";
		}
		
		$("#dateStock").val(todayStr);
		
		/*	대분류 중분류 삭제 2016.12.22 KANG JI NAM
		//창고현황 대분류 선택
		$('#selectUpperGroupCode').change(function() {
			
			if ($("#selectUpperGroupCode option:selected").text() != "대분류") {
				getGroupCode();
			}
		});
		
		//창고현황 중분류 
		$('#selectGroupCode').change(function(){
			
			if ($("#selectGroupCode option:selected").text() != "중분류") {
				getItemCode( );
			}
		});
		*/
		
		//selectItemCode
		$('#selectItemCode').change(function(){
			
			if ($("#selectItemCode option:selected").text() != "물품명") {
				getItemStan($("#selectItemCode option:selected").val());
				
				getItemInOut($('#whCodePopupS', opener.document).val(),$("#selectItemCode option:selected").val() ,resultItemInOut);
			}
		});
		
		$("#txtItemCnt").keyup(function(event){
			if (!(event.keyCode >=37 && event.keyCode<=40)) {
				var inputVal = $(this).val();
				$(this).val(inputVal.replace(/[^0-9]/gi,''));
				
				//출고 일 경우 재고 수량이라 비교해서 해야 함 
				 if($('#mode', opener.document).val() == 'outReg'){
					var inputNum = parseInt( $(this).val());
					
					if( retainCnt < inputNum ){
						alert('재고수량 보다 작게 입력 해야 합니다.');
						$(this).val('0');
					}
				}
			}
		});
		display($('#mode', opener.document).val() , $('#modeRegUpdate', opener.document).val());
		//display(opener.document.getElementById("mode").value , opener.document.getElementById("modeRegUpdate").value);
		//alert("mode:"+$('#mode', opener.document).val()+"==========>update:"+$('#modeRegUpdate', opener.document).val());
		setHourSelect();
	});
	
	function display(type , typeRegUpdate){
		//alert( $('#whCodeS', opener.document).val() +":"+ $('#whNamePopupS', opener.document).val());
		
		$('#warehouseName').val($('#whNamePopupS', opener.document).val());
		
		if(typeRegUpdate == "regist"){
			//getUpperGroupCode();
			getItemCode();
		}
		else{
			
			//$('#selectUpperGroupCode').attr("disabled", true);
			//$('#selectGroupCode').attr("disabled", true);
			$('#selectItemCode').attr("disabled", true);
			getItemInOut($('#whCodePopupS', opener.document).val(), '<c:out value="${param_s.itemCode}"/>' ,resultItemInOut);
		}
		
		if(type == "inReg"){
			//입고
			$('#inOutTitle').html('입고');
			dicReqParam["status"] ='I';
		}
		else if (type == "outReg"){
			//출고
			$('#inOutTitle').html('출고');
			dicReqParam["status"] ='O';
		}
	}
	
	//출고 등록 일 경우 재고 수량을 가져온다. 
	function getItemInOut(_whCode, _itemCode, callback){

		var itemCode = "";
		var itemCodeNum = "";
		if(_itemCode != ""){
			itemCodeNum = _itemCode.split('-')[1];
			itemCode = _itemCode.split('-')[0];
		}
		
		$.ajax({
			type: "POST",
			url: "<c:url value='/warehouse/getSearchItemStockList.do'/>",
			data: {
					itemCode:itemCode,
					itemCodeNum:itemCodeNum,
					whCode:_whCode
				},
			dataType:"json",
			async: false,
			beforeSend : function(){ },
			success : function(result){
				resultItemInOut(result);
				// 아이템 데이터 세팅
			}
		});
	}
	
	//getItemInOut call back function 
	function resultItemInOut(result){
		
		//alert("resultItemInOut : " + result['list'].length);
		if(result['list'].length > 0){
			var obj = result['list'][0];
			
			retainCnt = obj.itemCnt;
			$('#txtItemRetainCnt').html("(재고수량 :" + retainCnt + ")");
			
			if($('#modeRegUpdate', opener.document).val() == "update"){
				//입출고 수정 시
				//$('#selectGroupCode').html("<option value='"+obj.itemCodeDet+"'>"+obj.groupName+"</option>");
				$('#selectItemCode').html("<option value='"+obj.itemCode+ "-" + +obj.itemCodeNum+ "'>"+obj.itemName+"</option>");
				$('#txtItemStan').val(obj.itemStan);
			}
		}
	}
	
	/*	대분류 중분류 삭제 2016.12.22 KANG JI NAM
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
					$('#selectUpperGroupCode').html("<option value=''>대분류</option>");
				}
				else {
					var dropDownSetW = $('#selectUpperGroupCode');		
					dropDownSetW.loadSelectWareHouse(result.codes, '대분류', "VALUE", 'CAPTION');	
					$('#selectUpperGroupCode').attr("disabled", false);
				}
			}
		});
	}
	
	//중분류 코드  불러오기 
	function getGroupCode() {
	
		var upperGroupCode = $("#selectUpperGroupCode option:selected").val();
		
		if (upperGroupCode == '') {
			$('#selectGroupCode').html("<option value=''>중분류</option>");
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
						$('#selectGroupCode').html("<option value=''>중분류</option>");
					}
					else {
						var dropDownSet = $('#selectGroupCode');
						dropDownSet.loadSelectWareHouse(result.codes, '중분류','VALUE', 'CAPTION');
						dropDownSet.attr("disabled", false);
					}
				}
			});
		}
	}
	*/
	
	//물품 코드 불러오기
	function getItemCode(){
		//var groupCode = $("#selectGroupCode option:selected").val();
		
		/*
		if(groupCode == ''){
			$('#selectItemCode').html("<option value=''>물품명</option>");
		}else{}
		*/
		
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/itemConditionCode.do'/>",
			data:{
				//groupCode : groupCode
				},
			dataType:"json",
			beforeSend:function(){},
			success:function(result){
				
				if (result.codes == '')
					$('#selectItemCode').html("<option value=''>물품명</option>");
				else {
					dropDownSet = $('#selectItemCode');
					dropDownSet.loadSelectWareHouse(result.codes, '물품명', 'VALUE', 'CAPTION');
					dropDownSet.attr("disabled", false);
				}
			}
		});
	}
	
	//물품 단위 가져오기 ..
	function getItemStan(itemCode){
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/getItemDetailValue.do'/>",
			data:{
				itemCode : itemCode
				},
			dataType:"json",
			async: false,
			beforeSend:function(){},
			success:function(result){
				
				var arrdata = result['codes'];
				$('#txtItemStan').val(arrdata[0].itemStan);
			}
		});
	}
	
	// hour 
	function setHourSelect(){
		var item = '';
		
		for(i = 1 ; i < 25 ; i++){
			var temp = i.toString();
			
			if(temp.length == 1)
				temp = "0" + temp;
				
			item += "<option value='" + temp + "'>"+temp+"</option>";
		}
		$('#selectHour').html(item);
	}
	
	function validateItem(){
		
		if($('#whCodePopupS', opener.document).val().length == 0){
			alert('창고코드가 존재 하지 않습니다.');
			return false;
		}
		/*
		if($("#selectGroupCode option:selected").val().length == 0 || $("#selectGroupCode option:selected").val() == '중분류'){
			alert('중분류가 선택 되지 않았습니다.');
			return false;
		}
		*/
		if($("#selectItemCode option:selected").val().length == 0 || $("#selectItemCode option:selected").val() == '물품명'){
			alert('물품명이 선택 되지 않았습니다.');
			return false;
		}
		if($("#dateStock").val().length == 0){
			alert('날짜를 선택 해야 합니다.');
			return false;
		}
		
		if($("#selectHour option:selected").val().length == 0  ){
			alert('시간를 선택 해야 합니다.');
			return false;
		}
		
		if($("#txtItemCnt").val().length == 0 || $("#txtItemCnt").val() < 1){
			alert('수량를 선택 해야 합니다.');
			return false;
		}
		
		if($("#txtAreaItemDesc").val().length == 0){
			alert('내용를 입력해야 합니다.');
			return false;
		}
				
		dicReqParam['whCode']		=$('#whCodePopupS', opener.document).val();
		//dicReqParam['itemCodeDet']	=$("#selectGroupCode option:selected").val();
		dicReqParam['itemCode']		= $("#selectItemCode option:selected").val().split('-')[0];
		dicReqParam['itemCodeNum']		= $("#selectItemCode option:selected").val().split('-')[1];
		dicReqParam['itemCnt']		=$("#txtItemCnt").val();
		dicReqParam['itemDesc']		=$("#txtAreaItemDesc").val();
		dicReqParam['startDate']	=$("#dateStock").val2()+" "+$("#selectHour option:selected").val();
		
		// 입고 출고 재고 계산
		var inputNum = parseInt($("#txtItemCnt").val());
		var itemCnt = 0;
		if($('#mode', opener.document).val() == 'outReg'){
			itemCnt = parseInt(retainCnt) - inputNum;
		}
		else{
			itemCnt = parseInt(retainCnt) + inputNum;
		}
		dicReqParam['itemRetainCnt'] = itemCnt.toString();
		
		var ajaxStatus = "";
		// 동일 시간 동일 물품 입고(출고) 중복 확인 
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/checkDuplicateItemInOut.do'/>",
			data:{
				whCode:dicReqParam['whCode'],
				status:dicReqParam['status'],
				itemCode:dicReqParam['itemCode'],
				itemCodeNum:dicReqParam['itemCodeNum'],
				startDate:dicReqParam['startDate']
			},
			dataType:"json",
			async: false,	// 순차적인 작업을 할 경우 ajax를 쓰게되면 동기 방식으로 써야함!! KANG JI NAM 2017.01.04
			beforeSend:function(){},
			success:function(result){
				if(result.duplicate){
					var statusTemp = "";
					(dicReqParam['status'] == "I") ? statusTemp = "입고" : statusTemp = "출고";
					alert("해당 시간에 "+statusTemp+" 내역이 존재합니다.");
					ajaxStatus = "fail";
				}else{
					ajaxStatus = "success";
				}
			},
			error:function(result){
				alert("시스템에 오류가 발생하였습니다.");
				ajaxStatus = "fail";
			}
		});
		
		if(ajaxStatus == 'success'){
			return true;
		}else if(ajaxStatus == 'fail'){
			return false;
		}else{
			return true;
		}
	}
	
	//T_ITEM_INOUT insert 구현 
	function addItemInOut(callback){
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/addItemInOut.do'/>",
			data:{
				whCode:dicReqParam['whCode'],
				status:dicReqParam['status'],
				itemCode:dicReqParam['itemCode'],
				itemCodeNum:dicReqParam['itemCodeNum'],
				//itemCodeDet:dicReqParam['itemCodeDet'],
				itemCnt:dicReqParam['itemCnt'],
				itemDesc:dicReqParam['itemDesc'],
				startDate:dicReqParam['startDate'],
				regId:dicReqParam['regId']
			},
			dataType:"json",
			beforeSend:function(){},
			success:function(result){
				callback(result);
			}
		});
	}
	
	//T_ITEM_CODE merge 구현 
	function mergeItemCode(){
// 		alert(dicReqParam['itemRetainCnt']);
		
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/mergeItemStock.do'/>",
			data:{
				whCode:dicReqParam['whCode'],
				itemCode:dicReqParam['itemCode'],
				itemCodeNum:dicReqParam['itemCodeNum'],
				//itemCodeDet:dicReqParam['itemCodeDet'],
				itemCnt:dicReqParam['itemRetainCnt'],
				regId:dicReqParam['regId'],
				uptId:dicReqParam['regId']
				},
			dataType:"json",
			beforeSend:function(){},
			success:function(result){
				opener.dataLoadStockList(1);
				self.close();
			}
		});
	}
	
	// addItemInOut + mergeItemCode 트랜잭션 처리
	function tranItemInOut(){
		$.ajax({
			type:"POST",
			url:"<c:url value='/warehouse/tranItemInOut.do'/>",
			data:{
				whCode:dicReqParam['whCode'],
				status:dicReqParam['status'],
				itemCode:dicReqParam['itemCode'],
				itemCodeNum:dicReqParam['itemCodeNum'],
				itemCnt:dicReqParam['itemCnt'],
				itemRetainCnt:dicReqParam['itemRetainCnt'],
				itemDesc:dicReqParam['itemDesc'],
				startDate:dicReqParam['startDate'],
				regId:dicReqParam['regId'],
				uptId:dicReqParam['regId']
			},
			dataType:"json",
			beforeSend:function(){},
			success:function(result){
				opener.dataLoadStockList(1);
				self.close();
			}
		});
	}
	
	function itemInOutRecvCallback(result){
		mergeItemCode();
	}
	
	function onSave(){
		if(validateItem() == true){
			addItemInOut(itemInOutRecvCallback);
		}
	}
	
	function tranSave(){
		if(validateItem() == true){
			tranItemInOut();
		}
	}
	
	function onCancel(){
		self.close();
	}
	
	function commonWork() {
		var stdt = document.getElementById("dateStock");
		var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;
		
		
		if(stdt.value !=''){
			if(dateCheck.test(stdt.value)!=true){
				
				var returnValue = commonWork2(stdt.value, "dateStock");
				
				//숫자만 입력 체크를 통과못하면.
				if(returnValue != 'true'){
					alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
					stdt.value = "";
					stdt.focus;
					return false;
				}
			}
		}
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
				checkNum = "true";
			}else{
				returnValue = "false";
				checkNum = "false";
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
						<h3><span id="inOutTitle"></span></h3>
					</div>
				</div>
				
				<div class="listView_write" style="padding:0px;width:100%;">
					<div class="popup_situReceive" style=" padding:15px 0; border:2px solid #2f8bc0; border-width:2px 0;">
						<fieldset class="first">
							<div class="tabDisplayArea"></div>
							<form id="factbranchInfoAddFrm" name="factbranchInfoAddFrm" action="/spotmanage/saveFactbranchInfoAdd.do" method="post" >
								<table class="dataTable" style="width:100%; float:left;" summary="창고정보">
									<colgroup>
										<col width="120px"></col>
										<col></col>
									</colgroup>
									<tbody>
										<tr>
											<th scope="row">창고명</th>
											<td >
												<input type="text" id="warehouseName" name="warehouseName" value="" style="width:380px;" readonly="readonly" />
											</td>
										</tr>	
										<!-- 대분류 중분류 삭제 2016.12.22 KANG JI NAM
										<tr>
											<th scope="row">분류</th>
											<td>
												<select id="selectUpperGroupCode" name="selectUpperGroupCode" style="width:188px">
													<option value=>대분류</option>
												</select>&nbsp;
												<select id="selectGroupCode" name="selectGroupCode" style="width:188px">
													<option value=>중분류</option>
												</select>
											</td>
										</tr>
										 -->
										<tr>
											<th scope="row">물품명</th>
											<td>
												<select id="selectItemCode" name="selectItemCode" style="width:380px">
													<option value= >물품명</option>
												</select>
											</td>
										</tr>
										<tr>
											<th scope="row">규격</th>
											<td>
												<input type="text" id="txtItemStan" name="txtItemStan" value="" style="width:380px; background-color:#f2f2f2;" readonly="readonly"/>
											</td>
										</tr>
										<tr>
											<th scope="row">수량</th>
											<td>
												<input type="text" id="txtItemCnt" name="txtItemCnt" value="0" style="width:50px"/> EA
												<span id="txtItemRetainCnt">(재고수량 :0)</span>
											</td>
										</tr>
										<tr>
											<th scope="row">일시</th>
											<td>
												<input type="text" size="13" id="dateStock" name="dateStock" style="width:80px" onchange="commonWork()"/>
												<select id="selectHour" name="selectHour" style="width:40px"></select>
											</td>
										</tr>
										<tr>
											<th scope="row">내용</th>
											<td>
												<textarea rows="10" cols="20" id="txtAreaItemDesc" name="txtAreaItemDesc" style="width:380px"></textarea>
											</td>
										</tr>
									</tbody>
								</table>
							</form>
							<div style="float:right;margin:20px 0px;">
								<a onclick="javascript:tranSave();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>등록</em></span></a>&nbsp;
								<a onclick="javascript:window.close();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>닫기</em></span></a>
							</div>
						</fieldset>
					</div>
				</div>
			</div><!-- //content -->
		</div><!-- //Contents End Here -->
	</div><!-- //wrap -->
</body>
</html>