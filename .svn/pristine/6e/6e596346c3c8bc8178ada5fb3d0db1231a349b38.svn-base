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
function goView(n){
	$("#sId").val(n);
	document.forms['form1'].action = "ecompanyview.do";
	document.forms['form1'].submit();
}
function goMap(n){
	$("#sId").val(n);
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
		<input type="hidden" name="sId" id="sId" value=""/>
		<input type="hidden" name="sugye" id="sugye" value="<c:out value="${param_s.sugye }"/>"/>
		<input type="hidden" name="searchKeyword" id="searchKeyword" value="<c:out value="${param_s.searchKeyword }"/>"/>
	</form>
<div id="list"> 
    
	<p class="txt"><c:out value="${sugyeName}"/> / <c:out value="${(empty param.searchKeyword) ? '전체' : param.searchKeyword}"/></p> 
	<table width="100%"> 
	<colgroup>
		<col width="" />
		<col width="35%" />
	</colgroup>
	<tr> 
		<th>기관명</th> 
		<th>상세화면</th> 
	</tr>  
	<c:forEach items="${List}" var="item">
	<tr> 
		<td><c:out value="${item.nm}"/></td> 
		<td>
			<a href="#" onclick="goView('<c:out value="${item.id}"/>'); return false;"><img src="/images/mobile/btn_detail_info.png" align="absmiddle" width="52" height="18" border="0"/></a>
			<a href="#" onclick="goMap('<c:out value="${item.id}"/>'); return false;"><img src="/images/mobile/btn_view_map.png" align="absmiddle" width="52" height="18" border="0"/></a>
		</td>
	</tr> 
	</c:forEach>
	</table>
</div>
</body>
</html>