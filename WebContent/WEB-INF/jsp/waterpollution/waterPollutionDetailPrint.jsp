<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : waterPollutionDetailPrint.jsp
	 * Description : 수질오염사고접수 출력 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2013.04.20	YIK			최초 생성
	 * 2014.05.26	lkh			리뉴얼
	 * 
	 * author YIK
	 * since 2013.04.20
	 * 
	 * Copyright (C) 2010 by YIK All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<title>수질오염사고 접수</title>

<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<link rel="stylesheet" type="text/css" href="<c:url value='/css/com.css' />">
<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css' />" />

<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />

<script type="text/javaScript">
//<![CDATA[
//목록 으로 가기
	$(function() {
		var wpCode = "${param.wpCode}";
		$('#wpCode').val(wpCode);
		
		//시간셋팅
		setTime();
		
		//사고 접수 및 사고내용 데이터 가져오기(SMS, 수습경과, 사진은 따로 데이터가져옴)
		getWpDetailData();
		
		//화면 셋팅
		fnDisplay();
		
		fnPrint();
	});
	
	//목록 화면 이동
	function fnGoListPage(){
		location.href = "<c:url value='/waterpollution/waterPollutionList.do'/>";
	}
	
	//저장 
	function fnSave(){
		var wpKind		= $('#wpKind').val();
		var riverDiv	= $('#riverDiv').val();
		var address		= $('#address').val();
		var wpContent	= $('#wpContent').val();
		var smsContent	= $('#smsContent').val();
		var supportKind	= $('#supportKind').val();
		
		if(wpKind == "") {
			alert("사고유형을 선택해 주십시요.");
			$("#wpKind").focus();
			return false;
		}
		
		if(riverDiv == "") {
			alert("수계를 선택해 주십시요.");
			$("#riverDiv").focus();
			return false;
		}
		
		if(supportKind == "") {
			alert("지원유형를 선택해 주십시요.");
			$("#supportKind").focus();
			return false;
		}
		
		if(address == "") {
			alert("사고지점을 입력해 주십시요.");
			$("#address").focus();
			return false;
		}
		
		if(wpContent == "") {
			alert("사고내용을 입력해 주십시요.");
			$("#wpContent").focus();
			return false;
		}
		
		document.registform.action = "<c:url value='/waterpollution/waterPollutionModify.do'/>";
		document.registform.submit();
	}
	
	//접수자 정보 셋팅
	function setReceiveInfo(){
		$.ajax({
			type:"POST",
			url:"<c:url value='/waterpollution/getLoginMemberInfo.do'/>",
			data:{},
			dataType:"json",
			beforeSend:function(){},
			success:function(result){
				var obj = result['codes'][0];
				var deptName = obj.UPPERDEPTNAME + ' > ' + obj.DEPTNAME
				
				$('#receiverName').val(obj.MEMBERNAME);
				$('#receiverTelNo').val(obj.MOBILENO);
				$('#receiverDept').val(deptName);
				$('#receiverId').val(obj.MEMBERID);
			}
		});
	}
	
	//좌표 지정 팝업
	function lon_lat(){
		var popupMap = window.open("<c:url value='/warehouse/popupMap.do'/>",'popupMap','resizable=yes,scrollbars=yes,width=700,height=700');
	}
	
	//좌표 및 주소 반영
	function applyLonLat(lon, lat, addr) {
		$("#address").val(addr.replace('대한민국 ',''));
	}
	
	//SMS메세지 생성
	function getSmsMsg(){
		var wpKind = $("#wpKind option:selected").text();
		var address = $("#address").val();
		
		var today		= new Date();
		var curr_hour	= today.getHours();
		var curr_min	= today.getMinutes();
		today = today.getFullYear()+ addzero(today.getMonth()+1) + addzero(today.getDate());
		
		var regdate = '';
		var smsTemp = '';
		
		if(wpKind == "") {
			alert("사고유형을 선택해 주십시요.");
			$("#wpKind").focus();
			return false;
		}
		
		if(address == "") {
			alert("사고지점 선택해 주십시요.");
			$("#address").focus();
			return false; 
		}
		regdate = regdate + today.substring(2, 4);//2010
		regdate = regdate + "/" + today.substring(4, 6);
		regdate = regdate + "/" + today.substring(6, 8)+" "+curr_hour+":"+curr_min;
		
		smsTemp = smsTemp + "[" + wpKind + "]";
		smsTemp = smsTemp + "[" + regdate + "]";
		smsTemp = smsTemp + "[" + address + "]";
		
		$("#smsContent").val(smsTemp);
	}
	
	//부서별 직원생성
	function setPerson(){
		var value = $("#dept > option:selected").val();
		var dropDownSet = $("#person");
		
		if(value == undefined)
			return;
		
		$.getJSON("<c:url value='/alert/getGroupAndMember.do'/>",
				{
					orderType:"2",
					value:value
				},
				//, system:sys_kind}, 
				function (data, status){
					if(status == 'success'){
						//locId 객체에 SELECT 옵션내용 추가.
						
						dropDownSet.loadSelect(data.groupList);
						//adjustBranchList();
						
					} else {
						return;
					}
				});
	}
	
	//부서생성
	function setDept(){
		var dropDownSet = $("#dept");
		
		$("#sPerson").emptySelect();
		
		$.getJSON("<c:url value='/alert/getGroupAndMember.do'/>",
				{
					orderType:"1"
				},
				//, system:sys_kind},
				function (data, status){
					if(status == 'success'){
						//locId 객체에 SELECT 옵션내용 추가.
						
						dropDownSet.loadSelect(data.groupList);
						
						setPerson();
						//adjustBranchList();
							
					} else {
						return;
					}
				});
	}
	
	//SMS 보낼 직원 추가
	function add(){
		$("#person option:selected").each(function(i){
			var addOpt = document.createElement('option'); // 옵션을 설정한다..
			addOpt.value = $(this).val();
			addOpt.appendChild(document.createTextNode($(this).text())); // 셀렉트 박스의 text 를 설정한다.
			
			var flag = false;
			$("#sPerson option").each(function(i){
				if($(this).val() == addOpt.value)
				{
					flag = true;
					return false;//break;
				}
			});
			
			if(!flag)
			{
				$("#sPerson").append(addOpt);
			}
			
		});
	}
	
	//SMS 보낼 직원 삭제
	function del(){
		$("#sPerson option:selected").each(function(i){
			//$(this).appendTo('#person');
			$(this).remove();
		});
	}
	function SelCheck(sel){
		var add = "<input type='text' id='selAdd' style='width:300px;'/>";
		if(sel==35){
			$('#SelAdd').html(add);
			$('#selAdd').focus();
		}else{
			$('#SelAdd').html("");
		}
	}
	
	//날짜 관련 함수
	function commonWork() {
		var stdt = document.getElementById("reportDate");  //신고일
		var endt = document.getElementById("receiveDate"); //접수일
		var dateCheck = /^(19[7-9][0-9]|20\d{2})\/(0[0-9]|1[0-2])\/(0[1-9]|[1-2][0-9]|3[0-1])$/;
		
		if(endt.value != '' && stdt.value > endt.value) {
			alert("접수일이 신고일보다 빠릅니다.\n\n다시 입력해 주십시오.");
			stdt.value = "";
			endt.value = "";
			stdt.focus();
		}
		if(stdt.value !=''){
			if(dateCheck.test(stdt.value)!=true){
				alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
				stdt.value = "";
				stdt.focus;
				return false;
			}
		}
		if(endt.value !=''){
			if(dateCheck.test(endt.value)!=true){
				alert("날짜 형식에 부적합 합니다.\nYYYY/MM/DD형식을 맞춰야 합니다.\n다시 입력해 주십시오.");
				endt.value = "";
				endt.focus;
				return false;
			}
		}
	}
	
	function setTime(){
		//============================= 달 력  Start ======================================
		/*shows the loading div every time we have an Ajax call*/
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		
		$("#reportDate").datepicker({
			buttonText: '신고일자'
		});
		
		$("#receiveDate").datepicker({
			buttonText: '접수일자'
		});
		
		var today = new Date();
		today = today.getFullYear()+"/"+ addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		
		var today2 = new Date();
		var curr_hour = addzero(today2.getHours());
		var curr_min  = addzero(today2.getMinutes());
		
		function addzero(n) {
			return n < 10 ? "0" + n : n + "";
		}
		
		for(var i=0 ; i< 24 ; i++){
			var temp = addzero(i);
			var item = "<option value='"+temp+"'>"+temp+"</option>";
			$("#reportHour").append(item);
			$("#receiveHour").append(item);
		}
		
		for(var i=0 ; i< 60 ; i++){
			var temp = addzero(i);
			var item = "<option value='"+temp+"'>"+temp+"</option>";
			$("#reportMin").append(item);
			$("#receiveMin").append(item);
		}
	}
	
	//수질오염사고 상세내역 DATA 가져오기
	function getWpDetailData(){
		var wpCode = $('#wpCode').val();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpollution/getWaterPollutionDetail.do'/>",
			data:{
				wpCode:wpCode,
			},
			dataType:"json",
			success:function(result){
				
				var obj = result['wpDetail'][0];
				
				if(user_roleCode == 'ROLE_ADMIN' || id == obj.receiverId){
					$('#reporterName').val(obj.reporterName);
					$('#reporterTelNo').val(obj.reporterTelNo);
					$('#reporterDept').val(obj.reporterDept);
					
					$('#receiverName').val(obj.receiverName);
					$('#receiverTelNo').val(obj.receiverTelNo);
					$('#receiverDept').val(obj.receiverDept);
				} else {
					$('#reporterName').val("***");
					$('#reporterTelNo').val("***********");
					$('#reporterDept').val("*******");
					
					$('#receiverName').val("***");
					$('#receiverTelNo').val("***********");
					$('#receiverDept').val("*******");
				}
				
				$('#wpKind').val(obj.wpKind);
				$('#riverDiv').val(obj.riverDiv);
				
				$('#address').val(obj.address);
				$('#addrDet').val(obj.addrDet);
				
				$('#wpContent').val(obj.wpContent);
				
				var reportDate = obj.reportDate.substring(0,4) + '/' +
								 obj.reportDate.substring(4,6) + '/' +
								 obj.reportDate.substring(6,8);
				var reportHour = obj.reportDate.substring(8,10);
				var reportMin = obj.reportDate.substring(10,12);
				
				var receiveDate = obj.receiveDate.substring(0,4) + '/' +
								  obj.receiveDate.substring(4,6) + '/' +
								  obj.receiveDate.substring(6,8);
				var receiveHour = obj.receiveDate.substring(8,10);
				var receiveMin  = obj.receiveDate.substring(10,12);
				
				$('#reportDate').val(reportDate);
				$('#reportHour').val(reportHour);
				$('#reportMin').val(reportMin);
				
				$('#receiveDate').val(receiveDate);
				$('#receiveHour').val(receiveHour);
				$('#receiveMin').val(receiveMin);
				
				var supportKind = obj.supportKind;
				
				//지원유형
				if(supportKind == ''){
					alert("지원유형을 선택해주세요");
					$('#supportKind').val("");
				}else{
					$('#supportKind').val(supportKind);
				}
				getWpSmsData(wpCode);
			}
		});
	}
	
	//SMS내역 가져오기
	function getWpSmsData(wpCode){
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpollution/getWaterPollutionSms.do'/>",
			data:{
				wpCode:wpCode,
			},
			dataType:"json",
			success:function(result){
				var recvName= "";
				var tot = result['wpSms'].length;
				
				//SMS 내용 셋팅
				if(tot > 0){
					var obj = result['wpSms'][0];  
					$('#smsContent').val(obj.smsContent);
				}
				var item = "";
				$("#dataListSMS").html("");
				
				for(var i=0; i< tot; i++){
					var obj = result['wpSms'][i];
					
					item = "<tr>"
						+ "<td style='text-align: left;'>"+obj.recvDept+"</td>"
						+ "<td style='text-align: center;'>"+obj.recvName+"</td>"
						+ "</tr>";
						
					$("#dataListSMS").append(item);
					$('#dataListSMS tr:odd').addClass('add');
					
				}
				getWpStepData(wpCode); //수습경과 데이터
			}
		});
	}
	
	//수습경과 데이터
	function getWpStepData(wpCode){
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpollution/getWaterPollutionStep.do'/>",
			data:{
				wpCode:wpCode,
			},
			dataType:"json",
			success:function(result){
				//SMS 수신자 셋팅
				var tot = result['wpStep'].length;
				var item = "";
				var item2 = "";
				var wpsStep = "";
				
				$("#dataListStep").html("");
				$("#dataListImgTotal").html("");
				
				for(var i=0; i< tot; i++){
					var obj = result['wpStep'][i];
					
					if(obj.wpsStep == 'STA'){
						wpsStep = '신고';
					}else if(obj.wpsStep == 'RCV'){
						wpsStep = '접수';
					}else if(obj.wpsStep == 'ING'){
						wpsStep = '수습중';
					}else if(obj.wpsStep == 'END'){
						wpsStep = '처리완료';
					}
					
					if(obj.wpsImg == null || obj.wpsImg == ''){
						item = "<tr>"
							+ "<td style='text-align: center;'>"+obj.wpsCode+"</td>"
							+ "<td style='text-align: center;'>"+obj.wpsStepDate+"</td>"
							+ "<td style='text-align: left;'>" +obj.wpsContent+"</td>"
							+ "<td style='text-align: center;'>"+wpsStep+"</td>"
							+ "<td></td>";
							+ "</tr>";
					}else{
						item = "<tr>"
							+ "<td style='text-align: center'>"+obj.wpsCode+"</td>"
							+ "<td style='text-align: center'>"+obj.wpsStepDate+"</td>"
							+ "<td style='text-align: left' >" +obj.wpsContent+"</td>"
							+ "<td style='text-align: center'>"+wpsStep+"</td>"
							+ "<td style='text-align: center'><img src='<c:url value='/cmmn/getImage.do'/>?atchFileId=" + obj.wpsImg + "&fileSn=0&thumbnailFlag=Y'/></td>";
							+ "</tr>";
						
						item2 = "<tr>"
							+ "<td style='text-align: center; padding:0px'><img src='<c:url value='/cmmn/getImage.do'/>?atchFileId=" + obj.wpsImg + "&fileSn=0&thumbnailFlag=N'  width='100%'/></td></tr>";
							
						$("#dataListImgTotal").append(item2);
					}
					$("#dataListStep").append(item);
					$('#dataListStep tr:odd').addClass('add');
				}
			}
		});
	}
	
	//수습경과 추가.
	function fnAddStep(){
		var wpCode = $('#wpCode').val();
		
		window.open("<c:url value='/waterpollution/waterPollutionStepPopup.do?wpCode='/>" + wpCode
					,'Pop_Mvmn'
					,'resizable=no,scrollbars=auto,width=530,height=270,left='+(screen.width/2-225)+',top='+(screen.height/2-135)+',location=no');
	}
	
	//수습조치 단계 수정팝업
	function fnGoStepDetail(wpCode, wpsCode){
		
		window.open("<c:url value='/waterpollution/waterPollutionStepModifyPopup.do?wpCode='/>" + wpCode + "&wpsCode=" + wpsCode
					,'Pop_Mvmn'
					,'resizable=no,scrollbars=auto,width=530,height=320,left='+(screen.width/2-225)+',top='+(screen.height/2-135)+',location=no');
	}
	
	function fnDisplay(){
		$('#reportDate').attr("disabled",true);
		$('#reportHour').attr("disabled",true);
		$('#reportMin').attr("disabled",true);
		$('#reporterName').attr("disabled",true);
		$('#reporterTelNo').attr("disabled",true);
		$('#reporterDept').attr("disabled",true);
		
		$('#receiveDate').attr("disabled",true);
		$('#receiveHour').attr("disabled",true);
		$('#receiveMin').attr("disabled",true);
		$('#receiverName').attr("disabled",true);
		$('#receiverTelNo').attr("disabled",true);
		$('#receiverDept').attr("disabled",true);
	}
	
	//화면 출력
	function fnPrint_old(){
		/*
		btn.style.display = 'none';
		var wb = '<O' + 'BJECT ID="WebBrowser" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OB'+'JECT>'; 
		document.body.insertAdjacentHTML('beforeEnd', wb);
		WebBrowser.ExecWB( 7, -1 );
		WebBrowser.outerHTML = '';
		btn.style.display = 'block';
		*/
		//document.getElementById('printBtn').style.display = 'none';
		
		var strWpKind		= $("#wpKind option:selected").text();
		var strRiverDiv		= $("#riverDiv option:selected").text();
		var strReceiveDate	= $('#receiveDate').val();
		var strReceiveHour	= $('#receiveHour').val();
		var strReceiveMin	= $('#receiveMin').val();
		var StrAddress		= $('#address').val();
		
		var tempStr = '[' + strWpKind + ']'
					+ '[' + strReceiveDate + '/' + strReceiveHour + '/' + strReceiveMin + ']'
					+ '[' + strRiverDiv + ']'
					+ '[' + StrAddress + ']';
		
		factory.printing.header = tempStr;
		factory.printing.footer = "";
		factory.printing.portrait = true; //가로(false) 세로(true)
		factory.printing.topMargin = 0.0;
		factory.printing.leftMargin = 0.0;
		factory.printing.rightMargin = 0.0;
		factory.printing.bottomMargin = 0.0;
		factory.printing.Print(false, window) //바로 프린트
		window.close();
	}
	
	//화면 출력
	function fnPrint(){
		window.print();
// 		window.open('about:blank', '_self').close();
	}
//]]>
</script>
</head>
<body>
	<div id='loadingDiv' style="visibility:hidden;position:absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="wrap" style="width:830px">
		<div id="container">
			<!-- //사이드 리스트 -->
			<!-- content -->
			<div id="content" style="width:830px; float:center; padding:0px">
				<div id="managePage">
						<input type="hidden" id="wpCode" name="wpCode"/>
						<table>
							<tr>
								<td style="text-align:left; width:800px;">
								<h1> □ 사고 신고 및 접수</h1>
								</td>
								<td style="text-align:right;">
									<input type="button" id="btnPrint" name="btnPrint" value="인쇄" class="btn btn_basic" onclick="javascript:fnPrint();" alt="인쇄"/>
								</td>
							</tr>
						</table>
						<br>
						<table class="dataTable">
							<colgroup>
								<col width="115" />
								<col width="120" />
								<col width="220" />
								<col width="120" />
								<col />
							</colgroup>
							<tr>
								<th rowspan="3">신고</th>
								<th>신고일시</th>
								<td colspan="3">
									<input type="text" class="inputText" id="reportDate" name="reportDate" size="15" onchange="commonWork()"/>
									<select id="reportHour" name="reportHour" >
									</select>시
									<select id="reportMin" name="reportMin" >
									</select>분
								</td>
							</tr>
							<tr>
								<th>신고자</th>
								<td>
									<input type="text" class="inputText" id="reporterName" name="reporterName" size="15" maxlength="20;"/>
								</td>
								<th>연락처</th>
								<td>
									<input type="text" class="inputText" id="reporterTelNo" name="reporterTelNo" size="15" maxlength="20;"/>
								</td>
							</tr>
							<tr>
								<th>신고자 소속</th>
								<td colspan="3">
									<input type="text" class="inputText" id="reporterDept" name="reporterDept" size="58" maxlength="20;"/>
								</td>
							</tr>
						</table>
						<br>
						<table class="dataTable">
							<colgroup>
								<col width="115" />
								<col width="120" />
								<col width="220" />
								<col width="120" />
								<col />
							</colgroup>
							<tr>
								<th rowspan="3">접수</th>
								<th>접수일시</th>
								<td colspan="3">
									<input type="text" class="inputText" id="receiveDate" name="receiveDate" size="15" onchange="commonWork()"/>
									<select id="receiveHour" name="receiveHour" >
									</select>시
									<select id="receiveMin" name="receiveMin" >
									</select>분
								</td>
							</tr>
							<tr>
								<th>접수자</th>
								<td>
									<input type="text" class="inputText" id="receiverName" name="receiverName" size="15" maxlength="20;"/>
								</td>
								<th>연락처</th>
								<td> 
									<input type="text" class="inputText" id="receiverTelNo" name="receiverTelNo" size="15" maxlength="20;"/>
								</td>
							</tr>
							<tr>
								<th>접수자 소속</th>
								<td colspan="3">
									<input type="text" class="inputText" id="receiverDept" name="receiverDept" size="58" maxlength="20;"/>
								</td>
							</tr>
						</table>
						<br>
						<h1> □ 사고 내용</h1>
						<br>
						<table class="dataTable">
							<colgroup>
								<col width="115" />
								<col width="120" />
								<col width="80" />
								<col width="140" />
								<col width="120" />
								<col />
							</colgroup>
							<tr>
								<th>사고유형</th>
								<td>
									<select id="wpKind" name="wpKind">
										<option value="PA">유류유출</option>
										<option value="PB">물고기폐사</option>
										<option value="PC">화학물질</option>
										<option value="PD">기타</option>
										<option value="PT">테스트</option>
									</select>
								</td>
								<th>수계</th>
								<td>
									<select id="riverDiv" name="riverDiv">
										<option value="R01">한강</option>
										<option value="R02">낙동강</option>
										<option value="R03">금강</option>
										<option value="R04">영산강</option>
									</select>
								</td>
								<th>지원유형</th>
								<td>
									<select id="supportKind" name="supportKind">
										<option value="">선택</option>
										<option value="N">접수</option>
										<option value="Y">지원</option>
									</select>
								</td>
							</tr>
							<tr>
								<th rowspan="2">사고지점</th>
								<td colspan="5">
									<input type="text" class="inputText" id="address" name="address" size="90" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<td colspan="5">
									<input type="text" class="inputText" id="addrDet" name="addrDet" size="90"/>
								</td>
							</tr>
							<tr>
								<th>사고내용(상세)</th>
								<td colspan="5">
									<textarea rows="5" cols="66" id="wpContent" name="wpContent" readonly="readonly"></textarea>
								</td>
							</tr>
							<tr>
								<th rowspan="2">SMS전파</th>
								<th>내용</th>
								<td colspan="4">
									<input type="text" class="inputText" id="smsContent" name="smsContent" size="80" readonly="readonly"/>
								</td>
							</tr>
							<tr>
								<th>수신자</th>
								<td colspan="4">
									<table style="width: 80%" class="dataTable">
										<colgroup>
											<col />
											<col width="150" />
										</colgroup>
										<thead>
											<tr>
												<th style="text-align: center;">소속</th>
												<th style="text-align: center;">수신자</th>
											</tr>
										</thead>
										<tbody id="dataListSMS"></tbody>
									</table>
								</td>
							</tr>
						</table>
						<br/>
						<table>
							<tr>
								<td style="text-align: left;">
								<h1> □ 수습(조치) 경과</h1>
								</td>
							</tr>
						</table>
						<br>
						<table class="dataTable">
							<colgroup>
								<col width="85" />
								<col width="120" />
								<col />
								<col width="120" />
								<col width="100" />
							</colgroup>
							<thead>
								<tr> 
									<th style="text-align: center;">순번</th>
									<th style="text-align: center;">일시</th>
									<th style="text-align: center;">내용</th>
									<th style="text-align: center;">단계</th>
									<th style="text-align: center;">이미지</th>
								</tr> 
							</thead> 
							<tbody id="dataListStep"></tbody>
						</table>
						<br>
						<table style="width: 150px;">
							<tr>
								<td style="text-align: left;">
								<h1> □ 사진대지</h1>
								</td>
							</tr>
						</table>
						<br>
<!-- 						<table id="singleImg" style="width: 50%;" class="dataTable"> -->
<!-- 							<tbody id="dataListImg"></tbody> -->
<!-- 						</table> -->
						<table id="totalImg" style="width: 100%;" class="dataTable">
							<tbody id="dataListImgTotal"></tbody>
						</table>
				</div><!-- //managePage -->
			</div><!-- //content -->
		</div><!-- //container -->
	</div>
	<!-- <object id="factory" viewastext style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814" codebase="http://his-korea.com/business/smsx.cab#Version=6,4,438,06"> -->
<!-- 	<object id="factory" style="display:none" classid="clsid:1663ed61-23eb-11d2-b92f-008048fdd814" codebase="http://his-korea.com/business/smsx.cab#Version=6,4,438,06"> -->
<!-- 	<param name="template" value="MeadCo://IE7" /> -->
<!-- 	</object> -->
</body>
</html>
