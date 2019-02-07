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
$(function(){
	CommonSelectBox('sugye','riverDiv', '','', "선택", "", "");
	CommonSelectBox('Warehouse','whCode', 'R01','', "선택", "", "");
	$("#riverDiv").change(function(i){
		CommonSelectBox('Warehouse','whCode', $(this).val(),'', "선택", "", "");	
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
		<jsp:param value="/mobile/sub/warehouse/ware/waresearch.do" name="link"/>
		<jsp:param value="방제창고조회" name="title"/>
	</jsp:include>

<form name="form1" method="post" action="warelist.do">
	<div class="SearchTable"> 
		<table width="100%"> 
		<colgroup> 
			<col width="35%" /> 
			<col width="65%" /> 
		<colgroup> 
		<tr> 
			<th>수계</th> 
			<td> 
				<select name="riverDiv" id="riverDiv"> 
					<option value="R01">한강</option>
					<option value="R02">낙동강</option>
					<option value="R03">금강</option>
					<option value="R04">영산강</option>
				</select> 
			</td>
		</tr>
		<tr>
			<th>명칭</th>
			<td><select name="whCode" id=whCode></select></td>
		</tr>
		</table> 
	</div> 
	<div style="float:left; width:100%;text-align:center;">
		<ul class="sbtn" style="width:100%"> 
			<li style="width:90%">
				<a href="#" onclick="goSubmit();return false;">조회</a>
			</li> 
		</ul>
	</div>
</form>

</body>
</html>