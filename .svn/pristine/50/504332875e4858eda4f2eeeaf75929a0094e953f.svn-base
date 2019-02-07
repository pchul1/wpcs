<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="수질현황조회" name="title"/>
</jsp:include>

<script type="text/javascript" charset="utf-8">
	$(function(document){
		if($('#sys').val() != "A"){
			$('#auto').attr("disabled", "disabled");
		}
		CommonSelectBox('sys','sys', 'A,U','', '', "", "");
		CommonSelectBox('sugye','sugye','', $("#sys").val(), '선택', "", "");
		CommonSelectBox('branch','branch', $('#sugye').val(), "", '선택', "");
		
		$('#sugye').bind('change', function(e, data){
			var code_gbn = $('#sugye').val();
			var sys = $('#sys').val();
			CommonSelectBox('branch','branch', code_gbn, sys, "선택", "");
		});
		
		$('#sys').bind('change', function(e, data){
			var code_gbn = $('#sugye').val();
			var sys = $('#sys').val();
			CommonSelectBox('sugye','sugye', '',sys, "선택", "", "");
			CommonSelectBox('branch','branch', code_gbn, sys, "선택", "");
			autoElmActive();
		});

		
		autoElmActive();
	});
	
	function autoElmActive(){
		var sys_val = $('#sys').val();
		if(sys_val == 'A'){
			$('#auto').attr("disabled", false);
		}else{
			$('#auto').attr("disabled", true);
		}
	}
	
	function form_submit(){
		if(!vailidation($("#sugye"),'수계를 선택해주세요.')) return false;
		if(!vailidation($("#sys"),'시스템를 선택해주세요.')) return false;
		if(!vailidation($("#branch"),'측정소를 선택해주세요.')) return false;
		if(!vailidation($("#auto"),'대분류를 선택해주세요.')) return false;
		if(!vailidation($("#time_type"),'시간구분을 선택해주세요.')) return false;
		showLoading();
		document.form1.submit();
	}
</script>
</head>
<body topmargin="0" leftmargin="0" marginheight="0" marginwidth="0">
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/water/watersearch.do" name="link"/>
		<jsp:param value="수질현황조회" name="title"/>
	</jsp:include>
	<form name="form1" method="post" action="/mobile/sub/water/waterview.do">
	<div class="SearchTable"> 
		<table width="100%"> 
		<colgroup> 
		<col width="35%" /> 
		<col width="65%" /> 
		</colgroup> 
		<tr> 
			<th>수계</th> 
			<td> 
				<select id="sugye" name="sugye"> 
					<option value="R01">한강</option>
					<option value="R02">낙동강</option>
					<option value="R03">금강</option>
					<option value="R04">영산강</option>
				</select> 
			</td> 
		</tr> 
		<tr> 
			<th>시스템</th> 
			<td> 
                   <select id="sys" name="sys">
                       <option value ="U">이동형측정기기</option>
                       <option value ="A">수질측정망</option>
                   </select> 
			</td> 
		</tr> 				
		<tr> 
			<th>측정소</th> 
			<td> 
				<select id="branch" name="branch"> 
					<option value="">선택</option>
				</select> 
			</td> 
		</tr> 
		<tr> 
			<th>대분류</th> 
			<td>
				<select id="auto" name="auto"> 
					<option value="COM1">일반항목</option>
					<option value="BIO1">생물독성(물고기)</option>
					<option value="BIO2">생물독성(물벼룩1)</option>
					<option value="BIO3">생물독성(물벼룩2)</option>
					<option value="BIO4">생물독성(미생물)</option>
					<option value="BIO5">생물독성(조류)</option>
					<option value="CHLA">클로로필-a</option>
					<option value="VOCS">휘발성 유기화합물</option>
					<option value="METL">중금속</option>
					<option value="PHEN">페놀</option>
					<option value="ORGA">유기물질</option>
					<option value="NUTR">영양염류</option>
					<option value="RAIN">강수량계</option>
				</select> 
			</td> 
		</tr> 
		<tr> 
			<th>시간구분</th> 
			<td> 
				<select id="time_type" name="time_type"> 
				<option value="1">분자료</option> 
				<option value="2">시간자료</option>
				</select> 
			</td> 
		</tr> 
		</table> 
	</div> 
	<ul class="sbtn" style="width:100%"> 
		<li style="width:90%"><a href="#" onclick="form_submit();return false;">조회</a></li> 
	</ul> 
</form> 
</body>
</html>