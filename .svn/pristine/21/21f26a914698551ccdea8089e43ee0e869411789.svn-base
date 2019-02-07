<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<% pageContext.setAttribute("newLineChar", "\n"); %>
<%pageContext.setAttribute("crlf", "\r\n");%> 
<%
	/**
	 * Class Name  : situationRoomDetail.jsp
	 * Description : 상황실 근무일지 상세화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2014.09.25	kyr		최초 생성
	 * 
	 * author kyr
	 * since 2014.09.25
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

<script type="text/javascript">
//<![CDATA[
	$(function () {
		fnBringUpApprovalYn();		//결재상신 가능 여부 체크 하기(오전, 오후, 야간 다 입력 됐을 경우에만 결재 상신 가능)
	});
	
	function fnDelete(){
		if(confirm("삭제 하시겠습니까?")){
			$('#gubun').val('S');
			document.registform.action = "<c:url value='/dailywork/dailyWorkInfoDelete.do'/>";
			document.registform.submit();
		}
	}
	
	function fnModify(modifyGubun){
		
		if(confirm("수정 하시겠습니까?")){
			$('#modifyGubun').val(modifyGubun);	
			document.registform.action = "<c:url value='/dailywork/situationRoomModify.do'/>";
			document.registform.submit();
		}
	}
	function fnCancel(){
		
		if(confirm("근무일지를 회수하시겠습니까?")){
			$('#gubun').val('S');	
			document.registform.action = "<c:url value='/dailywork/dailyWorkInfoCancel.do'/>";
			document.registform.submit();
		}
	}
	function fnList(){
		var menuGubun = $('#menuGubun').val();
		
		if(menuGubun=='app'){
			document.registform.action = "<c:url value='/dailywork/receiveApprovalList.do'/>";
		}else{
			$('#gubun').val('S');
			document.registform.action = "<c:url value='/dailywork/dailyWorkList.do'/>";			
		}
		document.registform.submit();
	}
	
	function fnPrint(printGubun) {
		var sw=screen.width;
		var sh=screen.height;
		var winHeight = 700;
		var winWidth = 800;
		var winLeftPost = (sw - winWidth) / 2;
		var winTopPost = (sh - winHeight) / 2;
		var width = winWidth-40;
		var height = winHeight-40;
		
		var param = "dailyWorkId=${dailyWorkVO.dailyWorkId}&printGubun="+printGubun;
	
		window.open("<c:url value='/dailywork/dailyWorkPrintView_popup.do'/>?"+encodeURI(param),
		'dailyWorkPrintView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
	}
	
	function fnApp(appGubun){
		var dailyWorkId = $('#dailyWorkId').val();
		var workDay = $('#workDay').val();
		var seq = $('#approvalSeq').val();
		var msg = "";
		
		if(appGubun=='return'){
			msg = "반려"; 
		}else{
			msg = "결재"; 
		}
		if(confirm(msg+" 하시겠습니까?")){
			$('#checkDailyWorkId').val(dailyWorkId+";"+seq+";"+workDay);
			$('#appGubun').val(appGubun);
			
			if(appGubun=='return'){
				document.registform.action = "<c:url value='/dailywork/approvalReturnProc.do'/>"; 
			}else{
				document.registform.action = "<c:url value='/dailywork/approvalProc.do'/>"; 
			}
			document.registform.submit();
		}
	}
	
	function fnSave(){
		if(confirm("결재상신하시겠습니까?")){
			$('#gubun').val('S');
			document.registform.action = "<c:url value='/dailywork/insertDailyWorkApproval.do'/>";
			document.registform.submit();
		}
	}
	
	function fnBringUpApprovalYn(){
		var mId = "${situationRoomVO.mId}";
		var mContent = "${fn:replace(situationRoomVO.mContent,crlf,'<BR/>')}";
		var aId = "${situationRoomVO.aId}";
		var aContent = "${fn:replace(situationRoomVO.aContent,crlf,'<BR/>')}";
		var nId = "${situationRoomVO.nId}";
		var nContent = "${fn:replace(situationRoomVO.nContent,crlf,'<BR/>')}";
		
		// 수정 20161122 mContent mId 한개만 작성되도 결재상신 가능하도록 변경
		// if(mId !="" && mContent !="" && aId !=""&& aContent !=""&& nId !=""&& nContent !=""){
		if(mId !="" && mContent !=""){
			$("#btnApp").show();
		}else{
			$("#btnApp").hide();
		}
	}
	
	function fnHisList(){
		layerPopCloseAll();
		
		var dailyWorkId = $('#dailyWorkId').val();
		
		$.ajax({
			type:"post",
			url:"<c:url value='/dailywork/getDailyWorkHisInfoList.do'/>",
			data:{dailyWorkId:dailyWorkId
				},
			dataType:"json",
			success:function(result){
				var tot = result['hisInfoList'].length;
				var item = "";
				if(tot>0){
					for(var i=0; i< tot; i++){
						var obj = result['hisInfoList'][i];
						
						item += "<tr>"
							+"<td style='text-align:center;width:120px;'>"+obj.regName+"</td>"
							+"<td style='text-align:center;width:150px;'>"+obj.regDate+"</td>"
							+"</tr>";
					}
					$("#hisInfo").html(item);
				}else{
					$("#hisInfo").html("<tr><td  colspan='2' style='text-align:center;width:150px;'>수정이력이 없습니다.</td></tr>");
				}
			},
	        error:function(result){
					$("#hisInfo").html("<tr><td colspan='2' style='text-align:center'>서버접속 실패</td></tr>");
		        }
		});
		
		layerPopOpen('layerDailyWorkHis');
	}
	/* 모든 레이어 닫기*/
	function layerPopCloseAll() {
		layerPopClose("layerDailyWorkHis");
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
						<table style="width:420px;">
							<colgroup>
							<col width="30px" />
							<col width="120px" />
							<col width="30px" />
							<col width="120px" />
							<col width="120px" />
							</colgroup>
							<tr>
								<th rowspan="3"  style="height:120px;">기<br/>안<br/>자</th>
								<td style="height:20px;"><b><c:out value="${approvalList[0].approvalName}"></c:out></b></td>
								<th rowspan="3"  style="height:120px;">결<br/><br/>재</th>
								<td style="height:20px;"><b><c:out value="${approvalList[1].approvalName}"></c:out></b></td>
								<td><b><c:out value="${approvalList[2].approvalName}"></c:out></b></td>
							</tr>
							<tr>
								<td style="height:80px;">
								<c:if test="${not empty approvalList[0].signature_file}">
									<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
										<c:param name="atchFileId" value="${approvalList[0].signature_file}" />
									</c:import>
								</c:if>
								</td>
								<td style="height:80px;">
								<c:if test="${not empty approvalList[1].signature_file}">
									<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
										<c:param name="atchFileId" value="${approvalList[1].signature_file}" />
									</c:import>
								</c:if>
								</td>
								<td>
								<c:if test="${not empty approvalList[2].signature_file}">
									<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
										<c:param name="atchFileId" value="${approvalList[2].signature_file}" />
									</c:import>
								</c:if>
								</td>
							</tr>
							<%-- <tr>
								<td style="height:20px;"><c:out value="${dailyWorkVO.regDate}"></c:out></td>
								<td><c:out value="${approvalList[1].approvalDate}"></c:out></td>
								<td><c:out value="${approvalList[2].approvalDate}"></c:out></td>
							</tr> --%>
						</table>
					</div>	
					<!--tab Contnet Start-->
					<div class="tab_container2">
						<div class="table_wrapper">
							<form name="registform" method="post" onsubmit="return false;">
								<input type="hidden" id="dailyWorkId" name="dailyWorkId" value="<c:out value="${dailyWorkVO.dailyWorkId}"/>"/>
								<input type="hidden" id="menuGubun" name="menuGubun" value="<c:out value="${menuGubun}"/>"/>
								<input type="hidden" id="checkDailyWorkId" name="checkDailyWorkId" />
								<input type="hidden" id="workDay" name="workDay"  value="<c:out value="${dailyWorkVO.workDay}"/>"/>
								<input type="hidden" id="approvalSeq" name="approvalSeq"  value="<c:out value="${seq}"/>"/>
								<input type="hidden" id="appGubun" name="appGubun"/>
								<input type="hidden" id="modifyGubun" name="modifyGubun" />
 								<input type="hidden" id="gubun" name="gubun" value=""/> 
								
								<span style="float:left"><b>1. 일자</b> : <c:out value="${dailyWorkVO.workDay}"></c:out></span>
								<span style="padding-left:30px;float:left"><b>날씨</b> : <c:out value="${situationRoomVO.weather}"></c:out></span>
								<br />
								<div style="text-align:left;">
									<span><b></b></span> 
								</div>
								<br />
								<div style="text-align:left;">
									<span><b>2. 근무상황</b></span> 
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
											<td style="text-align:left;padding-left:10px;padding-top:5px; padding-bottom:5px;">
												근무시간 : <c:out value="${situationRoomVO.mTime}"></c:out><br />
												근무자 : <c:out value="${situationRoomVO.mId}"></c:out><br />
												작성시간 : <c:out value="${situationRoomVO.mRegDate}"></c:out>
											</td>
											<td style="text-align:left;padding-left:10px;padding-top:5px; padding-bottom:5px;">
												<c:out value="${fn:replace(situationRoomVO.mContent,crlf,'<BR/>')}" escapeXml="false"/> 
												
											</td>
										</tr>
										<tr>
											<td style="text-align:left;padding-left:10px;padding-top:5px; padding-bottom:5px;">
												근무시간 : <c:out value="${situationRoomVO.aTime}"></c:out><br />
												근무자 : <c:out value="${situationRoomVO.aId}"></c:out><br />
												작성시간 : <c:out value="${situationRoomVO.aRegDate}"></c:out>
											</td>
											<td style="text-align:left;padding-left:10px;padding-top:5px; padding-bottom:5px;">
											<!-- 
												<c:out value="${situationRoomVO.aContent}"></c:out>
											 -->
												<c:out value="${fn:replace(situationRoomVO.aContent,crlf,'<BR/>')}" escapeXml="false"/> 
											</td>
										</tr>
										<tr>
											<td style="text-align:left;padding-left:10px;padding-top:5px; padding-bottom:5px;">
												근무시간 : <c:out value="${situationRoomVO.nTime}"></c:out><br />
												근무자 : <c:out value="${situationRoomVO.nId}"></c:out><br />
												작성시간 : <c:out value="${situationRoomVO.nRegDate}"></c:out>
											</td>
											<td style="text-align:left;padding-left:10px;padding-top:5px; padding-bottom:5px;">
											<!-- 
												<c:out value="${situationRoomVO.nContent}"></c:out>
											 -->
												<c:out value="${fn:replace(situationRoomVO.nContent,crlf,'<BR/>')}" escapeXml="false"/> 
											</td>
										</tr>
										<tr>
											<th colspan="2">특이사항</th>
										</tr>
										<tr>
											<td style="text-align:left;padding-left:10px;">
												사고접수
											</td>
											<td style="text-align:left;padding-left:10px;">
												<!-- <c:out value="${situationRoomVO.accidentContent}"></c:out> -->
												<c:out value="${fn:replace(situationRoomVO.accidentContent,crlf,'<BR/>')}" escapeXml="false"/> 
											</td>
										</tr>
										<tr>
											<td style="text-align:left;padding-left:10px;">
												기타
											</td>
											<td style="text-align:left;padding-left:10px;">
												<!-- <c:out value="${situationRoomVO.etcContent}"></c:out> -->
												<c:out value="${fn:replace(situationRoomVO.etcContent,crlf,'<BR/>')}" escapeXml="false"/> 
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
											<td>사고전파</td>
											<td>
													<c:out value="${result.hour}"/>:<c:out value="${result.min}"/>
											</td>
											<td style="text-align:left;padding-left:10px;padding-top:5px; padding-bottom:5px;">
												<input type="checkbox" class="inputCheck" name="sTargetMe" id="sTtargetMe" value="Y" disabled <c:if test="${result.targetMe == 'Y'}">checked</c:if> /> 환경처
												<input type="checkbox" class="inputCheck" name="sTtargetGov" id="sTtargetGov" value="Y" disabled <c:if test="${result.targetGov == 'Y'}">checked</c:if> style="margin-left:15px;"/> 지자체 <br />
												<input type="checkbox" class="inputCheck" name="sTtargetKeco" id="sTtargetKeco" style="padding-right:3px;" value="Y" disabled <c:if test="${result.targetKeco == 'Y'}">checked</c:if>> 본사
												<input type="checkbox" class="inputCheck" name="sTargetArea" id="sTargetArea" value="Y" disabled <c:if test="${result.targetArea == 'Y'}">checked</c:if> style="margin-left:26px;"/>  <c:if test="${result.targetArea == 'Y'}"><c:out value="${result.targetAreaDetail}"/></c:if>지역본부 <br />
												<input type="checkbox" class="inputCheck" name="sTargetSigongsa" id="sTargetSigongsa" value="Y" disabled <c:if test="${result.targetSigongsa == 'Y'}">checked</c:if>> 시공사
												<input type="checkbox" class="inputCheck" name="sTargetEtc" id="sTargetEtc" value="Y" disabled <c:if test="${result.targetEtc == 'Y'}">checked</c:if> style="margin-left:15px;"/> 기타 <br />
											</td>
											<td style="text-align:left;padding-left:10px;">
												<c:out value="${fn:replace(result.content,crlf,'<BR/>')}" escapeXml="false"/>
											</td>
										</tr>
										</c:forEach>
										<c:if test="${fn:length(spreadSList) == 0}">
											<tr>
											<td>사고전파</td>
											<td></td>
											<td style="text-align:left;padding-left:10px;padding-top:5px; padding-bottom:5px;">
												<input type="checkbox" class="inputCheck" name="sTargetMe" id="sTtargetMe" value="Y" disabled <c:if test="${result.targetMe == 'Y'}">checked</c:if> /> 환경처
												<input type="checkbox" class="inputCheck" name="sTtargetGov" id="sTtargetGov" value="Y" disabled <c:if test="${result.targetGov == 'Y'}">checked</c:if> style="margin-left:15px;" /> 지자체 <br />
												<input type="checkbox" class="inputCheck" name="sTtargetKeco" id="sTtargetKeco" style="padding-right:3px;" value="Y" disabled <c:if test="${result.targetKeco == 'Y'}">checked</c:if>> 본사
												<input type="checkbox" class="inputCheck" name="sTargetArea" id="sTargetArea" value="Y" disabled <c:if test="${result.targetArea == 'Y'}">checked</c:if> style="margin-left:26px;"/>  <c:if test="${result.targetArea == 'Y'}"><c:out value="${result.targetAreaDetail}"/></c:if>지역본부 <br />
												<input type="checkbox" class="inputCheck" name="sTargetSigongsa" id="sTargetSigongsa" value="Y" disabled <c:if test="${result.targetSigongsa == 'Y'}">checked</c:if>> 시공사
												<input type="checkbox" class="inputCheck" name="sTargetEtc" id="sTargetEtc" value="Y" disabled <c:if test="${result.targetEtc == 'Y'}">checked</c:if> style="margin-left:15px;"/> 기타 <br />
											</td>
											<td></td>
										</tr>
										</c:if>
									</table>
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
											<td>기상특보</td>
											<td>
													<c:out value="${result.hour}"/>:<c:out value="${result.min}"/>
											</td>
											<td style="text-align:left;padding-left:10px;padding-top:5px; padding-bottom:5px;">
												<input type="checkbox" class="inputCheck" name="sTargetMe" id="sTtargetMe" value="Y" disabled <c:if test="${result.targetMe == 'Y'}">checked</c:if>/> 환경처
												<input type="checkbox" class="inputCheck" name="sTtargetGov" id="sTtargetGov" value="Y" disabled <c:if test="${result.targetGov == 'Y'}">checked</c:if> style="margin-left:15px;"/> 지자체 <br />
												<input type="checkbox" class="inputCheck" name="sTtargetKeco" id="sTtargetKeco" style="padding-right:3px;" value="Y" disabled <c:if test="${result.targetKeco == 'Y'}">checked</c:if>/> 본사
												<input type="checkbox" class="inputCheck" name="sTargetArea" id="sTargetArea" value="Y" disabled <c:if test="${result.targetArea == 'Y'}">checked</c:if>  style="margin-left:26px;"/>  <c:if test="${result.targetArea == 'Y'}"><c:out value="${result.targetAreaDetail}"/></c:if>지역본부 <br />
												<input type="checkbox" class="inputCheck" name="sTargetSigongsa" id="sTargetSigongsa" value="Y" disabled <c:if test="${result.targetSigongsa == 'Y'}">checked</c:if>/> 시공사
												<input type="checkbox" class="inputCheck" name="sTargetEtc" id="sTargetEtc" value="Y" disabled <c:if test="${result.targetEtc == 'Y'}">checked</c:if>  style="margin-left:15px;"/> 기타 <br />
											</td>
											<td style="text-align:left;padding-left:10px;">
												<c:out value="${fn:replace(result.content,crlf,'<BR/>')}"/>
											</td>
										</tr>
										</c:forEach>
										<c:if test="${fn:length(spreadGList) == 0}">
											<tr>
											<td>기상특보</td>
											<td></td>
											<td style="text-align:left;padding-left:10px;padding-top:5px; padding-bottom:5px;">
												<input type="checkbox" class="inputCheck" name="sTargetMe" id="sTtargetMe" value="Y" disabled <c:if test="${result.targetMe == 'Y'}">checked</c:if>/> 환경처
												<input type="checkbox" class="inputCheck" name="sTtargetGov" id="sTtargetGov" value="Y" disabled <c:if test="${result.targetGov == 'Y'}">checked</c:if>  style="margin-left:15px;"/> 지자체 <br />
												<input type="checkbox" class="inputCheck" name="sTtargetKeco" id="sTtargetKeco" style="padding-right:3px;" value="Y" disabled <c:if test="${result.targetKeco == 'Y'}">checked</c:if>/> 본사
												<input type="checkbox" class="inputCheck" name="sTargetArea" id="sTargetArea" value="Y" disabled <c:if test="${result.targetArea == 'Y'}">checked</c:if>  style="margin-left:26px;"/>  <c:if test="${result.targetArea == 'Y'}"><c:out value="${result.targetAreaDetail}"/></c:if>지역본부 <br />
												<input type="checkbox" class="inputCheck" name="sTargetSigongsa" id="sTargetSigongsa" value="Y" disabled <c:if test="${result.targetSigongsa == 'Y'}">checked</c:if>/> 시공사
												<input type="checkbox" class="inputCheck" name="sTargetEtc" id="sTargetEtc" value="Y" disabled <c:if test="${result.targetEtc == 'Y'}">checked</c:if>  style="margin-left:15px;"/> 기타 <br />
											</td>
											<td></td>
										</tr>
										</c:if>
									</table>
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
											<td><c:out value="${rainFallList[0].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[1].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[2].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[3].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[4].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[5].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[6].rainFall}"></c:out></td>
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
											<td><c:out value="${rainFallList[7].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[8].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[9].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[10].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[11].rainFall}"></c:out></td>
											<td><c:out value="${rainFallList[12].rainFall}"></c:out></td>
											<td>-</td>
										</tr>
									</table>
								</div>
								<br />
								<div>
									<table>
										<colgroup>
											<col width="16%" />
											<col />
										</colgroup>
										<c:forEach var="result" items="${approvalList}" varStatus="status">
							    			<c:if test="${result.approvalComment != null}">
												<tr>
													<th><c:out value="${result.approvalName}"></c:out> 의견</th>
													<td style="text-align:left;padding-left:10px;">
														<c:out value="${fn:replace(result.approvalComment,newLineChar,'<br/>')}"/>
													</td>
												</tr>
											</c:if>
										</c:forEach>
										<c:if test="${menuGubun == 'app'}">
											<c:if test="${appCheck=='Y'}">
											<tr>
												<th>의견</th>
												<td><textarea name="approvalComment" id="approvalComment" rows="2" style="width:98%;"></textarea></td>
											</tr>	
											</c:if>
										</c:if>
									</table>
								</div>
							</form>
							<br />
							<div>
								<c:if test="${dailyWorkVO.state == 'F'}">
									<input type="button" id="btnPrint" value="인쇄" class="btn btn_basic" style="float:right" alt="인쇄" onclick="javascript:fnPrint('S');"/>
								</c:if>
								<c:if test="${menuGubun == 'dailyWork'}">
									<c:if test="${dailyWorkVO.state == 'S' or dailyWorkVO.state == 'R'}">
									<input type="button" id="btnDelete" value="삭제" class="btn btn_basic" style="float:right" alt="삭제" onclick="javascript:fnDelete();"/>
									<input type="button" id="btnApp" value="결재상신" class="btn btn_basic" style="float:right" alt="결재상신" onclick="javascript:fnSave('app');"/>
									<input type="button" id="btnMod" value="수정" class="btn btn_basic" style="float:right" alt="수정" onclick="javascript:fnModify('m');"/>
									</c:if>
									<c:if test="${dailyWorkVO.state == 'B' or dailyWorkVO.state == 'A' or dailyWorkVO.state == 'R' or dailyWorkVO.state == 'F'}">
									<input type="button" id="btnCncl" value="회수" class="btn btn_basic" style="float:right" alt="회수" onclick="javascript:fnCancel();"/>
									</c:if>
									<input type="button" id="btnList" value="수정이력" class="btn btn_basic" style="float:right" alt="수정이력" onclick="javascript:fnHisList();"/>
									<input type="button" id="btnList" value="목록" class="btn btn_basic" style="float:right" alt="목록" onclick="javascript:fnList();"/>
								</c:if>
								<c:if test="${menuGubun == 'app'}">
									<c:if test="${appCheck=='Y'}">
									<input type="button" id="btnReturn" value="반려" class="btn btn_basic" style="float:right" alt="반려" onclick="javascript:fnApp('return');"/>
									<input type="button" id="btnApp" value="결재" class="btn btn_basic" style="float:right" alt="결재" onclick="javascript:fnApp('app');"/>
									<input type="button" id="btnMod" value="수정" class="btn btn_basic" style="float:right" alt="수정" onclick="javascript:fnModify('a');"/>
									</c:if>
							    	<input type="button" id="btnList" value="목록" class="btn btn_basic" style="float:right" alt="목록" onclick="javascript:fnList();"/>
								</c:if>
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
	<div id="layerDailyWorkHis" class="divPopup">
		<div id="xbox">
			<img src="/images/renewal/layerLogo.png" alt="한국환경공단" />
			<input type="button" id="btnBranRegXbox" name="btnBranRegXbox" value="X" class="btn btn_white" style="width:18px" onclick="javascript:layerPopClose('layerDailyWorkHis');" alt="닫기"/>
		</div>
		<table summary="수정이력정보">
			<caption>수정이력정보</caption>
			<colgroup>
				<col width="120px" />
				<col width="150px" />
				<col />
			</colgroup>
			<tbody>
				<tr>
					<th>수정자</th>
					<th>수정일</th>
				</tr>
				<tbody id="hisInfo"></tbody>
			</tbody>
		</table>
	</div>
</body>
</html>