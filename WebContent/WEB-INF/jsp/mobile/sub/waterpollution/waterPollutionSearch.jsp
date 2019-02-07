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
	<jsp:param value="사고관리" name="title"/>
</jsp:include>

<script type="text/javascript" charset="utf-8">
	$(function(document){
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
	
	function form_submit(n){
		if(n != ''){
			document.form1.action = n;
		}
		else{
			document.form1.action = "/mobile/sub/waterpollution/waterPollutionList.do";
		}
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
		<jsp:param value="/mobile/sub/waterpollution/waterPollutionSearch.do" name="link"/>
		<jsp:param value="사고관리" name="title"/>
	</jsp:include>
<form name="form1" method="post" action="/mobile/sub/waterpollution/waterPollutionList.do">
	<div class="SearchTable"> 
		<table width="100%"> 
		<colgroup> 
		<col width="35%" /> 
		<col width="65%" /> 
		</colgroup> 
		<tr> 
			<th>수계</th> 
			<td> 
				<select id="searchRiverDiv" name="searchRiverDiv"></select> 
			</td> 
		</tr>
		<tr> 
			<th>유형</th> 
			<td> 
				<select id="searchWpKind" name="searchWpKind">
					<option value="">전체</option>
					<option value="PA">유류유출</option>
					<option value="PB">물고기폐사</option>
					<option value="PC">화학물질</option>
					<option value="PD">기타</option>
				</select>
			</td> 
		</tr>
		<tr> 
			<th>단계</th> 
			<td> 
				<select id="searchWpsStep" name="searchWpsStep">
					<option value="">전체</option>
					<option value="STA">신고</option>
					<option value="RCV">접수</option>
					<option value="ING">수습중</option>
					<option value="END">조치완료</option>
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
		<tr> 
			<th>지원구분</th> 
			<td> 
				<select id="searchSupportKind">
					<option value="">전체</option>
					<option value="Y">지원</option>
					<option value="N">접수</option>
				</select>
			</td> 
		</tr> 
		</table> 
	</div> 
	<div  style="float:left; width:50%;text-align:center;">
		<ul class="sbtn"> 
			<li style="width:90%"><a href="#" onclick="form_submit('');return false;">조회</a></li> 
		</ul>
	</div>
	<div  style="float:left; width:50%;text-align:center;">
		<ul class="sbtn">
			<li style="width:90%"><a href="/mobile/sub/waterpollution/waterPollutionRegist.do" onclick="form_submit(this.href);return false;">등록</a></li> 
		</ul>
	</div> 
</form> 

</body>
</html>