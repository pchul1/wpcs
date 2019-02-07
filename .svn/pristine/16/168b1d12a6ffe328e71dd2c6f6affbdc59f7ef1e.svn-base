<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	* Class Name : keywordList.jsp
	* Description : 보도자료 키워드 관리
	* Modification Information
	* 
	* 수정일			수정자					수정내용
	* -------		--------	---------------------------
	* 2014.09.11	~			최초 생성
	* 
	* author	yrkim
	* since 2014.09.11
	* 
	* Copyright (C) 2013 by ~ All right reserved.
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
<script type="text/javascript" src="<c:url value="/validator.do"/>"></script>
<validator:javascript formName="keywordVO" staticJavascript="false" xhtml="true" cdata="false"/>
<script type="text/javaScript">
//<![CDATA[
           
    $(document).ready(function() {
    	// 체크 박스 모두 체크
		$("#checkAll").click(function() {
			if($(this).attr("checked")== true){
				$("input[name=checkNo]").attr("checked", true);
			}else{
				$("input[name=checkNo]").attr("checked", false);
			}
			
		});
    	
		$("input[name=checkNo]").click(function() {
			$("input[name=checkAll]").attr("checked", false);
		});
	});
        
        
	//페이징 처리 함수
	function linkPage(pageNo){
		document.listForm.pageIndex.value = pageNo;
		document.listForm.action = "<c:url value='/admin/keyword/KeywordList.do'/>";
		document.listForm.submit();
	}
	
	//조회 처리 
	function fnSearch(){
		document.listForm.pageIndex.value = 1;
		document.listForm.submit();
	}
	
	//등록 처리 함수 
	function fnRegist(){
		location.href = "<c:url value='/rss/KeywordRegist.do'/>";
	}
	
	//수정 처리 함수
	function fnModify(id, mode, pageNo){
		var varForm				= document.all["Form"];
		varForm.action			= "<c:url value='/rss/KeywordList.do'/>";
		varForm.keywordId.value	= id;
		varForm.mode.value	= mode;
		varForm.pageIndex.value	= pageNo;
		varForm.searchKeyword.value	= document.listForm.searchKeyword.value;
		varForm.submit();
	}
	
// 	//삭제 처리 함수
	function fnDelete(id, pageNo){
		if(confirm("<spring:message code="common.delete.msg"/>")){
			var varForm				= document.all["Form"];
			varForm.action			= "<c:url value='/rss/KeywordRemove.do'/>";
			varForm.keywordId.value	= id;
			varForm.pageIndex.value	= pageNo;
			varForm.searchKeyword.value	= document.listForm.searchKeyword.value;
			varForm.submit();
		}
	}
	
	//삭제 처리 함수
// 	function fnDelete(pageNo){
// 		if(confirm("<spring:message code="common.delete.msg"/>")){
// 			var varForm				= document.all["Form"];
// 			varForm.action			= "<c:url value='/rss/KeywordRemove.do'/>";
// 			varForm.pageIndex.value	= pageNo;
// 			varForm.searchKeyword.value	= document.listForm.searchKeyword.value;
// 			varForm.submit();
// 		}
// 	}
	
	//등록처리화면
	function fn_egov_regist_Keyword(form, mode){
		if($('#keywordNm').val() == "" || $('#keywordNm').val().replace(/\s*$/, "")=="") {
			alert('키워드를 입력해 주세요');
			return;
		}
		
		if(confirm("<spring:message code="common.save.msg" />")){
			form.action	= "<c:url value='/rss/KeywordRegist.do'/>";
			form.mode.value	= mode;
			form.pageIndex.value  = 1;
			form.searchKeyword.value  = "";
			form.submit();
		}
	}
	
	//수정처리화면
	function fn_egov_edit_Keyword(form, mode, pageNo){
		if($('#keywordNm').val() == "" || $('#keywordNm').val().replace(/\s*$/, "")=="") {
			alert('키워드를 입력해 주세요');
			return;
		} else {
			if($('#keywordNm').val().indexOf(",") > -1){
				alert("쉼표(,)는 등록 하실 수 없습니다.");
				return;
			}
		}
		document.listForm.pageIndex.value = pageNo;
		form.action = "<c:url value='/rss/KeywordEdit.do'/>";
		form.mode.value = mode;
		form.pageIndex.value  = pageNo;
		form.searchKeyword.value = document.listForm.searchKeyword.value;
		form.submit();
	}
	
	function onloadFunc() {
		<c:if test="${not empty resultMsg }">
			alert("${resultMsg}");
		</c:if>
	}
//]]>
</script>
</head>

<body onLoad="onloadFunc();">
	<div id='loadingDiv' style="visibility: hidden; position: absolute;">
		<img src="<c:url value='/images/common/ajax-loader2.gif'/>" alt="로딩중.." />
	</div>
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

						<form name="Form" action="" method="post">
							<input type=hidden name="keywordId">
							<input type="hidden" name="mode" value="<c:out value="${mode}"/>" >
							<input type="hidden" name="pageIndex">
							<input type="hidden" name="searchKeyword">
						</form>
						<form:form commandName="keywordVO" name="keywordVO" method="post">
							<input type="hidden" name="mode" value="<c:out value="${mode}"/>" >
							<input type="hidden" name="pageIndex">
							<input type="hidden" name="searchKeyword">

							<div class="table_wrapper">
								<table summary="그룹정보">
									<colgroup>
										<col width="20%">
										<col>
									</colgroup>
									<tr>
										<th>키워드</th>
										<td>
											<c:choose>
												<c:when test="${mode == 'edit'}">
													<form:input path="keywordNm" size="70" maxlength="100"/>
													<form:hidden path="keywordId"/>
												</c:when>
												<c:otherwise>
													<input name="keywordNm" id="keywordNm" type="text" required="true" fieldTitle="비밀번호 키워드" char="s"  maxLength="100" size="70"/>
												</c:otherwise>
											</c:choose>
											<span>
												<c:choose>
													<c:when test="${mode == 'edit'}">
														<input type="button" id="btnEdit_Keyword" name="btnEdit_Keyword" value="수정" class="btn btn_basic" onclick="JavaScript:fn_egov_edit_Keyword(document.keywordVO, 'editOK', '<c:out value="${searchVO.pageIndex}"/>');" alt="수정" />
													</c:when>
													<c:otherwise>
														<input type="button" id="btnRegistKeyword" name="btnModify" value="저장" class="btn btn_basic" onclick="JavaScript:fn_egov_regist_Keyword(document.keywordVO, 'registOK');" alt="저장" />
													</c:otherwise>
												</c:choose>
											</span>
										</td>
									</tr>
								</table>
								<div style="padding:5px;">
									※쉼표(,)로 구분해서 입력하면 일괄 등록할 수 있습니다. 이전 키워드와 중복될 경우 등록되지 않습니다.<br>
									예) 4대강, 수질, 탁수
								</div>
							</div>
						</form:form>
						
						<form name="listForm" action="<c:url value='/rss/KeywordList.do'/>" method="post">
							<!--top Search Start-->
							<div class="topBx">
								키워드 :
								<input type="hidden" name="searchCondition" type="text" size="35" value="name" />
								<input name="searchKeyword" type="text" size="35" value="<c:out value="${searchVO.searchKeyword}"/>" maxlength="35" />
								
								<input type="button" id="btnSearch" name="btnSearch" value="검색" class="btn btn_search" onclick="javascript:fnSearch();" alt="검색" />
							</div>
							<!--top Search End-->
		
							<div class="table_wrapper">
								<table summary="키워드정보">
									<colgroup>
										<col width="10%">
										<col width="40%">
										<col width="13%">
										<col width="12%">
										<col width="20%">
									</colgroup>
									<thead> 
										<tr> 
											<th>순번</th>
											<th>키워드</th>
											<th>등록일</th>
											<th>등록시간</th>
											<th>관리</th>
										</tr> 
									</thead> 
									<tbody>
										<c:set var="i" value="0" />
										<c:forEach items="${resultList}" var="resultInfo" varStatus="status">
										<c:set var = "checkFilterNo" value="${resultInfo.keywordId}" />
											<c:set var = "checkFilterNo" value="${filterNo}" />
											<c:set var="i" value="${i+1}" />
											<c:set var="even" value="" />
											<c:if test="${i%2 == 0}">
												<c:set var="even" value="even" />
											</c:if>
										<tr class="<c:out value="${even}"/>">
											<td><c:out value="${((searchVO.pageIndex - 1)*searchVO.pageUnit) + status.count}"/></td>
											<td>${resultInfo.keywordNm}</td>
											<td><c:out value="${resultInfo.regDate}"/></td>
											<td><c:out value="${resultInfo.regTime}"/></td>
											<td>
												<input type="button" id="btnModify" name="btnModify" value="수정" class="btn btn_basic" onclick="javascript:fnModify('<c:out value="${resultInfo.keywordId}"/>', 'edit', '<c:out value="${searchVO.pageIndex}"/>');" alt="수정" />
												<input type="button" id="btnDelete" name="btnDelete" value="삭제" class="btn btn_basic" onclick="javascript:fnDelete('<c:out value="${resultInfo.keywordId}"/>', '<c:out value="${searchVO.pageIndex}"/>');" alt="삭제" />
											</td>
										</tr>
										</c:forEach>
										<c:if test="${fn:length(resultList) == 0}">
										<tr> 
											<td colspan=5>
												<spring:message code="common.nodata.msg" />
											</td>
										</tr>
										</c:if>
									</tbody>
								</table>
								<div class="paging">
									<div id="page_number">
										<ui:pagination paginationInfo = "${paginationInfo}" type="default" jsFunction="linkPage"/>
									</div>
								</div>
								<!-- 버튼 메뉴 -->
<%-- 								<sec:authorize ifAnyGranted="ROLE_ADMIN"> --%>
<!-- 									<div id="btArea"> -->
<!-- 										<input type="button" id="btnAddNotice" name="btnAddNotice" value="삭제" class="btn btn_basic" onclick="javascript:fnDelete();" alt="삭제" />											 -->
<!-- 									</div> -->
<%-- 								</sec:authorize> --%>
								<!-- //버튼 메뉴 -->
								<!-- 검색조건 유지 -->
								<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>
							</div>
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