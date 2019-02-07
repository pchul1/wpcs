<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="방제물품현황" name="title"/>
</jsp:include>
<script type="text/javascript" charset="utf-8">
function goWareView(){
	document.forms['form1'].action = "/mobile/sub/warehouse/ware/wareview.do";
	document.forms['form1'].submit();
}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/warehouse/item/itemsearch.do" name="link"/>
		<jsp:param value="방제물품현황" name="title"/>
	</jsp:include>
<form method="post" name="form1">
	<input type="hidden" name="riverDiv" id="riverDiv" value="<c:out value="${param_s.riverDiv }"/>"/>
	<input type="hidden" name="whCode" id="whCode" value="<c:out value="${param_s.whCode}"/>"/>
</form>
<div id="list"> 
    
	<p class="txt"><c:out value="${sugyeName}"/> / <c:out value="${(empty WhName) ? '전체' : WhName}"/></p> 
	<table width="100%"> 
		<colgroup>
			<col width="" />
			<col width="16%" />
			<col width="16%" />
		</colgroup>
		<tr> 
			<th>물품명</th> 
			<th>현재재고</th> 
			<th>단위</th> 
		</tr>
		<c:forEach items="${List}" var="item">
		<tr> 
			<td>${item.itemName}</td> 
			<td>${item.itemCnt}</td> 
			<td>${item.itemStan}</td> 
		</tr> 
		</c:forEach>
	</table>
	
	<c:if test="${!empty List}">
	<ul class="sbtn" style="width:100%"> 
		<li style="width:90%"><a href="#" onclick="goWareView(); return false;">창고정보</a></li> 
	</ul>
	</c:if>
</div>   

</body>
</html>