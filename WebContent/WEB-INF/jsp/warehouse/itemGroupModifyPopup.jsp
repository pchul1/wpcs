<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/** 
	 * Class Name :  itemGroupModifyPopup.jsp
	 * Description : 분류등록 팝업
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 201211.19	 윤일권		 최초 생성
	 *
	 * author  윤일권
	 * since	2012.11.19
	 * version 1.0
	 * see
	 * 
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 

<link href="<c:url value='/css/content.css' />" rel="stylesheet" type="text/css" />
<link href="<c:url value='/css/com.css' />" rel="stylesheet" type="text/css">
<link href="<c:url value='/css/popup.css' />" rel="stylesheet" type="text/css">
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>
<script>
	var ROOT_PATH = '<c:url value="/"/>';
</script>
<script type="text/javascript" src="<c:url value='/js/common.js'/>"></script>
<title>분류수정</title>
<script type="text/javaScript" language="javascript">

var ntype;
var gHiddenUpperGroupName;
$(function(){
	
	<sec:authorize ifAnyGranted="ROLE_ADMIN">
		$('#goModifyBtn').show();
	</sec:authorize>
	
	ntype = -1;
	//화면에 뿌려줄 값을 opener 에서 가져와 setting.
	var hiddenGroupCode = $('#hiddenGroupCode', opener.document).val();
	var hiddenGroupName = $('#hiddenGroupName', opener.document).val();
	var hiddenUseFlag	= $('#hiddenUseFlag', opener.document).val();
	gHiddenUpperGroupName = $('#isUpper', opener.document).val();
	
	//alert(gHiddenUpperGroupName);
	//var hiddenUpperGroupName = $(#'hiddenUpperGroupName001',opener.document).val();
	//alert(hiddenUpperGroupName);
	
	
	if(hiddenGroupCode.substring(4,8) !=  '0000'){
		ntype = 1;
		displayPage(1,hiddenGroupName);	
	}

	else{
		ntype = 0;
		displayPage(0,hiddenGroupName);
	}
		
	
	$('#popupGroupCode').val(hiddenGroupCode);
	//$('#popupGroupName').val(hiddenGroupName);
	$('#popupUseFlag').val(hiddenUseFlag);
	
});

function displayPage(ntype,groupName){
	
	if(ntype == 0){
		//대분류
		
		$('#groupName').text("대분류 명칭");
		$('#popupGroupName').val(groupName);
		$('#popupGroupName').attr("readonly",false);
		$('#groupCode').text("대분류 코드");
		$('.MiddleOnly01').hide();
		
	}
	else{
		//중분류
		$('#groupName').text("대분류");
		$('#popupGroupName').val(gHiddenUpperGroupName);
		$('#popupGroupName').attr("readonly",true);
		$('#groupCode').text("중분류 코드");
		$('.MiddleOnly01').show();
		$('#mPopupGroupName').val(groupName);

	}
}

//코드분류 수정
function fnGoModify(){	
	
	var content = '';
	if(ntype == 0)
		content = $('#popupGroupName').val();
	else
		content = $('#mPopupGroupName').val();
	
	$.ajax({			
		type: "POST",
		url: "<c:url value='/warehouse/itemGroupModify.do'/>",
		data: { 
				groupCode : $('#popupGroupCode').val(),
				groupName : content,
				useFlag	: $('#popupUseFlag').val()
			},	
		dataType:"json",
		beforeSend : function(){},
		success : function(result){
			opener.itemGroupDataLoad();
			opener.itemUpperGroupDataLoad();
			self.close();
		}
	});
}

function fnClosePopup(){
	self.close();
}

</script>
</head>

<body class="subPop"><!-- 추가 및 수정 -->

	<table class="dataTable" style="width:439px !important;">
		<colgroup>
			<col width="30%" />
			<col width="*" />
		</colgroup>
		<tr>
			<th scope="col" id="groupName">대분류명칭</th>
			<td>
				<input type="text"	id="popupGroupName" name="popupGroupName" style="width:90%; ime-mode:active;"/>
			</td>
		</tr>
		<tr>
			<th scope="col" id="groupCode">대분류코드</th>
			<td>
				<input type="text"	id="popupGroupCode" name="popupGroupCode" style="width:90%; ime-mode:active;" readonly="readonly"/>
				<!--  <input type="hidden" id="popupGroupCode" name="popupGroupCode"/>-->
			</td>
		</tr>
		
		<tr class="MiddleOnly01">
			<th scope="col" >중분류 명칭</th>
			<td>
				<input type="text" id="mPopupGroupName" name="mPopupGroupName" style="width:90%; ime-mode:active;" />
			</td>
		</tr>
		
		<tr>
			<th scope="col">사용여부</th>
			<td>
				<select name="popupUseFlag" id="popupUseFlag" style="width:92%">
					<option value="Y">사용</option>
					<option value="N">미사용</option>
				</select>
			</td>
		</tr>
		<tr>
			<td colspan="2" style="text-align: right;">
				<input id="goModifyBtn" onclick="javascript:fnGoModify()" type="image" src="<c:url value='/images/common/btn_save.gif'/>" style="display: none;" alt="저장" />
			</td>
		</tr>
	</table> 
</body>
</html> 