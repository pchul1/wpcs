<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.ArrayList"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
  /**
  * @Class Name : alertTargetWrite.jsp
  * @Description : Alert Target 등록 화면
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
	<link rel="stylesheet" type="text/css" href="<c:url value='/css/content.css'/>" />		
	<c:import url="/WEB-INF/jsp/include/common/include_js.jsp" />		
</head>
<body class="popup_sms">
<div id="wrap">
	<div class="smsSection">	
		<div class="inner_noticelist">
			<fieldset>			
				<div class="showData">				
					<div class="data_wrap">											
						<div class="overBox">								
							<table class="dataTable">								
								<colgroup>
									<col width="100px" />								
									<c:forEach  items="${factList}"  var="fact"  varStatus="status">					
									<col width="100px" />
									</c:forEach>
								</colgroup>
								<thead>							
									<tr>
										<th scope="col">/</th>
										<c:forEach  items="${factList}"  var="fact"  varStatus="status">					
										<th scope="col">${fact.FACTNAME} - ${fact.BRANCHNO}</th>
										</c:forEach>									
									</tr>
								</thead>
								<tbody id="userTbody">										
									<c:forEach  items="${coefCorrArr}"  var="coefCorr"  varStatus="status">
										<tr>
											<c:forEach  items="${coefCorr}"  var="tmps"  varStatus="status">
											<td>${tmps }</td>
											</c:forEach>
										</tr>								
									</c:forEach>
								</tbody>
							</table>
						</div>																															
						<ul class="btnMenu">
							<li><input id="addRow" type="image" src="<c:url value='/images/common/btn_add.gif'/>" alt="추가" /></li>									
						</ul>
					</div>
				</div>
			</fieldset>
		</div>										
	</div>
</div>
</body>
</html>
