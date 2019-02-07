<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="교육일정" name="title"/>
</jsp:include>
  <link href="http://fonts.googleapis.com/css?family=Petrona|Inconsolata|Droid+Sans" rel="stylesheet" type="text/css" />
<script type="text/javascript">
//교육 신청 처리
function fn_egov_Entry() {
	if(confirm("선택하신 교육을 신청하시겠습니까?")){
		document.frm.submit();
	}
}
function fn_egov_EntryCencel(seminarEntryId) {
	if(confirm("교육을 취소 하시겠습니까?")){
		document.frm.seminarEntryId.value = seminarEntryId;
		document.frm.action = "<c:url value='/mobile/sub/seminar/CancelSeminarEntry.do'/>";
		document.frm.submit();
	}
}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/seminar/SeminarScheduleSearch.do" name="link"/>
		<jsp:param value="교육일정" name="title"/>
	</jsp:include>
<form name="frm" method="post" action="/mobile/sub/seminar/UpdateSeminarEntry.do">
<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
<input type="hidden" name="seminarId" value="<c:out value='${result.seminarId}'/>" />
<input type="hidden" name="checkSeminarId" value="" />
<input type="hidden" name="no" value="${no}" />
<input type="hidden" name="searchBgnDe" value="<c:out value="${param.searchBgnDe}"/>" />
<input type="hidden" name="searchEndDe" value="<c:out value="${param.searchEndDe}"/>" />
<input type="hidden" name="searchGubun" value="<c:out value="${param.searchGubun}"/>" />
<input type="hidden" name="searchClosingState" value="<c:out value="${param.searchClosingState}"/>" />
<input name="seminarEntryId" type="hidden"/>	
</form>
<div> 
    
	<jsp:include page="/WEB-INF/jsp/mobile/sub/seminar/SeminarScheduleCommonTop.jsp">
		<jsp:param value="${ApplicationList}" name="Seminargubun"/>
	</jsp:include>
	<div class="manageview">
		<table width="100%"> 
			<colgroup> 
				<col width="30%" /> 
				<col width="65%" />
			</colgroup> 
			<tr> 
				<th>제목</th> 
				<td>[<c:out value="${result.seminarGubunName}"/>]<c:out value="${result.seminarTitle}"/></td>
			</tr> 
			<tr> 
				<th>교육기간</th> 
				<td><c:out value="${result.seminarDateFrom}"/> ~ <c:out value="${result.seminarDateTo}"/></td>
			</tr> 
			<tr> 
				<th>교육시간</th>
				<td><c:out value="${result.seminarTimeFrom}"/> : 00 ~ <c:out value="${result.seminarTimeTo}"/> : 00</td> 
			</tr> 
			<tr> 
				<th>교육장소</th>
				<td><c:out value="${result.seminarPlace}"/></td> 
			</tr> 
			<tr> 
				<th>참여자수</th>
				<td><c:out value="${entryCnt}"/> / <c:out value="${result.seminarCount}"/></a></td> 
			</tr> 
			<tr> 
				<th>담당자</th>
				<td><c:out value="${result.seminarLectName}"/></td> 
			</tr> 
			<tr> 
				<th>주최</th>
				<td><c:out value="${result.seminarHost}"/></td> 
			</tr> 
			<tr> 
				<th>담당연락처</th>
				<td><a href="tel:<c:out value="${result.seminarLectTel}"/>"><c:out value="${result.seminarLectTel}"/></a></td> 
			</tr>
			<tr>
				<td colspan="2" style="padding-top:10px;">
					<c:out value="${result.seminarBody}" escapeXml="false"/>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<c:import url="/cmmn/selectFileInfs.do" charEncoding="utf-8">
						<c:param name="param_atchFileId" value="${result.atchFileId}" />
					</c:import>
				</td>
			</tr>
			<c:if test="${ApplicationList eq 'MySeminarSchedule'}">
			<tr>
				<td colspan="2" style="padding-top:10px;">
				<div style="margin:5px 0;font-weight: bold;">참여자</div>
				<c:forEach var="mem" items="${resultMemList}" varStatus="status">
					<div style="margin:3px 0;">[<c:out value="${mem.memDeptName}"/> / <c:out value="${mem.seminarMemName}"/>]</div>
				</c:forEach>
				</td>
			</tr>
			</c:if>
		</table> 
	</div> 
	<c:if test="${ApplicationList eq 'SeminarList'}">
		<c:if test="${result.seminarClosingState eq 'Y' }">
		<ul class="sbtn" style="width:100%;"> 
			<li style="width:90%;"><a href="#" onclick="fn_egov_Entry(); return false;">신청하기</a></li> 
		</ul>
		</c:if>
		<c:if test="${result.seminarClosingState ne 'Y' }">
		<ul class="sbtn" style="width:100%;"> 
			<li style="width:90%;"><a href="<c:url value="/mobile/sub/seminar/SeminarScheduleList.do?${listparameter }"/>">목록보기</a></li> 
		</ul>
		</c:if>
	</c:if>
	<c:if test="${ApplicationList eq 'MySeminarSchedule'}">
		<c:if test="${!empty param.seminarEntryId }">
			<div style="float:left; width:50%;text-align:center;">
				<ul class="sbtn"> 
					<li style="width:90%"><a href="<c:url value="/mobile/sub/seminar/SeminarApplicationList.do?${listparameter }"/>">목록보기</a></li>
				</ul>
			</div>
			<div style="float:left; width:50%;text-align:center;">
				<ul class="sbtn">
					<li style="width:90%"><a href="javascript:fn_egov_EntryCencel('<c:out value="${param.seminarEntryId}"/>');">신청취소</a></li>
				</ul>
			</div>
		</c:if>
		<c:if test="${empty param.seminarEntryId }">
			<ul class="sbtn" style="width:100%;">   
				<li style="width:90%;"><a href="<c:url value="/mobile/sub/seminar/SeminarScheduleList.do?${listparameter }"/>">목록보기</a></li> 
			</ul>
		</c:if> 
	</c:if>
</div>

</body>