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
	<jsp:param value="사고관리" name="title"/>
</jsp:include>
</head>
<script type="text/javascript">
function goAction(n){
	document.frm1.action = n;
	document.frm1.submit();
}
</script>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/waterpollution/waterPollutionSearch.do" name="link"/>
		<jsp:param value="사고관리" name="title"/>
	</jsp:include>
<form action="" method="post" name="frm1">
<input type="hidden" name="searchRiverDiv" value="<c:out value="${param_s.searchRiverDiv}"/>"/>
<input type="hidden" name="searchWpKind" value="<c:out value="${param_s.searchWpKind}"/>"/>
<input type="hidden" name="searchWpsStep" value="<c:out value="${param_s.searchWpsStep}"/>"/>
<input type="hidden" name="startDate" value="<c:out value="${param_s.startDate}"/>"/>
<input type="hidden" name="endDate" value="<c:out value="${param_s.endDate}"/>"/>
</form>
<div id="list"> 
	<table width="100%" style="word-break:break-all;table-layout:fixed;"> 
		<colgroup>
			<col width="20px" />
			<col width="14%" />
			<col width="13%" />
			<col width="13%" />
			<col width="*" />
			<col width="12%" />
			<col width="12%" />
		</colgroup>
		<tr> 
			<th>NO</th> 
			<th>일시</th> 
			<th>수계</th> 
			<th>유형</th>
			<th>내용</th>
			<th>단계</th>
			<th>지원</th>
		</tr>
		<c:forEach items="${List}" var="item" varStatus="count">
		<tr> 
			<td><c:out value="${count.count}"/></td> 
			<td><c:out value="${item.receiveDate}"/></td> 
			<td><c:out value="${item.riverDivName}"/></td> 
			<td>
					<c:if test='${item.wpKind eq "PA"}'>유류유출</c:if>
					<c:if test='${item.wpKind eq "PB"}'>물고기폐사</c:if>
					<c:if test='${item.wpKind eq "PC"}'>화학물질</c:if>
					<c:if test='${item.wpKind eq "PD"}'>기타</c:if>
					<c:if test='${item.wpKind eq "PT"}'>테스트</c:if>
			</td> 
			<c:if test='${item.wpsStep eq "STA"}'>
				<td><a href="/mobile/sub/waterpollution/waterPollutionRegist.do?wpCode=<c:out value="${item.wpCode}"/>" onclick="goAction(this.href); return false;"><c:out value="${item.wpContent}"/></a></td> 
			</c:if>
			<c:if test='${item.wpsStep ne "STA"}'>
				<td><a href="/mobile/sub/waterpollution/waterPollutionDetail.do?wpCode=<c:out value="${item.wpCode}"/>" onclick="goAction(this.href); return false;"><c:out value="${item.wpContent}"/></a></td> 
			</c:if>
			<td>
					<c:if test='${item.wpsStep eq "STA"}'>신고</c:if>
					<c:if test='${item.wpsStep eq "RCV"}'>접수</c:if>
					<c:if test='${item.wpsStep eq "ING"}'>수습중</c:if>
					<c:if test='${item.wpsStep eq "END"}'>조치완료</c:if>
			</td> 
			<td>
				<c:if test='${empty item.supportKind}'>미정</c:if>
				<c:if test='${item.supportKind eq "N"}'>접수</c:if>
				<c:if test='${item.supportKind eq "Y"}'>지원</c:if>
			</td> 
		</tr> 
		</c:forEach>
	</table>
</div> 
</body>
</html>