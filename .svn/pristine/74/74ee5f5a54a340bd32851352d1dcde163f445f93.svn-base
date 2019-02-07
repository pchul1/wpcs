<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html style="margin:0;padding:0;overflow:hidden;">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>
<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<script type="text/javascript">
function goSubmit(){
	var obj = document.form1;

	if(!obj.files.value){
		alert("파일을 첨부하십시오.");
		obj.files.focus();
		return false;
	}
	
	ext = obj.files.value.substring(obj.files.value.lastIndexOf('.'),obj.files.value.length).toLowerCase();    
	if(ext != ".xls" && ext != ".xlsx"){
		alert("xls, xlsx 파일만 첨부 하실수 있습니다.");
		obj.files.focus();
		return false;
	}
	
	obj.action = "/waterpolmnt/waterinfo/uploadKumhoExcelData.do";
	obj.submit();
}
</script>
</head>
<body style="border:5px solid #07AFFA;height:98%;">
<div style="margin:20px;height:100%;">
	<form id="form1" action="" name="form1" method="post" enctype="multipart/form-data">
		<div style="clear:both;">
		<table style="text-align:left" summary="관리자정보">
			<colgroup>
				<col width="25%">
				<col>
			</colgroup>									
			<tr>
				<th>모델링 파일 <span class="red">*</span></th>
				<td>
					<input type="file" name="excelFile" id="files" size="50" class="tbox03">
				</td>
			</tr>
		</table>
		</div>
		
		<div id="btSmallArea" style="text-align:right;padding-top:10px;">
			<div style="float:right;">
				<span id="menuAuth1">
				<input type="button" id="btnAddNotice" name="btnAddNotice" value="저장" class="btn btn_basic" onclick="goSubmit();" alt="저장" />
				</span>
			</div>
		</div>
	</form>	
</div>
</body>
</html>