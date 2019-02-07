<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pj" uri="ProjectJstlUtil"%>

<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="상황관리" name="title"/>
</jsp:include>

<script type="text/javascript" charset="utf-8">
	$(function(document){
		if($('#sys').val() != "A"){
			$('#auto').attr("disabled", "disabled");
		}
		CommonSelectBox('sugye','searchRiverDiv', '','', '전체', '', "");

		$("input[datepicker='Y']").datepicker();

		var today = new Date(); 
		var montoday = new Date();
		
		var year = today.getFullYear();
		var month = addzero(today.getMonth()+1);
		var day = addzero(today.getDate());
		$("#endDate").val(year + "/" + month + "/" + day);
		
		montoday.setDate(0)
		today.setDate(today.getDate() - montoday.getDate());
		
		year = today.getFullYear();
		month = addzero(today.getMonth()+1);  
		day = addzero(today.getDate());
		$("#startDate").val(year + "/" + month + "/" + day);
	});
	
	function form_submit(){
		showLoading();
		document.form1.submit();
	}
	
	function addzero(n) {
		return n < 10 ? "0" + n : n + "";
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/alert/alertMngSearch.do" name="link"/>
		<jsp:param value="상황관리" name="title"/>
	</jsp:include>
	<form name="form1" method="post" action="/mobile/sub/alert/alertMngList.do">
		<div class="SearchTable"> 
			<table width="100%"> 
			<colgroup> 
			<col width="35%" /> 
			<col width="65%" /> 
			</colgroup> 
			<tr> 
				<th>시스템</th> 
				<td> 
					<select id="system" name="system">
							<option value="U" selected="selected">이동형측정기기</option>
							<option value="A">국가수질자동측정망</option>
					</select>
				</td> 
			</tr>
			<tr> 				
				<th>시작일자</th> 
				<td>
					<input type="text" datepicker="Y" id="startDate" readonly="readonly" name="startDate" alt="조회시작일"/>
			 	</td>
			</tr> 
			<tr> 
				<th>종료일자</th>
				<td>
					<input type="text" datepicker="Y" id="endDate" readonly="readonly" name="endDate" alt="조회종료일"/>
				</td> 
			</tr> 
			</table> 
		</div> 
		<div  style="float:left; width:100%;text-align:center;">
			<ul class="sbtn" style="width:100%"> 
				<li style="width:90%"><a href="#" onclick="form_submit();return false;">조회</a></li> 
			</ul>
		</div>
	</form> 
</body>
</html>