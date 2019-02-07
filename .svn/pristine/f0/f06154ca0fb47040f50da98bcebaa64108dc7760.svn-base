<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : waterPollutionRegist.jsp
	 * Description : 상황발생접수 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2013.04.20	YIK			최초 생성
	 * 2013.10.31	lkh			리뉴얼
	 * 
	 * author YIK
	 * since 2013.04.20
	 * 
	 * Copyright (C) 2013 by YIK All right reserved.
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
	$(function () {
		$('#save').click(function(){
			//fnSave();
		});
		
		$("#dept").change(function(){
			setPerson(); //직원셋팅
		});
		
		setReceiveInfo();	//접수자정보 셋팅
		
		setDept();		//부서셋팅
		//시간셋팅
		setTime();

		<c:if test="${!empty View.wpCode}">
		getWpDetailData();
		fnDisplay();
		</c:if>
	});
	
	//목록 화면 이동
	function fnGoListPage(){
		location.href = "<c:url value='/waterpollution/waterPollutionList.do'/>";
	}
	
	//저장 
	function fnSave(){
		var reportDate	= $('#reportDate').val();
		var reportHour	= $('#reportHour').val();
		var reportMin	= $('#reportMin').val();
		
		var reporterName  = $('#reporterName').val();
		var reporterTelNo = $('#reporterTelNo').val();
		var reporterDept  = $('#reporterDept').val();
		
		var receiveDate	= $('#receiveDate').val();
		var receiveHour	= $('#receiveHour').val();
		var receiveMin	= $('#receiveMin').val();
		
		var wpKind		= $('#wpKind').val();
		var riverDiv	= $('#riverDiv').val();
		var regKind		= $('#regKind').val();
		var address		= $('#address').val();
		var wpContent	= $('#wpContent').val();
		var smsContent	= $('#smsContent').val();
		var sPerson		= $('#sPerson').val();
		
		if(reportDate == "") {
			alert("신고일을 입력해 주십시요.");
			$("#reportDate").focus();
			return false;
		}
		
		if(reporterName == "") {
			alert("신고자를 입력해 주십시요.");
			$("#reporterName").focus();
			return false;
		}
		
		if(reporterTelNo == "") {
			alert("신고자 연락처를 입력해 주십시요.");
			$("#reporterTelNo").focus();
			return false;
		}
		
		if(receiveDate == ""){
			alert("접수일자를 입력해 주십시요.");
			$("#receiveDate").focus();
			return false;
		}
		
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
		
		if(regKind == "") {
			alert("비고 선택해 주십시요.");
			$("#regKind").focus();
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
		
		if(smsContent == "") {
			alert("SMS내용을 생성해 주십시요.");
			$("#smsContent").focus();
			return false;
		}
		
		//전파대상자
		var member = new Array;	
		var cnt = 0;
		
		$("#sPerson option").each(function() {
			member.push($(this).val());
			cnt++;
		});
		$("#memberId").val(member);
		
		if(cnt == 0) {
			alert("대상자를 선택하여 주십시요.");
			return false;
		}
		
		if(confirm("저장 하시겠습니까?")){
			document.registform.action = "<c:url value='/waterpollution/waterpollutionRegProc.do'/>";
			document.registform.submit();
		}
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
				var deptName = obj.UPPERDEPTNAME + ' > ' + obj.DEPTNAME;
				
				$('#receiverName').val(obj.MEMBERNAME);
				$('#receiverTelNo').val(obj.MOBILENO);
				$('#receiverDept').val(deptName);
				$('#receiverId').val(obj.MEMBERID);
			}
		});
	}
	
	//좌표 지정 팝업
	function lon_lat(){
		var X = $('#longituded').val();
		var Y = $('#latiude').val();
		var param = "?X=" + X + "&Y=" + Y; 
		window.open("<c:url value='/addrMap.jsp'/>"+ param,'popupMap','resizable=yes,scrollbars=yes,width=960,height=800');
	}
	
	// 좌표 및 주소 반영
	function applyLonLat(lon, lat, addr) {
		$('#latiude').val(lat);
		$('#longituded').val(lon);
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
				if($(this).val() == addOpt.value){
					flag = true;
					return false;//break;
				}
			});
			
			if(!flag){
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
				
				$('#address').val(obj.address);
				
				$('#wpContent').val(obj.wpContent);
				
				var reportDate = obj.reportDate.substring(0,4) + '/'
								+ obj.reportDate.substring(4,6) + '/'
								+ obj.reportDate.substring(6,8);
				var reportHour = obj.reportDate.substring(8,10);
				
				var reportMin = obj.reportDate.substring(10,12);
				
				$('#reportDate').val(reportDate);
				$('#reportHour').val(reportHour);
				$('#reportMin').val(reportMin);
				
				$('#reporterTelNo').val(obj.reporterTelNo);
				
				$('#latiude').val(obj.latiude);
				$('#longituded').val(obj.longituded);
				var supportKind = obj.supportKind;
			}
		});
	}
	

	function fnDisplay(){
		$('#reportDate').attr("disabled",true);
		$('#reportHour').attr("disabled",true);
		$('#reportMin').attr("disabled",true);
	}
	
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
		//============================= 달 력 Start ======================================
		/* shows the loading div every time we have an Ajax call */
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
		
		var today2	  = new Date();
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
		
		$("#reportDate").val(today);
		$("#receiveDate").val(today);
		
		$("#reportHour").val(curr_hour);
		$("#reportMin").val(curr_min);
		
		$("#receiveHour").val(curr_hour);
		$("#receiveMin").val(curr_min);
	}


	<c:if test="${!empty View.wpCode}">
	function fnDelete(){
		if(confirm("삭제하시겠습니까?")){
			document.registform.action = "<c:url value='/waterpollution/waterPollutionDelete.do'/>";
			document.registform.submit();	
		}
	}
	</c:if>
	
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
						
						<div class="topBx">
							<span style="padding-top:10px">□ 사고 신고 및 접수</span>
<!-- 							<input type="button" id="btnList" name="btnList" value="목록" class="btn btn_basic" onclick="javascript:fnGoListPage();" alt="목록"/> -->
						</div>
						
						<div class="table_wrapper">
						
							<form name="registform" method="post" onsubmit="return false;" enctype="multipart/form-data">
								<c:if test="${!empty View.wpCode}">
									<input type="hidden" id="wpCode" name="wpCode" value="${View.wpCode}"/>
								</c:if>
								<input type="hidden" id="receiverId" name="receiverId">
								<input type="hidden" id="memberId" name="memberId"/>
								
								<table summary="신고정보" style="text-align:left">
									<colgroup>
										<col width="15%">
										<col width="15%">
										<col width="27%">
										<col width="15%">
										<col >
									</colgroup>
									<tr>
										<th rowspan="3">신고</th>
										<th>신고일시</th>
										<td colspan="3" style="padding:4px">
											<input type="text" id="reportDate" name="reportDate" size="15" onchange="commonWork()"/>
											<select id="reportHour" name="reportHour" >
											</select>시
											<select id="reportMin" name="reportMin" >
											</select>분
										</td>
									</tr>
									<tr>
										<th>신고자<span class="red">*</span></th>
										<td style="padding:4px">
											<input type="text" id="reporterName" name="reporterName" size="20" maxlength="20;"/>
											<span style="font-color:red">한글 10자까지만 입력.</span>
										</td>
										<th>연락처<span class="red">*</span></th>
										<td style="padding:4px">
											<input type="text" id="reporterTelNo" name="reporterTelNo" size="20" maxlength="20;"/>
										</td>
									</tr>
									<tr>
										<th>신고자 소속</th>
										<td colspan="3" style="padding:4px">
											<input type="text" id="reporterDept" name="reporterDept" size="58" maxlength="20;"/>
										</td>
									</tr>
								</table>
								<br/>
								<table summary="접수정보" style="text-align:left">
									<colgroup>
										<col width="15%">
										<col width="15%">
										<col width="27%">
										<col width="15%">
										<col >
									</colgroup>
									<tr>
										<th rowspan="3">접수</th>
										<th>접수일시<span class="red">*</span></th>
										<td colspan="3" style="padding:4px">
											<input type="text" id="receiveDate" name="receiveDate" size="15" onchange="commonWork()"/>
											<select id="receiveHour" name="receiveHour" >
											</select>시
											<select id="receiveMin" name="receiveMin" >
											</select>분
										</td>
									</tr>
									<tr>
										<th>접수자<span class="red">*</span></th>
										<td style="padding:4px">
											<input type="text" id="receiverName" name="receiverName" size="20" maxlength="20" readonly="readonly"/>
										</td>
										<th>연락처<span class="red">*</span></th>
										<td style="padding:4px">
											<input type="text" id="receiverTelNo" name="receiverTelNo" size="20" maxlength="20" readonly="readonly"/>
										</td>
									</tr>
									<tr>
										<th>접수자 소속<span class="red">*</span></th>
										<td colspan="3" style="padding:4px">
											<input type="text" id="receiverDept" name="receiverDept" size="58" maxlength="58" readonly="readonly"/>
										</td>
									</tr>
								</table>
								<br>
								<div class="topBx">
									<span>□ 사고 내용</span>
								</div>
								<table summary="사고정보"style="text-align:left">
									<colgroup>
										<col width="15%">
										<col width="25%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
										<col width="15%">
									</colgroup>
									<tr>
										<th>사고유형<span class="red">*</span></th>
										<td style="padding:4px">
											<select id="wpKind" name="wpKind">
												<option value="">선택</option>
												<option value="PA">유류유출</option>
												<option value="PB">물고기폐사</option>
												<option value="PC">화학물질</option>
												<option value="PD">기타</option>
											</select>
										</td>
										<th>수계<span class="red">*</span></th>
										<td style="padding:4px">
											<select id="riverDiv" name="riverDiv">
												<option value="">선택</option>
												<option value="R01">한강</option>
												<option value="R02">낙동강</option>
												<option value="R03">금강</option>
												<option value="R04">영산강</option>
											</select>
										</td>
										<th>비고<span class="red">*</span></th>
										<td style="padding:4px">
											<select id="regKind" name="regKind">
												<option value="">선택</option>
												<option value="1">공단</option>
												<option value="2">환경부</option>
												<option value="3">공단&amp;환경부</option>
											</select>
										</td>
									</tr>
									<tr>
										<th rowspan="3">사고지점</th>
										<td colspan="5" style="padding:4px">
											<input type="text" id="address" name="address" size="90" readonly="readonly"/>
											<input type="button" id="btnMap" name="btnMap" value="지도" class="btn btn_search" onclick="javascript:lon_lat();" alt="지도"/>
										</td>
									</tr>
									<tr>
										<td colspan="6" style="padding:4px">
											
											<input type="text" id="addrDet" name="addrDet" size="90" /><b>(상세 주소)</b>
											
										</td>
									</tr>
									<tr>
										<td colspan="6" style="padding:4px">
											
											<b>위도 : </b><input type="text" id="latiude" name="latiude" size="40" readonly="readonly" />
											<b>경도 : </b><input type="text" id="longituded" name="longituded" size="40"  readonly="readonly"/>
											
										</td>
									</tr>
									<tr>
										<th>사고내용(상세)</th>
										<td colspan="5" style="padding:4px">
											<textarea rows="5" cols="130" id="wpContent" name="wpContent"></textarea>
										</td>
									</tr>
									<tr>
										<th>첨부파일</th>
										<td colspan="5" style="padding:4px">
											<input name="file_1" id="egovComFileUploader" type="file"  size="90"/>&nbsp;&nbsp;
											<div id="egovComFileList"></div>
										</td>
									</tr>
									<tr>
										<th>SMS</th>
										<td colspan="5" style="padding:4px">
											<input type="text" id="smsContent" name="smsContent" size="90" maxlength="80"/>
											<input type="button" id="btnMake" name="btnMake" value="생성" class="btn btn_search" onclick="javascript:getSmsMsg();" alt="생성"/>
										</td>
									</tr>
									<tr>
										<th>전파대상</th>
										<td colspan="5" valign="top" style="padding:7px 7px 7px 100px">
											<div class="gBox" style="width:220px">
												<span class="ptit" >
													대상기관
												</span>
												<select multiple="multiple" id="dept" style="padding:7px;width:220px;height:190px"></select>
											</div>
											<div style="padding-top:25px;float:left"><img src="/images/renewal/parrow.gif" alt="다음단계"/></div>
											<div class="gBox">
												<span class="ptit">
													담당자
												</span>
												<select multiple="multiple" id="person" style="padding:7px;width:180px;height:190px"></select>
											</div>
											<ul class="arrbx">
<%-- 												<li style="padding-top:70px;"><a href="javascript:add()"><img src="<c:url value='/images/common/btn_getIns.gif'/>" alt="추가" /></a></li><br/> --%>
												<li style="padding-top:70px;"><a href="javascript:add()"><img src="<c:url value='/images/renewal/bt_arradd.gif'/>" alt="추가" /></a></li><br/>
<%-- 												<li><a href="javascript:del()"><img src="<c:url value='/images/common/btn_getDel.gif'/>" alt="삭제" /></a></li> --%>
												<li><a href="javascript:del()"><img src="<c:url value='/images/renewal/bt_arrdel.gif'/>" alt="삭제" /></a></li>
											</ul>
											<div class="gBox">
												<span class="ptit">
													전파대상자
												</span>
												<select multiple="multiple" id="sPerson" style="padding:7px;width:180px;height:190px"></select>
											</div>
										</td>
									</tr>
								</table>
							</form>
							<div id="btArea" class="mtop10">
								<c:if test="${!empty View.wpCode}">
									<input type="button" id="btnSave" name="btnSave" value="삭제" class="btn btn_basic" onclick="javascript:fnDelete();" alt="삭제"/>
								</c:if>
								<input type="button" id="btnSave" name="btnSave" value="등록" class="btn btn_basic" onclick="javascript:fnSave();" alt="등록" />
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
</body>
</html>