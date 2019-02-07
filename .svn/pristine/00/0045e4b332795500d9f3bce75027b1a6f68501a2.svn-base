<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="dailygubun" value="${param.dailygubun}"/>
<div style="overflow: hidden;">
	<div style="width:50%;float:left;">
		<div class="semitop<c:if test='${dailygubun eq "Y" }'>on</c:if>">
			<a href="/mobile/sub/dailywork/dailyWorkSearch.do">일지조회</a>
		</div>
	</div>
	<div style="width:50%;float:left;">
		<div class="semitop<c:if test='${dailygubun ne "Y" }'>on</c:if>">
			<a href="/mobile/sub/dailywork/receiveApprovalSearch.do">받은결재</a>
		</div>
	</div>
</div>