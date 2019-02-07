<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : alertTargetList.jsp
	 * Description : 전파대상관리 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2010.05.17	k			최초 생성
	 * 2013.10.20	lkh			리뉴얼
	 *
	 * author k
	 * since 2010.05.17
	 * 
	 * Copyright (C) 2010 by k  All right reserved.
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
	var isProcess = false;
	
	$(function(){
		$('#alertListTbody tr:odd').addClass('add');

		$('#btnSearch').click(function () {
			if(isProcess) {
				alert("처리중입니다.");
				return;
			}
			isProcess = true;
			getAlertTargetList();
		});
				
		$('#checkAll').click(function () {
			checkAll();
		});
		
		$("#btnAddRow").click(function () {
			saveForm("", $("#factCode").val(), $("#branchNo").val());
		});

		$('#btnDelRow').click(function () {
			if(isProcess) {
				alert("처리중입니다.");
				return;
			}
			isProcess = true;
			setDel();
		});

		$('#btnSave').click(function () {
			if(isProcess) {
				alert("처리중입니다.");
				return;
			}
			if(!validation()) { return; }
			isProcess = true;
			setSave();
		});
		
		//시스템 고정 renew 전부터 고정되어 있는 상태
		$('#system').attr("disabled", true);
		$('#system').attr("style", "background:#e9e9e9;");
		
		$('#system').change(function(){
			adjustGongkuDropDown2();
		});
		
		$('#sugye').change(function(){
			adjustGongkuDropDown2();
		});
		
		$('#factCode').change(function(){
			adjustBranchDropDown();
		});
		
		adjustGongkuDropDown2();
		
// 		set_User_deptNo(user_dept_no, "sugye");
		selectedSugyeInMemberId(user_riverid , "sugye");
	});
	
	var firstFlag = true;
	function init() {
		if(firstFlag) {
			getAlertTargetList();
			firstFlag = false;
		}
	}
	
	var atId = new Array;
	var atArs = new Array;
	var atSms = new Array;
	var atDay = new Array;
	var atNight = new Array;
	var atRece = new Array;
	var atClass = new Array;
	var atDepth = new Array;
	
	function setSave() {
		if(!isProcess) {
			alert("저장중입니다.");
			return; 
		}
		
		isSave = false;
		
		var i=0;
		atId = new Array;
		atArs = new Array;
		atSms = new Array;
		atDay = new Array;
		atNight = new Array;
		atRece = new Array;
		atClass = new Array;
		atDepth = new Array;
		
		$('input[name=chk]').each(function() {
			atId.push($('input[name=atId]').eq(i).val());
			atClass.push($('select[name=atClass]').eq(i).val());
			atDepth.push($('select[name=atDepth]').eq(i).val());

			if($('input[name=atArs]').eq(i).attr('checked'))
				atArs.push('A');
			else 
				atArs.push('');
			if($('input[name=atSms]').eq(i).attr('checked'))
				atSms.push('S');
			else 
				atSms.push('');
			if($('input[name=atDay]').eq(i).attr('checked'))
				atDay.push('D');
			else
				atDay.push(''); 
			if($('input[name=atNight]').eq(i).attr('checked'))
				atNight.push('N');
			else
				atNight.push(''); 
			if($('input[name=atRece]').eq(i).attr('checked'))
				atRece.push('Y');
			else
				atRece.push('');
			
			i++;
		});
		
		saveAlertTargetData(atId, atArs, atSms, atDay, atNight, atRece, atClass, atDepth);
	}

	function saveAlertTargetData(atId, atArs, atSms, atDay, atNight, atRece, atClass, atDepth){
		if(atId.length > 0) {
			$.ajax({
				type:"post",
				url:"<c:url value='/alert/saveAlertTargetData.do'/>",
				data:{atId:atId[0], atArs:atArs[0], atSms:atSms[0], atDay:atDay[0], atNight:atNight[0], 
						atRece:atRece[0], atClass:atClass[0], atDepth:atDepth[0]},
				dataType:"json",
				success:function(result){
					atId.shift();
					atArs.shift();
					atSms.shift();
					atDay.shift();
					atNight.shift();
					atRece.shift();
					atClass.shift();
					atDepth.shift();
					
					saveAlertTargetData(atId, atArs, atSms, atDay, atNight, atRece, atClass, atDepth);
				},
				error:function(result){alert("error");isProcess = false;}
			});
		} else {
			alert("저장했습니다.");
			isProcess = false;
			getAlertTargetList();
		}
	}

	function saveForm(atId, factCode, branchNo) {
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 510;
		var winWidth = 700;
		var winLeftPost = (sw - winWidth) / 2;var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-40;
		var height = winHeight-40;
		
		window.open("<c:url value='/alert/alertTargetUser.do'/>?atId="+atId+"&factCode="+factCode+"&branchNo="+branchNo, 
				'saveForm','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);			
	}

	function setDel() {
		var i=0;
		var cnt=0;
		var atIds = new Array;
		var delRowIdx = new Array;

		$('input[name=chk]').each(function() {
			if($(this).attr('checked')) {
				delRowIdx.push(i);
				cnt++;
			}
			i++;
		});

		if(cnt == 0) {
			alert("삭제할 항목을 체크해주세요");
			isProcess = false;
			return false;
		}			

		for(var i=delRowIdx.length; i>0; i--) {
			atIds.push($('input[name=atId]').eq(delRowIdx[i-1]).val());
		}
		
		deleteAlertTargetData(atIds, delRowIdx);
	}

	function getAlertTargetList() {

		showLoading();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/alert/getAlertTargetList.do'/>",
			data:{factCode:$("#factCode").val(), branchNo:$("#branchNo").val()},
			dataType:"json",
			success:function(result){
				var tot = result['alertTargetList'].length;
				$("#alertListTbody").html("");
				
				if( tot <= "0" ){
					$("#alertListTbody").html("<tr><td colspan='9'>조회 결과가 없습니다</td></td>");
					closeLoading();
				} else {
					for(var j=0; j < tot; j++){
						var obj = result['alertTargetList'][j];
						setRow(obj.factCode, obj.branchNo, obj.atId, obj.atDept, obj.atPart, obj.atName, obj.atPosition, obj.atArsTele, obj.atArs,
								obj.atSmsTele, obj.atSms, obj.atDay, obj.atNight, obj.atRece, obj.atClass, obj.atDepth);
					}

					if($('input[name=system]:checked').val() == "U") {
						$('select[name=atDepth]').append($('<option></option').attr('value','4').text('심각'));
					}	
				}
				isProcess = false;

				closeLoading();
			},
			error:function(result){alert("error");isProcess = false;closeLoading();}
		});
	}

	function deleteAlertTargetData(atIds, delRowIdx){
		$.ajax({
			type:"post",
			url:"<c:url value='/alert/deleteAlertTargetData.do'/>",
			data:{atIds:atIds[0]},
			dataType:"json",
			success:function(result){
				for(var i=delRowIdx.length; i>0; i--) {
					$('#listFrm input[name=atId]').eq(delRowIdx[i-1]).parent().parent().remove();
				}
				alert("삭제했습니다.");
				isProcess = false;
				getAlertTargetList();
			},
			error:function(result){alert("error");}
		});
	}

	function setRow(factCode, branchNo, atId, atDept, atPart, atName, atPosition, atArsTele, atArs, atSmsTele, atSms, atDay, atNight, atRece, atClass, atDepth) {
		factCode	= nullToString(factCode);
		branchNo	= nullToString(branchNo);
		atId		= nullToString(atId);
		atDept		= nullToString(atDept);
		atPart		= nullToString(atPart);
		atName		= nullToString(atName);
		atPosition	= nullToString(atPosition);
		atArsTele	= nullToString(atArsTele);
		atArs		= nullToString(atArs);
		atSmsTele	= nullToString(atSmsTele);
		atSms		= nullToString(atSms);
		atDay		= nullToString(atDay);
		atNight	= nullToString(atNight);
		atRece		= nullToString(atRece);
		atClass	= nullToString(atClass);
		atDepth	= nullToString(atDepth);
		
		$('<tr></tr>')
			.append($('<td></td>')
			.append($('<input />').attr('name', 'chk').attr('type', 'checkbox').addClass('inputCheck'))
			.append($('<input />').attr('name', 'factCode').attr('value', factCode).attr('type', 'hidden'))
			.append($('<input />').attr('name', 'branchNo').attr('value', branchNo).attr('type', 'hidden'))
			.append($('<input />').attr('name', 'atId').attr('value', atId).attr('type', 'hidden')))
			.append($('<td></td>')
			.append("<a href='javascript:saveForm(\""+atId+"\", \"\", \"\")'>"+atName+"</a/>"))
			.append($('<td></td>')
			.append(atDept))
			.append($('<td></td>')
			.append(atPosition))
			.append($('<td></td>')
			.append(atArsTele))
			.append($('<td></td>')
			.append(atSmsTele))
			.append($('<td></td>')
			.append($('<input />').attr('name', 'atArs').attr('value', 'Y').attr('type', 'checkbox')
			.addClass('inputCheck'))
			.append($('<label></label>').attr('for', '').text('ACS'))
			.append($('<input />').attr('name', 'atSms').attr('value', 'Y').attr('type', 'checkbox')
			.addClass('inputCheck'))
			.append($('<label></label>').attr('for', '').text('SMS'))
			.addClass('choice'))
			.append($('<td></td>')
			.append($('<input />').attr('name', 'atDay').attr('value', 'Y').attr('type', 'checkbox')
			.addClass('inputCheck'))
			.append($('<label></label>').attr('for', '').text('주'))
			.append($('<input />').attr('name', 'atNight').attr('value', 'Y').attr('type', 'checkbox')
			.addClass('inputCheck'))
			.append($('<label></label>').attr('for', '').text('야'))
			.addClass('choice'))
			.append($('<td></td>')
			.append($('<input />').attr('name', 'atRece').attr('value', 'Y').attr('type', 'checkbox')
			.addClass('inputCheck'))
			.addClass('choice'))
			//.append($('<td></td>')
			//.append($('<select></select>').attr('name', 'atDepth')
			//.append($('<option></option').attr('value','').text('선택'))
			//.append($('<option></option').attr('value','1').text('관심'))
			//.append($('<option></option').attr('value','2').text('주의'))
			//.append($('<option></option').attr('value','3').text('경계'))))
			//.append($('<td></td>')
			//.append($('<select></select>').attr('name', 'atClass')
			//.append($('<option></option').attr('value','').text('선택'))
			//.append($('<option></option').attr('value','1').text('1'))
			//.append($('<option></option').attr('value','2').text('2'))
			//.append($('<option></option').attr('value','3').text('3'))
			//.append($('<option></option').attr('value','4').text('4'))
			//.append($('<option></option').attr('value','5').text('5'))
			//.append($('<option></option').attr('value','6').text('6'))
			//.append($('<option></option').attr('value','7').text('7'))
			//.append($('<option></option').attr('value','8').text('8'))
			//.append($('<option></option').attr('value','9').text('9'))))
			.appendTo("#alertListTbody");

		var trIdx = $('#alertListTbody tr').size()-1;
		
		if(atArs == 'A')
			$('input[name=atArs]').eq(trIdx).attr('checked', true);
		else
			$('input[name=atArs]').eq(trIdx).attr('checked', false);

		if(atSms == 'S')
			$('input[name=atSms]').eq(trIdx).attr('checked', true);
		else
			$('input[name=atSms]').eq(trIdx).attr('checked', false);

		if(atDay == 'D')
			$('input[name=atDay]').eq(trIdx).attr('checked', true);
		else
			$('input[name=atDay]').eq(trIdx).attr('checked', false);

		if(atNight == 'N')
			$('input[name=atNight]').eq(trIdx).attr('checked', true);
		else
			$('input[name=atNight]').eq(trIdx).attr('checked', false);

		if(atRece == 'Y')
			$('input[name=atRece]').eq(trIdx).attr('checked', true);
		else 
			$('input[name=atRece]').eq(trIdx).attr('checked', false);

		$('select[name=atDepth]').eq(trIdx).val(atDepth);

		$('select[name=atClass]').eq(trIdx).val(atClass);
		
		$('#alertListTbody tr:odd').addClass('add');
	}

	function checkAll(){
		var c = $('#checkAll').attr('checked');
		$('input[name=chk]').attr('checked',c);
	}

	function validation() {
		var i = 0;
		var cnt1 = 0;
		var cnt2 = 0;
		var cnt3 = 0;
		var cnt4 = 0;
		var cnt5 = 0;

		$('input[name=chk]').each(function() {
			if($('input[name=atName]').eq(i).val() == "") { cnt1++; }
			if($('input[name=atPart]').eq(i).val() == "") { cnt2++; }
			if($('input[name=atPosition]').eq(i).val() == "") { cnt3++; }
			if($('input[name=atArsTele]').eq(i).val() == "") { cnt4++; }
			if($('input[name=atSmsTele]').eq(i).val() == "") { cnt5++; }
			i++;
		});

		if(cnt1 > 0) { alert("이름을 입력하여 주십시요."); return false; }
		if(cnt2 > 0) { alert("소속을 입력하여 주십시요."); return false; }
		if(cnt3 > 0) { alert("직위를 입력하여 주십시요."); return false; }
		if(cnt4 > 0) { alert("전화번호를 입력하여 주십시요."); return false; }
		if(cnt5 > 0) { alert("핸드폰번호를 입력하여 주십시요."); return false; }
		return true;
	}

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
</script>
</head>

<body>
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
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

						<!-- 전파 대상 관리 -->
						<form action=""  onsubmit="return false">
						
							<div class="searchBox dataSearch">
								<ul>
									<li>
										<span class="fieldName">측정소 위치</span>
										<select class="fixWidth7" id="sugye" name="sugye">
										   <option value="R01">한강</option>
										   <option value="R02">낙동강</option>
										   <option value="R03">금강</option>
										   <option value="R04">영산강</option>
										</select>
										<div style="display:none;">
											<span>&gt;</span>
											<select class="fixWidth11"   id="factCode" name="factCode">
												<option value="all">전체</option>
											</select>
										</div>
										<span>&gt;</span>
										<select class="fixWidth11" id="branchNo" name="branchNo">
											<option value="all">전체</option>
										</select>
									</li>
									<li style="display:none;">
										<select class="fixWidth13" id="system" name="system">
												<option value="U" selected="selected">이동형측정기기</option>
												<!-- <option value="T">탁수모니터링</option> -->
												<option value="A">국가수질자동측정망</option>
										</select>
									</li>
									<li class="last">
										<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" _onclick="javascript:getAlertTargetList();" alt="조회"/>
									</li>
								</ul>
							</div>
						</form>
						<!-- //전파 대상 관리 -->
						
						<div id="btArea">
							<span id="p_total_cnt">&nbsp;</span>
							<input type="button" id="btnAddRow" name="btnAddRow" value="추가" class="btn btn_basic" _onclick="javascript:saveForm();" alt="추가" />
							<input type="button" id="btnDelRow" name="btnDelRow" value="삭제" class="btn btn_basic" _onclick="javascript:setDel();" alt="삭제" />
							<input type="button" id="btnSave" name="btnSave" value="저장" class="btn btn_basic" _onclick="javascript:setSave();" alt="저장" />
						</div>

						<!-- 전파 대상 관리 추가, 삭제, 저장 -->
						<div class="table_wrapper">
						
							<form action="" onsubmit="return false">
								<div class="overBox">
									<table summary="경보기준정보">
										<colgroup>
											<col width="30px" />
											<col width="110px" />
											<col />
											<col width="70px" />
											<col width="120px" />
											<col width="120px" />
											<col width="160px" />
											<col width="110px" />
											<col width="70px" />
										</colgroup>
										<thead>
											<tr>
												<th scope="col"><input type="checkbox" class="inputCheck" id="checkAll" /></th>
												<th scope="col">이름</th>
												<th scope="col">소속</th>
												<th scope="col">직위</th>
												<th scope="col">전화번호</th>
												<th scope="col">핸드폰번호</th>
												<th scope="col">ACS/SMS</th>
												<th scope="col">주간/야간</th>
												<th scope="col">사용여부</th>
											</tr>
										</thead>
										<tbody id="alertListTbody">
										</tbody>
									</table>
								</div>
							</form>
						</div>
						<!-- //전파 대상 관리 추가, 삭제, 저장 -->
						
					</div>
					<!--tab Contnet End-->
				</div>
				<!-- Content End-->
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