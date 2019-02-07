<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

	<c:if test="${param.mode == 'modify'}">
		<c:if test="${isAirGroup == null}">
<%-- 			<sec:authorize ifNotGranted="ROLE_ADMIN"> --%>
<!-- 				<script type='text/javascript'> -->
<!-- 					alert("항공감시 정보를 수정할 권한이 없습니다!"); -->
<!-- 					history.back(); -->
<%-- 					//window.location = "<c:url value='/'/>";  --%>
<!-- 				</script> -->
<%-- 			</sec:authorize> --%>
		</c:if>
		<c:if test="${isAirGroup == false}">
<%-- 			<sec:authorize ifNotGranted="ROLE_ADMIN"> --%>
<!-- 				<script type='text/javascript'> -->
<!-- 					alert("항공감시 정보를 수정할 권한이 없습니다!"); -->
<!-- 					history.back(); -->
<%-- 					//window.location = "<c:url value='/'/>";  --%>
<!-- 				</script> -->
<%-- 			</sec:authorize> --%>
		</c:if>
	</c:if>