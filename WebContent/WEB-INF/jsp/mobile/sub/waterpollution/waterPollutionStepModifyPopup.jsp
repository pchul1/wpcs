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
		
		var wpCode  = "<c:out value="${param.wpCode}"/>";
		var wpsCode  = "<c:out value="${param.wpsCode}"/>";
		
		$('#wpCode').val(wpCode);
		$('#wpsCode').val(wpsCode);
		$('#wpsStepDate').val(today);
		
		$('#trImg_1').hide();
		$('#trImg_2').hide();
		$('#deleteBtn').hide();
		
		//저장버튼 클릭시
		$('#save').click(function(){
			fnSave();
		});
		
		//삭제버튼 클릭시
		$('#delete').click(function(){
			fnDelete();
		});
	});
	
	function fnSave(){
		var wpsContent = $('#wpsContent').val();
		
		if(wpsContent == ''){
			alert("조치내용을 입력해주세요");
			return false;
		}
		
		if(confirm("수정 하시겠습니까?")){
			document.stepForm.action = "<c:url value='/mobile/sub/waterpollution/modifyWaterPollutionStep.do'/>";
			document.stepForm.submit();
		}
	}
	
	function addzero(n) {
		return n < 10 ? "0" + n : n + "";
	}
	
	//사진삭제
	function fnDeleteWpsStepImg(){	
		var wpCode  = $('#wpCode').val();
		var wpsCode  = $('#wpsCode').val();
	
		if(confirm("삭제 하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"<c:url value='/mobile/sub/waterpollution/deleteWaterPollutionStepImg.do'/>",
				data:{
					wpCode:wpCode,
					wpsCode:wpsCode
				},
				dataType:"json",
				success:function(result){
					alert('삭제되었습니다.');
					window.parent.getWpStepImgDel(wpsCode);
// 					window.opener.location.reload();
				},
				error:function(result){}
			});
		}
	}
	
	//수습(조치)경과 삭제
	function fnDelete(){
		var wpCode = $('#wpCode').val();
		var wpsCode = $('#wpsCode').val();
		
		if(confirm("삭제 하시겠습니까?")){
			document.stepForm.action = "<c:url value='/mobile/sub/waterpollution/deleteWaterPollutionStep.do'/>";
			document.stepForm.submit();
		}
	}
</script>
</head>
<body class="subPop"><!-- 추가 및 수정 -->
<div>
	<div class="write">
		<form id="stepForm" action="" name="stepForm" method="post" onsubmit="return false;" enctype="multipart/form-data">
			<input type="hidden" id="wpCode" name="wpCode" value="<c:out value="${View.wpCode}"/>"/>
			<input type="hidden" id="wpsCode" name="wpsCode" value="<c:out value="${View.wpsCode}"/>"/>
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
							<option value="ING"<c:if test="${View.wpsStep eq 'ING' }">selected="selected"</c:if>>수습중</option>
							<option value="END"<c:if test="${View.wpsStep eq 'END' }">selected="selected"</c:if>>조치완료</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td>
						<textarea rows="5" id="wpsContent" name="wpsContent"><c:out value="${View.wpsContent}"/></textarea>
					</td>
				</tr>
				<tr>
					<th>사진</th>
					<td>
						<input align="top" id="fileData" name="fileData" type="file"/>
						<c:if test="${!empty View.wpsImg}">
						<div style="width:80px;float:left;margin:0;">
							<ul class="sbtn" style="text-align:center;margin:0;height:20px;">
								<li style="width:90%;margin:0;height:20px;background-color:#3792c5;font-size:12px;padding:0;"><a style="padding: 10px 5px"href="#" onclick="fnDeleteWpsStepImg(); return false;">사진삭제</a></li>
							</ul>
						</div> 
						</c:if>
					</td>
				</tr>
			</table>
			<div style="width:50%;float:left;">
				<ul class="sbtn" style="margin:5px;text-align:center;">
					<li style="width:90%;"><a href="#" onclick="fnDelete(); return false;">삭제</a></li>
				</ul>
			</div> 
			<div style="width:50%;float:left;">
				<ul class="sbtn" style="margin:5px;text-align:center;">
					<li style="width:90%;"><a href="#" onclick="fnSave(3); return false;">등록하기</a></li>
				</ul>
			</div> 
		</form>
	</div>
	<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 -->
</div>

</body>
</html>
