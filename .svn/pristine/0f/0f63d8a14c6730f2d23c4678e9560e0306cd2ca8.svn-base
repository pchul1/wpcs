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
$(function(){
	CommonSelectBox('sido','sDoCode', '','', '', '', '');
	CommonSelectBox('sigungu','sCtyCode', '11','', '전체', 'all','');
	$("#sDoCode").change(function(){
		CommonSelectBox('sigungu','sCtyCode', $(this).val(),'', '전체','all', '');
	});
});
function goSubmit(){
	showLoading();
	document.forms['form1'].submit();
}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/waterinfo/office/officesearch.do" name="link"/>
		<jsp:param value="유관기관조회" name="title"/>
	</jsp:include>
<form name="form1" method="post" action="officelist.do">
	<div class="SearchTable"> 
		<table width="100%"> 
			<colgroup> 
				<col width="35%" /> 
				<col width="65%" /> 
			</colgroup> 
			<tr> 
				<th>특별시/도</th> 
				<td> 
					<select name="sDoCode" id="sDoCode"> 
					</select> 
				</td>
			</tr>
			<tr>  
				<th>시군구</th> 
				<td>
					<select id="sCtyCode" name="sCtyCode">
						<option value="all">- 전체 -</option>
					</select>
				</td> 
			</tr> 
			<tr>
				<th>명칭</th>
				<td><input type="text" name="searchKeyword"/></td>
			</tr>
		</table> 
	</div> 
	<div  style="float:left; width:100%;text-align:center;">
		<ul class="sbtn" style="width:100%"> 
			<li style="width:90%">
				<a href="#" onclick="goSubmit(); return false;">조회</a>
			</li> 
		</ul>
	</div>
</form>
</body>
</html>