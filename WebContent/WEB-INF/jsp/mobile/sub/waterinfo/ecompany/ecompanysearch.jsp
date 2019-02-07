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
$(function(){
	CommonSelectBox('sugye','sugye', '','', "선택", "", "");
});
function goSubmit(){
	showLoading();
	document.forms['form1'].submit();
}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/waterinfo/ecompany/ecompanysearch.do" name="link"/>
		<jsp:param value="방제업체조회" name="title"/>
	</jsp:include>

<form name="form1" method="post" action="ecompanylist.do">
	<div class="SearchTable"> 
		<table width="100%"> 
		<colgroup> 
			<col width="35%" /> 
			<col width="65%" /> 
		</colgroup> 
		<tr> 
			<th>수계</th> 
			<td> 
				<select name="sugye" id="sugye"> 
					<option value="R01">한강</option>
					<option value="R02">낙동강</option>
					<option value="R03">금강</option>
					<option value="R04">영산강</option>
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