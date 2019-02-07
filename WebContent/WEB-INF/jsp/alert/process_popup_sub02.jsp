<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : process_popup_sub02.jsp
	 * Description : 상황발생이력 상세 화면(현장확인)
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
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/jquery.form.js'/>"></script>
	<style type="text/css">
	.btnSearchDiv{height:25px; margin:10px 0 10px 0;}
	.btnSearchDiv .btn_search{border-radius:5px; -webkit-border-radius:5px; -moz-border-radius:5px; background:#A6A6A6; padding:1px 15px; height:25px; line-height:15px;}
	.btnSearchDiv .btn_search:hover{ background:#8DB72A; color:#FFFFFF;}
	.btn {border: medium none;color: #ffffff;cursor: pointer;font-weight: 600;height: 21px;margin-left: 4px;margin-top: 0;text-align: center;z-index: 2;}
	</style>	
	<script type="text/javascript">
	$(function () {
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		
		$("#param4").datepicker({
			buttonText: '출동일'
		});
		$("#param6").datepicker({
			buttonText: '도착일'
		});
		$("#date").datepicker({
			buttonText: '조치일'
		});
		
		var today = new Date(); 
		var todayStr = today.getFullYear()+ "/" + addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		
		var time = addzero(today.getHours()) + ":" + addzero(today.getMinutes());
		
		function addzero(n) {
			return n < 10 ? "0" + n : n + "";
		}
		
		$("#param4").val(todayStr);
		$("#param5").val(time);
		
		$("#param6").val(todayStr);
		$("#param7").val(time);
		
		$("#date").val(todayStr);
		$("#time").val(time);
		
		$("#param1").change(function(){
			setPerson();		
			setFellowRider();
		});
		
		$("#param2").change(function(){
			setPhoneNum();
		});
		
		var strName = '${strName}';
		var DeptNo  = '${DeptNo}';
		
		setDept(DeptNo, strName);
		
		$('#param9').change(function(){
			changeResult();
		});
		
		changeResult();
	});
	
	function setFellowRider()
	{
		var value = $("#param1 > option:selected").val();
		var dropDownSet = $("#param8");
		
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
	
	function setDept(DeptNo, strName){
		var dropDownSet = $("#param1");
		$.getJSON("<c:url value='/alert/getGroupAndMember.do'/>", 
			{
				orderType:"1",
				step:"1"
			},
			//, system:sys_kind}, 
			function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					dropDownSet.loadSelect_dept(data.groupList);
					
					var optionCnt = $('#param1 option').size();
					
					for(var i=0 ; i<optionCnt ; i++){
						if( DeptNo == document.getElementById('param1').options[i].value){
							document.getElementById('param1').options[i].selected = 'selected';
						}
					}
					
					setPerson(strName);
					setFellowRider();
					//adjustBranchList();
					
				}else{ 
					return;
				}
			});
	}
	
	function setPerson(strName)
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
					
					var optionCnt = $('#param2 option').size();
					
					for(var i=0 ; i<optionCnt ; i++){
						if( strName == document.getElementById('param2').options[i].text){
							document.getElementById('param2').options[i].selected = 'selected';
						}
					}
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
	
	function changeResult()
	{
		var value = $('#param9').val();
		var spanBtn = $("#spanBtn");
		
		var btn1 = $("#btn1");
		
		if(value == "1")
		{
			spanBtn.hide();
			btn1.show();	
		}
		else
		{
			spanBtn.show();
			btn1.hide();
		}
	}
	
	function validate()
	{
		for(idx = 1;idx<=10;idx++)
		{
			var data = $("#param" + idx);
			var value = data.val();
			
			if(value == "")
			{
				alert("데이터를 입력해 주세요!")
				data.focus();
				return false;
			}
		}
		
		var time1 = $("#param5").val();
		
		if(time1.split(":").length < 2 || (time1.length != 5))
		{
			alert("현장확인 시간 형식이 잘못되었습니다!");
			$("#param5").focus();
			return false;
		}
		if(!numCheck(time1.split(":")[0]))
		{
			alert("현장확인 시간 형식이 잘못되었습니다!");
			$("#param5").focus();
			return false;
		}
		if(!numCheck(time1.split(":")[1]))
		{
			alert("현장확인 시간 형식이 잘못되었습니다!");
			$("#param5").focus();
			return false;
		}
		
		var value = $('#param9').val();
		
		if(value != "1")
		{
			var time1 = $("#time").val();
			
			if(time1.split(":").length < 2 || (time1.length != 5))
			{
				alert("조치시간 형식이 잘못되었습니다!");
				$("#time").focus();
				return false;
			}
			if(!numCheck(time1.split(":")[0]))
			{
				alert("조치시간 형식이 잘못되었습니다!");
				$("#time").focus();
				return false;
			}
			if(!numCheck(time1.split(":")[1]))
			{
				alert("조치시간 형식이 잘못되었습니다!");
				$("#time").focus();
				return false;
			}
		}
		return true;
	}
	
	function numCheck(str)
	{
		for(var index = str.length-1; index>=0; index--){
				splitchar = str.charAt(index);
				if (isNaN(splitchar)) {
				return false
				}
		}
		return true;
	}
	
	function clear(obj)
	{
		obj.value = "";
	}
	
	function fncSave() {
		if(validate())
		{
			if(confirm("진행하시겠습니까?"))
			{	
				frm = document.detailForm;
				frm.gov.value = $("#param1 > option:selected").text().replace(">","-");
				frm.person.value = $("#param2 > option:selected").text();
				frm.fellowRider.value = $("#param8 > option:selected").text();
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

	function deviceError(){
		if(validate())
		{
			if(confirm("[장비이상] 진행하시겠습니까?"))
			{
				frm = document.detailForm;
				frm.gov.value = $("#param1 > option:selected").text().replace(">","-");
				frm.person.value = $("#param2 > option:selected").text();
				frm.fellowRider.value = $("#param8 > option:selected").text();
				frm.alertStep.value = "6"; //장비이상
				frm.action = "<c:url value='/alert/addAlertStep.do'/>";
				frm.submit();
			}
		}
	}
	
	///동적 SELECTBOX 구현을 위한 사용자 함수
	$(function() {
		
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
						
						if ($.browser.msie) {
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
						
						if ($.browser.msie) {
							selectElement.add(option);
						}
						else {
							selectElement.add(option,null);
						}
					});
				}
			});
		}
	})
	</script>
</head>
<body class="pop_basic">

<div class="situationprocessPop2">
	<jsp:include page="/WEB-INF/jsp/alert/CommonAlertMngNumber.jsp">
		<jsp:param name="listparameter" value="?asId=${param.asId}&pageIndex=${param.pageIndex}&itemType=${param.itemType}&system=${param.system}&startDate=${param.startDate}&endDate=${param.endDate}&minOr=${param.minOr}&step"/>
		<jsp:param value="${asData.alertStep}" name="alertStep"/>
		<jsp:param value="${AllstepList}" name="AllstepList"/>
		<jsp:param value="2" name="stepno"/>
	</jsp:include>
<!-- 	<hr noshade="noshade" /> -->
 <!-- data -->
	<div class="data">
		<!-- overBox -->
		<div class="overBox2">
		
	<form:form commandName="alertStepVO" name="detailForm" method="post" cssClass="writeForm" onsubmit="return false;">
		<input type="hidden" name="asId" value="${asData.asId}"/>
		<input type="hidden" name="alertStep" value="3"/>
		<input type="hidden" id="pageIndex" name="pageIndex" value="${param.pageIndex}"></input>
		<input type="hidden" id="itemType" name="itemType" value="${param.itemType}"></input>
		<input type="hidden" id="system" name="system" value="${param.system}"></input>
		<input type="hidden" id="startDate" name="startDate" value="${param.startDate}"></input>
		<input type="hidden" id="endDate" name="endDate" value="${param.endDate}"></input>
		<input type="hidden" id="minOr" name="minOr" value="${param.minOr}"></input>
			<!-- dataTable -->
							<table class="dataTable">
									<colgroup>
										<col width="150" />
										<col />
										<col width="150" />
										<col />
										<col width="150" />
										<col />
									</colgroup>
								
							<tr>
								<th scope="row"><label for="">담당기관</label></th>
								<c:if test='${isReview == false}'>
									<td>
										<input type="hidden" name="gov" id="param1_hidden"/>
										<select id="param1" name="param1" style="width:140px">
										</select>
									</td>
								</c:if>
								<c:if test='${isReview == true}'>
									<td>${reviewData[0]}</td>
								</c:if>
								<th scope="row"><label for="">담당자</label></th>
								<c:if test='${isReview == false}'>
									<td>
										<input type="hidden" name="person" id="param2_hidden"/>
										<select id="param2" name="param2" style="width:108px">
										</select>
									</td>
								</c:if>
								<c:if test="${isReview == true}">
									<td>${reviewData[1]}</td>
								</c:if>
								<th scope="row"><label for="">연락처</label></th>
								<c:if test='${isReview == false}'>
									<td><input type="text" class="inputText" size="16" name="phone" id="param3"/></td>
								</c:if>
								<c:if test="${isReview == true}">
									<td>${reviewData[2]}</td>
								</c:if>
							</tr>
							<tr>
								<th scope="row"><label for="">현장확인시간</label></th>
								<c:if test='${isReview == false}'>
									<td><input type="text" class="inputText" size="9" name="date" id="param4"/>
											<input type="text" class="inputText" size="4" name="time" id="param5"/>
									</td>
								</c:if>
								<c:if test="${isReview == true}">
									<td>${reviewData[3]}</td>
								</c:if>
								<th scope="row"><label for=""></label></th>
								<c:if test='${isReview == false}'>
									<td>
										<span style="display:none">
											<input type="text" class="inputText" size="9" name="reachDate" id="param6"/>
											<input type="text" class="inputText" size="4" name="reachTime" id="param7"/>
										</span>
									</td>
								</c:if>
								<c:if test="${isReview == true}">
									<td><span style="display:none">${reviewData[4]}</span></td>
								</c:if>
								<th scope="row"><label for=""></label></th>
								<c:if test='${isReview == false}'>
									<td>
										<span style="display:none">
										<input type="hidden" name="fellowRider" id="param8_hidden"/>
										<select id="param8" style="width:108px">
										</select>
										</span>
									</td>
								</c:if>
								<c:if test="${isReview == true}">
								<span style="display:none">
									<td>${reviewData[5]}</td>
								</span>
								</c:if>
								
							</tr>
							<tr>
								<th scope="row"><label for="">확인결과</label></th>
					<c:if test='${isReview == false}'>
								<td colspan="5" class="txt2">
									<select class="selectList3" name="result" id="param9">
										<option value="1">시료채수</option>
										<option value="2">장비이상</option>
									</select>
									<span id="spanBtn">
											&nbsp; 조치시간 : <input type="text" class="inputText" size="9" name="procEndDate" id="date"/>
											<input type="text" class="inputText" size="4" name="procEndTime" id="time"/>
									&nbsp;<a href="javascript:deviceError()"><img src="<c:url value='/images/common/btn_action.gif'/>" alt="조치" /></a>
									</span>
								</td>
					</c:if>
					<c:if test="${isReview == true}">
						<td colspan="5" class="txt2">${reviewData[6]}</td>
						<select id="param7" style="display:none"/>
						<span id="span1" style="display:none"/>
						<span id="span2" style="display:none"/>
					</c:if>
							</tr>
							<tr>
								<th scope="row"><label for="">내용</label></th>
								<td colspan="5" class="txt2">
								<c:if test='${isReview == false}'>
									<textarea rows="" cols="" id="param10" name="alertStepText" style="width:795px; height:470px;"></textarea>
								</c:if>
								<c:if test="${isReview == true}">
									<textarea rows="" cols="" style="width:795px; height:470px;" disabled="disabled">${reviewData[7]}</textarea>
								</c:if>
								</td>
							</tr>
							
						</table>
		<!--// dataTable -->
	</form:form>
	
	<div class="btnSearchDiv">
		<c:if test='${isReview == false}'>
			<div style="float:right;">
				<input type="button" id="btnSearch" name="btnSearch" value="<< 이전단계" class="btn btn_search" onclick="javascript:fnBack();" alt="<< 이전단계" />
				<input type="button" id="btnSearch" name="btnSearch" value="시료 분석" class="btn btn_search" onclick="javascript:fncSave();" alt="시료 분석"/>
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
