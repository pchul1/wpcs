<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="측정소위치조회" name="title"/>
</jsp:include>
<script type="text/javascript" charset="utf-8">
function goView(n,m){
	$("#fact_code").val(n);
	$("#branch_no").val(m);
	document.forms['form1'].action = "ipusnview.do";
	document.forms['form1'].submit();
}
function goMap(n,m){
	$("#fact_code").val(n);
	$("#branch_no").val(m);
	document.forms['form1'].action = "ipusnmap.do";
	document.forms['form1'].submit();
}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/ipusn/location/ipusnsearch.do" name="link"/>
		<jsp:param value="측정소위치조회" name="title"/>
	</jsp:include>
<form method="post" name="form1">
	<input type="hidden" name="fact_code" id="fact_code"/>
	<input type="hidden" name="branch_no" id="branch_no"/>
	<input type="hidden" name="river_div" value="<c:out value="${param_s.river_div}"/>"/>
	<input type="hidden" name="sys" value="<c:out value="${param_s.sys}"/>"/>
	<input type="hidden" name="fact_name" value="<c:out value="${param_s.fact_name}"/>"/>
</form>

<div id="list"> 
	<p class="txt"><c:out value="${conditionText}"/> / <c:out value="${(empty param_s.fact_name) ? '전체' : param_s.fact_name}"/></p> 
	<table width="100%"> 
	<colgroup>
		<col width="" />
		<col width="35%" />
	</colgroup>
	<tr> 
		<th>측정소명</th> 
		<th>상세화면</th> 
	</tr>
	<c:forEach items="${List}" var="item">
		<tr> 
			<td><c:out value="${item.branch_name}"/></td>
			<td>
				<a href="#" onclick="goView('<c:out value="${item.fact_code}"/>','<c:out value="${item.branch_no}"/>'); return false;"><img src="/images/mobile/btn_detail_info.png" width="52" height="18" border="0"/></a>
				<a href="#" onclick="goMap('<c:out value="${item.fact_code}"/>','<c:out value="${item.branch_no}"/>'); return false;"><img src="/images/mobile/btn_view_map.png" width="52" height="18" border="0"/></a>
			</td>
		</tr> 
	</c:forEach>
	</table> 
</div> 

</body>
</html>