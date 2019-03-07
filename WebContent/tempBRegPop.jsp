<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:import url="/WEB-INF/jsp/include/common/include_authUserPopup.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<title>한국환경공단 수질오염 방제정보 시스템</title>
<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/com.css' />" />
<link rel="stylesheet" type="text/css" href="<c:url value='/css/smcube/tab.css' />" />

<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
<script type="text/javascript" src="<c:url value='/js/JQuery/jquery.form.js'/>"></script>

<script type="text/javascript">
var regUpdateType = 0;
var tempData;

	$(function () {
		//사업장조회
		$("#regId").val(request.getParameter('regId'));
		$("#longitude").val(request.getParameter('X'));
		$("#latitude").val(request.getParameter('Y'));
		
		// type = 0 등록 , type  = 1 수정
		regUpdateType = request.getParameter('type');
		if(regUpdateType == 0){
			$('#regBtn').html('등록');
		}else{
			$('#regBtn').html('수정');
			if(opener){
				tempData = opener._CoreMap.getSelectedTempBranchFeature();	
			}else{
			 	window.close();
			}
			
			if(tempData == null){
				alert('선택된 정보가 없습니다.');
				window.close();
				return;
			}else {
				$("#titleNm").val(tempData.TITLE);
				$("#contentNm").val(tempData.CONTENT);
				$("#regId").val(tempData.REG_ID);
				$("#longitude").val(tempData.X);
				$("#latitude").val(tempData.Y);
				$("#allYn").val(tempData.ALL_YN);
				$('#useYn').val(tempData.USE_YN);
			}
		}
	});
	
	function addTempPoint(){
		var obj = {};
			
		var date = new Date();
		var regDate = date.getFullYear() + addzero(date.getMonth()+1) + addzero(date.getDate())+addzero(date.getHours())+addzero(date.getMinutes());
		if(regUpdateType == 1 && tempData != null){
			obj.objectId = tempData.OBJECTID;	
			obj.tempSrno = tempData.TEMP_SRNO;
			obj.type = 'U';
		}else{
// 			obj.TEMP_SRNO = parseInt(Math.random()*1000000)+date.getDate();
			obj.type = 'I';
		}
		
 		obj.title = $("#titleNm").val();
		obj.content = $("#contentNm").val();
// 		obj.REG_ID = $("#regId").val();
//		obj.REG_DATE = regDate;
		obj.x = $("#longitude").val();
		obj.y = $("#latitude").val();
		obj.allYn = $("#allYn").val();
		obj.useYn = $('#useYn').val();
		if(obj.title.length <= 0) {
			alert('임의지점 명을 입력하세요.');
			return;
		}
		if(obj.content.length <= 0) {
			alert('상세 정보를 입력하세요.');
			return;
		}
		
		$.ajax({
			url:'/psupport/jsps/editTempBranch.jsp',
			type :'POST',
			data: obj,
			success:function(result){
				if(parseInt(result)> 0){
					alert("저장했습니다");
					if(opener){
						opener._CoreMap.refreshTempBranchLayer();	
					}
					window.close();
				}
			}, 
			error:function(result){  
				alert("서버접속에 실패하였습니다.\n다시 확인해주세요.");
			}
		});
	}
</script>
</head>

<body style="overflow-x:hidden;overflow-y:hidden;background-image: none;">
	<div id='loadingDiv' style="visibility:hidden;position:absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="" />
	</div>
	<div id="layerFullBgDiv"></div>
	
	<div id="wrap" style="padding:10px;width:95%">
		<div id="container">
		
			<!-- Contents Begin Here -->
			<div id="content" class="sub_waterpolmnt" style="padding:0px;width:100%;">
				<div class="content_wrap page_alarmmng">
					<div class="con_tit_wrap">
						<h3>임의지점 등록</h3> 
					</div>
				</div>
				<div class="listView_write" style="padding:0px;width:100%;">
					<div class="popup_situReceive" style=" padding:15px 0; border:2px solid #2f8bc0; border-width:2px 0;">
						<fieldset class="first">
							<div class="tabDisplayArea"></div>
							<table id="tab_1_1" class="dataTable" style="width:100%; float:left;">
								<colgroup>
									<col width="120px"></col>
									<col></col>
								</colgroup>
								<tbody>
									<tr>
										<th scope="row">임의지점 명</th>
										<td>
											<input type="text" id="titleNm" name="titleNm"  style="width:300px;"/>
										</td>
									</tr>
									<tr>
										<th scope="row">지도표시여부</th>
										<td><select id="useYn" style="width:380px;"><option value="1">표시</option><option value="0">표시안함</option></select></td>
									</tr>
									<tr>
										<th scope="row">표시대상</th>
										<td><select id="allYn" style="width:380px;"><option value="1">전체</option><option value="2">등록자</option></select></td>
									</tr>
									<tr>
										<th scope="row">좌표</th>
										<td>
											<input type="text" id="latitude" name="latitude" style="width:145px; background-color:#f2f2f2;" readonly="readonly" />&nbsp;
											<input type="text" id="longitude" name="longitude" style="width:145px; background-color:#f2f2f2;" readonly="readonly" />
										</td>
									</tr>
									<tr>
										<th scope="row">등록자</th>
										<td>
											<input type="text" id="regId" name="regId" style="width:145px; background-color:#f2f2f2;" readonly="readonly" />
										</td>
									</tr>
									<tr>
										<th scope="row">상세정보</th>
										<td><textarea  type="textarea" id="contentNm" name="contentNm" style="width:380px;" rows="10"  ></textarea></td>
									</tr>
								</tbody>
							</table>
							<div style="float:right;margin:20px 0px;">
								<a onclick="javascript:addTempPoint();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em id="regBtn">등록</em></span></a>&nbsp;
								<a onclick="javascript:window.close();" style="selector-dummy:expression(this.hideFocus=false);" class="btn_mng"><span><em>닫기</em></span></a>
							</div>
						</fieldset>
					</div>
				</div>
			</div><!-- //content -->
	<!--//레이어-->
		</div><!-- //Contents End Here -->
	</div><!-- //wrap -->
</body>
</html>