<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

<script>
function fn_rssListPopup(index){
	var retVal;
	var url = "<c:url value='rss/reader.do'/>?view=popup&index="+index;		
	var openParam = "width=650,height=550,resizable=yes,scrollbars=yes";
	retVal = window.open(url,"rssListPopup", openParam);
}
</script>

<c:choose>
	<c:when test="${view == 'index'}">
		<c:set var="doneLoop" value="false"/> 
		<c:forEach var="result" items="${feedList}" varStatus="status">
			<c:if test="${not doneLoop}"> 
				<li>
					<a href="javascript:fn_rssListPopup();">
						<span class="num"><fmt:formatDate value="${result.publishedDate}" pattern="yy.MM.dd"/></span> ${result.title}
					</a>
				</li>
				<c:if test="${status.count == 3}"> 
					<c:set var="doneLoop" value="true"/> 
				</c:if> 
			</c:if> 
		</c:forEach>
	</c:when>
	<c:when test="${view == 'main'}">
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
	</c:when>
	<c:otherwise></c:otherwise>
</c:choose>
