<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<html style="height:100%;">
<head>
<jsp:include page="/WEB-INF/jsp/mobile/common/header.jsp">
	<jsp:param value="방제지침서" name="title"/>
</jsp:include>
</head>
<body style="height:100%;">

	<jsp:include page="/WEB-INF/jsp/mobile/common/top.jsp">
		<jsp:param value="/mobile/sub/manual/manual.do" name="link"/>
		<jsp:param value="방제지침서" name="title"/>
	</jsp:include>
    
	<div style="position:relative;width:100%;height:100%;">
		<div style="position:absolute;width:100%;height:100%;">
			<table width="100%" height="100%" cellpadding="0" cellspacing="0" border="0">
			<tr>
				<td style="text-align:left;padding:3px;background:none;">
					<c:if test='${prev ne "0"}'>  
						<a href="<c:url value='manual_view.do?name=${prev}'/>"><img src="/images/mobile/l1.gif" style="margin-bottom:50px;" width="22"/></a>
					</c:if>
				</td>
				<td style="text-align:right;padding:3px;background:none;">
					<c:if test='${next ne "9999"}'>
						<a href="<c:url value='manual_view.do?name=${next}'/>"><img src="/images/mobile/r1.gif" style="margin-bottom:50px;" width="22"/></a>
					</c:if>
				</td>
			</tr>
			</table>
		</div>
		<table width="100%"> 
		<tr> 
			<td>
				<div style="margin-left:25px"><img src="/images/mobile/manual/p<c:out value="${curr}"/>" width="100%"/></div>
			</td>
		</tr> 
		</table> 
	</div>

</body>
</html>