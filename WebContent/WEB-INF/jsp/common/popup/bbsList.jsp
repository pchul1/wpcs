<%@ page contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /><meta http-equiv="X-UA-Compatible" content="IE=9"> 
	<link href="<c:url value='/css/board.css' />" rel="stylesheet" type="text/css"/>
	<link href="<c:url value='/css/content.css'/>" rel="stylesheet" type="text/css"/>
	<link href="<c:url value='/css/popup.css'/>" rel="stylesheet" type="text/css"/>
	<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
	<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />" ></script>
	<script type="text/javascript">
	<!--
		function press(event) {
			if (event.keyCode==13) {
				fn_egov_select_noticeList('1');
			}
		}
	
		function fn_egov_addNotice() {
			document.frm.action = "<c:url value='/bbs${prefix}/addBoardArticle.do'/>";
			document.frm.submit();
		}
		
		function fn_egov_select_noticeList(pageNo, galleryNttId) {
			document.frm.pageIndex.value = pageNo;
			document.frm.action = "<c:url value='/bbs${prefix}/selectBoardList.do'/>";
			document.frm.galleryNttId.value = galleryNttId;
			document.frm.submit();	
		}
		
		function fn_egov_inqire_notice(nttId, bbsId) {
			document.frm.nttId.value = nttId;
			document.frm.bbsId.value = bbsId;
			document.frm.action = "<c:url value='/bbs${prefix}/selectBoardArticle.do'/>";
			document.frm.submit();			
		}
	//-->
	</script>
	<title><c:out value="${brdMstrVO.bbsNm}"/></title>
	<style type="text/css">
		html {height:100%;}
	</style>
</head>
<body class="pop_board">
<div class="headerWrap">
	<div class="headerBg_r">
		<div class="header">
<%-- 			<h1><img src="<c:url value='/images/popup/h1_notice.gif'/>" alt="공지사항" /></h1> --%>
			<h1>공지사항</h1>
		</div>
	</div>
</div>
<div class="contentWrap">
	<div class="contentBg_r">
		<div class="contentBox">
			<div class="contentPad">
				<div class="pop_notice">
					
					<form name="frm" action ="" method="post">
					<input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>" />
					<input type="hidden" name="nttId"  value="0" />
					<input type="hidden" name="bbsTyCode" value="<c:out value='${brdMstrVO.bbsTyCode}'/>" />
					<input type="hidden" name="bbsAttrbCode" value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" />
					<input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />
					<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>"/>
					<input type="hidden" name="galleryNttId" value=""/>
					<input type="hidden" name="viewFlag" value="popup"/>
					
					<div class="board_wrap">
						<div class="board_list">
							<form action="" style="position:relative;">
								<fieldset>
									<legend class="hidden"><c:out value="${brdMstrVO.bbsNm}"/> 목록 검색</legend>
									<div class="searchForm">
										<p>
											<select name="searchCnd" class="select">
										   		<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >제목</option>
										   		<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >내용</option>			   
										   		<option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> >게시자</option>			   
											</select>
											<label for="" class="hidden">입력</label><input type="text" name="searchWrd" class="inputText" id="" value='<c:out value="${searchVO.searchWrd}"/>' onkeypress="press(event);"/> 
											<input type="image" src="<c:url value='/images/board/btn_search.gif'/>" alt ="검색" onclick="javascript:fn_egov_select_noticeList('1');return false;"/>
										</p>
									</div>
								</fieldset>
							</form>
							<!-- 글목록 내용 -->
							<div class="innerBox">
								<table class="listTable" summary="게시판 리스트. 번호, 제목, 날짜, 조회, 파일이 담김">
									<colgroup>
										<col width="50px" />
										<col />
										<col width="120px" />
										<col width="70px" />
										<col width="50px" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">번호</th>
											<th scope="col">제목</th>
											<th scope="col">날짜</th>
											<th scope="col">조회</th>
											<th scope="col">파일</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach var="result" items="${resultList}" varStatus="status">
										<tr>
											<td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.count}"/></td>
											<td class="con">
												<c:if test="${result.replyLc!=0}">
										    		<c:forEach begin="0" end="${result.replyLc}" step="1">
										    			&nbsp;
										    		</c:forEach>
										    		<img src="<c:url value='/images/board/bu_reply.gif'/>" alt="reply arrow">
										    	</c:if>
										    	<c:choose>
										    		<c:when test="${result.isExpired=='Y' || result.useAt == 'N'}">
										    			<c:out value="${result.nttSj}" />
										    		</c:when>
										    		<c:otherwise>
												    	<a href="javascript:fn_egov_inqire_notice('<c:out value="${result.nttId}"/>','<c:out value="${result.bbsId}"/>')">
												    	<c:out value="${result.nttSj}"/></a>		    		
										    		</c:otherwise>
										    	</c:choose>
											</td>
											<td><c:out value="${result.frstRegisterPnttm}"/></td>
											<td><c:out value="${result.inqireCo}"/></td>
											<c:if test="${not empty result.atchFileId}">
												<td class="file"><img src="<c:url value='/images/board/ico_file.gif'/>" alt="파일" /></td>
											</c:if>
											<c:if test="${empty result.atchFileId}">
												<td class="file">&nbsp;</td>
											</c:if>
										</tr>
										</c:forEach>
										<c:if test="${fn:length(resultList) == 0}">
											<tr>
									    		<td class="listCenter" colspan="5" ><spring:message code="common.nodata.msg" /></td>
											</tr>		 
										</c:if>
									</tbody>
								</table>
							</div>
							<!-- 페이징 -->
							<ul class="paginate">
								<ui:pagination paginationInfo="${paginationInfo}" type="image" jsFunction="fn_egov_select_noticeList" />
								<!-- 
								<li><a href="">이전...</a></li>
								<li><em>1</em></li>
								<li><a href="">2</a></li>
								<li><a href="">...다음</a></li>
								-->
							</ul>
							<!-- //페이징 -->
							<!-- 버튼 메뉴 -->
							<ul class="btn_menu">
								<li><a href="javascript:fn_egov_addNotice();" class="btn_basic btn_bgBlue"><span>글쓰기</span></a></li>
								<li><button type="button" class="pop_close" onclick="window.close();"><span class="hidden">닫기</span></button></li>
							</ul>
							<!-- //버튼 메뉴 -->
						</div>
						<!-- //글목록 내용 -->
					</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="footerWrap"><span class="footerBg_r"><span class="footer"></span></span></div>
</body>
</html>
