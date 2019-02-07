<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="방제창고조회" name="title"/>
</jsp:include>
<script type="text/javascript" charset="utf-8">
function goList(){
	document.forms['form1'].action = "warelist.do";
	document.forms['form1'].submit();
}
function goMap(){
	document.forms['form1'].action = "waremap.do";
	document.forms['form1'].submit();
}
function goItemView(){
	document.forms['form1'].action = "/mobile/sub/warehouse/item/itemlist.do";
	document.forms['form1'].submit();
}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/warehouse/ware/waresearch.do" name="link"/>
		<jsp:param value="방제창고조회" name="title"/>
	</jsp:include>
<form method="post" name="form1">
	<input type="hidden" name="whCode" id="whCode" value="<c:out value="${param_s.whCode}"/>"/>
	<input type="hidden" name="riverDiv" id="riverDiv" value="<c:out value="${param_s.riverDiv }"/>"/>
</form>
<div> 
    
	<div class="manageview"> 
		<table width="100%"> 
		<colgroup> 
			<col width="30%" /> 
			<col width="65%" />
		</colgroup> 
		<tr> 
			<th>창고코드</th> 
			<td><c:out value="${View.whCode}"/></td>
		</tr> 
		<tr> 
			<th>창고명</th>
			<td><c:out value="${View.whName}"/></td> 
		</tr> 
		<tr> 
			<th>담당부서</th>
			<td><c:out value="${View.adminDeptName}"/></td> 
		</tr> 
		<tr> 
			<th>담당자</th>
			<td><c:out value="${View.adminName}"/></td>
		</tr> 
		<tr> 
			<th>연락처</th>
			<c:if test="${'정보없음' eq View.adminTelno}">
			<td><c:out value="${View.adminTelno}"/></td>
			</c:if>
			<c:if test="${'정보없음' ne View.adminTelno}">
			<td><a href="tel:<c:out value="${View.adminTelno}"/>"><c:out value="${View.adminTelno}"/></a></td>
			</c:if> 
		</tr> 
		<tr> 
			<th>주소</th>
			<td><c:out value="${View.addr}"/></td> 
		</tr> 
		<tr> 
			<th>위도</th>
			<td><c:out value="${View.lon}"/></td> 
		</tr> 
		<tr> 
			<th>경도</th>
			<td><c:out value="${View.lat}"/></td> 
		</tr> 
		</table> 
	</div> 
	
	<table width="100%" cellpadding="0" cellspacing="0">
	<tr>
		<td style="width:33%;">
			<ul class="sbtn">
				<li style="width:90%;"><a href="#" onclick="goList(); return false;">목록</a></li> 
			</ul>
		</td>
		<td style="width:33%;">
			<ul class="sbtn">
				<li style="width:90%;"><a href="#" onclick="goMap();return false;">지도보기</a></li> 
			</ul>
		</td>
		<td style="width:33%;">
			<ul class="sbtn"> 
				<li style="width:90%;"><a href="#" onclick="goItemView();return false;">물품정보</a></li>  
			</ul>
		</td>
	</tr>
	</table>
</div>
</body>
</html>