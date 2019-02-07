<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
  /**
  * @Class Name : alertSmsMsg.jsp
  * @Description : 사용자가 발송했떤 SMS 메시지 목록을 가져온다.
  * @Modification Information
  * 
  *   수정일         수정자                   수정내용
  *  -------    --------    ---------------------------	
  *  2010.05.20     k	        최초 생성
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
<%-- 	</sec:authorize> --%>
</head>
	
<body class="subPop"><!-- 추가 및 수정 -->
<div class="headerWrap">
	
		<div class="header">
			<h1 style='font-size:large;font-weight:bold;color:white'>SMS 통보 수신인 목록</h1>
		</div>
	
</div>	
<div class="contentWrap">
	<div class="contentBg_r">
		<div class="contentBox">
			<div class="contentPad"><!-- //추가 및 수정 -->
				<div class="content">
					<div class="overBox">
						<table style="width: 350px;" class="dataTable">
							<colgroup>
								<col />																		
								<col width="60px" />																					
								<col width="100px" />
							</colgroup>
							<thead>							
								<tr>
									<th scope="col">대상기관</th>									
									<th scope="col">담당자</th>									
									<th scope="col">번호</th>
								</tr>
							</thead>
							<tbody id="userTbody">
								<c:forEach  items="${msgMemberList}"  var="msg"  varStatus="status">
									<tr>
										<td style="text-align: left;">&nbsp;${msg.DEPTNAME}</td>
										<td style="text-align: center;">${msg.MEMBERNAME}</td>
										<td style="text-align: left;">&nbsp;${msg.MOBILENO}</td>
									</tr>								
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
				
			</div>
		</div>
	</div>
</div>
<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div><!-- //추가 및 수정 -->					
</body>
</html>
