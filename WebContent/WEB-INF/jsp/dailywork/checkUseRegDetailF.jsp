<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : situationRoomRegist.jsp
	 * Description : 상황실 근무일지 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2014.09.19	kyr		최초 생성
	 * 
	 * author kyr
	 * since 2014.09.19
	 * 
	 * Copyright (C) 2014 by kyr All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
<script type="text/javascript" src="<c:url value='/js/dailywork.js'/>"></script>
<script type="text/javascript">
//<![CDATA[
	$(function () {
		//시간셋팅
		setTime();
		
		$("#dept_app").change(function(){
			setPerson('app'); //직원셋팅
		});
		
		$("#dept_auth").change(function(){
			setPerson('auth'); //직원셋팅
		});
		
		setDept('app');		//부서셋팅
		setDept('auth');		//부서셋팅
		$('[id^=equip]').find("input").attr("disabled", true);
		$('[id^=equip]').find("select").attr("disabled", true);
		$('[id^=spanUse]').find("input").attr("disabled", true);
		$('[id^=spanUse]').find("select").attr("disabled", true);
	});
	
	function setTime(){
		//============================= 달 력 Start ======================================
		/* shows the loading div every time we have an Ajax call */
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		
		$("#workDay").datepicker({
			buttonText: '일자'
		});
		
		$("#workDay").val("${param.workDay}");
		
		function addzero(n) {
			return n < 10 ? "0" + n : n + "";
		}
		
		for(var i=0 ; i< 24 ; i++){
			var temp = addzero(i);
			var item = "<option value='"+temp+"'>"+temp+"</option>";
			$("#sHour").append(item);
			$("#gHour").append(item);
		}
		
		for(var i=0 ; i< 60 ; i++){
			var temp = addzero(i);
			var item = "<option value='"+temp+"'>"+temp+"</option>";
			$("#gMin").append(item);
			$("#sMin").append(item);
		}
		
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerApprovalIns");
		layerPopClose("layerAuthIns");
	}
	
	function fnSave(){
		fnTargetCheck();

		var workDay	= $('#workDay').val();
		
		if(workDay == "") {
			alert("일자를 입력해 주십시요.");
			$("#workDay").focus();
			return false;
		}
		
		var weather = $('#weather').val();
		if(getTextLength(weather) > 20) {
			alert("날씨는 20바이트 이하로 입력해 주십시요.");
			$("#weather").focus();
			return false;
		}
		
		if(confirm("저장 하시겠습니까?")){
			document.registform.action = "<c:url value='/dailywork/checkUseRegProc.do'/>";
			document.registform.submit();
		}
	}
	
	/**
     * 한글포함 문자열 길이를 구한다
     */
    function getTextLength(str) {
        var len = 0;
        for (var i = 0; i < str.length; i++) {
            if (escape(str.charAt(i)).length == 6) {
                len++;
            }
            len++;
        }
        return len;
    }

	//부서생성
	function setDept(gubun){
		var dropDownSet = "";
		if(gubun=='app'){
			dropDownSet = $("#dept_app");
			
			$("#sPerson_app").emptySelect();
				
		}else if(gubun=='auth'){
			dropDownSet = $("#dept_auth");
			
			$("#sPerson_auth").emptySelect();
		}
		$.getJSON("<c:url value='/alert/getGroupAndMember.do'/>",
			{
				orderType:"1"
			},
			//, system:sys_kind},
			function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					
					dropDownSet.loadSelect(data.groupList);
					
					setPerson(gubun);
					//adjustBranchList();
					
				} else {
					return;
				}
		});
	}

	//부서별 직원생성
	function setPerson(gubun){
		var value = "";
		var dropDownSet = "";
		
		if(gubun=='app'){
			value = $("#dept_app > option:selected").val();
			dropDownSet = $("#person_app");
		}else if(gubun=='auth'){
			value = $("#dept_auth > option:selected").val();
			dropDownSet = $("#person_auth");
		}
		
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


	//직원 추가
	function add(gubun){
		if(gubun=='app'){
			$("#person_app option:selected").each(function(i){
				var addOpt = document.createElement('option'); // 옵션을 설정한다..
				addOpt.value = $(this).val();
				addOpt.appendChild(document.createTextNode($(this).text())); // 셀렉트 박스의 text 를 설정한다.
				
				var flag = false;
				$("#sPerson_app option").each(function(i){
					if($(this).val() == addOpt.value){
						flag = true;
						return false;//break;
					}
				});
				
				if(!flag){
					$("#sPerson_app").append(addOpt);
				}
			});
		}else if(gubun=='auth'){
			$("#person_auth option:selected").each(function(i){
				var addOpt = document.createElement('option'); // 옵션을 설정한다..
				addOpt.value = $(this).val();
				addOpt.appendChild(document.createTextNode($(this).text())); // 셀렉트 박스의 text 를 설정한다.
				
				var flag = false;
				$("#sPerson_auth option").each(function(i){
					if($(this).val() == addOpt.value){
						flag = true;
						return false;//break;
					}
				});
				
				if(!flag){
					$("#sPerson_auth").append(addOpt);
				}
			});
		}
	}

	//직원 삭제
	function del(gubun){
		if(gubun=='app'){
			$("#sPerson_app option:selected").each(function(i){
				//$(this).appendTo('#person');
				$(this).remove();
			});
		}else if(gubun=='auth'){
			$("#sPerson_auth option:selected").each(function(i){
				//$(this).appendTo('#person');
				$(this).remove();
			});
		}
	}

	function approvalIdInsert(){
		var sPerson_app		= $('#sPerson_app').val();			//결재자
		
		//결재대상자
		var memberAppId = new Array;	
		var cnt_app = 0;
		
		$("#sPerson_app option").each(function() {
			memberAppId.push($(this).val());
			cnt_app++;
		});
		
		if(cnt_app==0){
			alert("결재자를 선택하여 주십시요.");
			return false;
		}
		
		if(cnt_app != 2 ){
			alert("결재자는 2명을 선택하여 주십시오.");
			return false;
		}
		
		$("#memberAppId").val(memberAppId);
		
		var temp = $("#memberAppId").val().split(",");
		
		$.ajax({
			type:"post",
			url:"<c:url value='/dailywork/getApprovalInfo.do'/>",
			data:{approvalId1:temp[0],
					 approvalId2:temp[1]
				},
			dataType:"json",
			success:function(result){
				var approvalName1 = result['approvalName1'];
				var approvalName2 = result['approvalName2'];
				
	   			document.getElementById("approvalName1").innerHTML = approvalName1;
	   			document.getElementById("approvalName2").innerHTML = approvalName2;
	    			
	            isProcess = false;
			},
	        error:function(result){
					$("#alertDataList").html("<tr><td colspan='4'>서버접속 실패</td></tr>");
		        }
		});
		
		layerPopClose('layerApprovalIns')
		
		setDept('app');		//부서셋팅
	}
	
	
	function authIdInsert(){
		var sPerson_auth		= $('#sPerson_auth').val();		//작성권한
		
		//작성권한대상자
		var member_auth = new Array;	
		var cnt_auth = 0;
		
		$("#sPerson_auth option").each(function() {
			member_auth.push($(this).val());
			cnt_auth++;
		});
		
		if(cnt_auth==0){
			alert("작성권한 대상자를 선택하여 주십시요.");
			return false;
		}
		
		$("#memberAuthId").val(member_auth);
		
		layerPopClose('layerAuthIns')
		
		setDept('auth');		//부서셋팅
	}
	
	function fnCancel(){
		//alert($('[id^=equipC1]').length);
		document.registform.action = "<c:url value='/dailywork/checkUseList.do?gubun=${param.gubun}'/>";
		document.registform.submit();
	}
	
	function showHideRows(obj, gubun) {
		if($(obj).is(":checked")) {
			$('[id=equip'+gubun+']').show();
			$('[id=equip'+gubun+']').find("input").attr("disabled", false);
			$('[id=equip'+gubun+']').find("select").attr("disabled", false);
			$("#input"+gubun).show();
			$('[id^=span'+gubun+']').show();
		} else {
			$('[id=equip'+gubun+']').hide();
			$('[id=equip'+gubun+']').find("input").attr("disabled", true);
			$('[id=equip'+gubun+']').find("select").attr("disabled", true);
			$("#input"+gubun).hide();
			$('[id^=span'+gubun+']').hide();
		}
	}

	function showHideSpanUse(obj, gubun) {
		if(gubun=='P1') {
			$('[id^=spanUse]').hide();
			$('[id^=spanUse]').find("input").attr("disabled", true);
			$('[id^=spanUse]').find("select").attr("disabled", true);
		} else {
			$('[id^=spanUse]').show();
			$('[id^=spanUse]').find("input").attr("disabled", false);
			$('[id^=spanUse]').find("select").attr("disabled", false);
		}
	}
//]]>
</script>
</head>

<body>
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
					<form name="registform" method="post" enctype="multipart/form-data" onsubmit="return false;">
					<input type="hidden" id="gubun"  name="gubun"  value="<c:out value="${param.gubun}"/>"/>
					<input type="hidden" id="memberAppId"  name="memberAppId"  value="<c:out value="${param.memberAppId}"/>"/>
					<input type="hidden" id="memberAuthId" name="memberAuthId" value="<c:out value="${param.memberAuthId}"/>"/>
					<input type="hidden" name="reportGubun" value="F1"/>
					<div>
						<span style="text-align:center;"><u><b><h1>보조방제장비/기기류 (점검·사용) 일지</h1></b></u></span>
					</div>
					<div style="float:right; ">
						<table style="width:270px;">
							<colgroup>
							<col width="30px" />
							<col width="120px" />
							<col width="120px" />
							</colgroup>
							<tr>
								<th rowspan="2"  style="height:100px;">결<br/><br/>재</th>
								<td style="height:20px;"><b><span id="approvalName1"><c:out value="${approvalName1}"/></span></b></td>
								<td><b><span id="approvalName2"><c:out value="${approvalName2}"/></span></b></td>
							</tr>
							<tr>
								<td style="height:80px;"></td>
								<td></td>
							</tr>
						</table>
						<div style="padding-top:10px;">
							<input type="button" id="btnAppPopup" value="결재라인변경" class="btn btn_basic" style="float:right" alt="결재라인변경" onclick="javascript:layerPopOpen('layerApprovalIns');"/>
						</div>
					</div>	
					<!--tab Contnet Start-->
					<div class="tab_container2">
						<div class="table_wrapper">
							<span style="float:left"><b>일자</b> : <input type="text" id="workDay" name="workDay" size="15"/></span>
							<span style="padding-left:30px;float:left"><b>날씨</b> : <input type="text" id="weather" name="weather" size="20" maxlength="20"/></span>
							<br />
							<br />
							<div style="text-align:left;">
								<span style="float:left">
								<b>작성구분</b> : 
								<c:forEach items="${equipList }" var="list">
									<input type="checkbox" name="equipCode1" value="${list.EQUIP_CODE}" onclick="showHideRows(this,this.value)"/>${list.EQUIP_NAME } &nbsp;&nbsp;
								</c:forEach>
							</span>
							</div>
							<br />
							<br />
							<span id="spanPurpose" style="float:left">
								<b>목 적</b> : 
								<input type="radio" name="purpose" value="P1" onclick="showHideSpanUse(this,this.value)"/>점검 &nbsp;&nbsp;
								<input type="radio" name="purpose" value="P2" onclick="showHideSpanUse(this,this.value)"/>사용 &nbsp;&nbsp;
								<input type="radio" name="purpose" value="P3" onclick="showHideSpanUse(this,this.value)"/>점검 및 사용
							</span>
							<br/>
							<div style="text-align:left;">
								<span><b></b></span> 
							</div>
							<br />
							<span id="spanUsePurpose" style="float:left;padding-left:50px;display:none">
								<b>사용목적</b> : 
								<select name="usePurpose">
									<option value="">선택하세요</option>
									<!-- <option value="U1">순찰</option> -->
									<option value="U2">방제지원</option>
									<option value="U3">훈련</option>
									<option value="U4">지원</option>
									<option value="U5">기타</option>
								</select>
							</span>
							<span id="spanUsePlace" style="padding-left:30px;float:left;display:none"><b>사용처</b> : <input type="text" id="usePlace" name="usePlace" size="50"/></span>
							<br/>
							<div style="text-align:left;">
								<span><b></b></span> 
							</div>
							<br/>
							<div style="text-align:left;">
								<span><b>점검 현황</b></span> 
							</div>
							<div>
								<table id="accidentTable">
									<colgroup>
										<col width="100px" />
										<col width="200px" />
										<col width="100px" />
										<col />
										<!-- <col width="100px"/> -->
									</colgroup>
									<tr>
										<th>구분</th>
										<th>점검분야</th>
										<th>결과</th>
										<th>비고</th>
										<!-- <th>사진</th> -->
									</tr>
									<c:forEach items="${equipList }" var="list">
									<c:if test="${list.CHECK_GUBUN eq 'F1' }">
									<tr id="equip${list.EQUIP_CODE }" style="display:none">
										<input type="hidden" name="gubunCode" value="${list.EQUIP_CODE }"/>
										<input type="hidden" name="checkCode" value="01"/>
										<td rowspan="2">${list.EQUIP_NAME }</td>
										<td style="text-align:left;padding-left:5px;">본 체</td>
										<td style="text-align:left;padding-left:10px;">
											<select name="checkResult">
												<!--<option value="">선택</option>-->
												<option value="O">양호</option>
												<option value="X">이상</option>
												<option value="N">해당없음</option>
											</select>
										</td>
										<td><input type="text" name="note" id="note" value="" size="54"></td>
										<!-- <td><input type="file" name="fileArr"/></td> -->
									</tr>
									<tr id="equip${list.EQUIP_CODE }" style="display:none">
										<input type="hidden" name="gubunCode" value="${list.EQUIP_CODE }"/>
										<input type="hidden" name="checkCode" value="02"/>
										<td style="text-align:left;padding-left:5px;">작동유무</td>
										<td style="text-align:left;padding-left:10px;">
											<select name="checkResult">
												<!--<option value="">선택</option>-->
												<option value="O">양호</option>
												<option value="X">이상</option>
												<option value="N">해당없음</option>
											</select>
										</td>
										<td><input type="text" name="note" id="note" value="" size="54"></td>
										<!-- <td><input type="file" name="fileArr"/></td> -->
									</tr>
									</c:if>
									</c:forEach>
									<c:forEach items="${equipList }" var="list">
									<c:if test="${list.CHECK_GUBUN eq 'F2' }">
									<tr id="equip${list.EQUIP_CODE }" style="display:none">
										<input type="hidden" name="gubunCode" value="${list.EQUIP_CODE }"/>
										<input type="hidden" name="checkCode" value="01"/>
										<td rowspan="2">발전기</td>
										<td style="text-align:left;padding-left:5px;">본 체</td>
										<td style="text-align:left;padding-left:10px;">
											<select name="checkResult">
												<!--<option value="">선택</option>-->
												<option value="O">양호</option>
												<option value="X">이상</option>
												<option value="N">해당없음</option>
											</select>
										</td>
										<td><input type="text" name="note" id="note" value="" size="54"></td>
										<!-- <td><input type="file" name="fileArr"/></td> -->
									</tr>
									<tr id="equip${list.EQUIP_CODE }" style="display:none">
										<input type="hidden" name="gubunCode" value="${list.EQUIP_CODE }"/>
										<input type="hidden" name="checkCode" value="02"/>
										<td style="text-align:left;padding-left:5px;">작동유무</td>
										<td style="text-align:left;padding-left:10px;">
											<select name="checkResult">
												<!--<option value="">선택</option>-->
												<option value="O">양호</option>
												<option value="X">이상</option>
												<option value="N">해당없음</option>
											</select>
										</td>
										<td><input type="text" name="note" id="note" value="" size="54"></td>
										<!-- <td><input type="file" name="fileArr"/></td> -->
									</tr>
									</c:if>
									</c:forEach>
									<c:forEach items="${equipList }" var="list">
									<c:if test="${list.CHECK_GUBUN eq 'F3' }">
									<tr id="equip${list.EQUIP_CODE }" style="display:none">
										<input type="hidden" name="gubunCode" value="${list.EQUIP_CODE }"/>
										<input type="hidden" name="checkCode" value="01"/>
										<td rowspan="2">양수기</td>
										<td style="text-align:left;padding-left:5px;">본 체</td>
										<td style="text-align:left;padding-left:10px;">
											<select name="checkResult">
												<!--<option value="">선택</option>-->
												<option value="O">양호</option>
												<option value="X">이상</option>
												<option value="N">해당없음</option>
											</select>
										</td>
										<td><input type="text" name="note" id="note" value="" size="54"></td>
										<!-- <td><input type="file" name="fileArr"/></td> -->
									</tr>
									<tr id="equip${list.EQUIP_CODE }" style="display:none">
										<input type="hidden" name="gubunCode" value="${list.EQUIP_CODE }"/>
										<input type="hidden" name="checkCode" value="02"/>
										<td style="text-align:left;padding-left:5px;">작동유무</td>
										<td style="text-align:left;padding-left:10px;">
											<select name="checkResult">
												<!--<option value="">선택</option>-->
												<option value="O">양호</option>
												<option value="X">이상</option>
												<option value="N">해당없음</option>
											</select>
										</td>
										<td><input type="text" name="note" id="note" value="" size="54"></td>
										<!-- <td><input type="file" name="fileArr"/></td> -->
									</tr>
									</c:if>
									</c:forEach>
									<c:forEach items="${equipList }" var="list">
									<c:if test="${list.CHECK_GUBUN eq 'F4' }">
									<tr id="equip${list.EQUIP_CODE }" style="display:none">
										<input type="hidden" name="gubunCode" value="${list.EQUIP_CODE }"/>
										<input type="hidden" name="checkCode" value="01"/>
										<td rowspan="2">예초기</td>
										<td style="text-align:left;padding-left:5px;">본 체</td>
										<td style="text-align:left;padding-left:10px;">
											<select name="checkResult">
												<!--<option value="">선택</option>-->
												<option value="O">양호</option>
												<option value="X">이상</option>
												<option value="N">해당없음</option>
											</select>
										</td>
										<td><input type="text" name="note" id="note" value="" size="54"></td>
										<!-- <td><input type="file" name="fileArr"/></td> -->
									</tr>
									<tr id="equip${list.EQUIP_CODE }" style="display:none">
										<input type="hidden" name="gubunCode" value="${list.EQUIP_CODE }"/>
										<input type="hidden" name="checkCode" value="02"/>
										<td style="text-align:left;padding-left:5px;">작동유무</td>
										<td style="text-align:left;padding-left:10px;">
											<select name="checkResult">
												<!--<option value="">선택</option>-->
												<option value="O">양호</option>
												<option value="X">이상</option>
												<option value="N">해당없음</option>
											</select>
										</td>
										<td><input type="text" name="note" id="note" value="" size="54"></td>
										<!-- <td><input type="file" name="fileArr"/></td> -->
									</tr>
									</c:if>
									</c:forEach>
									<c:forEach items="${equipList }" var="list">
									<c:if test="${list.CHECK_GUBUN eq 'F5' }">
									<tr id="equip${list.EQUIP_CODE }" style="display:none">
										<input type="hidden" name="gubunCode" value="${list.EQUIP_CODE }"/>
										<input type="hidden" name="checkCode" value="01"/>
										<td rowspan="2">점도계</td>
										<td style="text-align:left;padding-left:5px;">본 체</td>
										<td style="text-align:left;padding-left:10px;">
											<select name="checkResult">
												<!--<option value="">선택</option>-->
												<option value="O">양호</option>
												<option value="X">이상</option>
												<option value="N">해당없음</option>
											</select>
										</td>
										<td><input type="text" name="note" id="note" value="" size="54"></td>
										<!-- <td><input type="file" name="fileArr"/></td> -->
									</tr>
									<tr id="equip${list.EQUIP_CODE }" style="display:none">
										<input type="hidden" name="gubunCode" value="${list.EQUIP_CODE }"/>
										<input type="hidden" name="checkCode" value="02"/>
										<td style="text-align:left;padding-left:5px;">작동유무</td>
										<td style="text-align:left;padding-left:10px;">
											<select name="checkResult">
												<!--<option value="">선택</option>-->
												<option value="O">양호</option>
												<option value="X">이상</option>
												<option value="N">해당없음</option>
											</select>
										</td>
										<td><input type="text" name="note" id="note" value="" size="54"></td>
										<!-- <td><input type="file" name="fileArr"/></td> -->
									</tr>
									</c:if>
									</c:forEach>
									<c:forEach items="${equipList }" var="list">
									<c:if test="${list.CHECK_GUBUN eq 'F6' }">
									<tr id="equip${list.EQUIP_CODE }" style="display:none">
										<input type="hidden" name="gubunCode" value="${list.EQUIP_CODE }"/>
										<input type="hidden" name="checkCode" value="01"/>
										<td rowspan="2">거리측정기</td>
										<td style="text-align:left;padding-left:5px;">본 체</td>
										<td style="text-align:left;padding-left:10px;">
											<select name="checkResult">
												<!--<option value="">선택</option>-->
												<option value="O">양호</option>
												<option value="X">이상</option>
												<option value="N">해당없음</option>
											</select>
										</td>
										<td><input type="text" name="note" id="note" value="" size="54"></td>
										<!-- <td><input type="file" name="fileArr"/></td> -->
									</tr>
									<tr id="equip${list.EQUIP_CODE }" style="display:none">
										<input type="hidden" name="gubunCode" value="${list.EQUIP_CODE }"/>
										<input type="hidden" name="checkCode" value="02"/>
										<td style="text-align:left;padding-left:5px;">작동유무</td>
										<td style="text-align:left;padding-left:10px;">
											<select name="checkResult">
												<!--<option value="">선택</option>-->
												<option value="O">양호</option>
												<option value="X">이상</option>
												<option value="N">해당없음</option>
											</select>
										</td>
										<td><input type="text" name="note" id="note" value="" size="54"></td>
										<!-- <td><input type="file" name="fileArr"/></td> -->
									</tr>
									</c:if>
									</c:forEach>
									<c:forEach items="${equipList }" var="list">
									<c:if test="${list.CHECK_GUBUN eq 'F7' }">
									<tr id="equip${list.EQUIP_CODE }" style="display:none">
										<input type="hidden" name="gubunCode" value="${list.EQUIP_CODE }"/>
										<input type="hidden" name="checkCode" value="01"/>
										<td rowspan="2">유속계</td>
										<td style="text-align:left;padding-left:5px;">본 체</td>
										<td style="text-align:left;padding-left:10px;">
											<select name="checkResult">
												<!--<option value="">선택</option>-->
												<option value="O">양호</option>
												<option value="X">이상</option>
												<option value="N">해당없음</option>
											</select>
										</td>
										<td><input type="text" name="note" id="note" value="" size="54"></td>
										<!-- <td><input type="file" name="fileArr"/></td> -->
									</tr>
									<tr id="equip${list.EQUIP_CODE }" style="display:none">
										<input type="hidden" name="gubunCode" value="${list.EQUIP_CODE }"/>
										<input type="hidden" name="checkCode" value="02"/>
										<td style="text-align:left;padding-left:5px;">작동유무</td>
										<td style="text-align:left;padding-left:10px;">
											<select name="checkResult">
												<!--<option value="">선택</option>-->
												<option value="O">양호</option>
												<option value="X">이상</option>
												<option value="N">해당없음</option>
											</select>
										</td>
										<td><input type="text" name="note" id="note" value="" size="54"></td>
										<!-- <td><input type="file" name="fileArr"/></td> -->
									</tr>
									</c:if>
									</c:forEach>
									<c:forEach items="${equipList }" var="list">
									<c:if test="${list.CHECK_GUBUN eq 'F8' }">
									<tr id="equip${list.EQUIP_CODE }" style="display:none">
										<input type="hidden" name="gubunCode" value="${list.EQUIP_CODE }"/>
										<input type="hidden" name="checkCode" value="01"/>
										<td rowspan="2">일반항목<br/>측정기</td>
										<td style="text-align:left;padding-left:5px;">본 체</td>
										<td style="text-align:left;padding-left:10px;">
											<select name="checkResult">
												<!--<option value="">선택</option>-->
												<option value="O">양호</option>
												<option value="X">이상</option>
												<option value="N">해당없음</option>
											</select>
										</td>
										<td><input type="text" name="note" id="note" value="" size="54"></td>
										<!-- <td><input type="file" name="fileArr"/></td> -->
									</tr>
									<tr id="equip${list.EQUIP_CODE }" style="display:none">
										<input type="hidden" name="gubunCode" value="${list.EQUIP_CODE }"/>
										<input type="hidden" name="checkCode" value="02"/>
										<td style="text-align:left;padding-left:5px;">작동유무</td>
										<td style="text-align:left;padding-left:10px;">
											<select name="checkResult">
												<!--<option value="">선택</option>-->
												<option value="O">양호</option>
												<option value="X">이상</option>
												<option value="N">해당없음</option>
											</select>
										</td>
										<td><input type="text" name="note" id="note" value="" size="54"></td>
										<!-- <td><input type="file" name="fileArr"/></td> -->
									</tr>
									</c:if>
									</c:forEach>
								</table>
							</div>
							<br />
							<div style="text-align:left;">
								<span><b>특이사항</b></span>
								<br/>
								<textarea name="issueComment" id="issueComment" rows="3" style="width:98%;"></textarea> 
							</div>
							<br />
							<span style="float:left"><b>인 원</b> : <input type="text" name="persons" size="15"/> 명</span>
							<span style="padding-left:30px;float:left"><b>참여자</b> : <input type="text" id="participant" name="participant" size="50" maxlength="100"/></span>
							<br/>
							<div style="text-align:left;">
								<span><b></b></span> 
							</div>
							<br />
							<div style="text-align:left;">
								<span><b>사진대지</b></span>
								<br/>
								<input type="file" name="file1" size="150"/><br/>
								<input type="file" name="file2" size="150"/><br/>
								<input type="file" name="file3" size="150"/><br/> 
							</div>
							<br/>
							<div style="text-align:left;">
								<span><b>설 명</b></span>
								<br/>
								<textarea name="exprComment" id="exprComment" rows="3" style="width:98%;"></textarea> 
							</div>
						</form>
						<div style="padding-top:10px;">
							<input type="button" id="btnSave" value="저장" class="btn btn_basic" style="float:right" alt="저장" onclick="javascript:fnSave();"/>
							<input type="button" id="btnCancel" value="취소" class="btn btn_basic" style="float:right" alt="취소" onclick="javascript:fnCancel();"/>
						</div>
					</div>
						
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
	<!-- 결재라인 레이어 팝업 -->
	<div id="layerApprovalIns" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnGroInsXbox" name="btnGroInsXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerApprovalIns');" alt="닫기"/>
		</div>
		<table summary="결재라인선택"style="text-align:left;">
				<tr>
					<th scope="col">결재라인선택</th>
				</tr>
				<tr>
					<td colspan="3" valign="top" style="padding:7px 7px 7px 100px">
						<div class="gBox" style="width:220px">
							<span class="ptit" >
								대상기관
							</span>
							<select multiple="multiple" id="dept_app" style="padding:7px;width:220px;height:190px"></select>
						</div>
						<div style="padding-top:25px;float:left"><img src="/images/renewal/parrow.gif" alt="다음단계"/></div>
						<div class="gBox">
							<span class="ptit">
								담당자
							</span>
							<select multiple="multiple" id="person_app" style="padding:7px;width:180px;height:190px"></select>
						</div>
						<ul class="arrbx">
							<li style="padding-top:70px;"><a href="javascript:add('app')"><img src="<c:url value='/images/renewal/bt_arradd.gif'/>" alt="추가" /></a></li><br/>
							<li><a href="javascript:del('app')"><img src="<c:url value='/images/renewal/bt_arrdel.gif'/>" alt="삭제" /></a></li>
						</ul>
						<div class="gBox">
							<span class="ptit">
								결재자
							</span>
							<select multiple="multiple" id="sPerson_app" style="padding:7px;width:180px;height:190px"></select>
						</div>
					</td>
				</tr>
			</table>
		<div id="btCarea">
			<input type="button" id="btnRegist" name="btnRegist" value="등록" class="btn btn_white" onclick="javascript:approvalIdInsert();" alt="등록"/>
		</div>
	</div>
</body>
</html>