<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pj" uri="ProjectJstlUtil"%>

<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="상황관리" name="title"/>
</jsp:include>
<script type="text/javascript">
function goAction(n){
	document.frm1.action = n;
	document.frm1.submit();
}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/alert/alertMngSearch.do" name="link"/>
		<jsp:param value="상황관리" name="title"/>
	</jsp:include>
<form action="" method="post" name="frm1">
<input type="hidden" name="system" value="<c:out value="${param_s.system}"/>"/>
<input type="hidden" name="startDate" value="<c:out value="${param_s.startDate}"/>"/>
<input type="hidden" name="endDate" value="<c:out value="${param_s.endDate}"/>"/>
</form>
<div id="list"> 
    
	<table width="100%"> 
		<colgroup>
			<col width="40%" />
			<col width="10%" />
			<col width="10%" />
			<col width="10%" />
			<col width="10%" />
			<col width="10%" />
		</colgroup>
		<tr> 
			<th rowspan="2">시스템</th> 
			<th colspan="5">경보</th> 
		</tr>
		<tr> 
			<th>계</th> 
			<th>관심</th> 
			<th>주의</th> 
			<th>경계</th> 
			<th>심각</th> 
		</tr>
		<c:forEach items="${StatsList}" var="item" varStatus="count">
		<tr> 
			<td><c:out value="${item.sysKind}"/></td> 
			<td><c:out value="${item.total}"/></td> 
			<td><c:out value="${item.val1}"/></td> 
			<td><c:out value="${item.val2}"/></td> 
			<td><c:out value="${item.val3}"/></td> 
			<td><c:out value="${item.val4}"/></td> 
		</tr> 
		</c:forEach>
	</table>
	
	<table width="100%" style="margin-top:10px;"> 
		<colgroup>
			<col width="5%" />
			<col width="13%" />
			<col width="13%" />
			<col width="13%" />
			<col width="13%" />
			<col width="13%" />
			<col width="16%" />
			<col width="13%" />
		</colgroup>
		<tr> 
			<th>No</th> 
			<th>구분</th> 
			<th>시스템</th> 
			<th>조치단계</th> 
			<th>수계</th> 
			<th>측정소</th> 
			<th>경보발생시간</th> 
			<th>상황종료시간</th> 
		</tr>
		<c:forEach items="${List}" var="item" varStatus="count">
		<tr> 
			<c:set var="listparameter" value='${pj:ParamString(param_s,"system,startDate,endDate,itemType,minOr")}&${pj:nonQuestionParamString(item,"asId,alertStep",false)}'/>
			<c:choose>
				<c:when test='${item.alertStep eq "9"}'>
					<c:set var="listparameter" value="/mobile/sub/alert/alertMngView1.do${listparameter}"/>
				</c:when>
				<c:otherwise>
					<c:set var="listparameter" value="/mobile/sub/alert/alertMngView${item.alertStep}.do${listparameter}"/>
				</c:otherwise>
			</c:choose>
			<td><c:out value="${count.count}"/></td> 
			<td><a href="<c:url value="${listparameter}"/>"><c:out value="${item.itemType}"/></a></td> 
			<td><a href="<c:url value="${listparameter}"/>"><c:out value="${item.system}"/></a></td> 
			<td><a href="<c:url value="${listparameter}"/>"><c:out value="${pj:SelectAlertStepName(item.alertStep,'Y')}"/></a></td> 
			<td><a href="<c:url value="${listparameter}"/>"><c:out value="${item.riverId}"/></a></td> 
			<td><a href="<c:url value="${listparameter}"/>"><c:out value="${item.branchName}-${item.branchNo}"/></a></td> 
			<td><a href="<c:url value="${listparameter}"/>"><c:out value="${item.minTime}"/></a></td> 
			<td><a href="<c:url value="${listparameter}"/>"><c:out value="${!empty item.step6  ? item.step6 : (!empty item.step7 ? item.step7 : (!empty item.step8 ? item.step8 : item.step10))}"/></a></td>
		</tr> 
		</c:forEach>
	</table>
</div> 
</body>
</html>

