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
	<jsp:param value="업무일지" name="title"/>
</jsp:include>
<c:set var="listparameter" value='${pj:nonQuestionParamString(searchVO,"startDate,endDate,searchState",false)}'/>
<script type="text/javascript">
	function fn_page(pageNo) {
		document.frm.pageIndex.value = pageNo; 
		document.frm.action = "<c:url value='/mobile/sub/dailywork/receiveApprovalList.do?${listparameter}'/>";
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
			<jsp:param value="N" name="dailygubun"/>
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
		<th>구분</th>
		<th>일자</th>
		<th>결재요청자</th>
		<th>결재요청일</th>
		<th>상태</th>
	</tr>
	<c:forEach items="${List}" var="item" varStatus="count">
	<tr>   
		<td><a href='<c:url value="/mobile/sub/dailywork/receiveApprovalDetail.do?dailyWorkId=${item.dailyWorkId}&searchGubun=${item.gubun}&approvalSeq=${item.dailyWorkseq}&appCheck=${item.state eq 'B' ? 'Y' : 'N'}&${listparameter}"/>'><c:out value="${count.count}"/></a></td> 
		<td><a href="<c:url value="/mobile/sub/dailywork/receiveApprovalDetail.do?dailyWorkId=${item.dailyWorkId}&searchGubun=${item.gubun}&approvalSeq=${item.dailyWorkseq}&appCheck=${item.state eq 'B' ? 'Y' : 'N'}&${listparameter}"/>"><c:out value="${item.gubunName}"/></a></td>
		<td><a href="<c:url value="/mobile/sub/dailywork/receiveApprovalDetail.do?dailyWorkId=${item.dailyWorkId}&searchGubun=${item.gubun}&approvalSeq=${item.dailyWorkseq}&appCheck=${item.state eq 'B' ? 'Y' : 'N'}&${listparameter}"/>"><c:out value="${item.workDay}"/></a></td>
		<td><a href="<c:url value="/mobile/sub/dailywork/receiveApprovalDetail.do?dailyWorkId=${item.dailyWorkId}&searchGubun=${item.gubun}&approvalSeq=${item.dailyWorkseq}&appCheck=${item.state eq 'B' ? 'Y' : 'N'}&${listparameter}"/>"><c:out value="${item.approvalRequestId}"/></a></td>
		<td><a href="<c:url value="/mobile/sub/dailywork/receiveApprovalDetail.do?dailyWorkId=${item.dailyWorkId}&searchGubun=${item.gubun}&approvalSeq=${item.dailyWorkseq}&appCheck=${item.state eq 'B' ? 'Y' : 'N'}&${listparameter}"/>"><c:out value="${item.approvalRequestDate}"/></a></td>
		<td><a href="<c:url value="/mobile/sub/dailywork/receiveApprovalDetail.do?dailyWorkId=${item.dailyWorkId}&searchGubun=${item.gubun}&approvalSeq=${item.dailyWorkseq}&appCheck=${item.state eq 'B' ? 'Y' : 'N'}&${listparameter}"/>" 
		<c:if test='${item.state eq "결재반려"}'>style="color:red;"</c:if>
		<c:if test='${item.state eq "결재완료"}'>style="color:green;"</c:if>  
		><c:out value="${item.stateName}"/></a>
		</td>
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