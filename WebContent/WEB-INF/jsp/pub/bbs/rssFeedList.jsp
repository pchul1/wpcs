<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="ko">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
<title>한국환경공단 수질오염 방제정보 시스템</title>
<link rel="stylesheet" type="text/css" href="/css/newFrontCommon.css"/>
<script type="text/javascript" src="<c:url value='/js/JQuery/jquery-1.3.2.min.js'/>"></script>
<script type="text/javascript" src="/js/common.js"></script>
<script type="text/javascript" src="/js/tab.js"></script>
<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />" ></script>
<script type="text/javascript">
//<![CDATA[
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_rssDataList('1');
		}
	}
	
	function fn_egov_select_rssDataList(pageNo) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/rss/rssDataSelect.do'/>";
		document.frm.submit();
	}
	
	// 페이지 번호 클릭
	function linkPage(pageNo){
		reloadData(pageNo);
	}
//]]>
</script>
</head>
<body>
<!-- wrap -->

<div id="wrap"> 
  
	<!--header -->
	<div class="header_wrap">
		<c:import url="/WEB-INF/jsp/pub/include/client_header.jsp"/>
	</div>
	<!--header --> 
  
	<!--container -->
	<div class="container_wrap">
		<div id="container"> 
		    
			<!--content wrap -->
			<div class="content_wrap">
				<div id="snb">
					<c:import url="/WEB-INF/jsp/pub/include/leftMenu4.jsp"/>
				</div>
				<div class="content">
					<!-- Navi -->
					<p class="spot">홈 &gt; 정보마당 &gt; <span class="point">보도자료</span></p>
					<h3>보도자료</h3>
					<!-- Navi -->
					 <div class="section_table02">
						<form name="frm" action ="" method="post">
							<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
							<input type="hidden" name="menu" value="${menu}"/>
							<input type="hidden" name="no" value="${no}"/>
							<!-- 일반 게시판 -->
							<div class="table_right">
								<p>
								<select name="searchCnd" class="select_box01" title="선택">
									<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >제목</option>
									<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >내용</option>
									<option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> >게시자</option>
								</select>
								<input type="text" name="searchWrd" id="" value='<c:out value="${searchVO.searchWrd}"/>' onkeypress="press(event);" class="search_box01" title="검색어"/> 
								<input type="image" src="<c:url value='/images/new/btn_search01.gif'/>" alt ="검색" onclick="javascript:fn_egov_select_noticeList('1');return false;"/>
								</p>
							</div>
							<!-- 글목록 내용 -->
							<table summary="번호,언론사,제목,내용,작성일자">
								<caption>보도자료</caption>
								<colgroup>
									<col width="45" />
									<col width="90" />
									<col width="150" />
									<col />
									<col width="90" />
								</colgroup>
								<thead>
									<tr>
										<th class="first" scope="col">번호</th>
										<th scope="col">언론사</th>
										<th scope="col">제목</th>
										<th scope="col">내용</th>
										<th scope="col">작성일자</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach var="result" items="${resultList}" varStatus="status">
									<tr>
										<td>
											<c:out value="${status.count + ((paginationInfo.currentPageNo-1) * paginationInfo.recordCountPerPage)}"/>
										</td>
										<td><c:out value="${result.author}"/></td>
										<td style="text-align:left; padding:0px 10px;"><c:out value="${result.title}"/></td>
										<td style="text-align:left; padding:0px 10px;">
											<a href="<c:out value='${result.url}'/>" target="_blank"><c:set var="description" value="${result.description}"/>
											${fn:substring(description, 0, 70)}...
											</a>
										</td>
										<td><c:out value="${result.publisheddate}"/></td>
									</tr>
									</c:forEach>
										<c:if test="${fn:length(resultList) == 0}">
											<tr>
												<td class="listCenter" colspan="5" ><spring:message code="common.nodata.msg" /></td>
											</tr>
										</c:if>
									</tbody>
									</table>
								<!-- 페이징 -->
								<ul class="table_number">
									<li>
									<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_rssDataList" />
									</li>
								</ul>
								<!-- //페이징 -->
								<!-- //글목록 내용 -->
						</form>
					</div>
				</div>
			</div>
			<!--content wrap --> 
		    
		</div>
	</div>
	<!--container --> 
  
	<!--footer -->
	<div class="footer_wrap">
		<div id="footer">
			<c:import url="/WEB-INF/jsp/pub/include/client_footer.jsp" />
		</div>
	</div>
	<!--footer --> 
  
</div>
<!-- wrap -->

</body>
</html>