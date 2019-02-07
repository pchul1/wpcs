<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : waterPollutionStepPopup.jsp
	 * Description : 수습(조치)경과 추가 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------	
	 * 2010.05.20	k			최초 생성
	 * 2014.04.18	lkh			리뉴얼
	 *
	 * author k
	 * since 2010.05.20
	 * 
	 * Copyright (C) 2010 by k  All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<sec:authorize ifAnyGranted="ROLE_USER">
		<script  type='text/javascript'>
			var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
		</script> 
	</sec:authorize>
	
<%-- 	<sec:authorize ifNotGranted="ROLE_USER"> --%>
<!-- 		<script  type='text/javascript'> -->
<!-- 			alert('로그인이 필요한 페이지 입니다'); -->
<%-- 			window.location = "<c:url value='/'/>";  --%>
<!-- 		</script>  -->
<%-- 	</sec:authorize> --%>
		
<script type="text/javaScript" language="javascript">
	$(function () {
		var today = new Date(); 
		today = today.getFullYear()+ addzero(today.getMonth()+1) + addzero(today.getDate());
		
		var wpCode = "${param.wpCode}";
		
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
			return false;
		}
		
		if(confirm("저장 하시겠습니까?")){
			document.stepForm.action = "<c:url value='/waterpollution/addWaterpollutionStep.do'/>";
			document.stepForm.submit();
		}
	}
	
	function addzero(n) {
		return n < 10 ? "0" + n : n + "";
	}
	
	//첨부파일 변경시
	function fileUploadPreview(thisObj, preViewer) {
		if(!/(\.gif|\.jpg|\.jpeg|\.png)$/i.test(thisObj.value)) {
			alert("이미지 형식의 파일을 선택하십시오");
			return;
		}
		
		preViewer = (typeof(preViewer) == "object") ? preViewer : document.getElementById(preViewer);
		var ua = window.navigator.userAgent;
// 		console.log("ua : ",ua);
// 		console.log("thisObj.value : ",thisObj.value);
		if (ua.indexOf("MSIE") > -1) {
			var img_path = "";
			if (thisObj.value.indexOf("\\fakepath\\") < 0) {
				img_path = thisObj.value;
			} else {
				thisObj.select();
				var selectionRange = document.selection.createRange();
				img_path = selectionRange.text.toString();
				thisObj.blur();
			}
			preViewer.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='fi" + "le://" + img_path + "', sizingMethod='scale')";
		} else {
			preViewer.innerHTML = "";
			var W = preViewer.offsetWidth;
			var H = preViewer.offsetHeight;
			var tmpImage = document.createElement("img");
			preViewer.appendChild(tmpImage);
			
			tmpImage.onerror = function () {
				return preViewer.innerHTML = "";
			}
			
			tmpImage.onload = function () {
				if (this.width > W) {
					this.height = this.height / (this.width / W);
					this.width = W;
				}
				if (this.height > H) {
					this.width = this.width / (this.height / H);
					this.height = H;
				}
			}
			if (ua.indexOf("Firefox/3") > -1) {
				var picData = thisObj.files.item(0).getAsDataURL();
				tmpImage.src = picData;
			} else {
				tmpImage.src = "file://" + thisObj.value;
			}
		}
	}
</script>
</head>

<body class="subPop"><!-- 추가 및 수정 -->
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
			<h1 style='font-size:large;font-weight:bold;color:white'>수습(조치)경과 추가</h1>
		</div>
	</div>
</div>
<div class="contentWrap">
	<div class="contentBg_r">
		<div class="contentBox">
			<div class="contentPad"><!-- //추가 및 수정 -->
				<div class="asmPop" style="padding-top:20px">
					<div class="content">
						<div class="overBox">
							<form id="stepForm" action="" name="stepForm" method="post" onsubmit="return false;" enctype="multipart/form-data">
								<input type="hidden" id="wpCode" name="wpCode"/>
								<input type="hidden" id="wpsStepDate" name="wpsStepDate"/>
								<table class="dataTable" style="width: 500px;">
									<colgroup>
										<col width="30px" />
										<col width="150px" />
									</colgroup>
									<tr>
										<th scope="col">단계</th>
										<td style="text-align: left;">
											&nbsp;
											<select id="wpsStep" name="wpsStep">
												<option value="ING">수습중</option>
												<option value="END">조치완료</option>
											</select>
										</td>
									</tr>
									<tr>
										<th scope="col">내용</th>
										<td style="text-align: left;">
											&nbsp;
											<textarea rows="5" cols="45" id="wpsContent" name="wpsContent"></textarea>
										</td>
									</tr>
									<tr>
										<th scope="col">사진</th>
										<td style="text-align:left;">
											&nbsp;
											<input align="top" id="fileData" name="fileData" type="file" style="width:400px" onchange="fileUploadPreview(this, 'preView')" />
											<div id="preView" class="preView3" title="이미지미리보기"></div>
										</td>
									</tr>
								</table>
								<table style="width: 500px;">
									<tr>
										<td style="text-align:right;">
											<input id="save" type="image" src="<c:url value='/images/common/btn_save2.gif'/>" alt="저장" />
										</td>
									</tr>
								</table>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 -->
</body>
</html>
