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
function goView(n){
	$("#sId").val(n);
	document.forms['form1'].submit();
}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/waterinfo/office/officesearch.do" name="link"/>
		<jsp:param value="유관기관조회" name="title"/>
	</jsp:include>
<form action="officeview.do" method="post" name="form1">
	<input type="hidden" name="sId" id="sId" value=""/>
	<input type="hidden" name="sCtyCode" value="<c:out value="${param_s.sCtyCode}"/>"/>
	<input type="hidden" name="sDoCode" value="<c:out value="${param_s.sDoCode}"/>"/>
	<input type="hidden" name="searchKeyword" value="<c:out value="${param_s.searchKeyword}"/>"/>
</form>
<div id="list"> 
    
	<p class="txt"><c:out value="${SidoName}"/> / <c:out value="${(empty SigunguName) ? '전체' : SigunguName}"/> / <c:out value="${(empty param_s.searchKeyword) ? '전체' : param_s.searchKeyword}"/></p> 
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
			<!--
			<a href="office_map.jsp?id=1040&s_do_code=11&s_cty_code=&s_nm=">지도보기</a>
			-->
		</td>
	</tr> 
	</c:forEach>
</table>

</body>
</html>