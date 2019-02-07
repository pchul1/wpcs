<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : EgovBoardMstrList.jsp
	 * Description : 게시판속성목록 화면
	 * Modification Information
	 * 
	 * 수정일         		수정자                   수정내용
	 * -------    	--------    ---------------------------
	 * 2009.03.12 	이삼섭			 최초 생성
	 * 2013.11.01	lkh			리뉴얼
	 *
	 * author 
	 * since 2009.03.12
	 *  
	 * Copyright (C) 2009 by 이상성 All right reserved.
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

<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />"></script>

<script type="text/javascript">
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_brdMstr('1');
		}
	}
	
	function fn_egov_insert_addBrdMstr(){	
		document.frm.action = "<c:url value='/admin/bbs/addBBSMaster.do'/>";
		document.frm.submit();
	}
	
	function fn_egov_select_brdMstr(pageNo){
		document.frm.pageIndex.value = pageNo; 
		document.frm.action = "<c:url value='/admin/bbs/SelectBBSMasterInfs.do'/>";
		document.frm.submit();	
	}
	
	function fn_egov_inqire_brdMstr(bbsId){
		document.frm.bbsId.value = bbsId;
		document.frm.action = "<c:url value='/admin/bbs/SelectBBSMasterInf.do'/>";
		document.frm.submit();			
	}
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

						<form name="frm" method="post">
							<input type="hidden" name="bbsId">
							<input type="hidden" name="trgetId">
							
							<!--top Search Start-->
							<div class="topBx">
								<select name="searchCnd" class="select">
									<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >게시판명</option>
								   	<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >게시판유형</option>	
							   	</select>
							   	<input name="searchWrd" type="text" size="35" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="35" onkeypress="press(event);" title="검색" /> 
								<input type="button" id="btnSearch" name="btnSearch" value="조회" class="btn btn_search" onclick="javascript:fn_egov_select_brdMstr('1');" alt="조회" />
							</div>
							<!--top Search End-->
							
							<div class="table_wrapper">
								<table summary="게시판정보">
									<colgroup>
										<col width="5%">
										<col>
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<thead> 
										<tr> 
											<th>번호</th>  
											<th>게시판명</th> 
											<th>링크</th> 
											<th>게시판유형</th> 
											<th>게시판속성</th> 
											<th>생성일</th> 
											<th>사용여부</th>
										</tr> 
									</thead>
									<tbody>
										<c:set var="i" value="0" />
										<c:forEach var="result" items="${resultList}" varStatus="status">
											<c:set var = "checkFilterNo" value="${filterNo}" />
											<c:set var="i" value="${i+1}" />
											<c:set var="even" value="" />
											<c:if test="${i%2 == 0}">
												<c:set var="even" value="even" />
											</c:if>
										<tr class="<c:out value="${even}"/>">
											<td>
												<c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/>
											</td> 
											<td>
												<a href="javascript:fn_egov_inqire_brdMstr('<c:out value="${result.bbsId}"/>')">
								    			<c:out value="${result.bbsNm}"/></a>
											</td> 
											<td>
												<a href="<c:url value='/bbs/selectBoardList.do'/>?bbsId=<c:out value="${result.bbsId}"/>" target="_blank">링크</a>
											</td> 
											<td><c:out value="${result.bbsTyCodeNm}"/></td> 
											<td><c:out value="${result.bbsAttrbCodeNm}"/></td> 
											<td><c:out value="${result.frstRegisterPnttm}"/></td>
											<td>
												<c:if test="${result.useAt == 'N'}"><spring:message code="button.notUsed" /></c:if>
								    			<c:if test="${result.useAt == 'Y'}"><spring:message code="button.use" /></c:if>
											</td> 
										</tr> 
										</c:forEach>
										<c:if test="${fn:length(resultList) == 0}">
										<tr>
										   	<td colspan="6"><spring:message code="common.nodata.msg" /></td>  
										</tr>		 
										</c:if>
									</tbody>
								</table>
							</div>
							<div class="paging">
								<div id="page_number">
									<ui:pagination paginationInfo = "${paginationInfo}" type="default" jsFunction="fn_egov_select_brdMstr" />
								</div>
							</div>
							<div style="float:right;">
								<input type="button" id="btnAddBrdMstr" name="btnAddBrdMstr" value="등록" class="btn btn_basic" onclick="javascript:fn_egov_insert_addBrdMstr();" alt="등록" />
							</div>
							<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
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