<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

	<c:if test="${param.mode == 'modify'}">
		<c:if test="${isAlgaGroup == null}">
<%-- 			<sec:authorize ifNotGranted="ROLE_ADMIN"> --%>
<!-- 				<script language="javascript"> -->
<!-- 					alert("조류예보 정보를 수정할 권한이 없습니다!"); -->
<!-- 					history.back(); -->
<%-- 					//window.location = "<c:url value='/'/>";  --%>
<!-- 				</script> -->
<%-- 			</sec:authorize> --%>
		</c:if>
		<c:if test="${isAlgaGroup == false}">
<%-- 			<sec:authorize ifNotGranted="ROLE_ADMIN"> --%>
<!-- 				<script language="javascript"> -->
<!-- 					alert("조류예보 정보를 수정할 권한이 없습니다!"); -->
<!-- 					history.back(); -->
<%-- 					//window.location = "<c:url value='/'/>";  --%>
<!-- 				</script> -->
<%-- 			</sec:authorize> --%>
		</c:if>
	</c:if>