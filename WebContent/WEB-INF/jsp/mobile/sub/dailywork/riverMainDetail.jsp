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
		<u>4대강 주요수계 상시감시 결과 일일보고</u>
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
					<td align="center"><b><c:out value="${approvalList[1].approvalName}"/></b></td>
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
					<td style="height:20px;" align="center"><c:out value="${approvalList[0].approvalDate}"/></td>
					<td align="center"><c:out value="${approvalList[1].approvalDate}"/></td>
				</tr>
			</table>
		</div>
		<div>
			<div class="titleBx">▶ 일자</div>
			<div class="contextBx">
				<div style="margin:4px;">일자 : <c:out value="${dailyWorkVO.workDay}"/></div>
			</div>
		</div>
		<div>
			<div class="titleBx">▶ 상시감시 주요결과 <br/>
			&nbsp;&nbsp;(방제센터 및 지역본부 방제팀 세부내용)</div>
			<div class="contextBx">
				<div class="titleBx" style="padding:4px;">[수질오염상황팀]</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 감시구간</div>
					<div style="margin:4px 15px;">4대강 등 주요하천 및 주변</div>
				</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 감시시간(횟수)</div>
					<div style="margin:4px 15px;">24시간</div>
				</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 확인결과/조치사항</div>
					<div style="margin:4px 15px;"><c:out value="${empty riverMainVO.situationteamContent1 ? '특이사항 없음' : fn:replace(riverMainVO.situationteamContent1,crlf,'<BR/>')}" escapeXml="false"/></div>
				</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 특이사항</div>
					<div style="margin:4px 15px;"><c:out value="${empty riverMainVO.situationteamContent2 ? ' 없음' : fn:replace(riverMainVO.situationteamContent2,crlf,'<BR/>')}" escapeXml="false"/></div>
				</div>
				
				<div class="dotline"></div>
				
				<div class="titleBx" style="padding:5px 4px 4px 4px;">[수도권 동부]</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 감시구간</div>
					<div style="margin:4px 15px;">한강 (북한강, 남한강)</div>
				</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 감시시간(횟수)</div>
					<div style="margin:4px 15px;">10:00 ~ 17:00 (일 1회)</div>
				</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 확인결과/조치사항</div>
					<div style="margin:4px 15px;"><c:out value="${empty riverMainVO.capitalAreaContent1 ? '특이사항 없음' : fn:replace(riverMainVO.capitalAreaContent1,crlf,'<BR/>')}" escapeXml="false"/></div>
				</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 특이사항</div>
					<div style="margin:4px 15px;"><c:out value="${empty riverMainVO.capitalAreaContent2 ? ' 없음' : fn:replace(riverMainVO.capitalAreaContent2,crlf,'<BR/>')}" escapeXml="false"/></div>
				</div>
				
				<div class="dotline"></div>
				
				<div class="titleBx" style="padding:5px 4px 4px 4px;">[경북권_낙동강(대구청)]</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 감시구간</div>
					<div style="margin:4px 15px;">낙동강(대구청) – 구미, 상주, 예천</div>
				</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 감시시간(횟수)</div>
					<div style="margin:4px 15px;">09:30 ~ 16:20</div>
				</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 확인결과/조치사항</div>
					<div style="margin:4px 15px;"><c:out value="${empty riverMainVO.gyeongbuk1Content1 ? '특이사항 없음' : fn:replace(riverMainVO.gyeongbuk1Content1,crlf,'<BR/>')}" escapeXml="false"/></div>
				</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 특이사항</div>
					<div style="margin:4px 15px;"><c:out value="${empty riverMainVO.gyeongbuk1Content2 ? ' 없음' : fn:replace(riverMainVO.gyeongbuk1Content2,crlf,'<BR/>')}" escapeXml="false"/></div>
				</div>
				
				<div class="dotline"></div>
				
				<div class="titleBx" style="padding:5px 4px 4px 4px;">[경북권_낙동강(낙동강청)]</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 감시구간</div>
					<div style="margin:4px 15px;">낙동강(낙동강청) – 창녕, 함안</div>
				</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 감시시간(횟수)</div>
					<div style="margin:4px 15px;">13:20 ~ 18:15</div>
				</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 확인결과/조치사항</div>
					<div style="margin:4px 15px;"><c:out value="${empty riverMainVO.gyeongbuk2Content1 ? '특이사항 없음' : fn:replace(riverMainVO.gyeongbuk2Content1,crlf,'<BR/>')}" escapeXml="false"/></div>
				</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 특이사항</div>
					<div style="margin:4px 15px;"><c:out value="${empty riverMainVO.gyeongbuk2Content2 ? ' 없음' : fn:replace(riverMainVO.gyeongbuk2Content2,crlf,'<BR/>')}" escapeXml="false"/></div>
				</div>
				
				<div class="dotline"></div>
				
				<div class="titleBx" style="padding:5px 4px 4px 4px;">[충청권]</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 감시구간</div>
					<div style="margin:4px 15px;">금강 – 서천, 익산, 논산, 공주, 세종, 옥천</div>
				</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 감시시간(횟수)</div>
					<div style="margin:4px 15px;">10:30 ~ 17:20</div>
				</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 확인결과/조치사항</div>
					<div style="margin:4px 15px;"><c:out value="${empty riverMainVO.chungcheongContent1 ? '특이사항 없음' : fn:replace(riverMainVO.chungcheongContent1,crlf,'<BR/>')}" escapeXml="false"/></div>
				</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 특이사항</div>
					<div style="margin:4px 15px;"><c:out value="${empty riverMainVO.chungcheongContent2 ? ' 없음' : fn:replace(riverMainVO.chungcheongContent2,crlf,'<BR/>')}" escapeXml="false"/></div>
				</div>
				
				<div class="dotline"></div>
				
				<div class="titleBx" style="padding:5px 4px 4px 4px;">[호남권]</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 감시구간</div>
					<div style="margin:4px 15px;">영산강 – 극락교, 송촌보, 죽산보</div>
				</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 감시시간(횟수)</div>
					<div style="margin:4px 15px;">10:00 ~ 17:00 (일 1회)</div>
				</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 확인결과/조치사항</div>
					<div style="margin:4px 15px;"><c:out value="${empty riverMainVO.honamContent1 ? '특이사항 없음' : fn:replace(riverMainVO.honamContent1,crlf,'<BR/>')}" escapeXml="false"/></div>
				</div>
				<div>
					<div style="margin:10px 4px 4px 4px;">■ 특이사항</div>
					<div style="margin:4px 15px;"><c:out value="${empty riverMainVO.honamContent2 ? ' 없음' : fn:replace(riverMainVO.honamContent2,crlf,'<BR/>')}" escapeXml="false"/></div>
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