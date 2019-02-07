<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pj" uri="ProjectJstlUtil"%>

<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="상황관리" name="title"/>
</jsp:include>
<script type="text/javascript">
$(function() {
	$("#dataList tr:odd").attr("class","add");
	
	$("#chart").load(function() {$("#graphLoading").hide();});
	chart();
});

function chart(){
	
	var width = "320";
	var height = "90";
	var alertTime = '<c:out value="${alertCnt}"/>';
	
	var param = "&as_id=<c:out value="${asData.asId}"/>" +
				"&sys_kind=<c:out value="${asData.system}"/>" +
				"&alertTime="+alertTime+
				"&legend=true" +
				"&width="+width+
				"&height="+height;
	
	var src = "<c:url value='/waterpolmnt/waterinfo/getRiverWater3HourWarningPopDetailGraph.do'/>?";
	$('#chart').attr("src", src + encodeURI(param));
}


function fnSave() {
	if(confirm("진행하시겠습니까?"))
	{
		frm = document.frm1;
		frm.action = "<c:url value='/mobile/sub/alert/addAlertStep.do'/>";
		frm.submit();
	}
}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/alert/alertMngSearch.do" name="link"/>
		<jsp:param value="상황관리" name="title"/>
	</jsp:include>
<form name="frm1" method="post" cssClass="writeForm">
	<input type="hidden" name="asId" value="<c:out value="${asData.asId}"/>"/>
	<input type="hidden" id="alertStep" name="alertStep" value="2"/> 
	<input type="hidden" name="alertStepName" maxlength="30" class="input" value="현장확인" readonly="readonly"/>
	<input type="hidden" name="alertStepText" maxlength="30" class="input" value="" readonly="readonly"/>
	<input type="hidden" id="date" name="date"/>
	<input type="hidden" id="time" name="time"/>
</form>
<div> 
	<c:set var="listparameter" value='${pj:ParamString(param_s,"system,startDate,endDate,itemType,minOr,asId")}&alertStep'/>
	<jsp:include page="/WEB-INF/jsp/mobile/sub/alert/CommonAlertMngNumber.jsp">
		<jsp:param value="${listparameter}" name="listparameter"/>
		<jsp:param value="1" name="stepno"/>
		<jsp:param value="${asData.alertStep}" name="alertStep"/>
		<jsp:param value="${AllstepList}" name="AllstepList"/>
	</jsp:include>
	<div class="write">
		<div class="titleBx" style="margin-top:20px">▶ 신고</div>
		<table> 
			<colgroup> 
				<col width="120px" />
				<col width="*" /> 
			</colgroup> 
			<tr>
				<th>사고접수유형</th>
				<td>
					<c:out value="${asData.itemTypeName}"/>
					<c:if test="${asData.itemType == null || asData.itemType eq ''}">
						<c:if test="${asData.system eq 'U'}">
							(이동형측정기기)
						</c:if>
						<c:if test="${asData.system eq 'A'}">
							(국가수질자동측정망)
						</c:if>
					</c:if>
				</td>
			</tr>
			<tr>
				<th>지역</th>
				<td>
					<c:if test="${asData.factCode != '50A0001'}">
						<c:out value="${asData.regName}"/>
					</c:if>
					<c:if test="${asData.factCode eq '50A0001'}">
						<c:out value="${asData.addr_short}"/>
					</c:if>
				</td>
			</tr>
			<tr>
				<th>측정소</th>
				<td>
					<c:if test="${asData.factCode != '50A0001'}">
						<c:out value="${asData.branchName}"/>-<c:out value="${asData.branchNo}"/>
					</c:if>
					<c:if test="${asData.factCode eq '50A0001'}">
						임의지점
					</c:if>
				</td>
			</tr>
			<tr>
				<th>경보발생시간</th>
				<td>
				<c:if test="${asData.system != 'U'}">
					<c:out value="${asData.minTime}"/>
				</c:if>
				<c:if test="${asData.system eq 'U'}">
					<c:out value="${asData.OMinTime}"/>
				</c:if>
				</td>
			</tr>
			<tr>
				<th>사고등록시간 </th>
				<td>
					<c:out value="${asData.alertTime}"/>
				</td>
			</tr>
			<c:if test="${asData.system != 'U'}">
				<tr>
					<th>경보지속시간 </th>
					<td>
						<c:if test="${asData.itemType == null}">
							<c:if test="${asData.system != 'U'}">
								<c:out value="${acctCnt}"/>
							</c:if>
						</c:if>
						<c:if test="${asData.itemType != null}">
							-
						</c:if>
					</td>
				</tr>
			</c:if>
			<tr>
				<th>상황전파이력 </th>
				<td>
					<c:if test="${asData.alertStep != '9'}">
						<c:out value="${data.alertStepText}"/>
					</c:if>
					<c:if test="${asData.alertStep eq '9'}">
						전파대상자를 찾을 수 없습니다.
					</c:if>
				</td>
			</tr>
			<tr>
				<th>상류정보</th>
				<td>
					댐정보 등
				</td>
			</tr>
			<tr>
				<th>하류정보</th>
				<td>
					취정수장정보 등
				</td>
			</tr>
		</table> 
		
		<div class="titleBx" style="margin-top:20px">▶ 경보발생 수질변화 추이</div>
		<table width="100%"> 
			<colgroup>
				<col width="35%" />
				<col width="30%" />
				<col width="35%" />
			</colgroup>
			<tr> 
				<th style="text-align:center;" >측정일시</th> 
				<th style="text-align:center;" >측정값</th> 
				<th style="text-align:center;" >경보단계</th> 
			</tr>
			<c:forEach items="${warningData}" var="item" varStatus="count">
			<tr>
				<td style="text-align:center;" ><c:out value="${item.min_time}"/></td>
				<td style="text-align:center;" >
					<c:out value="${item.min_vl}"/>
					<c:if test="${item.minVl2 != null}">
					/ <c:out value="${data.minVl2}"/>
					</c:if>
					<c:if test="${item.minVl3 != null}">
					/ <c:out value="${item.minVl3}"/>
					</c:if>
				</td>
				<td style="text-align:center;" ><c:out value="${item.min_or_name}"/></td>
			</tr>
			</c:forEach>
		</table>
		
		<div style="margin:20px 0 0 0;">
			<!-- 그래프자리 -->
			<div class="graph">
				<span id="graphLoading" style="position:absolute;">그래프를 불러오는 중 입니다...</span>
				<iframe id="chart"  src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="95px"></iframe>
			</div>
		</div>
		
		
		<c:if test='${isReview == false}'>
		<div style="margin:20px 0 0 0;">
			<ul class="sbtn" style="width:100%;text-align:center;">
				<li style="width:100%;">
					<a href="#" onclick="fnSave(); return false;">현장확인</a>
				</li>
			</ul>
		</div> 
		</c:if>
	</div>
</div>

</body>
</html>