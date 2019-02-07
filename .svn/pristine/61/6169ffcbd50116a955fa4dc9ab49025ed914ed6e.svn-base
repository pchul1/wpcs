<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : EgovMenuCreatManage.jsp
	 * Description : 메뉴생성관리조회 화면
	 * Modification Information
	 * 
	 * 수정일         		수정자                   수정내용
	 * -------    	--------    ---------------------------
	 * 2009.03.10	이용			최초 수정
	 * 2013.11.01	lkh			리뉴얼
	 *
	 * author 공통서비스개발팀 이용
	 * since 2009.03.10
	 *  
	 * Copyright (C) 2009 by 이용 All right reserved.
	 */  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<script type="text/javascript">
<!--
	//최초조회 함수
	function fMenuCreatManageSelect(){ 
	    document.menuCreatManageForm.action = "<c:url value='/admin/menu/EgovMenuCreatManageSelect.do'/>";
	    document.menuCreatManageForm.submit();
	}
	
	//페이징 처리 함수
	function linkPage(pageNo){
		document.menuCreatManageForm.pageIndex.value = pageNo;
		document.menuCreatManageForm.action = "<c:url value='/admin/menu/EgovMenuCreatManageSelect.do'/>";
	   	document.menuCreatManageForm.submit();
	}
	
	//조회 처리 함수
	function selectMenuCreatManageList() { 
		document.menuCreatManageForm.pageIndex.value = 1;
	    document.menuCreatManageForm.action = "<c:url value='/admin/menu/EgovMenuCreatManageSelect.do'/>";
	    document.menuCreatManageForm.submit();
	}
	
	//메뉴생성 화면 호출
	function selectMenuCreat(vAuthorCode) {
		document.menuCreatManageForm.authorCode.value = vAuthorCode;
	   	document.menuCreatManageForm.action = "<c:url value='/admin/menu/EgovMenuCreatSelect.do'/>";
	   	document.menuCreatManageForm.submit();	
	}
	
	function press() {
	
	    if (event.keyCode==13) {
	    	javascript:selectMenuCreatManageList();
	    }
	}
	<c:if test="${!empty resultMsg}">alert("${resultMsg}");</c:if>
//-->
</script>
</head>

<body> 
<%-- 	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div> --%>
	<div id="wrap">
	
		<!-- Head Start-->
		<div id="header">
			<c:import url="/common/menu/header.do" />
		</div>		
		<!-- Head End-->
		
		<!-- Body Start-->
		<div id="container">
			<div id="content_wrapper">
			
				<!--left menu Start-->
				<c:import url="/common/menu/left.do" />
				<!--left menu End-->

				<!-- Content Start-->
				<div id="content">
				
					<!-- navi, tab menu Start-->
					<c:import url="/common/menu/navi.do" />
					<!-- navi, tab menu End-->
						
					<!--tab Contnet Start-->
					<div class="tab_container">

						<form name="menuCreatManageForm" action ="javascript:fMenuCreatManageSelect();" method="post">
							<input name="checkedMenuNoForDel" type="hidden" />
							<input name="authorCode" type="hidden" />
							<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
							
							<!--top Search Start-->
							<div class="topBx">
								보안설정대상ID :
								<input name="searchKeyword" type="text" size="40" title="검색"  maxlength="40" onkeypress="press();">
							   	<input type="text" name="searchKeyword" size="25" title="검색" onkeypress="press();">
								<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" onclick="javascript:selectMenuCreatManageList();" alt="조회" />
							</div>
							<!--top Search End-->
							
							<div class="table_wrapper">
							
								<table summary="메뉴권한정보">
									<colgroup>
										<col width="15%">
										<col width="20%">
										<col>
										<col width="10%">
										<col width="10%">
									</colgroup>
									<thead> 
										<tr> 
											<th>권한 코드</th> 
											<th>권한 명</th> 
											<th>권한 설명</th> 
											<th>메뉴생성여부</th> 
											<th>메뉴생성</th> 
										</tr> 
									</thead> 
									<tbody>
										<c:set var="i" value="0" />
										<c:forEach var="result" items="${list_menumanage}" varStatus="status">
											<c:set var = "checkFilterNo" value="${filterNo}" />
											<c:set var="i" value="${i+1}" />
											<c:set var="even" value="" />
											<c:if test="${i%2 == 0}">
												<c:set var="even" value="even" />
											</c:if>
										<tr class="<c:out value="${even}"/>"> 
											<td>
												<c:choose>
													<c:when test="${fn:length(result.authorCode) > 17}">
														<c:out value="${fn:substring(result.authorCode,0,17)}"/>...
													</c:when>
													<c:otherwise>
														<c:out value="${result.authorCode}"/>
													</c:otherwise>
												</c:choose>
											</td> 
											<td><c:out value="${result.authorNm}"/></td> 
											<td><c:out value="${result.authorDc}"/></td> 
											<td>
												<c:if test="${result.chkYeoBu > 0}">사용</c:if>
						          				<c:if test="${result.chkYeoBu == 0}">미사용</c:if>
											</td> 
											<td>
												<input type="button" id="btnMenuCreat" name="btnMenuCreat" value="메뉴생성" class="btn btn_basic" onclick="javascript:selectMenuCreat('<c:out value="${result.authorCode}"/>');" alt="메뉴생성" />
											</td>
										</tr>
										</c:forEach> 
									</tbody>
								</table>
								<div class="paging">
									<div id="page_number">
										<ui:pagination paginationInfo = "${paginationInfo}"	type="default" jsFunction="linkPage"/>
									</div>
								</div>
							</div>
							
							<input type="hidden" name="req_menuNo">
						</form>

				
					</div>
					<!--tab Contnet End-->
				</div>
				<!-- Content End-->
			</div>
		</div>
		<!-- Body End-->

		<!-- Footer Start-->
		<div id="footer">
			<c:import url="/WEB-INF/jsp/include/footer.jsp" />
		</div>
		<!-- Footer End-->
	</div>
</body>
</html>