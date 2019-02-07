<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<% 
	List<Map<String,String>> test = (ArrayList<Map<String,String>>)(request.getAttribute("codes"));
%>
<%
  /**
  * @Class Name : alertTargetWrite.jsp
  * @Description : Alert Target 등록 화면
  * @Modification Information
  * 
  *   수정일		 수정자				   수정내용
  *  -------	--------	---------------------------
  *  2010.05.20	 k			최초 생성
  *
  * author k
  * since 2010.05.20
  *  
  * Copyright (C) 2010 by k  All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />		
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<sec:authorize ifAnyGranted="ROLE_USER">
		<script  type='text/javascript'>
			var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
		</script> 
	</sec:authorize>
	
<%-- 	<sec:authorize ifNotGranted="ROLE_USER"> --%>
<!-- 		<script  type='text/javascript'> -->
<!-- 			alert('로그인이 필요한 페이지 입니다'); -->
<%-- 			window.location = "<c:url value='/'/>";  --%>
<!-- 		</script>  -->
<%-- 	</sec:authorize>		 --%>
	<script>
		var isProcess = false;
		
		$(function(){
			$('#save').click(function () {
				save();	
			});		
		});

		function save() {
			if(!validation()) { return; }

			document.dataFrm.action = "<c:url value='/alert/saveAlertTargetData.do'/>";
			document.dataFrm.submit();
		}	
			
		function validation() {
			if($('input[name=atName]').val() == "") { 
				alert("이름을 입력하여 주십시요."); 
				return false;
			}
			if($('input[name=atDept]').val() == "") {
				alert("조직을 선택하여 주십시요."); 
				return false;
			}			
			if($('input[name=atPart]').val() == "") {
				alert("소속을 입력하여 주십시요."); 
				return false;
			}
			if($('input[name=atPosition]').val() == "") {		
				alert("직위를 입력하여 주십시요."); 
				return false;
			}
			if($('input[name=atArsTele]').val() == "") {
				alert("전화번호를 입력하여 주십시요."); 
				return false;
			}			
			if($('input[name=atSmsTele]').val() == "") {		
				alert("핸드폰번호를 입력하여 주십시요."); 
				return false;
			}						
				
			return true;							
		}			
	</script>		
</head>
<body class="popup_sms">
<div id="wrap">
	<div class="smsSection">
		<h1><img src="<c:url value='/images/popup/h1_alertTarget.gif'/>" alt="전파 대상 등록" /></h1>
			<form:form commandName="alertTargetVO" id="dataFrm" name="dataFrm" method="post" onsubmit="return false;">
			<form:hidden path="atId" />		
			<form:hidden path="factCode" />
			<form:hidden path="branchNo" />
			<fieldset>
				<legend class="hidden_phrase">전파 대상 등록</legend>				
				<table class="dataTable">
					<colgroup>
						<col width="100px">
						<col />
					</colgroup>					 
					<tr>
						<th scope="row"><label for="">이름</label></th>											
						<td>
							<form:input path="atName" cssClass="inputText" cssStyle="width:160px" />																				
						</td>
					</tr>	
					<tr>
						<th scope="row"><label for="">조직</th>										
						<td>
							<form:select path="atDept">
								<form:option value="">선택</form:option>
							<c:forEach items="${codes}" var="codes">
								<form:option value="${codes.VALUE}" label="${codes.CAPTION}" />
							</c:forEach>							
							</form:select>
						</td>
					</tr>							 					 
					<tr>
						<th scope="row"><label for="">소속</th>
						<td>
							<form:input path="atPart" cssClass="inputText" cssStyle="width:160px" />
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="">직위</th>
						<td>
							<form:input path="atPosition" cssClass="inputText" cssStyle="width:160px" />
							* 시공사의 경우 직위에 시공사를 입력하여 주십시요
						</td>
					</tr>					
					<tr>
						<th scope="row"><label for="">전화번호</th>
						<td>
							<form:input path="atArsTele" cssClass="inputText" cssStyle="width:160px" />
						</td>
					</tr>					
					<tr>
						<th scope="row"><label for="">핸드폰번호</th>
						<td>
							<form:input path="atSmsTele" cssClass="inputText" cssStyle="width:160px" />
						</td>
					</tr>					
					<tr>
						<th scope="row"><label for="">ACS/SMS</th>
						<td>
							<form:checkbox path="atArs" cssClass="inputCheck" value="A" /><label for="">ACS</label>
							<form:checkbox path="atSms" cssClass="inputCheck" value="S"  /><label for="">SMS</label>
						</td>
					</tr>					
					<tr>
						<th scope="row"><label for="">주간/야간</th>
						<td>
							<form:checkbox path="atDay" cssClass="inputCheck" value="D"  /><label for="">주</label>
							<form:checkbox path="atNight" cssClass="inputCheck" value="N"  /><label for="">야</label>
						</td>
					</tr>					
					<tr>
						<th scope="row"><label for="">사용여부</th>
						<td>
							<form:checkbox path="atRece" cssClass="inputCheck" value="Y"  />
						</td>
					</tr>					
					<tr>
						<th scope="row"><label for="">단계</th>
						<td>
							<form:select path="atDepth">
								<form:option value="">선택</form:option>
								<form:option value="1">관심</form:option>
								<form:option value="2">주의</form:option>
								<form:option value="3">경계</form:option>
								<form:option value="4">심각</form:option>
							</form:select>
						</td>
					</tr>					
					<tr>
						<th scope="row"><label for="">순위</th>
						<td>
							<form:select path="atClass">
								<form:option value="">선택</form:option>
								<form:option value="1">1</form:option>
								<form:option value="2">2</form:option>
								<form:option value="3">3</form:option>
								<form:option value="4">4</form:option>
								<form:option value="5">5</form:option>
								<form:option value="6">6</form:option>
								<form:option value="7">7</form:option>
								<form:option value="8">8</form:option>
								<form:option value="9">9</form:option>
							</form:select>						
						</td>
					</tr>					
				</table>
				<ul class="btn">
					<li><input id="save" type="image" src="<c:url value='/images/common/btn_save.gif'/>" alt="저장" /></li>
					<li><a href="javascript:close();"><img src="<c:url value='/images/common/btn_close.gif'/>" alt="취소" /></a></li>
				</ul>					
			</fieldset>
			</form:form>
	</div>
</div>
</body>
</html>
