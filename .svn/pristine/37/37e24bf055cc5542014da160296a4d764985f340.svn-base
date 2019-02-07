<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/com.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/smcube/tab.css' />" />

	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<sec:authorize ifAnyGranted="ROLE_USER">
		<script  type='text/javascript'>
			var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
		</script> 
	</sec:authorize>
	
<%-- 	<sec:authorize ifNotGranted="ROLE_USER"> --%>
<!-- 		<script  type="text/javascript"> -->
<!-- 			alert("로그인이 필요한 페이지 입니다"); -->
<!-- 			if(opener!=null) { -->
<%-- 				window.opener.location = "<c:url value='/'/>";  --%>
<!-- 				self.close(); -->
<!-- 			} else { -->
<%-- 				window.location = "<c:url value='/'/>";  --%>
<!-- 			} -->
<!-- 		</script>  -->
<%-- 	</sec:authorize> --%>
	
<script type="text/javascript">
/**
 * 달력 만들기
 */
$(function () {
	$.datepicker.setDefaults({
	    monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
	    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
	    showMonthAfterYear:true,
	    dateFormat: 'yy/mm/dd',
	    showOn: 'both',
	    buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
	    buttonImageOnly: true
	});
	$("#frdate").datepicker({
	    buttonText: '시작일'
	    
	});
	$("#todate").datepicker({
	    buttonText: '종료일'
	});
	
});
/**
 * 시작날짜가 종료날짜보다 크지 않도록 유효성 검사
 * onchange="checkDate('frdate','frdate','todate');"
 */
function checkDate(oId,sId,eId){
	var o = $("#"+oId);
	var s = $("#"+sId); 
	var e = $("#"+eId);
	var sd = parseInt(String(s.val()).replace(/[\D]/g,""),10);
	var ed = parseInt(String(e.val()).replace(/[\D]/g,""),10);
	if(o.attr("id") == s.attr("id")){
		e.val(sd>ed?s.val():e.val());
	}else if(o.attr("id") == e.attr("id")){
		s.val(sd>ed?e.val():s.val());
	}
}


var factCode = $("#fc",opener.document).val();
var branchNo = $("#bc",opener.document).val();
$(function () {
	$("#branchName").val($("#usnBranchName",opener.document).html());
	if(factCode == ""){
		alert("지점을 선택 하신 후 등록하여 주십시오.");
		window.close();
	}else{
		$("#factCode").val(factCode);
		$("#branchNo").val(branchNo);
	}
	
});
function showLoading()
{
	$("#loadingDiv").dialog({
		modal:true,
		open:function() 
		{
			$("#loadingDiv").css("visibility","visible");
			$(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar-close").hide();
			$(this).parents(".ui-dialog:first").find(".ui-dialog-titlebar").hide();
			$(this).parents(".ui-dialog:first").find(".ui-dialog-resizing").hide();
			$(this).parents(".ui-dialog:first").find(".ui-dialog-buttonpane").hide();
			$(this).parents(".ui-dialog:first").find(".ui-dialog-dragging").hide();
			$(this).parents(".ui-dialog:first").css("width", "85px");
			$(this).parents(".ui-dialog:first").css("height", "75px");
			$(this).parents(".ui-dialog:first").css("overflow", "hidden");
			$("#loadingDiv").css("float", "left");
		},
		width:0,
		height:0,
	    showCaption:false,
	    resizable:false
	});
	
	$("#loadingDiv").dialog("open");
}

function closeLoading()
{
	$("#loadingDiv").dialog("close");
}
function Commit(){
	document.board.action = "<c:url value='/spotmanage/usnInsert.do'/>";
	document.board.submit();
}
	</script>
</head>
<body style="overflow-x:hidden;overflow-y:hidden;background-image: none;">
<form:form commandName="board" name="board" method="post" enctype="multipart/form-data" >
<div id='loadingDiv' style="visibility:hidden;position:absolute;">
	<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="" />
</div>
<div id="wrap">
<div id="container">

<!-- Contents Begin Here -->
<div id="content" class="sub_waterpolmnt">
	<div class="content_wrap page_alarmmng">
		<div class="con_tit_wrap">
		  <h3>USN 측정일정추가</h3> 
	    </div>
	</div>
	
	<div class="listView_write">
		<div class="popup_situReceive" style="padding:15px 0; border:2px solid #2f8bc0; border-width:2px 0; width:530px;">
			<fieldset class="second">
				<input type="hidden" id="factCode" name="factCode" />
				<input type="hidden" id="branchNo" name="branchNo" />
					<table id="tab_1_1" class="dataTable" style="width:100%; float:left;">
						<colgroup>
							<col width="120px"></col>
							<col></col>
						</colgroup>
						<tbody>
							<tr style="display:none;">
								<th>지점명</th>
								<td><input type="text" id="branchName" name="branchName" style="width:95%"/></td>
							</tr>
							<tr>
								<th>시작일</th>
								<td><input type="text" id="frdate" name="frdate" onchange="checkDate('frdate','frdate','todate')" style="width:90%"/></td>
							</tr>
							<tr>
								<th>종료일</th>
								<td><input type="text" id="todate" name="todate" onchange="checkDate('todate','frdate','todate')" style="width:90%"/></td>
							</tr>
							<tr>
								<th>X좌표</th>
								<td><input type="text" id="longitude" name="longitude" style="width:95%"/></td>
							</tr>
							<tr>
								<th>Y좌표</th>
								<td><input type="text" id="latitude" name="latitude" style="width:95%"/></td>
							</tr>
							<tr>
								<th>설치근거</th>
								<td><input type="file" id="file" name="file" style="width:95%"/></td>
							</tr>
							<tr>
								<th>비고</th>
								<td><input type="text" id="memo" name="memo" style="width:95%"/></td>
							</tr>
						</tbody>
					</table>
			</fieldset>
		</div>
		<div align="right" style="width:530px; margin-top:10px;">
			<a href="javascript:Commit();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>등록</em></span></a>&nbsp;
			<a href="javascript:window.close();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>닫기</em></span></a>&nbsp;
		</div>
	</div>
	
</div><!-- //content -->
<!-- //Contents End Here -->
</div>

</div><!-- //wrap -->
</form:form>
</body>
</html>