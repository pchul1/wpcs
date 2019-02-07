<%@page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : alertTargetWrite.jsp
	 * Description : Alert Target 등록 화면
	 * Modification Information
	 * 
	 * 수정일         수정자                   수정내용
	 * -------    --------    ---------------------------
	 * 2010.05.20     k	        최초 생성
	 *
	 * author k
	 * since 2010.05.20
	 *  
	 * Copyright (C) 2010 by k  All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<title>한국환경공단 수질오염 방제정보 시스템</title>
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/popup.css'/>" />		
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />
	<sec:authorize ifAnyGranted="ROLE_USER">
		<script  type='text/javascript'>
			var user_dept_no = '<sec:authentication property="principal.userVO.deptNo"/>';
		</script> 
	</sec:authorize>
	
<%-- 	<sec:authorize ifNotGranted="ROLE_USER"> --%>
<!-- 		<script  type='text/javascript'> -->
<!-- 			alert('로그인이 필요한 페이지 입니다'); -->
<%-- 			window.location = "<c:url value='/'/>";  --%>
<!-- 		</script>  -->
<%-- 	</sec:authorize>		 --%>
	<script>			
		$(function(){			
			$('#checkAll').click(function () {
				checkAll();
			});
						
			$('#addRow').click(function () {
				saveAlertTarget();
			});
			
			$('#userTbody tr:odd').addClass('add'); 
		});

 
		function saveAlertTarget() {
			var cnt = 0;
			$('input[name=chk]:checked').each(function() {
				cnt++;
			});			

			if($('#factCode').val() == "" || $('#branchNo').val() == "") {
				alert("데이터가 정확하지 않습니다 창을 다시 열어주십시요.");
				return false;						
			}

			if(cnt == 0) {
				alert("추가할 사용자을 체크해주십시요.");
				return false;					
			}				

			document.saveFrm.submit();		   			
		}

		function checkAll(){
			var c = $('#checkAll').attr('checked');
			$('input[name=chk]').attr('checked',c);
		}		
	</script>			
</head>
<body class="subPop"><!-- 추가 및 수정 -->
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
			<h1 style='font-size:large;font-weight:bold;color:white'>추가 전파 대상 목록</h1>
		</div>
	</div>
</div>	

<div class="contentWrap">
	<div class="contentBg_r">
		<div class="contentBox">
			<div class="contentPad"><!-- //추가 및 수정 -->
				<div class="atPop" style="padding-top:20px">
					<div class="content">
					
						<div class="overBox">
							<form name="saveFrm" method="post" class="target" action="<c:url value='/alert/saveAlertTargetUser.do' />">
							<input type="hidden" id="factCode" name="factCode" value="${factCode}" />
							<input type="hidden" id="branchNo" name="branchNo" value="${branchNo}" />										
							<table class="dataTable">
								<colgroup>
									<col width="30px" />
									<col width="100px" />
									<col  />					
									<col width="100px" />																
								</colgroup>
								<thead>							
									<tr>
										<th scope="col"><input type="checkbox" class="inputCheck" id="checkAll" /></th>
										<th scope="col">이름</th>
										<th scope="col">소속</th>									
										<th scope="col">직위</th>
									</tr>
								</thead>
								<tbody id="userTbody">
									<c:forEach  items="${userList}"  var="user"  varStatus="status">
										<tr>
											<td><input type="checkbox" name="chk" class="inputCheck" value="${user.MEMBER_ID}" /></td>
											<td>${user.MEMBER_NAME}</td>
											<td>${user.OFFICE_NAME}</td>
											<td>${user.GRADE_NAME}</td>
										</tr>								
									</c:forEach>
								</tbody>
							</table>
							</form>
						</div>																															
						<ul class="btnMenu">
							<br/>
							<center><li><input id="addRow" type="image" src="<c:url value='/images/common/btn_add.gif'/>" alt="추가" /></li></center>	
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 -->	
</body>
</html>
