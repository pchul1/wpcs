<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : process_popup_sub01.jsp
	 * Description : 상황발생이력 상세 화면(경보발생)
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 2010.11.05	kgb			최초 생성
	 * 2014.05.26	lkh			리뉴얼
	 * 
	 * author khany
	 * since 2010.05.17
	 * 
	 * Copyright (C) 2010 by khany All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title></title>
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />
	<style type="text/css">
	.btnSearchDiv{height:25px; margin:10px 0 10px 0;}
	.btnSearchDiv .btn_search{border-radius:5px; -webkit-border-radius:5px; -moz-border-radius:5px; background:#A6A6A6; padding:1px 15px; height:25px; line-height:15px;}
	.btnSearchDiv .btn_search:hover{ background:#8DB72A; color:#FFFFFF;}
	.btn {border: medium none;color: #ffffff;cursor: pointer;font-weight: 600;height: 21px;margin-left: 4px;margin-top: 0;text-align: center;z-index: 2;}
	</style>	
	
	<script type='text/javascript'>
		$(function() {
			$("#dataList tr:odd").attr("class","add");
			
			$("#chart").load(function() {graphLoaded();});
			chart();
		});
		
		function fncSave() {
			if(confirm("진행하시겠습니까?"))
			{
				frm = document.detailForm;
				frm.action = "<c:url value='/alert/addAlertStep.do'/>";
				frm.submit();
			}
		}
		
		function fn_egov_downFile(atchFileId){ 
			window.open("<c:url value='/cmmn/AlertFileDown.do?atchFileId="+atchFileId+"'/>");
		}
		
		function chart(){
			
			var width = "953";
			var height = "148";
			var alertTime = '${alertCnt}';
			
			var param = "&as_id=${asData.asId}" +
						"&sys_kind=${asData.system}" +
						"&alertTime="+alertTime+
						"&legend=true" +
						"&width="+width+
						"&height="+height;
			
			var src = "<c:url value='/waterpolmnt/waterinfo/getRiverWater3HourWarningPopDetailGraph.do'/>?";
			$('#chart').attr("src", src + encodeURI(param));
		}
		
		function graphLoaded()
		{
			$("#graphLoading").hide();
		}
		
		function errorData()
		{
			var flag = false;
			
			var alertText = "";
			for(var idx=0;idx < warningDataCnt;idx++)
			{
				var check = $("#errorCheck" + idx); 
				var reason = $("#errorReason" + idx);
				var min_time;
				var reasonStr;
				
				if(check.is(":checked"))
				{
					flag = true;
					
					min_time = reason.val(); //min_time
					reasonStr = $("#errorReason" + idx + " option:selected").text();
					
					alertText = alertText + "|" + min_time  + "|" + reasonStr;
				}
			}
			
			alertText = alertText.replace("|", "");
			
			if(!flag)
			{
				alert("이상으로 체크된 데이터가 없습니다");
				return;
			}
			
			//현재 시간 
			var today = new Date(); 
			var todayStr = today.getFullYear() + addzero(today.getMonth()+1) + addzero(today.getDate());
			var time = addzero(today.getHours()) + addzero(today.getMinutes());
			
			function addzero(n) {
				 return n < 10 ? "0" + n : n + "";
			}
			
			if(confirm("[이상데이터 판단 저장] 진행하시겠습니까?"))
			{
				frm = document.detailForm;
				frm.date.value = todayStr;
				frm.time.value = time;
				frm.alertStep.value = "7"; //강우요인
				frm.alertStepText.value = alertText;
				frm.action = "<c:url value='/alert/addAlertStep.do'/>";
				frm.submit();
			}
		}
	</script>
</head>
<body class="pop_basic">
	<div class="situationprocessPop2">
		<jsp:include page="/WEB-INF/jsp/alert/CommonAlertMngNumber.jsp">
			<jsp:param name="listparameter" value="?asId=${param.asId}&pageIndex=${param.pageIndex}&itemType=${param.itemType}&system=${param.system}&startDate=${param.startDate}&endDate=${param.endDate}&minOr=${param.minOr}&step"/>
			<jsp:param value="1" name="stepno"/>
			<jsp:param value="${asData.alertStep}" name="alertStep"/>
			<jsp:param value="${AllstepList}" name="AllstepList"/>
		</jsp:include>
<!-- 		<hr noshade="noshade" /> -->
		<div class="data">
			<div class="overBox2">
				<table class="dataTable">
					<colgroup>
						<col width="150" />
						<col />
						<col width="150" />
						<col />
						<col width="150" />
						<col />
					</colgroup>
					<tr>
						<th scope="row">사고접수유형</th>
						<td>
							<c:out value="${asData.itemTypeName}"/>
							<c:if test="${asData.itemType == null || asData.itemType eq ''}">
								<c:if test="${asData.system eq 'T'}">
									(탁수 모니터링)
								</c:if>
								<c:if test="${asData.system eq 'U'}">
									(이동형측정기기)
								</c:if>
								<c:if test="${asData.system eq 'A'}">
									(국가수질자동측정망)
								</c:if>
							</c:if>
						</td>
						<th scope="row">지역</th>
						<td>
							<c:if test="${asData.factCode != '50A0001'}">
								<c:out value="${asData.regName}"/>
							</c:if>
							<c:if test="${asData.factCode eq '50A0001'}">
								<c:out value="${asData.addr_short}"/>
							</c:if>
						</td>
						<th scope="row">측정소</th>
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
						<th scope="row">경보발생시간</th>
							<td>
							<c:if test="${asData.system != 'U'}">
								<c:out value="${asData.minTime}"/>
							</c:if>
							<c:if test="${asData.system eq 'U'}">
								<c:out value="${asData.OMinTime}"/>
							</c:if>
							</td>
						<th scope="row">사고등록시간</th>
						<td><c:out value="${asData.alertTime}"/></td>
						<th scope="row">
							<c:if test="${asData.system != 'U'}">
								경보지속시간
							</c:if>
						</th>
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
					<tr>
						<th scope="row">상황전파이력</th>
						<td colspan="5" class="txt" style="padding-left:15px">
						<c:if test="${asData.alertStep != '9'}">
							${data.alertStepText}
						</c:if>
						<c:if test="${asData.alertStep eq '9'}">
							전파대상자를 찾을 수 없습니다.
						</c:if>
						</td>
					</tr>
				</table>
<%-- 				${asData} --%>
				<!-- 경보발생 수질변화추이 -->
				<div class="con_wrap3" id="div1">
					<div class="con_titArea">
						<h2 class="PointTit">경보발생 수질변화추이</h2>
					</div>
					<h3 class="buSqu_tit">
						${warningData[0].item_name}
						<c:if test="${warningData[0].itemName2 != null}">
							/ ${warningData[0].itemName2}
						</c:if>
						<c:if test="${warningData[0].itemName3 != null}">
							/ ${warningData[0].itemName3}
						</c:if>
					</h3>
					<form action="">
						<div style="overflow-y:auto;">
							<table class="dataTable2">
								<colgroup>
									<col width="220" />
									<col width="150" />
									<col />
								</colgroup>
								<thead id="dataHeader">
								<tr style="border-top:solid 0px #CCC">
									<th scope="col">측정일시</th>
									<th scope="col">측정값</th>
									<th scope="col">경보단계</th>
								</tr>
								</thead>
								<tbody id="dataList">
								
								<!-- 반복생성 -->
								<script type="text/javascript">
									var warningDataCnt = 0;
								</script>
								<c:forEach items="${warningData}"  var="data"  varStatus="status">
								<tr>
									<td>${data.min_time}</td>
									<td>
										${data.min_vl}
										<c:if test="${data.minVl2 != null}">
										/ ${data.minVl2}
										</c:if>
										<c:if test="${data.minVl3 != null}">
										/ ${data.minVl3}
										</c:if>
									</td>
									<td>${data.min_or_name}</td>
								</tr>
								<script type="text/javascript">
									warningDataCnt++;
								</script>
								</c:forEach>
								<!-- 반복생성 -->
								
								</tbody>
							</table>
						</div>
					</form>
					<div class="con_titArea">
						<!-- 그래프자리 -->
						<div class="graph">
							<span id="graphLoading" style="position:absolute;">그래프를 불러오는 중 입니다...</span>
							<iframe id="chart"  src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="100%"></iframe>
						</div>
						<!--// 그래프자리 -->
						
					</div>
				</div>
				<c:if test="${asData.itemType != null}">
					<script type="text/javascript">
						$("#div1").css("display","none");
					</script>
				</c:if>
				<!-- // 경보발생 수질변화추이 -->
				
				<div class="con_wrap4">
					<table class="dataTable">
						<colgroup>
							<col width="150" />
							<col />
						</colgroup>
						<tbody>
							<tr>
								<th>상류정보</th>
								<td>댐정보 등</td>
							</tr>
							<tr>
								<th>하류정보</th>
								<td>취정수장정보 등</td>
							</tr>
						</tbody>
					</table>
					<div class="btnSearchDiv">
	<!-- 				<a id="btnSearch" name="btnSearch" class="btn roundBox" onclick="javascript:reloadData();" style="float:right;">조회하기</a> -->
						<input type="button" id="btnSearch" name="btnSearch" value="현장 확인" class="btn btn_search" onclick="javascript:fncSave();" alt="현장 확인" style="float:right;"/>
					</div>	
				</div>
			</div>
		</div>
	</div>
	<form:form commandName="alertStepVO" name="detailForm" method="post" cssClass="writeForm" onsubmit="return false;">
		<input type="hidden" name="asId" value="${asData.asId}"/>
		<input type="hidden" id="alertStep" name="alertStep" value="2"/> 
		<input type="hidden" name="alertStepName" maxlength="30" class="input" value="현장확인" readonly="readonly"/>
		<input type="hidden" name="alertStepText" maxlength="30" class="input" value="" readonly="readonly"/>
		<input type="hidden" id="date" name="date"></input>
		<input type="hidden" id="time" name="time"></input>
		
		<input type="hidden" id="pageIndex" name="pageIndex" value="${param.pageIndex}"></input>
		<input type="hidden" id="itemType" name="itemType" value="${param.itemType}"></input>
		<input type="hidden" id="system" name="system" value="${param.system}"></input>
		<input type="hidden" id="startDate" name="startDate" value="${param.startDate}"></input>
		<input type="hidden" id="endDate" name="endDate" value="${param.endDate}"></input>
		<input type="hidden" id="minOr" name="minOr" value="${param.minOr}"></input>
	</form:form>
</body>
</html>
