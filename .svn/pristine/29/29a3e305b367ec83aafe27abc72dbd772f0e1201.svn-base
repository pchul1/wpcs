<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : situationRoomPrintView.jsp
	 * Description : 상황실 근무일지(인쇄) 화면
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2014.10.02	kyr			최초생성
	 * 
	 * author kyr
	 * since 2014.10.02
	 * 
	 * Copyright (C) 2010 by k All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<title>상황발생이력</title>
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/jquery.form.js'/>"></script>
	<script type="text/javascript">
		function fnPrint(){
			$('#btnPrint').hide();
			window.print();
			window.close();
		}
	</script>
</head>

<body class="pop_basic" style="overflow-X:hidden">
	<div style="margin-top:20px; margin-bottom:20px;">
		<span style="text-align:center;font-size: 20px;"><u><b><h1>상황실 근무일지</h1></b></u></span>
		<div style="float:right;padding-left:500px;padding-right:16px; padding-top:20px;">
			<table class="dataTable4">
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
					<td style="height:20px;"><c:out value="${dailyWorkVO.workDay}"></c:out></td>
					<td style="height:20px;"><c:out value="${approvalList[0].approvalDate}"></c:out></td>
					<td><c:out value="${approvalList[1].approvalDate}"></c:out></td>
				</tr> --%>
			</table>
		</div>
		<div style="margin-top:160px;">
			<div style="padding-bottom:10px;"> 
				<span style="float:left;padding-left:10px;"><b>1. 일자</b> : <c:out value="${dailyWorkVO.workDay}"></c:out></span>
				<span style="padding-left:30px;float:left"><b>날씨</b> : <c:out value="${situationRoomVO.weather}"></c:out></span>
			</div>
			<br />
			<div style="padding-bottom:10px;padding-top:10px;">
		    <span style="float:left;padding-left:10px;"><b>2. 근무상황</b></span>
		    </div>
		    <div  style="padding-left:10px;padding-top:10px;">
			<table  class="dataTable5">
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
						근무시간 :<c:out value="${situationRoomVO.mTime}"></c:out><br />
						근무자 :<c:out value="${situationRoomVO.mId}"></c:out>
					</td>
					<td style="text-align:left;padding-left:10px;">
						<c:out value="${situationRoomVO.mContent}"></c:out>
					</td>
				</tr>
				<tr>
					<td style="text-align:left;padding-left:10px;">
						근무시간 :<c:out value="${situationRoomVO.aTime}"></c:out><br />
						근무자 : <c:out value="${situationRoomVO.aId}"></c:out>
					</td>
					<td style="text-align:left;padding-left:10px;">
						<c:out value="${situationRoomVO.aContent}"></c:out>
					</td>
				</tr>
				<tr>
					<td style="text-align:left;padding-left:10px;">
						근무시간 :<c:out value="${situationRoomVO.nTime}"></c:out><br />
						근무자 : <c:out value="${situationRoomVO.nId}"></c:out>
					</td>
					<td style="text-align:left;padding-left:10px;">
						<c:out value="${situationRoomVO.nContent}"></c:out>
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
						<c:out value="${situationRoomVO.accidentContent}"></c:out>
					</td>
				</tr>
				<tr>
					<td style="text-align:left;padding-left:10px;">
						기타
					</td>
					<td style="text-align:left;padding-left:10px;">
						<c:out value="${situationRoomVO.etcContent}"></c:out>
					</td>
				</tr>
			</table>
		</div>
		<br />
		<div style="text-align:left;padding-left:10px;padding-top:10px;">
			<span><b>3. 상황전파 현황</b></span> 
		</div>
		<div style="padding-left:10px;padding-top:10px;">
			<table class="dataTable5" id="accidentTable">
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
					<td style="text-align:left;padding-left:10px;">
						<input type="checkbox" class="inputCheck" name="sTargetMe" id="sTtargetMe" value="Y" disabled <c:if test="${result.targetMe == 'Y'}">checked</c:if> /> 환경처
						<input type="checkbox" class="inputCheck" name="sTtargetGov" id="sTtargetGov" value="Y" disabled <c:if test="${result.targetGov == 'Y'}">checked</c:if> style="margin-left:15px;"/> 지자체 <br />
						<input type="checkbox" class="inputCheck" name="sTtargetKeco" id="sTtargetKeco" style="padding-right:3px;" value="Y" disabled <c:if test="${result.targetKeco == 'Y'}">checked</c:if>> 본사
						<input type="checkbox" class="inputCheck" name="sTargetArea" id="sTargetArea" value="Y" disabled <c:if test="${result.targetArea == 'Y'}">checked</c:if> style="margin-left:26px;"/>  <c:if test="${result.targetArea == 'Y'}"><c:out value="${result.targetAreaDetail}"/></c:if>지역본부 <br />
						<input type="checkbox" class="inputCheck" name="sTargetSigongsa" id="sTargetSigongsa" value="Y" disabled <c:if test="${result.targetSigongsa == 'Y'}">checked</c:if>> 시공사
						<input type="checkbox" class="inputCheck" name="sTargetEtc" id="sTargetEtc" value="Y" disabled <c:if test="${result.targetEtc == 'Y'}">checked</c:if> style="margin-left:15px;"/> 기타 <br />
					</td>
					<td style="text-align:left;padding-left:10px;">
						<c:out value="${result.content}"/>
					</td>
				</tr>
				</c:forEach>
				<c:if test="${fn:length(spreadSList) == 0}">
					<tr>
					<td>사고전파</td>
					<td></td>
					<td style="text-align:left;padding-left:10px;">
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
		<div style="padding-left:10px;">
			<table class="dataTable5" id="weatherTable">
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
					<td style="text-align:left;padding-left:10px;">
						<input type="checkbox" class="inputCheck" name="sTargetMe" id="sTtargetMe" value="Y" disabled <c:if test="${result.targetMe == 'Y'}">checked</c:if>/> 환경처
						<input type="checkbox" class="inputCheck" name="sTtargetGov" id="sTtargetGov" value="Y" disabled <c:if test="${result.targetGov == 'Y'}">checked</c:if> style="margin-left:15px;"/> 지자체 <br />
						<input type="checkbox" class="inputCheck" name="sTtargetKeco" id="sTtargetKeco" style="padding-right:3px;" value="Y" disabled <c:if test="${result.targetKeco == 'Y'}">checked</c:if>/> 본사
						<input type="checkbox" class="inputCheck" name="sTargetArea" id="sTargetArea" value="Y" disabled <c:if test="${result.targetArea == 'Y'}">checked</c:if>  style="margin-left:26px;"/>  <c:if test="${result.targetArea == 'Y'}"><c:out value="${result.targetAreaDetail}"/></c:if>지역본부 <br />
						<input type="checkbox" class="inputCheck" name="sTargetSigongsa" id="sTargetSigongsa" value="Y" disabled <c:if test="${result.targetSigongsa == 'Y'}">checked</c:if>/> 시공사
						<input type="checkbox" class="inputCheck" name="sTargetEtc" id="sTargetEtc" value="Y" disabled <c:if test="${result.targetEtc == 'Y'}">checked</c:if>  style="margin-left:15px;"/> 기타 <br />
					</td>
					<td style="text-align:left;padding-left:10px;">
						<c:out value="${result.content}"/>
					</td>
				</tr>
				</c:forEach>
				<c:if test="${fn:length(spreadGList) == 0}">
					<tr>
					<td>기상특보</td>
					<td></td>
					<td style="text-align:left;padding-left:10px;">
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
		<div style="text-align:left;padding-left:10px;padding-top:10px;">
			<span><b>4. 강우현황</b></span> 
		</div>
		<div style="padding-left:10px;padding-top:10px;">
			<table class="dataTable5">
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
					<td><c:out value="${rainFallList[0].rainFall}"/></td>
					<td><c:out value="${rainFallList[1].rainFall}"/></td>
					<td><c:out value="${rainFallList[2].rainFall}"/></td>
					<td><c:out value="${rainFallList[3].rainFall}"/></td>
					<td><c:out value="${rainFallList[4].rainFall}"/></td>
					<td><c:out value="${rainFallList[5].rainFall}"/></td>
					<td><c:out value="${rainFallList[6].rainFall}"/></td>
				</tr>
			</table>
			<br />
			<table class="dataTable5">
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
					<td><c:out value="${rainFallList[7].rainFall}"/></td>
					<td><c:out value="${rainFallList[8].rainFall}"/></td>
					<td><c:out value="${rainFallList[9].rainFall}"/></td>
					<td><c:out value="${rainFallList[10].rainFall}"/></td>
					<td><c:out value="${rainFallList[11].rainFall}"/></td>
					<td><c:out value="${rainFallList[12].rainFall}"/></td>
					<td>-</td>
				</tr>
			</table>
		</div>
		</div>
		<div style="float:right;padding-right:15px;padding-top:10px;">
		<p>
			<input type="button" id="btnPrint" value="인쇄" class="btn btn_basic" style="float:right" alt="인쇄" onclick="javascript:fnPrint();"/>
		</p>
		</div>
		<br />
	</div>
</body>
</html>