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
function goList(){
	document.forms['form1'].action = "ipusnlist.do";
	document.forms['form1'].submit();
}
function goMap(){
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
	<input type="hidden" name="fact_code" id="fact_code" value="<c:out value="${param_s.fact_code}"/>"/>
	<input type="hidden" name="branch_no" id="branch_no" value="<c:out value="${param_s.branch_no}"/>"/>
	<input type="hidden" name="river_div" value="<c:out value="${param_s.river_div}"/>"/>
	<input type="hidden" name="sys" value="<c:out value="${param_s.sys}"/>"/>
	<input type="hidden" name="fact_name" value="<c:out value="${param_s.fact_name}"/>"/>
</form>
<div>
 	
	<div class="manageview"> 
		<table width="100%"> 
		<colgroup> 
			<col width="30%" /> 
			<col width="65%" /> 
		</colgroup> 
		<tr> 
			<th>수계</th>
			<td><c:out value="${View.river_div_name}"/></td> 
		</tr> 
		<tr> 
			<th>측정소명</th> 
			<td><c:out value="${View.branch_name}"/></td>
		</tr> 
		<tr> 
			<th>지점코드</th>
			<td><c:out value="${View.fact_code}"/></td> 
		</tr> 
		<tr> 
			<th>시스템</th>
			<td><c:out value="${View.sys_kind_name}"/></td> 
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
			<td><c:out value="${View.fact_addr}"/></td> 
		</tr> 
		<tr> 
			<th>GPS오차범위</th>
			<td><c:out value="${View.gps_dist}"/></td> 
		</tr> 
		</table> 
	</div> 

	<div style="float:left; width:50%;text-align:center;">
		<ul class="sbtn"> 
			<li style="width:90%"><a href="#" onclick="goList(); return false;">목록</a></li>
		</ul>
	</div>
	<div style="float:left; width:50%;text-align:center;">
		<ul class="sbtn">
			<li style="width:90%"><a href="#" onclick="goMap(); return false;">지도보기</a></li>
		</ul>
	</div> 
</div> 

</body>
</html>