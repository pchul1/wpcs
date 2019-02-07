<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="유관기관조회" name="title"/>
</jsp:include>
<script type="text/javascript" charset="utf-8">
function goList(){
	document.forms['form1'].submit();
}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/waterinfo/office/officesearch.do" name="link"/>
		<jsp:param value="유관기관조회" name="title"/>
	</jsp:include>
<form action="officelist.do" method="post" name="form1">
	<input type="hidden" name="sCtyCode" value="<c:out value="${param_s.sCtyCode}"/>"/>
	<input type="hidden" name="sDoCode" value="<c:out value="${param_s.sDoCode}"/>"/>
	<input type="hidden" name="searchKeyword" value="<c:out value="${param_s.searchKeyword}"/>"/>
</form>
<div> 
    
	<div class="manageview"> 
		<table width="100%"> 
		<colgroup> 
			<col width="30%" /> 
			<col width="65%"/>
		</colgroup> 
		<tr> 
			<th>ID</th> 
			<td><c:out value="${View.id}"/></td>
		</tr> 
		<tr> 
			<th>기관명</th>
			<td><c:out value="${View.nm}"/></td> 
		</tr> 
		<tr> 
			<th>부서명</th>
			<td><c:out value="${View.dept}"/></td> 
		</tr> 
		<tr> 
			<th>주간전화번호</th>
			<td><a href="tel:<c:out value="${View.day_tel}"/>"><c:out value="${View.day_tel}"/></a></td> 
		</tr> 
		<tr> 
			<th>야간전화번호</th>
			<td><a href="tel:<c:out value="${View.night_tel}"/>"><c:out value="${View.night_tel}"/></a></td> 
		</tr> 
		<tr> 
			<th>주간팩스</th>
			<td><c:out value="${View.day_fax}"/></td> 
		</tr> 
		<tr> 
			<th>야간팩스</th>
			<td><c:out value="${View.night_fax}"/></td> 
		</tr> 
		<tr> 
			<th>주소</th>
			<td><c:out value="${View.address}"/></td> 
		</tr> 
		</table> 
	</div> 
	<div  style="width:100%;text-align:center;">
		<ul class="sbtn" style="width:100%"> 
			<li style="width:90%">
				<a href="#" onclick="goList(); return false;">목록</a>
			</li> 
		</ul>
	</div>
</div>
</body>
</html>