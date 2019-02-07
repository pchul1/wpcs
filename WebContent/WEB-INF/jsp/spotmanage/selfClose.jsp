<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/com.css' />" />
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/smcube/tab.css' />" />

	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<sec:authorize ifAnyGranted="ROLE_USER">
		<script  type='text/javascript'>
			var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
		</script> 
	</sec:authorize>
	
<%-- 	<sec:authorize ifNotGranted="ROLE_USER"> --%>
<!-- 		<script  type="text/javascript"> -->
<!-- 			alert("로그인이 필요한 페이지 입니다"); -->
<%-- 			window.location = "<c:url value='/'/>";  --%>
<!-- 		</script>  -->
<%-- 	</sec:authorize> --%>
<script type="text/javascript">
$(function(){
	$.ajax({
		type:"post",
		url:"<c:url value='/spotmanage/getIndexNum.do'/>",
		data:{},
		dataType:"json",
		success:function(result){
			var index = result['indexNum'];
			opener.parent.EventDiv(index);
			window.close();
		},
		error:function(result){
		
		}
	});
});
</script>
</head>
<body>
	<span id="index"></span>
</body>
</html>