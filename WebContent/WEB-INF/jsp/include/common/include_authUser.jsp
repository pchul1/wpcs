<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
	
	<sec:authorize ifNotGranted="ROLE_USER, ROLE_ADMIN, 환경공단, 환경부, 환경청, ROLE_ADMIN_DEPT, ROLE_MANAGER, ROLE_EXPERT">
		<script type='text/javascript'>
 			alert('로그인이 필요한 페이지 입니다');
 			window.location = "<c:url value='/'/>";
		</script>
	</sec:authorize>
	
	<sec:authorize ifAnyGranted="ROLE_USER, ROLE_ADMIN, 환경공단, 환경부, 환경청, ROLE_ADMIN_DEPT, ROLE_MANAGER, ROLE_EXPERT">
		<script type='text/javascript'>
		
			var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
// 			var user = '<sec:authentication property="principal.userVO"/>';
			var id = '<sec:authentication property="principal.userVO.id"/>';
// 			var user_riverid = '<sec:authentication property="principal.userVO.riverId"/>';
			var user_riverid = 'null';
			var user_roleCode = '<sec:authentication property="principal.userVO.roleCode"/>';
			
			var user_u_cnt = '<sec:authentication property="principal.userVO.userUcnt"/>';		//IP_USN 
			var user_a_cnt = '<sec:authentication property="principal.userVO.userAcnt"/>';		//국가수질측정망 
			var user_w_cnt = '<sec:authentication property="principal.userVO.userWcnt"/>';	//TMS 
		
			if (id == null || id == "" ||id == "undefined"){
				alert('로그인이 필요한 페이지 입니다');
				window.location = "<c:url value='/'/>";
			}
			
			var myAuthorSessionFactCode = new Array;
			var myAuthorSessionBranchNo = new Array;
			var myAuthorSessionAllFactCode = new Array;
			
			<c:forEach items="${sessionScope.authorList}" var="item">
				myAuthorSessionFactCode.push('${item.fact_code}');
				myAuthorSessionBranchNo.push('${item.branch_no}');
				myAuthorSessionAllFactCode.push('${item.fact_code}-${item.branch_no}');
			</c:forEach>
		</script>
		
	</sec:authorize>
