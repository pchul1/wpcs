<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name  : process_popup_sub06.jsp
	 * Description : 상황발생이력 상세 화면(상황종료-측정기이상)
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
	<script src="<c:url value='/js/JQuery/jquery-1.3.2.min.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/plugin/jquery.scrollList.js" type="text/javascript'/>"></script>
	<script src="<c:url value='/js/JQuery/ui/jquery.maskedinput-1.2.2.js" type="text/javascript'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/jquery-ui-1.7.2.custom.min.js'/>"></script>
	<link type="text/css" href="<c:url value='/js/JQuery/css/ui.all.css'/>" rel="stylesheet" />
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.core.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/ui/ui.datepicker.js'/>"></script>
	<script type="text/javascript" src="<c:url value='/js/JQuery/jquery.form.js'/>"></script>
	<script type="text/javascript">
		$(function() {
			$("#dataList tr:odd").attr("class","add");
			
			$("#chart").load(function() {graphLoaded();});
			chart();
			$("#btnReport",parent.document).css("display","");
		});
		
		function graphLoaded()
		{
			$("#graphLoading").hide();
		}
		
// 		function chart2(){
			
// 			var width = "883";
// 			var height = "148";
			
// 			var alertTime = '${alertCnt}';
			
// 			var param = "&as_id=${asData.asId}"+
// 						"&alertTime="+alertTime+
// 						"&legend=true"+
// 						"&width="+width+
// 						"&height="+height;
			
// 			var src = "<c:url value='/waterpolmnt/waterinfo/getRiverWater3HourWarningPopDetailGraph.do'/>?";
// 			$('#chart').attr("src", src + encodeURI(param));
// 		}
		
		function chart(){
			$("#span_loading").show();
			
			var width = "850";
			var height = "158";
			
			var sugye = "${asData.riverDiv}";
			var gongku = "${asData.factCode}";
			var chukjeongso = "${asData.branchNo}";
			
			var minTime = "${asData.minTimeStr}";
			var endTime = "${endTime}";
			
			var item = "${asData.itemCode}";
			var item2 = "${asData.itemCode2}";
			var item3 = "${asData.itemCode3}";
			var sys = "${asData.system}";
			
			if(sys == "U")
			{
				minTime = "${asData.OMinTime}";
				
				minTime = minTime.split("/").join("") + "";
				minTime = minTime.split(":").join("") + "";
				minTime = minTime.split(" ").join("") + "";
			}
			
			var param = "sugye=" + sugye + "&gongku=" + gongku + "&chukjeongso=" + chukjeongso +
						"&minTime=" + minTime + "&endTime=" + endTime +
						"&sys=" + sys +
						"&item=" + item +
						"&item2=" + item2 +
						"&item3=" + item3 +
						"&wLine=Y" +
						"&dataType=" + "2" + "&width=" +width + "&height=" + height
			
			//stats/getAccidentStatsChart.do
			//window.open("<c:url value='/waterpolmnt/waterinfo/getChartDetalViewRIVER.do'/>?"+encodeURI(param),
			//		'chartDetailViewRIVER','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=yes,left='+winLeftPost+',top='+winTopPost);
			
			var src = "<c:url value='/waterpolmnt/waterinfo/getChartDetalViewRIVER.do?'/>";
			$('#chart').attr("src", src + encodeURI(param));
		}
		
		var type = "${asData.itemType}";
		
// 		function report() {
// 			var sw=screen.width;
// 			var sh=screen.height;
// 			var winHeight = 600;
// 			var winWidth = 900;
// 			var winLeftPost = (sw - winWidth) / 2;
// 			var winTopPost = (sh - winHeight) / 2;
// 			var width = winWidth-40;
// 			var height = winHeight-40;
			
// 			var mrdFile = "";
			
// 			if(type == "TYPE1")//육안관찰이면
// 				mrdFile = "completeRpt_${asData.alertStep}_eye";
// 			else
// 				mrdFile = "completeRpt_${asData.alertStep}";
				
// 			var param = "/rp [${asData.asId}]";
			
// 			document.report.mrdpath.value = mrdFile;
// 			document.report.param.value = param;
					
// 			window.open("", 
// 					'reportView','width='+winWidth+',height='+winHeight+',toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=yes,resizable=yes,left='+winLeftPost+',top='+winTopPost);
			
// 			document.report.target = "reportView";
// 			document.report.submit();
// 		}
	</script>
</head>

<body class="pop_basic">
	<div class="situationprocessPop2">
	<jsp:include page="/WEB-INF/jsp/alert/CommonAlertMngNumber.jsp">
		<jsp:param name="listparameter" value="?asId=${param.asId}&pageIndex=${param.pageIndex}&itemType=${param.itemType}&system=${param.system}&startDate=${param.startDate}&endDate=${param.endDate}&minOr=${param.minOr}&step"/>
		<jsp:param value="${asData.alertStep}" name="alertStep"/>
		<jsp:param value="${AllstepList}" name="AllstepList"/>
		<jsp:param value="6" name="stepno"/>
	</jsp:include>
		<c:if test="${param.mngList != 'Y'}">
			<h1 class="buRect_tit2">상황종료</h1>
<!-- 			<hr noshade="noshade" /> -->
		</c:if>
		<div class="data">
			<div class="overBox2">
				<table class="dataTable">
					<colgroup>
						<col width="150" />
						<col width="150" />
						<col width="150" />
						<col width="190" />
						<col width="150" />
						<col />
					</colgroup>
					<thead>
						<tr>
							<th colspan="2" scope="col">경보 발생 시각</th>
							<th scope="col">경보단계</th>
							<th colspan="3" scope="col">측정소</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td colspan="2">
								<c:if test="${asData.system != 'U'}">
									<c:out value="${asData.minTime}"/>
								</c:if>
								<c:if test="${asData.system eq 'U'}">
									<c:out value="${asData.OMinTime}"/>
								</c:if>
							</td>
							<td>
								${asData.minOr}
							</td>
							<td colspan="3">
								<c:if test="${asData.factCode != '50A0001'}">
									<c:out value="${asData.branchName}"/>-<c:out value="${asData.branchNo}"/>
								</c:if>
								<c:if test="${asData.factCode eq '50A0001'}">
									임의지점
								</c:if>
							</td>
						</tr>
						<tr>
							<th scope="col" colspan="2">경보 등록 시각</th>
							<th scope="col">항목</th>
							<th scope="col">측정값</th>
							<th scope="col" colspan="2">경보기준</th>
						</tr>
						<tr>
							<c:if test="${asData.itemType == null}">
								<td colspan="2">${asData.alertTime}</td>
								<td>
									${asData.itemName}
										<c:if test="${asData.itemName2 != null}">
										/ ${asData.itemName2}
										</c:if>
										<c:if test="${asData.itemName3 != null}">
										/ ${asData.itemName3}
										</c:if>
								</td>
								<td>${asData.minVl}
										<c:if test="${asData.minVl2 != null}">
										/ ${asData.minVl2}
										</c:if>
										<c:if test="${asData.minVl3 != null}">
										/ ${asData.minVl3}
										</c:if>
								</td>
								<td colspan="2">
									<c:if test="${law.lawLValue != null && law.lawLValue != '0.0'}">
										${law.lawLValue} 이하,
									</c:if>
									${law.lawHValue} 이상
								/
									<c:if test="${law2 != null}">
										<c:if test="${law2.lawLValue != null && law2.lawLValue != '0.0'}">
											${law2.lawLValue} 이하
										</c:if>
											${law2.lawHValue} 이상
									</c:if>
									
								</td>
							</c:if>
							<c:if test="${asData.itemType != null}">
								<td colspan="2">${asData.alertTime}</td>
								<td>${asData.itemName}</td>
								<td>-</td>
								<td colspan="2">-</td>
							</c:if>
						</tr>
					<tr>
						<th scope="col" colspan="6" class="bgStyle">조치이력</th>
					</tr>
					<tr>
						<td scope="col" colspan="6">
							<c:forEach  items="${dataList}"  var="dataList"  varStatus="status">
								<c:if test="${dataList.alertStepNum eq '2'}">
									경보발생(${asData.itemTypeName}) → 
								</c:if>
								<c:if test="${dataList.alertStepNum eq '7'}">
									경보발생(${asData.itemTypeName}) → 상황종료(이상데이터)
								</c:if>
								<c:if test="${dataList.alertStepNum eq '3'}">
									현장확인(시료채수) → 
								</c:if>
								<c:if test="${dataList.alertStepNum eq '6'}">
									상황종료(측정기 이상) 
								</c:if>
								<c:if test="${dataList.alertStepNum eq '4'}">
									시료분석 → 
								</c:if>
								<c:if test="${dataList.alertStepNum eq '5'}">
									경보발령 → 
								</c:if>
								<c:if test="${dataList.alertStepNum eq '10'}">
									상황종료(시료분석)
								</c:if>
								<c:if test="${dataList.alertStepNum eq '8'}">
									상황조치 → 상황종료
								</c:if>
							</c:forEach>
						</td>
					</tr>
					<tr>
						<th scope="col" colspan="6" class="bgStyle">조치사항</th>
					</tr>
					<tr>
							<th scope="col">시각</th>
							<th scope="col">조치단계</th>
							<th colspan="4" scope="col">주요조치사항</th>
						</tr>
						<c:forEach  items="${dataList}"  var="dataList"  varStatus="status">
							<c:if test="${dataList.alertStepNum != '0'}">
								<tr>
									<td>
										<c:if test="${dataList.alertStepNum eq '1'}">
											<c:out value="${asData.alertTime}"/>
										</c:if>
										<c:if test="${dataList.alertStepNum != '1'}">
											${dataList.alertStepTime}
										</c:if>
									</td>
									<td>
										<c:if test="${dataList.alertStepNum eq '1'}">
											경보발생
										</c:if>
										<c:if test="${dataList.alertStepNum eq '2'}">
											현장확인
										</c:if>
										<c:if test="${dataList.alertStepNum eq '3'}">
											시료분석
										</c:if>
										<c:if test="${dataList.alertStepNum eq '4'}">
											경보발령
										</c:if>
										<c:if test="${dataList.alertStepNum eq '5'}">
											상황조치
										</c:if>
										<c:if test="${dataList.alertStepNum eq '8'}">
											상황종료
										</c:if>
										<c:if test="${dataList.alertStepNum eq '7'}">
											상황종료<br/>(이상데이터)
										</c:if>
										<c:if test="${dataList.alertStepNum eq '6'}">
											상황종료<br/>(측정기 이상)
										</c:if>
										<c:if test="${dataList.alertStepNum eq '10'}">
											상황종료<br/>(시료분석)
										</c:if>
									</td>
									<td colspan="4" scope="col" style="text-align:left;padding-left:10px">
										<c:if test="${dataList.alertStepNum eq '8'}">
											상황종료
										</c:if>
										<c:if test="${dataList.alertStepNum != '8'}">
											${dataList.alertStepText}
										</c:if>
									</td>
								</tr>
							</c:if>
							
							<c:if test="${dataList.alertStepNum eq '3'}">
								<c:set var="moveGov" value="${dataList.moveGov}"></c:set>
							</c:if>
						</c:forEach>
						
						<tr id="tr1">
							<th scope="row">오염도 추이</th>
							<td colspan="5">
							<!-- 그래프자리 -->
							<div id="data_graph" style="overflow:hidden;height:150px">
								<span id="graphLoading" style="position:absolute;">그래프를 불러오는 중 입니다...</span>
								<iframe id="chart" src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="100%"></iframe>
							</div>
							<!--// 그래프자리 -->
							</td>
						</tr>
						<tr>
							<th rowspan="3" scope="row" class="bgStyle">측정소 개황</th>
							<th scope="row">주소지</th>
							<td colspan="4">
								<c:if test="${asData.factCode != '50A0001'}">
									<c:out value="${asData.factAddr}"/>
								</c:if>
								<c:if test="${asData.factCode eq '50A0001'}">
									<c:out value="${asData.address}"/> <c:out value="${asData.addr_det}"/>
								</c:if>
							</td>
						</tr>
						<tr>
							<th rowspan="2" scope="row">연관정보</th>
							<th colspan="2" scope="col">상류정보</th>
							<th scope="col" colspan="2">하류정보</th>
						</tr>
						<tr>
							<td colspan="2">&nbsp;</td>
							<td colspan="2"></td>
						</tr>
						<c:forEach  items="${dataList}"  var="dataList"  varStatus="status">
							<c:if test="${dataList.alertStepNum eq '3' || dataList.alertStepNum eq '6'}">
								<tr>
									<th scope="row">담당기관</th>
									<td>${dataList.gov}</td>
									<th scope="row">담당자</th>
									<td>${dataList.person}</td>
									<th scope="row">연락처</th>
									<td>${dataList.phone}</td>
								</tr>
							</c:if>
							<c:if test="${dataList.alertStepNum eq '4' || dataList.alertStepNum eq '10'}">
								<tr>
									<th scope="row">분석기관</th>
									<td>${dataList.analGov}</td>
									<th scope="row">담당자</th>
									<td>${dataList.analPerson}</td>
									<th scope="row">연락처</th>
									<td>${dataList.analPhone}</td>
								</tr>
							</c:if>
							<c:if test="${dataList.alertStepNum eq '8'}">
								<tr>
									<th scope="row">작성기관</th>
									<td>${dataList.procGov}</td>
									<th scope="row">담당자</th>
									<td>${dataList.procPerson}</td>
									<th scope="row">연락처</th>
									<td>${dataList.procPhone}</td>
								</tr>
							</c:if>
						</c:forEach>
					</tbody>
				</table>
						<c:if test="${asData.itemType != null}">
							<script type="text/javascript">
								$("#tr1").hide();
							</script>
						</c:if>
						
<%-- 				<c:if test="${param.mngList != 'Y'}"> --%>
<!-- 				<p class="btn"> -->
<%-- 				<a href="javascript:report()"><img src="<c:url value='/images/common/btn_reportPrint.gif'/>" alt="보고서 출력" /></a>   --%>
<!-- 				</p> -->
<%-- 				</c:if> --%>
			</div>
		</div>
	</div>
	<form name="report" method="post" action="<c:url value='/common/rdView.do'/>">
		<input type="hidden" name="mrdpath" />
		<input type="hidden" name="param" />
	</form>
</body>
</html>
