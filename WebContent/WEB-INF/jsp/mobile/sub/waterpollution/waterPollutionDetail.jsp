<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%pageContext.setAttribute("crlf", "\r\n");%> 
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="사고관리" name="title"/>
</jsp:include>
<script type="text/javascript">
//<![CDATA[
           
	$(function () {
		
		$("#dept").change(function(){
			setPerson(); //직원셋팅
		});
		
		setDept();		//부서셋팅
	});
	
	//저장 
	function fnSave(){
		if(!vailidation($("#wpKind"),"사고유형을 선택해 주십시요.")) return false;
		if(!vailidation($("#riverDiv"),"수계를 선택해 주십시요.")) return false;
		if(!vailidation($("#supportKind"),"지원유형을 선택해 주십시요.")) return false;
		if(!vailidation($("#address"),"사고지점을 입력해 주십시요.")) return false;
		if(!vailidation($("#wpContent"),"사고내용을 입력해 주십시요.")) return false;

		if(confirm("저장 하시겠습니까?")){
			document.registform.submit();
		}
	}
	
	function popupClose(){
		$(".b-close").click();
	}
	//좌표 지정 팝업
	function lon_lat(X,Y){
		var url="/mobile/sub/waterpollution/waterMap.do?X=" + X + "&Y=" + Y;
		$("#ifrm").attr("src",url);
		$("#ifrm").css("height","280px");
		$("#popupStep").bPopup();
	}

	//좌표 지정 팝업
	function goStepAdd(){
		var url = "/mobile/sub/waterpollution/waterPollutionStepPopup.do?wpCode=<c:out value="${View.wpCode}"/>";
		$("#ifrm").attr("src",url);
		$("#ifrm").css("height","230px");
		$("#popupStep").bPopup();
	}
	

	//좌표 지정 팝업
	function goStepModify(wpsCode){
		var url = "/mobile/sub/waterpollution/waterPollutionStepModifyPopup.do?wpCode=<c:out value="${View.wpCode}"/>&wpsCode=" + wpsCode;
		$("#ifrm").attr("src",url);
		$("#ifrm").css("height","230px");
		$("#popupStep").bPopup();
	}
	
	//부서별 직원생성
	function setPerson(){
		var value = $("#dept > option:selected").val();
		var dropDownSet = $("#person");
		
		if(value == undefined)
			return;
		
		$.getJSON("<c:url value='/alert/getGroupAndMember.do'/>",
				{
					orderType:"2",
					value:value
				},
				//, system:sys_kind},
				function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					
					dropDownSet.loadSelect(data.groupList);
					//adjustBranchList();
				
				} else {
					return;
				}
		});
	}
	
	//부서생성
	function setDept(){
		var dropDownSet = $("#dept");
		
		$("#sPerson").emptySelect();
		
		$.getJSON("<c:url value='/alert/getGroupAndMember.do'/>",
			{
				orderType:"1"
			},
			//, system:sys_kind},
			function (data, status){
				if(status == 'success'){
					//locId 객체에 SELECT 옵션내용 추가.
					
					dropDownSet.loadSelect(data.groupList);
					
					setPerson();
					//adjustBranchList();
					
				} else {
					return;
				}
		});
	}
	
	function addzero(n) {
		return n < 10 ? "0" + n : n + "";
	}
	
	function getWpStepData(wpsCode , wpsStepDate , wpsContent , wpsStep, wpsImg)
	{
		var html = "<div id=\"step"+wpsCode+"\" class=\"listBx\">" + getWpStepContent(wpsCode , wpsStepDate , injectionscript(wpsContent) , wpsStep, wpsImg) + "</div>";
		var org_div = $("#stepList").html();
		$("#stepList").html(html + org_div);
		$(".b-close").click();
	}

	function getWpStepDel(wpsCode){
		$("#step" + wpsCode).html('');
		$(".b-close").click();
	}
	

	function getWpStepImgDel(wpsCode){
		$("#step" + wpsCode).find("img[img_id='file_img']").remove();
		$(".b-close").click();
	}
	
	function getWpStepModify(wpsCode , wpsStepDate , wpsContent , wpsStep, wpsImg)
	{
		$("#step" + wpsCode).html(getWpStepContent(wpsCode , wpsStepDate , injectionscript(wpsContent) , wpsStep, wpsImg));
		$(".b-close").click();
	}
	
	function getWpStepContent(wpsCode , wpsStepDate , wpsContent , wpsStep, wpsImg)
	{
		var html = "<div class=\"title\">" + 
		"	<div style=\"float:left;\">No."+ wpsCode + "&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"+ wpsStepDate + "</div>" + 
		"	<div style=\"float:right;padding:0 10px 0 0;\"><a href=\"#\" onclick=\"goStepModify('" + wpsCode + "'); return false;\"><img src=\"/images/mobile/btn_detail_info.png\" align=\"absmiddle\" width=\"52\" height=\"18\" border=\"0\"/></a></div>" + 
		"</div>" + 
		"<div class=\"content\">" + 
		"	<div style=\"padding:5px 0;\">";

		if(wpsStep == "STA") html += "신고";
		if(wpsStep == "RCV") html += "접수";
		if(wpsStep == "ING") html += "수습중";
		if(wpsStep == "END") html += "조치완료";
		
		html += "	</div>" + 
		"	<div style=\"padding:5px 0;\">" + 
		"		<table cellpadding = \"0\" cellspacing = \"0\" width=\"100%\">" + 
		"		<tr>" + 
		"			<td align=\"left\" style=\"padding:0 10px 0 0;\">" + injectionscript(wpsContent);
		
		html += "			</td>" + 
		"			<td align=\"right\" style=\"padding:0 10px 0 0;\">" + 
		"			";
		
		if(!(wpsImg == "" || wpsImg == "null" || wpsImg == null)){
			html +="				<img src='/cmmn/getImage.do?atchFileId="+wpsImg+"&fileSn=0&thumbnailFlag=Y' id='pic\" + i + \"' />";
		}
		
		html += "			" + 
		"			</td>" + 
		"		</tr>" + 
		"		</table>" + 
		"	</div>" + 
		"</div>";
		return html;
	}

	function injectionscript(str){
		str = str.replace(/</gi,"&lt;");
		str = str.replace(/>/gi,"&gt;");
		return str;
	}
//]]>
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/waterpollution/waterPollutionSearch.do" name="link"/>
		<jsp:param value="사고관리" name="title"/>
	</jsp:include>
<form name="registform" method="post" action="/mobile/sub/waterpollution/waterPollutionModify.do">
<input type="hidden" name="searchRiverDiv" value="<c:out value="${param_s.searchRiverDiv}"/>"/>
<input type="hidden" name="searchWpKind" value="<c:out value="${param_s.searchWpKind}"/>"/>
<input type="hidden" name="searchWpsStep" value="<c:out value="${param_s.searchWpsStep}"/>"/>
<input type="hidden" name="startDate" value="<c:out value="${param_s.startDate}"/>"/>
<input type="hidden" name="endDate" value="<c:out value="${param_s.endDate}"/>"/>
<input type="hidden" id="wpCode" name="wpCode" value="<c:out value="${View.wpCode}"/>"/>
<input type="hidden" id="receiverId" name="receiverId" value="<c:out value="${View.receiverId}"/>"/> 
<input type="hidden" id="memberId" name="memberId"/>

<div>
	<div class="write">
		<div class="titleBx">▶ 수습(조치)경과</div>
		<div id="stepList">
		<c:forEach items="${StepList}" var="item">
			<div id="step<c:out value="${item.wpsCode}"/>" class="listBx">
				<div class="title">
					<div style="float:left;">No.<c:out value="${item.wpsCode}"/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<c:out value="${item.wpsStepDate}"/></div>
					<div style="float:right;padding:0 10px 0 0;"><a href="#" onclick="goStepModify('<c:out value="${item.wpsCode}"/>'); return false;"><img src="/images/mobile/btn_detail_info.png" align="absmiddle" width="52" height="18" border="0"/></a></div>
				</div>
				<div class="content">
					<div style="padding:5px 0;">
								<c:if test='${item.wpsStep eq "STA"}'>신고</c:if>
								<c:if test='${item.wpsStep eq "RCV"}'>접수</c:if>
								<c:if test='${item.wpsStep eq "ING"}'>수습중</c:if>
								<c:if test='${item.wpsStep eq "END"}'>조치완료</c:if>
					</div>
					<div style="padding:5px 0;">
						<table cellpadding = "0" cellspacing = "0" width="100%">
						<tr>
							<td align="left" style="padding:0 10px 0 0;">
								<c:out value='${fn:replace(item.wpsContent,crlf,"<BR/>")}' escapeXml="false"/>
							</td>
							<td align="right" style="padding:0 10px 0 0;">
								<c:if test="${!empty item.wpsImg}">
									<img img_id="file_img" src='<c:url value='/cmmn/getImage.do'/>?atchFileId=<c:out value="${item.wpsImg}"/>&fileSn=0&thumbnailFlag=Y' id='pic" + i + "' />
								</c:if>
							</td>
						</tr>
						</table>
					</div>
				</div>
			</div>
		</c:forEach>
		</div>
		<div>
			<ul class="sbtn" style="width:100%;text-align:center;">
				<li style="width:90%;">
					<a href="#" onclick="goStepAdd();return false;" id="aaa">추가하기</a>
				</li>
			</ul>
		</div>
		
		<c:set var="reportDate" value = "${fn:substring(View.reportDate,0,4)}-${fn:substring(View.reportDate,4,6)}-${fn:substring(View.reportDate,6,8)}"/>
		<c:set var="reportHour" value = "${fn:substring(View.reportDate,8,10)}"/>
		<c:set var="reportMin" value = "${fn:substring(View.reportDate,10,12)}"/>
		
		<div class="titleBx" style="margin-top:20px">▶ 신고</div>
		<table> 
			<colgroup> 
				<col width="90px" />
				<col width="*" /> 
			</colgroup> 
			<tr>
				<th>신고일시</th>
				<td>
					<c:out value="${reportDate}"/> <c:out value="${reportHour}"/>시  <c:out value="${reportMin}"/>시 
				</td>
			</tr>
			<tr>
				<th>신고자</th>
				<td>
					<c:out value="${View.reporterName}"/>
				</td>
			</tr>
			<tr>
				<th>연락처 </th>
				<td>
					<c:out value="${View.reporterTelNo}"/>
				</td>
			</tr>
			<tr>
				<th>신고자 소속</th>
				<td>
					<c:out value="${View.reporterDept}"/>
				</td>
			</tr>
		</table> 
			
		<c:set var="receiveDate" value = "${fn:substring(View.receiveDate,0,4)}-${fn:substring(View.receiveDate,4,6)}-${fn:substring(View.receiveDate,6,8)}"/>
		<c:set var="receiveHour" value = "${fn:substring(View.receiveDate,8,10)}"/>
		<c:set var="receiveMin" value = "${fn:substring(View.receiveDate,10,12)}"/>
			
		<div class="titleBx" style="margin-top:20px">▶ 접수</div>
		<table summary="접수정보" style="text-align:left">
			<colgroup> 
				<col width="90px" />
				<col width="*" /> 
			</colgroup> 
			<tr>
				<th>접수일시 </th>
				<td>
					<c:out value="${receiveDate}"/> <c:out value="${receiveHour}"/>시  <c:out value="${receiveMin}"/>시 
				</td>
			</tr>
			<tr>
				<th>접수자 </th>
				<td>
					<c:out value="${View.receiverName}"/>
				</td>
			</tr>
			<tr>
				<th>연락처 </th>
				<td>
					<c:out value="${View.receiverTelNo}"/>
				</td>
			</tr>
			<tr>
				<th>접수자 소속 </th>
				<td>
					<c:out value="${View.receiverDept}"/>
				</td>
			</tr>
		</table>
		
		<div class="titleBx" style="margin-top:20px">▶  사고내용</div>
		<table summary="접수정보" style="text-align:left">
			<colgroup> 
				<col width="90px" /> 
				<col width="*" /> 
			</colgroup>
			<tr> 
				<th>사고유형 <span class="red">*</span></th>
				<td>
					<select id="wpKind" name="wpKind">
						<option value="">선택</option>
						<option value="PA" <c:if test="${View.wpKind eq 'PA' }">selected="selected"</c:if>>유류유출</option>
						<option value="PB" <c:if test="${View.wpKind eq 'PB' }">selected="selected"</c:if>>물고기폐사</option>
						<option value="PC" <c:if test="${View.wpKind eq 'PC' }">selected="selected"</c:if>>화학물질</option>
						<option value="PD" <c:if test="${View.wpKind eq 'PD' }">selected="selected"</c:if>>기타</option>
						<option value="PT" <c:if test="${View.wpKind eq 'PT' }">selected="selected"</c:if>>테스트</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>수계  <span class="red">*</span></th>
				<td>
					<select id="riverDiv" name="riverDiv">
						<option value="">선택</option>
						<option value="R01" <c:if test="${View.riverDiv eq 'R01' }">selected="selected"</c:if>>한강</option>
						<option value="R02" <c:if test="${View.riverDiv eq 'R02' }">selected="selected"</c:if>>낙동강</option>
						<option value="R03" <c:if test="${View.riverDiv eq 'R03' }">selected="selected"</c:if>>금강</option>
						<option value="R04" <c:if test="${View.riverDiv eq 'R04' }">selected="selected"</c:if>>영산강</option>
					</select>
				</td>
			</tr>
			<tr>
				<th>지원유형  <span class="red">*</span></th>
				<td>
					<select id="supportKind" name="supportKind">
						<option value="">선택</option>
						<option value="N" <c:if test="${View.supportKind eq 'N' }">selected="selected"</c:if>>접수</option>
						<option value="Y" <c:if test="${View.supportKind eq 'Y' }">selected="selected"</c:if>>지원</option>
					</select>
				</td>
			</tr>
		</table>
		
		<div class="titleBx" style="margin-top:20px">▶ 사고지점</div>
		<table summary="접수정보" style="text-align:left">
			<colgroup> 
				<col width="90px" /> 
				<col width="*" /> 
			</colgroup>
			<tr>
				<td colspan="2">
					<div style="padding:2px 0;"><input type="text" id="address" name="address" size="90" value="<c:out value="${View.address}"/>"/></div>
					<div style="padding:2px 0;"><input type="text" id="addrDet" name="addrDet" size="90" value="<c:out value="${View.addrDet}"/>"/></div>
				</td>
			</tr> 
			<tr style="display:none;">
				<th>위도</th>
				<td>
					<input type="text" id="latiude" name="latiude" size="40" readonly="readonly" value="<c:out value="${View.latiude}"/>"/>
				</td>
			</tr> 
			<tr style="display:none;">
				<th>경도</th>
				<td>
					<input type="text" id="longituded" name="longituded" size="40"  readonly="readonly" value="<c:out value="${View.longituded}"/>"/>
				</td>
			</tr> 
			<tr>
				<td colspan="2">
					<div>
						<ul class="sbtn" style="width:100%;text-align:center;">
							<li style="width:90%;">
								<a href="#" onclick="lon_lat('<c:out value="${View.latiude}"/>', '<c:out value="${View.longituded}"/>');return false;">지도</a>
							</li>
						</ul>
					</div> 
				</td>
			</tr> 
		</table>
		
		<div class="titleBx" style="margin-top:20px">▶ 사고내용(상세)</div>
		<table summary="접수정보" style="text-align:left">
			<colgroup> 
				<col width="*" /> 
			</colgroup>
			<tr>
				<td>
					<textarea id="wpContent" name="wpContent" cols="130" rows="5"><c:out value="${View.wpContent}"/></textarea>
				</td>
			</tr> 
		</table>
		
		<div class="titleBx" style="margin-top:20px">▶ SMS</div>

		<table> 
			<colgroup> 
				<col width="90px" />
				<col width="*" /> 
			</colgroup> 
			<tr>
				<th>내용</th>
				<td>
					<c:out value="${SmsList[0].smsContent}"/> 
				</td>
			</tr>
			<tr>
				<th valign="center">수신자</th>
				<td>
					<c:forEach items="${SmsList}" var="item">
						<div style="margin:3px 0;"><c:out value="${item.recvDept}"/> > <c:out value="${item.recvName}"/></div>
					</c:forEach>
				</td> 
			</tr>
		</table> 
		<div>
			<ul class="sbtn" style="width:100%;text-align:center;">
				<li style="width:90%;">
					<a href="#" onclick="fnSave(); return false;">저장하기</a>
				</li>
			</ul>
		</div> 
	</div>
</div>
</form>

<div id="popupStep" style="display:none;" class="popup">
	<span class="button b-close"><span>X</span></span>
	<iframe id="ifrm" frameborder="0" scrolling="no" style="width:95%;"></iframe>
</div>	
</body>
</html>