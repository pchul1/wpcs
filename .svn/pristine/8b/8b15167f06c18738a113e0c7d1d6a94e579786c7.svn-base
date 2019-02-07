<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="pj" uri="ProjectJstlUtil"%>
<html>
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="업무일지" name="title"/>
</jsp:include>
<c:set var="listparameter" value='${pj:nonQuestionParamString(searchVO,"startDate,endDate,searchGubun,searchState",false)}'/>
<script type="text/javascript">
	function fn_page(pageNo) {
		document.frm.pageIndex.value = pageNo; 
		document.frm.action = "<c:url value='/mobile/sub/dailywork/dailyWorkList.do${listparameter}'/>";
		document.frm.submit();	
	}
</script>
</head>
<body>
	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/dailywork/dailyWorkSearch.do" name="link"/>
		<jsp:param value="업무일지" name="title"/>
	</jsp:include>
<form name="frm" action ="" method="post">
<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>	
</form>
<div id="list"> 
	<jsp:include page="/WEB-INF/jsp/mobile/sub/dailywork/dailyCommonTop.jsp">
		<jsp:param value="Y" name="dailygubun"/>
	</jsp:include>
	<table width="100%"> 
	<colgroup>
		<col width="10%"/> 
		<col width="18%"/>
		<col width="18%"/>
		<col width="18%"/>
		<col width="18%"/>
		<col width="18%"/>
	</colgroup>
	<tr> 
		<th>No.</th> 
		<th>일자</th>
		<th><c:if test="${searchVO.searchGubun eq 'S'}">최초</c:if>작성자</th>
		<th>결재요청자</th>
		<th>결재요청일</th>
		<th>상태</th>
	</tr>
	<c:forEach items="${List}" var="item" varStatus="count">
	<tr>
		<td>${count.count}</td> 
		<td><a href="<c:url value="dailyWorkDetail.do?dailyWorkId=${item.dailyWorkId}&regId=${item.regId}&${listparameter}"/>"><c:out value="${item.workDay}"/></a></td>
		<td><a href="<c:url value="dailyWorkDetail.do?dailyWorkId=${item.dailyWorkId}&regId=${item.regId}&${listparameter}"/>"><c:out value="${item.regName}"/></a></td>
		<td><a href="<c:url value="dailyWorkDetail.do?dailyWorkId=${item.dailyWorkId}&regId=${item.regId}&${listparameter}"/>"><c:out value="${item.approvalName}"/></a></td>
		<td><a href="<c:url value="dailyWorkDetail.do?dailyWorkId=${item.dailyWorkId}&regId=${item.regId}&${listparameter}"/>"><c:out value="${item.approvalDate}"/></a></td>
	  	<td><a href="<c:url value="dailyWorkDetail.do?dailyWorkId=${item.dailyWorkId}&regId=${item.regId}&${listparameter}"/>"  
	  			<c:if test='${item.state eq "결재반려"}'>style="color:red;"</c:if>
	  			<c:if test='${item.state eq "결재완료"}'>style="color:green;"</c:if>><c:out value="${item.state}"/></a></td>
	</tr> 
	</c:forEach>
	</table>
	<div class="paging">
		<div id="page_number">
			<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_page" />
		</div>
	</div>
</div>

</body>
</html>