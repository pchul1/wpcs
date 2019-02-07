<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="사고관리" name="title"/>
</jsp:include>
<script type="text/javaScript">
$(function () {
	var today = new Date(); 
	today = today.getFullYear()+ addzero(today.getMonth()+1) + addzero(today.getDate());
	
	var wpCode = "<c:out value="${param.wpCode}"/>";
	
	$('#wpCode').val(wpCode);
	$('#wpsStepDate').val(today);
	$('#wpsContent').val('');
	
	$('#save').click(function(){
		fnSave();
	});
});

//저장
function fnSave(){
	var wpsContent = $('#wpsContent').val();

	
	if(wpsContent == ''){
		alert("조치내용을 입력해주세요");
		$('#wpsContent').focus();
		return false;
	}

	if(document.stepForm.fileData.value){
		if(!/(\.gif|\.jpg|\.jpeg|\.png)$/i.test(document.stepForm.fileData.value)) {
			alert("이미지 형식의 파일을 선택하십시오");
			return false;
		}
	}
	
	if(confirm("저장 하시겠습니까?")){
		document.stepForm.action = "<c:url value='/mobile/sub/waterpollution/addWaterpollutionStep.do'/>";
		document.stepForm.submit();
	}
}

function addzero(n) {
	return n < 10 ? "0" + n : n + "";
}
</script>
</head>

<body class="subPop"><!-- 추가 및 수정 -->
<div>
	
	<div class="write">
		<form id="stepForm" action="" name="stepForm" method="post" onsubmit="return false;" enctype="multipart/form-data">
			<input type="hidden" id="wpCode" name="wpCode"/>
			<input type="hidden" id="wpsStepDate" name="wpsStepDate"/>
			
			<table summary="접수정보" style="text-align:left">
				<colgroup> 
					<col width="90px" /> 
					<col width="*" /> 
				</colgroup>
				<tr> 
					<th>단계</th>
					<td>
						<select id="wpsStep" name="wpsStep">
							<option value="ING">수습중</option>
							<option value="END">조치완료</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="5" id="wpsContent" name="wpsContent"></textarea>
					</td>
				</tr>
				<tr>
					<th>사진</th>
					<td>
						<input align="top" id="fileData" name="fileData" type="file"/>
					</td>
				</tr>
			</table>
			<div>
				<ul class="sbtn" style="width:100%;text-align:center;">
					<li style="width:90%;"><a href="#" onclick="fnSave(3); return false;">등록하기</a></li>
				</ul>
			</div> 
		</form>
	</div>
	<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 -->
</div>

</body>
</html>