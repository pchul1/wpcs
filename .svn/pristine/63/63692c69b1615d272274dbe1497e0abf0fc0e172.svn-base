<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="pj" uri="ProjectJstlUtil"%>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="상황관리" name="title"/>
</jsp:include>
<script type="text/javascript">
$(function() {
	setTime();

	$("#dept").change(function(){
		setPerson(); //직원셋팅
	});

	setDept();		//부서셋팅
});

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
		$("#Hour").append(item);
	}
	
	for(var i=0 ; i< 60 ; i++){
		var temp = addzero(i);
		var item = "<option value='"+temp+"'>"+temp+"</option>";
		$("#Min").append(item);
	}
	
	$("#warnDate").val(today);
	$("#Hour").val(curr_hour);
	$("#Min").val(curr_min);
}


function addzero(n) {
	return n < 10 ? "0" + n : n + "";
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

function sendSMS(){
	var member = new Array;
	var cnt = 0;

	$("input[name='personval'").each(function() {
		member.push($(this).val());
		cnt++;
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

function fnSave() {
	var message = "진행하시겠습니까?";
	
	if(confirm(message))
	{
		frm = document.frm1;
		$("#warnTime").val($("#Hour").val() + ":" + $("#Min").val());
		frm.action = "<c:url value='/mobile/sub/alert/addAlertStep.do'/>";
		frm.submit();
	}
}

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

function goSMS(){
	var SMS="["+$('#str1').val().trim()+"]"+$('#str2').val().trim()+""+$('#str3').val().trim()+" 4/6 완료";
	$('#smsMsg').val(SMS);
}

function fnBack(){
	var message = "이전단계로 이동하시겠습니까?\r\n(현재 단계의 작성내용은 삭제됩니다.)";
	if(confirm(message))
	{
		frm = document.frm1;
		frm.alertStep.value = "<c:out value="${asData.alertStep}"/>"; //장비이상
		frm.action = "<c:url value='/mobile/sub/alert/prevAlertStep.do'/>";
		frm.submit();
	}
}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/alert/alertMngSearch.do" name="link"/>
		<jsp:param value="상황관리" name="title"/>
	</jsp:include>
<form name="frm1" method="post" onsubmit="return false;">
	<input type="hidden" name="asId" value='<c:out value="${asData.asId}"/>'/>
	<input type="hidden" name="alertStep" value="5"/> 
	<input type="hidden" name="alertStepText" value=" "/>
	<input type="hidden" name="isSendSMS" value="false"/>
		<!-- SMS 내용 작성을 위한 데이터 -->
	<input type="hidden" id="str1" value="<c:if test="${asData.factCode != '50A0001'}">
											<c:out value="${asData.branchName}"/>-<c:out value="${asData.branchNo}"/>
										</c:if>
										<c:if test="${asData.factCode eq '50A0001'}">
											임의지점
										</c:if>"/>
	<input type="hidden" id="str2" value="<c:out value="${asData.itemTypeName}"/>"/>
	<input type="hidden" id="str3" value="<c:if test="${asData.itemType == null || asData.itemType eq ''}">
											<c:if test="${asData.system eq 'U'}">
												(이동형측정기기)
											</c:if>
											<c:if test="${asData.system eq 'A'}">
												(국가수질자동측정망)
											</c:if>
										</c:if>"/>
<div> 
    
	<c:set var="listparameter" value='${pj:ParamString(param_s,"system,startDate,endDate,itemType,minOr,asId")}&alertStep'/>
	<jsp:include page="/WEB-INF/jsp/mobile/sub/alert/CommonAlertMngNumber.jsp">
		<jsp:param value="${listparameter}" name="listparameter"/>
		<jsp:param value="4" name="stepno"/>
		<jsp:param value="${asData.alertStep}" name="alertStep"/>
		<jsp:param value="${AllstepList}" name="AllstepList"/>
	</jsp:include>
	<div class="write">
		<table> 
			<colgroup> 
				<col width="120px" />
				<col width="*" /> 
			</colgroup> 
			<tr>
				<th>경보발령시간</th>
				<td>
					<c:if test='${isReview == false}'>
					<input type="text" id="warnDate" datepicker='Y' name="warnDate" size="15" readonly="readonly" style="width:80px"/>
					<select id="Hour" name="Hour"  style="width:20%;"></select>시
					<select id="Min" name="Min"  style="width:20%;"></select>분
					<input type="hidden" class="inputText" size="4" name="warnTime" id="warnTime"/>
					</c:if>
					<c:if test='${isReview == true}'>
						<c:out value="${reviewData[0]}"/>
					</c:if>
				</td>
			</tr>
			<c:if test='${isReview == false}'>
			<tr>
				<th>대상기관</th>
				<td><select id="dept"></select></td>
			</tr>
			<tr>
				<th>대상자</th>
				<td><select id="person"></select></td>
			</tr>
			<tr>
				<td colspan="2">
					<div style="width:100%;">
						<ul class="sbtn"> 
							<li style="width:90%"><a href="#" onclick="add(); return false;">추가하기</a></li>
						</ul>
					</div>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div id="smspersons" style="min-height:50px;">
					</div>
				</td>
			</tr>		
			<tr>
				<td colspan="2">
					<textarea name="smsMsg" id="smsMsg"></textarea>
				</td>
			</tr>
					
			<tr>
				<td colspan="2">
				<div style="float:right;right:0;margin:0;">
					<div style="float:left; width:80px;">
						<ul class="sbtn" style="margin:0 5px 0 0;height:20px;"> 
							<li style="width:90%;height:20px;font-size:9pt;"><a href="#" onclick="goSMS(); return false;" style="padding: 7px 0;">생성</a></li>
						</ul>
					</div>
					<div style="float:left; width:80px;">
						<ul class="sbtn" style="margin:0 0 0 5px;height:20px;"> 
							<li style="width:90%;height:20px;font-size:9pt;"><a href="#" onclick="sendSMS(); return false;" style="padding: 7px 0;">SMS발송</a></li>
						</ul>
					</div>
				</div>
				</td>
			</tr>
			</c:if>
		</table>
		
		<c:if test='${isReview == false}'>
			<div style="float:left; width:50%;text-align:center;">
				<ul class="sbtn"> 
					<li style="width:90%"><a href="#" onclick="fnBack(); return false;"><< 뒤로가기</a></li>
				</ul>
			</div>
			<div style="float:left; width:50%;text-align:center;">
				<ul class="sbtn">
					<li style="width:90%"><a href="#" onclick="fnSave(); return false;">상황조치 >></a></li>
				</ul>
			</div>
		</c:if>
	</div>
</div>
</form>

</body>
</html>