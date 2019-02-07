<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

	<script type='text/javascript'>
		var adminFlag = false;
	</script>
<%-- 	<sec:authorize ifAnyGranted="ROLE_ADMIN"> --%>
		<script type='text/javascript'>
			adminFlag = true;
		</script> 
<%-- 	</sec:authorize> --%>
	