<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pj" uri="ProjectJstlUtil"%>
<%pageContext.setAttribute("crlf", "\r\n");%> 
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="상황관리" name="title"/>
</jsp:include>
<script type="text/javascript">
$(function() {
	setTime();
	
	setDept();
	
	$("#param1").change(function(){
		setPerson();
	});
	
	$("#param2").change(function(){
		setPhoneNum();	
	});
	
	//SELECT OPTION 삭제
	$.fn.emptySelect = function() {
		return this.each(function(){
			if (this.tagName=='SELECT') this.options.length = 0;
		});
	}
	
	//SELECT OPTION 등록
	$.fn.loadSelect_dept = function(optionsDataArray) {
		return this.emptySelect().each(function(){
			if (this.tagName=='SELECT') {
				var selectElement = this;
				$.each(optionsDataArray,function(idx, optionData){
					
					var option;
					
					if(optionData.CAPTION != undefined)
						option= new Option(optionData.CAPTION, optionData.VALUE);
					else
						option = new Option(optionData.caption, optionData.value);
					
					if (browser.name) {
						selectElement.add(option);
					}
					else {
						selectElement.add(option,null);
					}
				});
			}
		});
	}
	
	$.fn.loadSelect_person = function(optionsDataArray) {
		return this.emptySelect().each(function(){
			if (this.tagName=='SELECT') {
				var selectElement = this;
				$.each(optionsDataArray,function(idx, optionData){
					
					var option;
					
					if(optionData.CAPTION != undefined)
						option= new Option(optionData.CAPTION, optionData.MOBILE_NO);
					else
						option = new Option(optionData.caption, optionData.MOBILE_NO);
					
				
					if (browser.name) {
						selectElement.add(option);
					}
					else {
						selectElement.add(option,null);
					}
				});
			}
		});
	}
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
		$("#procStartHour").append(item);
		$("#procEndHour").append(item);
	}
	
	for(var i=0 ; i< 60 ; i++){
		var temp = addzero(i);
		var item = "<option value='"+temp+"'>"+temp+"</option>";
		$("#procStartMin").append(item);
		$("#procEndMin").append(item);
	}
	
	$("#procStartDate").val(today);
	$("#procEndDate").val(today);
	$("#procStartHour").val(curr_hour);
	$("#procStartMin").val(curr_min);
	
	$("#procEndHour").val(curr_hour);
	$("#procEndMin").val(curr_min);
}

function addzero(n) {
	return n < 10 ? "0" + n : n + "";
}

function setDept()
{
	var dropDownSet = $("#param1");
	$.getJSON("<c:url value='/alert/getGroupAndMember.do'/>", 
			{
				orderType:"1",
				step:"3"
			},
			//, system:sys_kind}, 
			function (data, status){
			if(status == 'success'){	
				//locId 객체에 SELECT 옵션내용 추가.
				
				dropDownSet.loadSelect_dept(data.groupList);
				
				setPerson();
				//adjustBranchList();
					
			} else { 
				return;
			}
	});
}

function setPerson()
{
	var value = $("#param1 > option:selected").val();
	var dropDownSet = $("#param2");
	
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
				
				dropDownSet.loadSelect_person(data.groupList);
				//adjustBranchList();
				setPhoneNum();	
				
			} else { 
				return;
			}
	});
}

function setPhoneNum()
{
	$("#param3").val($("#param2").val());
}

function fnSave() {

	if(!vailidation($("#param8"),'내용을 입력해 주세요.')) return false;
	
	if(confirm("상황 종료로 진행하시겠습니까? \r\n 상황종료 후에는 수정이 불가 합니다."))
	{
		frm = document.frm1;
		frm.procGov.value = $("#param1 > option:selected").text().replace(">","-");
		frm.procPerson.value = $("#param2 > option:selected").text();
		$("#procStartTime").val($("#procStartHour").val() + ":" + $("#procStartMin").val());
		$("#procEndTime").val($("#procEndHour").val() + ":" + $("#procEndMin").val());
		frm.action = "<c:url value='/mobile/sub/alert/addAlertStep.do'/>";
		frm.submit();
	}
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
<input type="hidden" name="alertStep" value="8"/> 
<div> 
    
	<c:set var="listparameter" value='${pj:ParamString(param_s,"system,startDate,endDate,itemType,minOr,asId")}&alertStep'/>
	<jsp:include page="/WEB-INF/jsp/mobile/sub/alert/CommonAlertMngNumber.jsp">
		<jsp:param value="${listparameter}" name="listparameter"/>
		<jsp:param value="5" name="stepno"/>
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
				<th>작성기관</th>
				<td>
					<c:if test='${isReview == false}'>
							<input type="hidden" name="procGov" id="param1_hidden"/>
							<select id="param1">
							</select>
					</c:if>
					<c:if test='${isReview == true}'>
						<c:out value="${reviewData[0]}"/>
					</c:if>
				</td>
			</tr>
			<tr>
				<th>담당자</th>
				<td>
					<c:if test='${isReview == false}'>
						<input type="hidden" name="procPerson" id="param2_hidden"/>
						<select id="param2">
						</select>
					</c:if>
					<c:if test="${isReview == true}">
						<c:out value="${reviewData[1]}"/>
					</c:if>
				</td>
			</tr>
			<tr>
				<th>연락처</th>
				<td>
					<c:if test='${isReview == false}'>
						<input type="text" class="inputText" size="16" name="procPhone" id="param3"/>
					</c:if>
					<c:if test="${isReview == true}">
						<c:out value="${reviewData[2]}"/>
					</c:if>
				</td>
			</tr>
			<tr>
				<th>조치시작시간</th>
				<td>
						<c:if test='${isReview == false}'>
							<input type="text" id="procStartDate" datepicker='Y' name="procStartDate" size="15" readonly="readonly" style="width:80px"/>
							<select id="procStartHour" name="procStartHour"  style="width:20%;"></select>시
							<select id="procStartMin" name="procStartMin"  style="width:20%;"></select>분
							<input type="hidden" class="inputText" size="4" name="procStartTime" id="procStartTime"/>
						</c:if>
				</td>
			</tr>
			<tr>
				<th>조치종료시간 </th>
				<td>
						<c:if test='${isReview == false}'>
							<input type="text" id="procEndDate" datepicker='Y' name="procEndDate" size="15" readonly="readonly" style="width:80px"/>
							<select id="procEndHour" name="procEndHour"  style="width:20%;"></select>시
							<select id="procEndMin" name="procEndMin"  style="width:20%;"></select>분
							<input type="hidden" class="inputText" size="4" name="procEndTime" id="procEndTime"/>
						</c:if>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<c:if test='${isReview == false}'>
						<textarea rows="" cols="" id="param8" name="alertStepText"></textarea>
					</c:if>
					<c:if test="${isReview == true}">
						<c:out value='${fn:replace(reviewData[5],crlf,"<BR/>")}' escapeXml="false"/>
					</c:if>
				</td>
			</tr>
		</table> 
		
		<c:if test='${isReview == false}'>
			<div style="float:left; width:50%;text-align:center;">
				<ul class="sbtn"> 
					<li style="width:90%"><a href="#" onclick="fnBack(); return false;"><< 뒤로가기</a></li>
				</ul>
			</div>
			<div style="float:left; width:50%;text-align:center;">
				<ul class="sbtn">
					<li style="width:90%"><a href="#" onclick="fnSave(); return false;">상황종료 >></a></li>
				</ul>
			</div>
		</c:if>
	</div>
</div>

</form>
</body>
</html>