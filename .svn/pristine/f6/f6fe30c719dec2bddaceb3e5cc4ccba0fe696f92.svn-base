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
		<div style="font-size:20px;text-align:center;font-weight:bold;padding:10px 0;">
			<u>상황실 근무일지</u>
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
				<%-- <tr>
					<td style="height:20px;" align="center"><c:out value="${approvalList[0].approvalDate}"></c:out></td>
					<td align="center"><c:out value="${approvalList[1].approvalDate}"></c:out></td>
				</tr> --%>
			</table>
		</div>
		<div>
			<div class="titleBx">▶ 기안 : <c:out value="${dailyWorkVO.approvalName}"/> (<c:out value="${dailyWorkVO.regDate}"/>)</div>
		</div>
		<div>
			<div class="titleBx">▶ 일자</div>
			<div class="contextBx">
				<div style="margin:4px;">일자 : <c:out value="${dailyWorkVO.workDay}"/></div>
				<div style="margin:4px;">날씨 : <c:out value="${situationRoomVO.weather}"/></div>
			</div>
		</div>
		<div>
			<div class="titleBx">▶ 근무상황</div>
			<div class="contextBx">
				<div class="titleBx" style="padding:0;margin:4px 4px 10px 4px;">[근무내용]</div>
				<div style="margin:4px;clear:both;">
					근무시간 : <c:out value="${situationRoomVO.mTime}"></c:out><br/>
			 		근무자 :<c:out value="${situationRoomVO.mId}"/><br/>	
					작성시간 : <c:out value="${situationRoomVO.mRegDate}"></c:out><br/>
				</div>
				<div style="margin:4px;"><c:out value="${situationRoomVO.mContent}"/></div>
				
				<div style="margin:25px 4px 4px 4px;clear:both;">
					근무시간 : <c:out value="${situationRoomVO.aTime}"></c:out><br/>
			 		근무자 :<c:out value="${situationRoomVO.aId}"/><br/>	
					작성시간 : <c:out value="${situationRoomVO.aRegDate}"></c:out><br/>
				</div>
				 
				<div style="margin:4px;"><c:out value="${situationRoomVO.aContent}"/></div>
				
				<div style="margin:25px 4px 4px 4px;clear:both;">
					근무시간 : <c:out value="${situationRoomVO.nTime}"></c:out><br/>
			 		근무자 :<c:out value="${situationRoomVO.nId}"/><br/>
					작성시간 : <c:out value="${situationRoomVO.nRegDate}"></c:out><br/>
				</div>
				 
				<div style="margin:4px;"><c:out value="${situationRoomVO.nContent}"/></div>
				
				<div class="titleBx" style="padding:0;margin:15px 4px 10px 4px;">[특이사항]</div>
				<div style="clear:both;">
					<div style="margin:10px 4px 4px 4px;">사고접수</div>
					<div style="margin:4px;"><c:out value="${situationRoomVO.nContent}"/></div>
				</div>
				
				<div style="clear:both;">
					<div style="margin:20px 4px 4px 4px;">기타</div>
					<div style="margin:4px;"><c:out value="${situationRoomVO.etcContent}"/></div>
				</div>
			</div>

			<div class="titleBx">▶ 상황전파현황</div>
			<div class="contextBx">
				<div class="titleBx" style="padding:0;margin:4px 4px 0 4px;">사고전파</div>
				
				<c:forEach var="result" items="${spreadSList}" varStatus="status">
					<div style="margin:14px 4px 4px 4px;"><c:out value="${result.hour}"/>:<c:out value="${result.min}"/></div>
					<div style="margin:4px;">
						<c:set var="coma" value="0"/>
						<c:if test="${result.targetMe == 'Y'}">환경처</c:if>
						<c:if test="${result.targetGov == 'Y'}"><c:if test='${coma ne "0"}'> ,</c:if><c:set var="coma" value="${coma+1}"/>지자체</c:if>
						<c:if test="${result.targetKeco == 'Y'}"><c:if test='${coma ne "0"}'> ,</c:if><c:set var="coma" value="${coma+1}"/>본사</c:if>
						<c:if test="${result.targetArea == 'Y'}"><c:if test='${coma ne "0"}'> ,</c:if><c:set var="coma" value="${coma+1}"/><c:out value="${result.targetAreaDetail}"/> 지역본부</c:if>
						<c:if test="${result.targetSigongsa == 'Y'}"><c:if test='${coma ne "0"}'> ,</c:if><c:set var="coma" value="${coma+1}"/>시공사</c:if>
						<c:if test="${result.targetEtc == 'Y'}"><c:if test='${coma ne "0"}'> ,</c:if><c:set var="coma" value="${coma+1}"/>기타</c:if>
					</div>
					<div style="margin:4px;"><c:out value="${fn:replace(result.content,crlf,'<BR/>')}" escapeXml="false"/></div>
				</c:forEach>
				<c:if test="${empty spreadSList}">
					<div style="margin:8px 4px 4px 4px;">전파 내역이 없습니다.</div>
				</c:if>
				
				<div class="titleBx" style="padding:0;margin:20px 4px 0 4px;">기상특보</div>
				<c:forEach var="result" items="${spreadGList}" varStatus="status">
					<div style="margin:14px 4px 4px 4px;"><c:out value="${result.hour}"/>:<c:out value="${result.min}"/></div>
					<div style="margin:4px;">
						<c:set var="coma" value="0"/>
						<c:if test="${result.targetMe == 'Y'}">환경처</c:if>
						<c:if test="${result.targetGov == 'Y'}"><c:if test='${coma ne "0"}'> ,</c:if><c:set var="coma" value="${coma+1}"/>지자체</c:if>
						<c:if test="${result.targetKeco == 'Y'}"><c:if test='${coma ne "0"}'> ,</c:if><c:set var="coma" value="${coma+1}"/>본사</c:if>
						<c:if test="${result.targetArea == 'Y'}"><c:if test='${coma ne "0"}'> ,</c:if><c:set var="coma" value="${coma+1}"/><c:out value="${result.targetAreaDetail}"/> 지역본부</c:if>
						<c:if test="${result.targetSigongsa == 'Y'}"><c:if test='${coma ne "0"}'> ,</c:if><c:set var="coma" value="${coma+1}"/>시공사</c:if>
						<c:if test="${result.targetEtc == 'Y'}"><c:if test='${coma ne "0"}'> ,</c:if><c:set var="coma" value="${coma+1}"/>기타</c:if>
					</div>
					<div style="margin:4px;"><c:out value="${fn:replace(result.content,crlf,'<BR/>')}" escapeXml="false"/></div>
				</c:forEach>
				<c:if test="${empty spreadGList}">
					<div style="margin:8px 4px 4px 4px;">특보 내역이 없습니다.</div>
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