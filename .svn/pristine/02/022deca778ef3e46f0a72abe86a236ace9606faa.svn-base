<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="사고관리" name="title"/>
</jsp:include>
<script type="text/javascript">
//<![CDATA[
	$(function () {
		
		$("#dept").change(function(){
			setPerson(); //직원셋팅
		});
		
		setReceiveInfo();	//접수자정보 셋팅
		
		setDept();		//부서셋팅
		//시간셋팅
		setTime();
		
		fndisplay(1);
		window.onbeforeunload = function(e) {
			return ' ';
		};
	});
	
	//저장 
	function fnSave(n){
		if(n == 1)
		{
			if(!fnvalidation(1)) {
				return false;
			}else{
				fndisplay(2);
			}
		}
		if(n == 2)
		{
			if(!fnvalidation(1)){
				fndisplay(1);
				return false;
			}else if(!fnvalidation(2)){
				return false;
			}else{
				fndisplay(3);
			}
		}
		if(n == 3)
		{
			if(!fnvalidation(1)){
				fndisplay(1);
				return false;
			}else if(!fnvalidation(2)){
				fndisplay(2);
				return false;
			}else if(!fnvalidation(3)){
				return false;
			}else{
				if(confirm("저장 하시겠습니까?")){
					window.onbeforeunload = null; 
					document.registform.action = "/mobile/sub/waterpollution/waterpollutionRegProc.do";
					document.registform.submit();
				}
			}
		}
	}
	
	function fnvalidation(n){
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
		var address		= $('#address').val();
		var wpContent	= $('#wpContent').val();
		var smsContent	= $('#smsContent').val();
		var sPerson		= $('#sPerson').val();
		
		if(n == 1){
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
		}
		if(n == 2){
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
		}
		if(n==3){
			if(smsContent == "") {
				alert("SMS내용을 생성해 주십시요.");
				$("#smsContent").focus();
				return false;
			}
			
			//전파대상자
			var member = new Array;	
			var cnt = 0;
			
			$("input[name='personval']").each(function() {
				member.push($(this).val());
				cnt++;
			});
			$("#memberId").val(member);
			
			if(cnt == 0) {
				alert("대상자를 선택하여 주십시요.");
				return false;
			}
		}
		return true;
	}
	function fndisplay(n){
		
		var img_src="/images/mobile/sub/waterPollutionRegiststep0";
		$("#firsttitle div a img").attr("src", img_src + "1_off.png");
		$("#secondtitle div a img").attr("src", img_src + "2_off.png");
		$("#thirdtitle div a img").attr("src", img_src + "3_off.png");
	
		switch(n)
		{
			case 1 : 
				$("#firststep").css("display","").siblings().css("display","none");
				$("#firsttitle").addClass("stepon").siblings().removeClass("stepon").siblings().addClass("step");

				$("#firsttitle div a img").attr("src",img_src + "1_on.png");
				break;
			case 2 : 
				$("#secondstep").css("display","").siblings().css("display","none");
				$("#secondtitle").addClass("stepon").siblings().removeClass("stepon").siblings().addClass("step");
				
				$("#secondtitle div a img").attr("src",img_src + "2_on.png");
				break;
			case 3 : 
				$("#thirdstep").css("display","").siblings().css("display","none");
				$("#thirdtitle").addClass("stepon").siblings().removeClass("stepon").siblings().addClass("step");
				
				$("#thirdtitle div a img").attr("src",img_src + "3_on.png");
				break;
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
	function lon_lat(X,Y){
		var param ="";
		if(X != ''){
			param = "?X=" + X + "&Y=" + Y;
		}
		var url = "/mobile/sub/waterpollution/waterMap.do"+param;
		$("#ifrm").attr("src",url);
		$("#popupStep").bPopup();
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
	
	function addzero(n) {
		return n < 10 ? "0" + n : n + "";
	}
	
	//SMS 보낼 직원 추가
	function add(){
		var value = $("#person option:selected").val();
		if($("#"+value).length < 1){
			var smspersonshtml = $("#smspersons").html();
			var inputbox = "<input type='hidden' name='personval' value='" + value + "' />";
			var contenthtml = "";
			
			contenthtml += "<div id='" + value + "' style='padding:5px 0;clear:both;'>" + inputbox;
			contenthtml += 		"<div style='float:left'>" + $("#dept option:selected").text() + " > " + $("#person option:selected").text() + "</div>";
			contenthtml += 		"<div style='float:right'><a href='#' onclick=\"del('" + value + "'); return false;\">X</a></div>";
			contenthtml += "</div>";
			$("#smspersons").html(smspersonshtml + contenthtml);
		}
	}
	
	//SMS 보낼 직원 삭제
	function del(n){
		$("#"+n).remove();
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
	
	function popupClose(){
		$(".b-close").click();
	}
	
	function setTime(){
		//============================= 달 력 Start ======================================
		/* shows the loading div every time we have an Ajax call */
		
		
		$("input[datepicker='Y']").datepicker();
		
		var today = new Date(); 
		today = today.getFullYear()+"/"+ addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		
		var today2	  = new Date();
		var curr_hour = addzero(today2.getHours());
		var curr_min  = addzero(today2.getMinutes());
		
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
	
	function addzero(n) {
		return n < 10 ? "0" + n : n + "";
	}
//]]>
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/waterpollution/waterPollutionSearch.do" name="link"/>
		<jsp:param value="사고관리" name="title"/>
	</jsp:include>
<form name="registform" method="post" action="/mobile/sub/waterpollution/waterpollutionRegProc.do">
<input type="hidden" name="searchRiverDiv" value="<c:out value="${param_s.searchRiverDiv}"/>"/>
<input type="hidden" name="searchWpKind" value="<c:out value="${param_s.searchWpKind}"/>"/>
<input type="hidden" name="searchWpsStep" value="<c:out value="${param_s.searchWpsStep}"/>"/>
<input type="hidden" name="startDate" value="<c:out value="${param_s.startDate}"/>"/>
<input type="hidden" name="endDate" value="<c:out value="${param_s.endDate}"/>"/>
<input type="hidden" id="receiverId" name="receiverId">
<input type="hidden" id="memberId" name="memberId"/>
<c:if test="${!empty View.wpCode}">
<input type="hidden" id="wpCode" name="wpCode" value="${View.wpCode}"/>
</c:if>

<div>
	
	<div style="width:100%">
		<div id="firsttitle" style="width:33%;float:left;">
			<div style="padding:3px 4px;"><a href="#" onclick="fndisplay(1); return false;"><img src="/images/mobile/sub/waterPollutionRegiststep01_on.png" border="0" width="100%"/></a></div> 
		</div>
		<div id="secondtitle" style="width:33%;float:left;">
			<div style="padding:3px 4px;"><a href="#" onclick="fndisplay(2); return false;"><img src="/images/mobile/sub/waterPollutionRegiststep02_off.png" border="0" width="100%"/></a></div> 
		</div>
		<div id="thirdtitle" style="width:33%;float:left;">
			<div style="padding:3px 4px;"><a href="#" onclick="fndisplay(3); return false;"><img src="/images/mobile/sub/waterPollutionRegiststep03_off.png" border="0" width="100%"/></a></div> 
		</div>
	</div>
	<div class="write">
		
		<div id="firststep">
			<div class="titleBx">▶ 신고</div>
			<table> 
				<colgroup> 
					<col width="90px" />
					<col width="*" /> 
				</colgroup> 
				<tr>
					<th>신고일시</th>
					<td>
						<c:if test="${!empty View.wpCode}">
							<c:set var="reportDate" value = "${fn:substring(View.reportDate,0,4)}-${fn:substring(View.reportDate,4,6)}-${fn:substring(View.reportDate,6,8)}"/>
							<c:set var="reportHour" value = "${fn:substring(View.reportDate,8,10)}"/>
							<c:set var="reportMin" value = "${fn:substring(View.reportDate,10,12)}"/>
							<c:out value="${reportDate}"/> <c:out value="${reportHour}"/>시  <c:out value="${reportMin}"/>시 
						</c:if>
						<c:if test="${empty View.wpCode}">
							<input type="text" id="reportDate" datepicker='Y' name="reportDate" size="20" readonly="readonly" onchange="commonWork()" style="width:90px"/>
							<select id="reportHour" name="reportHour"  style="width:20%;"></select>시
							<select id="reportMin" name="reportMin"  style="width:20%;"></select>분
						</c:if>
					</td>
				</tr>
				<tr>
					<th>신고자  <span class="red">*</span></th>
					<td>
						<input type="text" id="reporterName" name="reporterName" maxlength="20"/>
					</td>
				</tr>
				<tr>
					<th>연락처 <span class="red">*</span></th>
					<td>
						<input type="text" id="reporterTelNo" name="reporterTelNo" maxlength="20" value="<c:out value="${View.reporterTelNo}"/>"/>
					</td>
				</tr>
				<tr>
					<th>신고자 소속</th>
					<td>
						<input type="text" id="reporterDept" name="reporterDept"  maxlength="20"/>
					</td>
				</tr>
			</table> 
			
			<div class="titleBx" style="margin-top:20px">▶ 접수</div>
			<table summary="접수정보" style="text-align:left">
				<colgroup> 
					<col width="90px" />
					<col width="*" /> 
				</colgroup> 
				
				<tr>
					<th>접수일시 <span class="red">*</span></th>
					<td>
							<input type="text" id="receiveDate" datepicker='Y' name="receiveDate" size="15" readonly="readonly" onchange="commonWork()" style="width:90px"/>
							<select id="receiveHour" name="receiveHour"  style="width:20%;"></select>시
							<select id="receiveMin" name="receiveMin"  style="width:20%;"></select>분
					</td>
				</tr>
				<tr>
					<th>접수자 <span class="red">*</span></th>
					<td>
						<input type="text" id="receiverName" name="receiverName" size="20" maxlength="20" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<th>연락처 <span class="red">*</span></th>
					<td>
						<input type="text" id="receiverTelNo" name="receiverTelNo" size="20" maxlength="20" readonly="readonly"/>
					</td>
				</tr>
				<tr>
					<th>접수자 소속 <span class="red">*</span></th>
					<td>
					
						<input type="text" id="receiverDept" name="receiverDept" size="58" maxlength="58" readonly="readonly"/>
					</td>
				</tr>
			</table>
			<div style="width:100%">
				<ul class="sbtn" style="width:100%"> 
					<li style="width:90%"><a href="#" onclick="fnSave(1); return false;">다음단계</a></li> 
				</ul>
			</div> 
		</div>
		
		<div id="secondstep" style="display:none;">
			<div class="titleBx" style="margin-top:20px">▶  사고내용</div>
			<table summary="접수정보" style="text-align:left">
				<colgroup> 
					<col width="90px" /> 
					<col width="*" /> 
				</colgroup>
				<tr> 
					<th>사고유형 <span class="red">*</span></th>
					<td>
						<select id="wpKind" name="wpKind">
							<option value="">선택</option>
							<option value="PA">유류유출</option>
							<option value="PB">물고기폐사</option>
							<option value="PC">화학물질</option>
							<option value="PD">기타</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>수계  <span class="red">*</span></th>
					<td>
						<select id="riverDiv" name="riverDiv">
							<option value="">선택</option>
							<option value="R01">한강</option>
							<option value="R02">낙동강</option>
							<option value="R03">금강</option>
							<option value="R04">영산강</option>
						</select>
					</td>
				</tr>
			</table>
			
			<div class="titleBx" style="margin-top:20px">▶ 사고지점</div>
			<table summary="접수정보" style="text-align:left">
				<colgroup> 
					<col width="90px" /> 
					<col width="*" /> 
				</colgroup>
				<tr>
					<td colspan="2">
						<div style="padding:2px 0;"><input type="text" id="address" name="address" size="90" value="<c:out value="${View.address}"/>"/></div>
						<div style="padding:2px 0;"><input type="text" id="addrDet" name="addrDet" size="90"/></div>
					</td>
				</tr> 
				<tr>
					<th>위도</th>
					<td>
						<input type="text" id="latiude" name="latiude" size="40" readonly="readonly" value="<c:out value="${View.latiude}"/>" onclick="lon_lat('<c:out value="${View.latiude}"/>','<c:out value="${View.longituded}"/>');return false;"/>
					</td>
				</tr> 
				<tr>
					<th>경도</th>
					<td>
						<input type="text" id="longituded" name="longituded" size="40"  readonly="readonly" value="<c:out value="${View.longituded}"/>" onclick="lon_lat('<c:out value="${View.latiude}"/>','<c:out value="${View.longituded}"/>');return false;"/>
					</td>
				</tr> 
				<tr>
					<td colspan="2">
						<div style="width:100%">
							<ul class="sbtn" style="width:100%"> 
								<li style="width:90%"><a href="#" onclick="lon_lat('<c:out value="${View.latiude}"/>','<c:out value="${View.longituded}"/>');return false;">지도</a></li> 
							</ul>
						</div> 
					</td>
				</tr> 
			</table>
			
			<div class="titleBx" style="margin-top:20px">▶ 사고내용(상세)</div>
			<table summary="접수정보" style="text-align:left">
				<colgroup> 
					<col width="*" /> 
				</colgroup>
				<tr>
					<td>
						<textarea id="wpContent" name="wpContent" cols="130" rows="5"><c:out value="${View.wpContent}"/></textarea>
					</td>
				</tr> 
			</table>
			<div style="float:left; width:50%;text-align:center;">
				<ul class="sbtn"> 
					<li style="width:90%"><a href="#" onclick="fndisplay(1); return false;">이전단계</a></li> 
				</ul>
			</div>
			<div style="float:left; width:50%;text-align:center;">
				<ul class="sbtn">
					<li style="width:90%"><a href="#" onclick="fnSave(2); return false;">다음단계</a></li> 
				</ul>
			</div>
		</div>
		
		<div id="thirdstep" style="display:none;">
			<div class="titleBx" style="margin-top:20px">▶ SMS</div>
			<table summary="접수정보" style="text-align:left">
				<colgroup> 
					<col width="*" /> 
				</colgroup>
				<tr>
					<td><input type="text" id="smsContent" name="smsContent" size="90" maxlength="80"/></td>
				</tr>
				<tr>
					<td>
						<div style="width:100%">
							<ul class="sbtn" style="width:100%"> 
								<li style="width:90%;">
									<a href="#" onclick="getSmsMsg(); return false;">생성하기</a>
								</li>
							</ul>
						</div> 
					</td>
				</tr>
			</table>
			
			<div class="titleBx" style="margin-top:20px">▶ 전파대상</div>
			<table summary="접수정보" style="text-align:left">
				<colgroup> 
					<col width="90px" /> 
					<col width="*" /> 
				</colgroup>
				<tr>
					<th>대상기관</th>
					<td><select id="dept"></select></td>
				</tr> 
				<tr>
					<th>담당자</th>
					<td><select id="person"></select></td>
				</tr>
				<tr>
					<td colspan="2">
						<div style="width:100%">
							<ul class="sbtn" style="width:100%"> 
								<li style="width:90%;">
									<a href="#" onclick="add(); return false;">추가하기</a>
								</li>
							</ul>
						</div> 
					</td>
				</tr> 
				<tr>
					<td colspan="2" style="min-height:60px;border:1px solid #333333" valign="top">
					<div>
						<div id="smspersons" style="min-height:50px;">
						</div>
					</div>				
					</td>
				</tr>
			</table>
			<div style="float:left; width:50%;text-align:center;">
				<ul class="sbtn"> 
					<li style="width:90%"><a href="#" onclick="fndisplay(2); return false;">이전단계</a></li> 
				</ul>
			</div>
			<div style="float:left; width:50%;text-align:center;">
				<ul class="sbtn">
					<li style="width:90%"><a href="#" onclick="fnSave(3); return false;">등록하기</a></li> 
				</ul>
			</div>
		</div>
	</div>
</div>
</form>

<div id="popupStep" style="display:none;" class="popup">
	<span class="button b-close"><span>X</span></span>
	<iframe id="ifrm" frameborder="0" scrolling="no" style="width:95%;height:280px;"></iframe>
</div>	

</body>
</html>