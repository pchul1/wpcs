<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>

	<script type='text/javascript'>
		var algaManager = false;
	</script>
	
	<c:if test="${isAlgaGroup == true}">
		<script type="text/javascript">
			algaManager = true;
		</script>
	</c:if>
	