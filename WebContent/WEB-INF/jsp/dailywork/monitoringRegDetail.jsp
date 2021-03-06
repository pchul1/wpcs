<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : monitoringRegDetail.jsp
	 * Description : 조류모니터링 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2014.10.10	kyr		최초 생성
	 * 
	 * author kyr
	 * since 2014.10.10
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
	
	function fnSave(){
		var workDay	= $('#workDay').val();
		
		if(workDay == "") {
			alert("일자를 입력해 주십시요.");
			$("#workDay").focus();
			return false;
		}
		
		if(confirm("저장 하시겠습니까?")){
			document.registform.action = "<c:url value='/dailywork/monitoringRegProc.do'/>";
			document.registform.submit();
		}
	}
	function fnCancel(){
		document.registform.action = "<c:url value='/dailywork/dailyWorkList.do?gubun=M'/>";
		document.registform.submit();
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
// 		layerPopClose("layerGroupIns");
// 		layerPopClose("layerGroupDel");
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
					<div >
						<span style="text-align:center;"><u><b><h1>조류(Chl-a) 모니터링 일지</h1></b></u></span>
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
								<form name="registform" method="post" onsubmit="return false;" enctype="multipart/form-data">
								<input type="hidden" id="memberAppId" name="memberAppId" value="<c:out value="${param.memberAppId}"/>"/>
								<input type="hidden" id="memberAuthId" name="memberAuthId" value="<c:out value="${param.memberAuthId}"/>"/>
								<span style="float:left"><b>1. 일자</b> : <input type="text" id="workDay" name="workDay" size="15"/></span>
								<span style="padding-left:30px;float:left"><b>날씨</b> : <input type="text" id="weather" name="weather" size="20"/></span>
								<br />
								<div style="text-align:left;">
									<span><b></b></span> 
								</div>
								<br />
								<div style="text-align:left;">
									<span><b>2. 수질예측정보</b></span> <span><input type="button" id="btnAuthPopup" value="작성권한변경" class="btn btn_basic" alt="작성권한변경" onclick="javascript:layerPopOpen('layerAuthIns');"/></span>
								</div>
								<br/>
								<div>
									<table>
										<colgroup>
											<col width="4%" />
											<col width="8%" />
											<col width="11%" />
											<col width="11%" />
											<col width="11%" />
											<col width="11%" />
											<col width="11%" />
											<col width="11%" />
											<col width="11%" />
										</colgroup>
										<tr>
											<th colspan="2" rowspan="2">구분</th>
											<th colspan="3">한강</th>
											<th colspan="3">금강</th>
											<th colspan="2">영산강</th>
										</tr>
										<tr>
											<th>강천</th>
											<th>여주</th>
											<th>이포</th>
											<th>세종</th>
											<th>공주</th>
											<th>백제</th>
											<th>승촌</th>
											<th>죽산</th>
										</tr>
										<tr>
											<td rowspan="4">예 <p>·</p><p>경</p><p>보</p></td>
											<td>일자</td>
											<td>
												<input type="hidden" name="aRiverDiv[]" id="aRiverDiv[]" value="R01"/>
												<input type="hidden" name="aFactCode[]" id="aFactCode[]" value="S01005"/>
												<input type="text" name="aForecastDay[]" id="aForecastDay[]" value="" size="14"/>
											</td>
											<td>
												<input type="hidden" name="aRiverDiv[]" id="aRiverDiv[]" value="R01"/>
												<input type="hidden" name="aFactCode[]" id="aFactCode[]" value="S01020"/>
												<input type="text" name="aForecastDay[]" id="aForecastDay[]" value="" size="14"/>
											</td>
											<td>
												<input type="hidden" name="aRiverDiv[]" id="aRiverDiv[]" value="R01"/>
												<input type="hidden" name="aFactCode[]" id="aFactCode[]" value="S01002"/>
												<input type="text" name="aForecastDay[]" id="aForecastDay[]" value="" size="14"/>
											</td>
											<td>
												<input type="hidden" name="aRiverDiv[]" id="aRiverDiv[]" value="R03"/>
												<input type="hidden" name="aFactCode[]" id="aFactCode[]" value="S03013"/>
												<input type="text" name="aForecastDay[]" id="aForecastDay[]" value="" size="14"/>
											</td>
											<td>
												<input type="hidden" name="aRiverDiv[]" id="aRiverDiv[]" value="R03"/>
												<input type="hidden" name="aFactCode[]" id="aFactCode[]" value="S03014"/>
												<input type="text" name="aForecastDay[]" id="aForecastDay[]" value="" size="14"/>
											</td>
											<td>
												<input type="hidden" name="aRiverDiv[]" id="aRiverDiv[]" value="R03"/>
												<input type="hidden" name="aFactCode[]" id="aFactCode[]" value="S03005"/>
												<input type="text" name="aForecastDay[]" id="aForecastDay[]" value="" size="14"/>
											</td>
											<td>
												<input type="hidden" name="aRiverDiv[]" id="aRiverDiv[]" value="R04"/>
												<input type="hidden" name="aFactCode[]" id="aFactCode[]" value="S04005"/>
												<input type="text" name="aForecastDay[]" id="aForecastDay[]" value="" size="14"/>
											</td>
											<td>
												<input type="hidden" name="aRiverDiv[]" id="aRiverDiv[]" value="R04"/>
												<input type="hidden" name="aFactCode[]" id="aFactCode[]" value="S04002"/>
												<input type="text" name="aForecastDay[]" id="aForecastDay[]" value="" size="14"/>
											</td>
										</tr>
										<tr>
											<td>현황</td>
											<td>
												<input type="text" name="aForecastStatus[]" id="aForecastStatus[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastStatus[]" id="aForecastStatus[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastStatus[]" id="aForecastStatus[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastStatus[]" id="aForecastStatus[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastStatus[]" id="aForecastStatus[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastStatus[]" id="aForecastStatus[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastStatus[]" id="aForecastStatus[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastStatus[]" id="aForecastStatus[]" value="" size="14"/>
											</td>
										</tr>
										<tr>
											<td>농도</td>
											<td>
												<input type="text" name="aForecastCon[]" id="aForecastCon[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastCon[]" id="aForecastCon[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastCon[]" id="aForecastCon[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastCon[]" id="aForecastCon[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastCon[]" id="aForecastCon[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastCon[]" id="aForecastCon[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastCon[]" id="aForecastCon[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastCon[]" id="aForecastCon[]" value="" size="14"/>
											</td>
										</tr>
										<tr>
											<td>남조류</td>
											<td>
												<input type="text" name="aForecastTidal[]" id="aForecastTidal[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastTidal[]" id="aForecastTidal[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastTidal[]" id="aForecastTidal[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastTidal[]" id="aForecastTidal[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastTidal[]" id="aForecastTidal[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastTidal[]" id="aForecastTidal[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastTidal[]" id="aForecastTidal[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastTidal[]" id="aForecastTidal[]" value="" size="14"/>
											</td>
										</tr>
										<tr>
											<td colspan="2">자동</td>
											<td>
												<input type="text" name="aForecastAuto[]" id="aForecastAuto[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastAuto[]" id="aForecastAuto[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastAuto[]" id="aForecastAuto[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastAuto[]" id="aForecastAuto[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastAuto[]" id="aForecastAuto[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastAuto[]" id="aForecastAuto[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastAuto[]" id="aForecastAuto[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastAuto[]" id="aForecastAuto[]" value="" size="14"/>
											</td>
										</tr>
										<tr>
											<th colspan="2" rowspan="2">구분</th>
											<th colspan="8">낙동강</th>
										</tr>
										<tr>
											<th>상주</th>
											<th>낙단</th>
											<th>구미</th>
											<th>칠곡</th>
											<th>강정·고령</th>
											<th>달성</th>
											<th>합청·창녕</th>
											<th>창녕·함안</th>
										</tr>
										<tr>
											<td rowspan="4">예<p>·</p><p>경</p><p>보</p></td>
											<td>일자</td>
											<td>
												<input type="hidden" name="aRiverDiv[]" id="aRiverDiv[]" value="R02"/>
												<input type="hidden" name="aFactCode[]" id="aFactCode[]" value="S02022"/>
												<input type="text" name="aForecastDay[]" id="aForecastDay[]" value="" size="14"/>
											</td>
											<td>
												<input type="hidden" name="aRiverDiv[]" id="aRiverDiv[]" value="R02"/>
												<input type="hidden" name="aFactCode[]" id="aFactCode[]" value="S02020"/>
												<input type="text" name="aForecastDay[]" id="aForecastDay[]" value="" size="14"/>
											</td>
											<td>
												<input type="hidden" name="aRiverDiv[]" id="aRiverDiv[]" value="R02"/>
												<input type="hidden" name="aFactCode[]" id="aFactCode[]" value="S02021"/>
												<input type="text" name="aForecastDay[]" id="aForecastDay[]" value="" size="14"/>
											</td>
											<td>
												<input type="hidden" name="aRiverDiv[]" id="aRiverDiv[]" value="R02"/>
												<input type="hidden" name="aFactCode[]" id="aFactCode[]" value="S02015"/>
												<input type="text" name="aForecastDay[]" id="aForecastDay[]" value="" size="14"/>
											</td>
											<td>
												<input type="hidden" name="aRiverDiv[]" id="aRiverDiv[]" value="R02"/>
												<input type="hidden" name="aFactCode[]" id="aFactCode[]" value="S02009"/>
												<input type="text" name="aForecastDay[]" id="aForecastDay[]" value="" size="14"/>
											</td>
											<td>
												<input type="hidden" name="aRiverDiv[]" id="aRiverDiv[]" value="R02"/>
												<input type="hidden" name="aFactCode[]" id="aFactCode[]" value="S02002"/>
												<input type="text" name="aForecastDay[]" id="aForecastDay[]" value="" size="14"/>
											</td>
											<td>
												<input type="hidden" name="aRiverDiv[]" id="aRiverDiv[]" value="R02"/>
												<input type="hidden" name="aFactCode[]" id="aFactCode[]" value="S02005"/>
												<input type="text" name="aForecastDay[]" id="aForecastDay[]" value="" size="14"/>
											</td>
											<td>
												<input type="hidden" name="aRiverDiv[]" id="aRiverDiv[]" value="R02"/>
												<input type="hidden" name="aFactCode[]" id="aFactCode[]" value="S02006"/>
												<input type="text" name="aForecastDay[]" id="aForecastDay[]" value="" size="14"/>
											</td>
										</tr>
										<tr>
											<td>현황</td>
											<td>
												<input type="text" name="aForecastStatus[]" id="aForecastStatus[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastStatus[]" id="aForecastStatus[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastStatus[]" id="aForecastStatus[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastStatus[]" id="aForecastStatus[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastStatus[]" id="aForecastStatus[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastStatus[]" id="aForecastStatus[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastStatus[]" id="aForecastStatus[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastStatus[]" id="aForecastStatus[]" value="" size="14"/>
											</td>
										</tr>
										<tr>
											<td>농도</td>
											<td>
												<input type="text" name="aForecastCon[]" id="aForecastCon[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastCon[]" id="aForecastCon[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastCon[]" id="aForecastCon[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastCon[]" id="aForecastCon[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastCon[]" id="aForecastCon[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastCon[]" id="aForecastCon[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastCon[]" id="aForecastCon[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastCon[]" id="aForecastCon[]" value="" size="14"/>
											</td>
										</tr>
										<tr>
											<td>남조류</td>
											<td>
												<input type="text" name="aForecastTidal[]" id="aForecastTidal[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastTidal[]" id="aForecastTidal[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastTidal[]" id="aForecastTidal[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastTidal[]" id="aForecastTidal[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastTidal[]" id="aForecastTidal[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastTidal[]" id="aForecastTidal[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastTidal[]" id="aForecastTidal[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastTidal[]" id="aForecastTidal[]" value="" size="14"/>
											</td>
										</tr>
										<tr>
											<td colspan="2">자동</td>
											<td>
												<input type="text" name="aForecastAuto[]" id="aForecastAuto[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastAuto[]" id="aForecastAuto[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastAuto[]" id="aForecastAuto[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastAuto[]" id="aForecastAuto[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastAuto[]" id="aForecastAuto[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastAuto[]" id="aForecastAuto[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastAuto[]" id="aForecastAuto[]" value="" size="14"/>
											</td>
											<td>
												<input type="text" name="aForecastAuto[]" id="aForecastAuto[]" value="" size="14"/>
											</td>
										</tr>
									</table>
									<div style="text-align:left;">
									<p><span>* 예·경보 : 국립환경과학원 수질통합관리센터 발표자료(관심, 주의, 경계, 심각으로 구분), 단위:chl-a(㎎/㎥)</span></p>
									<span>* 자동자료는 국가수질자동측정망에서 생산한 시간 평균자료(16시) 적용</span>
									</div>
								</div>
								<br />
								<div style="text-align:left;">
									<span><b>3. 조류제거(순찰)지원 등 현황</b></span> 
								</div>
								<div>
									<table>
										<colgroup>
										<col width="100px" />
										<col />
										</colgroup>
										<tr>
											<td colspan="2"><textarea name="supportStatus" id="supportStatus" rows="3" style="width:99%;"></textarea></td>
										</tr>
										<tr class="borderNone">
											<th><label for="">파일</label></th>
											<td colspan="8" style="text-align:left;">
												<input name="file_1" id="egovComFileUploader" type="file"  style="width:500px;"/>&nbsp;&nbsp;
												<div id="egovComFileList"></div>
											</td>
										</tr>
									</table>
									<div style="text-align:left;">
									<span>* 내용이 많을 경우 별도 양식 첨부</span>
									</div>
								</div>
								<br />
								<div style="text-align:left;">
									<span><b>4. 강우현황</b></span> 
								</div>
								<div>
									<table>
										<colgroup>
											<col width="16%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
										</colgroup>
										<tr>
											<th rowspan="2">구분</th>
											<th colspan="2">한강</th>
											<th colspan="3">금강</th>
											<th colspan="2">영산강</th>
										</tr>
										<tr>
											<th>여주</th>
											<th>충주</th>
											<th>부여</th>
											<th>공주</th>
											<th>연기</th>
											<th>나주</th>
											<th>광주</th>
										</tr>
										<tr>
											<td>강수량(mm)</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R01"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="41T1006"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R01"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="43T1007"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R03"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="44T3005"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R03"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="44T3007"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R03"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="47T3091"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R04"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="46T4005"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R04"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="S04003"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
										</tr>
									</table>
									<br />
									<table>
										<colgroup>
											<col width="16%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
											<col width="12%" />
										</colgroup>
										<tr>
											<th rowspan="2">구분</th>
											<th colspan="7">낙동강</th>
										</tr>
										<tr>
											<th>부산</th>
											<th>창녕</th>
											<th>합천</th>
											<th>대구</th>
											<th>구미</th>
											<th>안동</th>
											<th>-</th>
										</tr>
										<tr>
											<td>강수량(mm)</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R02"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="26T2003"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R02"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="S02006"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R02"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="48T2020"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R02"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="S02004"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R02"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="47T2026"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R02"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="S02016"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>-</td>
										</tr>
									</table>
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
	<!-- 레이어 팝업 -->
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
	<!-- 작성권한자 레이어 팝업 -->
	<div id="layerAuthIns" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnGroInsXbox" name="btnGroInsXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerAuthIns');" alt="닫기"/>
		</div>
		<table summary="작성권한 선택"style="text-align:left;">
				<tr>
					<th scope="col">작성권한 선택</th>
				</tr>
				<tr>
					<td colspan="3" valign="top" style="padding:7px 7px 7px 100px">
						<div class="gBox" style="width:220px">
							<span class="ptit" >
								대상기관
							</span>
							<select multiple="multiple" id="dept_auth" style="padding:7px;width:220px;height:190px"></select>
						</div>
						<div style="padding-top:25px;float:left"><img src="/images/renewal/parrow.gif" alt="다음단계"/></div>
						<div class="gBox">
							<span class="ptit">
								담당자
							</span>
							<select multiple="multiple" id="person_auth" style="padding:7px;width:180px;height:190px"></select>
						</div>
						<ul class="arrbx">
							<li style="padding-top:70px;"><a href="javascript:add('auth')"><img src="<c:url value='/images/renewal/bt_arradd.gif'/>" alt="추가" /></a></li><br/>
							<li><a href="javascript:del('auth')"><img src="<c:url value='/images/renewal/bt_arrdel.gif'/>" alt="삭제" /></a></li>
						</ul>
						<div class="gBox">
							<span class="ptit">
								작성권한
							</span>
							<select multiple="multiple" id="sPerson_auth" style="padding:7px;width:180px;height:190px"></select>
						</div>
					</td>
				</tr>
			</table>
		<div id="btCarea">
			<input type="button" id="btnRegist" name="btnRegist" value="등록" class="btn btn_white" onclick="javascript:authIdInsert();" alt="등록"/>
		</div>
	</div>
</body>
</html>