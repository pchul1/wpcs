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
function goView(n){
	$("#whCode").val(n);
	document.forms['form1'].action = "wareview.do";
	document.forms['form1'].submit();
}
function goMap(n){
	$("#whCode").val(n);
	document.forms['form1'].action = "waremap.do";
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
	<input type="hidden" name="whCode" id="whCode" value=""/>
	<input type="hidden" name="riverDiv" id="riverDiv" value="<c:out value="${param_s.riverDiv }"/>"/>
</form>
<div id="list"> 
    
	<p class="txt"><c:out value="${sugyeName}"/> / <c:out value="${(empty WhName) ? '전체' : WhName}"/></p> 
	<table width="100%"> 
	<colgroup>
		<col width="" />
		<col width="35%" />
	</colgroup>
	<tr> 
		<th>창고명</th> 
		<th>상세화면</th> 
	</tr>  
	<c:forEach items="${List}" var="item">
	<tr> 
		<td><c:out value="${item.whName}"/></td> 
		<td>
			<a href="#" onclick="goView('<c:out value="${item.whCode}"/>'); return false;"><img src="/images/mobile/btn_detail_info.png" align="absmiddle" width="52" height="18" border="0"/></a>
			<a href="#" onclick="goMap('<c:out value="${item.whCode}"/>'); return false;"><img src="/images/mobile/btn_view_map.png" align="absmiddle" width="52" height="18" border="0"/></a>
		</td>
	</tr> 
	</c:forEach>
</table>

</body>
</html>