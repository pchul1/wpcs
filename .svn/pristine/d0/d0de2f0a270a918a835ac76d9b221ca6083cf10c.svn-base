<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="방제업체조회" name="title"/>
</jsp:include>
<script type="text/javascript" charset="utf-8">
function goList(){
	document.forms['form1'].action = "ecompanylist.do";
	document.forms['form1'].submit();
}
function goMap(){
	document.forms['form1'].action = "ecompanymap.do";
	document.forms['form1'].submit();
}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/waterinfo/ecompany/ecompanysearch.do" name="link"/>
		<jsp:param value="방제업체조회" name="title"/>
	</jsp:include>
<form method="post" name="form1">
	<input type="hidden" name="sId" id="sId" value="<c:out value="${param_s.sId }"/>"/>
	<input type="hidden" name="sugye" id="sugye" value="<c:out value="${param_s.sugye }"/>"/>
	<input type="hidden" name="searchKeyword" id="searchKeyword" value="<c:out value="${param_s.searchKeyword }"/>"/>
</form>
<div> 
    
	<div class="manageview"> 
		<table width="100%"> 
		<colgroup> 
			<col width="30%" /> 
			<col width="65%" />
		</colgroup> 
		<tr> 
			<th>ID</th> 
			<td><c:out value="${View.id}"/></td>
		</tr> 
		<tr> 
			<th>업체명</th>
			<td><c:out value="${View.nm}"/></td> 
		</tr> 
		<tr> 
			<th>담당자</th>
			<td><c:out value="${View.owner}"/></td> 
		</tr> 
		<tr> 
			<th>주간연락처</th>
			<c:if test="${'정보없음' eq View.d_phone}">
			<td><c:out value="${View.d_phone}"/></td>
			</c:if>
			<c:if test="${'정보없음' ne View.d_phone}">
			<td><a href="tel:<c:out value="${View.d_phone}"/>"><c:out value="${View.d_phone}"/></a></td>
			</c:if> 
		</tr> 
		<tr> 
			<th>야간연락처</th>
			<c:if test="${'정보없음' eq View.n_phone}">
			<td><c:out value="${View.n_phone}"/></td>
			</c:if>
			<c:if test="${'정보없음' ne View.n_phone}">
			<td><a href="tel:<c:out value="${View.n_phone}"/>"><c:out value="${View.n_phone}"/></a></td>
			</c:if> 
		</tr> 
		<tr> 
			<th>비상연락처</th>
			<c:if test="${'정보없음' eq View.e_phone}">
			<td><c:out value="${View.e_phone}"/></td>
			</c:if>
			<c:if test="${'정보없음' ne View.e_phone}">
			<td><a href="tel:<c:out value="${View.e_phone}"/>"><c:out value="${View.e_phone}"/></a></td>
			</c:if> 
		</tr> 
		<tr> 
			<th>업체구분</th>
			<td><c:out value="${View.type}"/></td> 
		</tr> 
		<tr> 
			<th>팩스</th>
			<td><c:out value="${View.fax}"/></td> 
		</tr> 
		<tr> 
			<th>위도</th>
			<td><c:out value="${View.latitude}"/></td> 
		</tr> 
		<tr> 
			<th>경도</th>
			<td><c:out value="${View.longitude}"/></td> 
		</tr> 
		<tr> 
			<th>주소</th>
			<td><c:out value="${View.address}"/></td> 
		</tr> 
		</table> 
	</div> 
	
	<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td style="width:50%;" align="center">
			<ul class="sbtn" style="margin-right:5px;width:80%">
				<li style="width:90%;"><a href="#" onclick="goList(); return false;">목록</a></li> 
			</ul>
		</td>
		<td style="width:50%;" align="center">
			<ul class="sbtn" style="margin-left:5px;width:80%">
				<li style="width:90%;"><a href="#" onclick="goMap(); return false;">지도보기</a></li> 
			</ul>
		</td>
	</tr>
	</table>
</div>
</body>
</html>