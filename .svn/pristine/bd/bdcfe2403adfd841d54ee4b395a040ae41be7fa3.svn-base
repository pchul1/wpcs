<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : rssManageList.jsp
	 * Description : 보도자료
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 							최초작성
	 * 2014.09.03	yrkim	
	 * 
	 * author 
	 * since 2014.09.03
	 * 
	 * Copyright (C) 2014 by lkh All right reserved.
	 */
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/1999/REC-html401-19991224/loose.dtd">
<html>

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<title>한국환경공단 수질오염 방제정보 시스템</title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<%
	String startDate = request.getParameter("startDate");
	String endDate = request.getParameter("endDate");
%>

<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />" ></script>
<script type="text/javascript">
//<![CDATA[
    $(document).ready(function() {
    	// 체크 박스 모두 체크
		$("#checkAll").click(function() {
			if($(this).attr("checked")== "checked"){
				$("input[name=checkNo]").attr("checked", true);
			}else{
				$("input[name=checkNo]").attr("checked", false);
			}
			
		});
    	
		$("input[name=checkNo]").click(function() {
			$("input[name=checkAll]").attr("checked", false);
		});
		
		$.datepicker.setDefaults({
			monthNames: ['년 1월','년 2월','년 3월','년 4월','년 5월','년 6월','년 7월','년 8월','년 9월','년 10월','년 11월','년 12월'],
			dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			showMonthAfterYear:true,
			dateFormat: 'yy/mm/dd',
			showOn: 'both',
			buttonImage: "<c:url value='/images/common/ico_calendar.gif'/>",
			buttonImageOnly: true
		});
		$("#startDate").datepicker({
			buttonText: '시작일'
			
		});
		$("#endDate").datepicker({
			buttonText: '종료일'
		});
	});
    
    function fn_rss_list(){
		document.frm.action = "<c:url value='/rss/rssDataList.do'/>";
		document.frm.submit();			
	}
    
    function fn_egov_select_rssDataList(pageNo) {
		document.frm.pageIndex.value = pageNo; 
		document.frm.action = "<c:url value='/rss/rssDataList.do'/>";
		document.frm.submit();	
	}
    
	function fn_addRss(){
		var form = document.frm;
		
		if ( $('input:checkbox[name="checkNo"]:checked').length > 0 ){
			if(confirm("<spring:message code="common.save.msg" />")){
				var chked_val = "";
				$(":checkbox[name='checkNo']:checked").each(function(pi,po){
					chked_val += ","+po.value;
				});
				
				if(chked_val!="")chked_val = chked_val.substring(1);
				
				form.checkRssId.value = chked_val;
				form.action	= "<c:url value='/rss/rssDataRegist.do'/>";
				form.pageIndex.value  = 1;
				form.submit();
			}
    	}else{
    		alert("보도자료를 선택해주세요.");
			return false;
    	}
    }
    
    function fn_delRss(){
    	var form = document.frm;
    	
    	if ( $('input:checkbox[name="checkNo"]:checked').length > 0 ){
    		if(confirm("<spring:message code="common.delete.msg" />")){
				var chked_val = "";
				$(":checkbox[name='checkNo']:checked").each(function(pi,po){
					chked_val += ","+po.value;
				});
				
				if(chked_val!="")chked_val = chked_val.substring(1);
				
				form.checkRssId.value = chked_val;
				
				form.action	= "<c:url value='/rss/rssDataDelete.do'/>";
				form.pageIndex.value  = 1;
				form.submit();
			}
    	}else{
    		alert("보도자료를 선택해주세요.");
			return false;
    	}
    }
    
	function excelDown() {
		var startDate = $("#startDate").val();
		var endDate = $("#endDate").val();
		var searchStatus = "";
		var searchCnd = ""
		var searchWrd = "";
		
		if($("#searchStatus option:selected").val() != ""){
			searchStatus = $("#searchStatus option:selected").val();
		}
		
		if($("#searchWrd").val() != ""){
			searchCnd = $("#searchCnd option:selected").val();
			searchWrd = $("#searchWrd").val()
		}
	
		var param = "startDate=" + startDate + "&endDate=" + endDate + "&searchStatus=" + searchStatus +
				"&searchCnd=" + searchCnd + "&searchWrd=" + searchWrd;
		
		location.href="<c:url value='/rss/rssDataListExcel.do'/>?"+param;
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
						<form name="frm" action ="" method="post">
							<input type="hidden" name="checkRssId" id="checkRssId"/>
							<!-- 일반 게시판 -->
									<!-- 현 페이지 경로 -->
									<!--top Search Start-->
									<div class="searchBox dataSearch">
										<ul>
											<li>
												<span class="fieldName">등록기간</span>
												<input type="text" id="startDate" name="startDate" size="13" value="<c:out value="${searchVO.startDate}"/>" alt="조회시작일"/>
												<span>~</span>
												<input type="text" id="endDate" name="endDate" size="13" value="<c:out value="${searchVO.endDate}"/>" alt="조회종료일"/>
											</li>
											<li>
												<span class="fieldName">상태</span>
												<select name="searchStatus" id="searchStatus" class="select">
												<option value="">전체</option>
												<option value="N" <c:if test="${searchVO.searchStatus == 'N'}">selected="selected"</c:if>>대기</option>
												<option value="I" <c:if test="${searchVO.searchStatus == 'I'}">selected="selected"</c:if>>등록</option>
												<option value="D" <c:if test="${searchVO.searchStatus == 'D'}">selected="selected"</c:if>>삭제</option>
												</select>
											</li>
											<li>
												<span class="fieldName">구분</span>
												<select name="searchCnd" id="searchCnd" class="select">
												<option value="title" <c:if test="${searchVO.searchCnd == 'title'}">selected="selected"</c:if> >제목</option>
												<option value="content" <c:if test="${searchVO.searchCnd == 'content'}">selected="selected"</c:if> >내용</option>
												</select>
												&nbsp;&nbsp;&nbsp;
												<input type="text" name="searchWrd" id="searchWrd" class="inputText" size="55" value='<c:out value="${searchVO.searchWrd}"/>' onkeypress="press(event);" title="조회" />
											</li>
										</ul>
									</div>
									<div class="btnSearchDiv">
										<input type="button" id="btnSearch" name="btnSearch" value="조회하기" class="btn btn_search" onclick="javascript:fn_rss_list();" alt="조회하기" style="float:right;"/>
									</div>
									<!--top Search End-->
									<div id="btArea">
										<span id="p_total_cnt">[총 <c:out value="${resultCnt}"/>건]</span>
									</div>
									<!-- 글목록 내용 -->
									<div class="table_wrapper">
										<table summary="checkbox, No, 언론사, 제목, 내용, 등록일, 상태 ">
											<colgroup>
												<col width="30" />
												<col width="50" />
												<col width="120" />
												<col width="250" />
												<col />
												<col width="90" />
												<col width="70" />
											</colgroup>
											<thead>
												<tr>
													<th scope="col"><input type="checkbox" id="checkAll" name="checkAll"/></th>
													<th scope="col">번호</th>
													<th scope="col">언론사</th>
													<th scope="col">제목</th>
													<th scope="col">내용</th>
													<th scope="col">등록일</th>
													<th scope="col">상태</th>
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
														<input type="checkbox" id="checkNo" name="checkNo" value="<c:out value='${result.rssId}'/>"/>
													</td>
													<td>
														<c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/>
													</td>
													<td><c:out value="${result.author}"/></td>
													<td class="con" style="text-align:left; padding:0px 10px;">
														<a href="<c:out value='${result.url}'/>" target="_blank">
														<c:out value="${result.title}"/>
														</a>
													</td>
													<td class="con" style="text-align:left; padding:0px 10px; padding-top:5px; padding-bottom:5px;">
														<a href="<c:out value='${result.url}'/>" target="_blank"><c:set var="description" value="${result.description}"/>
														<c:out value="${fn:substring(description, 0, 77)}"/>...
														</a>
													</td>
													<td><c:out value="${result.publisheddate}"/></td>
													<td><c:out value="${result.status}"/></td>
												</tr>
												</c:forEach>
												<c:if test="${fn:length(resultList) == 0}">
													<tr>
														<td class="listCenter" colspan="7" ><spring:message code="common.nodata.msg" /></td>
													</tr>
												</c:if>
											</tbody>
										</table>
										
									<!-- 페이징 -->
									<div class="paging">
										<div id="page_number">
											<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_select_rssDataList" />
										</div>
									</div>
									<!-- //페이징 -->
									
									<!-- 버튼 메뉴 -->
									<sec:authorize ifAnyGranted="ROLE_ADMIN">
										<div id="btArea">
											<input type="button" id="btnAddNotice" name="btnAddNotice" value="등록" class="btn btn_basic" onclick="javascript:fn_addRss();" alt="등록" />
											<input type="button" id="btnAddNotice" name="btnAddNotice" value="삭제" class="btn btn_basic" onclick="javascript:fn_delRss();" alt="삭제" />											
										</div>
									</sec:authorize>
									<!-- //버튼 메뉴 -->
								<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>"/>	
								</div>
								<!-- //글목록 내용 -->
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