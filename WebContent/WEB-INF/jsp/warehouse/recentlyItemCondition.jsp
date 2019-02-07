<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<script>
function fn_itemConditionPopup(stdDate){
	var retVal;
	var url = "<c:url value='/warehouse/popupItemCondition.do'/>?stdDate="+stdDate;		
	var openParam = "width=650,height=700,resizable=yes,scrollbars=yes";
	retVal = window.open(url,"itemConditionPopup", openParam);
}
</script>

<c:choose>
	<c:when test="${view == 'index'}">
		<c:set var="doneLoop" value="false"/> 
		<c:forEach var="result" items="${resultList}" varStatus="status">
			<c:if test="${not doneLoop}"> 
				<div style="clear: both;padding: 8px;">
					<div style="float:left">
					<a href="javascript:fn_itemConditionPopup('${result.stdDate }');">
						${result.title}
					</a>
					</div>
				</div>
				<c:if test="${status.count == 6}"> 
					<c:set var="doneLoop" value="true"/> 
				</c:if> 
			</c:if> 
		</c:forEach>
	</c:when>
	<%-- <c:when test="${view == 'main'}">
		<h2>최신 보도 자료</h2>
		<ul>
			<c:set var="doneLoop" value="false"/> 
			<c:forEach var="result" items="${feedList}" varStatus="status">
				<c:if test="${not doneLoop}"> 
					<li>
						<a href="javascript:fn_rssListPopup();">
							[<fmt:formatDate value="${result.publishedDate}" pattern="yyyy-MM-dd"/>]${result.title}
						</a>
					</li>			
					<c:if test="${status.count == 3}"> 
						<c:set var="doneLoop" value="true"/> 
					</c:if> 
				</c:if> 
			</c:forEach>
		</ul>
		<p class="btn">
			<a href="javascript:fn_rssListPopup();">
				<img src="<c:url value='/images/common/btn_more.gif'/>" alt="more" />
			</a>
		</p>
	</c:when> --%>
	<c:otherwise></c:otherwise>
</c:choose>
