<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : checkUsePrintView.jsp
	 * Description : 점검및사용일지(인쇄) 화면
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
	<div style="margin-top:20px; margin-bottom:20px;padding-left:10px;">
		<span style="text-align:center;font-size: 20px;"><u><b><h1>진공흡입기/멀티콥터/방제바지선/에어텐트 (점검·사용) 일지</h1></b></u></span>
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
				<span style="float:left;"><b>일자</b> : <c:out value="${checkUseVO.workDay}"/></span>
				<span style="padding-left:30px;float:left"><b>날씨</b> : <c:out value="${checkUseVO.weather}"/></span>
			</div>
			<br />
			<div style="text-align:left;">
				<span><b></b></span> 
			</div>
			<br />
			<c:if test="${not empty checkUseVO.equipCode1 }">
			<span style="float:left;">
				<b>장비명</b> : 
				${checkUseVO.equipCode1 }
			</span>
			</c:if>
			<div style="text-align:left;">
				<span><b></b></span>
			</div>
			<br />
			<span id="spanPurpose" style="float:left">
				<b>목 적</b> : 
				${checkUseVO.purposeName }
			</span>
			<c:if test="${checkUseVO.purpose ne 'P1' }">
			<div style="text-align:left;">
				<span><b></b></span> 
			</div>
			<br />
			<span id="spanUsePurpose" style="float:left;padding-left:50px;">
				<b>사용목적</b> : 
				${checkUseVO.usePurposeName }
			</span>
			<span id="spanUsePlace" style="padding-left:30px;float:left"><b>사용처</b> : ${checkUseVO.usePlace }</span>
			</c:if>
			<br/>
			<br/>
			<div style="text-align:left;">
				<span><b>점검 현황</b></span> 
			</div>
			<div>
				<table class="dataTable5">
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
					<c:forEach items="${checkList }" var="list">
					<tr>
						<c:if test="${gubunCode ne list.gubunCode }">
						<td rowspan="${list.rowspan }">${list.gubunName }<br/>(${list.equipName })</td>
						</c:if>
						<c:set var="gubunCode" value="${list.gubunCode }"/>
						<td style="text-align:left;padding-left:5px;">${list.checkCode }</td>
						<td style="text-align:left;padding-left:10px;">${list.checkResult }</td>
						<td style="text-align:left;padding-left:10px;">${list.note }</td>
						<!-- <td>${list.photoId }</td> -->
					</tr>
					</c:forEach>
				</table>
			</div>
			<br />
			<div style="text-align:left;">
				<span><b>특이사항</b></span>
				<br/>
				<textarea name="issueComment" id="issueComment" rows="3" style="width:97%;" readonly="readonly">${checkUseVO.issueComment }</textarea> 
			</div>
			<br />
			<span style="float:left"><b>인 원</b> : ${checkUseVO.persons } 명</span>
			<span style="padding-left:30px;float:left"><b>참여자</b> : ${checkUseVO.participant }</span>
			<br/>
			<div style="text-align:left;">
				<span><b></b></span> 
			</div>
			<br />
			<div style="text-align:left;">
				<span><b>사진대지</b></span>
				<br/>
			</div>
			<br/>
			<div style="text-align:left;">
				<span><b>설 명</b></span>
				<br/>
				<textarea name="exprComment" id="exprComment" rows="3" style="width:97%;" readonly="readonly">${checkUseVO.exprComment }</textarea> 
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