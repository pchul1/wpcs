<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/com.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/site.css' />" />
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
	$("#introDate").datepicker({buttonText: '도입일'});
	
});

var factCode = $("#UsnfactCode",opener.document).val();
var branchNo = $("#UsnBranchNo",opener.document).val();
var sysKind = $("#est",opener.document).val();

$(function () {
	if(factCode == ""){
		alert("지점을 선택 하신 후 등록하여 주십시오.");
		window.close();
	}else{
		var sysType  = '';
		if(sysKind == '이동형측정기기'){
			sysType = 'U';
		}else if(sysKind == '방류수질정보'){
			sysType = 'W';
// 		}else if(sysKind == '탁수모니터링'){
// 			sysType = 'T';
		}else if(sysKind == '국가수질자동측정망'){
			sysType = 'A';
		}
		
		$("#factCode").val(factCode);
		$("#branchNo").val(branchNo);
		
		$.ajax({
			type:"post",
			url:"<c:url value='/spotmanage/getItemName.do'/>",
			data:{
				  factCode:factCode,
				  branchNo:branchNo,
				  sysKind:sysType
				 },
			dataType:"json",
			success:function(result){
	              $("#itemName").val(result['itemName']);
	             //closeLoading();		
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
				
				$("#itemName").val("");
	            $("#itemName").val("서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]");
	            //closeLoading();
	        }
		});
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

function nullCheck(str){
	if(str == "" || str == null){
		alert("빈항목이 있습니다.");
	}else{
		return str;
	}
}

function Commit(){
	showLoading();
	var factCode = $("#factCode").val();
	var branchNo = $("#branchNo").val();
	var eqName = $("#eqName").val();					// 수행자
	var itemName = $("#itemName").val();				// 항목명
	var introDate = $("#introDate").val();				// 일자
	var conpanySeq = $("#conpanySeq").val();			// 제조사
	var modelSeq = $("#modelSeq").val();				// 모델명
	var memo = $("#memo").val();						// 비고
	var eqCode = $("#eqCode").val();
	
	if(eqName == ""||itemName == ""||introDate == ""||conpanySeq == ""||modelSeq == ""||memo == ""){
		alert("입력 항목이 누락되었습니다.");
		closeLoading();
		return;
	}
	
	$.ajax({
		type:"post",
		url:"<c:url value='/spotmanage/eqInsert.do'/>",
		data:{
			factCode:factCode,
			branchNo:branchNo,
			eqName:eqName,
			itemName:itemName,
			introDate:introDate,
			conpanySeq:conpanySeq,
			modelSeq:modelSeq,
			memo:memo,
			eqCode:eqCode
		},
		dataType:"json",
		success:function(result){
        	opener.parent.EventDiv();
        	window.close();
            closeLoading();
           // usnHistoryDateListGroup();
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
			
			$("#MemberList").html("");
            $("#MemberList").html("<tr><td colspan='3'>서버 접속에 실패하였습니다! [CODE:" + oraErrorCode + "]</td></td>");
            closeLoading();
        }
	});
}

	//시스템 장비 정보를 가져오기
	function getSysinfoList(){
		//사업장정보
		var searchSysKeyword = $("#searchSysKeyword").val();
		var searchSysKind = $("select[name=search_sys_kind]").val();
		showLoading();
		$.ajax({
			type:"post",
			url:"<c:url value='/spotmanage/getSysinfoList.do'/>",
			data:{
				searchSysKeyword:searchSysKeyword,
				searchSysKind:searchSysKind
				},
			dataType:"json",
			success:function(result){
				var html = "";
				var tot = result['sysinfoList'].length;
				layerPopOpen("sysinfoLayer");
				
				if( tot <= 0 ){
					html += "<tr><td colspan='5' style='text-align:center;'>조회 결과가 없습니다.</td></tr>";
				}else{
					for(var i=0; i < tot; i++){
						var obj = result['sysinfoList'][i];
						var pageInfo = result['paginationInfo'];
						var no = i + ((pageInfo.currentPageNo-1) * pageInfo.recordCountPerPage) + 1;
						
						obj.no = no;
							
						trclass = "";
						if(i % 2 == 1) trclass = "class=\"even\"";
	
						html +="<tr "+trclass+">";
						html += "<td style='text-align:center; cursor:pointer;'><a onclick=\"javascript:setSysInfo('"+obj.equip_code+"','"+obj.equip_maker+"','"+obj.equip_name+"'); return false;\" >"+ obj.no +"</a></td>";
						html += "<td style='text-align:center; cursor:pointer;'><a onclick=\"javascript:setSysInfo('"+obj.equip_code+"','"+obj.equip_maker+"','"+obj.equip_name+"'); return false;\" >"+ obj.sys_kind_name +"</a></td>";
						html += "<td style='text-align:center; cursor:pointer;'><a onclick=\"javascript:setSysInfo('"+obj.equip_code+"','"+obj.equip_maker+"','"+obj.equip_name+"'); return false;\" >"+ obj.equip_code +"</a></td>";
						html += "<td style='text-align:center; cursor:pointer;'><a onclick=\"javascript:setSysInfo('"+obj.equip_code+"','"+obj.equip_maker+"','"+obj.equip_name+"'); return false;\" >"+ obj.equip_maker +"</a></td>";
						html += "<td style='text-align:center; cursor:pointer;'><a onclick=\"javascript:setSysInfo('"+obj.equip_code+"','"+obj.equip_maker+"','"+obj.equip_name+"'); return false;\" >"+ obj.equip_name +"</a></td>";
						html +="</tr>";
					}
				}
				$("#sysDataList").html(html);
				
				closeLoading();
			},
			error:function(result){
				// 오라클 에러 발생시 오라클 에러코드를 보여준다.김경환대리 요청사항 add by bobylone at 2011-12-21
	
				var html = "";
				html += "<tr><td colspan='5'>서버 접속에 실패하였습니다.</td></tr>";
				$("#sysDataList").html(html);
				
				closeLoading();
			}
		});
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("sysinfoLayer");			//시스템
	}
	
	function setSysInfo(equip_code, equip_maker, equip_name){
		$("#eqCode").val(equip_code);
		$("#conpanySeq").val(equip_maker);
		$("#modelSeq").val(equip_name);
		
		layerPopCloseAll();
	}
	</script>
</head>
<body style="overflow-x:hidden;overflow-y:hidden;background-image: none;">
<input type="hidden" id="factCode" name="factCode" />
<input type="hidden" id="branchNo" name="branchNo" />
<div id='loadingDiv' style="visibility:hidden;position:absolute;">
	<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="" />
</div>
<div id="wrap">
<div id="container">

<!-- Contents Begin Here -->
<div id="content" class="sub_waterpolmnt">
	<div class="content_wrap page_alarmmng">
		<div class="con_tit_wrap">
		  <h3>측정장비추가</h3> 
	    </div>
	</div>
	
	<div class="listView_write">
		<div class="popup_situReceive" style="padding:15px 0; border:2px solid #2f8bc0; border-width:2px 0;width:530px;">
			<fieldset class="second">
					<table id="tab_1_1" class="dataTable" style="width:100%; float:left;">
						<colgroup>
							<col width="120px"></col>
							<col></col>
						</colgroup>
						<tbody>
						<!-- 
							<tr>
								<th>장비코드</th>
								<td>
									<input type="text" id="eqCode" name="eqCode" style="width:300px;" readonly="readonly" onclick="javascript:getSysinfoList()" style="background-color:#f2f2f2;"/>
									<input type="hidden" id="eqName" name="eqName" style="width:95%"/>
									<input type="button" id="btnSysSearch" name="btnSysSearch" value="검색" onclick="javascript:getSysinfoList();" alt="검색" style="width:50px; cursor:pointer;"/>
								</td>
							</tr>
						 -->
						 	<tr>
								<th>도입일</th>
								<td><input type="text" readonly="readonly" id="introDate" name="introDate" style="width:90%"/></td>
							</tr>
							
							<tr>
								<th>항목명</th>
								<td><input type="text" id="itemName" name="itemName" style="width:95%"/></td>
							</tr>
							
							<tr>
								<th>제조사</th>
								<td><input type="text" id="conpanySeq" name="conpanySeq" style="width:95%"/></td>
							</tr>
							<tr>
								<th>모델명</th>
								<td><input type="text" id="modelSeq" name="modelSeq" style="width:95%"/></td>
							</tr>
							<tr>
								<th>수행자</th>
								<td><input type="text" id="eqName" name="eqName" readonly="readonly" disabled="disabled" value="<sec:authentication property="principal.userVO.name"/>" style="width:95%"/></td>
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
<!--시스템 장비 검색 레이어-->
<div id="sysinfoLayer" class="divPopup">
	<div id="xbox">
		<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
		<input type="button" id="btnSysInfoXbox" name="btnSysInfoXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('sysinfoLayer');" alt="닫기"/>
	</div>
	<div style="background:#fff;text-align:right; padding-top:5px; padding-bottom:5px; padding-right:18px;">
		시스템 : 
		<select name="search_sys_kind">
		<option value="U">이동형측정기기</option>
		<option value="A">국가수질자동측정망</option>
		<option value="W">방류수질정보</option>
		</select>
		<input type="button" id="btnPopSysSearch" name="btnPopSysSearch" value="검색" class="btn btn_search" onclick="javascript:getSysinfoList();" alt="검색"/>
	</div>
	<div style="width:500px; height:300px;overflow-x:hidden;overflow-y:scroll;">
		<table>
			<col width='45' />
			<col width='110' />
			<col width='110' />
			<col width='110' />
			<col width='125' />
			<thead>
				<tr>
					<th scope='col'>NO</th>
					<th scope='col'>시스템</th>
					<th scope='col'>장비코드</th>
					<th scope='col'>제조사</th>
					<th scope='col'>모델명</th>
				</tr>
			</thead>
			<tbody id="sysDataList">
			</tbody>
		</table>
	</div>
	<br/>
	<center>
		<span style="color:#fff;">장비코드 : </span>
		<input type="text" id="searchSysKeyword" name="searchSysKeyword" style="width:200px;"/>
		<input type="button" id="btnPopSysSearch" name="btnPopSysSearch" value="검색" class="btn btn_search" onclick="javascript:getSysinfoList();" alt="검색"/>
	</center>
</div>
<!--//시스템 장비 검색 레이어-->
</body>
</html>