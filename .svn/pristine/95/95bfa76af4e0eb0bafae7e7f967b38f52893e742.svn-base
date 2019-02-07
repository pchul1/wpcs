<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/jsp/include/common/include_taglib.jsp"%>
<%
	/**
	 * Class Name : EgovNoticeInqire.jsp
	 * Description : 공지사항상세 화면
	 * Modification Information
	 * 
	 * 수정일         		수정자                   수정내용
	 * -------    	--------    ---------------------------
	 * 2009.03.10				최초생성
	 * 2013.11.13	lkh			리뉴얼
	 *
	 * author lkh
	 * since 2009.03.10
	 *  
	 * Copyright (C) 2009 by 이용 All right reserved.
	 */  
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<c:import url="/WEB-INF/jsp/include/common/include_authUser.jsp" />	<!-- 로그인 여부 -->

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<meta name="viewport" content="initial-scale=1, maximum-scale=1,user-scalable=no"/>

<!-- <title>한국환경공단 수질오염 방제정보 시스템</title> -->
<title><c:out value="${brdMstrVO.bbsNm}"/></title>

<c:import url="/WEB-INF/jsp/include/common/include_commonjs.jsp" />

<script type="text/javascript" src="<c:url value='/js/bbs/EgovBBSMng.js' />"></script>

<c:if test="${anonymous == 'true'}"><c:set var="prefix" value="/anonymous"/></c:if>

<script type="text/javascript">
	function onloading() {
		if ("<c:out value='${msg}'/>" != "") {
			alert("<c:out value='${msg}'/>");
		}
	}
	
	function fn_egov_select_noticeList(pageNo) {
		document.frm.pageIndex.value = pageNo; 
		document.frm.action = "<c:url value='/bbs${prefix}/selectBoardList.do'/>";
		document.frm.submit();	
	}
	
	function fn_egov_delete_notice() {
		if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
			alert('등록시 사용한 패스워드를 입력해 주세요.');
			document.frm.password.focus();
			return;
		}
		
		if (confirm('<spring:message code="common.delete.msg" />')) {
			document.frm.action = "<c:url value='/bbs${prefix}/deleteBoardArticle.do'/>";
			document.frm.submit();
		}	
	}
	
	function fn_egov_moveUpdt_notice() {
		if ("<c:out value='${anonymous}'/>" == "true" && document.frm.password.value == '') {
			alert('등록시 사용한 패스워드를 입력해 주세요.');
			document.frm.password.focus();
			return;
		}

		document.frm.action = "<c:url value='/bbs${prefix}/forUpdateBoardArticle.do'/>";
		document.frm.submit();			
	}
	
	function fn_egov_addReply() {
		document.frm.action = "<c:url value='/bbs${prefix}/addReplyBoardArticle.do'/>";
		document.frm.submit();			
	}	
</script>	
</head>

<body onload="onloading();">
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
						<form name="frm" method="post" action="">
							<input type="hidden" name="pageIndex" value="<c:out value='${searchVO.pageIndex}'/>" />
							<input type="hidden" name="bbsId" value="<c:out value='${result.bbsId}'/>" />
							<input type="hidden" name="nttId" value="<c:out value='${result.nttId}'/>" />
							<input type="hidden" name="parnts" value="<c:out value='${result.parnts}'/>" />
							<input type="hidden" name="sortOrdr" value="<c:out value='${result.sortOrdr}'/>" />
							<input type="hidden" name="replyLc" value="<c:out value='${result.replyLc}'/>" />
							<input type="hidden" name="nttSj" value="<c:out value='${result.nttSj}'/>" />
				
		
							<%-- <h3 class="PointTit"><c:out value="${brdMstrVO.bbsNm}"/></h3>
							<!-- 현 페이지 경로 -->
							<p class="locationSta">홈 > 수질 오염 감시 > 방제 기술 정보 > 방제 기술 갤러리</p> --%>
							
							<div class="table_wrapper">

								<!-- 글작성 내용 -->
								<table summary="공지사항정보">
									<colgroup>
										<col width="150px" />
										<col />
										<col width="150px" />
										<col width="250px" />
									</colgroup>
									<tr>
										<th><label for="">제목</label></th>
										<td  style="boder-bottom-width:1px;">
											<c:out value="${result.nttSj}" />
										</td>
										<th>게시자</th>
										<td class="txtL">
											<c:out value="${result.frstRegisterNm}" />[<c:out value="${result.frstRegisterPnttm}" />] 
										</td>
									</tr>
									
									
									<c:if test="${searchVO.bbsId eq 'BBSMSTR_000000000030'}">
									<tr>
										<th><label for="">팝업등록여부</label></th>
										<td  style="boder-bottom-width:1px;">
											<c:out value="${result.popup_yn}" />
										</td>
										<th>팝업기간</th>
										<td class="txtL">
											<c:if test="${result.popup_yn eq 'Y' }">
												<c:out value="${result.popup_startdate}" /> ~ <c:out value="${result.popup_enddate}" />
											</c:if>
										</td>
									</tr>
									</c:if>
									
									<c:choose>
										<c:when test="${brdMstrVO.bbsAttrbCode == 'BBSA04'}">
											<tr>
												<td colspan="4" class="txtL" style="height:25px;vertical-align:top; padding-top:10px;">
													<c:out value="${result.nttCn}" escapeXml="false" />
												</td>
											</tr>
											<tr>
												<td colspan="4" class="txtL" style="height:200px;vertical-align:top; padding-top:10px;">
													<video width="640px" src='<c:url value='/cmmn/getVideo.do'/>?atchFileId=<c:out value="${result.atchFileId}"/>&fileSn=0&thumbnailFlag=${thumbnailFlag}' preload controls autoplay>
													더 이상 지원하지 않는 오래된 브라우저를 사용 중입니다. IE 9.0 이상 버전으로 업그레이드해주세요.
													</video>
												</td>
											</tr>	
										</c:when>
										<c:otherwise>
											<tr>
												<td colspan="4" class="txtL" style="height:200px;vertical-align:top; padding-top:10px;">
													<c:out value="${result.nttCn}" escapeXml="false" />
												</td>
											</tr>
										</c:otherwise>
									</c:choose>
									<c:if test="${not empty result.atchFileId}">
										<c:if test="${result.bbsAttrbCode == 'BBSA02'}">
											<tr>
												<th><label for="">첨부이미지</label></th>
												<td colspan="3" class="txtL">
													<c:import url="/cmmn/selectImageFileInfs.do" charEncoding="utf-8">
														<c:param name="atchFileId" value="${result.atchFileId}" />
													</c:import>
												</td>
											</tr>									
										</c:if>
										<tr>
											<c:choose>
												<c:when test="${brdMstrVO.bbsAttrbCode == 'BBSA04'}">
													<th><label for="">첨부영상</label></th>
												</c:when>
												<c:otherwise>
													<th><label for="">첨부파일</label></th>
												</c:otherwise>
											</c:choose>
											<td colspan="3" class="txtL">
												<c:import url="/cmmn/selectFileInfs.do" charEncoding="utf-8">
													<c:param name="param_atchFileId" value="${result.atchFileId}" />
												</c:import>
											</td>
										</tr>
									</c:if>
								</table>
								<div id="btArea" style="margin-top:10px">
									<%-- <c:if test="${result.frstRegisterId == sessionUniqId}"> --%> 
									<sec:authorize ifAnyGranted="ROLE_ADMIN">
										<input type="button" id="btnMoveUpdt" name="btnMoveUpdt" value="수정" class="btn btn_basic" onclick="javascript:fn_egov_moveUpdt_notice();" alt="수정" />
										<input type="button" id="btnDelete" name="btnDelete" value="삭제" class="btn btn_basic" onclick="javascript:fn_egov_delete_notice();" alt="삭제" />
									<%-- </c:if> --%>
									</sec:authorize>
									<c:if test="${result.replyPosblAt == 'Y'}">
										<input type="button" id="btnAddReply" name="btnAddReply" value="답변" class="btn btn_basic" onclick="javascript:fn_egov_addReply();" alt="답변" />
										<input type="button" id="btnNoticeList" name="btnNoticeList" value="목록" class="btn btn_basic" onclick="javascript:fn_egov_select_noticeList('<c:out value='${searchVO.pageIndex}'/>');" alt="목록" />
									</c:if>
									<input type="button" id="btnList" name="btnList" value="목록" class="btn btn_basic" onclick="javascript:location.href='/bbs/selectBoardList.do?bbsId=<c:out value="${brdMstrVO.bbsId}"/>'" alt="목록"/>
								</div>
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