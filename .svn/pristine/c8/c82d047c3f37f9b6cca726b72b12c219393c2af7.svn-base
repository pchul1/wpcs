<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : smsmanage.jsp
	 * Description : sms관리 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2013.11.05	lkh			리뉴얼
	 * 2014.11.20  mypark    그리드 걷어내고 테이블 처리
	 * 
	 * author lkh
	 * since 2013.11.05
	 *
	 * Copyright (C) 2013 by lkh All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->
<head> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>
<title>한국환경공단 수질오염 방제정보 시스템</title>
<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<script type="text/javascript">
$(function(){
	var _url = "/cmmn/getCode.do";
	var _data = "code_id=50&flag=select";
	
	$.ajax({
		type: "POST",
		url: _url,
		data: _data,
		dataType: 'json',				
		success : function(data){
			var result = data["codes"];
			var obj = "";
			var html = "";
			for(i = 0; i<result.length; i++){
				obj = result[i];
				html += "<option value='" + obj.VALUE + "'>" + obj.CAPTION + "</option>" 
			}
			$("#d_det_code option").remove();
			$("#d_det_code").append(html);
			
		},
		 error: function(data) {
			alert('에러! 상태 = ' + data.status);
		 }
	});
	reload();
	setDept();		//부서셋팅
	$("#dept").change(function(){
		setPerson(); //직원셋팅
	});
})

function reload(){
	showLoading();
	$.ajax({
		type:"post",
		url:"<c:url value='/smsmanage/ListDetailSmsConfig.do'/>",
		dataType:"json",
		success:function(result){
			var html = "";
			var onclickLink = "";
			if(result.List.length == 0){
				html += "<tr><td colspan='6'>조회 결과가 없습니다.</td></tr>";
			}else{
				for(i=0;i<result.List.length;i++){
					var trNo = i+1;
					
					onclickLink = "<a href='#' onclick=\" return false;\">";
					html += "<tr id='tr"+trNo+"' onclick=\"javascript:clickTrEvent(this);SmsConfigDetail('"+result.List[i].det_code+"', '"+result.List[i].sys_kind+"');\">";
					html += "<td>" + (i + 1) + "</td>";
					html += "<td>" + onclickLink + result.List[i].det_code + "</a></td>";
					html += "<td>" + onclickLink + ((result.List[i].sys_kind == "A") ? "국가수질 자동 측정망 " : "이동형측정기기 ") + result.List[i].det_code_name + "</a></td>";
					html += "<td>" + onclickLink + result.List[i].det_content + "</a></td>";
					html += "<td>" + onclickLink + result.List[i].det_cycle + "</a></td>";
					html += "<td>" + onclickLink + result.List[i].user_yn + "</a></td>";
					html += "</tr>";
				}
			}
			$("#dataList").html(html);
			$("#dataList tr:odd").addClass("even");	
			closeLoading();
		},
		error:function(result){
			// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
			var oraErrorCode = "";
			if (result.responseText != null ) {
				var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
				if (matchedValue != null && matchedValue.length > 0) { 
					oraErrorCode = matchedValue[0].replace('ORA-', '');
				}
			}
			
			$("#dataList").html("");
			$("#dataList").html("<tr><td colspan='6' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
			closeLoading();
		}
	});
}

function SmsConfigDetail(det_code,sys_kind){
	$("#btnModify").css("display","");
	$("#sPerson option").remove();
	$("#person option").remove();
	$('#smsdetail').css('display','none');
	$('#registlayerid').css('display','none');
	CommonSmsTargetList(det_code);
	SmsBranchConfigDetail(det_code,sys_kind);
	$("#smsTargetButton").css("display","");
	$.ajax({
		type:"post",
		url:"<c:url value='/smsmanage/DetailSmsConfig.do'/>",
		data:{
			sys_kind:sys_kind,
			det_code:det_code
		},
		dataType:"json",
		success:function(result){
			$("#d_sys_kind").val(result.Detail.sys_kind);
			$("#d_det_code").val(result.Detail.det_code);
			$("#d_det_cycle").val(result.Detail.det_cycle);
			$("#d_det_content").val(result.Detail.det_content);
			$("#d_user_yn").val(result.Detail.user_yn);
			closeLoading();
		},
		error:function(result){
			closeLoading();
		}
	});
}

function CommonSmsTargetList(det_code){
	$.ajax({
		type:"post",
		url:"<c:url value='/smsmanage/CommonSmsTargetList.do'/>",
		data:{
			det_code:det_code
		},
		dataType:"json",
		success:function(result){
			var html = "";
			var onclickLink = "";
			if(result.List.length == 0){
				html += "<tr><td colspan='5'>조회 결과가 없습니다.</td></tr>";
			}else{
				for(i=0;i<result.List.length;i++){
					onclickLink = "<a href='#' onclick=\"SmsTargetDelete('"+result.List[i].member_id+"'); return false;\">";
					html += "<tr>";
					html += "<td>" + (i + 1) + "</td>";
					html += "<td>" + result.List[i].memberName + "</td>";
					html += "<td>" + result.List[i].deptNoName + "</td>";
					html += "<td>" + result.List[i].mobileNo + "</td>";
					html += "<td>" + onclickLink + "X" + "</a></td>";
					html += "</tr>";
				}
			}
			$("#smsdataList").html(html);
			$("#smsdataList tr:odd").addClass("even");	
			closeLoading();
		},
		error:function(result){
			// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
			var oraErrorCode = "";
			if (result.responseText != null ) {
				var matchedValue = result.responseText.match(/ORA-[0-9]{5}/);
				if (matchedValue != null && matchedValue.length > 0) { 
					oraErrorCode = matchedValue[0].replace('ORA-', '');
				}
			}
			
			$("#smsdataList").html("");
			$("#smsdataList").html("<tr><td colspan='5' style='text-align:center;'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
			closeLoading();
		}
	});
}

function fnRegist(){
	$("#smsdetail").css("display","");
	$("#smsdetail").find("input[type='text']").val("");
	$("#smsdetail").find("select").val("");
	$("#btnModify").css("display","none");
	$("#smsTargetButton").css("display","none");
	$('#registlayerid').css('display','none');
	$("#smsdataList").html("");
	$("#smsdataList").html("<tr><td colspan='5' style='text-align:center;'>검출내역목록을  선택해 주세요.</td></td>");
	
	$("#smsBranchList_1").css("display","");
	$("#smsBranchList_2").css("display","none");
	$("#smsBranchListButton").css("display","none");
	$("#d_det_code").val("");
	$("#sPerson option").remove();
	$("#person option").remove();
}

function InsertSmsConfig(){
	var d_sys_kind = $("#d_sys_kind").val();
	var d_det_code = $("#d_det_code").val();
	var d_det_cycle = $("#d_det_cycle").val();
	var d_det_content = $("#d_det_content").val();
	var d_user_yn = $("#d_user_yn").val();
	var submit_flag = true;
	if(d_det_code.length < 1){
		alert("검출 내용을 입력해 주세요");
		$("#d_det_code").focus();
		submit_flag = false;
	}else if(d_det_content.length < 1){
		alert("검출 세부 내용을 입력해 주세요");
		$("#d_det_content").focus();
		submit_flag = false;
	}

	if(confirm("등록하시겠습니까?")){
		if(submit_flag){
			showLoading();
			$.ajax({
				type:"post",
				url:"<c:url value='/smsmanage/InsertSmsConfig.do'/>",
				data:{
					sys_kind:d_sys_kind,
					det_code:d_det_code,
					det_cycle:d_det_cycle,
					det_content:d_det_content,
					user_yn:d_user_yn
				},
				dataType:"json",
				success:function(result){
					alert("등록하였습니다.")
					reload();
					closeLoading();
				},
				error:function(result){
					closeLoading();
				}
			});
		}
	}
}


//SMS 보낼 직원 추가
function add(){
	$("#person option:selected").each(function(i){
		var addOpt = document.createElement('option'); // 옵션을 설정한다..
		addOpt.value = $(this).val();
		addOpt.appendChild(document.createTextNode($(this).text())); // 셀렉트 박스의 text 를 설정한다.
		
		var flag = false;
		$("#sPerson option").each(function(i){
			if($(this).val() == addOpt.value){
				flag = true;
				return false;//break;
			}
		});
		
		if(!flag){
			$("#sPerson").append(addOpt);
		}
	});
}

//SMS 보낼 직원 삭제
function del(){
	$("#sPerson option:selected").each(function(i){
		//$(this).appendTo('#person');
		$(this).remove();
	});
}

//부서별 직원생성
function setPerson(){
	var value = $("#dept > option:selected").val();
	var dropDownSet = $("#person");
	
	if(value == undefined)
		return;
	
	$.getJSON("<c:url value='/alert/getGroupAndMember.do'/>",
		{
			orderType:"2",
			value:value
		},
		//, system:sys_kind},
		function (data, status){
		if(status == 'success'){
			//locId 객체에 SELECT 옵션내용 추가.
			
			dropDownSet.loadSelect(data.groupList);
			//adjustBranchList();
		
		} else {
			return;
		}
	});
}

function setDept(){
	var dropDownSet = $("#dept");
	
	$("#sPerson").emptySelect();
	
	$.getJSON("<c:url value='/alert/getGroupAndMember.do'/>",
		{
			orderType:"1"
		},
		//, system:sys_kind},
		function (data, status){
			if(status == 'success'){
				//locId 객체에 SELECT 옵션내용 추가.
				
				dropDownSet.loadSelect(data.groupList);
				
				setPerson();
				//adjustBranchList();
				
			} else {
				return;
			}
	});
}

function goSave(){
	var member = new Array;	
	var cnt = 0;
	
	$("#sPerson option").each(function() {
		member.push($(this).val());
		cnt++;
	});
	
	$("#member_id").val(member);
	if(cnt == 0) {
		alert("대상자를 선택하여 주십시요.");
		return false;
	}
	
	if(confirm("등록하시겠습니까?")){
		showLoading();
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/InsertSmsTarget.do'/>",
			data:{ 
				member_id:$("#member_id").val() ,
				recv_type:"C",
				det_code:$("#d_det_code").val() 
				},
			dataType:"json",
			success:function(result){
				alert("등록하였습니다.")
				SmsConfigDetail($("#d_det_code").val(),$("#d_sys_kind").val());
				closeLoading();
			},
			error:function(result){
				closeLoading();
			}
		});
	}
}


function SmsTargetDelete(memid){
	$("#member_id").val(memid);
	
	if(confirm("삭제하시겠습니까?")){
		showLoading();
		$.ajax({
			type:"post",
			url:"<c:url value='/smsmanage/DeleteSmsTarget.do'/>",
			data:{ 
				member_id:$("#member_id").val(),
				recv_type:"C",
				det_code:$("#d_det_code").val() 
				},
			dataType:"json",
			success:function(result){  
				alert("삭제하였습니다.")
				SmsConfigDetail($("#d_det_code").val(),$("#d_sys_kind").val());
				closeLoading();
			},
			error:function(result){
				closeLoading();
			}
		});
	}
}

function SmsBranchConfigDetail(det_code,sys_kind){
	var rowspan="3"
	$("#smsBranchListButton").css("display","");
	$("#smsBranchList_1").css("display","none");
	$("#smsBranchList_2").css("display","");
	$("#smsBranchListTr1").css("display","none");
	$("#smsBranchListTr2").css("display","none");
	$("#smsLeaveDesc").css("display","none");
	
	$("#smsBranchListTr5").css("display","");
	$("#smsBranchListTr6").css("display","");

	if(det_code == "SMSCD001"){
		rowspan="4";
		$("#smsBranchListTr1").css("display","");
	} 
	if(det_code == "SMSCD004"){
		rowspan="4";
		$("#smsBranchListTr2").css("display","");
		$("#smsBranchListTr5").css("display","none");
		$("#smsLeaveDesc").css("display","");
	}
	if(det_code == "SMSCD002"){
		rowspan="3";
		$("#smsBranchList_2").css("display","");
		$("#smsBranchListTr5").css("display","");
		//$("#smsBranchListTr6").css("display","none");
	}
	if(det_code == "SMSCD003"){
		rowspan="2";
		$("#smsBranchListTr5").css("display","none");
	}
	
	$("#smsBranchListTd1").attr("rowspan",rowspan);
	$("#smsBranchListSpan").html(det_code);
	
	$.ajax({
		type:"post",
		url:"<c:url value='/smsmanage/DetailSmsBranchConfig.do'/>",
		data:{
			sys_kind:sys_kind,
			det_code:det_code
		},
		dataType:"json",
		success:function(result){
			result = result.Detail;
	
			$("#not_send_from").val("");
			$("#not_send_to").val("");
			$("#send_detail_explan").val("");
			$("#chk_delay").val("");
			$("#delay_detail_explan").val("");
			$("#not_rcv").val("");
			$("#time_detail_explan").val("");
			$("#chk_loc").val("");
			$("#not_rcv_detail_explan").val("");
			$("#chk_time").val("");
			$("#time_detail_explan").val("");
			
			$("#send_use_flag").attr('checked', false);
			$("#delay_use_flag").attr('checked', false);
			$("#time_use_flag").attr('checked', false);
			$("#loc_use_flag").attr('checked', false);
			$("#not_rcv_use_flag").attr('checked', false);
	
			if(result != null){
				$("#not_send_from").val(result.not_send_from);
				$("#not_send_to").val(result.not_send_to);
				$("#send_detail_explan").val(result.send_detail_explan);
				$("#chk_delay").val(result.chk_delay);
				$("#delay_detail_explan").val(result.delay_detail_explan);
				$("#not_rcv").val(result.not_rcv);
				$("#time_detail_explan").val(result.time_detail_explan);
				$("#chk_loc").val(result.chk_loc);
				$("#not_rcv_detail_explan").val(result.not_rcv_detail_explan);
				$("#chk_time").val(result.chk_time);
				$("#time_detail_explan").val(result.time_detail_explan);
				
				$("#send_use_flag").attr('checked', false);
				$("#delay_use_flag").attr('checked', false);
				$("#time_use_flag").attr('checked', false);
				$("#loc_use_flag").attr('checked', false);
				$("#not_rcv_use_flag").attr('checked', false);
				
				if(result.send_use_flag == "Y") $("#send_use_flag").attr('checked', true);
				if(result.delay_use_flag == "Y") $("#delay_use_flag").attr('checked', true);
				if(result.time_use_flag == "Y") $("#time_use_flag").attr('checked', true);
				if(result.loc_use_flag == "Y") $("#loc_use_flag").attr('checked', true);
				if(result.not_rcv_use_flag == "Y") $("#not_rcv_use_flag").attr('checked', true);
			}
			closeLoading();
		},
		error:function(result){
			closeLoading();
		}
	});
}

function goConfigSave(){
	if($("#d_det_code").val() == "SMSCD001" && $("#not_rcv").val() == "")
	{
		alert("수신율을 입력해 주세요");
		$("#not_rcv").focus();
	}
	else if($("#d_det_code").val() == "SMSCD001" && $("#not_rcv").val() > 100)
	{
		alert("수신율은 100미만으로 입력해 주세요");
		$("#not_rcv").focus();
	}
	else if($("#d_det_code").val() == "SMSCD004" && $("#chk_loc").val() == "")
	{
		alert("위치이탈을 입력해 주세요");
		$("#chk_loc").focus();
	}
	else{
		if(confirm("등록하시겠습니까?")){
			showLoading();
			$.ajax({
				type:"post",
				url:"<c:url value='/smsmanage/InsertSmsBranchConfig.do'/>",
				data:{ 
					det_code : $("#d_det_code").val(),
					sys_kind : $("#d_sys_kind").val(),
					not_send_from : $("#not_send_from").val(),
					not_send_to : $("#not_send_to").val(),
					chk_delay : $("#chk_delay").val(),
					not_rcv : $("#not_rcv").val(),
					chk_loc : $("#chk_loc").val(),
					chk_time : $("#chk_time").val(),
					send_detail_explan : $("#send_detail_explan").val(),
					delay_detail_explan : $("#delay_detail_explan").val(),
					not_rcv_detail_explan : $("#not_rcv_detail_explan").val(),
					loc_detail_explan : $("#loc_detail_explan").val(),
					time_detail_explan : $("#time_detail_explan").val(),
					send_use_flag : ($("#send_use_flag").attr("checked") ? "Y" : "N"),
					delay_use_flag : ($("#delay_use_flag").attr("checked") ? "Y" : "N"),
					not_rcv_use_flag : ($("#not_rcv_use_flag").attr("checked") ? "Y" : "N"),
					loc_use_flag : ($("#loc_use_flag").attr("checked") ? "Y" : "N"),
					time_use_flag : ($("#time_use_flag").attr("checked") ? "Y" : "N")
					},
				dataType:"json",
				success:function(result){  
					alert("등록하였습니다.")
					SmsConfigDetail($("#d_det_code").val(),$("#d_sys_kind").val());
					closeLoading();
				},
				error:function(result){
					closeLoading();
				}
			});
		}
	}
}


function numberCheck(n) {
	var temp = n.value
	if(isNaN(temp) == true) {
		n.value = "";
		alert("숫자만 입력해 주세요");
	}
};

function clickTrEvent(trObj) {
	var tr = eval("document.getElementById(\"" + trObj.id + "\")");
	$(tr).parent().find("tr td").removeClass("tr_on");		
	$(tr).find("td").addClass("tr_on");
}
</script>
</head>
<body>
<input type="hidden" name="member_id" id="member_id"/> 
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
	<div id="layerFullBgDiv"></div>
	<div id="wrap">
		
		<!-- Head Start-->
		<div id="header">
			<c:import url="/common/menu/header.do" />
		</div>
		<!-- Head End-->
		
		<!-- Body Start-->
		<div id="container">
			<div id="content_wrapper">
			
				<!--left menu Start-->
				<c:import url="/common/menu/left.do" />
				<!--left menu End-->
				
				<!-- Content Start-->
				<div id="content">
				
					<!-- navi, tab menu Start-->
					<c:import url="/common/menu/navi.do" />
					<!-- navi, tab menu End-->
						
					<!--tab Contnet Start-->
					<div class="tab_container">
						<!-- 리스트 -->
						<div class="table_wrapper">
							<table summary="게시판 목록. 번호, 검출코드, 검출내용, 검출세부내용, 검출주기, 사용여부가 담김">
								<colgroup>
									<col width="45" />
									<col width="125" />
									<col width="290" />
									<col width="290" />
									<col width="130" />
									<col width="110" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">No</th>
										<th scope="col">검출코드</th>
										<th scope="col">검출내용</th>
										<th scope="col">검출세부내용</th>
										<th scope="col">검출주기</th>
										<th scope="col">사용여부</th>
									</tr>
								</thead>
								<tbody id="dataList">
								</tbody>
							</table>
							<div style="float:right;margin:5px 0;">
								<input type="button" id="btnModify" value="수정" class="btn btn_basic" onclick="$('#smsdetail').css('display','');" alt="수정" style="display:none;"/>&nbsp;&nbsp;
								<input type="button" id="btnRegist" value="등록" class="btn btn_basic" onclick="javascript:fnRegist();" alt="등록" />
							</div>
						</div>
						<!-- 등록 수정 -->
						<div class="table_wrapper" id="smsdetail" style="display:none;clear: both;">
							<table summary="게시판 목록. 번호, 검출코드, 검출내용, 검출세부내용, 검출주기, 사용여부가 담김">
								<colgroup>
									<col width="110" />
									<col width="180" />
									<col width="110" />
									<col width="180" />
									<col width="130" />
									<col width="180" />
								</colgroup>
								<tbody>
									<tr>
										<th style="border: 1px solid rgba(127, 190, 224, 1);">시스템(*)</th>
										<td style="border: 1px solid rgba(127, 190, 224, 1);">
											<select id="d_sys_kind" name="d_sys_kind" style="width:90%;" class="select">													
												<option value="U">이동형측정기기</option>
												<option value="A">국가수질자동측정망</option>
											</select>
										</td>
										<th style="border: 1px solid rgba(127, 190, 224, 1);">검출내용(*)</th>
										<td style="border: 1px solid rgba(127, 190, 224, 1);">
											<select id="d_det_code" name="d_det_code" style="width:90%;" class="select"></select>
										</td>
										<th style="border: 1px solid rgba(127, 190, 224, 1);">검출주기(*)</th>
										<td style="border: 1px solid rgba(127, 190, 224, 1);">
										<select id="d_det_cycle" name="d_det_cycle" style="width:90%">
											<c:forEach begin="10" end="60" step="10" var="i">
												<option value="<c:out value='${i}'/>"><c:out value="${i}"/></option>
											</c:forEach>
										</select>
										</td>
									</tr>
									<tr>
										<th style="border: 1px solid rgba(127, 190, 224, 1);">검출세부내용(*)</th>
										<td style="border: 1px solid rgba(127, 190, 224, 1);" colspan="3"><input type="text" id="d_det_content" name="d_det_content" style="width:96%"/></td>
										<th style="border: 1px solid rgba(127, 190, 224, 1);">사용여부(*)</th>
										<td style="border: 1px solid rgba(127, 190, 224, 1);">
										<select id="d_user_yn" name="d_user_yn" style="width:90%">
											<option value="Y">Y</option>
											<option value="N">N</option>
										</select>
										</td>
									</tr>
								</tbody>  
							</table>
							<div style="float:right;margin:5px 0;">
								<input type="button" id="btnRegist" value="취소" class="btn btn_basic" onclick="$('#smsdetail').css('display','none');" alt="취소" />&nbsp;&nbsp;
								<input type="button" id="btnRegist" value="등록" class="btn btn_basic" onclick="javascript:InsertSmsConfig();" alt="등록" />
							</div>
							
						</div>
						
						<!--SMS 공통 수신자 설정 -->
						<div class="topBx">
							<span>공통 수신자 설정</span>
						</div>
						<div class="table_wrapper">
							<table summary="게시판 목록. 번호, 검출코드, 검출내용, 검출세부내용, 검출주기, 사용여부가 담김">
								<colgroup>
									<col width="45" />
									<col width="125" />
									<col width="290" />
									<col width="290" />
									<col width="130" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">No</th>
										<th scope="col">이름</th>
										<th scope="col">소속</th>
										<th scope="col">전화번호</th>
										<th scope="col">삭제</th>
									</tr>
								</thead>
								<tbody id="smsdataList">
									<tr><td colspan="5">검출내역목록을  선택해 주세요.</td></tr>
								</tbody>
							</table>
							
							<div style="float:right;margin:5px 0;display:none;" id="smsTargetButton">
								<input type="button" id="btnEgovRegistMember" value="등록" class="btn btn_basic" onclick="$('#registlayerid').css('display','');return false;" alt="등록" />
							</div>
						</div>
						
						<div id="registlayerid" style="margin-top:20px;display:none;clear: both;">
								<div>
									<div class="gBox" style="width:340px">
										<span class="ptit" >
											대상기관
										</span>
										<select multiple="multiple" id="dept" style="padding:7px;width:330px;height:190px"></select>
									</div>
									
									<div style="padding-top:25px;float:left"><img src="/images/renewal/parrow.gif" alt="다음단계"/></div>
									
									<div class="gBox" style="width:285px">
										<span class="ptit">
											담당자
										</span>
										<select multiple="multiple" id="person" style="padding:7px;width:280px;height:190px"></select>
									</div>
									
									<ul class="arrbx">
										<li style="padding-top:70px;"><a href="javascript:add()"><img src="<c:url value='/images/renewal/bt_arradd.gif'/>" alt="추가" /></a></li><br/>
										<li><a href="javascript:del()"><img src="<c:url value='/images/renewal/bt_arrdel.gif'/>" alt="삭제" /></a></li>
									</ul>
									
									<div class="gBox" style="width:285px">
										<span class="ptit">
											전파대상자
										</span>
										<select multiple="multiple" id="sPerson" style="padding:7px;width:280px;height:190px"></select>
									</div>
								</div>
								
								<div class="btnSearchDiv" style="clear:both;padding-top:10px;">
									<div style="padding-right:10px;float:right;">
										<input type="button" value="취소" class="btn btn_search" onclick="$('#registlayerid').css('display','none');return false;" alt="취소" />
										<input type="button" id="btnEgovRegistMember" name="btnEgovRegistMember" value="저장" class="btn btn_search" onclick="return goSave();" alt="저장" />
									</div>
								</div>
							</div>
							
						<!--  공통 수신기준 설정 -->
						<div class="topBx">
							<span>공통 수신기준 설정</span>
						</div>
						<div class="table_wrapper">
							<table summary="게시판 목록. 번호, 검출코드, 검출내용, 검출세부내용, 검출주기, 사용여부가 담김">
								<colgroup>
									<col width="45" />
									<col width="125" />
									<col width="190" />
									<col width="390" />
									<col width="130" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">검출코드</th>
										<th scope="col">조건내용</th>
										<th scope="col">조건값</th>
										<th scope="col">세부설명</th>
										<th scope="col">사용여부</th>
									</tr>
								</thead>
								<tbody id="smsBranchList_1">
									<tr><td colspan="5">검출내역목록을  선택해 주세요.</td></tr>
								</tbody>
								
								<tbody id="smsBranchList_2" style="display: none;">
									<tr>
										<td id="smsBranchListTd1"><span id="smsBranchListSpan"></span></td>
										<td>보내지 않는 시간</td>
										<td>
										<select id="not_send_from" name="not_send_from" style="width:40%">
											<c:set var="min" value="0"/>
											<c:forEach begin="0" end="24" step="1" var="i" >
												<c:set var="min" value="${i}"/>
												<c:if test="${i < 10}"><c:set var="min" value="0${i}"/></c:if>
												<option value="<c:out value='${min}'/>"><c:out value="${min}"/></option>
											</c:forEach>
										</select>&nbsp;&nbsp;&nbsp;&nbsp;~&nbsp;&nbsp;&nbsp;&nbsp; 
										<select id="not_send_to" name="not_send_to" style="width:40%">
											<c:set var="min" value="0"/>
											<c:forEach begin="0" end="24" step="1" var="i">
												<c:set var="min" value="${i}"/>
												<c:if test="${i < 10}"><c:set var="min" value="0${i}"/></c:if>
												<option value="<c:out value='${min}'/>"><c:out value="${min}"/></option>
											</c:forEach>
										</select>
										</td>
										<td><input type="text" id="send_detail_explan" name="send_detail_explan" style="width:96%"/></td>
										<td><input type="checkbox" id="send_use_flag" name="send_use_flag" value="Y"/></td>
									</tr>
									
									<tr id="smsBranchListTr5" style="display:none;">
										<td>검출지연시간(분)</td>
										<td>
											<select id="chk_delay" name="chk_delay" style="width:97%">
												<c:forEach begin="10" end="60" step="10" var="i">
													<option value="<c:out value='${i}'/>"><c:out value="${i}"/></option>
												</c:forEach>
											</select>
										</td>
										<td><input type="text" id="delay_detail_explan" name="delay_detail_explan" style="width:96%"/></td>
										<td><input type="checkbox" id="delay_use_flag" name="delay_use_flag" value="Y"/></td>
									</tr>
									
									<tr id="smsBranchListTr1" style="display:none;">
										<td>수신율 몇(%) 미만</td>
										<td><input type="text" id="not_rcv" name="not_rcv" style="width:96%" onkeyup="numberCheck(this)"/></td>
										<td><input type="text" id="not_rcv_detail_explan" name="not_rcv_detail_explan" style="width:96%"/></td>
										<td><input type="checkbox" id="not_rcv_use_flag" name="not_rcv_use_flag" value="Y"/></td>
									</tr>
									
									<tr id="smsBranchListTr2" style="display:none;">
										<td>위치이탈 범위지정(M)</td>
										<td><input type="text" id="chk_loc" name="chk_loc" style="width:96%" onkeyup="numberCheck(this)"/></td>
										<td><input type="text" id="loc_detail_explan" name="loc_detail_explan" style="width:96%"/></td>
										<td><input type="checkbox" id="loc_use_flag" name="loc_use_flag" value="Y"/></td>
									</tr>
									
									<tr id="smsBranchListTr6" style="display:none;">
										<td>SMS 송신 주기(시)</td>
										<td>
											<select id="chk_time" name="chk_time" style="width:97%">
												<c:set var="min" value="0"/>
												<c:forEach begin="1" end="24" step="1" var="i">
													<c:set var="min" value="${i}"/>
													<c:if test="${i < 10}"><c:set var="min" value="0${i}"/></c:if>
													<option value="<c:out value='${min}'/>"><c:out value="${min}"/></option>
												</c:forEach>
											</select>
										</td>
										<td><input type="text" id="time_detail_explan" name="time_detail_explan" style="width:96%"/></td>
										<td><input type="checkbox" id="time_use_flag" name="time_use_flag" value="Y"/></td>
									</tr>
								</tbody>
							</table>
							
							<div style="float:right;margin:5px 0;display:none;" id="smsBranchListButton">
								<input type="button" id="btnRegist" value="등록" class="btn btn_basic" onclick="javascript:goConfigSave();" alt="등록" />
							</div>
							<div id="smsLeaveDesc" align="left" style="display:none;">
								<br>
								<font color="red">※ 위치이탈 범위 계산식: </font> <br>
								측정지점 위도 x1, 경도 y1 <br>
								측정장비 위도 x2, 경도 y2 <br>
								위도에 대한 라디안각도 r1,r2 <br>
								경도에 대한 라디안각도 p1,p2 <br>
								r1 = x1 * π/180 <br>
								p1 = y1 * π/180 <br>
								r2 = x2 * π/180 <br>
								p2 = y2 * π/180 <br>
								d1 = r2 - r1 <br>
								d2 = p2 - p1 <br>
								a = sin(d1 / 2)² + cos(x1) * cos(x2) * sin(d2 / 2)² <br>
								c = 2 * atan{√a / √(1.0 - a)} <br>
								이탈거리 D = c * 6376.5 * 1000 <br>
							</div>
						</div>
					</div>
					<!--tab Contnet End-->
				</div>
			</div>
		</div>
		<!-- Body End-->
		
		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
	</div>
</body>
</html>