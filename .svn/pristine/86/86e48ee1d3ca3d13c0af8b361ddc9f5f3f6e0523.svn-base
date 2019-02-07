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
			
			$("#chart").load(function() {graphLoaded();});
			chart();
		});
		
		function graphLoaded()
		{
			$("#graphLoading").hide();
		}
		
		function chart(){
			$("#span_loading").show();

			var width = "420";
			var height = "180";
			
			var sugye = "<c:out value="${asData.riverDiv}"/>";
			var gongku = "<c:out value="${asData.factCode}"/>";
			var chukjeongso = "<c:out value="${asData.branchNo}"/>";
			
			var minTime = "<c:out value="${asData.minTimeStr}"/>";
			var endTime = "<c:out value="${endTime}"/>";
			
			var item = "<c:out value="${asData.itemCode}"/>";
			var item2 = "<c:out value="${asData.itemCode2}"/>";  
			var item3 = "<c:out value="${asData.itemCode3}"/>";
			var sys = "<c:out value="${asData.system}"/>";
			
			if(sys == "U")
			{
				minTime = "<c:out value="${asData.OMinTime}"/>";
				
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

			var src = "<c:url value='/waterpolmnt/waterinfo/getChartDetalViewRIVER.do?'/>";
			$('#chart').attr("src", src + encodeURI(param));
		}
		
		var type = "<c:out value="${asData.itemType}"/>";
	</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/alert/alertMngSearch.do" name="link"/>
		<jsp:param value="상황관리" name="title"/>
	</jsp:include>
<div> 
    
	<c:set var="listparameter" value='${pj:ParamString(param_s,"system,startDate,endDate,itemType,minOr,asId")}&alertStep'/>
	<jsp:include page="/WEB-INF/jsp/mobile/sub/alert/CommonAlertMngNumber.jsp">
		<jsp:param value="${listparameter}" name="listparameter"/>
		<jsp:param value="6" name="stepno"/>
		<jsp:param value="${asData.alertStep}" name="alertStep"/>
		<jsp:param value="${AllstepList}" name="AllstepList"/>
	</jsp:include>
	<div class="write">
		<div class="titleBx">▶ 상황발생</div>
		<table summary="접수정보" style="text-align:left">
			<colgroup> 
				<col width="120px" />
				<col width="*" /> 
			</colgroup> 
			
			<tr>
				<th>경보 발생 시각</th>
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
				<th>경보단계</th>
				<td>
					<c:out value="${asData.minOr}"/>
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
				<th>경보 등록 시각</th>
				<td>
					<c:if test="${asData.itemType == null}">
						<c:out value="${asData.alertTime}"/>
					</c:if>
					<c:if test="${asData.itemType != null}">
						<c:out value="${asData.alertTime}"/>
					</c:if>
				</td>
			</tr>
			<tr>
				<th>항목</th>
				<td>
					<c:out value="${asData.itemName}"/>
					<c:if test="${asData.itemName2 != null}">
					/ <c:out value="${asData.itemName2}"/>
					</c:if>
					<c:if test="${asData.itemName3 != null}">
					/ <c:out value="${asData.itemName3}"/>
					</c:if>
				</td>
			</tr>
			<tr>
				<th>측정값</th>
				<td>
					<c:if test="${asData.itemType == null}">
						<c:out value="${asData.minVl}"/>
						<c:if test="${asData.minVl2 != null}">
						/ <c:out value="${asData.minVl2}"/>
						</c:if>
						<c:if test="${asData.minVl3 != null}">
						/ <c:out value="${asData.minVl3}"/>
						</c:if>
					</c:if>
					
					<c:if test="${asData.itemType != null}">
						-
					</c:if>
				</td>
			</tr>
			<tr>
				<th>경보기준</th>
				<td>
					<c:if test="${asData.itemType == null}">
						<c:if test="${law.lawLValue != null && law.lawLValue != '0.0'}">
							<c:out value="${law.lawLValue}"/> 이하,
						</c:if>
						<c:out value="${law.lawHValue}"/> 이상
						/
						<c:if test="${law2 != null}">
							<c:if test="${law2.lawLValue != null && law2.lawLValue != '0.0'}">
								<c:out value="${law2.lawLValue}"/> 이하
							</c:if>
								<c:out value="${law2.lawHValue}"/> 이상
						</c:if>
					</c:if>
					
					<c:if test="${asData.itemType != null}">
						-
					</c:if>
				</td>
			</tr>
		</table>
		<div class="titleBx" style="margin-top:20px;">
			▶ 조치이력
		</div>
		<div class="listBx">
			<div class="content">
				<div style="padding:5px 0;">
					<c:forEach  items="${dataList}"  var="dataList"  varStatus="status">
						<c:if test="${dataList.alertStepNum eq '2'}">
							경보발생(<c:out value="${asData.itemTypeName}"/>) → 
						</c:if>
						<c:if test="${dataList.alertStepNum eq '7'}">
							경보발생(<c:out value="${asData.itemTypeName}"/>) → 상황종료(이상데이터)
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
				</div>
			</div>
		</div>

		<div class="titleBx" style="margin-top:20px;">
			▶ 조치사항
		</div>
		<div class="listBx">
			<c:forEach  items="${dataList}"  var="dataList"  varStatus="status">
				<div class="content" style="padding:10px 0;">
					<c:if test="${dataList.alertStepNum != '0'}">
						<div>
							<c:if test="${dataList.alertStepNum eq '1'}">
								<c:out value="${asData.alertTime}"/>
							</c:if>
							<c:if test="${dataList.alertStepNum != '1'}">
								<c:out value="${dataList.alertStepTime}"/>
							</c:if>
							
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
						</div>
						<div style="margin-top:4px;">
							<c:if test="${dataList.alertStepNum eq '8'}">
								상황종료
							</c:if>
							<c:if test="${dataList.alertStepNum != '8'}">
								<c:out value="${dataList.alertStepText}"/>
							</c:if>
						</div>
					</c:if>
					<c:if test="${dataList.alertStepNum eq '3'}">  
						<div style="padding:5px 0;">
							<c:set var="moveGov" value="${dataList.moveGov}"></c:set>
						</div>
					</c:if>
				</div>
			</c:forEach>
		</div>

		<div class="titleBx" style="margin-top:20px;">
			▶ 오염도 추이
		</div>
		<div id="data_graph" style="overflow:hidden;height:200px;margin-top:10px;">
			<span id="graphLoading" style="position:absolute;">그래프를 불러오는 중 입니다...</span>
			<iframe id="chart" src="" scrolling="no" marginwidth="0" marginheight="0" frameborder="0" width="100%" height="100%"></iframe>
		</div>

		<div class="titleBx" style="margin-top:10px;">▶ 연관정보</div>
		<table summary="담당" style="text-align:left">
			<colgroup> 
				<col width="120px" />
				<col width="*" /> 
			</colgroup> 
			<tr>
				<th>상류정보</th>
				<td></td>
			</tr>
			<tr>
				<th>하류정보</th>
				<td></td>
			</tr>
		</table>
		
		<div class="titleBx" style="margin-top:20px;">▶ 담당</div>
		<table summary="담당" style="text-align:left">
			<colgroup> 
				<col width="120px" />
				<col width="*" /> 
			</colgroup> 
			
			<c:forEach  items="${dataList}"  var="dataList"  varStatus="status">
				<c:if test="${dataList.alertStepNum eq '3' || dataList.alertStepNum eq '6'}">
					<tr>
						<th>담당기관</th>
						<td>${dataList.gov}</td>
					</tr>
					<tr>
						<th>담당자</th>
						<td>${dataList.person}</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>${dataList.phone}</td>
					</tr>
				</c:if>
				<c:if test="${dataList.alertStepNum eq '4' || dataList.alertStepNum eq '10'}">
					<tr>
						<th>분석기관</th>
						<td>${dataList.analGov}</td>
					</tr>
					<tr>
						<th>담당자</th>
						<td>${dataList.analPerson}</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>${dataList.analPhone}</td>
					</tr>
				</c:if>
				<c:if test="${dataList.alertStepNum eq '8'}">
					<tr>
						<th>작성기관</th>
						<td>${dataList.procGov}</td>
					</tr>
					<tr>
						<th>담당자</th>
						<td>${dataList.procPerson}</td>
					</tr>
					<tr>
						<th>연락처</th>
						<td>${dataList.procPhone}</td>
					</tr>
				</c:if>
			</c:forEach>
		</table>
		<c:set var="listparameter" value='${pj:ParamString(param_s,"system,startDate,endDate,itemType")}'/>
		<div style="margin:20px 0 0 0;">
			<ul class="sbtn" style="width:100%;text-align:center;">
				<li style="width:90%;">
					<a href="<c:url value="/mobile/sub/alert/alertMngList.do${listparameter}"/>">확인</a>
				</li>
			</ul>
		</div> 
	</div>
</div>

</body>
</html>