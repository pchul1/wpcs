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
	function fn_page(pageNo) {
		document.frm.pageIndex.value = pageNo; 
		document.frm.action = "<c:url value='/mobile/sub/seminar/SeminarScheduleList.do?${listparameter}'/>";
		document.frm.submit();	
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/seminar/SeminarScheduleSearch.do" name="link"/>
		<jsp:param value="교육일정" name="title"/>
	</jsp:include>
<form name="frm" action ="" method="post">
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>	
</form>
<div id="list"> 
    
	<jsp:include page="/WEB-INF/jsp/mobile/sub/seminar/SeminarScheduleCommonTop.jsp">
		<jsp:param value="SeminarList" name="Seminargubun"/>
	</jsp:include>
		<div class="listboxstart">
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<div class="listBox">
				<div class="listBoxTitle">
					<div style="float:left;display:block;">
						교육기간  : <c:out value="${result.seminarDate}"/>&nbsp;&nbsp;<c:out value="${result.seminarTimeFrom}"/>~<c:out value="${result.seminarTimeTo}"/><br/>
						신청기간 : <c:out value="${result.seminarEntryDate}"/> &nbsp;&nbsp;
						
					</div>
					<div style="float:right;padding:2px;"><a href="<c:url value="/mobile/sub/seminar/SeminarApplicationView.do?seminarId=${result.seminarId}&Seminargubun=SeminarList&${listparameter}"/>"><img src="/images/mobile/btn_detail_info.png" align="absmiddle" width="52" height="18" border="0"/></a></div>
				</div>
				<div style="margin:7px 0 7px 10px;clear:both;">
					<div style="margin:3px 0;">[<c:out value="${result.seminarGubunName}"/>] <c:out value="${result.seminarTitle}"/></div>
					<div style="margin:3px 0;"><c:out value="${result.seminarPlace}"/></div>
				</div>
				<div class="dotline"></div>
				<div style="margin:3px 0 10px 10px;">
					<c:out value="${result.seminarLectName}"/>(<c:out value="${result.seminarLectTel}"/>)
					<span style="<c:if test="${result.seminarClosingStateName eq '신청가능'}">color:green;</c:if>
					<c:if test="${result.seminarClosingStateName eq '신청마감'}">color:red;</c:if>
					">
					<c:out value="${result.seminarClosingStateName}"/>
					</span>
				</div>
			</div>
			</c:forEach>
		</div>
		
		<div class="paging">
			<div id="page_number">
				<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_page" />
			</div>
		</div>

</div>
</body>
</html>