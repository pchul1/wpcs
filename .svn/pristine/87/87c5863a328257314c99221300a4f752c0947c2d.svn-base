<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : EgovNoticeList.jsp
	 * Description : 공지사항,갤러리 화면(관리자)
	 * Modification Information
	 * 
	 * 수정일			수정자			수정내용
	 * -------		--------	---------------------------
	 * 							최초작성
	 * 2013.11.01	lkh			리뉴얼
	 * 
	 * author 
	 * since 2013.11.01
	 * 
	 * Copyright (C) 2013 by lkh All right reserved.
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

<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>
<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />" ></script>
<script type="text/javascript">
//<![CDATA[
	function press(event) {
		if (event.keyCode==13) {
			fn_egov_select_noticeList('1');
		}
	}
	
	function fn_egov_addNotice() {
		document.frm.action = "<c:url value='/bbs/addBoardArticle.do'/>";
		document.frm.submit();
	}
	
<c:if test="${brdMstrVO.bbsAttrbCode == 'BBSA02'}">
	function fn_egov_delete_notice() {
		if (confirm('<spring:message code="common.delete.msg" />')) {
			document.frm.action = "<c:url value='/bbs/deleteBoardArticle.do'/>";
			document.frm.nttId.value = '${galleryBoardVO.nttId}';
			document.frm.submit();
		}	
	}
	function fn_egov_moveUpdt_notice() {
		document.frm.action = "<c:url value='/bbs/forUpdateBoardArticle.do'/>";
		document.frm.nttId.value = '${galleryBoardVO.nttId}';
		document.frm.submit();
	}
</c:if>

<c:if test="${brdMstrVO.bbsAttrbCode == 'BBSA04'}">
	function fn_egov_delete_notice() {
		if (confirm('<spring:message code="common.delete.msg" />')) {
			document.frm.action = "<c:url value='/bbs/deleteBoardArticle.do'/>";
			document.frm.nttId.value = '${galleryBoardVO.nttId}';
			document.frm.submit();
		}	
	}
	function fn_egov_moveUpdt_notice() {
		document.frm.action = "<c:url value='/bbs/forUpdateBoardArticle.do'/>";
		document.frm.nttId.value = '${galleryBoardVO.nttId}';
		document.frm.submit();
	}
</c:if>

	function fn_egov_select_noticeList(pageNo, galleryNttId) {
		document.frm.pageIndex.value = pageNo;
		document.frm.action = "<c:url value='/bbs/selectBoardList.do'/>";
		document.frm.galleryNttId.value = galleryNttId;
		document.frm.submit();
	}
	
	function fn_egov_inqire_notice(nttId, bbsId) {
		document.frm.nttId.value = nttId;
		document.frm.bbsId.value = bbsId;
		document.frm.action = "<c:url value='/bbs/selectBoardArticle.do'/>";
		document.frm.submit();
	}
	//]]>
</script>
<%-- <title><c:out value="${brdMstrVO.bbsNm}"/></title> --%>
</head>

<body>
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
							<input type="hidden" name="bbsId" value="<c:out value='${boardVO.bbsId}'/>" />
							<input type="hidden" name="nttId"  value="0" />
							<input type="hidden" name="bbsTyCode" value="<c:out value='${brdMstrVO.bbsTyCode}'/>" />
							<input type="hidden" name="bbsAttrbCode" value="<c:out value='${brdMstrVO.bbsAttrbCode}'/>" />
							<input type="hidden" name="authFlag" value="<c:out value='${brdMstrVO.authFlag}'/>" />
							<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
							<input type="hidden" name="galleryNttId" value=""/>
							
						<c:choose>
							<c:when test="${brdMstrVO.bbsAttrbCode == 'BBSA02'}">
								<!-- 갤러리 게시판 -->
								<div class="content_wrap page_protecttechinfo">
									<div class="inner_techgallery">
										
										<div class="sec_gallery">
											<div class="photo_list">
												<div class="list">
													<p class="btn_prev">
													
													<c:if test="${searchVO.pageIndex > 1}">
														<a href="#" onclick="javascript:fn_egov_select_noticeList('${searchVO.pageIndex-1}','');return false;">
															<img src="<c:url value='/images/waterpolmnt/btn_prev.gif'/>" title="이전" alt="이전" />
														</a>
													</c:if>
													<c:if test="${searchVO.pageIndex <= 1}">
														<a href="#">
															<img src="<c:url value='/images/waterpolmnt/btn_prev.gif'/>" title="이전" alt="이전" />
														</a>
													</c:if>
													</p>
													<ul>
														<c:forEach var="result" items="${resultList}" varStatus="status">
															
															<c:choose>
																<c:when test="${result.nttId == galleryBoardVO.nttId}">
																	<c:set var="on" value="on"/>
																</c:when>
																<c:otherwise>
																	<c:set var="on" value=""/>
																</c:otherwise>
															</c:choose>
															
															<li>
																<a href="#" class="${on}" onclick="javascript:fn_egov_select_noticeList('${searchVO.pageIndex}', '${result.nttId}');return false;">
																	<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
																		<c:param name="atchFileId" value="${result.atchFileId}" />
																		<c:param name="thumbnailFlag" value="Y"/>
																	</c:import>
																</a>
															</li>
														</c:forEach>
													</ul>
													<p class="btn_next">
													
													<c:if test="${paginationInfo.currentPageNo*paginationInfo.recordCountPerPage < paginationInfo.totalRecordCount}">
														<a href="#" onclick="javascript:fn_egov_select_noticeList('${searchVO.pageIndex+1}','');return false;">
															<img src="<c:url value='/images/waterpolmnt/btn_next.gif'/>" title="다음" alt="다음" />
														</a>
													</c:if>
													<c:if test="${paginationInfo.currentPageNo*paginationInfo.recordCountPerPage >= paginationInfo.totalRecordCount}">
													<a href="#">
														<img src="<c:url value='/images/waterpolmnt/btn_next.gif'/>" title="다음" alt="다음" />
													</a>
													</c:if>
													</p>
												</div>
											</div>
											<div class="header">
												<h4 class="photo_tit"><c:out value="${galleryBoardVO.nttSj}" /></h4>
												<p class="photo_time">[<c:out value="${galleryBoardVO.frstRegisterPnttm}" />] <c:out value="${galleryBoardVO.frstRegisterNm}" /></p>
											</div>
											<div class="photo_img">
												<p class="img">
													<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
														<c:param name="atchFileId" value="${galleryBoardVO.atchFileId}" />
													</c:import>
												</p>
											</div>
											<p class="photo_con"><c:out value="${galleryBoardVO.nttCn}" escapeXml="false" /></p>
											<sec:authorize ifAnyGranted="ROLE_ADMIN">
											<p class="photo_btn">
												<c:if test="${not empty galleryBoardVO.nttSj}">
													<input type="button" id="btnEgovDeleteNotice" name="btnEgovDeleteNotice" value="사진삭제" class="btn btn_basic" onclick="javascript:fn_egov_delete_notice();" alt="사진삭제" />
													<input type="button" id="btnEgovMoveUpdtNotice" name="btnEgovMoveUpdtNotice" value="사진수정" class="btn btn_basic" onclick="javascript:fn_egov_moveUpdt_notice();" alt="사진수정" />
												</c:if>
												<input type="button" id="btnEgovAddNotice" name="btnEgovAddNotice" value="사진올리기" class="btn btn_basic" onclick="javascript:fn_egov_addNotice();" alt="사진올리기" />
											</p>
											</sec:authorize>
										</div>
									</div>
								</div>
							</c:when>
							<c:otherwise>
							
							<!-- 일반 게시판 -->
									<!-- 현 페이지 경로 -->
									<!--top Search Start-->
									<div class="topBx">
										<select name="searchCnd" class="select">
											<option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if> >제목</option>
											<option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if> >내용</option>
											<option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if> >게시자</option>
										</select>
<!-- 										<label for="" class="hidden">입력</label> -->
										<label for="" style="display:none">입력</label>
										<input type="text" name="searchWrd" class="inputText" id="" value='<c:out value="${searchVO.searchWrd}"/>' onkeypress="press(event);" title="검색" />
										<input type="button" id="btnSearch" name="btnSearch" value="검색" class="btn btn_search" onclick="javascript:fn_egov_select_noticeList('1');return false;" alt="검색" />
									</div>
									<!--top Search End-->
									
									<!-- 글목록 내용 -->
									<div class="table_wrapper">
										<table summary="게시판 리스트. 번호, 제목, 게시자, 날짜, 조회, 파일이 담김">
											<colgroup>
												<col width="50" />
												<col />
												<col width="120" />
												<col width="100" />
												<c:if test="${searchVO.bbsId eq 'BBSMSTR_000000000030'}">
												<col width="70" />
												</c:if>
												<col width="70" />
												<col width="50" />
											</colgroup>
											<thead>
												<tr>
													<th scope="col">번호</th>
													<th scope="col">제목</th>
													<th scope="col">게시자</th>
													<th scope="col">날짜</th>
													<c:if test="${searchVO.bbsId eq 'BBSMSTR_000000000030'}">
													<th scope="col">팝업여부</th>
													</c:if>
													<th scope="col">조회</th>
													<th scope="col">파일</th>
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
													<td class="con" style="text-align:left; padding:0px 10px;">
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
													<td><c:out value="${result.frstRegisterNm}"/></td>
													<td><c:out value="${result.frstRegisterPnttm}"/></td>
													<c:if test="${searchVO.bbsId eq 'BBSMSTR_000000000030'}">
													<td><c:out value="${result.popup_yn}"/></td>
													</c:if>
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
														<td class="listCenter" colspan="6" ><spring:message code="common.nodata.msg" /></td>
													</tr>
												</c:if>
											</tbody>
										</table>
										
									<!-- 페이징 -->
									<div class="paging">
										<div id="page_number">
											<ui:pagination paginationInfo = "${paginationInfo}" type="image" jsFunction="fn_egov_select_noticeList" />
										</div>
									</div>
									<!-- //페이징 -->
									
									<!-- 버튼 메뉴 -->
									<sec:authorize ifAnyGranted="ROLE_ADMIN">
										<div id="btArea">
											<c:choose>
												<c:when test="${brdMstrVO.bbsAttrbCode == 'BBSA04'}">
													<input type="button" id="btnAddNotice" name="btnAddNotice" value="영상올리기" class="btn btn_basic" onclick="javascript:fn_egov_addNotice();" alt="영상올리기" />
												</c:when>
												<c:otherwise>
													<input type="button" id="btnAddNotice" name="btnAddNotice" value="글쓰기" class="btn btn_basic" onclick="javascript:fn_egov_addNotice();" alt="글쓰기" />	
												</c:otherwise>
											</c:choose>
										</div>
									</sec:authorize>
									<!-- //버튼 메뉴 -->
									
								</div>
								<!-- //글목록 내용 -->
							</c:otherwise>
						</c:choose>
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