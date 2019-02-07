<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	* Class Name  : process_popup_sub04.jsp
	* Description : 상황발생이력 상세 화면(경보발령)
	* Modification Information
	* 
	* 수정일			수정자			수정내용
	* -------		--------	---------------------------
	* 2010.11.05	kgb			최초 생성
	* 2014.05.26	lkh			리뉴얼
	* 
	* author khany
	* since 2010.05.17
	* 
	* Copyright (C) 2010 by khany All right reserved.
	*/
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title></title>
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	
	<style type="text/css">
	.btnSearchDiv{height:25px; margin:10px 0 10px 0;}
	.btnSearchDiv .btn_search{border-radius:5px; -webkit-border-radius:5px; -moz-border-radius:5px; background:#A6A6A6; padding:1px 15px; height:25px; line-height:15px;}
	.btnSearchDiv .btn_search:hover{ background:#8DB72A; color:#FFFFFF;}
	.btn {border: medium none;color: #ffffff;cursor: pointer;font-weight: 600;height: 21px;margin-left: 4px;margin-top: 0;text-align: center;z-index: 2;}
	</style>	
	<script type="text/javascript">
	$(function() {
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		
		$("#param1").datepicker({
			buttonText: '경보발령일'
		});
		
		var today = new Date(); 
		var todayStr = today.getFullYear()+ "/" + addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		var time = addzero(today.getHours()) + ":" + addzero(today.getMinutes());
		
		function addzero(n) {
			return n < 10 ? "0" + n : n + "";
		}
		
		$("#param1").val(todayStr);
		$("#param2").val(time);
		
		$("#dataList tr:odd").attr("class","add");
		$("#chkAddSpread").bind("click", function() {chkChange()});
		
		$("#dept").change(function(){
				setPerson();
		});
		
		//$("#person").change(function(){
		
		//});
		
		setDept();
		
		$('#smsMsg').keyup(function(){
			var bytes = ChkByte(detailForm.smsMsg,80);
			$('#byteSpan').html(bytes);
		});
	});
	
	function setDept()
	{
		var dropDownSet = $("#dept");
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
	
	function setPerson()
	{
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
	
	function add() {
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
	
	function del()
	{
		$("#sPerson option:selected").each(function(i){
			//$(this).appendTo('#person');
			$(this).remove();
		});
	}
	
	function sendSMS(){
		var member = new Array;
		var cnt = 0;
		
		$("#sPerson option").each(function() {
			member.push($(this).val());
			cnt++
		});
		
		var smsMsg = $('#smsMsg').val();
		
		if(smsMsg == "") {
			alert("SMS 메시지를 입력하여 주십시요.");
			return;
		}
		
		if(cnt == 0) {
			alert("대상자를 선택하여 주십시요.");
			return;
		}
		
		var regId = "<sec:authentication property="principal.userVO.id"/>";
		
		$.ajax({
			type:"post",
			url:"<c:url value='/alert/sendSms.do'/>",
			data:{system:null, sugye:null, factCode:null, branchNo:null, memberId:member,
					smsMsg:smsMsg, regId:regId, actKind:"A"},
			dataType:"json",
			success:function(result){
				var cnt = result['cnt'];
				if(cnt == '0') {
					alert("전송에 실패했습니다.");
				} else {
					alert("SMS 발송을 등록하였습니다\n(실제 발송 여부는 TMS의 SMS서버 상태에 따라 다를 수 있습니다.");
					$('#smsMsg').attr('value','');
				}
			},
			error:function(result){alert("error");isProcess = false;}
		});
		
	}
	
	function ChkByte(objname,maxlength) {  
		var objstr = objname.value; // 입력된 문자열을 담을 변수 
		var objstrlen = objstr.length; // 전체길이 
		
		// 변수초기화 
		var maxlen = maxlength; // 제한할 글자수 최대크기 
		var i = 0; // for문에 사용 
		var bytesize = 0; // 바이트크기 
		var strlen = 0; // 입력된 문자열의 크기
		var onechar = ""; // char단위로 추출시 필요한 변수 
		var objstr2 = ""; // 허용된 글자수까지만 포함한 최종문자열
		
		// 입력된 문자열의 총바이트수 구하기
		for(i=0; i< objstrlen; i++) {
			// 한글자추출 
			onechar = objstr.charAt(i);
			
			if (escape(onechar).length > 4) {
				bytesize += 2;	// 한글이면 2를 더한다.
			} else {  
				bytesize++;	 // 그밗의 경우는 1을 더한다.
			}
			
			if(bytesize <= maxlen) {	// 전체 크기가 maxlen를 넘지않으면 
				strlen = i + 1;	// 1씩 증가
			}
		}
		
		// 총바이트수가 허용된 문자열의 최대값을 초과하면 
		if(bytesize > maxlen) { 
			objstr2 = objstr.substr(0, strlen);
			objname.value = objstr2;
			
			bytesize = bytesize - 1;
		} 
		
		return bytesize;
	}
	
	function fncSave() {
		if(validate())
			{
			if(confirm("진행하시겠습니까?"))
			{
					frm = document.detailForm;
					frm.action = "<c:url value='/alert/addAlertStep.do'/>";
					frm.submit();
			}
		}
	}

	function fnBack(){
		var message = "이전단계로 이동하시겠습니까?\r\n(현재 단계의 작성내용은 삭제됩니다.)";
		if(confirm(message))
		{
			frm = document.detailForm;
			frm.alertStep.value = "${asData.alertStep}"; //장비이상
			frm.action = "<c:url value='/alert/prevAlertStep.do'/>";
			frm.submit();
		}
	}
	
	function validate() {
		var time1 = $("#param2").val();
		
		if(time1.split(":").length < 2 || (time1.length != 5))
		{
			alert("출동시간 형식이 잘못되었습니다!");
			$("#param2").focus();
			return false;
		}
		if(!numCheck(time1.split(":")[0]))
		{
			alert("출동시간 형식이 잘못되었습니다!");
			$("#param2").focus();
			return false;
		}
		if(!numCheck(time1.split(":")[1]))
		{
			alert("출동시간 형식이 잘못되었습니다!");
			$("#param2").focus();
			return false;
		}
		return true;
	}
	
	function numCheck(str){
		for(var index = str.length-1; index>=0; index--){
				splitchar = str.charAt(index);
				if (isNaN(splitchar)) {
				return false
				}
		}
		return true;
	}
	
	function goSMS(){
		var SMS="["+$('#str1').val().trim()+"]"+$('#str2').val().trim()+""+$('#str3').val().trim()+" 4/6 완료";
		$('#smsMsg').val(SMS);
	}
	</script>
</head>
<body class="pop_basic">

<div class="situationprocessPop2">
	<jsp:include page="/WEB-INF/jsp/alert/CommonAlertMngNumber.jsp">
		<jsp:param name="listparameter" value="?asId=${param.asId}&pageIndex=${param.pageIndex}&itemType=${param.itemType}&system=${param.system}&startDate=${param.startDate}&endDate=${param.endDate}&minOr=${param.minOr}&step"/>
		<jsp:param value="${asData.alertStep}" name="alertStep"/>
		<jsp:param value="${AllstepList}" name="AllstepList"/>
		<jsp:param value="4" name="stepno"/>
	</jsp:include>
	<hr noshade="noshade" />
	<!-- data -->
	<div class="data">
		<!-- overBox -->
		<div class="overBox2">
		<!-- SMS 내용 작성을 위한 데이터 -->
		<input type="hidden" id="str1" value="<c:if test="${asData.factCode != '50A0001'}">
										<c:out value="${asData.branchName}"/>-<c:out value="${asData.branchNo}"/>
									</c:if>
									<c:if test="${asData.factCode eq '50A0001'}">
										임의지점
									</c:if>"/>
		<input type="hidden" id="str2" value="<c:out value="${asData.itemTypeName}"/>"/>
		<input type="hidden" id="str3" value="<c:if test="${asData.itemType == null || asData.itemType eq ''}">
										<c:if test="${asData.system eq 'T'}">
											(탁수 모니터링)
										</c:if>
										<c:if test="${asData.system eq 'U'}">
											(이동형측정기기)
										</c:if>
										<c:if test="${asData.system eq 'A'}">
											(국가수질자동측정망)
										</c:if>
									</c:if>"/>
		<!-- 추가 내용 끝	-->
		<form:form commandName="alertStepVO" name="detailForm" method="post" cssClass="writeForm" onsubmit="return false;">
			<input type="hidden" name="asId" value="${asData.asId}"/>
			<input type="hidden" name="alertStep" value="5"/> 
			<input type="hidden" name="alertStepText" value=" "/>
			<input type="hidden" name="isSendSMS" value="false"/>
			<input type="hidden" id="pageIndex" name="pageIndex" value="${param.pageIndex}"></input>
			<input type="hidden" id="itemType" name="itemType" value="${param.itemType}"></input>
			<input type="hidden" id="system" name="system" value="${param.system}"></input>
			<input type="hidden" id="startDate" name="startDate" value="${param.startDate}"></input>
			<input type="hidden" id="endDate" name="endDate" value="${param.endDate}"></input>
			<input type="hidden" id="minOr" name="minOr" value="${param.minOr}"></input>
			
			<!-- dataTable -->
			<table class="dataTable">
			<colgroup>
				<col width="180" />
				<col />
			</colgroup>
			<tr>
				<th scope="col" colspan="1" class="bgStyle">경보발령 시간</th>
				<td style="text-align:left;padding-left:10px">
					<c:if test='${isReview == false}'>
							<input class="inputText" type="text" id="param1" size="15" name="warnDate"/>&nbsp;<input class="inputText" type="text" id="param2" name="warnTime" size="5"/>
					</c:if>
					<c:if test='${isReview == true}'>
						${reviewData[0]}
					</c:if>
				</td>
			</tr>
		<c:if test='${isReview == false}'>
			<tr>
				<td colspan="2">
						<div class="groupSelector">
							<!-- 그룹선택-->
							<div class="groupBg2">
								<div class="groupTit2">대상기관</div>
								<select class="selectMultiple2" multiple="multiple" id="dept"></select>
							</div>
							<div class="groupBtn">
								<img src="<c:url value='/images/common/arrow_yellow.gif'/>" alt="다음단계" />
							</div>
							<div class="groupBg">
								<div class="groupTit">담당자</div>
								<select class="selectMultiple" multiple="multiple" id="person"></select>
							</div>
							<div class="groupBtn2">
								<a href="javascript:add()"><img src="<c:url value='/images/common/btn_getIns.gif'/>" alt="추가" /></a>
								<br />&nbsp;<br />
								<a href="javascript:del()"><img src="<c:url value='/images/common/btn_getDel.gif'/>" alt="삭제" /></a>
							</div>
							<div class="groupBg">
								<div class="groupTit">전파대상자</div>
								<select class="selectMultiple" multiple="multiple" id="sPerson"></select>
							</div>
							<!--// 그룹선택-->
						</div>
				</td>
			</tr>
			<tr>
				<td colspan="2" class="txt2">
				<input type="text" class="inputText" id="smsMsg" name="smsMsg" size="80" style="text-align:left;"/>&nbsp;
				<span id="byteSpan">0</span> / 80 Byte &nbsp;&nbsp;
				<a href="javascript:goSMS();"><img src="<c:url value='/images/common/ico2.gif'/>" alt="SMS생성"/></a>&nbsp;&nbsp;
				<a href="javascript:sendSMS()"><img src="<c:url value='/images/common/btn_sms.gif'/>" alt="SMS발송" /></a>
				</td>
			</tr>
		</c:if>
		</table>
		<!--// dataTable -->
	</form:form>
	
	<div class="btnSearchDiv">
		<c:if test='${isReview == false}'>
			<div style="float:right;">
				<input type="button" id="btnSearch" name="btnSearch" value="<< 이전단계" class="btn btn_search" onclick="javascript:fnBack();" alt="<< 이전단계" />
				<input type="button" id="btnSearch" name="btnSearch" value="상황 조치" class="btn btn_search" onclick="javascript:fncSave();" alt="상황 조치"/>
			</div>
		</c:if>
	</div>	
	
	</div>
	<!-- overBox -->
	</div>
	<!--// data -->
</div>
</body>
</html>