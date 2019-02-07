<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%@page import="daewooInfo.common.util.fcc.StringUtil"%>
<%
  /**
  * @Class Name : alertStepSub.jsp
  * @Description : Alert Step List 화면
  * @Modification Information
  * 
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------
  *  2010.05.19     khanian        최초 생성
  *
  * author khany
  * since 2010.05.17
  *  
  * Copyright (C) 2010 by khany  All right reserved.
  */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"> 

<html xmlns="http://www.w3.org/1999/xhtml"> 
<head> 
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9">  
	<title>한국환경공단 수질오염 방제정보 시스템</title>   
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content2.css'/>" />
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

<script type='text/javascript'>
function fncSave() {	
	frm = document.detailForm;
    frm.action = "<c:url value='/alert/addAlertStep.do'/>";
    frm.submit();
}
function fn_egov_downFile(atchFileId){ 
	window.open("<c:url value='/cmmn/AlertFileDown.do?atchFileId="+atchFileId+"'/>");
}
</script>
	
</head> 
<body class="popup"> 
<div id="wrap" style="width:auto; padding:10px" > 
	<h1 class="tit"><img src="<c:url value='/images/waterpolmnt/h1_pop_alarmmng.gif'/>" alt="사고 조치" /></h1> 
	<table class="dataTable"> 
		<colgroup> 
			<col width="80px" /> 
			<col /> 
			<col width="80px" /> 
			<col /> 
			<col width="120px" /> 
			<col /> 
		</colgroup> 
		<tr> 
			<th id="thA">수계</th> 
			<td headers="thA"><c:out value="${asData.riverId}"/></td> 
			<th id="thB">지역</th> 
			<td headers="thB"><c:out value="${asData.factName}"/></td> 
			<th id="thC">지점</th> 
			<td headers="thC"><c:out value="${asData.alertKind}"/></td> 
		</tr> 
		<tr> 
			<th id="thD">접수유형</th> 
			<td headers="thD"><c:out value="${asData.itemTypeName}"/></td> 
			<th id="thE">접수일시</th> 
			<td headers="thE"><c:out value="${asData.minTime}"/></td> 
			<c:if test="${asData.itemType =='TYPE1' || asData.itemType =='TYPE2' }">
			<th id="thF">사고유형</th> 
			<td headers="thF"><c:out value="${asData.receiptType}"/></td> 
			</c:if> 
			<c:if test="${asData.itemType =='AUTO'}">
			<th id="thF">측정치</th> 
			<td headers="thF"><c:out value="${asData.minVl}"/></td> 
			</c:if> 
		</tr> 
		<c:if test="${not empty asData.atchFileId}" >
		<tr> 
			<th id="thA">사진이미지</th> 
			<td headers="thA"><img src='<c:url value='/cmmn/getAlertImage.do'/>?atchFileId=<c:out value="${asData.atchFileId}"/>&thumbnailFlag=Y' /></td> 
			<th id="thB">사진다운로드</th>  
			<td headers="thB"><a href="javascript:fn_egov_downFile('<c:out value="${asData.atchFileId}"/>');" ><c:out value="${file}"/></a></td> 
			<th id="thC">신고자  구분</th> 
			<td headers="thC"><c:out value="${asData.memberCategory}"/> </td>
		</tr> 
		</c:if>
	</table> 
	<form:form commandName="alertStepVO" name="detailForm" method="post" cssClass="writeForm" onsubmit="return false;">
	<input type="hidden" name="asId" value="${asData.asId}"/>
		<fieldset> 
			<legend class="hidden_phrase">사고조치 입력</legend> 
			<table class="dataTable"> 
				<colgroup> 
					<col width="80px" /> 
					<col /> 
					<col width="80px" /> 
					<col /> 
				</colgroup>
				<c:forEach items="${dataList}"  var="dataList"  varStatus="status">
					<tr>
						<th scope="row"><label for="">조치단계</label></th> 
						<td>${dataList.alertStep}</td> 
						<th scope="row"><label for="">조치시간</label></th> 
						<td>${dataList.alertStepTime}</td>
					</tr>
					<tr> 
						<th scope="row"><label for="">조치내역</label></th> 
						<td colspan="3">${dataList.alertStepText}</td> 
					</tr> 
				</c:forEach> 
				<c:if test="${asData.alertStep < 6}">
					<tr> 
						<th scope="row"><label for="">방제단계</label></th> 
						<td colspan="3">
							<c:choose>
							
						    	<c:when test="${asData.alertStep == 1}">
									<input type="hidden" name="alertStep" value="2"/> 
									<input type="text" name="alertStepName" maxlength="30" class="input" value="현장확인" readonly="readonly"/>
									<input type="image" src="<c:url value='/images/common/btn_action.gif'/>" alt="조치" onClick="javascript:fncSave();"/>
								</c:when>
								
								
								<c:when test="${asData.alertStep == 2}">
									<select name="alertStep">
										<c:if test="${fn:substring(asData.factCode, 2, 3) == 'T'}" >
											<option value="3">시료분석</option>
											<option value="6">상황종료(측정기이상)</option>
											<option value="7">상황종료(강우요인)</option>
										</c:if>
										<c:if test="${fn:substring(asData.factCode, 2, 3) != 'T'}" >
											<option value="3">시료분석</option>
											<option value="6">상황종료(측정기이상)</option>
										</c:if>
									</select>
									<input type="image" src="<c:url value='/images/common/btn_action.gif'/>" alt="조치" onClick="javascript:fncSave();"/>
						    	</c:when>
						    	
						    	
						    	
						    	<c:when test="${asData.alertStep == 3}">
						    		<select name="alertStep">			
											<option value="4">경보발령</option>
											<option value="8">상황종료</option>										
									</select>
									<input type="image" src="<c:url value='/images/common/btn_action.gif'/>" alt="조치" onClick="javascript:fncSave();"/>
						    	</c:when>
						    	
						    	
						    	
						    	<c:when test="${asData.alertStep == 4}">
						    		<select name="alertStep">			
											<option value="5">상황전파</option>
											<option value="8">상황종료</option>										
									</select>
									<input type="image" src="<c:url value='/images/common/btn_action.gif'/>" alt="조치" onClick="javascript:fncSave();"/>
						    	</c:when>
						    	
						    	
						    	<c:when test="${asData.alertStep == 5}">
									<input type="hidden" name="alertStep" value="8"/> 
									<input type="text" name="alertStepName" maxlength="30" class="input" value="상황종료" readonly="readonly"/>
									<input type="image" src="<c:url value='/images/common/btn_action.gif'/>" alt="조치" onClick="javascript:fncSave();"/>
								</c:when>
								
						    </c:choose>
						    
					    </td>
					</tr>
					<tr> 
						<th scope="row"><label for="">조치내역</label></th> 
						<td colspan="3"> 
							<textarea name="alertStepText" rows="3" cols="20" Class="textArea"></textarea>
						</td> 
					</tr>
				</c:if> 
			</table> 
			<ul class="btnMenu"> 
				<li><a href="javascript:close();"><img src="<c:url value='/images/common/btn_close.gif'/>" alt="닫기" /></a></li> 
			</ul> 
		</fieldset> 
	</form:form>
</div> 
</body> 
</html> 