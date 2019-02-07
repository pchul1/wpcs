<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:set var="Seminargubun" value="${param.Seminargubun}"/>
<div style="overflow: hidden;">
	<div style="width:50%;float:left;">
		<div class="semitop<c:if test='${Seminargubun eq "SeminarList" }'>on</c:if>">
			<a href="/mobile/sub/seminar/SeminarScheduleSearch.do">교육일정</a>
		</div>
	</div>
	<div style="width:50%;float:left;">
		<div class="semitop<c:if test='${Seminargubun eq "MySeminarSchedule" }'>on</c:if>">
			<a href="/mobile/sub/seminar/MySeminarScheduleSearch.do">나의신청내역</a>
		</div>
	</div>
</div>