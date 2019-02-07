<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<style type="text/css">
.writestep {width:100%;}
.writestep .step {float:left;text-align:center;width:16%;}
.writestep .stepon {float:left;text-align:center;width:16%;}
</style>	
<c:set var="AllstepList" value="${fn:replace(param.AllstepList,'9','1')}"/>
	<div class="writestep">
		<div class='step${(param.stepno eq "1") ? "on" : ""}' id="title1">
			<div style="padding:3px 4px;">
			<c:choose>
				<c:when test="${param.stepno eq '1'}"><c:set var="img" value="/images/mobile/sub/step_on_01.png"/></c:when>
				<c:when test="${fn:indexOf(AllstepList,'1') > -1}"><c:set var="img" value="/images/mobile/sub/step_end_01.png"/></c:when>
				<c:otherwise><c:set var="img" value="/images/mobile/sub/step_off_01.png"/></c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${fn:indexOf(AllstepList,'1') > -1}">
				<a href='<c:url value="/mobile/sub/alert/alertMngView1.do${param.listparameter}=1"/>'><img src="<c:out value="${img}"/>" border="0"  width="100%"/></a>
				</c:when>
				<c:otherwise><a><img src="<c:out value="${img}"/>" border="0"  width="100%"/></a></c:otherwise>
			</c:choose>
			</div>
		</div>
		
		<div class='step${(param.stepno eq "2") ? "on" : ""}' id="title2">
			<div style="padding:3px 4px;">
			<c:choose>
				<c:when test="${param.stepno eq '2'}"><c:set var="img" value="/images/mobile/sub/step_on_02.png"/></c:when>
				<c:when test="${fn:indexOf(AllstepList,'2') > -1}"><c:set var="img" value="/images/mobile/sub/step_end_02.png"/></c:when>
				<c:otherwise><c:set var="img" value="/images/mobile/sub/step_off_02.png"/></c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${fn:indexOf(AllstepList,'2') > -1}">
				<a href='<c:url value="/mobile/sub/alert/alertMngView2.do${param.listparameter}=2"/>'><img src="<c:out value="${img}"/>" border="0"  width="100%"/></a>
				</c:when>
				<c:otherwise><a><img src="<c:out value="${img}"/>" border="0"  width="100%"/></a></c:otherwise>
			</c:choose>
			</div>
		</div>
		
		<div class='step${(param.stepno eq "3") ? "on" : ""}' id="title3">
			<div style="padding:3px 4px;">
			<c:choose>
				<c:when test="${param.stepno eq '3'}"><c:set var="img" value="/images/mobile/sub/step_on_03.png"/></c:when>
				<c:when test="${fn:indexOf(AllstepList,'3') > -1}"><c:set var="img" value="/images/mobile/sub/step_end_03.png"/></c:when>
				<c:otherwise><c:set var="img" value="/images/mobile/sub/step_off_03.png"/></c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${fn:indexOf(AllstepList,'3') > -1}">
				<a href='<c:url value="/mobile/sub/alert/alertMngView3.do${param.listparameter}=3"/>'><img src="<c:out value="${img}"/>" border="0"  width="100%"/></a>
				</c:when>
				<c:otherwise><a><img src="<c:out value="${img}"/>" border="0"  width="100%"/></a></c:otherwise>
			</c:choose>
			</div>
		</div>
		
		<div class='step${(param.stepno eq "4") ? "on" : ""}' id="title4">
			<div style="padding:3px 4px;">
			<c:choose>
				<c:when test="${param.stepno eq '4'}"><c:set var="img" value="/images/mobile/sub/step_on_04.png"/></c:when>
				<c:when test="${fn:indexOf(AllstepList,'4') > -1}"><c:set var="img" value="/images/mobile/sub/step_end_04.png"/></c:when>
				<c:otherwise><c:set var="img" value="/images/mobile/sub/step_off_04.png"/></c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${fn:indexOf(AllstepList,'4') > -1}">
				<a href='<c:url value="/mobile/sub/alert/alertMngView4.do${param.listparameter}=4"/>'><img src="<c:out value="${img}"/>" border="0"  width="100%"/></a>
				</c:when>
				<c:otherwise><a><img src="<c:out value="${img}"/>" border="0"  width="100%"/></a></c:otherwise>
			</c:choose>
			</div>
		</div>
		
		<div class='step${(param.stepno eq "5") ? "on" : ""}' id="title5">
			<div style="padding:3px 4px;">
			<c:choose>
				<c:when test="${param.stepno eq '5'}"><c:set var="img" value="/images/mobile/sub/step_on_05.png"/></c:when>
				<c:when test="${fn:indexOf(AllstepList,'5') > -1}"><c:set var="img" value="/images/mobile/sub/step_end_05.png"/></c:when>
				<c:otherwise><c:set var="img" value="/images/mobile/sub/step_off_05.png"/></c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${fn:indexOf(AllstepList,'5') > -1}">
				<a href='<c:url value="/mobile/sub/alert/alertMngView5.do${param.listparameter}=5"/>'><img src="<c:out value="${img}"/>" border="0"  width="100%"/></a>
				</c:when>
				<c:otherwise><a><img src="<c:out value="${img}"/>" border="0"  width="100%"/></a></c:otherwise>
			</c:choose>
			</div>
		</div>
		
		<div class='step${(param.stepno eq "6") ? "on" : ""}' id="title6">
			<div style="padding:3px 4px;">
			<c:choose>
				<c:when test="${param.stepno eq '6'}"><c:set var="img" value="/images/mobile/sub/step_on_06.png"/></c:when>
				<c:when test="${fn:indexOf(AllstepList,'6') > -1}"><c:set var="img" value="/images/mobile/sub/step_end_06.png"/></c:when>
				<c:otherwise><c:set var="img" value="/images/mobile/sub/step_off_06.png"/></c:otherwise>
			</c:choose>
			<c:choose>
				<c:when test="${fn:indexOf(AllstepList,'6') > -1}">
				<a href='<c:url value="/mobile/sub/alert/alertMngView6.do${param.listparameter}=6"/>'><img src="<c:out value="${img}"/>" border="0" width="100%"/></a>
				</c:when>
				<c:otherwise><a><img src="<c:out value="${img}"/>" border="0"  width="100%"/></a></c:otherwise>
			</c:choose>
			</div>
		</div>
	</div>