<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN""http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<style type="text/css">
.writestep .step {float:left;text-align:center;margin:0 3px;}
.writestep .stepon {float:left;text-align:center;margin:0 3px;}

.writestep .step a {color:#BBBBBB;}
.writestep .stepon a {color:#3792c5;font-weight:bold;}
</style>	
<script type="text/javascript">
function gosteplocation(n){
	top.location=n;
}
</script>
<c:set var="alertStep" value="${(param.alertStep eq '9') ? '1' : param.alertStep}"/>
<c:set var="AllstepList" value="${fn:replace(param.AllstepList,'9','1')}"/>
	<div class="writestep" style="margin-bottom:20px;padding-bottom:20px;">
		<div class='step${(param.stepno eq "1") ? "on" : ""}' id="title1">
			<div style="padding:3px 4px;">
			<c:choose>
				<c:when test="${param.stepno eq '1'}"><c:set var="img" value="/images/alert/step_on_01.png"/></c:when>
				<c:when test="${fn:indexOf(AllstepList,'1') > -1}"><c:set var="img" value="/images/alert/step_end_01.png"/></c:when>
				<c:otherwise><c:set var="img" value="/images/alert/step_off_01.png"/></c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${fn:indexOf(AllstepList,'1') > -1}">
				<a href="<c:url value="/alert/alertMngView.do${param.listparameter}=1"/>" onclick="gosteplocation(this.href)"><img src="<c:out value="${img}"/>" border="0"/></a>
				</c:when>
				<c:otherwise><a><img src="<c:out value="${img}"/>" border="0"/></a></c:otherwise>
			</c:choose>
			</div>
		</div>
		
		<div class='step${(param.stepno eq "2") ? "on" : ""}' id="title2">
			<c:set value='2 ${(param.stepno eq "2") ? " 현장확인" : ""}' var="title"/>
			<div style="padding:3px 4px;">
			<c:choose>
				<c:when test="${param.stepno eq '2'}"><c:set var="img" value="/images/alert/step_on_02.png"/></c:when>
				<c:when test="${fn:indexOf(AllstepList,'2') > -1}"><c:set var="img" value="/images/alert/step_end_02.png"/></c:when>
				<c:otherwise><c:set var="img" value="/images/alert/step_off_02.png"/></c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${fn:indexOf(AllstepList,'2') > -1}">  
				<a href="<c:url value="/alert/alertMngView.do${param.listparameter}=2"/>" onclick="gosteplocation(this.href)"><img src="<c:out value="${img}"/>" border="0"/></a>
				</c:when>
				<c:otherwise><a><img src="<c:out value="${img}"/>" border="0"/></a></c:otherwise>
			</c:choose>
			</div>
		</div>
		
		<div class='step${(param.stepno eq "3") ? "on" : ""}' id="title3">
			<c:set value='3 ${(param.stepno eq "3") ? " 시료분석" : ""}' var="title"/>
			<div style="padding:3px 4px;">
			<c:choose>
				<c:when test="${param.stepno eq '3'}"><c:set var="img" value="/images/alert/step_on_03.png"/></c:when>
				<c:when test="${fn:indexOf(AllstepList,'3') > -1}"><c:set var="img" value="/images/alert/step_end_03.png"/></c:when>
				<c:otherwise><c:set var="img" value="/images/alert/step_off_03.png"/></c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${fn:indexOf(AllstepList,'3') > -1}">
				<a href="<c:url value="/alert/alertMngView.do${param.listparameter}=3"/>" onclick="gosteplocation(this.href)"><img src="<c:out value="${img}"/>" border="0"/></a>
				</c:when>
				<c:otherwise><a><img src="<c:out value="${img}"/>" border="0"/></a></c:otherwise>
			</c:choose>
			</div>
		</div>
		
		<div class='step${(param.stepno eq "4") ? "on" : ""}' id="title4">
			<c:set value='4 ${(param.stepno eq "4") ? " 경보발령" : ""}' var="title"/>
			<div style="padding:3px 4px;">
			<c:choose>
				<c:when test="${param.stepno eq '4'}"><c:set var="img" value="/images/alert/step_on_04.png"/></c:when>
				<c:when test="${fn:indexOf(AllstepList,'4') > -1}"><c:set var="img" value="/images/alert/step_end_04.png"/></c:when>
				<c:otherwise><c:set var="img" value="/images/alert/step_off_04.png"/></c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${fn:indexOf(AllstepList,'4') > -1}">
				<a href="<c:url value="/alert/alertMngView.do${param.listparameter}=4"/>" onclick="gosteplocation(this.href)"><img src="<c:out value="${img}"/>" border="0"/></a>
				</c:when>
				<c:otherwise><a><img src="<c:out value="${img}"/>" border="0"/></a></c:otherwise>
			</c:choose>
			</div>
		</div>
		
		<div class='step${(param.stepno eq "5") ? "on" : ""}' id="title5">
			<c:set value='5 ${(param.stepno eq "5") ? " 상황조치" : ""}' var="title"/>
			<div style="padding:3px 4px;">
			<c:choose>
				<c:when test="${param.stepno eq '5'}"><c:set var="img" value="/images/alert/step_on_05.png"/></c:when>
				<c:when test="${fn:indexOf(AllstepList,'5') > -1}"><c:set var="img" value="/images/alert/step_end_05.png"/></c:when>
				<c:otherwise><c:set var="img" value="/images/alert/step_off_05.png"/></c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${fn:indexOf(AllstepList,'5') > -1}">
				<a href="<c:url value="/alert/alertMngView.do${param.listparameter}=5"/>" onclick="gosteplocation(this.href)"><img src="<c:out value="${img}"/>" border="0"/></a>
				</c:when>
				<c:otherwise><a><img src="<c:out value="${img}"/>" border="0"/></a></c:otherwise>
			</c:choose>
			</div>
		</div>
		
		<div class='step${(param.stepno eq "6") ? "on" : ""}' id="title6">
			<c:set value='6 ${(param.stepno eq "6") ? " 상황종료" : ""}' var="title"/>
			<div style="padding:3px 4px;">
			<c:choose>
				<c:when test="${param.stepno eq '6'}"><c:set var="img" value="/images/alert/step_on_06.png"/></c:when>
				<c:when test="${fn:indexOf(AllstepList,'6') > -1}"><c:set var="img" value="/images/alert/step_end_06.png"/></c:when>
				<c:otherwise><c:set var="img" value="/images/alert/step_off_06.png"/></c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${fn:indexOf(AllstepList,'6') > -1}">
				<a href="<c:url value="/alert/alertMngView.do${param.listparameter}=6"/>" onclick="gosteplocation(this.href)"><img src="<c:out value="${img}"/>" border="0"/></a>
				</c:when>
				<c:otherwise><a><img src="<c:out value="${img}"/>" border="0"/></a></c:otherwise>
			</c:choose>
			</div>
		</div>
	</div>