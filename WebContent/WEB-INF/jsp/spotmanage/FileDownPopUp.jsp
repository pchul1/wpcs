<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	
	<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />
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
	var indexNum = parent.document.getElementById("indexNum").value;
	var UpdateSeq = parent.document.getElementById("UpdateSeq").value;
	var factCode = parent.document.getElementById("fc"+indexNum).innerHTML;
	var branchNo = parent.document.getElementById("bn"+indexNum).value;
	
	$(function () {
		$("#indexNum").val(indexNum);
		$("#itemseq").val(UpdateSeq);
		
		if(indexNum == ""){
			alert("지점을 선택 하신 후 등록하여 주십시오.");
			window.close();
		}else{
			$("#factCode").val(factCode);
			$("#branchNo").val(branchNo);
			Commit();
		}
	});
	
	function Commit(){
		document.board.action = "<c:url value='/spotmanage/FileDown.do'/>";
		document.board.submit();
	}
</script>
</head>
<body style="overflow-x:hidden;overflow-y:hidden;">
	<form:form commandName="board" name="board" method="post" enctype="multipart/form-data" >
		<input type="hidden" id="indexNum" name="indexNum" />
		<input type="hidden" id="itemseq" name="itemseq" />
		<input type="hidden" id="factCode" name="factCode" />
		<input type="hidden" id="branchNo" name="branchNo" />
	</form:form>
</body>
</html>