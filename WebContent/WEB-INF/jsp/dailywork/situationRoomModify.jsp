<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : situationRoomModify.jsp
	 * Description : 상황실 근무일지 수정화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2014.09.26	kyr		최초 생성
	 * 
	 * author kyr
	 * since 2014.09.26
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
// 		setTime();
		
		$("#dept_app").change(function(){
			setPerson('app'); //직원셋팅
		});
		
		$("#dept_auth").change(function(){
			setPerson('auth'); //직원셋팅
		});
		
		setDept('app');		//부서셋팅
		setDept('auth');		//부서셋팅
		
		fnBringUpApprovalYn();		//결재상신 가능 여부 체크 하기(오전, 오후, 야간 다 입력 됐을 경우에만 결재 상신 가능)
	});
    
  	function setTime(){
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

	function AddRows(gubun, act) {
		var TABLE = $("#"+gubun+" tbody"), LASTROW = TABLE.find("tr:last-child");
		
		var rowCount = $('#'+gubun+' tr').length;
		
		if(act == 'remove'){
			if(rowCount<3){
				alert("기본항목은 삭제 할 수 없습니다.");
				return false;
			}else{
				LASTROW.remove()
			}
		}else{
			TABLE.append(LASTROW.clone()) 
		}
	}
	
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerApprovalIns");
		layerPopClose("layerAuthIns");
	}
	
	function fnSave(modGubun){
		fnTargetCheck();
		
		var workDay	= $('#workDay').val();
		
		if(workDay == "") {
			alert("일자를 입력해 주십시요.");
			$("#workDay").focus();
			return false;
		}
		
		$('#modGubun').val(modGubun);
		
		var msg = "";
		
		if(modGubun=="app"){
			msg = "결재상신하시겠습니까?";
		}else{
			msg = "저장 하시겠습니까?";
		}
		if(confirm(msg)){
			document.registform.action = "<c:url value='/dailywork/situationRoomModProc.do'/>";
			document.registform.submit();
		}
	}
	
	function fnList(){
		var modifyGubun = $('#modifyGubun').val();
		
		if(modifyGubun=='m'){
			document.registform.action = "<c:url value='/dailywork/dailyWorkList.do?gubun=S'/>";
		}else{
			document.registform.action = "<c:url value='/dailywork/receiveApprovalList.do'/>";
		}
		document.registform.submit();
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
		
		/* if(cnt_app != 2 ){
			alert("결재자는 2명을 선택하여 주십시오.");
			return false;
		} */

		if(cnt_app > 2 ){
			alert("결재자는 2명까지 선택하여 주십시오.");
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
	
	function fnBringUpApprovalYn(){
		var mId = $('#mId').val();
		var mContent = $('#mContent').val();
		var aId = $('#aId').val();
		var aContent = $('#aContent').val();
		var nId = $('#nId').val();
		var nContent = $('#nContent').val();
		
		if((mId !="" && mContent !="") || (aId !=""&& aContent !="") || (nId !=""&& nContent !="")){
			$("#btnApp").show();
		}else{
			$("#btnApp").hide();
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
					<div >
						<span style="text-align:center;"><u><b><h1>상황실 근무일지</h1></b></u></span>
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
								<td style="height:20px;"><b><span id="approvalName1"><c:out value="${approvalList[1].approvalName}"></c:out></span></b></td>
								<td><b><span id="approvalName2"><c:out value="${approvalList[2].approvalName}"></c:out></span></b></td>
							</tr>
							<tr>
								<td style="height:80px;"></td>
								<td></td>
							</tr>
						</table>
						<c:if test="${modifyGubun == 'm'}">
						<div style="padding-top:10px;">
							<input type="button" id="btnAppPopup" value="결재라인변경" class="btn btn_basic" style="float:right" alt="결재라인변경" onclick="javascript:layerPopOpen('layerApprovalIns')"/>
						</div>
						</c:if>
					</div>	
					<!--tab Contnet Start-->
					<div class="tab_container2">
						<div class="table_wrapper">
							<form name="registform" method="post" onsubmit="return false;">
								<input type="hidden" id="dailyWorkId" name="dailyWorkId" value="<c:out value="${dailyWorkVO.dailyWorkId}"/>"/>
								<input type="hidden" id="approvalMember1" name="approvalMember1" value="<c:out value="${approvalList[1].approvalMemberId}"/>"/>
								<input type="hidden" id="approvalMember2" name="approvalMember2" value="<c:out value="${approvalList[2].approvalMemberId}"/>"/>
								<input type="hidden" id="memberAppId" name="memberAppId" value=""/>
								<input type="hidden" id="memberAuthId" name="memberAuthId"/>
								<input type="hidden" id="sId" name="sId" value="<c:out value="${situationRoomVO.sId}"/>"/>
								<input type="hidden" id="modGubun" name="modGubun" />
								<input type="hidden" id="modifyGubun" name="modifyGubun" value="<c:out value="${modifyGubun}"/>"/>
								
								<span style="float:left"><b>1. 일자</b> : <input type="hidden" id="workDay" name="workDay" size="15" value="<c:out value="${dailyWorkVO.workDay}"></c:out>"/><c:out value="${dailyWorkVO.workDay}"></c:out></span>
								<span style="padding-left:30px;float:left"><b>날씨</b> : <input type="text" id="weather" name="weather" size="20" value="<c:out value="${situationRoomVO.weather}"></c:out>"/></span>
								<br />
								<div style="text-align:left;">
									<span><b></b></span> 
								</div>
								<br />
								<div style="text-align:left;padding-bottom:5px;">
									<span><b>2. 근무상황</b></span><c:if test="${modifyGubun == 'm'}"><span><input type="button" id="btnAuthPopup" value="작성권한변경" class="btn btn_basic" alt="작성권한변경" onclick="javascript:layerPopOpen('layerAuthIns');"/></span></c:if>
								</div>
								<div>
									<table>
										<colgroup>
											<col width="224px" />
											<col />
										</colgroup>
										<tr>
											<th>구분</th>
											<th>내용</th>
										</tr>
										<tr>
											<td style="text-align:left;padding-left:10px;">
												근무시간 : <input type="text" name="mTime" id="mTime" value="<c:out value="${situationRoomVO.mTime}"></c:out>" style="width:110px;"> <br />
												<span style="padding-right:11px;">근무자 :</span> <c:out value="${situationRoomVO.mId}"/> <input type="hidden" name="mId" id="mId" value="<c:out value="${situationRoomVO.mId}"/>"/>
											</td>
											<td>
												<textarea name="mContent" id="mContent" rows="2" style="width:98%;" onkeyup="fnBringUpApprovalYn()" onkeypress="fnBringUpApprovalYn()"><c:out value="${situationRoomVO.mContent}"></c:out></textarea>
											</td>
										</tr>
										<tr>
											<td style="text-align:left;padding-left:10px;">
												근무시간 : <input type="text" name="aTime" id="aTime" value="<c:out value="${situationRoomVO.aTime}"/>" style="width:110px;"> <br />
												<span style="padding-right:11px;">근무자 :</span> <sec:authentication property="principal.userVO.name"/> <input type="hidden" name="aId" id="aId" value="<sec:authentication property="principal.userVO.name"/>"/>
											</td>
											<td>
												<textarea name="aContent" id="aContent" rows="2" style="width:98%;"  onkeyup="fnBringUpApprovalYn()" onkeypress="fnBringUpApprovalYn()"><c:out value="${situationRoomVO.aContent}"></c:out></textarea>
											</td>
										</tr>
										<tr>
											<td style="text-align:left;padding-left:10px;">
												근무시간 : <input type="text" name="nTime" id="nTime" value="<c:out value="${situationRoomVO.nTime}"></c:out>" style="width:110px;"> <br />
												<span style="padding-right:11px;">근무자 :</span>  <input type="text" name="nId" id="nId" style="width:110px;" value="<c:out value="${situationRoomVO.nId}"></c:out>"  onkeyup="fnBringUpApprovalYn()" onkeypress="fnBringUpApprovalYn()"/>
											</td>
											<td>
												<textarea name="nContent" id="nContent" rows="2" style="width:98%;"  onkeyup="fnBringUpApprovalYn()" onkeypress="fnBringUpApprovalYn()"><c:out value="${situationRoomVO.nContent}"></c:out></textarea>
											</td>
										</tr>
										<tr>
											<th colspan="2">특이사항</th>
										</tr>
										<tr>
											<td style="text-align:left;padding-left:10px;">
												사고접수
											</td>
											<td>
												<textarea name="accidentContent" id="accidentContent" rows="2" style="width:98%;"><c:out value="${situationRoomVO.accidentContent}"></c:out></textarea>
											</td>
										</tr>
										<tr>
											<td style="text-align:left;padding-left:10px;">
												기타
											</td>
											<td>
												<textarea name="etcContent" id="etcContent" rows="2" style="width:98%;"><c:out value="${situationRoomVO.etcContent}"></c:out></textarea>
											</td>
										</tr>
									</table>
								</div>
								<br />
								<div style="text-align:left;">
									<span><b>3. 상황전파 현황</b></span> 
								</div>
								<div>
									<table id="accidentTable">
										<colgroup>
											<col width="110px" />
											<col width="115px" />
											<col width="220px" />
											<col />
										</colgroup>
										<tr>
											<th>구분</th>
											<th>시간</th>
											<th>대상</th>
											<th>내용</th>
										</tr>
										<c:forEach var="result" items="${spreadSList}" varStatus="status">
										<tr>
											<td>사고전파<input type="hidden" name="sGubun[]" id="sGubun" value="S"></td>
											<td>
												<select id="sHour" name="sHour[]" >
													<option value=''>선택</option>
													<c:forEach var="item" varStatus="i" begin="0" end="24" step="1">
													<c:if test="${item < 10}"><c:set var="temp" value="0${item}" /></c:if>
													<c:if test="${item >= 10}"><c:set var="temp" value="${item}" /></c:if>
												    <option value="${temp}" <c:if test="${temp == result.hour}">selected="selected"</c:if>>
												    <c:out value="${temp}" />
												    </option>
												    </c:forEach>
												</select>:
												<select id="sMin" name="sMin[]" >
													<option value=''>선택</option>
													<c:forEach var="item" varStatus="i" begin="0" end="60" step="1">
													<c:if test="${item < 10}"><c:set var="temp" value="0${item}" /></c:if>
													<c:if test="${item >= 10}"><c:set var="temp" value="${item}" /></c:if>
												    <option value="${temp}" <c:if test="${temp == result.min}">selected="selected"</c:if>>
												    <c:out value="${temp}" />
												    </option>
												    </c:forEach>
												</select>
											</td>
											<td style="text-align:left;padding-left:10px;">
												<input type="hidden" name="sTargetMe[]" id="sTargetMe[]" value="N"/>
												<input type="hidden" name="sTargetGov[]" id="sTargetGov[]" value="N"/>
												<input type="hidden" name="sTargetKeco[]" id="sTargetKeco[]" value="N"/>
												<input type="hidden" name="sTargetArea[]" id="sTargetArea[]" value="N"/>
												<input type="hidden" name="sTargetSigongsa[]" id="sTargetSigongsa[]" value="N"/>
												<input type="hidden" name="sTargetEtc[]" id="sTargetEtc[]" value="N"/>
												
												<input type="checkbox" class="inputCheck" name="sChkMe[]" id="sChkMe[]" value="me" <c:if test="${result.targetMe == 'Y'}">checked</c:if>/> 환경청
												<input type="checkbox" class="inputCheck" name="sChkGov[]" id="sChkGov[]" value="gov" <c:if test="${result.targetGov == 'Y'}">checked</c:if> style="margin-left:15px;"/> 지자체 <br />
												<input type="checkbox" class="inputCheck" name="sChkKeco[]" id="sChkKeco[]" style="padding-right:3px;" value="keco" <c:if test="${result.targetKeco == 'Y'}">checked</c:if>/> 본사
												<input type="checkbox" class="inputCheck" name="sChkArea[]" id="sChkArea[]" value="area" <c:if test="${result.targetArea == 'Y'}">checked</c:if> style="margin-left:26px;"/> <input type="text" name="sTargetAreaDetail[]" id="sTargetAreaDetail[]" size="7" value="<c:if test="${result.targetArea == 'Y'}"><c:out value="${result.targetAreaDetail}"/></c:if>">지역본부 <br />
												<input type="checkbox" class="inputCheck" name="sChkSigongsa[]" id="sChkSigongsa[]" value="si" <c:if test="${result.targetSigongsa == 'Y'}">checked</c:if>/> 시공사
												<input type="checkbox" class="inputCheck" name="sChkEtc[]" id="sChkEtc[]"  value="etc" <c:if test="${result.targetEtc == 'Y'}">checked</c:if> style="margin-left:15px;"/> 기타 <br />
											</td>
											<td>
												<textarea name="sContent[]" id="sContent[]" rows="3" style="width:98%;"><c:out value="${result.content}"/></textarea>
											</td>
										</tr>
										</c:forEach>
										<c:if test="${fn:length(spreadSList) == 0}">
										<tr>
											<td>사고전파<input type="hidden" name="sGubun[]" id="sGubun" value="S"></td>
											<td>
												<select id="sHour" name="sHour[]" >
													<option value=''>선택</option>
													<c:forEach var="item" varStatus="i" begin="0" end="24" step="1">
												    <option value="${item}" <c:if test="${item == result.hour}">selected="selected"</c:if>>
												    <c:if test="${item < 10}">0</c:if><c:out value="${item}" />
												    </option>
												    </c:forEach>
												</select>:
												<select id="sMin" name="sMin[]" >
													<option value=''>선택</option>
													<c:forEach var="item" varStatus="i" begin="0" end="60" step="1">
												    <option value="${item}" <c:if test="${item == result.min}">selected="selected"</c:if>>
												    <c:if test="${item < 10}">0</c:if><c:out value="${item}" />
												    </option>
												    </c:forEach>
												</select>
											</td>
											<td style="text-align:left;padding-left:10px;">
												<input type="hidden" name="sTargetMe[]" id="sTargetMe[]" value="N"/>
												<input type="hidden" name="sTargetGov[]" id="sTargetGov[]" value="N"/>
												<input type="hidden" name="sTargetKeco[]" id="sTargetKeco[]" value="N"/>
												<input type="hidden" name="sTargetArea[]" id="sTargetArea[]" value="N"/>
												<input type="hidden" name="sTargetSigongsa[]" id="sTargetSigongsa[]" value="N"/>
												<input type="hidden" name="sTargetEtc[]" id="sTargetEtc[]" value="N"/>
												
												<input type="checkbox" class="inputCheck" name="sChkMe[]" id="sChkMe[]" value="me"/> 환경처
												<input type="checkbox" class="inputCheck" name="sChkGov[]" id="sChkGov[]" value="gov" style="margin-left:15px;"/> 지자체 <br />
												<input type="checkbox" class="inputCheck" name="sChkKeco[]" id="sChkKeco[]" style="padding-right:3px;" value="keco"/> 본사
												<input type="checkbox" class="inputCheck" name="sChkArea[]" id="sChkArea[]" value="area" style="margin-left:26px;"/> <input type="text" name="sTargetAreaDetail[]" id="sTargetAreaDetail[]" size="7" value=""/>지역본부 <br />
												<input type="checkbox" class="inputCheck" name="sChkSigongsa[]" id="sChkSigongsa[]" value="si"/> 시공사
												<input type="checkbox" class="inputCheck" name="sChkEtc[]" id="sChkEtc[]"  value="etc" style="margin-left:15px;"/> 기타 <br />
											</td>
											<td>
												<textarea name="sContent[]" id="sContent[]" rows="3" style="width:98%;"></textarea>
											</td>
										</tr>
										</c:if>
									</table>
									<div style="padding-top:10px;">
										<input type="button" id="btnDelete" value="삭제" class="btn btn_basic" style="float:right" alt="삭제" onclick="javascript:AddRows('accidentTable', 'remove');"/>
										<input type="button" id="btnAdd" value="추가" class="btn btn_basic" style="float:right" alt="추가" onclick="javascript:AddRows('accidentTable', 'add');"/>
									</div>
								</div>
								<br />
								<br />
								<div>
									<table id="weatherTable">
										<colgroup>
											<col width="110px" />
											<col width="115px" />
											<col width="220px" />
											<col />
										</colgroup>
										<tr>
											<th>구분</th>
											<th>시간</th>
											<th>대상</th>
											<th>내용</th>
										</tr>
										<c:forEach var="result" items="${spreadGList}" varStatus="status">
										<tr>
											<td>기상특보<input type="hidden" name="gGubun[]" id="gGubun" value="G"></td>
											<td>
												<select id="gHour" name="gHour[]" >
													<option value=''>선택</option>
													<c:forEach var="item" varStatus="i" begin="0" end="24" step="1">
													<c:if test="${item < 10}"><c:set var="temp" value="0${item}" /></c:if>
													<c:if test="${item >= 10}"><c:set var="temp" value="${item}" /></c:if>
												    <option value="${temp}" <c:if test="${temp == result.hour}">selected="selected"</c:if>>
												    <c:out value="${temp}" />
												    </option>
												    </c:forEach>
												</select>:
												<select id="gMin" name="gMin[]" >
													<option value=''>선택</option>
													<c:forEach var="item" varStatus="i" begin="0" end="60" step="1">
													<c:if test="${item < 10}"><c:set var="temp" value="0${item}" /></c:if>
													<c:if test="${item >= 10}"><c:set var="temp" value="${item}" /></c:if>
												    <option value="${temp}" <c:if test="${temp == result.min}">selected="selected"</c:if>>
												    <c:out value="${temp}" />
												    </option>
												    </c:forEach>
												</select>
											</td>
											<td style="text-align:left;padding-left:10px;">
												<input type="hidden" name="gTargetMe[]" id="gTargetMe[]" value="N"/>
												<input type="hidden" name="gTargetGov[]" id="gTargetGov[]" value="N"/>
												<input type="hidden" name="gTargetKeco[]" id="gTargetKeco[]" value="N"/>
												<input type="hidden" name="gTargetArea[]" id="gTargetArea[]" value="N"/>
												<input type="hidden" name="gTargetSigongsa[]" id="gTargetSigongsa[]" value="N"/>
												<input type="hidden" name="gTargetEtc[]" id="gTargetEtc[]" value="N"/>
												
												<input type="checkbox" class="inputCheck" name="gChkMe[]" id="gChkMe[]" value="me" <c:if test="${result.targetMe == 'Y'}">checked</c:if>/> 환경청
												<input type="checkbox" class="inputCheck" name="gChkGov[]" id="gChkGov[]" value="gov" <c:if test="${result.targetGov == 'Y'}">checked</c:if> style="margin-left:15px;"/> 지자체 <br />
												<input type="checkbox" class="inputCheck" name="gChkKeco[]" id="gChkKeco[]" style="padding-right:3px;" value="keco" <c:if test="${result.targetKeco == 'Y'}">checked</c:if>/> 본사
												<input type="checkbox" class="inputCheck" name="gChkArea[]" id="gChkArea[]" value="area" <c:if test="${result.targetArea == 'Y'}">checked</c:if> style="margin-left:26px;"/> <input type="text" name="gTargetAreaDetail[]" id="gTargetAreaDetail[]" size="7" value="<c:if test="${result.targetArea == 'Y'}"><c:out value="${result.targetAreaDetail}"/></c:if>">지역본부 <br />
												<input type="checkbox" class="inputCheck" name="gChkSigongsa[]" id="gChkSigongsa[]" value="si" <c:if test="${result.targetSigongsa == 'Y'}">checked</c:if>/> 시공사
												<input type="checkbox" class="inputCheck" name="gChkEtc[]" id="gChkEtc[]"  value="etc" <c:if test="${result.targetEtc == 'Y'}">checked</c:if> style="margin-left:15px;"/> 기타 <br />
											</td>
											<td>
												<textarea name="gContent[]" id="gContent[]" rows="3" style="width:98%;"><c:out value="${result.content}"/></textarea>
											</td>
										</tr>
										</c:forEach>
										<c:if test="${fn:length(spreadGList) == 0}">
										<tr>
											<td>기상특보<input type="hidden" name="gGubun[]" id="gGubun" value="G"></td>
											<td>
												<select id="gHour" name="gHour[]" >
													<option value=''>선택</option>
													<c:forEach var="item" varStatus="i" begin="0" end="24" step="1">
												    <option value="${item}" <c:if test="${item == result.hour}">selected="selected"</c:if>>
												    <c:if test="${item < 10}">0</c:if><c:out value="${item}" />
												    </option>
												    </c:forEach>
												</select>:
												<select id="gMin" name="gMin[]" >
													<option value=''>선택</option>
													<c:forEach var="item" varStatus="i" begin="0" end="60" step="1">
												    <option value="${item}" <c:if test="${item == result.min}">selected="selected"</c:if>>
												    <c:if test="${item < 10}">0</c:if><c:out value="${item}" />
												    </option>
												    </c:forEach>
												</select>
											</td>
											<td style="text-align:left;padding-left:10px;">
												<input type="hidden" name="gTargetMe[]" id="gTargetMe[]" value="N"/>
												<input type="hidden" name="gTargetGov[]" id="gTargetGov[]" value="N"/>
												<input type="hidden" name="gTargetKeco[]" id="gTargetKeco[]" value="N"/>
												<input type="hidden" name="gTargetArea[]" id="gTargetArea[]" value="N"/>
												<input type="hidden" name="gTargetSigongsa[]" id="gTargetSigongsa[]" value="N"/>
												<input type="hidden" name="gTargetEtc[]" id="gTargetEtc[]" value="N"/>
												
												<input type="checkbox" class="inputCheck" name="gChkMe[]" id="gChkMe[]" value="me"/> 환경처
												<input type="checkbox" class="inputCheck" name="gChkGov[]" id="gChkGov[]" value="gov" style="margin-left:15px;"/> 지자체 <br />
												<input type="checkbox" class="inputCheck" name="gChkKeco[]" id="gChkKeco[]" style="padding-right:3px;" value="keco"/> 본사
												<input type="checkbox" class="inputCheck" name="gChkArea[]" id="gChkArea[]" value="area" style="margin-left:26px;"/> <input type="text" name="gTargetAreaDetail[]" id="gTargetAreaDetail[]" size="7" value=""/>지역본부 <br />
												<input type="checkbox" class="inputCheck" name="gChkSigongsa[]" id="gChkSigongsa[]" value="si"/> 시공사
												<input type="checkbox" class="inputCheck" name="gChkEtc[]" id="gChkEtc[]"  value="etc" style="margin-left:15px;"/> 기타 <br />
											</td>
											<td>
												<textarea name="gContent[]" id="gContent[]" rows="3" style="width:98%;"></textarea>
											</td>
										</tr>
										</c:if>
									</table>
									<div style="padding-top:10px;">
										<input type="button" id="btnDelete" value="삭제" class="btn btn_basic" style="float:right" alt="삭제" onclick="javascript:AddRows('weatherTable', 'remove');"/>
										<input type="button" id="btnAdd" value="추가" class="btn btn_basic" style="float:right" alt="추가" onclick="javascript:AddRows('weatherTable', 'add');"/>
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
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="<c:out value="${rainFallList[0].rainFall}"></c:out>" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R01"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="43T1007"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="<c:out value="${rainFallList[1].rainFall}"></c:out>" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R03"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="44T3005"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="<c:out value="${rainFallList[2].rainFall}"></c:out>" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R03"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="44T3007"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="<c:out value="${rainFallList[3].rainFall}"></c:out>" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R03"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="47T3091"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="<c:out value="${rainFallList[4].rainFall}"></c:out>" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R04"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="46T4005"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="<c:out value="${rainFallList[5].rainFall}"></c:out>" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R04"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="S04003"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="<c:out value="${rainFallList[6].rainFall}"></c:out>" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
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
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="<c:out value="${rainFallList[7].rainFall}"></c:out>" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R02"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="S02006"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="<c:out value="${rainFallList[8].rainFall}"></c:out>" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R02"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="48T2020"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="<c:out value="${rainFallList[9].rainFall}"></c:out>" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R02"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="S02004"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="<c:out value="${rainFallList[10].rainFall}"></c:out>" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R02"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="47T2026"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="<c:out value="${rainFallList[11].rainFall}"></c:out>" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>
												<input type="hidden" name="tRiverDiv[]" id="tRiverDiv[]" value="R02"/>
												<input type="hidden" name="tFactCode[]" id="tFactCode[]" value="S02016"/>
												<input type="text" name="tRainFall[]" id="tRainFall[]" value="<c:out value="${rainFallList[12].rainFall}"></c:out>" size="14" onkeyup="only_num_point(this)" onkeypress="only_num_point(this)"/>
											</td>
											<td>-</td>
										</tr>
									</table>
								</div>
							</form>
							<div style="padding-top:10px;">
								<input type="button" id="btnSave" value="저장" class="btn btn_basic" style="float:right" alt="저장" onclick="javascript:fnSave('mod');"/>
								<c:if test="${modifyGubun == 'm'}">
								<input type="button" id="btnApp" value="결재상신" class="btn btn_basic" style="float:right" alt="결재상신" onclick="javascript:fnSave('app');"/>
								</c:if>
								<input type="button" id="btnList" value="목록" class="btn btn_basic" style="float:right" alt="목록" onclick="javascript:fnList();"/>
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