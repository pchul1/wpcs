<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pj" uri="ProjectJstlUtil"%>
<%pageContext.setAttribute("crlf", "\r\n");%> 
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="업무일지" name="title"/>
</jsp:include>
<script type="text/javascript">
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
			document.registform.action = "<c:url value='/mobile/sub/dailywork/approvalReturnProc.do'/>"; 
		}else{
			document.registform.action = "<c:url value='/mobile/sub/dailywork/approvalProc.do'/>"; 
		}
		document.registform.submit();
	}
}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/dailywork/dailyWorkSearch.do" name="link"/>
		<jsp:param value="업무일지" name="title"/>
	</jsp:include>
<div> 
    
	<jsp:include page="/WEB-INF/jsp/mobile/sub/dailywork/dailyCommonTop.jsp">
		<jsp:param value="Y" name="dailygubun"/>
	</jsp:include>
	<div class="dailyview"> 
		<div style="font-size:15px;text-align:center;font-weight:bold;padding:10px 0;">
			상황실 근무일지
		</div>
		<div style="margin:10px 10px;padding:5px 5px;">
			<table width="100%">
				<colgroup>
				<col width="10%" />
				<col width="45%" />
				<col width="45%" />
				</colgroup>
				<tr>
					<th rowspan="3" style="height:120px;text-align:center;" align="center">결<br/><br/>재</th>
					<td style="height:20px;" align="center"><b><c:out value="${approvalList[0].approvalName}"/></b></td>
					<td align="center"><b><c:out value="${approvalList[1].approvalName}"></c:out></b></td>
				</tr>
				<tr>
					<td style="height:80px;" align="center">
					<c:if test="${not empty approvalList[0].signature_file}">
						<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
							<c:param name="atchFileId" value="${approvalList[0].signature_file}" />
						</c:import>
					</c:if>
					</td>
					<td align="center">
					<c:if test="${not empty approvalList[1].signature_file}">
						<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
							<c:param name="atchFileId" value="${approvalList[1].signature_file}" />
						</c:import>
					</c:if>
					</td>
				</tr>
				<tr>
					<td style="height:20px;" align="center"><c:out value="${approvalList[0].approvalDate}"></c:out></td>
					<td align="center"><c:out value="${approvalList[1].approvalDate}"></c:out></td>
				</tr>
			</table>
		</div>
		<div>
			<div class="titleBx">▶ 일자</div>
			<div class="contextBx">
				<div style="margin:4px;">일자 : <c:out value="${dailyWorkVO.workDay}"/></div>
				<div style="margin:4px;">날씨 : <c:out value="${monitoringVO.weather}"/></div>
			</div>
		</div>
		
		<div class="titleBx">▶ 수질예측정보</div>
		<div class="contextBx">
			<c:forEach begin="0" end="${fn:length(forecastSList) -1}" step="1" var="i">
				<c:if test="${i eq 0}"><div class="titleBx" style="padding:4px 4px 0 4px;clear:both ">[한강]</div></c:if>
				<c:if test="${i eq 3}"><div class="dotline"></div><div class="titleBx" style="padding:4px 4px 0 4px;clear:both ">[금강]</div></c:if>
				<c:if test="${i eq 7}"><div class="dotline"></div><div class="titleBx" style="padding:4px 4px 0 4px;clear:both ">[영산강]</div></c:if>
				<c:if test="${i eq 9}"><div class="dotline"></div><div class="titleBx" style="padding:4px 4px 0 4px;clear:both ">[낙동강]</div></c:if>
				<div style="padding:4px;">
					<div class="titleBx" style="padding:10px 4px;clear:both;">
					<c:if test="${i eq 0}">■ 강천     </c:if>
					<c:if test="${i eq 1}">■ 여주     </c:if>
					<c:if test="${i eq 2}">■ 이포     </c:if>
					<c:if test="${i eq 3}">■ 세종     </c:if>
					<c:if test="${i eq 4}">■ 공주     </c:if>
					<c:if test="${i eq 5}">■ 백제     </c:if>
					<c:if test="${i eq 6}">■ 승촌     </c:if>
					<c:if test="${i eq 7}">■ 죽산     </c:if>
					<c:if test="${i eq 8}">■ 상주     </c:if>
					<c:if test="${i eq 9}">■ 낙단     </c:if>
					<c:if test="${i eq 10}">■ 구미     </c:if>
					<c:if test="${i eq 11}">■ 칠곡     </c:if>
					<c:if test="${i eq 12}">■ 강정·고령</c:if>
					<c:if test="${i eq 13}">■ 달성     </c:if>
					<c:if test="${i eq 14}">■ 합청·창녕</c:if>
					<c:if test="${i eq 15}">■ 창녕·함안</c:if> 
					</div>
					<div style="height:43px;">
						<div style="width:30%;float:left;padding:4px;">
							<div style="float:left;">일자 : </div>
							<div style="float:left;padding-left:4px;"><c:out value="${forecastSList[i].forecastDay}"/></div>
						</div>
						<div style="width:30%;float:left;padding:4px;">
							<div style="float:left;">현황 : </div>
							<div style="float:left;padding-left:4px;"><c:out value="${forecastSList[i].forecastStatus}"/></div>
						</div>
						<div style="width:30%;float:left;padding:4px;">
							<div style="float:left;">농도 : </div>
							<div style="float:left;padding-left:4px;"><c:out value="${forecastSList[i].forecastCon}"/></div>
						</div>
						<div style="width:30%;float:left;padding:4px;">
							<div style="float:left;">남조류 : </div>
							<div style="float:left;padding-left:4px;"><c:out value="${forecastSList[i].forecastTidal}"/></div>
						</div>
						<div style="width:30%;float:left;padding:4px;">
							<div style="float:left;">자동 : </div>
							<div style="float:left;padding-left:4px;"><c:out value="${forecastSList[i].forecastAuto}"/></div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
		
		<div class="titleBx">▶ 조류제거(순출)지원 등 현황</div>
		<div class="contextBx">
			<c:out value="${fn:replace(monitoringVO.supportStatus,crlf,'<br/>')}" escapeXml="false"/>
			<br/>
			<c:if test="${not empty monitoringVO.atchFileId}">
				<c:import url="/cmmn/selectFileInfs.do" charEncoding="utf-8">
					<c:param name="param_atchFileId" value="${monitoringVO.atchFileId}" />
				</c:import>
			</c:if>
		</div>
		
		<div class="titleBx">▶ 강우현황(mm)</div>
		<div class="contextBx">
		
			<div class="titleBx" style="padding:4px 4px 10px 4px;clear:both ">[한강]</div>
			<div style="padding:4px;height:20px;">
				<div style="width:30%;float:left;padding:4px;">
					<div style="float:left;">여주 : </div>
					<div style="float:left;padding-left:4px;"><c:out value="${rainFallList[0].rainFall}"/></div>
				</div>
				<div style="width:60%;float:left;padding:4px;">
					<div style="float:left;">충주 : </div>
					<div style="float:left;padding-left:4px;"><c:out value="${rainFallList[1].rainFall}"/></div>
				</div>
			</div>
			
			<div class="dotline"></div>
			
			<div class="titleBx" style="clear:both;padding:4px 4px 10px 4px;">[금강]</div>
			<div style="padding:4px;height:20px;">
				<div style="width:30%;float:left;padding:4px;">
					<div style="float:left;">부여 : </div>
					<div style="float:left;padding-left:4px;"><c:out value="${rainFallList[2].rainFall}"/></div>
				</div>
				<div style="width:30%;float:left;padding:4px;">
					<div style="float:left;">공주 : </div>
					<div style="float:left;padding-left:4px;"><c:out value="${rainFallList[3].rainFall}"/></div>
				</div>
				<div style="width:30%;float:left;padding:4px;">
					<div style="float:left;">연기 : </div>
					<div style="float:left;padding-left:4px;"><c:out value="${rainFallList[4].rainFall}"/></div>
				</div>
			</div>
			
			<div class="dotline"></div>
			
			<div class="titleBx" style="clear:both;padding:4px 4px 10px 4px;clear:both;">[영산강]</div>
			<div style="padding:4px;height:20px;">
				<div style="width:30%;float:left;padding:4px;">
					<div style="float:left;">나주 : </div>
					<div style="float:left;padding-left:4px;"><c:out value="${rainFallList[5].rainFall}"/></div>
				</div>
				<div style="width:30%;float:left;padding:4px;">
					<div style="float:left;">광주 : </div>
					<div style="float:left;padding-left:4px;"><c:out value="${rainFallList[6].rainFall}"/></div>
				</div>
			</div>
			
			<div class="dotline"></div>
			
			<div class="titleBx" style="clear:both;padding:4px 4px 10px 4px;clear:both;">[낙동강]</div>
			<div style="padding:4px;height:40px;">
				<div style="width:30%;float:left;padding:4px;">
					<div style="float:left;">부산 : </div>
					<div style="float:left;padding-left:4px;"><c:out value="${rainFallList[7].rainFall}"/></div>
				</div>
				<div style="width:30%;float:left;padding:4px;">
					<div style="float:left;">창녕 : </div>
					<div style="float:left;padding-left:4px;"><c:out value="${rainFallList[8].rainFall}"/></div>
				</div>
				<div style="width:30%;float:left;padding:4px;">
					<div style="float:left;">합천 : </div>
					<div style="float:left;padding-left:4px;"><c:out value="${rainFallList[9].rainFall}"/></div>
				</div>
				<div style="width:30%;float:left;padding:4px;">
					<div style="float:left;">대구 : </div>
					<div style="float:left;padding-left:4px;"><c:out value="${rainFallList[10].rainFall}"/></div>
				</div>
				<div style="width:30%;float:left;padding:4px;">
					<div style="float:left;">구미 : </div>
					<div style="float:left;padding-left:4px;"><c:out value="${rainFallList[11].rainFall}"/></div>
				</div>
				<div style="width:30%;float:left;padding:4px;">
					<div style="float:left;">안동 : </div>
					<div style="float:left;padding-left:4px;"><c:out value="${rainFallList[12].rainFall}"/></div>
				</div>
			</div>
		</div>
		<div style="padding-top:10px;">
			<c:if test="${menuGubun eq 'dailyWork'}">
				<ul class="sbtn">
					<li style="width:90%;"><a href="<c:url value="/mobile/sub/dailywork/dailyWorkList.do${listparameter }"/>">목록보기</a></li> 
				</ul>
			</c:if>
			<c:if test="${menuGubun == 'app'}">
				<c:if test="${appCheck=='Y'}">
		    		<form name="registform" method="post" onsubmit="return false;">
						<input type="hidden" id="mId" name="mId" value="<c:out value="${monitoringVO.mId}"/>"/>
						<input type="hidden" id="dailyWorkId" name="dailyWorkId" value="<c:out value="${dailyWorkVO.dailyWorkId}"/>"/>
						<input type="hidden" id="menuGubun" name="menuGubun" value="<c:out value="${menuGubun}"/>"/>
						<input type="hidden" id="checkDailyWorkId" name="checkDailyWorkId" />
						<input type="hidden" id="workDay" name="workDay"  value="<c:out value="${dailyWorkVO.workDay}"/>"/> 
						<input type="hidden" id="approvalSeq" name="approvalSeq"  value="<c:out value="${seq}"/>"/>
						<input type="hidden" id="appGubun" name="appGubun"/>
						<input type="hidden" id="startDate" name="startDate" value="<c:out value="${param.startDate }"/>"/>
						<input type="hidden" id="endDate" name="endDate" value="<c:out value="${param.endDate }"/>"/>
						<input type="hidden" id="searchState" name="searchState" value="<c:out value="${param.searchState }"/>"/>
						<div class="titleBx">▶ 의견</div>
						<div class="contextBx">
							<textarea name="approvalComment" id="approvalComment" rows="2" style="width:98%;"></textarea>
						</div>
						<div style="float:left; width:50%;text-align:center;">
							<ul class="sbtn"> 
								<li style="width:90%"><a href="#" onclick="fnApp('return'); return false;">반려</a></li>
							</ul>
						</div>
						<div style="float:left; width:50%;text-align:center;">
							<ul class="sbtn">
								<li style="width:90%"><a href="#" onclick="fnApp('app'); return false;">결재</a></li>
							</ul>
						</div> 
					</form>
				</c:if>
				<c:if test="${appCheck ne 'Y'}">
				<ul class="sbtn">
					<li style="width:90%;"><a href="<c:url value="/mobile/sub/dailywork/receiveApprovalList.do${listparameter }"/>">목록보기</a></li> 
				</ul>
				</c:if>
			</c:if>
		</div>
	</div>
</div>

</body>
</html>