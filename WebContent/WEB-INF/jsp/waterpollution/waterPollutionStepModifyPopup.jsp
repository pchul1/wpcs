<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Map"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : waterPollutionStepModifyPopup.jsp
	 * Description : 수습(조치)경과 수정 화면
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
<%-- 			window.location = "<c:url value='/'/>"; --%>
<!-- 		</script> -->
<%-- 	</sec:authorize> --%>
		
<script type="text/javaScript" language="javascript">
	$(function () {
		var today = new Date(); 
		today = today.getFullYear()+ addzero(today.getMonth()+1) + addzero(today.getDate());
		
		var wpCode  = "${param.wpCode}";
		var wpsCode  = "${param.wpsCode}";
		
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
		
		dataLoad();
	});
	
	function fnSave(){
		var wpsContent = $('#wpsContent').val();
		
		if(wpsContent == ''){
			alert("조치내용을 입력해주세요");
			return false;
		}
		
		if(confirm("수정 하시겠습니까?")){
			document.stepForm.action = "<c:url value='/waterpollution/modifyWaterPollutionStep.do'/>";
			document.stepForm.submit();
		}
	}
	
	function addzero(n) {
		return n < 10 ? "0" + n : n + "";
	}
	
	function dataLoad(){
		var wpCode = $('#wpCode').val();
		var wpsCode = $('#wpsCode').val();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/waterpollution/waterPollutionStepModifyInfo.do'/>",
			data:{
				wpCode:wpCode,
				wpsCode:wpsCode
			}, 
			dataType:"json",
			success:function(result){
				var obj = result['detail'][0];
				var item = '';
				
				$('#wpsContent').val(obj.wpsContent);
				$('#wpsStep').val(obj.wpsStep);
				
				if(obj.wpsImg == null || obj.wpsImg == ''){
					$('#trImg_2').show();
				}else{
					$('#trImg_1').show();
					$('#deleteBtn').show();
					$('#trImg').html();
					item = "&nbsp;<img src='<c:url value='/cmmn/getImage.do'/>?atchFileId=" + obj.wpsImg + "&fileSn=0&thumbnailFlag=Y'/>";
					$("#trImg").append(item);
					
					$("#wpsImg").val(obj.wpsImg);
				}
			},
			error:function(result){}
		});
	}
	
	//사진삭제
	function fnDeleteWpsStepImg(){	
		var wpCode  = $('#wpCode').val();
		var wpsCode  = $('#wpsCode').val();
	
		if(confirm("삭제 하시겠습니까?")){
			$.ajax({
				type:"post",
				url:"<c:url value='/waterpollution/deleteWaterPollutionStepImg.do'/>",
				data:{
					wpCode:wpCode,
					wpsCode:wpsCode
				},
				dataType:"json",
				success:function(result){
					alert('삭제되었습니다.');
					window.opener.getWpStepData(wpCode);
					
// 					window.opener.location.reload();
					window.close();
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
			document.stepForm.action = "<c:url value='/waterpollution/deleteWaterPollutionStep.do'/>";
			document.stepForm.submit();
		}
	}
</script>
</head>

<body class="subPop"><!-- 추가 및 수정 -->
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
			<h1 style='font-size:large;font-weight:bold;color:white'>수습(조치)경과 수정</h1>
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
								<input type="hidden" id="wpsCode" name="wpsCode"/>
								<input type="hidden" id="wpsStepDate" name="wpsStepDate"/>
								<input type="hidden" id="wpsImg" name="wpsImg"/>
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
												<option value="STA">신고</option>
												<option value="RCV">접수</option>
												<option value="ING">수습중</option>
												<option value="END">조치완료</option>
											</select>
										</td>
									</tr>
									<tr>
										<th scope="col">내용</th>
										<td style="text-align: left;">
											&nbsp;
											<textarea rows="5" cols="45" id="wpsContent" name="wpsContent">
											</textarea>
										</td>
									</tr>
									<tr id="trImg_1">
										<th scope="col">사진</th>
										<td id="trImg" style="text-align: left;"></td>
									</tr>
									<tr id="trImg_2">
										<th scope="col">사진</th>
										<td style="text-align: left;">
											&nbsp;
											<input align="top" id="fileData" name="fileData" type="file" style="width:400px" onchange="fileUploadPreview(this, 'preView')" />
											<div id="preView" class="preView3" title="이미지미리보기"></div>
										</td>
									</tr>
								</table>
								<table style="width: 500px;">
									<tr>
										<td style="text-align: right;">
											<a id="deleteBtn" href='javascript:fnDeleteWpsStepImg()' class='btn_basic btn_bgBlue'><span>사진 삭제</span></a>
											<input id="save" type="image" src="<c:url value='/images/common/btn_save2.gif'/>" alt="저장" />
											<input id="delete" type="image" src="<c:url value='/images/common/btn_del2.gif'/>" alt="삭제" />
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
