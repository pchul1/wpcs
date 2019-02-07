<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : checkUseModifyA.jsp
	 * Description : 점검및사용일지 수정화면
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
		
		<c:set var="equipCode" value="${checkUseVO.equipCode1 }"/>
		<c:if test="${not empty checkUseVO.equipCode2 }"><c:set var="equipCode" value="${equipCode },${checkUseVO.equipCode2 }"/></c:if>
		<c:forEach items="${checkList}" var="list">
		<c:if test="${fn:indexOf(equipCode, list.EQUIP_CODE) < 0 }">
		$('[id=equip${list.EQUIP_CODE}]').find("input").attr("disabled", true);
		$('[id=equip${list.EQUIP_CODE}]').find("select").attr("disabled", true);
		</c:if>
		</c:forEach>
		<c:if test="${checkUseVO.purpose eq 'P1'}">
		$('[id^=spanUse]').find("input").attr("disabled", true);
		$('[id^=spanUse]').find("select").attr("disabled", true);
		</c:if>
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
		var workDay = "${checkUseVO.workDay}";
		workYear = workDay.substr(0,4);
		workMonth = workDay.substr(5,2);
		workDate  = workDay.substr(8,2);
		//alert(workYear + ' / ' + workMonth + ' / ' + workDate);
		var today = new Date(workMonth+"/"+workDate+"/"+workYear); 
		today = today.getFullYear()+"/"+ addzero(today.getMonth()+1) + "/" + addzero(today.getDate());
		
		$("#workDay").val(today);
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
			document.registform.action = "<c:url value='/dailywork/checkUseModProc.do'/>";
			document.registform.submit();
		}
	}
	
	function fnList(){
		var modifyGubun = $('#modifyGubun').val();
		
		if(modifyGubun=='m'){
			document.registform.action = "<c:url value='/dailywork/checkUseList.do?gubun=A'/>";
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
	
	function fn_delAttachFile(photoId) {
		if(confirm("사진을 삭제하시겠습니까?")) {
			$("#"+photoId+"Span").hide();
			$("#"+photoId+"DelYn").val("Y");
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
					<div>
						<span style="text-align:center;"><u><b><h1>궤도형운반차량/4륜오토바이/전동지게차 (점검·사용) 일지</h1></b></u></span>
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
								<td style="height:20px;"><b><span id="approvalName1"><c:out value="${approvalList[0].approvalName}"/></span></b></td>
								<td><b><span id="approvalName2"><c:out value="${approvalList[1].approvalName}"/></span></b></td>
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
							<form name="registform" method="post" enctype="multipart/form-data" onsubmit="return false;">
							<input type="hidden" id="dailyWorkId" name="dailyWorkId" value="<c:out value="${checkUseVO.checkUseId}"/>"/>
							<input type="hidden" id="checkUseId" name="checkUseId" value="<c:out value="${checkUseVO.checkUseId}"/>"/>
							<input type="hidden" id="approvalMember1" name="approvalMember1" value="<c:out value="${approvalList[0].approvalMemberId}"/>"/>
							<input type="hidden" id="approvalMember2" name="approvalMember2" value="<c:out value="${approvalList[1].approvalMemberId}"/>"/>
							<input type="hidden" id="memberAppId" name="memberAppId" value=""/>
							<input type="hidden" id="memberAuthId" name="memberAuthId"/>
							<input type="hidden" id="modGubun" name="modGubun" />
							<input type="hidden" id="modifyGubun" name="modifyGubun" value="<c:out value="${modifyGubun}"/>"/>
							<input type="hidden" id="gubun" name="gubun" value="<c:out value="${gubun}"/>"/>
							<input type="hidden" name="reportGubun" value="D1"/>
							<span style="float:left"><b>일자</b> : <input type="text" id="workDay" name="workDay" size="15"/></span>
							<span style="padding-left:30px;float:left"><b>날씨</b> : <input type="text" id="weather" name="weather" size="20" maxlength="20" value="${checkUseVO.weather }"/></span>
							<br />
							<br />
							<span id="inputD1" style="float:left;<c:if test="${empty checkUseVO.equipCode1 }">display:none</c:if>">
								<b>차량명</b> : 
								<c:forEach items="${equipList }" var="list">
									<input type="checkbox" name="equipCode1" value="${list.EQUIP_CODE}" <c:if test="${fn:indexOf(checkUseVO.equipCode1 , list.EQUIP_CODE) > -1 }">checked="checked"</c:if> onclick="showHideRows(this,this.value)"/>${list.EQUIP_NAME } &nbsp;&nbsp;
								</c:forEach>
							</span>
							<div style="text-align:left;">
								<span><b></b></span>
							</div>
							<br />
							<br />
							<span id="spanPurpose" style="float:left;">
								<b>목 적</b> : 
								<input type="radio" name="purpose" value="P1" <c:if test="${checkUseVO.purpose eq 'P1' }">checked="checked"</c:if> onclick="showHideSpanUse(this,this.value)"/>점검 &nbsp;&nbsp;
								<input type="radio" name="purpose" value="P2" <c:if test="${checkUseVO.purpose eq 'P2' }">checked="checked"</c:if> onclick="showHideSpanUse(this,this.value)"/>사용 &nbsp;&nbsp;
								<input type="radio" name="purpose" value="P3" <c:if test="${checkUseVO.purpose eq 'P3' }">checked="checked"</c:if> onclick="showHideSpanUse(this,this.value)"/>점검 및 사용
							</span>
							<div style="text-align:left;">
								<span><b></b></span> 
							</div>
							<br />
							<span id="spanUsePurpose" style="float:left;padding-left:50px;<c:if test="${checkUseVO.purpose eq 'P1' }">display:none</c:if>">
								<b>사용목적</b> : 
								<select name="usePurpose">
									<option value="">선택하세요</option>
									<option value="U1"<c:if test="${checkUseVO.usePurpose eq 'U1' }"> selected="selected"</c:if>>순찰</option>
									<option value="U2"<c:if test="${checkUseVO.usePurpose eq 'U2' }"> selected="selected"</c:if>>방제지원</option>
									<option value="U3"<c:if test="${checkUseVO.usePurpose eq 'U3' }"> selected="selected"</c:if>>훈련</option>
									<option value="U4"<c:if test="${checkUseVO.usePurpose eq 'U4' }"> selected="selected"</c:if>>지원</option>
									<option value="U5"<c:if test="${checkUseVO.usePurpose eq 'U5' }"> selected="selected"</c:if>>기타</option>
								</select>
							</span>
							<span id="spanUsePlace" style="padding-left:30px;float:left;<c:if test="${checkUseVO.purpose eq 'P1' }">display:none</c:if>"><b>사용처</b> : <input type="text" id="usePlace" name="usePlace" size="50" value="${checkUseVO.usePlace }"/></span>
							<br/>
							<div style="text-align:left;">
								<span><b></b></span> 
							</div>
							<br/>
							<span id="spanUseFuelInject" style="float:left;<c:if test="${checkUseVO.purpose eq 'P1' }">display:none</c:if>">
								<b>연료주입</b> : <input type="text" id="fuelInject" name="fuelInject" size="15" value="${checkUseVO.fuelInject }"/>
							</span>
							<br/>
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
									<c:set var="gubunCode" value=""/>
									<c:set var="equipCode" value="${checkUseVO.equipCode1 }"/>
									<c:if test="${not empty checkUseVO.equipCode2 }"><c:set var="equipCode" value="${equipCode },${checkUseVO.equipCode2 }"/></c:if>
									<c:forEach items="${checkList }" var="list">
									<tr id="equip${list.EQUIP_CODE }"<c:if test="${fn:indexOf(equipCode, list.EQUIP_CODE) < 0 }"> style="display:none"</c:if>>
										<input type="hidden" name="gubunCode" value="${list.EQUIP_CODE }"/>
										<input type="hidden" name="checkCode" value="${list.CHECK_CODE }"/>
										<input type="hidden" name="detailId" value="${list.DETAIL_ID }"/>
										<c:if test="${gubunCode ne list.EQUIP_CODE }">
										<td rowspan="${list.ROWSPAN }">${list.GUBUN_NAME }<br/>(${list.EQUIP_NAME })</td>
										</c:if>
										<c:set var="gubunCode" value="${list.EQUIP_CODE }"/>
										<td style="text-align:left;padding-left:5px;">${list.CHECK_ITEM }</td>
										<td style="text-align:left;padding-left:10px;">
											<select name="checkResult">
												<!--<option value="">선택</option>-->
												<option value="O"<c:if test="${list.CHECK_RESULT eq 'O' }"> selected="selected"</c:if>>양호</option>
												<option value="X"<c:if test="${list.CHECK_RESULT eq 'X' }"> selected="selected"</c:if>>이상</option>
												<option value="N"<c:if test="${list.CHECK_RESULT eq 'N' }"> selected="selected"</c:if>>해당없음</option>
											</select>
										</td>
										<td><input type="text" name="note" id="note" value="${list.NOTE }" size="54"/></td>
										<!-- <td><input type="file" name="fileArr"/></td> -->
									</tr>
									</c:forEach>
								</table>
							</div>
							<br />
							<div style="text-align:left;">
								<span><b>특이사항</b></span>
								<br/>
								<textarea name="issueComment" id="issueComment" rows="3" style="width:98%;">${checkUseVO.issueComment }</textarea> 
							</div>
							<br />
							<span style="float:left"><b>인 원</b> : <input type="text" name="persons" size="15" value="${checkUseVO.persons }"/> 명</span>
							<span style="padding-left:30px;float:left"><b>참여자</b> : <input type="text" id="participant" name="participant" size="50" maxlength="100" value="${checkUseVO.participant }"/></span>
							<br/>
							<div style="text-align:left;">
								<span><b></b></span> 
							</div>
							<br />
							<div style="text-align:left;">
								<span><b>사진대지</b></span>
								<br/>
								<c:if test="${not empty checkUseVO.photo1Id}">
									<span id="photo1IdSpan">
									<c:import url="/cmmn/selectCheckUseImageFile.do" charEncoding="utf-8">
										<c:param name="atchFileId" value="${checkUseVO.photo1Id}" />
									</c:import>
									<input type="button" class="btn btn_basic" value="사진삭제" onclick="fn_delAttachFile('photo1Id')" style="float:right"/>
									</span>
									<input type="hidden" name="photo1Id" value="${checkUseVO.photo1Id}"/>
									<input type="hidden" name="photo1IdDelYn" id="photo1IdDelYn" value="N"/>
									<b>사진수정 :</b> 
								</c:if>
								<input type="file" name="file1" size="150"/><br/>
								<c:if test="${not empty checkUseVO.photo2Id}">
									<span id="photo2IdSpan">
									<c:import url="/cmmn/selectCheckUseImageFile.do" charEncoding="utf-8">
										<c:param name="atchFileId" value="${checkUseVO.photo2Id}" />
									</c:import>
									<input type="button" class="btn btn_basic" value="사진삭제" onclick="fn_delAttachFile('photo2Id')" style="float:right"/>
									</span>
									<input type="hidden" name="photo2Id" value="${checkUseVO.photo2Id}"/>
									<input type="hidden" name="photo2IdDelYn" id="photo2IdDelYn" value="N"/>
									<b>사진수정 :</b>
								</c:if>
								<input type="file" name="file2" size="150"/><br/>
								<c:if test="${not empty checkUseVO.photo3Id}">
									<span id="photo3IdSpan">
									<c:import url="/cmmn/selectCheckUseImageFile.do" charEncoding="utf-8">
										<c:param name="atchFileId" value="${checkUseVO.photo3Id}" />
									</c:import>
									<input type="button" class="btn btn_basic" value="사진삭제" onclick="fn_delAttachFile('photo3Id')" style="float:right"/>
									</span>
									<input type="hidden" name="photo3Id" value="${checkUseVO.photo3Id}"/>
									<input type="hidden" name="photo3IdDelYn" id="photo3IdDelYn" value="N"/>
									<b>사진수정 :</b>
								</c:if>
								<input type="file" name="file3" size="150"/><br/>  
							</div>
							<br/>
							<div style="text-align:left;">
								<span><b>설 명</b></span>
								<br/>
								<textarea name="exprComment" id="exprComment" rows="3" style="width:98%;">${checkUseVO.exprComment }</textarea> 
							</div>
						<div style="padding-top:10px;">
							<input type="button" id="btnSave" value="저장" class="btn btn_basic" style="float:right" alt="저장" onclick="javascript:fnSave('mod');"/>
							<c:if test="${modifyGubun == 'm'}">
							<input type="button" id="btnApp" value="결재상신" class="btn btn_basic" style="float:right" alt="결재상신" onclick="javascript:fnSave('app');"/>
							</c:if>
							<input type="button" id="btnList" value="목록" class="btn btn_basic" style="float:right" alt="목록" onclick="javascript:fnList();"/>
						</div>
						</form>
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