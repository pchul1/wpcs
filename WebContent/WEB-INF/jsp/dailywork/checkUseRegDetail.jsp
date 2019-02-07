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
			$('[id^=equip'+gubun+']').show();
			$("#input"+gubun).show();
			$('[id^=span'+gubun+']').show();
		} else {
			$('[id^=equip'+gubun+']').hide();
			$("#input"+gubun).hide();
			$('[id^=span'+gubun+']').hide();
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
					<c:set var="title" value="선박"/>
					<c:if test="${param.gubun eq 'A' }">
					<c:set var="title" value="선박 및 계류장 (점검·사용)"/>
					</c:if>
					<c:if test="${param.gubun eq 'B' }">
					<c:set var="title" value="유회수기 (점검·사용)"/>
					<input type="hidden" name="reportGubun" value="B1"/>
					</c:if>
					<c:if test="${param.gubun eq 'C' }">
					<c:set var="title" value="방제창고·방제물품트레일러 점검"/>
					<input type="checkbox" name="reportGubun" id="reportGubunC1" value="C1" checked="checked" onclick="showHideRows(this, 'C1')"/> 방제창고&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" name="reportGubun" id="reportGubunC2" value="C2" onclick="showHideRows(this, 'C2')"/> 방제물품트레일러
					</c:if>
					<c:if test="${param.gubun eq 'D' }">
					<c:set var="title" value="궤도형운반차량/4륜오토바이/전동지게차 (점검·사용)"/>
					<input type="checkbox" name="reportGubun" id="reportGubunD1" value="D1" checked="checked" onclick="showHideRows(this, 'D1')"/> 궤도형운반차량&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" name="reportGubun" id="reportGubunD2" value="D2" onclick="showHideRows(this, 'D2')"/> 4륜오토바이&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" name="reportGubun" id="reportGubunD3" value="D3" onclick="showHideRows(this, 'D3')"/> 전동지게차
					</c:if>
					<c:if test="${param.gubun eq 'E' }">
					<c:set var="title" value="진공흡입기/멀티콥터/방제바지선/에어텐트 (점검·사용)"/>
					<input type="checkbox" name="reportGubun" id="reportGubunE1" value="E1" checked="checked" onclick="showHideRows(this, 'E1')"/> 진공흡입기&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" name="reportGubun" id="reportGubunE2" value="E2" onclick="showHideRows(this, 'E2')"/> 멀티콥터&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" name="reportGubun" id="reportGubunE3" value="E3" onclick="showHideRows(this, 'E3')"/> 방제바지선&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<input type="checkbox" name="reportGubun" id="reportGubunE4" value="E4" onclick="showHideRows(this, 'E4')"/> 에어텐트
					</c:if>
					<c:if test="${param.gubun eq 'F' }">
					<c:set var="title" value="보조방제장비/기기류 (점검·사용)"/>
					</c:if>
					<br/>
					<div>
						<span style="text-align:center;"><u><b><h1><span id="strTitle"><c:out value="${title }"/></span> 일지</h1></b></u></span>
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
								<c:if test="${param.gubun ne 'F' }">
								<span style="padding-left:30px;float:left"><b>날씨</b> : <input type="text" id="weather" name="weather" size="20" maxlength="20"/></span>
								</c:if>
								<br />
								<br />
								<div style="text-align:left;">
									<span style="float:left"><b>작성구분 : </b>
									<c:if test="${param.gubun eq 'A' }">
										<input type="checkbox" name="reportGubun" id="reportGubunA1" value="A1" onclick="showHideRows(this,this.value)"/> 선박
										&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
										<input type="checkbox" name="reportGubun" id="reportGubunA2" value="A2" onclick="showHideRows(this,this.value)"/> 계류장
									</c:if>
									<c:if test="${param.gubun eq 'C' }">
										<input type="checkbox" name="checkGubun" id="checkGubun" value="A1"/>선박
										<input type="checkbox" name="checkGubun" id="checkGubun" value="A2"/>계류장
									</c:if>
									<c:if test="${param.gubun eq 'E' }">
										<c:forEach items="${equipList }" var="list">
											<input type="checkbox" name="checkGubun" value="${list.EQUIP_CODE}"/>${list.EQUIP_NAME }
										</c:forEach>
									</c:if>
									</span> 
								</div>
								<br />
								<br />
								<c:if test="${param.gubun eq 'A' }">
								<span id="inputA1" style="float:left;display:none"><b>선박명</b> : 
									<!-- <select name="equipCode">
										<option value="">선택하세요</option>
										<option value="A01">수질방제3호</option>
										<option value="A02">R11</option>
										<option value="A03">수질방제11호</option>
										<option value="A04">수질감시1호</option>
										<option value="A05">수질감시2호</option>
										<option value="A06">수질방제1호</option>
										<option value="A07">수질방제2호</option>
										<option value="A08">수질방제4호</option>
										<option value="A09">R21</option>
										<option value="A10">수질방제21호</option>
										<option value="A11">수질방제22호</option>
										<option value="A12">수질감시3호</option>
										<option value="A13">수질방제5호</option>
										<option value="A14">R31</option>
										<option value="A15">수질방제31호</option>
										<option value="A16">수질감시4호</option>
										<option value="A17">R41</option>
										<option value="A18">수질방제41호</option>
									</select> -->
									<c:forEach items="${equipList }" var="list">
										<input type="checkbox" name="equipCode" value="${list.EQUIP_CODE}"/>${list.EQUIP_NAME } &nbsp;&nbsp;
									</c:forEach>
								</span>
								<span id="inputA2" style="padding-left:30px;float:left;display:none"><b>계류장명</b> : <input type="text" id="marinasName" name="marinasName" size="50" maxlength="50"/></span>
								</c:if>
								<c:if test="${param.gubun eq 'B' }">
								<span style="float:left"><b>유회수기</b> : </span>
									<!-- <select name="equipCode">
										<option value="">선택하세요</option>
										<option value="B01">KOMARA 20(디스크형,대형)</option>
										<option value="B02">KOMARA MINI(디스크형,소형)</option>
										<option value="B03">KOMARA Duplexi(브러시형)</option>
									</select> -->
								</c:if>
								<c:if test="${param.gubun eq 'C' }">
								<span style="float:left"><b>시설명</b> : </span>
									<!-- <select name="equipCode">
										<option value="">선택하세요</option>
										<option value="C01">광주</option>
										<option value="C02">여주</option>
										<option value="C03">한강수계방제비축창고(남양주)
										<option value="C04">대구경북방제비축창고(성서)
										<option value="C05">밀양</option>
										<option value="C06">달성</option>
										<option value="C07">예천</option>
										<option value="C08">강창</option>
										<option value="C09">창암</option>
										<option value="C10">적포</option>
										<option value="C11">대구</option>
										<option value="C12">세종</option>
										<option value="C13">논산</option>
										<option value="C14">충청권방제비축창고(공주)
										<option value="C15">담양</option>
										<option value="C16">서창</option>
										<option value="C17">방제물품 트레일러(1)</option>
										<option value="C18">방제물품 트레일러(2)</option>
										<option value="C19">방제물품 트레일러(3)</option>
										<option value="C20">방제물품 트레일러(4)</option>
										<option value="C21">방제물품 트레일러(5)</option>
										<option value="C22">방제물품 트레일러(6)</option>
										<option value="C23">방제물품 트레일러(7)</option>
										<option value="C24">방제물품 트레일러(8)</option>
										<option value="C25">방제물품 트레일러(9)</option>
										<option value="C26">방제물품 트레일러(10)</option>
										<option value="C27">방제물품 트레일러(11)</option>
										<option value="C28">방제물품 트레일러(12)</option>
									</select> -->
								</c:if>
								<c:if test="${param.gubun eq 'D' }">
								<span style="float:left"><b>차량명</b> : </span>
								</c:if>
								<c:if test="${param.gubun eq 'E' }">
								<span style="float:left"><b>장비명</b> : </span>
								</c:if>
								<c:if test="${param.gubun eq 'F' }">
								<span style="float:left"><b>장비명</b> : </span>
									<!-- <select name="equipCode">
										<option value="">선택하세요</option>
										<option value="F01">동력분무기</option>
										<option value="F02">발전기</option>
										<option value="F03">엔진펌프</option>
										<option value="F04">예초기</option>
										<option value="F05">점도계</option>
										<option value="F06">유속계</option>
										<option value="F07">일반항목측정기</option>
									</select>
								</span> -->
								</c:if>
								<br/>
								<div style="text-align:left;">
									<span><b></b></span> 
								</div>
								<c:if test="${param.gubun ne 'C' and param.gubun ne 'F'}">
								<span id="spanPurpose" style="float:left;display:none">
								<br />
									<b>목 적</b> : 
									<select name="purpose">
										<option value="">선택하세요</option>
										<option value="P1">점검</option>
										<option value="P2">사용</option>
										<option value="P3">점검·사용</option>
									</select>
								<br />
								</span>
								<div style="text-align:left;">
									<span><b></b></span> 
								</div>
								<span id="selectUsePurpose" style="float:left;padding-left:50px;display:none">
									<br />
									<b>사용목적</b> : 
									<select name="usePurpose">
										<option value="">선택하세요</option>
										<c:if test="${param.gubun eq 'A' }">
										<option value="U1">순찰</option>
										</c:if>
										<option value="U2">방제지원</option>
										<option value="U3">훈련</option>
										<option value="U4">지원</option>
										<option value="U5">기타</option>
									</select>
								</span>
								<span id="spanUsePlace" style="padding-left:30px;float:left;display:none"><b>사용처</b> : <input type="text" id="usePlace" name="usePlace" size="50"/></span>
								<c:if test="${param.gubun eq 'A' }">
								<span id="spanVoyageSection" style="float:left;padding-left:50px;;display:none"><b>항해구간</b> : <input type="text" id="voyageSection" name="voyageSection" size="50"/></span>
								<span id="spanVoyageHour" style="padding-left:30px;float:left;display:none">
									<b>항해시간</b> : <input type="text" id="voyageHour" name="voyageHour" size="15"/> hr <input type="text" id="voyageMin" name="voyageMin" size="15"/> min
									<br />
								</span>
								</c:if>
								<div style="text-align:left;">
									<span><b></b></span> 
								</div>
								<span id="spanFuelInject" style="float:left;display:none">
									<br />
									<br/>
									<b>연료주입</b> : <input type="text" id="fuelInject" name="fuelInject" size="15"/>
								</span>
								</c:if>
								<c:if test="${param.gubun eq 'F' }">
								<span style="float:left;">
									<br />
									<b>사용목적</b> : 
									<select name="usePurpose">
										<option value="">선택하세요</option>
										<option value="U2">방제지원</option>
										<option value="U3">훈련</option>
										<option value="U4">지원</option>
										<option value="U5">기타</option>
									</select>
								</span>
								<span style="padding-left:30px;float:left">
									<b>사용처</b> : <input type="text" id="usePlace" name="usePlace" size="50"/>
									<br />
								</span>
								<div style="text-align:left;">
									<span><b></b></span> 
								</div>
								<br />
								</c:if>
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
											<col width="100px"/>
										</colgroup>
										<tr>
											<th>구분</th>
											<th>점검분야</th>
											<th>결과</th>
											<th>비고</th>
											<th>사진</th>
										</tr>
										<c:if test="${param.gubun eq 'A' }">
										<tr id="equipA1" style="display:none">
											<input type="hidden" name="gubunCode" value="A1"/>
											<input type="hidden" name="checkCode" value="01"/>
											<td rowspan="8">선 박</td>
											<td style="text-align:left;padding-left:5px;">항해장비</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipA1" style="display:none">
											<input type="hidden" name="gubunCode" value="A1"/>
											<input type="hidden" name="checkCode" value="02"/>
											<td style="text-align:left;padding-left:5px;">선 체</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipA1" style="display:none">
											<input type="hidden" name="gubunCode" value="A1"/>
											<input type="hidden" name="checkCode" value="03"/>
											<td style="text-align:left;padding-left:5px;">엔진계통</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipA1" style="display:none">
											<input type="hidden" name="gubunCode" value="A1"/>
											<input type="hidden" name="checkCode" value="04"/>
											<td style="text-align:left;padding-left:5px;">연료계통</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipA1" style="display:none">
											<input type="hidden" name="gubunCode" value="A1"/>
											<input type="hidden" name="checkCode" value="05"/>
											<td style="text-align:left;padding-left:5px;">전기계통</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipA1" style="display:none">
											<input type="hidden" name="gubunCode" value="A1"/>
											<input type="hidden" name="checkCode" value="06"/>
											<td style="text-align:left;padding-left:5px;">탑재장비</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipA1" style="display:none">
											<input type="hidden" name="gubunCode" value="A1"/>
											<input type="hidden" name="checkCode" value="07"/>
											<td style="text-align:left;padding-left:5px;">안전장치</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipA1" style="display:none">
											<input type="hidden" name="gubunCode" value="A1"/>
											<input type="hidden" name="checkCode" value="08"/>
											<td style="text-align:left;padding-left:5px;">소화기</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<!-- 계류장 -->
										<tr id="equipA2" style="display:none">
											<input type="hidden" name="gubunCode" value="A2"/>
											<input type="hidden" name="checkCode" value="01"/>
											<td rowspan="7">계류장<input type="hidden" name="sGubun[]" id="sGubun" value=""></td>
											<td style="text-align:left;padding-left:5px;">계류장위치</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipA2" style="display:none">
											<input type="hidden" name="gubunCode" value="A2"/>
											<input type="hidden" name="checkCode" value="02"/>
											<td style="text-align:left;padding-left:5px;">계선로프상태</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipA2" style="display:none">
											<input type="hidden" name="gubunCode" value="A2"/>
											<input type="hidden" name="checkCode" value="03"/>
											<td style="text-align:left;padding-left:5px;">계선주(닻)상태</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipA2" style="display:none">
											<input type="hidden" name="gubunCode" value="A2"/>
											<input type="hidden" name="checkCode" value="04"/>
											<td style="text-align:left;padding-left:5px;">플로트 및 사이드범퍼</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipA2" style="display:none">
											<input type="hidden" name="gubunCode" value="A2"/>
											<input type="hidden" name="checkCode" value="05"/>
											<td style="text-align:left;padding-left:5px;">도교의위치(부교,바지선)</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipA2" style="display:none">
											<input type="hidden" name="gubunCode" value="A2"/>
											<input type="hidden" name="checkCode" value="06"/>
											<td style="text-align:left;padding-left:5px;">인명구조장비</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipA2" style="display:none">
											<input type="hidden" name="gubunCode" value="A2"/>
											<input type="hidden" name="checkCode" value="07"/>
											<td style="text-align:left;padding-left:5px;">계류장주변환경</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										</c:if>
										<c:if test="${param.gubun eq 'B' }">
										<!-- 유회수기 -->
										<tr id="equipB1">
											<input type="hidden" name="gubunCode" value="B1"/>
											<input type="hidden" name="checkCode" value="01"/>
											<td rowspan="6">유회수기</td>
											<td style="text-align:left;padding-left:5px;">동력부</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipB1">
											<input type="hidden" name="gubunCode" value="B1"/>
											<input type="hidden" name="checkCode" value="02"/>
											<td style="text-align:left;padding-left:5px;">유압부</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipB1">
											<input type="hidden" name="gubunCode" value="B1"/>
											<input type="hidden" name="checkCode" value="03"/>
											<td style="text-align:left;padding-left:5px;">유회수부</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipB1">
											<input type="hidden" name="gubunCode" value="B1"/>
											<input type="hidden" name="checkCode" value="04"/>
											<td style="text-align:left;padding-left:5px;">펌프부</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipB1">
											<input type="hidden" name="gubunCode" value="B1"/>
											<input type="hidden" name="checkCode" value="05"/>
											<td style="text-align:left;padding-left:5px;">유압호스</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipB1">
											<input type="hidden" name="gubunCode" value="B1"/>
											<input type="hidden" name="checkCode" value="06"/>
											<td style="text-align:left;padding-left:5px;">회수호스</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										</c:if>
										<c:if test="${param.gubun eq 'C' }">
										<!-- 유회수기 -->
										<tr id="equipC1">
											<input type="hidden" name="gubunCode" value="C1"/>
											<input type="hidden" name="checkCode" value="01"/>
											<td rowspan="11">방제창고</td>
											<td style="text-align:left;padding-left:5px;">외 부</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipC1">
											<input type="hidden" name="gubunCode" value="C1"/>
											<input type="hidden" name="checkCode" value="02"/>
											<td style="text-align:left;padding-left:5px;">내 부</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipC1">
											<input type="hidden" name="gubunCode" value="C1"/>
											<input type="hidden" name="checkCode" value="03"/>
											<td style="text-align:left;padding-left:5px;">기 초</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipC1">
											<input type="hidden" name="gubunCode" value="C1"/>
											<input type="hidden" name="checkCode" value="04"/>
											<td style="text-align:left;padding-left:5px;">담장 및 펜스</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipC1">
											<input type="hidden" name="gubunCode" value="C1"/>
											<input type="hidden" name="checkCode" value="05"/>
											<td style="text-align:left;padding-left:5px;">전기계통 및 전등</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipC1">
											<input type="hidden" name="gubunCode" value="C1"/>
											<input type="hidden" name="checkCode" value="06"/>
											<td style="text-align:left;padding-left:5px;">창고내부 누수여부</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipC1">
											<input type="hidden" name="gubunCode" value="C1"/>
											<input type="hidden" name="checkCode" value="07"/>
											<td style="text-align:left;padding-left:5px;">소화기 비치 및 점검</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="sGubun[]" id="sGubun" value="" size="54"></td>
											<td><input type="file" name="sGubun[]" id="sGubun" value=""></td>
										</tr>
										<tr id="equipC1">
											<input type="hidden" name="gubunCode" value="C1"/>
											<input type="hidden" name="checkCode" value="08"/>
											<td style="text-align:left;padding-left:5px;">창고 내부 정리정돈</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipC1">
											<input type="hidden" name="gubunCode" value="C1"/>
											<input type="hidden" name="checkCode" value="09"/>
											<td style="text-align:left;padding-left:5px;">인화성 물질 누출여부</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipC1">
											<input type="hidden" name="gubunCode" value="C1"/>
											<input type="hidden" name="checkCode" value="10"/>
											<td style="text-align:left;padding-left:5px;">방제장비 재고량</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipC1">
											<input type="hidden" name="gubunCode" value="C1"/>
											<input type="hidden" name="checkCode" value="11"/>
											<td style="text-align:left;padding-left:5px;">방제물품 재고량</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipC2" style="display:none">
											<input type="hidden" name="gubunCode" value="C2"/>
											<input type="hidden" name="checkCode" value="01"/>
											<td rowspan="7">방제물품<br/>트레일러</td>
											<td style="text-align:left;padding-left:5px;">주차위치</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipC2" style="display:none">
											<input type="hidden" name="gubunCode" value="C2"/>
											<input type="hidden" name="checkCode" value="02"/>
											<td style="text-align:left;padding-left:5px;">바퀴고정</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipC2" style="display:none">
											<input type="hidden" name="gubunCode" value="C2"/>
											<input type="hidden" name="checkCode" value="03"/>
											<td style="text-align:left;padding-left:5px;">타이어공기압</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipC2" style="display:none">
											<input type="hidden" name="gubunCode" value="C2"/>
											<input type="hidden" name="checkCode" value="04"/>
											<td style="text-align:left;padding-left:5px;">견인부</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipC2" style="display:none">
											<input type="hidden" name="gubunCode" value="C2"/>
											<input type="hidden" name="checkCode" value="05"/>
											<td style="text-align:left;padding-left:5px;">천막상태</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipC2" style="display:none">
											<input type="hidden" name="gubunCode" value="C2"/>
											<input type="hidden" name="checkCode" value="06"/>
											<td style="text-align:left;padding-left:5px;">자금장치</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipC2" style="display:none">
											<input type="hidden" name="gubunCode" value="C2"/>
											<input type="hidden" name="checkCode" value="07"/>
											<td style="text-align:left;padding-left:5px;">연락처</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										</c:if>
										<c:if test="${param.gubun eq 'D' }">
										<!-- 차량류 - 궤도형 운반차량 -->
										<tr id="equipD1">
											<input type="hidden" name="gubunCode" value="D1"/>
											<input type="hidden" name="checkCode" value="01"/>
											<td rowspan="6">궤도형<br/>운반차량</td>
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
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipD1">
											<input type="hidden" name="gubunCode" value="D1"/>
											<input type="hidden" name="checkCode" value="02"/>
											<td style="text-align:left;padding-left:5px;">엔 진</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipD1">
											<input type="hidden" name="gubunCode" value="D1"/>
											<input type="hidden" name="checkCode" value="03"/>
											<td style="text-align:left;padding-left:5px;">연료계통</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipD1">
											<input type="hidden" name="gubunCode" value="D1"/>
											<input type="hidden" name="checkCode" value="04"/>
											<td style="text-align:left;padding-left:5px;">구동 및 주행부</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipD1">
											<input type="hidden" name="gubunCode" value="D1"/>
											<input type="hidden" name="checkCode" value="05"/>
											<td style="text-align:left;padding-left:5px;">유압부</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipD1">
											<input type="hidden" name="gubunCode" value="D1"/>
											<input type="hidden" name="checkCode" value="06"/>
											<td style="text-align:left;padding-left:5px;">적재함</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<!-- 차량류 - 4륜 오토바이 -->
										<tr id="equipD2" style="display:none">
											<input type="hidden" name="gubunCode" value="D2"/>
											<input type="hidden" name="checkCode" value="01"/>
											<td rowspan="5">4륜<br/>오토바이</td>
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
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipD2" style="display:none">
											<input type="hidden" name="gubunCode" value="D2"/>
											<input type="hidden" name="checkCode" value="02"/>
											<td style="text-align:left;padding-left:5px;">엔 진</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipD2" style="display:none">
											<input type="hidden" name="gubunCode" value="D2"/>
											<input type="hidden" name="checkCode" value="03"/>
											<td style="text-align:left;padding-left:5px;">연료계통</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipD2" style="display:none">
											<input type="hidden" name="gubunCode" value="D2"/>
											<input type="hidden" name="checkCode" value="04"/>
											<td style="text-align:left;padding-left:5px;">브레이크</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipD2" style="display:none">
											<input type="hidden" name="gubunCode" value="D2"/>
											<input type="hidden" name="checkCode" value="05"/>
											<td style="text-align:left;padding-left:5px;">타이어</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipD2" style="display:none">
											<input type="hidden" name="gubunCode" value="D2"/>
											<input type="hidden" name="checkCode" value="06"/>
											<td rowspan="6">전동지게차</td>
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
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipD2" style="display:none">
											<input type="hidden" name="gubunCode" value="D2"/>
											<input type="hidden" name="checkCode" value="07"/>
											<td style="text-align:left;padding-left:5px;">배터리</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipD2" style="display:none">
											<input type="hidden" name="gubunCode" value="D2"/>
											<input type="hidden" name="checkCode" value="08"/>
											<td style="text-align:left;padding-left:5px;">타이어</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipD2" style="display:none">
											<input type="hidden" name="gubunCode" value="D2"/>
											<input type="hidden" name="checkCode" value="09"/>
											<td style="text-align:left;padding-left:5px;">조향장치</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipD2" style="display:none">
											<input type="hidden" name="gubunCode" value="D2"/>
											<input type="hidden" name="checkCode" value="10"/>
											<td style="text-align:left;padding-left:5px;">유압부</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipD2" style="display:none">
											<input type="hidden" name="gubunCode" value="D2"/>
											<input type="hidden" name="checkCode" value="11"/>
											<td style="text-align:left;padding-left:5px;">각종센서</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										</c:if>
										<c:if test="${param.gubun eq 'E' }">
										<tr id="equipE1">
											<input type="hidden" name="gubunCode" value="E1"/>
											<input type="hidden" name="checkCode" value="01"/>
											<td rowspan="6">진공흡입기</td>
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
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE1">
											<input type="hidden" name="gubunCode" value="E1"/>
											<input type="hidden" name="checkCode" value="02"/>
											<td style="text-align:left;padding-left:5px;">엔 진</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE1">
											<input type="hidden" name="gubunCode" value="E1"/>
											<input type="hidden" name="checkCode" value="02"/>
											<td style="text-align:left;padding-left:5px;">주행계통</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE1">
											<input type="hidden" name="gubunCode" value="E1"/>
											<input type="hidden" name="checkCode" value="03"/>
											<td style="text-align:left;padding-left:5px;">스키머</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE1">
											<input type="hidden" name="gubunCode" value="E1"/>
											<input type="hidden" name="checkCode" value="04"/>
											<td style="text-align:left;padding-left:5px;">진공흡입구</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE1">
											<input type="hidden" name="gubunCode" value="E1"/>
											<input type="hidden" name="checkCode" value="05"/>
											<td style="text-align:left;padding-left:5px;">흡입호스</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE2">
											<input type="hidden" name="gubunCode" value="E2"/>
											<input type="hidden" name="checkCode" value="01"/>
											<td rowspan="6">멀티콥터</td>
											<td style="text-align:left;padding-left:5px;">촬영승인</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE2">
											<input type="hidden" name="gubunCode" value="E2"/>
											<input type="hidden" name="checkCode" value="02"/>
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
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE2">
											<input type="hidden" name="gubunCode" value="E2"/>
											<input type="hidden" name="checkCode" value="03"/>
											<td style="text-align:left;padding-left:5px;">배터리</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE2">
											<input type="hidden" name="gubunCode" value="E2"/>
											<input type="hidden" name="checkCode" value="04"/>
											<td style="text-align:left;padding-left:5px;">카메라</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE2">
											<input type="hidden" name="gubunCode" value="E2"/>
											<input type="hidden" name="checkCode" value="05"/>
											<td style="text-align:left;padding-left:5px;">GPS상태</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE2">
											<input type="hidden" name="gubunCode" value="E2"/>
											<input type="hidden" name="checkCode" value="06"/>
											<td style="text-align:left;padding-left:5px;">조정기</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE3" style="display:none">
											<input type="hidden" name="gubunCode" value="E3"/>
											<input type="hidden" name="checkCode" value="01"/>
											<td rowspan="6">방제바지선</td>
											<td style="text-align:left;padding-left:5px;">선 체</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE3" style="display:none">
											<input type="hidden" name="gubunCode" value="E3"/>
											<input type="hidden" name="checkCode" value="02"/>
											<td style="text-align:left;padding-left:5px;">선외기</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE3" style="display:none">
											<input type="hidden" name="gubunCode" value="E3"/>
											<input type="hidden" name="checkCode" value="03"/>
											<td style="text-align:left;padding-left:5px;">가드레인</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE3" style="display:none">
											<input type="hidden" name="gubunCode" value="E3"/>
											<input type="hidden" name="checkCode" value="04"/>
											<td style="text-align:left;padding-left:5px;">앵커(닻)</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE3" style="display:none">
											<input type="hidden" name="gubunCode" value="E3"/>
											<input type="hidden" name="checkCode" value="05"/>
											<td style="text-align:left;padding-left:5px;">계선로프</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE3" style="display:none">
											<input type="hidden" name="gubunCode" value="E3"/>
											<input type="hidden" name="checkCode" value="05"/>
											<td style="text-align:left;padding-left:5px;">안전장비</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE4" style="display:none">
											<input type="hidden" name="gubunCode" value="E4"/>
											<input type="hidden" name="checkCode" value="01"/>
											<td rowspan="8">에어텐트</td>
											<td style="text-align:left;padding-left:5px;">텐트본체</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE4" style="display:none">
											<input type="hidden" name="gubunCode" value="E4"/>
											<input type="hidden" name="checkCode" value="02"/>
											<td style="text-align:left;padding-left:5px;">발전기</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE4" style="display:none">
											<input type="hidden" name="gubunCode" value="E4"/>
											<input type="hidden" name="checkCode" value="03"/>
											<td style="text-align:left;padding-left:5px;">블로워</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="sGubun[]" id="sGubun" value="" size="54"></td>
											<td><input type="file" name="sGubun[]" id="sGubun" value=""></td>
										</tr>
										<tr id="equipE4" style="display:none">
											<input type="hidden" name="gubunCode" value="E4"/>
											<input type="hidden" name="checkCode" value="04"/>
											<td style="text-align:left;padding-left:5px;">에어펌프(수동)</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE4" style="display:none">
											<input type="hidden" name="gubunCode" value="E4"/>
											<input type="hidden" name="checkCode" value="05"/>
											<td style="text-align:left;padding-left:5px;">수리공구</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE4" style="display:none">
											<input type="hidden" name="gubunCode" value="E4"/>
											<input type="hidden" name="checkCode" value="06"/>
											<td style="text-align:left;padding-left:5px;">열풍기</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE4" style="display:none">
											<input type="hidden" name="gubunCode" value="E4"/>
											<input type="hidden" name="checkCode" value="07"/>
											<td style="text-align:left;padding-left:5px;">조명장치</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										<tr id="equipE4" style="display:none">
											<input type="hidden" name="gubunCode" value="E4"/>
											<input type="hidden" name="checkCode" value="08"/>
											<td style="text-align:left;padding-left:5px;">고정고리</td>
											<td style="text-align:left;padding-left:10px;">
												<select name="checkResult">
													<!--<option value="">선택</option>-->
													<option value="O">양호</option>
													<option value="X">이상</option>
													<option value="N">해당없음</option>
												</select>
											</td>
											<td><input type="text" name="note" id="note" value="" size="54"></td>
											<td><input type="file" name="fileArr"/></td>
										</tr>
										</c:if>
									</table>
								</div>
								<br />
								<div style="text-align:left;">
									<span><b>특이사항</b></span>
									<br/>
									<textarea name="issueComment" id="issueComment" rows="3" style="width:98%;"></textarea> 
								</div>
								<br />
								<c:if test="${param.gubun ne 'F' }">
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
								</c:if>
								<c:if test="${param.gubun eq 'F' }">
								<span style="float:left"><b>사용자</b> : <input type="text" id="participant" name="participant" size="50"/></span>
								</c:if>
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