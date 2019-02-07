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
	<jsp:param value="교육일정" name="title"/>
</jsp:include>
<script type="text/javascript">
	function popOpen(seminarId){
		$.ajax({
			type: "POST",
			url: "<c:url value='/seminar/selSeminarEntryView.do'/>",
			data: {seminarId:seminarId},	
			dataType:"json",
			success : function(result){
				if(result != null) {
					var list = result['resultList'];
					var memHtml = "";
					var titleHtml = "";
					 for(var i = 0; i < list.length; i++) {
						if(i == 0) titleHtml += list[i].seminarTitle;
						memHtml += "<tr><td><input type=\"checkbox\" id=\"checkNo\" name=\"checkNo\" value=\""+ list[i].seminarEntryId+ "//" + list[i].seminarMemId +"\"/></td>"; 
						memHtml += "<td>" + list[i].seminarMemName + "</td>";
						memHtml += "<td>" + list[i].memDeptName + "</td>";
						memHtml += "<td>" + list[i].memEmail + "</td>";
						memHtml += "<td>" + list[i].memTel + "</td></tr>";
					}
					$('#memList').html("");
					$('#seminarEntryTitle').html("");
					$('#seminarEntryTitle').append("<span>" + titleHtml + "</span>");
					$('#memList').append(memHtml);
					document.memEntryForm.seminarId.value = seminarId;
					
					// 체크 박스 모두 체크
					$("#checkAll").click(function() {
						if($(this).attr("checked")== "checked"){
							$("input[name=checkNo]").attr("checked", true);
						}else{
							$("input[name=checkNo]").attr("checked", false);
						}
					});
			    	
					$("input[name=checkNo]").click(function() {
						$("input[name=checkAll]").attr("checked", false);
					});
					
					$("#MemList").bPopup();
				}
			}
		});
	}
	
	//교육 참여자 제외 레이어 표시
	function fn_egov_Except(){
		var form = document.memEntryForm;
		if ( $('input:checkbox[name="checkNo"]:checked').length > 0 ){
			if(confirm("선택하신 참여자를 제외 하시겠습니까?")){
				var chked_val = "";
				$(":checkbox[name='checkNo']:checked").each(function(pi,po){
					chked_val += ","+po.value;
				});
				if(chked_val!="")	chked_val = chked_val.substring(1);
				form.checkSeminarId.value = chked_val;
				form.entryYn.value = 'N';
				$("#MemList").css("display","none");
				$("#popup").bPopup();
			}
    	}else{
    		alert("제외할 참석자를 선택해주세요.");
			return false;
    	}
    }
	
	//참여자 제외 처리
	function fn_egov_Disapprover() {
		var pageNo = document.memEntryForm.pageIndex.value;
		var seminarId = document.memEntryForm.seminarId.value;
		var urlStr = document.memEntryForm.urlStr.value;
		var checkSeminarId = document.memEntryForm.checkSeminarId.value;
		if (pageNo == null) pageNo = 1;
		$.ajax({
			type: "POST",
			url: "<c:url value='/mobile/sub/seminar/UpdateSeminarEntry.do'/>",
			data: {
					entryYn:'N',
					seminarId:seminarId,
					pageIndex:pageNo,
					urlStr:urlStr,
					checkSeminarId:checkSeminarId,
					entryReason:$('#entryReason').val()
				},
			dataType:"json",
			success : function(result){
				alert('처리하였습니다.');
				location.replace('<c:url value="/mobile/sub/seminar/SeminarApplicationList.do?${listparameter}"/>');
			}
		});
	}
	
	function fn_page(pageNo) {
		document.frm.pageIndex.value = pageNo; 
		document.frm.action = "<c:url value='/mobile/sub/seminar/SeminarApplicationList.do?${listparameter}'/>";
		document.frm.submit();	
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp"/>
<form name="frm" action ="" method="post">
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>	
</form>
<div id="MemList" class="popup">
    <span class="button b-close"><span>X</span></span>
	<div id="seminarEntryTitle" style="font-size:15px;padding:0 5px 10px 12px;font-weight:bold;"></div>
	<div id="riverdetail">
		<div class="table_wrapper" style="width:100%;  text-align: center;">
			<table width="100%">
				<thead>
					<tr>
						<th scope="col" style="background-color:#AAAAAA;"><input type="checkbox" id="checkAll" name="checkAll"/></th>
						<th scope="col" style="background-color:#AAAAAA;">이름</th>
						<th scope="col" style="background-color:#AAAAAA;">소속</th>
						<th scope="col" style="background-color:#AAAAAA;">이메일</th>
						<th scope="col" style="background-color:#AAAAAA;">연락처</th>
					</tr>
				</thead>
				<tbody id="memList">
					<tr>
						<th scope="col" colspan='5'></th>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
	
	<div style="float:left; width:50%;text-align:center;">
		<ul class="sbtn"> 
			<li style="width:90%"><a href="#" class="b-close" onclick="fn_egov_Except(); return false;">제외</a></li>
		</ul>
	</div>
	<div style="float:left; width:50%;text-align:center;">
		<ul class="sbtn">
			<li style="width:90%"><a class="b-close" style="cursor:pointer;">확인</a></li>
		</ul>
	</div> 
</div>
<div id="popup" class="popup">
    <span class="button b-close"><span>X</span></span>
    <form id="memEntryForm" name="memEntryForm" method="post">
		<input type="hidden" name="checkSeminarId" id="checkSeminarId" value="" />
		<input type="hidden" name="entryYn" value="" />
		<input type="hidden" name="seminarId" value="" />
		<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
		<input type="hidden" name="urlStr" value="SeminarApplicationList.do" />
		<div id="deptList" style="background-color:#FFFFFF;">
			<div class="gBox" style="width:100%;height:160px;border:0;">
				<textarea id="entryReason" name="entryReason" style="width:100%;height:150px;"></textarea>
			</div>
			<div style="float:left; width:100%;text-align:center;">
				<ul class="sbtn">
					<li style="width:90%"><a class="b-close" style="cursor:pointer;" onclick="javascript:fn_egov_Disapprover();">확인</a></li>
				</ul>
			</div> 
		</div>
	</form>
</div>
<div id="list"> 
    
	<jsp:include page="/WEB-INF/jsp/mobile/sub/seminar/SeminarScheduleCommonTop.jsp">
		<jsp:param value="ApplicationList" name="Seminargubun"/>
	</jsp:include>
		<div class="listboxstart">
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<div class="listBox">
				<div class="listBoxTitle">
					<div style="float:left;display:block;">
						<c:out value="${result.seminarDate}"/>&nbsp;(<c:out value="${result.seminarEntryDate}"/>) &nbsp;&nbsp;
						<c:out value="${result.seminarTimeFrom}"/>~<c:out value="${result.seminarTimeTo}"/>
					</div>
					<div style="float:right;padding:2px;"><a href="<c:url value="/mobile/sub/seminar/SeminarApplicationView.do?seminarId=${result.seminarId}&Seminargubun=ApplicationList&${listparameter}"/>"><img src="/images/mobile/btn_detail_info.png" align="absmiddle" width="52" height="18" border="0"/></a></div>
				</div>
				<div style="margin:7px 0 7px 10px;clear:both;overflow: hidden;">
					<div style="margin:3px 0;">[<c:out value="${result.seminarGubunName}"/>] <c:out value="${result.seminarTitle}"/></div>
					<div style="width:100%">
						<div style="margin:3px 0;float:left;"><c:out value="${result.seminarPlace}"/></div>
					<c:if test="${result.entryCount > 0}">
						<div style="float:right;" class="MobileBtn">
							<a href="javascript:popOpen('<c:out value="${result.seminarId}"/>');">참석명단</a>
						</div>
					</c:if>
					</div>
				</div>
				<div class="dotline"></div>
				<div style="margin:3px 0 10px 10px;">
					<c:out value="${result.seminarLectName}"/>(<c:out value="${result.seminarLectTel}"/>)
					<c:out value="${result.seminarLectName}"/>(<c:out value="${result.seminarLectTel}"/>)
					<span style="<c:if test="${result.seminarClosingStateName eq '신청가능'}">color:green;</c:if>
					<c:if test="${result.seminarClosingStateName eq '신청마감'}">color:red;</c:if>
					">
					<c:out value="${result.seminarClosingStateName}"/>
					</span>
				</div>
			</div>
			</c:forEach>
			
			<c:if test="${fn:length(resultList) == 0}">
				<tr>
					<td class="listCenter" colspan="11" ><spring:message code="common.nodata.msg" /></td>
				</tr>
			</c:if>
		</div>
		
		<div class="paging">
			<div id="page_number">
				<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_page" />
			</div>
		</div>

</div>
</body>
</html>