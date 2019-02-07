<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="교육일정" name="title"/>
</jsp:include>

<script type="text/javascript" charset="utf-8">
	$(function(document){
		setTime();
	});
	
	function setTime(){
		//============================= 달 력 Start ======================================
		/* shows the loading div every time we have an Ajax call */
		
		
		$("input[datepicker='Y']").datepicker();
		
		var today = new Date(); 
		year = today.getFullYear();
		month = addzero(today.getMonth()+1);
		day = addzero(today.getDate());
		
		$("#searchBgnDe").val(year + "/" + month + "/01");
	}
	
	function addzero(n) {
		return n < 10 ? "0" + n : n + "";
	}
	
	function form_submit(){
		document.form1.submit();
	}
</script>
</head>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0">
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp"/>
<form name="form1" method="post" action="/mobile/sub/seminar/SeminarApplicationList.do">
	<div id="quality"> 
       	
       	<jsp:include page="/WEB-INF/jsp/mobile/sub/seminar/SeminarScheduleCommonTop.jsp">
			<jsp:param value="ApplicationList" name="Seminargubun"/>
		</jsp:include>

		<div class="rivermanage"> 
			<table width="100%"> 
			<colgroup> 
			<col width="35%" /> 
			<col width="65%" /> 
			</colgroup> 
			<tr> 
				<td>시작날짜</td> 
				<td> 
					<input type="text" name="searchBgnDe" id="searchBgnDe" datepicker="Y"/>
				</td> 
			</tr> 
			<tr> 
				<td>종료날짜</td> 
				<td>
					<input type="text" name="searchEndDe" id="searchEndDe" datepicker="Y"/>	 
				</td> 
			</tr> 				
			<tr> 
				<td>구분</td> 
				<td>
					<select name="searchGubun" id="searchGubun" class="select">
						<option value="">전체</option>
						<option value="L">강사신청</option>
						<option value="S">교육신청</option>
					</select>
				</td> 
			</tr> 
			<tr> 
				<td>마감여부</td> 
				<td>
					<select name="searchClosingState" id="searchClosingState" class="select">
					<option value="">전체</option>
					<option value="Y">신청</option>
					<option value="N">마감</option>
					</select>
				</td> 
			</tr> 
			</table> 
		</div> 
		<ul class="sbtn" style="width:100%;"> 
			<li style="width:90%;"><a href="#" onclick="form_submit();return false;">조회</a></li> 
		</ul> 
	</div>
</form> 
</body>
</html>